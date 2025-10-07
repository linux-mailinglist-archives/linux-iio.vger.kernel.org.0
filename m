Return-Path: <linux-iio+bounces-24834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D01BC2971
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 22:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A5743508FE
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49BD23C516;
	Tue,  7 Oct 2025 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AR4kzLt0"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A2239570;
	Tue,  7 Oct 2025 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867605; cv=fail; b=baf9hoDHDE3Ki9+4Lpa+khmck6cO6Wmu9sfTvvFg8VZnTQqPqVKYPQZxuUr8sjeonbCHRkMijFkYHsbnRuwCivFNsx7HxW19E4nquTFly4uhbLiIsgseoufQQORPaHPgrR0KwWx8xSrBBEGmvXOV4rbxStNd34XInY0MpekCHMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867605; c=relaxed/simple;
	bh=kJGqBJ9Oc2TL1s2TZlf2DrNMptbzQj8dV32Wz7uKJwM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=I2LGG1Iy5CLnEaUKfGHNyGWHVG2eJqAtlqadU1njTRacovehM2ESJUrzz9T9+sFYGusNelKbonpPQZSIo4Cwp2AU7Y+7YdECYxGJ0J0QvVbNra0v65pIs5mcfPuNt5hWtYCAh0m2h2HXuK6FKHOjhnmXfUwEXgARUh362GRTPFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AR4kzLt0; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1d4bDWBfHQYN/uvUiSKoAMGm1hllBd/dBPGmzQb3ItAQo9a5RJHkNLxn9kMBaY8ARORwyhVGQlAvcq6ISGh/nABbcEcWmcQVF2GMixelVfTQxwWZdRndpVM9XXd13Am6XzNkSp9Fdj0vyhtibSyGzKZimrpTuRfSr88SdcMaZRwRR6pAlAG04E2/ZxG5/v2zVgYhB561j598UbsekjxkuXPuiCTyYCEMSNjGXyjC706+1e0jLB3aJbrWh0fT3ku8VJBAJbj/qgBLIfox6lHIqhzP3cBuT69vJ/rmESrf3aMXdZHQUccVqC5NtFxfZehMf1E0/AENfDbjR4DZ874IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCELxrpp5jAzdSYO4FA+kWQV0lFpQH/3JRI/gg6mvW0=;
 b=WVcZF0mhrzn9SmxOiVL7vYrvSND8y5E81dfgqqUu9TDBhfll6dEzVQLpy+hu6ZBRRyZcum4b6PRoh0Ee/881y2F4BXYuTk6A2qdITwPhMCX/SaoksgBb869qnP37gx/pTDze3elalytOqBWE6r5m/pxG3vCGAAlTGZg476OflGRazfWUzHe1rDrlEgbgfriq1CJ+YHuMfZQGlY0aXg88NeM1/uaGKfT2BjLvbVvhMo6vT2BNq/56kMA0wnJoPYlOjEWrq6EQTd8M/wIpaJgZFzTUjPszeM/xpVUkArXcMIdrycBNFCJnh4rE6pa/lEwrhJ/GRJ2xfkefvbpXK8lklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCELxrpp5jAzdSYO4FA+kWQV0lFpQH/3JRI/gg6mvW0=;
 b=AR4kzLt0I5WzwyHhN8o/Kka5yjW9h1PMlreVsXrH3eXbzs1opZNzU5sEhN2I0w6zTQibNJqhZn/Gp1fiq6/X2UX5bt8V6NFQz99doWSowCZgrdcnmQm0czEMM5/JarKhnvK+lCyzoqc0W1PYFThaPJ82J7usk/DUo+o74fsjshNHoZjPE/XMPBaa7JV2W/RvM0A+PXpoFcWG1kkxyu8aF8GtIY41FLwY9MjGwqhsfwr31DT2+qR5U/NDYbirmkE0ppSG+C5x05aLPGjkmGD9BmKTeYCNmrtATh+fwfrAScVUjdlbBPMQoQ5BF/mJGQq82+NeXXBfiFeiuthfa7pziQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:06:40 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:06:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/5] i3c: Add basic HDR mode support
