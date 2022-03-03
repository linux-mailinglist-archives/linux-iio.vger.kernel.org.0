Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39D4CB5B5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 05:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiCCECE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 23:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCCEBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 23:01:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7394015C9FC
        for <linux-iio@vger.kernel.org>; Wed,  2 Mar 2022 20:01:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so4568439wmb.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Mar 2022 20:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qcOeicUxzw8WX6YNAc05GRTwMqRrAQsovI1aTRBfHWU=;
        b=osfrshoYSUClnXe2sXt4a5XWfVLBVXHGUNelA+L1I2SbQ1avCUos9geVkYwFqUHK8l
         mDApJkWDBnwKIHaysRqhGBVH5ErAbkcSbXghiHQZZ0kBMO5zuFkbsGNFyhiGP2lu4jpa
         aZcsMAxWrON3uWwDSFvm5HEjOIvBiH8yzNo+cVT5nHnhs3AuIDsb7shfo1ZLghcXI+Up
         YolGD9fYs/hDlyhMTOymW4+ez6WtGy1wpyHy4lkbcQIUlxXBY+fa2U0b9B/RW0RuujrX
         2WVnaQjDm8qnlz43Vbv8c61XLKfleJfibk+dxHcIztJM0jAU1NyD4cxBHEw7U2Ts8CRL
         5S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qcOeicUxzw8WX6YNAc05GRTwMqRrAQsovI1aTRBfHWU=;
        b=6oIlWsxstvrtjJN0VLMC9iMCIoj3WTTo5iOa8XZ8At4hes4mW80kj9FtVJCh/q27UH
         mxAXr3ki1XJyxzEfAs4bj1rs1DJdUaHv+6MtZJ3vUjEYdu9jXrPEw9rxqUTUutNNbKTm
         nMnV49DrBKPbuTWemIrUpKl3Qkb4gohspahGb3nj8kRoa61W+9h+U5hej6tCR7shmSjv
         gVxjfzZ+Ed2IaD5Uw77//WavfYwKigwBu/235f8l9EoOnzCwzIPoizC2+tP+PvYswlXM
         7Ff+GYZnld6gLGx8eBONEG2TOM2PxirU8LIsYztO2h99Ih6GdCt2o2l8Setd9YXmjd+/
         UeRg==
X-Gm-Message-State: AOAM5334S2F8psOZfMVnH4GhUuEAIpyV9/K5QYvihKHL4GKAnUB4DEMn
        J3wxX0NY1BjUEaDlILxZMUL4xw==
X-Google-Smtp-Source: ABdhPJws04sfpoSRDXFHRg7RKQhO1Ny6cLdZOB0fvZJu7+kmvlF+wYs1WIqCflYTCbKH3g539th15g==
X-Received: by 2002:a7b:c38f:0:b0:385:e56c:8624 with SMTP id s15-20020a7bc38f000000b00385e56c8624mr2250328wmj.19.1646280068985;
        Wed, 02 Mar 2022 20:01:08 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d4e50000000b001f0075f4ca1sm702615wrt.105.2022.03.02.20.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:01:08 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v9 0/9] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Thu,  3 Mar 2022 04:00:26 +0000
Message-Id: <20220303040035.1454103-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

 .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   54 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-rradc.c             | 1020 +++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                  |  275 +++--
 drivers/spmi/spmi.c                           |   17 +
 include/linux/spmi.h                          |    2 +
 include/soc/qcom/qcom-spmi-pmic.h             |   61 +
 12 files changed, 1372 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

-- 
2.35.1

