Return-Path: <linux-iio+bounces-11149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6A19AEC4B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 18:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964FB1F224F6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A031FAEE2;
	Thu, 24 Oct 2024 16:35:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788461F9EA6;
	Thu, 24 Oct 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787702; cv=none; b=PemS8li3cBVqEkujzX7SImHbqMEIMJGSLurKgMmz58rhRzaZYJsEYjBXhsMElanyyAiiigBOx7bNT/BuVUUFZzJHayMzFy7AA6UIf4D6tG8yv7A6Mh6t8bLF4/1PisBxmZrtR7m2icgTynJxeSucu3lPqA5L2phZXBdJfvFa9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787702; c=relaxed/simple;
	bh=IoytTz6FlczuCtBnLxvEi0mTRI7KDE/USf6usLPfusg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj7ZJNl1lW7xzc1EAtKsaRIB05Gjs/zkzAPPLtzznoEvgkwKQb4cozKc8HzdPLuUKQMFX2D7lUViXfWqjiKTf1v5Ah6fq2tboEk2j2WrYqO3i8kRCW+VUpx45hh6oGl6Mm9tSQoTQv92l8eYyx00BO2tTJ6GcCgCnKcEYSwMXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZBGb0lsxz6L74C;
	Fri, 25 Oct 2024 00:30:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CC341404FC;
	Fri, 25 Oct 2024 00:34:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 18:34:56 +0200
Date: Thu, 24 Oct 2024 17:34:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hans de Goede <hdegoede@redhat.com>, Rayyan Ansari <rayyan@ansari.sh>,
	<linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Bjorn Andersson <andersson@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, <linux-kernel@vger.kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Robert Yang <decatf@gmail.com>, Rob Herring
	<robh@kernel.org>, Sean Rhodes <sean@starlabs.systems>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: Add support for KX022-1020
Message-ID: <20241024173454.00006240@Huawei.com>
In-Reply-To: <ZxpZfgsf-KldiX4w@black.fi.intel.com>
References: <20240714173431.54332-1-rayyan@ansari.sh>
	<20240714173431.54332-3-rayyan@ansari.sh>
	<823ce598-dffd-4983-bffa-32559558235d@redhat.com>
	<ZxpZfgsf-KldiX4w@black.fi.intel.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 24 Oct 2024 17:28:14 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jul 15, 2024 at 10:30:46AM +0200, Hans de Goede wrote:
> > On 7/14/24 7:33 PM, Rayyan Ansari wrote:  
> > > Add compatible for the KX022-1020 accelerometer [1] using the
> > > KX022-1023 [2] register map as both have an identical i2c interface.
> > > 
> > > [1]: https://kionixfs.azureedge.net/en/datasheet/KX022-1020%20Specifications%20Rev%2012.0.pdf
> > > [2]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf
> > > 
> > > Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>  
> > 
> > Thanks, patch looks good to me:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>  
> 
> Note, this patch broke kx231025 case...
> 
> > >  	KXCJ91008,
> > >  	KXTJ21009,
> > >  	KXTF9,
> > > +	KX0221020,
> > >  	KX0231025,
> > >  	KX_MAX_CHIPS /* this must be last */
> > >  };  
> 
> ...because this enum is used of ODR startup timeout settings which
> are all moved now to be 0 and new ID inherited the timeouts from
> the KX0231025 case.
> 
> Since I have been looking into the driver, and I have a few patches
> coming, I propose to do the following (as it's still ODR data being
> missed) to:
> 1) revert this one
> 2) apply my set;
> 3) re-apply this with the fixed data.

> 
> Another approach can be done (but probably not by me) is to move the ID
> to the proper location, add ODR startup timeouts or explain why it's not
> needed and then apply my patch.
> 
> But, taking into account that we are almost at -rc5 and I want my stuff
> not to be postponed, I tend to follow the first approach.
> 
> Opinions, comments?
> 
> P.S. FWIW, my set will include switching this driver to use chip_info
> structure so the similar mistakes won't happen again, that's also why
> I prefer the first approach I listed above.
> 

Hmm. Either I want the revert in before the release, or your series
to make the merge window (and hence probably hit in first couple of stable
releases).

Ideal would be revert very soon and chase it in to togreg so your series
can go on top, but that would rely on some lucky timing of pull requests
and merges that is probably too optimistic.

Jonathan




