Return-Path: <linux-iio+bounces-6990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF691AD77
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195711C252C3
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2819A28B;
	Thu, 27 Jun 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTKt+KpR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29B433B3;
	Thu, 27 Jun 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508115; cv=none; b=t9dH1t8YEY1/hjWwSeQ81pnb00J6c6QuEqYCiae0CVTLbj/oNzH3iiTpMinN31LmAqqhKQUWkIX8M+bWlrQps9WdyV7p1dEvMrWy2j9iCdKdosxlzr35+NWMmhQzVMDb9BxFJwbqpCiYTq9IXVMnXMbRX+YnPyjl6gwJNtaFWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508115; c=relaxed/simple;
	bh=njE5CtSj/rNk0kn/54bHXhFvciLXp+Rn2NIuSOZj/Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbQb6De6DU7k9LveW8I2DQ35taJJxVLiugVhhF9oVNkEml0UGxDL7max6UoUzcxkqZk+cwAmMPRPJBnjneXnbDyUMK2k/lnbMunDKZo1cC8dnsjMc+zAifcStSURKQjT1OmQYCHLSqYOgAZOi5Wy62+hMpvG326zvUlg3QleOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTKt+KpR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7178727da84so4487621a12.0;
        Thu, 27 Jun 2024 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508113; x=1720112913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/IpdaNLmIgjligGg+u33YkSiigwxfjiieqRMpTLJxTc=;
        b=BTKt+KpRaPLzMChei3KoIi2hBBJkFQ33W2ZNQCKYaaCQbcF4/XNlIPDvxp7ZD1HcJU
         qLPZfA+XG41oR+VyXLKrMBFzZqYYWvTLpJRJy+pxjFvQJWpCNf5xabcm4JKepXQ3PtQr
         GAoW8/HIYtlguhO6BMsUFlnBeB6vDqu+jodS9rU/rg/QCxzBVZ7VeU0626YysALUyOxj
         eYUvPJOhPogF3zlm0ZvnPrMnM2ZZc3J+HbMEQqpKkRCKcHJwo3Rx/cTAKrz8L0xOBUPp
         OAQsec4rgeEb6v/bzFXSyyqtKQZEpGKYfR/C+S1q7dGJGtCUGZaxwSA0ozWjkJiV1OAB
         Pc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508113; x=1720112913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IpdaNLmIgjligGg+u33YkSiigwxfjiieqRMpTLJxTc=;
        b=eg04E5aKMWZ6ZSuObiHJG+RBhfc3QKS3fWso13R49v5DMO81MXvhynDaB+cxwMHRKC
         LQ0l09/HZYJ1SscKDEp7YztOkIU3b2J7m2DWYuKDFPG+k621gP4m4L7kWbXc3qUdkxdq
         dxtCGGDmCw8cKHinw6XvHlEIOl3as2NoZx45nf2nfbRE+h0PyVxmR7PYkRANXQw35B04
         74EIyyeVb+9tW2iNx4rArtE8PIzRoqjsj7/Im8bHRrE4eQPRhW44ujFWEp2Z5Kez/Z3p
         iNSlTtU1rcLZSE4c6UAcSLXvINTsmEoMlT1VbXON5rK6WjTZZrpUOOxSP0PuGTZVuQH4
         R6GA==
X-Forwarded-Encrypted: i=1; AJvYcCWz66THI3yy2BxPypQA8vz3Si2SjSan9RQO6kuml8VIBhxAX+0sKZ3qVp0USKaXAkGdmNCDSSFAp1bJfXDYd+5bl0PoGA1q/iUQ/l0ddx/jrHLO5+uEuAk7T7mWD3CQ2pQrmkcIWs8PU3VcTAYpXXk96uBqFWP2r8KE90irXy27Z0kLvtd3Q2ujFap2ie3bl7CEsBoz161OxRL+Wf9jQQeWoIPMxHF0htJO8RuACk444o1umPo/ARES3A==
X-Gm-Message-State: AOJu0YzgV9mZBsms6aEjr57PppsRay6/dtnhmoFCykfW56bj72MkPS/B
	osB+cf12RNI8iiQaUSHvINrNELAePsCHDV+ay/mIWV31n4LbrZ1C
