Return-Path: <linux-iio+bounces-8593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE5956C5B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 15:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1317F1F22407
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38D716C6A9;
	Mon, 19 Aug 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2LEim/Y0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CF16C438;
	Mon, 19 Aug 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074950; cv=none; b=PxkMeM1KuILHSJ+k1QBv5DMhJF/RXXgXMIOFHYHMd60qjMAnH7ligbcXrrjsHRgmvqL7V3sExPFqKIVSoY1YB/IOZuReXnaHNaeg4nIEYQFxy0Bai4QzBneg+YCJcn6HTme8SHMtu+FzeOlfTVlzSiQXQthYytx2x+QHu/1AiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074950; c=relaxed/simple;
	bh=xdq0mAE8Ba0fmk6rNvkOjgWo+w0dnu+VNJwVS6SS2l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LiXwHx1UUoe1C2ehh+hhK/YnKqiZK114YyiaAL4Co/WIaVy+9gMFfNPNaKob3Jy1IRezGOUNzwd4vO14kSohOoFmVjzELJxq7rnG4EMG04sZqEoQwsiEaiQq4SuHZiWTcUyF7QweceVs+fj7Hvh64aUX5KYQJERDvI4FO5Azcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2LEim/Y0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J8N2dQ014235;
	Mon, 19 Aug 2024 15:41:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	bQulpxG1VnLqgrCD3WCcMJwDbL8UJbzPwnhyTZrwwt8=; b=2LEim/Y0kyl6Pi9c
	IqYr2SLsPKLLWnPxWH6m6RvE+DrYzvl+EjT3Pnlwg8/3zpMmSb0k3lmAKyHx49N2
	KlWr3TofL5NDt+lm1d72dyIgoh1DGpPcltVRFstrPmX/hCDsh9eXTQhH8pyzLa2Q
	qePnzdn74bWMpB1aUZpPRkP8DY88ExqINm+rXJYDitlto03z/fIojx/mydKysonQ
	Ug37CYDrDYALBP4gvRch4PCI97Q8Izd0cRx15XPKFxN9a1lsCV6lB/hNUY+b1tJ2
	ix2nWTTLCGgeyLpybXwrojMhV8J1fL65DlYQ7qT9tLyIryw5TPG1Een9ll6539WH
	JXtf5w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 412h9fppv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 15:41:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3C9D94002D;
	Mon, 19 Aug 2024 15:41:40 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B1ED26FD11;
	Mon, 19 Aug 2024 15:40:50 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 19 Aug
 2024 15:40:50 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 19 Aug
 2024 15:40:49 +0200
Message-ID: <9dc935e0-a980-41a0-b4bb-ae54453bd3a3@foss.st.com>
Date: Mon, 19 Aug 2024 15:40:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: st,stm32-adc: add top-level constraints
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240818172951.121983-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20240818172951.121983-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_12,2024-08-19_01,2024-05-17_01


On 8/18/24 19:29, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> index ec34c48d4878..ef9dcc365eab 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> @@ -54,7 +54,9 @@ properties:
>            It's not present on stm32f4.
>            It's required on stm32h7 and stm32mp1.
>  
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
>  
>    st,max-clk-rate-hz:
>      description:

Hi Krzysztof,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Thanks,
Fabrice

