# Adaptive Neural Decoder for Cerebral Palsy (AND-CP)

An enterprise-grade, modular closed-loop brain-computer interface (BCI) decoding platform designed to ingest healthy motor imagery EEG recordings and adapt through transfer learning to contaminated, CP-like neural signals.

---

## 🏗️ System Architecture

```mermaid
graph TD
    A[BCI Competition IV 2a MAT Files] --> B[BCI2aLoader]
    B --> C[EEGPreprocessor]
    C -->|8-30Hz Bandpass + notch + CAR| D[Epoched EEG Signals]
    D --> E[BaseDecoderPipeline]
    
    subgraph Decoder Models
        E --> F[CSP + LDA]
        E --> G[Filter Bank CSP]
        E --> H[Bandpower + SVM]
        E --> I[Riemannian Covariance]
        E --> J[EEGNet PyTorch]
        E --> K[ShallowConvNet PyTorch]
        E --> L[DeepConvNet PyTorch]
    end

    subgraph Real-Time Inference Loop
        M[Amplifier Simulator / Client] -->|WebSocket JSON stream| N[FastAPI Server]
        N -->|Degrades Signal| O[Pathological Noise Simulator]
        O --> P[StreamingBuffer]
        P -->|Sliding Window| Q[RealTimeInferenceEngine]
        Q -->|Preprocesses & Decodes| R[Predicted Intention + Probabilities]
        R -->|WebSocket JSON return| M
    end

    subgraph Patient Adaptation
        S[Patient Calibration Trials] --> T[ModelAdapter]
        T -->|Linear Probing| E
        T -->|Fine-Tuning| E
        T -->|Weight Interpolation| E
    end
```



