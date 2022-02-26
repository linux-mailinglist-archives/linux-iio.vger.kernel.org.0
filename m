Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E74C56F1
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiBZRFf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 12:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBZRFf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 12:05:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107FD106B04;
        Sat, 26 Feb 2022 09:05:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F8E60C86;
        Sat, 26 Feb 2022 17:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA92C340E8;
        Sat, 26 Feb 2022 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645895099;
        bh=g7yo3fMuqJTQ1SHGCREG0ls4yeOh0MQ0TqRbYe1i/cw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BxzDkYNYu3oh4WTcVLbiqWNDxHytoQ2IcMez4PIDiSC9Wz4JJUg1yO9Wj3sGC5ERh
         JgQH7VCKCIWKBGf2Y+HRw3oqPbh+aJdtrRigZOULUQ/3IIpUARy6YNfdrP74QE+Vkc
         e5/H8YTpKCynsDt/bm4QaVONsEXCFXfbNPkYag3sii9UYNSsqp+cfngOIsJSrMGNqn
         7+gcBcY9mFiMB2RqMuEvO39L3JtM+PDReeCUJe1CAfxUlvfA9JkoNUU+caFe90i+DJ
         jVq6QFt6B4s6zco4LHxn9hcVmG2jzCnKnl1/PHLbJGAhWOPtudSGfx5pI3yiroG/Ve
         0fzvSGYsYSUrA==
Date:   Sat, 26 Feb 2022 17:11:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <20220226171158.4ced99d7@jic23-huawei>
In-Reply-To: <20220221220743.541704-3-caleb.connolly@linaro.org>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
        <20220221220743.541704-3-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Feb 2022 22:07:36 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Some PMIC functions such as the RRADC need to be aware of the PMIC
> chip revision information to implement errata or otherwise adjust
> behaviour, export the PMIC information to enable this.
> 
> This is specifically required to enable the RRADC to adjust
> coefficients based on which chip fab the PMIC was produced in,
> this can vary per unique device and therefore has to be read at
> runtime.
> 
> [bugs in previous revision]
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Hi Caleb,

One trivial question about a comment below.

Otherwise, looking for mfd ack from Lee.

Is anyone actively maintaining mfd/qcom-spmi-pmic.c?
If some one at least familiar with that code (Bjorn or Stephen maybe?)
could take a quick look that would also be great.

Thanks,

Jonathan


