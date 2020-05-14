Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF01D3F45
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgENUtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 16:49:41 -0400
Received: from mail-dm6nam11olkn2036.outbound.protection.outlook.com ([40.92.19.36]:51009
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgENUtk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 May 2020 16:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNrVWVYDnfkAfUiGkW4kT7MAH58GowoVUpRcQ8rSti3fgnPaBmPXlnvjvJPXDbtB26y1iKqy8CoUu0vvug0yWO1FaHA1c8TgNQV7h9Q0Uj5rMkt3Qxx3bN2nDVJqMs8d4UoPj7K+cCwtl7hg4+2ySbrcKp4ZiQQOaTMlK12wzcpOS9X4IUV/oLqXDPUUcHKtzareOFB9G7EYsQU+q09j2LLvL1PH/qxYkYeZkw1XrPAmJv7nuCN54jlic8wrnj1dYVfxbJoMD6Gpx4lwBeENTsm/eD/4mjJN1TSgQuDEoG41ul6SYTBb6TTMMv2pNJyz/JrJaJVs7fe1GWgraiOLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLXfwEjJh8MGAMcbEiQap2tlbnExuEi6e1wy4y7mRUE=;
 b=g8VPVckCs54nv5EVJ3pt1WvKuZdMa8snna1JShUCJh2A7lbmDS6GPIEI2+VxWbuCnmad2BAvcBlr8gDSuNex48r+xtxITWCYumB2N8SQnEuDyKauWDWKq/f1Nd2QvYS6vhT4V63L5kjI/YN0kb9RWybEA8gwViDSdr2dsKQnCl3GyR7aZ/7vUm5GwJ1ajeE1/Fa6KzivG1j0vIeNaFtAdcfl7DXpRgK6KUAnFGp40ix0PZw33PTGQLG8V3tTV4br9cPutwT1pLfveJf8GAByBUXurusnrkk+HTxKesDb4ilw9VIBp49rFeLJHnI3JntyP8YYiD8oqrSmrLtxcrQ9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::4e) by
 DM6NAM11HT250.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::227)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Thu, 14 May
 2020 20:49:38 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT024.mail.protection.outlook.com
 (2a01:111:e400:fc4d::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 20:49:38 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B91955B90F133AC969426355792BB32C1643662F4EC65DF2C9027C2F4EAFB0A6;UpperCasedChecksum:A02372C0B7D5EDF370E687DBAF6F5101144928A35B396FE563535BBE444C0406;SizeAsReceived:7917;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:49:38 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 1/7] iio: accel: bma180: Prepare for different reset values
Date:   Thu, 14 May 2020 13:48:55 -0700
Message-ID: <BN6PR04MB06606D8A597C031FC8A1AAE2A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514204901.3199-1-xc-racer2@live.ca>
References: <20200514204901.3199-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514204901.3199-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1701CA0009.namprd17.prod.outlook.com (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 20:49:36 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514204901.3199-2-xc-racer2@live.ca>
X-TMN:  [j0hnrinodcWUyjMVXxy3JkaqSHZlxk0uzD0HcfS0OVhF/q6fn4I5CV8E3onM4U4X]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 14db704b-2699-406e-514e-08d7f8485126
X-MS-TrafficTypeDiagnostic: DM6NAM11HT250:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6swGnZvLmwTWxEf1TA+vuEVGejRgx++PH/qlyFJDQ/5pye9Px08dJiFVYUoPSGn/iv8J0QzMyeB9xR//g4EN3mfnizzQuNxYd3AV0++/RGaqMM5pTzk+yfwtunH4TGUvSTzdxOrDCAaRYdBfYJBsRKZbxMDOkDcI7eNH2fx0CjsCnfWRDqro2tV9Vw0C2zisV8vsuEJl2CU70eK6Co44RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: xi+MrQoDzcs2Apb5hJQj/3rShqghMK/UWK1M4dqFNnzYZt90Bs4PyGQdaF1qHFb6t/qz2TnGq0QmpFjIWduvrPLqMhl1Md4Y+kJzBTZ6L6rWoFqvDGncBF+R91F9fJ1DSK7+IC9hWTkw35biygR34Gk/IHhYqTcwm+Chvah4IiBSAMV1uiCMdji9wagERFH3MR39ZOrcuAa/joTcMabxSw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14db704b-2699-406e-514e-08d7f8485126
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:49:38.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT250
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some variants of the bma180 (eg bma023) have different reset
values.  In preparation for adding support for them, factor
out the reset value into the chip specific data.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
Changes from v1
- Added R-b tag
---
 drivers/iio/accel/bma180.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index fcd91d5f05fd..75440dd83ec4 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -57,7 +57,7 @@ struct bma180_part_info {
 	u8 power_reg, power_mask, lowpower_val;
 	u8 int_enable_reg, int_enable_mask;
 	u8 int_map_reg, int_enable_dataready_int1_mask;
-	u8 softreset_reg;
+	u8 softreset_reg, softreset_val;
 
 	int (*chip_config)(struct bma180_data *data);
 	void (*chip_disable)(struct bma180_data *data);
@@ -319,7 +319,8 @@ static int bma180_set_pmode(struct bma180_data *data, bool mode)
 static int bma180_soft_reset(struct bma180_data *data)
 {
 	int ret = i2c_smbus_write_byte_data(data->client,
-		data->part_info->softreset_reg, BMA180_RESET_VAL);
+		data->part_info->softreset_reg,
+		data->part_info->softreset_val);
 
 	if (ret)
 		dev_err(&data->client->dev, "failed to reset the chip\n");
@@ -693,6 +694,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.int_enable_reg = BMA180_CTRL_REG3,
 		.int_enable_mask = BMA180_NEW_DATA_INT,
 		.softreset_reg = BMA180_RESET,
+		.softreset_val = BMA180_RESET_VAL,
 		.chip_config = bma180_chip_config,
 		.chip_disable = bma180_chip_disable,
 	},
@@ -721,6 +723,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.int_map_reg = BMA250_INT_MAP_REG,
 		.int_enable_dataready_int1_mask = BMA250_INT1_DATA_MASK,
 		.softreset_reg = BMA250_RESET_REG,
+		.softreset_val = BMA180_RESET_VAL,
 		.chip_config = bma25x_chip_config,
 		.chip_disable = bma25x_chip_disable,
 	},
@@ -749,6 +752,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.int_map_reg = BMA254_INT_MAP_REG,
 		.int_enable_dataready_int1_mask = BMA254_INT1_DATA_MASK,
 		.softreset_reg = BMA254_RESET_REG,
+		.softreset_val = BMA180_RESET_VAL,
 		.chip_config = bma25x_chip_config,
 		.chip_disable = bma25x_chip_disable,
 	},
-- 
2.20.1

