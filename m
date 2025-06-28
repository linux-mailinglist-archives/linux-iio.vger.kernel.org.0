Return-Path: <linux-iio+bounces-21045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE772AEC85A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBED6E01D4
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D321A445;
	Sat, 28 Jun 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4g9cMaG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2D1E502;
	Sat, 28 Jun 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751125260; cv=none; b=BAH5XUv6vDviXU7iOuPxkz4O76ybTPAeTGad6z4KgE8a0iPKCVSSs6jx4WtvxklvVs645KV3NioW7wUiD2/IU946xuxrip6YdfqR86e6TrhQZxKc0wK9XAadBhgDAqjs96c1npEod2ikKRC26uUSB1N2y5P5+DYktmU4pyz+Feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751125260; c=relaxed/simple;
	bh=1lcgyLVwTfxuqxdF5MYvsRIHyKto1JLmJ3TNgqZ2JRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em+JvzSAAl3ExNtjb+bM6Z5zx9e4sbjAR+Io9mFlJgI5+cX0mY4tlngGsWpUGtA8HrjSJX/yHL+2AD6htBBcOp96cwiJf1X4KDxGtDo9769D6MV5xnvE/yxrB57qBRG6D238jdstTPp1E/InwkRXe9hHzrX9PaxPcGiSEhMOvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4g9cMaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3641C4CEEA;
	Sat, 28 Jun 2025 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751125260;
	bh=1lcgyLVwTfxuqxdF5MYvsRIHyKto1JLmJ3TNgqZ2JRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S4g9cMaGsQbtEqrrcKmHRUmRKvwY4E0fiL6jP6ZFlGfRN2HJUNxgeOyEH8E4wXLDq
	 HixDQu89vfQPR8Y1aw1Vg3twhs7Yj2CKA8C3S7KicIS3CktKlp3D/nZQhjUUqjucD2
	 /fUt69WUJJYw/Bk6JtXKkQCdlXeXEMsaXBt7JXZUf0ItYeWKb/xRrovj7SGsWPjFJf
	 QzBKomAyX+ZTNG0SvEqKGr3jkPEXlSfV20z25zjTC9//vluwKHt2OTvDR94pVkf7sW
	 /AYjgbXx4nprKZLhgpqZqZAYo2uBRN2KQkOuCxCF+gM0P1ZaUDMbnaNoD765zXypCT
	 2dj0ekalL5kzA==
Date: Sat, 28 Jun 2025 16:40:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, jean-baptiste.maneyrol@tdk.com,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall
 <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250628164054.54ae2e7a@jic23-huawei>
In-Reply-To: <dcf86acc-567e-48e3-ad15-fd9522b46180@sabinyo.mountain>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
	<20250623-losd-3-inv-icm42600-add-wom-support-v5-2-4b3b33e028fe@tdk.com>
	<CAMknhBHaSBF-a9nLZ0ZxB2-9HzYkPMBqUr4Aa4TthNnJMwtFgg@mail.gmail.com>
	<20250626195323.6336820c@jic23-huawei>
	<dcf86acc-567e-48e3-ad15-fd9522b46180@sabinyo.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 14:48:10 -0500
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Thu, Jun 26, 2025 at 07:53:23PM +0100, Jonathan Cameron wrote:
> > > > +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
> > > > +{
> > > > +       struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> > > > +       struct device *pdev = regmap_get_device(st->map);
> > > > +       struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> > > > +       unsigned int sleep_ms = 0;
> > > > +       int ret;
> > > > +
> > > > +       scoped_guard(mutex, &st->lock) {
> > > > +               /*
> > > > +                * Consider that turning off WoM is always working to avoid
> > > > +                * blocking the chip in on mode and prevent going back to sleep.
> > > > +                * If there is an error, the chip will anyway go back to sleep
> > > > +                * and the feature will not work anymore.
> > > > +                */
> > > > +               st->apex.wom.enable = false;
> > > > +               st->apex.on--;
> > > > +               ret = inv_icm42600_disable_wom(st);
> > > > +               if (ret)
> > > > +                       break;    
> > > 
> > > The fact that scoped_guard() uses a for loop is an implementation
> > > detail so using break here makes this look like improper C code. I
> > > think this would be better to split out the protected section to a
> > > separate function and just use the regular guard() macro.  
> > 
> > Good catch.  This feels like something we should have some static analysis
> > around as we definitely don't want code assuming that implementation.
> > 
> > +CC Dan / Julia to see if they agree.
> >   
> 
> I feel like the scoped_guard() macro is so complicated because they
> wanted break statements to work as expected...  (As opposed to how I write
> half my loop macros using nested for loops so that when I break it only
> breaks from the inner loop and corrupts memory).

Was a while back but don't remember that coming up as a reason.
I thought the for loop construct was just a way to define the scope in
a place where the following or preceding code couldn't influence what was
instantiated.

Anyhow I think breaks in a scoped_guard() is a horrible pattern based on hidden
implementation details so I'm keen to avoid it at least in IIO. 
Maybe this will become common enough that I'll revisit that view in a year
or two. Factoring out the code as a function seems the right answer in this
case.

Never mind on checking for it generally if we think it might be something
that was intended as a feature not a bug.

Thanks

Jonathan

> 
> regards,
> dan carpenter
> 


