Return-Path: <linux-iio+bounces-25887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE09C31EB4
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A4694E9062
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6227056D;
	Tue,  4 Nov 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J7SiJWPQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101527FD59;
	Tue,  4 Nov 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271257; cv=fail; b=cb+KxU7t91Q9goZBh7fH9xdA5TAxqHsh1byXpY+CB+PWC2ilvJ5x3pwWH+1CIBAIZ4qFz3C8jjBsrlOvqbVoaEYsRN/eCJmXdoumdQsEp8SnUTMKyHrger1eToJH/UiyxlMTzVHyF6dBK1mn0d/mhqf2wrt2HUURozgLIHlTPaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271257; c=relaxed/simple;
	bh=nlkWoD8YyAVNTCcivRKKKH3PHPyEh2kTQNun2husr1M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CT8RgHcdCI4q87O/7wMXW9AJljDnqA5UKzO86ia5IvAxNt6JOZ6DRoMenuiAli6F6pM3BFi1/JADQJJQfYWgzq1kJclPKzm5H62UlbRhf0519X8hsAwa0B2OF2Nem6TOY+F1J8xckb4IlxEnlb6O/jkuKPLk6boEn6KVd2ze3zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J7SiJWPQ; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ2I4GVV7NPc92Gf0JjBDDYQSN05DXI30EerIji980h+9eHSZDSdxDuoNBXL1Z5a0tJ6Q4yJ9VJsG597TE8KqB1c3mA11nS3UkYYWw3KUIk87+LP9Wdp2/Xdg9pcdahwNGpn/vjwHun1P9Gzqb41CSKL/oH9hdEfsXkbflpVAESfF4fEBI2XtQpNY08JXxqdGr/bt7PCQtVGK0Jll6yKpV9STkSpRMHQyQp7HM5z5AuBmBmr+9/CZrwMeediGlMiPwDPF88UpcbU5aZh43BXarpXBv2SAd/CvGB4LwMhC+Ct11fx5Uut3bqKZ+fqSLtVc0Uc87/PcWJaMj3aLCo4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/Ow4rS8TiqNnKMV4r0PgyuBl8H+xEpH6vPp3UriCNk=;
 b=zFYBV2JR91M2nVZRiW95f431ti2ohpD+2779/QpSDjSUnSXsywG7mIlmT4R+ci9NF/1WDngPZwPo+YZJT/jb0k431XH3Lc4p5MvjPMO9ohVUHxhcfGWGSuNIiA0edi7IzlrsDNJKG6/St5zv59CtA0UQZedo9Ey6uX0IZdKIjaZgTXy65mVTvMmtUslrFo4p+RZvaHebOgRQvYhhF7RUTRL0lBcu5CEU/5ens7PNhjj1N++n6J6dMXs+8AeiWq0yFmTisrqQotXlZ8BJypKk6D4hs4YvcOer3ZoxU0SIACp/hCWLsmb0iCZADCPyHn/3KsHk4FYKA1SX/aGXL5oc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/Ow4rS8TiqNnKMV4r0PgyuBl8H+xEpH6vPp3UriCNk=;
 b=J7SiJWPQg4jc96e+D0dUQzE2UN45RU/ywgq2De06KiVaK/l39I0yUJHnIQdU07MRUT6Aamsg0bjyv8Ovp5TPxjVOUzKZCfPaCF5GdAZ8HK8hWvltzLAM8Gv8jFMPN8qtxaIcwKW3Kxi8ynhEPPEKRA41swrrDgNP93sMnytxlfzBpOhDdsVd1OFj0E8OC9K+7mvdqp+ZmFipS1M9fK2P21PxRXILBkICuOCBAn6Nq58l+ODfTvAgVjA66BbgHJVqOnGYPyWIgNhWU0k2qs16dyiLEopq2r0gn4PuNpAxX3xxXqlvVzhfSQ+M+sylT7EqXnrf+27vhOyWRQ8JPpwHlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:47:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:47:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 10:46:42 -0500
