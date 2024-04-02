Return-Path: <linux-iio+bounces-3998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7F894E7A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 11:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3945B23E8F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5157315;
	Tue,  2 Apr 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="fFuRyEL5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243F1E525;
	Tue,  2 Apr 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049461; cv=fail; b=oFImUmtleZcJwukh6tooGNPzxK8mM/56U7E89ueWR5AGlegacTzvNr9DTiTaTNbCQsTmmHugA3/3EwoqtfGvYynvlYUZSweLGHq4kjLJB8ipKBGgLyifS5XYe1LzXKw0HwcngApIthJjVmwTb7rRTb1e9Mfbij4hv+fTDw0cEuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049461; c=relaxed/simple;
	bh=TPg2QkOKg63223nn7IVuEx3jMChUuzo9Vf5Ur/uN+5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tXgT8+xXO9XTcHFWFHVTDRb91nIeLe5SUZWN5HJiRD5/nVEZ42T1N5c4Vh43d7OVJjGUTt2g/tvv4z8z+xqh8/OwxNf6vh/MvyGzEnGCZQ2UZ6jUQe/SH92wMhRq0CKofkOwFzz5LBKzhE1VZsuf/JcR9IEQYBtLw9PqRBcU19s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=fFuRyEL5; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431MZkfb003135;
	Tue, 2 Apr 2024 09:01:17 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3x6c3jhwd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 09:01:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/NGEf/2V0nAepuuOCz8iQWoMS/IkjOX47sCwnXJMOU6WCCTzHmMUAsGZJF6nIliCPQTLSfi7dWqFomc92zINNSP9afJASTqjqSNtpS7CHeRPzdE71X+4/8ZEzGDRc+MSUC2FEHWH7dCPw3/UH7u9EC09JIASTIuzbVpY5wzECVLB9wTAJ6ZknWHiYyyaHXlUxCZBSmcAa0m8Fkg9Ok9lSW1Cmk4Vzpwu6FwdvP54UKT86JLjlo2s/Rusio4Q0IkW68kzAZk0mD6xuBD0ExTK8lqOrMiURLPJVXIexSK3hmEVv2ZXB3mZ2d2na2EINUsf29+R2gBBG3BCoxEJY/znQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRduI5j9/fZIeI4OQXmRcLdheeCKfWItFk9DFSvaDTA=;
 b=FzhklNobBc2Xyj0YDhvzaTFcEo4kWsNuG5tP92D8EwydRk3cn42FwjqYRX9Q1bRhabgcHbwyO3V+sRo03fGM36yMnoXpI1A0k5w3e7mKmd8RlvUZk4eGDsUz9jd9JGwF/mo2q+bQ0NAWW/KTFOVdfV8hVFB14AV/wDaKAnfu+ObQ6tVz7ybRcYmqCLap5/998rbrzPEArTibG4u4EnBRHVo0YYIjc9FIMS/npLsTAbt7TDXesmWaLvn8ghN0tSMA14kscUaK/ESk+NYD3I9nmWIvtg/4oYXa5E/UITVjrFzofVRmOs9nKde4F9lms8iNe2PR6fIY9VgnVWhdzHVGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRduI5j9/fZIeI4OQXmRcLdheeCKfWItFk9DFSvaDTA=;
 b=fFuRyEL5PX8fDdsuXAv+lQAwOMwRmFhM6lO/LKFKCHOtvquzZLOHvuPgXtFgtf6suySpggVXL18QcAgRFJUkxjGUg5Ml8ytRMRaBlni3mj5ziks9WjuWZZn5GC+VB32rQMpyPDLhaDNKE578/xqmc690QqTp5hDDsABpsQhyLJZDMkpgzJTFydNnMyr6bGztRtij+XD8U/HOFB0Pps7JN0ZtxALT6lQGr9nXqSi04iSgeGu8JJkWFKZEUx9u8sIhlkld8FunzSe9cuAy5NCqIq7/haq9xQyoGv/pZ4YqirvEJAzum1sOgZpal7ccxTnewCW/9k/Z2aCFfTngEZE6hw==
