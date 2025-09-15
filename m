Return-Path: <linux-iio+bounces-24114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A939BB5815A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B573A23D8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F522A1D4;
	Mon, 15 Sep 2025 15:55:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2821883F;
	Mon, 15 Sep 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951711; cv=none; b=Y6qHb/SIG1PdyrXfIw8Am0+80VpXaglw7I8zlFirJ9d51ltk8Y9yZwVPSoMsg27LaXYnWuJe+DJ89H+xAIn0RqJui6YgfjOcszTIvvJBRBL2x4B0JI4kPowcBfMKi0HuaXf1KMXyFabcDreMAAYL3iUIqCVHMJBweUWp6Mb48Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951711; c=relaxed/simple;
	bh=jyNyeciSLMh+iVMZpndRFFCqFiP+0UlzjSzUmf7LWzY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5BHALqzHP9sVGPAQGcGSDHW/sewheYhmAYqJte7313KFyXPunznlqa7F3w73AnZ/9Ih2DpIHNBCZseThIUYS039f9+i3/gl1RuKIzlkbFMPX1xD9exaFwqKvag1nO+2QuHYNGWjJvwCkznuclpu6iteV/k2wZNJ7jbQiO7pLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQTyR6nsHz67J7D;
	Mon, 15 Sep 2025 23:50:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C4FF1400DC;
	Mon, 15 Sep 2025 23:55:06 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 17:55:05 +0200
Date: Mon, 15 Sep 2025 16:55:04 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Linus
 Walleij" <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250915165504.000077e3@huawei.com>
In-Reply-To: <7c1cd888-539e-42f9-8333-a68044257531@gmail.com>
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
	<20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
	<20250910184619.0303163d@jic23-huawei>
	<d586b4a3-8fb8-45b5-a5a6-5bee8d366879@gmail.com>
	<20250913132438.11d14416@jic23-huawei>
	<7c1cd888-539e-42f9-8333-a68044257531@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 14 Sep 2025 12:25:06 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 13/09/2025 15:24, Jonathan Cameron wrote:
> > On Thu, 11 Sep 2025 08:13:03 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Morning Jonathan,
> >>
> >> On 10/09/2025 20:46, Jonathan Cameron wrote:  
> >>> On Wed, 10 Sep 2025 14:24:35 +0300
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>>      
> >>>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> >>>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> >>>>
> >>>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> >>>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> >>>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> >>>>
> >>>> The IC does also support CRC but it is not implemented in the driver.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> >>>
> >>> Hi Matti,
> >>>
> >>> A few trivial things that I'll tidy up if nothing else comes up (I might not
> >>> bother given how trivial they are!)  
> >>
> >> Thanks again!
> >>  
> >>> Also one question. I couldn't immediately follow why any random register
> >>> read is sanity checking if an ADC pin is configured as GPIO.
> >>>      
> >>
> >> Ah. Valid question! I see my comment below is partially wrong.
> >>
> >>  
> >>>> +/*
> >>>> + * Read transaction consists of two 16-bit sequences separated by CSB.
> >>>> + * For register read, 'IOSET' bit must be set. For ADC read, IOSET is cleared
> >>>> + * and ADDR equals the channel number (0 ... 31).
> >>>> + *
> >>>> + * First 16-bit sequence, MOSI as below, MISO data ignored:
> >>>> + * - SCK: | 1 | 2 |   3   |    4   | 5 .. 8 | 9 .. 16 |
> >>>> + * - MOSI:| 0 | 0 | IOSET | RW (1) |  ADDR  |  8'b0   |
> >>>> + *
> >>>> + * CSB released and re-acquired between these sequences
> >>>> + *
> >>>> + * Second 16-bit sequence, MISO as below, MOSI data ignored:
> >>>> + *   For Register read data is 8 bits:
> >>>> + *   - SCK: | 1 .. 8 |   9 .. 16   |
> >>>> + *   - MISO:|  8'b0  | 8-bit data  |
> >>>> + *
> >>>> + *   For ADC read data is 12 bits:
> >>>> + *   - SCK: | 1 .. 4 |   4 .. 16   |
> >>>> + *   - MISO:|  4'b0  | 12-bit data |  
> >>
> >> This is not 100% true. I overlooked the ADC read "status flag" when
> >> adding this comment for the ADC data reading.
> >>
> >> This should be:
> >>
> >>    *   For ADC, read data is 12 bits prepended with a status flag:
> >>    *   - SCK: | 1 |      2      | 3  4 |   4 .. 16   |
> >>    *   - MISO:| 0 | STATUS_FLAG | 2'b0 | 12-bit data |
> >>
> >> The 'STATUS_FLAG' is set if the input pin is configured as a GPIO.  
> > 
> > That's good additional info, but I'm still struggling on why
> > we are effectively providing a 'debug' check in ever register
> > read. My assumption is that it should never fire unless you have
> > a driver bug?  
> 
> Yes, a driver bug or someone accessing the ADC outside the driver.
> 
> I kind of agree the check shouldn't be needed - but I've seen quite a 
> few driver bugs during my career. XD The check is _very_ light weight 
> compared to the SPI access time - but you're right that it is done at 
> every ADC data read - which is 'hot path'. As a result, I am not sure 
> whether to leave or drop it.
Maybe just add a comment along the lines of
/* Lets check this whilst here, but should never happen! */

> 
> Yours,
> 	-- Matti
> 
> > 
> > Jonathan  
> 
> 