Subject: [PATCH v10 4/6] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-i3c_ddr-v10-4-e3e4cbc17034@nxp.com>
References: <20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com>
In-Reply-To: <20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762271233; l=9221;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nlkWoD8YyAVNTCcivRKKKH3PHPyEh2kTQNun2husr1M=;
 b=PucNrkVR3X0DjYH1VMenwejHPlpeJe+N4XmZjk9Bk+TbZ0RA+ZdM+kp6/ZaWuIihYh72/oUJI
 JNUQgKSIjefCwWmTKkltlIfbzN+RzGQDlYpEymhYVutHo5XGk35hVno
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e52a36-6f8e-45be-3dc3-08de1bb97813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmF6d2VCQ1V6K3QzNmlSZHp0cTM3SmxRdW1aMUJ4bEEwTHlTN0E4YjBrakhw?=
 =?utf-8?B?d3J6dGNpYXYxa05DWi9oUjNhMUIrTkx2V0dVTklMRm5DUFFWcXJnZEhMQzhk?=
 =?utf-8?B?eUEvSVZ4NE81WHNCdmdHWVEwSmxReW5CbENNajNyVElRTTVSclFid21JUTFj?=
 =?utf-8?B?SzVzTXdWVWNiUy80RytFVHhmRy9hK095cHNNUGdpbktFblMyNmp0KzV0a05o?=
 =?utf-8?B?dXhwYkpJM0l4dHNnZFZLT0pEcCtKc3NiL254OWhEcklsYWVBeElnTGVFczUr?=
 =?utf-8?B?cGk3NEk3VHRqbUg3TFVjdFh0YXBnQ2c1UUlvSkxqNjdHUHB3dTA4RWVkT004?=
 =?utf-8?B?T3E3aDRsdzN3NkNIN3ZFbGRsQjQ0YnFLRlVad1FzZVRhY2RXaW1ueFF6dGRR?=
 =?utf-8?B?b1RTanhCdjFyZWZjR0RtaUhQQjYwYXF2dnNJTkNtanpZRVRXZ1VsSGd0TGs0?=
 =?utf-8?B?b3pIdHBuUkV3b1JjUDRmVFFQdTdMV1Z4RzBIOURmeERjOXVZaExYRE9TeGlE?=
 =?utf-8?B?bDJPY1c4Q1I1cmw2UzFSNmZOVTN0QVJUMDlNcXErZzJ4OUtiZ3JJT0hVZW02?=
 =?utf-8?B?aEdhTldsZldaNjVGWVJacnRqanBjOGw5K25BV0NHZXVWK0FubjNmV2pianFw?=
 =?utf-8?B?RTJQY05DbjRhL01vYUtlcVFMSlc1TzJLMlU1Y0Nnb0JDZitrdDlCOEw4cTY3?=
 =?utf-8?B?M1Z5Tmp4UmJJdzZ3U0ZvT29PczhYNWtJc054RS9uUGRsbWJ5UjJmR3FvQng2?=
 =?utf-8?B?dm11UklqeXZ6QzFHeGh4U3krTUFMcTQwQ1FzelNRem1Fb2ZvNGVKWEVpZkJR?=
 =?utf-8?B?UzQ2MGtweUtpYmlCc29EWjJJakovQ3hJYkowNjhCakFxZkNUR0MwbWxnZGxv?=
 =?utf-8?B?dk56UUtKL1dOdHhuNjVkcEwxeGJZWE9Gc00rOExBZHFDU28zaE4xSjRnRWF2?=
 =?utf-8?B?N0JjVG1nZlFaWW5RWGIvUFpOOEF6d2dDS1d1OGxnejAxK1JYVTV2N3YvZzY5?=
 =?utf-8?B?TUJ0YVYwM3hsV0hocllBeHZLNHhJVE9zVjIvL3p2K0tkanU2b3lWSVkwSFBC?=
 =?utf-8?B?R1phbDI3ekp0RllvWlFpVjlJOTFXMlVUL25oamdsdGZOMGhsYTFIZnEzU1hr?=
 =?utf-8?B?NFk2Wm1MK2pHY3RZcU9YWlg2RGpKTDEvMGhZK2dLM0k0b1U2NXlRY01zaFNr?=
 =?utf-8?B?emhCaTlKazBXazBqTi9XN0JnYTV1QWpCVlBqWjVUR1YzcnZOd3ZaWjZqQ1Q4?=
 =?utf-8?B?UFovVFpmY2xCRHJLWU5DQVBzTGhLM1IvQmp0eG42dzNkZ0JaaEVNVnhMcHg1?=
 =?utf-8?B?N1d4aWRuaFgwV0MrVDEvd0lVQnh6MlY4bWJHTnNmMituOVFOQU1VZGZoMUVt?=
 =?utf-8?B?SVFWU1hKZDZtQ1owcWRyV1MyMHlScTZoL28zQjVpNE8vdHV4TDVxSU55Z3E5?=
 =?utf-8?B?VFJHc0JRNUl0MXVEc3lEbGQ3UmNoRVo1Nlg2Vm9VbHpYcHdVY3VBVzJHRUlS?=
 =?utf-8?B?d0p1TjIrWUEwakNpTU1FV0pCWnFZejdXdFMyZFlFRVd3Y2F1MGYwOTZJT1pv?=
 =?utf-8?B?QjYvL2Z1aEEvakg0K0lETURqTzNjZndESVA0bEtWR1N5M1d5VG1wUHR0SjBt?=
 =?utf-8?B?Vll5dFNjTGhWUDR5ZlY1RCtObGk1QXBQRVJHSWorV09MUiswZ3ZNOTFSWWdn?=
 =?utf-8?B?Skc1ZVY1Z09XZGZLaG5wZmFObmtaZkJXT3hMZmJuOU9ibE1oQXlLTk9TZUU4?=
 =?utf-8?B?Vzc4TmlLbEJPcGVOV0JQa3NQTytydVJJNVV1cEZNcTRrdHkrZWFMNWg5cHVh?=
 =?utf-8?B?ejRBL0VSTWpCbHVqRXcvU3BGbW9HeUlCUitmZXJWSlFrazZ5bEJ0RU9EYi94?=
 =?utf-8?B?QlJqT1RVYTVjcnFNMmg1WUNBd0ZwS0RvNjdjcldHWEhvMGxIYjV0ZHd4c1E4?=
 =?utf-8?B?NlZnQkVhVXJ4Y25pMThmNjdhUWo2cmQ2cVlZb2Vldlo1S3MrREwwVG11WHpt?=
 =?utf-8?B?VjZzUy9MMW9vUm8vT3Z5RXRNQUUwNTJHRlBqajgwZGVSYmZ6TzJxMFJ6Tmhq?=
 =?utf-8?Q?Y6PMPi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRzekpMaGVmcmF5UmJkVHJUNVYxOTZkdnFheUFNam0ya2JSRWtiL3ZlWDhT?=
 =?utf-8?B?WkYyb3dsRFQ4VCtqSWUzelRIOHlyRlJkbGkrVjRlOXNHTmEvVDc1TXRPekZv?=
 =?utf-8?B?bC9hM1VoUkNIUzZkVE9FVCtqRzVRY3dPY0R1dzM1Uy9xU0RNOGlEWGx4OTl5?=
 =?utf-8?B?VzU1V2NnUkxPL3FtL3kvTmtwa3djenIyZTZBTUZ4d01FOVVGNVVMSW00Ynl2?=
 =?utf-8?B?WnpQRG1RNUFhTW8vQzlzc2FBSmhwZlk2d2NXRkhoZnFDYVhtVy9VOU95SlRH?=
 =?utf-8?B?clFDMk5MT2VVOE5UUUlmLzJubExueUJkaEVSKzZqZW1FWkg2akNVVDFJRlYr?=
 =?utf-8?B?Q01ZaTNQUytkaFUyejdITGs3UXhwWG9KYTVSYWdtVjJhdWkzcDVmaURqR21K?=
 =?utf-8?B?bWpXdkJyemRmaE9uSUJZUUVpMm16Znl4NUZjS2M0Z2x4VUVmdllCWHVzc2d4?=
 =?utf-8?B?cG5BL0hROGZQUElqT2YrK0FMZnRoVkVJYmY3MUROU2ZyOWtvQ0JYeGJwY1F2?=
 =?utf-8?B?dGRidmkxbVpWbjgweFJyQ1FkMXEzR1dzK1FqRlJ4OTNxUC9xbHlCNTllQVho?=
 =?utf-8?B?NzdENktiRnh6NFRROEVJWkQwNEZTbERRNkNpTWJYQzhnTURPa0hsYTRkZHdq?=
 =?utf-8?B?Z2xZSVBBb3h4NXBHZUNRVFJUMkRObHB0Z05OWnVNYjJtMjJtWk93VUJ0T0Fo?=
 =?utf-8?B?M0kxWUFEWVcxZ2JUeUIyZmxkb0RPRmYyazlKQVZJNVVQNDZXNHpJeDc2OFRB?=
 =?utf-8?B?Y2JPZTJaYzY1VGtqTC9rN0IxN1Q4L1BsRjN0bTU1SnJGWG5FU01JL3BPQ1U3?=
 =?utf-8?B?U3pwRm5laDRkdm9XMGdsWXl6MlBiTUVQanh3NWsrbndmRlRuejNjRHk1dFVH?=
 =?utf-8?B?Q3Q2dzI0KzdObHFCUENuN25uK3FYK3B1dVBJRjFybWwwL0k5ODk4ZDI1Yk91?=
 =?utf-8?B?bUdMcTRjQ1NtM2hzdDN3T2l6WWRsR3kyQUFSUHE1NTJ2b1BvVzF1cXNwWnhX?=
 =?utf-8?B?Q3JLa01RclJxWVV0NDROemtZK01PMjQ4V3Q4YWI4cHBwM3k1M3kzU3lMUCtJ?=
 =?utf-8?B?UnIxblpNazBOMzRoZTVBcEtsNU5LZzVvZW9pdjJSMlUwQ3Z1WXpYY1piK2JY?=
 =?utf-8?B?QlBudXhtZnJQYXpOR1ppbHhVdmdwR1MrSm5lTXlaNDhhN1E4MlRWd09YVllv?=
 =?utf-8?B?SXFkaEtDWEZtcHRzdWkzblZBelVpOXMxTXBlZTE3bFM4VmtVeC9kb3VLbVFm?=
 =?utf-8?B?a3h0eHd3ZXVrcmJsRnl4ZWhXbHRra3diRjR5Sm1wa2ZHTDQrNVJjcWJ6Rzgx?=
 =?utf-8?B?eXhRSFBBSG1TVDhGU0pKQjdoc1dGcTBIalNrejFkcDl4M01ZUkZHNGlzUkd2?=
 =?utf-8?B?a3dTenRsK0JHUHdaV2FRZ0diWkl2cEM5bGNaYUl6LzFNN1hJWjgvRm1qS3Qr?=
 =?utf-8?B?aVYzTHV1eC9icGxlaU0wSUNpWkdsdmFRcUNiS0IrQldySFRxc05vZCtZeGxp?=
 =?utf-8?B?K0JNNk5hT0lOM2lQT1ZHYU9MWWd4aWhORDNQRGNWQWhLSEEwbWxEZkdEZi81?=
 =?utf-8?B?R0dtVm1ORE1WUnJLZndnd3NKWFpYYVRReW0vblE4d0hvNlF5bElhcjM4bGU3?=
 =?utf-8?B?RndIZ3JYUlJmVEVvVmt4b1dPYWZwbUk2c0ZxVUxMV25VWEloQ1JTc0dkanhL?=
 =?utf-8?B?K1Z4dVJxQlF2djViL0FXWnhtRWF2aHYvUVpicFlZSE1EcFhiamZuWnl5V1hC?=
 =?utf-8?B?ZGR3b3ZqeXdYVEpxbTFjaGFRYWlaK0pqV2RKdlJkOHluekUzSXUwWmpvRTgy?=
 =?utf-8?B?RmQ1N2tkYzg0ekYzWElyZkU0VXZmKzJJWEd3RjQwYkJQeXgvZ3ZadDZPelY4?=
 =?utf-8?B?aGkrcnUxM2owNE5Lc3lSSlJ0Z3JmR0lmMDVTYnEzYUIzMGhnK3NLMFRZTlow?=
 =?utf-8?B?N2d0cW1ReHRMZVg2RFpkQTd2WVEvT1dUbktyeTZaMUxQRmxNanFOT1ppL2pG?=
 =?utf-8?B?Uk1mQ1BidGY2aGJPbE0xMVQ0MTNCZUpJU2FOaEZ0WTNPZU0zZXVvQ0dkc2c3?=
 =?utf-8?B?aFhEV20wdDZWYTQ5YzhsWWNGUUdaRTNZYnRDV3VFMVc2VkVUOHZ0NElQcDJu?=
 =?utf-8?Q?a8/s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e52a36-6f8e-45be-3dc3-08de1bb97813
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:47:33.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EvTgh/Ee0v+T7o2Ey0PcfmQGNOKsz++mbfrSIZ5dXcm5x91sPa/r+DaBatQQ6VqZsv0EQszbMQ33J5ZU5qwtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

