Return-Path: <linux-iio+bounces-24837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0179BC298F
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BE319A3C46
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4DB24677C;
	Tue,  7 Oct 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OeMokJBr"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013028.outbound.protection.outlook.com [52.101.83.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977E23C8C7;
	Tue,  7 Oct 2025 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867618; cv=fail; b=ZgggSYNJXr7bOLbXZY1ENwHYOluoD+DPA4Io91b5XUkGo6xd5d7ll7OXPssP4Mt/Y8TbZAE58DeoOGYHksJ8l3P7gABXQUsBMJgoqnGTX5PFnZGZzq1AnN6mJSQgF9oPHroodN4FRd/+kZkZh9fuC3ExR8rRfGvdupOmgz10/B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867618; c=relaxed/simple;
	bh=qctcZM2Yjo6P7Pibi2HaShPT1XpRoM1zFJIIdP5KFJQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iyNtZ5ka/vCweVWdxuwXvhjuBI8Kl4qc3N7QWngKCfz4xHeBwd1BVlNxLzF+vcCTuypMWNWzTJnIdfnrjLhz0/eKzpvQvG6EPoOSO6qVYlMYdtycdqTf+XnMYXe5w+IWUt+cAYM2CMXpGpSyizYgI2JNVfVrZD3OmEzfIlY6lSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OeMokJBr; arc=fail smtp.client-ip=52.101.83.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWY+vtwlQ4pzldqTs56uUzeYmtdw0SUDP4fZhM0911o1CxyaaU21uj2s1i1x4E8ppvRmEoKg3vvFpMRuzrPp5M0QDPRw8Y8Mvku5PO+A/OTWW7ftypItJeW+kBr1aI6VrmNiPonUJ99C1UPmCDneSabY68Xtp6sgpXklogQM39bwYvVoTCX99sl0DDV30plB+HpFBrZqX3eYEVwluH9Pn8uqN1dkJXq8ENiiU0o12AWdF1xZM3v0A5zf+i/5hcRRl90lin3RQOVqDkqE6VBavw8J4p0giDZ8f9pW2DE1ZE/KCG+vjeX4OCaO5TRuLvywQNh0Q/sVvATy90gHYQLeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwMemhnfg0G/7Zg23/aJ0GAA/p2UuXKSs05JuqLA/Ds=;
 b=BUgdmJ4xFcIxF3A5zK1UaXVOVY6uIYSQrFGKPT8RqXkRjogng/Dtp8RAvhXulqtw94XicjgxXkHlw/RBh5aHBch/l3b1BgYFGyiVJUxslUhk3dT63iqT+tvipdbD4ambBaG3Mm+3zuNzkNK3O3SWVL48u1FUeYb/FSvbKYEi9i17dYwW70LBjT8zecgLN8oYGG9QcbHnc1sKOR3gts2Wg2AQvLUlDeOqlw3l0IZKyXTf5t9BIvPuxYhns6fJj1exenqt7Xzo09+hIyohx/sW+0/L9vIex57bQUionzqz8vVFyt7SdLJjq6B6vnEtY48YmU78NrO0rO1BKzUJzHwQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwMemhnfg0G/7Zg23/aJ0GAA/p2UuXKSs05JuqLA/Ds=;
 b=OeMokJBrjZv01GTXuKo7chuWDp+us0pUB5a/Aq5AEPyu71tadZMBZGv3RRh1pQ69wKcAeBLBn76g3GkrJJTJ4tnQ9PaX0zMij8WMxuUZ/fd96a9VQcrMZj1jWYqAbusqUmqR/LHukTUT7RkNQxKeCzsxUReLUtEGUjtL73vHFF6/WqmStMrMQfu4Ffa7idn0Ri7zhgFKDujYk7KgYi2g4HJFuiQ6xOL1T1bgp4aFL8mJeUahi4UDa1/GX5xLxi0RGg4y4oCk7xq4P5lZmlyjDmh/FIqJ3pTGuVLtivBLlg09NKYF2SLpdMaCwgbiQbL5/0kwGbPXdo68DDek0PPuBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:06:52 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:06:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 16:06:15 -0400
