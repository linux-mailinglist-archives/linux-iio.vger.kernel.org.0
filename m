Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495354BDFC4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381612AbiBURUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 12:20:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381620AbiBURUV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 12:20:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8606DD0
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 09:19:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i19so9908334wmq.5
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rbll2jU6oJfV1Ywi00i5bG6bj2ELDV2fryCVZEMZzYk=;
        b=NY0uVjVwCgEF4Ol7gTd/8OiSTZU5jnU86dAUSQQjX5DqroD7yci5f5lHdAJ513rUW7
         keINNiCCpnoADYRKp/T97go0BOrNc6+GHK7I/zOysHVOpzt/ymmJQFd501nTtsUGbO71
         rKJAc9tG3jSBxo7HdYbwpcv25k7qg7zoipAvevDo88QIbSoN18TqPEAExHZcdqrOshfA
         bzp+ph7WZjhLJFd+iPzUWWOo3/2yITd2Vx3+d+C9rF2hGFWAX/mwAeCqbY9inZ6ZXQpe
         Ud2rD5kBt5t+q9mkLKhXN6yvUlX08CLbnjkuvaF0FaOAGr7QR+By58wMGxlVB0QtVSuU
         VaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbll2jU6oJfV1Ywi00i5bG6bj2ELDV2fryCVZEMZzYk=;
        b=QjNpvB4KJfxJdBqTJjByM4zZpowkPO0mT2LaYyZksiP1Vk1fXEd88zL1DQdrRYfW4q
         9DWA8WWVsD1SkicbdR7AZB1Nchui14QjcJy2Ar4TZuwdhVkveushxP16aFBaWEnqYs3C
         FgZWrwMj7+WA+ka4GKVdLFWZmoAEO6tHkyO7P2DHqOHOtJ0/+MoxGZ0g+n9JnFOzi+WU
         47kuKWtHsaA7ht59qTXhW+JTSSpJxPWgOILDCR5DYQe5UY/MTHSJCe78DJmxcSrueu3o
         Kjf09wKM2FQ6F7ptQdsYLHafvXEfc5IC+BNSI4diKqTQoeZA53aM3JOeDhOX8/BIqYtZ
         fgFQ==
X-Gm-Message-State: AOAM5338rt72P0w2OP85e002DBRcCLLibJCRcUwjq6+Zp/VyV6ic1w8P
        d5fTqMmGO8p036PeuevbCBw4bQ==
X-Google-Smtp-Source: ABdhPJyVrwK6hMtWKNshrUvWvjRMjFKAVVUzf4DS9iHmaKzXkfyAXApaSbE6MxjIpSdyIHIHWAbtEQ==
X-Received: by 2002:a1c:7704:0:b0:354:4d2b:9d5 with SMTP id t4-20020a1c7704000000b003544d2b09d5mr21983191wmi.155.1645463993387;
        Mon, 21 Feb 2022 09:19:53 -0800 (PST)
Received: from [192.168.0.30] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id b18sm43008991wrx.92.2022.02.21.09.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 09:19:52 -0800 (PST)
Message-ID: <f16105af-5373-8148-d4c2-12024c5f5fc2@linaro.org>
Date:   Mon, 21 Feb 2022 17:19:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v7 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
 <20220216134920.239989-3-caleb.connolly@linaro.org>
 <20220219182703.2ab13110@jic23-huawei>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220219182703.2ab13110@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 19/02/2022 18:27, Jonathan Cameron wrote:
> On Wed, 16 Feb 2022 13:49:13 +0000
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> Some PMIC functions such as the RRADC need to be aware of the PMIC
>> chip revision information to implement errata or otherwise adjust
>> behaviour, export the PMIC information to enable this.
>>
>> This is specifically required to enable the RRADC to adjust
>> coefficients based on which chip fab the PMIC was produced in,
>> this can vary per unique device and therefore has to be read at
>> runtime.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Hi Jonathan,
> Hi Caleb,
> 
> A few minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/mfd/qcom-spmi-pmic.c      | 176 ++++++++++++++++++++----------
>>   include/soc/qcom/qcom-spmi-pmic.h |  60 ++++++++++
>>   2 files changed, 179 insertions(+), 57 deletions(-)
>>   create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
>>
>> diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
>> index 1cacc00aa6c9..5e656485cd55 100644
>> --- a/drivers/mfd/qcom-spmi-pmic.c
>> +++ b/drivers/mfd/qcom-spmi-pmic.c
>> @@ -3,51 +3,26 @@
>>    * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>    */
>>   
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/gfp.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/math.h>
>> +#include <linux/slab.h>
>>   #include <linux/spmi.h>
>> +#include <linux/types.h>
>>   #include <linux/regmap.h>
>>   #include <linux/of_platform.h>
>> +#include <soc/qcom/qcom-spmi-pmic.h>
> 
> All these new headers are a result of changes in this patch?
> Some clearly are, but device.h / errno.h?
device.h is required for devm_kzalloc() and errno.h for EPROBE_DEFER.

