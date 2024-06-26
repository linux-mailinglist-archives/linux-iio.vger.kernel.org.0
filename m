Return-Path: <linux-iio+bounces-6953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB7918253
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0952823EF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C281822F3;
	Wed, 26 Jun 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD8zcdxN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF508825;
	Wed, 26 Jun 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408360; cv=none; b=MUdmBWOH719KkJu0NCphKW+J4WXw+MCTdnrRD/ZcTmPP/IczKDEkLkRnBMu2XbJhCi8FGW55qW7jw6WV+P4Li/bwD3SU4IaS86Bg4mQs1q2fW8q+UvF1rqgHnYt+cOpC+jGVH04C8wxvmSLMpZmN/wekxGNkdDsTjDadZ8VL/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408360; c=relaxed/simple;
	bh=a2MiMWPuYk0qvLgPHdbMbHteIsHggJW7MHoMbsZoJ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vbu6N6CfU22Q8V3BQLlo8SUGy9PABIjZMR3PfW21JRN9oyCM24wK3M3APd3AGdIwj59QdyNiHBHlW0JjG5Y3PV93E0tGpOUW0CydyVgKnYDx4AQj6DQ3o/5j/ajN2Y+Rt7yR8QNIuW7zDv7NNjSJViSPZlSu11uadebiLVhPC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD8zcdxN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-701b0b0be38so5616703b3a.0;
        Wed, 26 Jun 2024 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719408358; x=1720013158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SNW8OiLwaA5mYn7mAT6eoqNNPmxPlZMg85u3cNG1HT8=;
        b=DD8zcdxNYbXV2ZLeewPJ+dKYIlpaOOev4ybda3i3BHZ4Mh3oXby2LtB7Efm+KTx1sE
         YbYsvrjgMFPjG2Ql6npZ5FBPc/7TOueJE7IeFynIY084TuRL67ZltXrgLjjDJt3NORuq
         /jI79+A0iSvM+38lN0bTEgGb9o9myKu6jOP7KJ8e1QE1dj16j/vSGFvViPXO48LlpHQV
         T9sZ3ahp016mzzW9T/dycBAVqsinDG1NrLDm+PqN1xXGyZUdwygePn99cjate35t4Ao5
         KR3OnXxobwfPd4FR5nyfS9RpPaR7Y1XB91brJMfi9fQP3NZuFx2dxwTZgvKzTeZlOxHm
         8a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408358; x=1720013158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNW8OiLwaA5mYn7mAT6eoqNNPmxPlZMg85u3cNG1HT8=;
        b=RUQz8ANwqEUtHSKREwI1xG9HpcXX6tWfkF35n8yRhvdi0GkAAUmoiusdDCezAmqJVK
         g2xIlf/LQHfzroGw75Kh7OIrSmcZtB/DXAO18rWcXJdbQO7Ps3UPdAEKOb830Cdxw6CJ
         gFPkU1svyl981uaS0VQVq9kjef0S2AbgNDbhHWyWBfXSsMeszXf4viaeCrKc8CFOte/7
         fh+dH2VFHIuss0HI4fVG+qEl8BBRlEE0NEcmO17ql4hPbGewK9FmpSY1gSy7PQOfOMqB
         Bg3OaxYFZPJKMc+NAR5EtNpmQe/LYKTO6UGkCRWggzidr/6gliTJkUdsB1G6ku+WEUYK
         Mw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXu0zHOcsIZFrz9oM++y2nntjqdxkh0uurjiafVEE17yjCEiHTj/Fm7b6o1C3a0/RRuKOeqqZIaI8y1kNhdOuPW0WoTJcGDqZdsOZWCc4i6kaHz9gjjoSQp/WQrl7iH7fj6B02S6rQNOFq0CXtuCjCpoRLzMJK1AiUeB4hwpA38ZgBhLPO5hYKwGsbdcGOdkEztlFAhgQnjnyr+AiiW3m8WFGn7upDQEieXdPaEkf/Sbg4a+YLjInwXA==
X-Gm-Message-State: AOJu0YwuFG4W9LKh47btSUljeNsxt7hUy5OqIplfOV1U/Rq5hcfpYc8n
	94caj8c9s9d9LI5f9mGpnA5XC1j705W2EZ6WMHaxA2E8Qpvh6Lzj
X-Google-Smtp-Source: AGHT+IG5de0OBwkS5JyH2ZKjE30wVQboMcmfftyBXNzCUH06FbsrVWCi+AcSjERuzgX2Z6vD3Fna/w==
X-Received: by 2002:a05:6a20:18b0:b0:1bd:28a3:20b3 with SMTP id adf61e73a8af0-1bd28a32238mr2879981637.21.1719408357797;
        Wed, 26 Jun 2024 06:25:57 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d8bd8sm99449385ad.209.2024.06.26.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:25:57 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:27:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
Message-ID: <ZnwXO6vApHfkXyqx@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <072d74af9fc624490b84a1d001039424e572e827.1719351923.git.marcelo.schmitt@analog.com>
 <CA+GgBR9S7q32i-1ehNAgLHim66-Ud=PajgTSczBSJ5LUZdA7cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+GgBR9S7q32i-1ehNAgLHim66-Ud=PajgTSczBSJ5LUZdA7cA@mail.gmail.com>

On 06/26, Alexandru Ardelean wrote:
> On Wed, Jun 26, 2024 at 12:55 AM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Implement MOSI idle low and MOSI idle high to better support peripherals
> > that request specific MOSI behavior.
> >
> 
> One minor nitpick.
> Feel free to ignore, if there won't be a re-spin.
> 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  drivers/spi/spi-axi-spi-engine.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
...
> > @@ -646,6 +651,9 @@ static int spi_engine_probe(struct platform_device *pdev)
> >
> >         host->dev.of_node = pdev->dev.of_node;
> >         host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> > +       if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1 &&
> > +           ADI_AXI_PCORE_VER_MINOR(version) >= 3)
> > +               host->mode_bits |=  SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
> 
> There's a second space after the assignment.
>                host->mode_bits |=<2 spaces here>SPI_MOSI_IDLE_LOW |
> SPI_MOSI_IDLE_HIGH;
ack

thanks
> 
> 
> >         host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
> >         host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
> >         host->transfer_one_message = spi_engine_transfer_one_message;
> > --
> > 2.43.0
> >
> >

