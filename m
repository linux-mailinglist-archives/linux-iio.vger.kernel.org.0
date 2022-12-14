Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C464C29F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 04:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiLNDPN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 22:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiLNDOt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 22:14:49 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5D527CC5
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 19:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKVetoKodryQv00wM2Jc0KzoxQqiboTPICQDh5NxDMUOmKonrxGpJW2FlZN2e1HDPeppXF+TZRHsPsVWckXjKYWNbhb0WHyfBV7/DLe1d8GQuG6j427G6ooBn1adi+Pbq6YMANO+bLP0wSHi7MbWxiFcuAFgnHibtxShTkp1dsB3Cn1pRgdYN+AWadQKIBkuTdO0n3NZhZ4iL27slkssI1vrN+2TltQrQmS3GixRgjGASRrP//YbKYYlJ/UiOe+uPxJ4QYTXM+WBiAUCbISS2Wj1eYnzuzeJORNccFSiJwHLgQBUOhs6wePe3c18oddh8GPbjrOid3dsQZFtPBo+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neatzXpN66ObfcHS/GqDzRuq1gGjSQznvklNvr5wufc=;
 b=G4fzCsbUILLKfxmf0mT7NqsjxPvDUtYWiInNiuBSwtehHYY83P6T7GXi72/baMFgvJp9JjEYY+Z5pEz3wPNctJPTMbxCi9U+9gR/pGQBH2IDfS9sMIvYpTBBrGgINcjea5YGjF1bWkkcUxO5G/K67Lk4uGsJJ1EN8O/YSpeR/jK8DAhl+VbYeDfcvxmItpnc2W1Hiy9IVx8Hcq6Pv1kTiDeajp/yhtA58UNGuQVhWtRUI2QVazwlB8HIkcJ5/cr30Imp/xchQ/Xt3BYlNsWQdiOnAXUeg9QUCAYKzetr8JjzS1W3Eq2hkoF+nyKDi2dLAkZe57tjp1b9saAe/wwB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neatzXpN66ObfcHS/GqDzRuq1gGjSQznvklNvr5wufc=;
 b=Lv42wbzB9+DVM/p+RiXybJ+BV247wq9bkcPmVpsS7b1oIq7cUKs/I45HmFAVLnp6Y/V5AAQOsZrisOApWHi6JByu2w/4AY9Q1hq5IId91Rz8HfRzOJKyTfUu+KqLXOXWsMynqBtWBjvlSKJDM5QfLRFSogCme/6VX6C+rlZfAEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 14 Dec
 2022 03:14:38 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:14:37 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 1/5] iio: imu: fxos8700: fix incorrect ODR mode readback
