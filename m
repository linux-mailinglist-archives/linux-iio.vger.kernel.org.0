Return-Path: <linux-iio+bounces-5592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC378D7455
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F8B1F213DE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43E249E5;
	Sun,  2 Jun 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCUpA9X7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1E13ACC;
	Sun,  2 Jun 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318513; cv=none; b=T60RD+SNhNgICXzjY/riJdSxpmcsAWrxQ/OY9YZ6YuVFCn5VTZPJ9PAfGP48dBqbvayMH3sJJv26HhTplhD4MvZRPS0n4E+vIUaIfwag7MVv4567/o8ajB2aqnw3rScULy7KhRrCKIrF3fA7WGzmoAVLVF+wHB93l5M1lue7S0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318513; c=relaxed/simple;
	bh=RqzsHG0rU8Uh3GsSJYAkC0HjqaHaoNnnOAz3uLL/yME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfqDEqvXOVpKyFMBZT+OW61nSpypdmR0ZCzzQtX6+mPLEnlnKn5YJ3UONwKRWdwlD0fuMsM3JDu1w6FzuwDwp2EH3CAbOCNk/g+bWJ1n73tFsIkWkU21m6//+BsPNt4UCzvFnWkLk8IfuTIE8GH4Yj2w9dRyT20L5jbtNtxUohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCUpA9X7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F071C2BBFC;
	Sun,  2 Jun 2024 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717318512;
	bh=RqzsHG0rU8Uh3GsSJYAkC0HjqaHaoNnnOAz3uLL/yME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LCUpA9X7dR7BVE7o0xZ7fy1tNM48aPoTttWr0RrxZgTGN/L3U+qduBPZbsOd5s1f3
	 VS5KwrbX8mrJoLKs/23QrdESqzbpVwCCdrpwp7AyBUwZhh/z1Fwpd8Vigg2wSbYjpk
	 KtyTIrnNKbAKB9cC/kITWBG/JylJUCe4iR2SO/Z0AhGsuHP4k72jUInnx7+PC8OogB
	 pHDqjmGlYViz6wzyQoA8aRz18bvLBp1CX+fh9rL4I+LUjksh6PqZekwnrUy+uBSkRS
	 Nbyf6y3N+s8PnncsSaK8ZBaCAUCnTq4XPeZKLihcmknBYvUgmXVHujPnVRaSNWy/ka
	 8LRDmW87I6DKQ==
Date: Sun, 2 Jun 2024 09:54:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 linux-iio@vger.kernel.org, denis.ciocca@st.com, devicetree@vger.kernel.org,
 linus.walleij@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v3] iio: accel: st_accel: add LIS2DS12
Message-ID: <20240602095459.4a2cdc54@jic23-huawei>
In-Reply-To: <20240601-spouse-hurler-e7b93ac26f86@spud>
References: <20240601192914.141906-1-kauschluss@disroot.org>
	<20240601-spouse-hurler-e7b93ac26f86@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 20:49:25 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, Jun 02, 2024 at 12:56:41AM +0530, Kaustabh Chakraborty wrote:
> > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> > index fd3749871121..329a4d6fb2ec 100644
> > --- a/drivers/iio/accel/st_accel_i2c.c
> > +++ b/drivers/iio/accel/st_accel_i2c.c
> > @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
> >  		.compatible = "st,lis2de12",
> >  		.data = LIS2DE12_ACCEL_DEV_NAME,
> >  	},
> > +	{
> > +		.compatible = "st,lis2ds12",
> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
> > +	},
> >  	{
> >  		.compatible = "st,lis2hh12",
> >  		.data = LIS2HH12_ACCEL_DEV_NAME,  
> 
> > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> > index f72a24f45322..825adab37105 100644
> > --- a/drivers/iio/accel/st_accel_spi.c
> > +++ b/drivers/iio/accel/st_accel_spi.c
> > @@ -64,6 +64,10 @@ static const struct of_device_id st_accel_of_match[] = {
> >  		.compatible = "st,lis2dh12-accel",
> >  		.data = LIS2DH12_ACCEL_DEV_NAME,
> >  	},
> > +	{
> > +		.compatible = "st,lis2ds12",
> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
> > +	},
> >  	{
> >  		.compatible = "st,lis3l02dq",
> >  		.data = LIS3L02DQ_ACCEL_DEV_NAME,  
> 
> Any new compatibles need to be documented in st,st-sensors.yaml

At the moment the st_sensors core is doing hard matching against whoami values
which isn't good.  That should ideally be fixed and the binding for this
device should use a fallback compatible if the statement about compatibility
is accurate.

It may just be a case of relaxing the check in st_sensors_verify_id()
to printing a warning not an error message and not returning an error code
(reserving error returns in that function for bus error etc.

That doesn't need to be in this patch though.  Just have the fallback
stuff in the binding and for now we can rely on matching the more
precise compatible.

Jonathan


> 
> Thanks,
> Conor.
> 


