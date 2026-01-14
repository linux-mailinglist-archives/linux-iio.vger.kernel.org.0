Return-Path: <linux-iio+bounces-27774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4643D1EDE9
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C936A302920F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741239903E;
	Wed, 14 Jan 2026 12:45:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF839903B;
	Wed, 14 Jan 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394734; cv=none; b=BRfILqHAVOub/lwE+qdbz4PREBaFbip4KWPSP+C0khz/8gcNngIzezn7iYHKMFgoePfbLM2gFxQM7W5nKrwRuNfFOAlYbofq+H1I0vtoR6GozB39JNHr//wCIICJeICTgSCqs2BMkUbL73xrpnHuEYYjhNbfq2Cc/get+cFcEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394734; c=relaxed/simple;
	bh=nty8LgT231y7IUfYwjizh9hq071dgjnd4Wk1SjzoEhg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcm8BGCOsW71YYwJN2Z0Ndbd21ZqiJ+S+RmlBQP3w8Enu5bGsmwGYLx8z/Jx9vLYhjA6LRvQzUBasUnIN4j3XxRc49t1BjarE8jUCuVEJksRQtDb1J3EYSRqVvDfEDryZBpFfJXbeSziXf4CHceH4CoHs3y+nNlm64dI7IBg0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drm6g0ZwmzJ46BG;
	Wed, 14 Jan 2026 20:45:15 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B429340563;
	Wed, 14 Jan 2026 20:45:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 12:45:29 +0000
Date: Wed, 14 Jan 2026 12:45:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Tomas Melin <tomas.melin@vaisala.com>
CC: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
	<nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, "Jonathan
 Cameron" <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, "Andy
 Shevchenko" <andy@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
Message-ID: <20260114124527.00000344@huawei.com>
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	<20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 10:45:53 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Add capability checks for operation with backends that do not support
> full set of features, but are otherwise compatible with the device.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Hi Tomas,

A few comments inline around when we should or should not return errors.

> ---
>  drivers/iio/adc/ad9467.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 9cfe66425d4e91e215cccc40e24a92c5e99e9b87..349779a049ad68b4c9f72abfc40154b4a3f2e095 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -645,6 +645,9 @@ static int ad9467_backend_testmode_on(struct ad9467_state *st,
>  	};
>  	int ret;
>  
> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return 0;

If it isn't supported then isn't any attempt to turn test_mode on an error?
I would return errors from all these calls and only decide it doesn't
matter right at the top of the call stack.

In this particular case that's either calibration mode stuff (covered by check
below) or ad9467_chan_test_mod_write()  I'd just add a top level check there
on ability to do calibration. Alternative would be to not register the debugfs
at all.  Challenge is that is a small ABI break.  Do we care?  If we had
been doing this from the start we would have just hidden the pointless
interface.
(Key is we can change userspace interfaces, as long no one notices!)

> +
>  	ret = iio_backend_data_format_set(st->back, chan, &data);
>  	if (ret)
>  		return ret;
> @@ -665,6 +668,9 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
 	};
>  	int ret;
>  
> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return 0;
> +
>  	ret = iio_backend_chan_disable(st->back, chan);
>  	if (ret)
>  		return ret;
> @@ -807,6 +813,9 @@ static int ad9467_calibrate(struct ad9467_state *st)
>  	bool invert = false, stat;
>  	int ret;
>  
> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return 0;

So this the idea of a stub calibration bothers me a little, but I think
it's more acceptable to do it for this top level call. So keep this one, but
all the others look to me like they should be returning errors.

> +
>  	/* all points invalid */
>  	bitmap_fill(st->calib_map, st->calib_map_size);
>  
> @@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *spi)
>  		return ret;
>  
>  	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
> -	if (ret)
> +	if (ret && ret != -EOPNOTSUPP)

I don't see any modification of devm_iio_backend_request_buffer() in this
set so why why is it now acceptable to return not supported?
Given the capabilities stuff added, should this not be another capability
we check before trying to request the buffer?

>  		return ret;
>  
>  	ret = devm_iio_backend_enable(&spi->dev, st->back);
> 


