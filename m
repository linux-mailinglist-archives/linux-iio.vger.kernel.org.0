Return-Path: <linux-iio+bounces-25994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E50C3CE55
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C0254FD7CF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7597350A3D;
	Thu,  6 Nov 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Czu5ZhcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176C350A11;
	Thu,  6 Nov 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450605; cv=fail; b=R0JUT+aKZ+0qix065FOQ1d2gEVmsnrFNscJ1UMX15c52OAqAdIG/Xd2FY+6OIIOxI8BO3RSL1n1yhSjv7eEbtPpIVwbt4iW1OKN2wzN+ZSArHeJ3k0rrSWjQzezP88YBzz7SM5u37iEsy/Wg7JHYLMaAp3h/r5wcL07AyA2n6RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450605; c=relaxed/simple;
	bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P8rZ40dsFzbYQ4DadJZHdIyNy4LT+VQ+t0SSichbTvorMSXjgj59cnIvjQl5D3L8juRceMLaEdUwjtTG3LcmOiM21NvSHle6tMPmBc7hXtc4aValT3/CXvyr2hzhaOATbQg8Cidmv/SdlrtafQ3yljNsrv5EWjtTa+xSfFqDV48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Czu5ZhcM; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXttLbAhnJAW3vuvcaVYApOYhO5oslQTdL5oMejo8E5ip82VV9tHAtiqP+V0lZvi9pQ0rBIZ6ZU6DEdfEhvOoNDEPNhLQOIoHoixkqfeQ9mNUgmZSNQ/jfANSsmd0hw/VRmYDJxhS++xn9WYVhs627NX9+70LYZX325tgapwNdacRZjblzTiAwBDwbEoFn1lLE+zEnMxeqYsm5ezn5ws2qoT1cUl2nbKe22sHyigOpn2hCSWD4dGV4T5jjtkhQOgASklAzMm27Sg3mwIR2GQ/fRofTLqarbmtR51ALi9IwmUlE4r171SvLyIYb4hbysKb6OxYJDnXrtyq7ywTXSLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=koB1dQDh+BdzjDFtZMD9V4DnrJSi8PAJXjwDrg3X/XRQWJwCXJYXQspq/ZZ1xZBc32M0+w84nW8n+9cZfpxI4jEViYNug0DNAV0PWssebDowSqlkst97SnSBpXeO7eSLnGJ3t9kn4ppCOb/e0wIRDMKxC4pmkRsukTACt7glHgsNIWaJqkZdk4sy2NjYmAc1fW1v2TNwTqKfHjdXMJSwnMW+MzGuM26UC+Bfx9zYKBdO/OmEvX4MM9wCao/OA1ODxm3aPe9vNwyeFEg84miN/cZ9Ws/lYoERj7HEQ8lvJvc7Bz+jkCgjdX7oaHV7mArNmSfGp+QfQcHX4v3HQjneag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=Czu5ZhcMx08My5JGNmiqjc6zM5Fty9mKGlOg+7wDacroYyjRzFBI56/Dfo7l08W0v2XD6ge6I1Fp38cp4Nal10c2Stso3g/moScXV0ZUQm4KwvLCcRLwV9O0oZ/p3zUdjwNiFEyjHpzXM5oqs3HFDhBcDOTjtAH3v0LPdR40S5t8CP3rkDvi11hsnd2tE+2F97/5JDbCqUrl5Vd+WxqtVS/8mhGL5uBSGq/3LLiRqa4MUc8Zam4JUtiv2/poXzMPuy/yotKkRNYeG0UveVXyfvv8tu0hU9l4uXUGoEdd6nwHYnN/nneb9ok5U0EcRzr4CHcD9gGwLMdzuKbu7WOMJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:36:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:36:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 12:36:04 -0500