X-Google-Smtp-Source: AGHT+IHqvQQBxkARL9ViZknQisxeNyRfWIBLwm40l924BqQRCfbzfJ1gVbYaxrsEdKf9SpdvNc+ZCg==
X-Received: by 2002:a05:6a20:728c:b0:1be:cdce:9fb7 with SMTP id adf61e73a8af0-1becdcea170mr3525520637.19.1719508112716;
        Thu, 27 Jun 2024 10:08:32 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a5bbf5sm1597190b3a.215.2024.06.27.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:08:31 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:09:59 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
Message-ID: <Zn2c531lfpBErYKb@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
 <f6dc458f759c47154eee16354c807c020028512e.camel@gmail.com>
 <ZnwU3MovTWfrovrE@debian-BULLSEYE-live-builder-AMD64>
 <53ae33f72d2326a58db3bcf629fc522db3acf550.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53ae33f72d2326a58db3bcf629fc522db3acf550.camel@gmail.com>

On 06/26, Nuno Sá wrote:
> On Wed, 2024-06-26 at 10:17 -0300, Marcelo Schmitt wrote:
> > On 06/26, Nuno Sá wrote:
> > > On Tue, 2024-06-25 at 18:55 -0300, Marcelo Schmitt wrote:
> > > > Add support for AD4000 series of low noise, low power, high speed,
> > > > successive approximation register (SAR) ADCs.
> > > > 
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > ---
...
> > > > +	ret = devm_regulator_get_enable(dev, "vdd");
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Failed to enable VDD
> > > > supply\n");
> > > > +
> > > > +	ret = devm_regulator_get_enable(dev, "vio");
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Failed to enable VIO
> > > > supply\n");
> > > 
> > > devm_regulator_bulk_get_enable()? Do we have any ordering constrains?
> > 
> > No ordering constraints, but vdd and vio are optional while ref is required
> > and
> > we need to get the voltage of ref.
> > devm_regulator_bulk_get_enable_read_voltage()? and discard vdd and vio
> > voltages?
> 
> Hmmm, vdd and vio do not look like optional to me :). Anyways I meant
> devm_regulator_bulk_get_enable() only for vdd and vio and still treat ref
> separately.
> 

I've mistaken these supplies with supplies for a different device.
Yes, vdd and vio are required and devm_regulator_bulk_get_enable() is useful
to init them.

> > 
> > > 
> > > > +
...
> > > > +		/*
> > > > +		 * In "3-wire mode", the ADC SDI line must be kept high
> > > > when
> > > > +		 * data is not being clocked out of the controller.
> > > > +		 * Request the SPI controller to make MOSI idle high.
> > > > +		 */
> > > > +		spi->mode |= SPI_MOSI_IDLE_HIGH;
> > > > +		ret = spi_setup(spi);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		ret = ad4000_prepare_3wire_mode_message(st, indio_dev-
> > > > > channels);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		ret = ad4000_config(st);
> > > > +		if (ret < 0)
> > > > +			dev_warn(dev, "Failed to config device\n");
> > > > +
> > > 
> > > Should this be a warning? Very suspicious :)
> > 
> > This devices have some many possible wiring configurations.
> > I didn't want to fail just because reg access fail.
> > Maybe ADC SDI was wired to VIO but dt don't have adi,sdi-pin = "high".
> > Reg access will fail but sample read should work.
> 
> Well, to me that really is a configuration failure and we should treat it as
> such. If we are in the so called "reg_access_info" which I read as "we can
> access registers", failing to do so should be treated as an error. 
> 
> So, setting scale would also fail and we then have a broken interface :)

Drat, that's right. 
Okay, will make probe fail if config fails.

Thanks,
Marcelo

> 
> - Nuno Sá
> > 

