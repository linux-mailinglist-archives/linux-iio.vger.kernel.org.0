Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1115B1A3F
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfIMI4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:56:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40966 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387402AbfIMI4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:56:03 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8qnXp010601;
        Fri, 13 Sep 2019 04:56:01 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2052.outbound.protection.outlook.com [104.47.50.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfsakv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:56:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUQE28TR35Wf4eB3EdfDCAgNWwcn+m92xe+s8ow4RExmFxhoaMV4pZqzWZWYz+ob6+AS8tteiO5dTpG0Q8UI41u4MgtY7GV+77njJpX2hOOfUWGKrl+pG6/vRtkFwsDMNEw50imV7n1b/rHenvKRbseb10bkgandft84hiwdshyplxAAhbdxGdUFajyoiFWMnIA0TKs4fj+DElnxUwgyv1D5YUPKZybu9oF5U7KVlIiWAfUHoRk99SpINCKNeJASxeQGfRIiAywVIj3W4KvV0Vcy+Am60VrEX5lMOn840DraU06m1eWr3MG5/qtWMTiHE8U8vBpoubis7nBEPpL69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N//v9tP42mO82MASuaLghoW7AUmfw1VhX5gXorThYfI=;
 b=kP3qHsGbePZBUUvR4h3gxHtoDMRZqfR32UG3xQsB3Z0mZNUMcdh0wZW51JW+/Opg9DCJPW1e097E2PNHEPxOeLjkCNt4mGcLRLZUk0g+ETAVSyBlInmpU0XeCiU8N3aaNYcCz/HUEhEm7WuQEwn/lIi7RaYXwYR8ly5vApY7rmGFkO1rwQyFHYmLz9O/7OJPQMbWD/auPP3c/0/1IE6no/EAGUdZf/nD9bXrqme1DGHjHMWbH/sSgJy/Cr9VuLTnQaW0ZyAT+/DTNT2M5hK7kL+W0tsBCSqAr+qm1KdXsoriBDOeqFo7YmUqTOGVSWOSLZLDpsCo/sH1YGBXKouXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N//v9tP42mO82MASuaLghoW7AUmfw1VhX5gXorThYfI=;
 b=ZfpR/e5VcDgezYPZE6d5YzELQxnZgoIhz/1vhoaT8IPKzbQWI93gf35q1WMB18LEwN2mJhemCOz4Vcz4xwb/HidunkakMuxI+oNdMTl/nKc6LhdjQ8WGP3dlmQFHQVVd9g1cgd65PQgIxK+JeEHQ4NUBKXWdpxJdWk+H9EvVc3A=
Received: from DM6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:100::39)
 by DM6PR03MB4618.namprd03.prod.outlook.com (2603:10b6:5:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.19; Fri, 13 Sep
 2019 08:56:00 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by DM6PR03CA0062.outlook.office365.com
 (2603:10b6:5:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.19 via Frontend
 Transport; Fri, 13 Sep 2019 08:55:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:55:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8tsOX000404
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:55:54 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:55:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/4] spi: move `cs_change_delay` backwards compat logic outside switch
Date:   Fri, 13 Sep 2019 14:55:46 +0300
Message-ID: <20190913115549.3823-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913115549.3823-1-alexandru.ardelean@analog.com>
References: <20190913115549.3823-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(316002)(1076003)(8676002)(76176011)(336012)(26005)(186003)(48376002)(51416003)(36756003)(54906003)(426003)(305945005)(7636002)(7696005)(110136005)(2906002)(4744005)(2616005)(107886003)(2870700001)(106002)(70586007)(70206006)(8936002)(50466002)(126002)(446003)(5660300002)(478600001)(486006)(44832011)(2201001)(476003)(50226002)(4326008)(246002)(11346002)(6666004)(356004)(47776003)(86362001)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4618;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23f2435c-47d2-4943-bf18-08d7382832d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR03MB4618;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4618:
X-Microsoft-Antispam-PRVS: <DM6PR03MB461834232AF10F87D9ACFFC4F9B30@DM6PR03MB4618.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: IWp8zEdHnrDQcUzGp5yGsuSRvejnVNtg2uUpaSYpSoQjqEGOHfC2wITSS14tB05k8tAqzWhrF9nDV5lyLjZr7WLEj7ifFOTqbQjJIHig4bo4aHDRJ0zL1GTINgrxM4L2pzZuBKuMZZ+ZbnBLGbvUxTUPkEKpo5/A9z7pxCHz8woOyDm8PMbqyOCZvnzc0LRAsMNFSTSDZ2CLLD+isompC1mu1/A41nskiYIqUv2uJnH+7AwoSLemf7XpZFzF+9a7ImqnlSr2dqWvTo+cxIXUCeLRMDJnPDRhxlwEHI7Mmozd6VglIsHUX9/dXKNY9s22QSQjeN1BB12SdMw974OR5w8JDVbd+3b7wjv/rWn9HuYdqanPLaXO50vuACMpJUmz21r/7dSIj5glwmv4Qc6LBshKiFIxf72+BrQHH7RfuU0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:55:59.7372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f2435c-47d2-4943-bf18-08d7382832d0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4618
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130085
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

