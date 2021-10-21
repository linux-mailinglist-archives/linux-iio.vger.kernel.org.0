Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798BF436028
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJUL1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 07:27:25 -0400
Received: from mail-eopbgr1310102.outbound.protection.outlook.com ([40.107.131.102]:31283
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230072AbhJUL1Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 07:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTrYnh3aVMTB7O29DKXgdd9QNNVg/YwYkYOlZ3XGyMzEDdxg6FQ+uqfYtp+d5Z8jqP4E4Qq6u7T4I8gJoyTNaAcGJns9+6kGMW3wbjmjEMVlg/kgVHrZ5vbG3d12y2Pysyk313tf6tqquUM6hr2ugLu5nU7m9LyJerBbrwM+bJp4ORiG8jZJ5hRemRjbFYGWSNu5enYSV269rJ6GSfHljt3G1BuV5DDGrbLPVlytdLhHj/+/ycPBCyzRXMJggntAW739Nqpi9DfF0QoaevoBP1wbs9iRM5S67Ho64R/Wg3gixDdyNncBX9PXrzc6QCrF6JrtV5db84dVYu3NNKXP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZXq6ygkNsrLJjXtGer1fvQZNjdjIaUbYKaj5NFk8RA=;
 b=BhbGQILSHqANFiX2FEIorcg+y10zXYVj9+1Wh+VO4kLpmsuSHCzSSPiom3GyCEKy14vwp4giVGNIGj3hEa0a76onPyZHB5fgIXWLBCiMrIwH3S6zfCnljjvSsJcom2sS7U+oPGd4Y1r2A+DDTKGLY2zoiC2usz8VHiJHIuWGVthMdXNwOxd8GyEV411iFvMri46QlTEWpn96HaOvZOkC/MPmxyCPaGbrlluC1p/bx2GKWiFKhXaOgBx3JyxP1d5x5UHq91IZHj53pAHnKMX+kGmcFeOZCUQZOzHB7Ltf/tYbL4NU5ZYyddk9YqRr0MxGKj/Il7zYTnVFmhpfn9p7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZXq6ygkNsrLJjXtGer1fvQZNjdjIaUbYKaj5NFk8RA=;
 b=mS6QBGHeS4tRRgx1AqqCYRlOaPO6wILTGUpZPspNTggt3ocqBzZhoVk6nzehaCf58akUefdqDq4yFnTXRo2tnY3JZQO5CQXhfYo/YnBeERZgtmnxpizKuDPv8xVU50ubW59hg6TeUlt5e8JcOHKW9KlDsbH9kfaDvIJ5M9OakAA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2779.apcprd06.prod.outlook.com (2603:1096:4:21::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 11:25:04 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 11:25:04 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Xu Wang <vulab@iscas.ac.cn>, Wan Jiabing <wanjiabing@vivo.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] iio: adc: stm32-adc: Fix of_node_put() issue in stm32-adc
Date:   Thu, 21 Oct 2021 07:24:49 -0400
Message-Id: <20211021112452.9491-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR04CA0075.apcprd04.prod.outlook.com (2603:1096:202:15::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 11:25:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985d6a5f-530d-4d35-109b-08d994856da9
X-MS-TrafficTypeDiagnostic: SG2PR06MB2779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB27795CEE13D6FE6CC3CD2713ABBF9@SG2PR06MB2779.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brLOAQMuP2YSwdPbhbCR6nqRyf/OaoGP7JkseL7PeTKhE5/fG9qlcaUUlBesOzSfam9NuWrFVp671HZhA41vPl0GNHZqPdUV1ERfLXD/+yhZ7bjOJGReSrPiGA5P0YH47ywoTaRathGfZ+fDzbJTsFDdUp8x37x+0HmO9blKj2pdXL4r/bbV3NvWTcbM/BV5IWmDaxmd3HxSsVvzJ3z2840cnsF9zEtT9hMmF/RJ04U2qD9DLAfBRy/W8AKA6J3Xa+A5w3HUgktxHmtz1mQih1cX3SpZr/cucNgGHqTbm1Hx8W/Lq6DIn9xo4N++Ee0Qde+gFN9857RVdvm3B2Fv2qx4PulvBhy2fRI6WYwj+XHi7bzdGZ0BTirmhomo4Ea8K6Toy09LyB67qMW/HTiK+QUFkIY6KdTRCT71zt3t/cLUuWzzNTn1cRX3B79ZeeavSOy4Biaj3MzvuzkKlZB7GIN75x/+AokJkSYsmC33LLqIjE6FA3SYw2DsXuzGfX/mHaE28XuUX5D5/PRjuK+8qYxJV2hoBtZRfmOgkDvO06f79SizTwTc6WWOlZDm+b6R1xhdMbosDwqEMqDi63DWWXaQj4blJYwSXDFlHlktJtHJCNavZ76YD9dbopQ1wtPeNz12a47cuBcxpM8QTNWERY7mjk/MpNYwGeaFmbX0TyWx1V7hbiHS8yAu7pCx2dm8neVmxmfXoQOG43OD8PksdJu3tlTed8KndmZhn4+E4fM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(316002)(38100700002)(186003)(38350700002)(66556008)(1076003)(66946007)(6512007)(110136005)(5660300002)(956004)(4744005)(4326008)(52116002)(7416002)(6666004)(6506007)(26005)(508600001)(2906002)(8676002)(66476007)(83380400001)(921005)(86362001)(8936002)(6486002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aV8Ui46EVrgn+mcR/bBih+lnQ7+8cQOL5+cIrNhaGHt75DQVj5SYecLYKwYu?=
 =?us-ascii?Q?TFwrtUIpBKo3TOg8s5pGpvxBB56lsuOOPg4lfZqBAt0Y/uwJQYklS2Jgui6j?=
 =?us-ascii?Q?QmQ/2LDnxjZrCVqVMPpLy0iVa8SjuPOrPTtgLs+MKCaur7RSSP/i1PIOLfrN?=
 =?us-ascii?Q?BVxNq951dsDI++k5yZ/m3Z3AfRiiyBE5K66QaKVmMK4KmiXy4r5tsZg4Vsho?=
 =?us-ascii?Q?Qp5XR9qbsQHs66ouh7UUnXKgptepYi6VBjnHdVhCN+iUsxhV55QOQwL20Fts?=
 =?us-ascii?Q?5fm+Oyjn4OZkkeEMXRqQEoMZ5fN0xtL2Zmg7lgNgXYI13HKb4KX1DnfDbyu4?=
 =?us-ascii?Q?rZe0CfMvo5Q14v+b1YfR8ec+0E/ZGEkYZWoqRg3BQoBpdAppjhJ0Dg5KQrk+?=
 =?us-ascii?Q?8D/Cr2Nn1rWTyAXCj3Uwa9r5DzRAC2Q6jjuY2qS28OFB4j+TJ/8h6s61SL1z?=
 =?us-ascii?Q?uUfBybzvoaAtEumLimzGdDeFYoDgW1ceOh7ogmQXgx6nhbggS6e5Kx6SQMR6?=
 =?us-ascii?Q?ke0DH4pu+XGtl4pdAo0298wfSqjZIYYsFVcf+Vhry4zkMPgaavhINEA/Alr+?=
 =?us-ascii?Q?JxkjvNRyK7Nz0VtokEpG9/HCaXMD+0OgTwEMQP5SIDuGNARBxO3ikcN0vLu1?=
 =?us-ascii?Q?NE3UoVa+ml6vtuNztQ8NAR7ZIdsD1EAy1WH+eT6UEZkthTHcHhFZm0Yh4Aue?=
 =?us-ascii?Q?kc86nUD/PFWHc9gNSEy7+7dkeVv/TVcU4Eshr+t6v8bKFyrKe6X54WMxXqw1?=
 =?us-ascii?Q?2pLb3e/wzMqy/PpJMenNjGqUnTw7073PYikXxl8rw17fTPuCgMn2S3KSCLqN?=
 =?us-ascii?Q?xrK3GgUHSjk46yb3Df9Efhs4gg1kuY4STxjMX6ngbeEoECYKVzk4MI1Ue9fe?=
 =?us-ascii?Q?QJg27xQbQEshvRI3teS79Baqe9OH42kS2sKSbOiOHqBm+zEu3WTV+KW8nsFc?=
 =?us-ascii?Q?1Y9a2frb8xqvWy+WEl40RRZbKv+yUrouTXCqh/for1j7ZZU5NtBtDTXUCkaX?=
 =?us-ascii?Q?/mhgh3AqGGMXKSYA5pnFF0DOgPeExUMjbem/5aFa66JbV6qqK31rK7Rnf/Rh?=
 =?us-ascii?Q?jElufN5jZYfrvIOhIS4R0Z8GxY57o9eMxWq8ZbSLtyYVPIorIQT9A8p8DQ8/?=
 =?us-ascii?Q?sBmcnOXH5Sa8FN01wR/ey4Gn5XES6SVLv5+p6SH7TdaOc+fu1kGd9KznZSPj?=
 =?us-ascii?Q?hZZJy9RAH2HYBd25iIey869Xei1WkfwcuZ7mASFulbNqfG5o5iYery7AEiIM?=
 =?us-ascii?Q?gwS1N/ZM2oQ8FpvL2PDlZkLYJqhWCLLCmUNo84JbdcRNigXmWarsdrhIlS7D?=
 =?us-ascii?Q?Oj/shEI6WGQDp1kFVROWXPt7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d6a5f-530d-4d35-109b-08d994856da9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 11:25:04.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11126903@vivo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2779
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix following coccicheck warning:
./drivers/iio/adc/stm32-adc.c:2014:1-33: WARNING: Function
for_each_available_child_of_node should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter. Replce return by goto here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
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

