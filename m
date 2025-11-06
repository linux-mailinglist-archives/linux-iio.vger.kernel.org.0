Return-Path: <linux-iio+bounces-25993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C00C3CDFE
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE46C188DA40
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94769350A0F;
	Thu,  6 Nov 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YFK7pg7V"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C93502AD;
	Thu,  6 Nov 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450603; cv=fail; b=EUgfiiBT4vQrt3EhrWkuIOQ9EgjtOGsktwAByWzOr9kJZqK0FHAkDx585SVIItV8c/6i/N8xyRfkZlhhNgyTvvRid4dVNz0Bp475hfpw8BoWC7UFidlIT/ICIW7tbCRQJBf67XP1Ob4avfXfubkGea3qCFi4hII96CJKiL8MwDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450603; c=relaxed/simple;
	bh=nlkWoD8YyAVNTCcivRKKKH3PHPyEh2kTQNun2husr1M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DAM4HXqF/HCjrlUFAPZ90j18CD5kcqje2lYwCAFRHC1EFM4eMJlCiNXE4jg0q3Z1LFRP65qLoq3AUlzBI0akn0MEmRUUKQA5om/3iUVdc4AwgQzGAEH79mLdcCjh6wDKmUCE43XVSDhQf854czlb2gEnSTbrUZ5JxevNg+CFlBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YFK7pg7V; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER5OU0P4ob0MVRGBmWNl3w6W6b+w5uyMQNCONIxERaCyxz1djGx6aQKTMgYs/ypY8cs5XI1IlPqlIIrZ65d7Jo8y3UJYdiJCLkj17ZCGTydTKkKvdjl54pL8d+kp5B6OYCV/qzKbx/B8gJjXcvjjO6DL51305qnRKNNijlr24llzseaCywmEhh5HXOWFcbqTJRr+o3UNJDy+RmlJdtevOfWDw9smp21dpu+eFkWc/EFUbrvinLERKzdAzvlwMYH0gqSVjLfktHUy9fYUI3kTnk/5wmooB/P0Qfk5GM9wDTDGQUD/sfpU/1DYmUrmzno7m+hCNhmLRLJvBVP2miLdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/Ow4rS8TiqNnKMV4r0PgyuBl8H+xEpH6vPp3UriCNk=;
 b=nxc0Dib5zawPGtTaNmrRIGqex8Nh5cq6RR4bY8czXGckFImK3qA6/cesFRTGRMSTYqAGYNqEVnkyuhmKIh3g439auD+NAQlnqk/PFXC4HapePTfVKk73WN6+PiYcPJZFq/oSu/WEm9UcTvqH8KpAbmCXPsaguZUOivXT0RttmP3is3NmGGnpitFF/clLMl2weva0LKlWiDGqyWnQXIwP6xBG18ukaIsfY7jiJ8IIRGn4+V4d00jL6miUIILdhwcYhYY7xNhe6jUO4/Mh8BGvY1JU+pszEJ+Xm8AD3OSKS5DJGJKnNGKajl+rfho1sp9vydNZo0FUoSpI83C/T5AwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/Ow4rS8TiqNnKMV4r0PgyuBl8H+xEpH6vPp3UriCNk=;
 b=YFK7pg7V3rUCh0KmLhO6gW/dxMunYl7vcePF9VVY7HJ/EV7XxkE8GG+CnC9gwxoB3wJHSH1cjiXxFxn9hXahCPwo46utzdMhnorf5F8g6n9ZA46TaIhN2Txz0HAsgwgzgesng03JJb/9ljGO1haw0JajIfCF/nbI85gCCANZBp2nOv9yHfH1Bgm+yumtZ4gR288s5StnHwlJYUXhCY84dqXd+WqwWTOyIIzYAi4KJZ8GAp//znJs/sOT5lwwjCTtVAI44nQgsda8tOnvFGDLviyd+Wp4IWy8BcCQGGOfwOMhQyVO3+VluVXDNHRgelVidwDZM1VRpuw8ZdcfM6PA8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:36:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:36:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 12:36:03 -0500
