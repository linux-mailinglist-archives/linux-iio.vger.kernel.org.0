Return-Path: <linux-iio+bounces-24603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09011BAE749
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 21:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C75194545C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E9F2877F0;
	Tue, 30 Sep 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HTlwL8w5"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA8286D50;
	Tue, 30 Sep 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260894; cv=fail; b=YhpxBstKCkH4nufwH7/3Eo01P3vnpyqW/ju1vp0i6VVD1HMYDAg2hysKzrzHKpL6S1SL9hxQ4SPrvW2Nv3jt4pWC7h2V8CfpnaCmY/G+/68Epd7boFQ4TtVffhoKYkd8IqMjOJ0zLPOezAGQkgqEqLN6xD1+NMPGlzVnfMYClZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260894; c=relaxed/simple;
	bh=hAesbFXXoQDUm2F/xTKXIkyoisVYjxgEcF7YN6rj7+E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DqbS+K5pDAye618NQLLZO/ZXmNLdGV6n7z0nApIsAt9GwHnux2v8iIGXUrskOT0wmm6jbvaWyG4czqDtp7hg2cHCh9x/CUGw81+Nxn4QpeXjTUpfwPePC9M2jyE+a0wlvMquOKyIF6/Mcop39+tYFkU7BCVMbOYSxjZwCuYUlOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HTlwL8w5; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZk6kHhBpb+kIJ8f+5vqlFOPWVBvOIe6prUhUcrekNfsS1BMLOId48InYvX6n2DJLccoC67ceaexPpmDQ2AY2vaeP4fbhQXz1F65tXG740vGdc8X8usGlZ7KmIZRBPYiphtf6BaGWr4vCnTimbx8VJG23n+r4G4XhiDRMzv/UPI8C1trqWjM1noQ7227nRGITiC4RMiun5KZw0enjGV0x4SVfG7dMYwm+R/J9tnUwtE7+CrjjSM5doaVfdChmi3fkFo8keXBGf79u4X+W6lS4kUQ6PRTCkmghCzHygUuAeG+rDUshAh9zVEQGiw6uPE4uvHRVZv5mBGLuhJmT9AyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2opE9pxXuqMUN5K416Q8/CU5Ur4Rjf/EwUbeY+1wFJE=;
 b=VLX4jUOoguxP4AJkYS1+f+fES92bGYzXIIIwWd3+m+piKZa8rSW37bNs0dpkenEi3C/+Dh0+yud+URGNWhmyjfdjEjO+uccMAXzPmHZENxlyUb/+5z/jPKwc7lMX0smVph5hrLTqfdMIV1JInmGZtb2NGatBLn6SHSX3a9HEfIbWGbJfCZWSi19tMqabGGg2taXlME5JZ6v0Ua64hd+yx5JoPbfmezdFoyfuAH7AhCIPoS9EYKVKjJzSN1xq2kn2zD8u80NDp2os8/9mUyHuKgsGnxYuiZyhyRFxPecYaMKnRZs9TuDfleMLQpRRl7ssiosOYZHezNuAFYegp5PhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2opE9pxXuqMUN5K416Q8/CU5Ur4Rjf/EwUbeY+1wFJE=;
 b=HTlwL8w5CjDtA4UZzbyDXT08OmMtiB4Z6XQ/DDIcJZj3CdvwuX1pJXfi89uSdhkpOQx8QDU26Cp0/5QOZZijIfWAQyOCH5OSO3yEBAo2c1D0f/z/8roZLCwfK54eusnDNji77ADsrC2D9CTv1c6szr1v1d/Q3NtOZu6shMmNqb62Fsprh/gdMKGS42lo1Eh+429jmvMsLKgyKZpWslEpvtyG6c/fvfzJ6sEvIYr/S7YKGP8cmwaUjFsSSkOG6nG0JfgUNyItpznoqozgTF7Wc5Z9OunNs64U/OLSdN0B4WDHMgKxlEJVRmY/wMdmCevQ10CG1U9rctWLjIpECluDaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10926.eurprd04.prod.outlook.com (2603:10a6:800:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:34:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:34:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Sep 2025 15:34:20 -0400
Subject: [PATCH v3 1/5] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-i3c_ddr-v3-1-b627dc2ef172@nxp.com>
References: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
In-Reply-To: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759260882; l=10808;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hAesbFXXoQDUm2F/xTKXIkyoisVYjxgEcF7YN6rj7+E=;
 b=7HWfTBfaVoVZSlViZqu5ou6TJjnFZPu55cxoejafZ7kHwizR6v5OvCPonZSPKsfBaQ9/x6l3O
 qAs5l2CuChcD1jgL5teMaGrMIzB7j1aKa6B8IJV0cYrUGLo5k7ZRyeZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdf0d44-b345-464c-c7dd-08de00586aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2FxeUdFKzEzczd4M2pnWlNOWndkS1VSdHUrR29IUGpESWtVS215NWJVRUU4?=
 =?utf-8?B?WWlqYXhXdCsyaHUxUytPQWtDODBrVzltTkptV2VCc1dLWWllVytsZDM2bWlJ?=
 =?utf-8?B?djlOTkEra2RhWjAxU0pORUEvWUtZOVVIYUY5ZkRGNE05eE5kUXpabGpiMVRK?=
 =?utf-8?B?bmZSRjBBYnZPWXJMV3pOSVlRaytJNlVvUXdjOU5qQ0FybEthN0h5SWpPUmFR?=
 =?utf-8?B?SjFjLzBZSFg5UkJ1ZFZPYTl1U0h5Q001OXR3UXVOWm8zZVRTUDQvcnpjUFZL?=
 =?utf-8?B?bFBZSEdqa1k4OUVLcWVhb0VxK29xZm5oZy9JQ0t0d1FiSzl4aXBPZFZqdHNn?=
 =?utf-8?B?Wk4yOHZZTVl2ZklER3Jld1pFSSs3c2RkandhOTYwZHJhSjNWT2lzQm41MDNS?=
 =?utf-8?B?QzZiaFV6M1puNzN4OWk0TE8wYXNLUEMzYk5USTBpYWFrSUhycDBpZkk0NHBv?=
 =?utf-8?B?bjB5OCtVeDVuWkZLVGdObzdtRUJJcjg3dVh1ZnlnRnFaVHIyTU5Xbk5NUzN6?=
 =?utf-8?B?V0tQK29PTWFzc0JjajdhR1hWSHdPYXVaRE9mU2lRTnU4RFZjZHMyczJURzdo?=
 =?utf-8?B?OFkrK0QxUXpKNzNLdEdnR1hORGpHQTZDR3dqOENtZVJFS3E2QllRMmJZSEVz?=
 =?utf-8?B?enNNVXBOVXVMYkxMUHhQRlNnUWJ4SUZUdEttUDdhVjVuR1NSUHQybjFtcHB5?=
 =?utf-8?B?ZW0rQ0wreUcxV0VPTFVzVERQUmZXa2ZmWWFsM0RLZkVVOEI4bnVoRWRhNWJE?=
 =?utf-8?B?TUw2SXZrbHpWQ05jbThncE1mZ2NmRTBrUGNJRnRmWWIyZ2x4NWI0M2czT0xX?=
 =?utf-8?B?aTJoWjJyT1dCMjc4b3hiUzhkT1Btck9PeThuWWJvcCtaeVB1ZUVqWUwvcUU3?=
 =?utf-8?B?QTNuZUo5NFcrQ1Q4RzQxczdZdHhFaFg0Q3J6UWNSNGs0eUczZ2pmZ0VPRWZZ?=
 =?utf-8?B?blFSZmRJY3Y3QXlaaVU4a1NDMzZPc05hOFQ4WnBIK1MvRXZsZ243U3F5dWFl?=
 =?utf-8?B?cjlzVlVFbEpndXBkYnVlZEZscUtmenVWUzdtZTM2eDkvUCtCejd1SkZsR1FH?=
 =?utf-8?B?eFF4UkNZejVnSC9rN3MrTGhUYTh3T3pCUEZSVXZzZmNVUmp4SC9WNnZwbjBp?=
 =?utf-8?B?VEg1UzlBbnRNTk8vcXlPRnZMRjh0TnpKcEJwZDZPNzkxSjZ1V2tuSkV0RlBC?=
 =?utf-8?B?UkhIVTRFaU5kTW5SMnFoU2N3K0dFcHQvYTFRVGhvbXJvK1VCMkFnRE5rRVM2?=
 =?utf-8?B?dzFiWWdHd2hIUFNIVGFKbkZXZ24xem9IUks5MTBIMEFLMitoQUlLNHc2T3gw?=
 =?utf-8?B?Vm5EdU05UXZnUlhYUTZ5SUpwTCswc3crRXo1aTdKSkFEUUN5WVFlKzh4YWZT?=
 =?utf-8?B?a1doUTdhN1AyWlR1SjEyMW1mMzFyamRIVWJtUUkzYWV6VUJMMjNOSWcxZEtv?=
 =?utf-8?B?WWJrL1dMa0IvS2s0UXZ2Vjd3Z1pCcHI2ZjExN3pScUZvZmpqWGRiUzlvS0Nz?=
 =?utf-8?B?cFpSVS9ic3I4R2pOaVowWlYwak1DYzl0WnpFK0VWbEZMUXBvVVV0aEJPVVdQ?=
 =?utf-8?B?Q2VIUGM1a3NDd0U4cnJrQnVjVWFGdStiUnlIR1N1cU4wRnl0WjJndVV2N092?=
 =?utf-8?B?NVNNWk1temNsOUJUWjVDNkRpekVDdnpqWUZMNnUrd0w0ZnpiRWJCOGdtWTlL?=
 =?utf-8?B?SzZOeWM2QXVNZUV0OFNUR1FMSDZRM2IrTWRmOUxFVnhkYzFzSi9PK0IrRldj?=
 =?utf-8?B?VGtkSEhjNGFScWtjbC8zRXNwaGp5WUVrcGo3MVYzeG1EckJWNXdHS3BtNDRW?=
 =?utf-8?B?QkFQMjIwMGNhbHhJdjdMZkRVQitnWFpxV1dJc2ZqNXZxR0pSSktWNHlnbjhO?=
 =?utf-8?B?bzV3R0pQRWp6Q0tBTU1oMUtOeHZrTnVFRkYrNWNZcFo3Sm1HQVZDOWh4eXBD?=
 =?utf-8?B?QXZka2g5NDhUdlR0aVdMaDlWTXhsUlRpdjd6anZZbWJMUWVZZlEzbXM5UVZr?=
 =?utf-8?B?enI2QlF6NUxmZU4vd2lYdnNxSU9YLzhDNCtnVDBQV0lzN3lHT3BXOUpGOUZy?=
 =?utf-8?Q?xprDLj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHowOGIzeWhpbkpRZ1c1T0NUQkcwNG5LYzhFeVBQR09mN2gxWDVHQzhqZUlM?=
 =?utf-8?B?bjJNeThtcXpiZ0ZYbnV4ckxlcDJLc3ROZ0lPWXZOby92K2ZZMmpib1lxcURr?=
 =?utf-8?B?YVp4SHI5aXEwUU9TOXB0VWIzTFc0MUdlZFRZSEFPa0FFU1NaWmE0bUhORWF5?=
 =?utf-8?B?UnhtSTZvTkZZNEc1dWpNa0lLQU0yOW5aMzliSnJKUHJ6VG4wYkVza09Yc05Y?=
 =?utf-8?B?OUR1a2VoK1JvclI2NEtUUDA4K1hSd1VNbVhUSUkxTmVRWnI5NlpwQUIrcy9h?=
 =?utf-8?B?QzBvS1QxK05jQUNRTzIralRieUNueFdtdFE3cTRIWStrSzJKcmh6cE5TSHls?=
 =?utf-8?B?LzFFOXhhNGFKeTR2VDhBeDNvbjVCUzR1NEc5YTlkSndJRnc1N0ZKS25Pai8r?=
 =?utf-8?B?UitWajhDZEFiME4rS1R6VUtMbFdsOFhkL1lrNFFXVTl3MDRxTzJ3V3J6TXky?=
 =?utf-8?B?OExzeWJ1WE1pNzFpWm5xZytITmMxQkptejdaMEZ4R1EvZUg3Y3BjcmRtdzUx?=
 =?utf-8?B?R29YdmFET1FBd1daeEhzc0tYMEpFZDJyS2l3cFpvOFE5MFdydVlaeWpMaEtE?=
 =?utf-8?B?Vk05NzRBNzk1RDlFZ29hcEV4QWo3NUlKTStZWGNpQVcrRGloQU5XNEsrLzc1?=
 =?utf-8?B?bXdIajNDR250RjhhOTdsMUFTN0QrenRPNEhmOWorQXdHRTNnNTFiazJaSEhJ?=
 =?utf-8?B?eUUzR2I2dFd6OThhR2tvTzY4bzZQMTFISmZDbmlkOUJIOWJVeFQ0b3lRWW1h?=
 =?utf-8?B?eCtzanIwM0dDMG9iVzRyTW9tZU40U2ZIeHo2MEFwOFRJR1cvTWNnVnlMT3ZY?=
 =?utf-8?B?VXVFTkx4ckpkZGUvbEI3Ull3YXhGM0Q4WFZwUTdHaWxrY3MrTEx5d0hpZm5F?=
 =?utf-8?B?T0htdWxNTGZUNk9sblBvS1ViWGo2ZTBkU0RDdlJzbzF1T2owSUtWTVZpam0z?=
 =?utf-8?B?QkFpRnBqMHpYdnNsVnpIeStLK0R5ZjMxaTlicEo5WDZUb3p6ejU1K3YwdHpP?=
 =?utf-8?B?Q3JsU0VFZFZHMFNmcWMxdmg5RGh1RU5qL2cyeDMvNjBVOExMamY1bUl0MFNN?=
 =?utf-8?B?RlZOa3ZIMHZZb3h3MnlaZHE5b1Z5YmlRUEN5ZUJwUlU4WXVSdE83eitxdnhZ?=
 =?utf-8?B?cnVGNG1iQmRKSENHWkk0Y0g3YlJaTHk3ZDhTUythMlhIeVExNWZHckFqRkNn?=
 =?utf-8?B?anZQTmZHQ21xWFR6d1d1cnJZUlZDdHVpQktPWU94SlI5T2NPUFRpS1pvajly?=
 =?utf-8?B?WDZBNFYzYTMvOUNoeHJYODNBamtqZEo2RFRhdWkwYVNxbWdGcmJRRitWUUVO?=
 =?utf-8?B?UFVOWWwwWUloVzdaUjgrRXV6UnRMdVpTSnk2cng0NXIzR2UxczZsRm1kK1d6?=
 =?utf-8?B?V080d3RlUW5sc0oyT0hNUVNoZlNtWnJCeUd3Ym9MMmdvdFVtYjZYNjhNNDV1?=
 =?utf-8?B?VjZDUUV2QXEvT1djRm1vdWV2dHVxc0RYYWpyY1YyZmIwTGl1RUZPOGV4T2hj?=
 =?utf-8?B?anJFSDBEMEtldnNrUEx5cURhcnN4djhpNTM4R0dPbTNtbEN4SDhmbDA4aHUw?=
 =?utf-8?B?eFhUdXVWSmRwaFhSNnNaQUVXUDFlMzZpN0tPalk0LzVvZUNUWFkvZUZiTzBy?=
 =?utf-8?B?Z0QyTHRtUEd6eFNqRlZaNzhUV3ZTWTV0b20xWFBpTVlQaFJsTm5DYm5TaTRX?=
 =?utf-8?B?UmVQL3lIeGpYTHVqVyt1Q1plaDZHV0FDalV4N08wVXpQcGlsMm9XWXJFYmNn?=
 =?utf-8?B?K2VpSWgvcFFVUGh2R1JoaXc0ZDUwSUsxc1pMSE05ekxTN2ZPcWdSdHJGSStm?=
 =?utf-8?B?bC96MFQ2ZitBNFZzV0NKVUduajlPaFhXNTZ0aGtkOHVuNm9NZis1Qk44cStJ?=
 =?utf-8?B?NnZVczEwNlN1azNpRzdRcTFhbU9mTHVyVjAwdXFyQUxFVnVwd1pqVS80UlhX?=
 =?utf-8?B?OHkzRkRVU0YxQVVkZlA5V1JsamdhdW5mek4xL21ybkNJQmJPKy9oREY2Qng1?=
 =?utf-8?B?ditRelhBRUN3M3pyWlo2amhmUlJHS1pBK1JGN2NkR3cyYVAxcFY5Znozck9N?=
 =?utf-8?B?YWFTUGY4SXkxZWN1azZsM1o5dEFDNjZ4aW4wQzlUSkR6emY0c2ErUjhMZmVi?=
 =?utf-8?Q?v9RE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdf0d44-b345-464c-c7dd-08de00586aff
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:34:48.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thpbpmwtn18oeqCwsHzPfOqX0SWz42Ds0HSxCu3qhwXFX4hLGQKJJO0k0xUprakhPAhgJStFyoPvXekoDibenQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10926

Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
Technical Overview.

i3c_xfer will be used for both SDR and HDR.

Add i3c_device_do_xfers() with an HDR mode argument, while keeping
i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
with I3C_SDR for backward compatibility.

Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
'rnw', since HDR mode uses read/write commands instead of the SDR address
bit.

Add .i3c_xfers() callback for master controllers. If not implemented, fall
back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
all controllers switch to .i3c_xfers().

Add 'mode_mask' bitmask to advertise controller capability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
one i3c transfer. for example, can't send a HDR follow one SDR between
START and STOP.

i3c_priv_xfer should be treat as whole i3c transactions. If user want send
HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
instead put into a big i3c_priv_xfer[n].

change in v3
- Add Depreciated comment for priv_xfers.

change in v2
- don't use 'priv_' since it is refer to sdr mode transfer in spec.
- add 'mode_mask' indicate controller's capibility.
- add helper function to check master's supported transfer mode.
---
 drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
 drivers/i3c/internals.h    |  6 +++---
 drivers/i3c/master.c       | 22 ++++++++++++++++++----
 include/linux/i3c/device.h | 28 ++++++++++++++++++++++------
 include/linux/i3c/master.h |  6 ++++++
 5 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..00706b47758bc164178a5578a018b36c5c433f5f 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -15,12 +15,12 @@
 #include "internals.h"
 
 /**
- * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
- *				specific device
+ * i3c_device_do_xfers() - do I3C transfers directed to a specific device
  *
  * @dev: device with which the transfers should be done
  * @xfers: array of transfers
  * @nxfers: number of transfers
+ * @mode: transfer mode
  *
  * Initiate one or several private SDR transfers with @dev.
  *
@@ -33,9 +33,8 @@
  *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
  *   5.1.2.2.3.
  */
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers)
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
+			int nxfers, enum i3c_hdr_mode mode)
 {
 	int ret, i;
 
@@ -48,12 +47,12 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 	}
 
 	i3c_bus_normaluse_lock(dev->bus);
