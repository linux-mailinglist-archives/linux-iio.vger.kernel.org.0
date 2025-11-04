Return-Path: <linux-iio+bounces-25888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C6C31EBD
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DD3A4EE6E3
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B381296BD1;
	Tue,  4 Nov 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IMEVh4hg"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335428750C;
	Tue,  4 Nov 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271262; cv=fail; b=nRVRAfRbZca9aRHzDGTwaDaS/DiUdV6wF4VDMtbdlT3P49mJCFe5A7Hrx9wKKtrc9mc63GLzaHjcpWaU5spYIMXRkmXzjhYwR7igLjlNn8ONPmmAKd6bAFMF7auanbnW7AS81JywCmdG3R73oK7pW6HxfbEjeIie3px2nw7ey3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271262; c=relaxed/simple;
	bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZvIYbIWn3CtUp3DIwt5zVSKKXpP+F4FKs/LU1XP2mxFXzp5tsBoUYuh0ythRYfc33DSfCBKezyhZMv1vK/SCx4wdgC7BwybQ2sGHEuEyjEMxyC50WsUTLTg8Cp4KdEVy1XDjkETlxdkaJX5/yTACF9rsAHBBoF4qZEadJhPzwPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IMEVh4hg; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+mbr9BvVAL5rELOnPc3k+aZtafQTKsfA3bjfEbYYYzh7y4PUuhQP0LXYSzyVruQFiAtT9S0QqeopfQcXz8r9aSJemFl6QLCxKzI6lPZkRshYWGi9Si9mhZ714hdJ8wNLDvRm8jpePc74J7NphGuimaRS0uutz91mw1QDQ/PPLPUFUbbSXnexMsYqV6eJPKaqPHjvOYnXdmqrGmP/GRVv9vY6Vo+QHx9YdrAyGnimELJFwajzqqphJvCoii9CZ/LEPxEQEQIXDuVQkkHTOaHAr+ggTo2eUy8cf5lN5bNrcubrYmZlUpuLqzA6aBuwYx155I7H7PcesJpaa+KjFeLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=vIswAz+E4NlE9cgzv972I6ok9E1K/D7aHGa6ADDeJkNbkg8X7M53COvtTiEbOeU7IK/W4XAyl/HegZw3FzZ4PTFrSgGt2grgVkPvL6m1GKZxN5TVDLTzNJH9iP+VevxVsGUSlYzBGmqG2TGGFXMiTIFnGgmuyMmNS3sGqQjmZo7JlWWi2+ZAny6VhCeVn60fJ9UR88lnW/6/ahGklepyp9JSwpI59A3BH99rZob0S7YC+H6xhq6Ox2GBP8XpslDD4UgGHwmMSYJmarUDxth80d+KMo65yJfdmIo5nSeKiujP58acFD72FiQhfnHNl3Nk+MOCN4IpUfuKWV8fO8O3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=IMEVh4hgCDbJxSbYN1fRt+2AXW44GLDdrA977cIq0TytNnW5TB/yMnj+fTdMMMptnoFdPjWVDNRaJsc2T8eD/gvu8MsHy38jamxPaXQFurBdkjflGJzqsMCrOITgJJ1dN0udIEKzMuw0n17cZkhCnfFIsDu2LFfY7Iw9iYdGYdljBIGeUDJKHwWFe2/BRBs4ztMDIxHhLGBz7Ewv4SIdslhnuvprhW7lHfShh1/IefdjWzUdumBmm2zZolzq4iOBOUs/ZS9HFh5qAZ+iQ/kDfqPCw4RzvFNmmhg6DeIIlLS3x8M6GaPGxOdFKwNzUIuSGfN/eE2oG5UyRaNCckjxBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:47:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:47:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 10:46:43 -0500
