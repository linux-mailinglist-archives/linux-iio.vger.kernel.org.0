Return-Path: <linux-iio+bounces-9657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D01397CB26
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2C41C21C0A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9F19E7FB;
	Thu, 19 Sep 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="bZP94o/r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35519B59D
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757136; cv=fail; b=AWQtotm+iUjLTAuDqsYcAVsJ0raHjLXCxStNk9qVYHpyaOhhl+jaSElj4UptaeFp/4VTkMv+AXWaxFw/WB8p3QxTNCALizelc0SUnUgu9DdXovNNqtIWa6D7axzp7X8JpbH7EtpBiwoz79lDUTYUqEqX9ZB01wrefgFOw4UWOt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757136; c=relaxed/simple;
	bh=ewmejB/Jr+BabxR0EBqgAem45BX7HThNGsxc43KnjwA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RYdVJhJWkCS7c9ZrtEHS8sUH0Niy7ha29gkBLcTEdHzY3F2hX2mK6vXaeP2CrGuO/DDtM7MKqUdkEyNiIQaBgh+/ZV6bNgUkFci6sFgtpaXEF5bLi3D7fwj+M4ZnZNpXbqQWWgH6hgAKel8k7F9ci2YZGEMiPUqQc0KfLg9+4ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=bZP94o/r; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J3Mr0O005832;
	Thu, 19 Sep 2024 14:27:43 GMT
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazlp17010005.outbound.protection.outlook.com [40.93.73.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89u55c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 14:27:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjkgDou+LKGmilQFs6kLV7AQ/2vDcPgQEX2rVNSfANbY4QD3b++8BfNaJPbkVfemCH8dELdxv77UpPPu9TLFq2enWSGcZtSneyBUE1LinsjbAwC1W3tZSjDsFV92HukD+kghB0CD5LiE7c1lgr7pOJrsGHdQdUjB3Ioz811oLv+p6VJgHceW8gWQ/fqBbAqFXrqmAMPhOqG4X88QL7tZCGCuU3U+2PlOGsJlpNDDS0bL+0bQYluKrT9ZykD3EoDgQnUHmHO08aQMZX2nHQQvZDHY4ImtmAblzCzxFJygGMoNsLQMTGKHqDs+AwGjtmEAvLr+Ux8K9cHKndKGv0nZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMoaQi8Sp+mGcBVCwyNe1vwD4esFKsu8TQ+Xk+XNglo=;
 b=BVD5uMVPoylFSl31uTcGkjOUFMjztl0JB2d/e+l7mRS5D9aKd87tD/iaC77NxiBECj45DmXv4L6rYP9RUQeqt2QyKHZMXRBAHgiLrcr9JrMvFjIS62PaTghZa8W8A6HUk9XdhazfXhD5+uv/6MoNqo/k1yEd00JL0n2NxmGANn98mrlUeipittoOn2iuoaSev1HqXR8bBmItVoY0vaeItPdK1pJdYR/qiOD/64lnUOC+VppkDUeoKoUw1P1lfMFwcTx1cRXfeBWhLUAFTUuHVzjaaZsbBsssJSq7p2T67Y0bcKvS8/TMeT/0AXFVCCmR8XdhMTawoxxwGl9mq1N80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMoaQi8Sp+mGcBVCwyNe1vwD4esFKsu8TQ+Xk+XNglo=;
 b=bZP94o/r5UpLHH3adfoCE5iEun2TobQUAmgYQ8XfswcakSPB/rmX/arACNvrSI8by6AkU77yL0eUVan+17l4lZG6hggbZ6gipc9+W84MEqgRunMyHEjjOCvk1GX3gbHPnG53XnW+xG+F4maJ4TgnFGQJRq2lxTVy/09x5ofJfngGBEA/HuzC/HejRZcOITY0m+aOSoxDGDQcsX4xcPjYndSJEzOCWqAnzjTG9UlLbsAW49hGQoKHoI1wUfAqAYCdVnO+i6SBncwFLoYA3/QBTXV2CVaYdEwneDC6Lqux8+x/nDBlzykkbvejiLhWf0xSuKHB7dijcaoPbJFm8Qz9/w==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYRP286MB4946.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 14:27:37 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 14:27:37 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 0/2] Add support of IAM-20680 HP & HT