Date:   Wed, 14 Dec 2022 11:14:59 +0800
Message-Id: <20221214031503.3104251-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214031503.3104251-1-carlos.song@nxp.com>
References: <20221214031503.3104251-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: babf006c-7840-4abe-55a8-08dadd815544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/rurpxf4BGe5se7sqtY+16id/SPn6ikBx12qCsjnB6k+3fWSBjR3JWPeA5f2ZRo1k8SqyJPOvgAMh8ZBXOPsclmoZziwVaNoil2PmUZAsn6dB29TMTX0vQtCrLJWMJ55x+6SInm2RelPOdjLVDIC08mtAXyMECoD11pL1Dlj0tgR1hV/6uKpbkgMTw8TTaPJTWDAwccVeoIsWFPtnBMgYuz7aOIuqsgi+/aJp4IHShHNIaBVjR6xoxgiaThsVTwd7UilVnMSIcWNfGVQNzJZxIHBeGLKPSeXXwy6rjFHlUToVeaDsFYmrDOfVqSN8SBqh/HOYvGqnSDF7aTm49omWh+JfRI3A8FkwSmvHl01QVnTpFLTh7MNxxChNa6b7uWH8tQicXDw7sjIh3hkOBpsI7QgdKJ5YLsjxu7gYHL5JC+btdYJictnW77W70kNR3k0ypGgerifXjXjUoZEf3kFMPImxFTJbF9uJKZ3jYMTAMcEpE7tP2qiN2JTpxCRnRSonuhJQ4YSBQYqUtR9ypy3+9m6jGha8wQMzQyyWoYalFsOz6iD0sfyaBSc368RuXHnK6gTgmmikl9OgxbL4V8Yr03f1qPH4M2dNsSFYeZZDWphQun1ZlERIpDivoRTlJugSbLiHmuC7FqKf84cuFLAq9TSbTTZdDW7DHzO41v3KQ6OO2pY1osqiQ3XWvIXSD7wnx412nibm+NkocwIgeVhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(66556008)(4326008)(36756003)(66946007)(41300700001)(66476007)(8676002)(316002)(5660300002)(38350700002)(38100700002)(6666004)(478600001)(6486002)(6506007)(186003)(1076003)(86362001)(2616005)(26005)(9686003)(52116002)(6512007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2Tccuhp9fP51fS+OD3hnzay+UT7ylJLP4t1X8WQjLTYzAW+4L0JxQD29lo+?=
 =?us-ascii?Q?wpmL72gNhdC8N3Tm72gA78xdrWjwYnGT0xE+5s4Ut8W334YyqxDgqvogvC+f?=
 =?us-ascii?Q?tEe2zQ0oBaokOpObosx/LCDVmYWomLAj747AnLO9yxigbeFlWKXLtET42rCj?=
 =?us-ascii?Q?sXnydr8RNsLirXBdWw3HPgEmDRwIpiV9eeUBrbkm8OhQFO1kzk16vMs9bm8T?=
 =?us-ascii?Q?y7wPsmxyu/Wzm2yuKYXGQpXrZ6jJl4B+RnE26QDLs8x2gwf6FutG66hT83UN?=
 =?us-ascii?Q?VAv50AkRUVsx4l9k5Jqs2ZIXmeQRkYV2riaT6CIcmepNcVuKRszmhM1YQDeR?=
 =?us-ascii?Q?DlFPSO07j5h/JkKMEtch61AaPcB4QuN1+BjXOjI9uFnPQ+vL8K1kbtzAVBzu?=
 =?us-ascii?Q?LyiFv1eHcz9WvJQRg4vVNRvZ3Hk+lj7BAyxLu+hgll7rieRUb7PCnJ6e5IZE?=
 =?us-ascii?Q?cAPwMYtsZ1Jgg00UuoFFC+bCa1Y2GnZw+ElyduJE8G28PBn2h9d2MQE28Tjl?=
 =?us-ascii?Q?XIZCjMFtitC2NGm9EDN3BjEp+2zHNkJuXDwPIEm78PRyRxbu+/Vu94Bb3aSp?=
 =?us-ascii?Q?5GGgWkV5WQxTHSiJD6nwqtXg5vvpHf6Eb4RY6EwJQ0jjEePJva1jlwudJ+GV?=
 =?us-ascii?Q?AFQS1e9wEkjeonzpChSG5k5PNu6187b7blmbvnraTSO0ycWCmRLmYPO4djba?=
 =?us-ascii?Q?F2nSTZPIcFwhMJ4mSNA74Xezh9eGMZmotLk0VMpn8dMSV7SDgKQ6xi5qhOgx?=
 =?us-ascii?Q?WX04rY+2n/6M6LH02O3iK00nT9OvQ9tMskndQNyCAOtMZcxi3Auni7ZEC57H?=
 =?us-ascii?Q?DxRQqZejvmjHs7QJh0KpgHDB+yptRJ9Gxdz7EDE5XCMH+g7CkIr6xjrlg9NW?=
 =?us-ascii?Q?Yn7shJg9HIho2xJhxkHPzZld7oUXHZbah0AY6xf0GLbxZhixnYrRU2oUeM4E?=
 =?us-ascii?Q?GYK0XgRvJ0aKyJQnWow1uwk68ekdMWjwqa7OgZk4fKrl7iXaqtRtbVDsUTIt?=
 =?us-ascii?Q?+nOP5tFThvCZ6y0HB2RR+avP5nsDnQo5nvYIgu+XaFt9tQjXRYBsCaOq9fXs?=
 =?us-ascii?Q?DXcmY7LLbPAjcVn6HcHVIrQxNntz2zC+KkzLJbGRUSXtrKirJ++pzf/f48yy?=
 =?us-ascii?Q?u9B6rtCcnNNnDXZ2LkABYyavFkSYirYDZCGiLnAAZGyr+smBI08c1L9Fb4Cn?=
 =?us-ascii?Q?2wuOGuLtOmYiH+79h0g3pcHl0up9DADQoe0cQGYld/biNaow6bTaG7X1W1nv?=
 =?us-ascii?Q?Mz01bUnuEdNQ9Aaret0+lRUzgcxx4pPfn2N8ydB2nLQAwJoKIXYi5XMzf2Ud?=
 =?us-ascii?Q?8uS2sav4DLJzTi50dwr+MDrtMIHVnJWks44TjRoFeO3HrDN4SO8QhuxoJCo7?=
 =?us-ascii?Q?LDBzU8pkz0jxem5Rvvqmz52sBq2UgjpggjraYU5bZIOUr3XQTFD7beoZxgyi?=
 =?us-ascii?Q?on5/hZof8FmztklLovQMkHASOReFgJnBN/f+e2Y3ezoP+fbPIjyLlyVUQx6j?=
 =?us-ascii?Q?CcptTuQCjcR3bep93tfqaLMZ8oap66bPd/uWRclBvzjy/KDrGVFy0P8VKtrA?=
 =?us-ascii?Q?XQs+toYsulAyf86PUSIRFpzHdz9pwfby41z9k77r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babf006c-7840-4abe-55a8-08dadd815544
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:14:37.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUbA7bPJsH3y8GlDhdJA9pqnJPe0d7mzAyTQ4nLnNrI+Jyx4F1Ozkm67X/dcQCaUv30njyMmbqwAz8kT+GCZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

The absence of a correct offset leads an incorrect ODR mode
readback after use a hexadecimal number to mark the value from
FXOS8700_CTRL_REG1.

Get ODR mode by field mask and FIELD_GET clearly and conveniently.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>

Changes for V3:
- Rework commit log

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 773f62203bf0..83ab7d0f79b3 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -10,6 +10,7 @@
 #include <linux/regmap.h>
 #include <linux/acpi.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -147,6 +148,7 @@
 #define FXOS8700_CTRL_ODR_MSK       0x38
 #define FXOS8700_CTRL_ODR_MAX       0x00
 #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
+#define FXOS8700_CTRL_ODR_GENMSK    GENMASK(5, 3)
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
 #define FXOS8700_HMS_MASK           GENMASK(1, 0)
@@ -524,7 +526,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (ret)
 		return ret;
 
-	val &= FXOS8700_CTRL_ODR_MSK;
+	val = FIELD_GET(FXOS8700_CTRL_ODR_GENMSK, val);
 
 	for (i = 0; i < odr_num; i++)
 		if (val == fxos8700_odr[i].bits)
-- 
2.34.1

