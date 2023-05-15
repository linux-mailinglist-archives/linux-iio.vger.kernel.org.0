Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55904702AF2
	for <lists+linux-iio@lfdr.de>; Mon, 15 May 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEOK4O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 May 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbjEOK4N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2023 06:56:13 -0400
X-Greylist: delayed 2902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 03:56:04 PDT
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33281990
        for <linux-iio@vger.kernel.org>; Mon, 15 May 2023 03:56:04 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F8vRHx014467;
        Mon, 15 May 2023 10:07:16 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qj3wg13et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 10:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoYm5I+QOqMYDSX/KNrY6W3QpR1LxueEUax0Bxl891HtlszdP1WDPDp6fcdSesuDTrj2jSAhcDe/3DkS4gfDdpyefkXKJ9tPFwzB17FdRZq9nLgmLrzG62YZfe8jyQpOdBiF5XY51yHcQptUfB9raPC6ujSbXed+jandvVBsqbTPCsu0Xd/DPBDUgLFKixal9Lz/57w4m9cxOAi8xBo5qUoqhkZrXJenXreFVBzDBm85Px0g2MbrUUCbvuFOv7PG2WZ8Qy85E/LfHugAotuLfG5h4DbiqwSdATgEd3a1a0+WPllHgdCdZX7rzDyu1Yf6CG8MaS/BZ0PAmG21R6dGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9QVHNYedKQK1WppVs4qT+yQvGSI11cCJDH19CnQ5kI=;
 b=b1nH4040GpXmTxrdj4yVo0geXUXkNMEnZh3jwuqEOUdhUF0QbZ0Y4fSNJrveg2yxkM6QZFlsB2/oc82lbZdQGrFNqiCIPTnFcAYVqQtvGq82LYGAD6FYR0bZVeNe4yBYut7JfgXta5UbJAZ6OIu/2elO22gecHk8p6JWo9RE1e6rZFvcFsON4bknHXhPwbAkpVt0R6LMWIQ+eIDRARB2Wa0IaJS4OWq1MmMVJwkpDVOZZO3z5byWT2UufQrC2H9VLuKJeL0bhIry5JEJUtS5v/K3Jqgb+9fDsHLofla9gWq9E8ZyM76fgGH0gHGY8prIQWZ0gVRnUXpVgMxJGxgQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9QVHNYedKQK1WppVs4qT+yQvGSI11cCJDH19CnQ5kI=;
 b=lqJSXxwxzTTcV01wBx1+7t4nSS1c979WL87L2n/w7C9rthFCiklbDOsL/2hEubHsigL9oZ0EicAj1baKadVgVL/+QstA0xXn+vUJxvkVSsjHM5K7B1T4RPZaSqZsvDUpX2slWBE6MYqQPVA2ZYPei6zjcbY2HUsWA8YgFhr/Q0T3BlBNkqu7nG5W4NqpyGZ7JgJBg45BqpQFZ5XeS8Y1OAMlM+wMpOUm6PDUkg5OZWij1R6w6d9Buwtm3POfk2PPHMpkY3wXL+eY4vY/UfRJdjBlJC1/HcP6iwMDass4oxBc4F7y72FDMpWBSDcXuOipIv7dJ2nfhkJFevwi8kAuIw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2660.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:07:11 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72e9:c955:a34c:9647%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:07:09 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2] iio: imu: inv_icm42600: avoid frequent timestamp jitter