Subject: [PATCH v10 5/6] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-i3c_ddr-v10-5-e3e4cbc17034@nxp.com>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762271233; l=1253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
 b=WZvkGtnUcaBJnclUriMb7OSVjyOJVLEXIFa319Kbsmm3v5IjfisgFcQKsmZg8rHC4QO8ryC/U
 dreK+smHUjNB2LLHdQ+VKZRXLUpK2pB2iAZddrU+6TT/u/t37EC+lqM
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
X-MS-Office365-Filtering-Correlation-Id: f8813a01-6207-41ba-d7a6-08de1bb97a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2R5WVI5b21wK3lLMjF4YmljWW01Yk01Wmd5N05HOGNZSlZ4bTYvazB1NTZt?=
 =?utf-8?B?K0VFb084TjNMdnN3Y2FHYVlwekNVc1dLYkQwTXpZZ2dKZ1VvcUc3RjhyL1g0?=
 =?utf-8?B?M1ExVGE0SlIwRjNHQmU1UmxLVG41aWpBaElmaXZiRVlhRDNyUXliSHprYnRF?=
 =?utf-8?B?TE5ENTBIZDJCWFQrTTNaM2xRaEJKcVZmRml0L2tJTys0eHZjZFYwd2FQaDVW?=
 =?utf-8?B?Szg0SnA5L0lDK2xLOVBDTVY5Yi9JbzRKNUpob1FkYzE3QVlzSmNIS3Q2aTZM?=
 =?utf-8?B?M0RXUi9QMUtEQmFMMnoza2Fxa1dzaGlFOXNKeDN2SnNqcEV0Ryt5VjdHMXFk?=
 =?utf-8?B?WW4vVUdvSWVzdVFySnJDT1htQkxyK0JTWW9OYVB1eldIazhuSWdDY1B2a0lB?=
 =?utf-8?B?RGZvOFE4RC9uTTNFRFk3ZS9Rdnhib0N4ekdqejhBM0VyeFNXamZiS2Y1N1JT?=
 =?utf-8?B?cHQyQWRhZ0FYamVuNmcyVFdHS21YbVZMTFFjL2FtM0hUb0h4WE14TWx3UEc1?=
 =?utf-8?B?ZXg4TVUyNTVpS2xMVnJQT3ZpRGtpNWVORlljcStzWm8wUDlkbWM0UmRnVnI2?=
 =?utf-8?B?aExyTEcvQThSdDROTFVBRGJoY3AyOEh3ODNCOVZnZ0RFZUwxTzgvTlJsTVd0?=
 =?utf-8?B?OVV2RGxlN1hiMUhKbUlEendaUWw3UUE3UUdtVGpMR1E2RlpQQ0VYS0pQdGZL?=
 =?utf-8?B?RVE4RkxmNlpNaXIyUEpsZ2ZnTFNGZzhpVlIxOWk0eC81RE9PQXVGcndLYmVh?=
 =?utf-8?B?QWlxdGUxVGhQOTFtV053RlY1bjJZWTFZdmVBZkJmalV5bWcwOGM2bGRkblVB?=
 =?utf-8?B?M2l5b29JMldRRm8yZkQyWjJzTEpDaElzQ0dzTFdlQUxyUHovYzZOL3FhUmNL?=
 =?utf-8?B?NHUxSnNEL1ZXaktxVHoxWkpQOUdYRjBqUjRjZkx6bEZVVTNoeXVtd3hVY3hl?=
 =?utf-8?B?RkNjMTBxdVdBRkd2Q2tiN1daRHdYQjdHbCtCT2NaWDVpKzBlbW9NSHJOc2FK?=
 =?utf-8?B?bXZ6Z3EvL29wazNnVU1jWE4wYVlGR0RPckFEWkdsL2dSRnZqWmtiY0hJeUk3?=
 =?utf-8?B?UXM0KzQvL3lVNXI4TGhNdm9YR3lBTDJ5K3BZREYwVjVNSjk1TFR1UzJ5anFj?=
 =?utf-8?B?Nlo2MlNUMEtoVDVVNGNQUno1Mk13MS84ckFvVmZCTHEyUjFzbjdOQXRiT0Za?=
 =?utf-8?B?SmtjMkxrYU8weFl6N3Z4cTQ1aERXdzNUZXRrOU1VUWlSTzJ1YVRXZlplU0RP?=
 =?utf-8?B?YnpFR2xMbUZ6WlUxaFFxR1lsYlJQbEhEVnEwM0o1RDRsMGpRSFVNZjhiSk5O?=
 =?utf-8?B?SnkydFpReENvZlRycEp3SVY1TUdvMlhiWG5oYmpPcU1QTDlaeXRpQU1nRjVn?=
 =?utf-8?B?aEhnQ3RCSEQ5WEh4Uk9yNUpsdUJvVm5ucmR5cnpuazNQaEpaNG1PenJyNjRm?=
 =?utf-8?B?VlBxb2ppL3NLRS9HUHNjeU9La1B5ZTVFTVNybm5GQmlXUldJL09zM2JZckFO?=
 =?utf-8?B?djh1MEZQaW02QU0rYWlVT1VlYUFPWkM0bzJScEZDWndSc050elJ0bXU4bHVT?=
 =?utf-8?B?Sk9IbG5OblUyWG5BQVovejlNazBGbWdiWkJtM3MwT2lIcU0vWWRTemtEdlF2?=
 =?utf-8?B?WDVuLzBQQ1ZsMmdObHgrTlFLandub2FUWk80N1dVU0NZem1rSG1MaHVzT21j?=
 =?utf-8?B?U0wyWno3Z0NtSEdVOWIvcXJPZEQrckppTk1xR3dScVkwN3lXTHpPRWJjVDNm?=
 =?utf-8?B?cEFuT1NsTFhTZmFUK0lMYzVwUjVKa09qcSt2d2M4MDFpY25SREt2Y1lsVWg1?=
 =?utf-8?B?N3pxeC9ILzVLQnY4emMrNkhyVm5KL0tJVDA2STliTXEwSW1RZXJVdVR1emJS?=
 =?utf-8?B?SDFzcHRKWERCVm5vNUg5ZWR3aTdNYkxFb3FDTCtmVk50R1BiMmJuMDNIMWha?=
 =?utf-8?B?YTg3OGxSdkRhdExmYWE4YmJWT3ZLN0Q3WGw2ME8vNktzUC90bVFyREZncng1?=
 =?utf-8?B?aFd6RDU1YTQxMmpvTm1FcGNlNWdsR2JBUEg0TUhIb2EzZ3VPa2hpQ3hQV1A4?=
 =?utf-8?Q?pRg//i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L09pVnBEWUpsU25NNG4rbWVHTGp5V2daQlc4NlRuM2pGUHdZbmNJN1ZiWjU2?=
 =?utf-8?B?YXNKU2dJWWhrdDBvZEhDblRnZXBlS0EvTVBzTkw3T1hEbUpsNXMzV0JEbzEr?=
 =?utf-8?B?aUZlRnQ3YmMxNjd0M2tHNnlKNm10VFBQdWVkQVV2U2ZoeE1qN0xVcnZjdzJ5?=
 =?utf-8?B?Q0lJdnJDNEJYUHZNZFpFeldwRllvU2RvUGIrVWY2alJGbVpYTmNVekxhL3Ex?=
 =?utf-8?B?OEdDMmNWSlJQSGkvOWtoQ0RBY1M5bW1pN042UnNqZUJPZXpIRG5MR2UxUHJG?=
 =?utf-8?B?VUJFNm05Y1g0cUZmQ1p1VGM2R29DaGVQRmNoamJ1dmNEY3FNR3hmUy9LVUww?=
 =?utf-8?B?eUlXN29raUFBVUN3ODVpVXJpRHE1elpMS2hMS1l1ZzBXc2ZiNm9XWURuYzRa?=
 =?utf-8?B?U05Fa3diODgvU1pyeWphc0UyYTBaYlR3SmNSSDRrTEd4d2JjY0lmTVl1Nm5G?=
 =?utf-8?B?M1VPZzV6UHNWb2FpUXBDOXN4KzJyZFBZS2JZMmFveDNWMFh6QVMrVG5aTDNx?=
 =?utf-8?B?ZFBIdXJoZGppVDZJWnREaTEvQUVvMnlNN3o0b3EreXFsc1hLQ1pHeWxNTjJ1?=
 =?utf-8?B?SVZMUG9pV1dxUHM5enpUMHdrREREb2NJRGczUjVYZTJnQkIrcEd0cktWdkk0?=
 =?utf-8?B?QUZVVmY4WHdrYms5S3AzNmQ4RGFDSGJ0aXVrWU9aU2ZvUGpVOXNoVGxKVjRn?=
 =?utf-8?B?ZnI3UE9JeDhjYWJNNk0vSzhncktXK1h3TTRJVThJc2wwSHJrUlJwMDNaK1pS?=
 =?utf-8?B?V0xwK0pDanZmbEFjZHo3YTZaeGtuVGFvbkYzL3huNXpidWVnS093QUhubjhm?=
 =?utf-8?B?VlJ6NTEyRTFzWkZ6Tjh1cUR2dWYzSmV4SWZhZFJ4b2VkRTY1eXZYM0JaMUdC?=
 =?utf-8?B?OHdnS0FFZTNNci9vN3U3QVFLY1BiRkdXTldzUU54cUl3Q1BuR0JrbXVUWjM0?=
 =?utf-8?B?c0JQTXI4YlhOVEFndlkwQmVoVDIwUFNBSU45S3dacDhDQVVXRmZ4U1VBTURL?=
 =?utf-8?B?Z2dJVkN0d1ZTVmlNMUp0RjFWaGRoY1NIQTdsek0rTUZoT0IvUENHZ21FcGh6?=
 =?utf-8?B?YXBBcno2YUxQNktCV3YyZDlzZEZJUGpNbGdpb2N5ZVNBSDUzTGVBSXgzajc2?=
 =?utf-8?B?YnVlTWtCeG5rRHJON2xsTDNnQUl4VGpkdmJFRExGL2pSZm91aEpyQW9EeDgy?=
 =?utf-8?B?TkFaeVllbUJxM0QvMW9VUGFuaTBQM3hsQmpQM2VCeEtKS0twajJLaHl5Vm1Z?=
 =?utf-8?B?Zlg2Q1p2VGdPUnNZTGxuaHU5VTRDdlh0Ukt2b3pmTlpJTk5veGJRTXVkTzc0?=
 =?utf-8?B?Z0VoQkMyaUFUbE40MmxYV3ZVbStlUVpJNTFLWC9PTVNUbHl0RjJMZm1NdXlp?=
 =?utf-8?B?OVlMN3BKMHFQNm9LTHFhUHVhRWFzZ0x3UDE1NFRUN1IrajdabmJMSGp5Wjkz?=
 =?utf-8?B?WnlPT1EwV0kycUg5VWRGZ0xuN0JSSERmU1BvWEt1QW84MUkrck85cWVpSTRv?=
 =?utf-8?B?ZVZEMXR5Q0dpN05kc0NJZGlWUVZiQzJGZjl2K0dlT3JtSE9EaHZ6Z3JIc1VT?=
 =?utf-8?B?S1BLek9lTVh4Mjh3WFJtb2NldVIwUVZHa2x5aU5WaWpEZFBZSFNnK3kyc09P?=
 =?utf-8?B?Yks5ZEdWSVE3L2x5a1ZBNk4yMHkrYU5CdTk4NnRtK29kMEtKRTdXRG4rY2E4?=
 =?utf-8?B?NzRpR1NzSU93Mk9rTUh5TCtXTmw4T1dqUUxFTkVLa2RyS2FvMXJhNkhKRytZ?=
 =?utf-8?B?cSt2QzQ5RitjSXIwYmRYb2VqOVU3SUxvdm1UL2JCOWxKLy9XZTJHdGkvS0Y5?=
 =?utf-8?B?Vzc3SDBlYXJXL1FoQlIrdXIvdk1YZW44VGFlVzBESVZJSHhnZ2pySmp0ZUdz?=
 =?utf-8?B?dkNDK2l4cXlhenYyc2ZpdG5obTUzVVkzdHVHY2p5TzdvOUlxVDJQMWxEMkE0?=
 =?utf-8?B?RnlXN09PS2I2SEV6RGo2QjdxdDBmeCt2Qmc3dzBaY0g5NlUzSVgyOXdQRUwz?=
 =?utf-8?B?MUtQMVBLU3AwZjhHYnVGVkg5bVRkVjdyNTd5TW13eGFreDkvOEF3dmxDemFU?=
 =?utf-8?B?Z2lyc0hody8vaCt0b3NFazlLRjJuUEpTUHhVYmtyTElZc0o4NHVGOUI0WEIr?=
 =?utf-8?Q?+TEg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8813a01-6207-41ba-d7a6-08de1bb97a8d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:47:37.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BhMT89uka2lFKUj7DEt1Jrr0eZ8NYtOgDvqS/irZlulZ/Klc362NY8IITti/DB+Z5K5T9DD8q3eUQYV1dQiiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

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


