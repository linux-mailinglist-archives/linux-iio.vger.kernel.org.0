Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A40ADB6E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfIIOqS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 10:46:18 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:21068 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbfIIOqR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 10:46:17 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89EgUwK023339;
        Mon, 9 Sep 2019 10:45:38 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uv967g6fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Sep 2019 10:45:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJscGho80T9CzmTWoKI6JRUCPz6pXy6oS+x50wDML5bWnhzUwivOA9y6Ytv72XIcd6oDbQOwxlgpU0RzdtrAMbgwQLf+NYidNP0CAsMwdsQ1urzU74i2cq2scQffMWbGebvYQlVh5j6ZNKxOYvtI1cxl4uI+SAc3deXarDaw9gCbKL8XCLlhUmdeCOQ1DJRkI9OlI/a3VMOC0twT9lmpOyu/0K96r9UxBiL5mI5YGin2Cd2ciqul9dazdORT9rfKXkIA1PQ9pxWZ4KQJqkbEeIHqfl27FjBKN+vhx7/l99uNUP3aGqsbXZ/pCujrRnQme3C+C04Ykzqv5q3H9PeFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq9rIBYUVCluUz6bDrUD2my0Xn7UuRD5bMj8NZL7af8=;
 b=IKxeeqjQqSti7giad2qujnUVmRwRpOL/GZOsDzbFIS0nilRmOmp7s5e+zjYc42kiGAAZLrzjXh66vUhVZokh1eHfBYpulFWtEuFwWyZFZaijMYGxfQ8FwCGqCezn5YQUZyaqZTwURjnPCuhw9vNntwMveNjKFf/rCeNMg186JW0RFpkIPQiaRB0w3fDAfZoTkzq2msFlyjDUjFKPk71juPVa47tsRdwyncjggS4hRUIFGnBr2CoP/7uFfEaxXZzky1q4uDwirXGvzdQVxTm1yXhQ7E+Sl48iqVoVoVYrizzTvJFZzRGXnvfH/UqVtubWazO+ZZUao1kBjIFe1f8IJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq9rIBYUVCluUz6bDrUD2my0Xn7UuRD5bMj8NZL7af8=;
 b=saRwyaciUCaRK9IqckIYvPo3rDicAVdoeIGEYgxXAvfPd/QkgaCO8t9yFzKW8HHi9O/PCU0f7rRp8/zNAphsy92iDjHJqQId8P3FnmZPpMEZUfN9v9qYuEIj9X5KsVFeMHr3gchjmDuCLcub1JOfTW007gCHcnu6ZqnXVfFV+Uk=
