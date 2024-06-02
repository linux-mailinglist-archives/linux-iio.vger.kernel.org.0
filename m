Return-Path: <linux-iio+bounces-5639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB378D76E2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D83B221D8
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DAB52F71;
	Sun,  2 Jun 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qMwEde2p"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C94AED1;
	Sun,  2 Jun 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343387; cv=fail; b=i1RhL3bX81LFN9Q7wuqEYDlceN9hA94N6VfpYTV3V3likTLPRgs34JSWLmDNFDqjUAMn5QTb6yVoDDDmm+wnWDF50BPXp6IEjQViFBrZL3DH14JWVp4YXvN08siWGp6f3SmkjLb8lKdvV0Jnu5O+0a8kY9Ax5vOqlHl325yxjiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343387; c=relaxed/simple;
	bh=yF2WjJebhM9u1UTN6ytXuZaSSDxmt0MCPbK9WhIwzq8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BSRStJttpRUxzfQlGBcYcA+U1fMI60UOBJ54Tcu2FKZsmvJFkiQz1/fyGTb8YYJ9tc0D0Xw8Wdo0pHJ7pbXZK5eV74cjngZz8Wie3nMbe1h/4YcsyqAew8v+A/Af1UxK7wtVO8b3NaDm6ahjwrD3Nx9OvK1zuMUYNgPhJ7vDPsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qMwEde2p; arc=fail smtp.client-ip=40.107.7.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYpLUg8UvMIjbF1DkXmz5UP1mR+/iiF99W/XLoMVFjwPD4HYK33KBLWRq5zwQuU6kFkpHjdmDwJv2af6gsAU7782t9H1eWAt/B9EZFsp/ISWfD8IO11MEMeBNDuR7msDwa2xJLH9xxDPaHt0oaTCpeRFDDrDcA2O80dqxV4xOoOzMHCpKe15pDPBWst3N1LeelN9c32z2SggekQYhTNjg48T9jPCbnYwC/n4kzhzyW+BlGjwANGj8Nwf4bgQGeMUF2eNYn+fuftObCI9ITq9XBQ6G5QegHRwcimIyT2T69dICoQkdtr73AF4ns974FzHIV2lD8A37qUMJKFhmaWAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cnKwuQg7UXBwV6gGpPTkPILMWVN2zd9PNolhRt2/9U=;
 b=b1sn17AyjiX7AqCf9QOQUGe89JXYX16tCVt5kYh1sjf5b2YgpGXFt2PlK5VLdkH3Ne6pJvRSpF+iJFqQCTY/adItJ7bauqzidoeBiVR+NP0WsFx+w7hM/ZHRELi04W6/P/rhNwKKFMxR9ArhGxGNMKd9q8LYbVTsumJ0476tv6vHxO6aEDen8MBXl934k0GZvfBd8yks9Gk3vn8y2vMh05d77+psfh171wg2UXUw85TfJJht4cEThA93Zf/PGBa+Z5f6RV8iWQhALhs9qhKf+KECHEwyfMgne84rMKpRAI+2yu/whvhc8JMnhN+wARIkfE4HjlLwfJ5G4YF2lHJ2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cnKwuQg7UXBwV6gGpPTkPILMWVN2zd9PNolhRt2/9U=;
 b=qMwEde2pd4qoBEe+zZK0u4i3vg9cO79VCQPu5Mjqlw4hVlKbPKitYomWn0Tfkm2lqqGQSac7cxelcpJE/LcmZQwty7Rwj5EUrsULvAOKbZM9TBvTAW/J/gvgHywOeQYyXp+4a1DeMEi9OutV8cEYAQeRWWHsnjR3GhTWtFxBfx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sun, 2 Jun
 2024 15:49:39 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 15:49:39 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v6 0/7] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Date: Sun, 02 Jun 2024 17:49:35 +0200
