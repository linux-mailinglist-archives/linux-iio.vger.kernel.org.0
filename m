Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE94C77AC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbiB1S1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 13:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiB1S12 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 13:27:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DC5DE55
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 10:08:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p4so3687136edi.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6xn9MNCR/aiZM9DPxzKBQutUxpm+wgkwa7RY+T/QuhI=;
        b=kcac9IwLzqC6SxnDqb/4WXOfhUmIyPWGqwqzi8zlBLWpjU8wiA5A68KQf858WxckqR
         KB1tggiHNND3fIKpHZ4vp361mgksbZ7wZ4tLm3fTVyD1OZPlmj5KuMqIE+uwHkdZIi0W
         tPxc6dxPGpgIQKJTcniXDgAVFsw51p7jSleFcYncRKdq4JyNW+ZVlkhJ0rABWYeqQFA5
         00Pil16o7s1O423zjqAd8jdPSTx7ZwyqydJ838JKspRL5IwsuwUwzRz9zUnbI6anjBbe
         HVlxXAarMWcGdh3h7uflYX2IDfx2sOE4mK7ChP5e3cYBjpOLxAfDJwktOZUNEKh9r0YR
         Qy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6xn9MNCR/aiZM9DPxzKBQutUxpm+wgkwa7RY+T/QuhI=;
        b=X03QsdtjKT1d9q0El/4THrDuSTDgj2Xgv5+H1f3FBxhTfXnBsXc099/TIqo5Qd9QYS
         kckiOSbwkp+dXepydEC2VKK1nY/api/0YZiYSQrd98w0WW/y0PGK04pNGrgPokGG/igD
         CFzizGa5k6S8etGnbTkrdQjICSxEnNZolV7rwDROuRugHrLNoDDWCE9IalDvd+CezhnK
         FL3weipHBx+RVoXNRXZfByKEmenSnEp4w14kUrr/Ev6YzaZBxj/WYwY42g5CKqlgG3Ku
         OBx4kFZEbr9E0LP+eWHnL3nA+cvPTLcu8cBrIfsH7QYVgFTsDE9yUzvJK3YK38b+pok2
         qqrA==
X-Gm-Message-State: AOAM532/2VY3HyQ6lYsR61AMwORntqC9rcyXZ5lSp7A8Rj5tI9eEUxGE
        m5aRXXZAWJtb+jO/t365r498kQ==
X-Google-Smtp-Source: ABdhPJzXkgSy1335OxlopvGPCzH6Z0LVDHCyN7Pf/2qCKDbUYfrqusOWkz0suLg3CaP1VxJI8B8ogA==
X-Received: by 2002:a50:fb91:0:b0:408:5100:b4a7 with SMTP id e17-20020a50fb91000000b004085100b4a7mr20470238edq.311.1646071733974;
        Mon, 28 Feb 2022 10:08:53 -0800 (PST)
