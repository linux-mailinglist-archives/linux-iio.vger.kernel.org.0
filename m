Return-Path: <linux-iio+bounces-5383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969DF8D151D
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 09:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D449284723
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35B7346D;
	Tue, 28 May 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="ULHc/BPu";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="ULHc/BPu"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020002.outbound.protection.outlook.com [52.101.186.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18473453;
	Tue, 28 May 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.2
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880516; cv=fail; b=GLtyj5EV1129RalRdH5Xg7KfZE3uIsxdhZ3jbGy2cYR7JMr280hzqcB9/V2hQKwRijsjHJFIvb34C9Ww5AfpQaUm2PYhKBeFgfBAw+SXJ1/2aEL0W+ucwSHlLY19Wkng+ZMMnnhv4GjbOzLlNQR7oRTfzJ2vCPfsRmI6zEwEE2E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880516; c=relaxed/simple;
	bh=l1LpOs4rnXops93BddkM+No/wSWGbwKIX/7CFs4Z6RE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FhYShl2APvY6FLmH/10k7mCBCr1Sq2/CNZ8wAtyO0FTqwhuxC/1XR/NxROVxNT8GIrr9S51JsL5lT3NZcxVMjRW7JMNyAmGPFqIUe1M0kCKGcM0vVsfjZ6XDk49jwSp061sa94CH2mb7UFZtagBiBJEGuOykv7zjznZ5U98/xVA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=ULHc/BPu; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=ULHc/BPu; arc=fail smtp.client-ip=52.101.186.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=i9p7nOH9bE2ute5OZXQUnLAlgB3X60rof9I/zwZ0sZSRsFEr57jNIrDbQTJZWVcQO6Wts7OCtoPUktvGbwpIrIq79VkxGMo2JTEe09VgRvOtHmNRi6/5pYVjpbJyP3Jz7pBNfdsMETxpm8n11FqNPQ9hFgY9ynu2bNleaz3dx7/pTEigKhImSxCtx7jGk0ZIuSuDKHZDu3D59Aa1g9F9LP6VfpsDxGnpv4fAfAGBh5FtzinAEvsXqgigwGpzPdhRrgw4l/OyZ+Zr0CeQsXC1uEWCVOUsN/4i8+K5KT+z+eK3neHx/9vaBwBULsSc/FO8o9KKAm2AhpAWHUHconqnag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1LpOs4rnXops93BddkM+No/wSWGbwKIX/7CFs4Z6RE=;
 b=UJTb+CWqKA3AZZBY5vokGJTJBRQ7rZdZOBG88Wf2DP8215eJfHWbrWR0bV4a26hwYk3BHuaSymPOdHCIk5hk4Ax4zkUyqw5MzqqrVOSvTspbt0LMwzjrXmVOm9RvYsFmD9UQPZUE0T4GBYZBW9SqgXvx09OfDhEFecyPbvvV/XJIi7vIXXnlGK/Wfj0r5Qe/OS3TucK3i87Ar2H/kT9Cpcf+/sBgu8oUefBoyeevPTsRhWOWKe3Ddc4a3pl1LhMIjlfuBMi4sInOncPwKrvHC6NbhTgE9TGVW4hoGb5OniAF8k55Qfv3i/UCvdgX7bjojYjFmkD5rVo8FyytsiPLZQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1LpOs4rnXops93BddkM+No/wSWGbwKIX/7CFs4Z6RE=;
 b=ULHc/BPuQL8Q0hzb3caxkIDfmQeqeqXeJs2XA/d0XJKzRwp5ztW7vXpNigpc+L9j/i53TKPBzRgnYOac7FG19Wh+73BIKG3lXfg/fwwbeWCEmKyed0OsvjnGUZnmYMJafIBzEmCgdJ/3aHDuTg+epMQc7sJHEPDeL0MvYxH8ExU=
Received: from AS4P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::11)
 by ZR3P278MB1426.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:15:10 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::ef) by AS4P250CA0023.outlook.office365.com
 (2603:10a6:20b:5e3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 07:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 13.74.137.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.74.137.176; helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 07:15:09 +0000
Received: from ZRAP278CU002.outbound.protection.outlook.com (40.93.85.0) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 May 2024 07:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWGi50wMkaZ4HSnFtIpejIrh+dYgSppOyIEZN4DyWRnsaBWlTpMbG+LeabBOpOcP9w0j4YXLy4Tep2nbUNwuF0hhzL/prC/PcA5SF4scehhO6n+qZKCIXUWsQALEZdvmsHUniZxlLz6N5HCfuT9w6iRVG/j/ENjIUqFqr72RXhqZx5TXMGV5HG823eW/DiTTJqHi9Dr7gqw6DLHU85wV7G6vADsc54IJcuhes1Vi7q7fpUyglTkLIdrHp7/fITsklykddOV93+WCG5x3G0mEAkSHiV/l99TJDq0y6NnfrY6J6ppEzHP/Vx3ZkehYIeoQZmKLwwPSHJG4YGtY2TH0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1LpOs4rnXops93BddkM+No/wSWGbwKIX/7CFs4Z6RE=;
 b=apatGag2gWV11ERAIt4pbWK5vWJ9rtrHqAuxNoZD5FSy8oWjGRmZj+uVI9f3vxVaZPBQX2IduIed9azLCugJXRZNvKTMa6CdA72Aj5OcpvGQ5U6Is3+ohnO3B5EzJFouUT/cb+6diZfx1WsVUsmCvHgc76+SEIjS/uYAwnwLws+3bVvJUUy2xueXCbkXJqwRWne8ig022nwmU8+LF6W4YkBx8ZzQ+URrnWBrgzfvRLzqUo4ClZgApHfQs+r5cdu/X6QTlJAKxVbstJ08WNaP3xwLxfhaHLzw4ReV+Lu5+zOVAlzGrhNsR76eWqVFV4wiOmu9qLje0R9j61cJpaVPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1LpOs4rnXops93BddkM+No/wSWGbwKIX/7CFs4Z6RE=;
 b=ULHc/BPuQL8Q0hzb3caxkIDfmQeqeqXeJs2XA/d0XJKzRwp5ztW7vXpNigpc+L9j/i53TKPBzRgnYOac7FG19Wh+73BIKG3lXfg/fwwbeWCEmKyed0OsvjnGUZnmYMJafIBzEmCgdJ/3aHDuTg+epMQc7sJHEPDeL0MvYxH8ExU=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZR3P278MB1372.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:15:07 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:15:06 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Topic: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Index: AQHasFNBcKNP7BpFT0OAijsvpCIyBLGsO5Kt
Date: Tue, 28 May 2024 07:15:06 +0000
Message-ID: <ZR1P278MB1117E4A1B05DCB5E7020459181F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
 <20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
 <20240527-effort-hungry-c7bbb0b0e36b@spud>
In-Reply-To: <20240527-effort-hungry-c7bbb0b0e36b@spud>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
undefined: 2132904
drawingcanvaselements: []
composetype: reply
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZR3P278MB1372:EE_|AM3PEPF00009BA0:EE_|ZR3P278MB1426:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c13624-a63e-4e65-1e58-08dc7ee5e90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?ABCduD/kZWKydkOzNCce9ImTrEcbOJdaibaWM+xFxoEkKGbHK4jDriQH2I?=
 =?iso-8859-1?Q?kv+Ad50xICIw63h4XshiGfWRde+Slq9Z6KyJwX764WZv38CPBMMPh4dNZS?=
 =?iso-8859-1?Q?SMhrx8amXaZCntuHNsEZ/iK6x03lB/l1be25154R7H+u0HUJ+wN0h3XNQF?=
 =?iso-8859-1?Q?ZafMh4bnOmtKMwkHYP8Df5zrSuDKFUXq594QVzXXRsWuuS/sXzRA2G0O5M?=
 =?iso-8859-1?Q?Lq4wlPdJlnMtmlYWURC2m9xvPkaYV+qVaTXL+KEc91Jbnwok6Uqv6i/Ddj?=
 =?iso-8859-1?Q?CHykigZ8yU4dKoceJJE5qZchY0sVIx5zYU0Kcebbi8KMrYn+o0gZpnSJw8?=
 =?iso-8859-1?Q?7gOOR+8psWkfa3PXxXnfsRQdkHLfvGopXJoWYW5pb5gouvfCjOr2oErUy1?=
 =?iso-8859-1?Q?PucAF9yKGOfNDMZ0pKy/eUjOL3FIwkF+tGVfDK0b69QZYLhNvukNT0iiXg?=
 =?iso-8859-1?Q?ztTno5n2WynkZ0qNV6BrzVzCiQNrE2vFuLj2TOYgPDXaRMciH5T0QWjT+0?=
 =?iso-8859-1?Q?1Ji5s8nyW9k4Wte96WB61fO1ZHRHneafwQ7Xs5AFUfFyVf04z/qE01neO+?=
 =?iso-8859-1?Q?8HVk+Vrz6SKghSmud9iksYxbmlF2RRgrlxr/jHsbXfJpC1NPLimTKj/E+X?=
 =?iso-8859-1?Q?uXIF73u0bFR0S86Kc1gHf7WTBAtS0oTQXOEB55nYbs4kUMiqGY6urQb/qL?=
 =?iso-8859-1?Q?b9KQr7OaqB7zPIw5cL5E8W3lFCYd2MF8moW+RFznv+6xfFTTa76ztbKvac?=
 =?iso-8859-1?Q?MvOVDsXrlacDkqzGPBYC/CS2GNPfXbqPE+fOHyFwlnL0brRVzozikmG4yN?=
 =?iso-8859-1?Q?ZIFVhhBbQ7n1sZzlIV2cBs7B2uvHhBAp2vWUK08in1nllWdEi7skTx11z+?=
 =?iso-8859-1?Q?Jtaxz1MztYskWyBH7uQV/OB9St3qstr3PZiBi5JjCwmAECPLuIIUixWHQ4?=
 =?iso-8859-1?Q?BWSaQ4v/O5rzVGlSWjTb3nHund+b6X4qQnSLSXq5kt9xnW5ameN6aTmaqJ?=
 =?iso-8859-1?Q?Ogo6x626ySXJuXc6bnrwNOc7GkawP3oleVy1jw9IN0ZkzJDRYL/YDV7mLB?=
 =?iso-8859-1?Q?YVn8A5FduT0AVbTBSWmt/37LthuCmZO92EsPpI70q4PC5c5zS4zns+BO2A?=
 =?iso-8859-1?Q?FmrAVCAEHJ/7iBxSkQj1S0VC5YDrmLp23Vj8UkgpgE/4xYP86Odvj/DwPf?=
 =?iso-8859-1?Q?F6ZUqse8mV0WVzQXFzYm+1SGnbinHANVtjxTbmTuy0bmQxK1iEVzfKwE4j?=
 =?iso-8859-1?Q?1tlqatWUdQfMb9Ei3u8N+F4l8XB3v2Kj1yIrYPx9h0KetXKU4KONhon7hr?=
 =?iso-8859-1?Q?Co5tjX/GVJePUEHop/EmBLPCMhWMFC3rVv5sVlfNnqttlQ3X5Vd6GchX0g?=
 =?iso-8859-1?Q?lA22LkG1slaqj4J1BuaW3py3hLjHmsUQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1372
X-CodeTwo-MessageID: 1a306e6d-e4ae-4ff8-b185-f57207aa121c.20240528071508@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0a9c26ed-59e6-413d-d179-08dc7ee5e714
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|35042699013|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Rpo//6ec0Gzu0A2Lbk/fW+8Po260fC6AcyhiUt9uFjhjZVPKcAY2crQttu?=
 =?iso-8859-1?Q?6lVlHrnbsKpiIR98qBiOfdzD68nsoao4UGgh2wFIiqQlt1IBqMXhAJLpg4?=
 =?iso-8859-1?Q?BBsec8QTKZO2LC69e4CcaqLJ4GTz9bRZ4z1BKhbi4zvhEUETJgDoSbn1fZ?=
 =?iso-8859-1?Q?uJJ4km6Ggf0B3qChF8Y4Y9JVLQCq2l5BMaBHtelljRGEWSmWxL9e7PyBBv?=
 =?iso-8859-1?Q?Sw17jWoV0mV5wgdg2p78Erl9J57dRxV+N8hWoIAJz+cXA9leVwGvxzGnNI?=
 =?iso-8859-1?Q?9bnDKwGmPuesEjfd4lMQSwjOT3jV6HxRPCdOaGbdLIpdo0biY6J3IQv5Sh?=
 =?iso-8859-1?Q?9PF9GYjOE0Q92iY6JnwjQS6t5V0R5B4hrEzKDPmsUzA28mL7wAv5sosJDl?=
 =?iso-8859-1?Q?KH0TqpttbynX4Paqd4jMMgWj+A3Rm5LjgwJ57Ewx7hCTWVTlL/35hMqSZh?=
 =?iso-8859-1?Q?WIxYEy+FkQSDcrneW4OiF5Z2WJUYWfRNIoI8xOLf6uqB/69wMHExdLObo7?=
 =?iso-8859-1?Q?uF/TA4pIePH31XfT6OGW7+P0I55RUYy6YQ2xaDsuloClHi3xBQi6/OkdXL?=
 =?iso-8859-1?Q?Hy/sHXZ/Rx3bHHz5vWFRGuVAQMOzYLHqDnBnsEMWapbuhepQNK0yvx8Dov?=
 =?iso-8859-1?Q?vTT34ezoX+nItLthDsPleVbTVHwQyyeyB8CnaXW2dco2g3bE2bBHtvTQZ3?=
 =?iso-8859-1?Q?Jk5XvGa96obZB8Mdosv6PcB1z1Oz7DyJOGI87Zep4Cv4bkIXBm+McX7FkR?=
 =?iso-8859-1?Q?0pAQSMEZWyStiLEMFLEaMPHS9omCZUMEM91UWv1pL6UsVUcNxXlqf/34p8?=
 =?iso-8859-1?Q?8210H6xVwZJspGMiFJKy/lSvesT7Ugy9pwTtynokw7yIKiAseUiIYC7cYt?=
 =?iso-8859-1?Q?MQr4/nEa1OH/Vn1FNJHdpGsl2wQULk1iWSiMJbPiIdfKravZKw6ifi4uOK?=
 =?iso-8859-1?Q?kAOTlCTUtsJzip/ajLbyVP2DlqXdfvl9M5zBE3EVs0y5tS/FfE2G7JLZmW?=
 =?iso-8859-1?Q?mgbJB93hcRx/vL+PGBXCmhKIqtziZMGBGz89BWhQb1E6yDjrjWZaLBnqaP?=
 =?iso-8859-1?Q?69A7Y1fNrrQ22Wmi1ocKpxY7w3rmiF2aLK3yjB2aoUGNhtYYW9IDG5gA+8?=
 =?iso-8859-1?Q?F05S8IU10ymHaNDv03r75KnT5SG8PXN4VOej7ldcVPmAtksOgwODENwIT0?=
 =?iso-8859-1?Q?kwK58qolpBLRb25sh5GzSxHMTb6Ngqym+Z2yt45YzxntbrQdjE3SemvoqK?=
 =?iso-8859-1?Q?c4s59y7yhsSciFdmFzTTnN6o1NkbnBgGgDRCQoNWCgL3b+7v2EMjiQIZwr?=
 =?iso-8859-1?Q?qxD50c8SUOBEl52C8Xxfco4i00igpNCBPreP6k7jPpHLRSCtiw+AMWvPyv?=
 =?iso-8859-1?Q?2FPLz560j17PQBfNznMERW5WrQqpkOJY+36t75EAQOEKQE8YibxDo=3D?=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(35042699013)(376005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:15:09.9491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c13624-a63e-4e65-1e58-08dc7ee5e90f
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1426

Thanks for the Review!=0A=
=0A=
Cheers,=0A=
Arthur=0A=
________________________________________=0A=
From:=A0Conor Dooley=0A=
Sent:=A0Monday, May 27, 2024 18:30=0A=
To:=A0Arthur Becker=0A=
Cc:=A0Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowsk=
i; Conor Dooley; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; d=
evicetree@vger.kernel.org=0A=
Subject:=A0[EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML60=
40 RGBW-LS bindings=0A=
=0A=
On Mon, May 27, 2024 at 05:12:09PM +0200, Arthur Becker via B4 Relay wrote:=
=0A=
=0A=
> From: Arthur Becker <arthur.becker@sentec.com>=0A=
>=0A=
> Device tree bindings for the vishay VEML6040 RGBW light sensor iio=0A=
> driver=0A=
>=0A=
> Signed-off-by: Arthur Becker <arthur.becker@sentec.com>=0A=
=0A=
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>=0A=
=0A=
Cheers,=0A=
Conor.=0A=
=0A=

