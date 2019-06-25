Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975C254FFE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfFYNNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 09:13:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62532 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730244AbfFYNNx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 09:13:53 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PDCrva013241;
        Tue, 25 Jun 2019 09:13:51 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9e63gwjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 09:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqxVOQ23b92vtwOQ62heMw/w/JYj9Xy86e2UrYaD1xo=;
 b=JuAfqcyjVcfnsGyw/NpBLUzYSHT5EE2peIykCyG+DMbS2Np4RqW7YximS2r1iDt9+WJd8cMoweVufcEVnfUTLtTsYBZPm7ZHdt/ByjLAJetZpmlHeIqeJ3i1k2FaQcQkdrVkeRpvb9zW2rSIimpIJ8zC7xy5X46OTioon4SYjSI=
Received: from DM6PR03CA0051.namprd03.prod.outlook.com (2603:10b6:5:100::28)
 by MWHSPR01MB320.namprd03.prod.outlook.com (2603:10b6:301:35::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 13:13:47 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by DM6PR03CA0051.outlook.office365.com
 (2603:10b6:5:100::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 13:13:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 13:13:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5PDDk0V008727
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 06:13:46 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 09:13:46 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/5] drivers: spi: core: Add optional stall delay between cs_change transfers
Date:   Tue, 25 Jun 2019 16:13:25 +0300
Message-ID: <20190625131328.11883-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625131328.11883-1-alexandru.ardelean@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(2980300002)(199004)(189003)(51416003)(2201001)(186003)(76176011)(106002)(7696005)(54906003)(450100002)(336012)(14444005)(86362001)(48376002)(50466002)(305945005)(110136005)(5660300002)(77096007)(26005)(446003)(36756003)(8676002)(11346002)(356004)(316002)(476003)(4326008)(426003)(478600001)(2616005)(2906002)(1076003)(8936002)(6666004)(47776003)(70206006)(70586007)(2870700001)(107886003)(44832011)(50226002)(246002)(7636002)(486006)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHSPR01MB320;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda07d7b-608c-4e16-8fd1-08d6f96ef514
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHSPR01MB320;
X-MS-TrafficTypeDiagnostic: MWHSPR01MB320:
X-Microsoft-Antispam-PRVS: <MWHSPR01MB320A35D1E4FA67BBE456674F9E30@MWHSPR01MB320.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LoFhiDjHDvGq+SyedsBj2y8L31/AhOQb/tpFHmXDpjzmQ0dHDOayT0wSEftzR+FmCHyYaIf4RNZ4UrtV8tHangmfVsY3eIO+NutdQ1RkWmFI/z7Xy9zAlthuhApEo7KjuW+4gYSRkOmY5p57cDu52nwvNDJqazuAzDTJrYcDb1dmSMhagmgcVVLTZKpzhbTvOILMU3W2MXA7kSZ6DWlP+Bf6pc79FYeYdz6nfQBWxCz46zYDHYy4x213PfsnrdXbeO4LzdUnXY5j8P3+gIZ8rrh+Ol2rLtYiTgAMjgH2CfADLb0ZhCU2ZBS4jyOdYKxSgm7PTU7R6NwWN0kZV8lDtE2F1SLNFwKQDVyO1jovrmwPyrY/jL5dT5BYQ1IE4AwJARzS2nQ122Y+CC1SUYSEMGPNylvXEiJnGTcEE1EmQY4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 13:13:47.0125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda07d7b-608c-4e16-8fd1-08d6f96ef514
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB320
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices like the ADIS16460 IMU require a stall period between
transfers, i.e. between when the CS is de-asserted and re-asserted. The
default value of 10us is not enough. This change makes the delay
configurable for when the next CS change goes active.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..739de0118ee1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1163,7 +1163,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+				udelay(xfer->cs_change_stall_delay_us ?
+				       xfer->cs_change_stall_delay_us : 10);
 				spi_set_cs(msg->spi, true);
 			}
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..d23add3b4790 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -734,6 +734,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *      transfer. If 0 the default (from @spi_device) is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
+ * @cs_change_stall_delay_us: microseconds to delay between cs_change
+ * 	transfers.
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
@@ -823,6 +825,7 @@ struct spi_transfer {
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
 	u8		word_delay_usecs;
+	u8		cs_change_stall_delay_us;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.20.1

