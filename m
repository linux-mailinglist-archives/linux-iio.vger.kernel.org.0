Return-Path: <linux-iio+bounces-13752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE199FAD9B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 12:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9F8164517
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD67198A01;
	Mon, 23 Dec 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbHZsOW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574DF191F9E;
	Mon, 23 Dec 2024 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952664; cv=none; b=Jt53Bg6BRD/tK+YETayX8x7m7gu616++SJFUfZQ7dDiyIezCp/5n/cipBMn1k3DGnXfDT1cJxfy9WZyaI0I8qKCbL80kHPz4N0HQRVcfQdktRF1IbIBpceYj18w5sYWGmeIFepyDl20cksX9PxZ9ELQC0euf/CZXCp+gYA+WJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952664; c=relaxed/simple;
	bh=TrpbuE7AtmlVy+LS0N5aLbdSW1TjCrvmclqT30aJoAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXobEncXQg4ZWARbuyCSb+TEypbHFsbpJd+H+dwcKXbcZJShVbTJYKXfIRYLnRxBS0CDi3FrSpvCZjynPAo+nFUZ+2Ifsp3d9zeqcNUlFrKHdCtP2xT4B3ah1MTapjixZHmWmI6uP97q1vEPOtPBhLyg3TRaBaMZ29+vCaiSnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbHZsOW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69883C4CED3;
	Mon, 23 Dec 2024 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734952663;
	bh=TrpbuE7AtmlVy+LS0N5aLbdSW1TjCrvmclqT30aJoAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CbHZsOW/iPNS/PUqWbCFY9QUqSPVfv2CCw5+vcLcdnVmWMB6RiSe98wn0PtzcJ+bc
	 TVtelAfqZchrU8IEr519g2CsV0eyU1x8F/fXJi6527z0/4SZeDIyTmbzmlNVpJ223p
	 Z2cMnWrCLRYGRNSviUyRw9R6zCAXTPDBz/o7KeYuFj7ZMLqa+e+JYsQsfZnO95ZY2a
	 6ZDd5CpVOPG51kpdBgGlHjfUjfSuc3zDPBtqtRESeq1VtoLNJI50kBnWIaomYravv8
	 ivhpvaotHjZzHW7TMgnkZVv9DBLyJL8sc5zMSrZe7jSMcc1Ul80ReLe/Ao2m2Li8Ru
	 sIvd08eDOcVvQ==
Date: Mon, 23 Dec 2024 11:17:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: gts-helper: add helpers to ease searches of
 gain_sel and new_gain
Message-ID: <20241223111735.666d2e8a@jic23-huawei>
In-Reply-To: <3d1154e3-bd5c-46b8-8cce-4ede9c39de4b@gmail.com>
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
	<20241220-veml3235_scale-v1-1-b43b190bbb6a@gmail.com>
	<3d1154e3-bd5c-46b8-8cce-4ede9c39de4b@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 20:19:21 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 20/12/2024 21:28, Javier Carrasco wrote:
> > This helper functions reduce the burden in the drivers that want to
> > fetch a gain selector in all available times or a new optimal gain.
> > 
> > The former is currently achieved by calling
> > iio_gts_find_gain_sel_for_scale_using_time() for the current time
> > selector, and then iterating over the rest of time selectors if the
> > gain selector was not found.
> > 
> > The latter requires a combination of multiple iio-gts helpers to find
> > the new gain, look for an optimal gain if there was no exact match, and
> > set a minimum gain if the optimal gain is not in the range of available
> > gains.
> > 
> > Provide simpler workflows by means of functions that address common
> > patterns in the users of the iio-gts helpers.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> 
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
A couple of comments inline.

Thanks,

Jonathan