-	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
+	ret = i3c_dev_do_xfers_locked(dev->desc, xfers, nxfers, mode);
 	i3c_bus_normaluse_unlock(dev->bus);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+EXPORT_SYMBOL_GPL(i3c_device_do_xfers);
 
 /**
  * i3c_device_do_setdasa() - do I3C dynamic address assignement with
@@ -260,6 +259,20 @@ i3c_device_match_id(struct i3c_device *i3cdev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_match_id);
 
+/**
+ * i3c_device_get_supported_xfer_mode - Returns the supported transfer mode by
+ *					connected master controller.
+ * @dev: I3C device
+ *
+ * Return: a bit mask, which supported transfer mode, bit position is defined at
+ *	   enum i3c_hdr_mode
+ */
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
+{
+	return i3c_dev_get_master(dev->desc)->mode_mask;
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5d473db733b12ffcec0c1c28d9def..2adba9136f3d147b82c58bd9b491d6d1bc6bfdf7 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -15,9 +15,9 @@ void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
 int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers);
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev,
+			    struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_hdr_mode mode);
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2ef898a8fd8065032b68c97c52dcb12e771525a4..1ba21fd737a31386704e47afb3026c4fc8fc7305 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2749,10 +2749,13 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -2808,6 +2811,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 	master->dev.release = i3c_masterdev_release;
 	master->ops = ops;
 	master->secondary = secondary;