However slab.h and math.h aren't needed, they were from development,
I'll drop them in the next revision.
> 
> If you want to add missing ones that should always have been here
> it belongs in a different patch.
> 
>>   
>>   #define PMIC_REV2		0x101
>>   #define PMIC_REV3		0x102
>>   #define PMIC_REV4		0x103
>>   #define PMIC_TYPE		0x104
>>   #define PMIC_SUBTYPE		0x105
>> -
> 
> Unrelated change.  Please check through patches for this sort of noise.
> Whilst it doesn't matter in this particular case, it is good practice to
> ensure it isn't there to distract a reviewer from what matters.
ack
> 
>>   #define PMIC_TYPE_VALUE		0x51
>>   
>> -#define COMMON_SUBTYPE		0x00
>> -#define PM8941_SUBTYPE		0x01
>> -#define PM8841_SUBTYPE		0x02
>> -#define PM8019_SUBTYPE		0x03
>> -#define PM8226_SUBTYPE		0x04
>> -#define PM8110_SUBTYPE		0x05
>> -#define PMA8084_SUBTYPE		0x06
>> -#define PMI8962_SUBTYPE		0x07
>> -#define PMD9635_SUBTYPE		0x08
>> -#define PM8994_SUBTYPE		0x09
>> -#define PMI8994_SUBTYPE		0x0a
>> -#define PM8916_SUBTYPE		0x0b
>> -#define PM8004_SUBTYPE		0x0c
>> -#define PM8909_SUBTYPE		0x0d
>> -#define PM8028_SUBTYPE		0x0e
>> -#define PM8901_SUBTYPE		0x0f
>> -#define PM8950_SUBTYPE		0x10
>> -#define PMI8950_SUBTYPE		0x11
>> -#define PM8998_SUBTYPE		0x14
>> -#define PMI8998_SUBTYPE		0x15
>> -#define PM8005_SUBTYPE		0x18
>> -#define PM660L_SUBTYPE		0x1A
>> -#define PM660_SUBTYPE		0x1B
>> -#define PM8150_SUBTYPE		0x1E
>> -#define PM8150L_SUBTYPE		0x1f
>> -#define PM8150B_SUBTYPE		0x20
>> -#define PMK8002_SUBTYPE		0x21
>> -#define PM8009_SUBTYPE		0x24
>> -#define PM8150C_SUBTYPE		0x26
>> -#define SMB2351_SUBTYPE		0x29
>> -
>>   static const struct of_device_id pmic_spmi_id_table[] = {
>>   	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
>>   	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
>> @@ -81,42 +56,118 @@ static const struct of_device_id pmic_spmi_id_table[] = {
>>   	{ }
>>   };
>>   
>> -static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>> +/**
> 
> Run kernel-doc script over this and fix all the errors + warnings.
> I'm fairly sure you will get some.
ack, yeah this is not good kernel-doc, I'll get it sorted for the next revision, thanks.
> 
>> + * @brief Get a pointer to the base PMIC device
>> + *
>> + * @param dev the pmic function device
>> + * @return const struct qcom_spmi_pmic*
>> + *
>> + * A PMIC can be represented by multiple SPMI devices, but
>> + * only the base PMIC device will contain a reference to
>> + * the revision information.
>> + *
>> + * This function takes a pointer to a function device and
>> + * returns a pointer to the base PMIC device.
>> + */
>> +const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev)
>> +{
>> +	struct spmi_device *sdev;
>> +	struct device_node *spmi_bus;
>> +	struct device_node *other_usid;
>> +	int function_parent_usid, ret;
>> +	u32 reg[2];
>> +
>> +	if (!of_match_device(pmic_spmi_id_table, dev->parent))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	sdev = to_spmi_device(dev->parent);
>> +	if (!sdev)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/*
>> +	 * Quick return if the function device is already in the right
>> +	 * USID
>> +	 */
>> +	if (sdev->usid % 2 == 0)
>> +		return spmi_device_get_drvdata(sdev);
>> +
>> +	function_parent_usid = sdev->usid;
>> +
>> +	/*
>> +	 * Walk through the list of PMICs until we find the sibling USID.
>> +	 * The goal is the find to previous sibling. Assuming there is no
>> +	 * PMIC with more than 2 USIDs. We know that function_parent_usid
>> +	 * is one greater than the base USID.
>> +	 */
>> +	spmi_bus = of_get_parent(sdev->dev.parent->of_node);
>> +	do {
>> +		other_usid = of_get_next_child(spmi_bus, other_usid);
>> +		ret = of_property_read_u32_array(other_usid, "reg", reg, 2);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +		sdev = spmi_device_from_of(other_usid);
>> +		if (sdev == NULL) {
>> +			/*
>> +			 * If the base USID for this PMIC hasn't probed yet
>> +			 * but the secondary USID has, then we need to defer
>> +			 * the function driver so that it will attempt to
>> +			 * probe again when the base USID is ready.
>> +			 */
>> +			if (reg[0] == function_parent_usid - 1)
>> +				return ERR_PTR(-EPROBE_DEFER);
>> +
>> +			continue;
>> +		}
>> +
>> +		if (reg[0] == function_parent_usid - 1)
>> +			return spmi_device_get_drvdata(sdev);
>> +	} while (other_usid->sibling);
>> +
>> +	return ERR_PTR(-ENODATA);
>> +}
>> +EXPORT_SYMBOL(qcom_pmic_get);
>> +
>> +static inline void pmic_print_info(struct device *dev, struct qcom_spmi_pmic *pmic)
>> +{
>> +	dev_info(dev, "%x: %s v%d.%d\n",
>> +		pmic->subtype, pmic->name, pmic->major, pmic->minor);
>> +}
>> +
>> +static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
>> +				 struct qcom_spmi_pmic *pmic)
>>   {
>> -	unsigned int rev2, minor, major, type, subtype;
>> -	const char *name = "unknown";
>>   	int ret, i;
>>   
>> -	ret = regmap_read(map, PMIC_TYPE, &type);
>> +	ret = regmap_read(map, PMIC_TYPE, &pmic->type);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>> -	if (type != PMIC_TYPE_VALUE)
>> -		return;
>> +	if (pmic->type != PMIC_TYPE_VALUE)
>> +		return ret;
>>   
>> -	ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
>> +	ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
>> -		if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
>> +		if (pmic->subtype == (unsigned long)pmic_spmi_id_table[i].data)
>>   			break;
>>   	}
>>   
>>   	if (i != ARRAY_SIZE(pmic_spmi_id_table))
>> -		name = pmic_spmi_id_table[i].compatible;
>> +		pmic->name = devm_kstrdup_const(dev, pmic_spmi_id_table[i].compatible, GFP_KERNEL);
>>   
>> -	ret = regmap_read(map, PMIC_REV2, &rev2);
>> +	ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>> -	ret = regmap_read(map, PMIC_REV3, &minor);
>> +	ret = regmap_read(map, PMIC_REV3, &pmic->minor);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>> -	ret = regmap_read(map, PMIC_REV4, &major);
>> +	ret = regmap_read(map, PMIC_REV4, &pmic->major);
>>   	if (ret < 0)
>> -		return;
>> +		return ret;
>>   
>>   	/*
>>   	 * In early versions of PM8941 and PM8226, the major revision number
>> @@ -124,14 +175,14 @@ static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>>   	 * Increment the major revision number here if the chip is an early
>>   	 * version of PM8941 or PM8226.
>>   	 */
>> -	if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
>> -	    major < 0x02)
>> -		major++;
>> +	if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
>> +	    pmic->major < 0x02)
>> +		pmic->major++;
>>   
>> -	if (subtype == PM8110_SUBTYPE)
>> -		minor = rev2;
>> +	if (pmic->subtype == PM8110_SUBTYPE)
>> +		pmic->minor = pmic->rev2;
>>   
>> -	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
> 
> Why remove the dev_dbg?
I moved the print to be after the call to this function instead of in it - this function previously
just fetched and printed the PMIC revision information when debug printing was enabled, I'm changing
it to instead just fetch the information and populate the new struct qcom_spmi_pmic, I renamed the
function to match the new behaviour too. So it seemed sensible to remove the print behaviour and
instead move it outside the function (see the call to pmic_print_info() below).

