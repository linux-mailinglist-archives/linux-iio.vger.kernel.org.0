Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAF64699B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLHHTA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHHS6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:18:58 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD88429B0
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkY7rPUSGlSmjaTrW7F58nhQ+XXDHdsiI8fU12IeSId8qSQ0uLFulVWEpFvoJgJvsY2qD/vDmquUdvMOdj7oCkCjhgGEF0OjtD7ewUeR8hARJF+HCoD2A+Tlp5b4GtX3h/eYBIPwcllWfP/0sCIQnNPabB11Z1KtS8je+afj8yMoGTDbJHG5WZEeTbLlKnXv8P9XOD7tdcPOpmE8tbKUUuNIUVO19f5Xfce5f4DTu042Q/or13W10M3y+EY9fkOmSId/dXPDmRNi/WFn6eGHdJ9bB4YVEzW/5RXVDrVFbGCrWh2pYCiMVxEq37fneWo5aNlVE6g51+wlOGfyoP0xQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2+M+741Z0t+lSWtxp4QvER0T5MYK0rk+HA64uGqInM=;
 b=RbzX8qL+BMi7vW/iaeRclv19zbn1d+uSaeOp7ju1oRYltChGsyFrXjVd2/16Uh3/UkJEKs3Ou08cljYf4+h/onivwFAIPw01yTVIk7gQbl3l/m5IWoA3mSMddYpyqcPRmiGvWXaC8iZdgICBfb5Tj8HPWr/QI79tPPdPZevTHaVnkgRCgFrtHmHtR249iKpuyB89QF3OpQVB2zy+f69D+vfaqTL9N3tGfqoSssm14BDCp36y4easOzABJaxbJ0s48EgzD6QSzRohJiMBIvId16u+KMjeYK88xOgbjwhp8+zUieqRnwJquIRyZHdfeBH/f6a/29FXIvo94j0lccNXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2+M+741Z0t+lSWtxp4QvER0T5MYK0rk+HA64uGqInM=;
 b=i+RKXc0tFj0lU8PJ9Ch+uR+Tlc5361XH5EvRieF2kfL/cd3Ygg2pR8tZf+9Y8VCZAmigdpVXO7XdwvUM7zdVvArg9ixDDJaYSnTc+HTjPl90ckOlSqkDQDXDK9d4/80iP7XMHA3T5pImyIl1ATrDSl/gMSXnFPJxU6+XcyAG66s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:18:55 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:18:54 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 2/7] iio: imu: fxos8700: fix swapped ACCEL and MAGN channels readback
