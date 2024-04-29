Return-Path: <linux-iio+bounces-4611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EC8B4FA3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 05:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD59C1C20979
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4079F5;
	Mon, 29 Apr 2024 03:02:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30E9449
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714359738; cv=none; b=ZqXrqEOJPXaMRw5vT4FRoULr6oYfJH4mwsTBTwRDUNn3KVvf9sEpNfWq8amwhQ2syUryWzFPDejbK4g6HHd+4psy7pdC8vK1EpuTiW1ThoaA2i4HuzLT3G+4rwpV/NRzrXCOgEKMbTTZy4hsoZkN38gonUZh0/sSj7ff5CBNDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714359738; c=relaxed/simple;
	bh=B7IThttYaS9IXAMjaJ7OLdmRcg7HOpGLUcEiXESSmtE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWOJMWD3yTIZRzYxCUsFXboKkKcqlbLL4VwJs4D87l/5pao8UzPf6fTjF00QU5bgrKoZ7Uq39ZFX2RMgvMzSsvecLuboRCxgZoQ6O0VUhdBgac3QeRSJHw3pz4o21k/dP4q87ES7A2d1N1TKg7xZKYM59phNZcJuuLBSsK7livg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
Received: By OpenMail Mailer;Mon, 29 Apr 2024 11:02:13 +0800 (CST)
X-MGFlag: HAM
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367367:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 29 Apr 2024 09:52:38 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 09:52:38 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 09:52:37 +0800
Date: Mon, 29 Apr 2024 09:52:37 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Gabriel Schwartz <gschwartz@usp.br>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: rtq6056: Use automated cleanup for mode
 handling in write_raw
Message-ID: <340CF1714359733000.cy_huang@richtek.com>
X-MG-ORIG-MSGID: <20240429015237.GA24882@linuxcarl2.richtek.com>
References: <20240426200118.20900-1-gschwartz@usp.br>
 <20240428125129.1605a09d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240428125129.1605a09d@jic23-huawei>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Apr 28, 2024 at 12:51:29PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Apr 2024 17:01:14 -0300
> Gabriel Schwartz <gschwartz@usp.br> wrote:
> 
> > Using iio_device_claim_direct_scoped() to automate mode claim and release
> > simplifies code flow and allows for straight-forward error handling with
> > direct returns on errors.
> > 
> > Signed-off-by: Gabriel Schwartz <gschwartz@usp.br>
Hi,

Patch looks good. Thanks.

Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>

> +CC driver author.  This is a fairly recent driver, so like they are still
> around.
> 
> Patch looks good so I'll apply it but if ChiYuan Huang gives a review that would
> be great.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/adc/rtq6056.c | 34 +++++++++++-----------------------
> >  1 file changed, 11 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
> > index a5464737e..bcb129840 100644
> > --- a/drivers/iio/adc/rtq6056.c
> > +++ b/drivers/iio/adc/rtq6056.c
> > @@ -520,32 +520,20 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> >  {
> >  	struct rtq6056_priv *priv = iio_priv(indio_dev);
> >  	const struct richtek_dev_data *devdata = priv->devdata;
> > -	int ret;
> >  
> > -	ret = iio_device_claim_direct_mode(indio_dev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	switch (mask) {
> > -	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		if (devdata->fixed_samp_freq) {
> > -			ret = -EINVAL;
> > -			break;
> > +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +		switch (mask) {
> > +		case IIO_CHAN_INFO_SAMP_FREQ:
> > +			if (devdata->fixed_samp_freq)
> > +				return -EINVAL;
> > +			return rtq6056_adc_set_samp_freq(priv, chan, val);
> > +		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +			return devdata->set_average(priv, val);
> > +		default:
> > +			return -EINVAL;
> >  		}
> > -
> > -		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
> > -		break;
> > -	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > -		ret = devdata->set_average(priv, val);
> > -		break;
> > -	default:
> > -		ret = -EINVAL;
> > -		break;
> >  	}
> > -
> > -	iio_device_release_direct_mode(indio_dev);
> > -
> > -	return ret;
> > +	unreachable();
> >  }
> >  
> >  static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
> 