I also inadvertently upgraded it to a dev_info() instead which I don't think
upstream are too keen on. I'll drop it back to dev_dbg in the next revision.
> 
>> +	return 0;
>>   }
>>   
>>   static const struct regmap_config spmi_regmap_config = {
>> @@ -144,14 +195,25 @@ static const struct regmap_config spmi_regmap_config = {
>>   static int pmic_spmi_probe(struct spmi_device *sdev)
>>   {
>>   	struct regmap *regmap;
>> +	struct qcom_spmi_pmic *pmic;
>> +	int ret;
>>   
>>   	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
>>   	if (IS_ERR(regmap))
>>   		return PTR_ERR(regmap);
>>   
>> +	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
>> +	if (!pmic)
>> +		return -ENOMEM;
>> +
>>   	/* Only the first slave id for a PMIC contains this information */
>> -	if (sdev->usid % 2 == 0)
>> -		pmic_spmi_show_revid(regmap, &sdev->dev);
>> +	if (sdev->usid % 2 == 0) {
>> +		ret = pmic_spmi_load_revid(regmap, &sdev->dev, pmic);
>> +		if (ret < 0)
>> +			return ret;
>> +		spmi_device_set_drvdata(sdev, pmic);
>> +		pmic_print_info(&sdev->dev, pmic);
>> +	}
>>   
>>   	return devm_of_platform_populate(&sdev->dev);
>>   }
> 

-- 
Kind Regards,
Caleb (they/them)
