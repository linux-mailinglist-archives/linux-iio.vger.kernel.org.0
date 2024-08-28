Return-Path: <linux-iio+bounces-8844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE6B962992
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160771F254A3
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E2176ABA;
	Wed, 28 Aug 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQzo0utK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06A16BE06;
	Wed, 28 Aug 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853689; cv=none; b=iuaZOY9Ds9ssRVlUgDqNeoe5wn3dl3AvvI92bquurLKqx/lYmDrfaVMzgKblMcvlY9ypiZF2Cq6lJjqoG6dhwYSNFRXEei3D1EQ+r8a/4hCNqlWiN8XtQ3EK/x1ndG1NjhvD32rD/trQdKFbGPFmqCNOGA7+0ci3+uMyxl81UB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853689; c=relaxed/simple;
	bh=nRr179BtBxb/Y/0dnj/sJX6MHVC7tZBnmMjP//Gtkks=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESof9JPX3wJGEuXCGOrYEx+qZ7PQpcpUfF8QHyT7ACJcHVegsfQlkIrJKdp3YUBTs8ssT+/NcJ9GIpk4NzhxZxZmEIqv8fg8VTlSDffGRaVrauu+Vs8oIYZ0Fdi7wxBiNoGUMyLihT6A8+NKjGSr4Z3STA25Ci6e9VSD2SJxneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQzo0utK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533461323cdso7853777e87.2;
        Wed, 28 Aug 2024 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724853685; x=1725458485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty49zj19B9dflfxgkTafzOnR24yLpnVjka8nQSk8PJM=;
        b=hQzo0utK09pkBOWuZu3Ij/nEmr3lL6NV8rQtSB1vYv1JJI5189mYl7RN3TrhOjXrnr
         nEc+0n1nSK6iokhAif/x/bNnSZhTmaIKxx3KtMEuK9z5ESv60jzNOa9iAvEDcFfPEGxz
         arKC2y/HYVBjmgHzxhXnZLvLSBB8dZYPQQr3BrxINqanqRVlnmlD8n3zeyFQQQ1r2FE/
         XzHNVGEtMz6FMrLQKRHi/XKZZesG1sk7kp5I8fNYNA9QzDdbAeHdyhCRYuXOQvf1+ZBF
         oomExAEj+ONJ+flgnplK9ScjvHjKLfpnta7kkbiVQzX1yah3nU9XzB9jQrIFAf8l0yuw
         PJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853685; x=1725458485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty49zj19B9dflfxgkTafzOnR24yLpnVjka8nQSk8PJM=;
        b=t4ekZRDDdt9Ldgn/ns6HiNDND5+j6FkXsYacGMebWrSmTGpKThJSDKa2BjU3sni7YA
         4CF0v4QfaKTA+2EX9h8EH7vgtFbVrz0kHAbLnKTvU6aVjWi++1qtmbz9oeTQqUraBdht
         sXXzsXJxovqyyjozwx2Pk+L5P6SVEYs8thwNCOJEZe+0fCm5jzEZrjJpwSzjeKFW9fQc
         quzcKTcKIil/Nsdnl4xFiREcVYpSP3jxY/XQCiXlNBz02R7B7WADX351K5aJHi6N6zE3
         K/r5WLL5cUUZMCGF/B85AXnDx5SVp6dgtpz6vzari6Uxr56cPAfFvQyjS+ZX+mRQ3PYz
         z7+A==
X-Forwarded-Encrypted: i=1; AJvYcCWAswsXxaxQQ3U+ksgrAoCjnjY270TUBAqsRCoBrvQxkWW9i0zEHmBG5eZRNrdZ4nqc1VAAWmHMtXdM@vger.kernel.org, AJvYcCWIXWXAumVdmXrDf/mifCgYvQz553Rsz0IEAIM7D1tCqbEMYksFuW2UJo9DsuCIBi4AT6O61f2yUwEOKAWF@vger.kernel.org, AJvYcCWnFYENpXix2z9Fhvmahzq8gWZLP432i65UCRDLDe4uhge6NsrHHZqGNAA/h8PDDGzTZTeYBw11Mqj2@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRzAhmaH1j4TC/0cPHaFMk1fXVXGWQzmOg/iaSDple1fj04KG
	Uz59PIyGUiVXeJhMg0F6OApNIbMEHqQWQTeOBhA+qxkockcZWn3S
