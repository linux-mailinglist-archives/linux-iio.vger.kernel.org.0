Return-Path: <linux-iio+bounces-13959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A534A04273
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA3F3A57A3
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B71E9B2E;
	Tue,  7 Jan 2025 14:25:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F61AD3E0
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259899; cv=none; b=P1A/aMxZyTMmv5gX1fOd1FwATrE2FN94LTS8sY+JPba7pocVqNA5DP14e1XUs+8U1cMp+ciJyJhHc8bG57DmU4PCWdiJi8UL7HE7wTU5SBXgnkOwyAY542oxk9qLzPA0f2hLUPITSNsMfBFAtVlJBue6nGIPMvdNvf1emJmXctE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259899; c=relaxed/simple;
	bh=LQt3nDWw9gdhwXy4ktKWqj9KHfRKWdKhVFTJidLZL0w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/pmPb86WymNr6YljlaPsJx+BJZ9msMVT5FSxXGLxkwk54rh2WuVzFp8uVVz996FTpjelb3E0c4bKOEN6T0v6cF3MQk2b4yqKjBofPp0HPrp5EwlY/OVFaJwBuH7scWPK4V99Bmt78xwDaVOO1k4dUOWkvas9Bxz7GuoNPG42Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YSCr50g07z6JBDf;
	Tue,  7 Jan 2025 22:20:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CAB281403A8;
	Tue,  7 Jan 2025 22:24:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 7 Jan
 2025 15:24:53 +0100
Date: Tue, 7 Jan 2025 14:24:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	=?UTF-8?Q?=E2=80=9CLuc?= Van =?UTF-8?Q?Oostenryck=E2=80=9D?=
	<luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <20250107142451.000021db@huawei.com>
In-Reply-To: <88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
	<20250105172613.1204781-2-jic23@kernel.org>
	<88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 6 Jan 2025 17:14:12 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/5/25 11:25 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Initial thought was to do something similar to __cond_lock()
> > 
> > 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
> > + Appropriate static inline iio_device_release_direct_mode()
> > 
> > However with that, sparse generates false positives. E.g.
> > 
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock  
> 
> Even if false positives aren't technically wrong, if sparse is having a hard
> time reasoning about the code, then it is probably harder for humans to reason
> about the code as well. So rewriting these false positives anyway could be
> justified beyond just making the static analyzer happy.
> 
> > 
> > So instead, this patch rethinks the return type and makes it more
> > 'conditional lock like' (which is part of what is going on under the hood
> > anyway) and return a boolean - true for successfully acquired, false for
> > did not acquire.  
> 
> I think changing this function to return bool instead of int is nice change
> anyway since it makes writing the code less prone authors to trying to do
> something "clever" with the ret variable. And it also saves one one line of
> code.
> 
> > 
> > To allow a migration path given the rework is now no trivial, take a leaf
> > out of the naming of the conditional guard we currently have for IIO
> > device direct mode and drop the _mode postfix from the new functions giving
> > iio_device_claim_direct() and iio_device_release_direct()
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/iio/iio.h | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 56161e02f002..4ef2f9893421 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> >  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> >  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> >  
> > +/*
> > + * Helper functions that allow claim and release of direct mode
> > + * in a fashion that doesn't generate false positives from sparse.
> > + */
> > +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)  
> 
> Doesn't __cond_acquires depend on this patch [1] that doesn't look like it was
> ever picked up in sparse?
> 
> [1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/

I wondered about that. It 'seems' to do the job anyway. I didn't fully
understand that thread so I just blindly tried it instead :)

This case is simpler that that thread, so maybe those acrobatics aren't
needed?

Jonathan

> 
> > +{
> > +	int ret = iio_device_claim_direct_mode(indio_dev);
> > +
> > +	if (ret)
> > +		return false;
> > +
> > +	__acquire(iio_dev);
> > +
> > +	return true;
> > +}
> > +
> > +static inline void iio_device_release_direct(struct iio_dev *indio_dev) __releases(indio_dev)
> > +{
> > +	iio_device_release_direct_mode(indio_dev);
> > +	__release(indio_dev);
> > +}
> > +
> >  /*
> >   * This autocleanup logic is normally used via
> >   * iio_device_claim_direct_scoped().  
> 
> In summary, assuming we get the required changed merged into sparse, I think this
> seems like the best solution.
> 


