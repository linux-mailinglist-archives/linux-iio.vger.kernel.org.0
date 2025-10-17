Return-Path: <linux-iio+bounces-25214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7522CBEB698
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 21:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FC394E48BF
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673512C21D5;
	Fri, 17 Oct 2025 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBvNa1Ka"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBE2405E1
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730827; cv=none; b=ue+XMDGMqMchXSSf/pU7PyeLeTsoCaiyoOD5dCzTw7aK67djmpRdA9Dk5ZF6LdMFDEo9GiXI+ENg2sM1fxRC+msj85cXdEZdx1I7H+p/u+F37bWBJrkPsT3Nlwz2AhsKzERh5fOADzt5E2vsjH9JguTTh1muRwvJj91OdY3wrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730827; c=relaxed/simple;
	bh=i5Hk7l6xoSrN+AXcpR4MGOF8Rj8+Hz0UPLQLCeNrNAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJMYYRgRGhOtq7ag1ztFTPvXuqO4oFbwKYXhVi/q5XxM4x6bZcHHKKZ+9Wc067O4Tz34SMKe7KJoyyCijer+VmilT1tXiK8iKTEHQbqFI/AhiklJQ9CGAmgpRY+FiEbOOeoTnqJe5CpwBxYpRuJ2OtmHrG70P0gsLRQdbWZBctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBvNa1Ka; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2907948c1d2so25224015ad.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760730825; x=1761335625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66FjiNXaw8TmphFF9eNaWop8aMdiITfbjide+1BjBFk=;
        b=HBvNa1KaWts9c2rgQWDkU20KWOrpUxl8AmeijyxnjLCTYQ+yX8wZwQBP1+mInRgJU/
         nDuIMZ3LOacOaNqmO7/rDisXD7QbkgKSFnhRI3vVVV2Rk1Zocd6Qg9ZsXe6kr8D2gTcZ
         yZ5aK+e3qiqVvqypWxOyx0mIZhNcq+NGNtCk1v9VxxGpqYuGZg+F6BH4qArboXz8CpIV
         k3UWekdRN1beDAIdt1uztpZWQ+dLekrvQbUbekmVnrXh5+tjezrS/7+76K8oSX1SRV/c
         EmPO0qDPVpbbDsgTiy8wuNSOAllCtDjcSHPkQ11Pb7VSZ8oUW862fefddu+fzKlY9raP
         5exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760730825; x=1761335625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66FjiNXaw8TmphFF9eNaWop8aMdiITfbjide+1BjBFk=;
        b=EsI3KURIGoJ4cPa21BLDRJRwQSPJQUgBIs+E3L20u5sxGpf2B0uNR8I3rbz7ohRT+I
         W58oEDys8RB/eQ0JwFWxeNfBpa30WlIs2bHi56fNpq8VFJTWtikb4ECvblg9ZtPIhzOP
         hyHQnPgchIm9qxXP9QlErN0DK4ua4CvmJ9831fQOY6QAqUEpmEWt1i4r2wmxuaJkNfTk
         IBgXA+rgxJLVvOAJ18oD57V86loCAmjBZdW0lMs7FlXptPYpgaBq1WDXImcOvZofnf0D
         Hb13eX3dMBd2mBITpy7mPEs34DzUR2v98aNfd3GJuvtCNlF3OZV8VfWFHtJVfCGcdyKn
         twnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkUoXsMTaoe30K/lJMAwpXZMY/Nn/oeVqJOgRExI4FFU1Thdye5aR6rcpHVpBDiGTFyqrVGRarKO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyldDbf0se4AspZTWiCnAHE8wvnGy6eOcB+e4WkA/ugqbxTII0
	K6BLS1jevnZ3k4/pDHSUMoZczDK/hopLyucatLAzGa9rMsFClElu72k+BZj1AJvY
