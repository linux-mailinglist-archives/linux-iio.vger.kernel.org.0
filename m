Return-Path: <linux-iio+bounces-16744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649BAA5DC67
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 13:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BDF17737F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039324291A;
	Wed, 12 Mar 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="KeYcb7yo"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B023F26B;
	Wed, 12 Mar 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781783; cv=none; b=uTzLteoUfunCDiqXkC/keykBZlCQq88BKN92D1fA6ElEzvx3Wtwv4mmbK8hGEX8im/Uy8MkTLqiMZ0hEZMmwDhe+h0ScOaJUR5apAIoMQ8o44TK8761wS9jKnsZ71nUcsG+w2W95ztJFs4u2zkENshryj0QQVKAu2JnBIyjJrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781783; c=relaxed/simple;
	bh=+JhIv47YGBNM/qh6+n+ZIfJoHiVGRJYpu/WIb6UoC3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6ITPwHwW4JDTEWNXD1dRaKsokubdoLpxLP1vMIww57AelJ7PlZAFMsyuzZfmhbXKJRbD8zYjz3c2EJNkDW3prLAhfHD6284bqXVZqg6oCJSIM/spQEIQvR4XiZO5c4J4tRF5MIovn6ignyRtBrMT2GGxLZy8gf4dMZH4DUrmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=KeYcb7yo; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZCV3J4vrjz3xWG;
	Wed, 12 Mar 2025 12:16:12 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZCV3J4Kf0z2Sd0R;
	Wed, 12 Mar 2025 08:16:12 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4ZCV3J30mmz3hhSW;
	Wed, 12 Mar 2025 08:16:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741781772;
	bh=+JhIv47YGBNM/qh6+n+ZIfJoHiVGRJYpu/WIb6UoC3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeYcb7yoMKJSUVon6V1Nl7i3KcmNjIN0p655tu1GCPueZfaHuYcTmHczIdWjlNlGo
	 CzFCifYwHv1hdCxNHx1lG0KSRVv/ywTSBDy0yMosRuYWd2njwKwzGiJeLp98F5ZaM0
	 cjlXbOlaul8cyphuBW93REyIUHnery17rJaZGf65jkak0Yh+JKuxvBoes++UECsYxs
	 QuGPA88QoqIXBEK0FSPEgIpD1KnasEynnqquThZmpsfDimPQp5JtJ1i1vwT+XfSm9V
	 n3uqr3QTdN8Gu+wA6dej1uuxi3vwQo0jsjcSkPe5zAM+wm93+5eZi1l7JiS0QDlHEH
	 vgl5efv+tomuA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Wed, 12 Mar 2025 08:15:59 -0400 (EDT)
Date: Wed, 12 Mar 2025 08:16:00 -0400
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	bpellegrino@arka.org
Subject: Re: [PATCH v6 6/6] iio: filter: admv8818: Support frequencies >= 2^32
Message-ID: <Z9F7AJTCtFRIPHpw@65YTFL3.secure.tethers.com>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
 <20250307150216.374643-6-sam.winchenbach@framepointer.org>
 <20250308140143.411caf7b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308140143.411caf7b@jic23-huawei>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sat, Mar 08, 2025 at 02:01:43PM +0000, Jonathan Cameron wrote:
> On Fri,  7 Mar 2025 10:02:16 -0500
> Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> 
> > From: Brian Pellegrino <bpellegrino@arka.org>
> > 
> > This patch allows writing u64 values to the ADMV8818's high and low-pass
> > filter frequencies. It includes the following changes:
> > 
> > - Rejects negative frequencies in admv8818_write_raw.
> > - Adds a write_raw_get_fmt function to admv8818's iio_info, returning
> >   IIO_VAL_INT_64 for the high and low-pass filter 3dB frequency channels.
> > 
> > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> > Signed-off-by: Brian Pellegrino <bpellegrino@arka.org>
> > Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> I only have that minor comment on patch 5.  If nothing else comes up
> and the dt binding ack comes in I may just tidy that up whilst applying.
> 

Sounds good. If given the opportunity I would like to submit
the patchset once more; I would like to use my work email
for author and signoff, and use the framepointer address
as an envelope. If I do this, I can update patch 5 as noted.
Would that be ok?

Thanks,
-Sam

> > ---
> >  drivers/iio/filter/admv8818.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> > index e9602bfd4af7..9785533d0cdd 100644
> > --- a/drivers/iio/filter/admv8818.c
> > +++ b/drivers/iio/filter/admv8818.c
> > @@ -402,6 +402,19 @@ static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
> >  	return ret;
> >  }
> >  
> > +static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +								struct iio_chan_spec const *chan,
> > +								long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > +		return IIO_VAL_INT_64;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int admv8818_write_raw(struct iio_dev *indio_dev,
> >  			      struct iio_chan_spec const *chan,
> >  			      int val, int val2, long info)
> > @@ -410,6 +423,9 @@ static int admv8818_write_raw(struct iio_dev *indio_dev,
> >  
> >  	u64 freq = ((u64)val2 << 32 | (u32)val);
> >  
> > +	if ((s64)freq < 0)
> > +		return -EINVAL;
> > +
> >  	switch (info) {
> >  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >  		return admv8818_lpf_select(st, freq);
> > @@ -571,6 +587,7 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
> >  
> >  static const struct iio_info admv8818_info = {
> >  	.write_raw = admv8818_write_raw,
> > +	.write_raw_get_fmt = admv8818_write_raw_get_fmt,
> >  	.read_raw = admv8818_read_raw,
> >  	.debugfs_reg_access = &admv8818_reg_access,
> >  };
> 

