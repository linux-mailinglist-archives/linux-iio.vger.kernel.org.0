Return-Path: <linux-iio+bounces-26396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50134C7E6D1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DF68341711
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DE23909F;
	Sun, 23 Nov 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRi4K1M9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F124501B
	for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763927313; cv=none; b=iXTEV9hReW9TkWLe7SPcTjxzOZIt10EnMq+FRaMZ1HWCYe53mgeebmOhqjibwOi/lIpSYVPCiywBpmR4luRfPVrvufTLEALNoaxKzSDmXUBrvMQ6ddATx3qYxU2tUVDU2jAD6yu+B52bf3Rzcm2BUPNAav2pycvXIbBgsNax7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763927313; c=relaxed/simple;
	bh=z90dP/gmrGc3E3iGgr4xN3P1DyqNNmslhpLsQcT2q7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqAYVEu4+Q1pyDQsjFy0W5S/WzzZSVJYk7mJTwTTlyj6yQTIdLOLnaxr6S8z4zIS90FlGWQqA2eSzfkdXLMwbHnlqXPeVAFhigjQ6OI3uQdIaKnJEJPYGsOQ/U4rOp0bK3wsKT5035PAWg+s3jrMifhnt/d2hOmy8dcSW1Rz4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRi4K1M9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so543363766b.0
        for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2025 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763927309; x=1764532109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tw1PE/7RiX5xgeVNMbWvJDSPG8tWD79BqHxtcrrWivA=;
        b=nRi4K1M9zlUotNKzAINsKbOf7KT4EuBMb1R6jtQ0BKsKr5JjqMTDvsDhdbit3HT1Eo
         uHhvfsYlqeX4ApR5UUMcUlAzwfwygtGxkjDygtwNIZmcqQhIaKG9Ktl3tEWxqNIs0hat
         /8xLoZeaw8aYbZbEy/0wczH4MwsHrRA4akM0uq20eLTUtta6sw+ncGBAItU7ks8PDt0D
         3OC15TT/THczhV7r0etSpu7iQrGg14bOijs2yMI2BiKF/5F4iIXFlzU35yLIa6cRU96o
         bPCTAU0Dhla78dRSlizlw/CSeuxjcBF1wN1APwt88BmaKUPMeP1w4TQQLUSfZZGsRF24
         vufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763927309; x=1764532109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw1PE/7RiX5xgeVNMbWvJDSPG8tWD79BqHxtcrrWivA=;
        b=K3vT1dfWbNwyQmwIfmRk4kCSWXTeMGU/GfyCJRzUd5szXDMxk+Vv3oIfhVa+tNBUlb
         C9n1FQUb5Y81s9kv6Su7MQVFr0bQYEsrWUaHo8nU8eOSEBqNav8AMMq5fuVEEJksi1bA
         /MH0t20MFvPQZvmWZlcAT9PD7s8cbaBzX9ZsGEkT4m4oAAJyqZPjIRWC65KDcQcSCTJk
         pAhkOPq3PVL5kmLHJTuD9fbD0WGGMUQkN7Xzsyvp+toCFIhdtVRZz41ws5pXtSt3UajT
         yZDFysifFZSjG+z2LJgdDErpvlziiP011f7stm0GH4EJ90pqgxQgVrdfvPZvJj1K65UB
         s+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUbob1XG3UIuaV1VbYJg/2+moK6FhdgUDW9wmAymcroKpZXEmrNZhgMv23ZzV0plyljLTlWGsJo6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggLT0yZLlH2QHeKiaa1emOFDgyGbd3r0V441LhIblECsin2B1
	ofkZummXKYzWGGSt2P/UDR2hwCWBYJ1Aeckcq+/giXYeojtQQTLXpgA7
X-Gm-Gg: ASbGncseJHLGeW9IbkTTmXIwyS3t1GazL2YQdrtrnGmZLKuAjWkRj6PpOXBLpcT0WLK
	/UwJc4iKTakHwreX11Gj8BKVfe1uYoPKb3tKfjBAi0a798p4KHezOkx21xx1QGiozs4BDikyXWa
	ot0NuSCF4pklw/ZSpVqmbQt5oaclUMUiA+sHzUaSFFc/0daKcwewUK3hAPw2wdyKs2zI4wb2L2O
	viLzwyGMn/lIxv2pvnRpea7/9WNDeSpnati8uU2aj2qOkdRz7/ZNfvoLjVC1YAwwPf+tBntmsLL
	zHd6+RftrLRZi64S2HPlrq04HaNwFCRIXTROlRAEg0sl1WhKsLqRq3Oyy+ged46jvr3t3DeIgKy
	DMKukUmyDLIZ9R1wh922mvUUpAOZXnwsoB960Xayjqj+er65bdKbrKlvPip55iWh8Wrd3KIMM4k
	SqNIICLNKed3HNp+P51+hYGkjaU82Ffwu+Bu7/vRRVaPmn0LeXq8thHTbCYXvBSUd4RGE=