Received: from CY4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:910:4d::35)
 by SN2PR03MB2400.namprd03.prod.outlook.com (2603:10b6:804:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.19; Mon, 9 Sep
 2019 14:45:36 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR03CA0094.outlook.office365.com
 (2603:10b6:910:4d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.17 via Frontend
 Transport; Mon, 9 Sep 2019 14:45:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Mon, 9 Sep 2019 14:45:35 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x89EjUTW023316
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 9 Sep 2019 07:45:30 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 9 Sep
 2019 10:45:34 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH 2/2] dt-bindings: iio: Add ltc2983 documentation
Date:   Mon, 9 Sep 2019 16:45:50 +0200
Message-ID: <20190909144550.164488-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909144550.164488-1-nuno.sa@analog.com>
References: <20190909144550.164488-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(189003)(199004)(70586007)(23676004)(110136005)(356004)(2616005)(486006)(106002)(476003)(6666004)(426003)(11346002)(446003)(126002)(26005)(30864003)(76176011)(4326008)(54906003)(36756003)(336012)(86362001)(50466002)(7636002)(7736002)(316002)(1076003)(305945005)(5820100001)(966005)(5660300002)(8936002)(53376002)(45776006)(70206006)(47776003)(2870700001)(186003)(16526019)(246002)(53416004)(6116002)(3846002)(2906002)(478600001)(8676002)(6306002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2400;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565b4ce1-87c2-4b3d-00e2-08d735345fd0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN2PR03MB2400;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2400:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <SN2PR03MB240007BA9E426E28FB3A43CC99B70@SN2PR03MB2400.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01559F388D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zje0bkdGUhU+GqjmYGNqElBhZn3Wp0U2WyXKEEyLNr8giQoYuZG3TtbaPe7AXs2m2jCBZk8sQ0uAueECeqFksPO3USA+OLxBWuefXb5Dh2vVOhln92F4u1hnNd+Jn0ke6YNRltQZil6ebTGNy3mWIemPzh7RwBDRXMskSKh+/C+8MQcoyMotQuR1dUc+L9TXCFUV8zEwmo6TDVSKTV3R7eAwPuwPVuynPUDP/0FEoeIlHaQQEHadABMKC/15D7LmrPIvf4+gCmK2nsyZBu8f7zhtogqlm9ZzmjormjuJZhwgIA1/BWA51uOICKkhkTp17aJoBOLMVM+1EpJKgoXVZshnJUot+1gAVOdSeD6QT1HhGYLLtYcWsmccBBFmZHERYJjnC39c/Qqg0MUC2u3M73f5uCPI0Pr0YAGoxvcA+y0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2019 14:45:35.3589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565b4ce1-87c2-4b3d-00e2-08d735345fd0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2400
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_06:2019-09-09,2019-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909090150
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the LTC2983 temperature sensor devicetree bindings.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 442 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
new file mode 100644
index 000000000000..2b468b3ed177
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -0,0 +1,442 @@
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
+    maxItems: 1
+
+  adi,mux-delay-config:
+    description:
+      The LTC2983 performs 2 or 3 internal conversion cycles per temperature result.
+      Each conversion cycle is performed with different excitation and input multiplexer
+      configurations. Prior to each conversion, these excitation circuits and input
+      switch configurations are changed and an internal 1ms delay ensures settling prior
+      to the conversion cycle in most cases. An extra delay can be configured using this
+      property. The value written here is multiplied by 100us.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - maximum: 255
+        maxItems: 1
+
+  adi,filter-notch-freq:
+    description:
+      Set's the default setting of the digital filter. The default is simultaneous
+      50/60Hz rejection.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2]
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^thermocouple@([1-9]|1[0-9]|20)$":
+    type: object
+    description: Represents a thermocouple sensor which is connected to one of the device channels.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can be connected to one of the 20 channels of the device.
+          Note that, for differential thermocouples, the minimum is 2.
+        minimum: 1
+        maximum: 20
+        maxItems: 1
+
+      adi,sensor-type:
+        description: |
+           Identifies the type of thermocouple connected to the device.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [1 2 3 4 5 6 7 8]
+        maxItems: 1
+
+      adi,sensor-config:
+        description: |
+          Raw value which set's the sensor configuration. Look at table 14 of the
+          datasheet for how to set this value for thermocouples.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximun: 15
+        maxItems: 1
+
+      adi,cold-junction-handle:
+        description: |
+          Phandle which points to a sensor object responsible for measuring the
+          thermocouple cold junction temperature.
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+        maxItems: 1
+
+      adi,custom-sensor:
+        description: |
+          This is a table, where each entry should be a pair of voltage(mv)-temperature(K).
+          The entries must be given in nv and uK so that, the original values must be
+          multiplied by 1000000. For more details look at table 69 and 70.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/int64-array
+        minItems: 6
+        maxItems: 128
+    required:
+      - reg
+      - adi,sensor-type
+
+patternProperties:
+  "^diode@([1-9]|1[0-9]|20)$":
+    type: object
+    description: Represents a diode sensor which is connected to one of the device channels.
+
+    properties:
+      reg:
+        description:
+          The channel number. It can be connected to one of the 20 channels of the device.
+          Note that, for differential diodes, the minimum is 2.
+        minimum: 1
+        maximum: 20
+        maxItems: 1
+
+      adi,sensor-type:
+        description: |
+          Identifies the sensor as a diode.
+        const: 28
+        maxItems: 1
+
+      adi,sensor-config:
+        description: |
+          Raw value which set's the sensor configuration. Look at table 17 of the
+          datasheet for how to set this value for diodes.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0 1 2 3 4 5 6 7]
+        maxItems: 1
+
+      adi,excitation-current:
+        description: |
+          This property controls the magnitude of the excitation current applied
+          to the diode. Look at table 19 of the datasheet for more info.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0 1 2 3]
+        maxItems: 1
+
+      adi,ideal-factor-value:
+        description: |
+          This property sets the diode ideality factor. The real value must be
+          multiplied by 1000000 to remove the fractional part. For more information
+          look at table 20 of the datasheet.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        maxItems: 1
+
+    required:
+      - reg
+      - adi,sensor-type
+
+patternProperties:
+  "^rtd@([2-9]|1[0-9]|20)$":
+    type: object
+    description: Represents a rtd sensor which is connected to one of the device channels.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can be connected to one of the 20 channels of the device.
+        minimum: 2
+        maximum: 20
+        maxItems: 1
+
+      adi,sensor-type:
+        description: |
+          Identifies the type of RTD connected to the device.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [10 11 12 13 14 15 16 17]
+        maxItems: 1
+
+      adi,rsense-handle:
+        description: |
+          Phandle pointing to a rsense object associated with this RTD.
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+        maxItems: 1
+
+      adi,sensor-config:
+        description: |
+          Raw value which set's the sensor configuration. Look at table 28 of the
+          datasheet for how to set this value for RTD's.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0 1 4 5 8 9 10 12 13 14]
+        maxItems: 1
+
+      adi,excitation-current:
+        description: |
+          This property controls the magnitude of the excitation current applied
+          to the RTD. Look at table 29 of the datasheet for more info.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [1 2 3 4 5 6 7 8]
+        maxItems: 1
+
+      adi,rtd-curve:
+        description: |
+          This property set the RTD curve used and the corresponding Callendar-Van
+          Dusen constants. Look at table 30 of the datasheet.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0 1 2 3]
+        maxItems: 1
+
+      adi,custom-sensor:
+        description: |
+          This is a table, where each entry should be a pair of resistance(ohm)-temperature(K).
+          The entries added here are in uohm and uK. For more details values look at table 74 and 75.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint64-array
+        minItems: 6
+        maxItems: 128
+    required:
+      - reg
+      - adi,sensor-type
+      - adi,rsense-handle
+
+patternProperties:
+  "^thermistor@([1-9]|1[0-9]|20)$":
+    type: object
+    description: Represents a thermistor sensor which is connected to one of the device channels.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can be connected to one of the 20 channels of the device.
+          Note that, for differential thermistors, the minimum is 2.
+        minimum: 1
+        maximum: 20
+        maxItems: 1
+
+      adi,sensor-type:
+        description: |
+          Identifies the type of thermistor connected to the device.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [19 20 21 22 23 24 25]
+        maxItems: 1
+
+      adi,rsense-handle:
+        description: |
+          Phandle pointing to a rsense object associated with this thermistor.
+        $ref: "/schemas/types.yaml#/definitions/phandle"
+        maxItems: 1
+
+      adi,sensor-config:
+        description: |
+          Raw value which set's the sensor configuration. Look at table 52 of the
+          datasheet for how to set this value for thermistors.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0 1 2 4]
+        maxItems: 1
+
+      adi,excitation-current:
+        description: |
+          This property controls the magnitude of the excitation current applied
+          to the thermistor. Look at table 53 of the datasheet for more info.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+          - enum: [1 2 3 4 5 6 7 8 9 10 11 12]
+        maxItems: 1
+
+      adi,custom-sensor:
+        description: |
+          This is a table, where each entry should be a pair of resistance(ohm)-temperature(K).
+          The entries added here are in uohm and uK only for custom thermistors.
+          For more details look at table 78 and 79.
+          Steinhart-Hart coefficients are also supported and can be programmed into the
+          device memory using this property. For Steinhart sensors, this table has a constant
+          size of 6 entries (defining the coefficients) and the values are given in the raw format.
+          Look at table 82 for more information.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint64-array
+        minItems: 6
+        maxItems: 128
+    required:
+      - reg
+      - adi,sensor-type
+      - adi,rsense-handle
+
+patternProperties:
+  "^adc@([1-9]|1[0-9]|20)$":
+    type: object
+    description: Represents a channel which is being used as a direct adc.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can be connected to one of the 20 channels of the device.
+          Note that, for differential adc's, the minimum is 2.
+        minimum: 1
+        maximum: 20
+        maxItems: 1
+
+      adi,sensor-type:
+        description: |
+          Identifies the sensor as a direct adc.
+        const: 30
+        maxItems: 1
+
+      adi,single-ended:
+        description: |
+          Boolean property which set's the adc as single-ended.
+        type: boolean
+
+    required:
+      - reg
+      - adi,sensor-type
+
+patternProperties:
+  "^rsense@([2-9]|1[0-9]|20)$":
+    type: object
+    description: |
+      Represents a rsense which is connected to one of the device channels.
+      Rsense are used by thermistors and RTD's.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can be connected to one of the 20 channels of the device.
+        minimum: 2
+        maximum: 20
+        maxItems: 1
+
+      adi,sensor-type:
+        description: |
+          Identifies the sensor as a rsense.
+        const: 29
+        maxItems: 1
+
+      adi,rsense-val-micro-ohms:
+        description: |
+          Sets the value of the sense resistor. Look at table 20 of the datasheet
+          for information.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint64
+        maxItems: 1
+
+    required:
+      - reg
+      - adi,sensor-type
+      - adi, rsense-val
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