Message-Id: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+UXGYC/23OwWrEIBDG8VdZPNcyM2qMPfU9lh5cnXSFbizaD
 S1L3r1mKWxCg6dv4PfHm6hcElfxcriJwlOqKY9tdE8HEc5+fGeZYtuCgDQo7GUYHSqQNV9kr3v
 uOx9O4INo4LPwkL7vseNb2+dUv3L5ubcnXK5/GcJ1ZkIJ0iIiWa/BeX6t+SNFWa7jc8gXsaQme
 vD2NpwaV34gIhdspLjH1YrjlquFG/CdjVoz+D2uH9wAbbhuHDwxDRgsxH6PmzV3G24ad0Y7xSc
 TrPv3+XmefwHm/K2YpAEAAA==
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Konstantin Porotchkin <kostap@marvell.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7399fbe5-61c1-4ce1-3e3f-08dc831b9c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFlUQVhOazAxSGFtSzRPdzYyT2szY3N1TWxlb05yY0x0aWRuMzdHL2o0MGFu?=
 =?utf-8?B?cm5HUGtNWDBUem9aRUF0cnBTZmNOaUhJUVUwMk9vaENFTHIvWTM5d2REWXJh?=
 =?utf-8?B?a2xCZ3hYMkJubXRNL2pqU1BzYnJvWW9wMHl1NFhRbDBPNXQ5ODYzL1N2Nldx?=
 =?utf-8?B?eGZ4dzhFYzJoWWZSU3p4eDE2QkFPKzdaZHI5OXJWaThEQ21aVThHZWVFR0JI?=
 =?utf-8?B?UktIZ1Q0a1Q4UGJhMzAvc1VDaUJkclRCVW1aby9vMGFvL2pyeU9vNjY0Vkpj?=
 =?utf-8?B?c2xFczJQV053dkFlQWsxQjVJMkNZbEVFc3hRSXhIR0J1eWZxREpQbW9FWWN4?=
 =?utf-8?B?bjNENXdITEwreWVIRzl0Y2FHVkl3aG5XYnBJNWVKUGxzd3dIanQ5dlR2ZDht?=
 =?utf-8?B?VXE1NUFBVGRjK0gyRnBLZGMyQ0RSemI4cGxaUnVxTFlFdWQ1b04wZG9KTlds?=
 =?utf-8?B?L3JyNVRVOXE1VXh5Vk1tbnp0R2IxdGE2Sml6Q0VleS9TcklQTE5WSlNxRlZv?=
 =?utf-8?B?TzNMbzlLa1d3QU1rbmd0QlpvUVl1dVRHTjMzUVFFZFJWY1Y1ajJjS0xTb1Z0?=
 =?utf-8?B?WXdYMHJ4dk9ldFgzVWUzM3NjejZXYzJQMUtXT1JYYi8vRG8yaExDQkRNdjlM?=
 =?utf-8?B?cW5Ka2dLcG1xK2tlSE12WWVPdVhMeFRWWEZHRGVnVWZZL0RFVUtmeEpraG9I?=
 =?utf-8?B?aTlOaCtVVHk1SEVRYnF4aWxBc29XTVhRRWFsRFNmZVF4VnFrWlZFVnZyYTZT?=
 =?utf-8?B?dWZlemw3TlBqc29ZNmx5L2ZXTzNQQ3ozdnhiZ04zam5ITlhJazNXU0pLb2F3?=
 =?utf-8?B?MnQ0UzlyMldGNGt4Tk9lL2s0bFU0bm9nazhFNnpIcGpLZWFTQTRKZjJvSDRw?=
 =?utf-8?B?RG1XMWdKMjh6V3R6QmhhNWc0OXZoQjQyUUo2ODVwRno1eDRJUFdXUjA5elpU?=
 =?utf-8?B?YkdXVTdOVzBURnFtd1RYK3pLUG9VUndtTGlTMVg1OEVuTVlNaVpWSXVkQnZH?=
 =?utf-8?B?azkvVWNWVm11bjBvUW9KN2FNQmxmb3pKaHNvcE4rMzFEWFVmWXpiVGFma05a?=
 =?utf-8?B?RERIL2NkQWliT2FsTC9pWW1qaDFXaGVQY1J6aXdFTUJMTFdOTnhLUDdoS0NM?=
 =?utf-8?B?NVhKVnQ2RVUrRGJSSjRMMHlOSWM4UFhiWlFyNHBramx1MXhOUng1KzlCUUht?=
 =?utf-8?B?aFJ5bmFKclp2d1dBM0RUREpyekNWbUtUbHhUWnl4TkpsRDc4UWs5WGx1MjNK?=
 =?utf-8?B?ZDE4V0dyMnFKN3Y0cDRDQWdNQWNBbUNLN2N5VHByOUxMTmpoTmwySWVDd0Ix?=
 =?utf-8?B?UlBuTkhtL3BZNWU1ZXlpK3o2NkJxb3BYc2VGSmcxSjlwekloU09icDdYNnhB?=
 =?utf-8?B?K2xJamsrSy9EeHNId1YvU09mV2R0cDl3Q2VoOHVIeTJOeUovTUxweFJReFJB?=
 =?utf-8?B?TFZXV1o2ZGJGZzA4UHBqWVF2RW01bTBPcExMUTdGQXd3YkdQODRHZzZrVldh?=
 =?utf-8?B?VGhCb0gwNTk5eFJyVmc3ekthT2ZCaG42eDdzcUJXWFZwSTduVThkUWlKc0hQ?=
 =?utf-8?B?ZzJSWFhaT2NvYzBIMWZuOTg1ZjRXUTJzQnVQWjU0Vm9nWnNDa0g1Z2lkUkdY?=
 =?utf-8?B?WUhhUVZRc3puV00vaDBoT0VUS0NsbTNERGd2aGx3a3daMkJiR281aHVoYk5N?=
 =?utf-8?B?WlQ1VGNMTWNERkVwSkg2RExYNVlEQUFoMzhzU0xNRWRFVzZvM0NRRHNXUFdM?=
 =?utf-8?Q?pjhtWSur4sUC0XbNDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3FxSWFjWnpKbDRHTDBaVTdEdXg3TlB0c08wMVVjM09lamlrRHllQjEyNUNW?=
 =?utf-8?B?QUZsN3dRRWVhYngxNGdEeGlTL1hONnZ3SEVCajRjcUkvblpraW5rVVdqY2pV?=
 =?utf-8?B?K3RuWTVCbGVraHA1OW9UVzlKYUVzRkx5bUs5dW5yZHoxL2ZLaFd4VUxzdWZ0?=
 =?utf-8?B?dWtzdzJFcEk1SUxsYmlOWHRNMWVjUlh3TnhySXFYQkhiMCs2TkxUK2FPYXJN?=
 =?utf-8?B?MzJ6N3pGZ2RRYXlPZTRGcmlBSDZiOUVhUHYyRW9oVGFJalNFZWxSRFpEZng3?=
 =?utf-8?B?SVBYdE95SGx2My9MMEJnY1ZBSk1lckttdGx4S2EzL1dQN3k2ZFlqeldoT2VZ?=
 =?utf-8?B?eG1WNC91RStpdjdEbm9wRzJ3ZUlQVXNsbWtwMXI3WlZuRHJnUHozZFk5U1ZX?=
 =?utf-8?B?blpRb0tEMWlmRGZuN1hTOGFwd3dTSFRROW9GcE1kdGx2OElDaHprMFB1b3FR?=
 =?utf-8?B?OVFzeEtxczVJaDMvSG01UkprZ3FBckZrNjNoMFNETW9sZnVMcnZ2bCtnOWVM?=
 =?utf-8?B?NWlzU3Z6SkwrV0hadjNyZ3hxaGRRSmI0NnBrbHRNQzJUcWxtYTRMajJTSitW?=
 =?utf-8?B?U3BQTFp1U2xWcnhwMDVGbUMxenJwYTFnUzdmYXVQMFFteFRMOWRCL3lMOHgv?=
 =?utf-8?B?MnVxTDlTNTFkaDFaYzRqeitwZWk5VDBUc1JIdHZtaW90bGRtVE5LMENUVkVI?=
 =?utf-8?B?ei9IKzd4MzY4M0VQY3UrSm1ZbG90UTVEZFJRL3kvSW16dDluUWpHUGk2VDU4?=
 =?utf-8?B?MDdkZ1JtYTFXeUhKblQ1ZVBiUUZINXJJZHQ4bzRLSHZhMUhSZzRzdm56c05L?=
 =?utf-8?B?SFNaNmpmRFdMM3NBNWNCa2lyakVCTExaRXZvUHN3Y1MrcnpRZDllWHFackhh?=
 =?utf-8?B?UWpMQmlqV2gyc2pUSGNUdVJBS0l1RERpZFBHbXhKTWJ1NWdTYmgyVnZYUVB3?=
 =?utf-8?B?TzN1alFDTHloTXJDVFNkNFVPMmxUWVhSbGRDeER4QzZwcjV0SUhaa092OEhJ?=
 =?utf-8?B?N0ptT1Q0VTlRZW1DZTBHQytGVzI5NmNXc3p2NDROQTJYcUo2OGhyRzFsTTJp?=
 =?utf-8?B?M2VoOUV2UUwzUFZCUFV4Mlc3RE1vc20wazVFMTI0bEc1aW1OS0tReW0rTUdk?=
 =?utf-8?B?bHYrbkVQYjdSbXVFV1NMV2xtY05CdHZJVGxDZTlWWHhsTGUraWJJdzYwVUda?=
 =?utf-8?B?YVdtanpURlNxbVNOT2hDSkhjV3FTNElRb0dCZkpqR3RUUUdMOXo2QzRmd1Y0?=
 =?utf-8?B?a1VPMi94Ykw5WU9ySFROUEs2ZlViMnYvSFJWYXZScVBCb0VEMVpzNXFaTDE2?=
 =?utf-8?B?Zm5HVnY1YVBJVWthVjk4WUsyV2NDanV3d2tYVEFrbm9FSEJqRkNaUUZUQ0tY?=
 =?utf-8?B?THppUVl4WmVndmRZUEJoNTFsTCt3NkM0eWZaZ2NTZ2p5R05hM2N3bmwrU2F4?=
 =?utf-8?B?L3hrUEtNZmVscmJ5Y3lpSnVNWUhqNjN2ZUlqZ1hGZEdHTloydTlDWHczd2ln?=
 =?utf-8?B?THcrUVpubnBwZFFRenlPbjRMRXpXb0ZRRFFrSmZvUm55TzNlZ3dHQXdJQ0lF?=
 =?utf-8?B?MzdMdUZnWG5zZWh6UzUvSm9RUFg1OVp1WUtXLzNLR1A4eFpmWU5rUGZkM1hK?=
 =?utf-8?B?dTlveWM5aFdZblZHSUtJM0JyS2ZDSEtxMXAwSmtQd3RPTC9NQnpNNkxiR1B4?=
 =?utf-8?B?TEhEVHlyeDgxdFc5UEZ0blBPVHlUTWlQdkh2bzZTSWZpS2Z5WnJHL3RTem9v?=
 =?utf-8?B?dTc3SFlTMTJ4WXZOSTZaa1hjTDBrWmx5U28xR0FFYTRKT1draUlPcmViUkhE?=
 =?utf-8?B?Q3JuUFc3OFhDT2pEc0tMRCtXcWU2Q2ZBWCswOU1lVnordWJna1hLZzVJTFlt?=
 =?utf-8?B?ajZFUW1sWGs1alVuYW5CZGIybklETSswcy8yNmV3YURGVjgvTFo5c3ZTS1Ur?=
 =?utf-8?B?WEVaRmJ5bVBaaU5ycXk1eXpRbENhWExXeVhmbitTRGNESGxweldCOHN2Sy85?=
 =?utf-8?B?RnlPWjBBMk5ML21hQmVaSHRma0JxUzkzOVJuQmg1R3JXUTYzd1VJb05EL0Rl?=
 =?utf-8?B?WWN4d3lOVHpaMHJ1bnNmTVBVYlJ1NmpoS3dyeU1IK2xLQU5HRHc1c2J5Z0lw?=
 =?utf-8?Q?XxPLwUjj8/kTqYHUm6wjSJBLw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7399fbe5-61c1-4ce1-3e3f-08dc831b9c81
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:39.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q61hN6/n0AQDNiR98WBwBDSdP79LvTYi4+bIzb/wWPXOqn4CK3xtE+TosS1wvnRje7iJDEc3hfDZATCptWzSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
SoM used in Clearfog and Clearfog Pro boards.