Received: from [192.168.0.30] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906198f00b006ce36c0c138sm4555406ejd.186.2022.02.28.10.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:08:53 -0800 (PST)
Message-ID: <dd0517fb-3650-830e-62e2-533b3b1a116e@linaro.org>
Date:   Mon, 28 Feb 2022 18:08:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <CAA8EJpqmqZ00jdZiNkXzniQV4Q3fHw9x6KPgAwQp=uy1t0FZmg@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAA8EJpqmqZ00jdZiNkXzniQV4Q3fHw9x6KPgAwQp=uy1t0FZmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 26/02/2022 18:09, Dmitry Baryshkov wrote:
> On Tue, 22 Feb 2022 at 01:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Some PMIC functions such as the RRADC need to be aware of the PMIC
>> chip revision information to implement errata or otherwise adjust
>> behaviour, export the PMIC information to enable this.
>>
>> This is specifically required to enable the RRADC to adjust
>> coefficients based on which chip fab the PMIC was produced in,
>> this can vary per unique device and therefore has to be read at
>> runtime.
>>
>> [bugs in previous revision]
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/mfd/qcom-spmi-pmic.c      | 174 ++++++++++++++++++++----------
>>   include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++++++
>>   2 files changed, 178 insertions(+), 56 deletions(-)
>>   create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
>>
>> diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
>> index 1cacc00aa6c9..1ef426a1513b 100644
>> --- a/drivers/mfd/qcom-spmi-pmic.c
>> +++ b/drivers/mfd/qcom-spmi-pmic.c
>> @@ -3,11 +3,16 @@
>>    * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>    */
>>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/gfp.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/spmi.h>
>> +#include <linux/types.h>
>>   #include <linux/regmap.h>
>>   #include <linux/of_platform.h>
>> +#include <soc/qcom/qcom-spmi-pmic.h>
>>
>>   #define PMIC_REV2              0x101
>>   #define PMIC_REV3              0x102
>> @@ -17,37 +22,6 @@
>>
>>   #define PMIC_TYPE_VALUE                0x51
>>
>> -#define COMMON_SUBTYPE         0x00
>> -#define PM8941_SUBTYPE         0x01
>> -#define PM8841_SUBTYPE         0x02
>> -#define PM8019_SUBTYPE         0x03
>> -#define PM8226_SUBTYPE         0x04
>> -#define PM8110_SUBTYPE         0x05
>> -#define PMA8084_SUBTYPE                0x06
>> -#define PMI8962_SUBTYPE                0x07
>> -#define PMD9635_SUBTYPE                0x08
>> -#define PM8994_SUBTYPE         0x09
>> -#define PMI8994_SUBTYPE                0x0a
>> -#define PM8916_SUBTYPE         0x0b
>> -#define PM8004_SUBTYPE         0x0c
>> -#define PM8909_SUBTYPE         0x0d
>> -#define PM8028_SUBTYPE         0x0e
>> -#define PM8901_SUBTYPE         0x0f
>> -#define PM8950_SUBTYPE         0x10
>> -#define PMI8950_SUBTYPE                0x11
>> -#define PM8998_SUBTYPE         0x14
>> -#define PMI8998_SUBTYPE                0x15
>> -#define PM8005_SUBTYPE         0x18
>> -#define PM660L_SUBTYPE         0x1A
>> -#define PM660_SUBTYPE          0x1B
>> -#define PM8150_SUBTYPE         0x1E
>> -#define PM8150L_SUBTYPE                0x1f
>> -#define PM8150B_SUBTYPE                0x20
>> -#define PMK8002_SUBTYPE                0x21
>> -#define PM8009_SUBTYPE         0x24
>> -#define PM8150C_SUBTYPE                0x26
>> -#define SMB2351_SUBTYPE                0x29
>> -
>>   static const struct of_device_id pmic_spmi_id_table[] = {
>>          { .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
>>          { .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
>> @@ -81,42 +55,118 @@ static const struct of_device_id pmic_spmi_id_table[] = {
>>          { }
>>   };
>>
>> -static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>> +/**
>> + * qcom_pmic_get() - Get a pointer to the base PMIC device
>> + *
>> + * @dev: the pmic function device
>> + * @return: the struct qcom_spmi_pmic* pointer associated with the function device
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
>> +       struct spmi_device *sdev;
>> +       struct device_node *spmi_bus;
>> +       struct device_node *other_usid = NULL;
>> +       int function_parent_usid, ret;
>> +       u32 reg[2];
>> +
>> +       if (!of_match_device(pmic_spmi_id_table, dev->parent))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       sdev = to_spmi_device(dev->parent);
>> +       if (!sdev)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       /*
>> +        * Quick return if the function device is already in the right
>> +        * USID
>> +        */
>> +       if (sdev->usid % 2 == 0)
>> +               return spmi_device_get_drvdata(sdev);
> 
>> +
>> +       function_parent_usid = sdev->usid;
>> +
>> +       /*
>> +        * Walk through the list of PMICs until we find the sibling USID.
>> +        * The goal is the find to previous sibling. Assuming there is no
>> +        * PMIC with more than 2 USIDs. We know that function_parent_usid
>> +        * is one greater than the base USID.
>> +        */
> 
Hi Dmitry,
> I think this is not correct for newer platforms. On SM8450 we have
> PMICs which do not share a pair of USIDs.
> For example on sm8450-qrd:
> 
> PMK8350 @ 0
> PM8350 @ 1
> PM8350C @ 2
> PM8350B @ 3
> PMR735A @ 4
> PMR735B @ 5
> PM8450 @ 7
Huh alright, I see a few ways we can deal with this, as if this is the case then I think the existing logic in probe 
(which only prints the PMIC information) would need to be fixed either way.

Could you clarify if these PMICs have only one USID, or if for example PM8350[ABC] is a PMIC with 4 USIDs?

None of these PMICs seem to be referenced in the PMIC match table, they aren't in mainline yet?

If I rework the logic to use shared compatible strings to find the base PMIC (by finding the matching USID with the 
smallest address) maybe that would be an acceptable solution, although that would break if a device has more than one of 
a single pmic...

Perhaps for now we could limit the logic to only run for pm(i)8998 and pm660 and return `-EINVAL` with a WARN for other 
PMICs, as these two are the only ones with drivers that would use this functionality for now, and it can be fixed up for 
newer PMICs in the future if needed.

Let me know what you think.>
>> +       spmi_bus = of_get_parent(sdev->dev.parent->of_node);
>> +       do {
>> +               other_usid = of_get_next_child(spmi_bus, other_usid);
>> +               ret = of_property_read_u32_array(other_usid, "reg", reg, 2);
>> +               if (ret)
>> +                       return ERR_PTR(ret);
>> +               sdev = spmi_device_from_of(other_usid);
>> +               if (sdev == NULL) {
>> +                       /*
>> +                        * If the base USID for this PMIC hasn't probed yet
>> +                        * but the secondary USID has, then we need to defer
>> +                        * the function driver so that it will attempt to
>> +                        * probe again when the base USID is ready.
>> +                        */
>> +                       if (reg[0] == function_parent_usid - 1)
>> +                               return ERR_PTR(-EPROBE_DEFER);
>> +
>> +                       continue;
>> +               }
>> +
>> +               if (reg[0] == function_parent_usid - 1)
>> +                       return spmi_device_get_drvdata(sdev);
>> +       } while (other_usid->sibling);
>> +
>> +       return ERR_PTR(-ENODATA);
>> +}
>> +EXPORT_SYMBOL(qcom_pmic_get);
>> +
>> +static inline void pmic_print_info(struct device *dev, struct qcom_spmi_pmic *pmic)
>> +{
>> +       dev_dbg(dev, "%x: %s v%d.%d\n",
>> +               pmic->subtype, pmic->name, pmic->major, pmic->minor);
>> +}
>> +
>> +static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
>> +                                struct qcom_spmi_pmic *pmic)
>>   {
>> -       unsigned int rev2, minor, major, type, subtype;
>> -       const char *name = "unknown";
>>          int ret, i;
>>
>> -       ret = regmap_read(map, PMIC_TYPE, &type);
>> +       ret = regmap_read(map, PMIC_TYPE, &pmic->type);
>>          if (ret < 0)
>> -               return;
>> +               return ret;
>>
>> -       if (type != PMIC_TYPE_VALUE)
>> -               return;
>> +       if (pmic->type != PMIC_TYPE_VALUE)
>> +               return ret;
>>
>> -       ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
>> +       ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
>>          if (ret < 0)
>> -               return;
>> +               return ret;
>>
>>          for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
>> -               if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
>> +               if (pmic->subtype == (unsigned long)pmic_spmi_id_table[i].data)
>>                          break;
>>          }
>>
>>          if (i != ARRAY_SIZE(pmic_spmi_id_table))
>> -               name = pmic_spmi_id_table[i].compatible;
>> +               pmic->name = devm_kstrdup_const(dev, pmic_spmi_id_table[i].compatible, GFP_KERNEL);
>>
>> -       ret = regmap_read(map, PMIC_REV2, &rev2);
>> +       ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
>>          if (ret < 0)
>> -               return;
>> +               return ret;
>>
>> -       ret = regmap_read(map, PMIC_REV3, &minor);
>> +       ret = regmap_read(map, PMIC_REV3, &pmic->minor);
>>          if (ret < 0)
>> -               return;
>> +               return ret;
>>
>> -       ret = regmap_read(map, PMIC_REV4, &major);
>> +       ret = regmap_read(map, PMIC_REV4, &pmic->major);
>>          if (ret < 0)
>> -               return;
>> +               return ret;
>>
>>          /*
>>           * In early versions of PM8941 and PM8226, the major revision number
>> @@ -124,14 +174,16 @@ static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>>           * Increment the major revision number here if the chip is an early
>>           * version of PM8941 or PM8226.
>>           */
>> -       if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
>> -           major < 0x02)
>> -               major++;
>> +       if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
>> +           pmic->major < 0x02)
>> +               pmic->major++;
>> +
>> +       if (pmic->subtype == PM8110_SUBTYPE)
>> +               pmic->minor = pmic->rev2;
>>
>> -       if (subtype == PM8110_SUBTYPE)
>> -               minor = rev2;
>> +       pmic_print_info(dev, pmic);
>>
>> -       dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
>> +       return 0;
>>   }
>>
>>   static const struct regmap_config spmi_regmap_config = {
>> @@ -144,14 +196,24 @@ static const struct regmap_config spmi_regmap_config = {
>>   static int pmic_spmi_probe(struct spmi_device *sdev)
>>   {
>>          struct regmap *regmap;
>> +       struct qcom_spmi_pmic *pmic;
>> +       int ret;
>>
>>          regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
>>          if (IS_ERR(regmap))
>>                  return PTR_ERR(regmap);
>>
>> +       pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
>> +       if (!pmic)
>> +               return -ENOMEM;
>> +
>>          /* Only the first slave id for a PMIC contains this information */
>> -       if (sdev->usid % 2 == 0)
>> -               pmic_spmi_show_revid(regmap, &sdev->dev);
>> +       if (sdev->usid % 2 == 0) {
>> +               ret = pmic_spmi_load_revid(regmap, &sdev->dev, pmic);
>> +               if (ret < 0)
>> +                       return ret;
>> +               spmi_device_set_drvdata(sdev, pmic);
>> +       }
>>
>>          return devm_of_platform_populate(&sdev->dev);
>>   }
>> diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
>> new file mode 100644
>> index 000000000000..a8a77be22cfc
>> --- /dev/null
>> +++ b/include/soc/qcom/qcom-spmi-pmic.h
>> @@ -0,0 +1,60 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright (c) 2021 Linaro. All rights reserved.
>> + * Copyright (c) 2021 Caleb Connolly <caleb.connolly@linaro.org>
>> + */
>> +
>> +#ifndef __QCOM_PMIC_H__
>> +#define __QCOM_PMIC_H__
>> +
>> +#define COMMON_SUBTYPE         0x00
>> +#define PM8941_SUBTYPE         0x01
>> +#define PM8841_SUBTYPE         0x02
>> +#define PM8019_SUBTYPE         0x03
>> +#define PM8226_SUBTYPE         0x04
>> +#define PM8110_SUBTYPE         0x05
>> +#define PMA8084_SUBTYPE                0x06
>> +#define PMI8962_SUBTYPE                0x07
>> +#define PMD9635_SUBTYPE                0x08
>> +#define PM8994_SUBTYPE         0x09
>> +#define PMI8994_SUBTYPE                0x0a
>> +#define PM8916_SUBTYPE         0x0b
>> +#define PM8004_SUBTYPE         0x0c
>> +#define PM8909_SUBTYPE         0x0d
>> +#define PM8028_SUBTYPE         0x0e
>> +#define PM8901_SUBTYPE         0x0f
>> +#define PM8950_SUBTYPE         0x10
>> +#define PMI8950_SUBTYPE                0x11
>> +#define PM8998_SUBTYPE         0x14
>> +#define PMI8998_SUBTYPE                0x15
>> +#define PM8005_SUBTYPE         0x18
>> +#define PM660L_SUBTYPE         0x1A
>> +#define PM660_SUBTYPE          0x1B
>> +#define PM8150_SUBTYPE         0x1E
>> +#define PM8150L_SUBTYPE                0x1f
>> +#define PM8150B_SUBTYPE                0x20
>> +#define PMK8002_SUBTYPE                0x21
>> +#define PM8009_SUBTYPE         0x24
>> +#define PM8150C_SUBTYPE                0x26
>> +#define SMB2351_SUBTYPE                0x29
>> +
>> +#define PMI8998_FAB_ID_SMIC    0x11
>> +#define PMI8998_FAB_ID_GF      0x30
>> +
>> +#define PM660_FAB_ID_GF                0x0
>> +#define PM660_FAB_ID_TSMC      0x2
>> +#define PM660_FAB_ID_MX                0x3
>> +
>> +struct qcom_spmi_pmic {
>> +       unsigned int type;
>> +       unsigned int subtype;
>> +       unsigned int major;
>> +       unsigned int minor;
>> +       unsigned int rev2;
>> +       const char *name;
>> +};
>> +
>> +struct device;
>> +
>> +const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev);
>> +
>> +#endif /* __QCOM_PMIC_H__ */
>> --
>> 2.35.1
>>
> 
> 

-- 
Kind Regards,
Caleb (they/them)
