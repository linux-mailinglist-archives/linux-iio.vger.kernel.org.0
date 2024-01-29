Return-Path: <linux-iio+bounces-2009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C084040F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 12:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63307283B62
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339F5C5E4;
	Mon, 29 Jan 2024 11:46:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D705FEE5
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528788; cv=none; b=AZgQygo2Kxa6lByQunG52zsjD5TVeev/pfo1KTvUboaKFig1vTA53SjLFvA96+lBC4Ozo/o1H3AeJst5dCxgKO8VwGicYU1V36wCJcla5HjUw74MzV4sHBYTDc00uaxiO/LtW2C36S4I6axf2qYh2yZ3r6VLKq6ESYeXswakylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528788; c=relaxed/simple;
	bh=uKGk/7/o3HMB/VNsuUKF06VQy8sceZYcXte6dI33bDA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca5rJxGffkS+DIpnGaQ7cWSC6zx8qGfOB/+o664p7S8Qqf57BSrSxcMKBmUamgGpnjaU6MOD/esH038AKjkG97XQ31c72xn6qDyI7L185xZzwJUt6XVezJNtbzXSQPTySK+s1AM4DhkDIgCtyjCYQcl5LqnxlFP2s0JA1s9WrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNmdg6W96z6K9B2;
	Mon, 29 Jan 2024 19:43:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D455140136;
	Mon, 29 Jan 2024 19:46:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 11:46:23 +0000
Date: Mon, 29 Jan 2024 11:46:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>
Subject: Re: [PATCH 02/10] iio: dummy: Use automatic lock and direct mode
 cleanup.
Message-ID: <20240129114622.00007e1c@Huawei.com>
In-Reply-To: <CAMknhBFzuoQQDbfJjUkDd8udAkRzhsM_Vs-FyEmaAE_k6QXk3Q@mail.gmail.com>
References: <20240128150537.44592-1-jic23@kernel.org>
	<20240128150537.44592-3-jic23@kernel.org>
	<CAMknhBFzuoQQDbfJjUkDd8udAkRzhsM_Vs-FyEmaAE_k6QXk3Q@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > @@ -436,10 +431,10 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
> >                         if (chan->output == 0)
> >                                 return -EINVAL;
> >
> > -                       /* Locking not required as writing single value */
> > -                       mutex_lock(&st->lock);
> > -                       st->dac_val = val;
> > -                       mutex_unlock(&st->lock);
> > +                       scoped_guard(mutex, &st->lock) {
> > +                               /* Locking not required as writing single value */
> > +                               st->dac_val = val;
> > +                       }
> >                         return 0;
> >                 default:
> >                         return -EINVAL;
> > @@ -447,9 +442,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
> >         case IIO_CHAN_INFO_PROCESSED:
> >                 switch (chan->type) {
> >                 case IIO_STEPS:
> > -                       mutex_lock(&st->lock);
> > -                       st->steps = val;
> > -                       mutex_unlock(&st->lock);
> > +                       scoped_guard(mutex, &st->lock) {
> > +                               st->steps = val;
> > +                       }
> >                         return 0;
> >                 case IIO_ACTIVITY:
> >                         if (val < 0)
> > @@ -470,30 +465,29 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
> >                 default:
> >                         return -EINVAL;
> >                 }
> > -       case IIO_CHAN_INFO_CALIBSCALE:
> > -               mutex_lock(&st->lock);
> > +       case IIO_CHAN_INFO_CALIBSCALE: {
> > +               guard(mutex)(&st->lock);
> >                 /* Compare against table - hard matching here */
> >                 for (i = 0; i < ARRAY_SIZE(dummy_scales); i++)
> >                         if (val == dummy_scales[i].val &&
> >                             val2 == dummy_scales[i].val2)
> >                                 break;
> >                 if (i == ARRAY_SIZE(dummy_scales))
> > -                       ret = -EINVAL;
> > -               else
> > -                       st->accel_calibscale = &dummy_scales[i];
> > -               mutex_unlock(&st->lock);
> > +                       return  -EINVAL;
> > +               st->accel_calibscale = &dummy_scales[i];
> >                 return ret;  
> 
> Can we change this to `return 0;` and get rid of the `ret = 0`
> initialization at the beginning of the function?

Yes. That would make sense.

> 
> > +       }


