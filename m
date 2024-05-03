Return-Path: <linux-iio+bounces-4778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1A8BA971
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 11:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371B1281F61
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90DD14E2FD;
	Fri,  3 May 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="i/9rM12g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771361367
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727267; cv=fail; b=Mixo8/nqFpvYkfsD5wiuuoDsC1MUpZ5F3jnH1ZZEc3XKOdTyd8KbTPYilDA+yVo5Ozt73RvwvCPwOnsHa1zCcHNsnxNMy0Hu8egNDhgt/a4R8BsF9SzF8vMXhOAXvEHXXiShvmaz9wJ1pTv6kVK17ciFQRe56pbDRcAXSmDooh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727267; c=relaxed/simple;
	bh=UAMOWRaOvmz0GSVxDwC7CuD+zaOBZvwulBUJsAKrCjk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FvVPve46+Ig8apx+y+4HKsiA7jtugBNy/P4eI7ybCmlInZkdYLrF98JgHwxWQDaNIpmJ5dXU27Cs6OEgiPCxIbkMVWChSgIj5rW7d7fhLHliPkq4N/Cucg70JtSLV0d005g9DdENYCptzttsDnKHUceoNSIMBOxFWa53/GGQ9sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=i/9rM12g; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4435PSdg021247;
	Fri, 3 May 2024 09:07:28 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xrtqjujmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 09:07:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGTbdhqSMkiu0GmULu2KNME6mUUveLpLr3Z8A01GJB9NrmxbzEqD1iAHBLzIK6PLL83Y53QzC0VakJavdF5/dbpwhlQlFps3AhhBigHRg24rqmZKtbTClPUG4MwbiawMiGScRID56WAlQAvYfFhWO43dikWxr19brP0g2JAwdf/wxlcGAT6BeyJNeBFeDEYTcP7TLkBIh1+VhQvUbbWrPOMlXbiMyTYtw6LRuA5FNwAVidiChBKmY2eLtHvZ2EKEQSQdM+kKymj+tX8vVYJaQYUxDEaUgXDIcWgRKedK0pFJeXX17MYy7Eqw6eQuo8atfJgoqghvsIrXxzC+xp90Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmkNXs5cT+MQgqWa9vt+5vzAmows13P1k0zqjUGtDeM=;
 b=InzgmButg7CqDcHOwJa6lUmqsqGLz1LimwEBd2sCK0n696f3NtoDmY30hTY47gm++cair380lnutUeWH5/8BQRtc01FEIhn6nuaUigqCTxTvCQGDYEtGjKa6slCFh2jY4gqrLgNnJh7HGjInf6bY0MSPW2J/bg7fjhrDUAAW2pE2XweCyhm9Er1vRGg1wvprMs2DpL1PCRPUGs1+LtMUmwCcTKFPedrHp2q9bUgzQ8dUhwQ90+sTi1TKnpzteXxOu4c2y9Ku+LAy9/QfLOsTH35OThgVmuI/U0MT1bRW7xC41HnXy1S7ySwjnP6jO7JrohXtBm4htF5sNOONtMQRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmkNXs5cT+MQgqWa9vt+5vzAmows13P1k0zqjUGtDeM=;
 b=i/9rM12gaPnfrY5RwMS8g7rN6G7bfEr/smK64OOFjbAshIQ2NLsIe5z/S80z5r4JOCDHeTG7Jr8V6TwZ3WwdpAniMlU05AIOJadQOPP/6p+5AnXlqLgjxP9GXnRPmKM/0GK9NusbLO6zP0MPt3vwhO/gV8TQs3iKvBacOquLytNt0JOyhjvwB5H/bNFZzcjmFzx9geV+WVK6REXxA2Yig90T1fyTm5nhXwP1iHBOK8LUSi+ZC4LV2V4CAbrbEWA8ZWEMQiSfF/jj90+xtRn3t4sOKfRRyUUMHW+827XRMfP56KcYYaQ1pFpnVoMuVm7+A4dMEFMwlRJQbTfqkJN+SA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1567.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Fri, 3 May
 2024 09:07:21 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 09:07:20 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_icm42600: fix timestamp patch integration