X-Gm-Gg: ASbGncuAfeVSxwpQCn/rMSOJE5uDLuURXGvk4Pk2zT03oqc9xpFW9tkv7Eb+LA4J+xS
	/DisPnuNVsso1Qd5MZhkuZxmemfDS6S+skMS3bYESdqdpMKI97dXDRYWDjfw9A3PiTR491yKbvf
	+09YthuC0PHzGWyWoVaikgD+GaD/fOdlsnphPrIiitZnjA4UvO/NVO1ekEov7/JLHFYPGjyQFmJ
	84mv0H+u1IXenrgoqPA1fHw3AZfFE+g+ETI3Cahi4TO9ouLOzGRMi36iPXHgLboWKHsYrOz/bPo
	zqFNAiihm9gYOPrSLDq3Zz8WWR8qvCFmvVTTp8anFDaMioobcUZA6N0QtqiFbEViFAmypAT79Xf
	DMSEQZqoFFeuOw9YweG+WpbIGN7uyeMPpvYiRTg9fsctj73aeS6LN2V9hOL785tuv8Tsn9itSoN
	fpMzmk3oHEG/znsBl7plGH0Rlw7tzmONc=
X-Google-Smtp-Source: AGHT+IFmw4xfU96UxI5JCpiksAaEuctIniSQG6RkIj6XxJvpDrHo87ypYEHktyPgkIumG9POKqgUKQ==
X-Received: by 2002:a17:902:f550:b0:269:874c:4e48 with SMTP id d9443c01a7336-290cb65ca69mr70425735ad.47.1760730824956;
        Fri, 17 Oct 2025 12:53:44 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-292471fd9ddsm3303605ad.89.2025.10.17.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:53:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:54:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
Message-ID: <aPKfCbZSXxaHICel@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
 <5e3a1d31f3cec340650e2e63db79903b78ab9a1f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e3a1d31f3cec340650e2e63db79903b78ab9a1f.camel@gmail.com>

On 10/17, Nuno Sá wrote:
> On Tue, 2025-10-14 at 19:22 -0300, Marcelo Schmitt wrote:
> > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > samples per second (MSPS). Not all SPI controllers are able to achieve such
> > high throughputs and even when the controller is fast enough to run
> > transfers at the required speed, it may be costly to the CPU to handle
> > transfer data at such high sample rates. Add SPI offload support for AD4030
> > and similar ADCs to enable data capture at maximum sample rates.
> > 
> > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> 
...
> > +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4030_state *st = iio_priv(indio_dev);
> > +	unsigned int reg_modes;
> > +	int ret, ret2;
> > +
...
> > +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> > +					 &st->offload_trigger_config);
> > +	if (ret)
> > +		goto out_pwm_disable;
> > +
> > +	return 0;
> > +
> > +out_pwm_disable:
> > +	pwm_disable(st->cnv_trigger);
> > +out_unoptimize:
> > +	spi_unoptimize_message(&st->offload_msg);
> > +out_reset_mode:
> > +	/* reenter register configuration mode */
> > +	ret2 = ad4030_enter_config_mode(st);
> 
> nit: if ret2 is not being used at all, maybe just
ret2 is logged on the error message below so I guess I'll keep it as it is.
> 
> if (ad4030_enter_config_mode(st))
> 	
> > +	if (ret2)
> > +		dev_err(&st->spi->dev,
> > +			"couldn't reenter register configuration mode: %d\n",
> > +			ret2);
here we log the error code. We only reach it if reg access fails after
something on offload buffer enable have failed first. We cannot reuse ret here 
because we would be shadowing the original error code.

> > +
> > +	return ret;
> > +}
> > 
> 
> ...
> 
...
> > +	} else {
> > +		/*
> > +		 * One hardware channel is split in two software channels
> > when
> > +		 * using common byte mode. Offloaded SPI transfers can't
> > support
> > +		 * software timestamp so no additional timestamp channel is
> > added.
> > +		 */
> > +		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
> 
> Maybe I'm missing something but common mode is not supported for now so isn't
> the above wrong?
> 

Yes, that was buggy. Dropping common-mode channels as last minute change was a
bad idea. I did another set of tests with ADAQ4216 and fixed that for v6. I'll
also re-add common-mode channel support as a separate patch.

Thanks,
Marcelo

