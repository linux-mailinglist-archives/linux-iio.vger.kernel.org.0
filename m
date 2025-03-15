Return-Path: <linux-iio+bounces-16873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7AFA63182
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98987AADCF
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98D205AA8;
	Sat, 15 Mar 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol+8l6tt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6D20550D;
	Sat, 15 Mar 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063176; cv=none; b=rRvzLeXRvHZ/DOH6B/2f9FW9iDifltZL9Pj8T7IZ93/vnPYaxDnvX9IDI3KrNSv12XpGp3EBM0L79PVsXpJDr+6UYD5jk88vM3RTWja1PcchggcQmUxv2yb7O+rk+1fDezFSRJ3ygu3hLw4e3toGOMxDxUoDVJD8EMhlUcHPkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063176; c=relaxed/simple;
	bh=I/4a0rJw9tA+KgKCuIujMstbndmP7r6YI1u1x8qbr/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMzgFFv+OAOOgTNvpsqmDw3yXZJ+KlJ94+wdqtYVqUa8tinsz632x3lkRJjJS1/ZLKiGNBu4Dse3OkoWga8kH71I18v2LV/8AtTYxviqSG9CE8HWG9JRY8XIqXN8GDgZZDbkeDtPSh1FWPcVRdk4aKJMGn3xqoar8GUZOfZNlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol+8l6tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D07C4CEE5;
	Sat, 15 Mar 2025 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063175;
	bh=I/4a0rJw9tA+KgKCuIujMstbndmP7r6YI1u1x8qbr/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ol+8l6ttjd483XvLnbhHKcqhsfNKqupX31kB2ckWRaU1piS/oacxaxYQYyEI0q0Gz
	 e0ylj+kGaS9d3DTWq+AbOcJ8qHGisYRV5H4F0wdK3BSZX35lMRWXD5rkS6OZXlPlDO
	 HCWrMfJplbHbRpmpXSOJqQEth4SQHxltA3iBlbLCjLk2upt0tlY/jGPhL+AD+Vg6lF
	 cubUNqX2O1he+Z9pg53fcOj39WrSCqNFdTB3f7FrmDyCcxBXwdV9cW2Qed0s8p0PHp
	 IwC0aXwrfIpNNbJwo45QaaObq43aOz2wHNhKnjyXdITPXP9HFltPfFbcEda/QXGUws
	 a+Fz8lxJH7Xlw==
Date: Sat, 15 Mar 2025 18:26:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, bpellegrino@arka.org
Subject: Re: [PATCH v6 6/6] iio: filter: admv8818: Support frequencies >=
 2^32
Message-ID: <20250315182605.4b0dd8b3@jic23-huawei>
In-Reply-To: <Z9F7AJTCtFRIPHpw@65YTFL3.secure.tethers.com>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
	<20250307150216.374643-6-sam.winchenbach@framepointer.org>
	<20250308140143.411caf7b@jic23-huawei>
	<Z9F7AJTCtFRIPHpw@65YTFL3.secure.tethers.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 08:16:00 -0400
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> On Sat, Mar 08, 2025 at 02:01:43PM +0000, Jonathan Cameron wrote:
> > On Fri,  7 Mar 2025 10:02:16 -0500
> > Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> >   
> > > From: Brian Pellegrino <bpellegrino@arka.org>
> > > 
> > > This patch allows writing u64 values to the ADMV8818's high and low-pass
> > > filter frequencies. It includes the following changes:
> > > 
> > > - Rejects negative frequencies in admv8818_write_raw.
> > > - Adds a write_raw_get_fmt function to admv8818's iio_info, returning
> > >   IIO_VAL_INT_64 for the high and low-pass filter 3dB frequency channels.
> > > 
> > > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> > > Signed-off-by: Brian Pellegrino <bpellegrino@arka.org>
> > > Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>  
> > I only have that minor comment on patch 5.  If nothing else comes up
> > and the dt binding ack comes in I may just tidy that up whilst applying.
> >   
> 
> Sounds good. If given the opportunity I would like to submit
> the patchset once more; I would like to use my work email
> for author and signoff, and use the framepointer address
> as an envelope. If I do this, I can update patch 5 as noted.
> Would that be ok?
> 
Absolutely. That's fine.

> Thanks,
> -Sam
> 
> > > ---
> > >  drivers/iio/filter/admv8818.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> > > index e9602bfd4af7..9785533d0cdd 100644
> > > --- a/drivers/iio/filter/admv8818.c
> > > +++ b/drivers/iio/filter/admv8818.c
> > > @@ -402,6 +402,19 @@ static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
> > >  	return ret;
> > >  }
> > >  
> > > +static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
> > > +								struct iio_chan_spec const *chan,
> > > +								long mask)
> > > +{
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > > +		return IIO_VAL_INT_64;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > >  static int admv8818_write_raw(struct iio_dev *indio_dev,
> > >  			      struct iio_chan_spec const *chan,
> > >  			      int val, int val2, long info)
> > > @@ -410,6 +423,9 @@ static int admv8818_write_raw(struct iio_dev *indio_dev,
> > >  
> > >  	u64 freq = ((u64)val2 << 32 | (u32)val);
> > >  
> > > +	if ((s64)freq < 0)
> > > +		return -EINVAL;
> > > +
> > >  	switch (info) {
> > >  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > >  		return admv8818_lpf_select(st, freq);
> > > @@ -571,6 +587,7 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
> > >  
> > >  static const struct iio_info admv8818_info = {
> > >  	.write_raw = admv8818_write_raw,
> > > +	.write_raw_get_fmt = admv8818_write_raw_get_fmt,
> > >  	.read_raw = admv8818_read_raw,
> > >  	.debugfs_reg_access = &admv8818_reg_access,
> > >  };  
> >   


