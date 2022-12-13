Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097F964BAC4
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 18:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiLMRQQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 12:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiLMRQP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 12:16:15 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEFDB848;
        Tue, 13 Dec 2022 09:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+1dMSgSh8gBQntk9Hwy9W0OhDNRdEGM6mG2VChD0Grm+tfq/fXUMqkKjMxilR2dgHYoMjxnMTEKXaBKEdY+jgA5tZG/1tueBpd5/2cmbun0uPiz3y1gP5oBOtoCA1criRT9ficDGI28f1Mz4tAABt7YTVyoZpBVzs4Iuy8mafalQF9VysgvJIZM18I8+mEEXM1LmLekumyehEdisXIWOtw+oKi/yfpOFDAGgPgjXpPV1OlrC/pDWC2hP1FBZLk6Ngp6lru03RSt83wUXUrgLYbOfxHk5m5P2ybBSub11w/2JEgZQXJN2aeWPqRcihqb0OmDQCa7kjPHSo2AX2sH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjul39VvoCWsgUG/dfTWd7kRVigawZP/golmyPbOfXg=;
 b=QkuUK1yXzLtzdeLugZyqZMhyae1DVjGMw2bchVWCJIfVIYzXs2Uf5saoPrRYLTPXgETEHvPpPlDXPq+2tWuWc8NoLM2Hw0MoSsSIMLfRbhl3rUZluWZDM1ryxge3CYRnOuYhnHS3G8l+CE9cj42omDavAbdfGa1BheFMU54+S+DjpYU/Ms94dGkbLFxfpwd7RPor0PuZAZ8alrhHH1dk9AjBCkIzFzX3uzfgi3hW7jz+Z0UkfFB3tFC37ozm0zQSUNh6YmP6v1S6m96hAbJ9ZJqigzXpHmictGEsmuvOv99CYZUQk0OC8zjgkwFOHixVasBAx1wAjPl2q+cgGj+l7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjul39VvoCWsgUG/dfTWd7kRVigawZP/golmyPbOfXg=;
 b=jbIl1BBZ5/bkBkdqsi2khSCLIPq8WsYShwMehsrhCrJGrWzCF96rrmgRx3Foe5/eNIolcLpXRkE2Y+mpCT/Bav7IqhfxrjJ8+gmIPICOZvZ9Vy3SHKB0nSN3oWnQV9BKjmluU4uLEoZex24bJmAYYOM31yXGQ6/NP8dNvEeLTZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:16:11 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:16:11 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Han Xu <han.xu@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v3 2/4] iio: accel: add the new entry in driver for fxls8967af
