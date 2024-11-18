Return-Path: <linux-iio+bounces-12375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12029D0FCD
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 12:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8621F2821E9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A378198A39;
	Mon, 18 Nov 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJg7+kp6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D13BBF2;
	Mon, 18 Nov 2024 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929664; cv=none; b=BuaIPXvmaKbo8oqZ/6jBbOioJSuHGxhXNnpkhCoggQO1k8S8lIcfs/WU9HrGKbD5ZChGSAKEvDyBXfPln27sWlTZo9mygeJ7ZkSLh/mLVPGdCBg7WVcQx1ATf6o2Uc3uh/zmKR9O9SuJsGe7pZ2nSTAkoHwvr1hdekbfamSYd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929664; c=relaxed/simple;
	bh=RdC1LlnbhGN7esaUqZ1ZsXKq0EcLZt7thcJkXxrpVjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt13ou9yUqrtL542+y7aybQINYDvOi2MFB8hQ3BqUUrwLa7+0KiGryxSGAQqX33Zq9NkZD1t0kQrwGQp55mUiZxi+610jDAI4hMSvADVeAbuY3k79FSLg7FVLkNQ6jy6R/A9M/votyWiH+VEUJ70o2vsk3194XT6x9YB11cPt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJg7+kp6; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a70315d38dso5421175ab.0;
        Mon, 18 Nov 2024 03:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731929662; x=1732534462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBt+VM3XUf38/2UTMI3czA73IaeQUs1IwdyKg6N5eu4=;
        b=iJg7+kp6HaQtOXeYJlCN+Q+JioNABTGa/VALHOlfDwRtTAUDyt5GD9Vcc9+g6DfBsb
         wJKJiy0i0+jSCeWyMDxnCUW3oJOewvz02nlGjyA0CYAQINjGETAH9E/uK7atuK0DvX29
         hwYaJ3ub6FRc0acVJCybOQMKJr6ay7ddMRYs4En6dimdUmflylPodM8ubn+MQt9qNtsW
         VNqhZObDcS6ogYmYW+d3QIzp5dhSSGushSKHsDvf00FPWIKW206cZdv01MATOamWITY8
         c+6u5V1Cb0k5YMrGHJb5IMqk8LJb/S2IC0GaN0LcB64gttTrkmpluOMRRkxK8msoDHyV
         gWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929662; x=1732534462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBt+VM3XUf38/2UTMI3czA73IaeQUs1IwdyKg6N5eu4=;
        b=w9chGeiNGENjR8SIQmfcKQHYWXdtrGfGGKSNa/wXQCgahMeTQvgeE74DDDiIs9bAnw
         Ny5JLMKTF4DeQQ4zec4XdFfFUJcpHrO3QKbyLtu3mseNEPyJC15DdMnLawRIu610NaDB
         XFIoslwy5behqlsn4sUcwhpz2wf+YmfIzu/MGHkLSSIr33zr3smpt8YYBFcl2JnzjNws
         TAjoxf5AmIZjNCvrL8jeI3Vy8xKUlnSZ1s/xvlVk9oS4B+xWk0Rj4FMrwNUQ6u8WbWGT
         ch26/zyBacb7APE5qLdNmlQzDypbtbW+xXYfD9HXVx/evXKF0btSoilDv6npZdnSNRSD
         enqA==
X-Forwarded-Encrypted: i=1; AJvYcCUhkFyH0lh97TChTHpc9dq6/maV7t9nKljuuMLOA2T0qcJX5Im3kM+gc+q5puULjoo6BFX9ln8IcA81@vger.kernel.org, AJvYcCUw8Nl79HFZy07jmmNTGFx0AqbR2r6E7tFL62y3N126QWDomjx8o5mBCG8YfFlbDqZ7wCE1jAa7OQ6mC0CD@vger.kernel.org, AJvYcCVLjDBDzdtgaNKT/vAlUckON/IKG0tIZ6YqW9BXWop95y7pb0W+OsfudLf4xIjwU6X5YuKyFNosgx7/@vger.kernel.org
X-Gm-Message-State: AOJu0YxTT3ehk5BCRuTscuPeRgasjNRJI41PwDPn2prjA6XMY6erziY0
	M+uSQv6f21zPtWL0nE88SUfsklNL/qClLeyzovar0McmLQM5cJGAZolB/wuB
X-Google-Smtp-Source: AGHT+IGPLb61oLo5RtwBoYSmDN9uJM1DNkfCadfAXWDi+2vMIybRV5hFOvHZIMgDw69aXWcJH2qtYA==
X-Received: by 2002:a92:c248:0:b0:3a7:6c5c:9aa4 with SMTP id e9e14a558f8ab-3a76c5c9b34mr18835875ab.12.1731929661993;
        Mon, 18 Nov 2024 03:34:21 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c616a7sm5779706a12.39.2024.11.18.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:34:21 -0800 (PST)
Date: Mon, 18 Nov 2024 08:34:42 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: ad4000: Use device specific timing for SPI
 transfers
Message-ID: <ZzsmUqqyAll9BBCv@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <81370b043de208795738e5679c33de37439c0a2e.1731626099.git.marcelo.schmitt@analog.com>
 <7e302a49-db5a-444d-aae1-3c80ab75b471@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e302a49-db5a-444d-aae1-3c80ab75b471@baylibre.com>

On 11/15, David Lechner wrote:
> On 11/14/24 5:51 PM, Marcelo Schmitt wrote:
> > The SPI transfers for AD4020, AD4021, and AD4022 have slightly different
> > timing specifications. Use device specific timing constraints to set SPI
> > transfer parameters.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  drivers/iio/adc/ad4000.c | 50 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 41 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > index 21731c4d31ee..68ac77494263 100644
> > --- a/drivers/iio/adc/ad4000.c
> > +++ b/drivers/iio/adc/ad4000.c
> > @@ -35,10 +35,6 @@
> >  
> >  #define AD4000_SCALE_OPTIONS		2
> >  
> > -#define AD4000_TQUIET1_NS		190
> > -#define AD4000_TQUIET2_NS		60
> > -#define AD4000_TCONV_NS			320
> 
> We are removing 3 but only adding 2 in the struct below?
> 
> If one of these was unused, best to mention it in the commit message.

One of them was unused (AD4000_TQUIET1_NS IRCC).
Sure, will add a comment about it in the commit body.

> 
> > -
> >  #define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
> >  {										\
> >  	.type = IIO_VOLTAGE,							\
> > @@ -122,10 +118,30 @@ static const int ad4000_gains[] = {
> >  	454, 909, 1000, 1900,
> >  };
> >  
> > +struct ad4000_time_spec {
> > +	int t_conv_ns;
> > +	int t_quiet2_ns;
> > +};
> > +
> > +/*
> > + * Same timing specifications for all of AD4000, AD4001, ..., AD4008, AD4010,
> > + * ADAQ4001, and ADAQ4003.
> > + */
> > +static const struct ad4000_time_spec ad4000_t_spec = {
> > +	.t_conv_ns = 320,
> > +	.t_quiet2_ns = 60,
> > +};
> > +
> > +static const struct ad4000_time_spec ad4020_t_spec = {
> > +	.t_conv_ns = 350,
> > +	.t_quiet2_ns = 60,
> > +};
> 
> t_quiet2_ns is the same in both cases, so do we actually need to
> add it here instead of using a common macro? Or if it is for future
> differences, mention that in the commit message.

Okay, will add a macro for setting ad4000_time_spec. My plan is to also add a
t_quiet1_ns filed which will be needed for offloading support.
t_quiet1_ns will also differ between AD4000 and AD4020.