Subject: [PATCH v5 3/5] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v5-3-444184f7725e@nxp.com>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759867595; l=7659;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qctcZM2Yjo6P7Pibi2HaShPT1XpRoM1zFJIIdP5KFJQ=;
 b=/s4eKPc9bAMPlgEOSUVD90bijscF6cwrVPv7XaEsVpJ4q5n3GcaBGhyusEs9E+flxA9hY5jq4
 CPcZiq4Z4Z/DagX3qrq9WEoCM5FJClB1NzNMCqIwS3vg9pFZP0aaCvA
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
X-MS-Office365-Filtering-Correlation-Id: 85b81f6f-1452-4775-baae-08de05dd0eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUxScldwOXNQZUVIdWdKS0F2cHh1WThxaWNGekF3T29NNHNrb3BxUzAvUWVl?=
 =?utf-8?B?aDR6aVExUjBkWGpOdXcxZEFXWHhITEVhTTJWcUtRd3p5T2tDbnJqMUhaSHho?=
 =?utf-8?B?VXIxa0JVTUtPMVRQOWFqR0FhWFRHQlpZbkx5VC84U0FIUWorME43NDZWeGJH?=
 =?utf-8?B?dFRyaUFjTlZ3Wjc3Mm9QdHl2SFJVa1J1NEl2SEhoK0IrUmxhVjg5U3hkaSsr?=
 =?utf-8?B?ZnRDajJ3Y3RxQkorYXlGdThndWhFUlJiY2d1YzZHY0FxbjB0QWkxUzk3MXc3?=
 =?utf-8?B?cGpSNURLMUk0RGVyT2xETU9UVnQ5M3ZEbDMzUWxwR2pLT2VjaUM2UUs1TmFL?=
 =?utf-8?B?eElQdTg3MG9qdkx6eTExNmpndnhNcm9QM2xWaVJ2RWhyOWordnpsVzFnTk9n?=
 =?utf-8?B?T0JuTVhKUFNyNnVMbGJiWURIVGpoT1dBK0s1MW5WRzRmTC9xL2JHREg2V015?=
 =?utf-8?B?eCtUYTNhVjVKbGNaZUdKOFM0OWRtMzAzN2JvVndUcmI0YmlVWWFUWWNsWWY2?=
 =?utf-8?B?ZVJwZnpHTHZDMzYyOUMzUEthS1M1V0llbmFpM3Z3dmFqVkl5WkJaeWZqeG5k?=
 =?utf-8?B?NmlsTC93Z0NhczdsK3dvVWhlQ0gybnJoVUpaWG9ub2I2ZjZrUVBHVDVyc1VV?=
 =?utf-8?B?OVRkc1M1ZDRlSUMxZFBsZUVxbHdGT2FWZkhNYjhCb3BLOXpzVkNYN0tWU09S?=
 =?utf-8?B?VU5vR2l4enlKMTBXcUZTaEhNcGJXczQ5N2FGRy9jN0txZVJ3WEpjZDZOSytK?=
 =?utf-8?B?a3FHYUJRUEdGalVSK25INDlwaDg3L2FwdzU0cFFmbUdOQ1JDdkJ3RTFqMHN0?=
 =?utf-8?B?ZlhlRUxNYVlCTUhEOHU4MTBSeGF5RkNQZDJTMzk1bzZtNk16KzhxZU91bjdi?=
 =?utf-8?B?RGpLQnNPaEpoZTdVRUVON2N2REFrVm90YW9mSHIvcXRoRkppZlRJeWthU3g3?=
 =?utf-8?B?ZkpLNnN2cUN6dzFQZ2tYdTd4VWlSc3k2WUZybUhiUE4rbklyS1R1WFYyMGpV?=
 =?utf-8?B?QndsR0tlUnVQeGxWUEtiRGt4S0x0cDBrN2dla09INGZjQm55RHFkL0xsdHQ2?=
 =?utf-8?B?NGNTYmJNL29qU1BlWFZxUFl6bUJLOUlYUHN3Nk84UWMyT1huUUJkMDllems0?=
 =?utf-8?B?K2dvWFFmZFJLRzhQLzA1ZW8yd0cyTzJBMWlObkpsWk9RZmJuM2pxblFmQzlP?=
 =?utf-8?B?Tzk3OEJTakxrcE9jd0RCSXBhY1ZTUEx6aGM5VEV6ZDJrbU05QW5UNUdKNXFl?=
 =?utf-8?B?ekliRE9jWE9xZFFkSWJPaVgvTzV2M2pIL1c2SEhabWhITnQrd2U4TVRCMEF6?=
 =?utf-8?B?RVA0V1psV0MwbnMrZm9Kb1NQcHl2RTRKalpCM3ZjYkx2OTI2RjZjTWt1Wi9D?=
 =?utf-8?B?dDVYZzl5Q2E0ekNrNmlpVnVjeEFWa2phV2hCTG4xR09ETHlFUnRoQlEwZG9r?=
 =?utf-8?B?dHVQWFdwN2ZRUWtIRlpqaHZhY29qT2QvTURJa1Q0YlFTZjVCOTNmV2ZLOEkw?=
 =?utf-8?B?ZjlyRDg4eWtIYnIxYklrTFhGK2JQbHZ4TGVwTkRZTEtSNkE3M2NEQzNhV1Z6?=
 =?utf-8?B?NmFoWjNmeWMwK0tOeEpGVG5qd2M0TjRIMTg3SFdzL2RJV0U5Z21wVDFCVG5t?=
 =?utf-8?B?M2tUNDlHMDd1SFNwL2JsSStIeGZWZlJiUm51UzdNbmgyem1yajdWSlZ1YjJ0?=
 =?utf-8?B?VWppUFVndjB4a0JWeGk2cU03czZBUHlQQzNSQnR0UE1ZS1Q3TTBLRnNtOU0z?=
 =?utf-8?B?bmZJL0cwTDcvajlRcHM1UmRpRXN4aEdFUGphREF5Wlkxd2o5Y3RTR0ZDYVpH?=
 =?utf-8?B?UGxneE9SbzUwWGxEaUJuUThCMkdZelVCdkZNZ0pnbmtYSVVKa2ErT1Y2Y243?=
 =?utf-8?B?Wk82c2xkNWd6dkl3SHU5SUI2SUVqSXMwcG41c3lEZmhuTFZmWGFCUFA0dFhE?=
 =?utf-8?B?RmFCUW9uNlpwU0lST1EybnRTNXFqdU5OQkZBWXZOc3BLSTh4TnZOU25JZGpx?=
 =?utf-8?B?MUZ5VEd0QVpOYUgySHllalZFdHU0eEZNNU5HN09QQTRKQURFTWZROGtpakxU?=
 =?utf-8?Q?+qSQqk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWswZ0xVNER0aTZaZGxtcUU0Q0s3TDY0TTNBOHVzVDFaSFBkaFh6Tk9VMms2?=
 =?utf-8?B?TjJycjlhWDlMTzM3RkZ4Q1VFR3VVQWtwc3I4cnlwdG8xWHN6QXRRWTgzYTd2?=
 =?utf-8?B?YjVVbE1HTXBtTUY2T0l3eFljelMzSTkzWWYyV2ZwaDZlQWh0SnNHbjJJdUlK?=
 =?utf-8?B?OFBBaDRhRDJGWElqZGtMdlRhYWFyb0VMcGVPTHlSeFpWdDAwUldVUVdaMFFJ?=
 =?utf-8?B?a3pXS2V2U3hZZlo5ZVpTT1RNOEVlOGhvWFlKMXFHckUyQlRuRnhWaDQzdUZS?=
 =?utf-8?B?K1FEU0dRK1dOTSsyaCtoTlVVQk1PRFNkd3FndXpSVmlhOTREQzE3VzJiSCs4?=
 =?utf-8?B?eWNzZUsxUjJ5bXl2aDVQeTR3ayt2WW5wck0zbnoyMGhjTUlRdFNoZTFyQWxn?=
 =?utf-8?B?WWZ1T2pZRFZqTFR5UWNsSm5XdE12dVRPVGlySUM5ZTlQM2xMajY2b3ZEdnFz?=
 =?utf-8?B?MWc1SkRmK1ZiTDJFZm9yV1g5dHBibkhsUndUMUlNcUh6R3ljMEphQ29XRDE4?=
 =?utf-8?B?djJsSTRQSktGSkR6ZjkrVWxWK0NkQnd1V0xSYjVRUUVzMThsOFB5ZWp3TkRx?=
 =?utf-8?B?Wkc1K2VtTFhJdjJEZElrOVBYL2hjQU1XYUE4eXgxbzN6c01DRkFPVE5zMkVj?=
 =?utf-8?B?aUM5QVVscFF3ejhMYUI4ZitsNjl2a2hOOHdtNFRxS29pTHdrWUNDNW1tT0Np?=
 =?utf-8?B?bC8yN0oxTjJlWnFodXl6aFpIOEZhK2RNWEEwSDIxSVFOSVkyaS91RzJaTVA1?=
 =?utf-8?B?c3ROK0I2dnBYOGZCZlJ4ZnBiN0dqaVVwd085dEc3TmhVcUNSK1ZxRmhVZWV5?=
 =?utf-8?B?OXJkNmEvV1dCMG4rK0lrQjI4UzdaMW5JNGNocFRUNEtZR2VyMFk3dHFxL2tu?=
 =?utf-8?B?RVNBbnhNWG9kbng3S2tqQldoSG5vNjc1cGlCK1RFQlVrT2VQS2VaRzlYcElt?=
 =?utf-8?B?cUhhRndXWERPQk0yRjJ0UDVFZHlSZlhwUmpTd1p0VEdYd29KaTJlMncreUFH?=
 =?utf-8?B?L1dVdCtPQXE3V29oUm1QUlMvSVBWTGpKczNXMmFta3NMRVZrMUVvaVFFaVpL?=
 =?utf-8?B?Y1FUMXZVaHlBNDZud2RwbHNuUk1ySm84bFZoV3JFT1pjNFZyRlFFamNYaUxI?=
 =?utf-8?B?SmNQSW9uL1RiVHFobUM1V3VBTThQeWh3eXFXaGJpRVpQYzZ3UVFUaU1mbllM?=
 =?utf-8?B?SVMvRkFxTkFGR0pKa0poaWZ3Y2pPUitybW10SW9xanFIODZJb1dkVHNQR0RI?=
 =?utf-8?B?b1lpK2N1WkN4VFdHS0xRcmJ0MC95YlhHK0Y0RGNYYlYvY21zYTFhNVExSkRI?=
 =?utf-8?B?djJmdVh5dnF4Y3QzTkRDSUNEUjdXcmpkamNmRmpxT2lPL3gvLzJZQnJNaFR4?=
 =?utf-8?B?N01wSmJHYjBrNGdWS0ZlMWdDMUl2OE45VGFRR1JCSG84MGpqeFF5citNRElo?=
 =?utf-8?B?R2Q1bmpsRnNBOHcwRjl6SFBodVZzOFlEUUlrRE9udjJ2eVBObHpsek5zbVVQ?=
 =?utf-8?B?d3hiZnNNVlVHM056elRiQUV1QVJWcFM4S29tWnhyRm9qdDZHVVEzOWMvMUdM?=
 =?utf-8?B?cUZ3K3FhejNBM3ZWZEF4Mkt0QlU4R25tSFlxaTNySElodjV6b0drSXN0RlJz?=
 =?utf-8?B?dnE3dlJwQTFkZ2dkZVY2cVY4NWZDRkN1NjEzOElKdmE4R2t4SktVcEpnTlZo?=
 =?utf-8?B?c2x3MFFJR3ZoR242MmNIazZFczlOOXB2SkNQbldFUnF2YmU1TjI2YjRacEk4?=
 =?utf-8?B?NENwQ0VwelhZOTNBNXdtTzNiKzJkMFlYNDNMYU1SamI0RlpJRlhRM01mcUph?=
 =?utf-8?B?S2s1UzZKQUUzRE0xVml2U3lHZ3A0VzNoOVV5dHgyK3d6ejE2dmJ4Y1lhMytW?=
 =?utf-8?B?ZXkvWVpjQ25kUUNCUktXTzdkVXVGL1BWanhSQ0dPQkVSeCs3RDZ3cGU3bi9Q?=
 =?utf-8?B?ZVJ3MlhLWnB5VFM0Lyt2eXJQK0VzWnMzSGpzTCt4QXZETG1HNWV0QUpWSkNT?=
 =?utf-8?B?TGM1U0lFQmZVQ1N4eWUvVUcxZEo3bWlWVXFJR2pwOGJvb3dEd3poYUFveDBz?=
 =?utf-8?B?Z1FWWCtUclJRM3kvRGt6a3pvdDNwb0pOZVNqaGNwSjI5Q3ZSNzMrZmhYdVR2?=
 =?utf-8?Q?sGuZL6ZAqUMeuRSPEOxqhRvll?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b81f6f-1452-4775-baae-08de05dd0eb5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:06:52.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njqzeMFVOmsV0rmOqh4EdsSvfPBa2mHsQcu/egmVG93QLZLwoXkXs+p598eE401egkqh/htfIMJt4JONiVYXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424

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
 drivers/i3c/master/svc-i3c-master.c | 77 +++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 956172dc9d5f1f54d76b4c2917f2d9cf3bd21a85..f25c9ed561290d2a33046855b84702eb310590b0 100644
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
@@ -389,7 +392,17 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg = 0;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -780,6 +793,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	info.dyn_addr = ret;
 
+	info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
 	writel(SVC_MDYNADDR_VALID | SVC_MDYNADDR_ADDR(info.dyn_addr),
 	       master->regs + SVC_I3C_MDYNADDR);
 
@@ -1293,6 +1308,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+		if (ret)
+			goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1386,7 +1411,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1399,10 +1424,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
@@ -1412,7 +1446,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
 
@@ -1459,6 +1497,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
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
@@ -1648,9 +1691,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1658,19 +1700,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
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
@@ -1869,7 +1924,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
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


