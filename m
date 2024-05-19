Return-Path: <linux-iio+bounces-5130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216DA8C95F7
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15831F21274
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816E6EB75;
	Sun, 19 May 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AES6ZGlv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C06E605;
	Sun, 19 May 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145040; cv=none; b=WVprURTffcKHkqhaQdv7uBlCbMHscsM7MnVaO5EKz7SzgKJNoC1uASSp30oUiYgHaHZCwWHjISIjauWrHP4YIO8y7i/e6zKJUwP7KQyzWGpjq/F4zBVxRlbVPaQxbxnPBoPBRvt/iCIqnb/thFx405y7ucEP1R0sqxXWB0gSP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145040; c=relaxed/simple;
	bh=I6nVrHOGANN67dUTbH0/caRelNajskVLBV6EupgLPkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pe/OSxcKZ+eAVX54t4YjvmljvuSADMg0nkYaJRt/Aw25DiI4Fc2TqtGPHLQ3psm0o27nD9F7va/oREi2luHt+PxlPuJB854tStCBuwSqvv+3nP09+5P6hPep5ILBN7Wr8R3AlSAxfNz5c+NWwhIVTq9rQaAECVKKPFV3cBVs2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AES6ZGlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3A6C32781;
	Sun, 19 May 2024 18:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716145040;
	bh=I6nVrHOGANN67dUTbH0/caRelNajskVLBV6EupgLPkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AES6ZGlv7/z+pw7dXTJgSEYHzgam2vIdt87AygYXDbDoytoUHFq7Hu9yq/QPe7ot8
	 XgCvYyIPvuTlCeGfviULyonfmMkk/NhNWRYv4Xo2D1uuStdrGLgpwqVd61jMr8CsTp
	 v8lKTrCCvtzkqjT9Nm6e0vmDabJqm6Cm+jniX2ftSEXJ91xvAFvPpnU00VxXKRusPO
	 cudjXQZdbsuOiajfnifqGJClEWvwP12Kwa9I4+IFF0fCcjShTcmnMCxHMz7xSp89pu
	 lWSWmgo0xxPyGd/luOibJH2AxUK6fe+HUPbbu0J7RVptb1xpXjIU5iH72FuT/eSuAD
	 5sJoMgU7fyDSg==
Date: Sun, 19 May 2024 19:57:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240519195707.71163f84@jic23-huawei>
In-Reply-To: <20240517074750.87376-10-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
	<20240517074750.87376-10-ramona.bolboaca13@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 10:47:50 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Add support for ADIS1657X family devices in already exiting ADIS16475
> driver.
> 
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>

Whilst it's not necessarily vital to support, it I'm curious about
what happens to the hardware timestamp? I thought we had one driver
still doing hardware timestamps directly to the buffer, but I can't
find it so I guess we now deal with alignment in the few devices with
this support.  The st_lsm6dsx has this sort of combining of local
and fifo timestamps for example.

As it stands I think you push the same timestamp for all scans read
from the fifo on a particular watermark interrupt?  That isn't
ideal given we should definitely be able to do better than that.

> +
> +static const struct iio_dev_attr *adis16475_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
The autobuilder caught this one.  Drop the dev_attr.attr.

> +	NULL
> +};
> +

> +
> +static const struct iio_buffer_setup_ops adis16475_buffer_ops = {
> +	.postenable = adis16475_buffer_postenable,
> +	.postdisable = adis16475_buffer_postdisable,
> +};
> +
> +static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct adis16475 *st  = iio_priv(indio_dev);
> +	int ret;
> +	u16 wm_lvl;
> +
> +	adis_dev_lock(&st->adis);

As a follow up perhaps consider defining magic to use guard() for these as there are
enough users that will be simplified to make it worth the effort.	

> +
> +	val = min_t(unsigned int, val, ADIS16575_MAX_FIFO_WM);
> +
> +	wm_lvl = ADIS16575_WM_LVL(val - 1);
> +	ret = __adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16575_WM_LVL_MASK, wm_lvl);
> +	if (ret)
> +		goto unlock;
> +
> +	st->fifo_watermark = val;
> +
> +unlock:
> +	adis_dev_unlock(&st->adis);
> +	return ret;
> +}
> +




> @@ -1514,8 +1978,20 @@ static int adis16475_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> 
> -	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> -						 adis16475_trigger_handler);
> +	if (st->info->flags & ADIS16475_HAS_FIFO) {
> +		ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
> +								    adis16475_trigger_handler_with_fifo,
> +								    &adis16475_buffer_ops,
> +								    adis16475_fifo_attributes);
> +		if (ret)
> +			return ret;
blank line here.

> +		/* Update overflow behavior to always overwrite the oldest sample. */
> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> +				       ADIS16575_OVERFLOW_MASK, (u16)ADIS16575_OVERWRITE_OLDEST);
		if (ret) in here.
> +	} else {
> +		ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +							 adis16475_trigger_handler);
and if (ret) in here and drop the one that follows.

otherwise we end up with odd code pattern of handling one case in this scope and not
the other two.

> +	}

