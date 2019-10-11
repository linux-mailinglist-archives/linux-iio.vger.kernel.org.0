Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06161D3B6F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 10:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfJKInK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 04:43:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15778 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbfJKInJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 04:43:09 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9B8gSmo006705;
        Fri, 11 Oct 2019 04:42:39 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ver39tjcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 04:42:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSYY7eAoMNaTOgre+UvwhyZaSOSq+VGvZpIiY/5vc9EEDt8N7AAW+WNn7pAFs9TTNSH2QRAVg7TeSsp6tyaySt26qRpUvalrm8zO8Kyb/WGP0/BHY139I3r0PCz9XtBts5zNzgN8i21YsGBj43TSxMdVUZtXbfQIrsx9uwBBI0atNKKGDl+5dMoHv9gZiaayOGLrPN5PdwqcInCmv3T+/ZTi50YUYzK65xveS8BN/2yMa5e1zsS0QnMXXaXXEFFEENW8sJafRqBsekZfDQFVJlLATJYJEyY241JOzvH4kV2Fx52ZP+eCmbkoRJ5Azx4a9jsh9suCbt/z0TJC7AKwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtEEopBGmTnT77qGcpVFM2H7obDVscbjR4QPpWzeNh4=;
 b=jBqFPI8yxH1G6MBJp7luKRUYVped2HaVy6W4qxr/fwAmJzaW0bki6VlqyULx35y63CKFwp87+AzvmJlnFWgY9K11NQFi0h/oZWTV899EXNXv2dq5r6fXgtCzH5h17alieTzKe8kXSnZzl2usCRFYDqgKLEwJ8qAn1njqmcRGMsMrnpR2hgATqYifQIEEAg02EsU9gYQpdukYhq9NTVd88eLEg/P6EPcrTcx7YYmX61hUzEb8QV1WxE53hA08ghAzm3BXgk+z5magHXnOpGVNTtsBLNWG6uzALk+qAlbpnsbT9PVjpom6QmpPlVI34Yia5MPN5H4gCeFtx0sowNqrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtEEopBGmTnT77qGcpVFM2H7obDVscbjR4QPpWzeNh4=;
 b=ENCLc6WwVQEp/DJY75tnfBWT75N1riDr7EkIX6EZ2NRr/MxVLcSDT76fySaHVdAiOSeRKZmeJ7N/wsmNlW3R4aVJjZSEMWMDAMhZKNemrbx0pk1mAG90ccsXGa5p2aBzKLnxBXwIOEXbvEXr2kzlF/7aj47TeHm81RrD7pjzAXE=
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 DM6PR03MB4522.namprd03.prod.outlook.com (2603:10b6:5:10a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Fri, 11 Oct 2019 08:40:25 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via Frontend
 Transport; Fri, 11 Oct 2019 08:40:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Fri, 11 Oct 2019 08:40:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9B8eO9F000730
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Oct 2019 01:40:24 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 11 Oct
 2019 04:40:23 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v4 2/2] dt-bindings: iio: Add ltc2983 documentation
