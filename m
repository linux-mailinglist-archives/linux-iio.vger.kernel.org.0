Return-Path: <linux-iio+bounces-20043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB473AC92D4
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35629E25A2
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A083823815C;
	Fri, 30 May 2025 15:56:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412F2376FC;
	Fri, 30 May 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620593; cv=none; b=NmWycz+ZC5SwgXsJU9I6jh/oXC02/P/RqGcf3vQUOqQPtxur9vqKJQ6SVc9Vebppm4MNY3ltNTdwI5EUiJSZwA3j36srZmkxjWptKeIeb2jMgYD3SPuogaKXrMo2GUo3ji/27hP8AYqYAdMWiRzOLyn5qHaFcKG0MtU9dsu9C7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620593; c=relaxed/simple;
	bh=dFLpiaFzHIro19SRZcWr8KYtMI29DNjKuWrfQFD8bzk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6cDrB/43oWEZx5zRWFzISb/55U5D6m3LFCxxFGNOl6Q+u/6qHGXbvRZzWBkhFiw7TXLw+BuIvQNLc9Y0GHyriIphWXp94KoegAxk/ASlA5wJSdnSmiYOWZf6a75zfXmw796YYBGAcIaX3gz0P6slOP60I4c8yhfamX6NPWHeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b87Bt0QJcz6GFWg;
	Fri, 30 May 2025 23:56:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CDFA114027A;
	Fri, 30 May 2025 23:56:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 17:56:27 +0200
Date: Fri, 30 May 2025 16:56:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: add enabling of optional
 Vrefin voltage
Message-ID: <20250530165625.000028da@huawei.com>
In-Reply-To: <20250530-wip-bl-ad7606-reference-voltages-v2-2-d5e1ad7e6f14@baylibre.com>
References: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
	<20250530-wip-bl-ad7606-reference-voltages-v2-2-d5e1ad7e6f14@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 30 May 2025 16:27:57 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add optional refin voltage enabling. The property "refin-supply" is
> already available and optional in the current fdt dt_schema.

Good to call out either as a comment and/or in the patch description
that we don't need to do anything 'different' dependent on whether
this exists or not because it is coupled with an external pin that
should be tied low to use this supply.

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..4fd9638eb6e56f800c7c97425e45e04f269e3df7 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1335,6 +1335,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		return dev_err_probe(dev, ret,
>  				     "Failed to enable Vdrive supply\n");
>  
> +	ret = devm_regulator_get_enable_optional(dev, "refin");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable REFIN voltage\n");
> +
>  	st->chip_info = chip_info;
>  
>  	if (st->chip_info->oversampling_num) {
> 


