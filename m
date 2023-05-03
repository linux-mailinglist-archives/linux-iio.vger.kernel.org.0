Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA96F6054
	for <lists+linux-iio@lfdr.de>; Wed,  3 May 2023 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjECU4U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 May 2023 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECU4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2023 16:56:18 -0400
X-Greylist: delayed 658 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 May 2023 13:56:12 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD54D83DD;
        Wed,  3 May 2023 13:56:12 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343IS90p021408;
        Wed, 3 May 2023 20:44:48 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2168.outbound.protection.outlook.com [104.47.23.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3q8skyjbgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 20:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9bjaFzmCmpT/hUekDt8IZclaeQ69piARM3vaxRBAkHPLAVPhNaUXgM137Mg6K6ywTTdSSvQRmH8XfzPje6Q6SpMYr/Z4oR1rdF7HUqnFN1BLrZVR/YSKa0PZ6u6msF+L2+FTBJLCLLaVw+zqJEk1tNDWWiKT4W8oG0nn4sj4inrBeaTExk3K1NcrhqrvtTonTFChG7sJXZdT5g0XbWyHWXeLr0Hfk4ecQMUDK4/ld7ObHytgjj9toDxOEuhhKYhizxjQoT2FYnGy9EXC+N81V1znwH6VvHPQdNvIrVTW6Ll7nf+bHFngcN2kn6Rz1Pozf6Jtb59QqtjmTL8WrvcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulCimDeSBGHIbBnUvyNDLJDGapJcSRLIqC4b0mfEjmI=;
 b=MXgApg6aeLsqGN1izP0NxQFEWXePfs5ZFg/G4lBmsIu54/0KAEHdD7IYccVF4AUsKo8QCmr1Xyq2QkJae/S9zY0vV8JwDYUsFO60Et84dVvoulHlimon4eIhtrNvWQSzV06zjmnYXNpV15/pkdcK0hUfa/vjYggReZGxtXQ4Jj7r0I0iPcUwZmNIVRdxASB/sBtTvLJH9Syco31js7rnfvcHTbltH/sc/4iZsIs8LpQ8ZTfaAhRl5oTScYzh+Nubeer2gChAVn46olK3CkgUNVS/0nyc3rcJIO33DNGj+1QXH6tuc+SpyaB1M2aha5b8SriLhNagOHYjXSKI27UYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulCimDeSBGHIbBnUvyNDLJDGapJcSRLIqC4b0mfEjmI=;
 b=OUJyfHPf4q/pb6pSRDpI4bruNNapA+cfhYYAv9TKv55pXkQkziyVa7aLbxwTCCz4yqrriy86I6QDXhyEZkDEQ/cXV6ZC7bj6V0QfUOVOqFruRPPxCmH8LGSZO2djnTUm53DdPlx6habAsesr1Bciw1cOJ2H7aZBw6gK6SCvEcaY1PbKmm8ZC2UgznH2IaC00SMN1vpoxrsa8LdIfHUB8D9/Uvyu24hkS8lLyUHz3kUiZtJcg170ZyXQTtwEoCrhkJpcATZOolNIKFKNfgqOnttbb6RAexaOePZaCO6NXOT4n1GFpdzlaNiFAXzy8XLyUkzIpOw0Ie1NHYuwWq97Qzw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB1974.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:165::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Wed, 3 May
 2023 20:44:45 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647%4]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 20:44:43 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        inv.git-commit@tdk.com, stable@vger.kernel.org
