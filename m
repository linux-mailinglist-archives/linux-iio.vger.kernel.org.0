Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33844B768B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiBOQz0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 11:55:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbiBOQz0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 11:55:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437F3117C84
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k41so10541109wms.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcPH4oH9GnF8hGwcWO7jHpeOxnV4mrgJbNMQI2Ecch0=;
        b=dq7sNddLWYcmWkSf5MYvhBmg2CbWwx06Z8YIS29fybZDdqlnPMacTIRENZVSoUu+xb
         xIgx88zabYzQ0hDlxk0cLhhoCeP5BsIQ7Z4WYQx3ZvpN+WumiPXvBEDbifs/hxuInN8w
         CWFA6Z6T/grY53gHv/dnYKGuR5lAltnMhTYKVuG6ZzuUE8js0RUIL5/31gir/0nnjCuq
         PHq0ERUAZT3pXroFMLasKpNCAeRue+YGnQuyOJpgbCifYsiCQFh6kx2m3JqSXEq8ZzOe
         MIA3WoyvPmz0GCIcrO85HWy3200zYewK6oqRS3F1PRHUqny5hClViNCfBl1XPvy8Fe9W
         Be0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcPH4oH9GnF8hGwcWO7jHpeOxnV4mrgJbNMQI2Ecch0=;
        b=fJHMYzFgTXzBtuLChpVCPTbwH7+po7t1STlADje5OTtSMSNPFV7OBnb2amqoUH8hHs
         zCjGGo7dKc2+s9NROtSn/w37cHERzmOix+2hjj07uwpj45d0EjT2bbL+oIA7PyXbztAD
         UD9cPCS5JG+AvozpmDL5wSbA6tmBhLVkxvZhyOVCVeUkUEP5bHNtx5Pilkp0QupLCMrf
         qdinkKbdYL5VKrPiWQn+BmfGmB6bhaL0tjMNTyCGUn9ABrIcqObeBXaoJ2GqgWS7V2xv
         YJtQKdd323m4ujUEl0vv7PbPL7VFRBc1uZIKyoctcjIMMnryHJpqETG0Cljr2ANsSSuu
         Y55Q==
X-Gm-Message-State: AOAM531aC5nKSq7rrqjlLjqF1/upGACDZwXTiNORp6ztpH/5sb1pTDhT
        PRWT8Q1rSsZHXjWrGDRbFxG+Kw==
X-Google-Smtp-Source: ABdhPJx+aFJMloZ6hU43Nu2XRhwrQXtRTsBANIfJyHcQ9qupap4v/vQ9sX3L0w3vgvdGI8GhOgZsog==
X-Received: by 2002:a05:600c:34cf:b0:37b:d0dc:ea9 with SMTP id d15-20020a05600c34cf00b0037bd0dc0ea9mr3822365wmq.97.1644944112793;
        Tue, 15 Feb 2022 08:55:12 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f14sm15373652wmq.3.2022.02.15.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:12 -0800 (PST)
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
Subject: [PATCH v5 0/9] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Tue, 15 Feb 2022 16:54:47 +0000
Message-Id: <20220215165456.1205583-1-caleb.connolly@linaro.org>
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

 --

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
 drivers/iio/adc/qcom-spmi-rradc.c             | 1016 +++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                  |  183 ++-
 drivers/spmi/spmi.c                           |   16 +
 include/linux/spmi.h                          |    2 +
 include/soc/qcom/qcom-spmi-pmic.h             |   61 +
 12 files changed, 1308 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

-- 
2.35.1