Add basic HDR mode support for the svs I3C master driver.

Only support for private transfers and does not support sending CCC
commands in HDR mode.

Key differences:
- HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
distinguish transfer direction.
- HDR read/write commands must be written to FIFO before issuing the I3C
address command. The hardware automatically sends the standard CCC command
to enter HDR mode.
- HDR exit pattern must be sent instead of send a stop after transfer
completion.
- Read/write data size must be an even number.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v10
- remove !! at svc_cmd_is_read()
- move comments "IP" to next line

change in v7:
- add comment about why need check return value readl_poll_timeout()
in svc_i3c_master_emit_force_exit()
- add comment about why need udelay(1)
- remove reg = 0;
- chagne to use readl_poll_timeout_atomic();
- replace all i3c_priv_xfer with new i3c_xfer.

change in v4
- use hdr_cap.

change in v3
- rename to svc_cmd_is_read()
- rename to i3c_mode_to_svc_type()
- use local varible bool rnw to reduce change

change in v2
- support HDR DDR write
- rdterm unit is byte, not words (RM is wrong).
---
 drivers/i3c/master/svc-i3c-master.c | 96 ++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7c516e05d0a1a118479ee3d8ea8ae37ae19fea57..42f678eac5b788abf7688845894df7b56ac08bec 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -40,11 +40,13 @@
 #define   SVC_I3C_MCTRL_REQUEST_NONE 0
 #define   SVC_I3C_MCTRL_REQUEST_START_ADDR 1
 #define   SVC_I3C_MCTRL_REQUEST_STOP 2
