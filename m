Return-Path: <linux-iio+bounces-14141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA06A0A630
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 22:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F70168555
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370C1BC09A;
	Sat, 11 Jan 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auD1K+uB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFCA55;
	Sat, 11 Jan 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736632582; cv=none; b=IMOzjuV+hy5for/PVLaaYtuBRgdX/y7qoDDjfCtw/6uLt4P6aezUDtEF8vS9zCCMsjKHJszCwuaml7H0HiG6O9K8nVdjB2qGwNOxfXh0vlPQ1eEb+1OFAAyW0jnz7zrOGJ2Ozdw8Q/SPjFaSCoTNNBIjaqMPGYkxMWZbQ9DQdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736632582; c=relaxed/simple;
	bh=wVAIOcC8/MluVMZNcHxAYpkkoZnwc3NcstGDJ0zZu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI1Wm+yTT2nCfL7kKqAb60SNiXVGbYIUszGlr81T5vXvXWLScIlsjgmPlG/KE8iMedezzQIzDoY72Mq3c/3HAiuT0GTmoqLRs/fYs//TT/Xf10fenTflouwC2G9k0QZJPIA5w8hHSZgUmYhcC6DDRelwMhpGtbE+5RhZD7Iv7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auD1K+uB; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e31d295eeso367814a34.3;
        Sat, 11 Jan 2025 13:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736632579; x=1737237379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loOtPquvh3+Rddn8R48POaSkeUCptBGFOlaZFrQdYso=;
        b=auD1K+uBW83olQ+A4M/xN5zcG7FgVpMoGIgMKCDqpKMdUiN02xTSwPvIp04kfqL1Oi
         NZvWgZpwkc8r1siPhy/MNdhPmxiZNqWfshbHixGRjgHdoYNvIWGL/kZYY7RsPrtTdJ+P
         xnzArgNOpxipyCEArUqiNvWbu3Eg8k4RrndNORW+PjarhCzdQY+zvJAkuBAQaHb21V9z
         P1Rt5u+Dr8ljLiTm/zTfBMKwcEfAAF0Qrx7l8DgGAGh1+v/J0K7/YDxgUqQMBaHHz5q3
         Jhr8SUHihCwuO2RithQOR2YCPTBiXBiFoAR5olyKTNl8jFn3JjCDdhW8zw6YSqKufpuZ
         Gcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736632579; x=1737237379;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loOtPquvh3+Rddn8R48POaSkeUCptBGFOlaZFrQdYso=;
        b=ik0FDhpruRVLWkxRJIMRjnRMtV+4vh1mCUF8Yj4zrzQ2/GsBNDsI0LJc9xUsbe8SeK
         XOJsiy1C1I2g0eL3fzeIb3LLcTHQZT8DA/3Gsmx/VkL4DhvMiOdXtc7bVWcYGOPMxQWZ
         1y+6N+q9coSoBWXmryiAVNoeHj+ci7AfSc05oc7505Jh1uNJLWQ0fNWAX00sL7dHhLgv
         p2zcz7m0LGWY73Ueo2XmVPwDCXXuoPNadxZsqDMR8PTtWzYXVB9qbFfUHt/EaeWM8lCH
         067oRvS3UYd349m6huUMq3WiMBHlnAqSJVStEnzavkfNWRlaoum9Dr1c459nUGi1OBnB
         kQKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+OYW7jPTe6UeAX8SbaUTheyNuZL0YogctkgBOxcVJrnKE5wsSnQEHD9WTl/E45EGN2+6/CM/J7tqc@vger.kernel.org, AJvYcCWiKWq8cDNPI6U935sWlPB04aEinydpNowWSKal7BehJPl2Bphrvo1wKeN3/KvS576fjfBGe7zTIrOp@vger.kernel.org, AJvYcCXZgG+V9a9tRheHr4ikmKqDR8JhcDogAar4icbxkMbhJwbA3qHKh452Tt3OVUBoDHDMSJbJGbcBqC3ktJsN@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXn1vAD9Q0vawzbhFtxzitz00JfZp6HSu3dr4PpuQxiAiDbsv
	Cim7et5nri0O1iSGzCpQpcDF6ro1vF+owboxhQaAA0/RCG5cORES