X-Google-Smtp-Source: AGHT+IHa7wPRTvnz4K3W76cG3whCxm5EYPjZMMXK9d4KVx/23yQwdaIE4SXzEuVIMm0UDrqfYzoA/A==
X-Received: by 2002:a05:6512:3b13:b0:530:ac6e:ea2f with SMTP id 2adb3069b0e04-5343885f5camr12019358e87.37.1724853681550;
        Wed, 28 Aug 2024 07:01:21 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549ccebsm250466566b.84.2024.08.28.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:01:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 28 Aug 2024 16:01:19 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <20240828140119.GB4934@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-7-vassilisamir@gmail.com>
 <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
 <20240824120222.GG9644@vamoiridPC>
 <ZsxXvGy4GNrZWs-D@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsxXvGy4GNrZWs-D@smile.fi.intel.com>

On Mon, Aug 26, 2024 at 01:23:56PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 24, 2024 at 02:02:22PM +0200, Vasileios Amoiridis wrote:
> > On Fri, Aug 23, 2024 at 11:06:28PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:
> 
> ...
> 
> > > > +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> > > > +				  const struct iio_trigger_ops *trigger_ops,
> > > > +				  int (*int_config)(struct bmp280_data *data),
> > > 
> > > > +				  irqreturn_t (*irq_thread_handler)(int irq, void *p))
> > > 
> > > irq_handler_t
> > 
> > But the function returns an irqreturn_t type, no?
> 
> The type of the last parameter is irq_handler_t, no need to open code it.
> 
> ...
> 
> > > > +	fwnode = dev_fwnode(data->dev);
> > > > +	if (!fwnode)
> > > > +		return -ENODEV;
> > > 
> > > Why do you need this? The below will fail anyway.
> > 
> > Because If I don't make this check then fwnode might be garbage and I will
> > pass garbage to the fwnode_irq_get() function. Or do I miss something?
> 
> Yes, the function validates fwnode before use. So, please drop unneeded (or
> even duplicate) check.
> 
> ...
> 
> > > > +	irq = fwnode_irq_get(fwnode, 0);
> > > > +	if (!irq)
> > > 
> > > Are you sure this is correct check?
> > > 
> > Well, I think yes, because the function return either the Linux IRQ number
> > on success or a negative errno on failure.
> 
> Where is 0 mentioned in this?
> 
> > https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/property.c#L987
> > 
> > > > +		return dev_err_probe(data->dev, -ENODEV,
> > > 
> > > Shadowed error code.
> > 
> > I am not sure I understand what you mean here. You mean that there is no
> > chance that the first one will pass and this one will fail?
> 
> -ENODEV is not what fwnode_irq_get() returns on error.
> 
> > > > +				     "No interrupt found.\n");
> 
> ...
> 
> > > > +	desc = irq_get_irq_data(irq);
> > > > +	if (!desc)
> > > > +		return -EINVAL;
> > > 
> > > When may this fail?
> > 
> > I think that this will fail when Linux were not able to actually
> > register that interrupt.
> 
> Wouldn't fwnode_irq_get() fail already?
> 

Hi Andy,

By looking at it again, I didn't reply correct here. This function
internally calls the irq_to_desc() which basically returns the
irq desctiptor for this irq. This function can return NULL in
case the interrupt is not found in the maple tree (CONFIG_SPARSE_IRQ)
or in case the interrupt number is bigger than the NR_IRQs which
the irq controller can handle (!CONFIG_SPARSE_IRQ).

So in my opinion, it makes sense to keep this check.

Cheers,
Vasilis

https://elixir.bootlin.com/linux/v6.10.6/source/kernel/irq/chip.c#L155

> ...
> 
> > > 	if (ret)
> > > 		dev_err(data->dev, "Could not enable/disable interrupt\n");
> 
> Btw you may use str_enable_disable() here.
> 
> > > 	return ret;
> > > 
> > > ?
> > 
> > All the other if statements follow the style that I typed. If I
> > follow yours, will make it different just for this one, does it
> > make sense?
> 
> When a comment is given, it's assumed that the _full_ patch (or patch series)
> should be revisited for it. Or should I add to every comment something like
> this:
> 
> "Please, check the entire code for the same or similar case and amend
> accordingly."
> 
> ?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

