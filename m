Return-Path: <linux-iio+bounces-24043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC53B560B6
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F5EA07F12
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236102ECD02;
	Sat, 13 Sep 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQCQks+N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2D26057A;
	Sat, 13 Sep 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766288; cv=none; b=vCZ5tTwQVjVdpMXi6gOkVmT2Ckg98xRrgX2YOix/GQdzQxow5tqL0kHbBshOSnxVvKIomyyum1l8RXKsKe8NX5qODDRQeRJhOc4CIZnhtqWQma4Ib0f3/dn9/8mO+sP29tnU2nxemGUr1rENPUuZvxo7uu6Wj+BV5H0Lj8pDs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766288; c=relaxed/simple;
	bh=Vv4EpD59A8wJjkz0wkOsjCktkIvh4LqGHl4EZ4PD0OM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJlENu0n3nEnvnns3qpwqxgQojKgZZu3xRQB+z1ilLD3BI/Esq83vfvQ7EktQdwfFGZKKcMME+GSQ96G2uh0mKkRJ8uH3kQaeHnJsMzxxC74oTSUup/MpfOC9RV56N0ijyrmnqx/O1+h1R9cGMR7QmaHEGcXcJLBpkiIhIxyPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQCQks+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14DEC4CEEB;
	Sat, 13 Sep 2025 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757766288;
	bh=Vv4EpD59A8wJjkz0wkOsjCktkIvh4LqGHl4EZ4PD0OM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eQCQks+NlXUcRnFtT45lg0458Zhcws1AN9ZBsGkb0V7k9pGL7WpYOM8mUxw7D0Nmt
	 qbaztFs/t6xiw7B17OIVZC48WKvpfmalX1c7RWhnvyiIsBfs6ieEqM6M4EHCJdak76
	 Bl4i1YEf7pmW2ZsEobH0rMibbmiZQ9BEvlkWEMm2PaMkQa9XnCSCPraIw3CuXPcwcX
	 RgXMW3fGTVRSnTLJhtKylrbgUPZ0Bf7VttYbhOTmfCAK/MeW9Oeq61t9BLXyGxjNHx
	 Wioi2qghp/QltAiSU1b2dVAGaWVadmFZ0IjNLsYSqMS6LbOK7e/xCwzTQwKWt0KHP8
	 fAnKdH7IVYiBw==
Date: Sat, 13 Sep 2025 13:24:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250913132438.11d14416@jic23-huawei>
In-Reply-To: <d586b4a3-8fb8-45b5-a5a6-5bee8d366879@gmail.com>
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
	<20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
	<20250910184619.0303163d@jic23-huawei>
	<d586b4a3-8fb8-45b5-a5a6-5bee8d366879@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 08:13:03 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Morning Jonathan,
> 
> On 10/09/2025 20:46, Jonathan Cameron wrote:
> > On Wed, 10 Sep 2025 14:24:35 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> >> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> >>
> >> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> >> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> >> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> >>
> >> The IC does also support CRC but it is not implemented in the driver.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Hi Matti,
> > 
> > A few trivial things that I'll tidy up if nothing else comes up (I might not
> > bother given how trivial they are!)  
> 
> Thanks again!
> 
> > Also one question. I couldn't immediately follow why any random register
> > read is sanity checking if an ADC pin is configured as GPIO.
> >   
> 
> Ah. Valid question! I see my comment below is partially wrong.
> 
> 
> >> +/*
> >> + * Read transaction consists of two 16-bit sequences separated by CSB.
> >> + * For register read, 'IOSET' bit must be set. For ADC read, IOSET is cleared
> >> + * and ADDR equals the channel number (0 ... 31).
> >> + *
> >> + * First 16-bit sequence, MOSI as below, MISO data ignored:
> >> + * - SCK: | 1 | 2 |   3   |    4   | 5 .. 8 | 9 .. 16 |
> >> + * - MOSI:| 0 | 0 | IOSET | RW (1) |  ADDR  |  8'b0   |
> >> + *
> >> + * CSB released and re-acquired between these sequences
> >> + *
> >> + * Second 16-bit sequence, MISO as below, MOSI data ignored:
> >> + *   For Register read data is 8 bits:
> >> + *   - SCK: | 1 .. 8 |   9 .. 16   |
> >> + *   - MISO:|  8'b0  | 8-bit data  |
> >> + *
> >> + *   For ADC read data is 12 bits:
> >> + *   - SCK: | 1 .. 4 |   4 .. 16   |
> >> + *   - MISO:|  4'b0  | 12-bit data |  
> 
> This is not 100% true. I overlooked the ADC read "status flag" when 
> adding this comment for the ADC data reading.
> 
> This should be:
> 
>   *   For ADC, read data is 12 bits prepended with a status flag:
>   *   - SCK: | 1 |      2      | 3  4 |   4 .. 16   |
>   *   - MISO:| 0 | STATUS_FLAG | 2'b0 | 12-bit data |
> 
> The 'STATUS_FLAG' is set if the input pin is configured as a GPIO.

That's good additional info, but I'm still struggling on why
we are effectively providing a 'debug' check in ever register
read. My assumption is that it should never fire unless you have
a driver bug?  

Jonathan

