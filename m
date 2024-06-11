Return-Path: <linux-iio+bounces-6179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295E904221
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF171F23BC7
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5241843AAE;
	Tue, 11 Jun 2024 17:06:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243093FB83;
	Tue, 11 Jun 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125565; cv=none; b=KpcsE9ESOQ97YzABDuK/Pgm1rEdAeugbhw2+r2+oXe0KtkU3l7a6PVGc4rf5z2dAhMfiMNwqEnPQ3JzJ5m5K+zHUAtLT7b5ntrY39fZDBxEkayHrZw4pVfKYOpszvI7DPmwRAtJgK0LybpahLTqG9IAT6Zq5gkD6TRv70J46xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125565; c=relaxed/simple;
	bh=T1GLK5swXm9ffi3GijVN1uaXajq/zCynYioG+5H0AvA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOQqhSotp1s42hIg+qXDO/tbUKGLckONXF3/cumZtWr8Lb/vd8eLr55VqObZHpT0WFLohpKFpvhqEyrMDr9Z8qoFGmpFcHgd3ZMTMo5AJOe312EhituYRDWn2NDHnDhSheBy0wBEOS3a5SeRVU5WalT6d16xLAO7pfFgOr2NIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzFLT6Db9z6K6tC;
	Wed, 12 Jun 2024 01:01:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D371C140A70;
	Wed, 12 Jun 2024 01:06:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 18:06:00 +0100
Date: Tue, 11 Jun 2024 18:05:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	<broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 6/6] iio: adc: Add support for AD4000
Message-ID: <20240611180559.000052c7@Huawei.com>
In-Reply-To: <ZmgoNRkso4egGWgJ@surfacebook.localdomain>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	<e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>
	<e92871489d416e4f8a350fd24fc5ed0012b3cf2b.camel@gmail.com>
	<20240609102354.02aa1128@jic23-huawei>
	<ZmgoNRkso4egGWgJ@surfacebook.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 11 Jun 2024 13:34:29 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Sun, Jun 09, 2024 at 10:23:54AM +0100, Jonathan Cameron kirjoitti:
> 
> ...
> 
> > > > +	/*
> > > > +	 * In 4-wire mode, the CNV line is held high for the entire
> > > > conversion
> > > > +	 * and acquisition process. In other modes st->cnv_gpio is NULL and
> > > > is
> > > > +	 * ignored (CS is wired to CNV in those cases).
> > > > +	 */
> > > > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);    
> > > 
> > > Not sure it's a good practise to assume internal details as you're going for
> > > GPIO. I would prefer to have an explicit check for st->cnv_gpio being NULL or
> > > not.  
> > 
> > Hmm. I had it in my head that this was documented behaviour, but
> > I can't find such in the docs, so agreed checking it makes sense.
> > 
> > I would be very surprised if this ever changed as it's one of the
> > things that makes optional gpios easy to work with but who knows!  
> 
> Not Linus and not Bart, but we have tons of drivers that call GPIO APIs
> unconditionally as long as they want optional GPIO.
> 
> What I see here is the comment that should be rewritten to say something like
> 
> "if GPIO is defined blablabla, otherwise blablabla."
> 
> I.o.w. do not mention that implementation detail (being NULL, i.e. optional).
> 

Good point - handy comment there already and this minor tweak will make it clear.

Thanks Andy!

Jonathan