Date:   Thu,  8 Dec 2022 15:19:06 +0800
Message-Id: <20221208071911.2405922-3-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208071911.2405922-1-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB9PR04MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd3b6dc-2c7d-43dc-5b1d-08dad8ec76fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Za9R3Iu7ea0zvnDIOUFpJp4yOZrcSma20nL22d9Pt7hg1jwOTK+KnB9iV6GyRGN2ggG8jaAioTvYGsrgRzfptKuYAXAlbLHikWakItQzBTx9A/bqlagax7c/iBBnQEJ31KSP7I6zG8jx2K+tPfB+h74+EexfW/Ay7IS8aoYDKon3v/8Koc6Jam8IdNoQAZlIX+EmidVx5A4W5TX4t0oGezaq0/lCF2O3Yp6IsM0HNrP2q7jcByS7GZnIC+roxBrZX1awxGDJ84DgqcIHp3VyRE3gzL2fO348/lmty/n1rYpzmF/dJMic/2/RvNh68QScs7DsQjm8007ycNWuIfwY4xhBPkqvIxE1ttY+q2lfEgBW6TDX7IqVkAqspXaDxjxgU2Yw94GaqPKI+hIgFV8WNfFfKDdCrP1IpTuyUXrFKCwQHReZcGM60sdf36pnC7RrvArFnWIGGsgY1xuFW6Oxea8+7wTPDIgGl9RxpKJ8XJx4V2Rx6fMFmRVtDMtflaQfZWDnqIUyHFx0g/+2smBE3YrvyXoRmCjpQCXNLBLJ/1wq/Ik4gJARb0cJzmq4Mf/gyw4kRZjgQvS1QQ++U17J/g494qzj5a/8OgTTxlTlFbRwZoznjKmbgcyLhrEFZK1uWLLt7jZqC2tdxbuqmgt8Mg36XOexyxhH2YGc7tqh3XMjBzhLaIKm212huV+eX/CjvszoLc4bolNlY3FlqwBzXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(83380400001)(2906002)(186003)(6486002)(6512007)(1076003)(6666004)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rs9hwA70KeDRsH4Ubs1cy3F81GPi2/FnkuDNgRYaTri9QyLKekE0YMIgkMK6?=
 =?us-ascii?Q?rQVNFp8WVS+1HsoXNE5OYapbpRVdbLboQqM/cHyeYX98f1BUp0szen6S/HUF?=
 =?us-ascii?Q?iufz0GOai+/jGkJM7thhrY5+aYmeooZAr57crBK9jN9BWVocGknau3N5pZo9?=
 =?us-ascii?Q?pYFnrFikTXMav3zuj8FUneH8vuynvqN85OBm8Tc1K+owYRJcyBjR8GtH3KFx?=
 =?us-ascii?Q?/EytedgYnPGM2PKMBUnTrV9XgfUY8TOqZxA2gasCB58QDyixERSKbW6NfNpG?=
 =?us-ascii?Q?EoJi0Q5v346cTCtHH5F2+qAp2gm77tKOK/HG/ihfpDinwbqrtpq07uemV5ws?=
 =?us-ascii?Q?T3Nct6QoopgG8Z6DkbNQyxFs/6LJyAk8JMpFHzovzMZxBGuo4RHbBUlhmaVa?=
 =?us-ascii?Q?vhhH+3JD7Msxw4XiwNjtfmTpF2z8snJNAtSqL2lULzg8WF+fUozCY+srusDb?=
 =?us-ascii?Q?Aukr+8vTFeZ6LUtJuAV0tZeB71/o+0a8TjYfNc1i1u7b97PbZwxRnynRWY6W?=
 =?us-ascii?Q?ObDjcdeY78aftizDECsfe8e/iDdNLoAV1Q+ojru1lxY85v6bmAzjO/Naiovv?=
 =?us-ascii?Q?SB2QjDMf1SGSqaJmwvDG07TDxZeFiSDlDeOEyi7GDHpLJuLBIaWRWrumCpSc?=
 =?us-ascii?Q?dtuT26zZHC86/tLQLE/22PvTWDJB/Zh6MM67BAkj5NlLDK+oGCGr4WaSPvY8?=
 =?us-ascii?Q?x/m4btIwMUf9O0AevSvB+RWljsSmReDlDY0oMcPRYmRIGkYDbrwFqL7RpmhA?=
 =?us-ascii?Q?zdketX0yTG8w7LC5DwpmioS5y1rqJECvqgfTZiad2rQsH2T5LhA+FKRm165d?=
 =?us-ascii?Q?CGPZz7PK6ffTB0KQUAdg9ITpPNsCV+wwc62nqGg2eOm8jDGENjwGXsdJ/2Q8?=
 =?us-ascii?Q?XSGkPGGz4AoJQNhpjCI52st1XP3JL3DtK8r4e3jM0MVlyhEHfzN8IIWk3VC3?=
 =?us-ascii?Q?HVVFEgYXOu0tJOu51FiVqs07PQwKgxByn8bwkeeHaExuxB9yfuF4Drc5fIOI?=
 =?us-ascii?Q?aJSrdmLEYgA/AIlw5hzw1+/t7CKjvxhbS8hBheRcz7FVUpBvk8D9QqlHndDP?=
 =?us-ascii?Q?vrA8fbuM1A9B5cR0gjxrgIv3c1EXZlEG3qf42V9P8ZDDw9E35H3l7UaFgTGM?=
 =?us-ascii?Q?5bmbPPdLiED6+7xG7uKMK5UiXawqcu6aoBf32K6GPJTe4ZDynlDhaucBKTLB?=
 =?us-ascii?Q?/TXnz3rblqnokILrn2/benqEVRHB6dC5GLNe1fREuPyW6cxNfBmuLdPCW+Yz?=
 =?us-ascii?Q?Yi9oJ5IBXpc35l1dOi64THf7DX4TEio5PNDJx6X59o6weq0eqh/wS41785Km?=
 =?us-ascii?Q?uBzb628NL1JFTfvWiaWeu6VJ8mALLcWUpqL0GeZnycZs9tnnJfGezFZXRrht?=
 =?us-ascii?Q?5zx2kzTlM4rWF8q6wbkdqOJuUjuTrLAqusP3CUnO9YRqdtMENndZeHh13aZE?=
 =?us-ascii?Q?khKuAEONnBOGJvIGEHLPaXzXAW7kSrA4de8zUxJowieacxllhFEc9t4DlhSs?=
 =?us-ascii?Q?fatdiTJf6dwmLY76VkFo/es6VOkhzgHPEkrKUOrsmupnxWaGZtDOtWY9zJBv?=
 =?us-ascii?Q?HOhCyX6X/QXEJenJOrbICci1qJbjb9Vt96PFQ9oT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd3b6dc-2c7d-43dc-5b1d-08dad8ec76fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:18:54.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+/v5lHXQfEgHV5wIfD4r+7nl/SD3zcx1vOBWSVqucn7l6oENg3eqMlpF/GzfvG10pwTb9S/ykTq4cZ1ItCyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9701
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

Because ACCEL and MAGN channels data register base address is
swapped by error judgement, accelerometer and magnetometer
channels readback is swapped.

Fix swapped accelerometer and magnetometer channels readback.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V2:
- Use a switch statement to instead of an enum to index the base
  address of the register by the channel type
- Rework commit log and comments

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 235b02b2f4e5..977eb7dc7dbd 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -395,9 +395,22 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
 {
 	u8 base, reg;
 	int ret;
-	enum fxos8700_sensor type = fxos8700_to_sensor(chan_type);
 
-	base = type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
+	/*
+	 * Different register base addresses varies with channel types.
+	 * This bug hasn't been noticed before because using an enum is
+	 * really hard to read. Use an a switch statement to take over that.
+	 */
+	switch (chan_type) {
+	case IIO_ACCEL:
+		base = FXOS8700_OUT_X_MSB;
+		break;
+	case IIO_MAGN:
+		base = FXOS8700_M_OUT_X_MSB;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/* Block read 6 bytes of device output registers to avoid data loss */
 	ret = regmap_bulk_read(data->regmap, base, data->buf,
-- 
2.34.1