1. Add new binding for compatible strings closely matching the original.

2. Add device-tree includes for SoM and carrier shared design.

3. Add device-tree for both Clearfog Base and Pro.

While dtbs_check is happy with LED descriptions behind dsa switch,
functionally they require supporting code by Andrew Lunn:
https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v6:
- add device-tree for cn9132 clearfog and CEX-7 module
- add dt compatible for tla2021 adc
  --> I don't plan to submit a driver patch because I can't test it
  --> might share untested patch
- add dt property for swapping d+-/d- on cp110 utmi phy
  --> I plan to submit a driver patch, already prototyped
- removed duplicate node reference / status=okay for cp0_utmi from
  cn9131-cf-solidwan.dts
- rebased on 6.10-rc1
- Link to v5: https://lore.kernel.org/r/20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com

Changes in v5:
- replaced *-gpio properties with preferred *-gpios
  (Reported-by: robh@kernel.org)
- removed fixed-regulator regulator-oc-protection-microamp properties
  This property is intended to set a configurable over-current limit to
  a particular value. The physical component however is not
  configurable, remove the property.
- kept all review tags since the changes were minor, hope that is okay
  with everybody.
- Link to v4: https://lore.kernel.org/r/20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com

Changes in v4:
- Picked up reviewed-by tags by Andrew Lunn.
- fixed a typo and changed 3-line comment into single-line comment
  for clearfog-base/-pro dts, but kept review tags since change was
  minor.
