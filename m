Return-Path: <linux-iio+bounces-8783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E6995EDFA
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3E286181
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF214659C;
	Mon, 26 Aug 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdT9otjG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DB146A71;
	Mon, 26 Aug 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666523; cv=none; b=RDtj56+qDEppagD2N2TUMXhkNTmJts3B0hGlefkqNVnhA+jT+nASiJngX/p0fusty2Tci/VdLtnw5tGQd024df/HiLftxrbnm7MpLRCR+bvTdxRY9BQgQiZNWBvFi6KMPTkGbR68mnp8DoxHzejXpPEeodK7vzBjEZnQCoY6kBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666523; c=relaxed/simple;
	bh=2bOnO0n6dYgvuE21Uq9+WsJrkGncEn9LYJnCBKux97I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHNWPdHKWK7c3hdJpIi3Vrk/JgmogpcFddq1c1xIN/9pbCiZqramLyNViHhLGfPm8MV7Cz2ygEUJ7Hpnmn9kYO/41GX3mPxe4tbY1DBDmj8aaBuBOe4BcVU1IaoQhV+jlpzY4pC0w5zRxowwvzpjAkdS01vyDvzXujv6+1GqR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdT9otjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF6FC51407;
	Mon, 26 Aug 2024 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724666522;
	bh=2bOnO0n6dYgvuE21Uq9+WsJrkGncEn9LYJnCBKux97I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdT9otjGdc1TQpp3yvN/W3dTwLtDRB4/DpulPZluyP15DvpWhe6zN1FuqVMor/jVN
	 bweCHmtPX6yuC0TU18QqYuId/eELMYKeykF3dP3awC/ov6mlWt+Sqf5JIzylDN5NUD
	 Ls5vIQKFHk7JaJK/HKG2s6wfbEdVnazXdIJDPXku5vR2lBVoB+ECO+zWJUTnkMPDWh
	 vFKnJjfS1rUQmopyTFnUX6i+hjvMQHpxi20bV1+ZK3o93c4YppmFAIKKaHp7VVvWxX
	 Vh/hNNgHT/dvL494n/PBWxsJkU19VxXOR8CJeO3wP899ab4ZjqYtOEfXwSad1PpNMK
	 Gfg4/xjdvHmPw==
Date: Mon, 26 Aug 2024 11:01:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240826110150.5f2e5c72@jic23-huawei>
In-Reply-To: <20240824120222.GG9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
	<20240823181714.64545-7-vassilisamir@gmail.com>
	<ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
	<20240824120222.GG9644@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 14:02:22 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Fri, Aug 23, 2024 at 11:06:28PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:  
> > > The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> > > a trigger for when there are data ready in the sensor for pick up.
> > > 
> > > This use case is used along with NORMAL_MODE in the sensor, which allows
> > > the sensor to do consecutive measurements depending on the ODR rate value.
> > > 
> > > The trigger pin can be configured to be open-drain or push-pull and either
> > > rising or falling edge.
> > > 
> > > No support is added yet for interrupts for FIFO, WATERMARK and out of range
> > > values.  
> > 
> > ...
> >   
> > > +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> > > +				  const struct iio_trigger_ops *trigger_ops,
> > > +				  int (*int_config)(struct bmp280_data *data),  
> >   
> > > +				  irqreturn_t (*irq_thread_handler)(int irq, void *p))  
> > 
> > irq_handler_t
> >   
> 
> But the function returns an irqreturn_t type, no?
irq_handler_t is a typdef for the full function signature.
It will still return irqreturn_t 
> 
> > ...
> >   
> > > +	fwnode = dev_fwnode(data->dev);
> > > +	if (!fwnode)
> > > +		return -ENODEV;  
> > 
> > Why do you need this? The below will fail anyway.  
> 
> Because If I don't make this check then fwnode might be garbage and I will
> pass garbage to the fwnode_irq_get() function. Or do I miss something?
It checks for NULL which is all it can actually be and returns a suitable
error code if it is.

> 
> >   
> > > +	irq = fwnode_irq_get(fwnode, 0);
> > > +	if (!irq)  
> > 
> > Are you sure this is correct check?
> >   
> Well, I think yes, because the function return either the Linux IRQ number
> on success or a negative errno on failure.
> 
> https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/property.c#L987

Indeed, so if (irq < 0)
		return dev_err_probe(data->dev, irq, ...)

	carry on as valid irq.
your error check if returning only if irq == 0 which never
happens (due to catch for that in the code you link).
Negative values are true, so !-EINVAL == false
for example.
> 

