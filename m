Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F541491D
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfEFLq0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 07:46:26 -0400
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:56078
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfEFLq0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 May 2019 07:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOrVVUQBuCAKNPw82oXnZJu1DZvR2w6IdPtX8WOPBr4=;
 b=jgVoXpuT+ACrP97yLy7cE6ie2TO8Gij6vXXxBcJ34ZZ4oicsaaD7bBU1wFuhfNdstcJoERB204mqStsuAYwHGEJZlY7bUkG4Z6f7WEcebRR1VqbNLnRnkUUrquIqIA+fS86S9ZPzCHn0+TRtfs9TajKf23t9qdC5F2T2kbkxQO8=
Received: from DM5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:4:3b::17) by
 MWHSPR01MB120.namprd03.prod.outlook.com (2603:10b6:301:2e::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 11:46:22 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by DM5PR03CA0028.outlook.office365.com
 (2603:10b6:4:3b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Mon, 6 May 2019 11:46:22 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Mon, 6 May 2019 11:46:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x46BkL3u012598
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 May 2019 04:46:21 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 6 May 2019
 07:46:20 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC][PATCH] dt-bindings: iio: accel: add adi,adxl345.yaml binding
Date:   Mon, 6 May 2019 14:46:10 +0300
Message-ID: <20190506114610.28083-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(8936002)(50226002)(86362001)(53416004)(305945005)(7636002)(7696005)(966005)(486006)(336012)(186003)(51416003)(478600001)(126002)(50466002)(44832011)(426003)(476003)(2616005)(48376002)(26005)(77096007)(70586007)(70206006)(47776003)(246002)(106002)(36756003)(54906003)(53376002)(107886003)(2906002)(5660300002)(8676002)(110136005)(4326008)(6306002)(316002)(16586007)(1076003)(356004)(6666004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHSPR01MB120;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18511072-1e2f-49d1-1dc6-08d6d21875e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:MWHSPR01MB120;
X-MS-TrafficTypeDiagnostic: MWHSPR01MB120:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <MWHSPR01MB120525B34B08630AD0FA16CF9300@MWHSPR01MB120.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0029F17A3F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YJE+UXf2JwyJKQ14s6eEVptHy+CONZkF/mM/GyHDIic+cVBCWc0khyaAxqNbwbpwJVvElNgjTmwPYo73eczdOo2MxYTYztPPHE3QcP8y/ErXbuCd+zoDX3vZx2VHFHfIicryG8MBhvVkGB1HovhNvjYdo6tkQDM5yf5wSMNoBnUWNfWTN3SXTMVNw4CoR2xK/MUrJIY2L3qNL7i317Pvd9qx37we7ThD7XACeRjc+QPHZIEiP3mgPmUnV85/EDezIrvRSm3msbGK5y5X7FUCviCYSeSitiagIbpEquuWH7FCO9ac6Y3RoH18yXRgHuvhPUgZZFSMWIpkF28LpqnvntoFJoqgMavV6iIEKydT9ktDRiX5FmMnRXwLhhpkRlYv9TnH6f1m5lwe3ROX+fYCNmjLmtvDlw4iynMO7OmGgCQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2019 11:46:21.6295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18511072-1e2f-49d1-1dc6-08d6d21875e6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a YAML binding for the Analog Devices ADXL345 I2C/SPI
accelerometer.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

And now for the RFC part.
Normally, I would dig into source-code to try to figure this out, but at
this point-in-time, I am low on time/energy to do this.
And maybe this helps trigger a discussion about this.

Apologies if this has been coverted on the devicetree mailing list, but
at least we'd get some coverage on the IIO list (with this).

The ADXL345 device (as others) supports both I2C & SPI interfaces.

Question1: do we write 2 YAML files, or 1 ? I was looking at Zephyr (for
some ideas/reference) but it seems to me that the YAML DT binding format is
different than this one ? They write 2 files for ADXL372 (1 for SPI, 1 for
I2C).

Question1-a: one thing is that SPI requires some props to be `required`
that would not be required for the I2C binding. This could be solved by
doing 2 files, but if doing 1 YAML file, is there a way to do conditional
`required` ? i.e. property is required if `SPI` ? not sure how to check for
SPI vs I2C, it would be interesting (at some point) to somehow enforce
SPI/I2C bindings correctness.

Question2: `make dt_binding_check` seems to generate only the first
example. Is this known behavior, or do I need to take something else into
consideration ?

Question3: one idea that was neat in Zephyr, is that there is a 'inherits'
+ `!include` mechanism for including common SPI & I2C device stuff. It
would be neat to have this. Is there a way to do this now, or maybe this
would come later ? Maybe, just having a way to include a YAML file into
another would be interesting.

 .../bindings/iio/accel/adi,adxl345.yaml       | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
new file mode 100644
index 000000000000..246b90c07aaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl345.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Driver for Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
+    http://www.analog.com/en/products/mems/accelerometers/adxl345.html
+    http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - adi,adxl345
+              - adi,adxl375
+
+  reg:
+    description:
+      The I2C address or SPI chip select number of the sensor
+    maxItems: 1
+
+  spi-cpha:
+    description:
+      SPI clock phase must be set, to select SPI mode 3
+
+  spi-cpol:
+    description:
+      SPI clock polarity must be set, to select SPI mode 3
+
+  interrupts:
+    description:
+      A variable number of interrupts warrants a description of what conditions
+      affect the number of interrupts. Otherwise, descriptions on standard
+      properties are not necessary.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    /* Example for a I2C device node */
+    accelerometer@2a {
+         compatible = "adi,adxl345";
+         reg = <0x53>;
+    };
+  - |
+    /* Example for a SPI device node */
+    accelerometer@0 {
+         compatible = "adi,adxl345";
+         reg = <0>;
+         spi-max-frequency = <5000000>;
+         spi-cpol;
+         spi-cpha;
+    };
-- 
2.17.1