Subject: [PATCH v11 5/6] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-i3c_ddr-v11-5-33a6a66ed095@nxp.com>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762450581; l=1253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
 b=NjVg+mQ4YrCOlObCqWzbMcIYaMOJSPMd/Cpa8UXWTqN39RSSTCAtorEpvYoPYeXJgEDYHtPAN
 C3EqJ86ZrsFDaFg1wdpiXdfulmtKxxZpf3C5wIZpifttWkZLPin6vPa
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
X-MS-Office365-Filtering-Correlation-Id: e30d4721-82ac-4cb0-f31d-08de1d5b0baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0JSSzZUZSt6WXFRMUhDNmI1QS9sZm53Zy84VTFBOU8xR2lhaVRXRVdHOTlO?=
 =?utf-8?B?cUZoRnhoS0lWUDBXU0N4K2FLWVVieXU3QjJKdlFLY29KRTVZSTB4ZFY5NFpG?=
 =?utf-8?B?ZU4wUEN4c24yZzlnYXR0UDNPZVZFR0dGQ2sybWNNTlJ1MHV6VVBwSEtVV3VC?=
 =?utf-8?B?SWJTaE9Ja0Y0anNqUWIyREpnRDhCQmJRWUhQenRZcm91TllYdXhNQVdxUzBE?=
 =?utf-8?B?STQyZXE3eXNJakdNQ2tMNTk4aVRWY0JBR3ZCSzJpVE84N1loSytDNWU2eXNX?=
 =?utf-8?B?ZXJoSUhnejQycHpHSWN0cGgveWRZam55MEVoNFpVVWd0OFdVcUNFQkwxd21J?=
 =?utf-8?B?SmxDRWZuTHdrUXRwa1ZSc1NMejVMcVNUazNuOVJlVzladVVaT2Erb3ZsbmdQ?=
 =?utf-8?B?eFhGcTRucHI0NjlyUzRKbGQwY3JNZy8yelFUR1c2dlBhUi9mVFlmSU9LekdV?=
 =?utf-8?B?U1p0MjlhQjRabzUyMkw2VHYxaHlNd2hPZ3ZoRWwyeTkyQlF1VEw3MFhTY01n?=
 =?utf-8?B?UU4zdjgzT28zeVQxWi9Jc095c1JlVUN6S3JlVXN1NGV4UGYvdnZ4eUltajlL?=
 =?utf-8?B?L04yaUwxckcvalQxWnZQS2ROY2Jwb08wd2ZjSTg0SnZ3bnllM2tRaCs4MzU1?=
 =?utf-8?B?elRzckMvTWlGYjVCVFFUYzh5bCt6dTJnZ1gvTjhSamkvVVdncTE3Uy9qTWZF?=
 =?utf-8?B?UWw1UVRzUE9oWUJKWnRuVjVlNko0a0R5TW1yYnZPQkMzZlVZblI3dmlvSGRn?=
 =?utf-8?B?MGl1aENRaTNmZ2lMMU1SdEhFaXo2eWNodnRoVzhMc2U3Qm9MVmlpT1ZlZFdn?=
 =?utf-8?B?WkxHQlJ6bjE1TllhWmVvbHpKbmJiSnVYNWtINHYzaVQ3QS9wcjVtdE85MkZ5?=
 =?utf-8?B?VXRVTWR0dTVtWUZYTEU4YThsaFNoS2FHeTFQVHNYWmg1YTJRZkZPTTBoMHZY?=
 =?utf-8?B?Q0gxcDVCSXE1RGdSd0xWbUJqK25aZ0h5bG0zRWV1NjhBRitNa2k4OTJTM2h3?=
 =?utf-8?B?ek04anBiT0NDTU5JTXJmMGZnbks5YUVlWnFmamM5SmN4YVE4ZldteHhUeHJa?=
 =?utf-8?B?Y29WNkRQNFc4cDhFQmcza012d2FiZHM4OWZEbVhiRHhLQWRwZmNFMncvREFJ?=
 =?utf-8?B?V21JQkIwYkVtNkk1WFUrSENYNTBCMitGbnFSYTdFNzdNTFp5cVF4S05MV2po?=
 =?utf-8?B?Q0RkcUJiK0pDLzExWmJkUkVqSzE1a3ZKZmxJNERaWmpJeERkWnVvdHptK0x0?=
 =?utf-8?B?ZWs0N2JEeStTYk0yTjJ2VkpKT1BEbmwzdTMwTHFUcU00M0FTak9IZG12VHBq?=
 =?utf-8?B?NFJtOWhUWEp2aHZ2ZDF6VGtwMkxDQ1MvalkyUm5oMEVHckNQT1FreEVsTnRB?=
 =?utf-8?B?c05vOXgrRDJ3enZEcFp1VzVpWTQzUTFTdnlieXFXckFuS3RCY3E2SVNaQzJt?=
 =?utf-8?B?dE40QkVVZUNhNWdZU0tXRGw2Wkt6VkRiZFBVK1h2UnpjdEw5MW1nUzFHTVla?=
 =?utf-8?B?ZEp2VVgxZHFDdjZkRTZqbVpiZVZEcGhkbVdnZlA3VlVMdXBXV09QQ0xQLzQ5?=
 =?utf-8?B?N1Jhcm9iZUZ2bFE3MDM1VFhLa0kvRWs5TThFNzVmZ0lKY2xpNUdBdjNjUEs2?=
 =?utf-8?B?NWZNUUo3K21Wd2daenRvUElQMFRXT1UwTmRDYS94Qi9SUVdNWGt0MytNaG5D?=
 =?utf-8?B?dVl4NDJ4Ullsbml6cG1iNndIWGtVcndkc0ZmcE1tUkZnVklYRWE0Y2RlczI2?=
 =?utf-8?B?aTl6N2UxdWl0RWtRWi9NcUJFKzVOVUxWVlpRQmMvQVpwMGtBQ0pwb3pnU052?=
 =?utf-8?B?L29KblhTY3Q3NWZ4ZTFXbjVjME5nbjhwWXFpbTdsbmxpT2xIV3FpbERKR2pu?=
 =?utf-8?B?UTliUlJ1cWlmTHIvTmZxa3hGZzc4RGdCLzUzWlVjaGJOaEplaGJkUmxITTgz?=
 =?utf-8?B?eUhVdWszM0psbEs2VE15MnhoWVhKcVR6MEZxV1RSQythQ3V4dzRrNk9uRU1K?=
 =?utf-8?B?Ny9XeWlGUjlXUkpZNFBoV0hJaGN4MlppWUpmQXg0OTgrbk1GbHl6Zno0WlUz?=
 =?utf-8?Q?ee4TRl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXA2eEp4ejBEVFRHb0EzSU1kczhlSWxocnN1cUdSTXV4QThnTVNLazlIZ1B3?=
 =?utf-8?B?Qno3dTdoZ3ZidmpMUzE2YURjaG1iak1TUTdva2o0dVZNY0NFWDhRWXdVK2NN?=
 =?utf-8?B?MkpGbk4xQ284ek8wVG5jL2M3VnQ0UjlaR3FFMWVPQVRBQStoelkrTzRmWmI0?=
 =?utf-8?B?TThFL2RXejFWL2ZCVmtVVHBQL0RJZmRuNnRsQ0dRMXBQRmRNdU9rZzJtcUF0?=
 =?utf-8?B?alBUWVJmcWkvMGNCVi9zaE9YTGYwcE1lR1podDUrRTRXUXBPNStkeE54NWsx?=
 =?utf-8?B?N2c2SmJ1cURkQlo0dHprOXRxUzgzSjFFNC9tOG5HTXA1VndSL3JUTzJKL0Ry?=
 =?utf-8?B?eTY5azJ4WENFWnVBWjFEcFh3YzdKcGVhdG9FRWhGV0lVM1h5Nk5HbmJESTBF?=
 =?utf-8?B?OGR1WHNiWnNYTTkzTjBlNENTcFZTYWZVZE1VdFpTdnN6aGhibys4WjBxWmpI?=
 =?utf-8?B?c2I3MStuWElRWjQrOHIxWEEvcWVUQzNzMlBENTk5SmlIVlRBdVRIMlhRR0Jn?=
 =?utf-8?B?eU1odkVDQ01QZ01wcFlpT2lUTm9VcGVDaHVZOVVRYkUyS2thL25KYzVVYjVC?=
 =?utf-8?B?Z2c0cFBOcXk2VEp1eGJuUEErRDBvRmtVbHp2cVY0SGJvc2RtNm5pMzhOd0Vt?=
 =?utf-8?B?ZlFVN2RCdGpXcDhSQU5KeS9EcG16TGJ2OFdwQWhLd083cmprWDdhSDFxbng0?=
 =?utf-8?B?Rm43WGJOUXQwV1d4eFFMd0cydFArSm9BeGVtREUvYjg5MEc1Wmw1RkdtR2NS?=
 =?utf-8?B?TVYxN05SV3YyWmlsUXdCdERzNHZNTi9JZ2JtcXByUlZGSFdDckd0RFdQU0Mv?=
 =?utf-8?B?dklkSFlYR3o4QVNKdU9vbWJCNkV1Z3FTd2ZLdnNxV3VXNE9KczFxTDN1WU9r?=
 =?utf-8?B?U0FQa1N3UzVvZ002aEdnS0VnWE41cXRYK2NNejFEcjNwWjVRNmxWK3dobGY4?=
 =?utf-8?B?YWI4YjloU3ZKcThIeW15djh0Yy92SmNnMWVMd1gxNy93cEZZL3JUWTNtTjFR?=
 =?utf-8?B?SUt5eWg3LzZMcE5hRmJpb3R0QTMvbEx4aWY1SFd6NkQzbk1UV1R1cGdwdnNF?=
 =?utf-8?B?WGsvK2V1V2UxRlBNVnRKeHBPdjV3L0tCcVExWGpWR1orV09rWk9RUVFLN3ZS?=
 =?utf-8?B?Tmt0ZGVDQTdyS2IxSWR2cmhsVVFBMDZETnFZZkxHZ3c4NVUxV0l0djR2SGlt?=
 =?utf-8?B?MWxzNkt4eUEyYWhhTmFWSDB4eDZlbzBTNGY4bm9MSEdXL3RiUU50d2Z5Szdo?=
 =?utf-8?B?bENZZzAxck5XMTNkenpDV1FnZEJpQUNjR3RnMERRbm9SdzJzTXplK1JaV3B4?=
 =?utf-8?B?MkE0c1ExbVZSR2dkaDVqMmRsSENVdG5la1FWRysxNnl6Q3JVenUwVUtWM3Bo?=
 =?utf-8?B?REJmaHNNcDlzbk9KWVpOL2V1akVKa0EwdkN2bWRyRU1lbHBHbjBPa3c2RG1Y?=
 =?utf-8?B?RmluaGVsUklsSGp0amlBLzZBVUF1SVdBREI0M29EUWFEeUxVTkZQVjU1UVR1?=
 =?utf-8?B?MkFGajFLeTloZkd6eWVZOHQ2djJZanNGUlBXQ2VpbXNwNVYxOHFmcjJXdUpX?=
 =?utf-8?B?OWlvOERYMUVWWDhKMXg1WGs4V1FLVmRFYVJGK1ZZSXYra3lWQVJiOWY5ektj?=
 =?utf-8?B?WkhmN1I3dGpyZjMwTkhxZTBXM0Fsazhzd0VXQTM4M1hRL2Nhall5aG8wLzdn?=
 =?utf-8?B?V2VuUUJXZHJ5MERZcHFCSjk2aENQUFpsR3V3aWNLK01LY1A5NUxDeWRHVG9R?=
 =?utf-8?B?Z3p2M3BiVkE1cHZFYUFwN1krU1plVkxxT3Y5bkpYQXBOWlhPeDBsT2dTQjBG?=
 =?utf-8?B?ZENYazNFWE9jSFRkbnFOVnhZY0JKREZvY3NaSFIweWlSSmRxSE5PNlZPMVZm?=
 =?utf-8?B?dGNhUytqZll6RTRINXZTQXVnYkdNalBEWlFxUUUwTXlXRkM3MnNaeTBST0ly?=
 =?utf-8?B?QTlFcXVUejZOb0g2NTYvbkQ4cnFkMlUvZUY3ZzNNWGJYeEtRTEx4bFJQREI0?=
 =?utf-8?B?c1ZGTVVpRzYrdXJtMDVzU1l6QlZEM0xPNlZ1bnJJbjI0cmwvelpRSmNMbjU0?=
 =?utf-8?B?NjRnT1dISDZnZHRabFRUbXpBN2FpeGpITlF1d2NmMFVrWHFidjJZODhQTkow?=
 =?utf-8?Q?e3nzivYEE7sMmMrTsO1x4g5zd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30d4721-82ac-4cb0-f31d-08de1d5b0baa
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:36:40.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzKAm/O8CEysCw2qFKMAqdQnMIoAE35vK9l/1cg9mSqxoL/bmoFHVaWg+SV6VP3bL+v19Tp08qcH6lc9UWRcpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
MEMSIC 3-axis magnetometer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7
- none

Changes in v6:
- add Conor Dooley ack tag.

Changes in v5
- none

Changes in v4
- add memsic,mmc5603

Changes from v1 .. v3
- None
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302add1ef8f6ae9ec9672697bc812ea..94fc8ff4504b5dc2c0fd7b384f6acaae3d5f80a4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -227,6 +227,10 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis magnetometer
+          - memsic,mmc5603
+            # MEMSIC 3-axis magnetometer (Support I3C HDR)
+          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer

-- 
2.34.1


