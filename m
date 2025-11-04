Return-Path: <linux-iio+bounces-25884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790BC31ED2
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9232D427633
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A434273803;
	Tue,  4 Nov 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oEvJYzay"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C64271457;
	Tue,  4 Nov 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271249; cv=fail; b=L202Ny16K6rlfvdhHHSj+9YMQ6ppEpbMYRcT0gzA+l0BkckvgYKq9Ea6qplL6bzWSdnAFuwoNazp7JwCiPYH2WVsJ+QsnN4v7op1n0CyMcy11x2mK2bqW1HSsCUvjk/J8rVK0d68bh5yY9+9SdOlZeiRzCZcv61S7nLgnogMbkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271249; c=relaxed/simple;
	bh=Xu8bp9V4hfsx8ETYTi55tKRQ6COWT2egdx/YMlh7Rpg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M5WGSENY44PE15+STtp36fnNcF6n2sH1WF8wFK3dCr8jxPrY1BeEpob5uvmfSnbmQKdT5Kqc7ak6bgieFP3Qgx/hNRB2BNo13T+BD0qDHyzs7LhXI3lNSsI6uMr9ByTjrIWR0H1Qa8XR2+Q7sjWiASSTAiyAUaVBvcfFYY9VqTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oEvJYzay; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn2bLlegsfAbSgfzmVkWQbVj/MZw0Y4cSZqj8wLrVNtwlf2vluGH1klnHv1V+y/5U5lYDfs4y8LcxkN5yHfHHkFHMRwiaHycdAJOs5JyaHVgwhLfpLWa4JaFygpXLWnl/iJmf5QgxWlE9DJ8XwvHJQnmYMBVydXUKQA8aBBBJqmAUW81m/usJDYMdeeFgvYVXzUAI144gGK1sUzKaf6QauCDbtNrGhOb26cvFgbB6whfkchcEtxuVLUr2fBER1YdmdEAScObAx4OSq/XvVEVGVxDRO81b5ox9Vm+hC6oHE8gMhvNn7m5MvJKz+trT4RyJ+iNfZUY1yoobv51+W4+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OEKCc7tVnIacFKaPEeylBUa7U0P1wVjPQ/ux24a1u0=;
 b=XN6UZTWCZhgHfbZguQzntitEl47C4JUU5cKtG+zxTgSZapd+uhmGQv0X55H4dsD0zUq9vaIjMS62kxFFPytk2FTeVkxid9RNWM44UkVGsToGKYGmoY05v+xJY0K5YycN1dsoeqeK50U0ggu0TZQa4VDpbjFOwnmhBnB4xhKfXgp+nY4/diUDd+qhdpOTCJDjUEAqFsisWiTAc+Mm6gEnH9ulr9OniK5sfMhkc25sOX8WCGjNdWLMH/5SNNnyC6OUI3srH7fFLfcLLCN9kwmFWRUR0h0kCT/iG4cq682W1v8QJHVCjYAAmDPXCom12Z6cMZXQ5i5Cy6/7c20wQPMZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OEKCc7tVnIacFKaPEeylBUa7U0P1wVjPQ/ux24a1u0=;
 b=oEvJYzay1jmtP8RUE760U4SZovCsGVB7OFxsvDdC/VUOIXIdrG1xX83GGK6iXWo4vCc28b+MPJG2M8FE1zqvcZfqTVbluk2CprafWM5Di670oiwAcQQcIJd/QF5KucnX/RSqHTY8J03km4w2WW7mbilTdqYgFVw2vBUDPQm4pLD3B15HTkOfuLBsjsZ6xzVXbl7/ArTGISNVmCA7457Fcoq1EG5jFzNtJyQBlxEiPGLp+xvbbZB8KDznB+E7wyxtrc07EL7DWU+Q0tU/QL8gMSttBcF8j4+HlNlHiix6n6baX6dtZwdzJ7JxVW2m6tpKjxNi9+4uLwl8zfsN5o76xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:47:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:47:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 10:46:39 -0500
