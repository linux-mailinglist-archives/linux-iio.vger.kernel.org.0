Return-Path: <linux-iio+bounces-16908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B02A635E1
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 14:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A304188BC6A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC11A841E;
	Sun, 16 Mar 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="c3+yTtTK"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33A376;
	Sun, 16 Mar 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133261; cv=none; b=IEf4M0XUqwfxLyh/Wdfa2Ul4jmQin0Kz1VlS8bRBA3QWT/8JwvrMvNL+TksWluqN+upRXaNo1kMR/bcmzEQQywXySrPxs+fNleiPQCtqWieQd3moUMnHMRowAc+FH+m6GMhqioivMzu5qQRVbVDN5azVq60Urp819kOwVIvLZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133261; c=relaxed/simple;
	bh=ESd/AoK6IxfrxRmXgmj5yUxI0i1g9ZACh/0U+1cLQ7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTo0IMo37f9B072qqnfCNccA3GdxPLt/ZOORJA/9uzyZy29Uuw2WJfDFRNu+LYC+wVfaraXR2G3VFW36y3vNJ/rQc7sag/uKzkU4DN+QspKuIX7p0/5ket2hKQ6GnRaUQlV6l6V3bhwh7qxd2MLMYd+B6bQCIjM5K3Tc6f+/U2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=c3+yTtTK; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZG02f2Rz6z9sSZ;
	Sun, 16 Mar 2025 13:54:18 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZG02f1ljkz2Sd0R;
	Sun, 16 Mar 2025 09:54:18 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4ZG02f0LgLz3hhSF;
	Sun, 16 Mar 2025 09:54:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742133258;
	bh=ESd/AoK6IxfrxRmXgmj5yUxI0i1g9ZACh/0U+1cLQ7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3+yTtTKUmCOYxcwaUPeOyyVioPvOzGoQT7SiPKxsJ3UkR77RO9/W3eAAmxqj+4+m
	 mocgAYcC4KBfcIN900xtVxIyNjjY7IqJzxJyC3Lq17w2zwySzcvIZ5dY6pqXFgotMN
	 +2UDqsukZcCUIE/LIdt2zr0WcalgOCV8ugAWJfJS7Hb1Y74qDrmffsoOvChzEKRBdb
	 s6IenLiU0CT4f5kTcUlIS50eUkQY2flAUw4Z21lGTCdHcf0Ye2znNhfxIh+gOgj6bu
	 bQxlbsBwfLhKthDy6g5sK2WOzgcWt8uX2KOaOes0lerHinbpxjWO024UPUTDLMO3Dc
	 R9DscU8nsSC5w==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sun, 16 Mar 2025 09:54:05 -0400 (EDT)
Date: Sun, 16 Mar 2025 09:54:07 -0400
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	bpellegrino@arka.org
Subject: Re: [PATCH v6 6/6] iio: filter: admv8818: Support frequencies >= 2^32
Message-ID: <Z9bX_7pAxcwzpHv6@65YTFL3.secure.tethers.com>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
 <20250307150216.374643-6-sam.winchenbach@framepointer.org>
 <20250308140143.411caf7b@jic23-huawei>
 <Z9F7AJTCtFRIPHpw@65YTFL3.secure.tethers.com>
 <20250315182605.4b0dd8b3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315182605.4b0dd8b3@jic23-huawei>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sat, Mar 15, 2025 at 06:26:05PM +0000, Jonathan Cameron wrote:
> On Wed, 12 Mar 2025 08:16:00 -0400
> Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> 
> > On Sat, Mar 08, 2025 at 02:01:43PM +0000, Jonathan Cameron wrote:
> > > On Fri,  7 Mar 2025 10:02:16 -0500
> > > Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> > >   
> > > > From: Brian Pellegrino <bpellegrino@arka.org>
> > > > 
> > > > This patch allows writing u64 values to the ADMV8818's high and low-pass
> > > > filter frequencies. It includes the following changes:
> > > > 
> > > > - Rejects negative frequencies in admv8818_write_raw.
> > > > - Adds a write_raw_get_fmt function to admv8818's iio_info, returning
> > > >   IIO_VAL_INT_64 for the high and low-pass filter 3dB frequency channels.
> > > > 
> > > > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> > > > Signed-off-by: Brian Pellegrino <bpellegrino@arka.org>
> > > > Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>  
> > > I only have that minor comment on patch 5.  If nothing else comes up
> > > and the dt binding ack comes in I may just tidy that up whilst applying.
> > >   
> > 
> > Sounds good. If given the opportunity I would like to submit
> > the patchset once more; I would like to use my work email
> > for author and signoff, and use the framepointer address
> > as an envelope. If I do this, I can update patch 5 as noted.
> > Would that be ok?
> > 
> Absolutely. That's fine.
> 

Done, patch v7 is up.

The only changes are:
 * "driver core:" -> "iio: core:"
 * "sam.winchenach@framepointer.org" -> "swinchenbach@arka.org"

Thanks,
-Sam

> > Thanks,
> > -Sam
> > 
> > > > ---
> > > >  drivers/iio/filter/admv8818.c | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > > 
> > > > diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> > > > index e9602bfd4af7..9785533d0cdd 100644
> > > > --- a/drivers/iio/filter/admv8818.c
> > > > +++ b/drivers/iio/filter/admv8818.c
> > > > @@ -402,6 +402,19 @@ static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
> > > > +								struct iio_chan_spec const *chan,
> > > > +								long mask)
> > > > +{
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > > +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > > > +		return IIO_VAL_INT_64;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > >  static int admv8818_write_raw(struct iio_dev *indio_dev,
> > > >  			      struct iio_chan_spec const *chan,
> > > >  			      int val, int val2, long info)
> > > > @@ -410,6 +423,9 @@ static int admv8818_write_raw(struct iio_dev *indio_dev,
> > > >  
> > > >  	u64 freq = ((u64)val2 << 32 | (u32)val);
> > > >  
> > > > +	if ((s64)freq < 0)
> > > > +		return -EINVAL;
> > > > +
> > > >  	switch (info) {
> > > >  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > >  		return admv8818_lpf_select(st, freq);
> > > > @@ -571,6 +587,7 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
> > > >  
> > > >  static const struct iio_info admv8818_info = {
> > > >  	.write_raw = admv8818_write_raw,
> > > > +	.write_raw_get_fmt = admv8818_write_raw_get_fmt,
> > > >  	.read_raw = admv8818_read_raw,
> > > >  	.debugfs_reg_access = &admv8818_reg_access,
> > > >  };  
> > >   
> 