Date: Thu, 19 Sep 2024 14:27:17 +0000
Message-Id: <20240919142719.162431-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::23) To OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:174::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYRP286MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3c1828-6f3f-4192-bba9-08dcd8b73539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tsvX2loCbC2ssAhU148CDobYHQHjqDW2d6gxeZJykCNNQnrgWqrglKBR9TgO?=
 =?us-ascii?Q?PREmCbC6rNNRlZEfMtwF9QjDm/o4EaMULIes7Wf4oowIRNv9c/80YR993xzy?=
 =?us-ascii?Q?hkbY2KmnQiw+c3MwiKyV44ucvU8URmRqc9X0PrB6M3pzqWXwyxK//ULU7n9X?=
 =?us-ascii?Q?/Z8WfKg4fE8rUWk98vRvy0ZXtssz1xpqHS5qevlXzo/oOj9KrotZ2IaJ8fWm?=
 =?us-ascii?Q?JN7iWFiOQo2WXByqHazHS8DSlPaShDtPOQ61oQ7rJgX+ePWVJIlQQ62IJwft?=
 =?us-ascii?Q?KcuAMizhLy9Hu3cXCi/yJwrKUuuSB6fP/zSektJCZQyBLUvffDUEBylYhY2y?=
 =?us-ascii?Q?fGx7rVFkZEK9DelfvAf7LYUfDVFQfvNhgA4E5gJLz9djjsQeRVg+xBmdoPzX?=
 =?us-ascii?Q?s7BH2xF9iVD+PpJgo+zjzkD3t+kzoRbgcJtFbRFicLRrDwS85TpYyn2u++k7?=
 =?us-ascii?Q?rT66JpaTWf3hlFoUdJ/s9ylDEJzU4/TYeaMCHaL3Wu2Swz8RBdhwIIR47/YN?=
 =?us-ascii?Q?tIHt7rWyWlp3gInJ21CHFLIr3TuQ5QgNSpRfWyHJ8uP/qE4bbxEbmcAjYseM?=
 =?us-ascii?Q?KGDF7rHi6z8D8IId+C5LZOOgy2SzNGLo5t8QnXdfu2SPmRtRyfcjJGtodE+J?=
 =?us-ascii?Q?pHH6Z5nDrP4wKaLrSnqKubw/xz/ITmWepRElUbfh9oqyAQrUR7XVlAc1C2MY?=
 =?us-ascii?Q?BX3ToEykwOhDbfx6wNuyEWb7f76zb0Ahq4dz8ryyMtRm59fQZ6wS9hVlmwvr?=
 =?us-ascii?Q?pdq1nNGhKgCoDUuUQolH7krCc8VTQrT3NVozYC1rJolWaylwks/uO0t7YnQS?=
 =?us-ascii?Q?WieI0SDa5Zh/1Vn62OOnQVkOUEBcIRLPqVIzXoq8WU0NBIJaFkd4xGLCigEl?=
 =?us-ascii?Q?Za0M5owrVoYx80cKRMj0oIzv1nxYBSek0cSlwmdC3qINlYePa7hTwTL9hhrt?=
 =?us-ascii?Q?Tv6uzn88B3ZXp8VEg/gBWKiSYk4W807hZOaQwAdWF4rVH6Fxi6oA/u0bAt2Z?=
 =?us-ascii?Q?wryDLMcpaBzfTPUPXFvDuno65rO7v29JyvrMukSAkW2ioeF8Ukfd2fd4NRV+?=
 =?us-ascii?Q?y4dhmVUNZP3MWKSlH3cc5YsAVPHM80et1QQlaAbmhs3zsr5M6hNronFfc1Vl?=
 =?us-ascii?Q?tT/8cQDu/LA/xfgI2PBoQ4rsKJo7MewwsEwtMJb3MHU3A3r+zxDTDZpSWhRy?=
 =?us-ascii?Q?bnkp5OjID3FdEwJNOTiwVekTtfGsejvCr0q0bzgBj6xQF+dNIXmCd9wjCL2c?=
 =?us-ascii?Q?LXSJe5b62DtU0yx9oc3piT++qVDKeJnBk20R8Qp0xehsMQ+lWkQMQG8mELyc?=
 =?us-ascii?Q?D89ZaMiSCRffQ9PkCQ2MdBtE7ud2FhLaLjZO2/GmDplrVDCjdvNHvKbzVBFf?=
 =?us-ascii?Q?h2ePNxjvvAyLjPqbT0RGJoHGOOw/67T52Wx9u2XFdNnuzG3z3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1j+myQmhrhMMaz6zZ81muhXjR5uJt76LIHn2YTGJxKOaboo2/StZgccYsris?=
 =?us-ascii?Q?fJItOjlaVeizbQEV2iCDIUGjrvJewP61kYE+xQJqFAkK8RPmbDUACPeXTSL5?=
 =?us-ascii?Q?f60KIsqTQla9JrUYGMvOivzlVuaHqBWl+wxsExVx91y4CfxeJF2g3YgMb/m4?=
 =?us-ascii?Q?PgyrnUJOOmVQTlfd/sG6Nb5KnkkoYq0A/3waysx7evZpjUm3YfOmEGnJYqtj?=
 =?us-ascii?Q?hFaANWu+JE3v2lP26IKZtCtlInIuthjDoxudq8ykkD2Wf/zKc0hleOEOxuTg?=
 =?us-ascii?Q?6RJ/y/v/ZK5eGC4nd7yf7SiaPf4hYTkUgK0yajTY8zvElFi8KOZUU2BjrGVT?=
 =?us-ascii?Q?1BFubZw01ruZN/MmXrQx+j9HIjajiCOiBjjQTWb2s+lVW6J5wvBtmRCyX1/q?=
 =?us-ascii?Q?HsoxnE2gpwAwF1RKhnse7WbK+aFUZTwAH/DIfS84gIFZShxFrrSZ2EwMA4wA?=
 =?us-ascii?Q?rlwbIJHbfEEIpAcgS7aSHrsqr//MAV85APx3/N5w4h/jgD/xo8dlnBQve8dj?=
 =?us-ascii?Q?10GxAzVNx+2Ox1nwBJCetz1o9DiLHeobrEa4bFhX7XkvKWJMOKcjU6YegvyW?=
 =?us-ascii?Q?ymCDUqHbmU/B0OzBEPe856voA2VmuKlKVIPBZ+h3e281kx426Hj6EhN4bmK8?=
 =?us-ascii?Q?ud94ykf3IoZB327KthDVAq0b6UtbmJc6Lty8h18O3yvHPvMBIp9At/bTim4p?=
 =?us-ascii?Q?aaFCbYsz88EJHLLm439LnciFQsFta3JQ63AB9UPqjJuCljyNejiOp0ZJkJFB?=
 =?us-ascii?Q?G1oI0a9BjP+65+twajxjhLMOthmuv4yqO1LVIpRxoupXLzltwVofNZBsIc6P?=
 =?us-ascii?Q?YyyNxL2Ix4XDxXjyyihfg4CMjnko8xvohtspDwkR4Gd7DtiBZJSeAcQ4nI0e?=
 =?us-ascii?Q?w6bsbDoMM8sehnH37pFSmWkEde+ojBKVAcOEE/SjbGbFkZp4LCaMTwVVidT1?=
 =?us-ascii?Q?zv4S4e3MUksot9DjHBkMLMmUm3XGpgjBCYNVzB+W53t9qfx0QvKZw02+hhq9?=
 =?us-ascii?Q?ovRI+Al1Xa7buPM1UQekNuhvPHFUOFV1WzI9lk7Q0ssP5Q4wt38ox5Jw5Eu2?=
 =?us-ascii?Q?Ejdvtdg3IBibuSo48ezkkSZAgvF8q9z30a0llFsL7zg+DE9zrZNlp4iUJQdd?=
 =?us-ascii?Q?uGEUBqbdvBzdmh8XGKKTTK9kBam3bc7jhtu1e+znSf1cwbePKVVOLwOAlBE4?=
 =?us-ascii?Q?vrcOoZU8Gl+xRWItBCy8l1QGxLjhOydLciE0/YtbQR1RpWse+zIpoPIVlWD8?=
 =?us-ascii?Q?QhRejpYDfGirXO4qc9Ytp5v9+sNXf3d8BaBHxRS3hOgbzOlopI7cDqwfKu47?=
 =?us-ascii?Q?rg/dYaLahOTbCTvC0QOFzMuyVgotxHeE/0OzEmQJfz5/UQWQ9g1TxKrnrjEE?=
 =?us-ascii?Q?tCGvqdfoAAplL+kZkb64P+8R+Z8I3pWJVzyS3gTzaKNDZNM/EsrjymB9G04y?=
 =?us-ascii?Q?8Fjt1d8pnml9D4JUwq2LbQaQeMK2aShI5FXxNPiDzU6b6M1uhIcxe/hQZ265?=
 =?us-ascii?Q?/CKxiCGQnT1I/7WcVnroplc0UXQQgDtKSY9PmrC6WI+Mz0eTLt0qSgtiFfFP?=
 =?us-ascii?Q?uIySgR6pgPGYMTLbbM/yuaUEfDCzGnP1faPXOF/Z?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3c1828-6f3f-4192-bba9-08dcd8b73539
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:27:36.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WeYKsJpPMVkgCaqt9E4vA5YbTCPQAfdiuwMF++stW3604YcYaCcxO8Fi1NB4gROJNIF102LLMcccE8W6T6CbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4946
X-Proofpoint-ORIG-GUID: o_YlPXgpo2j-j2uZwTSWMY-yLfd2WGo3
X-Proofpoint-GUID: o_YlPXgpo2j-j2uZwTSWMY-yLfd2WGo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190095

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add support of IAM-20680 HP & HT variants. These chips have better
hardware specs and a bigger FIFO while retaining full compatibility with
IAM-20680.

Jean-Baptiste Maneyrol (2):
  dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu6050
  iio: imu: inv_mpu6050: add support for IAM-20680HT/HP

 .../bindings/iio/imu/invensense,mpu6050.yaml  |  5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 20 +++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  4 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     | 10 ++++++++++
 5 files changed, 49 insertions(+)

--
2.34.1


