Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9471B400079
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhICNZx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 09:25:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46854 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhICNZw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 09:25:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 183DOQcg115630;
        Fri, 3 Sep 2021 08:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630675467;
        bh=PEqomZ4Oiml/sEhlVDsmQO11W5RCqsiO5+Ta60ysjuw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LdI0WxniaW0bFR6H2Nv0SVSO5ZOf0hHKXAyWZrkhv6/um49n/DzxQ1GBLmWINZEPK
         QlU5W4N5MhrNIn8lfO7PB1wGX8U+92cwBDozHnYzWxQiL5jxGUW/frVfgIqIncq2je
         VApoAc/1btX+4+BJNy08qBkT9Nmyz82ifMTxcF1I=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 183DOQq1056319
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 08:24:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Sep 2021 08:24:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Sep 2021 08:24:26 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 183DONNN072354;
        Fri, 3 Sep 2021 08:24:23 -0500
Subject: Re: [PATCH v2 33/46] mfd: ti_am335x_tscadc: Move control register
 configuration
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Jason Reeder <jreeder@ti.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
 <20210902215144.507243-34-miquel.raynal@bootlin.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3bc1f515-0b3c-ad0c-9624-4d4804899007@ti.com>
Date:   Fri, 3 Sep 2021 16:24:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902215144.507243-34-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 03/09/2021 00:51, Miquel Raynal wrote:
> The datasheet states that most of the configuration should be set in the
> control register in the first place, before actually enabling the
> hardware. So far only half of the configuration was made in the first
> step, which does not make really sense and would complicating the code
> when introducing support for the am437x hardware.
> 
> Let's move that register write a bit below to enclose more configuration.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/mfd/ti_am335x_tscadc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 29ada9da8826..a0db3e4ff265 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -239,6 +239,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>   	}
>   	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>   
> +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> +

Strange change - above 2 lines a the same !?

>   	tscadc_idle_config(tscadc);
>   
>   	/* Enable the TSC module enable bit */
> 

-- 
Best regards,
grygorii
