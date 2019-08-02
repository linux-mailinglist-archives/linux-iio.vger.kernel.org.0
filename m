Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97077F457
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2019 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407120AbfHBKE1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Aug 2019 06:04:27 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45440 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391983AbfHBKE0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Aug 2019 06:04:26 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72A2Le6010589;
        Fri, 2 Aug 2019 06:03:47 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2055.outbound.protection.outlook.com [104.47.50.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u4ddxrvrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 06:03:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A732m5YyNFT32VZzkj5QvklZiKtAp+iVAOtLZ6Xtd2hZnsjICA7IlYxJO9GvzaMRQcACgH3zT88gokfNPjbncSLymv998VkKyAUK2OKvLy4cSmFr9Pq29ic670WRv7hbKoiD2oOHdBt03Ne5cLogkhy+ejNAQyIGkHiV1NwZqklLx9qWz30beL91CbzrXIkaEAog2u3RvQd+fHavdCUokAjSfI5hqq77KuYqFz37z65WKvjuqBX8DBFkrUqhBDdWEoyHJ2SAvQAcrjqAHhMDW9BmR3nH3Te0GC7KoytbhT2ZH0Xxy/3q4gLuFy3Zw64F8tRbbuuTKCD+3WJBVYI2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEmF0mK+wxOiWYtr2kD77YT9/TZe6zsyYelvmcnLZmw=;
 b=ZQ8O8XPlapeHa9E1rntOIxAWwaCrmA+tnmeb+zFEAOfrDrSNWkfcz8ftyf4wtOfv/yG1ZdPKs3JBivBXxPjWO9dz9anXGNKpCjJGmR+xp77Rhc+cHTcrRuFsXPkBMdz3jhip5AmTc7+mJzvXUwKlleWbYEgJYL/zs+ZJfdt8XyNeUYk2KmfrLX3T5AsAVip23QWqRqKSvbacxlIN6+IRNOfi8tDThG3tDx+sHrGuEd+cuwCglhJHLUuxKyG8w0i/yZYycxXrgQ/OOgXXF4PmeeZu/+kPz9iSKS6i23saytBnTBT21ZTZizhEMCHLQqGgS3kw3+2jrn6WM9NBiovjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEmF0mK+wxOiWYtr2kD77YT9/TZe6zsyYelvmcnLZmw=;
 b=wjhxpA5PWGjlTWtr5Iv5aXLX+iuF4s96yWew8JnarKkNmgsp/19cMFti8NTtuU5tiLka5U/EN6BjR0IydvnitkanS2v21Cc0jclWVOK+MiCHQkFsVQpMfBelBpDrxLvJp/ZoV8k5lH4Gm6+x0/D3dkpbnFxQlD7kupJfjUt9FOI=
Received: from BN3PR03CA0109.namprd03.prod.outlook.com (2603:10b6:400:4::27)
 by BYAPR03MB3783.namprd03.prod.outlook.com (2603:10b6:a03:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Fri, 2 Aug
 2019 10:03:45 +0000
Received: from BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN3PR03CA0109.outlook.office365.com
 (2603:10b6:400:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.13 via Frontend
 Transport; Fri, 2 Aug 2019 10:03:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT024.mail.protection.outlook.com (10.152.77.62) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Fri, 2 Aug 2019 10:03:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x72A3i9q025318
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 2 Aug 2019 03:03:44 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 2 Aug 2019 06:03:44 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/4] dt-bindings: iio: adc: Migrate AD7606 documentation to yaml
Date:   Fri, 2 Aug 2019 13:03:03 +0300
Message-ID: <20190802100304.15899-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802100304.15899-1-beniamin.bia@analog.com>
References: <20190802100304.15899-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(199004)(189003)(6666004)(356004)(6916009)(107886003)(53376002)(14444005)(966005)(4326008)(2906002)(2870700001)(6306002)(5820100001)(36756003)(7416002)(478600001)(50226002)(1076003)(50466002)(2351001)(7636002)(106002)(305945005)(316002)(246002)(54906003)(5660300002)(70586007)(44832011)(486006)(70206006)(76176011)(23676004)(8676002)(47776003)(11346002)(26005)(126002)(186003)(446003)(7696005)(8936002)(476003)(2616005)(426003)(86362001)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3783;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589fdbc7-ed29-4246-cea4-08d71730b49b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB3783;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3783:
X-MS-Exchange-PUrlCount: 5
X-Microsoft-Antispam-PRVS: <BYAPR03MB3783248C9961033E184EAB55F0D90@BYAPR03MB3783.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 011787B9DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2Nc+Mug6aNM8wdbg1ZStVcXzX6wPivp2F6HBPjHdqGckWQxz9HdGfLhXmnkdg3jvrFmWMxAQD1lWpHC31xGyV6dAPP2293fQ6zj/lu8dZQ2EdiKQfdorvEBtSufcoRMeH+KXxsfI+wgjIpcnW/pdQ/tk4+PAeb9n7m45kyyzd2ardD6EYOyvWr3sJYKRBKfTmbPPWMeofB3d0KvIOdT2c2BD9wI8KXPe/+sq/GKSHj/Ma2ialNg2XzplVyZ5nOTf7LzkmK7tRXuFzExWNyXvFcfgYdEj1j++soqtHtUUG+iqgf0qdlAn/YYeIO8RuXt5il2YLnxyRSL0P/aTxsxbHJyVkRil4GCPkpQPSa7Cz1BGLDwhKjf2Tjbt1cw97gIxSvmnudeO+r4bmeEQRKcjqyNcVaIgnYC5qIfpG1TiPEo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 10:03:45.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589fdbc7-ed29-4246-cea4-08d71730b49b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3783
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation for ad7606 was migrated to yaml, the new Linux Kernel
standard.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 .../bindings/iio/adc/adi,ad7606.yaml          | 134 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 2 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
new file mode 100644
index 000000000000..509dbe9c84d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7606 Simultaneous Sampling ADC
+
+maintainers:
+  - Beniamin Bia <beniamin.bia@analog.com>
+  - Stefan Popa <stefan.popa@analog.com>
+
+description: |
+  Analog Devices AD7606 Simultaneous Sampling ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7605-4
+      - adi,ad7606-8
+      - adi,ad7606-6
+      - adi,ad7606-4
+      - adi,ad7616
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  adi,conversion-start-gpios:
+    description:
+      Must be the device tree identifier of the CONVST pin.
+      This logic input is used to initiate conversions on the analog
+      input channels. As the line is active high, it should be marked
+      GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. If specified,
+      it will be asserted during driver probe. As the line is active high,
+      it should be marked GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  standby-gpios:
+    description:
+       Must be the device tree identifier of the STBY pin. This pin is used
+       to place the AD7606 into one of two power-down modes, Standby mode or
+       Shutdown mode. As the line is active low, it should be marked
+       GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  adi,first-data-gpios:
+    description:
+      Must be the device tree identifier of the FRSTDATA pin.
+      The FRSTDATA output indicates when the first channel, V1, is
+      being read back on either the parallel, byte or serial interface.
+      As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,range-gpios:
+    description:
+      Must be the device tree identifier of the RANGE pin. The polarity on
+      this pin determines the input range of the analog input channels. If
+      this pin is tied to a logic high, the analog input range is ±10V for
+      all channels. If this pin is tied to a logic low, the analog input range
+      is ±5V for all channels. As the line is active high, it should be marked
+      GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,oversampling-ratio-gpios:
+    description:
+      Must be the device tree identifier of the over-sampling
+      mode pins. As the line is active high, it should be marked
+      GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,sw-mode:
+    description:
+      Software mode of operation, so far available only for ad7616.
+      It is enabled when all three oversampling mode pins are connected to
+      high level. The device is configured by the corresponding registers. If the
+      adi,oversampling-ratio-gpios property is defined, then the driver will set the
+      oversampling gpios to high. Otherwise, it is assumed that the pins are hardwired
+      to VDD.
+    maxItems: 1
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - avcc-supply
+  - interrupts
+  - adi,conversion-start-gpios
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+                compatible = "adi,ad7606-8";
+                reg = <0>;
+                spi-max-frequency = <1000000>;
+                spi-cpol;
+
+                avcc-supply = <&adc_vref>;
+
+                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+
+                adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+                reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+                adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+                adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH
+                                                &gpio 23 GPIO_ACTIVE_HIGH
+                                                &gpio 26 GPIO_ACTIVE_HIGH>;
+                standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+                adi,sw-mode;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 052d7a8591fb..d2e465772071 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,7 +900,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 
 ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.17.1

