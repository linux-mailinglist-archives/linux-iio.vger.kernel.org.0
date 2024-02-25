Return-Path: <linux-iio+bounces-3065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BD862B5F
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 17:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10647281CDC
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99B175B1;
	Sun, 25 Feb 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="fIhDC3Rw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD90168DE
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876876; cv=fail; b=PnbDR4BsYevXAVLiYLD67KhqnEZNYYCKZ8JlcFWzVyQ50wN1eFhssSPp/DE15QFbhYRxPsJRR8osKyAD1piKKxhAtj9TCfp5CX2l7Is3nyizIu9StC28aO88FGrFj8PrWusTAaPGOiEdteqPomybOqjqNKkc92MAX6etq58hUAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876876; c=relaxed/simple;
	bh=/pxRqpfwrd6XdDoXdT3gRK59jXeynn0nEjHOEtL6p9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPHS0BFWeKWz+mIdmY0zZG4RNog7QLhY8PKrCCSdZYU21v5lEX8BaB0o3F8q5O7JzrMmuWCpWS2cK6r8KYY1HEVg2mSFSj6pZnCgc3cj1syXWzk1tK4l7SIJ1zTdE+DxeRs/Snwcjc9k/DFPKeJOHnx0xIZHirfMeLbqu7Mj8f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=fIhDC3Rw; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41PFo2ck018247;
	Sun, 25 Feb 2024 16:01:00 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wf9tjrf3v-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 16:00:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENJysjdVXOhAO/Pe1xgT1ZDxHG45Y/DxSVGLbJq/D5yr7t/PZxeyrMOYJZqZrkYYZ1d6w/shj6YugqcGXazioats9Oz6u0J8yaqMxi00/8k8FazBcjeL5M/0EPnN2UM81bTMYjhnwEEcC5Ls5pHI0eGkKnvtf9f7VvTs79pkqv406odV1IUSxwvxS/uOwYK4bGt5/0n7pnMqAOXaH55mK5Ff3Rgujz7isTJi8tVhm0VdY9hP3dA8G+tou7sc7W9xLOudXs5S3EyCljZNjjlOKZ0EaRxj+wZ1S2+YbrtAjSXHb4qlmk0WGOGbNcQhY0+V7QGC0bsNDoMe0Pagmok2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuHFgPgENuPIPUANRte+Cpd+uIzsQCz0Qx/9LoNTWL4=;
 b=I3KQS4dG7JyryKlxhoy/T6pKjjQLtO9zg0SlrZsjEbSIAWDbySZOsOxgJWW0piZDR+xTXOHf/V0gB7Ft6gCGnJFflekJ6BSZ5rXYgTWoJI1Ko4OwFok7gHNry919JDJx/DNzNDnwxDXSGYT+IW8FnGyZH/ENJwZhsYBdQ8GKuRSDy1TtQ/2DQ6cxYzXacm1Jm74WD0bbINNOVK3Iz8LV6ttbKZSnSW2b1S7ABB64ybw4dzVYSWo759oDUW+7fnQAoAze8vjC+skXyEnoFxJuA0qiXguYQvOaahKhvSaelbCBieTMdIy0NdZ0/FkQB5OVAAk4P1ieI4eHz4Q0RbWxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuHFgPgENuPIPUANRte+Cpd+uIzsQCz0Qx/9LoNTWL4=;
 b=fIhDC3RwVftzFfkdGfiWEqPSLBA0FH8rRAxlrTAQ1F84dWynrRmH2l0DmsXsm1V4tIkyeBjE0djnLWO46zlQrzaznCGtTTYtGamWSBziPGb4a89ELSL0eUBeTzbnGMIRouWneubTHhzLuiJUtYtIoJCWqKvSvh9ur9mN8d+cxRjXnkpP1RSOym9BT6R4d1bND9g/LjEYLYni4VbI3BlVYuAz+FATUE+TNiIjf/8YeUpIHAjLOrBXvUKpp31Xg5IWxfN5PS5E/2lBKh5Zp4CE000vEZOnn5NUKo9zg7D0Y3jtNFAY+TPsRZfGSNUVfrCqk2AKBK/L1/enMciU6p3xYg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYTP286MB3462.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Sun, 25 Feb
 2024 16:00:55 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7316.018; Sun, 25 Feb 2024
 16:00:55 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode
