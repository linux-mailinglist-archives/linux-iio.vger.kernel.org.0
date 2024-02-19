Return-Path: <linux-iio+bounces-2783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F197585A7C8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 16:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6501F249E8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04CD3A1CD;
	Mon, 19 Feb 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Z5dFIyp4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BC39ACD;
	Mon, 19 Feb 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357720; cv=fail; b=AkrFnq7SquaqS5sBlD9NczSEJ8IBMKPPwqM2r+EXpXq4+RrNBOgoe28OJJHeJcowXJv8JYxN90799zinW7s6GVus/7knAUacPVdc6xAPUuTdk6V7k027DDetoFCm8Tg/rBfZC1/UuEO7eAjF0CkRyFLnQJZDVzeVnRXA3OvRNRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357720; c=relaxed/simple;
	bh=xOvaHMU3EEmiEoUqIf5WlD1dFnvJ+1zK93fLTaLm1XY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XEIuoj4HAJbhDE9DKtBqlXmEQLdOI3KBgFZ5zRTMUdp1qX44e23bykM89lhBkDfP3VPVZmYxqk/3c0FyXDnolUd/jrqu6h8Qc0irIgEYdNNgQ3KDEZ5AzkMn4AyH+WQFw/kqeWgQWzYvaiYUDlqLnlvP3acKp/Vc8dzKtr5ODFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Z5dFIyp4; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J8xjiS009241;
	Mon, 19 Feb 2024 15:48:23 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wak5y1cem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:48:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3Jj27r4bC0/5R0yURVjG8k/3uw2h/9OqBY674/JtNDFF6+4mzHeBfBmsFU8wOIhTIZ4ZZ5YURrbw/6MtUwPalMMsBUpFvDNtS+T4mSelB2csjI12p5dLMxeojdo3h5jCzj6LIB2Hmco05Kc3foC4y02+HLNZE3PPQWRha1R8PMG4mQNlU2HfSP8ETaxvJHNpyJlhNXmDCh2TAgtSuneEHwMKBBsJTYhbFy3v/ei4mnASyARU2E7lKG2qDWMl+qw2vXBPZQFRWhnyuIAkCGQ52VDw9eG4xD7umaZChf6CUBBjSskB6ERdC4/eY8XDNcmXwPutSASqoeEDuo9GFYlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ77sFh2uIWQG3zG/c4/ECs1j/yuiw8huZMuPsPNvsk=;
 b=edHYlSZQedw5o5+et1GdQot+iMNekl26OCNsiXlUD/0LOxRk8IgnoIxbk5+RQu1h1etcIiKsp/PFDq86vHZO4w85FutHfHtfDjWQY6NKafak9zzbO+9tVSEULufICws48theFyqIYNEADfZGqK+EF1ZBK5uDzLAriE8rDoW1+C3T7DWN3agDzFes4P3FyxWdZpikHCKNdOu/1djQw29N/FOMzPbMhZz6rhrdVieD5VXfcA5ORFySlJkAYsdwRtR2T9hUi68HVdPAsEm3eQYsK/huC/Y2MO2UguYcQdXFeMe/VmBGNPPMdsPQiT5fNW289CBUurESaYBTXSXnl3uCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ77sFh2uIWQG3zG/c4/ECs1j/yuiw8huZMuPsPNvsk=;
 b=Z5dFIyp4diEKtsT/9w2XOhGBvLpnc5qds8+Z98iPmA2TDzM5FQd80dbzfMpF681Ueix8o9k5nvLTgL2C/wAkSt7r5NheOp1nzXqLjBBrD8efqMbG9dxBB8J/AsRO34I4V8RCg/sK9u+n12+F+kFGnqE/y3Zb5M18+iXmKiYjCHrWZWxq3ZJ8davOUOV/7GQr1zttbxXnpmoG6xG/Wfqao/Fna/NgIvmaGqptnPP8Rilt7gLKGoe4IemGJMRpLYxGMex3gFutRgVmt7HDy7bXS8mgjIVCXxPvtc9j/Izbu2CjQ1ts+MB2Uz6bti4O3jymqKym/G7Z8ZX79+LTRKQtww==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB2249.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 15:48:04 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:48:03 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: fix frequency setting when chip is off
