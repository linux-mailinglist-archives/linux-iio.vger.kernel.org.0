Return-Path: <linux-iio+bounces-23538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A2B3D422
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6F517B238
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EEC1F91C8;
	Sun, 31 Aug 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2lRINPc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2DE573;
	Sun, 31 Aug 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653958; cv=none; b=m31Vc8WZ0KqmBVQyaxG9sWTmwn/5+zwNgJFEhMKMqMqHNjBFFR8pd7mB9mK9Gz8O1jwjVHD2T9E9LJqPZPwqXZqZU8dDFImOm0RN42ueXSIp2kFFj/ES6KxpaUpSNB6hBuFpx1sJeUU9A4YRJqvf2fETpo4oJLl2JNfH9qiBHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653958; c=relaxed/simple;
	bh=SBp2910O6Bx1CRCp60WlRVZ/9XM8fMSK9lgHPCxhAtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZynekKGzTam4Hcq/tEdEW+SCB8XUOS1Bh/BAoaQZp24Uim1ACaeaDqxnywjoQH8kuhnApUWk/GpDYEa/bWq3zzopvqpTboGXEVF0PuacXlVMe2Gp6PQj2cCdplgDp86/VJhFT/03cIadoj6mGSFIMnP3oUDEh1meugLu7rUbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2lRINPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA57BC4CEED;
	Sun, 31 Aug 2025 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756653958;
	bh=SBp2910O6Bx1CRCp60WlRVZ/9XM8fMSK9lgHPCxhAtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G2lRINPcLlLJ7bK8JL/E6coVPvyELOeVKe+F9RgvNuLq9yLt1PFJ1Wm2qkif5esy9
	 Fdphxbx763USnkxq3n4/yIzRQfJOtc9ln8PnKrNq5bmEr9XZEdGelBc3+3bpJIcpkl
	 3qiiYF7FkPz6SNipUqfmynQdc6p3BLdopTpOjrOl1mTjrCNPMo+baK6cdT2KQMb55a
	 PaFcdc0ElxCTaLIFGsQc/dL3P5jLtYyMzAz1FjAOflfgjzP0j9YuZI6thAXQcBOMuN
	 PrnCiBssBblaidIQ/G/QWeYraccFQ+tAEstlff2Tqb/TD6Uo+03oXyxhtVLP24lckc
	 wjA2t1SrQEhPA==
Date: Sun, 31 Aug 2025 16:25:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: ad4080: Rework filter_type "none" logic
Message-ID: <20250831162549.5395fa37@jic23-huawei>
In-Reply-To: <2025082615-striped-crocodile-9cb63f@boujee-and-buff>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
	<20250825-mcp9600-iir-v7-5-2ba676a52589@kernel.org>
	<0f515c35-b2ac-4d23-b8bb-77151ed2eb9f@baylibre.com>
	<2025082615-striped-crocodile-9cb63f@boujee-and-buff>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 15:11:14 -0400
Ben Collins <bcollins@kernel.org> wrote:

> On Tue, Aug 26, 2025 at 11:51:56AM -0500, David Lechner wrote:
> > On 8/25/25 7:10 PM, Ben Collins wrote:  
> > > The filter_type logic for "none" needed to be reworked to be more
> > > general.
> > > 
> > > As documented, return IIO_VAL_EMPTY for sampling rates in "none" type
> > > and EINVAL when there's an attempt to write a rate for "none" type.  
> > 
> > This patch breaks usespace, which is something we always must avoid.  
> 
> I was under the impression there was a need to make the use of
> filter_type "none" more consistent.
> 
> I don't disagree with not breaking userspace, but it does create
> ambiguity for other implementations.

For oversampling the value of 1 has long been used for
'not oversampling'. So I'm not seeing an ambiguity there.


Jonathan


> 
> > > 
> > > Signed-off-by: Ben Collins <bcollins@kernel.org>
> > > ---
> > >  drivers/iio/adc/ad4080.c | 23 ++++++++++-------------
> > >  1 file changed, 10 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > > index 6e61787ed3213fe4332bd92b938a7a717dada99f..c7408b9703731ee5d4229a85ffa91ea64b233cd9 100644
> > > --- a/drivers/iio/adc/ad4080.c
> > > +++ b/drivers/iio/adc/ad4080.c
> > > @@ -154,8 +154,6 @@ static const int ad4080_dec_rate_avail[] = {
> > >  	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
> > >  };
> > >  
> > > -static const int ad4080_dec_rate_none[] = { 1 };
> > > -
> > >  static const char * const ad4080_power_supplies[] = {
> > >  	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
> > >  };
> > > @@ -268,13 +266,13 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
> > >  			*val = st->clk_rate;
> > >  		return IIO_VAL_INT;
> > >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > -		if (st->filter_type == FILTER_NONE) {
> > > -			*val = 1;
> > > -		} else {
> > > -			*val = ad4080_get_dec_rate(indio_dev, chan);
> > > -			if (*val < 0)
> > > -				return *val;
> > > -		}
> > > +		if (st->filter_type == FILTER_NONE)
> > > +			return IIO_VAL_EMPTY;
> > > +
> > > +		*val = ad4080_get_dec_rate(indio_dev, chan);
> > > +		if (*val < 0)
> > > +			return *val;
> > > +
> > >  		return IIO_VAL_INT;
> > >  	default:
> > >  		return -EINVAL;
> > > @@ -289,7 +287,7 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
> > >  
> > >  	switch (mask) {
> > >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > -		if (st->filter_type == FILTER_NONE && val > 1)
> > > +		if (st->filter_type == FILTER_NONE)
> > >  			return -EINVAL;
> > >  
> > >  		return ad4080_set_dec_rate(indio_dev, chan, val);
> > > @@ -376,17 +374,16 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
> > >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > >  		switch (st->filter_type) {
> > >  		case FILTER_NONE:
> > > -			*vals = ad4080_dec_rate_none;
> > > -			*length = ARRAY_SIZE(ad4080_dec_rate_none);
> > > +			*type = IIO_VAL_EMPTY;
> > >  			break;
> > >  		default:
> > >  			*vals = ad4080_dec_rate_avail;
> > >  			*length = st->filter_type >= SINC_5 ?
> > >  				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
> > >  				  ARRAY_SIZE(ad4080_dec_rate_avail);
> > > +			*type = IIO_VAL_INT;
> > >  			break;
> > >  		}
> > > -		*type = IIO_VAL_INT;
> > >  		return IIO_AVAIL_LIST;
> > >  	default:
> > >  		return -EINVAL;
> > >   
> > 
> > Returning a value of 1 for the oversampling ratio when there is no
> > oversampling going on is perfectly reasonable and mathematically correct.
> > So I don't consider this change an improvement.  
> 


