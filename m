Return-Path: <linux-iio+bounces-5502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C428D4E40
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5549285318
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ED617C21F;
	Thu, 30 May 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="eWuxho3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A7186E41
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080293; cv=fail; b=lbymqvd7coyB3NN3lGUrsMz9ehhdfqKHxECWT274oNyVGvA7pnEko11HxqXwJWJ490SdSBLW/3j3mvle8zF/r9adzy0lW3JtfXUyTk+ACp3jMLP+6pnaZv0TTPgA2udMKTwcVvbalpX9IhRXfyih/ySSyd8KdfxOdZ2gcIj7OAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080293; c=relaxed/simple;
	bh=B9+r2trWDE/petfPCPpYGAU0Ni8eyMWe7RuoM8ukS74=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JckCxqRIHd3E9E9npc8X8X+WMXGNWNUzgO0MrQlUxjY2F+fjLZLwt96QEQZ3LaAAw5YSn0LNljync6UO7PyXyH6M56+JasmYDRCbFkWfgbznsUL6a4VisbeB/IuMpqN3xV+/0v/u/zxwymdgIP0dSXEpvTq+kGSHtALKuRdqwH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=eWuxho3A; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UCgDXQ016504;
	Thu, 30 May 2024 14:26:20 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2107.outbound.protection.outlook.com [104.47.23.107])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yba233xk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 14:26:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhJkK7l6dm9bfVNaAVmdEmm9TUBP1ccfvv0odNn3pKyHbE9JjVMchM8YuspdOPvHcJUJ0V9vhIaQPt+XwSR4e7QI9zj80AVoT/KUZkMCiazCpeDOqHaoB0MP5AhLwN+U/UUUEIhXEHuQLY3dwOgKZrnTYZJ7gF/JUHW+TcCySrben5yu5O6qz2XTz708wblrgwnmlq1PjOmyiJ5ISJO98CO8ZsuSsIBZKvhoGM5n4IN7mq7Levcu13tTvKQFjsHWhc1jFd8v7cuzeMGxAZWSV3M/WUQHtuaf+LXB0ywvcJ0RzI8HULh82Mfg3Kg/6ADVrCQ4P+wyaF8BtwH5YJejsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2MEDSrRLrN63L2APKFSskNikMZ2svzahdmEkswdGqE=;
 b=disBFvQfy+zLtprqBQljSpmsVPHE1CrZ55URYRGjDK2Kh4RqochL7LJB1brQKSl9ZSq23E3XqtnY6vGz3BpDOgn/QyM/3a6fbogKUwMCGRnKJET6+ciQH4jIO3gAIrzjVM+0k8MmZxWj118MwVx0Mq/xGKgFO0MoKEccLqonLJccp/WfRoh7XfGF2rIK1VeD3z5VU/yJNdkKhOoZqEB5VGPSoT1cqp0gAOPwiDt3XzaHDd37NuzcGieG/xSrwC/vJpwcGYL18ImLFyawvTdrAeIJopp4vEfGn60orfEoqPDDXDlYLOmDs+i8Fm7k+ekwiFhZFEYYnc9D1xAZYRQVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2MEDSrRLrN63L2APKFSskNikMZ2svzahdmEkswdGqE=;
 b=eWuxho3AHJ6ay7F6BUxMLB+s0bn1q2qQ481uob3x97b31Cvct/l860hbSLgBJCAlh2ovfKRHDeIPAO384hWh6cDm0EWwmv7Vfda6dvAoaRsE10JPRSkQlEAE9Lan0kW5+h3VhQ8s0CsZBFhQk63zYqaH//Fyx1r1oX+zZZ0XRaHb2DaG2waBEShA22gvdYDcSWVeA07cAz3JqQptNcwMpk8q0H1W0wMI9++B4OnZ+JpSDsh8/WhMQ0SU9NdAjbhOJZKBZ18zptJs2RepdtJMD16+XLqQT8C2AFBjLypCg+QfYImdXDSP/talCI033x1Cq1MVPkZJ/A7+5oLFlNEtaA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY1P286MB3311.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 14:26:14 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%3]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 14:26:14 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3] iio: imu: inv_icm42600: add support of accel low-power mode
