Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE54CE5A1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiCEP4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Mar 2022 10:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEP4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2022 10:56:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8716FDDF;
        Sat,  5 Mar 2022 07:55:49 -0800 (PST)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K9q6F1ZHhz67Wb2;
        Sat,  5 Mar 2022 23:54:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Sat, 5 Mar 2022 16:55:47 +0100
Received: from localhost (10.47.66.18) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 15:55:46 +0000
Date:   Sat, 5 Mar 2022 15:55:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <amit.pundir@linaro.org>,
        <john.stultz@linaro.org>
Subject: Re: [PATCH v10 0/9] iio: adc: introduce Qualcomm SPMI Round Robin
 ADC
Message-ID: <20220305155543.000076b5@Huawei.com>
In-Reply-To: <20220305021247.1020122-1-caleb.connolly@linaro.org>
References: <20220305021247.1020122-1-caleb.connolly@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.66.18]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  5 Mar 2022 02:12:38 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The RRADC is responsible for reading data about the current and
> voltage from the USB or DC in jacks, it can also read the battery
> ID (resistence) and some temperatures. It is found on the PMI8998 and
> PM660 Qualcomm PMICs.

Hi Caleb,

You've addressed all my feedback so on basis bulk, in LOC at least,
is in IIO I'm assuming I'll take this, probably using an immutable
branch so Lee can pick it up in MFD as well if he needs to.

We are very late in the cycle, so I doubt we'll sneak it in until
next time around now even if the merge window slips back a week
as Linus has hinted it might.

Anyhow, I'll be looking for Acks/RBs from Lee and perhaps from
others who have been involved in earlier versions of this series
before I pick it up.

Thanks,

Jonathan

> 
> The RRADC has to calibrate some ADC values based on which chip fab
> the PMIC was produced in, to facilitate this the patches
> ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
> and ("mfd: qcom-spmi-pmic: read fab id on supported PMICs")
> expose the PMIC revision information and fab_id as a struct and register
> them as driver data in the Qualcomm SPMI PMIC driver so that it can be
> read by the RRADC.
> 
> The first 3 patches add support for looking up an SPMI device from a
> struct device_node, as well as introducing support for looking up the
> base USID of a Qcom PMIC, see patch comments for more details. These
> Address Bjorns comments on v2.
> 
> Changes since v9:
>  * Add back missing copyright, this driver is originally derived from
>    downstream (Thanks Manivannan).
> 
> Changes since v8:
>  * Drop Reported-by for the bugfix on previous revision reported by LKP
>  * Apply Jonathans suggestions
>  * Rework patch 2 ("expose the PMIC revid information to clients") to
>    handle PMICs with a single USID (thanks Dmitry)
> 
> Changes since v7:
>  * Addressed Jonathans comments
>  * Fixed bug reported by LKP
> 
> Changes since v6:
>  * Fix printf format warning in rradc
> 
> Changes since v5:
>  * Add missing EXPORT_SYMBOL_GPL() to
>    ("spmi: add a helper to look up an SPMI device from a device node")
> 
> Changes since v4:
>  * Addressed Jonathan's comments on v4
>  * Reworked the qcom-spmi-pmic patches to properly walk the devicetree
>    to find the base USID. I've tested this on SDM845 which has two PMICs
>    (pm8998 and pmi8998) and I'm able to look up the PMIC revid from all
>    4 USIDs.
> 
> Changes since v3:
>  * Split PMIC patch in two, rework to support function drivers on a
>    sibling USID
>  * Completely rework RRADC driver to make use of the modern IIO
>    framework. This required re-arranging a lot of the equations and
>    results in some lost precision, where relevant I've left comments to
>    explain this. I don't think any of it is significant enough to
>    justify doing post-processing in driver.
> 	Thanks a lot Jonathan and John Stultz for helping me out with
> 	this 
> 
> Changes since v2:
>  * Add missing include (thanks kernel test robot :D)
>  * Rework some confusing function return values, specifically
>    rradc_read_status_in_cont_mode and rradc_prepare_batt_id_conversion
>    both of which didn't correctly handle "ret". This also bought up an
>    issue as the previous implementation didn't actually wait for the
>    channel to be ready. It doesn't seem like that's strictly necessary
>    (same data is reported if I wait for the status to be good or not)
>    but I've included it anyway for good measure.
> 
> Changes since v1:
>  * Rework the RRADC driver based on Jonathan's feedback
>  * Pick up Rob's reviewed by for the dt-binding patch.
> ---
> Caleb Connolly (9):
>   spmi: add a helper to look up an SPMI device from a device node
>   mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
>   mfd: qcom-spmi-pmic: read fab id on supported PMICs
>   dt-bindings: iio: adc: document qcom-spmi-rradc
>   iio: adc: qcom-spmi-rradc: introduce round robin adc
>   arm64: dts: qcom: pmi8998: add rradc node
>   arm64: dts: qcom: sdm845-oneplus: enable rradc
>   arm64: dts: qcom: sdm845-db845c: enable rradc
>   arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
> 
>  .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   54 +
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/qcom-spmi-rradc.c             | 1021 +++++++++++++++++
>  drivers/mfd/qcom-spmi-pmic.c                  |  275 +++--
>  drivers/spmi/spmi.c                           |   17 +
>  include/linux/spmi.h                          |    2 +
>  include/soc/qcom/qcom-spmi-pmic.h             |   61 +
>  12 files changed, 1373 insertions(+), 90 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
>  create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
>  create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
> 

