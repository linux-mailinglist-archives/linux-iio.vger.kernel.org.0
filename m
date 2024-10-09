Return-Path: <linux-iio+bounces-10365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC009996877
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 13:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0551F2287E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF01922CD;
	Wed,  9 Oct 2024 11:19:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2136.outbound.protection.outlook.com [40.107.222.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F218FDAF;
	Wed,  9 Oct 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472742; cv=fail; b=cwIXF273D1TZziDcC8IoxOCC4FwG7aQ6SSIUZVUiJY5XlM1ff8bk50Ocv/OPH3czNiitXXbUEwy360GnjAl7Dw6Hms8fuqFF5Kd1B4Au5y/P5M9K32vcdSYpzKTZ/kkqaNEM8MwzDSjs0Jp+yM92Ioi/chl0aF0nWIxiiS8PQek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472742; c=relaxed/simple;
	bh=Vx2wuctJhjNWYOxg6oZTvBYzVLOVCHR+uhlocZ05J8g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iu3CNM48IIKCTZqbY6PS0qObp1UiVetC3vi04XAn5eWRUjXBah+qa8aO3zumoIypeBZ+9nxs4eEcDuMA0/K05F67Difo7+DWM6knoC2LeVnsV8TXEphhjjVvJMgEsrUn54MSQ/TF68zDcUHiK9qka7jBrpzWWoh14sv/EOyHX/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t30AuyTODVPb5VOtjRhO1uDU1f8zX+RPHL/bokaBptxE+EOVYzxs9Jf3EE+HWnN3tfgezPRZ0utEzGpxj01ci50X02UcOGuAhVZKkAGl+rSZyCMpI72FvV4B5Dl27JqsSEb2UurKIoFZg0M3zn7YLzVnJtAEMmXljLqRySVImIIUYFwgId7QTzXEOdeMWeX+suHLcp22GhyaPyi3fJfDhBje8D8Kbect8KGShgidleaZzCnN1b4SKqz2s64Xs3SRwdQBJqHTDsQWC+G5CqOIFkm3zK4fx04Zp6AZc8xXnv3PxyMVFEy0C/ey0weCtZFezLWBdghWD46TQJs43/wl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbMgGPKcRIcXjhn/go9JdHAvCl47vty6RXn5XrqREGY=;
 b=p/pb8Rpl1olbG6szC8ANkIqCuX4WgHDE7m8DbLc2J2MSII6ocSh8XSNaGmOm5LTsL9fdaL41lRJkTHbbWmCHBmqqSHPH2/HamjTjegc26ekgwFDmCljdiqQk1heQzEGOWajNYi5NNnBpOcS8zzOzWKLMtboGG5y1SMnyn2qLRmGNieGtr1KlWa6ZE4/sSRWRryORxwirhWLDW04NGN1ew+pLpcLcLckziRHnVZuR8s12Prwt0Gs1zgwHazPZGg/y/TcsB76UXI7OzjgSISeIXKC9eMzDzm6plEzWxiuxXQ0R9aV9CZccruqk7EE3b/y8I3Iv/YLt5OnBLjnefDWK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN3P287MB1511.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 11:18:54 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 11:18:53 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: jic23@kernel.org,
	jagathjog1996@gmail.com
Cc: tarang.raval@siliconsignals.io,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: bmi323: remove redundant register definition
Date: Wed,  9 Oct 2024 16:47:51 +0530
Message-ID: <20241009111828.43371-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN3P287MB1511:EE_
X-MS-Office365-Filtering-Correlation-Id: 400fc0af-eb2d-4c7c-85ce-08dce854288b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/42VlF/U55gS7Wwd5R2nOcyK4ri75ohRqOzBGtpw6HBoQ+lvQ/n53GWpK30L?=
 =?us-ascii?Q?qshU3ZWbLFJRDEKjYrgKJioPZPykLFgSeQkQ/uRPTC/i1Uq7R1IH/fJrBgqg?=
 =?us-ascii?Q?iuQdng9sJyfS6/cmjAY0ILNEs8HMuIXEV6d+tTaNnOH4v4HBQKo4duw5zPSt?=
 =?us-ascii?Q?dw5574u/C2N2t/Tnc9JSHclAsF/bqYY9q0w/sjAXB7OwvqVLhzqUHeMnC4XQ?=
 =?us-ascii?Q?4L010O96WyUy2i7vkvM4R2ZaH1jhyHeWhunbWeY9xgEgQY/VrJeWm/E3/QTX?=
 =?us-ascii?Q?yMeYWtvhp4e9mO4pELijhf0g3wxi5bEZ2yMI256UpGl5oVRhiOTOvu8miPL4?=
 =?us-ascii?Q?/xudKzqNc2fUXILP7Cu/f6oGcwdXOnZn+nvvLOUnBDn55Fl1E2cMBUwNm8uf?=
 =?us-ascii?Q?vHX90aHkNJsXPN+O17bZb6Mwh8ZPdTTckhx/IjTMatH00sUXVowi/H72Aish?=
 =?us-ascii?Q?RIUUi9+eP6nQ2JGud8erXTgKXf+0aG4XvPuwqzPCW2Bu+666+cJesRW8qI6f?=
 =?us-ascii?Q?JTDYNaQgCbUL0Cug88IIVnydS52yD+dGqSC7kqInnJpRExoF/YPNHZHuoc13?=
 =?us-ascii?Q?f/q6B3yzLjmLNWIawYsdxE/6GYuDV181nY6rbb23WjRS2jceu0BPqRbURFKR?=
 =?us-ascii?Q?GQ0k5mNQXqlnRQsBcSWyJ8GNJcNwfh+6Aq7hw44VaAtjWVYa8TNJMYAfIjHm?=
 =?us-ascii?Q?ZbIWhXuBIYafdCPofTpCyBGZ7BouGndJD5h+K3tIlN7SucEF+eUc9oEKSpiz?=
 =?us-ascii?Q?Yj+pNOrfVwX0XlBy8ZIm0rt9mDSygc/+WKJhsl4AKLDEbI3qUAiEyvsSnZzb?=
 =?us-ascii?Q?gRw2V16RbFxWmhq2fSH1IVue5uklGy1rg/otFrNvuW5u97NzXuniEooqg3eY?=
 =?us-ascii?Q?cl8jN/kbYTtrIiF73eqUy6Z204QUBX5Wl4qfERUKmPoYvYA0DKQPWb88jlDF?=
 =?us-ascii?Q?h/fGHASunK3HTSWas/oFG08LsI5sRpwv3SEmSy1/z6gjLSgzLRlgYotE6f1o?=
 =?us-ascii?Q?LWoTDwJR8uhCF4IZooG/WZILXomdjUA4x9J434ysmwy7B+GRk2a+3yvSiAEM?=
 =?us-ascii?Q?m/gbNaKTktMKd5p7o9HhVssAocJcG5/dKZG4LZTn2eVn3TYm1vDldu+9g7tq?=
 =?us-ascii?Q?n/D0r9yriSluDR+wU5P8UMPiHerLPF/HApvc1+5GknHy31zLgxD7rgDnSs8+?=
 =?us-ascii?Q?Wif6ELWCmnu8dFhU8bVOaZNa+UWSbOpTyYutdIo3EytH3cdtyYXESPAfC9ti?=
 =?us-ascii?Q?z/kMblu4ugYuvsJ7RXgZLMcEfUIZTQxrt/XMb2x+e0SOvQ9doAegBxU9/kab?=
 =?us-ascii?Q?VfCdrwc6Zio/duIorDBelJDEMAIG5gkSI7JGBMXd3GJSRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izh6UrLDEqBI2z8VsS7vEgN+SiTLSmQks6YJ3yDsetd2oivetdCQfpYfanRy?=
 =?us-ascii?Q?GHsNOvJjx1h6ajda22NgAsldFrEoyYaRTNDhyqt0O7VGQeVpDaUPxww7cawz?=
 =?us-ascii?Q?MrUht0UA1MCfTzV+yacEb1IOWnRRNiIT+2RK134UUAe67w984n3B0uL5rq7X?=
 =?us-ascii?Q?xZzIWEWtGHIttVOSIzcBLybCjeCII+JJjFricnLWVUFXeTUUnNCAAJJcuMAi?=
 =?us-ascii?Q?+XAyonzjzT8hfaDn/6UBG3TjeIZvsd2HY4IG2+QUzeaVGVy7IA3RZiPU3Gq/?=
 =?us-ascii?Q?/CDLV7yuEjvBvONAbqW2YS2FD+hw7c5ZgnVsqIpMsX66hJIJiax2dHq3WkXf?=
 =?us-ascii?Q?1kzXYb4vfj31fAKZb5p8V/WpnBRlyljR0Q1LqUy25ltnvwHRKmCZx8VBzodO?=
 =?us-ascii?Q?Qy9mrS5OossYSl5snnqYGHL4ScgW+092uLWE3clAGZUg+XR+eg4LzE4cOAOW?=
 =?us-ascii?Q?60TbfF/WOLe+yw/A64GbVZa3r067NUVwx8ykBWTFgPXLXhib0+LhfCru9TyN?=
 =?us-ascii?Q?IqnvT7FpWyXkaojquVuEoG1JxSZvjUUX/ncYw6tIPwSCVFOuDThs/eDQAC1t?=
 =?us-ascii?Q?Nxcb7CnE7tfE79YXUOGuPzBQbDQVNYQrBH15MbHlBzq8A3TYwxBcoN6UMks2?=
 =?us-ascii?Q?AjjZa9sOTI4eg91C0UA1OiVbGltOzXhPQ+vDBTZC4V9819sbUcHSZNaTBle2?=
 =?us-ascii?Q?Pl7u/jk8YEPW0hAMSqyMq9yn+3ilvIJp99dhh82Xw+pbj3eZ4bJXVPvDoZdz?=
 =?us-ascii?Q?ISR7LkXVFiQ4c/n8PKb5RU/xv7TOfY2Q34fRnTwulZVtasXiILnMxoBJhhwU?=
 =?us-ascii?Q?vguj1Fx/GQ1/TkBWDh7PZrv7rLFT6JV1Rxl5ZYZ4ouPvKKfjcVXKPCGoov9c?=
 =?us-ascii?Q?LOGYKoxDJOswf0puGFTGQljtW62US0SofW4uNbz0Ur++ISTqssJFZy72KAxW?=
 =?us-ascii?Q?vFCdEgRPYIyJ8E6I7hCgyAVi4vf9oOGQfEMG+DRsWAS7xUyPobAN2glPHbhu?=
 =?us-ascii?Q?/ynycTMWu67Q/7g7kDKkzKokf8akgsFyj5L+Ex9NyjWi8nRv5lonAsPZURWE?=
 =?us-ascii?Q?diyAPi4U98pDfDBHOFAuBVvyrxnOf3ibMNRe6uNMIzW/qGqlMrUmYqrI/IAd?=
 =?us-ascii?Q?DQj+f+z0L/KTDpWmAFnHJCt1vjxu6O5OetlwIeICWAKCxmn+rfrcdRU3CtuH?=
 =?us-ascii?Q?Zr+Zzz70iqdwk/FsdPQT9sW442t4F46x59S+z66ibHmPvMBXhcHgZpTq69Ju?=
 =?us-ascii?Q?qWt3lu9sQItGas4kI+CLwGlaRloOvRS5MD1OpHt4cx3685TRDKofLYRbkFej?=
 =?us-ascii?Q?jlvNMjTCxR7BtDBu67+sypRR2HQ8k2Vw3JiUm47y5IHwlQ5zaGqx8GONHNFR?=
 =?us-ascii?Q?tpdaqe7OxEVTCWWNreNmgGsc8yLSNsLAdASHbTudkGxX9UyIpoxdIvN4qVxr?=
 =?us-ascii?Q?YieKCZ92Y6gNvA23EsAA6ElXeAXp7aFFvlfY5FRv308poojfYe6I4hiels6b?=
 =?us-ascii?Q?M2nl8Bo+xoEkyIX2zyftEDAd7lVLgS3b0OpxjYoW9xermR7oEZgoY/taswbE?=
 =?us-ascii?Q?Bgt2f5IRtqn/4rhwBC7DNV3XlxIjK6nzpxizhFqVw/2kjqeo3ri2msHs1uEC?=
 =?us-ascii?Q?/k/bDqDNfvOTgmYpg9m9CEk=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 400fc0af-eb2d-4c7c-85ce-08dce854288b
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:18:53.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNw/SYi+T5hJzvjhboaJVrS2OlnSIbigywuRxfe6rrqasWWwgYBA98RYR9wdX1dJsQVetgJbcbE1+WI7muN/qYegdkI2ln6VWOJMERZFSOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1511

BMI323_STEP_SC1_REG was defined twice.

Redundant definition has been removed

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 drivers/iio/imu/bmi323/bmi323.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
index 209bccb1f335..b4cfe92600a4 100644
--- a/drivers/iio/imu/bmi323/bmi323.h
+++ b/drivers/iio/imu/bmi323/bmi323.h
@@ -141,7 +141,6 @@
 #define BMI323_STEP_SC1_REG			0x10
 #define BMI323_STEP_SC1_WTRMRK_MSK		GENMASK(9, 0)
 #define BMI323_STEP_SC1_RST_CNT_MSK		BIT(10)
-#define BMI323_STEP_SC1_REG			0x10
 #define BMI323_STEP_LEN				2
 
 /* Tap gesture config registers */
-- 
2.43.0