Date:   Mon, 15 May 2023 10:06:45 +0000
Message-Id: <20230515100645.61172-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB2660:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b2808a-f552-4188-6dce-08db552c2510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYFzw7JyGiaiRXf3dT++wZ2+zqkV42G/gDOUnUWg0mNueqKhEmYT4vUeAXl32kIHJNl4fqrflrFC7vB4+You4BEPPVTqN+k3D6jV/sraqFEyUu//OSVFlo4x2MU0X1NtBWJ/DTU2Zgf+h9phozw058+YCQanJttjefsIjtZSAl9TZOwHzchP4WbBcDyVpmCv08xDxYJCbyxWKalsSmca9ofDZbLy//HzoDWachvhWU4FD5/2dqtzPNw6CZ5brBq86dwZUjYBQ9zLLmtmG26KqxmTYem90clAoDhxT4NEIA76ll1AuzFA9X+tpsZ2PPhygX5FmaIhfpNWthqLlUzBZ/8CNhQeCqZumwLSKEWdeU+gcEVsSkBXpPmLJyq+MhzmErs2MXNjCmtk2c2EqRnmh45zlZV1Sl+m3jJDqAY3kYFlhvrXC4lrNKmtGYFhw+ciGKvygzivqRhcTn/Q0BZKjb5ph3ytAKqRqp805rv4qU2ka8F+KbDlFqIvOn171DXC0HwvWWPfZ+wp9wOGta5+lr8QqycDemV0oJcXmn49F9TuJXaEIv155dHUZErafDvbY2U15Fp+hPUouwqmARdDJn1lYjPwVV3eQUA6H2jDzfajhFSB3H2ud0TurpwfXRrg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(66556008)(478600001)(4326008)(66476007)(66946007)(6666004)(52116002)(316002)(6486002)(2906002)(8936002)(8676002)(41300700001)(5660300002)(26005)(1076003)(86362001)(38350700002)(38100700002)(2616005)(83380400001)(9686003)(6512007)(186003)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4cQWO7QqgsbUtuW4FvVZELLM1EaMntvug672MjkZWM3dzg34bYpARR0RlU/?=
 =?us-ascii?Q?QmnHrYfPYVsXhGvREfiUEf5z/PN+VMvaMuPuYN/YanBbpU2OjZhn+NRw/1pU?=
 =?us-ascii?Q?1m+glFfEq6puxFlA/aga3Z+g+N92A/t/NRRQ+Kr5bxgPL6Ddk3nAQddO+Kq+?=
 =?us-ascii?Q?fD1CCv/kuQwjNcqPxu01XZQlulIiVYPNDbGkI05PjzK2LN8Pe/WK9R+mflHC?=
 =?us-ascii?Q?1MWgPemcdDHb4lE9K3Hr4veO7/eEGHAgu6XqSC9QB+JJH8JuU0+eHQtycip2?=
 =?us-ascii?Q?ud7lgZweI7C7dFdG28rxJzUV/983T/ZVHMVXxIdD+5CvkbsKkkLX5zjHhKW0?=
 =?us-ascii?Q?4zq9GPE0JSzv8BnFyMnsb/IPZURvpMSTChijxuOpkTDcrCIbn7aRB2BgvU2/?=
 =?us-ascii?Q?28jgDuJOMPslo5EK10bjtVcLkiOaoTUm7RkmGUtqJ3QQnrPh4k9vYhBz6QA4?=
 =?us-ascii?Q?jGyGbYiige5pXCS2836jBNBvDXh+9zUYhhO8LYvNB0+1aRCPX4741szUDmFN?=
 =?us-ascii?Q?LrVVSkR8PeRfNfJlM7Q1QAnlYTi8W49eqhMhe8rpzt9+2bQTy+nPI3rKFxiY?=
 =?us-ascii?Q?EKj/v/4dI9ECYWP5xnQ7wDVmD6k2mGHuhiTZ/CdF37dNbKwrT+rbeTP8mpBD?=
 =?us-ascii?Q?eCx7wD/9yJHhsEwzL2NSFbqEwraManYCO/cFhhIFQvyOpow68SGroikdU/0l?=
 =?us-ascii?Q?K1Vrm3V8UrKRGXkoweEPkKs9p3LS1gZ/QN85CGzfKAsHG42S6TmUizl5lFB8?=
 =?us-ascii?Q?M3sQtzOmSG75TLGzOSZ4w+2ZmX00ZpjWnjI/SP05aUFFHoj0XmbuCxqskMSZ?=
 =?us-ascii?Q?niDsnXz1l6t5PhwKPakvelgpwGWRmsMg7McV+kH/mbLigMDpSdmAqo0D6Atp?=
 =?us-ascii?Q?rMRZaGcbQ/IeIDYL9zEYN44Vtj68NgUY4+/O+vEJxo5wV+rJG20R7K2ZDC13?=
 =?us-ascii?Q?ZcOMa6W4wLAs+MyhmCBdFc1GOnKUC2ZesZ2tOOjq07DBvE55NRSJjokTmuw5?=
 =?us-ascii?Q?uab5FHzE0jBl6WwkRAqn9PW0jh1/fXfrZ5Q2IFRCIL0YmaehUbHmj+NaTC6m?=
 =?us-ascii?Q?11arbnrZhbOZz43b69RPwvgrlLF5hismXJ74omnkmHTXUEtsrIVSZT6tfg3u?=
 =?us-ascii?Q?KjcRyjW9pe9LBgPrdHu00yZPNjj//NsVDnJ2asqLwB5RSHgah3svWwyLu81l?=
 =?us-ascii?Q?RQoqTXYIjYyWPzVGxVUZEivpznQOFepKPijzB6ZR1Tnfp1TqK7RkyTKQRXf9?=
 =?us-ascii?Q?CLchwjf0lAib8i1hGr9VkvfXpa8ptm/6q1UXpCLgt7fx2dzOQlKgr3KoGEix?=
 =?us-ascii?Q?ROU0eYk1cog9KiZ764ypiqlaZzgJ+OMPgz50dKQNsYTwOIpFF6UIdb9qFbRa?=
 =?us-ascii?Q?sXdZYHfp/k9HngvPUtzfiTTtRCQfYAcvBkeds9I4HYCiYgX7UK9p9T+E98+3?=
 =?us-ascii?Q?4Q1LpyeIS22Z4CTOVhvi7myqMT8mvOWOaoafC1knbHE34xvaBfiQV9mmAkHi?=
 =?us-ascii?Q?ePbpeGC1qlpXP6nyb36YyrzeSXsMvjTsUyIlaK5Qg0r0wHT4+XpPBEa4wn4a?=
 =?us-ascii?Q?1Et6/WigTBqs9Xd92MejUEr7mmGugLe5ippuI7Mf?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b2808a-f552-4188-6dce-08db552c2510
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 10:07:09.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYALdaKU3idt+vcF4bcBU5RcQm3Zla86JY7W0FdKeDiQRIlkWtGZOL3CRqpLCnDOPGD4M/MMiEfiaqPQ7B0CkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_06,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

