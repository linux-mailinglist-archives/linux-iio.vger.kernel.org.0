Return-Path: <linux-iio+bounces-23964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FBB52053
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F545E238D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF72C234F;
	Wed, 10 Sep 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/4xex8u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBA23F42D;
	Wed, 10 Sep 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529412; cv=none; b=phHy90D4BUP99YmXsAvVTwnCGtgC1671RR4EkgC/FFwvVg8oQDGYoeBKED4/gYrzNcyAWerALDro2L7ei2XwkmVL5VskZ9txfM7iNZq5BFcOCOo6tE73UVTjYVZmudPqbolBjaMIOBVQ9M7eRfju4Ki0MQiKl/srHClbn2NRGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529412; c=relaxed/simple;
	bh=3kVUQr3IjP3Mesy9HWtYjb13tpRwVeyf9L8UDLw172Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUwMAvOrqN76C7hhv37hDE/FaXvPJbJj2eIn1VtQGDZJh3fRtW/sb5wQKRWoIP4DsIk6UcfvyT3F3/DJxuOf6aQx5x5TJVTpgjS9ZyLbkvayIx04MHClzJ9YLCqUZIHE9E07ftHoQZmwn64x5shU3HNO9vv3ER1sTtW37PlnP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/4xex8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B1C4CEEB;
	Wed, 10 Sep 2025 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757529412;
	bh=3kVUQr3IjP3Mesy9HWtYjb13tpRwVeyf9L8UDLw172Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/4xex8ult4IR3AVEwqex6nmknLVOvvt8DWT3q1cC8OlW5fXjllhwFrBDXsj8rEQh
	 2hlMN2hiOSj+SbfAPUM1nXjF85qiLAQ46Dyc2QRzdbGHO+nNrcraI11giDfzROaxVP
	 1F6dghUaPGF9SlHP1xKkp9fxb1upDEz/KKdWy/OiAYfx1lN/8ztlwh8tamK1XsBOLU
	 vYO+9tFC7yIOCyzvFmYyILInOrUwgtD/RWBV0N9jwdM1ZkZQFZC5OhMNY6wYgudnzf
	 BZT7PS195XxbYEEmsVwlQAfiSNq/Nro37YTISWR20uPaMJCdyoSO2HXS7KWJLGmFES
	 psVwL6Z1C8Wwg==
Date: Wed, 10 Sep 2025 19:36:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jean-Baptiste
 Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
Message-ID: <20250910193641.7c982d46@jic23-huawei>
In-Reply-To: <aMAoWPAvOmOfgfaR@smile.fi.intel.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
	<20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
	<aMAR4Jx3pWQ1_rjX@smile.fi.intel.com>
	<wl4fvd76hjf66k6pmkoce5wg5luspxjjsclxg5pdh7rjycarko@ovddl55mn77l>
	<aMAoWPAvOmOfgfaR@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 16:15:04 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Sep 09, 2025 at 11:53:02AM +0000, Sean Nyekjaer wrote:
> > On Tue, Sep 09, 2025 at 02:39:12PM +0100, Andy Shevchenko wrote:  
> > > On Tue, Sep 09, 2025 at 09:11:11AM +0200, Sean Nyekjaer wrote:  
> 
> ...
> 
> > > >  	/* exit if FIFO is already on */
> > > >  	if (st->fifo.on) {
> > > > -		ret = 0;
> > > > -		goto out_on;  
> > > 
> > > Probably you wanted the same comment here
> > > 
> > > 	/* increase FIFO on counter */
> > >   
> > > > +		st->fifo.on++;
> > > > +		return 0;
> > > >  	}  
> 
> ...
> 
> > > >  	/* exit if there are several sensors using the FIFO */
> > > >  	if (st->fifo.on > 1) {
> > > > -		ret = 0;
> > > > -		goto out_off;  
> > > 
> > > In the similar way
> > >   
> > 
> > Considered it. But isn't it obvious whats happening?  
> 
> With the same equality existing ones may be killed. Some of consistency at least :-)
> 
> > I will be happy to add them...  
> 
> > > 	/* decrease FIFO on counter */
> > >   
> > > > +		st->fifo.on--;
> > > > +		return 0;
> > > >  	}  
> 
Applied with this tweak.  Thanks

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 15391961bf96..ada968be954d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -300,7 +300,6 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
 
        guard(mutex)(&st->lock);
 
-       /* exit if FIFO is already on */
        if (st->fifo.on) {
                st->fifo.on++;
                return 0;
@@ -329,7 +328,6 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
        if (ret)
                return ret;
 
-       /* increase FIFO on counter */
        st->fifo.on++;
 
        return 0;
@@ -342,7 +340,6 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 
        guard(mutex)(&st->lock);
 
-       /* exit if there are several sensors using the FIFO */
        if (st->fifo.on > 1) {
                st->fifo.on--;
                return 0;
@@ -366,7 +363,6 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
        if (ret)
                return ret;
 
-       /* decrease FIFO on counter */
        st->fifo.on--;
 
        return 0;


