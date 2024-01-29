Return-Path: <linux-iio+bounces-2034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE198413F4
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 20:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C2D1F24C1B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE76F097;
	Mon, 29 Jan 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMhksVn0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151C48790
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558305; cv=none; b=aw0pDaPczb1er2ZCiZincQAzCZ1Cu1HAorrymXQ2IbolSHndv/vuR/beELMdeZZhxqrVYBPnYgbWKC/QcHjxoDozaPPogAhPIPGRiw6AIBluYnAMnR6/2ysOeULvhXFDaHsSkqtFxVtbZlmQSE/VuF+o7mRKBBdNiIBpfx/iE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558305; c=relaxed/simple;
	bh=bMCNr8TdR9K7k6i61F3I2TKGeTKbMtMvIrNqpyTqBIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5V0OT8OLqcMPc0w22Qy9qBJHtxeBcms1xzxkrLtKOojsxHO6ZW5ymFrHeNcvx8gbkBLhOPbZ6Ukd3WuoOuMu5rGHdSwLbuIVoLK9kit1WvxKulBJMkcM1Jj5j8WWZFrpp91yNP2vUoy0ZlTDoovGKTfhM/qUi5jC1Y6dQNzKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMhksVn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC7C433C7;
	Mon, 29 Jan 2024 19:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558305;
	bh=bMCNr8TdR9K7k6i61F3I2TKGeTKbMtMvIrNqpyTqBIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bMhksVn0CfM2Zguh7v0NjSdBiJ9o/NoHMI5Sg3aJQcjS/1opl0SnUJtBaRxHi3DZh
	 8F5M+fSQCWz+9VkxGTvTSSw2WQSnySNyUK/nYkD7bD64dXQk8kxgtK/RnWP8Nk75sB
	 ee/95CG+AzpLd9TSguPrjpRs9i7gWjZld8KKVZAxwI/V/NlPlb29aJtPVzAAuwiQBS
	 h747Np8CN0SbIA9bsEhhYJLUVdLZt8lKyNh0Yl4qg3m0FtlOtbR/1dM17NimikswL/
	 5WJ20MNqdlQJ2G1lQuFytMfH4ASQkaJmEurNWYbwAgRsPaMOoq6CRM5k8h8ynyYh3d
	 KW0FMftjsN7VQ==
Date: Mon, 29 Jan 2024 19:58:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [PATCH 02/10] iio: dummy: Use automatic lock and direct mode
 cleanup.
Message-ID: <20240129195813.34912f8c@jic23-huawei>
In-Reply-To: <20240129114622.00007e1c@Huawei.com>
References: <20240128150537.44592-1-jic23@kernel.org>
	<20240128150537.44592-3-jic23@kernel.org>
	<CAMknhBFzuoQQDbfJjUkDd8udAkRzhsM_Vs-FyEmaAE_k6QXk3Q@mail.gmail.com>
	<20240129114622.00007e1c@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 11:46:22 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> > > @@ -436,10 +431,10 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
> > >                         if (chan->output == 0)
> > >                                 return -EINVAL;
> > >
> > > -                       /* Locking not required as writing single value */
> > > -                       mutex_lock(&st->lock);
> > > -                       st->dac_val = val;
> > > -                       mutex_unlock(&st->lock);
> > > +                       scoped_guard(mutex, &st->lock) {
> > > +                               /* Locking not required as writing single value */
> > > +                               st->dac_val = val;
> > > +                       }
> > >                         return 0;
> > >                 default:
> > >                         return -EINVAL;
> > > @@ -447,9 +442,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
> > >         case IIO_CHAN_INFO_PROCESSED:
> > >                 switch (chan->type) {
> > >                 case IIO_STEPS:
> > > -                       mutex_lock(&st->lock);
> > > -                       st->steps = val;
> > > -                       mutex_unlock(&st->lock);
> > > +                       scoped_guard(mutex, &st->lock) {
> > > +                               st->steps = val;
> > > +                       }
> > >                         return 0;
> > >                 case IIO_ACTIVITY:
> > >                         if (val < 0)
> > > @@ -470,30 +465,29 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
> > >                 default:
> > >                         return -EINVAL;
> > >                 }
> > > -       case IIO_CHAN_INFO_CALIBSCALE:
> > > -               mutex_lock(&st->lock);
> > > +       case IIO_CHAN_INFO_CALIBSCALE: {
> > > +               guard(mutex)(&st->lock);
> > >                 /* Compare against table - hard matching here */
> > >                 for (i = 0; i < ARRAY_SIZE(dummy_scales); i++)
> > >                         if (val == dummy_scales[i].val &&
> > >                             val2 == dummy_scales[i].val2)
> > >                                 break;
> > >                 if (i == ARRAY_SIZE(dummy_scales))
> > > -                       ret = -EINVAL;
> > > -               else
> > > -                       st->accel_calibscale = &dummy_scales[i];
> > > -               mutex_unlock(&st->lock);
> > > +                       return  -EINVAL;
> > > +               st->accel_calibscale = &dummy_scales[i];
> > >                 return ret;    
> > 
> > Can we change this to `return 0;` and get rid of the `ret = 0`
> > initialization at the beginning of the function?  
> 
> Yes. That would make sense.

Given it's fairly trivial, I may not post it again but instead just
tidy that up whilst applying.  Diff will also git rid of the bonus space
in this block. oops.

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index d6ef556698fb..09efacaf8f78 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -421,7 +421,6 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
                               long mask)
 {
        int i;
-       int ret = 0;
        struct iio_dummy_state *st = iio_priv(indio_dev);
 
        switch (mask) {
@@ -473,9 +472,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
                            val2 == dummy_scales[i].val2)
                                break;
                if (i == ARRAY_SIZE(dummy_scales))
-                       return  -EINVAL;
+                       return -EINVAL;
                st->accel_calibscale = &dummy_scales[i];
-               return ret;
+               return 0;
        }
        case IIO_CHAN_INFO_CALIBBIAS:
                scoped_guard(mutex, &st->lock) {

> >   
> > > +       }  
> 