Date: Tue, 07 Oct 2025 16:06:12 -0400
Message-Id: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRy5WgC/2XMTQ7CIBCG4asY1mKGAQp15T2MMbRMLQvbBkyjM
 b276EL8WX6Ted47SxQDJbZd3VmkOaQwDnno9Yq1vRtOxIPPmyGgBoE1D7I9eh95I7SytgZBjWX
 5e4rUheurtD/k3Yd0GePtFZ7F8/rfmAUHDmidcdoriWo3XKdNO57ZszBjUTWqojCryqIDaiRqg
 99KfigJRcmsmgqNb5E68avUWwkAU5TKSrqOXL5rY3RRy7I8AMw8eio+AQAA
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759867595; l=2562;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kJGqBJ9Oc2TL1s2TZlf2DrNMptbzQj8dV32Wz7uKJwM=;
 b=ZiN4DRalWhGofAEww4pPuL0r4qbteVD/T8YWMOF/0IIqodU8T2qw4BJlJ3D5XYsXuIzuQk21K
 y3pOvfwRMs6BQ8zb0sEuEBk5OBY7/QGxA8ev2MC5LRJYpPQXNDuCfny
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: dde53663-46be-4e8a-d1ec-08de05dd0731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnlSVXQrMUR4UHl1Q05UVktiMzNpdDVncFo2anFvNS9GVEkyNStjZG50MXNx?=
 =?utf-8?B?Rk5raWcyWEFLK1l0YWRMMm5IcGEwbk11MlhuTStwQnZCS3dXVmw3ZnNjMkMx?=
 =?utf-8?B?SllEVG1JWFQ4aGlXcHUrdmhKRWhiMlk0YzJFTVdiUW9MTFgreTI4WnIxUWFT?=
 =?utf-8?B?SEMwSFpxWWkxeU1kRmc1SGtVa2UyTXZsOUVQaFBPcURKZFh2OGpVeVgwNEQv?=
 =?utf-8?B?Zk13RUlUMDUzMVFwUlZEMC9oZi9xMEdiUDRCMkdEeU9qcGw3M3ZtWkZSSmpx?=
 =?utf-8?B?U1A3S1p3Z09OT1ZzRWhNUHhXTTB0Rks5TFFOQWdPQlVZc1FvcXZNUVN0aVRF?=
 =?utf-8?B?clRPamd0eUJ3MUFTYWp5NEluSkFhcXJsc0xYbjZ4NTV2ZHF0T3B3WE5mM0Rt?=
 =?utf-8?B?bkdYdmJId0dpOUM3RjE1QkFJUk5zT2gvc210R2JBaC9UZTd6aGtoWWd4ejQr?=
 =?utf-8?B?ZW56bGNqcXNBU2NXN0wrVFV6YWlXZzdxbzRGYUkzMUozQ0FYUFpxc1YzZUhz?=
 =?utf-8?B?dlhnY2NKT25rWlZqV200YkNJM0xBdTBJVGo0SGNqa3FsZm80S2hVMzQrc0Jn?=
 =?utf-8?B?cW85TGFYbUZ3aitoMDd2M1F4U0E4WlpYWHdhaHFKMXB0d0NlSDJHamlWTVoz?=
 =?utf-8?B?REhDbHJ2Y2NMOHAxeXEwZkZRa3VPK05tbXU5WlN6UHYrbk5UcE5teEJEZFZy?=
 =?utf-8?B?L3ZJdDZxVmp5dkJsYmR3YVAyc0FacG5CSktncjVIQ0FLeTlvSU9YZkhLWGhN?=
 =?utf-8?B?YkpXcTdOSnZrMzBxQnpTUk5US3M3ZkxZOGYvWWljbHVOb3U3TEYxY3ZLMGcv?=
 =?utf-8?B?UnRxSmYydlIxdVU1b1cycXJnMFc4Rjc4aFRhcE0vcTJ2aHIranVET2hUUUUx?=
 =?utf-8?B?OFdENm1CUzlMQlE1ZlJ4QmpMeXgwRHpFaVhTR0tUU3o2TFFtWEVBdDdFRmgv?=
 =?utf-8?B?dE9uMU1SYk1lemwzajdNSUVkbFg3QkQwNTlIa1RDT1pwQW5Pak5VcWdiMzRp?=
 =?utf-8?B?NE9ibHFRWjRGdkplOHdVd0huc1AxREdKTUVIYStDckpnQU1mTmZ6STBVamNh?=
 =?utf-8?B?SmtFOVpnY2N6T3QrYTJESmF4dHA2N2J2TG1qM3NsVVJIRXI4SVZ3Y2tUaTRT?=
 =?utf-8?B?VXgvVkhOcmkySHV2blNOWHFsa0hnNEpQQ2p6WDFMeUx5cG9FWFZQS05oTXVa?=
 =?utf-8?B?NzB1WDRxTkE3cGlOR2hJbmN5OS9za2JoTjc1WjBKQ0lkRzhiTlB3d04yamZx?=
 =?utf-8?B?M3hsTDNKYmVXTWRiVXoxdC83Y1M3ZkpJWkVFTEIwODZwQkJFaS9mMEpFREJO?=
 =?utf-8?B?eFRydzJESmxtMnJGZjJIQytOaU1kNzRTZEZiaE40bWRFa1h0dVlKK0o3S1lE?=
 =?utf-8?B?TmNodGV6U1lHeTZUSjcvTWJoaUZWQ0ZyZUhtZGZPV2lybkE5U2lteFlTQ28w?=
 =?utf-8?B?VlQzNktYZldJQW01Umd6ZzVBSDlUV210ZDhqSGxhMkpXbElBQWZhTEZoay9S?=
 =?utf-8?B?WDJtTUVva3VZd2kwbEZQdGZGR2pudjB5dHlud0lTajNMckp2SHJQU0t1d3ZQ?=
 =?utf-8?B?UHFqZlI5dmJpZjVTUTY3ZXVuWHVMS0pLMGpSQ0FpaHdpT1JBWDJoMHpXQnFz?=
 =?utf-8?B?QjJMTWZSdkdIQWNRSG5scGFwczhLcE1zKzF4TUFVcE5YZUxRTWhJbVoyTzNO?=
 =?utf-8?B?N0o1UnA1bWlhRjNleGxUbjhPOGs4bWtXcUJZZ0l0VFh5dy8xbmtTcjFzbFYr?=
 =?utf-8?B?MW1BM2xMeEptUTFnbGN5a2dkMW12ZjhqYUVmcXJ1SXFKWlpSVHlrcHhpSDFC?=
 =?utf-8?B?dVIybGlCdk9IMm5VeE14NTdNMFhUYTJmMjdMNkxJbFlsK0NURGZtZHRva29J?=
 =?utf-8?B?Ly9kSjMycytKQmQvL3ZydmR4UFF2RSs2c0J5ZlpjRWd3bmhJOWpTY2lWRG9q?=
 =?utf-8?B?Q2I1NDBYN0pGdE5rVDJUakwyZldIMjQvZFNybERnMGtPM1AwTmozOTZLdlFu?=
 =?utf-8?B?a1g4dE40b3F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdBTitKTzBPOEV0QzFmQ0N4aE5SOVhRc1d5cURGVHBvUk9hT1AydVdhWFJD?=
 =?utf-8?B?Vk0vWDJEM2c3aXNUMWJOWWgrUGZHYnJuSWJGM2VLbnFUUVBvRFNlVVlyNlBt?=
 =?utf-8?B?bTJBTHhFUG9yWnI3L0VhVTlnRTZzeEtGNHR5V1hGOHNWYkQzU2I4a1lZL3ln?=
 =?utf-8?B?Wmk4U0lTSW1GbG55S0w2VG1ienNvWEc1RHBiakwwOXhlNzJZVVJkdHRpVVNa?=
 =?utf-8?B?blA4U1RpcTYxUWNSc055S1lSOVJkQzlXd2VQZHZMa25ZbTd5VWdLVExXUDk4?=
 =?utf-8?B?TU41V0J5Mlh2SlVueGhWUWF2NGVoNFBwczFtaTZKWHRuK2FhSmx2S2g5OUpI?=
 =?utf-8?B?UlAvK0xYdzYwTmttYUs5Zlh1ZmNOUmJqWlVSSm5wckFheUVpRlVUZ0ZwZUE0?=
 =?utf-8?B?YnU5Smp4NWVvWWZSVzdKM2dpRGdLT2pFTFF5clF2UXBWbWRDb2JtZXVmcGtq?=
 =?utf-8?B?TmVUNysxQ0tsdENRNzJZajU0aGhEcy81VUNmVTZUdm05MTR3TUZqMDg1c2xC?=
 =?utf-8?B?MGdGQ3NvRkxVa3QrZnIzdXhqS0hsbmtQd1VaOWNOdVd1eW1KVU1XdzRUbkI1?=
 =?utf-8?B?bU1wOWwvQitEZWVseDU1aXZ3TURQVUxUNjYwNVR1Rk56bVBWQ3JiTm54MitE?=
 =?utf-8?B?d0JNZU0veUJGQmtOc25melk3TzViL1VPeDVpQ1lWQVd3UGFZTy84MFlCdEFv?=
 =?utf-8?B?QWtLU2xlUUZwYWw3RktlNFE2aEFaMTMxU2pmYzBrbUIvZG1Xc2VpUkJ0bjFv?=
 =?utf-8?B?YWRVc0xBUmZNbVFGa1hGL3pONTJyQ2tvRm9Cb3Mzc081RUJmMHJaQjEzSy9p?=
 =?utf-8?B?aVlIc3NVWS92aml5bnI0Q1dXMENrbmpSc0w0eVVDVkhsclNadHlxYXB3YjZL?=
 =?utf-8?B?SXdTQzEyeTUvZ3RwYzV1dE9tUDdWSllKOGs1ZGxwamhvWktieldPRVpxR3RW?=
 =?utf-8?B?NHFoZEtzS1B4YytXMUdFa3JzZnByNGtvMEVIZE4xNC8ybnp1cU02M2kvSjV4?=
 =?utf-8?B?bVYzZ05WZ0s1TXlES25IRUhXOXlOam9lMlUrZlZyaE1JN0F1R2dOY2dza1FX?=
 =?utf-8?B?U1ZNRTI1NHFUb2QxYnczbEhrSnFYaE1Jamc1RVNldmovTjh6L3VKSGlHMy9C?=
 =?utf-8?B?S3lxWmZpQ1laMXlBSDZMSTJjZE1FSDMvN0xsdHJ1ZDdhVzdTd1pqWkswcVgr?=
 =?utf-8?B?NEYvL0JEa09YS2d2T003Sjk1Wld2anRHN2R5RWV1TitISkRYYUNtcjNSQUlE?=
 =?utf-8?B?VGVvVGJnOTh1WjdlN2UvaXVVZ3BsZlI3SXgxMHpWY1F3NnhMOUozRVZkK3NE?=
 =?utf-8?B?aU1vTVpiWHNyNmlYTWUzSzM3N0dHUWFJRWZHU0xmek5JcEppOVc2dG1HLy92?=
 =?utf-8?B?dklyYTFlaFBHRys3aGRRbEFuK3hRNGk0YmcreTQ4eXZTMHgvYVhVUUJmdnVD?=
 =?utf-8?B?amVpU0tmeVlYOTlST2VCM00veEJKV1d6MnZiZVlyalRxQjVmOHRHSG5OL2pN?=
 =?utf-8?B?UmtLNTVrQkI2ZVdHdnl3STY4NnBVb3NBdWlpcXBadnBFTS95ZUJ0ZVYyYmdM?=
 =?utf-8?B?eEhyb3Z1OTRaZm0rT25pd0wydWFtT3ZzM0tzYnJLM3dsQTM4QnVsdXZEcWJR?=
 =?utf-8?B?RzJPS0NkNG9VamRJZXY5VTRuRWFaay9rTy83TTYzdzZ5dDU0dXg1SU84enpq?=
 =?utf-8?B?d042TG90bHRFdTNUTGZRRldCWWdvdExJNDNRdGp1Y1Y4UFl0eklCT2Rpd2Np?=
 =?utf-8?B?QTFjb2oya1k2ZlgxeHdiL1Z3TEt6TDh5QnJBZVlHYmxKM3JrWWZkMVhMaEFC?=
 =?utf-8?B?K21FL1pCQUN4NlZ5YU5mOG9QVjZ0RnlRODhrNXE5bmRub250K1ZwbjJGZi90?=
 =?utf-8?B?SjkzMThYV2hIUlE5ekR6enBWdHk1SVdCQWRPL0VXN2tuUFF5OVBBNDFwdHNu?=
 =?utf-8?B?dWM3b21QdlY1bGsyUGxUMEJDV3NiQmlERElSblVobGNQd1VCay95cFlId0FL?=
 =?utf-8?B?SVVXT1dCL2o5SzJnVXhSVjZIdUJ1VEl6R3hJR0xTeHVrY1MzYmU2ZmIycDJt?=
 =?utf-8?B?b2lCTUlJUGJodjN2allZbU42NGdkY2NZcjJvMFg5Z1JmYmUvK08xaWVUejA0?=
 =?utf-8?Q?NZXtMyf+LwM9QEhGY4C6dKU4D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde53663-46be-4e8a-d1ec-08de05dd0731
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:06:40.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8Yz47pWlIVw3Y2d7xXr5LmsQPqFLd4gG917xVdZud+f+uI0de6H+UsfwubGIJr7TZJJl4WPT6iCh6jmMOoTuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424