Date: Thu, 30 May 2024 14:26:01 +0000
Message-Id: <20240530142601.666984-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0191.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::10) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY1P286MB3311:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f6b892-a29b-46b3-221a-08dc80b4759c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XdkUoidR5+Tqy51uWOA12LhYemTeBp+LBxN4tvqFUXGgNguyKu39RXj3HYXo?=
 =?us-ascii?Q?+riETFJ0o/+vrGgsscUg5Tfy9cqgwtH7n/e8jcMr+jZHL0NkwG2lHLrkv3M4?=
 =?us-ascii?Q?AdZjkPU0vPp41hDQyCRbD/t3TlO8HoiG6I94SXTCdTZh7AZMl5LpXgTsKnfg?=
 =?us-ascii?Q?uIfh+oUWn7SkUxukotXoF+SWMyHrJVWqOmreepE+j3t7XcRoz6tKPtm4A1OD?=
 =?us-ascii?Q?XAsnFZAVPLSYJY+pI3XCZ9wyRSihzExmcFWlGn5TFJQG9BqLgqvx/RFUZrSS?=
 =?us-ascii?Q?tgUExeOWhNE5xCUf5MHmCXSxaTFAw/TtH+aro7W7HJgIizcm/DCXHHAPm70D?=
 =?us-ascii?Q?qhvYFoyL6WBn8NkXS6tclZg2PvvMUkX46xyLNcUEVymfzchfABM0r9TwlTKm?=
 =?us-ascii?Q?eOzWL4NHcRcHkhUCe4i0OuKRJH9D94Unxs5tGG6H8/+QOjBhgT37vPKg5oo7?=
 =?us-ascii?Q?TT9zDkKyd5teKEV+tX80YLudwk+60VngusFrhpDj22rQ5LeeQI6Z+I25k97s?=
 =?us-ascii?Q?y+xQow2Paqj/WXlKc2zBfP/FmL1gCCqPJ29lV2pqIYMXGpXqWLcWnpqLPH98?=
 =?us-ascii?Q?G5DlIFk67Z+1RsDLNOMABBF/A92797bwg6HDi5C2TD6bqpD9wtCQ0xsw4SY9?=
 =?us-ascii?Q?/Tl54z7quNnBmlWJUlFmfxSFzQV3+vOSJ7qXeqkMHxb4PkmhfZAE7Q49xMJQ?=
 =?us-ascii?Q?Sp5kYHxQus1odaSC+83sMd0HSGk6h5MJt9/KZftIlhbQ96I+uGEjHHCbNg2F?=
 =?us-ascii?Q?3tfn7KwamW+3xCuHebNhq8vSiDVTeYvcj4IaQiiI/J343O5FYlUqZYhyH+ym?=
 =?us-ascii?Q?WAYomsvjhXALwHApHp7oebvTxSrqlgAllZSb8lXd1FnT921rlIefs1UMwJh2?=
 =?us-ascii?Q?GP7t4mBdZgHc122brdO457gCgOaW85/HObiS11My6ahETsjY8ftYdAFefoqk?=
 =?us-ascii?Q?K6WJ670XQHb3OR9vENGHGyAVs25XyxMPsw0TZUOGAwDLC0BRhpojkwR+o5wB?=
 =?us-ascii?Q?f0uO3PRinDi4CMO0ldF70RJ8VUTd995TlUMVh+tuU6UaWZsgh9mGFbyo869t?=
 =?us-ascii?Q?0+KOy0MEn0a0vOngwEWO1ZJGaMYVR+CCYdxc04T2ebUeI3Q/jZITBu2fUfm6?=
 =?us-ascii?Q?tsbSjD0FsAhriUExf+vqHWZabFhWU27r0jIfB/weNowka5+V5W1SBlY5pIP3?=
 =?us-ascii?Q?KvYRvYH+C4X9fWLxpZGp57lcE9bWgEvBfBjdePHp0XNYbJYJf441Uk8ifu6m?=
 =?us-ascii?Q?vD24K5Qpz/7YLmV83+7AGAyCplRoLtsKM6nrMcHKwniHZ/EUznYPRMrt/BEi?=
 =?us-ascii?Q?aecyIqJd9sngTNPXf657irSedIb8/m56yWg2ysEkUMARs9lgHsmWVzyeRgfl?=
 =?us-ascii?Q?VKhSfaE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rS5Z6EIHkqqcAd1os4xP+USzLuuyz6JwokBFiM7I+kq/Su7gDRLBSF/DU+UX?=
 =?us-ascii?Q?oVuiUZy+uu+KSvYeA7NO9E9s4EjcKGVte0VPudbdKxqPyzVzDH9t8yRysAnM?=
 =?us-ascii?Q?z3rSJ0phT2FkwtABrCQznmKVVedO1dBSsb3U2fppMwyjq4BWmCFDolvybL6z?=
 =?us-ascii?Q?750NLdViV8e29KYTcwrsPdj9gxz4jGf9TxoQsrTaxdhiVd6ItqtlVXkPFYe9?=
 =?us-ascii?Q?KLCJLouchKfz8G6m+/d8sfEVX4oVv1beXonRrFtvZZ1W4tYbBPExyzLAkRIH?=
 =?us-ascii?Q?NtPaEZNhoo6izz/kAdLzVBfD+cbs3Hb2hKXkr4MutKDipyUvybze6tJheBR4?=
 =?us-ascii?Q?9zSGN7TosBUR4vm7Emti3aJSlGW1tcmTe8BFtLmj34I3ieI0Xdg5mA9zM3dp?=
 =?us-ascii?Q?Q1uBQRdZ0QLsSfwVJZ9Yqo6hrUuIaS+GuXc1F/DwP8u3aqjgr3WpYynDlaG/?=
 =?us-ascii?Q?msCsLl3NMAnnUlLhjr9YcPlzVo2jkuSfAowNLLziOdzeTn0rBmuaaFjEj+rE?=
 =?us-ascii?Q?4y01QDOI+W8QQrimBKOcefpelTVtADCf/XCOMPehnSsgtoYJvDeGQAAzRZuh?=
 =?us-ascii?Q?N31/oH47VyOKT1DMpoVbsm7/p8zKoWeyfihtZ/fqhvxIW/UiXFFS585BQxSh?=
 =?us-ascii?Q?SHucYfgBjM3lYxVUDZLlmLf8bdAFgdsAqyZMtKMNH9JKcNZQSwPfNfRe/YSa?=
 =?us-ascii?Q?2AfT78+lCozJa9c53QIC88WKxOwieEtbI7A53C7fSjQrnw5KeIKytjoPW/+l?=
 =?us-ascii?Q?oXZdqAhu5m1WMtQ4cHq6tYGsngjnwBqoEG2t/o61jdZ0yp068DrYPHCS/PVF?=
 =?us-ascii?Q?E3oH5CrODYozX3qsbRKQ9vl3/SijAi9YrEUV8k7xyT8+F2IIysyx0umJ7aIw?=
 =?us-ascii?Q?OT33PxgSB7i/OOVj6t8Z6GbEBPm8QARKhvkHKR9U75G7AVfKddirl1TdKXo6?=
 =?us-ascii?Q?ZPwN4taax9Y5H0xHCVdlhIS8c9rvI/8UkdZlK0wNtwwW/GmndQMT7Ju6NPJ2?=
 =?us-ascii?Q?TAO5OSP2opSlkvEJLb6Pp5hheykiLUEKVACmYl1I1glV1YpQSiT2BHeiPhEP?=
 =?us-ascii?Q?6nhs4EaZG/HUDdAR+mku5IJWOoREtzyTZg20uPPA/vDrr6hv0hwSwPSOoNi4?=
 =?us-ascii?Q?EFXJzvOYM3YTCU1Tn7N3dqioepO6A0Np1FZeAg/YRNTp4/6RKXbwze8sEkjL?=
 =?us-ascii?Q?E/SGBCMwFyYWRqVm7GEal916GJ/hoTMKya2qD1OfiOY9Plp2+87FLqhV/yil?=
 =?us-ascii?Q?h6vvO3+FfHE2qzry18wjVqXSL/AWOuzSbOOTW573XqYBlGJpEjblRHujRMMb?=
 =?us-ascii?Q?zS5WYejUahIkJPVAKuQY7koOs+1L1tOJ4Q1/wpDSJ5ocKsfYDUhgzQU3Skw5?=
 =?us-ascii?Q?6Oc88CBLNKK4/26ys+NhFYut73ex8stTQ9CD0pZp868Uve5LP6NwzZMeipCl?=
 =?us-ascii?Q?zFYqaNI4CBJ7/gf3xFANf5Me9Kl/JX7Kv9/c6Pg+NxLaV53KuQLiavIcDhR3?=
 =?us-ascii?Q?tPVRQXR+egjTL3atfgymoBTb2UV3iyJGh/2c8Yv/BgnRYsb+nZpLfVhM7jzv?=
 =?us-ascii?Q?0lsznLe/vOwYLgCRbJwUZE8r1Hvx38TETbyep5m0?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f6b892-a29b-46b3-221a-08dc80b4759c
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:26:14.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RELVOikoKMOYXWjmu1xTcayb04xmAX0Jr7On4c67bodPIypZosi5v0mWrdxPDZLo4keozW36MyrKkLMmvwd6ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3311
X-Proofpoint-ORIG-GUID: H7i8FjJ6ZyPFIC9DoIhLuxXhleMo4ca-
X-Proofpoint-GUID: H7i8FjJ6ZyPFIC9DoIhLuxXhleMo4ca-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405300109

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add ODRs accessible only in low-power mode. Switch automatically to
low-power or low-noise depending on the mode supported by the ODR.

