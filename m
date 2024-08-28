Return-Path: <linux-iio+bounces-8846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E52962F81
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F142829FD
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4141A7AF3;
	Wed, 28 Aug 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+rL5mRf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5E149C53;
	Wed, 28 Aug 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868820; cv=none; b=k1xSD5XoeFupDm5JHGzxwGdIds6octts4zyPcBK8F8ntwjQdGxA6tnDyh4OgGXZBMTJ2xRC4npHezii7EoT4fykH5fRW7KWDuyNJOrJ8grbb33EJxhx0GmC2nQ51ROaorKID73c9NZ05Yz2BNfqbXbr3GVdHWatG+sV36ODAYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868820; c=relaxed/simple;
	bh=84N7GUoSTh5Zag2sqMAuTBp8+3s6bgNeovLHo60vvIY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecmsb/G4eD8xEeM9a+t6BxY4SaSMt9uLZk/yT9ClolQj+JNtGzgkScyW8Rzv3kGY3WfLHdnxHG9KhmOX9vgqPSV2XTJq9lBI7FMi3pI1xHdeQrjd1Vdjg4pRlg03TGeaKcXmkaOs+MLnIUD8D+TzfhpodIHaF8BxOeT3y1AFSzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+rL5mRf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a867a564911so834192166b.2;
        Wed, 28 Aug 2024 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868817; x=1725473617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUjb4jH9ETimZE0pCg8LtC0TnBmwTnywA8+wN1lvhOQ=;
        b=G+rL5mRffRIOqs+VztLcs1N0ds+OWdlhP5fEV0oDOul9UrLltaGpmdgooTysfGtmqd
         lWH2zyGUd5Akb3eCr0w1qNfTEfvEF5i4rp52yMqSElAwwQhXTv3vw2HvkBEBpN+YRk2r
         gbrZ9IrmkuMh4BDSY3qvKxEKAmAfv3m+PUkMykXbzRdok+Fm++s3W0MpFpzC+eFL0bCK
         LBEVk1kYex5kxGE45SLCKiqAR1K83yGWCFJvdban+uj9ljzdJwTt99ZOfdwZNWlHOXxN
         +WwBF1Q4XutozYjn1tVFoVsJZCdFoLbnBTJYUquihkH5KeOv4nnoDUFGBz5wzbQ5PYVZ
         JWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868817; x=1725473617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUjb4jH9ETimZE0pCg8LtC0TnBmwTnywA8+wN1lvhOQ=;
        b=pqv5T8HgiOF1jhkrv/Q5QUtXIgBqa6GJCddcZM+pe6mt2sPo+2rwzMhdGJ61A7Mdqc
         oCBdR2oCske08SzXwgA+ZMng9H4uUsq/iuQlvp1+kv8DZCJ3jKZMQvrcwT7pZQCOqft0
         c/oWaQI6/Jkrz4HbdX9kIZYyTxdjVNKLU+QVpYbclDrtx+AZBIjL+v+lxqq0/i6AKvYb
         FmGmWeszS6r58jVR2QnfgmWBC08Z24GcZZqY19eBPOIqFwjSKNw/y+L5dx9QC2bdO6fS
         CK4N2ykTd7SqoTvkj2AyCc+FCWCwAvKFZrjk2YLiS0qk37MaLTAuGcgZcr+B0p7SP43u
         l+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK4xYXRuZi3nWbjYnN+0IU/8YO2swyn549ER5pDK8Buy8EUpWJiZtAnbvDdTLUUacB7Ps0yyZ+UbG1@vger.kernel.org, AJvYcCWJTq9F9ZxmVx7AbmoQg+mUpsNASXjVsQE6/FobJRRBbT3u+tLKJwsIsqoRo9ys6xL24DHDcOZXLroCx5dl@vger.kernel.org, AJvYcCXqcD94mdUCsPllVvEFE+b7huRCMG/DtpcIik+E8iGtjmiczaz/lMFLwCDTdrWUmaURQfVOe2xX0TcW@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRKbpPXB5dAFCO7IG6jVeVSPV122/3CiMO+33dLSAhjXsNLFW
	TwjXXSZWXbqPb63fRiiChdhITP+MXJMXSbv6bFgFaAxLSt99TRBb