Date: Mon, 19 Feb 2024 15:47:41 +0000
Message-Id: <20240219154741.90601-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0031.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::18) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB2249:EE_
X-MS-Office365-Filtering-Correlation-Id: cb125b74-6060-4114-cc69-08dc31622825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	svyrSn+sF7hI257/AJW3liu+9mdcoJNLHDWFVZFfz4yQiFHYH05V7ld/fsTU/hun6e9dRhscZBBoDxkpXKDIm+UjaRUtF5ituN5T5Nz+myf+40soOVlglvGIhwdA9ZCFDDphNa6L5PuoaeTXT1TRGOo5SeSVhozJjq+gD1F2JtUp69PJ23yx0ZLyeNE/2y3eg0/IXbJsgQxwZqQHVtkpzmDxNaRslrSr75ImGQYIMlbzGkpqLkYRMqu3naXNk8vx4P75JUNlp3PsQbO3Zn9mT/0Y4wrygKth1UEmXQSt68fqy5ns1TEvK2+VPiDV7MOo71lT/idzdZUdBpqCXqwYyEBwpqZKj5S3U3jSk3BuVvxifp75GzzVPjQPQ8Tx2bgAX9E5D1POF90bsp/MuyhpQx3QGameIYkY1gP6i0/lfQHPo7wpfAR0M5vsI41KNod9yUwfwyT5MmiVoBhYkR7nkdCPUtr2eBVkj4OhhMlcoO/T49f9N7ajaXIx0+KeYBMgMGoIkwr/0lqpO8ts700RuIPCOZsEml8oXSHmPAmBWWmILM1//wBOPL9H/k7kLTbbq8KEJT4ud94Ibt0hkbuSYU5JrOyk6xErkfDt7iT0nkcEOJ5BLM9cm1qexK4lCtgHyzT2nnpvKoDHcl/B+e0QQA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DnqLys+HuCJHqKtvSXyxTymijW8ajA7fslC4Ow5b4vz3BwGaTbKjgh5c04Rd?=
 =?us-ascii?Q?Bv5Vf+2IxN937mCCgsIWu9AJnpyCaYwvFHOgfT6wecj6cecZ5XgUZ+Uy6AYb?=
 =?us-ascii?Q?vubMi0Z5XaLNqeeWVN69jrUhSYmU6/JeAf0mZmi+rZjQRFhDpE+rPfK+OT5+?=
 =?us-ascii?Q?a8Wacrn73x23iQfB6XNcoEKco0SIvYtiWTFlXg3emvNYzNS+BInLzYQoLriv?=
 =?us-ascii?Q?VZY16ZSCGzSIN3JpuT0gC/amxvD0hIEYyCAk1RVa4Ww80dOagCL/D/PnqNtZ?=
 =?us-ascii?Q?UXaNrj3DtWMroo2klCgpMGSu6fXqpLQcqC550Ch7IRsvSLfsohxSjvJYEMP4?=
 =?us-ascii?Q?urlx8EKEfJz67Vbm2HFNAkjsUJsvuOg6w60LoJ43jY9zTAMz1ommncvkLC+L?=
 =?us-ascii?Q?lhQecFL/L1NWRtYkmxz9kQ2CyT8HY807/WIxes78ka3ikMkm8G7K+i9Hxrui?=
 =?us-ascii?Q?A59Cz0un+GlaVoXZP9gDrjZgIamj6/Ei56yM1RiQ76T+/k6zhrjvH4F26Sy9?=
 =?us-ascii?Q?CAhLJRbFW+mfOU/E0hu3yw0m1sbg6t4IUwrM1O5eech/vFfajtaoNyNXxGxQ?=
 =?us-ascii?Q?CuMRZ7yBLykG7M81KailvekmaRCIklvbsDBniKTxMk+U+8/z3BKnQUxxMA5C?=
 =?us-ascii?Q?RxXSRmMgTyIzR7b+eeOSvyD2PGDyB/CIGobrLjzDK0DpF/mqXvijcQl7gK0n?=
 =?us-ascii?Q?yO3pvwXU2v/u4lbRvIPNCETzuqsaXv7UpDe1S4r5SsgIhjJt4G+rYBSRgDXi?=
 =?us-ascii?Q?8gZ+z85LGVe2I3oV9KSvDvb0kA8b3UcCCjKB7a76zmxeTTT6bb099PuWWntB?=
 =?us-ascii?Q?K4jifLhs/XTn733Ur/2t+FGvo5hwFJex7ZKJXTsLwiKVrv6cFWp8Ev8e9VgB?=
 =?us-ascii?Q?8O8l/L8CR5fKybo2n/E2O8uSyPn0eD/EnDNtEfTcRDp3+SgBatRBd8ayqndH?=
 =?us-ascii?Q?3R8Cuchboe/rUh9hEHMJ751/vk+fAFw1L5BuAoMGiHu3t3YcIOwksw/PCF9W?=
 =?us-ascii?Q?wM0BLTS/x0lql8nNQh4SsfQw0RO+6pLq4aGn1EUsVihV+FjIpuAU6g2cn9zP?=
 =?us-ascii?Q?lvRrD6bBK+zVxETYB2ltgEgehoRs/0uXuZiQklT6S+s1Qgetg9Sma3kgxjro?=
 =?us-ascii?Q?26Ukr17TIXLcsx+qBAk8hhMQwshRPWrAugxQnli0/r2oVI26yojOnVDdbHVB?=
 =?us-ascii?Q?kmeApmYZ2GSXOJd02+SC9m79V3Hz19y7Ut8c2qXANrRK9cmkqbyNd1adlhCA?=
 =?us-ascii?Q?Tv7/jpDzpgFQ5TaiCQ8SUZJTOPY31AFryFL46GMqfb9dhbtCpgWGzGaaOqoG?=
 =?us-ascii?Q?gjE4rmfbxBQsLjNJB9iQ3kdh/H59wFcyE1ABcojsiEmeTwBhu7hCqEk/0S72?=
 =?us-ascii?Q?z6NGe4bQIlRp07Zq9GYTdrNTWxE6BQXMa4KamRkarA+6WLvmIy5LkHhDKGP/?=
 =?us-ascii?Q?51ZIvftfn1x4Zy2g2RZgeYFeoIQu88NcaIuDiuVRg5kq1kxJ0zS6QkyrEB3M?=
 =?us-ascii?Q?2tGWbfgKAPedKiF9HVe9gBh+mqjbttpO8e1a9kMHYLRTitR6A9SnevW5WkBG?=
 =?us-ascii?Q?EeHCL4mQtFhnn8U6uBd4GR7cbMJ9CKvod6iauUTA?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb125b74-6060-4114-cc69-08dc31622825
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:48:03.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJLTaKzG2KWcZN0jIG/kHZxzF5COU42J+11iKWXhtexEmh06y2ZMtpl086PnTfoGHSv1/Vyrp8DnDeUEqe+XGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2249
X-Proofpoint-ORIG-GUID: b1jV_okARPbp-zv8t6ln-1xc5VTKCTiy
X-Proofpoint-GUID: b1jV_okARPbp-zv8t6ln-1xc5VTKCTiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_11,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402190117

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Track correctly FIFO state and apply ODR change before starting
the chip. Without the fix, you cannot change ODR more than 1 time
when data buffering is off.

Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
V2: add missing stable tag

 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 676704f9151f..e6e6e94452a3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -111,6 +111,7 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	if (enable) {
 		/* reset timestamping */
 		inv_sensors_timestamp_reset(&st->timestamp);
+		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
@@ -184,6 +185,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			goto error_power_off;
 	} else {
+		st->chip_config.gyro_fifo_enable = 0;
+		st->chip_config.accl_fifo_enable = 0;
+		st->chip_config.temp_fifo_enable = 0;
+		st->chip_config.magn_fifo_enable = 0;
 		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
 			goto error_power_off;
--
2.34.1


