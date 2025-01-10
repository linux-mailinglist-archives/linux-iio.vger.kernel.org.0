Return-Path: <linux-iio+bounces-14098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A682FA08F05
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 12:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A38188C3E7
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBCB20ADC2;
	Fri, 10 Jan 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f6JWExp4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994E1FF602;
	Fri, 10 Jan 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508035; cv=none; b=Ue3Ddj6bCixYFhRR7D65+XA5wqj2M/M9DtoxtaeyLWK6SvREoGtYNEiqJ5rKmn4EImyhzT9FEsNKQ2AU7LqL4DoY7RtOufBXcPjbOgG4BfDNrCm2YcscMb0HSofJIZURbz811nSnxNfxMZV/kyjbuqoG3e6SR6l4fLonnU1yL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508035; c=relaxed/simple;
	bh=CqhVdS4+KOe/q6qNAbml57dOWyYgAtHElQpX66q4b2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bCpLtGsmM8WFkHspMJTiM9lmwK/q8AxQvhINOP7SuMlTWqSecDB4Nj5OhLeX/wQ3HRQW56/kEGtX7YbdJskkr0U9AEb6sYaL6cgYEGOJVgkXXHAXuSuPUholXizoOnxAcV305KuNM26cMDL6MlP0wGys4WsAtbiwk99Uvf6nNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f6JWExp4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A6XPXL018522;
	Fri, 10 Jan 2025 12:20:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6O0IzZdicbDnl+ThnIAAob2BiQyf9NMS5q74NBvP63Q=; b=f6JWExp4ct10P4SU
	OjyL/96MiRqY2IXnuKvQSzUbrLCOd31/N1T+C7yotKJm/D5/S8LyF5gFNpjE77wM
	em03bvuzgVWXgw526qn+RJn940qKk2urGywI/ki9gbjFQNEyrwt6n62oyG3x9DEn
	/CYreg4GjtjlhNUpoVs0vzXAdFeaqmDHCmbA+YuXE668GspWqdOAGv/MIHkodbwa
	E1Hm4PmNw0O2mQEkxra80LfEdw6nP7wnGRv3ccMu8IcTN3MJYg2Vx54GZhjnZxoU
	xSZh/b5CZtkcg3SS64lEAl9WYO6jqa7BdTTcjnMliR8x2YvOhGoIQzs1m2LYwKTn
	6yzB8A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 442f5q4p5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 12:20:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5518940045;
	Fri, 10 Jan 2025 12:18:56 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4C542930E7;
	Fri, 10 Jan 2025 12:18:14 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 12:18:14 +0100
Received: from [10.252.28.64] (10.252.28.64) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 12:18:13 +0100
Message-ID: <9df8fc8b-b827-4505-9273-ac56ab7426e7@foss.st.com>
Date: Fri, 10 Jan 2025 12:18:12 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: stm32: Drop unnecessary DT property presence
 check
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250109182325.3973684-2-robh@kernel.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250109182325.3973684-2-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 1/9/25 19:23, Rob Herring (Arm) wrote:
> There's no reason to check for regulator supply property presence before
> calling devm_regulator_get_optional() as that will return -ENODEV if
> the supply is not present.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> The diff context doesn't show it, but the next line returns on error 
> other than -ENODEV.

Hi Rob,

Tested on STM32MP157C-EV1,

Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks & BR,
Fabrice

> 
>  drivers/iio/adc/stm32-adc-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 2201ee9987ae..0914148d1a22 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -615,8 +615,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>  	}
>  
>  	/* Booster can be used to supply analog switches (optional) */
> -	if (priv->cfg->has_syscfg & HAS_VBOOSTER &&
> -	    of_property_read_bool(np, "booster-supply")) {
> +	if (priv->cfg->has_syscfg & HAS_VBOOSTER) {
>  		priv->booster = devm_regulator_get_optional(dev, "booster");
>  		if (IS_ERR(priv->booster)) {
>  			ret = PTR_ERR(priv->booster);
> @@ -628,8 +627,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>  	}
>  
>  	/* Vdd can be used to supply analog switches (optional) */
> -	if (priv->cfg->has_syscfg & HAS_ANASWVDD &&
> -	    of_property_read_bool(np, "vdd-supply")) {
> +	if (priv->cfg->has_syscfg & HAS_ANASWVDD) {
>  		priv->vdd = devm_regulator_get_optional(dev, "vdd");
>  		if (IS_ERR(priv->vdd)) {
>  			ret = PTR_ERR(priv->vdd);