Subject: [PATCH v11 4/6] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-i3c_ddr-v11-4-33a6a66ed095@nxp.com>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
In-Reply-To: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762450581; l=9221;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nlkWoD8YyAVNTCcivRKKKH3PHPyEh2kTQNun2husr1M=;
 b=ST7+ufBtM+hWndwl9AyejmduWXkqJXj0f8nkc0RS+/EtZgT6WWYzVCziVf+HWxRbMjN9eH3bQ
 h3+0TAasaUaCc2A04XV5i1q3+T08otwY0b465Gj+D+lGMPzg3kUcUqQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0111.namprd11.prod.outlook.com
 (2603:10b6:806:d1::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10989:EE_
X-MS-Office365-Filtering-Correlation-Id: f62f7510-a36e-486a-9838-08de1d5b09c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REdOM0VVcFA0dVBIdTdqc0hlT295WmxIVFRQRjNvUmZBQis4TytuZHRmRmdr?=
 =?utf-8?B?VEY1MzhLQkpwR0dFK3MxSzlUb09md0w4L2J1Ny9PNFVqNlo0NkVNZmk4MTd6?=
 =?utf-8?B?dnEwSXFlTGFCKzlLdllteVp3ZzZzUmw1RTNackFEejVMY3hCNDA4WFdjalBV?=
 =?utf-8?B?OGJjU2MvVmhnR2ROOUZVcmJxejFFZ2VabU5EcXpBNHUzK3VBMHlDQjIyd2x4?=
 =?utf-8?B?dTZTSGtQUENaRWx6UWx6M3hnNW50U3RlUWFPWDJhYWVhV3g2ZSs1TlNTUVpT?=
 =?utf-8?B?MUZxM29WRDhvT0ZPRURkYXE4Q0QwbVdzbDRyYTJTSHVpa0FaWkwrYklKQ2dV?=
 =?utf-8?B?VEF1dmRUa1puWGI0WllGVWFMS0wvQnFoL2R5T2g5azhQU3lxZGlTN0l3ZC9X?=
 =?utf-8?B?STc0S0p1cnJWVE1pYi9aMEE5cHhMdDRBUnNCRTh5RHM0cmc3bEZxYjJOYTBs?=
 =?utf-8?B?NnRaeGRkbWJyUit3SmhwTklLTVpyYXVBbzIrTzdKbjUwamlTZC9MSHJjVUlu?=
 =?utf-8?B?Rkt0c1d1elFWN0x6YmdUdXNoRGtUeHNTREJoUUg1Uyt4SEo4bWI2SklveXNV?=
 =?utf-8?B?bncraFBjTHBXQkFuek9hRXdLOFYwQVgxeU94ZElSV25yY3NqTTlZRVBaRjBw?=
 =?utf-8?B?UVhoS1VrSWQ5Z2tsaVAwMkQrS2hKeWt2VjQzSzlwM2FDOTUyWDVXMjE3Vm9V?=
 =?utf-8?B?MktMeTJMZHdWL1VCUThBVmtFVk9YeDlmYjZ5VzhpbHhabm1aR0lkY0pyNHlz?=
 =?utf-8?B?NHJmVm85b25zT1V4WDJsZjB1MTBnRmY5SU0rMnFRaXdPWDVWdzlJaTYxRW5O?=
 =?utf-8?B?R2VSWG4rZDg2OU5hVk5qT0g0clhIcm5IWXN5SHZJZmIrN3czOFBLM2hFNHUy?=
 =?utf-8?B?VTJkSjc2eEdtNWZZcldaRWJJaTNpQTZLNlFyYVA0L1dKVFBqSnJHcEFZa0tS?=
 =?utf-8?B?Si9ZajhVd3lJMFdKRXFvam5LNzRZWVcvOXVKNkZIakxTY3V2WjJVUTJteWlh?=
 =?utf-8?B?QWYzMUJrbkZXS0Jld1FnVW5zeGJCay9LNStxazZhQnhUdWV2R0h3OEpEVHN1?=
 =?utf-8?B?bjROSEJYSWNiYUFYY00yVjM2dXVwSktnVnpiQkoyTVlUVjVVOE1zbUtybFlx?=
 =?utf-8?B?cU8rdmt4NnV6NWlBWnZKMzQvSXZOTDBiMWh5Znc0aTJ0aFJJaFNvbDh4WVBn?=
 =?utf-8?B?aUxDYWFiODZjbEdqcUFFN3gyMHpRcDBpZHpvcFhha2wwRDdYSDl6akl0cDEx?=
 =?utf-8?B?VlVWL0JDR2luaGpjQTBCZ2R5TG04STFoWDVhMGtxaGJnSnVpSVJqY2s4QmNq?=
 =?utf-8?B?NnV5SjVQZ1V0MDRPbS9FeUlCWkY4QisvVW5GWXNKQTd5QTBhQVBnWVk0RDN3?=
 =?utf-8?B?NW5neXRZd2VteWJQdStydU4vRHhvRktQUnZGZHB0UWxzSkRwbGRrQ1V5cHAv?=
 =?utf-8?B?dW9pZmpXT3JqS1NrVm1yek5aZmdZQk5mQldoZ3pLQ0orY2dsQzU2QURxekwr?=
 =?utf-8?B?WGxXY1poaVAvcmRTTDk0enpBMXRxKzlWV29ab21iU2VVeWpKMnBTQnFyd0V3?=
 =?utf-8?B?bjJJRk1qbFdDOWUzMnNNOGY2WVdJcmxkSVpZOVBTRUlGaFNiTkE3ZzJ4ZzNQ?=
 =?utf-8?B?Z3FVSUR4cE1zZVhlYllaeXRsNWZwcEJMOTBsbHc4V2hnTHp2dk9VcDZIdUxL?=
 =?utf-8?B?R0lVb21MV3o4TjhRc25XMTZwMEdPSVZkRnJlYzNBQ01iMERaVDNQODRUVW9Y?=
 =?utf-8?B?ZXhJbERBVjBzN2cxeVNJd0lKL1cxT0FIa0dsQWVLSTJYTDJES210NFIzckdG?=
 =?utf-8?B?R0pWK0xleXNWVFQ5T0hiQzd6QVJxbG5SQW5PTmJhQ01GRGhOZFQ1dUtFcVky?=
 =?utf-8?B?K09kYW9jOGZEbHpZM3ZXZ1luL2NZd1FPb3NwYmczWEd5TGNzcWFxQUNSNnJw?=
 =?utf-8?B?RFB2Zk9CSkYrT2Y2bjlxRTBmS1NOVXZmM3Bnc2E2dlA5RUY1TE1RWG4vdFJ2?=
 =?utf-8?B?NEJrQi9SR2M4c3lPUEM0UysvMmEwek9meVY4Z2Nhc0VzL2ppSUVNUGdsR3Yx?=
 =?utf-8?Q?EwH24/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRORnNRV1NkNHdURW9Obzh1bndvb1NZT3VHbXhNSExKR2tYbzViZ0k0dDQy?=
 =?utf-8?B?M01tWUNvNmh5VFo5OGxHSGVnM29vUWZWakwzTE1zVVdUdUI0UHpCNzBacUoz?=
 =?utf-8?B?QzBHNFh1dWIrSVNOb1c5MjNYUElZMmR2VGRRd08xdlkwVlNxK0dxenZBMGFj?=
 =?utf-8?B?ckZGZGhKWVN4OENsd1B2ZmdIdzZodlhCbXhXRkk1dzh0UlZpb2k1Vm5kOTVR?=
 =?utf-8?B?WlFvOXE0WjZoVWUyRzhVU2pQZjFYL256U3dkb1VYVlduUlc2ZkZJVG1xRHgy?=
 =?utf-8?B?MFhRS3FWZkNKTG9nV0Z3ZXQ1eFVHNG43WUVDaEd4dklZMlIxcCtVRzFCSGdk?=
 =?utf-8?B?SnBSdUpPU3ZMY2JNRnhSWU55YmphQlhzenhaeUxiYnBaaW9KeTRyUi9WQnB0?=
 =?utf-8?B?MWFxZEFDdHN2eXdMUkFOWDNsRVFUS0o0WTlyTFhwcVBNMCs1c1ZLOGp4LytT?=
 =?utf-8?B?b0dxWDZhbE9XUmhVSE1odkN1N0haN0NkUjhwdnNqQXNjRTFSU29IMSt5T3Fy?=
 =?utf-8?B?YzBjdUk0b0U2czd0aXpNUk5kdmt6dGtDbTNxMWxRaGZCKzVvS2g5Y3lzdEtv?=
 =?utf-8?B?UXk0MDBuQWdOMWpmMkdxYzBWZy9FSmtNbzdyNlJNenpwOEZmcDg0TnZmb0Vs?=
 =?utf-8?B?Y3hPYSt1a2Q1SWlqLzAzOTNVMnFRVmVMcWkrMmdLTmZKdERKR3IxMnE3YWRP?=
 =?utf-8?B?MExRREk0eW9rMU9wZjRlOExzejMzdUNWWG56TlF6TUVLdDlkK0MwTEZCQVhw?=
 =?utf-8?B?cHdIZmZLaFdtQ2RNTHY2N21RcWZVYXVJeWRmcEQrZzVFRzhIbnFZNTZjU0M4?=
 =?utf-8?B?alRoV1hIaGJSY09FTU43NEg2Z0hucnRsdkdQVWpreUQ3VVhub2xzV3gzK3d6?=
 =?utf-8?B?M2NYbW1JaFc1SXpsMDZoSTlLeWlRUkZjMVNEMmYvTzRheWNaaG9kM3VJUmty?=
 =?utf-8?B?aGVROUo3a05ydVJxZ3g2a1NwMkFMOVVHRXQrUDZEd01UQi9wS0YwMEVENWVF?=
 =?utf-8?B?dkRxOEdqUTZ5ZVBaOWVJVUZiZnRPY0hFSUpiRWdLRzVsa1k3STVIT3VlSDNS?=
 =?utf-8?B?SFU2ZE9BQkc2WHNja2J0Zm9XQ3dDSzVGTFdacWd2ZkFhUjdPUTJWeEdBY0Vv?=
 =?utf-8?B?dVkxQ3FINHR4MkxzMUQ1RmdUajVKdml4ODhHWmZqdGtkeU1vZExKejBpWWR3?=
 =?utf-8?B?TXlnNDlBenc2VTRGT3hTNExEVU15Ri9yS3BGdFVKOFpvbjVxVjg5QjVja2RP?=
 =?utf-8?B?T2JYQ2QvOFBIRzF6UEVkMG1wMHNIZytOVFZhQWN3NnZibG96VFQyYnU3WVFT?=
 =?utf-8?B?WitNY3RiM01BQ0FHQlVXcVY4NFVyams2OXV4VkdvSlh2RFpyRmxPYzdrRElk?=
 =?utf-8?B?ekdJSzIyZTdpM1Z0ZXFvcDVTM2dweEVBVkhQZGZuUTFLUlZUZWhSUFBlMDZj?=
 =?utf-8?B?dHNzaFFnVmtnUUV0L0MvYjJKWkptZzNES3JyTld3S0tJcGUxb1NFQzd6dFk4?=
 =?utf-8?B?WWNWUkJ2ZkVYR2wrQi9nLzRFSkQ4aVRBS0tNeGxFdWhpREx2ODAyUldpMytu?=
 =?utf-8?B?UXk3UnV5cklrcnA1RlZkb3M2UVdWUDhDVysrVmRiZmllZ25LeWZTZmJZQXNu?=
 =?utf-8?B?eUFrbHl4ZVpEMWE4eXRPUGdNRVBkVFpWd24yWjRtVWs4OE9TMUR4Q1pIdFhC?=
 =?utf-8?B?Q3ZaNlJ2OXRKY2FGUjNBaElZTkRtaVZmU1RDNE03cTVsazdwbk9YcmtNZkk2?=
 =?utf-8?B?TFRsS2VzZWRLa1g4RTY1cHM1a2U1NGhLRTJBTDR5V1FYZVV0ekJZYkk3Q2ZM?=
 =?utf-8?B?SzBrSUhYK2V4NTlHZm5CQkVsY2dEM1NhOEF6MkRTU3ZwcjZQSlBGclZJUGEy?=
 =?utf-8?B?NW1CVXhNaHZLYVlyZEJyaWhYTzFrUGZlZzdCeHFrcUJoM2hSbUMzU0xPNG40?=
 =?utf-8?B?c3QyU24wbHZ6MlZVYkV3ek1wZ1BpK3prTGVzUFRWb3VyQ0R2NGNPOU96dWV1?=
 =?utf-8?B?WHFaalNmOEo3M2N4cDVjZ05HTWNxajk0UnlHaXBQTEllV2V3VG5oTjVoeXlW?=
 =?utf-8?B?RDZoQlFjQVpuTlQ1MFZDdDVMMGcxSm9uRkJNWkVQa1hqMjlMNlVFTWQzOE1I?=
 =?utf-8?Q?97tsSmNcA3D8Wy+uUhUbvL/Kc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62f7510-a36e-486a-9838-08de1d5b09c6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:36:37.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jvg6/yf0n+a70AiHjmE5LjV+EtHRGyzjn/qoUNqVsz/kJCYAgU6ZEu0nEIzrk5oQz8BUPFtiCdqlipluMbKMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

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


