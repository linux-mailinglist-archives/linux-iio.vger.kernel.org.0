Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E816613AAB7
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 14:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgANNWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 08:22:46 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:24002 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbgANNWq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 08:22:46 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EDEMoU000528;
        Tue, 14 Jan 2020 08:22:25 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb7k7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 08:22:25 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00EDMPMm007407;
        Tue, 14 Jan 2020 08:22:25 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb7k7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 08:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7FlCe1scOCULR6ujPZfwgSUc59Xa9HQtN/BD1bc4Gscu1Ro2ucDAXDnQPpP0T+tmqifZ6O7wZj10ZsKvRr1+qIXaI3ySL24Og5sADvEC5BQrH4c6f0D2jLUUjyMfgAVPQZuLGcYAo39AlhYvaV/4tat3BaegP63itLrepyGGCp7obQ3PBcv81ZoAO92ZlkAbtIphRXUrVWVVnly3Fm4GhhxHXv1ZnfYfjAEUXfGx47gOGaWZkBhBMjUJzyoHOgWRDdr4Aa82+hIRDMCShKOkpeKgQAV+nD5ouF5W7H7T8Lv5AYmUgfB2GEcnVjyQzgGXiJw9pWNIzuvWBWZRo8Lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktorYfXBX8vPbmGbfqEcoyw7uElCtCNaSOPAqGlXCmY=;
 b=DZmgVUSronmxCb/fv0+qdReVYrEVzLNMj9ZGSxRr05SqrY+qO2w5MINaUSNkqn31uyQQV3XqaFIq9N8mEubpWhxD0qtyqd24ZJ6uFCkiPESoSFqrq+FRa8sKDUNEW/25mE+UgpGoSeot5M5V/55nqF0yk/pdkfQ4Op1dmZw6UAhL3OVFGr4P1rNGRk5hqfmsnO8cdqOIl/Vkv7AZ/AeUqwzjj1LqwtFF8a4u2nClSEU+dsk5p8zMXB8T3dZu3vqxDvdCiigDuhY69f0gNBSgHylKvg/S/pvwSpclkNwOFLpuSdUE4MhQfw/qM9/GAB4vrYgWB2kMOT2PUfdLqH5xag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktorYfXBX8vPbmGbfqEcoyw7uElCtCNaSOPAqGlXCmY=;
 b=UR/0hZPN9T16qGkD4uPk4PqMoB2XDNGuiMxIRJbMWXqHyLsOkN5+nxxNPV4tGK8PEPY7iAsUwAt1+SQv1bFjEZJdP8anjHtEajNoi9arQAGrTD+gmh6L9JJvQYEkvGULMbluQm8w23ecqFD9omYc795A3n7J39EUtQJwoF28u4A=
Received: from MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31)
 by MWHPR03MB3101.namprd03.prod.outlook.com (2603:10b6:301:3d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12; Tue, 14 Jan
 2020 13:22:20 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by MN2PR03CA0026.outlook.office365.com
 (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend
 Transport; Tue, 14 Jan 2020 13:22:20 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Tue, 14 Jan 2020 13:22:18 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00EDM5SC015201
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 14 Jan 2020 05:22:06 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 14 Jan
 2020 08:22:16 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 14 Jan 2020 08:22:16 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00EDMC1P020256;
        Tue, 14 Jan 2020 08:22:12 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <robh@kernel.org>,
        <Jonathan.Cameron@huawei.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH] dt-bindings: iio: adc: ad7606: Fix wrong maxItems value
Date:   Tue, 14 Jan 2020 15:24:01 +0200
Message-ID: <20200114132401.14117-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(2906002)(6916009)(86362001)(8676002)(246002)(1076003)(336012)(70206006)(70586007)(186003)(26005)(7696005)(426003)(5660300002)(7636002)(4326008)(478600001)(6666004)(36756003)(356004)(8936002)(44832011)(54906003)(2616005)(316002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3101;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56e76276-9e6b-4a37-e53e-08d798f4c7ab
X-MS-TrafficTypeDiagnostic: MWHPR03MB3101:
X-Microsoft-Antispam-PRVS: <MWHPR03MB310107BC45141AA355670737F0340@MWHPR03MB3101.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXuqodkYbawF25YpEFm+v6jGYJXhb4jByaFOzgg1c3Bptns0C3pvfJRXAkxO+qPa7xwsrIojp8/jRxFmemyTKU2WITgokkKrLZ1xrIhX4kqS5RWKUtUhUoKZWYH75Kcz0VcZ7Y+IB25z6q1eMyjcnq5Bx9HAldf0ze7G+NsSUqdLSVROi5/CZXYQ/VwL8OvdOCFi5hfGTO8OWkO3SoYWOsm0UFtrz0C8BnHPsPDo73apIdMmu3syx5WiZzUAYsSAt/VThNgeurVW8TUR5k7OpXZv7q5ArAINXjtrh7LAW8x6KYLm5dYY7YCYoxOlCPZyPlG2sKfwdPjLgDL2JEA1m4PIKm3ivbQC14ulV0MGsCW4Cc9QynuFtC9XOnCx30AVTcupAmDTYSa8Inrgj9KaX1m2D4idgrokzhC++70E6BjmYxbvT/ztUO2Foowv2jCa
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 13:22:18.4066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e76276-9e6b-4a37-e53e-08d798f4c7ab
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=750 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set the correct value for oversampling maxItems. In the
original example, appears 3 items for oversampling while the maxItems
is set to 1, this patch fixes those issues.

Fixes: 416f882c3b40 ("dt-bindings: iio: adc: Migrate AD7606 documentation to yaml")
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 6eb33207a167..5117ad68a584 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -82,7 +82,7 @@ properties:
       Must be the device tree identifier of the over-sampling
       mode pins. As the line is active high, it should be marked
       GPIO_ACTIVE_HIGH.
-    maxItems: 1
+    maxItems: 3
 
   adi,sw-mode:
     description:
@@ -125,9 +125,9 @@ examples:
                 adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
                 reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
                 adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
-                adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH
-                                                &gpio 23 GPIO_ACTIVE_HIGH
-                                                &gpio 26 GPIO_ACTIVE_HIGH>;
+                adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>,
+                                               <&gpio 23 GPIO_ACTIVE_HIGH>,
+                                               <&gpio 26 GPIO_ACTIVE_HIGH>;
                 standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
                 adi,sw-mode;
         };
-- 
2.17.1

