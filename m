Return-Path: <linux-iio+bounces-10500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09999B4A8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434001C20FB2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29611547DC;
	Sat, 12 Oct 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4pST8XG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B544146D57;
	Sat, 12 Oct 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734303; cv=none; b=tSQGLMrMYA+7Tu1lDtaxXs3fY7F8fIoeo3sdi3x/wu5tlMpkyI0RxpthjQTdORYOVhlekqQy/FcLpNDRzqWUkDn/vu9VObNhA5/02tQSNgSHyf/4KZN+VTBtJeZv4qQzZVTkIXE9uXGCFpFLbe0XUV2/XaL+OxYyl7wop1lE/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734303; c=relaxed/simple;
	bh=1CDwAkKs/RY56wXGUn+S96ubWSYUFUchIsJqlbvnSSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHq8T2nsMp7ojyaEFMopcUSxzkyTNozr/kGXNPERa9Z+TXaDTSvoEId8W8RUlbiuvLfexzNWuii0GXRhdNmdOBVSX77YDGX8yhGq4329fDXYbzU/oDP4CVPFXk0OdlgUeS7WdqRBWR5Ln8dRDpuwDgGdALLlHlIYSfG96a9w0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4pST8XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D2C4CEC6;
	Sat, 12 Oct 2024 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728734303;
	bh=1CDwAkKs/RY56wXGUn+S96ubWSYUFUchIsJqlbvnSSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q4pST8XGBYgG02d6sPp4PMBw2sGhIoykrHd9qH043lcnZsMtWzUyyfBmZIHgPksKt
	 1/N6w32/elcB1nYt2JfgwJoAwsfpegL9Y82BwFlBrgr0z+SM/vvtM3Px7PC1qV0JvO
	 WsjLTlaXBFBJYCE2BczsWlSXYokF7NKEIQYG5LcDp6AKD64AwGPOcE0CNHWoEujYX1
	 PXFS+PRGbQYJQ2UoYIIKaEDKQXni8c5J2buWI3REBar2EJbKCX7B5UrXezqK+4Wb6l
	 /QrGU2BkwnWnVR93ZBTq9NTAYU5bBNtIy3MNUx642FcnDh0bapNhilK6T6iBybAsvZ
	 VbDoSrgTDU1nA==
Date: Sat, 12 Oct 2024 12:58:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/13] iio: chemical: bme680: add power management
Message-ID: <20241012125813.1a5ed9ff@jic23-huawei>
In-Reply-To: <Zwl2SEmDqc-PTtqp@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-9-vassilisamir@gmail.com>
	<Zwj5jBm-_9_FX6ms@smile.fi.intel.com>
	<Zwl2SEmDqc-PTtqp@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 21:02:32 +0200
Vasileios Aoiridis <vassilisamir@gmail.com> wrote:

> On Fri, Oct 11, 2024 at 01:10:20PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 10, 2024 at 11:00:25PM +0200, vamoirid wrote:  
> > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > 
> > > Add runtime power management to the device. To facilitate this, add also
> > > a struct dev * inside the bme680_data structure to have the device
> > > accesible from the data structure.  
> > 
> > ...
> >   
> > > --- a/drivers/iio/chemical/bme680.h
> > > +++ b/drivers/iio/chemical/bme680.h
> > > @@ -75,6 +75,7 @@
> > >  #define BME680_CALIB_RANGE_3_LEN               5
> > >  
> > >  extern const struct regmap_config bme680_regmap_config;
> > > +extern const struct dev_pm_ops bmp280_dev_pm_ops;  
> > 
> > Is pm.h being included already in this header? Otherwise you need to add it.
> >  
> 
> No it is not, and indeed I need to add it. Probably because it was
> included by some other file I didn't get an error from gcc?
> 
> > ...
> >   
> > >  	struct regmap *regmap;
> > >  	struct bme680_calib bme680;
> > >  	struct mutex lock; /* Protect multiple serial R/W ops to device. */
> > > +	struct device *dev;  
> > 
> > Is it the same that you may get wia regmap_get_device()?
> >   
> 
> Yes it is the same. Maybe I can try and see if I can use the following
> 
> 	regmap_get_device(data->regmap)
> 
> in the places where the pm functions are used in order to not declare a
> new value inside the struct bme680_data. But in general, is this approach
> prefered?

slightly by me.  I tend not to poke on that if people have chosen a local
variable, but it is a little neater.

This patch might get caught up in an effort to simplify the
autosuspend handling but if it is we'll deal with that whilst merging.
There 'should' be a clean path to transition from this style to the proposed
new one where a simple pm_runtime_put() without the mark_last_busy stuff
is enough for autosuspend cases.

Jonathan

