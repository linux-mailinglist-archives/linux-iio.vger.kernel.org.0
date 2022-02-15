Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE264B77DA
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiBORKQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 12:10:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbiBORKP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 12:10:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BB11ADD9
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h6so33245081wrb.9
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgbvedyHGhUjE1oZGS3GkCNE9P0anQzjS/ZoNbklbBg=;
        b=v3izdjS8nvQzw3l0l6wzBoMZUv98IQLUb8OGj9S1dfaF+hr2ZxSDvf9zjUc68yXWgX
         iPlbVEVR9JS1s45gPmy/uVUZhmucoUuqxRz3+CLRI4/4Li13ZtAoR5362bA4UzHA34+U
         EMnvLY0S572MWZY78C3rHh7OB6S4e9GZHMRzocBkTSi/0mJ54E+0gXHczldjy620A3ot
         aCdEZyW01TeI4mhCRgMQ3tSijjoWtk/4sX7zc+jK6G+lGEUPVNbvSil231Cjn+EiHkPO
         M79wLyVPDcKzO1TNpQK0id6OSNWmj/AtGs4RMRsWULqKVn9cVqVt+Z/3qk08rZu4A9g2
         yf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgbvedyHGhUjE1oZGS3GkCNE9P0anQzjS/ZoNbklbBg=;
        b=5b/fL/uYJPsloInGQok4XYZXJ2padgjgwnenk9jiS2Bn920wEHCRuYensj6gNXv64u
         aXpzv3B9B31FQni4WJF98bl8WazQCAobtYan8jEl1KiefXC8mFbAMLd3GHDMopR0ZkzK
         0d/qQvJWmpt08j9iteimeth1DSU2wAi3QhzlDnTQoYn+EipOYVN+xNG0JlMrOGvtciwv
         fAOI1+l7NQTKrqjxdQPRMVCbabFX1PApJsUxTcD8GgBH7rvhGSTB7VPylIMQQv+7VuhC
         5bAQRwFrZhUVkPXEHXQgT0sERQFe4SvQW6J60YYKZFkxutKIe8sVY5c9+DTwDioeqfTr
         KGwA==
X-Gm-Message-State: AOAM5320zSrCuoM8S9pV86RH+S2ocRAimIx8U+wX67707626IoiNWJrM
        nrDJiBrckx78aWDmvAgrnqrcNA==
X-Google-Smtp-Source: ABdhPJxMFDGSGt2aeamPKqVOboa+lW9lqACJ0tsvpyghtMpw93tYnmhzyHl2W0N1U95w9tzknzi5sQ==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr4034231wri.645.1644945003305;
        Tue, 15 Feb 2022 09:10:03 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5sm15558474wmk.38.2022.02.15.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:02 -0800 (PST)
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
Subject: [PATCH v6 0/9] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Tue, 15 Feb 2022 17:09:42 +0000
Message-Id: <20220215170951.1233375-1-caleb.connolly@linaro.org>
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
 drivers/spmi/spmi.c                           |   17 +
 include/linux/spmi.h                          |    2 +
 include/soc/qcom/qcom-spmi-pmic.h             |   61 +
 12 files changed, 1309 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

-- 
2.35.1

