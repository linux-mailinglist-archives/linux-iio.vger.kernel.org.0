Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAA918A063
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCRQVs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:21:48 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:34098 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbgCRQVs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:21:48 -0400
X-Greylist: delayed 2795 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 12:21:47 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IFOLf4026838;
        Wed, 18 Mar 2020 10:34:52 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0a-00010702.pphosted.com with ESMTP id 2yua4ha91r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 10:34:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGuqRKWK7n2hYcu+XfnzAI/lGatTqhMSjKvZUIVD+HIVc5UhAqgJPf+p6XoOWEIc1t8Q6g+U6T4YWHGdqhlvYBCPJ0AqZ0d+9BfAACUW4OolXBopE0QM/7ATpL4gU8fU8yEhBFsnHrrvTNxdzDGLgzOxEOaeh3cDgZiVjKM9LQZm0Phjawr3V1eNapISv1SLDMKCwSXPVfRod4nR2Ns3TiaNPYvUqziw8liUsVf5ENZkslQ2wbXGAcfa+FLPZwxPqHrJtEdstcKQMw7RBz69XsscT07VhMrPEotA4mjm53iKF4ZEd3yYc8P1cbCWkTIST/YE3M+4LN0snpD8/qRMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDnFnkMX9vIGiWG8S9fUYcwhbKfMJZhAl7P3oDnd1Qg=;
 b=TLKn9E7S7CJE8cJw9GLPxi/s0Oy6gsP2zKUndwBgX3mdE4AI98rr6dHuixRHEbRF6D8+ERC0+JRyqkenzwD4MOlXDjMZD3r7bbiqOSswLJnXSSuUf/b/0Cx34c3OqlZUzfCraOvlAS5Jb0/m0mr3LzlFRCR8WjDnVjRWJTOj7yO8nwkYyH8WhpvfGvtlgwbBpVYQRFTqqw46xpcJWIOWig6PwjvgdS5rZTETQlo+eR28eVI9NSTUn3tZzOfl+tYX4ArD3c3/vuctLKCBpb8e6DthL6mD7SBwcQPnjphpLRby830vSpp5z86PVK4S9nhP9Fz9zU8x8xknZTUKbPFksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDnFnkMX9vIGiWG8S9fUYcwhbKfMJZhAl7P3oDnd1Qg=;
 b=AVsHbsGsvViikQ8SnbvbPxOwbqPHfF4SlZw8NrClDn16LYJNPWHJ8AXe1ubSRsa8GRoXkqz7Sia6teDMsgoeQQ1BMT4U2yqFx8xznvO886UAMi7VbzumI7iocU7C1lQ+/4ebTovVbCfNCzuub5r8WILOfMfgNlGXPCnrGnf7LBY=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3709.namprd04.prod.outlook.com
 (2603:10b6:803:48::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 15:34:51 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2793.023; Wed, 18 Mar 2020
 15:34:51 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: iio: dac: ad5686: add binding
Date:   Wed, 18 Mar 2020 10:34:34 -0500
Message-Id: <20200318153434.62833-3-michael.auchter@ni.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318153434.62833-1-michael.auchter@ni.com>
References: <20200318153434.62833-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR14CA0146.namprd14.prod.outlook.com
 (2603:10b6:0:53::30) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by DM3PR14CA0146.namprd14.prod.outlook.com (2603:10b6:0:53::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend Transport; Wed, 18 Mar 2020 15:34:50 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baa99a74-bc59-41f5-bef0-08d7cb51e62e
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3709:|SN4PR0401MB3709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB370950BD942A9B0C882BBCE187F70@SN4PR0401MB3709.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(66556008)(66476007)(8676002)(2906002)(81166006)(81156014)(66946007)(2616005)(36756003)(6506007)(44832011)(966005)(6512007)(6486002)(5660300002)(110136005)(478600001)(16526019)(316002)(52116002)(956004)(4326008)(8936002)(6666004)(26005)(186003)(1076003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3709;H:SN4PR0401MB3646.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juarWr5oX1TPTk5iel+G485b0dI0w/JQ7iPfrvuuS1hIebgxDbRN8P5usDUpB8jLJEdVadO+MKs2SmksZ7yuEX6nE0CCTjew7GfYoeHNxx4iPKwg3+xSQ+GK2QGdlEykMgTG/vWwafZocgOQYQiPuhhJ83t6FxS4SWM5Fkwv6yBUOdEww5nMbIR5KPqIIm9Y2iKEvsd48ejpP9O4LRCa1OUHGS68uhJqK33iFtE8T7dqfUO65pocZntuIbKhVDl3W022wfl6dC+Frjr3yNNf/dBXfP5yDH5PvE8G90qzLUGSApG0M2+Ja78QILvmjBEjlRPa5KI4WQN+Xpt0BmgHxSy/L3yJyfwKWtGnv7gHQH3oJiaaoVwPs5I4e8Pn5av6gMriMO9tEz11KX8ANGJf2Am4ph19mGOmYMweV+BXmncydxcu5WaUtcZAJz6Ucc4pDUN+dTJGqaNSsmlAIG1Cqs/DqOS1sOXUUWTBd65BniyioFWenIkccpizLK8uKP7mYAwlS0FIFG5mwAOCtTHc2w==
X-MS-Exchange-AntiSpam-MessageData: C67PBI+qn/Zfc25DPufZjI6sj3Zx7mhJqXuv4GuC1KQO6jPXnn1oPou47J1htX3ZWyLRP88piCloI4VBOnLew+1u5DXWdxNnmpA7FiiA5pcC2Cz3pV6iP2XBvnQfQczbJI45uqXcohqeG2y6mea0RQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa99a74-bc59-41f5-bef0-08d7cb51e62e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 15:34:51.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWWDnkMKgpsL1ftPEtvUp0tef8AH6bM+6yrGPh6cO3laKwlZ1VgQ3ioJ2stKI8fMSXsAmV+2kSwCeiTjwJio0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3709
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a binding for AD5686

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 .../bindings/iio/dac/adi,ad5686.yaml          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
new file mode 100644
index 000000000000..4bd379720e99
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad5686.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5686 and similar multi-channel DACs
+
+maintainers:
+  - Michael Auchter <michael.auchter@ni.com>
+
+description: |
+  Binding for Analog Devices AD5686 and similar multi-channel DACs
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5311r
+      - adi,ad5671r
+      - adi,ad5675r
+      - adi,ad5691r
+      - adi,ad5692r
+      - adi,ad5693
+      - adi,ad5693r
+      - adi,ad5694
+      - adi,ad5694r
+      - adi,ad5695r
+      - adi,ad5696
+      - adi,ad5696r
+      - adi,ad5338r
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: |
+      The regulator supply for DAC reference voltage.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad5686: dac@0 {
+        compatible = "adi,ad5686";
+        reg = <0>;
+        vcc-supply = <&dac_vref>;
+      };
+    };
+
-- 
2.24.1

