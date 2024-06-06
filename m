Return-Path: <linux-iio+bounces-5941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D207C8FF5A5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050CA1F26207
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326BF6FE21;
	Thu,  6 Jun 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3zrLNoB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE047F6C;
	Thu,  6 Jun 2024 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704306; cv=none; b=lKj0aXGTD0FRom7nMSktLOdE+et375NnEcruY66m0qwUkO7UTQhXN0P/SZ3vtq3GvLDGYhOKGHsv/FoK+vaRCKyo08DMDwvbOu4oJxz5a8GgHI1zgWjOluUMjb/Gq9GI5UPcmMLwOElH1sSrTp5Ic1uzZKJS7zlw9MY+paicncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704306; c=relaxed/simple;
	bh=RYIOYdHGwbqPl1aaqvHR7fOAw39lfugj1YTm4N4n7DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wl43AdC9SxvmCO43RzEcWRHjDgNFZGKvWu+JZHz5SJLYqp6SAQWK0JzpYlqAwlYyfRfl/HeEMm+P9MWpQOyWoJAFiClNz5oBNoZQAuaOP+W7uxCIKCM5UBh63UJ8YEn2276p8s4S8pp/OxA6UEBlrHNJCMipNxIc6IJ0XNVlfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3zrLNoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D1EC2BD10;
	Thu,  6 Jun 2024 20:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717704305;
	bh=RYIOYdHGwbqPl1aaqvHR7fOAw39lfugj1YTm4N4n7DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3zrLNoB8Ya9ldqboZVhOq23KvOhUDyv+eLj5K3naweuhVxcULtgXIeM3TlDzmIcW
	 GB940PQWjtJulEIIP/yc1H6yljPr0YZ83Feqdb3xgBqO/GRXhwN1NW+xzAsp7BYmj2
	 aRnqb5c2RT0iiIP2aRjoNqRDDBHDXoO3bRBAxuRRIsV+XwSHgqDptSXq8uuA5wb7xX
	 Az9oUK64SJ8bjfoHcchRf1KlcGZ6TVd9kzcqpqqCBMzgrV3L8yitMPMNNlsfm0jmYI
	 V2HVrOvs+7JkH5BcVjYl4VonQGNvzfI8hGaLDcD6qsn9TYCkLL5onBEROETDSOyIlm
	 7aw3dHcYQveXA==
Date: Thu, 6 Jun 2024 21:05:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kauschluss <kauschluss@disroot.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 denis.ciocca@st.com, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 robh+dt@kernel.org
Subject: Re: [PATCH v3] iio: accel: st_accel: add LIS2DS12
Message-ID: <20240606210500.1d49d578@jic23-huawei>
In-Reply-To: <4ed8ba956aee82bf7ccde2af1012bae2@disroot.org>
References: <20240601192914.141906-1-kauschluss@disroot.org>
	<20240601-spouse-hurler-e7b93ac26f86@spud>
	<20240602095459.4a2cdc54@jic23-huawei>
	<4ed8ba956aee82bf7ccde2af1012bae2@disroot.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Jun 2024 10:12:11 +0000
kauschluss <kauschluss@disroot.org> wrote:

> On 2024-06-02 08:54, Jonathan Cameron wrote:
> > On Sat, 1 Jun 2024 20:49:25 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> >> On Sun, Jun 02, 2024 at 12:56:41AM +0530, Kaustabh Chakraborty wrote:  
> >> > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> >> > index fd3749871121..329a4d6fb2ec 100644
> >> > --- a/drivers/iio/accel/st_accel_i2c.c
> >> > +++ b/drivers/iio/accel/st_accel_i2c.c
> >> > @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
> >> >  		.compatible = "st,lis2de12",
> >> >  		.data = LIS2DE12_ACCEL_DEV_NAME,
> >> >  	},
> >> > +	{
> >> > +		.compatible = "st,lis2ds12",
> >> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
> >> > +	},
> >> >  	{
> >> >  		.compatible = "st,lis2hh12",
> >> >  		.data = LIS2HH12_ACCEL_DEV_NAME,  
> >>   
> >> > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> >> > index f72a24f45322..825adab37105 100644
> >> > --- a/drivers/iio/accel/st_accel_spi.c
> >> > +++ b/drivers/iio/accel/st_accel_spi.c
> >> > @@ -64,6 +64,10 @@ static const struct of_device_id st_accel_of_match[] = {
> >> >  		.compatible = "st,lis2dh12-accel",
> >> >  		.data = LIS2DH12_ACCEL_DEV_NAME,
> >> >  	},
> >> > +	{
> >> > +		.compatible = "st,lis2ds12",
> >> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
> >> > +	},
> >> >  	{
> >> >  		.compatible = "st,lis3l02dq",
> >> >  		.data = LIS3L02DQ_ACCEL_DEV_NAME,  
> >> 
> >> Any new compatibles need to be documented in st,st-sensors.yaml  
> > 
> > At the moment the st_sensors core is doing hard matching against whoami values
> > which isn't good.  That should ideally be fixed and the binding for this
> > device should use a fallback compatible if the statement about compatibility
> > is accurate.  
> 
> I apologize for not wording the description accurately. By "compatibility",
> I mean that the sensor settings of LIS2DE12 (such as the gain values) seem
> to be well-suited for LIS2DS12, as per my experimentation. Both devices are
> manufactured by ST and have no correlation regarding compatibility whatsoever.
> In that case, a fallback compatible isn't required, right?

If only the Who Am I value prevents it working if you give the compatible
as lisde12 then even though ST rarely if ever identifies it in datasheets, they are
software compatible.  In that case we should allow for a fallback compatible.
+ fix the driver not to fail on the whoami mismatch.
Note we don't care if they have totally different packages as long as
the driver doesn't need to know that.  If they have different numbers
of interrupts though or power supplies, then they aren't compatible and
we shouldn't provide a fallback.

Roughly speaking you have to compare datahsheet sections for pins (not which
but what) and register maps.

That applies even if the current driver will fail to probe (for now)
> 
> I'll make sure to rewrite the description more accurately in v4.
>  
> > It may just be a case of relaxing the check in st_sensors_verify_id()
> > to printing a warning not an error message and not returning an error code
> > (reserving error returns in that function for bus error etc.  
> 
> I agree, if you want I may send a patch for that after I'm done with this
> one.
Thanks,

Jonathan

> 
> > That doesn't need to be in this patch though.  Just have the fallback
> > stuff in the binding and for now we can rely on matching the more
> > precise compatible.
> > 
> > Jonathan
> > 
> >   
> >> 
> >> Thanks,
> >> Conor.
> >>   


