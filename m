Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E1436152
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhJUMVK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 08:21:10 -0400
Received: from mail-eopbgr1320131.outbound.protection.outlook.com ([40.107.132.131]:21091
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231503AbhJUMVG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 08:21:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PibFH96BpkHsLXtC5jSmukuefQiFdaN84pVHYjbDwnhpEUFGLJMXObw4e7qDrkXUQcVhI8f8nMdVX0TW6cquscETBGJFVGdsDm1534X091bnydUOXXcfyrKGJU/TbQMknxrQVc4OJvVHBz5/ogrf9nKZjNobrA91te0SmUt32PDwt86+S2DEF84yS1YojUXkr175qUQU4YOqNZJcIaRbUtUlpdBIYBte9VKTt//xQM+ElreQnZ4/8f5k5HOYVPw25uaxec7iIaXtjKRdiS1I+1wRMK2C8otjY3DwC3Kjs7XfVepxTOl3p4VsY6nz3+LeKHUNxPsQFfviOPS0iYRTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg1DKBKbx6Dp6ZpamFMafV2FR4uocIao9rF73lqP7n4=;
 b=Bu23FDKObkM8JLp2TcwUC3YKZsB55uyMdMS/t+kDmmpoh2rl+X4PAOeXY1dYiRJqNlJnQOaz5VEUMOptAmM04QngX6+zL+OKq0Acld0nu8IsI6bOG16cYkPijR6P0vtnea2NqV2W0AhrxP8m0CAVLFzcTUJ+er4Oze3ez+GL5Oao8OLpkkiYaDqtPGk/HjICmIXXqeNilzJqzdc6HnCl4eubTHfShWPvwj++6WOKD55VChonWLvqGUTjhLOQRpRXseF6n5Cw0lbo86fJ23JR10erTgWXsLWkNtPaiX4NfZQvn85JSBafobnd3ftEWZoBOQruEdfFh70zrpA3CjatIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg1DKBKbx6Dp6ZpamFMafV2FR4uocIao9rF73lqP7n4=;
 b=ov21w0Q/lFxiFGV/iUx2q3eWchMMh9mWvFOEH6CDzv8Ek2We2b4ua2Ve2tdeDk8q9ViIeAj/4SZy+UKVPrA0NvzbtpmJ9Ji4ZUO5yNEN+Sedd6iAv22g3xOXog3NM8L9BIB2KwrgT7ExCMKtuDPxuWFm/2BC3KWBlmvWjZ+Tg3c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3727.apcprd06.prod.outlook.com (2603:1096:4:d9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Thu, 21 Oct 2021 12:18:43 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 12:18:42 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH v2] iio: adc: stm32-adc: Fix of_node_put() issue in stm32-adc
Date:   Thu, 21 Oct 2021 08:18:23 -0400
Message-Id: <20211021121826.6339-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK2PR02CA0191.apcprd02.prod.outlook.com (2603:1096:201:21::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 12:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f69f6b86-b303-4a05-6543-08d9948cebec
X-MS-TrafficTypeDiagnostic: SG2PR06MB3727:
X-Microsoft-Antispam-PRVS: <SG2PR06MB3727760402A1A46D2A845EC3ABBF9@SG2PR06MB3727.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XUnmcxkwa15Nga4HHOttigCQjd+GPjg/GtPWwx+o5CP368DS+Rz1aILn9lOJcnZVLwCcv4S7XFEqnPKK3gE8ghLllb3HS3BsTQMYw5r5wpKRtRBaD3V+rAqiJ3WP8RAhbn1jfil/IvG7d6N58qf68rJzNkDxWXtpDxPQdzldRdWISWe1WM91d01naukz4H4PQxfjmnRsA6gJt/vl+c5wyD2wi2xkwHQ37Y8BXlVpi90qsSltdo8kFvTzr948QAaAicvtbJ/ODdrKbwHb7yi/WBRnxmkcTHhdh26II6RxoRkd37vN1YubdlMeM0lvOCbUVmsAJdvUwpBTDNsocqtxczxNFtXiMzeZNX2v9gwDza+IHpM64lbnW7b58I6vGoIqasFxKDd9FFMqaXail+EI6jyT/dccELSo1Y9hgaq9cRH254u0OeGAjdNwzee3dFxwkjWwIP3CAjlt8UIjr61pw5tC3RRYjq2/hbdVitfJk02WJLAddjc+MpjpPuIZN1thbBvwR/Rq/pLVKuTVZCYRiSOa7qyyaj3p4iU8zGtXdQ4IUBiiy0xyvb2/fKoCIfZ6JD+qirR9nwPrDcp+zNhZJR5YFY5ytSbpA2w+91UyWIUeB1ZhzaaSmeBhi7xgg3w91iJTXct6kaytKswETXLFs8mkqHTMaS74HmEcUfqtB19BdF5dL2TSIjCdu9HaUTrg/HF5RmmC+n1Tnvz7hnVgJst8OggJMEWkioEqRICg/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(110136005)(2906002)(36756003)(316002)(26005)(2616005)(186003)(66946007)(66476007)(6486002)(66556008)(83380400001)(52116002)(956004)(508600001)(38350700002)(38100700002)(1076003)(6512007)(6506007)(8936002)(5660300002)(4326008)(7416002)(86362001)(6666004)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DB1Jy4r89lc9BJkZ5o3vqXjc/9HIBXo/ZzKYtXH0YHmZm1QqvBlqt4m+J27Z?=
 =?us-ascii?Q?2canYFQ8Tc2x/v657MuUgbGSbcoIEyRJPofamwoaC0g64xMcBcoZoXF6xnxN?=
 =?us-ascii?Q?mp1MLxD+80fCSVCeBl+qcjs+KQs8AIAvDHgz+dPLCVMFM1mnyIjGO116qVUa?=
 =?us-ascii?Q?YVGlyd0clAOACl7sARlBGSiIkiNqBQZlgOIF3UdfSXkhriWttU4aUPgUbdip?=
 =?us-ascii?Q?5LAg2CBSaZQVPd1AGjmigqOGsCsyJHRg+xm+evShhbZkhg3e6mHvocuLESQL?=
 =?us-ascii?Q?JoMXZFVhptXjsYZQmmESfHc5F7sEYmozSjFgR7Z17kGjOxsbDxVdg0nCIF5J?=
 =?us-ascii?Q?gBM7JaQgGUN7KktJKINhHpHJM6BdJXyHlVbmycOk5ZGEPASVbGAdUgbyyvOX?=
 =?us-ascii?Q?nZ6uYf846QwUAYNaYktv2g1QOehybHjgEAH0g+/oJFwQVTKCpGIWAoOqXHZW?=
 =?us-ascii?Q?fwCrwbT9whddp7V7u7/GWTfSI8hDNK7qwhSt3Gfp2jheKAhVfgHUd30PBJ/N?=
 =?us-ascii?Q?9vn77vV2Byre8N1fYIJZEAmAaRsBckt3FGZNaAlQzMOFyhT22uXd01Cadt96?=
 =?us-ascii?Q?WgZIt/b8lejSxE2mR9X0NFACqj8VPkhw9x0oX1km6bToRhAFThWi2bGWncgi?=
 =?us-ascii?Q?S0W3KO2g2ED30s9/fNXY3+1HgLzbHvsQCHrqQhr1g7Ds1gSv1Ik4pAF5kSDr?=
 =?us-ascii?Q?7z/VYJqQE6X+X3nJc/5P2mZNO3piO7ocjaBXgSNgGJYzPAwM4acVeu703Uc0?=
 =?us-ascii?Q?IOroTd9vjBug4rv416PfvA1qr+/hXWStIYgtVJeqwxE5C6tMFt/5j2Y/7ABP?=
 =?us-ascii?Q?8nDecqegwfZsRzxCrvkGd0/C0dBUoCj94lBkXVhNALmhMNkEKBJcpz6Dt0AU?=
 =?us-ascii?Q?1yw5oXaJbafds5mqZuDsBR8Kpuosrn0Ywt/+7YvMPbTOeWrQ9nG0E/r7lb7N?=
 =?us-ascii?Q?TMSe9g7KDDUQXJpwMJ43ud8X4oQOfjsM5yQmVZjTOUQ6uA5oLXK4VgiB8oZm?=
 =?us-ascii?Q?UrAgdHQuH4fM8nn3mCr1rTaMAnNMq6hv3u3vey4u88LSsXLOkWAMLknVI3uG?=
 =?us-ascii?Q?Yr+s0JkwYWD6IAZIjFTmrTlVZNQXcwT0qy/tZt0rRRtaFHYl6+YDW2uIjTmT?=
 =?us-ascii?Q?2jOxuDco/nTdVhsgNex9M4MoJWt6DjB/ftxjFP/JvAWr573EgwqADYzRqDL0?=
 =?us-ascii?Q?gMOJP2w0uZlRMtbXLM5BhxvUp4Y/gzxldNU0+rprDh3O/BP9N8sQBO2xOpMF?=
 =?us-ascii?Q?XvGMwtBeSWtwalzzY4mdueW1C85nNd43vEwFIlCyWtDqGoRutENtzKEVNN2t?=
 =?us-ascii?Q?JBJoELVAlSHyiWFTBgKqp0Pkki25wuOwZvuT3QFyN4TcWsJeN9nWyjYyvgk3?=
 =?us-ascii?Q?qkwO1arUASsE3Nfe42fLRr19JzEzGnbYu/d8PeLoqoQgNFxb+KTWoU0DAOyl?=
 =?us-ascii?Q?LepFVVxO4ts=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69f6b86-b303-4a05-6543-08d9948cebec
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 12:18:42.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11126903@vivo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3727
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix following coccicheck warning:
./drivers/iio/adc/stm32-adc.c:2014:1-33: WARNING: Function
for_each_available_child_of_node should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter. Repalce return by goto here.

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Fix typo and add reviewed-by.
---
 drivers/iio/adc/stm32-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 6245434f8377..7f1fb36c747c 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2024,7 +2024,8 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			if (strlen(name) >= STM32_ADC_CH_SZ) {
 				dev_err(&indio_dev->dev, "Label %s exceeds %d characters\n",
 					name, STM32_ADC_CH_SZ);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err;
 			}
 			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
 			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
-- 
2.20.1

