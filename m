Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0C6574C7
	for <lists+linux-iio@lfdr.de>; Wed, 28 Dec 2022 10:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiL1Jjj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Dec 2022 04:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiL1JjV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2022 04:39:21 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1837DEBA
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2022 01:39:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp55z3ov/2LbjKXUzf+Dbzkf+JZhJEPwmh+Tf/CQCp1PrZ+pvXufZojGqZyD0QZ0B7fm3VchafJUaznpmdwbnigN8IBUW1RnTGfwWREqiQW+brmlru1K8H0PWN07ojL36GXqXjVWJVrq8WWMyylT9BB8/R7n8KLMK8fS78F9gqUl7FCQJzVdmPeNNuNUJm7CgaY9x+WHI64xcUGV2wrSLlSeJrtFCeOsx8GTdWh+rT01wXlpD6W0HZDaz2EUEzcZs4xOXR+YU4bKWDjZPHIlfYpdfW3rrPtEX2+YBJrFQMNDPGoQMcPlPUDspQNzguEE5ZEbnsapBzjs/efhQm/q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2SvZQE3CxiykwmACqCbvngM30kXemGS6Gv/XpJZ/L8=;
 b=JyUIzVaXpBFNANu4qmmvMcm+3kAGpaX+PN58Ldiv5nfduduP97KMvctyS8OUJ2p9eN+E3LQfOZWYbTMaGtTHvhYAJxH3DuH5noaFYwcWz71sHbZ2WTG09SfAuyNEQnKfKQoVDedt3yfxC4Shj8yUqxBJ+nX36EScNnlxRpHD1sWhNud6OgSoKr6n6iyaFAZ7Z82kWh7/tLCL5xGYs3KXmDBa/i6JhDpsB7EJ8/TUnQIJMrqeFNVIDAaN6e52Cki432PONO1hirZHCYXtMqNixDUTaHU89AZ7xHZ3QJblhJC301mwrFhPw2Q8Ix10KwpAPJ7N8SX+I0xf920YvL3zZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2SvZQE3CxiykwmACqCbvngM30kXemGS6Gv/XpJZ/L8=;
 b=IkcL1k9UhHWa73ckcnV1iSf7Q4cvNVDnX5VJiUwzZoLy+cfifb0RGWUY3fX1qZr3TS9LX7qi8fYX7uNlkndKs2rRDz9EckmfK29NYPwTuKd2BYZ7pRAIUo5jeqOd4TkwQhmoOLxzXIyQzlJ4y2WCG4g/Q4QuswOb+P+Wd6tZfx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 09:39:16 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5944.014; Wed, 28 Dec 2022
 09:39:16 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 4/4] iio: imu: fxos8700: fix MAGN sensor scale and unit