We are currently synchronizing every time the data timestamp with
the IT timestamp, leading to system jitter jamming timestamps.
To fix that and keep it simple, let's just synchronize when the
delta is bigger than the acceptable jitter, and keep
synchronization at the jitter value.

The result is much stable timestamps reflecting better the real
physical value. Example @50Hz delta timestamp,
* before: 20.123ms, 19.721ms, 20.023ms, 20.353ms, 19.821ms, ...
* after: 20.173ms, 20.173ms, 20.173ms, 20.40ms, 20.173ms, ...

Refactorize code and delete the unnecessary handling of multiple
FIFO data.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 49 ++++++++++---------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
index 7f2dc41f807b..af2e59fb7258 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
@@ -93,8 +93,8 @@ static bool inv_validate_period(uint32_t period, uint32_t mult)
 		return false;
 }
 
-static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
-				    uint32_t mult, uint32_t period)
+static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,
+				   uint32_t mult, uint32_t period)
 {
 	uint32_t new_chip_period;
 
@@ -104,10 +104,31 @@ static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
 	/* update chip internal period estimation */
 	new_chip_period = period / mult;
 	inv_update_acc(&ts->chip_period, new_chip_period);
+	ts->period = ts->mult * ts->chip_period.val;
 
 	return true;
 }
 
+static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
+{
+	int64_t delta, jitter;
+	int64_t adjust;
+
+	/* delta time between last sample and last interrupt */
+	delta = ts->it.lo - ts->timestamp;
+
+	/* adjust timestamp while respecting jitter */
+	jitter = ((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JITTER) / 100;
+	if (delta > jitter)
+		adjust = jitter;
+	else if (delta < -jitter)
+		adjust = -jitter;
+	else
+		adjust = 0;
+
+	ts->timestamp += adjust;
+}
+
 void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 				      uint32_t fifo_period, size_t fifo_nb,
 				      size_t sensor_nb, int64_t timestamp)
@@ -116,7 +137,6 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	int64_t delta, interval;
 	const uint32_t fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
 	uint32_t period = ts->period;
-	int32_t m;
 	bool valid = false;
 
 	if (fifo_nb == 0)
@@ -130,10 +150,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	if (it->lo != 0) {
 		/* compute period: delta time divided by number of samples */
 		period = div_s64(delta, fifo_nb);
-		valid = inv_compute_chip_period(ts, fifo_mult, period);
-		/* update sensor period if chip internal period is updated */
-		if (valid)
-			ts->period = ts->mult * ts->chip_period.val;
+		valid = inv_update_chip_period(ts, fifo_mult, period);
 	}
 
 	/* no previous data, compute theoritical value from interrupt */
@@ -145,22 +162,8 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
 	}
 
 	/* if interrupt interval is valid, sync with interrupt timestamp */
-	if (valid) {
-		/* compute measured fifo_period */
-		fifo_period = fifo_mult * ts->chip_period.val;
-		/* delta time between last sample and last interrupt */
-		delta = it->lo - ts->timestamp;
-		/* if there are multiple samples, go back to first one */
-		while (delta >= (fifo_period * 3 / 2))
-			delta -= fifo_period;
-		/* compute maximal adjustment value */
-		m = INV_ICM42600_TIMESTAMP_MAX_PERIOD(ts->period) - ts->period;
-		if (delta > m)
-			delta = m;
-		else if (delta < -m)
-			delta = -m;
-		ts->timestamp += delta;
-	}
+	if (valid)
+		inv_align_timestamp_it(ts);
 }
 
 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,
-- 
2.34.1

