Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9947D188886
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCQPE7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 11:04:59 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:33496 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726388AbgCQPE6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 11:04:58 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HDbxfW000726;
        Tue, 17 Mar 2020 08:57:04 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00010702.pphosted.com with ESMTP id 2yrua11mn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 08:57:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1pBipBnvbXZzFvibq/IrkVaxt2PFGWENETVSRxelzwulketE6ATcNrW8aT/UB06DrAvPgjpulZQHOb071g1Rea/F9E2B38lAnEjvULQmknzplNy3Vs4D0AXNPsIjvZ5Eny4pAkuLMFEcGvgyz3a+AwU3d8/6h/zc+IcOcQ4wGW9k8WQV7Xzcdrye+6yMIDhNv6HgGl6XUxcB/px4xH9OGVKkozv9lnq666WaJcFdNPSKZH1+y6v1uUi0SyVqccX4YUAx1436MUYH/nUlOaQl3BVNAJHgfOnqOkQ2Fd16C7dfmh78PCAlJ9ZWR2AFUU0DQ2xasAsLexKebcYw+xK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTc1M08uh4ajhnLJSGyCpHmDMmV/ESEmtH376gDBt14=;
 b=GyYef7Sus5xe2kxqd6CJBd3coLOOTvNRtbJH34Xa5JjMGg+rT0+2OPcYJMcQh704dYBAeiPmLYDLV0IzxYmO0D/eXvTc3QZmtzYzObnwgoXAE131UWMdDoHl+oLRW0rAhmVAsw6G+7505/ApRp5jhb6Z0d5BGgx70iReMse1ArA5jO+nNyzPhPTPD0nT1OdfU6Bsfsw1U6DODU8KWoMUv9+E7Ap2HxvyG6aAhvorWN7qYR4G+5A1i+5QKLk/aKM93Q6ZoDP0FpuX0e66p3zI59Sui8Vo0GZcBYI6Qy8S47c4/2kgTHywF6PGk4NvBSdD1tb0l4dCmXhl0YMRXprdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTc1M08uh4ajhnLJSGyCpHmDMmV/ESEmtH376gDBt14=;
 b=B7tejMTZoe8MrP5Sj+tUxCQ8j1gqScsb8hK7Mkyzg99sbzabyKnSoBmzkMBBOMFuH2AYB4h/3CFP8v8K60pyRONAFGHXkK5U+uDdfdy6bsG87vFKCoZ8vdmh/gsz4lOpaMSLDDIiXnDRYcdGzRFDb4N0Rjze5g9dvw1RbV7mJVc=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 17 Mar
 2020 13:57:01 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2793.023; Tue, 17 Mar 2020
 13:57:01 +0000
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
Subject: [PATCH 2/2] dt-bindings: iio: adc: ad7291: add binding
Date:   Tue, 17 Mar 2020 08:56:49 -0500
Message-Id: <20200317135649.8876-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317135649.8876-1-michael.auchter@ni.com>
References: <20200317135649.8876-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by SN4PR0401CA0034.namprd04.prod.outlook.com (2603:10b6:803:2a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 13:57:01 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71534422-479e-48a5-f597-08d7ca7b1128
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3567:|SN4PR0401MB3567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB35672C9A560BDCDE14C5BBE587F60@SN4PR0401MB3567.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(6666004)(110136005)(966005)(2906002)(6512007)(186003)(66476007)(2616005)(956004)(44832011)(6506007)(5660300002)(478600001)(52116002)(4326008)(316002)(26005)(1076003)(16526019)(66556008)(36756003)(81156014)(81166006)(8936002)(8676002)(6486002)(66946007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3567;H:SN4PR0401MB3646.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMxMguFKxcGNw4yiYPqhXXMCmY1oMZIq6hTf/ORCfV76p9SzpXT08t88GsfzVZfffyQOH7JAMb9KNFCpPqbMrC/z+Xl5kW4C1ybEAMzTjheIORuaKCk+T3+EaC4t/pUE+ToUZlu3mfLMgDS8Cqs3/UmAULpY+NjRQZuOmEu0b0B5Ho1R4sUhAlBREhb1mDVn/4MORwPwwn0JTLhL1G1NgTzB+sVZudZJpPSZRa2nh1TndexA7I5RzInTiQwdX9ChajNPt7QHiJCjpe1adeDq4PTvvJTANfEilXCMie9XN51kFJ0vuTLbr1jLqEvLS+jpKCagFpsEmtNKffORt3JxuwFLETsk2LZi87+DJBhJOpmcOZIXWY29t7EYFaA0xRRTrLdg5z9G0Zp1Tpm67V0o9BEn3V5w3OZFPxybLNZhFYQcjfiwq09kw1OSYKKDVWI5730oZH2ayLphTJBeGUR+Q3//XDuS6kW9xeN15dBIZxLVnilh/fuk4EiD76o/ic/znorg7nlJoKxGmOnl9cwO4g==
X-MS-Exchange-AntiSpam-MessageData: DyP3RspsG2/j4W3atibpwwzRWQRS4ikfLHMqkjnfzm3p7dnk2TVSBtoKsSwLO5hJIfSxQITCIf/2za9fVS2WeBTHWP+UNvYuf+jRHbyvlhrWLvMU2NHJ0hJFdpQhytIp+gZkFyTqUTtIjbE74M3F1w==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71534422-479e-48a5-f597-08d7ca7b1128
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:57:01.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRWlkJAheJfHYDs5ZY96yxK2u4Oq+dw0gCyfcpkutLtmXBggG732Qlq3tZWhmP6In5Fxf/4MEJG1xW+WOsKpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003170060
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree binding for ADI AD7291 ADC.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 .../bindings/iio/adc/adi,ad7291.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
new file mode 100644
index 000000000000..93aa29413049
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7291.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD7291 8-Channel, I2C, 12-Bit SAR ADC with Temperature Sensor
+
+maintainers:
+  - Michael Auchter <michael.auchter@ni.com>
+
+description: |
+  Analog Devices AD7291 8-Channel I2C 12-Bit SAR ADC with Temperature Sensor
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7291
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: |
+      The regulator supply for ADC reference voltage.
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
+      ad7291: adc@0 {
+        compatible = "adi,ad7291";
+        reg = <0>;
+        vref-supply = <&adc_vref>;
+      };
+    };
+
-- 
2.24.1

