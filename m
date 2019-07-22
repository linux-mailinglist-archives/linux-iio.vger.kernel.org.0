Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0270007
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfGVMsH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 08:48:07 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:40914 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729035AbfGVMsG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 08:48:06 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MCSXtX008866;
        Mon, 22 Jul 2019 08:48:00 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tuvq9pcaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 08:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1XaSc4SQ2NbwPxs9E1V4cBQv5OWxvhtaKBtKg8/Oipr3KpVdFBuoZkFT3ya3LUwwCb6bkeJDhD8aKv/qCUjjfWHH9iIE/p00GSLtPsjlMSbkTo9JrmbdpGxjGjC5LeumARIt/VDE09sM0c6yE425r2IRdppsC9Xh3rTAIwr6wEqpgo13e1LCn27ag00JAQGYdWw5Jr2tmlSMURld9oSMxlTjImwN/V2P3UFHrnxSkfvyRI8n5dqzgEt2Dp2imlzJeoBD3In3BkuDWMptWHca+A3S0YQkLn0d04DLMiuPhPrie3gk0kAHkSfzESYTtaHNxJTHcRNOEQTBp0zSag0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT6/+8tkwoia95OYXO3SRFvgRTSiVRK0RRC9AXVPthI=;
 b=AO5QcqKk4Sjmop7YjUhQY153QjZhbTeTv3ERTBotPfd+cZzEeFN0Zm+gPbSGomi+9SD/IyAtnz+M1ZnpJu2pzVJVaoi9Eb+PfVX1L1ZuZwt6XGCiIlSMdfEl9egtA9g59JPxh9rRoipx3q0PoSUaySMRt9L9HSGR87GCqhi7z6hZlElrwJcyUaITdhwC0I6gZBKSqkPz3qXoYjvsqEtxIcwASw0An6o5gjWInyz4xARpEX7OFSodJ8Xv88SIjAYPX58gcgBiZ/hfbqYuJfy3Z6UBUcCSuM2NK0r1AXb2XDECDnx+pwlYnGBY1n7IW+5agQNhvV12PXbU4Uf2bQ+uAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT6/+8tkwoia95OYXO3SRFvgRTSiVRK0RRC9AXVPthI=;
 b=AjoZQNiVzmOsvuS3OTlnWiM8GwrYrDVAj4mmUDmOFqLapauA4PkT0Rph41APOe1x1kE/EhfkvXf8wawMiNUl3CLSh15uFhvlkwc28C4st0TIynWukPjMqv3TaAdLfqiPABtCZVHG9bULLyfckWBcEuu0qtVWj86hqbQLZQpZBuc=
Received: from BN3PR03CA0089.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::49) by DM6PR03MB3833.namprd03.prod.outlook.com
 (2603:10b6:5:4f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Mon, 22 Jul
 2019 12:47:58 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN3PR03CA0089.outlook.office365.com
 (2a01:111:e400:7a4d::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12 via Frontend
 Transport; Mon, 22 Jul 2019 12:47:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Mon, 22 Jul 2019 12:47:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6MCltmL019628
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Jul 2019 05:47:55 -0700
Received: from saturn.ad.analog.com (10.48.65.145) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 22 Jul 2019 08:47:56 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/4][V3] spi: Add optional stall delay between cs_change transfers
Date:   Mon, 22 Jul 2019 15:47:44 +0300
Message-ID: <20190722124747.4792-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722124747.4792-1-alexandru.ardelean@analog.com>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(54906003)(106002)(44832011)(110136005)(50466002)(486006)(6666004)(8676002)(50226002)(356004)(47776003)(426003)(316002)(246002)(2616005)(48376002)(7636002)(14444005)(305945005)(446003)(11346002)(1076003)(86362001)(476003)(126002)(336012)(4326008)(478600001)(186003)(2201001)(36756003)(107886003)(70206006)(2870700001)(70586007)(8936002)(51416003)(7696005)(2906002)(76176011)(26005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3833;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4398ba22-3a87-4695-f471-08d70ea2d2c9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR03MB3833;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3833:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3833725B6D2168285CC4CE3EF9C40@DM6PR03MB3833.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01068D0A20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: X9BMwlQ48z3GwMZitx90l7CpVQNlObYSsirRWXviFuuo8z2iTLV4gtjqtlsXzuIzh82sjTfk2e9el2e6IPseCLxACLYxsPmRR/+ES5ymKevujab31kCvRrG75R7HtJuy6P4QDN1089OmYKzzeXxLDDa6Hztd0XLqgWP/Rm2qali/5ZghJ3OCmo80f6cgODdHihW7GM53MNlSCd3YjNYe2Fp7j7jt4Xn2iC2hwwnPsgmat8WnTAyKpzPzWzLph9SFT9IxfVk1hdYKFBj0yq0BqKplNVYRADZAbygRnkTh41QyoWtjvELOdXU/dIQzZdZFO4/YktGFKz34z10Ql/LTkmaGgvXq4lFlQrfEK+uStGxvuUfEsVgzS7a0ND4TIko7y36/BU9mXSuNP91or4rnoTHcZgHYcuwgsxKstv5Z1GM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2019 12:47:57.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4398ba22-3a87-4695-f471-08d70ea2d2c9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220147
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices like the ADIS16460 IMU require a longer period between
transfers, i.e. between when the CS is de-asserted and re-asserted. The
default value of 10us is not enough. This change makes the delay
configurable for when the next CS change goes active, allowing the default
to remain 10us is case it is unspecified.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..fe7fa7fb25c5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1163,7 +1163,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+				udelay(xfer->cs_change_delay ?
+				       xfer->cs_change_delay : 10);
 				spi_set_cs(msg->spi, true);
 			}
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..6de287f8e465 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -734,6 +734,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *      transfer. If 0 the default (from @spi_device) is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
+ * @cs_change_delay: microseconds to delay between cs_change transfers.
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
@@ -823,6 +824,7 @@ struct spi_transfer {
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
 	u8		word_delay_usecs;
+	u8		cs_change_delay;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.20.1