> > ---
> >   drivers/iio/industrialio-gts-helper.c | 74 +++++++++++++++++++++++++++++++++++
> >   include/linux/iio/iio-gts-helper.h    |  5 +++
> >   2 files changed, 79 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> > index 3b5a99815062..f88b0b7192dd 100644
> > --- a/drivers/iio/industrialio-gts-helper.c
> > +++ b/drivers/iio/industrialio-gts-helper.c
> > @@ -915,6 +915,38 @@ int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel
> >   }
> >   EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_for_scale_using_time, "IIO_GTS_HELPER");
> >   
> > +/**
> > + * iio_gts_find_gain_sel_in_times - Fetch gain selector in the available times.
> > + * @gts:	Gain time scale descriptor
> > + * @scale_int:	Integral part of the scale (typically val1)
> > + * @scale_nano:	Fractional part of the scale (nano or ppb)
> > + * @gain_sel:	Pointer to value where gain selector is stored.
> > + * @time_sel:	Pointer to value where time selector is stored.
> > + *
> > + * Wrapper around iio_gts_find_gain_for_scale_using_time() to fetch the
> > + * gain selector for all supported integration times.
> > + *
> > + * Return: 0 on success and -EINVAL on error.
> > + */
> > +int iio_gts_find_gain_sel_in_times(struct iio_gts *gts, int scale_int,
> > +				   int scale_nano, int *gain_sel, int *time_sel)
> > +{
> > +	int i, ret;
> > +
> > +	for (i = 0; i < gts->num_itime; i++) {
> > +		*time_sel = gts->itime_table[i].sel;
> > +		ret = iio_gts_find_gain_sel_for_scale_using_time(gts, *time_sel,
> > +								 scale_int,
> > +								 scale_nano,
> > +								 gain_sel);
> > +		if (!ret)
> > +			return 0;
Trivial but slight preference for keeping the error path out of line rather than
the good path.

Easily done with:

		if (ret)
			continue;

		return 0;

> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_in_times, "IIO_GTS_HELPER");
> > +
> >   static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
> >   {
> >   	const struct iio_itime_sel_mul *itime;
> > @@ -1086,6 +1118,48 @@ int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
> >   }
> >   EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_by_old_gain_time, "IIO_GTS_HELPER");
> >   
> > +/**
> > + * iio_gts_find_new_gain_by_gain_time_min - compensate for time change
> > + * @gts:	Gain time scale descriptor
> > + * @old_gain:	Previously set gain
> > + * @old_time:	Selector corresponding previously set time
> > + * @new_time:	Selector corresponding new time to be set
> > + * @new_gain:	Pointer to value where new gain is to be written
> > + * @in_range:	Indicate if the @new_gain was in the range of
> > + *		supported gains.
> > + *
> > + * Wrapper around iio_gts_find_new_gain_by_old_gain_time() that tries to
> > + * set an optimal value if no exact match was found, defaulting to the
> > + * minimum gain to avoid saturations if the optimal value is not in the
> > + * range of supported gains.
> > + *
> > + * Return: 0 on success and a negative value if no gain was found.
> > + */
> > +int iio_gts_find_new_gain_by_gain_time_min(struct iio_gts *gts, int old_gain,
> > +					   int old_time, int new_time,
> > +					   int *new_gain, bool *in_range)
> > +{
> > +	int ret;
> > +
> > +	*in_range = true;
> > +	ret = iio_gts_find_new_gain_by_old_gain_time(gts, old_gain, old_time,
> > +						     new_time, new_gain);
> > +	if (*new_gain < 0)
> > +		return -EINVAL;
> > +
> > +	if (ret) {
> > +		*new_gain = iio_find_closest_gain_low(gts, *new_gain, in_range);
> > +		if (*new_gain < 0) {
> > +			*new_gain = iio_gts_get_min_gain(gts);
> > +			if (*new_gain < 0)
> > +				return ret;

The return value here is possibly misleading as it comes from the original
iio_gts_find_new_gain_by_old_gain_time() call.
Sure it may have the same value, but I'd rather it was set explicitly here
so it was clear that we have a case where all fallbacks failed.


> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_by_gain_time_min, "IIO_GTS_HELPER");
> > +
> >   MODULE_LICENSE("GPL");
> >   MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> >   MODULE_DESCRIPTION("IIO light sensor gain-time-scale helpers");
> > diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> > index 9cb6c80dea71..ae91ad008cc8 100644
> > --- a/include/linux/iio/iio-gts-helper.h
> > +++ b/include/linux/iio/iio-gts-helper.h
> > @@ -188,6 +188,8 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
> >   int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel,
> >   					       int scale_int, int scale_nano,
> >   					       int *gain_sel);
> > +int iio_gts_find_gain_sel_in_times(struct iio_gts *gts, int scale_int,
> > +				   int scale_nano, int *gain_sel, int *time_sel);
> >   int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_int,
> >   		      int *scale_nano);
> >   int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
> > @@ -196,6 +198,9 @@ int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
> >   int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
> >   					   int old_time, int new_time,
> >   					   int *new_gain);
> > +int iio_gts_find_new_gain_by_gain_time_min(struct iio_gts *gts, int old_gain,
> > +					   int old_time, int new_time,
> > +					   int *new_gain, bool *in_range);
> >   int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
> >   			int *length);
> >   int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,
> >   
> 


