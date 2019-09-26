Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79856BF028
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfIZKwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:52:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38576 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfIZKwU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAlgbm010047;
        Thu, 26 Sep 2019 06:52:15 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2058.outbound.protection.outlook.com [104.47.40.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwy7yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGdxjHLor+KCFK+WfJwcdljsjDQ8TBtD50AlCuICq3GF9mCZgGw3Ky58wVdoL8dVipGRX+mXSIXagNZ5mScgphh5c4/ufCAMPPEg45Fn6yvZLS6vF61d6YDKcs7C+qjVJYyBK7acjRtYcSQJpv80yfMArB8UYQzxMtbRUEROAe7bWzJ3BMkGhLffkDM8vzgE4F9Ufs8kG+4LyDbByaO9RDjQtl/EtAg3jtj4Qg4ZwYQvKQrsB9C12FsUwLeOHyHP+cwZOohpssSz21olO+cW93EvnEVo3k+NH+N4P2sCLt2lfHe4VqrwbZwhdcDXlWTQBCHQ5SEUMKGiTHQ9VRKf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N//v9tP42mO82MASuaLghoW7AUmfw1VhX5gXorThYfI=;
 b=CHxzx3pylJo7Ec+t56RLya6ibPAWvrq4G/mObPNwcU3TD6U0EJA6lUdFFZ3N2aSrxtuHuzumXv4WzHaR9YxmFU/HUmYHVXeVvWue/MhaZ4cwH+aw+qLo+g5NHVbq6OAzHkoPpWBN28wL45LZcagEYqlPHEYHEzFDurfUJGJYrZ/Fw+lk+v97vLr6C8fbaAnjmIViS29VLP2rmsgyK80Uz4QBhGtx0wusyVzWzn19lyZqN9smIa18K7cwM0pJJgu/8cvivE+6+MloYXYbWzSxQsJYycg1YSqt1zt+EAhmiurOWYEpZN2tDJPnSVD5c2bxH9Tf0RclLV44JLY0JY9PSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N//v9tP42mO82MASuaLghoW7AUmfw1VhX5gXorThYfI=;
 b=c/BVvjXq77/r+f97P1/SbEANYpgxMVz5eK+tIbCd8RAheVIUOX5N3h5Oae0rLvpDmvmlfy6Aj/00CB4QzyShKenELVLz/2h63NL7vbDbeYrRdUAVPVyKpM5dVVNw1Ni4WV+aSXjBUuhMHwKWZTmnt7uX68uHcCs/MlSS8RI4w3s=
Received: from BY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:1e0::15)
 by MWHPR03MB3182.namprd03.prod.outlook.com (2603:10b6:301:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 10:52:12 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BY5PR03CA0005.outlook.office365.com
 (2603:10b6:a03:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:11 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqBLC014754
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:11 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:10 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 01/19] spi: move `cs_change_delay` backwards compat logic outside switch
Date:   Thu, 26 Sep 2019 13:51:29 +0300
Message-ID: <20190926105147.7839-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(189003)(199004)(26005)(47776003)(106002)(305945005)(54906003)(8676002)(7636002)(478600001)(2870700001)(7416002)(4744005)(316002)(110136005)(2906002)(4326008)(50466002)(8936002)(1076003)(186003)(446003)(426003)(11346002)(486006)(6666004)(356004)(336012)(2201001)(2616005)(476003)(126002)(107886003)(48376002)(36756003)(5660300002)(246002)(44832011)(76176011)(70206006)(86362001)(7696005)(70586007)(50226002)(51416003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3182;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d110576b-0f0a-497c-4c02-08d7426f95cc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MWHPR03MB3182;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3182:
X-Microsoft-Antispam-PRVS: <MWHPR03MB318244D7D2821898CF033766F9860@MWHPR03MB3182.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wgeW8tUdjEp5GCGFO/VF0/yaBgCHBK180e6fWlZb20lYTySWcnCa+Ks92PYVpKdoyWPa9ZLXJXkymhqQc7qNV7+ivyqYW9+md9nhKJeIBR3Dem1bslF/wjO8R/dM9YufphvI6fQkUG8TtDdLDjKg+8uR/oB9HTytAAk0Fbu+ynQGyNlMEAM3ulaAnCryMfF6HTtua6z4nVz1xvzSH+x8G4B+0aDleCvjOa7R49Y8LsVplmmcBER/4eI9UHq/W1Gtcc8POG1gKI2IV+bSe6ZfwYwYYiBaItJOCz0mPGsZLHD1a9CEsT1JxXTlRNWqidAmTzOD2hBgLA8OlLx+H2HVB9MCdr0v/0JGGE+VVqhxZTDkAGVOK/ND71CjLkosrIjoQJDMExAT0sb8aAw54+Zlb7NrHJSundtcnmLsTBK9pD0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:11.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d110576b-0f0a-497c-4c02-08d7426f95cc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3182
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The `cs_change_delay` backwards compatibility value could be moved outside
of the switch statement.
The only reason to do it, is to make the next patches easier to diff.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae52..c90e02e6d62f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1114,16 +1114,15 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 	u32 hz;
 
 	/* return early on "fast" mode - for everything but USECS */
-	if (!delay && unit != SPI_DELAY_UNIT_USECS)
+	if (!delay) {
+		if (unit == SPI_DELAY_UNIT_USECS)
+			_spi_transfer_delay_ns(10000);
 		return;
+	}
 
 	switch (unit) {
 	case SPI_DELAY_UNIT_USECS:
-		/* for compatibility use default of 10us */
-		if (!delay)
-			delay = 10000;
-		else
-			delay *= 1000;
+		delay *= 1000;
 		break;
 	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
 		break;
-- 
2.20.1

