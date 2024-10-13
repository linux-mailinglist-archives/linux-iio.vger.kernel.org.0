Return-Path: <linux-iio+bounces-10535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BEC99B9EA
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 941DFB21057
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E5146D7E;
	Sun, 13 Oct 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3ojjKLz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF91465BE;
	Sun, 13 Oct 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728832505; cv=none; b=OreFirI4BXZXvm86dgBXXUdz4877ongKFBE8VGQnADJU4YssWWWPqPLbohELfVZC2PxCfgD3ObtKbMIepU9tVn+kITixdJoZAVBkx5KZVrJJYF89m6RCb0P7E8L0AmbJX2NCCk1i0hwo2W4gZysIbXvVQn/bH1qb1/wIOQuHM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728832505; c=relaxed/simple;
	bh=vkJo+KKJH8jayrJLeIZKAJjSZEELKwa+qrp4QZQxzcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qg7HsNdRvPO75bK1XDpOvQxt3eZSWF9gMXOLV8XYwaojRHvuciuyD9tRu/h1UTmp4KxVMzqETWL/7CepmNO+JgJZoCyzLwrPFOSvboISeWHGFLSLzFONVarGI5N+WzPrhRls3tmxklZAijEkYijwVQvYRNoVFTtC31EYp4baNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3ojjKLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9834CC4CEC5;
	Sun, 13 Oct 2024 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728832504;
	bh=vkJo+KKJH8jayrJLeIZKAJjSZEELKwa+qrp4QZQxzcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3ojjKLzsHxtMwwEBGCanAIRTnPaFgpECZ0TSkU/8vSuVJITEKqJrBsDK7XcDA0CK
	 kxfa6eRmNiIthtrhPJSro2mN1MgYuUORs5hDfYiQxblJH7lWFXo2rry+IAJ4C/WXtv
	 B5mHu0KH+tzTpBtwrtNpEBVj/EeIk6G8rZk/zFpwEHcINeJ0YeibvGY0XaciE5QUOt
	 VywFlN0R1iUlTJpanTRT40288dC5zRG18CpbeNy/p+5HGvLP+HgBWmdWX+/o+iYUT5
	 K5F3zkvMlwR8tBn89h/b2sb+FxeWAsyL9qIOqdH3jd2v90ADJXlF8lzQZ0B7OBvLvl
	 9uD+Sae7BrpKw==
Date: Sun, 13 Oct 2024 16:14:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 1/3] iio: imu: Add i2c driver for bmi260 imu
Message-ID: <20241013161457.506c2296@jic23-huawei>
In-Reply-To: <874j5grafd.fsf@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-2-justin@justinweiss.com>
	<20241012120830.338aca19@jic23-huawei>
	<874j5grafd.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +static const struct acpi_device_id bmi270_acpi_match[] = {
> >> +	{ "BOSC0260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> >> +	{ "BMI0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> >> +	{ "BOSC0160", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> >> +	{ "BMI0160",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },  
> >
> > Sigh.  That's not a valid ACPI ID or PNP ID.
> > (Well technically it is, but it belongs to the Benson Instrument Company
> > not Bosch)
> >
> > Which of these have been seen in the wild?
> > For any that are not of the BOSC0160 type form add a comment giving
> > a device on which they are in use.  
> 
> I know of the BMI0160 (this seems to be the most common way the BMI260
> is identified on handheld PCs), and the 10EC5280 has been seen in the
> wild, as described here:
> https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/
> 
> I have not personally seen any devices using BMI0260, but I'll add
> comments to the BMI0160 and 10EC5280 entries with some examples of
> devices that use those IDs.

Drop any we don't have evidence are out there.

Do we have any confirmation from Bosch (or products in the wild) for
the structurally correct BOSC0160 etc?  Those would normally have
to be tracked by Bosch as allocated for this purpose.

> 
> >> +	{ "10EC5280", (kernel_ulong_t)&bmi270_chip_info[BMI260] },  
> >
> > What's this one?  There is no such vendor ID.
> >  
>
...

> >>  
> >>  static const struct of_device_id bmi270_of_match[] = {
> >> -	{ .compatible = "bosch,bmi270" },
> >> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },  
> >
> > If the bmi260 supports SPI, should be added here as well. (I've no idea if it does!)
> >
> > Or is this because you can't test it?  
> 
> Yeah, it was because I can't test it, the BMI260 does support SPI. I can
> add entries here, though.
> 
> Should the ACPI match entries from I2C also go here? All of the devices
> with mismatched IDs seem to use I2C so there might not be as much of a
> problem here.
We want the incorrect formatted ones to be as hard to use as possible to discourage
them going into new products.  Can't do anything to solve the i2c cases
but definitely don't want to allow them for SPI as well if no evidence
of products where it yet matters.

If we have confirmation from Bosch of the BOSC forms, then those I would like
in the SPI drivers as well (to point to the correct option for anyone using
this in future!)

Jonathan
 
> 
> >>  	{ }
> >>  };
> >>    
> 
> Thanks again,
> Justin


