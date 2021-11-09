Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3587344AD95
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 13:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbhKIMev (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 07:34:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38524 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242554AbhKIMet (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 07:34:49 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A9870Ib025731;
        Tue, 9 Nov 2021 07:32:03 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c711fxsca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 07:32:03 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A9CW2Xv053006
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Nov 2021 07:32:02 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 9 Nov 2021 07:32:01 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 9 Nov 2021 07:32:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 9 Nov 2021 07:32:01 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A9CVsSx007733;
        Tue, 9 Nov 2021 07:31:59 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Date:   Tue, 9 Nov 2021 14:31:26 +0200
Message-ID: <20211109123127.96399-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109123127.96399-1-antoniu.miclaus@analog.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: OXfdd3CMdbGEyk23VHOB_zuftIh7DLPU
X-Proofpoint-GUID: OXfdd3CMdbGEyk23VHOB_zuftIh7DLPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADMV8818 Filter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/filter/adi,admv8818.yaml     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml

diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
new file mode 100644
index 000000000000..d581e236dbdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/filter/adi,admv8818.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMV8818 Digitally Tunable, High-Pass and Low-Pass Filter
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+    Fully monolithic microwave integrated circuit (MMIC) that
+    features a digitally selectable frequency of operation.
+    The device features four independently controlled high-pass
+    filters (HPFs) and four independently controlled low-pass filters
+    (LPFs) that span the 2 GHz to 18 GHz frequency range.
+
+    https://www.analog.com/en/products/admv8818.html
+
+properties:
+  compatible:
+    enum:
+      - adi,admv8818
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  clocks:
+    description:
+      Definition of the external clock.
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: "rf_in"
+
+  clock-output-names:
+    maxItems: 1
+
+  adi,bw-hz:
+    description:
+      Allows the user to increase the Bandpass Filter (BPF) bandwidth
+      in Hz. Normally when invoked by the clk notifier, the driver
+      sets the HPF cutoff close below the frequency and the LPF cutoff
+      close above the frequency, and thus creating a BPF.
+    $ref: /schemas/types.yaml#/definitions/uint64
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      admv8818@0 {
+        compatible = "adi,admv8818";
+        reg = <0>;
+        spi-max-frequency = <10000000>;
+        clocks = <&admv8818_rfin>;
+        clock-names = "rf_in";
+        adi,bw-hz = /bits/ 64 <600000000>;
+      };
+    };
+...
+
-- 
2.33.1