+#define   SVC_I3C_MCTRL_REQUEST_FORCE_EXIT 6
 #define   SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK 3
 #define   SVC_I3C_MCTRL_REQUEST_PROC_DAA 4
 #define   SVC_I3C_MCTRL_REQUEST_AUTO_IBI 7
 #define   SVC_I3C_MCTRL_TYPE_I3C 0
 #define   SVC_I3C_MCTRL_TYPE_I2C BIT(4)
+#define   SVC_I3C_MCTRL_TYPE_DDR BIT(5)
 #define   SVC_I3C_MCTRL_IBIRESP_AUTO 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE BIT(7)
@@ -95,6 +97,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_CRC	BIT(10)
 #define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
@@ -174,7 +177,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
-	struct i3c_priv_xfer *xfer;
+	struct i3c_xfer *xfer;
 	bool continued;
 };
 
@@ -389,7 +392,32 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? (rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+
+	/*
+	 * Not need check error here because it is never happen at hardware.
+	 * IP just wait for few fclk cycle to complete DDR exit pattern. Even
+	 * though fclk stop, timeout happen here, the whole data actually
+	 * already finish transfer. The next command will be timeout because
+	 * wrong hardware state.
+	 */
+	readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+				  SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+
+	/*
+	 * This delay is necessary after the emission of a stop, otherwise eg.
+	 * repeating IBIs do not get detected. There is a note in the manual
+	 * about it, stating that the stop condition might not be settled
+	 * correctly if a start condition follows too rapidly.
+	 */
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -521,7 +549,7 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	 * cycle, leading to missed client IBI handlers.
 	 *
 	 * A typical scenario is when IBIWON occurs and bus arbitration is lost
-	 * at svc_i3c_master_priv_xfers().
+	 * at svc_i3c_master_i3c_xfers().
 	 *
 	 * Clear SVC_I3C_MINT_IBIWON before sending SVC_I3C_MCTRL_REQUEST_AUTO_IBI.
 	 */
@@ -801,6 +829,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	info.dyn_addr = ret;
 
+	info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
 	writel(SVC_MDYNADDR_VALID | SVC_MDYNADDR_ADDR(info.dyn_addr),
 	       master->regs + SVC_I3C_MDYNADDR);
 
@@ -1314,6 +1344,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+			if (ret)
+				goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1407,7 +1447,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1420,10 +1460,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR &&
+	    (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_CRC)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
 
 	if (!continued) {
-		svc_i3c_master_emit_stop(master);
+		if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+			svc_i3c_master_emit_stop(master);
+		else
+			svc_i3c_master_emit_force_exit(master);
 
 		/* Wait idle if stop is sent. */
 		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1433,7 +1482,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	return 0;
 
 emit_stop:
-	svc_i3c_master_emit_stop(master);
+	if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+		svc_i3c_master_emit_stop(master);
+	else
+		svc_i3c_master_emit_force_exit(master);
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1480,6 +1533,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
 
+static int i3c_mode_to_svc_type(enum i3c_xfer_mode mode)
+{
+	return (mode == I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_TYPE_DDR;
+}
+
 static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 {
 	struct svc_i3c_xfer *xfer = master->xferqueue.cur;
@@ -1669,9 +1727,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1679,19 +1736,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct svc_i3c_xfer *xfer;
 	int ret, i;
 
+	if (mode != I3C_SDR) {
+		/*
+		 * Only support data size less than FIFO SIZE when using DDR
+		 * mode. First entry is cmd in FIFO, so actual available FIFO
+		 * for data is SVC_I3C_FIFO_SIZE - 2 since DDR only supports
+		 * even length.
+		 */
+		for (i = 0; i < nxfers; i++)
+			if (xfers[i].len > SVC_I3C_FIFO_SIZE - 2)
+				return -EINVAL;
+	}
+
 	xfer = svc_i3c_master_alloc_xfer(master, nxfers);
 	if (!xfer)
 		return -ENOMEM;
 
-	xfer->type = SVC_I3C_MCTRL_TYPE_I3C;
+	xfer->type = i3c_mode_to_svc_type(mode);
 
 	for (i = 0; i < nxfers; i++) {
+		u32 rnw_cmd = (mode == I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
+		bool rnw = svc_cmd_is_read(rnw_cmd, xfer->type);
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
-		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = rnw;
+		cmd->rnw_cmd = rnw_cmd;
 		cmd->in = rnw ? xfers[i].data.in : NULL;
 		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
@@ -1890,7 +1960,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.do_daa = svc_i3c_master_do_daa,
 	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
-	.priv_xfers = svc_i3c_master_priv_xfers,
+	.i3c_xfers = svc_i3c_master_i3c_xfers,
 	.i2c_xfers = svc_i3c_master_i2c_xfers,
 	.request_ibi = svc_i3c_master_request_ibi,
 	.free_ibi = svc_i3c_master_free_ibi,

-- 
2.34.1


