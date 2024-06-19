Return-Path: <linux-iio+bounces-6597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DC90F4FC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 19:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AECD28539B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ABB156242;
	Wed, 19 Jun 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiSWRv0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AA339A8;
	Wed, 19 Jun 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817961; cv=none; b=X+Wgsz3y3R/t5i3/JdvtEnUD4NXKdJbf7Af3VkilV9U9WGEsgCs25OJROivttPSkSk4r0NwDWQFhPRTUCC8g8k52KAQccNtwzCIoj+udh3twMnzW7s5GfKyoUog4luDOU8bZopngsBMdEjzYMg4JqfkkxY6VnAjEEjjlchOumuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817961; c=relaxed/simple;
	bh=1PyvFsSzXeMYA/yXgCcy8zJG0wnlXUA8w2TkCdy6z58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg1GrQehZevxj4In1nfGOM9uzPwDpeKWV3eFe3hujCrtppEay4fRXlU0lLsYOaatk3RXBj3FqyvA9+NeZffyXXyLCNxbnq/bSIlnyFNvMEiIosdVMPlucOyQidUBCn8hlbMg6eJnIGsPQ6aN6AI5NGZEq+DkPwlAQb5HtRev38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiSWRv0K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9bf484d9fso2469875ad.1;
        Wed, 19 Jun 2024 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718817960; x=1719422760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXGOM3JdNbdgfTFKvIqjEPXAgH0KOOCR0kXzcNVRFZU=;
        b=BiSWRv0KvrthedX3IfVuDFydjGvdEwAg0TRQorOoGtxeTygAE9tqra4r9YlgfejMeN
         NIO7eDCTd4bMwST7ba4kkhdakR+5e+ULf+JTGtPKjB8i7coEK7IabCET/tORSkFXzEfX
         6eBOtpc10PRFrXhypQmtcj/nmL1nfO3GwSH473omBzex+xQRlFGYZq40xp/mhWxdm0uA
         V99xk8P9+6b5MJo3uII691aAo2t6UF29D3q82I8gOVqN11w9XYWQU0N+QpJ/yyJC1vA7
         9HV8zj4NEVO+2n5ModNHvf1j8Bgpe91z4w78xoHkE01MxHd83eBPSJPQGfLysnv4QkfP
         t/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718817960; x=1719422760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXGOM3JdNbdgfTFKvIqjEPXAgH0KOOCR0kXzcNVRFZU=;
        b=a95iB3bImFDasiwIsGIYixZ8e5UWq4r6ldVqvWoKJ7MbXpaQRWxS++3QZUq3siXODD
         oCX/rEb+Hi/R6Xl2atK+u37oWc9rw06pczRg+zmBbRgzhfZCENt/FduFXtGZnUu5dUka
         fRYJCdo1A97EoNuS6fCgtPClUGP5W/aWtIuG6+yGUuYIfJCliWkh/z+gQ0BkyoCbfxmH
         fX90IyrKGKOt0fQkRcLWxJiFfsrZgfO3ayvPaAVLPoOWVhRaTAWZAmZsGYbdxBEYnVHx
         hgG++a+lpzdxRR1RCSdwZuggzoMe1VguTl94Zp5+TaWW8hjVAmJW6Xy6UjKLX531sqKm
         Keuw==
X-Forwarded-Encrypted: i=1; AJvYcCWsv/WZLswqtWNkREP5SYqZWJwLzjkJXlSlviQ4U7oJ6gkWrnVU0I8UBvSfFRvfGRxLgVbHdiWyZUb3KP4fil+SEkKbg/MMIh/r6jqfL5cHSgGOFWJMekwylf2A99t+o3QJxa0EOetYn5QxCphK6yDA6rnr9Sv/qRKJaGHsIRW62egIrgZsOJBIRHiK4YK5Lg+lkgX0DrHNChSQrFUw5g==
X-Gm-Message-State: AOJu0YyuHJJoLYFuhfbh7OvomH6FdlhW1LTpblbUeYOrnDJcTur//4Fp
	+qrdOPigdVDbHYaH34qlTFBdMavYollizBL+8PXkH0aEM2/b10H7
X-Google-Smtp-Source: AGHT+IHuV4oGtzd9Wf54j/9UST/kzIl8G/wnBWGC1cMTWlztDFJDGRRTGQYT/Wn2nkMGh1SgdC/J7g==
X-Received: by 2002:a17:902:db05:b0:1f9:a242:c3a9 with SMTP id d9443c01a7336-1f9a242c7demr59091835ad.24.1718817957624;
        Wed, 19 Jun 2024 10:25:57 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4ad2bsm119664875ad.285.2024.06.19.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:25:56 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:27:20 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
Message-ID: <ZnMU-OUV2DCpS3mu@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <ead669c15db7cfad4034df1d743fd4088f1c2253.1718749981.git.marcelo.schmitt@analog.com>
 <6f945701-cac0-4a56-9ca7-1daceccc5efd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f945701-cac0-4a56-9ca7-1daceccc5efd@baylibre.com>

On 06/19, David Lechner wrote:
> On 6/18/24 6:11 PM, Marcelo Schmitt wrote:
> > Implement MOSI idle low and MOSI idle high to better support peripherals
> > that request specific MOSI behavior.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  drivers/spi/spi-axi-spi-engine.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> > index 0aa31d745734..787e22ae80c0 100644
> > --- a/drivers/spi/spi-axi-spi-engine.c
> > +++ b/drivers/spi/spi-axi-spi-engine.c
> > @@ -41,6 +41,7 @@
> >  #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
> >  #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
> >  #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
> > +#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)
> 
> Calling this SPI_ENGINE_CONFIG_SDO_IDLE_HIGH would make it more
> clear what happens when the bit is enabled.

Yeah, agreed. Changing to SPI_ENGINE_CONFIG_SDO_IDLE_HIGH.

> 
> >  
> >  #define SPI_ENGINE_INST_TRANSFER		0x0
> >  #define SPI_ENGINE_INST_ASSERT			0x1
> > @@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
> >  		config |= SPI_ENGINE_CONFIG_CPHA;
> >  	if (spi->mode & SPI_3WIRE)
> >  		config |= SPI_ENGINE_CONFIG_3WIRE;
> > +	if (spi->mode & SPI_MOSI_IDLE_HIGH)
> > +		config |= SPI_ENGINE_CONFIG_SDO_IDLE;
> > +	if (spi->mode & SPI_MOSI_IDLE_LOW)
> > +		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE;
> >  
> >  	return config;
> >  }
> > @@ -646,6 +651,9 @@ static int spi_engine_probe(struct platform_device *pdev)
> >  
> >  	host->dev.of_node = pdev->dev.of_node;
> >  	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> > +	if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1 &&
> 
> Currently, the major version is required to be 1, so this check is not
> strictly needed.
> 
This is expecting the MOSI idle feature to be available on all versions from 1.3 on.
Will SPI-Engine always be major version 1?

> > +	    ADI_AXI_PCORE_VER_MINOR(version) >= 3)
> > +		host->mode_bits |=  SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
> 
> 
> 
> >  	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
> >  	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
> >  	host->transfer_one_message = spi_engine_transfer_one_message;
> 