Subject: [PATCH] iio: imu: inv_icm42600: fix timestamp reset
Date:   Wed,  3 May 2023 20:44:10 +0000
Message-Id: <20230503204410.165035-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB1974:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ee1e5f-e303-41d2-e294-08db4c17389f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ug49uW8CINnaIbhCOwNqtRLuTL0hs3MrybPGeHterChqGttsaZDitiMRbD89jeHa+Oz9bGTqYBa+IHGDwZrohznPZXB5fKSQWWU7zBuenYO+Mdg4xNC8ci4l7tJKHkW62ZzCWtAmakg2g9p7yE3R5XOi6wqEqXo/hn6FJhE8czR7WPNPMqMJsBXRgCvI6R8lZRlsiFHc7xJTQS2cD/NetaF+1msluGv/stFbi+xpXKEXiDukEu4aCjy1ri/801eDdBFFzI++vZb6uKFuIWM3fjN2cw7xAxQERrpKoRCOj+o3s/4WTqKeV4ku1mdrP2gkAtAjzcnrD65PoQqfrBxBrdiMk2lRx49wRabZ2h/ce7jK89cwC1BikTwd8MYz5n6ns2FGyl9T/2PNXOUX9yZNYlU+l9B3wlBYgqmJ2NJLYQfggGs7zszVyBt1nil8hZ9OOKEr/QCQwmr/AP03uYoS9Gna80/FRNMLOmTYRp6DoCsCPIBupYbLQWfRVLuJ+MMiw0HngQOVwsD2NM/vCyh8r28YNOx912YQILHXBQFRwmpdvvUI3jtZLUEIkeTGdyNZuQZ91v1y0Iz6kFk2Sij3gyDDjJHUx31GU1bIgnf5ev9zzTuN4HvrmHhIpVpwGGce
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(2906002)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(36756003)(86362001)(6666004)(52116002)(6486002)(478600001)(186003)(9686003)(6506007)(6512007)(1076003)(26005)(2616005)(83380400001)(41300700001)(66556008)(66946007)(66476007)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hwhy30Z5Zve1Qi3DshLQul2s15B32u0jM2mSxRN1hw1VovIQd3DjZRkV0yzw?=
 =?us-ascii?Q?VazToySWNv4u2jLTFmdSrgzEdPq/PrFIVb1qtuz+dm/s9eKcD35dAYhgQo1w?=
 =?us-ascii?Q?bA5zae+F1AE+ayOp0LVfqBH0kWolikTzlf1Zhh3y+n19U6S2IIzg9orcGDsO?=
 =?us-ascii?Q?T7pS7QwuXZYmdnxS/dRQ5lvULRbtGzDGpNYloCvnRu6JO1di/jEIMaVo35a+?=
 =?us-ascii?Q?TiXaP8K1E7ZrpF+UfLjaQx5wMZNJJwo3oVA+icpGAlIuVB++yKj+C8Bgs2TB?=
 =?us-ascii?Q?ojBjikwWGQxkBikvLvM53I36l1knUJfNY3Zau9MhDB5nds8vUt9XZhBi3osf?=
 =?us-ascii?Q?gCx2cWIWqVUxCIjSZELCSOkZqe2aFCslIH/X9PJ99oVVHzSVX+i6DdRnkcWx?=
 =?us-ascii?Q?1wEqz2BPoXvLRGRNXbkY7WRJp62nAv1NBYlkpjqA5nyT39EJmh675mMDrzKy?=
 =?us-ascii?Q?4a66AviPeXMlsvw5cqef9E+FysL9uIjb5BG/8s4xy2Mt17RHfVQlXMY1bzCp?=
 =?us-ascii?Q?RrX7UQEMK/8TO8e4isnpfaXYYWddWbq4vjnmKhaU+qWIgENx5C52rt5rjUuf?=
 =?us-ascii?Q?JBXRVz1yWfs2iF7BzK3KGB3nXA1bPnxBjLpKy4ZZPDOQ190UETgL4xVs4Xpe?=
 =?us-ascii?Q?k9IA/S8UQMls+H29IBQcp3c7zZkQ4rJ7IlyVeTW901g4V3lO2yz3GKPW+fRh?=
 =?us-ascii?Q?ohPu9svhN2anfWh4ymzre5JJeU7rL29Wqcq0VeRmseNfhqg/DWQvb7L2k0Jl?=
 =?us-ascii?Q?zq7vd89VeGtNmCgdeGdzE+3WVPZO3s5aMsADv/8jCumJniqRO2W5E2lWITq9?=
 =?us-ascii?Q?F5jXih8s6JC7z7VOyH9QLu3vuVqham8DkYGE8neSQEK5jksr8MtChjPWfpYJ?=
 =?us-ascii?Q?ql+KzuWJCj57uHg5wn86y9x76OBt+3CGIxv9h5VVXDhBRBmmFwaZwAyAUwBd?=
 =?us-ascii?Q?7pfgTXw6zihXt7qL56IfcJ/NXkuTkm1DPM9hylIWoxceFtb2PPgEHAHvpg7M?=
 =?us-ascii?Q?ZmgNORFLyHl/5HrsGTkVMw2gP6vLyQE8ZqG2Z8UKvRgFquqnz2n9hIjQ+xMG?=
 =?us-ascii?Q?IwmuGm6LEBiczYqPApWa2DjzY5alWQICgmNoIk6I6aB5Bp3VFnaMD8VS2Urb?=
 =?us-ascii?Q?pfNOfxVeKkDcoEgy4XYuatzWiASCPeX5UpzV3gb5LWCMctLtqFz/EUixA8CE?=
 =?us-ascii?Q?W8RNY4nV10QxVLN19eX4ugVaEck5T7mRjXVYFZoJJbwDNkkozpvL6AQDcGLh?=
 =?us-ascii?Q?8PhOUkSE8uJLxoqcg9bLQzDCIP9QmGjwKrXSTd08GBYJFaLJdJa9ccSMcQkM?=
 =?us-ascii?Q?pL9BzqBqDfHuiyxa9cyjl1hM1NRZJbqhIjD+6d3sr5XydH9V7CbRidacvSw7?=
 =?us-ascii?Q?/K3kRAcmDgbAVG3wjJpEcXbfx3KI2xcaspWADrhimcMl4iBfGPAb3F/BDJZI?=
 =?us-ascii?Q?Z+A/PKe51+DF7ZKZfabqPVOpJ259f584i/18oXOK9JmEYAXtf/2uN8incGXi?=
 =?us-ascii?Q?U2DyLjL9HW84EB6mardomxzOSjejs+wJA5HMQO0Eq3KcjAG7cbt9rYWVPoo+?=
 =?us-ascii?Q?V6Uv/vyiVBc36SvZf1DAc3eZSaTJq8437mDGbFSf?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ee1e5f-e303-41d2-e294-08db4c17389f
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 20:44:42.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgscXpLRfcC853ChXa1jNnZGjL1OzoO+PUA6aEkFRoge/Hig64lv8bo3Yklro3HnfyP0OQJQvQh3dHQN/194Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB1974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Timestamp reset is not done in the correct place. It must be done
before enabling buffer. The reason is that interrupt timestamping
is always happening when the chip is on, even if the
corresponding sensor is off. When the sensor restarts, timestamp
is wrong if you don't do a reset first.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Signed-off-by: <inv.git-commit@tdk.com>
Cc: <stable@vger.kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 99576b2c171f..32d7f8364230 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -275,9 +275,14 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(dev);
 
+	mutex_lock(&st->lock);
+	inv_icm42600_timestamp_reset(ts);
+	mutex_unlock(&st->lock);
+
 	return 0;
 }
 
@@ -375,7 +380,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
-	struct inv_icm42600_timestamp *ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
@@ -385,11 +389,9 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (indio_dev == st->indio_gyro) {
 		sensor = INV_ICM42600_SENSOR_GYRO;
 		watermark = &st->fifo.watermark.gyro;
-		ts = iio_priv(st->indio_gyro);
 	} else if (indio_dev == st->indio_accel) {
 		sensor = INV_ICM42600_SENSOR_ACCEL;
 		watermark = &st->fifo.watermark.accel;
-		ts = iio_priv(st->indio_accel);
 	} else {
 		return -EINVAL;
 	}
@@ -417,8 +419,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!st->fifo.on)
 		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
 
-	inv_icm42600_timestamp_reset(ts);
-
 out_unlock:
 	mutex_unlock(&st->lock);
 
-- 
2.34.1

