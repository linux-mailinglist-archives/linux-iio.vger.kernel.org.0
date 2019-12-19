Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F931263E8
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 14:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLSNsh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 08:48:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37934 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbfLSNsh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 08:48:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJDUGaJ027299;
        Thu, 19 Dec 2019 08:48:23 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvtfdmjkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 08:48:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy++AH8UXK29tNwHXid8b2s8bpWxLWX+r97eupZKNKvklgdRsPp7TA2is5CzTL43A85cGWS8HX0K2jaTZHyoB6Fm9zBdBWfaJ+KKfuZQCMfbUURTwJpoExXSuG1+qgAaP8WL1MnvtOjKfKn7Yy9KCIVOaHViE5X6xcaYh5odwfY9ySctMho8zeiI2gIWnSN7sGlyZ1bI1jhYRLS3NfGLbqQgBvVTB+IsEEm5VxzF2koG6I+APsIQQCCtZmTfV9B3XDj8GGizqkomrDQrXkXRw614xB25VBflacSrNr1mYCcJMIJLzHSu0RoQEeR482gG5gOzWrmbnCA2Tpv8gcplrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcOwbZEITo+JHmjlLafWq0lTO3W0XjOk5eHaQuAX2Fs=;
 b=kdynAe7C/yUXlzJjc1j6tFKzIDuNRJu6eyEMxc6llaFsT2+NbyimRyvyXmuQ0YzjxXPo4B/PnHtioNL1gNAilcYeGtXV70ps2UlXXuh0Nd1tShGUJrsMYCmEdnIcyqV8rfWdhb9LbLUGP/hEmzfODYlfEiWpXCd1OHijZOuxaOEiWm7HlBspugwD5BAG3ejgl4Ebz8DQzYhTolmlgS07hqM6vb0/E3+hej0oWcJbWC34w2nWtt2Axns7g80k6AbN9MTJ8OWcQpUwEBir5hnqS83beOs5qsp8KtytqoUjYsDOqM/6kDtxnBS7U6ND67H+SDtnPOmvM3JcTJvjWhPplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcOwbZEITo+JHmjlLafWq0lTO3W0XjOk5eHaQuAX2Fs=;
 b=WArJK+uXv+Pt9/9u9ZMaIagmAPsn3Rvo8tlz6eKozQDTVTsNVb5xSc51A63VS5a0T2J6VO9aVbJVQK3BfvvRtJ5x3aVYudmykzC/6NLmKk0xOB2nGjkJh5q/a/+Wri8uwAiR1TnFFXzBSjE4X0X7DPtc+/svRJFtRD3dHJABD+Y=