X-Google-Smtp-Source: AGHT+IF4rSE58srn42tnY8ETc6zwxuPhwk117QeC9E0pzNnhNh6IzfVuWm+BbG43e5xDM79sc2H10Q==
X-Received: by 2002:a17:907:c1a:b0:b73:544d:ba2e with SMTP id a640c23a62f3a-b76715e604bmr1050588666b.25.1763927309268;
        Sun, 23 Nov 2025 11:48:29 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:38ae:e5e8:159a:3b69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765c1379ddsm997748466b.0.2025.11.23.11.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 11:48:29 -0800 (PST)
Date: Sun, 23 Nov 2025 20:48:27 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: adc: ad4062: Add IIO Trigger support
Message-ID: <egfjokiqoo6dxh6m3dhjtj2jtpbnw6p7pxxllth2unycl5fdf4@lirpbye74rtg>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-5-0f8ce7fef50c@analog.com>
 <20251018171425.7515d39f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018171425.7515d39f@jic23-huawei>

On Sat, Oct 18, 2025 at 05:14:25PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Oct 2025 09:28:03 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
Hi Jonathan,

> > Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
> > signal, if not present, fallback to an I3C IBI with the same role.
> > The software trigger is allocated by the device, but must be attached by
> > the user before enabling the buffer. The purpose is to not impede
> > removing the driver due to the increased reference count when
> > iio_trigger_set_immutable or iio_trigger_get is used.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> 
> A few things inline.
> Thanks,
> 
> > diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> > index e55a69c62694a71a4e29f29b9a2bfeec3b16c990..40b7c10b8ce7145b010bb11e8e4698baacb6b3d3 100644
> > --- a/drivers/iio/adc/ad4062.c
> > +++ b/drivers/iio/adc/ad4062.c
> 
> > +static irqreturn_t ad4062_poll_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	u8 addr = AD4062_REG_CONV_TRIGGER;
> > +	int ret;
> > +
> > +	/* Read current and trigger next conversion */
> > +	struct i3c_priv_xfer t[2] = {
> > +		{
> > +			.data.in = &st->raw,
> 
> If it is safe to use addr on the stack, do we need to have
> a dma safe buffer for raw?  I'm not sure for i3c!
> 
All buffer should be dma aligned, I will use the heap.
I will use a separate buffer that is written once (CONV_READ or
CONV_TRIGGER, depending if gp1 is routed or using the IBI fallback).
> > +			.len = 4,
> > +			.rnw = true,
> > +		},
> > +		{
> > +			.data.out = &addr,
> > +			.len = 1,
> > +			.rnw = false,
> > +		}
> > +	};
> > +
> > +	/* Separated transfers to not infeer repeated-start */
> > +	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[0], 1);
> > +	if (ret)
> > +		goto out;
> > +	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[1], 1);
> 
> Add a comment on this. I assume it's setting things up for the next
> scan?
> 
yes, the next scan is triggered after the reading of the current scan.
There are 2 registers that can be used for scans, CONV_READ and
CONV_TRIGGER:
* CONV_READ: Stop bit of the previous read (without write address),
  triggers the next scan. Allows roughly twice the sample rate, since
  does not requires writing the address every transfer.
* CONV_TRIGGER: The conversion is triggered by writing the address, so
  every new conversion requires writing the address again. Only this
  registers will issue an IBI data ready.

That means, if GPIO is not routed as the IRQ, in the fallback using IBI,
CONV_TRIGGER needs to be used. v2 will also use schedule_work to avoid
the IRQF_ONESHOT being triggered (next conversion data ready), before
the current irq_handler returns.
> > +	if (ret)
> > +		goto out;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &st->raw,
> > +					   pf->timestamp);
> > +
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> >  }
> 
> > +
> > +static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +
> > +	pm_runtime_mark_last_busy(&st->i3cdev->dev);
> 
> Take a look at the changes across the tree recently.
> Now pm_runtime_put_autosuspend() calls pm_runtime_mark_last_busy()
> internally to avoid the need for this pair.
> 
Ack.
> > +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > +	return 0;
> > +}
> 
> 
Best regards,
Jorge

