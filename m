Return-Path: <linux-iio+bounces-20979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394BCAEA5D8
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D87416535C
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A52EE995;
	Thu, 26 Jun 2025 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PowYWOax"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A525A2CF;
	Thu, 26 Jun 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964012; cv=none; b=GFm1fUucIdZNWJklys/qPUuhLbY6GNsIgQFsbbfIsnLxpjLu0rk7tg2zBr8f95w89S2SOduyXFAHUDChwJucGawH9bAbfFwW/EvtL2vKEy7hcSKxG1HuoqyYxRKFxPUcwClTaxdCMwAF5KrA+zRIhm4M4vQ1I2V1l6+gKM4NcZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964012; c=relaxed/simple;
	bh=ADBolS75xLKE/jxa6NphB3eCQz07BwDoYr9Xbgh4oy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdmkQZAyYLRW47WFZQeQhz5gbz30+kgqMwximdeD0xzU7fssS0Qnigxih/2ALz4oZK7P/6f43tnQQ7FQE6y6u5zuU9V1gau023JfUnKSISvhyKfBsJ0qQoG0BYXsQrzDPAT24p9wr3X8FzN0NAbTmhfCaUyBld3lk3bQKOwL5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PowYWOax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2075BC4CEEB;
	Thu, 26 Jun 2025 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964011;
	bh=ADBolS75xLKE/jxa6NphB3eCQz07BwDoYr9Xbgh4oy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PowYWOaxTecn9AEe7ZMi8tuimMoweYsy9nAQ+LKATcqOrmd703GdO4uMZf5R6SHHk
	 AlQeOqVLkyRI+T5b5spJsJkvnF2CZ27KuLhcQUuiI78KVPqsFiPttnfZ0l6eOjZ39G
	 UsPHzfLuCNnPL5DKvlLITPGamaFHtU+IrypKDkcj+ewO7BZzdrndsA19gc8c5h5/+4
	 zm7869bUsVGATPCnZFs/JHg2cK7fAismcMDv/AxAlLKPfCQGtP/2Sxspo3UQWkJ+yd
	 Zomau7fqL1dny4xNXJMlDcPQQgk16kCQIHhZOAwnCKB2/YzRzwykNHrKR0f8Mf8ftx
	 yqvM1M3NmKGFA==
Date: Thu, 26 Jun 2025 19:53:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, Julia Lawall
 <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250626195323.6336820c@jic23-huawei>
In-Reply-To: <CAMknhBHaSBF-a9nLZ0ZxB2-9HzYkPMBqUr4Aa4TthNnJMwtFgg@mail.gmail.com>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
	<20250623-losd-3-inv-icm42600-add-wom-support-v5-2-4b3b33e028fe@tdk.com>
	<CAMknhBHaSBF-a9nLZ0ZxB2-9HzYkPMBqUr4Aa4TthNnJMwtFgg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
> > +{
> > +       struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> > +       struct device *pdev = regmap_get_device(st->map);
> > +       struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> > +       unsigned int sleep_ms = 0;
> > +       int ret;
> > +
> > +       scoped_guard(mutex, &st->lock) {
> > +               /*
> > +                * Consider that turning off WoM is always working to avoid
> > +                * blocking the chip in on mode and prevent going back to sleep.
> > +                * If there is an error, the chip will anyway go back to sleep
> > +                * and the feature will not work anymore.
> > +                */
> > +               st->apex.wom.enable = false;
> > +               st->apex.on--;
> > +               ret = inv_icm42600_disable_wom(st);
> > +               if (ret)
> > +                       break;  
> 
> The fact that scoped_guard() uses a for loop is an implementation
> detail so using break here makes this look like improper C code. I
> think this would be better to split out the protected section to a
> separate function and just use the regular guard() macro.

Good catch.  This feels like something we should have some static analysis
around as we definitely don't want code assuming that implementation.

+CC Dan / Julia to see if they agree.

> 
> > +               /* turn off accel sensor if not used */
> > +               if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
> > +                       conf.mode = INV_ICM42600_SENSOR_MODE_OFF;
> > +                       ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
> > +                       if (ret)
> > +                               break;
> > +               }
> > +       }

