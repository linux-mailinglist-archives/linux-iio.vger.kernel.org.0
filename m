Return-Path: <linux-iio+bounces-20981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AAAEA851
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084FB4A7A78
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3D2EF9C5;
	Thu, 26 Jun 2025 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="NiOslNo7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0F15A864;
	Thu, 26 Jun 2025 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970547; cv=none; b=ex8DfjjMvxsse3hrqltyidY1Cpc5vqT/lXB1IIj8yTeO/3oojSPY1cb4Frng42SkRfzsF3RxznhL37Cu7KpcinkiHoqMRVbyo84wMB8FHiDjJwZxKseyl1ZzvYoXyXBBWY67VnPlZSXnGKzD/R4zNjEiC8vX+RfE/tI8TcyOUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970547; c=relaxed/simple;
	bh=RLEx2xKefeSdsWRjJHhqob9J1C2xu4UA7PKJZEw1L2A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fbti4UZYKNc4Vm3N4nUGPdQXn9FLnfBTwEgUNZlKjckgTt6uOJilEoEUpBYNAHTL0Fwa8yFwEdB8gpi1lMrAbL9je7DiE5WCu+QoUQ9jHeQBGuh7jzdNC59ULNgGRE05AUmgiThDY3owgK2HHaESnJoa9ZNtmI8tZWujeox5VWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=NiOslNo7; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ooYxFu0ZWuS1WjbcYF5fd0/upAuSNVgkBMhhaiyiwhk=;
  b=NiOslNo77VErKGfM1NgunJAVuq4Iq2LJEI3iSjlGwBpGVVssdUnZplDa
   mhDK4TC/3HT2bpvb3G/vixPTSHjPTpQrD30uQIzqJk/bLrb4atAupEwz7
   RVFNAp2MrJD9kC70QdcIYbVarb+J+BpI0dVFxbr2oi+pSmmH+IVuQnofD
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.16,268,1744063200"; 
   d="scan'208";a="120085974"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 22:41:12 +0200
Date: Thu, 26 Jun 2025 22:41:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
    jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>, 
    Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support
In-Reply-To: <dcf86acc-567e-48e3-ad15-fd9522b46180@sabinyo.mountain>
Message-ID: <alpine.DEB.2.22.394.2506262240440.3473@hadrien>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com> <20250623-losd-3-inv-icm42600-add-wom-support-v5-2-4b3b33e028fe@tdk.com> <CAMknhBHaSBF-a9nLZ0ZxB2-9HzYkPMBqUr4Aa4TthNnJMwtFgg@mail.gmail.com> <20250626195323.6336820c@jic23-huawei>
 <dcf86acc-567e-48e3-ad15-fd9522b46180@sabinyo.mountain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 26 Jun 2025, Dan Carpenter wrote:

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

How about a goto if making another function is not practical?

julia

>
> regards,
> dan carpenter
>
>

