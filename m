Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9FC7651DB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjG0LCQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjG0LCO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 07:02:14 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA21FED;
        Thu, 27 Jul 2023 04:02:13 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RAS5SV027907;
        Thu, 27 Jul 2023 07:02:10 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s36afnrdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:02:10 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36RB28Fl032974
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 07:02:08 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Jul 2023 07:02:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Jul 2023 07:02:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Jul 2023 07:02:06 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36RB1urn001199;
        Thu, 27 Jul 2023 07:01:58 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/2] dt-bindings:iio:frequency:admv1013: add vcc regs
Date:   Thu, 27 Jul 2023 14:01:20 +0300
Message-ID: <20230727110121.93546-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MnZL5oJ9i-3826ZHf8AnedJwyTjco8kq
X-Proofpoint-ORIG-GUID: MnZL5oJ9i-3826ZHf8AnedJwyTjco8kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270098
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add bindings for the VCC regulators of the ADMV1013 microware
upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - make the vcc regulators as required.
 .../bindings/iio/frequency/adi,admv1013.yaml  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
index fc813bcb6532..f2eb2287ed9e 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
@@ -39,6 +39,46 @@ properties:
     description:
       Analog voltage regulator.
 
+  vcc-drv-supply:
+    description:
+      RF Driver voltage regulator.
+
+  vcc2-drv-supply:
+    description:
+      RF predriver voltage regulator.
+
+  vcc-vva-supply:
+    description:
+      VVA Control Circuit voltage regulator.
+
+  vcc-amp1-supply:
+    description:
+      RF Amplifier 1 voltage regulator.
+
+  vcc-amp2-supply:
+    description:
+      RF Amplifier 2 voltage regulator.
+
+  vcc-env-supply:
+    description:
+      Envelope Detector voltage regulator.
+
+  vcc-bg-supply:
+    description:
+      Mixer Chip Band Gap Circuit voltage regulator.
+
+  vcc-bg2-supply:
+    description:
+      VGA Chip Band Gap Circuit voltage regulator.
+
+  vcc-mixer-supply:
+    description:
+      Mixer voltage regulator.
+
+  vcc-quad-supply:
+    description:
+      Quadruppler voltage regulator.
+
   adi,detector-enable:
     description:
       Enable the Envelope Detector available at output pins VENV_P and
@@ -69,6 +109,16 @@ required:
   - clocks
   - clock-names
   - vcm-supply
+  - vcc-drv-supply
+  - vcc2-drv-supply
+  - vcc-vva-supply
+  - vcc-amp1-supply
+  - vcc-amp2-supply
+  - vcc-env-supply
+  - vcc-bg-supply
+  - vcc-bg2-supply
+  - vcc-mixer-supply
+  - vcc-quad-supply
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
@@ -87,6 +137,16 @@ examples:
         clocks = <&admv1013_lo>;
         clock-names = "lo_in";
         vcm-supply = <&vcm>;
+        vcc-drv-supply = <&vcc_drv>;
+        vcc2-drv-supply = <&vcc2_drv>;
+        vcc-vva-supply = <&vcc_vva>;
+        vcc-amp1-supply = <&vcc_amp1>;
+        vcc-amp2-supply = <&vcc_amp2>;
+        vcc-env-supply = <&vcc_env>;
+        vcc-bg-supply = <&vcc_bg>;
+        vcc-bg2-supply = <&vcc_bg2>;
+        vcc-mixer-supply = <&vcc_mixer>;
+        vcc-quad-supply = <&vcc_quad>;
         adi,quad-se-mode = "diff";
         adi,detector-enable;
       };
-- 
2.41.0

