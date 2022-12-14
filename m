Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5839264C2A0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 04:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiLNDPO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 22:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbiLNDOu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 22:14:50 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2072.outbound.protection.outlook.com [40.107.14.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F85427CCF
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 19:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPGFhmNpV7oNHmYhpu0khjTlgbnchG1aO4DCVRjO68MZ86lFO+Odp0937cHoiQi4AX/vyQO+sNF4TrtA6Gkq2QAMbGvxXqUFU84DSSAeBtGXPPwaCNjvJzBQSqx3DAWS9r14CcHZFPdoptDB8fa3sRJy9jc/VdQYBZEhvaVxr269gNNILhLIyQAJCvJ6DOUi5oG2DP04oMtx9omaSwV+Fp1vS2NPtKAsdfK4ZquRRDF/V412WYCuwXinm6KCpfLcihzbU4bYkIibOJsLdr2Ap3VnLB6ZvM1awKpanU4hl6Jl5QXcl8UVNdwbY/VdHd3stzwg0/3FQROyb8nq3zy3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fXZcI2V/UEAZIy2v/VFNdEQbjB6+Csi87Pzq2/hjzE=;
 b=PHmwTSNiziyHDWNaEHBcemt/1X/DjcKjPlq0VRFo43fuSvUOpjEPVipz8ALQ/YNiS69nNGEOuykzkEQVSgIvmpFOMszKqjW0bXQB689K/yLTNy8qnD4moLIOSB2lqoWCaaBMmwRshVLev0Gzhli9StENmNnwnDwuwYfKgPxMMVQzKnBROr/ctcuY1v7IwZa1gwMm4iiOCiHV3t1y8M8x7YWPXSjrbKDuEvH/0MBa0IpWVLLfCnHPXxw4Czr1Exj1MveKhuCoyl2VY7M7+MxrMixAP3qZPDxjOH6A4jukQpGWbf45zFm3Q/SiH66hi2e7XBn8Z9PwTLZ8mXFt9/fipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fXZcI2V/UEAZIy2v/VFNdEQbjB6+Csi87Pzq2/hjzE=;
 b=X1ZoMlD0vCXCCU1GoAbddiDUkDq/lxGnUK8o6bqKFjZo2gyBuValPG3uNygomx2QzvkhPDcZZcPjXeo8Md9Lu2PeZ4lK5FFMvPHleNC9MTNWFfkezgzfGF4gguYKsPDLIR+opCrnrekQFhI0ZCSS+HGmLhyophJSI054tSmptWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 14 Dec
 2022 03:14:40 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:14:40 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 2/5] iio: imu: fxos8700: improve readability by field mask and regmap_write