Date:   Tue, 13 Dec 2022 11:15:33 -0600
Message-Id: <20221213171536.1880089-3-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213171536.1880089-1-han.xu@nxp.com>
References: <20221213171536.1880089-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 374dee2d-e821-4807-0e92-08dadd2dbb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXwEI5IIf/jq6KjTOSqf0nxImcAfR+mUfaUMz3XsOHjvkix4bvn1D/py7WnZW/m22EbwdzKZ5M2jtDUG7DksUFj5NR+jvo+5qEDj/JPq/eIdlodvCk2PhB9fZoFuybXcu2vwZEcwAPXkEL+/7FTis1u2duuPQSzVmZW9kANJ4Jch0NMLz+CTuhFDD+C8vnFbyk3FO/37CThQAO4AUqHnK68wJ+EkoRofkTEsFqyR+lHgATx2rOCwOtXOAM6HKbL6YtBzV4mFU13nj/58TmhVZa+yqbpYbQmh3pAzvBwyK0AVVKzitSK509HbVHa2BNK3HIjJb8YB/BfhpNPfGH3OpIwMkqXgA5Rxb5T1ygw05Oh+y/gyz/H0Wwi/WfjrBV1N6PASC6o8pcOXnkuhiRPIGXggpTaadRZYJisfxmFIf/fRCgX7VhAZAonmjmSxPGs/KZFRU1iXlIID6Wqk2VGFoWhJZLEUuv3UtHCGVdwi1BWXa2NXBI17IHICccrdS2V7YiVh8tzlsmQI1bLr+BaifKV/4r69DViE5srFHg06OwIb6va/HK0sezLzOE3VsjtBwVettEcXwwjZSmnqbLNu4JmRJEfQAdUgaRargs0TWpTIbNsLgacud7In5OTh6yeAxJ6Y9omKwNdQQdzRYLkltFJEs+vlpKPb5wTmuh5OVClrCm3h3c555w8daeAw8e1EwkLq8XiRgx4vz1sj6BwF2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36756003)(6486002)(110136005)(316002)(478600001)(86362001)(38350700002)(38100700002)(54906003)(6512007)(1076003)(52116002)(186003)(6506007)(6666004)(2616005)(26005)(66556008)(44832011)(41300700001)(66476007)(5660300002)(66946007)(8936002)(7416002)(2906002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JbxI2RIP//arNy1IFgCT8KyOd7NSvSwPi444X/1EDB8oG2/HduUd04f52X/2?=
 =?us-ascii?Q?Enykc2wR19pAv+mRaLXuDVmEf3vKZK/olsQI/+VlZyvBFOMgEyp9fZm1UHnc?=
 =?us-ascii?Q?LJsZIT6Lturd128mB+a2ZrlPYvnSDNWXiHBnBWX0jnYhbgDo4QPFsuYKcKtD?=
 =?us-ascii?Q?L6NiDs2uA5iUwG12qPXDnPDn+mvcddhAaq40aoDJiQPi0F6PpZbxBv+Jtxt0?=
 =?us-ascii?Q?/VcJWYGalPLhEGk7GrJd35hKROqboSj1x+IKkTfFcXaRQseHle+z7XtyDuA/?=
 =?us-ascii?Q?YDvrWPXKOC8OveDJ4t6QDnByAwjG1TDxkStsA7wjptYOrc/Ztmncdec4S9xA?=
 =?us-ascii?Q?4Zq9EBUEamPGXlAMOB80WR8nkSvkb/W6/IlrGwDGQSmIuuGmdWZcLz6rHMXZ?=
 =?us-ascii?Q?MGsLTOXC1Q2ojbh8BcSFiJc+VHfIG4JN2PyXYf+nuZe2CHRfBAJVRvJfovHz?=
 =?us-ascii?Q?Xj2p67rTSK0bSJ0wLFt0B4K1uWgHek6sa5aY/MDWf5UhEhjaPi0CNNW1+tC4?=
 =?us-ascii?Q?N7mZVxL9X9gTtBhR6b3CR56uPb+g7cswc+ERclHXl2ROxiCdWkSrXBEdtdQB?=
 =?us-ascii?Q?Esa9NSWEd614z9GBnhOGBSK3t8aJz7MGKWzE6OGRozzoyJnkyKPa8kx5RcxG?=
 =?us-ascii?Q?0cl1mbZ/x/6b5iBxzPLt6zait0RxcoEEWcQrgNHnTQFN+FQdREnk+WykTDNc?=
 =?us-ascii?Q?es/oHQ/LCB3AFyTRhIkdmsomaa+Pv4gppyAKvemPit5rn5oBq74womR3mAd4?=
 =?us-ascii?Q?p7zdvj8KgvyxgImYHpHfd5edNGloLy8uEtjIfuEIDdoMWLCPL9O/scgvampX?=
 =?us-ascii?Q?gMZE/oLug/fIkpm3ErA+EwBLfI5u/P4PnIpZt+NP6N5WmBxkef1LaUMRgL7I?=
 =?us-ascii?Q?5ycPxzvsNQ+7GtG0bB2SWtgWJetoWLxa6qrWOroj45FBwwBhgME9WAqKUzKt?=
 =?us-ascii?Q?vxqsvKHuepRpHVgPaeDyJr4OSc8NotgnHpQGMoJF9CZEy/s2LFyx3ItE01oh?=
 =?us-ascii?Q?wQKMhIAtBjkKoP7qnx7CXgKYF9fzdzAF3DkDmEn1hrg4N/RbUvuJXePKzBg+?=
 =?us-ascii?Q?E1W7mYf0w9MrAEeEZEijguolF65kMAojpkYjXyAIM22j6FSIBZgOZUsi4IFv?=
 =?us-ascii?Q?sJvou57jO4cmrnPqfoJmsD5XFsliGfVZtI8hwVySpW0Vv3xzppHg/TXDBgtO?=
 =?us-ascii?Q?4Za++ictFGL2X6GEJhHD83o3wzcQkLDkGucfC3LagV0oOI63+gv/VFLkNoIM?=
 =?us-ascii?Q?MEFjSX/Xvz3F9O9S5X9N9xxVyAZlYb0htVQ8OEwUc1InzgVhGb31hy4QCOoM?=
 =?us-ascii?Q?9/Ksc+sO3U1RH6CG7YNBAZEoyUqrSQy7i6O9GWLiEmtrTqAt1VOg9ysiehUv?=
 =?us-ascii?Q?CEEdIVpc3NktXU0gIJMb+4dGNmbNCNhHyHBw++bakPhLD1jOg4uhD8vwqQ3v?=
 =?us-ascii?Q?lYnUAQguDVmA9NNlLDcH7tBSAfOfId3YqMKgyNGLCjFB78J+CybGr4t/6w2V?=
 =?us-ascii?Q?Q8DEjMSagppUHG8Sj/HrbzDBfCPfcumvhCAp0JnCZ36DA19Z11bhof3rTjs2?=
 =?us-ascii?Q?6Zl6xNokOA5+Shzcovc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374dee2d-e821-4807-0e92-08dadd2dbb71
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:16:11.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pBMRr2aQLaD85jMcd81jzxK6mkev6bw5ICs4HZbDdyv8IcVVaLbxMOnPUjuxGFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add this new device entry in the driver id table.

Signed-off-by: Han Xu <han.xu@nxp.com>

---
changes in v2
- change chip info orders
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 98811e4e16bb..c3589c3084ee 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -127,6 +127,7 @@
 #define FXLS8962AF_DEVICE_ID			0x62
 #define FXLS8964AF_DEVICE_ID			0x84
 #define FXLS8974CF_DEVICE_ID			0x86
+#define FXLS8967AF_DEVICE_ID			0x87
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
@@ -765,6 +766,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
 		.channels = fxls8962af_channels,
 		.num_channels = ARRAY_SIZE(fxls8962af_channels),
 	},
+	[fxls8967af] = {
+		.chip_id = FXLS8967AF_DEVICE_ID,
+		.name = "fxls8967af",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
 	[fxls8974cf] = {
 		.chip_id = FXLS8974CF_DEVICE_ID,
 		.name = "fxls8974cf",
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 17dd56756ff9..a8944b255a28 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
 static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
+	{ "fxls8967af", fxls8967af },
 	{ "fxls8974cf", fxls8974cf },
 	{}
 };
@@ -38,6 +39,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
 static const struct of_device_id fxls8962af_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
+	{ .compatible = "nxp,fxls8967af" },
 	{ .compatible = "nxp,fxls8974cf" },
 	{}
 };
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 45c7e57412e0..ba33eb2b807d 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -11,6 +11,7 @@ struct device;
 enum {
 	fxls8962af,
 	fxls8964af,
+	fxls8967af,
 	fxls8974cf,
 };
 
-- 
2.25.1

