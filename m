Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82273FE2FE
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 21:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhIAT1y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 15:27:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57636 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhIAT1y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 15:27:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 181JQV31026608;
        Wed, 1 Sep 2021 14:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630524391;
        bh=TRuE6KH2UxmRjPL0Ha46ANT3bo9HPWgsSgDp/PvBKzc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OXBmmCLjO6oE6W9zHxyjm/9XLP3rXatuwT6QPX2OSmM0On9ZbRhpKv5gqz54yQZZS
         acnmgW4VsAWLhBQlDE5CTLNk4ydNWDdNpvdSPp1AjBPOLGFGwdktOmT3K1v9QOIRIw
         zzfikghV581kQmywpLzluztlRdPRw76+wwN3J4Ns=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 181JQVOn060436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Sep 2021 14:26:31 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 1
 Sep 2021 14:26:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 1 Sep 2021 14:26:30 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 181JQQCx020864;
        Wed, 1 Sep 2021 14:26:26 -0500
Subject: Re: [PATCH 28/40] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Jason Reeder <jreeder@ti.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
 <20210825152518.379386-29-miquel.raynal@bootlin.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <732e002d-d732-5411-1be4-1ecafc993da5@ti.com>
Date:   Wed, 1 Sep 2021 22:26:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825152518.379386-29-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 25/08/2021 18:25, Miquel Raynal wrote:
> Introduce a new compatible that has another set of driver data,
> targeting am437x SoCs with a magnetic reader instead of the
> touchscreen and a more featureful set of registers.
> 
> Co-developed-by: Jason Reeder <jreeder@ti.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Jason Reeder <jreeder@ti.com>
> ---
>   drivers/mfd/ti_am335x_tscadc.c       | 43 ++++++++++++++++++++++------
>   include/linux/mfd/ti_am335x_tscadc.h |  9 +++++-
>   2 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 1a30610dc65f..f4f6b9db4d2a 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -122,9 +122,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>   	const __be32 *cur;
>   	struct clk *clk;
>   	u32 val;
> -	bool use_tsc = false;
> +	bool use_tsc = false, use_mag = false;
>   	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
> -	int total_channels, err;
> +	int mag_tracks = 0, total_channels, err;
>   
>   	/* Allocate memory for device */
>   	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> @@ -146,6 +146,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>   		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
>   		if (tscmag_wires)
>   			use_tsc = true;
> +	} else {
> +		node = of_get_child_by_name(pdev->dev.of_node, "mag");
> +		of_property_read_u32(node, "ti,tracks", &mag_tracks);

"ti,tracks" seems undocumented?

[....]

-- 
Best regards,
grygorii
