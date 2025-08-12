Return-Path: <linux-iio+bounces-22625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72AB22CEC
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 18:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2F7622A8E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9602D7802;
	Tue, 12 Aug 2025 16:01:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DE2E7172
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014462; cv=none; b=OwkFFwAe9PtEkF8zQsBhOWZ6Tyo5xyL090iju/+8KK5fqUBGcIe1j13JXqwcts0bTutD00MtE9/2qk2DlJgtuRrV7uXRInTqJCUm3Yu/bZdfF88Mal1i9d6vR04RR3Gx63LotaGFKGKh5Cwuao2tMbwMiICSZ1qwfWfp2E+SIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014462; c=relaxed/simple;
	bh=MZmhq0li+TESS1MPDeCcpZuleYVsDEdApskg7pGxUbk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I87DixnEPqhgdh4/H+Jm5tFGSXIypQ5dvnBcHBO39JG/m31kawQlVDgZcVs8ytnrrxwZih9sFrr7VKOvF1TKyuj+tJSyBkEZagq11SnZCKgxiwupRqSNUpxMRzYgI8DszSIyarl07mAQ/w/48HYCjHyqExxMPvjYfaiywhfMZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1bl03yTZz6L5LV;
	Tue, 12 Aug 2025 23:58:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D5E61402C8;
	Wed, 13 Aug 2025 00:00:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 18:00:58 +0200
Date: Tue, 12 Aug 2025 17:00:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>, Liam Beguin
	<liambeguin@gmail.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] iio: consumers: Add an iio_multiply_value()
 helper function
Message-ID: <20250812170057.00007151@huawei.com>
In-Reply-To: <CAHp75VfohEyQkXZfKe4-NkGqrA9ACLNYVqbh8zEMw=XqZDvrHQ@mail.gmail.com>
References: <20250811155453.31525-1-hansg@kernel.org>
	<20250811155453.31525-4-hansg@kernel.org>
	<CAHp75VfohEyQkXZfKe4-NkGqrA9ACLNYVqbh8zEMw=XqZDvrHQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > +int iio_multiply_value(int *result, s64 multiplier,
> > +                      unsigned int type, int val, int val2)
> > +{
> > +       s64 denominator;
> > +
> > +       switch (type) {
> > +       case IIO_VAL_INT:
> > +               *result = multiplier * val;
> > +               return IIO_VAL_INT;
> > +       case IIO_VAL_INT_PLUS_MICRO:
> > +       case IIO_VAL_INT_PLUS_NANO:
> > +               switch (type) {
> > +               case IIO_VAL_INT_PLUS_MICRO: denominator = MICRO; break;
> > +               case IIO_VAL_INT_PLUS_NANO: denominator = NANO; break;
> > +               }
> > +               *result = multiplier * abs(val);
> > +               *result += div_s64(multiplier * abs(val2), denominator);
> > +               if (val < 0 || val2 < 0)
> > +                       *result *= -1;
> > +               return IIO_VAL_INT;
> > +       case IIO_VAL_FRACTIONAL:
> > +               *result = div_s64(multiplier * val, val2);
> > +               return IIO_VAL_INT;
> > +       case IIO_VAL_FRACTIONAL_LOG2:
> > +               *result = (multiplier * val) >> val2;
> > +               return IIO_VAL_INT;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(iio_multiply_value);  
> 
> Is it in the namespace? I think we already discussed with Jonathan
> that IIO_CORE or something can be started if not yet for this kind of
> exported symbols (and it doesn't matter if the rest are still using
> global namespace, we can address that later on).

I think we are only exporting this for the unit test?  If so IIO_UNIT_TEST
namespace might be better?  We can move it to a more general one if it
starts getting use other that for testing (or directly in this file
where the export isn't needed).


> 
> ...
> 
> > +/**
> > + * iio_multiply_value() - Multiply an iio value  
> 

