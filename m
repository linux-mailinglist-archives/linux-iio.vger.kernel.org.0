Return-Path: <linux-iio+bounces-23316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7EB372E0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700514628CF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B13374267;
	Tue, 26 Aug 2025 19:11:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D331A54F
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235487; cv=none; b=hrgwQ2aQr4nXZqsKF9OsM23Vpxf3CuFJYsN6HdmNhFEvsHVFzvgGwgUGQTZSuCMscaTMxVHkRfSbDYyYYp4nYOv6aCv8+p1wOiqkuDtCRO6P3s0E1LFJcbeDyC5eRtaJv9Szrk5J39JrEfb5Uh3bMM++5ShTbCiNgIOit+EkaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235487; c=relaxed/simple;
	bh=Uhdzc8EEUYuWN+cZjWFk5mNDLydwMtF2JLNcSZ5LYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLl0x86X/KQd2nFliGNmwfOvEjzPQ0wVSW8jh03FbW/s3XXE2iU8Feag93vpYn7+SD8S0SjLJvlGwosCRjfFAb8hNV/DFJf/UURgCXiC8+SXSIGp9BK31A2cV6c0PgPT68h3OsMfliGlE55yzjcq+YNKaOpxU8df2f7UAkwEd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Aug 2025 15:11:14 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: ad4080: Rework filter_type "none" logic
Message-ID: <2025082615-striped-crocodile-9cb63f@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <20250825-mcp9600-iir-v7-5-2ba676a52589@kernel.org>
 <0f515c35-b2ac-4d23-b8bb-77151ed2eb9f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f515c35-b2ac-4d23-b8bb-77151ed2eb9f@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 11:51:56AM -0500, David Lechner wrote:
> On 8/25/25 7:10 PM, Ben Collins wrote:
> > The filter_type logic for "none" needed to be reworked to be more
> > general.
> > 
> > As documented, return IIO_VAL_EMPTY for sampling rates in "none" type
> > and EINVAL when there's an attempt to write a rate for "none" type.
> 
> This patch breaks usespace, which is something we always must avoid.

I was under the impression there was a need to make the use of
filter_type "none" more consistent.

I don't disagree with not breaking userspace, but it does create
ambiguity for other implementations.

> > 
> > Signed-off-by: Ben Collins <bcollins@kernel.org>
> > ---
> >  drivers/iio/adc/ad4080.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > index 6e61787ed3213fe4332bd92b938a7a717dada99f..c7408b9703731ee5d4229a85ffa91ea64b233cd9 100644
> > --- a/drivers/iio/adc/ad4080.c
> > +++ b/drivers/iio/adc/ad4080.c
> > @@ -154,8 +154,6 @@ static const int ad4080_dec_rate_avail[] = {
> >  	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
> >  };
> >  
> > -static const int ad4080_dec_rate_none[] = { 1 };
> > -
> >  static const char * const ad4080_power_supplies[] = {
> >  	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
> >  };
> > @@ -268,13 +266,13 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
> >  			*val = st->clk_rate;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > -		if (st->filter_type == FILTER_NONE) {
> > -			*val = 1;
> > -		} else {
> > -			*val = ad4080_get_dec_rate(indio_dev, chan);
> > -			if (*val < 0)
> > -				return *val;
> > -		}
> > +		if (st->filter_type == FILTER_NONE)
> > +			return IIO_VAL_EMPTY;
> > +
> > +		*val = ad4080_get_dec_rate(indio_dev, chan);
> > +		if (*val < 0)
> > +			return *val;
> > +
> >  		return IIO_VAL_INT;
> >  	default:
> >  		return -EINVAL;
> > @@ -289,7 +287,7 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > -		if (st->filter_type == FILTER_NONE && val > 1)
> > +		if (st->filter_type == FILTER_NONE)
> >  			return -EINVAL;
> >  
> >  		return ad4080_set_dec_rate(indio_dev, chan, val);
> > @@ -376,17 +374,16 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >  		switch (st->filter_type) {
> >  		case FILTER_NONE:
> > -			*vals = ad4080_dec_rate_none;
> > -			*length = ARRAY_SIZE(ad4080_dec_rate_none);
> > +			*type = IIO_VAL_EMPTY;
> >  			break;
> >  		default:
> >  			*vals = ad4080_dec_rate_avail;
> >  			*length = st->filter_type >= SINC_5 ?
> >  				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
> >  				  ARRAY_SIZE(ad4080_dec_rate_avail);
> > +			*type = IIO_VAL_INT;
> >  			break;
> >  		}
> > -		*type = IIO_VAL_INT;
> >  		return IIO_AVAIL_LIST;
> >  	default:
> >  		return -EINVAL;
> > 
> 
> Returning a value of 1 for the oversampling ratio when there is no
> oversampling going on is perfectly reasonable and mathematically correct.
> So I don't consider this change an improvement.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