Add channel attributes "power_mode" and "power_mode_available" for
setting the power mode to use (low-noise or low-power) for ODRs
supporting both modes (500Hz to 12.5Hz).

By default, low-power mode is used for all frequencies < 1kHz and
low-noise is used for the others.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  4 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 95 ++++++++++++++++++-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 22 +++++
 3 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index c4ac91f6bafe..3a07e43e4cf1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -177,11 +177,15 @@ struct inv_icm42600_state {
  * struct inv_icm42600_sensor_state - sensor state variables
  * @scales:		table of scales.
  * @scales_len:		length (nb of items) of the scales table.
+ * @power_mode:		sensor requested power mode (for common frequencies)
+ * @filter:		sensor filter.
  * @ts:			timestamp module states.
  */
 struct inv_icm42600_sensor_state {
 	const int *scales;
 	size_t scales_len;
+	enum inv_icm42600_sensor_mode power_mode;
+	enum inv_icm42600_filter filter;
 	struct inv_sensors_timestamp ts;
 };
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 83d8504ebfff..6ade0a5d4d1d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -55,8 +55,79 @@ enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_TIMESTAMP,
 };
 
+static const char * const inv_icm42600_accel_power_mode_items[] = {
+	"low-noise",
+	"low-power",
+};
+static const int inv_icm42600_accel_power_mode_values[] = {
+	INV_ICM42600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM42600_SENSOR_MODE_LOW_POWER,
+};
+static const int inv_icm42600_accel_filter_values[] = {
+	INV_ICM42600_FILTER_BW_ODR_DIV_2,
+	INV_ICM42600_FILTER_AVG_16X,
+};
+
+static int inv_icm42600_accel_power_mode_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int idx)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
+		return -EINVAL;
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+
+	accel_st->power_mode = inv_icm42600_accel_power_mode_values[idx];
+	accel_st->filter = inv_icm42600_accel_filter_values[idx];
+
+	return 0;
+}
+
+static int inv_icm42600_accel_power_mode_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int idx;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_power_mode_values); ++idx) {
+		if (accel_st->power_mode ==
+				inv_icm42600_accel_power_mode_values[idx])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
+		return -EINVAL;
+
+	return idx;
+}
+
+static const struct iio_enum inv_icm42600_accel_power_mode_enum = {
+	.items = inv_icm42600_accel_power_mode_items,
+	.num_items = ARRAY_SIZE(inv_icm42600_accel_power_mode_items),
+	.set = inv_icm42600_accel_power_mode_set,
+	.get = inv_icm42600_accel_power_mode_get,
+};
+
 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
