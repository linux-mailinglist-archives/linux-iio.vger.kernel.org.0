Return-Path: <linux-iio+bounces-22976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC9B2C451
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CC9687ACC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BD3314C0;
	Tue, 19 Aug 2025 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dpI3aU3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013057.outbound.protection.outlook.com [52.101.127.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA908322DCE;
	Tue, 19 Aug 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607832; cv=fail; b=lHDmiDcjGuCkP8XM3O1Sy4D85+GMOF0goOpWRdLt1pcqG0c/mmAkpywJfg0PpqGl6yBAALdT3tCx270OzDFj8BL9xoaA3qreaIgomjwrZ6/9GEloC8r2tjJfKOiRJ3CG/gEgFk7AKHqpexDqS4oE6k3fCLEq36/gdBMNlhsx/p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607832; c=relaxed/simple;
	bh=ijnz6WQd8akV9IPPVmzOmoDEhoiNLby5SDesY83kz1M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t4mYOtYv4vxduPO4mXatD23QtuooEyHEQm8Dgi/PZ9Lx/Z2aH/9Rj0K0pn2YGJvkBV8oeRYk/OQ7jxqlxQje0JR8p0xx0lE42aIYDKJV8ngSjM1zN9nw7RCjrLZ3KV0K058idxpQr9HgeQEcV7lje2kzc+JKdJqkb2OSP6+lHPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dpI3aU3w; arc=fail smtp.client-ip=52.101.127.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNNlVEpZInknBeIZBqaVVruRoPj2L7H8S1dExorIe2iBxRlOA+K16n1u50iqrlPRedwpreqFKd8iVBRYN78NhTgN7kQ2y6MIKm/h+Y9uMywLkSj20OAOMMA6BfRiEFl7acq2XoXD35E7ZMBUuGMKrAQdItxt7FmHrbdtUH0pIVLzOkznZZJrUQqbf2FjjVKSq+BZp59t/tqbN+L2G4Bedmk8gPNhfSjOvkxCCiVykmpJ5TUtDkvK9HCA9iRm4PVPohKZW2WHfuQn1IlK54sguYYjSNH2QqRS4PSAb+wTiYO/U9bDZ41vVEFglKJ2IwyCsnL/QE8FqzczgV2XCRHHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KH8A/4+1PAYYwDbWIjq6wkRmpK2/IGsIxosdE5SltD0=;
 b=AgbFviPS54WKaiXxccKrS/dMAlhCN34xfqHsI8xrd6sP7MqeadkuFACyaJp8PVo2gWzULBfmPetsHMbZAGHQpZwgCJQgTpUzW4kgzijOvBybPKeza3ZkS51mOpsQ2oLtXyebGsI3ww1jcSRd0ZWEuHFejOTQOdvG5IZaP6OVpjyVLXJYa5gQNmw1KFXTwKGMVWAzcXfq9yMSovUeuWpNJZjOma1TvD92Sw/C5bgFFvz/QSQsJK0XHBEJTtluG4e4oajvylmNRJf7JOJCRNmytx8W6A4NAyon0Zsw00z9XQpsy5S6D2PdT7N4UuJJeR/dBdXJbgS0DbEWbRxpqewalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH8A/4+1PAYYwDbWIjq6wkRmpK2/IGsIxosdE5SltD0=;
 b=dpI3aU3wrRkMPUlfn3GsQNsNogFH2b+6RlH/TPROjW9prnnptqo/VaLz3iZ2S4UwzONkCE93NRiDbr7gTHaeKILBb1dnXbr/KYbbnx2CM5hYpN1RyUuxi0AZ7WdtWiSrU8coDGPVEf37Oyhdl8o2heQ7/TSkplKIzrxRQ5vCUsKgp9Dnah5e69cjGDEFCo8qA1qJ8kS9W0BaOOY5ZqySU7QHcB0eLTjmRfQNM/Vq0RT3CcTU+2Ki6UPx71IKfyvWOLLjyMfwL7g5NH/Mwplpe93rsgKGRKX3omjnEwhOvhpRg1n3DKH1hEnnUiyWOfg7xLsXj/EJG6W2pQNlMhaRjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SE1PPF7C5444CB3.apcprd06.prod.outlook.com (2603:1096:108:1::41e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 19 Aug
 2025 12:50:26 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:50:26 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] iio: common: scmi_iio: use kcalloc() instead of kzalloc()
Date: Tue, 19 Aug 2025 20:50:17 +0800
Message-Id: <20250819125017.635182-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SE1PPF7C5444CB3:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fce8e0-b64e-48a2-9b3a-08dddf1ef854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7f0gKQS8r4t7AP01ryYy6DoHlMpRiHA3Gl22QDhqeabHoZi/R+aTMfAEnPM?=
 =?us-ascii?Q?MnIW7IkqOv4HEIXdd/GqU+nzQujci5/YyEIRVwI9mqzC/lanFKiIqnH2urdw?=
 =?us-ascii?Q?xtNhuH6k6s0vJ18qqMpp/RQkxJt+zbM5hUNfx1s2SsARWbt1STGOBLDutUej?=
 =?us-ascii?Q?fM+vv78htjNgIr3LienjUfvQWa5XG1X9rZQetZGVQF3DpqBzjybAs3eZWf53?=
 =?us-ascii?Q?C4TJmHzEqG7jnO3IpVTpZ4Wjl2OlZmsNrgUOVA6OoLITbS0jFk/05reKIuL2?=
 =?us-ascii?Q?XK1uZS/kH4IN/kyDPtZ11OwXT7aUgaJpmt9H2KgnqXHZ67Md7ANovJ//oqGP?=
 =?us-ascii?Q?Oya9CC/zpFdwPhhcGOjoAqIMki8d58qPepMYrduVlqY9Lf/6uJV87Zq7ndJx?=
 =?us-ascii?Q?PL6kzArDJP0NHvuS9fZAUc6vWOpFy5U5jDqlSqVwFxJTkV57w0M/fESwJrV0?=
 =?us-ascii?Q?pzNQzWjNAQxk95yhtzVTpv/dqHs+0SKe8br3J0jtUPN9CEgwwp3aitTRll9E?=
 =?us-ascii?Q?8cKRFuyWxhrUW2k+7z3iJOpEFP+DYwyVc+xOivHmYCvw7fQxFE2ybjnkb2Df?=
 =?us-ascii?Q?TPoOHSkVjM1LUeRjpJwH1nKem0/uosX0FRFEJmk3dogpWc7OVZkHiwIZirS9?=
 =?us-ascii?Q?lWtHEXU6k8pA5N/xr9ZKDncOprIBAzVkfxJM5+HxeM7P7uUEHhYYlYA6YAgD?=
 =?us-ascii?Q?2d+q6fjZo/SdNawA4JIlMmuy+Ic0Hw5BmuTruLzgoqr6z1I7y7niutS6HDyi?=
 =?us-ascii?Q?DUDegKqpiKw/UNuse+sEKrhZqk4q03VRbLRAg3Ja+fKSGeXD11uB+W4e7QaU?=
 =?us-ascii?Q?JfeJGhMcrOGSnX7rALMG+LSawYbK2ULL5iLmWDbiWl/Ss9Y1FUQ58VrqiLpw?=
 =?us-ascii?Q?dr6Iy09xza7Jl8333DaS40NWOYK02Ux4qyS4fRxf9+bIkikh1r6iBXeH0DqC?=
 =?us-ascii?Q?RqalIrKU18KPRYO+jvtcHJfkDaDoTEkQljBi8UbQy2eWAU1js/Cr8yfTomoy?=
 =?us-ascii?Q?02Ixch6PBNCLO4LyfNE+9h02KjclabCT1MU+WtjG507D2OdBhFqYoc91Q+xf?=
 =?us-ascii?Q?IECQqBu/eEPokFP8RNF/y35vYX+OlJs0vvdZUPa7yfGdEscGS1ogzS9BssWY?=
 =?us-ascii?Q?U6kaPZJhktgrt6T3+gRYUwXq/YwEhTb0U4COKHOZGqgmZgq/WutIVu9b9tg4?=
 =?us-ascii?Q?6vDh3BA9xfMxR8eamw1HU1R7Wv9cqaSjrH3gpSRJdO0WB2IAQkyYbDW0xHUr?=
 =?us-ascii?Q?1cL6pLaFIAqCn0jI/f0DJZKOPKr1vBmwvsZ/EhxG1L9O4qCtbdpGLZaCjtdD?=
 =?us-ascii?Q?cs3rhxiTivEb+5StWPyvXKPE7hzy5FcegSHlu0azJRenJEuIU9Qu1RIV+LKf?=
 =?us-ascii?Q?54igNb7weciE+C0TL7SUUQn/SOYU1SqKPcu4MAlixjbDaqk2jGBsLpIs7WXZ?=
 =?us-ascii?Q?czQF9fTptZjSK6dJ82sHziKLgLvxxHKpkVgjY80/dHURnZ/04Yer6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iqy52/cC3JIGiX6PWhVnTyw5RGkwAgYqiOmnCt2ffIKlRKR4X3O/Ji+bb8lp?=
 =?us-ascii?Q?ifqVp8MBER9aiZmuD85akx1mCxnBG01NnIhotE+b2V+Owe2BKkKmuIyunJKC?=
 =?us-ascii?Q?7UcU/9qw4FVLTFUpglohwCJf7y5j0qEHxJFuPTZiVLiF8IBYbw7F2C2Gf5wG?=
 =?us-ascii?Q?p1JkjqlfnFivYe6nmL51C6lPo9zzbgisS35RD8IOmI+j5JZ6TGnLnSXqiIx2?=
 =?us-ascii?Q?WBGcgBcrm/HSrIYhrVZj62HJ/YplmuU2+1touAuldmcuLRRccPoF5tOqiLEH?=
 =?us-ascii?Q?yzYy35b1VhZ8qNTNF6OQ6PeFowIUg4+O/FSo6i/Ftbu1JsZs5X7e0I/L7yVz?=
 =?us-ascii?Q?NiTjPInxE+Lv/yhjNPXmDO2FMfL5yKwGUHzHoQp0mJUUto1Yo4o9+v/SHqgC?=
 =?us-ascii?Q?k3xMD+10+iEeNrs/0Uc4gJ5p0eeNndhCMIh7cJwGbC7W98K2AEPh9J4Cgp/W?=
 =?us-ascii?Q?EHsdS0MKX4oaimh3uDrWRYD8Cls+nkGG7mhunn5wGh68R2WA0BoW4Q0p4plU?=
 =?us-ascii?Q?+7Cua+M9Tsykx0fzvYmjguDSiY5CeIGwv/PRv3ZwEgbsLjUXhuQo2R23oxB/?=
 =?us-ascii?Q?kdKEdq+Uv2SqD8wVzPlljsdo0SrkkvS/LPO0T/REJjGhYMSIWbUglF8yEJ/v?=
 =?us-ascii?Q?rpmSGlqe6qygDMWFwtsFIMdL1lw3idJxvtM3NnJc1xDzAY1BZP4umjAG7r8j?=
 =?us-ascii?Q?huC5rO6JP1bHXL2bjk6OT/Wws6lrsqzjhuP+l/Hug/fq/90TsdLyFUD0bxjh?=
 =?us-ascii?Q?HDr5MidYbCVFBRs7EcEiHORkgZwq6IMdvnd3Yq61cMSFlnPDmBXLSS69+bvn?=
 =?us-ascii?Q?sTiGWrwhQiAv4t3lvbQgjr9Dd06mQE+D1cEZHERVEJS/evyjFsEmKFuV8HMw?=
 =?us-ascii?Q?QXSlfpCWXblGUMFpGF0CzD8GasqMn6GuQ5E6SIsP0aP5U2Gu6By944Ooq4pN?=
 =?us-ascii?Q?OZ0N2VV+cqP6qtDS5BkR0lL9ASzqeiNUbpcnabIGRgtJU9rtO3sqMgE2Vntn?=
 =?us-ascii?Q?9SGHiWfLv0ZfiG1PDGulwJ1o6hZJtsxMZtNEMHQV26SUxKtARlkrqdrHI7ML?=
 =?us-ascii?Q?9Jkbmkif6icIeNGtwg6IM2oNoTbXAE9vyezdo8NuLIs4jRngSLwyRAyrVUuU?=
 =?us-ascii?Q?F0dBh8LpOqyTjauuGUiq3Kg3yFVnpwG4OzPMk+HlS8fFnlBZuX56sEU6tM4+?=
 =?us-ascii?Q?jQnwvsEuQxfPUlL3nBMwPJFfpdjUheQbb7pPWNC3//mqHTYYhxTFovkGiyMw?=
 =?us-ascii?Q?6EMHqGgvy/mSjvwzrF0fHgv2hq5i9CC62HtyXQkJDUiCRJglsZ5ufrtZqVTL?=
 =?us-ascii?Q?dpLPMccswnGpI+CfQdXySTWnpHacxiXPoRJ+Pl3Tumg+h0VN0iQjPk908k/4?=
 =?us-ascii?Q?6DAsduDsx/vaFaDM2oyFX6JRqs5sNC3UgdK5nNNhntnxEGnweecf/t1i3ZMD?=
 =?us-ascii?Q?s331z9PpNjWn5Vzgbj6+brLXpJFqYksXYAldQ6gmjM0OCdzlfKQw8El0zfIL?=
 =?us-ascii?Q?Tn1+DeNpweTvqR2nldhYiaKzLJwfRVQ2mipxvAxesMSjQGAl5aAFHCf9muQa?=
 =?us-ascii?Q?Vyw5l2QedvHIsvCPTC//Hz4w0VNLQpqvFf0AY0k2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fce8e0-b64e-48a2-9b3a-08dddf1ef854
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:50:26.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTCGsTo2BSVufoGKufn7qIIvpnFHf2lJGzGm5xpFlsxrpH9aGEQrgd8gbzmubncFDQn+n7CFYfG2lEBXooiHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF7C5444CB3

Replace calls of devm_kzalloc() with devm_kcalloc() in scmi_alloc_iiodev()
and scmi_iio_set_sampling_freq_avail() for safer memory allocation with
built-in overflow protection.

Similarly, Use array_size() instead of explicit multiplication for
'sensor->sensor_info->intervals.count * 2'.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2:
Changed explicit multiplication 'sensor->sensor_info->intervals.count*2'
to use array_size().
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index da516c46e057..39c61c47022a 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -521,9 +521,9 @@ static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
 	int i;
 
 	sensor->freq_avail =
-		devm_kzalloc(&iio_dev->dev,
-			     sizeof(*sensor->freq_avail) *
-				     (sensor->sensor_info->intervals.count * 2),
+		devm_kcalloc(&iio_dev->dev,
+			     array_size(sensor->sensor_info->intervals.count, 2),
+			     sizeof(*sensor->freq_avail),
 			     GFP_KERNEL);
 	if (!sensor->freq_avail)
 		return -ENOMEM;
@@ -597,8 +597,8 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
 	iiodev->info = &scmi_iio_info;
 
 	iio_channels =
-		devm_kzalloc(dev,
-			     sizeof(*iio_channels) * (iiodev->num_channels),
+		devm_kcalloc(dev, iiodev->num_channels,
+			     sizeof(*iio_channels),
 			     GFP_KERNEL);
 	if (!iio_channels)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1


