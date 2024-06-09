Return-Path: <linux-iio+bounces-6097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF2901575
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DA6281234
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DB1CFAF;
	Sun,  9 Jun 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7X6hI+e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB85E57D;
	Sun,  9 Jun 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717927586; cv=none; b=uo1lJ8nqcqMqHfL+2mzSpUuSpc12ldxp+Dm3Ilgm/NbNGsQ1/MgK7p9uymYntwid8lZPpERwMfApYt3ifzb16JCK2ICBy/Gz9c9+mGvEMUr9DcVTWZ2jmbLicOc47COJhbLbaOrQSgc+QpL9+DobryUJwTmJc5Tu+T9mZ0iDy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717927586; c=relaxed/simple;
	bh=9L8bzw15Z46JWpcMuG3nSdT2H5VUywWmWmUxC82X2OM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C31SCm8Nk88RVABM0lFJVnVNC9vthj1rmpVvGxV2khUpmQr+S+FnXITCbpTWDlpbjG2cs7hnzgDQcHAqXJuYqxVkf8GDKC5vlft+sPku/HGlrG3WTXOZ8NHwAX8pjHSX1tMoVJbSwcmDgL6Te0SHVfooMtZwaro6YeuEpH9X6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7X6hI+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29598C2BD10;
	Sun,  9 Jun 2024 10:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717927586;
	bh=9L8bzw15Z46JWpcMuG3nSdT2H5VUywWmWmUxC82X2OM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p7X6hI+efA2wwfAGaBdb/JQXE9B/bKimn7bPUNYkQAZYIgvywBu+hzmYXpGjLNCfR
	 Fqt8rkwtHI3XLrYkFatBQTrixGpazw9ToRUjTfTjPqTyQXtSoCBsk9ThXc7MKijO05
	 ap0M1prqmXrEQTLLwUmM3GLDgHjISpq1jh03c3+Mslk9XuWLo3ki8/Ytjq95vLrMWR
	 WFDD++ujX6zQ/XmNlU6Dus3suDmozFrdVR2cl+3W/dr1hJTG+Us7+u9BMZ0MWVZRf9
	 /Ejocf/Mq1bBToF+7teK7g3w5d7x1+lKFsHZAG5CQeT8SJ53oUWQucArmp2K+YMr3o
	 SbX//z1UBaeIw==
Date: Sun, 9 Jun 2024 11:05:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>, Li peiyu <579lpy@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: humidity: hdc3020: fix hysteresis
 representation
Message-ID: <20240609110558.0fd08074@jic23-huawei>
In-Reply-To: <6481f8ab-5082-4952-a29c-075a57239472@gmail.com>
References: <20240605192136.38146-1-dima.fedrau@gmail.com>
	<6481f8ab-5082-4952-a29c-075a57239472@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 16:34:39 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 05/06/2024 21:21, Dimitri Fedrau wrote:
> > According to the ABI docs hysteresis values are represented as offsets to
> > threshold values. Current implementation represents hysteresis values as
> > absolute values which is wrong. Nevertheless the device stores them as
> > absolute values and the datasheet refers to them as clear thresholds. Fix
> > the reading and writing of hysteresis values by including thresholds into
> > calculations. Hysteresis values that result in threshold clear values
> > that are out of limits will be truncated.
> > 
> > To check that the threshold clear values are correct, registers are read
> > out using i2ctransfer and the corresponding temperature and relative
> > humidity thresholds are calculated using the formulas in the datasheet.
> > 
> > Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> > 
> > Changes in V3:
> >   - Add missing changes
> >   - Remove math.h, already included in math64.h
> >   - Drop range comments
> >   - Fix typo devide divide
> >   - Add empty line before return in hdc3020_write_thresh
> >   - Keep hysteresis value when changing the threshold
> > 
> > ---
> >  drivers/iio/humidity/hdc3020.c | 325 +++++++++++++++++++++++++--------
> >  1 file changed, 249 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> > index cdc4789213ba..cf00999b826d 100644
> > --- a/drivers/iio/humidity/hdc3020.c
> > +++ b/drivers/iio/humidity/hdc3020.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/math64.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/pm.h>
> > @@ -66,8 +67,10 @@
> >  
> >  #define HDC3020_CRC8_POLYNOMIAL		0x31
> >  
> > -#define HDC3020_MIN_TEMP		-40
> > -#define HDC3020_MAX_TEMP		125
> > +#define HDC3020_MIN_TEMP_MICRO		-39872968
> > +#define HDC3020_MAX_TEMP_MICRO		124875639
> > +#define HDC3020_MAX_TEMP_HYST_MICRO	164748607
> > +#define HDC3020_MAX_HUM_MICRO		99220264
> >  
> >  struct hdc3020_data {
> >  	struct i2c_client *client;
> > @@ -368,6 +371,105 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >    
> 
> Nit: "thresh" instead of "tresh" (applies to several lines of your patch).
I fixed that up whilst applying.
> 
> > +static int hdc3020_tresh_get_temp(u16 thresh)
> > +{
> > +	int temp;
> > +
> > +	/*  
> 
> 
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan



