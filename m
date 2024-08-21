Return-Path: <linux-iio+bounces-8654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE24C95A2E1
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8430D1F225E0
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85D15383E;
	Wed, 21 Aug 2024 16:34:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46275D8F0;
	Wed, 21 Aug 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258041; cv=none; b=XgQ32VsJYr1Xg/Gk96HhSNxCeSOiRsYFoYNI/vMSNAQ/chBWgx68EKaRyLeFYvABUR3yMlM4Y1rqs17b+E/gNMKg2yV1jMiFMGR0GGdbDk+VCUAe4fBMYkBIVsjTCiMBs+/+vEUMyMSsbD/NlScsobQBXkzXi+DQT5K1eMARZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258041; c=relaxed/simple;
	bh=pVLVC7RFMjEJt7SU0a6Zj0TKVkL+KpleH3S4AM1LVtI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELUMtmA3ubAgH0wSd0Gi1tPXjQXVt9+xayaGnpBZiKEj6sKXaaZYmsf8uUjs8KLB/XavxGBJE99nG8KNeR3NOJkE3s8ZoQKSE5tr4bpZjtIc2W0Zi0RJP7e9qtAfqorFosAqufb/gmZcQldmU4hvuj9unvAMIeI+FaW0EcMFREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WpsJl6P0kz6J7sn;
	Thu, 22 Aug 2024 00:30:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F9DF140A36;
	Thu, 22 Aug 2024 00:33:54 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 17:33:53 +0100
Date: Wed, 21 Aug 2024 17:33:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: adc: ad4695: implement calibration support
Message-ID: <20240821173352.000000b6@Huawei.com>
In-Reply-To: <e2401290-5504-4a17-93bd-af8684a82a7a@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
	<20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
	<20240821141615.00006ebe@Huawei.com>
	<e2401290-5504-4a17-93bd-af8684a82a7a@baylibre.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Aug 2024 11:12:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/21/24 8:16 AM, Jonathan Cameron wrote:
> > On Tue, 20 Aug 2024 10:58:36 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> The AD4695 has a calibration feature that allows the user to compensate
> >> for variations in the analog front end. This implements this feature in
> >> the driver using the standard `calibgain` and `calibbias` attributes.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> > Hi David,
> > 
> > Whilst some of the messy value manipulation is unavoidable
> > (oh for signed integer zero!), I wonder if we can at least
> > move one case into the core.
> > 
> > See below.
> >   
> >> +
> >> +static int ad4695_write_raw(struct iio_dev *indio_dev,
> >> +			    struct iio_chan_spec const *chan,
> >> +			    int val, int val2, long mask)
> >> +{
> >> +	struct ad4695_state *st = iio_priv(indio_dev);
> >> +	unsigned int reg_val;
> >> +	int ret;
> >> +
> >> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> >> +		switch (mask) {
> >> +		case IIO_CHAN_INFO_CALIBSCALE:
> >> +			switch (chan->type) {
> >> +			case IIO_VOLTAGE:
> >> +				if (val < 0 || val2 < 0)
> >> +					reg_val = 0;
> >> +				else if (val > 1)
> >> +					reg_val = U16_MAX;
> >> +				else
> >> +					reg_val = (val * (1 << 16) +
> >> +						   mul_u64_u32_div(val2, 1 << 16,
> >> +								   MICRO)) / 2;  
> > Maybe worth extending iio_write_channel_info() to handle
> > IIO_VAL_FRACTIONAL_LOG2()?
> > It'll look much like this and you'll need to provide write_raw_get_fmt()
> > so the core know what to do with the value formatting.
> > 
> > I don't really like the mixture here between the read path being able
> > to rely on the core code to deal with the /2^X and the write path not.  
> 
> Sounds like a good idea to me.
> 
> It seems like we would need to add an extra out parameter to 
> write_raw_get_fmt to say what we want the X in 2^X to be. For
> example, we would want to make sure the val2 we get in write_raw
> for this driver is 15.
Yes.  (I tried to reply to say I'd neglected this but managed to
just email myself. oops.)

Maybe it's too complex to bother given that.  Definitely a job
for another day rather than something to block this series on.


Jonathan

> 
> >> +
> >> +				return regmap_write(st->regmap16,
> >> +					AD4695_REG_GAIN_IN(chan->scan_index),
> >> +					reg_val);
> >> +			default:
> >> +				return -EINVAL;  
> > 
> > 
> >   
> 


