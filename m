Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFD713DB24
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2020 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgAPNJz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jan 2020 08:09:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57682 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgAPNJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jan 2020 08:09:55 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GD8e8f013810;
        Thu, 16 Jan 2020 08:09:53 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xfc59nf67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 08:09:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR7ZkHrS+nipbwFufwScnn6KxK2dJ5ja3NGtdt7d3cAWdh4d+5IWwylmT22bb6YGWJLK5SAogXxxI1PDHxd5W4N9StDsQiX/1LqYW2CPigdXytXMjQx1tVIDQzw9pmWqTwvgM5ytlCpuIfmjAC6TdEchJnQl0mHUPjPRPey1t8MH+ZBSekweqUAWtlcupdmXeuqP1wS5z0CnNScoS2GA1u8xCBkhsrkqvA4SalQoaz+jmphe/AR0bLhYeB7ZlksK8b7RspSYxn57jal29I5wvwRYGqfyWhBs6D+aHL/RZ96HnB3ibEIS2Im6pOAkli3aKiu0r32Un5KHCmVtfiJz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIY91KhqebyKLQ2zSBXKUQXnBpSjkTYUPFPhmR7uTQY=;
 b=Bv3lleGWbEY4HHqHJbEza5LfrkhMyP6hhuZ9wsdAok/TrtT/OCM+h9hlp/AzmWCZ7PEj3Oae9WOIMQFQPJgbVHgBBnJlU5wVWWiPSs5qRpz1b8ImJ8+0yp/Jsyj+qzFEeszZiYA351Zf4lYQVv6T52IHx9LI8ZYopMalT5WmdhA6sgj0ir+JrUtG8bgw69a0jeIIZ1sWf6K/WAPWbQ2OGSE/I4AbTVPoVinXTycDlyuVvzdRcGiAbktN4K5mWOOynAWBQ0Va0Rj/37rREwoUDlYewhd73OjywZahiqDNklomDkOeLBYf69cKkElwuAxWh1KIN6QkPtChkDYnBsxT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIY91KhqebyKLQ2zSBXKUQXnBpSjkTYUPFPhmR7uTQY=;
 b=FRPVaXlJNxP7bSsldv+f6wf2djJRJYQq/Ycr6Ob/MDwlFLwAlMv1ArTKNEb6YFIpN8sPWaJsj/yFWEvL9dx8aNKvAMkboDPd2bavsSKCBLevTKNskk1A/++XPRUjxZY4BOJjY9GaUNL8+2PvrDIdbSRrxfmOBZumJiCp9ZEG5LA=
Received: from DM6PR03CA0047.namprd03.prod.outlook.com (2603:10b6:5:100::24)
 by DM6PR03MB4794.namprd03.prod.outlook.com (2603:10b6:5:186::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Thu, 16 Jan
 2020 13:09:52 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM6PR03CA0047.outlook.office365.com
 (2603:10b6:5:100::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 13:09:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Thu, 16 Jan 2020 13:09:51 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00GD9b4Y022001
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 16 Jan 2020 05:09:38 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 16 Jan
 2020 05:09:48 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jan 2020 08:09:48 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00GD9gVC024849;
        Thu, 16 Jan 2020 08:09:45 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: adis16480: add compatible entry for ADIS16490
Date:   Thu, 16 Jan 2020 15:11:48 +0200
Message-ID: <20200116131148.18149-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116131148.18149-1-alexandru.ardelean@analog.com>
References: <20200116131148.18149-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(199004)(189003)(478600001)(8676002)(54906003)(336012)(26005)(7636002)(107886003)(70206006)(36756003)(246002)(44832011)(356004)(5660300002)(2906002)(70586007)(2616005)(316002)(7696005)(86362001)(4326008)(4744005)(1076003)(426003)(110136005)(186003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4794;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecddb91d-81eb-46bc-6434-08d79a855f44
X-MS-TrafficTypeDiagnostic: DM6PR03MB4794:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4794BFAE3BC89E2F93FFE81BF9360@DM6PR03MB4794.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsZ9nsmFe4vnERWlx2p2dyuIol7RPeLfitFk5VD2THDTxDGEFud9uguLznT/3y6+8YeOcIuuhme9ifaTOGefMM8NpjczD96t5uDsKU0dIjnTpMBqoeYmnnrqJ/ixLJ9rK6ByehZ/6col758z6sHSREscU/0ZqrO2CM+TEswLsrEzSqAhhFWSAM3UWiiw3PcXkRp0YzLHsfGPcMB5aikmc8TE7n9gyexFAmKRiRObmc6gHHK3MJ72J+ZkYMqxEQDQ+HHeUKI4276rtsmkqKdNM2ApOxk118S3wnJF6olr7CJcs43gxvVmZheDI9jwBhN22njJJLxwbxhAOKKjUtNgH19pHHZIE2ZvRTsSmwYaM78zpkBquRIm1haiEMwmWlHH6U5irJ7hArh6aPFjrGtTFVx8SRKAEvE5KOb8fyxtQ9f9bajJ0Oc+VIgW5Xx0zmJ1
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 13:09:51.4428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecddb91d-81eb-46bc-6434-08d79a855f44
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4794
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=889 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001160111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds an entry for ADIS16490 in the list of compatible devices
defined in the dt-bindings of the adis16480 driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
index ed7783f45233..cd903a1d880d 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
@@ -8,6 +8,7 @@ Required properties for the ADIS16480:
 	* "adi,adis16480"
 	* "adi,adis16485"
 	* "adi,adis16488"
+	* "adi,adis16490"
 	* "adi,adis16495-1"
 	* "adi,adis16495-2"
 	* "adi,adis16495-3"
-- 
2.20.1

