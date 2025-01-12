Return-Path: <linux-iio+bounces-14172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17FA0A8C3
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18ACD3A14CF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECF1AA1C0;
	Sun, 12 Jan 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUlwQpIz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B782556E;
	Sun, 12 Jan 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682602; cv=none; b=Nf1NsuErsvs05jYuC7CseE362EUgLJ2TUF3riO1Vn4vvt57FE49TY/38c723xPDLltVKevjQBVstbq+BWJXy1/f6lDzfHXn2fbXMCja2vOaRrR/JIynoRByPNcE1NDjMqElPs2fNrOL6W32KJxEXnOtR2Tyj/Nal28XGxLpo6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682602; c=relaxed/simple;
	bh=qW3SN0+8yu+eXss+WGDpMJlVctQrS6BdMLs5e+xEHKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApCblg7PQw/C3ITvA7ej9uufGt8wk1N65hnyPBFa1htNiSR5hf0iX46uKY58fNh6uh6jZi1YTpVb3Y/tmXgIwkeEvXoeQg66Xbj7doLHH4XH/ZL6E1Wqb64/bLs9Exw1k4m7Meo6PcS0YZRjig9jI3MfUZfoQRxpUWmQ8jDHLz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUlwQpIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA57C4CEDF;
	Sun, 12 Jan 2025 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736682601;
	bh=qW3SN0+8yu+eXss+WGDpMJlVctQrS6BdMLs5e+xEHKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hUlwQpIza41YKQB/W414lpZbHUthjJu95kX2mSjytLKungnxmB8tYse2piGA5wnIA
	 JJnT0iAWSmN28cMZstfI5uEI0s9d3xKvpyS0gTrAqKdav1a5DFSGeMkhrrDzI2DuOV
	 f6a0ODINP6IeCB3UqjN3TWZCUlINU5IK08k1kyZll1vqWCuOeeEWyXqp/5tZTIjJuF
	 H6SGs94R9F1mBavTL3ohVxW18dhNu6KwixwHSI1WBA9vHVTvckxpXBFwFU1Ze+dZaE
	 asC+tF0Cu51RRzLpN4ry6iG5fPzMJSmgESyRs4bb1hi/z/CvPPddhtaPUisnQfh9B/
	 MrBvUkrfrd/0g==
Date: Sun, 12 Jan 2025 11:49:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: adc: ad7380: add alert support
Message-ID: <20250112114953.60e9991f@jic23-huawei>
In-Reply-To: <f53c6f9d-f17c-45fb-b8dd-b4eb8ef7a15a@baylibre.com>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
	<20250108-ad7380-add-alert-support-v4-4-1751802471ba@baylibre.com>
	<f53c6f9d-f17c-45fb-b8dd-b4eb8ef7a15a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 09:17:32 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/8/25 6:49 AM, Julien Stephan wrote:
> > The alert functionality is an out of range indicator and can be used as
> > an early indicator of an out of bounds conversion result.
> >   
> 
> ...
> 
> > +static int ad7380_get_alert_th(struct ad7380_state *st,
> > +			       enum iio_event_direction dir,
> > +			       int *val)
> > +{
> > +	int ret, tmp;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		ret = regmap_read(st->regmap,
> > +				  AD7380_REG_ADDR_ALERT_HIGH_TH,
> > +				  &tmp);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_EV_DIR_FALLING:
> > +		ret = regmap_read(st->regmap,
> > +				  AD7380_REG_ADDR_ALERT_LOW_TH,
> > +				  &tmp);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;  
> 
> We can just return directly in each case instead of using break (preferred
> style in IIO).
> 
> > +}
> > +  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

I tweaked it whilst applying.

