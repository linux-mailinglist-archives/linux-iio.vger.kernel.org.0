Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5133B3FEBBA
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhIBJ65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 05:58:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34176 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhIBJ64 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 05:58:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1829vZVF024830;
        Thu, 2 Sep 2021 04:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630576655;
        bh=nEoymP6uiFiiUs51DwV54eLM+vIw5+7/A3ZrzYKIF2w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TLIJKYvgitFbshk0d29u9N5kCnhcT3+knLZvP3vYItsrYveDUKecS+YatT/pPvl05
         hSQDAb3sz8jcT0Aaq8931DzYe0U6ZDIrcihspwTgFCor2dBWfIAWczmbhEgnuvArjb
         /G07zugGFS/zX6BM+/7B1itjIVb0hQgWy3GX6Ex0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1829vZL5107782
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Sep 2021 04:57:35 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Sep 2021 04:57:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Sep 2021 04:57:34 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1829vU2G106438;
        Thu, 2 Sep 2021 04:57:31 -0500
Subject: Re: [PATCH 28/40] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Jason Reeder <jreeder@ti.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
 <20210825152518.379386-29-miquel.raynal@bootlin.com>
 <732e002d-d732-5411-1be4-1ecafc993da5@ti.com> <20210902084706.7cd54453@xps13>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <2e1cb934-c85a-34ca-c701-0d845bf0680a@ti.com>
Date:   Thu, 2 Sep 2021 12:57:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902084706.7cd54453@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 02/09/2021 09:47, Miquel Raynal wrote:
> Hi Grygorii,
> 
> Grygorii Strashko <grygorii.strashko@ti.com> wrote on Wed, 1 Sep 2021
> 22:26:25 +0300:
> 
>> On 25/08/2021 18:25, Miquel Raynal wrote:
>>> Introduce a new compatible that has another set of driver data,
>>> targeting am437x SoCs with a magnetic reader instead of the
>>> touchscreen and a more featureful set of registers.
>>>
>>> Co-developed-by: Jason Reeder <jreeder@ti.com>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> Signed-off-by: Jason Reeder <jreeder@ti.com>
>>> ---
>>>    drivers/mfd/ti_am335x_tscadc.c       | 43 ++++++++++++++++++++++------
>>>    include/linux/mfd/ti_am335x_tscadc.h |  9 +++++-
>>>    2 files changed, 43 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>>> index 1a30610dc65f..f4f6b9db4d2a 100644
>>> --- a/drivers/mfd/ti_am335x_tscadc.c
>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>>> @@ -122,9 +122,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>>    	const __be32 *cur;
>>>    	struct clk *clk;
>>>    	u32 val;
>>> -	bool use_tsc = false;
>>> +	bool use_tsc = false, use_mag = false;
>>>    	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
>>> -	int total_channels, err;
>>> +	int mag_tracks = 0, total_channels, err;
>>>    >   	/* Allocate memory for device */
>>>    	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
>>> @@ -146,6 +146,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>>    		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
>>>    		if (tscmag_wires)
>>>    			use_tsc = true;
>>> +	} else {
>>> +		node = of_get_child_by_name(pdev->dev.of_node, "mag");
>>> +		of_property_read_u32(node, "ti,tracks", &mag_tracks);
>>
>> "ti,tracks" seems undocumented?
> 
> Well that's true and almost on purpose, I am not focusing on the
> magnetic reader feature, it is not supported, I don't have one, I don't
> plan to add support for it. But in the driver I need to know how many
> "tracks" are unavailable for the ADC in order to implement the entire
> logic (this block comes from TI and the naming from Jason Reeder).
> 
> I am not comfortable writing a binding file for a device that I won't
> use, it's the best way to miss something and have stable broken
> bindings in the future. So I assumed it was not a big deal to have this
> property in the code, which may be updated/removed/enhanced later if
> needed without having to mess with the code too much. What do you think?

Sry, it's not ok.
You need to (a) add binding or (b) w/a it in some way -
like drop it and use const value instead, for example.

-- 
Best regards,
grygorii
