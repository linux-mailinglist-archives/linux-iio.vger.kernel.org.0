Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8949C1F57
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2019 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfI3KnP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Sep 2019 06:43:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25624 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730696AbfI3KnP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2019 06:43:15 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UAXiXF002492;
        Mon, 30 Sep 2019 06:42:43 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2va456872t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 06:42:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOJIYMa5xqmFazQ+z0SsrvpXHvsRv4CV9MCboyMwe5CUstwjNCFpBjiheicW1MS6JPd6/Vl0i8Iiw0e4nRTKePAnhqzev7xUo6JWjtUIxjRtIGhmFspfDKPAkU46fIxH36IyCPqL1GD2NJlMmfUUCKoadCUuXk3N1nx7b1MZAGSQztqsOG90beOBYgJRsiCVWqhrdetgUslQVGu3ELO0vxsb2NgyNaPX4xHAZ9g8Obk/r/eEpdSABV8VhPGrG4BKwNphe3DOxGhgezGkLBjEkEE/jfOUmFsPr9apdRzJqefDG1YMwrIFZ3L85DadVzBy2ISLnESrjHgiJmIiMB7XEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpPLITKNRunIlbgOdxwj2QjR5rLTqk4VJNPDnpXV4bg=;
 b=lp7+8EmhS/lkUckxR1evaz2zrqXtc60XoHb+HI23iBZNWfYr4/SX+TdPIC0fiqVGvC8mxwQHMsFdFV5uGuNjfyyhlvhBtoZnb5h7ccGf9K/+ndnZGV7IMJn+xQPgsxI7Neay4khn/zBXdwF778Pj2A4NfqfdPFvj0I694EOt9xIbXs/AQWcyQCls7s9XXoulzuF5xCr4FZtdHKDcMVQle+SCG9VKnHhjQ9m4hGg1lPJFyEdXF0mphnptGWUU2VPeFb3Cv/p0QqAKEjnXPag842BH6dpVm6I9YcnHanWThLAEbjVqJogjmW2hWJoAZ0zmPKQNNxiSIYVu2npggfmDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpPLITKNRunIlbgOdxwj2QjR5rLTqk4VJNPDnpXV4bg=;
 b=7a8Ap4clFaOCfTLm51aFwTL4b2TVCtmH2+s0gD5i6oeuTZp//gm3iN7fw9DWmPBTKlpUqslrEzKHD/pxQSwsfBDqX93HGl8TPWwLoVsNY8fO5UhyhUrqqpK2f2cBvLc01yL0s2s+V6yfsZ+AX78kRbSUVnE5fNuJD4SmhLxpTnY=