> ---
>  drivers/mfd/qcom-spmi-pmic.c      | 174 ++++++++++++++++++++----------
>  include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++++++
>  2 files changed, 178 insertions(+), 56 deletions(-)
>  create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
> 
> diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
> index 1cacc00aa6c9..1ef426a1513b 100644
> --- a/drivers/mfd/qcom-spmi-pmic.c
> +++ b/drivers/mfd/qcom-spmi-pmic.c
> @@ -3,11 +3,16 @@
>   * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/spmi.h>
> +#include <linux/types.h>
>  #include <linux/regmap.h>
>  #include <linux/of_platform.h>
> +#include <soc/qcom/qcom-spmi-pmic.h>
>  
>  #define PMIC_REV2		0x101
>  #define PMIC_REV3		0x102
> @@ -17,37 +22,6 @@
>  
>  #define PMIC_TYPE_VALUE		0x51
>  
> -#define COMMON_SUBTYPE		0x00
> -#define PM8941_SUBTYPE		0x01
> -#define PM8841_SUBTYPE		0x02
> -#define PM8019_SUBTYPE		0x03
> -#define PM8226_SUBTYPE		0x04
> -#define PM8110_SUBTYPE		0x05
> -#define PMA8084_SUBTYPE		0x06
> -#define PMI8962_SUBTYPE		0x07
> -#define PMD9635_SUBTYPE		0x08
> -#define PM8994_SUBTYPE		0x09
> -#define PMI8994_SUBTYPE		0x0a
> -#define PM8916_SUBTYPE		0x0b
> -#define PM8004_SUBTYPE		0x0c
> -#define PM8909_SUBTYPE		0x0d
> -#define PM8028_SUBTYPE		0x0e
> -#define PM8901_SUBTYPE		0x0f
> -#define PM8950_SUBTYPE		0x10
> -#define PMI8950_SUBTYPE		0x11
> -#define PM8998_SUBTYPE		0x14
> -#define PMI8998_SUBTYPE		0x15
> -#define PM8005_SUBTYPE		0x18
> -#define PM660L_SUBTYPE		0x1A
> -#define PM660_SUBTYPE		0x1B
> -#define PM8150_SUBTYPE		0x1E
> -#define PM8150L_SUBTYPE		0x1f
> -#define PM8150B_SUBTYPE		0x20
> -#define PMK8002_SUBTYPE		0x21
> -#define PM8009_SUBTYPE		0x24
> -#define PM8150C_SUBTYPE		0x26
> -#define SMB2351_SUBTYPE		0x29
> -
>  static const struct of_device_id pmic_spmi_id_table[] = {
>  	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
>  	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
> @@ -81,42 +55,118 @@ static const struct of_device_id pmic_spmi_id_table[] = {
>  	{ }
>  };
>  
> -static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
> +/**
> + * qcom_pmic_get() - Get a pointer to the base PMIC device
> + *
> + * @dev: the pmic function device
> + * @return: the struct qcom_spmi_pmic* pointer associated with the function device
> + *
> + * A PMIC can be represented by multiple SPMI devices, but
> + * only the base PMIC device will contain a reference to
> + * the revision information.
> + *
> + * This function takes a pointer to a function device and
> + * returns a pointer to the base PMIC device.
> + */
> +const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev)
> +{
> +	struct spmi_device *sdev;
> +	struct device_node *spmi_bus;
> +	struct device_node *other_usid = NULL;
> +	int function_parent_usid, ret;
> +	u32 reg[2];
> +
> +	if (!of_match_device(pmic_spmi_id_table, dev->parent))
> +		return ERR_PTR(-EINVAL);
> +
> +	sdev = to_spmi_device(dev->parent);
> +	if (!sdev)
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * Quick return if the function device is already in the right
> +	 * USID
> +	 */
> +	if (sdev->usid % 2 == 0)
> +		return spmi_device_get_drvdata(sdev);
> +
> +	function_parent_usid = sdev->usid;
> +
> +	/*
> +	 * Walk through the list of PMICs until we find the sibling USID.
> +	 * The goal is the find to previous sibling. Assuming there is no

Probably:  The goal is to find the previous sibling. ?

> +	 * PMIC with more than 2 USIDs. We know that function_parent_usid
> +	 * is one greater than the base USID.
> +	 */
> +	spmi_bus = of_get_parent(sdev->dev.parent->of_node);
> +	do {
> +		other_usid = of_get_next_child(spmi_bus, other_usid);
> +		ret = of_property_read_u32_array(other_usid, "reg", reg, 2);
> +		if (ret)
> +			return ERR_PTR(ret);
> +		sdev = spmi_device_from_of(other_usid);
> +		if (sdev == NULL) {
> +			/*
> +			 * If the base USID for this PMIC hasn't probed yet
> +			 * but the secondary USID has, then we need to defer
> +			 * the function driver so that it will attempt to
> +			 * probe again when the base USID is ready.
> +			 */
> +			if (reg[0] == function_parent_usid - 1)
> +				return ERR_PTR(-EPROBE_DEFER);
> +
> +			continue;
> +		}
> +
> +		if (reg[0] == function_parent_usid - 1)
> +			return spmi_device_get_drvdata(sdev);
> +	} while (other_usid->sibling);
> +
> +	return ERR_PTR(-ENODATA);
> +}
> +EXPORT_SYMBOL(qcom_pmic_get);
> +
> +static inline void pmic_print_info(struct device *dev, struct qcom_spmi_pmic *pmic)
> +{
> +	dev_dbg(dev, "%x: %s v%d.%d\n",
> +		pmic->subtype, pmic->name, pmic->major, pmic->minor);
> +}
> +
> +static int pmic_spmi_load_revid(struct regmap *map, struct device *dev,
> +				 struct qcom_spmi_pmic *pmic)
>  {
> -	unsigned int rev2, minor, major, type, subtype;
> -	const char *name = "unknown";
>  	int ret, i;
>  
> -	ret = regmap_read(map, PMIC_TYPE, &type);
> +	ret = regmap_read(map, PMIC_TYPE, &pmic->type);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
> -	if (type != PMIC_TYPE_VALUE)
> -		return;
> +	if (pmic->type != PMIC_TYPE_VALUE)
> +		return ret;
>  
> -	ret = regmap_read(map, PMIC_SUBTYPE, &subtype);
> +	ret = regmap_read(map, PMIC_SUBTYPE, &pmic->subtype);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(pmic_spmi_id_table); i++) {
> -		if (subtype == (unsigned long)pmic_spmi_id_table[i].data)
> +		if (pmic->subtype == (unsigned long)pmic_spmi_id_table[i].data)
>  			break;
>  	}
>  
>  	if (i != ARRAY_SIZE(pmic_spmi_id_table))
> -		name = pmic_spmi_id_table[i].compatible;
> +		pmic->name = devm_kstrdup_const(dev, pmic_spmi_id_table[i].compatible, GFP_KERNEL);
>  
> -	ret = regmap_read(map, PMIC_REV2, &rev2);
> +	ret = regmap_read(map, PMIC_REV2, &pmic->rev2);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
> -	ret = regmap_read(map, PMIC_REV3, &minor);
> +	ret = regmap_read(map, PMIC_REV3, &pmic->minor);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
> -	ret = regmap_read(map, PMIC_REV4, &major);
> +	ret = regmap_read(map, PMIC_REV4, &pmic->major);
>  	if (ret < 0)
> -		return;
> +		return ret;
>  
>  	/*
>  	 * In early versions of PM8941 and PM8226, the major revision number
> @@ -124,14 +174,16 @@ static void pmic_spmi_show_revid(struct regmap *map, struct device *dev)
>  	 * Increment the major revision number here if the chip is an early
>  	 * version of PM8941 or PM8226.
>  	 */
> -	if ((subtype == PM8941_SUBTYPE || subtype == PM8226_SUBTYPE) &&
> -	    major < 0x02)
> -		major++;
> +	if ((pmic->subtype == PM8941_SUBTYPE || pmic->subtype == PM8226_SUBTYPE) &&
> +	    pmic->major < 0x02)
> +		pmic->major++;
> +
> +	if (pmic->subtype == PM8110_SUBTYPE)
> +		pmic->minor = pmic->rev2;
>  
> -	if (subtype == PM8110_SUBTYPE)
> -		minor = rev2;
> +	pmic_print_info(dev, pmic);
>  
> -	dev_dbg(dev, "%x: %s v%d.%d\n", subtype, name, major, minor);
> +	return 0;
>  }
>  
>  static const struct regmap_config spmi_regmap_config = {
> @@ -144,14 +196,24 @@ static const struct regmap_config spmi_regmap_config = {
>  static int pmic_spmi_probe(struct spmi_device *sdev)
>  {
>  	struct regmap *regmap;
> +	struct qcom_spmi_pmic *pmic;
> +	int ret;
>  
>  	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> +	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
>  	/* Only the first slave id for a PMIC contains this information */
> -	if (sdev->usid % 2 == 0)
> -		pmic_spmi_show_revid(regmap, &sdev->dev);
> +	if (sdev->usid % 2 == 0) {
> +		ret = pmic_spmi_load_revid(regmap, &sdev->dev, pmic);
> +		if (ret < 0)
> +			return ret;
> +		spmi_device_set_drvdata(sdev, pmic);
> +	}
>  
>  	return devm_of_platform_populate(&sdev->dev);
>  }
> diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
> new file mode 100644
> index 000000000000..a8a77be22cfc
> --- /dev/null
> +++ b/include/soc/qcom/qcom-spmi-pmic.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2021 Linaro. All rights reserved.
> + * Copyright (c) 2021 Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#ifndef __QCOM_PMIC_H__
> +#define __QCOM_PMIC_H__
> +
> +#define COMMON_SUBTYPE		0x00
> +#define PM8941_SUBTYPE		0x01
> +#define PM8841_SUBTYPE		0x02
> +#define PM8019_SUBTYPE		0x03
> +#define PM8226_SUBTYPE		0x04
> +#define PM8110_SUBTYPE		0x05
> +#define PMA8084_SUBTYPE		0x06
> +#define PMI8962_SUBTYPE		0x07
> +#define PMD9635_SUBTYPE		0x08
> +#define PM8994_SUBTYPE		0x09
> +#define PMI8994_SUBTYPE		0x0a
> +#define PM8916_SUBTYPE		0x0b
> +#define PM8004_SUBTYPE		0x0c
> +#define PM8909_SUBTYPE		0x0d
> +#define PM8028_SUBTYPE		0x0e
> +#define PM8901_SUBTYPE		0x0f
> +#define PM8950_SUBTYPE		0x10
> +#define PMI8950_SUBTYPE		0x11
> +#define PM8998_SUBTYPE		0x14
> +#define PMI8998_SUBTYPE		0x15
> +#define PM8005_SUBTYPE		0x18
> +#define PM660L_SUBTYPE		0x1A
> +#define PM660_SUBTYPE		0x1B
> +#define PM8150_SUBTYPE		0x1E
> +#define PM8150L_SUBTYPE		0x1f
> +#define PM8150B_SUBTYPE		0x20
> +#define PMK8002_SUBTYPE		0x21
> +#define PM8009_SUBTYPE		0x24
> +#define PM8150C_SUBTYPE		0x26
> +#define SMB2351_SUBTYPE		0x29
> +
> +#define PMI8998_FAB_ID_SMIC	0x11
> +#define PMI8998_FAB_ID_GF	0x30
> +
> +#define PM660_FAB_ID_GF		0x0
> +#define PM660_FAB_ID_TSMC	0x2
> +#define PM660_FAB_ID_MX		0x3
> +
> +struct qcom_spmi_pmic {
> +	unsigned int type;
> +	unsigned int subtype;
> +	unsigned int major;
> +	unsigned int minor;
> +	unsigned int rev2;
> +	const char *name;
> +};
> +
> +struct device;
> +
> +const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev);
> +
> +#endif /* __QCOM_PMIC_H__ */