Add basic HDR mode support, only support private transfer, not support
CCC command.

Update i3c framework API to allow pass down mode and extend driver callback
function.

Implement HDR transfer in svc i3c master driver.

Simplifed HDR flow is (ref i3c spec line 5514) Figure 129

<--              SDR            ---> | <--- HDR
START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)

                                    ----> |
HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT

Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
read/write command.

svc hardware can auto issue SDR part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- Just realized missed CC mail list devicetree@vger.kernel.org and resend
- Link to v4: https://lore.kernel.org/r/20251007-i3c_ddr-v4-0-3afea5105775@nxp.com

Changes in v4:
- use master's hdr_cap to check HDR cap.
- add mmc5603 support.
- Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com

Changes in v3:
- Add new patch for change rnw to union for svc.
- Detial changes see each patch's change log.
- Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com

Changes in v2:
- Add sensor driver, which use HDR mode read/write data.
- change priv_xfer to i3c_xfer.
- Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com

---
Frank Li (5):
      i3c: Add HDR API support
      i3c: master: svc: Replace bool rnw with union for HDR support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  19 +-
 drivers/i3c/master/svc-i3c-master.c                |  96 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 579 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  34 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 745 insertions(+), 37 deletions(-)
---
base-commit: 5248ab97a6dd1dc6856422f6b1595baaf4fa85ce
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


