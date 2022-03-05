Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF34CE20E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 03:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiCECNv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Mar 2022 21:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiCECNu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2022 21:13:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7451C2D8E
        for <linux-iio@vger.kernel.org>; Fri,  4 Mar 2022 18:13:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so15045249wrg.11
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2022 18:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9xki5/aBHg+JNCs525L+vVcC0rF1VeaYWMM3TPzpvQ=;
        b=orMT1IePVqxhLVeB/qrOvSWbMgnan/OxDacXB+4mpZbYxssATWgB1jvLxX7kWzapRy
         i/U0QXksZr/7s1vWzxqmdDTjbzPGAXNIgqXt8IbLosovts0CRmPaiU8hDjF2jJ4GA2Vp
         efEFqgSeXuN6FVZcRZndviFvfcFS4nPrHLzKLTVYQYApc3Yl8ihHg7i+BnkSa1yWfqTU
         Z2YVLqOq15ZQOWsy02eMipV2Rps80fv2vQgWIc2gT+Rw5LNjk47voMPdweEVTZVtU9xn
         SWDcPl/mdkQBQTwgeueMlt5yypJ4T9Rgtbm+5xR2Mh5HfKBCKWWW+hAYx/xYlSZ/RJPB
         6/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9xki5/aBHg+JNCs525L+vVcC0rF1VeaYWMM3TPzpvQ=;
        b=Gg6zSpvl5pnXhvFvChhLzwuEe/lHsrmVQiguIAmq7BDMicsW5QsQAen/9XkClPIIdC
         DUauoL4Qq7cpDz+BxYEzLY1zvnq3LgcXtve2SuSsV69Lo5TmLmDpUncsErV6ZMWo9Ihv
         cOh+06++P+y1FIMZ0Ybz1qBD7DKhNNnOHbtoLohRreu2Lyi7RVh6Cqj8H8wDxKLQnF2h
         pSz5ZYYpBe5eEpBaWmxW7cqnxtHYwVcePWJIv6yaf0pMU8Avo7q5ORSODReNfEx5LcJV
         LyS6jdTRC/O8Q/NKQJEIVKT5ue5848jx5QfJHUqAYvg2i0eu+k+nCjNPUV6wI11lNnyd
         CYzQ==
X-Gm-Message-State: AOAM532laxioUB1iKB2y4uo04GwMYDG2OFjbTeXOx/Tbb+vzA4v6ylo7
        8qsbA8askB24NGZz8uICzmZYLA==
X-Google-Smtp-Source: ABdhPJzow0UMKo5KaYNTnq4+WEncEdjSRuF7CYtb5n7KepBbRn4SWXDjvN5n2xDUG+K/qurt16M08A==
X-Received: by 2002:a5d:6506:0:b0:1f1:da5e:e077 with SMTP id x6-20020a5d6506000000b001f1da5ee077mr954076wru.405.1646446379104;
        Fri, 04 Mar 2022 18:12:59 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k10-20020adfe3ca000000b001f0329ba94csm7932589wrm.18.2022.03.04.18.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:12:58 -0800 (PST)
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
Subject: [PATCH v10 0/9] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Sat,  5 Mar 2022 02:12:38 +0000
Message-Id: <20220305021247.1020122-1-caleb.connolly@linaro.org>
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
 include/linux/spmi.h                          |    2 +
 include/soc/qcom/qcom-spmi-pmic.h             |   61 +
 12 files changed, 1373 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

-- 
2.35.1

