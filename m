Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888F8BF04D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfIZKwr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:52:47 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18718 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbfIZKwr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:47 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqbYg018188;
        Thu, 26 Sep 2019 06:52:41 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2054.outbound.protection.outlook.com [104.47.40.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hkcq434-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnZTgvniy2TAyRo4p6Ffs4QNWURMQ78EYY283xmjr0+U2jTHmJX5jBh691W0FSilAddCJBwvXYDx68ssEHq+ZCL9Vd2mpyg8DOttLE5ibJUcyJdXHygwOWbG1ZgbwjvEAfO0hPgChJFcNx+JDPZPjQOfj3H9k/gL3IYhCMspmQh4QPMNW0mHOdvEzAwFSbhYy2Ztg8QQzbzfp+J0rxn28psIMJPJpnXPkb8rTIDcqRrNsRHpqGoC0itRzeKjpPLiVqre6qaIjkeO4AfqMblFT8o0205LHi6Dt4+dxLUtZpHPX1XWsrCyZwj1y4OvuDJISOT69AmcYR+ofMfIEXoxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w05f36Wri849xiCzTE3iZCvCsD7YL9/WVdiYhFde67U=;
 b=hqsikHl2pUjBMRGE4ScjjgC6OeyUVXg8SqeHJ/yzOMIAeUuR8LNkowL1PGjHQe0VokDp7t69nxHnVlZjGVIkM4a61uPLqd640i7/M7AOsWmSgpZJAyr6uQqEaiytnlpB5IpFmPZ0zBWTZhyo3qdjt6HZ46tHjXkdTcbM2VBSUaw5q0G9sWd5nrxomr/gE+D8GInz+U1pBp08ziNiq6OYY6na4e0f9zj4RMk1A3aWEYcaYAod8Ncs/LN0Y0SwCg55o1OR3S53iX3Ktb1/nc7n1vLfqaPrACy4nYuzPP66PVSdmOqBj5DFbbbseOhZBQhPrAJKKRfCBAOWtem9DrHbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w05f36Wri849xiCzTE3iZCvCsD7YL9/WVdiYhFde67U=;
 b=SFceQggewwmjjS+NFQPNar42HYkuNKq0ckzW+vOm71vdQWefv8t41Ey3soUDqXj6YIUNqWauMpvxZ303kIWNaeazfel+95FfmJQJmqtt+lsRNoMPI3dhmbNJ7FtGj4S4G/A6AFEwlsefY5vg5OvL1VMtyUdAa+t5WTRswD/AJ0w=
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by CH2PR03MB5176.namprd03.prod.outlook.com (2603:10b6:610:97::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Thu, 26 Sep
 2019 10:52:39 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqcBE014819
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:38 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:37 -0400
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
Subject: [PATCH v4 11/19] spi: tegra20-sflash: use to new `spi_transfer_delay_exec`
Date:   Thu, 26 Sep 2019 13:51:39 +0300
Message-ID: <20190926105147.7839-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(106002)(110136005)(54906003)(246002)(1076003)(8676002)(2870700001)(2906002)(356004)(316002)(4326008)(107886003)(7416002)(446003)(476003)(26005)(426003)(126002)(44832011)(478600001)(48376002)(86362001)(186003)(76176011)(336012)(50466002)(7696005)(36756003)(486006)(51416003)(305945005)(7636002)(2201001)(70206006)(8936002)(2616005)(11346002)(50226002)(47776003)(70586007)(5660300002)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5176;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d447ccc-1b0a-4503-925a-08d7426fa601
X-MS-TrafficTypeDiagnostic: CH2PR03MB5176:
X-Microsoft-Antispam-PRVS: <CH2PR03MB5176B1F133EA192D20A622C0F9860@CH2PR03MB5176.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/vWeW8jf3g2DylBRygCIbbuFONlhFA5jOhue7SIyFpZHZlTJqOCC5AiIvsCG4L4414W8ALLDkyMKlHIPjrPnX6o2TD/DqfGHRCGwvScegDQ08mXawM4AJfMlcg8Nauwx+PTewcJ1yibydyFwfO0ecVSJyDhWtCC9vOuG82dYo4YmFad/3W6B/dBjxFypOMe9f2yabYt8X2lj3kMsIPcm2ybJV+436YtO38HiENxUqDE0x2bMhDUUmzIZ81+CwNSzGUszXSHwTNdJPZ6T13fG6U7IouXmoEjd1O10ifJBoo4UopmAp/+TBRWoiuUd1Jm0dCeUed3Me+yMxdewq3EYlOS4GXEO0Bne3WiaglKVx+mXgdaDkqG4EFMnwgtC+ICcsi9bR5AcYGprYuN2id9lfOxfgbz13jN2IGFUrrXIeA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:38.8817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d447ccc-1b0a-4503-925a-08d7426fa601
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5176
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This conversion to the spi_transfer_delay_exec() helper is not
straightforward, as it seems that when a delay is present, the controller
issues a command, and then a delay is followed.

This change adds support for the new `delay` field which is of type
`spi_delay` and keeps backwards compatibility with the old `delay_usecs`
field.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-tegra20-sflash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index cd714a4f52c6..ff1933e55830 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -341,10 +341,11 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
-		if (xfer->cs_change && xfer->delay_usecs) {
+		if (xfer->cs_change &&
+		    (xfer->delay_usecs || xfer->delay.value)) {
 			tegra_sflash_writel(tsd, tsd->def_command_reg,
 					SPI_COMMAND);
-			udelay(xfer->delay_usecs);
+			spi_transfer_delay_exec(xfer);
 		}
 	}
 	ret = 0;
-- 
2.20.1