- Updated SFP led labels to use "sfp?:colour" without "color" property,
  to avoid duplicate labels while reflecting they are each dual-colour.
- Link to v3: https://lore.kernel.org/r/20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com

Changes in v3:
- picked up acked-by for dt-bindings
- skipped acked-by for dts because additional changes were made:
  - moved legacy netdev aliases to carrier dts
  - fix status property style errors
  - add pinctrl for secondary spi chip-select on mikrobus header (& som)
  - specify spi bus frequency limits for som
- Added CN9131 SolidWAN board
- Link to v2: https://lore.kernel.org/r/20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com

Changes in v2:
- rewrote dt bindings dropping unnecessary compatibles
  (Reported-By: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- added bindings for two additional boards (cn9131/9132)
  support planned for the coming weeks, mostly serves
  illustrational purposes, to understand cn913x variants
- cf-pro: add description for LEDs behind DSA switch
- cf-base: add description for LEDs behind PHYs
  (Reported-By: Andrew Lunn <andrew@lunn.ch>)
- Link to v1: https://lore.kernel.org/r/20240321-cn9130-som-v1-0-711127a409ae@solid-run.com

---
Josua Mayer (7):
      dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
      dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
      dt-bindings: iio: adc: ti,ads1015: add compatible for tla2021
      dt-bindings: phy: armada-cp110-utmi: add optional swap-dx-lanes property
      arm64: dts: add description for solidrun cn9130 som and clearfog boards
      arm64: dts: add description for solidrun cn9131 solidwan board
      arm64: dts: add description for solidrun cn9132 cex7 module and clearfog board

 .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |   1 +
 .../phy/marvell,armada-cp110-utmi-phy.yaml         |   6 +
 arch/arm64/boot/dts/marvell/Makefile               |   4 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 375 +++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 197 ++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 637 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 673 +++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi    | 712 +++++++++++++++++++++
 11 files changed, 2961 insertions(+)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240318-cn9130-som-848e86acb0ac

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


