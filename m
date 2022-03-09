Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463584D3B86
	for <lists+linux-iio@lfdr.de>; Wed,  9 Mar 2022 22:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiCIVB3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 16:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiCIVB3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 16:01:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54394381BB
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 13:00:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so7785837ejc.7
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2022 13:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOOkdtc+VsMF4nCCvIf5NcQCcbr2SGhuCNVVCprZjwQ=;
        b=hX9DN4gJyye6aQvPfJO3TYR2NS6HSMxW4xLJMz8R6n0Jo4QA5MTflP9qoBhi8IQpMa
         P3cgqPQ2KRU8w7EtrLscxGMMLbNbPl1ZeMoMQDv0NzoUA8VqN1HFLAQ8SF7PH+jci4do
         pOEK9bROX0KrUlnVqIZMX1+UbTIiBSfhIlmhnCJVeQ7gDE9HUsa8EC/rlonMhtuiAtp2
         0hBUKa+ZcYWdW3CWLrD/xfMN31/r/1RXtnCG9VQJVAR7z+q5XehmbAzo7KZozB/l2A69
         l0xfR75avro8blTgmGhkFU7UCbEwde5civejQm+DIdMT0snpNDtJI7c3ue23IPsLFpM+
         o3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOOkdtc+VsMF4nCCvIf5NcQCcbr2SGhuCNVVCprZjwQ=;
        b=mX2yw5gvc1jOJ1whaBrto4aDT3n9CZISPI8qoBXBJnVH9Il4gP/5VZQfW2m+AA2jZL
         8ZElaPRqGJwrwPLLvbv/NR3vJoAtUotEaQ/PJN8qSS1tWoQUOVpREjDGNaJ5FuhekXBf
         ysZ0qVwBY55ZZIVaP0YO75JXMdpdqPwGN8A3GWSD6YzOvgD7d2r8iY+DDeYaWp/YgT4D
         WdDf2dvdjg7LvPM6TnlGsOHvQP3efoEMKwwvcRjkQoWhGcQmtTq0ot6qCJ+j4IEFBeXi
         iH55N20ZRq/TFXdcKMG09fI1K3xgOmcfLJEQUECj8DCCA5xpiaRFJGUkohGgmqh9HJh9
         DUzg==
X-Gm-Message-State: AOAM533uf61jnq6eZxpm7ZU7bmZNIz8qryjjfCtPVMRIeJqxaaRjWCjS
        joLPfYpQe1BUkEUQIFV/faAXdwGrRNAHOw==
X-Google-Smtp-Source: ABdhPJyxmX7IGNmRTjq/Q7NNpOpW8d/jy2C8X8jYmZpAAGYKia+8FbstgplJ60prpFCuLIEhULTMnA==
X-Received: by 2002:a17:907:d92:b0:6da:7ac4:533c with SMTP id go18-20020a1709070d9200b006da7ac4533cmr1530088ejc.234.1646859627870;
        Wed, 09 Mar 2022 13:00:27 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b006da815e14e2sm1114743ejg.37.2022.03.09.13.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:00:27 -0800 (PST)
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
        john.stultz@linaro.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v11 0/9] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Wed,  9 Mar 2022 21:00:05 +0000
Message-Id: <20220309210014.352267-1-caleb.connolly@linaro.org>
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

 .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   54 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-rradc.c             | 1021 +++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                  |  275 +++--
 drivers/spmi/spmi.c                           |   17 +
 include/linux/spmi.h                          |    3 +
 include/soc/qcom/qcom-spmi-pmic.h             |   61 +
 12 files changed, 1374 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

-- 
2.35.1

