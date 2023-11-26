Return-Path: <linux-iio+bounces-406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DA7F94BD
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 19:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66DA281083
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D623EAD6;
	Sun, 26 Nov 2023 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0hGpUYP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021793D7C
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 18:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84472C433C7;
	Sun, 26 Nov 2023 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701021763;
	bh=GrzOSbw6X34tTV7cToVm3nPcglrShd1HMJtSVI8K+7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a0hGpUYPpa3B4+9XVnw0i72bIpFlF7C52SHu7BHrG9CmZpv2FiAVWPfcfLbx+xcar
	 Q+AMk3MrOE/HeOIWefDvukX5H7WW1EFHpGL8fk9Ejiw3WmhY6sGD4t5dNjj9qZ8JYk
	 8NsSOv/+TiN1lvxSxLAg9BBOrzOiMIa88Bo60yoKBtrl1uDtcu8SOx/B+pfIiX7hll
	 VoXnk3Uyek/3Hm/g6jQaH2FD0WUzRalEsu7vS6NxTM5UUPaUr3OtzPKfKtvVEOmJ/C
	 OIiTNB19VdOv7UPSsuEEEROi7tXct4y6FrrRmSTQrstaf0x7viZRBPMRGk2/83r/a8
	 wGIjrNB70/alA==
Date: Sun, 26 Nov 2023 18:02:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] iio: light: ltrf216a: Return floating point values
Message-ID: <20231126180236.4af26387@jic23-huawei>
In-Reply-To: <06d3c2f7-50b4-b44d-fa75-8ca6a1a26d89@collabora.com>
References: <20231107192005.285534-1-shreeya.patel@collabora.com>
	<06d3c2f7-50b4-b44d-fa75-8ca6a1a26d89@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 01:05:41 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> On 08/11/23 00:50, Shreeya Patel wrote:
> > For better precision of input light intesity, return floating point
> > values through sysfs instead of an integer value  
> 
> Hi Jonathan,
> 
> Gentle ping for this patch. I am not sure if you got time to look at the 
> patches
> after LPC but just making sure it doesn't get lost between bunch of 
> others :)
Hi Shreeya,

Getting there on catching up - for some reason this one didn't reach my inbox, but thankfully
patchwork had it.

Anyhow, applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> 
> 
> Thanks,
> Shreeya Patel
> 
> >
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > ---
> >   drivers/iio/light/ltrf216a.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> > index 8de4dd849936..68dc48420a88 100644
> > --- a/drivers/iio/light/ltrf216a.c
> > +++ b/drivers/iio/light/ltrf216a.c
> > @@ -234,7 +234,7 @@ static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
> >   static int ltrf216a_get_lux(struct ltrf216a_data *data)
> >   {
> >   	int ret, greendata;
> > -	u64 lux, div;
> > +	u64 lux;
> >   
> >   	ret = ltrf216a_set_power_state(data, true);
> >   	if (ret)
> > @@ -246,10 +246,9 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
> >   
> >   	ltrf216a_set_power_state(data, false);
> >   
> > -	lux = greendata * 45 * LTRF216A_WIN_FAC * 100;
> > -	div = data->als_gain_fac * data->int_time_fac * 100;
> > +	lux = greendata * 45 * LTRF216A_WIN_FAC;
> >   
> > -	return div_u64(lux, div);
> > +	return lux;
> >   }
> >   
> >   static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> > @@ -279,7 +278,8 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> >   		if (ret < 0)
> >   			return ret;
> >   		*val = ret;
> > -		return IIO_VAL_INT;
> > +		*val2 = data->als_gain_fac * data->int_time_fac;
> > +		return IIO_VAL_FRACTIONAL;
> >   	case IIO_CHAN_INFO_INT_TIME:
> >   		mutex_lock(&data->lock);
> >   		ret = ltrf216a_get_int_time(data, val, val2);  
> 


