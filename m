Return-Path: <linux-iio+bounces-5967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE58FF6E5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48141F221D6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74773459;
	Thu,  6 Jun 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWpTHPmC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D924595B;
	Thu,  6 Jun 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709443; cv=none; b=MlwqpfyhTVgi5Kbob3DQUlqFOV3FuJuR0DTDMkY98kyzKuRgMEyfzMnFbvkYluLnGXOhpW1Sv6r8pYU0SE/onjpk7xgHhKShVY9LegGiZw28knitN6ziP7YusdNeG1NB2A9OJXocxW7ZFa6S2lbVHn8wJFtWsBgZOKC331TY93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709443; c=relaxed/simple;
	bh=GsgJwa/FwW2SlFBiMFcYxk+JVXnVTpzZgoTf/0KbxlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AceKDzuoVIXdTDYTjxekJWcC3q3ZcSBeQUwwHay1TiDNRwxpCwU5qsAsM3Qefk24ch//sf/eeTW1mugv0vvWFBxi1ie2/PjUr6F67LKsmq6EBmAWmUzLh8HhvlV45E85XEqKE/iJuVjHBGU9+LJWLg6EbeFK2l7tdXdHxT9icR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWpTHPmC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f64ecb1766so12617855ad.1;
        Thu, 06 Jun 2024 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709441; x=1718314241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VG+FhUMIemPNzijlVmturC0HHAgzjdPKydYKX9+fG78=;
        b=XWpTHPmCR6sUieUIgQ7a1T4Q8AoU3H8tQu6crUsU+1DaT5La6s4jYov2+nQYL8zJ3j
         PJPhcrHaYb4F0GWhZJAdZtXrY8rC+Bbeh2tKFiKT/S0OWDketoRVZgjEutPI6x5m1Lez
         0BxciyIR5ArwAh2EiwZmMfXHhSs4bk3SpZVHM4sHYHwDCcflHVw2+bLoaqQF5aqmiipj
         rnzkr4amnjmqkcRY2j8QzjKxtXV2JIw6vyt0hIgUp5r3U/2MMVkiiwcylxSSEcXCbNGk
         wbjUdLKEjfDFLLDk6IP3eIarLGNl6ZzRQo6/aqg9VlOajqEeW4RMMOWj2OlJPMO98Mxk
         2BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709441; x=1718314241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG+FhUMIemPNzijlVmturC0HHAgzjdPKydYKX9+fG78=;
        b=q9nouIzZUwpjNfzJmNEMSgX026bsU6DNghcSX9wFRKDt/TIPriebM60BdCp6zRRZEj
         O0uAe8B0ZpW9nLhgxEud9SuJ+tGWwMpr3qMGpaA/WrfT5/k+0tvosluoqZPpYgT6ERK+
         h1Yoa3Wpbfb9aFCcegAVN35EhIlhZd5rpmH+TV4lWJ+eDmmNOuevBJoWObhWUaJqW+fK
         y7WVLpQjAfpJElxmoZcgi4ImMcmRLGB487rwzZ3p5/cGLA6R/zMQ4VcyJGXeRMHGBWFi
         nv/pHGf5by9fnrZvAnpFcyUfRaNwswvSYm+YQf/0FKGD7FRI/sfXS7dae6iYdOp1e4Ws
         pYJw==
X-Forwarded-Encrypted: i=1; AJvYcCX2YU+h5gVnJfLdQFXMy5edhNZETfZYKQTx82bGxiI/Nu5pJuJNJgoQ5tkZKG+wiCPd7m7NPwJyAaKYDytO8l8vxO58T2HP4X0yC5brvOB9bGhOzZ5EgEKwOdh+qNsCrPLUraGpsWXf+96H6mwdSK5U/kPGyNGbq+WGH8GA+cUdwWrVBFrF9haw7o5VrHJuBUzpnJ2DgguGdVdZpD4UsQ==
X-Gm-Message-State: AOJu0Yw6VjlkaZKfZbtYidZH2csV1Dq7j3lUqbyjy0m0XrYFI+/bDmBy
	NWkLQz79xCq8YY1pitRBv3XkGO0ZhfnYgEycivp8p++J+DrNzkp1
X-Google-Smtp-Source: AGHT+IF6RLsY8z3Bg926Owab/WEi0IA3FYbIXfUzsYPVEqPPzT4w4iqZoL0ronwPvarZKS8J677VXg==
X-Received: by 2002:a17:903:2345:b0:1f6:74f3:ac0a with SMTP id d9443c01a7336-1f6d03d6ef3mr9493505ad.64.1717709440765;
        Thu, 06 Jun 2024 14:30:40 -0700 (PDT)