Received: from DM6PR11CA0061.namprd11.prod.outlook.com (2603:10b6:5:14c::38)
 by BN7PR03MB3412.namprd03.prod.outlook.com (2603:10b6:406:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 19 Dec
 2019 13:48:22 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::17) by DM6PR11CA0061.outlook.office365.com
 (2603:10b6:5:14c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13 via Frontend
 Transport; Thu, 19 Dec 2019 13:48:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Thu, 19 Dec 2019 13:48:20 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBJDmIJ1015762
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:48:19 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 05:48:17 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 05:48:16 -0800
Received: from mircea-Latitude-E6540.ad.analog.com ([10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJDmBON001170;
        Thu, 19 Dec 2019 08:48:12 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/3] dt-bindings: iio: frequency: Add docs for LTC6952
Date:   Thu, 19 Dec 2019 15:48:08 +0200
Message-ID: <20191219134810.6677-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6916009)(86362001)(4326008)(107886003)(5660300002)(2906002)(54906003)(426003)(7696005)(2616005)(336012)(26005)(186003)(70586007)(70206006)(7636002)(246002)(36756003)(316002)(44832011)(8676002)(1076003)(966005)(356004)(6666004)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3412;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1697f72a-4fab-485a-c30b-08d7848a1c0e
X-MS-TrafficTypeDiagnostic: BN7PR03MB3412:
X-Microsoft-Antispam-PRVS: <BN7PR03MB3412023BF8CFB6CC2B7ADB1E81520@BN7PR03MB3412.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQaA5hw5eaxgLvsR8ghJghXheVbYOpXwwXOA9dh4UujgdgNuvUarIfu6WjCMytn/lgo6pQVL5eF0fhPXkRUI4Qi09udzMputBuFra33D6veNEuYGphymRN4QXGGsdCm8Ld2FXiSCyHDJgxSH9LK3N0k5IkhX9fphIpbStpWNQTt8ZBrTNDEDY9RH7o+d3Lg6fLedawUbDlbn/qoL9RDk0+ApICMKENIUSlQxPo1kbK9A2GyLaZSx7BELuHSGEVYG980vfigPwgC3SL09ynb+X3STvFQW6Oiv+lU8BIWh3Bqvdb3IVJ5L2W2rU9gBsdUbVC+EaubsHbubOZ0eQu0efr9lId2VaXybLZNdDAUv+O+hH/qvCd6Q2EULcaiMjMRVDFPTnXN5XTHui62ANOuVTEILj4GAsL5CUC1zVsO5wk1lat1o1u2HXU+xXJ+Vgd4bsbbvs4QN/jHSuRszzDXSfDu5ChGlSir5nEScgvh6O84=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 13:48:20.5415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1697f72a-4fab-485a-c30b-08d7848a1c0e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3412
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document support for Analog Devices LTC6952 ultralow jitter, 4.5GHz PLL
with 11 outputs and JESD204B/C support.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 .../bindings/iio/frequency/adi,ltc6952.yaml   | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml
new file mode 100644
index 000000000000..a28c773c3948
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/frequency/adi,ltc6952.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC6952 ultralow jitter, JESD204B/C clock generation IC.
+
+maintainers:
+  - Mircea Caprioru <mircea.caprioru@analog.com>
+
+description: |
+  Analog Devices LTC6952 ultralow jitter, JESD204B/C clock generation IC.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc6952.pdf 
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc6952
+
+  reg:
+    maxItems: 1
+
+  clock-output-names:
+    description: |
+      Clock output signal names indexed by the first cell in the clock
+      specifier (see clock/clock-bindings.txt)
+    maxItems: 1
+
+  adi,vco-frequency-hz:
+    description: |
+      VCO input frequency. This is fed to the internal distribution path and
+      feedback dividers.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+  adi,ref-frequency-hz:
+    description: |
+      Reference input frequency. This is fed in the reference divider.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clock-output-names
+
+patternProperties:
+  "^channel@[0-9]$":
+    type: object
+    description: Represents the external channels which are connected to the device.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 11 channels numbered from 0 to 10.
+        maxItems: 1
+
+      adi,extended-name:
+        description: Descriptive channel name.
+        maxItems: 1
+
+      adi,divider:
+        description: |
+          Channel divider. This divides the incoming VCO frequency.
+        maxItems: 1
+
+      adi,digital-delay:
+        description: |
+          Each output divider can have the start time of the output delayed by
+          integer multiples of half of the VCO period after a synchronization
+          event.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 0
+          - maximum: 4095
+        maxItems: 1
+
+      adi,analog-delay:
+        description: |
+          Each output has a fine analog delay feature to further adjust its
+          output delay time (tADELx) in small steps.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 0
+          - maximum: 63
+        maxItems: 1
+
+    required:
+      - reg
+
+examples:
+   - |
+     ltc6952@0 {
+       compatible = "adi,ltc6952";
+       reg = <0>;
+
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       spi-max-frequency = <10000000>;
+
+       clock-output-names = "ltc6952_out0", "ltc6952_out1", "ltc6952_out2",
+         "ltc6952_out3", "ltc6952_out4", "ltc6952_out5", "ltc6952_out6",
+         "ltc6952_out7", "ltc6952_out8", "ltc6952_out9", "ltc6952_out10";
+       #clock-cells = <1>;
+
+       adi,vco-frequency-hz = <4000000000>;
+       adi,ref-frequency-hz = <100000000>;
+
+       ltc6952_c0: channel@0 {
+         reg = <0>;
+         adi,extended-name = "REF_CLK";
+         adi,divider = <10>;
+         adi,digital-delay = <100>;
+         adi,analog-delay = <0>;
+       };
+
+       ltc6952_c1: channel@1 {
+         reg = <1>;
+         adi,extended-name = "TEST_CLK";
+         adi,divider = <10>;
+       };
+     };
-- 
2.17.1