X-Google-Smtp-Source: AGHT+IGxGDh1vAJKcxejQ6uYAxsltvH9+XNhCUm0PLl6GKCm4I/7JUGkH9zDi4vDHQMcDBRI2Ydyxg==
X-Received: by 2002:a17:907:72c8:b0:a86:8832:2fb7 with SMTP id a640c23a62f3a-a897f83b316mr19870266b.20.1724868815960;
        Wed, 28 Aug 2024 11:13:35 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b50dbsm275221966b.93.2024.08.28.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:13:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 28 Aug 2024 20:13:33 +0200
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
Message-ID: <20240828181333.GA80267@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-7-vassilisamir@gmail.com>
 <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
 <20240824120222.GG9644@vamoiridPC>
 <ZsxXvGy4GNrZWs-D@smile.fi.intel.com>
 <20240828140119.GB4934@vamoiridPC>
 <Zs8xhMaFahBVanwd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8xhMaFahBVanwd@smile.fi.intel.com>

On Wed, Aug 28, 2024 at 05:17:40PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 04:01:19PM +0200, Vasileios Amoiridis wrote:
> > On Mon, Aug 26, 2024 at 01:23:56PM +0300, Andy Shevchenko wrote:
> > > On Sat, Aug 24, 2024 at 02:02:22PM +0200, Vasileios Amoiridis wrote:
> > > > On Fri, Aug 23, 2024 at 11:06:28PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:
> 
> ...
> 
> > > > > > +	irq = fwnode_irq_get(fwnode, 0);
> > > > > > +	if (!irq)
> > > > > 
> > > > > Are you sure this is correct check?
> > > > > 
> > > > Well, I think yes, because the function return either the Linux IRQ number
> > > > on success or a negative errno on failure.
> > > 
> > > Where is 0 mentioned in this?
> > > 
> > > > https://elixir.bootlin.com/linux/v6.10.6/source/drivers/base/property.c#L987
> > > > 
> > > > > > +		return dev_err_probe(data->dev, -ENODEV,
> > > > > 
> > > > > Shadowed error code.
> > > > 
> > > > I am not sure I understand what you mean here. You mean that there is no
> > > > chance that the first one will pass and this one will fail?
> > > 
> > > -ENODEV is not what fwnode_irq_get() returns on error.
> > > 
> > > > > > +				     "No interrupt found.\n");
> 
> ...
> 
> > > > > > +	desc = irq_get_irq_data(irq);
> > > > > > +	if (!desc)
> > > > > > +		return -EINVAL;
> > > > > 
> > > > > When may this fail?
> > > > 
> > > > I think that this will fail when Linux were not able to actually
> > > > register that interrupt.
> > > 
> > > Wouldn't fwnode_irq_get() fail already?
> > 
> > By looking at it again, I didn't reply correct here. This function
> > internally calls the irq_to_desc() which basically returns the
> > irq desctiptor for this irq. This function can return NULL in
> > case the interrupt is not found in the maple tree (CONFIG_SPARSE_IRQ)
> > or in case the interrupt number is bigger than the NR_IRQs which
> > the irq controller can handle (!CONFIG_SPARSE_IRQ).
> > 
> > So in my opinion, it makes sense to keep this check.
> 
> So, you mean that if fwnode_irq_get() succeeded there is a chance that returned
> Linux IRQ number is invalid?! If it's so, it's something new to me. I would like
> to see the details, please!
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Hi Andy,

I did some more digging, and from my understanding, fwnode_irq_get()
directly returns the Linux IRQ which means that there should already
exist the irq_desc structure that is returned by the irq_to_desc().

So as you already said, I cannot see how this function can fail, if
the fwnode_irq_get() has succeeded. Thanks for asking the right
questions, I am getting to know things better.

Cheers,
Vasilis

