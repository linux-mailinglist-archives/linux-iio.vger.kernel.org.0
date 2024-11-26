Return-Path: <linux-iio+bounces-12705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE49D9DA4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110D51629B1
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322081DE2A5;
	Tue, 26 Nov 2024 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USzxeqaw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A51DA614;
	Tue, 26 Nov 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646951; cv=none; b=i0y9q4WSpLVfwKuBdoBugc5Ct0qMlsOF/u13gghdnFlCQKNlV7FR/xJ/Pc8cXsv2kvlEnFgLFQb5fMlWkOLgTh3MgctpbdB7g334DIc9vvgrBmuYNDY2zL5P/CYT0YCZvBOpCjQxFRcKppxFJWLe29El3Nrl1+nUzADMAWXKvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646951; c=relaxed/simple;
	bh=ZtPBQKk9PTIaQVnyuOg00v4/13J+GN9z4uCbr3BSDLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViQqrweU1ovQ5u4jT9ip9Yw8cYNbMkJy/S3i1EC9tg0iLmpBVb9d+41V9X6KyYSde4R171PKfZ//vxCBMqyPMghRrejCNlDnaO/QceM8BdK0/Q432qCHp/emHZFHKMtNVISeIzPpbrhkxyEkTgS9Uh3kBOHBHzKrxb4RtxO5uEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USzxeqaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F052C4CECF;
	Tue, 26 Nov 2024 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732646950;
	bh=ZtPBQKk9PTIaQVnyuOg00v4/13J+GN9z4uCbr3BSDLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USzxeqawwweQQpD6/JeQidpKFv1Ak3/4gfblR6RxC4U+bNzehg9+w25aYHO3e++3o
	 WubSQSAjyeHDqSYkOT6kWOgAkzNa4sssSiADArS/1Kj5wRce8sg62iv/WnsAR/ACAa
	 iVBmyuivVGoyytlIC6YUSOU3Vp3uSr9CvF8Y/RKkyYUWrfCv0hH0NfxSZZWCDWxlHe
	 qvh7RCOJdQKprj/mUzIR08OC1UbzrBbg8j1uvswKJai03gknl1vBtOOtlj1W/jdwG2
	 wk0PZODUd6Xyjof7OIObFBrHuESDlkixWCmdCgZd7jF+CePA8zFS9CwToQ5DLlR0SK
	 Hs/ya/BAtEilA==
Date: Tue, 26 Nov 2024 18:48:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 9/9] iio: adc: ad7606: Add support for writing registers
 when using backend
Message-ID: <20241126184851.5d28793e@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-9-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-9-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:31 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Adds the logic for effectively enabling the software mode for the
> iio-backend, i.e enabling the software mode channel configuration and
> implementing the register writing functions.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

A few comments inline, but basically looks fine to me.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index a25182a3daa7..0c1177f436f3 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c

>  static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -70,7 +83,7 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_backend_enable(dev, st->back);
> +	ret = devm_iio_backend_enable(st->dev, st->back);

Is that a different dev? That's not obvious...

>  	if (ret)
>  		return ret;
>  
> @@ -86,9 +99,52 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
>  	return 0;
>  }
>  
> +static int ad7606_bi_reg_read(struct iio_dev *indio_dev, unsigned int addr)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		ret = pdata->bus_reg_read(st->back,
> +					addr,
> +					&val);

As below.

> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	return val;
> +}
> +
> +static int ad7606_bi_reg_write(struct iio_dev *indio_dev,
> +			       unsigned int addr,
> +			       unsigned int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {

Given David's if_not_cond_guard() should land shortly I'd prefer
to use that going forwards for cases like this.

> +	ret = pdata->bus_reg_write(st->back,
> +					addr,
> +					val);
Put parameters all on one line.
+ return here (which needs the new if_not_cond_guard() to avoid
confusing the compiler).

> +	}
> +	return ret;
> +}

