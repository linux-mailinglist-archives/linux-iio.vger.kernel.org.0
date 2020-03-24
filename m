Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52541191542
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 16:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgCXPpw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 11:45:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17763 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728520AbgCXPpw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 11:45:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585064751; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=aFxrEvb5FZ3Oz2BxK2Zd6fZmP3lxuVKKy35InfgXQ9U=; b=foSP3AZS8Zd2Q2W2os3YSWdx3kZs8c4oPyu8hG35dQAe+/NpUOO4BwcZBENqezdhzZHRMfDe
 8Wq/lIVuRnHVbNGomznltUJLApmEaCoHke2XjBBvE8sPcmg4/RlkgMrpG03OC2fZ3OOIKclb
 5nrH+eRdG2/Nmr+VRA8TQEtXIQE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a2b2e.7fd79e01c1f0-smtp-out-n03;
 Tue, 24 Mar 2020 15:45:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3A248C44793; Tue, 24 Mar 2020 15:45:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A458C433CB;
        Tue, 24 Mar 2020 15:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A458C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
From:   Jishnu Prakash <jprakash@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jishnu Prakash <jprakash@codeaurora.org>,
        linux-iio@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: Add PMIC7 ADC bindings
Date:   Tue, 24 Mar 2020 21:14:09 +0530
Message-Id: <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for PMIC7 ADC peripheral. For PMIC7 ADC, all SW
communication to ADC goes through PMK8350, which communicates with
other PMICs through PBS.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
---
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 28 ++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 72db14c..20f010c 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -13,7 +13,7 @@ maintainers:
 description: |
   SPMI PMIC voltage ADC (VADC) provides interface to clients to read
   voltage. The VADC is a 15-bit sigma-delta ADC.
-  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
+  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
   voltage. The VADC is a 16-bit sigma-delta ADC.
 
 properties:
@@ -23,6 +23,7 @@ properties:
       - qcom,spmi-adc5
       - qcom,spmi-adc-rev2
       - qcom,pms405-adc
+      - qcom,spmi-adc7
 
   reg:
     description: VADC base address in the SPMI PMIC register map
@@ -65,6 +66,8 @@ patternProperties:
         description: |
           ADC channel number.
           See include/dt-bindings/iio/qcom,spmi-vadc.h
+          For PMIC7 ADC, the channel numbers are specified separately per PMIC
+          in the PMIC-specific files in include/dt-bindings/iio/.
 
       label:
         description: |
@@ -72,7 +75,7 @@ patternProperties:
             For thermistor inputs connected to generic AMUX or GPIO inputs
             these can vary across platform for the same pins. Hence select
             the platform schematics name for this channel. It is required
-            for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2".
+            for "qcom,spmi-adc5", "qcom,spmi-adc7" and "qcom,spmi-adc-rev2".
         allOf:
           - $ref: /schemas/types.yaml#/definitions/string
 
@@ -85,6 +88,8 @@ patternProperties:
               of 512 will be used.
             - For compatible property "qcom,spmi-adc5", valid values are 250, 420
               and 840. If property is not found, default value of 840 is used.
+            - For compatible property "qcom,spmi-adc7", valid values are 85, 340
+              and 1360. If property is not found, default value of 1360 is used.
             - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
               512 and 1024. If property is not present, default value is 1024.
         allOf:
@@ -109,11 +114,11 @@ patternProperties:
               channel calibration. If property is not found, channel will be
               calibrated with 0.625V and 1.25V reference channels, also
               known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
-              if this property is specified VADC will use the VDD reference (1.875V)
-              and GND for channel calibration. If property is not found, channel
-              will be calibrated with 0V and 1.25V reference channels, also known
-              as absolute calibration.
+            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
+              "qcom,spmi-adc-rev2", if this property is specified VADC will use
+              the VDD reference (1.875V) and GND for channel calibration. If
+              property is not found, channel will be calibrated with 0V and 1.25V
+              reference channels, also known as absolute calibration.
         type: boolean
 
       qcom,hw-settle-time:
@@ -135,6 +140,12 @@ patternProperties:
               Certain controller digital versions have valid values of
               15, 100, 200, 300, 400, 500, 600, 700, 1, 2, 4, 8, 16, 32, 64, 128 ms
               If property is not found, channel will use 15us.
+            - For compatible property "qcom,spmi-adc7", delay = 15us for
+              value 0, 100us * (value) for values < 8, 1ms for value 8
+              and 2ms * (value - 8) otherwise.
+              Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000,
+              4000, 8000, 16000, 32000, 64000, 128000 us.
+              If property is not found, channel will use 15us.
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
 
@@ -147,6 +158,9 @@ patternProperties:
             - For compatible property "qcom,spmi-vadc", valid values
               are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
               If property is not found, 1 sample will be used.
+            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7"
+              and "qcom,spmi-adc-rev2", valid values are: 1, 2, 4, 8, 16.
+              If property is not found, 1 sample will be used.
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