Date:   Wed, 28 Dec 2022 17:39:41 +0800
Message-Id: <20221228093941.270046-5-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228093941.270046-1-carlos.song@nxp.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5966d244-c40a-47fb-33f1-08dae8b762c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mp6LtXu7PmFDH8em8eIbjnFzq0ROfCwTU36p9TWzU+VYnAUn/ZsW2uUh+Q/8MWvz7cmhSENzqSnhJfU74pZY70JYHyg1FvbtIf7zBTpqIbPyvu9E2Bl4Jc+WfH1HyIUtjdmFBq9a4ZJFtJJFFaUjzbHlIxYror+FmNZrJ9LDNu2B+JGSBpfX5Z7HhFIgAIGKw9A4gEUK7ie0gX1823MrNtDCBJWcWnVluPUC9kOCZ3lOl42/4LssX3vL0jppSaNuTApeQaG4w+o/Q0bNm1UksMWc6PP9+hJP1nodivYW88tt4aL+4ZgT9jVnVVlfVusjuSgCxPjx35IzQUwT22U4HlY7QaeQFYvRCCPbfU/xe4BTyAJU2VL4fwBKjVM22PkPH5dJNLbYx2fbsieSk6Cr5IhFxqMJOooCuT/QiTNxauCXosZX+mZKF2XWpFzzCAXJEc5owceGu3q1tYMVMcaFxsWTLocjgp1ouixdHm93Ff7KXqeAQ73u20phdWQHQDtK1EB3bkmrravCqmRoY7KI5ofmUHgB0vF+gbemtDFr/o+8x4OY181r+nFYe099wiYbfEyNpVsWxXVvDBFxY9YiXIzbXd8wux/QrAQwcc8bsH6AK+h5ZGecDe84vUAYza5UXw2V1ECtdJaaGnfDPWRjAMoBXkOTcjC24MR3k6A20IFNv8HMX+cPCfPveo622eUJL0VMEPPtRkUDh26HUu52RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(66476007)(66556008)(4326008)(8676002)(8936002)(86362001)(5660300002)(66946007)(41300700001)(36756003)(316002)(2906002)(83380400001)(52116002)(6486002)(478600001)(1076003)(6666004)(2616005)(6506007)(186003)(26005)(6512007)(9686003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePLMeu0oleG+jurDR9mK5gojQfrjKQd0Ih5mBRmVnG+H6gKDESRQEebyYHCk?=
 =?us-ascii?Q?h+3QiWGMyTmao61J3NvTDCpMglHVZYqgVMgbnlTmXI2Q2DAayp2xsUbfOTVD?=
 =?us-ascii?Q?/ug9YrpxXPX4KL3pBkdrF7eq8r1g6CzsIwEdCbp/V5uRm/uqbzoYr8FFuH1V?=
 =?us-ascii?Q?WnYJW3Iy6enyjbBKWs5Gfk4BIQORB7dWimtXxUIf/gxw5azj1VhVC5hkjJfR?=
 =?us-ascii?Q?+/uIUIJUV9IqHec34sqQNFZUWnutBnbf5Toor8MoFLZ2HxafZcABygIwGQlZ?=
 =?us-ascii?Q?SVGzN/345u1e3awa/82zzmlHXO4GBcKSGWWM0TLn3Uala3eG550fMmqSRC3u?=
 =?us-ascii?Q?RKIPahYB/bF9EN1p9iOg77t752QlXbj+Cyf5o8rpL5ZrRRyqOA3N9kEMsGIF?=
 =?us-ascii?Q?01SUXLGGOW7afKkss9rrY9WMfXqDgEzvMjOgRK/+eJ3XXpAQAlhCRIiD3Fli?=
 =?us-ascii?Q?tleZBYHgiwijXVWS3pi+034GZHg9L6j7rfi4ZbG5Ia/XpDZdDwgvsYlZiQmM?=
 =?us-ascii?Q?Cc0PGritOUIQzUxK2rJASZfRSgJS/pW4li8fhSj6IK1b8r7tmzGNUhRZsK5g?=
 =?us-ascii?Q?oN/aeHZxABPqGqnd5VzHjzaB5Eipy2bUBjohqvaPatv+wFod17/sCFcKzWEp?=
 =?us-ascii?Q?bCnjg0vN7JhWlFZRvs8jz+nk7iEjkmpFjmAh4Ma6v4CfChOLpILZ4oZ2VdCN?=
 =?us-ascii?Q?b9yrKTrPVMAK2xiWluMUPpJiYvYcWH3mbjl7XN5vQLuf7N66WkXiEwC4Ztth?=
 =?us-ascii?Q?fvtkKb1pDdJaVMeoxQSYL3G/d5VwY/nBP3FVlccyqeqaAMLTs/rXFihlnZQW?=
 =?us-ascii?Q?vG0CAf0VAMQGu1RxvGAhUmT7t89dfdrfFQlrkkX6OzqrTiWmA9syd1MmHMk6?=
 =?us-ascii?Q?4EQQhQ9/eedPaRKSzlJaO5kCayJuF6NLU6+NUPM8ebSU8CS+sS8C+O6Ipnqm?=
 =?us-ascii?Q?BtVjBnajgAKIw0o65b2ZoxYlBltxOG6hIqislCKxDi63wyLbK0qk+KZ78a7H?=
 =?us-ascii?Q?f2lZxhmVulxYyQ1KunPhbjX3zwicfgK7BfEVyFDMqgrEX2yEc7IoARQwUfDo?=
 =?us-ascii?Q?aEPjrQllKuyZf1SXt1RiGtRuxGLfqEe6POAPycRCR8jQD9qPf8xgszlgZz0L?=
 =?us-ascii?Q?D6N+Q2xAxxAMg17mbo09gifWmpdC3T4cchec84Th+SIS8WpJmdicvej8GREm?=
 =?us-ascii?Q?rGs9bQmaWTKv9tyC8xg18fEpg/8/TzK0Y558P6Wyt2pe1JbyDJb8eP4Nr23s?=
 =?us-ascii?Q?c88es7OljTv6GghSFwqTR+2x1KK3QPNk8x5K4z6FNJfPvXDWn7a0fTz5AJvI?=
 =?us-ascii?Q?Zm+f/RKVQjxUujwvSmQx41T57EWqE0wws5Gycjw54JfluNk9T5Tpf6+8T/1K?=
 =?us-ascii?Q?Gesftlqrb7TTdzQsahviGlNaRtg90mqNmAGtLeX9yazjE9xo9/tkvhPu803m?=
 =?us-ascii?Q?sbaSIkmrONVUN33ksJG7Rh6osH8Bmk6T+EklEVsalKagTtZwnhH1FWFAhH6n?=
 =?us-ascii?Q?/CqpQqtc44X2FmcIcFeEhyRjITl0Vm5VWZ3w6HggZvk+ACihQJH3Os2dlTl+?=
 =?us-ascii?Q?LxO7gCa1WhGUXGsYWTFqLWx4gEpTGbKrZA1jufsC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5966d244-c40a-47fb-33f1-08dae8b762c8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 09:39:16.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7r7CZlDeHo0KVA9/tWT5tfwwxiVFluQFMECmhoxJZmn1q+0O9VmTdn7ue/CqiDytHb2dG0+HPeX9Xlvhq83dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

+/-1200uT is a MAGN sensor full measurement range. Magnetometer scale
is the magnetic sensitivity parameter. It is referenced as 0.1uT
according to datasheet and magnetometer channel unit is Gauss in
sysfs-bus-iio documentation. Gauss and uTesla unit conversion
relationship as follows: 0.1uT = 0.001Gs.

Set magnetometer scale and available magnetometer scale as fixed 0.001Gs.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V4:
- None
Changes for V3:
- Modify the magnetometer sensitivity unit "g" to standard unit "Gs"
- Check and confirm uscale value is correct. The readback of
  MAGN scale is 0.001 Gs
- Rework commit log
Changes for V2:
- Modify the magnetometer sensitivity unit to be consistent with the
  documentation as 0.001g
- Rework commit log
---
 drivers/iio/imu/fxos8700_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 7b370bd643a1..8320a3b6f942 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -351,7 +351,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 
 	if (t == FXOS8700_MAGN) {
-		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
+		dev_err(dev, "Magnetometer scale is locked at 0.001Gs\n");
 		return -EINVAL;
 	}
 
@@ -396,7 +396,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 
 	if (t == FXOS8700_MAGN) {
-		*uscale = 1200; /* Magnetometer is locked at 1200uT */
+		*uscale = 1000; /* Magnetometer is locked at 0.001Gs */
 		return 0;
 	}
 
@@ -587,7 +587,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
 static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
 		      "1.5625 6.25 12.5 50 100 200 400 800");
 static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
-static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
+static IIO_CONST_ATTR(in_magn_scale_available, "0.001000");
 
 static struct attribute *fxos8700_attrs[] = {
 	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
-- 
2.34.1

