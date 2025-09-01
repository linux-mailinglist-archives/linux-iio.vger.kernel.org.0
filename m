Return-Path: <linux-iio+bounces-23559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA9B3D982
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 08:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC26E16EA1D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 06:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4724418E;
	Mon,  1 Sep 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhwBYEG7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DA23E25B;
	Mon,  1 Sep 2025 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706887; cv=none; b=UDW1a4YUCSS+0g/ZK3C8d2kepsngCB+bRmNPNfgyL2GRdHQTpsddEpwZfikB+B440DEgO5MeEfNTZfxidsJ5r9D3KWtJYwKTSCAfexxD9uSkz2cZili2GYAvzdHBvOwZWEtRQJogCcdGlEYFPmCxaTwxKQt/7XNbXOpiXYZJAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706887; c=relaxed/simple;
	bh=dzIS5KQ4sPo2lK7s10+eDwEJp7PENpB3PEARRrzqWiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRtp8IagTRmEr1IVIo2aTe+y06h6hl+03vhpVOyeS68YSMcuIbTDWphAlapx/GNOLPcL+LgR1Ock1gmiKem+YYZSPSp/z2///+m6ucZHU+QHYkT/gG3E/VPHWzbWU2TLlYZz8HZlmp8qdxb2JmVd8qg4w+FeIGF0JCF/fqwqNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LhwBYEG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE123C4CEF5;
	Mon,  1 Sep 2025 06:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756706886;
	bh=dzIS5KQ4sPo2lK7s10+eDwEJp7PENpB3PEARRrzqWiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhwBYEG7qkvhhdtMVHJCIbfscHl22xUCQ5lUih/UYYZ+7HQs7eXIGHEMz6/rK3qHC
	 +dnDiBl94G3Ot/ie5X1YnWyuEWa/kPsbMrK36AtyTC0Goq3An5etzWfxgUdxZsrD3L
	 D3NBzoIAXKryQi8J6ssZBfkB3CVc99TFt2zcbuUI=
Date: Mon, 1 Sep 2025 08:08:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 5/5] iio: imu: icm20948: add runtime power management
 support
Message-ID: <2025090154-whiny-output-3f73@gregkh>
References: <20250831-icm20948-v1-5-1fe560a38de4@gmail.com>
 <33ca2805-aa52-4b27-9fa9-ec582b7129f2@web.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33ca2805-aa52-4b27-9fa9-ec582b7129f2@web.de>

On Sun, Aug 31, 2025 at 09:23:08PM +0200, Markus Elfring wrote:
> …
> > @@ -24,17 +24,24 @@ static const struct iio_chan_spec
> >  static int inv_icm20948_temp_read_sensor(struct inv_icm20948_state *state,
> >  					 s16 *temp)
> >  {
> > -	guard(mutex)(&state->lock);
> > +	int ret;
> > +
> > +	pm_runtime_get_sync(state->dev);
> > +	mutex_lock(&state->lock);
> >  
> >  	__be16 raw;
> > -	int ret = regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
> > +	ret = regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
> >  				   &raw, sizeof(raw));
> >  	if (ret)
> > -		return ret;
> > +		goto out;
> >  
> >  	*temp = __be16_to_cpu(raw);
> > +	ret = 0;
> >  
> > -	return 0;
> > +out:
> > +	mutex_unlock(&state->lock);
> > +	pm_runtime_put_autosuspend(state->dev);
> > +	return ret;
> >  }
> …
> 
> Does anything hinder you with the continued application of scope-based resource management
> for such a function implementation?
> 
> Regards,
> Markus
> 



Hi,

This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
You have sent him a patch that has triggered this response.

Right now, the development tree you have sent a patch for is "closed"
due to the timing of the merge window.  Don't worry, the patch(es) you
have sent are not lost, and will be looked at after the merge window is
over (after the -rc1 kernel is released by Linus).

So thank you for your patience and your patches will be reviewed at this
later time, you do not have to do anything further, this is just a short
note to let you know the patch status and so you don't worry they didn't
make it through.

thanks,

greg k-h's patch email bot

