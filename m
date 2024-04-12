Return-Path: <linux-iio+bounces-4213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0E8A3906
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 01:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CED1F22BB0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E84152DE7;
	Fri, 12 Apr 2024 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Bd7Lw4R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57C199B0
	for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965668; cv=none; b=biMZFcCaLUIsNVYBFcg4Vxbg79u72C1u6lNP1Ipi5jZJuEtojgdR8HiiXukh90ohYtH0ilAVXUsyETX1bMcNkglOK+aVrTw4Kd7DLqmatTeMv1rBu+Pc2+MxlXO2gTLS7Z01xpnbdsoNuOeoRxQC4/gM6gU6S5uN3NKF6amobYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965668; c=relaxed/simple;
	bh=jw/yz0yE0kH6mgpkP9FvufT0s7h6fEHt5cUIgmJZCVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwDTl4LKRO8LsPn03xtz9PCvDCOGxBwh3W9EoraMjC6FnBUDnHJTuNU3K3FIdxyUF6gEZtigCxE0ugZvwFOaba7PjGOdfmFHZ+VL+mBzim35Ba5HlaQEPwkjvW+Ss9bzDwixOUWP328AxX09jfSqutYI1KjfN7M7XN2mdekgmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Bd7Lw4R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d476d7972aso17936221fa.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712965664; x=1713570464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM8/+MVXo4j589BOsrVszGbTlP/kpDmS7ndlq2yapl0=;
        b=3Bd7Lw4RCRbCJyzVOwolosW85tdJPCGwMiUtVw8pVLAjIHl2DGSa5JOQKaKVPAyAP+
         kubIz6pM3vTQ3+Mc/GVMerGtVRsuWJEskZ0Gm9aHyv+rmm0CDOGnjRfdzEb6rBzqBL2c
         BrEBWDlmGXnCY7Z8Aw9D0ex9/NEKjg03jzkB4+/qTcQ8F5Y50W0e1mEYRwnNmu/TUqG5
         cdNZGNZxAQr2Uwupa/KSCmnYUXtejn90u2cxeJNJr1jdMckVhqXdd1TjMLUqDrquMqmF
         LSi2l7C9EHyg/20Ql1kdoENrXvMiihj1in9+B05YdWwc3OlV8tlP5S6JYcaShJEpglhA
         aFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712965664; x=1713570464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM8/+MVXo4j589BOsrVszGbTlP/kpDmS7ndlq2yapl0=;
        b=sP+QtZ7RXkk7a4qLBJSLqWBr3rCZ029lnfAKnJ98CFtWGWdAOg1lWyFsoHP7+P5f+k
         pJhYIKfA6McDfsIErB6Jx2hIOLtlgAb7x5Yv3Sq5W3Y/G/J+rldhKDrJ7XWGw1skS9J9
         Q/7WXPUUlDj/q8Pg/HXTP8T/aQAFowPJiqKEgdrdXXTtYHjtMKq/AAmYNwthSvEAANxU
         9qvfMWgLWNcmia75XgdioNe97rD6vo/ds2FCoX3NcmSTMkRt+jOCwkZZU2aCXQW3/ueE
         GFZgVLaG26Ce+HkD7vJTG3XqG12UNa2RxYGP22ZmQvZgXErcKkp91aR7NicDIX5Z6nMm
         l9bA==
X-Gm-Message-State: AOJu0YzD0D2gEMsdPlS0zuzRZvPl/+4e+Tkmlm83OYtYUEfnwHTjR15w
	ZgM7kM4TIoYuxg7cHWJIOpPJDil3mr0IZYwnLR/FU7TU2Yrf15g9LchkAh/Sm1kRLheQXXJC8UA
	lP6b+aOBOwntf/ElIkPuzV4pwtK/iHDT+v048fQ==
X-Google-Smtp-Source: AGHT+IExiVIJcWMSlJZEaatbknw9+1QMz0NNtkro7JngoiP2cYevmLCqjU/V1Zl+XIXmghwPbX45naeJ8amcBFZEP8M=
X-Received: by 2002:a2e:97cf:0:b0:2d8:5e21:8eaf with SMTP id
 m15-20020a2e97cf000000b002d85e218eafmr3182431ljj.41.1712965664380; Fri, 12
 Apr 2024 16:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com> <20240412-iio-backend-axi-dac-v3-7-3e9d4c5201fb@analog.com>
In-Reply-To: <20240412-iio-backend-axi-dac-v3-7-3e9d4c5201fb@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Apr 2024 18:47:33 -0500
Message-ID: <CAMknhBHZRfvNtkbpWbi7tTXYa_rgRk+Q4z5MOd0O61FeEqBQnQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] dt-bindings: iio: dac: add docs for AD9739A
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Dragos Bogdan <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 8:36=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>

...

> +  adi,full-scale-microamp:
> +    description: This property represents the DAC full scale current.

The description could be improved by saying what determines the value
that need to be entered here. (Also wondering if this is not something
that should be set at runtime using the _scale attribute instead.)

> +    minimum: 8700
> +    maximum: 31700

Missing a default value since this is not a required property?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - io-backends
> +  - vdd-3p3-supply
> +  - vdd-supply
> +  - vdda-supply
> +  - vddc-supply
> +

