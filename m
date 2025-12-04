Return-Path: <linux-iio+bounces-26723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D1CA2BD0
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 09:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CE2E304D873
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE232572F;
	Thu,  4 Dec 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="XWyfSKd6"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023109.outbound.protection.outlook.com [40.107.159.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769EC322C97;
	Thu,  4 Dec 2025 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835299; cv=fail; b=Li9FEK3AEcO+A4RRcgOGjFFEx45z9gXCyjjxjQgi77r2JD7SasnzRY9YfkRNoBeakiLSu/V7U/ruedQxrlrXyXrPXZ8Ktbib6zXv784t6TlU2csZq8oL17fq8rQIA5lQWc8yUbXP9F610iQy6sc7pgSCR12s5s8rD4dVHdf5FO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835299; c=relaxed/simple;
	bh=XDmNUxONHo2ixv+vu6o1qTNpWZ9p+dJlYhpUk6T5Xas=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p6ZX7KeJIAcaveoMQQz+pMkyiopGRtyuYK0qec6tQQHjazcbw5naGzaaGHjji63XE/r00CQaJfu6bZcs/wQWYz88jsnKBYk0zQOcEQHpSzzmFTPwceY/QRjDVBd+4YnmZujARqcW4Z2XikmQ3Dr9DdO8YltB9sJnQFWQ/kp/mE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=XWyfSKd6; arc=fail smtp.client-ip=40.107.159.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0/6pTtV8GqBdc+tBRCiYMsm8eQBq1LPosHUN7Tt4WkRs9YjW2XD6pBG9BiJaNepGVZp4ItlyTiimEmbGtR6dZlBJKhvY9aKG8lbGh90m436NeLSszTyCKrj0AzVDz3KUgb51S4S/QI3XmsVh1XJIeR07NMyp1QpSy2MAARdcWWY6kLfS+Usb5IWLmyIeiSAHXQruaruJWujMaj7xRfsOpfdg0kG2I2w8BPmgugT9ogC6liopkTjCP/lyIwjFu07drPdvrncfD7l2m2tz55HWzzpBBHwhWNa71kz74dyUiuy96+Cqde7W4TCg8LVzWz2KJjea6SH4sqjb8DUHHXIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDA27qlafMvcEiZeDUteM1QGOAZYZ/hy7BGdb71w14Y=;
 b=r5wb7Rr6QD6jkPpD7lIZHyff4PlsgCRCgknzsRSgR77RkORfOAvRPRAVeShwlDldkPNeessnr5w5/4cmq3W8r0c3N4zSgOojDOUGJN/Xbux+cn0kHhRAh0c1NsTyejKOIdq6HAZfA5XpwoarmbkiI2FYfZ/sg1O+7UGBRiq9an975byaonU/vfOC5o3VwuJHU9qa8PGX4HyB9waGr1Ldkdo7M1uHDRJu4TwMjeQJC0sIgwdZuGD44gHohd5v07BxrNMKGvyDKebZvNfW8FIGUxzr2V8pHYhAd/SrmYpUxeY9al1O9OA+3wiHx6XbVC8necgpqRQEtKuQ7IcWWc7SqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDA27qlafMvcEiZeDUteM1QGOAZYZ/hy7BGdb71w14Y=;
 b=XWyfSKd6G9boFHTN6UUA+l2/kLMMh7clnRjQfU1UeJ2OxOWvBkjL6wnziRrCbB6Q9HP6pQ7URUpiPhkolCOo6yzrYRXxWEu3135rO8c0K3CcDWdLzq5bzwLp7rN0ZuUtXylHrYbPVirWk1eFPUF3VFmSh4wKT77itWM2SFGuxqwhwl9SDj1dPg2QeW/ABZDJ8jz8pAdOHjKKACaz5hqcUyHXV0muDcv7FlfeKRgevDVfJj4mVigwusZ+78M5djTRHhXEcjE6scXOS9rGFmqsbkdEGpdBYmug2Q6fZFfv3+E69e8lAcUs/nZB7PhnvQNyArvNhvb+0Bdzizf810Razg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB7024.eurprd06.prod.outlook.com (2603:10a6:800:1a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 08:01:18 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 08:01:18 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Thu, 04 Dec 2025 08:01:03 +0000
Subject: [PATCH v2 1/2] dt-bindings: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-add-ad9211-v2-1-a1561f977ee5@vaisala.com>
References: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
In-Reply-To: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764835276; l=1360;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=XDmNUxONHo2ixv+vu6o1qTNpWZ9p+dJlYhpUk6T5Xas=;
 b=vs0FRCiM55UV8xaimbA8ABsWLb28VlP8fo96WAoEvCFi+JbBb4/R+5geAk1Li02WmgsR1Dz5i
 Zc9iyxHQ4beDWRdPJaxEB/YJVhrMTZWiJgyvmt/3r5Dger2eUmhTDBw
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV2PEPF00003857.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:17) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed49e58-6ee4-45b1-d3ba-08de330b4dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGxGS1BFa0ErczV0WGhUV2lWSkVadjJHZTJYZUhRZWNZaWlrempiRTAxSWdx?=
 =?utf-8?B?TTJaZUJqaElTdDkwalowVWtGQXpMTE50bytwaUkvRGNGUVhJR2lwbVpQUDBx?=
 =?utf-8?B?Z1lVTHd1MkNUNTBidkxvRXJuY2cvWHpwUTRJL0Zlc3RaMlVIUGNiUy85K3ZO?=
 =?utf-8?B?QjRtVTJmTDRMb1N4YVV1V0NJZHZPd2dLR3k2aVBrZjdPMnE1STcwU09aUFNB?=
 =?utf-8?B?VlQybnB0dCtxSHpobDl4RThKazVuNHUvZlhXOUpEaVJCS1JVSlJZbWluWDQ3?=
 =?utf-8?B?R2VZSlA4eitVOUp0MHE1bVFtVlBEMmFOeGNYR0FTRTFQNjBwRkp1VnZhcmhl?=
 =?utf-8?B?bjdNbFZNL2NKbnJFUWZGMmc1N3FZekdTY1BJdU1hYUtSbG50amVyTEY1RWFY?=
 =?utf-8?B?aXRLK1hHNWJZbEtGUnJBS2ZKK1dKa3hESWpCNDdzMjljRWdrbGhNYkhJZmZF?=
 =?utf-8?B?djQvWHhWNDhoaXFiTGF0c2cxYnYxNmZ2RzVnTC83MFA4aGc1YkV4NTNuMjJU?=
 =?utf-8?B?Qnc1N2RVMS85N2ZCS0FodlVUQVQ2VjhJd2xWM3NSdUZNdWVDUXJmeWNmZXFD?=
 =?utf-8?B?MmpKRVZDRmtXZmZQSVRWVmVXS044NHlXWjFoNDVTR05lWnc3bEZPOTI5QWdr?=
 =?utf-8?B?MjRpOExjTFRPNTk5cVlOWHNyWDd4TWs1YnBmQVpBNlpVNDVlMjMxTUIwbStO?=
 =?utf-8?B?MDJLSEQzVmgwL3NZT0NacXZRcHJ6azhzV04xOFlKeDJ1RngyZGxqeUU0WFFM?=
 =?utf-8?B?Y2tsbGhJTlVINHU2emROQytFVHJJWWN6ekZYWXpFWG5LbjNtam1VYUR3SUNI?=
 =?utf-8?B?ZGVVcFg2K1RublUzeUc5cU5EYU5ibXRvc1ArZXhWamw1bGtOTlZJNE8wVUtj?=
 =?utf-8?B?dkFaL0szaEl6blFranVEUk1oMm0xTXB0MHorYVNCWlNab29xT3RXVE9oMEQz?=
 =?utf-8?B?QmpvcnJlZXFjemdCaGRmQjAxYzNTOHJVc2F4Rm9rMy8wL1daZUhPUXlQMGha?=
 =?utf-8?B?YWpQSTJ5YTJPcTNUTEw1VHRTTWszMHRaUjNJK1VMWmZ4OExCdWY4cXVjNmI3?=
 =?utf-8?B?Nytsc241K29BM0dFT2l6OGF1RnFlVTRhM3hsWWNlRmlNbTc3N0ZCRjJGcUI3?=
 =?utf-8?B?aXMwSmRTNXF0MnBHY0M2Tk9yeDdIMEMzT0J6R2JUVTdJZGxjeXd5VGFONHZq?=
 =?utf-8?B?NmovSnpxRDYrNktob1JjRGZwekx2QURtR0NiamtvU2ZLTjJaUEF2NzBRSG1r?=
 =?utf-8?B?WE80QjFmN3J0WE10Nm4xNFFmZ3ByNlJuUEIzL1EyY3NWNlR6bXZETDRLMStN?=
 =?utf-8?B?aWMwY3lTZDArbVFvZ1F2UnJyWmd4aWE5WTlXS1c1U0VpRHY5VG9NeWx1TkNX?=
 =?utf-8?B?ckZKbmM1VElNTGFOZ1JkcnBnb01BOGVSUUEyNU1DRUVBbkVNclREK21EdUJh?=
 =?utf-8?B?L21ZZEczY2lBbDdUdnhMVjNyRWsrQkdTR1hhNlp0NGZMUXZKL0dSNFFXTG0z?=
 =?utf-8?B?M2czOVR5S3RJTS9RSjhBQ3U3TW9XMDJMaUwwNFg3L2Q4ZzVjeW5EcmhQSEV4?=
 =?utf-8?B?VVVSaGRPV3Z0WlNUTi84ZWVCN0xqSG5udjNZbDFNT0tGaTZqVmNUV05ROWN3?=
 =?utf-8?B?UXJRWG5HbDBCUmRMVnh5S1pTWHEvTmdCOFpnNkhSU2FIY2xPZGVHci8rNjV4?=
 =?utf-8?B?akdEZHBTN1dTdXhCdjl4a1AzdnJBeXYvSVZFa2JrTkJ2NThWck9mK2hzSmhY?=
 =?utf-8?B?ZWNPVjgyV0xnazdJUkpuSmtDRUZUbzR4ZVZoeGQ0YlNQQUo2TFpHTjdSb0xh?=
 =?utf-8?B?M09RVnZIQUxncjByOU55WXpuQ2FUcWNSRUdqeG1jcHdCRkdQTHpTT0VEN0pW?=
 =?utf-8?B?VWFhU29uamN0VTl3UTVjWDNjaXFNSTc0ZnlERzVMajB3WUVlWEpETHJWdDVk?=
 =?utf-8?B?MWF3T1dzeEt0d1pBMURUQXRzbEl6VTBzbkVWV0todVlVc1FsemI3M3AvT085?=
 =?utf-8?B?SUFTRDFLYks3c1dzdmhOTzgxMkxqVHRzS010bjRSY3hqRmxKaGtEUFBUc2ta?=
 =?utf-8?Q?BG0WiQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDJUaEFLeXc3eFVKSW83OStmR3FLL1lSVnF4N3lJbWZjVGxkdkdtaDRKS1NS?=
 =?utf-8?B?NlNJZEsrQ1o2dGprdlFmSHNmSkRVN0kvOXBRTjM0M1E5V1ZNYnlVUklUWFVV?=
 =?utf-8?B?bzJuRHVGUXAraGZGaXZYSHFTekRQNWxGelZEWEhNTmxhZ1FLRzVxaDV3YWpB?=
 =?utf-8?B?Z1dZTzgvUkNpcTdIM0l0WFRBdkdQTngzZTM4Qm85WlhmcWliOHVDeDVMYnNz?=
 =?utf-8?B?TzU2eVdLdTV1RWxXOGttdzltTnhRREp2YTZBNGFWK0JwZ1pSM1AyNnk2WUp1?=
 =?utf-8?B?d2d5SmZxbDlQcGVoU2Q4TXExdXdBUmZWN3QxZk9TaERsWjFPcDh1UkkzbmR6?=
 =?utf-8?B?eGFoQkZiTlV1V3RIeVRPUmE2YmtTM2FobDlPVDl1aXRGT3FCTnNQMnk3N3lU?=
 =?utf-8?B?eTFWdVh1Vk1jRFlQaFQzbVg4VHdObkd4OWNHOGVxUHZuMjhTQlRGSE0xQmRZ?=
 =?utf-8?B?U24rdjd0b3k2b1pzN1Z3Y1JuVFV3WkJxUXJUR25QdHU4dC81ZWV6YWJ2WVRS?=
 =?utf-8?B?WFZHNUJIdkNYOGhMVVFLM2dwQUNMd3Y2SFpFWkRmS0lSdWoycTVFRnFSY2Jk?=
 =?utf-8?B?MC93RVBGa0JhL3hCU2h1NmNoUmg0d1pqVjUybXRaVjhpOUtRTnNqUzBXUWFK?=
 =?utf-8?B?aVREZW5ObGd6ZzZpT2dpNVF6ZEhTdDJVMS9wcU9MdzJJU3RsREdFZ1V2a2dq?=
 =?utf-8?B?N3NPSjJhT3FSQk9lY1E1Mk90K045T2wwYlVZZU51SjU0UGRjZTBxVGlwKzBu?=
 =?utf-8?B?QlB5OW1rRHVPc0pBUU14UjRkNEgzcW9ocHN6VTRySjllVlVKeWplZTNCRW9m?=
 =?utf-8?B?aERWREZPVDV4L1RGWVBEQmZKRDViWm5kK09oY0J6c3F3TFExVHBjdXhzVzY0?=
 =?utf-8?B?Unh2dWlTc095aDFyaXN0ZCs5UFFOWExVNi9ZYTZmOHgxS0V2OTJEcENvbHZv?=
 =?utf-8?B?Q2ZnZ1d4NmFoeFBUck83SGdSSys4dmJQUG1PWjdHV1ExNVN5anN2TnA2MEpT?=
 =?utf-8?B?RmtJeFRjNndETjFsQWpDWVJjVHF0NGJvOHNsNS9QaDFsSXdVN1pQelJMdjVD?=
 =?utf-8?B?R2xWb3JXbisvY0xuVWRLQzhEbjJjbVlONUYzckx5UFlJMk56QUM0SE9sZTFt?=
 =?utf-8?B?QklHY2hhSjA2Z1htajMwY1F4RzQ2Y0NOQmN0Yk5Md2pMNm84T05hK01YSWJx?=
 =?utf-8?B?QXN0cHRjemdjZ1hQeHRkQWtwMkNJNkZQMUdRUG10R1ppY0tDdnp0REJ5VGFH?=
 =?utf-8?B?QXBlL0QwMVpVUzQ0NjdnM2t6bmZLeEFkT3BvbU1Qc3FSZ1ZuNnU0eENiSitk?=
 =?utf-8?B?eG5iMGtiMVdmbzBlNHJnVkQ5akhDaXliY2xkZW5PVWpENUlxaFVobzNIY2FZ?=
 =?utf-8?B?S3V3WmlKT3ZWaDNsa3Y4YzR6QXMxNjhFZ2NXcGJYTVQwLzJncnV1dERlR09k?=
 =?utf-8?B?L1llUm5adjNiU1BDNmtpQ0dtTW1MT3ZJd2Z2SmhLK0k3S0JjRmh0T0xGY05C?=
 =?utf-8?B?RVhUd0lrTXYxM2xxdmdVOFM3bkJyb2RyOHRFSU56TEpKQjB0RFR3THdyOGdo?=
 =?utf-8?B?TDdiSGFBWHZpbW1yVFM1REl5WnJzQ3V4L21vVy85NTllbE9wSkVGaFBRdVFs?=
 =?utf-8?B?MS9GWHppZnNRanpZUnVSZk52c1dCdW1pVGxoZHc5TmlZQUVobEJuUnYrMHNU?=
 =?utf-8?B?SXh2ei9yaDhJOXpPbFlvMG80NHJUYnYzUHR4V3orUmlyWnJZUjdDajYzNUF1?=
 =?utf-8?B?azFpRXc0azNuNkYvS1pZSU1SbFcvVDhyLzZTMFlqV2VBQU1kSWE1c1A0c2pU?=
 =?utf-8?B?cyt2TXNBN2FWWUx0WUxsSjlWQ0xuT1NiTVY5V0VraEJ5WXBYb2JJcHVrWS93?=
 =?utf-8?B?MkxUWnBrMHhJZzVPNk55WXFVd0NZSjdMdlhWakV3aUhLa0Fyc0xGMDRXYUdm?=
 =?utf-8?B?aGRSakhwUmJpczRXR1FUV21kc1JEbUFhV25xL3Jrc3pWUlp4cHBxeldsemV5?=
 =?utf-8?B?eFpVcmJSQktva2F1dnlzb2NBdHdTTjdUUzZFZDJrRzRqY3JScjMrTGJILzAw?=
 =?utf-8?B?WlVKWEhJZG5YbWtlUTBSUzhXNzJROGhXRXZXQXUyQmtkWWxmeDZLSklUVVZJ?=
 =?utf-8?B?Q3pwNUdrOEcvZkVDeHdJUGNQUzdzNXlNcGs4RmxObk1uamhmRzk2RVNwZzZh?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed49e58-6ee4-45b1-d3ba-08de330b4dfc
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:01:18.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4azhMHel/dCWmUhDyKRVQwAv0oBkfY1Y2mOSfTnQWBu9l1ONpeypt3+GGkkzLdMZosHWznpZJ0juyiyVH2UlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7024

Document ad9211 variant as supported by driver. This has e.g.
different scaling values than currently supported devices.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 2606c0c5dfc61fd65cd0fb2015b3f659c2fc9e07..5acfb0eef4d5cf487adaa93ce5bda759bb4853c9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -18,6 +18,7 @@ description: |
   All the parts support the register map described by Application Note AN-877
    https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
 
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9265.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
@@ -25,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad9211
       - adi,ad9265
       - adi,ad9434
       - adi,ad9467

-- 
2.47.3


