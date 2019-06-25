Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF5954FF9
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFYNNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 09:13:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61766 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729213AbfFYNNw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 09:13:52 -0400
X-Greylist: delayed 710 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 09:13:51 EDT
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PDCcsC017153;
        Tue, 25 Jun 2019 09:13:51 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tbgangm76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 09:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbLYyRsu6Hyk3aNYwdoYr7R9RJRI0gQD8YzAXjCDCTg=;
 b=LXjqMlEn0wHUeHE7Z8oxLyeQ90lv41jsRjuKhbNX/9y/C2higZ/zavFOe8ogym7x+nSPdJmm/NTvtM9gPHG7LgyON9Wf1xq+p3PRO3yC6HT1lxOU6Q4StKk5yfHoLVyJ9LrfH0w0Z1cIdX72Arg4a0Q9VTqT8B+Y0Tx0W6DZeic=
Received: from BN6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:404:10::14)
 by DM2PR03MB560.namprd03.prod.outlook.com (2a01:111:e400:241c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 13:13:46 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN6PR03CA0100.outlook.office365.com
 (2603:10b6:404:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 13:13:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 13:13:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5PDDj1o008719
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 06:13:45 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 09:13:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/5] MAINTAINERS: add ADIS IMU driver library entry
Date:   Tue, 25 Jun 2019 16:13:24 +0300
Message-ID: <20190625131328.11883-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(199004)(189003)(50226002)(2906002)(1076003)(4326008)(8676002)(450100002)(26005)(6666004)(5660300002)(7696005)(246002)(8936002)(316002)(110136005)(186003)(2201001)(70206006)(2616005)(356004)(86362001)(51416003)(126002)(70586007)(476003)(44832011)(106002)(486006)(77096007)(36756003)(426003)(7636002)(305945005)(478600001)(50466002)(336012)(4744005)(47776003)(2870700001)(107886003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB560;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6740d2e5-c320-4944-226a-08d6f96ef44e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM2PR03MB560;
X-MS-TrafficTypeDiagnostic: DM2PR03MB560:
X-Microsoft-Antispam-PRVS: <DM2PR03MB56096F753EB360BFB70BA86F9E30@DM2PR03MB560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GZF19NH38K+1hk/FCOW6Un3gp5YXXHJR/oq/9fB3SSBE1Q29OLxuttBoR0wIrCMwbGpnHiS7YmbgNhT/wTqu29L2UyE6a5Rm3xFG+vVbMZC60oR2LBek+/RYm6Oc/87GmNrWTZhbrnReNDAhlijO1CQ4mK6VWzBHwVdQuyxTo2MExBZDM+r3BBS5Tf123IK8QnUdYWWd2XEUi5y8YOjQwJhHjm2Uev1D55h+FrqDs/MqIeWgwHHekDUpHUbS+6r5bbmgDrjD9Ue+9poOA5dUCI+J8gcKhtzdYfWNc3iOCv4cvzBVyD4Iq8uafJ5s8MRar4Em5dzDtEc93+6VsOrJTy3TiTv3JAKcEv7q9vdKMrbTV10/makY8S0/FVlOAM676Pm0DFPvI3GKPT42+em50bsHMw0/8A371RfbHYrR1pw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 13:13:45.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6740d2e5-c320-4944-226a-08d6f96ef44e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds the ADIS driver library to the MAINTAINERS list, and adds
myself as the current maintainer of this library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1eb971608ac4..544e23753e96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -930,6 +930,13 @@ S:	Supported
 F:	drivers/mux/adgs1408.c
 F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 
+ANALOG DEVICES INC ADIS DRIVER LIBRARY
+M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
+S:	Supported
+L:	linux-iio@vger.kernel.org
+F:	include/linux/iio/imu/adis.h
+F:	drivers/iio/imu/adis.c
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.20.1