Date: Sun, 25 Feb 2024 16:00:27 +0000
Message-Id: <20240225160027.200092-5-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225160027.200092-1-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYTP286MB3462:EE_
X-MS-Office365-Filtering-Correlation-Id: 863062a4-2d22-49f4-ac76-08dc361af309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lR+bOcTAAAnndV3JcISGh66Qrg3T7aUJPE8+B9AbJpJRN8FdY/euylKG6VL0AXr1kMVYeVXIiy5IUkdgzN6Cnbi1C5QQvx0j9QFN109Prb+bxTLMom2nrNeFNt342dP0iyyoi9DwgaOuTkqawDUG4SY3YHPoFY1DBUgHjs436EcT2MNSi8/ALH0eW7d8tLf54Eggm5V7ZSr7XJ/8AOv1nvgvZ9AjXfkk+40t0JYNGxGdeAEAt8bFgFs9ikr8A0P6/Y7ADowTr7Yy5ngocw34C+sD0InvutWydnM8P1elk3RM6Et5C9+b6t36r9PUexCDLfNQbu6reTwEUkPOB/ZxjEupjtbtIRIuJ1rc3tp0Na/3BxiyGRY1NcQApu+4HNzWt2JJZfGGdRYZMl/erdPe918EQM9BwkzU1ICjB3bUNcOVZCg8MAPzaZI4FN92XmVic2Sip0gXoV8UotiIKHXVtI0+GSHiOcgWcHY0q8SlmaiFElYZhbNStE9YfARsj0BOBAfuuHX39mesBhcTRDqmmgJNKHkQxU3scfr1SSsQcNsRCu0plqLyeye49MZwIS9zUvzqwB5XvbeoSmjbja+RlNg2Vk6EPXFcSyZbI+SBhNIp0qYFgF+8d0d66i8fZe9/yFKlE9ntM/oplw9Ad6/CDg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ShGDb01jrvLggmgMRiqxnQfubMn8vwdTeOCNcHRwE2L18+4o9uhwjQVTUl11?=
 =?us-ascii?Q?lD9UpVLmiYUO0n/eMGm5xV5UIJ6jamgpF/fDoFgqJw/BXalqh3sk6S10zykL?=
 =?us-ascii?Q?c3HSpVC7qDljQmuJ+Jm94RvYSoehUI/GdCV9ovAAvpvCNZ06UQ5fTppFJnKP?=
 =?us-ascii?Q?2Xhh0cN/4OfI6sZfi0eD8mCgo4AZH4o6gDlS1aZsBhcr2Zjs5hL9KGeLpI+g?=
 =?us-ascii?Q?Kpus7q3KCZTRZA84X/g9os6e3FY/OBdBkQ0oJeftXpoOKvOyfU8+19mDEslP?=
 =?us-ascii?Q?kLdA5tywE8zE8wi2NozA4gybCDB3SFJ3sfrnX8nIZYc/TMGquJVgsE1U9PFJ?=
 =?us-ascii?Q?x9ef9VFx+pX9vdwQdMueTScyX0Kcspka1R86sJv+1ZSj+XeieavhsJqAJtj9?=
 =?us-ascii?Q?yWcp1NFh8ggPC5CihoOZ8PO0y6xgpvdeGWXKg5c8DCAPaPIYuRXRPdxTC7Ob?=
 =?us-ascii?Q?Q32UkE06eC/xqpjRQAbRIz/QgjBGDd8SA+r5rZGREm2Q4hhgWU/sDBOh9MrA?=
 =?us-ascii?Q?6H7CqcmtYdJ/bv0H5dsvIUIwcpW3jCMVeeGqZMA5kOWEidPcWYar3JBTmRoL?=
 =?us-ascii?Q?6QwYapamDAk6emLXZV30ZZNALTqGGebZyMGGdXg//4q5u9uGyB4mtXAmhq9C?=
 =?us-ascii?Q?pJh+YiTvrVlR3SVWaFPQp8Ox90bRFRPigEJXzYORnNE4ywFxt851ZLGEkOl+?=
 =?us-ascii?Q?xRGzcUkuL8qwIx61/3vJgHV3LBTfxr+k+XLq3olMbz8wyKqiu3erQQhdyJHQ?=
 =?us-ascii?Q?9J5JxYP8wK29TiDWmQLDM8PQa+b9sOdNropFERjOtvrVtKyX8g31+ihPsuYJ?=
 =?us-ascii?Q?qhUQf77RkQWOSzdF0iH2Mzli9EOJwv+0t/JAluQGG7PfN2s0vdFZ66L9f10y?=
 =?us-ascii?Q?NmY6VQRu0tcWvirzVhXDIzTF70s45UATF/fmYrc1IlsaU4y1yYb1wS94bSX8?=
 =?us-ascii?Q?WscDgJ8dcgV9PLpX3NJOztIkctdpzoYs2bJAHz6Oox1Gq3jACaaogsO6MNcL?=
 =?us-ascii?Q?cv6vpQ9sn0n1f2rKkWg3oG3XN8fGjRtHNKCfbXV43nfSxdqKR/HwYw7+3VPC?=
 =?us-ascii?Q?VX3lgXYAIlt7P39E7Ct5tCMfr2rimN7nBwozP74Fd03I46g6TlH6Cbnj0w97?=
 =?us-ascii?Q?12qMPaS5EcY1Jr90ebz0ul/AbDICHJiVL4dvjrR3GJE32p6gaCd6Vx8m5Rht?=
 =?us-ascii?Q?llLh8IfKFhA/Crnuhmzt2T6xs/tS4VMAjLkOIGMQkDImPoOBCYypHTUIhWDx?=
 =?us-ascii?Q?VuC4g0XB6aaoAS/att1YbgNzh4y99U3LZ9qfvMrd49ei+4iHE3bqx7X+q+hx?=
 =?us-ascii?Q?Ts8xgM1/9Br9/QgtxA6okMu8ELCPv6xo8O/KBSK9mrQJEDwKq3dL8rQTsJWc?=
 =?us-ascii?Q?JPSQLhrkiW7NP3rEFDacJvSk5Q7xifcVGo2Y6Plx9QIjw6uXf/mJeN9plrGA?=
 =?us-ascii?Q?GJy1lTqnRpNOM1aR0Paxo1Uj1tEyJPsYZvP0K4DBV9KoLCRAzBKMT/2iR34p?=
 =?us-ascii?Q?PJns5IRiAZExi1DHnFMTosQh3xnypFYEKMEeaddpTGTg9deyqe9dNzIEsvND?=
 =?us-ascii?Q?ufxPAZ2QgRghtpTa3k2hc7pNfDsR1TQDwVzTo5Ng?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863062a4-2d22-49f4-ac76-08dc361af309
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 16:00:55.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG4ofCWWOaT2haK6caxOUD+hg9NNU2hPaYxejRxAhh0tE6xulp9RZi3kEEI+Smdu7/u7n1jDVyqagdvQIRVJKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3462
X-Proofpoint-GUID: 0-Weksogfa_jTm9hW0HH6_66QLL-hga3
X-Proofpoint-ORIG-GUID: 0-Weksogfa_jTm9hW0HH6_66QLL-hga3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_18,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402250127

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add wakeup from suspend for WoM when enabled and put accel in
low-power mode when suspended. Requires rewriting pwr_mgmt_1
register handling and factorize out accel LPF settings.
Use a low-power rate similar to the chip sampling rate but always
lower for a best match of the sampling rate while saving power.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 160 ++++++++++++++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  14 ++
 2 files changed, 141 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index d2544c758815..db02dd50c0bc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -287,7 +287,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 };
 
 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
