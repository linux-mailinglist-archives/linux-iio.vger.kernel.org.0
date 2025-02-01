Return-Path: <linux-iio+bounces-14815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0AA24957
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 14:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E758B1639B4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9F1ADC99;
	Sat,  1 Feb 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+LJk11N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9E1885AD;
	Sat,  1 Feb 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738415696; cv=none; b=HI8db5GE+1eTEEp2sWGjhDU1BOpHcuZCgfVJ/MqXCkOyehFBUdhquh+MbzW2kGiFmzg0EmLU1Q+8hwHqGtF/81U7i3elQ6FB2x2K9wf0qWdJKf1H7vCRPKKkMZYemDTscKUr5Yserwl7xrtUJirGh+qCsUcNYZAUa1To5x6vXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738415696; c=relaxed/simple;
	bh=Cn2nZHnSTH+FBfATcC78w8zbQW6SSI1lGefI8uphhok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGUnBSYyzw51ZyOrHliSuXs59MfTX6SsWLHLkiMCykczkbLWQ8CT71mNUQZwsfOTSzZkH0iUfOAGmBbHWxRSjqqaClI4kgTcOjLTbDQ4IcnFnrct7MY3Shg8VWpWcAHugwSMJmq9Mhd5pcF950EZo/7ZPjZdGOz762xsPOY+Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+LJk11N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D1C4CED3;
	Sat,  1 Feb 2025 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738415696;
	bh=Cn2nZHnSTH+FBfATcC78w8zbQW6SSI1lGefI8uphhok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+LJk11NQmPW5dxhdcfXbVeM4/0Kb8UrBF3QM7acTl9KoXifxqNmiDu9vIKSGYorl
	 zFhbxSpXm8ZHJBM6/N/NOFJwHHGkBO2/e7cUqja0lVj0whgyAExHqV5Guf69HkNeTc
	 rdlwbaV0SCNwg5sx6Q6eQUswprRxQJ0bIy2AZSTXwzHM1a3dDMS/MV3dWbzqIm6nH3
	 fqiELVadQPWo4ylVU5Hm1UTDR94yHPctm4luS/nc00VnuqeCqz8YzyjWkTXzR6a0p1
	 KA9iikFA7zLGeYIL9udIt4pK+e6lOcYbDMYCda2HTLx+MgldbSwkPsKScKZ0wy/Z7D
	 XIbxSk/4ZjJFQ==
Date: Sat, 1 Feb 2025 13:14:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alexandru
 Ardelean <aardelean@baylibre.com>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guillaume Stols
 <gstols@baylibre.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ad7606: add support for writing
 registers when using backend
Message-ID: <20250201131445.12ceb7e9@jic23-huawei>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-10-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
	<20250129-wip-bl-ad7606_add_backend_sw_mode-v3-10-c3aec77c0ab7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 12:03:11 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Guillaume Stols <gstols@baylibre.com>
> 
> Add the logic for effectively enabling the software mode for the
> iio-backend, i.e. enabling the software mode channel configuration and
> implementing the register writing functions.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

A few trivial things inline.

> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index 64733b607aa8..19d93ae49e1d 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -19,6 +19,7 @@

>  
> -static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
> +static const struct iio_chan_spec ad7606b_bi_sw_channels[] = {
> +	AD7606_BI_SW_CHANNEL(0),
> +	AD7606_BI_SW_CHANNEL(1),
> +	AD7606_BI_SW_CHANNEL(2),
> +	AD7606_BI_SW_CHANNEL(3),
> +	AD7606_BI_SW_CHANNEL(4),
> +	AD7606_BI_SW_CHANNEL(5),
> +	AD7606_BI_SW_CHANNEL(6),
> +	AD7606_BI_SW_CHANNEL(7),
> +};
> +
> +static int ad7606_par_bus_update_scan_mode(struct iio_dev *indio_dev,
> +					   const unsigned long *scan_mask)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	unsigned int c, ret;
> @@ -48,7 +61,8 @@ static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const unsigned
>  	return 0;
>  }
>  
> -static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio_dev)
> +static int ad7606_par_bus_setup_iio_backend(struct device *dev,
> +					    struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	unsigned int ret, c;
> @@ -86,9 +100,56 @@ static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio
>  	return 0;
>  }
>  
> +static int ad7606_par_bus_reg_read(struct iio_dev *indio_dev, unsigned int addr)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;
Bonus space before st that shouldn't be there.

I'd also reorder this to have int val, ret last.

> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pdata->bus_reg_read(st->back, addr, &val);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return val;
> +}
> +
> +static int ad7606_par_bus_reg_write(struct iio_dev *indio_dev,
> +				    unsigned int addr, unsigned int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	struct ad7606_platform_data *pdata =  st->dev->platform_data;

Same bonus space.

> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pdata->bus_reg_write(st->back, addr, val);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}


