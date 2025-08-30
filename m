Return-Path: <linux-iio+bounces-23421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E2B3C784
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 04:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4945BA211B1
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E1B26CE12;
	Sat, 30 Aug 2025 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3UPOYER"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7D224D6;
	Sat, 30 Aug 2025 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756522059; cv=none; b=VjwmdF40GDVaSQr2rRUc0Jlq3W2c5/B5xVmp6aXZ5h3jDwxi4B0/cthHYbQPuBjshXdszAM/EWPVUuF6POIoBaVuYzExyADXk8E9clw63Mqce8KAlFu27uECc3IZkaaxhFheABcQi+n/nz7iUrLOY7Fl91mYXr90i92+LZfjwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756522059; c=relaxed/simple;
	bh=s0Wzuy5FKe7WprUs0n9XM0ue5dvcfmuCGmfE1nLywiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6OpviLFECprWenTOyikZ7QzLRUkHvrwYvDar4U0gnOaW3mWa+f8403J7TzDZlAWZtQPsuDsfCcOIlSHb8fCfX7+XBmjT88Bp21XEJduZ+J43WyA9hKylqdP+fBqn2lMXIJtmxPTleoOQGR5qZNRb7lSQkYfQaueAaXVkAtPNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3UPOYER; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-771ed4a8124so2775503b3a.2;
        Fri, 29 Aug 2025 19:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756522057; x=1757126857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOKB86akayhJUe68ZwqhBuo1eGGE51BvMN33IB4BODg=;
        b=G3UPOYERwjdeE+GSTGLDWZUTfQ5gMtbZ3KogJD3Dakk09MkYtqJ/qlhtT3hneTatgu
         N3uICuEjTrnXno3+71swmqDK3wGd5WiJnLzEYy2G/IoviMWp/NGAAgaqcExDFd4u0QOd
         FlRoLj48NI6zeqjhXsYANScQorpmkxUm9LpGMiVr9Z3F6zf1HYdD7CHD55AmGFESBb4j
         dUCrXx29xknqo7b0WTgYRr/QJZ5ZjYhwOU8mVWlh9ERYdy4eoFN4fEVrv6lO0hscCRuX
         xVVBITTOCvyXeFAwQqdA4fKVS5gDIRnlWbbSPOPH/F40/IAY7meA3t/4/ovbv0uq6tDO
         zFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756522057; x=1757126857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOKB86akayhJUe68ZwqhBuo1eGGE51BvMN33IB4BODg=;
        b=GVYTb+Ma5y6b0j27JrY+mDE6b4pd1hCHr0YZDxcywKWi+VdK7zn8uRVh46zgm+HWhA
         5m/yBdzgMKfWNc53fkAp2LHdUwltEz7DFDBXk6u/wwH6ElBz651QH6WyLWihj+dge6IB
         4BJJFEeEKHUxUVtUrHBjRWKRz9sjudbf2GwS0ZY7IXB2KgstR2T8l791x44KMK7FuzLu
         7Jz4iC7Ltu9UGvTJCb8DfdnMgcwAEgqr7OpDuHyZJSsLw+x+XSzm2/xGaGDTqEdPYdoT
         gekZMEC+cR5UjGrQPj6sOShj22wr6/FI2GCwjxdC4qCYP4tYdZvWvy0Z3UBB77a/8vBH
         yiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUad+ZkBE27sv4VPhybvuhJ+vCjo3NSI0mDCA/lKRxwyZD1LlX0pC1F5TwLAOxsYA+9w7GIeLkHNwqG@vger.kernel.org, AJvYcCVw2v4F0W0gQHOegDpGl8o92k4+0kHPuQI9EZaq2RZBIBWyDzXYPTIKygTAZrnjxReNQ/cIdEbduMAO@vger.kernel.org, AJvYcCW2sBRoLwXkrbkyF4rP3V1FiaeE0C9fgVL/5mgDozKqViFcSXnXMOAiW5aQPljZaFvCz10UkUfAnhIk@vger.kernel.org, AJvYcCXjo4s/CI+LXijINWE1aWrAdR8op1F+k41EEG5Nx66NLqdlJ/uiGIC8OlW9PddiNrWQDvnfjkvuD90SMa2U@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJjX5vB3gUH6s9eSsxgfi5aiPDe1NJBhW4v9FDXZJkbZOLgjA
	y7pc5xz1mPZ1ijLpZj7QlwP7mCCLZLDKIOph8lI2EA5yFVJ+BQ3PO4Ym
X-Gm-Gg: ASbGncuJPOT/IU2SW+EpP6f9Qz5+Xw5PDM3k+hA8tWtmXefWo/UXd7cSfj8tkipgyt6
	oKcS6oIdSAL7+upAtw/Uuhlyn1s9JpM7EL+5g0A2towlNMtjkbdV6zxN0VA0XQQCXHVpNqEbIkD
	Ab7w3HtG4bz4sY4NGuxXaox/qm5puOTSeRB1EhAzwToGofCeARP93EzSiX4/ipmnj8axP+Qz1Id
	MPR9r3MTHrvxHVp5d+GguTUW4yd636SJVLd7fqYwA4Jwwe7efiiLFn+uIU3RTPLfTQfCNqCVZyd
	ePBpZ3kCn94XDB1yhFrXf6R1sLbNSaSnqWNryX8AQbFOoJOfGJc2/dpQiMBJXG+aWlKcNw33SY4
	4ibxHh+/HDhXFC+6dvTCuiCuk1Xfbvb0dN0sH4prd
X-Google-Smtp-Source: AGHT+IHbd379rktpp8cSwfbgbcZ5ZxvEeTjg2B8sY9DMs5CBqf4tCV6sqeWS+PtL9GZaOmJuFpuQUA==
X-Received: by 2002:a05:6a00:1952:b0:772:25f6:caee with SMTP id d2e1a72fcca58-7723e40347amr875575b3a.30.1756522057204;
        Fri, 29 Aug 2025 19:47:37 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-772306a1870sm2935087b3a.75.2025.08.29.19.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 19:47:36 -0700 (PDT)
Date: Fri, 29 Aug 2025 23:48:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, jic23@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org,
	Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
	ahaslam@baylibre.com
Subject: Re: [PATCH 00/15] Add SPI offload support to AD4030
Message-ID: <aLJmYXlfCf5fy9po@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>

...
> 
> The patches to the SPI subsystem are from Axel Haslam and I only signed them to
> indicate I'm moving them forward.
> 
Realized I should have based the SPI patches on top of SPI for-next or SPI
for-6.17 and probably sent them on a separate patch set.
I'll do so in v2, but will first leave time for v1 review.
The changes to the SPI subsystem are not extensive and the patches apply cleanly
on to of SPI for-next, nevertheless.

> 
> Axel Haslam (2):
>   spi: offload: types: add offset parameter
>   spi: spi-offload-trigger-pwm: Use duty offset
> 
...
>  .../bindings/iio/adc/adi,ad4030.yaml          |  86 ++-
>  Documentation/iio/ad4030.rst                  |  29 +
>  drivers/iio/adc/Kconfig                       |   2 +
>  drivers/iio/adc/ad4030.c                      | 704 +++++++++++++++++-
>  drivers/spi/spi-offload-trigger-pwm.c         |   5 +-
>  include/linux/spi/offload/types.h             |   1 +
>  6 files changed, 792 insertions(+), 35 deletions(-)
> 
> 
> base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
> -- 
> 2.39.2
> 