-					int clock, int temp_dis)
+					bool cycle, int clock, int temp_dis)
 {
 	u8 val;
 
@@ -301,6 +301,8 @@ static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep
 		val |= INV_MPU6050_BIT_TEMP_DIS;
 	if (sleep)
 		val |= INV_MPU6050_BIT_SLEEP;
+	if (cycle)
+		val |= INV_MPU6050_BIT_CYCLE;
 
 	dev_dbg(regmap_get_device(st->map), "pwr_mgmt_1: 0x%x\n", val);
 	return regmap_write(st->map, st->reg->pwr_mgmt_1, val);
@@ -316,7 +318,7 @@ static int inv_mpu6050_clock_switch(struct inv_mpu6050_state *st,
 	case INV_MPU6000:
 	case INV_MPU9150:
 		/* old chips: switch clock manually */
-		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, clock, -1);
+		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, false, clock, -1);
 		if (ret)
 			return ret;
 		st->chip_config.clk = clock;
@@ -358,7 +360,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 
 	/* turn on/off temperature sensor */
 	if (mask & INV_MPU6050_SENSOR_TEMP) {
-		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, -1, !en);
+		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, !en);
 		if (ret)
 			return ret;
 		st->chip_config.temp_en = en;
@@ -465,7 +467,7 @@ static int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st,
 {
 	int result;
 
-	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, -1, -1);
+	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, false, -1, -1);
 	if (result)
 		return result;
 