Received: from localhost ([2804:30c:167a:4100:8407:a7e5:9b87:8081])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e2d70sm20282305ad.228.2024.06.06.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:30:40 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:31:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
Message-ID: <ZmIqxS-xUVMNH_lJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
 <ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
 <0e18b3aa83a62103b0f06ee516193c03f80abae9.camel@gmail.com>
 <f8ce5dc8-ed68-4f04-af3a-187bf0e4a3b3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8ce5dc8-ed68-4f04-af3a-187bf0e4a3b3@baylibre.com>

On 06/06, David Lechner wrote:
> On 6/6/24 1:51 AM, Nuno Sá wrote:
> > On Wed, 2024-06-05 at 12:03 -0500, David Lechner wrote:
> >> On 6/4/24 5:43 PM, Marcelo Schmitt wrote:
> >>> Implement MOSI idle low and MOSI idle high to better support peripherals
> >>> that request specific MOSI behavior.
> >>>
> >>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> >>> ---
> >>>  drivers/spi/spi-axi-spi-engine.c | 8 +++++++-
> >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-
> >>> engine.c
> >>> index 0aa31d745734..549f03069d0e 100644
> >>> --- a/drivers/spi/spi-axi-spi-engine.c
> >>> +++ b/drivers/spi/spi-axi-spi-engine.c
> >>> @@ -41,6 +41,7 @@
> >>>  #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
> >>>  #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
> >>>  #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
> >>> +#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)
> >>>  
> >>>  #define SPI_ENGINE_INST_TRANSFER		0x0
> >>>  #define SPI_ENGINE_INST_ASSERT			0x1
> >>> @@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct
> >>> spi_device *spi)
> >>>  		config |= SPI_ENGINE_CONFIG_CPHA;
> >>>  	if (spi->mode & SPI_3WIRE)
> >>>  		config |= SPI_ENGINE_CONFIG_3WIRE;
> >>> +	if (spi->mode & SPI_MOSI_IDLE_HIGH)
> >>> +		config |= SPI_ENGINE_CONFIG_SDO_IDLE;
> >>> +	if (spi->mode & SPI_MOSI_IDLE_LOW)
> >>> +		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE;
> >>>  
> >>>  	return config;
> >>>  }
> >>> @@ -645,7 +650,8 @@ static int spi_engine_probe(struct platform_device
> >>> *pdev)
> >>>  		return ret;
> >>>  
> >>>  	host->dev.of_node = pdev->dev.of_node;
> >>> -	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> >>> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE |
> >>> SPI_MOSI_IDLE_LOW
> >>> +			  | SPI_MOSI_IDLE_HIGH;
> >>>  	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
> >>>  	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
> >>>  	host->transfer_one_message = spi_engine_transfer_one_message;
> >>
> >> I think we need a version check instead of setting the flags unconditionally
> >> here since older versions of the AXI SPI Engine won't support this feature.
> > 
> > Oh, was not aware of that... Then, we definitely need to do that. Marcelo, only
> > add my r-b tag with the version change in place.
> > 
> > - Nuno Sá

Nuno,

I think there will be more disscussion about this series.
Maybe better I not add the tag at all so you may check to agree with the next
patch version.

> 
> Actually, looking at [1], it looks like this could be a compile-time
> flag when the HDL is built. If it stays that way, then we would need
> a way to read that flag from a register instead of using the version.
> 
> 
> [1]: https://github.com/analogdevicesinc/hdl/pull/1320#issuecomment-2145744521

When is a driver version check needed?
Yes, older versions of SPI-Engine won't support this, but the patch set should
cause no regression. Even if loading the current ad4000 driver with
older SPI-Engine HDL and driver, the ADC driver would get a warn (or error?)
and do what's possible without MOSI idle feature (probably only be able to do
reg access) or fail probing.

We decided to have the MOSI idle state feature for SPI-Engine configured by
writing to a dedicated bit [1] in the SPI Configuration Register [2].
Does this looks good?

[1]: https://github.com/analogdevicesinc/hdl/pull/1320/commits/941937eedae6701d253b4930d8f279c21ef3f807#diff-dc9213744b55493ca9430cd02cd62212436c2379ca121d1a2681356e6a37e22dR257
[2]: https://analogdevicesinc.github.io/hdl/library/spi_engine/instruction-format.html#spi-configuration-register

Thanks,
Marcelo