Date: Fri,  3 May 2024 09:07:00 +0000
Message-Id: <20240503090700.235707-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1567:EE_
X-MS-Office365-Filtering-Correlation-Id: e86e92f4-c05d-499f-9aae-08dc6b507007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|3613699003|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fAmOx5ca26BAbvETQpjp9dTUp/1HrZnZ7Ms7c2FRYQPmbRzSEC+Ajmn8SSnq?=
 =?us-ascii?Q?4n+0OLZxr6QGnLn8JCxNnqAoW0bjWMCX7yE2u4nWDyl28zaBrKi9IawLMJH6?=
 =?us-ascii?Q?vq12fPFSxkdNfVu2DI/N/WnX/21+oS13sr7+jY/BHrNILtxkL+uSnPwm0AEg?=
 =?us-ascii?Q?jBBob0zhkNFi8timeyn0GD7hKxJFRT0i51Ioobhcu6NosbBWYHkbDG9ZfJhu?=
 =?us-ascii?Q?Pj5JksUWUaMf5O5txborRaDjXL8DC5aRYC1WwAqfqnTGp6BvQwgQYv4/n0Ow?=
 =?us-ascii?Q?lhMyNQvmbQjFAUP/zyiIWfRkxrO+gjegcWxnzeF1LqDvjfndfpBNxuhkJDQg?=
 =?us-ascii?Q?JYykgsYJY++eZoZPPAewzDuyP44LPGXv6hFKbP0OLc+I54zQdt22KO8vgxEo?=
 =?us-ascii?Q?ldX95+zItYlhGM45c8jLM2IYE/VsPpPQJFpVwTULUW9KfZtqt8jdp3GOfa0f?=
 =?us-ascii?Q?tm/MuSehJUgN0WdCDWJqTrSjKirVYvsllMDrTTC32Q6ZkipwegpK39wH36QH?=
 =?us-ascii?Q?40tkM+3oQrPppv8RSt3tupERZMzeY1Xa5wO5wRjqD5vFwevFM8crqCWCL/Qo?=
 =?us-ascii?Q?fl5exChNBYFLYBlMjyS/qOpsQwAVkOrBRmvRAdu7231vei+lxMANBdPktOQZ?=
 =?us-ascii?Q?mW2hnHSWqZ5ylxkUZupWJXuE3jDRTUckWJZj5GZ6zc8/FPontJo8pXitMCXc?=
 =?us-ascii?Q?JWZbLH6fuHnrwvzcqPPCrbogg5gBLUNnqaYHqFmRcnDXNQz6IMdxIcxtIs8l?=
 =?us-ascii?Q?Faba5eoSaCgPhuECsgiSf0LmJIk9dWLbtZ1LzdkEzhvvbUDSZsKW/LzNIY8o?=
 =?us-ascii?Q?8pnPvkPOUvXo0XpneI3otGe7gMVePVNyY29yUUa2TWNHtl37ui9ra+ebzRwg?=
 =?us-ascii?Q?Q68X63CzSNWOjc5VQbudCCGjuPnl2eP/tF0WMuchf0g0dgI/zw6cU2UvLxaL?=
 =?us-ascii?Q?8yhdDTQJLx6N5rCKky2wjsOWYNqfeTwz/NM2SqGg3roRrm9jkT6m6DOD4+VT?=
 =?us-ascii?Q?T7z3yCUAU1zdXABaz/y9s+Vwm9ys5cOcentY+5NDivKZiUjQNKhCPb+seWCZ?=
 =?us-ascii?Q?Y/LvsPW1RHPBKSPXpBKIJAW6zpCbIglmhz99efea59u970GS0tJpOHpxrnrG?=
 =?us-ascii?Q?3qcfx4h5ONXnW++QOA0W97FMB0ttSWHMvJMjFXwDdVdlq4b0+NXHlPL3o9Y8?=
 =?us-ascii?Q?+qKKonVUWgxRzxgrDMssm/No6F2cHw3deV0b2Fo8AB/84XkuzNFfqtJKnoh6?=
 =?us-ascii?Q?o2CdE8zJIjz7f36RYc6LZAfH6gPb5koxtKet6pcG77aBYJ95q6GyAES+Dl4+?=
 =?us-ascii?Q?SB9HQBZRW8UyzNZVm8F1Pg9rp/PUZt9WqJcWblvye0PC4twFCsypMTBe0EZ1?=
 =?us-ascii?Q?KbTQXEQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rcxceqI6TVssq1tJ/OI9y8+I7lFPiHzw8NTJg3CBCD4sY2CjSj2eD4Ch/Vu6?=
 =?us-ascii?Q?1k6jMF5Qv4/OTvtXVvxCctGAAZAanQEu/LJe9NJz1/gX785PWXk+buZYPYHu?=
 =?us-ascii?Q?Ca6xl45a1Ai+LoIWh6A/9OhaFwNbdVjXYCrepeVbZZnpXcG6ngMIqxqP99Kr?=
 =?us-ascii?Q?PDa18Nk5QU4wmnLMxanuuwi622O1S4+xW5NMOrc1whSO4QikEUVgxbY5OFuu?=
 =?us-ascii?Q?qjl58lavyCjSTHyopKgg2T2d1tircq2wjXN2KFGyMOL0ttvo24HIRn5f4XRs?=
 =?us-ascii?Q?w0weI5sI4hc59STyF2Qo8CU8IPlpaTJLHD8rcYQw15hvT17rsj/xGA6TATA5?=
 =?us-ascii?Q?vitWHrWHcmzlOa5k5oXORar3wmGQIcju7AVt5crOCJLQ+HMoilcuwlrHNLvr?=
 =?us-ascii?Q?SKNwCo84wLrPM8G5m33ke7ZnexO7xlnGXmf23LFheYlCq3ENimHyOjdzZY6G?=
 =?us-ascii?Q?c4a9UAh3M/oSiZAgN/mK9xPGGtwOx1D4p3SSThXQfzq28L4F+fLLEYwYk5Ty?=
 =?us-ascii?Q?CTeyXoKem6tNCpEnQ5SUeC1vr+a/f9Alj/xhIOS/3G0hJFQ/MHmD+w04oiLZ?=
 =?us-ascii?Q?yeXWWba3Fw0R7QJl3WKGrZJWJWlclohApwmugDOnfnh59X3EkNa48zLVaABK?=
 =?us-ascii?Q?DQGp8C1VnjbUv4DCJI9KXSPvYy2bbg8u47YqvelvryW2e3LkGu8KgRMPxoix?=
 =?us-ascii?Q?uAjhfmHc16aeDLUvHpSkhvOJKiD7Rb5+SbtssYLVaN6uu+J/JHkT9/2EibDl?=
 =?us-ascii?Q?u0JDoPhdfN4czt30CAhfjIWY97VYalJX0gAi44ix3MbKKVIrIKTC8T3h2tqq?=
 =?us-ascii?Q?YNTv9Ii57Yy/h7EpZSB+WjcrfqqvJ43RFNyvPm6kMDNObaKoDMaQsqiUIpRz?=
 =?us-ascii?Q?LMC5Vz5brJdlOpqykGAZWEiZjzcaB0Xo8VTdz6r3UkH7wvuR8t47NkniBUVV?=
 =?us-ascii?Q?CPFgLoUUu6xrEmjTZoRgMe2335gTBeXuj5d7Z8HJAK+U1Hfs5logGz3v3QWE?=
 =?us-ascii?Q?wpebC1OYDo//JIbpJHBUrpXmVOJSRT/eQz2PpcI7/6uq/2pcCdIjc4T04sJU?=
 =?us-ascii?Q?Kx8BGdFHOBW4+9Ps6UTTxS4F5Z06Ybj+P66D5AneS35NG9ZWjvvAHw8U15zt?=
 =?us-ascii?Q?tejzHhaAf4sYl+nh5XSdP21Xln+SgC1YhHjwfGehf2lEMq8HbedoVpsmOChy?=
 =?us-ascii?Q?IsPVBW6CmWLnTAl1M+kDh4UaM7pFCFcq4tqB55v4aqf6gyNdffCMneypDOAu?=
 =?us-ascii?Q?rAaeaCGaDu/gHNcDGadL0rzCH3tu/bPd/rxlr8VJev5VGnYiMBi8gGzJh1yS?=
 =?us-ascii?Q?aZxP3P1jMjO7dcZ6mDxfb9y+6P8GuKqS4R45c8chohFXxScv5TSGm0d0oGKa?=
 =?us-ascii?Q?uX8PiufouASOwhPRBcIQ8yrhiCfv4oG1KT+c4SnGV0wyGQrlOLS5Rj8Wfm6b?=
 =?us-ascii?Q?GdPBibXeVzWt45GkrIC+2Lb54u8208Z3ZRClYGfnOtmAmkygGzn2S4kbmo6D?=
 =?us-ascii?Q?Sfh7o/M82FuanCQRZAGZ4fDkfWggcsKRsLsywVkd817zwN7qIOJoIoOfltVy?=
 =?us-ascii?Q?0tVosYwgCjk5ZOh2Doa+e/K0G8aReLAw5mL+MnZi?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86e92f4-c05d-499f-9aae-08dc6b507007
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 09:07:20.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNGTWqJROSRRFbTv6OSQVujg4q58lC2s5BHodnhTUtJo/S5+dmi4hWb413Gw6+ek8xl1FXmNHoht3UvIf+Nkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1567
X-Proofpoint-GUID: 8JIn2FeRWRNYRo8S4FF6CiYvzUFoTb9W
X-Proofpoint-ORIG-GUID: 8JIn2FeRWRNYRo8S4FF6CiYvzUFoTb9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405030065

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

For fixing commit a5918cecaec3650df in iio tree.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index bce25ff57ecd..63b85ec88c13 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -503,6 +503,8 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 
 int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 {
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct inv_sensors_timestamp *ts;
 	int ret;
 
@@ -511,7 +513,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle gyroscope timestamp and FIFO data parsing */
 	if (st->fifo.nb.gyro > 0) {
-		ts = iio_priv(st->indio_gyro);
+		ts = &gyro_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
 						st->timestamp.gyro);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
@@ -521,7 +523,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
-		ts = iio_priv(st->indio_accel);
+		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
 						st->timestamp.accel);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
@@ -535,6 +537,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 				     unsigned int count)
 {
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct inv_sensors_timestamp *ts;
 	int64_t gyro_ts, accel_ts;
 	int ret;
@@ -550,7 +554,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 		return 0;
 
 	if (st->fifo.nb.gyro > 0) {
-		ts = iio_priv(st->indio_gyro);
+		ts = &gyro_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
@@ -558,7 +562,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 	}
 
 	if (st->fifo.nb.accel > 0) {
-		ts = iio_priv(st->indio_accel);
+		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
-- 
2.34.1


