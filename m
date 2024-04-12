Return-Path: <linux-iio+bounces-4198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7078A2E5A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECF81C226C0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A245BF3;
	Fri, 12 Apr 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QO5/ZnkY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35B4595B
	for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925217; cv=none; b=gyNFhmAUgEwhSVu32D2Oj1phd7JW2XWS6KkqjmRiEYiriGUDB+TT+ZXtW1V7dnbrw56VrRyhH6gV03lmAMieNZGXAacgMTcs06k6be/g/gvVtSaIYREkZrhFnmMrmZ2u+MnMR71fhd6/Nkjv6kdPio5Rk3phrM7nOFSaJFuoYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925217; c=relaxed/simple;
	bh=xy8zBcIFRDa1WwX7m0uzbcsyuKBRYsxCgNr+4fgXhNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rKbPdDiujMHEsQvnhzjAeGRBSCZk3c+mlRRL3bvb3EnD6YabiJPEkROnEQafbVLT2n3ivazy0j9pLJqo4+kTI5+7gRbK1JysMxYTrC9i20GqjJQgRDcRR+xmKhXpBp7MOaLbV2kJiMzfWJanHRAtk1O/Clhl+PVbY6xKjxswWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QO5/ZnkY; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CC06cT016590;
	Fri, 12 Apr 2024 14:32:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=hFKwqDIFKt5+2bDaoIY+EsjsZNmh+ui4K5adntdmA2I=; b=QO
	5/ZnkY08sdPve3n5s+dpmypvnW9A6P4bblOb1RQUnDdF78MVz/LNAY56vd3D9VJA
	AnP1LvYZoWqaCJYC/mkjvwtaXp0q0MIXwx7FVzwdrrOv9doMLX+HYbTYoF48FpiG
	DzK0AG4/s2iKzQmPspXJyV44zmQxhXFQyet9P90SMgpzSPzArjFcnzfNRDX/o7Zk
	ZF5uQ7vEUSPeqtB761iIOXVPTjYKsdIhsbj4oOtJ3qaF6p1Yaxi0K2gNSOOQGYQY
	umYzKvJPoeiZGw2zJ5CXzu3hve3zWquzEudCL9fYD96Ti+A1fZ6eCEUxa4udymx3
	Fbcd0Gn/mTHCE6xdmbZA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xautg9y6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:32:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 953B44002D;
	Fri, 12 Apr 2024 14:32:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EEA52132F2;
	Fri, 12 Apr 2024 14:31:22 +0200 (CEST)
Received: from [10.252.23.222] (10.252.23.222) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Apr
 2024 14:31:21 +0200
Message-ID: <900004c4-0a30-4dff-85ba-ad6f61fe3818@foss.st.com>
Date: Fri, 12 Apr 2024 14:31:20 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] iio: adc: stm32: Fixing err code to not indicate
 success
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Mihail Chindris
	<mihail.chindris@analog.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240330185305.1319844-1-jic23@kernel.org>
 <20240330185305.1319844-4-jic23@kernel.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20240330185305.1319844-4-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_09,2024-04-09_01,2023-05-22_02

On 3/30/24 19:53, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This path would result in returning 0 / success on an error path.
> 
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Fixes: 95bc818404b2 ("iio: adc: stm32-adc: add support of generic channels binding")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Hi Jonathan,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Thanks,
Fabrice

> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index b5d3c9cea5c4..283c20757106 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2234,6 +2234,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
>  				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
>  					vin[0], vin[1]);
> +				ret = -EINVAL;
>  				goto err;
>  			}
>  		} else if (ret != -EINVAL) {

