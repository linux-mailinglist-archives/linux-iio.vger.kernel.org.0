Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3288F322B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 16:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbfKGPJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 10:09:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25276 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388220AbfKGPJh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 10:09:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7F3apC008704;
        Thu, 7 Nov 2019 10:08:05 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w41vvjcya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 10:08:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnNKytp1xCJUe1EXS0GGJJxBO6F9ux8l9Lrfjmv5P2rvFT3ox6dwL2g+lkdnUxvyDfPwVF39rHFYNmy0vLeFeFReAaI+820VrLCAxdN73PFu2dephV25+P0gjSEWBdRJfi/E7b3gj7h90cFRsz6gnuFE+nYu1EBIyM6SjAx9OR7jGy0f7exO4k1e6b00rsfI1hdrpU07LStSz5yGLi8pDNjbY/1DxWFFhDN06lTJshJpDTwfhOPjMpB1+f//ejrktYZ447BA3LU2ZiuxGXWLz36zBZF7JrVdXyUvGghsB8BDLmsjSTI2hPyY35uHNhAwd5HCzvlNApkXjjglijPJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odaA4h5Qhdb1aJ3BOFc9ck22eij2f9psKSxBRo817+c=;
 b=lnQ1P+AfZ/76LcTEIBhqum5j704Pnf9MgAZ7++4KQhR9yOXHeW5S/45uKDpGglEcqXHTx9ONB54YXtEhTOM4i9sZHVuQumveaSe2dAS2Tz44ctYBtPaZ6+uQ3OWLDhwnMRSr7a47vTvi+mRU588GUrZzgaxzeZGK3RJQsfABdJfI9D2hTZUu1xbOS9jcpcCtVV4glbQhXFi2PCFYJkQFl30s+odkMMPXO5OxQxzKfMSPTHOWFLQb8dBDVdj4xc5ZTuriAXKjQONLRY/94GVwZwVPdfzhyo7/zuy/nYy6cJw76Z+XouzMq804llUHGcvWjyES0GMTLM5VHQ36ZJz3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=none action=none header.from=analog.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odaA4h5Qhdb1aJ3BOFc9ck22eij2f9psKSxBRo817+c=;
 b=8Yf3m51+RxYDL+w4LJBsoDw+n2LUPwn/OsQ92PgQXb0WBSktizWcN49ahUjT+JOFKQoJnrSJd5fy6p62b+jt1KGleoWglq24sCVfcaD1qs5vn/cXJ8Erw6+7i9chSLPmABMF/ILf6CxCVpIDCEEtTRN6PQ48YwLe6u/9v2gVoM4=
Received: from BN6PR03CA0019.namprd03.prod.outlook.com (2603:10b6:404:23::29)
 by DM5PR03MB3049.namprd03.prod.outlook.com (2603:10b6:3:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 15:08:03 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN6PR03CA0019.outlook.office365.com
 (2603:10b6:404:23::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 15:08:02 +0000
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of analog.com: DNS Timeout)
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 15:08:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA7F80UO024290
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 7 Nov 2019 07:08:00 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 7 Nov 2019 10:07:59 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <paulmck@linux.ibm.com>, <mchehab+samsung@kernel.org>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 4/4] MAINTAINERS: add entry for AD7091R5 driver
Date:   Thu, 7 Nov 2019 17:07:59 +0200
Message-ID: <20191107150759.5937-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107150759.5937-1-beniamin.bia@analog.com>
References: <20191107150759.5937-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(199004)(189003)(50226002)(476003)(2616005)(107886003)(54906003)(16586007)(446003)(316002)(47776003)(51416003)(7696005)(246002)(63350400001)(305945005)(126002)(2906002)(8936002)(44832011)(4326008)(48376002)(356004)(86362001)(186003)(36756003)(106002)(26005)(2351001)(486006)(50466002)(76176011)(6916009)(70586007)(70206006)(6306002)(4744005)(478600001)(1076003)(11346002)(5660300002)(7416002)(8676002)(336012)(7636002)(426003)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3049;H:nwd2mta1.analog.com;FPR:;SPF:TempError;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57d63447-1039-4115-8ba7-08d7639447f9
X-MS-TrafficTypeDiagnostic: DM5PR03MB3049:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR03MB30495DBFB8861DF482C35C60F0780@DM5PR03MB3049.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7enl6D5hPM9Uim0UYqrzefhTHbsjtdaDhlwRKfiCn4P0ZdSWRTA9mDGFklRozubwabE/4q0BBHYpl9/BJdkzU/IpKmli9KrjkrRmIUHQyhHU3gHWmjUN+Hj3CSF9HwhuKkbJ3DCAnTb57GWd0jp3N8uKo4BNaybe3aPoocGW9NxONC3V+nppaFqmgcpnE0qbwnHnuwqPiRp7kbfIuh7V0KSAVlOKP1KbF6aOxltGT8uI2JIh2dT3CXicFEuArGd7jJJKmB0wdpJSpNJiEOTOBDL6c2uNJgnGbx7hZpl78To4c0l3nXtLL4Ws0YewYxZ0LMr1A5tTeq8mCRWAmiDFFAIJH+PcIQxE/vWpuyG4ILOoU4QBsIRbgFuFg+UhlS5xzc74FxIhdsIDKjMcGw/bAmgzJDlR1N5xzrwVDMUN0tseNwaR2hUVzK24hmlWD3d3ytigaBhowbaCeSCRhx7sq4W4PzUcGjSzqpITC5cASjQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:08:00.8749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d63447-1039-4115-8ba7-08d7639447f9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3049
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=1 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as a maintainer for AD7091R5 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v3:
-nothing changed
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e01d0f0b0e5..7f1e4b88688f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -893,6 +893,14 @@ S:	Supported
 F:	drivers/iio/dac/ad5758.c
 F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
+ANALOG DEVICES INC AD7091R5 DRIVER
+M:	Beniamin Bia <beniamin.bia@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad7091r5.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+
 ANALOG DEVICES INC AD7124 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