@@ -495,22 +497,9 @@ static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
 	return regmap_write(st->map, st->reg->gyro_config, data);
 }
 
-/*
- *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
- *
- *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
- *  MPU6500 and above have a dedicated register for accelerometer
- */
-static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
-				    enum inv_mpu6050_filter_e val)
+static int inv_mpu6050_set_accel_lpf_regs(struct inv_mpu6050_state *st,
+					  enum inv_mpu6050_filter_e val)
 {
-	int result;
-
-	result = regmap_write(st->map, st->reg->lpf, val);
-	if (result)
-		return result;
-
-	/* set accel lpf */
 	switch (st->chip_type) {
 	case INV_MPU6050:
 	case INV_MPU6000:
@@ -529,6 +518,25 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
 	return regmap_write(st->map, st->reg->accel_lpf, val);
 }
 
+/*
+ *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
+ *
+ *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
+ *  MPU6500 and above have a dedicated register for accelerometer
+ */
+static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
+				    enum inv_mpu6050_filter_e val)
+{
+	int result;
+
+	result = regmap_write(st->map, st->reg->lpf, val);
+	if (result)
+		return result;
+
+	/* set accel lpf */
+	return inv_mpu6050_set_accel_lpf_regs(st, val);
+}
+
 /*
  *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
  *
@@ -921,6 +929,69 @@ static int inv_mpu6050_set_wom_int(struct inv_mpu6050_state *st, bool on)
 				  INV_MPU6500_BIT_WOM_INT_EN, val);
 }
 
+static int inv_mpu6050_set_wom_odr(struct inv_mpu6050_state *st, unsigned int rate)
+{
+	static const unsigned int hz[] = {500, 250, 125, 62, 31, 16, 8, 4};
+	static const unsigned int d[] = {
+		INV_MPU6050_LPOSC_500HZ, INV_MPU6050_LPOSC_250HZ,
+		INV_MPU6050_LPOSC_125HZ, INV_MPU6050_LPOSC_62HZ,
+		INV_MPU6050_LPOSC_31HZ, INV_MPU6050_LPOSC_16HZ,
+		INV_MPU6050_LPOSC_8HZ, INV_MPU6050_LPOSC_4HZ,
+	};
+	unsigned int data, i;
+
+	switch (st->chip_type) {
+	case INV_ICM20609:
+	case INV_ICM20689:
+	case INV_ICM20600:
+	case INV_ICM20602:
+	case INV_ICM20690:
+		/* nothing to do */
+		return 0;
+	default:
+		break;
+	}
+
+	data = INV_MPU6050_LPOSC_4HZ;
+	for (i = 0; i < ARRAY_SIZE(hz); ++i) {
+		if (rate >= hz[i]) {
+			data = d[i];
+			break;
+		}
+	}
+
+	dev_dbg(regmap_get_device(st->map), "lp_odr: 0x%x\n", data);
+	return regmap_write(st->map, INV_MPU6500_REG_LP_ODR, data);
+}
+
+static int inv_mpu6050_set_wom_lp(struct inv_mpu6050_state *st, bool on)
+{
+	int result;
+
+	if (on) {
+		/* set WoM low power ODR */
+		result = inv_mpu6050_set_wom_odr(st,
+				INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider));
+		if (result)
+			return result;
+		/* disable accel low pass filter */
+		result = inv_mpu6050_set_accel_lpf_regs(st, INV_MPU6050_FILTER_NOLPF);
+		if (result)
+			return result;
+		/* set cycle mode */
+		result = inv_mpu6050_pwr_mgmt_1_write(st, false, true, -1, -1);
+	} else {
+		/* disable cycle mode */
+		result = inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, -1);
+		if (result)
+			return result;
+		/* restore accel low pass filter */
+		result = inv_mpu6050_set_accel_lpf_regs(st, st->chip_config.lpf);
+	}
+
+	return result;
+}
+
 static int inv_mpu6050_set_wom_threshold(struct inv_mpu6050_state *st, unsigned int value)
 {
 	struct device *pdev = regmap_get_device(st->map);
@@ -1786,6 +1857,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 			irq_type);
 		return -EINVAL;
 	}
+	device_set_wakeup_capable(dev, true);
 
 	st->vdd_supply = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(st->vdd_supply))
