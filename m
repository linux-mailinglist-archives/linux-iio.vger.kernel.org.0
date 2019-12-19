Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1D51263B2
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSNhr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 08:37:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46940 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfLSNhr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 08:37:47 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJDUF3Q027292;
        Thu, 19 Dec 2019 08:37:25 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvtfdmhta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 08:37:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK7ZS/bAx0cjmCK5FeTNhZ1dwrd6SwqfUbvPNFeJcXFKJDxRywZP61EV5wQsRK14xXzkFvZ/4Fok0dJGlg5FsldpXrmnQ80fLhTtTzQblaNHdUcEyySt5tDY2/aEvCsi6kvVfR0Gr9hCCIXJLQYbwI6TuxtONcSTa4V2RFok2cGgsx1lg+p3N01c2HV1rCxcCOXWUvUlH0mOREG0/L68gsUbLIQ9Qp2vlo3RcZ+2rzRHyQllY9rNnSQ6I5KA7Z33xuNz1r2CT7JyeRqzDrU3GU0bjIxKgm9zudeRV6PzRIyAd2/mUDc/FVq7kFkhVeLgETOP7hFEvz/RNTdBAbZXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy3B1hnmT/YRaT5SeWs2Fs9eNIM9YStQjj6aIqH2DMw=;
 b=lxXt7tsvNAUkhp3mhXGuJh8eFpJJYat5+BjaHVZrufEt07SYX0zg7y6Af12jiEUFUIO3RZ0gLq/oKjjfGFYgYmUIr7Ztn7j7xQY589r7lVxmFRd2KHgRGtPOnshPRPFxxnVkI9hqpI2wCjCOj8sPzN71Af0QrOZp6gAW6bSknJZkszi/FCKUIb78R51LDsIVyGPi9RJEvDFHCsUtgTYoLnyhdelJDVxlvdAjmJNIr9yVr3MylVwZdjdRhc8K+pDox3rkckxLSPjtEl8qujUZ8orZfEVZYCLTnvcuZgz3cruLzY/M4lwfKb+yt/kA6mfIGZwj0+4d/WByUeeRGsHgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy3B1hnmT/YRaT5SeWs2Fs9eNIM9YStQjj6aIqH2DMw=;
 b=hTbCt7nRabmEHdTBISGYPbK1okyg+/3utAkkjdPvK/cBN7GKLC/x1JF0bjMfvBMtONWJg5zgLc1mGlU/lYfoDEuV/lOfTUJN1JtmdTSxVgMzX0VCgvHE0LQ5UcCqzXNpN/xeMxwGBFkwd4E71BpD3VjsagGCfB/MKnPzx0Fgf9Q=
Received: from SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) by CY4PR03MB2918.namprd03.prod.outlook.com
 (2603:10b6:903:133::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 19 Dec
 2019 13:37:14 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::b8) by SN6PR2101CA0004.outlook.office365.com
 (2603:10b6:805:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.3 via Frontend
 Transport; Thu, 19 Dec 2019 13:37:14 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Thu, 19 Dec 2019 13:37:14 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBJDbCtP012887
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:37:13 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 08:37:06 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 05:37:05 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJDal8f000582;
        Thu, 19 Dec 2019 08:37:01 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/3] dt-binding: iio: Add documentation for ADF4371 channel child notes
Date:   Thu, 19 Dec 2019 15:37:55 +0200
Message-ID: <20191219133755.26109-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219133755.26109-1-beniamin.bia@analog.com>
References: <20191219133755.26109-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(426003)(1076003)(70206006)(70586007)(6916009)(7636002)(7696005)(2616005)(478600001)(54906003)(44832011)(8676002)(6666004)(36756003)(26005)(356004)(336012)(107886003)(246002)(5660300002)(86362001)(8936002)(186003)(2906002)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2918;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 235bb793-53e0-4c17-1b37-08d784888ebc
X-MS-TrafficTypeDiagnostic: CY4PR03MB2918:
X-Microsoft-Antispam-PRVS: <CY4PR03MB29180BF960553045F4580861F0520@CY4PR03MB2918.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z7Pd0TJnZtArvG/Lsu0EdahZslZ3sZDIR2OhcfUgfgLqa6voG2ltabk+K0/nqonDxKCUBeM8M6CxttXErungwsZyZQ0icP1a6pGsvbzOBqf1zrHKQq4RHu7aBodmyzTMHX+fH9YaIqykWNNIxoKH3m6Cnn/8fkg9EyTwGGSUAEwPEH39kXFJM8kTB2wqGz1yM5n7vo5oEii+WTDQ1LHm7d9lzXJmNmqQuBqG2uHWfphKRi9TyC3o65eqZ05hQKKKXy2B+gZyPODDxA12nIrayWGkka3Kf7MMpaL6+oQMHFKZX6YaaumIOEWB/ploSXKlB1Hj8RNVEk3kHRGxLlygEFPsLxNIp/YTdmY+H7Vy0NewYesYq2/GHOmsE5Gnf+9fsMMYOKze+vQuU9H8zGOakrqUs+Zvjr1B+ndux4FHIILSfaJTOWS5KRgX/f18qdQ
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 13:37:14.0114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235bb793-53e0-4c17-1b37-08d784888ebc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2918
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch documents the ADF4371 individual channel configuration.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 .../bindings/iio/frequency/adf4371.yaml       | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 7ec3ec94356b..5339c929e883 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -40,12 +40,48 @@ properties:
       output stage will shut down until the ADF4371/ADF4372 achieves lock as
       measured by the digital lock detect circuitry.
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
 required:
   - compatible
   - reg
   - clocks
   - clock-names
 
+  patternProperties:
+  "^channel@[01]$":
+    type: object
+    description: Represents the external channels which are connected to the device.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 3 channels on adf4372
+          and 4 channels on adf4371, numbered from 0 to 3.
+        maxItems: 1
+
+      adi,output-enable:
+        description: |
+          If this property is specified, the output channel will be enabled.
+          If left empty, the driver will initialize the defaults (RF8x, channel 0
+          will be the only one enabled).
+        maxItems: 1
+
+      adi,power-up-frequency:
+        description: |
+          Set the frequency after power up for the channel. If this property is
+          specified, it has to be in sync with the power up frequency set on the
+          other channels. This limitation is due to the fact that all the channel
+          frequencies are derived from the VCO fundamental frequency.
+        maxItems: 1
+
+    required:
+      - reg
+
 examples:
   - |
     spi0 {
@@ -55,9 +91,36 @@ examples:
         frequency@0 {
                 compatible = "adi,adf4371";
                 reg = <0>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
                 spi-max-frequency = <1000000>;
                 clocks = <&adf4371_clkin>;
                 clock-names = "clkin";
+
+                channel@0 {
+                        reg = <0>;
+                        adi,output-enable;
+                        adi,power-up-frequency = /bits/ 64 <8000000000>;
+                };
+
+                channel@1 {
+                        reg = <1>;
+                        adi,output-enable;
+                };
+
+                channel@2 {
+                        reg = <2>;
+                        adi,output-enable;
+                        adi,power-up-frequency = /bits/ 64 <16000000000>;
+                };
+
+                channel@3 {
+                        reg = <3>;
+                        adi,output-enable;
+                        adi,power-up-frequency = /bits/ 64 <32000000000>;
+                };
         };
     };
 ...
-- 
2.17.1

