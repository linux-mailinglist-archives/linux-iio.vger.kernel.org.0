Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EAACBC56
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2019 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbfJDNzh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Oct 2019 09:55:37 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:57418 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388673AbfJDNzh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Oct 2019 09:55:37 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94DrA8l005136;
        Fri, 4 Oct 2019 09:55:02 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2056.outbound.protection.outlook.com [104.47.42.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2va19d29tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 09:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP9vzamI7WevEKHv0RvaBSPNXeDIuWACLWl1DXk2ZO67REbCIfGm9erEaE1wnrQfRven785KTrcbY0Ve6ooozGDD/chVkr3IrgEzwin8cHziFynW23alEEZNtrSzwaydApqUiaJdMq1IlnmRzu6E6mn4hz0m9MhmG8katCPjJ52dtudHezpN9+NfKAw04xIHKcEm96ZJ5CysGlbNQXcZgnPV5Ah/WXbY1GBbDB9OGAuIN7pZjACsX08trQaoFnyFQeZ91FSKOMVVa7QoRJcpiSXNv8qvcmg9lM19/EP7p2YqHsOSkv4BQ0Q42uo/puGMtqN8kWb/3GrfU9ou1FBxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6xyDhtOKzsjn/jG3IbrNMHebEuVgll3FsiO9f+Ntpw=;
 b=evXck3TjFyNoSxU1tr5oRsrfhww1ucSGrZUQR8rJp7wc0aBYh30IPZ/Dna8QKFl0IcmoinBuMGUq1CoO5YBMPhjmshRBCD6O2ae9vaXvSHZLVq1popKy9Q/CvjuZqU6sT3N4Fz0nBkRQx3xnFFGqiNHEQqjWoPwFwzaZuVBZ1yAscIDJ72G/VTPX9MxT6tPTERq/iqqb48riZDJcElV4x7oCFoH4uImHVy+2ZRL9McPUYWUnbjCeO8PbIzlZ4hlbFyFu44cu1XfbEpMI3mdeqNhDbzs/TfQ91mtu2Lux7UI3g594QV8fx1CCdOi5EFSnlSW7BIjTUkcR3A8vgUOWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6xyDhtOKzsjn/jG3IbrNMHebEuVgll3FsiO9f+Ntpw=;
 b=7dsJ/cCHG/E4CazOfIHL2ROFEMyPyJCuF64HgZULNaXP20Y/Petp/8i8YvXFK1lVi082vzgIul71ixrEJulwPehHIwpBxZvbqDXx6kB4mwDSuTkq74URY+BlxZppmIoNSZdULfTQoB/XMTxrdna0YnMxcotmFN25CSZ2fQpqdYE=
Received: from MWHPR03CA0001.namprd03.prod.outlook.com (2603:10b6:300:117::11)
 by DM6PR03MB5083.namprd03.prod.outlook.com (2603:10b6:5:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Fri, 4 Oct
 2019 13:54:59 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MWHPR03CA0001.outlook.office365.com
 (2603:10b6:300:117::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24 via Frontend
 Transport; Fri, 4 Oct 2019 13:54:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Fri, 4 Oct 2019 13:54:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x94Dsqad029161
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 4 Oct 2019 06:54:52 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 4 Oct
 2019 09:54:57 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: Add ltc2983 documentation
Date:   Fri, 4 Oct 2019 15:55:19 +0200
Message-ID: <20191004135519.191657-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004135519.191657-1-nuno.sa@analog.com>
References: <20191004135519.191657-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(2616005)(5660300002)(2906002)(1076003)(476003)(30864003)(23676004)(5820100001)(2870700001)(76176011)(966005)(3846002)(26005)(47776003)(486006)(446003)(356004)(6116002)(478600001)(126002)(16526019)(11346002)(36756003)(426003)(336012)(53416004)(186003)(6666004)(14444005)(8676002)(106002)(6306002)(316002)(45776006)(110136005)(50466002)(54906003)(70586007)(4326008)(70206006)(86362001)(50226002)(8936002)(305945005)(7736002)(7636002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5083;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e0f5a84-5133-4cd1-e8e3-08d748d2720b
X-MS-TrafficTypeDiagnostic: DM6PR03MB5083:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <DM6PR03MB50834379A56F0C33C1F8E60D999E0@DM6PR03MB5083.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 018093A9B5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9irrtgD7pXlII2LhVQX/8b3XzCMCoBINQQpgOZaIW20T32iWkhEO9haWko3v/D9yHG7+z8JSQEpPasNdUlKQHnvgKA40K8selGFIhQ+9kpXpaIZjrlfFnnVVv6ASz2zX8y/Tv8QyykDykLMbp7r47yGV1mGvsYatKpuk7y1ogzmawVDRRcyaAUW2i9CiuiGrhmAIKYHzslRNAEw7zclqezKJ1XTDgbd3pN/2wfjR7o2l03GKHAjYdnJa+GAa1g0mvPfTxwx72ZiNu79G6COpOg8Ww39ypJKB8rmarbrPODTgEWr2SPbcT312jjvKUw3ntibPpxVx1snFBaACI+UWJ9GTOpt4ZGwsMU68IiFX0ytObavyfvaVwTbMQjVL+/1czg/MyGfgDuBsEBLowJN1t41/Ib1H3n8t50EcPKbC9NT3/Gd0vmtTNazB96zBTRXnRILCfcXZCV/W1/RaFA0ag==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 13:54:58.8798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0f5a84-5133-4cd1-e8e3-08d748d2720b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5083
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_07:2019-10-03,2019-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910040130
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

 .../bindings/iio/temperature/adi,ltc2983.yaml | 479 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
new file mode 100644
index 000000000000..b7101a0e84db
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -0,0 +1,479 @@
+# SPDX-License-Identifier: GPL-2.0-only
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
+      0 - 50/60Hz rejection
+      1 - 60Hz rejection
+      2 - 50Hz rejection
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
+              1 - Type J Thermocouple
+              2 - Type K Thermocouple
+              3 - Type E Thermocouple
+              4 - Type N Thermocouple
+              5 - Type R Thermocouple
+              6 - Type S Thermocouple
+              7 - Type T Thermocouple
+              8 - Type B Thermocouple
+              9 - Custom Thermocouple
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 1
+              - maximum: 9
+
+          adi,single-ended:
+            description: |
+              Boolean property which set's the thermocouple as single-ended.
+            type: boolean
+
+          adi,sensor-oc-current-microamp:
+            description: |
+              This property set's the pulsed current value applied during
+              open-circuit detect.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - enum: [10, 100, 500, 1000]
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
+            minItems: 6
+            maxItems: 128
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
+          adi,single-ended:
+            description: Boolean property which set's the diode as single-ended.
+            type: boolean
+
+          adi,three-conversion-cycles:
+            description: |
+              Boolean property which set's three conversion cycles removing
+              parasitic resistance effects between the LTC2983 and the diode.
+            type: boolean
+
+          adi,average-on:
+            description: |
+              Boolean property which enables a running average of the diode
+              temperature reading. This reduces the noise when the diode is used
+              as a cold junction temperature element on an isothermal block
+              where temperatures change slowly.
+            type: boolean
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
+            description: |
+              Identifies the type of RTD connected to the device.
+              10 - RTD PT-10
+              11 - RTD PT-50
+              12 - RTD PT-100
+              13 - RTD PT-200
+              14 - RTD PT-500
+              15 - RTD PT-1000
+              16 - RTD PT-1000 (0.00375)
+              17 - RTD NI-120
+              18 - RTD Custom
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 10
+              - maximum: 18
+
+          adi,rsense-handle:
+            description: |
+              Phandle pointing to a rsense object associated with this RTD.
+            $ref: "/schemas/types.yaml#/definitions/phandle"
+
+          adi,number-of-wires:
+            description: |
+              Identifies the number of wires used by the RTD. Setting this
+              property to 5 means 4 wires with Kelvin Rsense.
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - enum: [2, 3, 4, 5]
+
+          adi,rsense-share:
+            description: |
+              Boolean property which enables Rsense sharing, where one sense
+              resistor is used for multiple 2-, 3-, and/or 4-wire RTDs.
+            type: boolean
+
+          adi,current-rotate:
+            description: |
+              Boolean property which enables excitation current rotation to
+              automatically remove parasitic thermocouple effects. Note that
+              this property is not allowed for 2- and 3-wire RTDs.
+            type: boolean
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
+            minItems: 6
+            maxItems: 128
+
+        required:
+          - adi,sensor-type
+          - adi,rsense-handle
+
+        dependencies:
+          adi,current-rotate: [ adi,rsense-share ]
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
+              19 - Thermistor 44004/44033 2.252kohm at 25°C
+              20 - Thermistor 44005/44030 3kohm at 25°C
+              21 - Thermistor 44007/44034 5kohm at 25°C
+              22 - Thermistor 44006/44031 10kohm at 25°C
+              23 - Thermistor 44008/44032 30kohm at 25°C
+              24 - Thermistor YSI 400 2.252kohm at 25°C
+              25 - Thermistor Spectrum 1003k 1kohm
+              26 - Thermistor Custom Steinhart-Hart
+              27 - Custom Thermistor
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint32
+              - minimum: 19
+              - maximum: 27
+
+          adi,rsense-handle:
+            description: |
+              Phandle pointing to a rsense object associated with this
+              thermistor.
+            $ref: "/schemas/types.yaml#/definitions/phandle"
+
+          adi,single-ended:
+            description: |
+              Boolean property which set's the thermistor as single-ended.
+            type: boolean
+
+          adi,rsense-share:
+            description: |
+              Boolean property which enables Rsense sharing, where one sense
+              resistor is used for multiple thermistors. Note that this property
+              is ignored if adi,single-ended is set.
+            type: boolean
+
+          adi,current-rotate:
+            description: |
+              Boolean property which enables excitation current rotation to
+              automatically remove parasitic thermocouple effects.
+            type: boolean
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
+            minItems: 6
+            maxItems: 128
+
+        required:
+          - adi,sensor-type
+          - adi,rsense-handle
+
+        dependencies:
+          adi,current-rotate: [ adi,rsense-share ]
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
+                adi,temperature-celcius;
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
+                        adi,rsense-val-micro-ohms = /bits/ 64 <1200000000>; //1.2Kohms
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
+                        adi,custom-sensor = /bits/ 64 <0x00F371EC 0x12345678
+                                        0x2C0F8733 0x10018C66 0xA0FEACCD
+                                        0x90021D99>; //6 entries
+                };
+
+                thermocouple@20 {
+                        reg = <20>;
+                        adi,sensor-type = <9>; //custom thermocouple
+                        adi,single-ended;
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