Date:   Fri, 11 Oct 2019 10:40:38 +0200
Message-ID: <20191011084038.45829-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011084038.45829-1-nuno.sa@analog.com>
References: <20191011084038.45829-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(53416004)(446003)(2906002)(36756003)(11346002)(4326008)(966005)(6116002)(3846002)(30864003)(126002)(1076003)(476003)(486006)(86362001)(14444005)(2870700001)(106002)(54906003)(110136005)(50466002)(2616005)(305945005)(478600001)(6306002)(7736002)(7636002)(5820100001)(6666004)(356004)(47776003)(70586007)(316002)(70206006)(45776006)(26005)(8936002)(8676002)(336012)(246002)(16526019)(50226002)(186003)(426003)(23676004)(5660300002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4522;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d380987-7616-4601-0357-08d74e26a929
X-MS-TrafficTypeDiagnostic: DM6PR03MB4522:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <DM6PR03MB45229119FD6425229332641999970@DM6PR03MB4522.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBdBf+aSqdten8JHXv+RzAv0f1t35bjcpVZrpvIyYL7CIeiKIb+lk53644Il8e6pjDMr1qyhbq4kEisL4ZljRJ6wziaCa69skD99020/+wGL7LlORIGN/1cJSqXW5Xuw/ujBZSqsaH/enLiYb4fYOtYYoizQe91zHem3kv4UVGFYML1GPeUTnllUeY8VfZDGXlv2PcrOeS0uL1Fv/OddsvKOhLiG82ACXUyGCxRTVCO9EIT85Y+ycrurB21zi56rHDQaAd5DndRyBuHyJBu2fd3akf0geDDkVX81klKUw7EIZSCQWyt17gM22dZtKFGBbH/yXm1OkPQyWB77hjw/d8jzLs4nSbEC63XB+FjlnSfPrAX75++cKZFT1Jiad4S+7cEdO3YkdmL4MBlGrvO2yvEWdanPg0Uv8j0xGKRHJKadwTS99Wiru9xGSqGYHtVzvt5KXEiTnYATvWYe/N7aqg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 08:40:24.8713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d380987-7616-4601-0357-08d74e26a929
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4522
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_06:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110082
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

Changes in v3:
 * Add meaning to adi,sensor-type values which are not const;
 * Add meaning to adi,filter-notch-freq values;
 * Break up adi,sensor-config into human readable elements;
 * Set maxItems/minItems at the same identation as allOf in adi,custom-sensor;
 * Fixed the maximum value for adi,sensor-type for sensors with custom support;
 * Changed license to GPL-2.0-only as it should be for new bindings;
 * Changed spi0 to spi in the dts example;
 * Updated the dts example to the new properties.

Changes in v4:
 * Set correct license for new bindings;
 * Drop $ref for standard unit suffixes;
 * Dropped adi,temperature-celcius;
 * Drop '.*' in the patternProperties regex;
 * Make min/man a single schema;
 * Have rsense in milli ohms;
 * Dropped '|' when no formatting is needed;
 * Add matrixes for adi,custom-sensors;
 * Rename adi,custom-sensor to a more appropriate and distinct name;
 * Add adi,custom-stenheirt for thermistors.

 .../bindings/iio/temperature/adi,ltc2983.yaml | 478 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 479 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
new file mode 100644
index 000000000000..b4946c6530c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -0,0 +1,478 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+  adi,mux-delay-config-us:
+    description:
+      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
+      result. Each conversion cycle is performed with different excitation and
+      input multiplexer configurations. Prior to each conversion, these
+      excitation circuits and input switch configurations are changed and an
+      internal 1ms delay ensures settling prior to the conversion cycle in most
+      cases. An extra delay can be configured using this property. The value is
+      rounded to nearest 100us.
+    maximum: 255
+
+  adi,filter-notch-freq:
+    description:
+      Set's the default setting of the digital filter. The default is
+      simultaneous 50/60Hz rejection.
+      0 - 50/60Hz rejection
+      1 - 60Hz rejection
+      2 - 50Hz rejection
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 2
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "@([1-9]|1[0-9]|20)$":
+    type: object
+
+    properties:
+      reg:
+        description:
+          The channel number. It can be connected to one of the 20 channels of
+          the device.
+        minimum: 1
+        maximum: 20
+
+      adi,sensor-type:
+        description: Identifies the type of sensor connected to the device.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - reg
+      - adi,sensor-type
+
+  "^thermocouple@":
+    type: object
+    description:
+      Represents a thermocouple sensor which is connected to one of the device
+      channels.
+
+    properties:
+      adi,sensor-type:
+        description: |
+          1 - Type J Thermocouple
+          2 - Type K Thermocouple
+          3 - Type E Thermocouple
+          4 - Type N Thermocouple
+          5 - Type R Thermocouple
+          6 - Type S Thermocouple
+          7 - Type T Thermocouple
+          8 - Type B Thermocouple
+          9 - Custom Thermocouple
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 1
+        maximum: 9
+
+      adi,single-ended:
+        description:
+          Boolean property which set's the thermocouple as single-ended.
+        type: boolean
+
+      adi,sensor-oc-current-microamp:
+        description:
+          This property set's the pulsed current value applied during
+          open-circuit detect.
+        enum: [10, 100, 500, 1000]
+
+      adi,cold-junction-handle:
+        description:
+          Phandle which points to a sensor object responsible for measuring
+          the thermocouple cold junction temperature.
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+
+      adi,custom-thermocouple:
+        description:
+          This is a table, where each entry should be a pair of
+          voltage(mv)-temperature(K). The entries must be given in nv and uK
+          so that, the original values must be multiplied by 1000000. For
+          more details look at table 69 and 70.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/int64-matrix
+        items:
+          minItems: 3
+          maxItems: 64
+          items:
+            minItems: 2
+            maxItems: 2
+
+  "^diode@":
+    type: object
+    description:
+      Represents a diode sensor which is connected to one of the device
+      channels.
+
+    properties:
+      adi,sensor-type:
+        description: Identifies the sensor as a diode.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        const: 28
+
+      adi,single-ended:
+        description: Boolean property which set's the diode as single-ended.
+        type: boolean
+
+      adi,three-conversion-cycles:
+        description:
+          Boolean property which set's three conversion cycles removing
+          parasitic resistance effects between the LTC2983 and the diode.
+        type: boolean
+
+      adi,average-on:
+        description:
+          Boolean property which enables a running average of the diode
+          temperature reading. This reduces the noise when the diode is used
+          as a cold junction temperature element on an isothermal block
+          where temperatures change slowly.
+        type: boolean
+
+      adi,excitation-current-microamp:
+        description:
+          This property controls the magnitude of the excitation current
+          applied to the diode. Depending on the number of conversions
+          cycles, this property will assume different predefined values on
+          each cycle. Just set the value of the first cycle (1l).
+        enum: [10, 20, 40, 80]
+
+      adi,ideal-factor-value:
+        description:
+          This property sets the diode ideality factor. The real value must
+          be multiplied by 1000000 to remove the fractional part. For more
+          information look at table 20 of the datasheet.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  "^rtd@":
+    type: object
+    description:
+      Represents a rtd sensor which is connected to one of the device channels.
+
+    properties:
+      reg:
+        minimum: 2
+        maximum: 20
+
+      adi,sensor-type:
+        description: |
+          10 - RTD PT-10
+          11 - RTD PT-50
+          12 - RTD PT-100
+          13 - RTD PT-200
+          14 - RTD PT-500
+          15 - RTD PT-1000
+          16 - RTD PT-1000 (0.00375)
+          17 - RTD NI-120
+          18 - RTD Custom
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 10
+        maximum: 18
+
+      adi,rsense-handle:
+        description:
+          Phandle pointing to a rsense object associated with this RTD.
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+
+      adi,number-of-wires:
+        description:
+          Identifies the number of wires used by the RTD. Setting this
+          property to 5 means 4 wires with Kelvin Rsense.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [2, 3, 4, 5]
+
+      adi,rsense-share:
+        description:
+          Boolean property which enables Rsense sharing, where one sense
+          resistor is used for multiple 2-, 3-, and/or 4-wire RTDs.
+        type: boolean
+
+      adi,current-rotate:
+        description:
+          Boolean property which enables excitation current rotation to
+          automatically remove parasitic thermocouple effects. Note that
+          this property is not allowed for 2- and 3-wire RTDs.
+        type: boolean
+
+      adi,excitation-current-microamp:
+        description:
+          This property controls the magnitude of the excitation current
+          applied to the RTD.
+        enum: [5, 10, 25, 50, 100, 250, 500, 1000]
+
+      adi,rtd-curve:
+        description:
+          This property set the RTD curve used and the corresponding
+          Callendar-VanDusen constants. Look at table 30 of the datasheet.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 0
+            maximum: 3
+
+      adi,custom-rtd:
+        description:
+          This is a table, where each entry should be a pair of
+          resistance(ohm)-temperature(K). The entries added here are in uohm
+          and uK. For more details values look at table 74 and 75.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        items:
+          minItems: 3
+          maxItems: 64
+          items:
+            minItems: 2
+            maxItems: 2
+
+    required:
+      - adi,rsense-handle
+
+    dependencies:
+      adi,current-rotate: [ adi,rsense-share ]
+
+  "^thermistor@":
+    type: object
+    description:
+      Represents a thermistor sensor which is connected to one of the device
+      channels.
+
+    properties:
+      adi,sensor-type:
+        description:
+          19 - Thermistor 44004/44033 2.252kohm at 25°C
+          20 - Thermistor 44005/44030 3kohm at 25°C
+          21 - Thermistor 44007/44034 5kohm at 25°C
+          22 - Thermistor 44006/44031 10kohm at 25°C
+          23 - Thermistor 44008/44032 30kohm at 25°C
+          24 - Thermistor YSI 400 2.252kohm at 25°C
+          25 - Thermistor Spectrum 1003k 1kohm
+          26 - Thermistor Custom Steinhart-Hart
+          27 - Custom Thermistor
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 19
+        maximum: 27
+
+      adi,rsense-handle:
+        description:
+          Phandle pointing to a rsense object associated with this
+          thermistor.
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+
+      adi,single-ended:
+        description:
+          Boolean property which set's the thermistor as single-ended.
+        type: boolean
+
+      adi,rsense-share:
+        description:
+          Boolean property which enables Rsense sharing, where one sense
+          resistor is used for multiple thermistors. Note that this property
+          is ignored if adi,single-ended is set.
+        type: boolean
+
+      adi,current-rotate:
+        description:
+          Boolean property which enables excitation current rotation to
+          automatically remove parasitic thermocouple effects.
+        type: boolean
+
+      adi,excitation-current-nanoamp:
+        description:
+          This property controls the magnitude of the excitation current
+          applied to the thermistor. Value 0 set's the sensor in auto-range
+          mode.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0, 250, 500, 1000, 5000, 10000, 25000, 50000, 100000,
+                   250000, 500000, 1000000]
+
+      adi,custom-thermistor:
+        description:
+          This is a table, where each entry should be a pair of
+          resistance(ohm)-temperature(K). The entries added here are in uohm
+          and uK only for custom thermistors. For more details look at table
+          78 and 79.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        items:
+          minItems: 3
+          maxItems: 64
+          items:
+            minItems: 2
+            maxItems: 2
+
+      adi,custom-steinhart:
+        description:
+          Steinhart-Hart coefficients are also supported and can
+          be programmed into the device memory using this property. For
+          Steinhart sensors the coefficients are given in the raw
+          format. Look at table 82 for more information.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          minItems: 6
+          maxItems: 6
+
+    required:
+      - adi,rsense-handle
+
+    dependencies:
+      adi,current-rotate: [ adi,rsense-share ]
+
+  "^adc@":
+    type: object
+    description: Represents a channel which is being used as a direct adc.
+
+    properties:
+      adi,sensor-type:
+        description: Identifies the sensor as a direct adc.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        const: 30
+
+      adi,single-ended:
+        description: Boolean property which set's the adc as single-ended.
+        type: boolean
+
+  "^rsense@":
+    type: object
+    description:
+      Represents a rsense which is connected to one of the device channels.
+      Rsense are used by thermistors and RTD's.
+
+    properties:
+      reg:
+        minimum: 2
+        maximum: 20
+
+      adi,sensor-type:
+        description: Identifies the sensor as a rsense.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        const: 29
+
+      adi,rsense-val-milli-ohms:
+        description:
+          Sets the value of the sense resistor. Look at table 20 of the
+          datasheet for information.
+
+    required:
+      - adi,rsense-val-milli-ohms
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
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
+                interrupts = <20 IRQ_TYPE_EDGE_RISING>;
+                interrupt-parent = <&gpio>;
+
+                thermocouple@18 {
+                        reg = <18>;
+                        adi,sensor-type = <8>; //Type B
+                        adi,sensor-oc-current-microamp = <10>;
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
+                        adi,rsense-val-milli-ohms = <1200000>; //1.2Kohms
+                };
+
+                rtd@14 {
+                        reg = <14>;
+                        adi,sensor-type = <15>; //PT1000
+                        /*2-wire, internal gnd, no current rotation*/
+                        adi,number-of-wires = <2>;
+                        adi,rsense-share;
+                        adi,excitation-current-microamp = <500>;
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
+                        adi,custom-steinhart = <0x00F371EC 0x12345678
+                                        0x2C0F8733 0x10018C66 0xA0FEACCD
+                                        0x90021D99>; //6 entries
+                };
+
+                thermocouple@20 {
+                        reg = <20>;
+                        adi,sensor-type = <9>; //custom thermocouple
+                        adi,single-ended;
+                        adi,custom-thermocouple = /bits/ 64
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