+	/* Spec require must support SDR mode */
+	master->mode_mask |= BIT(I3C_SDR);
+
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
@@ -2942,9 +2948,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_hdr_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -2955,9 +2960,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master || !xfers)
 		return -EINVAL;
 
+	if (!(master->mode_mask & BIT(mode)))
+		return -EOPNOTSUPP;
+
+	if (master->ops->i3c_xfers)
+		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
+
 	if (!master->ops->priv_xfers)
 		return -EOPNOTSUPP;
 
+	if (mode != I3C_SDR)
+		return -EINVAL;
+
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..be7d9e4c98e09ec29357d19dc73d1f050d7bde1e 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -40,19 +40,22 @@ enum i3c_error_code {
 
 /**
  * enum i3c_hdr_mode - HDR mode ids
+ * @I3C_SDR: SDR mode (NOT HDR mode)
  * @I3C_HDR_DDR: DDR mode
  * @I3C_HDR_TSP: TSP mode
  * @I3C_HDR_TSL: TSL mode
  */
 enum i3c_hdr_mode {
+	I3C_SDR,
 	I3C_HDR_DDR,
 	I3C_HDR_TSP,
 	I3C_HDR_TSL,
 };
 
 /**
- * struct i3c_priv_xfer - I3C SDR private transfer
+ * struct i3c_xfer - I3C data transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
  * @len: transfer length in bytes of the transfer
  * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
@@ -60,8 +63,11 @@ enum i3c_hdr_mode {
  * @data.out: output buffer. Must point to a DMA-able buffer
  * @err: I3C error code
  */
-struct i3c_priv_xfer {
-	u8 rnw;
+struct i3c_xfer {
+	union {
+		u8 rnw;
+		u8 cmd;
+	};
 	u16 len;
 	u16 actual_len;
 	union {
@@ -71,6 +77,9 @@ struct i3c_priv_xfer {
 	enum i3c_error_code err;
 };
 
+/* keep back compatible */
+#define i3c_priv_xfer i3c_xfer
+
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -297,9 +306,15 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers);
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_hdr_mode mode);
+
+static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
+					   struct i3c_priv_xfer *xfers,
+					   int nxfers)
+{
+	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
+}
 
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
@@ -341,5 +356,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 043f5c7ff398ff631f1eea6acfc54a2e871016d8..de180511dc65e260885099913141eef8d0768f5e 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
 				 const struct i3c_ccc_cmd *cmd);
 	int (*send_ccc_cmd)(struct i3c_master_controller *master,
 			    struct i3c_ccc_cmd *cmd);
+	/* Depreciated, please use i3c_xfers() */
 	int (*priv_xfers)(struct i3c_dev_desc *dev,
 			  struct i3c_priv_xfer *xfers,
 			  int nxfers);
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *xfers,
+			 int nxfers, enum i3c_hdr_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,
@@ -505,6 +509,7 @@ struct i3c_master_controller_ops {
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
  * @hotjoin: true if the master support hotjoin
+ * @mode_mask: bit mask for supported transfer mode
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
  * @boardinfo: board-level information attached to devices connected on the bus
@@ -528,6 +533,7 @@ struct i3c_master_controller {
 	unsigned int secondary : 1;
 	unsigned int init_done : 1;
 	unsigned int hotjoin: 1;
+	unsigned int mode_mask;
 	struct {
 		struct list_head i3c;
 		struct list_head i2c;

-- 
2.34.1