@@ -1951,16 +2023,27 @@ static int inv_mpu_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	bool wakeup;
 	int result;
 
 	mutex_lock(&st->lock);
-	result = inv_mpu_core_enable_regulator_vddio(st);
-	if (result)
-		goto out_unlock;
 
-	result = inv_mpu6050_set_power_itg(st, true);
-	if (result)
-		goto out_unlock;
+	wakeup = device_may_wakeup(dev) && st->chip_config.wom_en;
+
+	if (wakeup) {
+		enable_irq(st->irq);
+		disable_irq_wake(st->irq);
+		result = inv_mpu6050_set_wom_lp(st, false);
+		if (result)
+			goto out_unlock;
+	} else {
+		result = inv_mpu_core_enable_regulator_vddio(st);
+		if (result)
+			goto out_unlock;
+		result = inv_mpu6050_set_power_itg(st, true);
+		if (result)
+			goto out_unlock;
+	}
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -1970,7 +2053,7 @@ static int inv_mpu_resume(struct device *dev)
 	if (result)
 		goto out_unlock;
 
-	if (st->chip_config.wom_en) {
+	if (st->chip_config.wom_en && !wakeup) {
 		result = inv_mpu6050_set_wom_int(st, true);
 		if (result)
 			goto out_unlock;
@@ -1989,6 +2072,7 @@ static int inv_mpu_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	bool wakeup;
 	int result;
 
 	mutex_lock(&st->lock);
@@ -2005,13 +2089,15 @@ static int inv_mpu_suspend(struct device *dev)
 			goto out_unlock;
 	}
 
-	if (st->chip_config.wom_en) {
+	wakeup = device_may_wakeup(dev) && st->chip_config.wom_en;
+
+	if (st->chip_config.wom_en && !wakeup) {
 		result = inv_mpu6050_set_wom_int(st, false);
 		if (result)
 			goto out_unlock;
 	}
 
-	if (st->chip_config.accl_en)
+	if (st->chip_config.accl_en && !wakeup)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
 	if (st->chip_config.gyro_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_GYRO;
@@ -2019,17 +2105,25 @@ static int inv_mpu_suspend(struct device *dev)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
 	if (st->chip_config.magn_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
-	if (st->chip_config.wom_en)
+	if (st->chip_config.wom_en && !wakeup)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_WOM;
 	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
 	if (result)
 		goto out_unlock;
 
-	result = inv_mpu6050_set_power_itg(st, false);
-	if (result)
-		goto out_unlock;
+	if (wakeup) {
+		result = inv_mpu6050_set_wom_lp(st, true);
+		if (result)
+			goto out_unlock;
+		enable_irq_wake(st->irq);
+		disable_irq(st->irq);
+	} else {
+		result = inv_mpu6050_set_power_itg(st, false);
+		if (result)
+			goto out_unlock;
+		inv_mpu_core_disable_regulator_vddio(st);
+	}
 
-	inv_mpu_core_disable_regulator_vddio(st);
 out_unlock:
 	mutex_unlock(&st->lock);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 9be67cebbd49..751e2b72aebc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -302,6 +302,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
 #define INV_MPU6050_BIT_H_RESET             0x80
 #define INV_MPU6050_BIT_SLEEP               0x40
+#define INV_MPU6050_BIT_CYCLE               0x20
 #define INV_MPU6050_BIT_TEMP_DIS            0x08
 #define INV_MPU6050_BIT_CLK_MASK            0x7
 
@@ -333,6 +334,7 @@ struct inv_mpu6050_state {
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
+#define INV_MPU6500_REG_LP_ODR              0x1E
 #define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
 #define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
 #define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
@@ -449,6 +451,18 @@ enum inv_mpu6050_filter_e {
 	NUM_MPU6050_FILTER
 };
 
+enum inv_mpu6050_lposc_e {
+	INV_MPU6050_LPOSC_4HZ = 4,
+	INV_MPU6050_LPOSC_8HZ,
+	INV_MPU6050_LPOSC_16HZ,
+	INV_MPU6050_LPOSC_31HZ,
+	INV_MPU6050_LPOSC_62HZ,
+	INV_MPU6050_LPOSC_125HZ,
+	INV_MPU6050_LPOSC_250HZ,
+	INV_MPU6050_LPOSC_500HZ,
+	NUM_MPU6050_LPOSC,
+};
+
 /* IIO attribute address */
 enum INV_MPU6050_IIO_ATTR_ADDR {
 	ATTR_GYRO_MATRIX,
-- 
2.34.1