Received: from OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:174::14)
 by OS3P286MB2216.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:19e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 09:01:10 +0000
Received: from OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e47:e0f5:b361:f441]) by OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e47:e0f5:b361:f441%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 09:01:10 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 2/2] iio: imu: inv_icm42600: add support of ICM-42688-P
Date: Tue,  2 Apr 2024 09:00:46 +0000
Message-Id: <20240402090046.764572-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402090046.764572-1-inv.git-commit@tdk.com>
References: <20240402090046.764572-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB1950:EE_|OS3P286MB2216:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5zEyReXFZ8BVSa7uIYwlKDRKED3Ttl9YHXxIpCi/NCw6lVtzkE6yhsZgFWmViEFR9m/58CyjDzTu6gc34xWIxvJ51i0aw0JQIkwe/KWV40+QAJ/I67oBqcSNGzEiVlUll4Qu2fIU3aDliPCDouyj71ljqXkUUhZA0dNAGxDGC2S16gkjaJs8C9wti7Zcomp0lyfR1UvJS0NmLThFpmf0LKIjmn4dAxIWzfxhnNEyUBYiGasWrVizQK0rpFu97d2qU99T7oQiO6WMpWtJjIhBftPE71hfx8NlNZ9rqlompmNoFb/rWIIEvWBCu5t6zbhFPFg8r28VImebdsvxnVToSoRhNtDM6E9CG9C1FYib82vBUaYV01xNnfT+80unQ5GDVW3Hmy7FM7F6MMawH/MIZ0qcf7ePZmI7xKlj2C6H2OIohGfQ5BcOjpA8SHMNtWWPeRfrGEgOmdGBQyKXnXZSgEZ9cqLlLcxFiSwWj/1GVT8uDuphIDUE/RT7Lu6GAXIfC+N+CGsdLdlnkj4f9IY4AjMtLvkGijsc7baDjWNXHlk5RpSXXFwIUa/TAME6ug70p3kFQ2FhUY3npF+sVIQ8qfVQZnm+H+TjKw2DUtBDT8qtje9OPt5KvASA90nmI6NxZw/MnXdX2ACY+LMVuf+hUpNU1/fmFHfmBXUK6GcFyQ0OlJ7hrEIeiGmIY0CCLjVRLtnRJOrbIDtisoSkrIBJMgbHHvxhG2Xcz4gJbV4usJQnHm1q/fzveGrcsg2gOvvz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005)(3613699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mRLmfOpAL6PdWi7f4pz5LpER0wX8xClEInSLmR7jdcaEdloTnNxlIzLcUWDK?=
 =?us-ascii?Q?QTckAZXLkqd0pY35P5g1gNXwtllWzLUaMJZnXcs6RH1IyguztTWCcdlDn4To?=
 =?us-ascii?Q?j+tA1nbG+37ZL3jNZZwApU/T3CKadY53vFZmE3knKVzXuvE5sHqu7IZwhqrV?=
 =?us-ascii?Q?WeVFSqvdd0UxOhiR8XaxygeA1X5S5PwlmIZaYozOKiKAioUYvJ4EELMMdCIV?=
 =?us-ascii?Q?rF4jjqOS8m+c7DFODPW9PKNG4i0bWt3IrxuuJX9n4BF0toQM2fCo3SybzKTm?=
 =?us-ascii?Q?Oh4+aqzOoXRlrHCoqtuYRaYFsoZoQo1/ecKAJuoCiU5Rc2psw5O+8MgUVUmQ?=
 =?us-ascii?Q?8OjKP5PLbErDx8YE1Hyreu4aws87gkmTgavlo/kpIZLohzMXCfFavIPwfRu2?=
 =?us-ascii?Q?TLtJ2JuqNFab4DyfG/El6cpXM8BbUt93nRRQnVB7SptV9Sp5OK6IJ7MdSAk8?=
 =?us-ascii?Q?wqfpcKuAxSPoSFj7QJGhXuWILf47j/akKAOzsaQtWJvhXHT6jqbqsMrgn0DM?=
 =?us-ascii?Q?odFRvw2nrM5GtexhHPfIWlgbYP85WuwifXyX/mX5/Chbiv4oNhmagDAK6EI7?=
 =?us-ascii?Q?JxjbTGVEV1PNeEFjGcJJbnrdSzwNE8E0KTg1LszqNGuDm3rrXV+gIH6TooGZ?=
 =?us-ascii?Q?jqAjXVr37X/YplYASKZmO1+63sc8R1eWgaCmZ3+ovbg1fngc4/yBfGI0mabw?=
 =?us-ascii?Q?LnUMC2SYmWy8yUdQ0tA6bliVea787J2ZOFmUNt2M1IfUbgL4W4rLzWya6pbS?=
 =?us-ascii?Q?zJqd7EaCTfgDvYYGtVuP8Qd1zheRGNDRir5Dbzh5/BgvM6TQKZQ1duAbnFlw?=
 =?us-ascii?Q?0nuHqC8bxvvnGbJgagn2t+3ETLUf+WfsFQijaHy3h//q8oZv7Aa+pDfPb1NI?=
 =?us-ascii?Q?lzAytNEkxF1+2GhUWz2IHaURiMfzEdzkZXSXFRchbQHWXh/Y0EF1mlE9jjen?=
 =?us-ascii?Q?IP+Htw0IO1AFipaVObZ0XTyc3ilba9Hm5nAX1XPKPbbpoDYGkAjU37sEbgpk?=
 =?us-ascii?Q?u06iqUDd8R5S+I2BTBlzo2SPUFXBNr55rxaUugfgMokcpWBww4dP05ClORN6?=
 =?us-ascii?Q?n/qFXL8/mU4VAEtEQl6k4njfdo+7oAruiu+oDVoudElQy7XqiILTdMbHyC1C?=
 =?us-ascii?Q?PhUzfvSzR2wRc8gxwluWMs4h3Bngxq8zFW+qPxDoW4ElpSjMxFKkPHV9E7iQ?=
 =?us-ascii?Q?GFZt5QM2zkeKDt+wxeWhIvKvXRL8PP0nPHZwWjTaZ+4pnZtjB91Ud9lbyyXY?=
 =?us-ascii?Q?z+fc89yB2ETLvto9zyWU0uVWqrgoK9nruD1Y5D46kTpBcN4JVcvqZW5n2sn6?=
 =?us-ascii?Q?hMcMu9I30Fb59CLMAB9nLARmaUMeQzezxr3qErFx2Gei+QeRP/sbe4xoe8L5?=
 =?us-ascii?Q?fY1oHCtb2rcPzV3d1fbqnoCP/Y7eNUvkm4ykcGkg/SbvF8udZS/yRY/wpwq3?=
 =?us-ascii?Q?ZFvGqwNGxyoQQFCryMQamdrvx6TtpzNNyGp293XBWSOv4Pr8YE1m3dLxkVwp?=
 =?us-ascii?Q?F4yfofXYHbz31Fgm1VDTz4yOnxkqEYhz/H/5PwEbHNjVZy6F1xCOeL487Yw9?=
 =?us-ascii?Q?Pv1+Tz9s9FP6qmf+IteHI3G96QXQlv9GchuzPzfG?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6bb67e-364b-4c53-69ae-08dc52f370bf
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:01:10.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tn0ZvZcnctqzHhsRgKyBEv6hWGVOds341Kf42ZJe9ui8o3gEu5JG4cwGVj8MqjU+hbpIn/e/SBGM/KvGRsdPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2216
X-Proofpoint-ORIG-GUID: nzr9Gfqjf7uJbb46J2kQCK0-YDh6IzO9
X-Proofpoint-GUID: nzr9Gfqjf7uJbb46J2kQCK0-YDh6IzO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020064

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  | 3 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/=
inv_icm42600/inv_icm42600.h
index 0e290c807b0f..0566340b2660 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -22,6 +22,7 @@ enum inv_icm42600_chip {
        INV_CHIP_ICM42602,
        INV_CHIP_ICM42605,
        INV_CHIP_ICM42622,
+       INV_CHIP_ICM42688,
        INV_CHIP_ICM42631,
        INV_CHIP_NB,
 };
@@ -304,6 +305,7 @@ struct inv_icm42600_state {
 #define INV_ICM42600_WHOAMI_ICM42602                   0x41
 #define INV_ICM42600_WHOAMI_ICM42605                   0x42
 #define INV_ICM42600_WHOAMI_ICM42622                   0x46
+#define INV_ICM42600_WHOAMI_ICM42688                   0x47
 #define INV_ICM42600_WHOAMI_ICM42631                   0x5C

 /* User bank 1 (MSB 0x10) */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c
index a5e81906e37e..82e0a2e2ad70 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -87,6 +87,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_=
CHIP_NB] =3D {
                .name =3D "icm42622",
                .conf =3D &inv_icm42600_default_conf,
        },
+       [INV_CHIP_ICM42688] =3D {
+               .whoami =3D INV_ICM42600_WHOAMI_ICM42688,
+               .name =3D "icm42688",
+               .conf =3D &inv_icm42600_default_conf,
+       },
        [INV_CHIP_ICM42631] =3D {
                .whoami =3D INV_ICM42600_WHOAMI_ICM42631,
                .name =3D "icm42631",
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_i2c.c
index 1af559403ba6..ebb28f84ba98 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -84,6 +84,9 @@ static const struct of_device_id inv_icm42600_of_matches[=
] =3D {
        }, {
                .compatible =3D "invensense,icm42622",
                .data =3D (void *)INV_CHIP_ICM42622,
+       }, {
+               .compatible =3D "invensense,icm42688",
+               .data =3D (void *)INV_CHIP_ICM42688,
        }, {
                .compatible =3D "invensense,icm42631",
                .data =3D (void *)INV_CHIP_ICM42631,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_spi.c
index 6be4ac794937..50217a10e0bb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -80,6 +80,9 @@ static const struct of_device_id inv_icm42600_of_matches[=
] =3D {
        }, {
                .compatible =3D "invensense,icm42622",
                .data =3D (void *)INV_CHIP_ICM42622,
+       }, {
+               .compatible =3D "invensense,icm42688",
+               .data =3D (void *)INV_CHIP_ICM42688,
        }, {
                .compatible =3D "invensense,icm42631",
                .data =3D (void *)INV_CHIP_ICM42631,
--
2.34.1

TDK-Micronas GmbH
Company Headquarters / Sitz der Gesellschaft: Freiburg i. Br. - Municipal C=
ourt of / Amtsgericht: Freiburg i. Br. HRB 6108. VAT ID / USt-IdNr.: DE 812=
878184
Management / Gesch=E4ftsf=FChrung: Sam Maddalena

This e-mail and any files transmitted with it are confidential information =
of TDK-Micronas and intended solely for the use of the individual or entity=
 to whom they are addressed. If you have received this e-mail in error plea=
se notify the sender by return e-mail and delete all copies of this e-mail =
message along with all attachments. If you are not the named addressee you =
should not disseminate, distribute or copy this e-mail.

Bitte vermeiden Sie den Ausdruck dieser E-Mail.
Please consider your environmental responsibility before printing this e-ma=
il.

[X]

[https://www.micronas.tdk.com/sites/default/files/header/2024_04_TDK_Trades=
how_Banner_250x135px_96dpi_embeddedworld.png]<https://www.tdk.com/en/news_c=
enter/press/20240312_01.html>