Date:   Wed, 14 Dec 2022 11:15:00 +0800
Message-Id: <20221214031503.3104251-3-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 767f16ec-2f1d-47f6-4e56-08dadd8156ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkZuPPABAZW71pvcbp0maaD21wRz4ZJW3KbHBFClQffRnspi9caqDxA22D5meNjPnibq2yzvK6HF/DKGyk4MusV8uk2yPchix20p+7WC3yhcQjygiCGimUZs3Sd6RQbdK2j9sKFQ95NWI5XHEf45ib6PVknmt23DBvaRqFArQT/qV1u9/UYlbNs9TQY7+TQf4C3OhDXuUhmiE8VDbHprc3fjHTD008RhcxLhaRB9qMnTBB6VnOhOiVoxLTts6UV14tiOz9SWLs9HmaMHqUlVucWpSnCMwcTK9cUXTB8anqDkuJW5Nqprd5qYdiFxCjB5nQRM7ypSXyXWurB06/J+9V03irJMbShxbJQH9t5VOZttCwY1DhdQD/kOpv9bYBUt0h3KLIQ3xOx1L3Hxcxe4/9wTnwqEWZolAudDIEqCYsqaRoEuwFU0xlqFtug9Av7C+PmJGR787xU6ZR6DaSnF9BYnoPThvU4R/tXDy/oPI8+OXJQv4ZDbJ5lD/IsavJQht4US4LEx4JHhwGuUn64IG9vzk7JVguc9E8yWu0gQdObZyKr0lOrYA96zb+y5+3CyBRvoEpj8lxQmJHcCc0zjF29P0hYFu+ikSgkAiMcqucPehEhBNyOhTWnbHjv52aHUy9m/eejDQdsfGSS1g75VMwPcTQSfaKj36NK/NhYLVllosDDBG5zgc9svLgRRabyW9ZOw15FMBzzLzKqJ7trn1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(66556008)(4326008)(36756003)(66946007)(41300700001)(66476007)(8676002)(316002)(5660300002)(83380400001)(38350700002)(38100700002)(6666004)(478600001)(6486002)(6506007)(186003)(1076003)(86362001)(2616005)(26005)(9686003)(52116002)(6512007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/eUDgot67dvtRX8o5c9mPvXi/WEW5ZBHdC7zM/bFPLtVJGmbN52gBRJZhKj?=
 =?us-ascii?Q?i21aM6Jg4gddO9D2hksijIv5dn5TIUBU7ZZLAUoEZg4vXWHDrHB7ewe95aeq?=
 =?us-ascii?Q?XDiFV9RHtdXA973IEfVffqRhbW9C7OJ/CuRf6Vc7jiofx94tclnS2n4cwoQT?=
 =?us-ascii?Q?ZXFpDNtHfddp3PBM9AbF1jJn1u09SCZ2VkJ7/1KLJSbHTIb822IHfMiQWpi9?=
 =?us-ascii?Q?KvkrQGup/uXF9XeZLCK94Ur2eZVo7t1kMFintDU49E0guKIuam8DXTDFuLSR?=
 =?us-ascii?Q?QVsKV9LdcakQzC6vqKn4uatiAUXl46fGehc/QgqcxYaCSBGVLJwwwPQ83mur?=
 =?us-ascii?Q?u6J9G6ugR1fgZ6I2cUtyfoGPsVroVsYf1UAsIyOxBwhNAPzpuuHBX84mbnvU?=
 =?us-ascii?Q?ELGfEGuZOOssKA8ABustUNYTgn7MBfcYFKNbg34/DhcfJej43qgyjtxNs+sH?=
 =?us-ascii?Q?3GhWgy5ryZXRW5veUoPliWugHWbs8FlqiFpLOOiOD6J+ThbtdKzkM8fZ7Q89?=
 =?us-ascii?Q?+ZHLRvbpPPhE7m8eSuZe8MRn0d8pn4IAZTG6hqOiBRnF3s1N2E7GYrgoVh0I?=
 =?us-ascii?Q?D0EeVwpgLZji2sCaCV6yfFfNmjLRr0Kmr06nKFZdQLvmy+kkSI65kfoqaKev?=
 =?us-ascii?Q?ReGMqpJXA/Syylob+GPKWLNVuHziLTceKlRKaqc3EMZeelXjez0rHymBxbWv?=
 =?us-ascii?Q?vwUCkhDkFAOpXVxM1S0zddrNciF1EmsURxV/siseH9wHzOumCk6XrvK3mzwN?=
 =?us-ascii?Q?jWXQGO1W5g8BDdyyRM0Z6xZMjj9tmOfRHKf+xufz3t0qqEYPfS0bWZjMZG5X?=
 =?us-ascii?Q?xb/2H6HWQuloM5Fo+uIjiCUFsNd5g4W+67DFj15zoTUBSFSakXGmblSDN+F8?=
 =?us-ascii?Q?ND3CTEvMAlqRz8FyWJlvyxd0ZZEa1CPlnHt0CmwJGabWayZ6dgflPLUMECus?=
 =?us-ascii?Q?C+YuR5B0zQdtZIB0zAJu9k/C2bwWaYmA0zneqBzBkMvfxAYW9YQyNIoAaE3p?=
 =?us-ascii?Q?60sCiJkfJtnRsWscu6Q1TsRAYsWMaxf7zQDtATCm6WIj9R4Of0Z7tZzDIhrp?=
 =?us-ascii?Q?gEIMwrkz5FV6TTJJfes8PdWWln1y8QW1u4Rdeqe3CLt9eXywh1mzlh5aEUAP?=
 =?us-ascii?Q?DLL8ylph1oysVUeqX7nsfYopUJBwX+TB1iYXmBvCxlHATgugJ8cFMU8MXEvb?=
 =?us-ascii?Q?fNUczErK+4Md2IJksWzzwTldM57L3O1WO2jMikwdu3S1cVSzSjpcUKiWZCOA?=
 =?us-ascii?Q?VReN7Jo7p21T9sfUWE3raVY1IEhGA52HrplVs1A6Bh0lNAa4PJxuZcnVYp0v?=
 =?us-ascii?Q?UxklQfTSdWNmtJYh7tjQqqN1Yd08B+gG4Vve/oaGPgcByKWcAbD5n2d4GzC7?=
 =?us-ascii?Q?QUJqLhW8t3249bsxGZ2Jdf8PsJsC1/kyB6zBMG2QzIbchsSMsFUl60JVUBWn?=
 =?us-ascii?Q?nJ3eT8+dKUJfGwncTm6x3rReCq/qO3JX3hzmk07jVbo0MmSQRNJwJW67gVp1?=
 =?us-ascii?Q?Og03yV3kTTJ3rXZnvud/c0Ia09XowAMJeMet2xHR+VOSzi7cyK4ySO8+fKPd?=
 =?us-ascii?Q?GU5UxQwnrb79h8sJs/a/o8H/a/Obn7EfKIc/6pTj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767f16ec-2f1d-47f6-4e56-08dadd8156ea
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:14:40.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAs281tfWmqAJ/jSk6pxLeNjATEcmT11DKuTPGn+9DIP7XdH3Jg8FqCor2dCp2fpMbYTZJqNjMif5rBOry+GZg==
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

FXOS8700_CTRL_ODR_MSK is a hex digit mask and FXOS8700_CTRL_ODR_GENMSK
is a field mask. They have a similar function. And mixing regmap_write
and regmap_update_bits isn't good for readability.

Remove FXOS8700_CTRL_ODR_GENMSK and set FXOS8700_CTRL_ODR_MSK a field
mask definition with a synchronous change. Use regmap_write() instead
of regmap_update_bits() to update bits. They are good for readability.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>

Changes for V3:
- Remove FXOS8700_CTRL_ODR_GENMSK and set FXOS8700_CTRL_ODR_MSK a
  field mask.
- Legal use of filed mask and FIELD_PREP() to select ODR mode
- Rework commit log

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 83ab7d0f79b3..a1af5d0fde5d 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -145,10 +145,9 @@
 #define FXOS8700_NVM_DATA_BNK0      0xa7
 
 /* Bit definitions for FXOS8700_CTRL_REG1 */
-#define FXOS8700_CTRL_ODR_MSK       0x38
 #define FXOS8700_CTRL_ODR_MAX       0x00
 #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
-#define FXOS8700_CTRL_ODR_GENMSK    GENMASK(5, 3)
+#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
 #define FXOS8700_HMS_MASK           GENMASK(1, 0)
@@ -510,10 +509,8 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (i >= odr_num)
 		return -EINVAL;
 
-	return regmap_update_bits(data->regmap,
-				  FXOS8700_CTRL_REG1,
-				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
-				  fxos8700_odr[i].bits << 3 | active_mode);
+	val = val | FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) | active_mode;
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
 }
 
 static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
@@ -526,7 +523,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (ret)
 		return ret;
 
-	val = FIELD_GET(FXOS8700_CTRL_ODR_GENMSK, val);
+	val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
 
 	for (i = 0; i < odr_num; i++)
 		if (val == fxos8700_odr[i].bits)
-- 
2.34.1