X-Gm-Gg: ASbGnctvDl1CKEj008M+ClFH4r3I8RWNtKqrLDcpp1xaffC9PxdrmYS5O8y95MViv+S
	r71lIGJXWqK2i+qaV7UsVlWKYBeiq8INNR/lfNImzZ/mbi0dZdwvdBSN1Y0waNKGfm42VdMoIbh
	kvuHIhLKzI+8E02J7iRbIcxdyZ6v+jSBzFTqkLFsVp4tvlINunkwqpXH2R1sO3cuGsOhWdcNHS4
	uIAYCtlaS7toc+GIRIw0GnjlPWVGgguWddwf2SNlJCdACjwqvggfOAl8daKo1Mi98OKDPCTTr5A
	GA==
X-Google-Smtp-Source: AGHT+IGuHISPlavr3hGJB+OMwWrc9jBpOUN+SV1VDOHzQz20bQR9b31+g8SYn+XssRntWIJfIqFvTw==
X-Received: by 2002:a05:6830:6206:b0:71f:c1df:7b5 with SMTP id 46e09a7af769-721e2f2cbbbmr3966321a34.7.1736632578914;
        Sat, 11 Jan 2025 13:56:18 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231862a20asm2027666a34.65.2025.01.11.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 13:56:18 -0800 (PST)
Date: Sat, 11 Jan 2025 18:56:13 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 00/15] iio: adc: ad7768-1: Add features, improvements,
 and fixes
Message-ID: <Z4Lo/cmUbKeBJWce@JSANTO12-L01.ad.analog.com>
Reply-To: eeea054d-ebe8-4917-85c6-ff001cef50c5@baylibre.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <eeea054d-ebe8-4917-85c6-ff001cef50c5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeea054d-ebe8-4917-85c6-ff001cef50c5@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:23 AM, Jonathan Santos wrote:
> > This patch series introduces some new features, improvements,
> > and fixes for the AD7768-1 ADC driver. 
> > 
> > The goal is to support all key functionalities listed in the device
> > datasheet, including filter mode selection, common mode voltage 
> > configuration and GPIO support. Additionally, this includes fixes 
> > for SPI communication and for IIO interface, and also code improvements
> > to enhance maintainability and readability.
> 
> It looks like some of the patches also have to do with a sync trigger for one
> or more chips. There was a recent discussion about this for another ADC that
> seems relevant:
> 
> [1]: https://lore.kernel.org/linux-iio/20241128125811.11913-1-alisa.roman@analog.com/
> 
Interesting. That would cover the case where we control the synchronization with a GPIO,
but it gets more complex when using /SYNC_OUT in a multidevice setup, since it requires
sending a SPI command to the "main device" to toggle the pin.

The main device being the one which its /SYNC_OUT drives the others SYNC_IN.
> > 
> > Jonathan Santos (8):
> >   dt-bindings: iio: adc: ad7768-1: add synchronization over SPI property
> >   Documentation: ABI: add wideband filter type to  sysfs-bus-iio
> >   Documentation: ABI: testing: ad7768-1: Add device specific ABI
> >     documentation.
> >   iio: adc: ad7768-1: set MOSI idle state to high
> >   iio: adc: ad7768-1: use guard(mutex) to simplify code
> >   iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
> >   iio: adc: ad7768-1: add support for Synchronization over SPI
> >   iio: adc: ad7768-1: add filter type and decimation rate attributes
> > 
> > Sergiu Cuciurean (7):
> >   iio: adc: ad7768-1: Fix conversion result sign
> >   iio: adc: ad7768-1: Update reg_read function
> >   iio: adc: ad7768-1: Add reset gpio
> >   iio: adc: ad7768-1: Move buffer allocation to a separate function
> >   iio: adc: ad7768-1: Add support for variable VCM
> >   iio: adc: ad7768-1: Add reg_write_masked function
> >   iio: adc: ad7768-1: Add GPIO controller support
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio       |   2 +
> >  .../ABI/testing/sysfs-bus-iio-adc-ad7768-1    |  13 +
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        |  24 +-
> >  drivers/iio/adc/ad7768-1.c                    | 830 +++++++++++++++---
> >  4 files changed, 747 insertions(+), 122 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > 
> > 
> > base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
> 
> What are all of these prerequisites?
> 
I might have done something wrong while generating the pacthes, i will check this.
> > prerequisite-patch-id: 8b531bca46f7c7ea1c0f6d232d162fd05fda52f7
> > prerequisite-patch-id: c8c8637cb3343097c3224a9aa315fc45dca15f45
> > prerequisite-patch-id: e0baac9ef84e6e8a0a272fc6191fc1cb48143e44
> > prerequisite-patch-id: 7e5cad70809fa7d37e917628147c197427c11594
> > prerequisite-patch-id: 28dcdb0ebc3ca3c02713f83c94a4eedbe81095dc
> > ...