+	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
+			   &inv_icm42600_accel_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
+		 &inv_icm42600_accel_power_mode_enum),
 	{},
 };
 
@@ -120,7 +191,8 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 
 	if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL_3AXIS) {
 		/* enable accel sensor */
-		conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+		conf.mode = accel_st->power_mode;
+		conf.filter = accel_st->filter;
 		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_accel);
 		if (ret)
 			goto out_unlock;
@@ -144,10 +216,12 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
+static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 					  struct iio_chan_spec const *chan,
 					  int16_t *val)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int reg;
@@ -175,7 +249,8 @@ static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 
 	/* enable accel sensor */
-	conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+	conf.mode = accel_st->power_mode;
+	conf.filter = accel_st->filter;
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
 	if (ret)
 		goto exit;
@@ -277,6 +352,12 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 
 /* IIO format int + micro */
 static const int inv_icm42600_accel_odr[] = {
+	/* 1.5625Hz */
+	1, 562500,
+	/* 3.125Hz */
+	3, 125000,
+	/* 6.25Hz */
+	6, 250000,
 	/* 12.5Hz */
 	12, 500000,
 	/* 25Hz */
@@ -296,6 +377,9 @@ static const int inv_icm42600_accel_odr[] = {
 };
 
 static const int inv_icm42600_accel_odr_conv[] = {
+	INV_ICM42600_ODR_1_5625HZ_LP,
+	INV_ICM42600_ODR_3_125HZ_LP,
+	INV_ICM42600_ODR_6_25HZ_LP,
 	INV_ICM42600_ODR_12_5HZ,
 	INV_ICM42600_ODR_25HZ,
 	INV_ICM42600_ODR_50HZ,
@@ -581,7 +665,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = inv_icm42600_accel_read_sensor(st, chan, &data);
+		ret = inv_icm42600_accel_read_sensor(indio_dev, chan, &data);
 		iio_device_release_direct_mode(indio_dev);
 		if (ret)
 			return ret;
@@ -754,6 +838,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 		accel_st->scales_len = ARRAY_SIZE(inv_icm42600_accel_scale);
 		break;
 	}
+	/* low-power by default at init */
+	accel_st->power_mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
+	accel_st->filter = INV_ICM42600_FILTER_AVG_16X;
 
 	/*
 	 * clock period is 32kHz (31250ns)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 96116a68ab29..b14ff58d8a9d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -248,6 +248,18 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 	if (conf->filter < 0)
 		conf->filter = oldconf->filter;
 
+	/* force power mode against ODR when sensor is on */
+	if (conf->mode != INV_ICM42600_SENSOR_MODE_OFF) {
+		if (conf->odr <= INV_ICM42600_ODR_1KHZ_LN) {
+			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+			conf->filter = INV_ICM42600_FILTER_BW_ODR_DIV_2;
+		} else if (conf->odr >= INV_ICM42600_ODR_6_25HZ_LP &&
+			   conf->odr <= INV_ICM42600_ODR_1_5625HZ_LP) {
+			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
+			conf->filter = INV_ICM42600_FILTER_AVG_16X;
+		}
+	}
+
 	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
 	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
 		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
@@ -441,6 +453,16 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	if (ret)
 		return ret;
 
+	/*
+	 * Use RC clock for accel low-power to fix glitches when switching
+	 * gyro on/off while accel low-power is on.
+	 */
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG1,
+				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC,
+				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC);
+	if (ret)
+		return ret;
+
 	return inv_icm42600_set_conf(st, hw->conf);
 }
 
-- 
2.34.1