Subject: [PATCH v10 1/6] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-i3c_ddr-v10-1-e3e4cbc17034@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762271232; l=10620;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xu8bp9V4hfsx8ETYTi55tKRQ6COWT2egdx/YMlh7Rpg=;
 b=FHnkQl4UYASMX2MHSUWJGJvyreN/AdJ0TbDLy9oiJlLJJVaAkRVtS3geN8NekoZiMBk88hN3+
 IGRK3WjidruBPTFWJGavvGePycdGWnpt8Zdd08D1282kqpdNSREQqP+
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
X-MS-Office365-Filtering-Correlation-Id: a297060c-bc42-44e8-7724-08de1bb970b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVJ3ZU9qU1JOQXZOZlhhK3VSOFZLQTRiTmloQ2xmTWNieWR1elhqVlBTT2VD?=
 =?utf-8?B?WWw0bytieDRhWWp3UzZlaTdDOHVNN0hYMStveEpZUTlqb2VaNlFqbWtDQms2?=
 =?utf-8?B?SVQxdjdWMjZyc3NqdXJtR3BWaVJvN3kwNktGRWR1WWowYzhRd2VoSGNhbGg1?=
 =?utf-8?B?d0lXUWFzZTFHZTgyelZWZERKbmtlUEpqK09vV0o4VTY5U2cyMm5aYXJPUHhV?=
 =?utf-8?B?NjFjQmdiQjlsVFBPTXF3bDJpNms1eFZ6N3BtTkFXMUQ1WkxSc1c2S1FIUWNU?=
 =?utf-8?B?M3hhTmZFc0tRVGtzQno5SXpsSTBsMlFwSndVMjd2WW5vNEhLWmU2NEl4Q3Fo?=
 =?utf-8?B?WG5MUXJKYTlnUzFVS2J3YVVLeklPYnU1N0xhSUovYU9OTTdWUS9zcFFPTWIy?=
 =?utf-8?B?Sk42Zm5zSGx0S3YyVVZuV0wyRXY2NEJlZDUzekJYY3pHeHczenV3b3c0YXhP?=
 =?utf-8?B?VzlQRG81cnA4eU9ZS2Z6Uk9ZSGVEWFNzR2FXNWs3K1VmUFBhcE1mZXhqVHUv?=
 =?utf-8?B?b1pjSXNQMVl3dUxBSXpMSkxCQmZ5Kzd5bEhtZ0xBL0JVT2xINUJOampYTUNG?=
 =?utf-8?B?dGJxbXJ2TGN6MVRLOTBweU5hUDZZSTUrclJrRk8xYngxUHQ1YU1ndlFsblIy?=
 =?utf-8?B?NkhMRThnSHFHRnhhb3hGQ2xtRU9pcXVkdzJjQ0U5MS81enZIbzJjMGxFQWZy?=
 =?utf-8?B?aXdJT0FyNVFhUjdXdzNMT05OOHhLT0xHUDFqUU1VY0VONVVoRG1mTVVpaEZD?=
 =?utf-8?B?TitXWUc5SXQ2TEEwUWxFbk90R0lWLzY2SUdkSmczUUZ3SGR1Z1l4clgxVFdS?=
 =?utf-8?B?VVkzWDlSTS9SNDdSRWVPZ2FaT3h0YTBWYXlycGd6Rk51YmpzalNldHB2VFZP?=
 =?utf-8?B?dnI1bUprTmlWWVF3aFc2TnI2YXkzVkc3MWxIc054NElhakNKcTQrYnZDdUhh?=
 =?utf-8?B?MXd6OHdWU1JvaGxRNmNXZWVRbDdCeFowRE1KV2dVcnVRNmFydE9Qb3JQQTJl?=
 =?utf-8?B?a1hITXdqWG1WUWpDZ0Q1M3RZQUdWYVllOHJoSDF1elMwNmpNWTloMGtQQmVu?=
 =?utf-8?B?Y1hzRlhhRWdZcXZlaUlxUEV2N1FPWUpNUGMxNUhYMmw2Wml0Tkx2bjlsSDRt?=
 =?utf-8?B?MWdjd0hIcnN1QnlOenRRc283aVhWbTdtSVhMZTdYNG5ESkxhYW9Lald6NUh6?=
 =?utf-8?B?OUJ6QW1KV01sSlAvRm1rQXAxeWdZWHZIbnJxb0lRdXJ0c2FVQlVPK1B5Ulh3?=
 =?utf-8?B?Z2xrMFZLakZzdU04RXI4T1dhdXVrT3djRmpRSm9yb1VFWW1QR1JNWVVtVGxE?=
 =?utf-8?B?d0ozRW5YUjZ4b3FYZGVHWXBpZXpVUXFjZkVkUVNqUzRuZU5SeG9pYUNVdkxL?=
 =?utf-8?B?Zm5OZ2dyYUpkSFByRVo4aUZWcUpNbzRtbFEvY3EvUFFwdHJaNVlaYzFHUGVQ?=
 =?utf-8?B?bE5QaTZ1Y2JRTUIrWWhhTmU5YkgyS011VWJpdXZucWNyTWs2V243cFJOaDlh?=
 =?utf-8?B?eVhBcFJrQUV5K2k5OFl1Y04vaC9tYXM2UkZLZG1ZNHdPWUpDcFRuRVMxQmpZ?=
 =?utf-8?B?QlB1SVhqRURHK3Z1NUpiV0pQM01xZ2RSVTJ0OFYvTnFlekljcDdzdmh3TUZH?=
 =?utf-8?B?KzNOUVpBZEhDU2liQ0hycUZwQjFoKzRDeUpsNGFvRVkyNzhWYUk2eXd5aFZH?=
 =?utf-8?B?Z2F4YzIwQ1pSSTQ4aU5FYWJaRWNSNklBb29zLy9OeGtyRUFJaG5jejdzblJB?=
 =?utf-8?B?OWxzUkNGbWcremlQWmRxL2ZVekdhUmZuUFcrMkpKSWFZZ3o0TUExRUFxK3hJ?=
 =?utf-8?B?eG12QU5jZUlYSXpsb09XS294cEZ5MXZkbDdaZlgvS25wa3hxWUZPc1h4dXNB?=
 =?utf-8?B?L1o4SlNBcWRVZFBVeGhDNkM4WU50cVR0VEJkWmNPcWMwTDlJWktCYzlrZXRZ?=
 =?utf-8?B?ei9YVUkwdDJTcTZxdnU3SEtPSWxMYWJqVzlGQmM5cXN1WDlYVDBUc3o3Yk9z?=
 =?utf-8?B?TlZYMWJUZXFrUGtHWlJ6MVd3eXJyNDVGT2hVVXlraGJMZHRSSVZEUWJmQ2RV?=
 =?utf-8?Q?iijGrt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czRkTXZMckpFREp0N09Bd1oyWkw1Rkl0L2w4c1JNZFNVS3pJdmRuVFZ1UUdG?=
 =?utf-8?B?UkVabUY5czJUOWcxZUk1c1dyU0ZabWpPRVRWMHVHUHpFUlRJTDZoVisvWHd6?=
 =?utf-8?B?cForRzg4aHBkbGxNdGJIQWVYSmVwMGYxRVRCbjFHdkVKL1ZaZkdOU2JZNXB0?=
 =?utf-8?B?MUtXb0NSSGI0b1lhOC9jZnFYODByRTFoN0JVNkxDMFlROWdSSEVJd01RTTRT?=
 =?utf-8?B?UmxFcENqNUZYY0VpMUVLSGhvc3NJc1oyS2JJLzFCNzJETG1Pd2dqVDhoYUxq?=
 =?utf-8?B?bTZiYkQyd2paU2YxcmM1enVxNWZScEs1bXBLUTRVdk1kQjNSRlJ5RGtBOUVC?=
 =?utf-8?B?dzltSzNMUVNxWG1vVXhKM1dZQ1oweVZDUGJpSytzaWt0b25vZkJ2NGlLUkRY?=
 =?utf-8?B?ZHR5K2dRaWh1bEpOOWRRVVhOUWRWSDBSV3BQSzlxcWZ1SWYxalZocnBNTm9Q?=
 =?utf-8?B?d3VIOE5hZzNmS1F4MDVUSEFEZVlQVHJFbGh2Vkh2Zm1IZldSV0Z5QzB0MTJ5?=
 =?utf-8?B?bXprV2I5M3lvaFVZVmgvRzlvakdxSTY5Y05yU21UV1hEOHU1dmpmVWVQZGZs?=
 =?utf-8?B?cHdqcW0vWWZ0Z0ltYyswSHkzUXZ3NkhDOFpRVklkUm5PM2lXai9nYkMyczhY?=
 =?utf-8?B?dHM2RTN6dzUydHE4cUxlZ2NyOEIxTEwxSVdFYU1XQmZLZ1JkT0pFUWJEelZt?=
 =?utf-8?B?UzdZeE1mYXY1NjlkVWF6WkFDVWhiYlBITnBHbitCNmtQSTZBRGNqcmxiWUll?=
 =?utf-8?B?cnpqU1hudk9mRkJHYUtTSmlKcGhpTThxazhQOCtpZVdOT1p4ckk4V3dEUXRC?=
 =?utf-8?B?eU1scjZRUnN6Y0k0b054dUxBUW5xWlBhbzlMYVlWa3hxUnFLN0c1THlVWEkx?=
 =?utf-8?B?NEFlb0t5czJhamxRL1pvM3VRNkg1Yko4dU94d2hXYmNYZEpLMmJSc2ljczh5?=
 =?utf-8?B?NHVXdW4xVTJ6dDRBY1FwWVptcXp3VmlkZFZkMVl3S3hkd1hRWHFiT3l5S2tS?=
 =?utf-8?B?cERFbzNMVWlyUkhPUkxOL0IxRUhxUndhSFFXSC9paHl2MG9SQ3h4OEFFTnJj?=
 =?utf-8?B?TFNuZGFKMW1WU3J2MDBZNEZSSWpiYzlIMXhkRDR1L25NSnBEclVHVUxkQStO?=
 =?utf-8?B?UHRKb1o1aDVRVWJrcS92RjhtQ1RqNDFmaUtBMW4yTDQ3OVpTemRra2lMbE5F?=
 =?utf-8?B?dGlNRWxMVWh6VlJKcGRnNGVxNHpNV1RML2RrbEVGVjdUZEplWEF6K0hlcXE5?=
 =?utf-8?B?OU9mb0cwMkZZK3R3bFI5N2kvM2FHbVNGejZZMlFxa1F2bGdpenpVSkJjMS9M?=
 =?utf-8?B?SElmTGdZMEZkdGtNcUNISDBJTnhUNmQrdFpVNzlVTEVSaXlLaFNUU0JrekpH?=
 =?utf-8?B?VFBuSTFHMzNUWWg4NldFNXdnelgvdVh2UlpFNmZGUG9SbWMxSVZGYWJZQ0NI?=
 =?utf-8?B?SGJUa0M5RmVXOGlOQlNJa0NqQ01GNGl4UElQYWVZYS9LZ1ZyWmZIcXQ3bTV6?=
 =?utf-8?B?Qm0vMlZkbi9reEU4VFdDZDNCK3FHUUpJTThNQUFBN0ZTQUh2WituMklOWGhZ?=
 =?utf-8?B?OVJXT00wUis2bEdjU0pSa1hJOWlNM29vbjVabTI0emtBdis0WFdyWnZieWZY?=
 =?utf-8?B?S0NjaGRoRmdDZWxiNWtMZTR3T0krb2pGalRmUDlqbmkvNGNSYU5MeWsvMWlO?=
 =?utf-8?B?RzUzZDhlZUdqQ2VTdkRlMGtqUHA2aVdnZEhPc1BxUkY2WTJUb2dqM2tkbDU1?=
 =?utf-8?B?UWNITWxPcXQ2QS9XU3p4SUlPdTZ2L2dtWVlFQnRQTDZlQ0tYeng1U01pQ0t0?=
 =?utf-8?B?QUhVczZ2RFpWT0ZZZERmYUlaSmJwendsLzJRVVBlay9BZEd6eFIzYzNhcm51?=
 =?utf-8?B?cU5QeW9BL2t3NGdEc1Z4REI3MjFUOWk4cDB0S1dzMUNMYXJvT3YvZkFoT3BF?=
 =?utf-8?B?NW5IRFNsMWc4a05DUkowb0hWMFVESEdWYUJCQVdmdnRzaWxaTlFvcjZ3RzBE?=
 =?utf-8?B?V0dIQzFBQ0dmc1NtajZnMFhEdjJDcTgyL2NqbmVzTWNHczVTb0hEdUVrMy9Q?=
 =?utf-8?B?MGVKdm1ORWREcnhsYkNVNGUwR1FOV2R4Z05lQXBpRmZzRjYvQWJFZnNoR0pw?=
 =?utf-8?Q?yI5E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a297060c-bc42-44e8-7724-08de1bb970b0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:47:20.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBjNXkJ6eDwXONl09cxF4upXx8gvzChezDiiD4nnZO3xKooy6IJWpmQzRyZ6niap/m0qONvzw+WHLKncxNDhRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
