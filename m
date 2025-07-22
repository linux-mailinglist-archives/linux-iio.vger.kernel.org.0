Return-Path: <linux-iio+bounces-21875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64AB0DEA3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22BDAC4847
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2282EA171;
	Tue, 22 Jul 2025 14:20:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAB2C159F;
	Tue, 22 Jul 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194004; cv=none; b=AVpliAjEOgzN9CfscPcE+39u4Ktgvqw6coSuqd941asr18tNvKH3FA+xj/zmMStCX8dKBDRnsga2iAj6XeKG+KVqDn17ueh0jut+UbRnrm24/u5WK/JLDNgfzB+3xchm2IkrkSQU5zAOP402VrOreSNVDDu9JkIAfnjiRfvG7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194004; c=relaxed/simple;
	bh=u/XPPTPM2HV+PCBZb6VZfHt7+7wTVbn0NocEtxJmV4M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEoCYQDHfwczSVHgLwVTZKsfteP42wH57dEg+A9/nOHs7uTrLumGZ3RXz6urV7+aoasATE8IOA3JDb9TPQXlRqf7Att2SrWo4rq0n1K+4O8D0JlKAM23hjEWThgNjKB1iCePgnFJkotAg1KE75FUEqO5p9uRl77DPGVAW+6Y9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmfWb5N70z6H7Kd;
	Tue, 22 Jul 2025 22:18:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B7B751402C8;
	Tue, 22 Jul 2025 22:19:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 16:19:58 +0200
Date: Tue, 22 Jul 2025 15:19:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <sboyd@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <srini@kernel.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <sre@kernel.org>, <krzysztof.kozlowski@linaro.org>,
	<u.kleine-koenig@baylibre.com>, <linux-arm-msm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<kernel@collabora.com>, <wenst@chromium.org>, <casey.connolly@linaro.org>
Subject: Re: [PATCH v2 7/7] iio: adc: qcom-spmi-iadc: Remove regmap R/W
 wrapper functions
Message-ID: <20250722151956.000043a0@huawei.com>
In-Reply-To: <20250722101317.76729-8-angelogioacchino.delregno@collabora.com>
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
	<20250722101317.76729-8-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Jul 2025 12:13:17 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> This driver doesn't need to add any register base address to any
> regmap call anymore since it was migrated to register as a SPMI
> subdevice with its own regmap reg_base, which makes the regmap
> API to automatically add such base address internally.
> 
> Since the iadc_{read,write,read_result}() functions now only do
> call regmap_{read,write,bulk_read}() and nothing else, simplify
> the driver by removing them and by calling regmap APIs directly.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
One trivial comment following on from previous.
Either way

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> @@ -267,11 +249,6 @@ static int iadc_poll_wait_eoc(struct iadc_chip *iadc, unsigned int interval_us)
>  	return -ETIMEDOUT;
>  }
>  
> -static int iadc_read_result(struct iadc_chip *iadc, u16 *data)
> -{
> -	return regmap_bulk_read(iadc->regmap, IADC_DATA, data, 2);
> -}
> -
>  static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
>  {
>  	unsigned int wait;
> @@ -296,7 +273,7 @@ static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
>  	}
>  
>  	if (!ret)
> -		ret = iadc_read_result(iadc, data);
> +		ret = regmap_bulk_read(iadc->regmap, IADC_DATA, data, 2);

sizeof(*data) would be better than the magic 2.  This is probably a good
place to tidy that up given you are replacing the line anyway.


>  exit:
>  	iadc_set_state(iadc, false);
>  	if (ret < 0)


