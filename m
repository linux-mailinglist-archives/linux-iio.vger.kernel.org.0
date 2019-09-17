Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48F7B503D
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfIQOWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 10:22:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59786 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfIQOWD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 10:22:03 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8HEJkQJ030671;
        Tue, 17 Sep 2019 10:21:26 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0t2962jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 10:21:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLQafHPtfUpw6TRhsk40GuvLi2LoZXdirHvJM0vFYxPjC7vlCfQ4dcTPcHfXgWYyI+7K5rNiWlBXEvNotHvkLqPOdudlzPheNWJ6b9WoOlMOTxrhsOwuOZfFUBEvbnl00uwHNx95Ee54q0Hu1kSQXnOxkiNipOzpFAk79ae2zhCaCL91IDesFrHJmLQdS3cY5IBZ3aU9QExe2EQCVGAg/IPFZFZeAYsa7MpLBAcKkFwoMLlEpbaw5yaZmmz5PqgRzb7by/vRD83mExpmC0xsxoeGI/s1dcffuLo5Jv8BJXory12oMcHhKmxhr+U932+ZE0WemlGbEMyaJEjjrB5Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpPLITKNRunIlbgOdxwj2QjR5rLTqk4VJNPDnpXV4bg=;
 b=UHi4qX1763VU3AL6O1zDPiVOO2s9cqaMTyqzkyiqmnS2HHx6FhuXq1HV4Uvd5/uslRWaFdXhkdTEAnYMsWqvVKmm8A14o4UpXQpG64ghTYN8TTbHFfVjiNbtUcswnejwJ+/qOpoCON8OuTywmBVcZNRg5iebiqbXwyxuz7CyAEw0tVOdvcZKAy+rdZQcvpbXEOiu/MlAe0JnrjrQgwr3fJhvtPjAIteJGxlJOJMc+M+qPOpNW8QQXmhxPVew/nUyA9pSesbKWTHp3Zy+1pntoRC0MFwvu/G58yEVQBXJKOOR2RGBjPEIQ/SJDfZMGnHk04U264VEulpW4sA8695Psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpPLITKNRunIlbgOdxwj2QjR5rLTqk4VJNPDnpXV4bg=;
 b=rYfehLPUXGQOJR0pNfnyqN9Vq/kF4p0P19I5HcM0HR4tuuZzcetSrxid+UxA79iX1OrHtWHtM9Hr8MEEDQdqELlYE2AtXRqLcs0QEPpcUcAg2g1saaWWhu1g9GOBEa9jVtNpil9k5L5S5Ua6Z2fwt2u2k2alC8AWaKrEIUSjmGE=
Received: from BN6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:404:23::30)
 by DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.23; Tue, 17 Sep
 2019 14:21:19 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR03CA0020.outlook.office365.com
 (2603:10b6:404:23::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Tue, 17 Sep 2019 14:21:19 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Tue, 17 Sep 2019 14:21:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8HELJxP001845
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 17 Sep 2019 07:21:19 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 17 Sep
 2019 10:21:18 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: Add ltc2983 documentation
Date:   Tue, 17 Sep 2019 16:21:37 +0200
Message-ID: <20190917142137.157898-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917142137.157898-1-nuno.sa@analog.com>
References: <20190917142137.157898-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(8676002)(106002)(446003)(70586007)(2870700001)(6116002)(1076003)(3846002)(356004)(2906002)(7636002)(7736002)(53416004)(50466002)(5660300002)(305945005)(6666004)(86362001)(23676004)(6306002)(246002)(5820100001)(486006)(426003)(476003)(50226002)(30864003)(16526019)(70206006)(45776006)(36756003)(76176011)(2616005)(126002)(26005)(478600001)(4326008)(186003)(336012)(966005)(316002)(110136005)(54906003)(47776003)(11346002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4411;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7d3b2f2-be38-4107-8ff0-08d73b7a4f12
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR03MB4411;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4411:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <DM6PR03MB441175A821367CEB27F58323998F0@DM6PR03MB4411.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01630974C0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: d4XLtgH/c3QVHl4/R+IFqK1MQsXqvZQLaKU1HveryR0GUTZqQw8Izx8Wt6oYNGb0CmPQQuarsoG7RHWR1uehFAflMuL1HWF08NDzmLh7usJ+bO+J/2jfdBv0SYQtqw6K1MpbKzjZ2ewW/dyC5w4qfjF2az7gBzuFYeDtsXVzl8XK9tg3z1LPepXw3GionEfX+xbUZl6NqZiwxqlbFySSUMDzMVs7L8mmbOXCa9eMYltCTnYlNyzxxJF+ap9zkVmJkhEO3mraEA33s9tGpmN+avZohb/43kwo8qRu8L/9PXNFi7VkktxBFkryfzpDzF+y6te/WLGW0MXP74rQXwUkOvrvHzKxe5vWhDGUpm6WvfB+oQekAIX4S5HWFbAFA3bv2k90DEo3QSQPDmQFQjV6Y2y9WChJ4iaeFEOX5q2vVFQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2019 14:21:19.4379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d3b2f2-be38-4107-8ff0-08d73b7a4f12
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4411
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_07:2019-09-17,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909170139
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

