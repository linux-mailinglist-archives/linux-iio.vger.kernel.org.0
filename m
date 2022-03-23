Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2054E565C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbiCWQaN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbiCWQaH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:30:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE423BD9
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k10so2512744edj.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImWjO9BliYkKUOP8R8MoJSDWIHefk+M95GmJN/O3O34=;
        b=D2UctzQgO6u8cSXQTeksgdgZK6wjOHPjBkMPC9p5wqSUA+AdgVP/16rd4JTJ8QIZag
         SshJ6nu7ov8y5JzysNeFebZxjMf7utn9Y+Aw2OyWwmqSGq/hiCHobFtyLWAOsZDfj9gS
         gFFLq+3k6yXiIf6SYaRkWhmhEiLwP7Rmen5TuzJfJk4Cwx6mI9xuip43BIhi4mUsLPNX
         hlfE/LCkYmc6FMGTQq0VqnkRt1+QSSSVDM2ZKtG7bRl7FnxpXTdXKt/IHLsoI72zw5ll
         pmw29n6RpT9a4aihuIHAoSm6VMPd/kbVbWTavIfwnV/unUiGev67gdNv2UIdQ+6aXWPI
         buSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImWjO9BliYkKUOP8R8MoJSDWIHefk+M95GmJN/O3O34=;
        b=il8zu/xMdGoac5tp0faCjEzyMKDpA6g7GXwL3ArSHbehujZ4OfaQTn8qQwo1oYZbIC
         K+QDgQMGuluvgNGhNecv2FZDrLV+k+qyQAbCLOz1nvjSSm7XnUaTPDbeA9XDDDhNsSus
         4p7HNEIR71/wpetJf+RHL3w4dI9DXBBN+Ty6aZCto1x1l5+ZZTDBZ4C2VsmuWGpwdVjh
         xJHsu63w9OhQyMMAE3uztSZ5VE3E6f+C3Yg704Rk85ELQeyTHw18OMD3I2nU3C9C1fUW
         ETkB5OaYci8LSPivHr0RgrzCpsjpAgHyNcKT3249j+9WuQdqNSHjiRPytFUn+UbIRyww
         zMUw==
X-Gm-Message-State: AOAM532rsVHSRg0iJ9ZqJFA1H1H17KAppcTYUufd41y31fO1o2HvB9sG
        1hYxNnb2DPI4Tdv0cK9bt823/g==
X-Google-Smtp-Source: ABdhPJwtqa9IXBn0CPhC3ymFTqHAs/EABke2Tqin8PNOz/NpPRz0s0cM0Mh30YdqnOx6zhroCOKA8w==
X-Received: by 2002:a05:6402:2342:b0:419:e86:c7d5 with SMTP id r2-20020a056402234200b004190e86c7d5mr1185904eda.92.1648052914267;
        Wed, 23 Mar 2022 09:28:34 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm173306edm.90.2022.03.23.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:28:33 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Caleb Connolly <caleb@connolly.tech>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v13 0/9] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Wed, 23 Mar 2022 16:28:11 +0000
Message-Id: <20220323162820.110806-1-caleb@connolly.tech>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The RRADC is responsible for reading data about the current and
voltage from the USB or DC in jacks, it can also read the battery
ID (resistence) and some temperatures. It is found on the PMI8998 and
PM660 Qualcomm PMICs.

The RRADC has to calibrate some ADC values based on which chip fab
the PMIC was produced in, to facilitate this the patches
("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
and ("mfd: qcom-spmi-pmic: read fab id on supported PMICs")
expose the PMIC revision information and fab_id as a struct and register
them as driver data in the Qualcomm SPMI PMIC driver so that it can be
read by the RRADC.

The first 3 patches add support for looking up an SPMI device from a
struct device_node, as well as introducing support for looking up the
base USID of a Qcom PMIC, see patch comments for more details. These
Address Bjorns comments on v2.

Changes since v12:
 * Apply Krzysztof's suggestions to rradc DT binding docs.

Changes since v11:
 * Remove debug logging which was left in ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
 * Picked up Dmitry's Tested-by and Reviewed-by tags.

Changes since v10:
 * Don't inline spmi_device_from_of()
Reported-by: kernel test robot <lkp@intel.com>

Changes since v9:
 * Add back missing copyright, this driver is originally derived from
   downstream (Thanks Manivannan).

Changes since v8:
 * Drop Reported-by for the bugfix on previous revision reported by LKP
 * Apply Jonathans suggestions
 * Rework patch 2 ("expose the PMIC revid information to clients") to
   handle PMICs with a single USID (thanks Dmitry)

Changes since v7:
 * Addressed Jonathans comments
 * Fixed bug reported by LKP

Changes since v6:
 * Fix printf format warning in rradc

Changes since v5:
 * Add missing EXPORT_SYMBOL_GPL() to
   ("spmi: add a helper to look up an SPMI device from a device node")

Changes since v4:
 * Addressed Jonathan's comments on v4
 * Reworked the qcom-spmi-pmic patches to properly walk the devicetree
   to find the base USID. I've tested this on SDM845 which has two PMICs
   (pm8998 and pmi8998) and I'm able to look up the PMIC revid from all
   4 USIDs.

Changes since v3:
 * Split PMIC patch in two, rework to support function drivers on a
   sibling USID
 * Completely rework RRADC driver to make use of the modern IIO
   framework. This required re-arranging a lot of the equations and
   results in some lost precision, where relevant I've left comments to
   explain this. I don't think any of it is significant enough to
   justify doing post-processing in driver.
	Thanks a lot Jonathan and John Stultz for helping me out with
	this 

Changes since v2:
 * Add missing include (thanks kernel test robot :D)
 * Rework some confusing function return values, specifically
   rradc_read_status_in_cont_mode and rradc_prepare_batt_id_conversion
   both of which didn't correctly handle "ret". This also bought up an
   issue as the previous implementation didn't actually wait for the
   channel to be ready. It doesn't seem like that's strictly necessary
   (same data is reported if I wait for the status to be good or not)
   but I've included it anyway for good measure.

Changes since v1:
 * Rework the RRADC driver based on Jonathan's feedback
 * Pick up Rob's reviewed by for the dt-binding patch.
 ---
Caleb Connolly (9):
  spmi: add a helper to look up an SPMI device from a device node
  mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
  mfd: qcom-spmi-pmic: read fab id on supported PMICs
  dt-bindings: iio: adc: document qcom-spmi-rradc
  iio: adc: qcom-spmi-rradc: introduce round robin adc
  arm64: dts: qcom: pmi8998: add rradc node
  arm64: dts: qcom: sdm845-oneplus: enable rradc
  arm64: dts: qcom: sdm845-db845c: enable rradc
  arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc

 .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   51 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-rradc.c             | 1021 +++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                  |  268 +++--
 drivers/spmi/spmi.c                           |   17 +
 include/linux/spmi.h                          |    3 +
 include/soc/qcom/qcom-spmi-pmic.h             |   61 +
 12 files changed, 1364 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

-- 
2.35.1

