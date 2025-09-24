Return-Path: <linux-iio+bounces-24414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D7B9A40A
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5663B7DF2
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11C309F0D;
	Wed, 24 Sep 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tmgq2A0c"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814F3093D3;
	Wed, 24 Sep 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724228; cv=fail; b=i+EAAc14uV/Pz5nbca8/iwJo3oVNqk/bdfcjIAhpJNbvre1ZMCNv+IC18qWGIi6KpSYbpoW7IKyNrZr4DlmQVwZix7E+G09N9pJ2Ds0bU8BlNbUAGaCb0jZQvMXoQJl/wCNQ5FxfH2Z/eAvtdz1dcyVnnbi1CSf8hqQKx5WN8rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724228; c=relaxed/simple;
	bh=Wn33yvLfzVS1x/wyZkwAlBReMosWj9JdoWilKNLmxX4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nmqypaU6r8eFZx4BL8bHOv7Fn86fKK11xIB+QaECOZsrUkiD1o7qnVMzQK0RcHeFWLr1Hn+xVNUZr0dqLYR3iRuk1iRoLkywbdMoGD4II7TEEQiJdGCX6ql9HeLmAwtSo+wNyK4cCCdFg99ivJunLlU4Mosv8aYe++yXqiURy14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tmgq2A0c; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChP9N778z16FKlz2COZ7kt1plZmGzIoBF8nWPqlkdrC8TKymRFyeWvaL8UBbMhuJr5wqxieN3Mbo0EfpsQjABhSC7zH3Yk+yL61N1uif7JZpijm6BeiiKZwIJyzWM77dkgyqZPBanMkjbsrhwEDPgRK6hkL3tLKdkdAbtSkAp2SWEymstInXtO7g0qZB0nMiafzE24A3FVQZMMDDAOVF5paFKwCLZUSLTtphEbwn84QpAp1mJpXjHPeksV7sFBcZ8UWUCVf7r1eg0b6Okac9Id8HRjATdRXpRQhJ8i/94WAXukBEK0ndd5dEjUzF1i+N1nbQO5KGEPDVciNjnOJAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8TmE2Lm/MJEJoqeRMzY5cm8tnAS1sz3VwkFDGnGfqw=;
 b=P/wCwmAICdiNKtHYTXcxN9WI++5DeXGape2piAWkaCTcZ8HY7OJtSku4uYy/MzbmXTQuxS4zuy4QG/oCO3gKO7GSMpsHVkQ+Vtr19aDmj/p7mqbMynD646Fm9c7gehL8PaPBcecDfgMm8DJDhsS1IDrGtcESYt2gdQnn+CH2E2kJnZJnRjeymApGxi82JOFNyQozItJsI+9WtiIDRU9vrXGN6fefJ0trfwu21FF3qHKJFq90RvxxLhK5NcyszrAX6pA+cxSV0p/qH/X/HCUmxZKWh7Zoj2WD1o+Gtwq/zZ/N+zbZ6cNPf2iqe0xYNN2sIFTJ3XPlh63IMD94s/p/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8TmE2Lm/MJEJoqeRMzY5cm8tnAS1sz3VwkFDGnGfqw=;
 b=Tmgq2A0c/e4RXyfFHmK94EtPaPG0dP/KiWmTu51QA4A1pPsC7gEXDBnJCJ45bMbPGS/kLKXbWPcO33nsjbiDg4ABhCdWSHa+2PgBhI17MSiUVPt7/dzLSSHoUDojAPhekIEeTQDqLZyweRY2442dRBaOH8SNNS6L4+zpoHXxZ4S493V/EPh8EJBLuW/dyN+CzKE8HhrUMomgm1wDCzUWZblrv+iXBDm9rgaB6KHtKcs1NldpWWd8n36UH0i7j9kInzLM+3sQazImlvnxYvuzts5ZSToOh3LI7rY6AtM92Va3TvG9wiyZ4K90ILqM3lIqWJKqLWwKMfctU1YA97nwqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI2PR04MB10192.eurprd04.prod.outlook.com (2603:10a6:800:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Wed, 24 Sep
 2025 14:30:23 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:30:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Sep 2025 10:30:04 -0400
Subject: [PATCH v2 3/4] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-i3c_ddr-v2-3-682a0eb32572@nxp.com>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
In-Reply-To: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758724211; l=913;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Wn33yvLfzVS1x/wyZkwAlBReMosWj9JdoWilKNLmxX4=;
 b=hrn1wrPMv1LcMhAo60BjKYnjV3Y+NRcyh4ZZYJPlsqHvPrv2Rgly9ElgQ6YDgU3ua4LlFZzvr
 3TFqAaRsoxQDOIfFOIVLzdM99qoCMSh8ZtN2PlWKUsq62pODYDQeFqy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI2PR04MB10192:EE_
X-MS-Office365-Filtering-Correlation-Id: d37d39c3-48f3-40a9-46e5-08ddfb76e59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0U4THoyYVh6UzdCSjVtb3VmNDVmYVAyYm5hcmE1dEFXeS9XeUora3JsazI1?=
 =?utf-8?B?R2NnYUtaS0JuR1VzRnFHN0g0K1NMNFhOS2JuSmhyU1lxd0I0WFhKSG91UjZ6?=
 =?utf-8?B?Y3FOMEJvckFMWnkzKzNHMjYzTVlGZzVZdW1tMDV5bnliZ0hRNVlKYkJqWmhq?=
 =?utf-8?B?RXM4djJTeDErZEZ4T2xvN1RxQ3ZEaDljR29ydk9tMnJERFByTERkWWdSSXRm?=
 =?utf-8?B?eERlamRVOHBGb2pNUGJXdlo2Qis0T3dacDE4M3VSc1hpWnBQMnY3YzlIV0Nj?=
 =?utf-8?B?QzV0YmJLd3p0MHgwR0RnbEtjNmc2Q3NZbFQzb056NVRSQVlRbVFsZG4rQ0NR?=
 =?utf-8?B?dHI4TEFxQnFyQy9pZnhhNkdTRGU4eUVBbzR3VzEwdE00ZzZ5N3NRY0dXcDJi?=
 =?utf-8?B?Y1ZONFk4WGttcmMrRTVIRHRNZUM1c2FsTjdWYlVYS0J4WkF4SlRzOVV5UXVv?=
 =?utf-8?B?WXlyWGtmMHNib2lGUVp6VmllQmwvcjFnL3dqZjR4SzIvY2U3djhQWTUwUlJG?=
 =?utf-8?B?cjl4eld2aDBGemlKODdVVm04SGVkWHBXV2puUE5BSzFRK21zZ29QVlhMeUZU?=
 =?utf-8?B?bDZsazZHUlJKOEZ5cVRsdmVLODAwb3EwakFFYjRSazdUT0JCSGIwUFVLUFc0?=
 =?utf-8?B?Sy9EazI3dEc0OFh4SklnRjVNWWUxSVEveUZJTCtIaXFKSzlMY0p3MWZ4aFBu?=
 =?utf-8?B?UWZLd1VLSlBBd1hrWXIvalYwaHFJeUEzZ1pBMll1TVR0SGhhSFJNQmFGbExC?=
 =?utf-8?B?Q0daSmQzTlkzOGQvRHdpU29LSGpQc2c1a2Q5QWpsMmJoS0NVeFlKZW9KbjFw?=
 =?utf-8?B?ZDBka2czOEZ0Qjh0ZUNpYmVoM2l0V3pnMENJMUI3RFFIYUtBWUx3WUxCNWQ1?=
 =?utf-8?B?cVZteElwcmJ5ZWZqcGJKZHlFN1k2bjFRTWxjcHR3Tzc4eUd5SE8rZ2NqaUtL?=
 =?utf-8?B?U05QbDZRZU1aWXQvU0FJY1FtK1hUaSs1ekltcEo2bWorN3lmOFVwclFqakxW?=
 =?utf-8?B?M1VBKy91ZTdXdXFuNjU3cVlCNGVOc2VvTXoxSkFVaEd4cm04RjFNUkNLTWtX?=
 =?utf-8?B?Umd2V0tMdmtyT0dFcWNXMWlBcXk2VDlsMjkyQ3hZZkpMUDNUaFRWMzk2dWxz?=
 =?utf-8?B?MnNWQW51L3JFSG9UZDVjMHMvNHJmTjJVbWJMaWxIYkRFOTl5ZUVnVDFhckFD?=
 =?utf-8?B?a2kzWnRIY3BucWlTeGJzZVY1QXJtUE1QR0o4UzBRN3hQbDFRdDh4SHdDS3BH?=
 =?utf-8?B?TnQ1MVNMSGg5QXM5cy9FT3hLV296bk53Y0dFUDUwSkRVYlVtaVR3bThrRHBC?=
 =?utf-8?B?VFlEQVJUY0JaR0NYOGdKbDI0TWpZUDJxRERGSERFTFhETHZiMi9FTG9qN1lu?=
 =?utf-8?B?KzlMVTJIZDk3ejZPRHJkZHFrMXZyM0lwek5BWmx1UFYwMVVLQlNhSkdiUUlU?=
 =?utf-8?B?MjRvRFVTL2tSL1FSTjdvS1hPYnk4c0ROQVdZSFV6NWVSMjkwNmpBdW5oRTdi?=
 =?utf-8?B?OWFZV0NtdTN6TmJ1aE9iWDhjNkJCSFczaW9kYlhISEFyRm5BeVBRS25EdWR1?=
 =?utf-8?B?dTBpcDN3UkQ0NUtaSnp6SkpuQmFlakZvMGE2endHMDZKRVhuWUZ1L0ZmL25K?=
 =?utf-8?B?K2c2STdEUzAzZHpRRGRDM3RXTXhSNVJHTEFjWVp1cXpiUlF0RnhkWWE3Q2ha?=
 =?utf-8?B?bWlhTzBnc3JBVXZYS1JpNk1zVkRnQ2FrMVdHYklwZVpqS1VLSTAwOUZyblJZ?=
 =?utf-8?B?Skxtd0h4cHdmOWZhdVhyeVFpVGZKSUhVZDRWMkxsR3E1SStHVHFqREp0Qmh6?=
 =?utf-8?B?YmlGTzdpMEZzMHpieEEzU2Y4Q1F5UmhZMXBYbHZrUzFBWm8xYXdzbytBbDRO?=
 =?utf-8?B?cnlIWnpNY2VodmZPK2llajNURHRSczZXcDJ4eExZdXFVUWNGZVdOSzU1QlZD?=
 =?utf-8?B?YWRrNWZaeTF1aCswd2VkWHpFbUtjRFJNdDNWejZMU2Vyemx4ZlZKV2lkZE1C?=
 =?utf-8?B?cUp4Zy9FNnhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zkk3ZGY2cldhTjhMNFJneU51NVNLWmw3MmRibVJVVWpDMVhvMW93OXQwcDdY?=
 =?utf-8?B?WHRpcUxmcG10R0YyRjlkZjVyRHQxRVZrWG1RMnBhbFdjV1hmOE9Ed0FpUDFm?=
 =?utf-8?B?bHQ0NWR6ZmdqdUtYTE1rajA5UXlmUmE0dDVJQmR1bUFJY3owWCsyODFIeVdV?=
 =?utf-8?B?MXJmSzg1ZHJCNlFpRGRCYmxqRFhEbWNOWmZPQkJyMDB6Z3FDN3RKUU54ak1B?=
 =?utf-8?B?cDJ5WE1Nb3ZWalNtUGQyeU02R0syMEwvYTk0MmVFZ0FicVdEYlo4N1RXSGsr?=
 =?utf-8?B?REpHRkI4OUIySkxGR25pOTZWQ1ZmcFY0Q2lJTks5ck42eSsyYms5NzZoeW52?=
 =?utf-8?B?NTNvcEdXSTlDMlZsZDJMYnhhQThhZnlQU1dVYVNXNTkxektKYWIyNEl3dW8x?=
 =?utf-8?B?QUpBcWtNWE5NVFhlN3l4bjVYb0VpNS8rUldEMVh1ZWhkKzFQL2tKM3BnRmRV?=
 =?utf-8?B?aXNFVHJveFRrRks5aERhNXdGdWx3Wk9GcE1mOVFzME1TV3hUVXZrcld5NXBr?=
 =?utf-8?B?V096SmwyY1FmckljQWJhZ3QxeXNqY3JTV0ovTEFxbTlFMnB2QmFRNW81bW1O?=
 =?utf-8?B?MHVNL3RpU3FncytOK1NnWTQ1S2pLZFpiYmxOenJGNVl0aHVQTyt3S1Nta2h3?=
 =?utf-8?B?RUlhWXR6SlhwUW9wajFmQUVkV3FaK3VOcGtiUzJSbklTM21YYnFIclJPU01C?=
 =?utf-8?B?SitlRmFvMUNDZGswL0NZY09zSmszTTNnTk56dGh3ZHRiclF5OEZGSjluWjFD?=
 =?utf-8?B?bGdBS0k5S2VwcHRMMHlOMUhMYVltT2p4T3IxelhZZnBhSVBucGgrL0pGSy9J?=
 =?utf-8?B?Z1pXdFQzdld6c25zQ2pOSk5lS3h4RFBBc0xadmFhWHlYUkNOZ1NSek1Lcjk3?=
 =?utf-8?B?elBxTGhHSUVaVFE4WEhSTDFXeTdqcmh1ZFN6OVl4VHJEWFhKWFBabGJYcy83?=
 =?utf-8?B?cjIrZ0NjSW1Oc2xONjdETjdXd0NCRGlXNlNESmwyUFI4Q1ZnNVB1SzBSWm5H?=
 =?utf-8?B?cWRKS3R2MlhOZjZwZURwcmovdGFpdXk0YzZQU0o0OWhvU1lwN3dIZVBlVkJ4?=
 =?utf-8?B?T3BwMWRIQzRzS3JlbnJpcW5GeEFXeHBpYk04S01ET3YwNUl0Rzl0YW9uKzFF?=
 =?utf-8?B?Yy95ZkxnNjBjc1hYN2hsQW9BZExoa3BoRUlFcmtGRHhiT3lTVUJtV2p5d0hi?=
 =?utf-8?B?YmYxVS9wbkJoOEZXSFd3bzFUbnV2cUxUTE1vQU9wRUZaL0pyMnhyMldEcm4z?=
 =?utf-8?B?T1M4SXVMYUJXUUR6bWxDdTFQWVRRV3FudzVycTdoVDFCbVpYMGhzMWhKZzZD?=
 =?utf-8?B?cnl5YnJObmR1MzluQUFINjFxTUtVUlZJeXRYVnJINXJZVVhVcWlRSDgyNngr?=
 =?utf-8?B?RlVZSm43THhueUVuUndSUm11c1ZiZ2pFNFk1dDBsNjFmQTh4R1dJSEVUaVZ0?=
 =?utf-8?B?Y0dXN1k5WUtJdVFYUFd0Y2FGSnFtM3pYRDdWUTF3Q0dMbWJaalZYOXVSUzZE?=
 =?utf-8?B?OXBsODh1Ni84c3lTTjFUdTE4SjFER21xa1Y4ZVVuaWZqdWp4bzJxR25JZEta?=
 =?utf-8?B?U0ViZ1hiOEdqamhxdW9Qc3NMc0FUVE9SdkZiU1MvYndtOVpIdU8zNmg0MmxW?=
 =?utf-8?B?aDU0bGhNYkQ0bFVwN1NjWWE2OUxaNTEzbHhjVTZQSjVpMHp4U2lidFVKOGhL?=
 =?utf-8?B?Rk80UWtKM28yOHY0ZFE3YmVOVEJEc3VxdERHWm5MRFlZcTBOUGhzL0ovRW91?=
 =?utf-8?B?SDcwZUZQOTZ3TGNDNTB3UHhDYjVhL2pHMXl4TnJNQzRteVB6UkRrMTkyTTht?=
 =?utf-8?B?bUt2SGFYN28zRXRiQnA3M3VsYlB1WXMvYzJ6UGdRSi9yS0V6RVR3Z0lUNThZ?=
 =?utf-8?B?MEtPaTEvei81M0lGNWJwMmNxekZXVk5qV1c0NUs0V1Nqemd3MVROYzF2TTVW?=
 =?utf-8?B?aEVvOG9YR01WaENVWFNRbit1c2pVZGcyNXozdUdiVVlmWU5jODYwUXoyT0tP?=
 =?utf-8?B?V1U3dTI3d3pOWVFvT2ZHaWgzNjhKZTJZd1ZBWU5VTm54RkpHWTR0a1gzV1Jo?=
 =?utf-8?B?bzJzKzZnc3lhQmdGTldqbHhaZCtXSUNoSDljYTltbGN2U3RSaEdNa0xTaThr?=
 =?utf-8?Q?xvyP6gbJF/A66y/2BkROWtYlz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37d39c3-48f3-40a9-46e5-08ddfb76e59a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:30:23.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GxUKVFOL+/znQkWENEmbXv2D/A7w6lbr1dQi5728mvC5mHuV2O5mmDY6j/oI+8crFz2pPAaDsCIHx0hMkbJFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10192

Add compatible string 'memsic,mmc5633' for MEMSIC 3-axis magnetometer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7609acaa752d5c1c89a26bb007fa38357dee1a28..373e36e5460c033c0c39a51c3c2c1cdee3970982 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -225,6 +225,8 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis magnetometer
+          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer

-- 
2.34.1