Received: from BN6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:405:6f::21)
 by CY4PR03MB3205.namprd03.prod.outlook.com (2603:10b6:910:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.24; Mon, 30 Sep
 2019 10:42:41 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR03CA0083.outlook.office365.com
 (2603:10b6:405:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Mon, 30 Sep 2019 10:42:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2305.20
 via Frontend Transport; Mon, 30 Sep 2019 10:42:41 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8UAgZwu031431
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 30 Sep 2019 03:42:35 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 30 Sep
 2019 06:42:39 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [RESEND PATCH v2 2/2] dt-bindings: iio: Add ltc2983 documentation
Date:   Mon, 30 Sep 2019 12:42:47 +0200
Message-ID: <20190930104247.21519-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930104247.21519-1-nuno.sa@analog.com>
References: <20190930104247.21519-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(6666004)(7636002)(3846002)(47776003)(1076003)(305945005)(23676004)(356004)(426003)(45776006)(6116002)(2870700001)(246002)(5820100001)(8936002)(8676002)(50226002)(2906002)(6306002)(7736002)(4326008)(316002)(106002)(54906003)(186003)(36756003)(336012)(53416004)(476003)(966005)(2616005)(76176011)(26005)(5660300002)(70586007)(478600001)(30864003)(16526019)(11346002)(446003)(486006)(86362001)(70206006)(110136005)(126002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3205;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55e43c71-e464-4d78-b7de-08d74592eb7d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR03MB3205;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3205:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <CY4PR03MB3205B58418A2AC8CCC58308799820@CY4PR03MB3205.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01762B0D64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wS7IYV15ehqKh52MyfhnOV3/omIDGr4zrn3BWKTXY2O9Uh1LxsBqR1uqrgYbITkO3+w6+ygYlzxarhsSOzXV//iVzsn1s16LoDgvJ+iYBVM7xo6fFJOREZzAGg1gj/LZ07BprPPzweM3r7snpTCy5SvC2cnMIG1PY6sTbLYSUI6mVf2eZFmGuvJ/HMDhQ0et9MkZHbbrCvv4HUhDe2yjF3aAeNguDkAfsbZuGgtQKvCofopzeYzdKiJqG+a5Z5oz8sF/fdUCHfa2YPUVsAAJA13oxowisnqDwcQcLpXRDz51gu7wR5xWLjCTekyp6C4F7p9PcYVOs+zlZIF3263RbgeA2MG65d7vgfqmCU72ErRIhTRIyo/qX8caXs6QmEqeueC1sKNJg7OfV1X6vvYyhNIq7Vx6/PynpF2PyS0aX3Ni5Nm64Seg6AAPclrZUX46oiGDzOCQlkpPJvsL0hwdPg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 10:42:41.4160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e43c71-e464-4d78-b7de-08d74592eb7d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3205
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_07:2019-09-25,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300115
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the LTC2983 temperature sensor devicetree bindings.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
 * Drop maxItems in non-array elements;
 * Set adi,mux-delay-config-us instead of adi,mux-delay-config;
 * Wrapped lines at 80 char;
 * Added comas to enum elements;
 * Use real units in adi,excitation-current;
 * Moved some enums to minimum and maximum;
 * Grouped patternProperties and moved reg property as a generic property.

 .../bindings/iio/temperature/adi,ltc2983.yaml | 406 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
new file mode 100644
index 000000000000..df68b8233e5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -0,0 +1,406 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2983 Multi-sensor Temperature system
+
+maintainers:
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
+  https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2983
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  adi,temperature-celcius:
+    description:
+      If this property is present, the temperature is reported in Celsius.
+    type: boolean
+
+  adi,mux-delay-config-us:
+    description:
+      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
+      result. Each conversion cycle is performed with different excitation and
+      input multiplexer configurations. Prior to each conversion, these
+      excitation circuits and input switch configurations are changed and an
+      internal 1ms delay ensures settling prior to the conversion cycle in most
+      cases. An extra delay can be configured using this property. The value is
+      rounded to nearest 100us.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - maximum: 255
+
+  adi,filter-notch-freq:
+    description:
+      Set's the default setting of the digital filter. The default is
+      simultaneous 50/60Hz rejection.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 2
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  ".*@([1-9]|1[0-9]|20)$":
+    type: object
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can be connected to one of the 20 channels of
+          the device.
+        minimum: 1
+        maximum: 20
+
+    required:
+      - reg
+
+    patternProperties:
+      "^thermocouple@.*":
+        type: object
+        description: |
+          Represents a thermocouple sensor which is connected to one of the device
+          channels.
+
+        properties:
+          adi,sensor-type:
+            description: |
+              Identifies the type of thermocouple connected to the device.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 1
+              - maximum: 8
+
+          adi,sensor-config:
+            description: |
+              Raw value which set's the sensor configuration. Look at table 14
+              of the datasheet for how to set this value for thermocouples.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 1
+              - maximun: 15
+
+          adi,cold-junction-handle:
+            description: |
+              Phandle which points to a sensor object responsible for measuring
+              the thermocouple cold junction temperature.
+            $ref: "/schemas/types.yaml#/definitions/phandle"
+
+          adi,custom-sensor:
+            description: |
+              This is a table, where each entry should be a pair of
+              voltage(mv)-temperature(K). The entries must be given in nv and uK
+              so that, the original values must be multiplied by 1000000. For
+              more details look at table 69 and 70.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/int64-array
+              - minItems: 6
+              - maxItems: 128
+
+        required:
+          - adi,sensor-type
+
+      "^diode@.*":
+        type: object
+        description: |
+          Represents a diode sensor which is connected to one of the device
+          channels.
+
+        properties:
+          adi,sensor-type:
+            description: Identifies the sensor as a diode.
+            const: 28
+
+          adi,sensor-config:
+            description: |
+              Raw value which set's the sensor configuration. Look at table 17
+              of the datasheet for how to set this value for diodes.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 0
+              - maximum: 7
+
+          adi,excitation-current-microamp:
+            description: |
+              This property controls the magnitude of the excitation current
+              applied to the diode. Depending on the number of conversions
+              cycles, this property will assume different predefined values on
+              each cycle. Just set the value of the first cycle (1l).
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - enum: [10, 20, 40, 80]
+
+          adi,ideal-factor-value:
+            description: |
+              This property sets the diode ideality factor. The real value must
+              be multiplied by 1000000 to remove the fractional part. For more
+              information look at table 20 of the datasheet.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+
+        required:
+          - adi,sensor-type
+
+      "^rtd@.*":
+        type: object
+        description: |
+          Represents a rtd sensor which is connected to one of the device channels.
+
+        properties:
+          reg:
+            minimum: 2
+
+          adi,sensor-type:
+            description: Identifies the type of RTD connected to the device.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 10
+              - maximum: 17
+
+          adi,rsense-handle:
+            description: |
+              Phandle pointing to a rsense object associated with this RTD.
+            $ref: "/schemas/types.yaml#/definitions/phandle"
+
+          adi,sensor-config:
+            description: |
+              Raw value which set's the sensor configuration. Look at table 28
+              of the datasheet for how to set this value for RTD's.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - enum: [0, 1, 4, 5, 8, 9, 10, 12, 13, 14]
+
+          adi,excitation-current-microamp:
+            description: |
+              This property controls the magnitude of the excitation current
+              applied to the RTD.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - enum: [5, 10, 25, 50, 100, 250, 500, 1000]
+
+          adi,rtd-curve:
+            description: |
+              This property set the RTD curve used and the corresponding
+              Callendar-VanDusen constants. Look at table 30 of the datasheet.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 0
+              - maximum: 3
+
+          adi,custom-sensor:
+            description: |
+              This is a table, where each entry should be a pair of
+              resistance(ohm)-temperature(K). The entries added here are in uohm
+              and uK. For more details values look at table 74 and 75.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint64-array
+              - minItems: 6
+              - maxItems: 128
+
+        required:
+          - adi,sensor-type
+          - adi,rsense-handle
+
+      "^thermistor@.*":
+        type: object
+        description: |
+          Represents a thermistor sensor which is connected to one of the device
+          channels.
+
+        properties:
+          adi,sensor-type:
+            description: |
+              Identifies the type of thermistor connected to the
+              device.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 19
+              - maximum: 25
+
+          adi,rsense-handle:
+            description: |
+              Phandle pointing to a rsense object associated with this
+              thermistor.
+            $ref: "/schemas/types.yaml#/definitions/phandle"
+
+          adi,sensor-config:
+            description: |
+              Raw value which set's the sensor configuration. Look at table 52
+              of the datasheet for how to set this value for thermistors.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 0
+              - maximum: 4
+
+          adi,excitation-current-nanoamp:
+            description: |
+              This property controls the magnitude of the excitation current
+              applied to the thermistor. Value 0 set's the sensor in auto-range
+              mode.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - enum: [0, 250, 500, 1000, 5000, 10000, 25000, 50000, 100000,
+                       250000, 500000, 1000000]
+
+          adi,custom-sensor:
+            description: |
+              This is a table, where each entry should be a pair of
+              resistance(ohm)-temperature(K). The entries added here are in uohm
+              and uK only for custom thermistors. For more details look at table
+              78 and 79. Steinhart-Hart coefficients are also supported and can
+              be programmed into the device memory using this property. For
+              Steinhart sensors, this table has a constant size of 6 entries
+              (defining the coefficients) and the values are given in the raw
+              format. Look at table 82 for more information.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint64-array
+              - minItems: 6
+              - maxItems: 128
+
+        required:
+          - adi,sensor-type
+          - adi,rsense-handle
+
+      "^adc@.*":
+        type: object
+        description: Represents a channel which is being used as a direct adc.
+
+        properties:
+          adi,sensor-type:
+            description: Identifies the sensor as a direct adc.
+            const: 30
+
+          adi,single-ended:
+            description: Boolean property which set's the adc as single-ended.
+            type: boolean
+
+        required:
+          - adi,sensor-type
+
+      "^rsense@.*":
+        type: object
+        description: |
+          Represents a rsense which is connected to one of the device channels.
+          Rsense are used by thermistors and RTD's.
+
+        properties:
+          reg:
+            minimum: 2
+
+          adi,sensor-type:
+            description: Identifies the sensor as a rsense.
+            const: 29
+
+          adi,rsense-val-micro-ohms:
+            description: |
+              Sets the value of the sense resistor. Look at table 20 of the
+              datasheet for information.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint64
+
+        required:
+          - adi,sensor-type
+          - adi, rsense-val
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensor_ltc2983: ltc2983@0 {
+                compatible = "adi,ltc2983";
+                reg = <0>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                adi,temperature-celcius;
+                interrupts = <20 IRQ_TYPE_EDGE_RISING>;
+                interrupt-parent = <&gpio>;
+
+                thermocouple@18 {
+                        reg = <18>;
+                        adi,sensor-type = <8>; //Type B
+                        adi,sensor-config = <1>; //Differential, open-circuit current
+                        adi,cold-junction-handle = <&diode5>;
+                };
+
+                diode5: diode@5 {
+                        reg = <5>;
+                        adi,sensor-type = <28>;
+                };
+
+                rsense2: rsense@2 {
+                        reg = <2>;
+                        adi,sensor-type = <29>;
+                        adi,rsense-val-micro-ohms = /bits/ 64 <1200000000>; //1.2Kohms
+                };
+
+                rtd@14 {
+                        reg = <14>;
+                        adi,sensor-type = <15>; //PT1000
+                        /*2-wire, internal gnd, no current rotation*/
+                        adi,sensor-config = <1>;
+                        adi,excitation-current = <7>; //500uA
+                        adi,rsense-handle = <&rsense2>;
+                };
+
+                adc@10 {
+                        reg = <10>;
+                        adi,sensor-type = <30>;
+                        adi,single-ended;
+                };
+
+                thermistor@12 {
+                        reg = <12>;
+                        adi,sensor-type = <26>; //Steinhart
+                        adi,rsense-handle = <&rsense2>;
+                        adi,custom-sensor = /bits/ 64 <0x00F371EC 0x12345678
+                                        0x2C0F8733 0x10018C66 0xA0FEACCD
+                                        0x90021D99>; //6 entries
+                };
+
+                thermocouple@20 {
+                        reg = <20>;
+                        adi,sensor-type = <9>; //custom thermocouple
+                        adi,sensor-config = <8>; //single-ended
+                        adi,custom-sensor = /bits/ 64
+                                 <(-50220000) 0
+                                  (-30200000) 99100000
+                                  (-5300000) 135400000
+                                  0 273150000
+                                  40200000 361200000
+                                  55300000 522100000
+                                  88300000 720300000
+                                  132200000 811200000
+                                  188700000 922500000
+                                  460400000 1000000000>; //10 pairs
+               };
+
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 14a256e785ca..f747a9dc27f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9497,6 +9497,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/temperature/ltc2983.c
+F:	Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
 
 LTC4261 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
-- 
2.23.0

