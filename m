Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A98E1D3F3C
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 22:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgENUtu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 16:49:50 -0400
Received: from mail-co1nam11olkn2010.outbound.protection.outlook.com ([40.92.18.10]:19105
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728190AbgENUtt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 May 2020 16:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBxSVm4gaXnl0czx48Tv/e1Ky3a7a1gDxpMSPhr2DVM+gwqIL+9S27xbaP6kUDnGp5KKp6vIcXYlhBlRes75zciDn7M5ugszXpol2QeDFRO89Nni4Kt/Vqa3Cna/y2Zy8aP4SrJAyWBezYox/bKivTnXvmCNsARZgaZG/lKdCwA8cinJEFESO1lyGkDhz8P3Q0WJAwrri4N8+Z4L6HqE7+JJrTe4amiELczKn3A9oSKEDj16mfPF6mlB30LDaiTLcZFTq30YIrrPnY4MctsSWsqd/DEozJDwNFXZQWUF5DupUdo+UHPVEBvxDhmto8BO/eexYdPXCgd8LwOVAPOxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7JgeEF2TaH/6k7kyijCKJhoo4dka1HfSqyBgHiI6KI=;
 b=NXzgFrM+3CFj8TFwzUUjlDzpNV2vj27igYJjwMmIR0q8jVGFj4tiIBUgQqvpzmjV2XLupT3FcV5AmXax9O75uOrwUI7VsdtLniirxFiPVuOL5Pr7QtFm+kgfhUavZjkjpv7ZEFDWnA7I9lx45VOLWekW3WkU6IMbJqHRBfc5ghlVUuZ+3IxpGcP85fzkJfrmr7OPKXi3rhAJddOf315qzGZ7ChvrsUAUCjusIQoIJKUWdEJc1Nn36vml4J0OqcYp1fqwXp2g3Hg8GEnk9A12TQ08UTMDZNXeglYKcEU5Otr7LSj84mCAv05Im8qq/NN0rPAN1gOzPDY4mGItqwYt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::40) by
 DM6NAM11HT064.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::306)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Thu, 14 May
 2020 20:49:48 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT024.mail.protection.outlook.com
 (2a01:111:e400:fc4d::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 20:49:48 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9F951078177A2491ABC5874BCBEE8D2355BFA6B9DBB806DD9B8E838ADD5CF2BF;UpperCasedChecksum:06DCA2CD2D75EF62A742B426E0D9CCDB6F31FFC36DFA9B14FB0A6CAE9DE38C75;SizeAsReceived:7916;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:49:47 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 6/7] iio: accel: bma180: Rename center_temp to temp_offset
Date:   Thu, 14 May 2020 13:49:00 -0700
Message-ID: <BN6PR04MB06603F08B010828F7CBFB610A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514204901.3199-1-xc-racer2@live.ca>
References: <20200514204901.3199-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514204901.3199-7-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1701CA0009.namprd17.prod.outlook.com (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 20:49:46 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514204901.3199-7-xc-racer2@live.ca>
X-TMN:  [A6eiZlCL3MtHRfvI5xl/b9AQ8gteEcsk+5uo5NyEx+rqDA1B/SvdCa+6kXJFTGXZ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 73988799-defb-41d9-d907-08d7f84856dc
X-MS-TrafficTypeDiagnostic: DM6NAM11HT064:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P46JhXodGyJT6Q7dR08yUb7wR/BSrHS4dvxiSrjgsvhkurPW1O7FPYbb3pT7HhUAqx539PhXQUYGgadHklKkqSv6649Qh3WHiDKGlJSOnrYQI4a3m2DY+MJkEtCAlKNHHBfCEgPiMOn6/Jy4yRvGH++mu+D1wTPTPi248WbS9QRKvNBD8e2SFAgvBQESAOrY8g0VKPe2S24sWlQG72cBCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: vVF3nWvMVJK1wVgHs0XrudcN3jnK6wECJbT6VstgxAfvVeeACp7DFHTMQ0WkOuTPpKXQ5vJ6wiRskOcpitxFgACbbB880By7A1qfcr7NevEMo+0qmwyPqQJknMHMGEuhO+dxNKzJL7JUe8CjhSoLdxpRhsYbu6Hb3kohCi5ah4I8vj3lpMFOTqCblj3NAJf7rWY/zP4dcEo8wCgqo2PuEw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73988799-defb-41d9-d907-08d7f84856dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:49:47.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma180 driver is being extended to support the bma150.
Its temperature channel is unsigned so the center_temp naming
no longer makes.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/iio/accel/bma180.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 19d4f174a890..23da0a79b0c4 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -50,7 +50,7 @@ struct bma180_part_info {
 	unsigned int num_scales;
 	const int *bw_table;
 	unsigned int num_bw;
-	int center_temp;
+	int temp_offset;
 
 	u8 int_reset_reg, int_reset_mask;
 	u8 sleep_reg, sleep_mask;
@@ -584,7 +584,7 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OFFSET:
-		*val = data->part_info->center_temp;
+		*val = data->part_info->temp_offset;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -761,7 +761,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.bw_table = bma023_bw_table,
 		.num_bw = ARRAY_SIZE(bma023_bw_table),
 		/* No temperature channel */
-		.center_temp = 0,
+		.temp_offset = 0,
 		.int_reset_reg = BMA023_CTRL_REG0,
 		.int_reset_mask = BMA023_INT_RESET_MASK,
 		.sleep_reg = BMA023_CTRL_REG0,
@@ -789,7 +789,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.num_scales = ARRAY_SIZE(bma180_scale_table),
 		.bw_table = bma180_bw_table,
 		.num_bw = ARRAY_SIZE(bma180_bw_table),
-		.center_temp = 48, /* 0 LSB @ 24 degree C */
+		.temp_offset = 48, /* 0 LSB @ 24 degree C */
 		.int_reset_reg = BMA180_CTRL_REG0,
 		.int_reset_mask = BMA180_RESET_INT,
 		.sleep_reg = BMA180_CTRL_REG0,
@@ -816,7 +816,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.num_scales = ARRAY_SIZE(bma25x_scale_table),
 		.bw_table = bma25x_bw_table,
 		.num_bw = ARRAY_SIZE(bma25x_bw_table),
-		.center_temp = 48, /* 0 LSB @ 24 degree C */
+		.temp_offset = 48, /* 0 LSB @ 24 degree C */
 		.int_reset_reg = BMA250_INT_RESET_REG,
 		.int_reset_mask = BMA250_INT_RESET_MASK,
 		.sleep_reg = BMA250_POWER_REG,
@@ -845,7 +845,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.num_scales = ARRAY_SIZE(bma25x_scale_table),
 		.bw_table = bma25x_bw_table,
 		.num_bw = ARRAY_SIZE(bma25x_bw_table),
-		.center_temp = 46, /* 0 LSB @ 23 degree C */
+		.temp_offset = 46, /* 0 LSB @ 23 degree C */
 		.int_reset_reg = BMA254_INT_RESET_REG,
 		.int_reset_mask = BMA254_INT_RESET_MASK,
 		.sleep_reg = BMA254_POWER_REG,
-- 
2.20.1