Technical Overview.

i3c_xfer will be used for both SDR and HDR.

Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.

Add i3c_device_do_xfers() with an xfer mode argument, while keeping
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

change in v9
- fix typo Deprecated
- remove reduntant master->ops->priv_xfers check.

change in v8
- new API use i3c_xfer instead of i3c_priv_xfer.

change in v7
- explicit set enum I3C_HDR_* to value, which spec required.
- add comments about check priv_xfers and i3c_xfers

change in v5-v6
- none

change in v4
- Rename enum i3c_hdr_mode to i3c_xfer_mode.

change in v3
- Add Deprecated comment for priv_xfers.

change in v2
- don't use 'priv_' since it is refer to sdr mode transfer in spec.
- add 'mode_mask' indicate controller's capibility.
- add helper function to check master's supported transfer mode.
---
 drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
 drivers/i3c/internals.h    |  6 +++---
 drivers/i3c/master.c       | 19 ++++++++++++++-----
 include/linux/i3c/device.h | 40 +++++++++++++++++++++++++++++-----------
 include/linux/i3c/master.h |  4 ++++
 5 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..8a156f5ad6929402eb92b152d2e80754dd5a2387 100644
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
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode)
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
+	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 79ceaa5f5afd6f8772db114472cfad99d4dd4341..f609e5098137c1b00db1830a176bb44c2802eb6f 100644
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
+			    int nxfers, enum i3c_xfer_mode mode);
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 66513a27e6e776d251203b286bcaecb9d8fc67b9..30c5e5de7963c78735e96605367e9a762d286e86 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2821,10 +2821,14 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	/* Must provide one of priv_xfers (SDR only) or i3c_xfers (all modes) */
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -3014,9 +3018,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -3027,9 +3030,15 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master || !xfers)
 		return -EINVAL;
 
