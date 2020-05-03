Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525061C2E4D
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgECRWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:22:35 -0400
Received: from mail-bn8nam11olkn2103.outbound.protection.outlook.com ([40.92.20.103]:15713
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728859AbgECRWe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:22:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaTVBbCQCZQ/UluBFD3tUoiqWT0FIOlWVGeaZtkiG2KC8ZRC4GevY0RjZzW1wgKwVjhPTi8yUoFv11Q1hZmQM1FQWe1KIU59xDVhEZTG5ao4iuEWvQRMxvDrsoBI8qP6KuC+TYiLo6d3hvXZ3EoP7gr317kz9EOAOGObpOV+6Dtc/N8amj53sWaKtova5sWHtWT9dM3IIksGR3nXpYtiSeKvbpYv683wGk2L+fuvwKAyKur4Xy/eZ80NldoG8hEIS4+6mQJ7BpWD2FLJBrXlPfI/++8lzj0uG26gsGshpXDuWVYaHw31eaU1JB1lj62vfE32sgd5zSyWPdh8eRE5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zg7hWnyZ3sczViwoZ3XmKapDRxnqFPiiZZBMPIGPP8=;
 b=V+tE/CLNMEaGL34EFYT4ihot5oymeNHQ061K5xzczWkYfp4CLaXxroV6gFalcc6HuPDR75Bzhjkqmtlzz8uvgyEWOG0nFtLbqIzo3+MfVcctF6ZNdu6f4L9fqPyRsjIPWAfKLTo5b58beFLOQgs7AL6a92Dg1wyKhjmiFPxo/Xn8S2Rv1+WoRFJq+0Sru4UFEQYbFYuiQeeVBms22JgZNxQJsKp3g5mwBGLCgu+YD+eGUkpvJpR3EH7HP0KOVZ5YZRHa2eh9NvxTPRE4Q/pyNRlN28SUG9ECBvdF2X737L2a6pbZNRL112P8rB9o+q3ftc2Qv7msd/w9g23fgLFZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::4b) by
 BN8NAM11HT242.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::156)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sun, 3 May
 2020 17:22:31 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::42) by BN8NAM11FT054.mail.protection.outlook.com
 (2a01:111:e400:fc4b::358) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sun, 3 May 2020 17:22:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:52407124F5FB3A0DE75FD3A7822DCF576D9602F7250260A99C5F6BB28F704DEF;UpperCasedChecksum:BA5470450F066D5C6274061998A62520D44BCB43776413EBA7DCF79654863469;SizeAsReceived:8013;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Sun, 3 May 2020
 17:22:31 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-input@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 1/5] iio: accel: bma180: Prepare for different reset values
Date:   Sun,  3 May 2020 10:22:02 -0700
Message-ID: <BN6PR04MB0660ABCDFF774833264D39A6A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200503172206.13782-1-xc-racer2@live.ca>
References: <20200503172206.13782-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200503172206.13782-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0047.namprd14.prod.outlook.com (2603:10b6:300:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Sun, 3 May 2020 17:22:29 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200503172206.13782-2-xc-racer2@live.ca>
X-TMN:  [yYJxKkMlbnAAcPdvhqIh1O/8lKc7kvoWdLPS5yFM6GdNLtVXxwduIbIm2UetqEe+]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: b7b704f2-e107-49fb-42da-08d7ef868fac
X-MS-TrafficTypeDiagnostic: BN8NAM11HT242:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2S3PfxwJVD3CT+FG4+Y8TDTo6iPCXP9uLmFz7d7c/qpbW8eGlygSrl5Ep825ryAwvvnDe76VIdfNGqlAprq8U8ZuM5oAIdlMaUTs0Yv3mHAx7euOXFSBaFx1NzFUy3VwNet8oCYF6p4WpJoHoDFdfau62ZMKCwEQzBj3evd4Kg+du0W1EXIgZWUObvY7N52t/pCZ/s1/mr5qvoDj/vwpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: PgtAowJkEQiKcs61bpo+Pgzu+IfvCUd0TVQhQqzTpVJdN6XR6PTiK7Jlyv7gc///9hBxAK0r4/C550sGdSg6TkQhPJjFOua8agIZlADJDk07CT+X67xq/E6cFZREI08DLPtEt7idkh9KB7XvLjh/AKKsJG1bWESNlni/5gxumg6/avqPexSwXDrr+bdjFwLmn/PHB+/W3vXoDlAx4NNH2A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b704f2-e107-49fb-42da-08d7ef868fac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2020 17:22:31.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT242
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some variants of the bma180 (eg bma023) have different reset
values.  In preparation for adding support for them, factor
out the reset value into the chip specific data.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
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