-	if (!master->ops->priv_xfers)
+	if (mode != I3C_SDR && !(master->this->info.hdr_cap & BIT(mode)))
 		return -EOPNOTSUPP;
 
+	if (master->ops->i3c_xfers)
+		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
+
+	if (mode != I3C_SDR)
+		return -EINVAL;
+
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..7f7738041f3809e538816e94f90b99e58eb806f9 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -39,20 +39,25 @@ enum i3c_error_code {
 };
 
 /**
- * enum i3c_hdr_mode - HDR mode ids
+ * enum i3c_xfer_mode - I3C xfer mode ids
  * @I3C_HDR_DDR: DDR mode
  * @I3C_HDR_TSP: TSP mode
  * @I3C_HDR_TSL: TSL mode
+ * @I3C_SDR: SDR mode (NOT HDR mode)
  */
-enum i3c_hdr_mode {
-	I3C_HDR_DDR,
-	I3C_HDR_TSP,
-	I3C_HDR_TSL,
+enum i3c_xfer_mode {
+	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
+	I3C_HDR_DDR = 0,
+	I3C_HDR_TSP = 1,
+	I3C_HDR_TSL = 2,
+	/* Use for default SDR transfer mode */
+	I3C_SDR = 0x31,
 };
 
 /**
- * struct i3c_priv_xfer - I3C SDR private transfer
+ * struct i3c_xfer - I3C data transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
  * @len: transfer length in bytes of the transfer
  * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
@@ -60,8 +65,11 @@ enum i3c_hdr_mode {
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
@@ -71,6 +79,9 @@ struct i3c_priv_xfer {
 	enum i3c_error_code err;
 };
 
+/* keep back compatible */
+#define i3c_priv_xfer i3c_xfer
+
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -297,9 +308,15 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers);
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode);
+
+static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
+					   struct i3c_priv_xfer *xfers,
+					   int nxfers)
+{
+	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
+}
 
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
@@ -341,5 +358,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index c52a82dd79a63436c1de6a01c11df9e295c1660e..d0d5b3a9049f0b5ff65ae6c5a7d59444b373edec 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
 				 const struct i3c_ccc_cmd *cmd);
 	int (*send_ccc_cmd)(struct i3c_master_controller *master,
 			    struct i3c_ccc_cmd *cmd);
+	/* Deprecated, please use i3c_xfers() */
 	int (*priv_xfers)(struct i3c_dev_desc *dev,
 			  struct i3c_priv_xfer *xfers,
 			  int nxfers);
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_xfer *xfers,
+			 int nxfers, enum i3c_xfer_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,

-- 
2.34.1


