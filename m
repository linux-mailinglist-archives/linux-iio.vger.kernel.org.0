Return-Path: <linux-iio+bounces-25051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42ABDAA86
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BF734EF2F5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73415303A1A;
	Tue, 14 Oct 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B9ZF3FiE"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F8302CC6;
	Tue, 14 Oct 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460032; cv=fail; b=E9QOzQJ5WGQY1kJ3CJksMysPf7pAohCMvV3Sc8Gbke62x/HN5vUMnIPSC13b6plNtkOOc3E7rPrZtKFoBYgDBXqnVAer3O3Xa8CACCmrAgGApjhMwTD99nO0T2R+9ucZxVQ0LOSWMj2LOWTezDNwpyRfdtBbiY28UuIU5CbRGBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460032; c=relaxed/simple;
	bh=GjLXL+gm1jWYNKCEbJdOq+74VWMbv2IY9wXQMF6gNPI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MKY5P7iX8lbOXx56w/qFFNyXKpqjyHOvS/YBN/1ibWi8vjDUAx3SGbCg98qzJU202ciQQDtZGKMlZuE01wCMZ0lUMyABD0pryyxjZyaWbBaBwif+kEjGoP5ptToMwuVCi/vuEedJsCLrl+kamm2oIN8/SDDYRTt/16+eYAi97Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B9ZF3FiE; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOWdsEf7XbMecCHH/e092tUA/LBUQHMCk8Ef7WqBiDKyvcHtqoa0SkI6768ppVKptIDDglP8YL/U0YnroXHxR0hbLGiWuRlmE6vK21pR/tiAgxZia0eIf8ytMTB7UNWnO5ZQcp1vjPU1+6mMJQruLpZIWS5ToRQo2Y12EzmO5T2eHtndvmiVsg9PZYp5gpD/DrvGJmUPtJeyOZzVjEvABCdmxPziK5bbEN3+69mHsjeHewwkdKQkGu5FeFGquE6DFfWdaBcDPW5xY9PKmg8FDVfKaw15u14vJBS7apJhs6f+Lx0R3xptdGRJVeQYduKsZ80MQDMbVMd5Ov7BWYmDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTm35wJWxfE/WuxTJ6c4Nb3jDUh3qajo5MQvh+ik9+I=;
 b=ly6QazNN/kdEd2g5jl9N6rrDFZZsMSb4MUUfOiXllcYZCLv8x4wgH1DEdcIYgoB9X2NiGglEy89LzNAt3qw7FgeJG76CaUoWGuvDvKbhBUBSi3h8gOT+kE89tr5Byp0oagGQqbPNjQUU7WBmvsddSjps6pf9BPJenpBym9TCTE9IeFHcvY5s1LIDh0J44VpBtoWtkdCCwmOJl9qRM37nxuPbKAv6GU/1NYo1AXWGyESlVhihlfDJVcqBxEf+4IrJ/9IiqcI65R56sKJZv/IyxWz+e0U7zwbwFgUg02A1e9NiFBRZd0SO8DGUwC96rAvRpxQrs8TTAAYlUdVKkxPQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTm35wJWxfE/WuxTJ6c4Nb3jDUh3qajo5MQvh+ik9+I=;
 b=B9ZF3FiEmx6DSBJRVQ2V+yVhgU+WVNA0itmWeHA5BicTal4RjTt8RTDrNY7dwgGL+mKjqN80RQgYvlGh3FrdqEoy6L1JVY8qClWTnHivZMHvPL4Q9dBJ3UF7IPI8klqnFnM2fE2koCSFmW45MjV2cPw0cVjRjOOMHbnfqpsfqrm59IVmEmW/UGEieJL9inZH0hHnkUNoDFv+nhXG2YC8Da9CuOyTxjSbOsdmcPDJqpVbzF1fxXyse62ZZAUkxnlqz3KXLxdADJZcXRp1yLCKmqbnWWqZt80m26zSLm0q1nBAPCfBAkkFnUa5Z2qwo4Q6LCWNBZuPzHcNyKSIjFQacA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10946.eurprd04.prod.outlook.com (2603:10a6:150:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:40:27 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:40:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 12:40:01 -0400
Subject: [PATCH v6 2/5] i3c: master: svc: Replace bool rnw with union for
 HDR support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-i3c_ddr-v6-2-3afe49773107@nxp.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
In-Reply-To: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760460014; l=2992;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GjLXL+gm1jWYNKCEbJdOq+74VWMbv2IY9wXQMF6gNPI=;
 b=aB7+BqFmeOZi+8kOGAO0lWyJbzg92zIerZQ431adZ8htXQKvZ3qeMYPXWMAMrVoTooxna3kSF
 e8CkY2jVUgdDOH/xITUoF0GxZ9pCarCUGh9xav8/dQCk7ASuQCRUJJ3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e534c15-c3d9-4617-754d-08de0b40610d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFRkVVB0SVIxaEUrSmFqSncwMWxUSEtmN2EwRFpFTFlrdHRpaE9xUTZZMjA2?=
 =?utf-8?B?dFh2TzlOK3QxWHFHbUlhSFhTS1E3T2pSVGE4UXpRTGVWQm9tejErRUkvNEQ3?=
 =?utf-8?B?QUxVbElFWHZ2aytVZ2FTRTVPRkVlS1JDeWdHN0hXS2FCd2oydC9mbDYxOGtC?=
 =?utf-8?B?N0puQ1pPSkdNbDhWVngzNkhkekpsWWhHMFBpaCszMjZxQVhNUVVQMDhSUS9O?=
 =?utf-8?B?M2FMaEJLN2ozSnd2NkVpQlF2SFRGMERFVCtLTy8rSHN3cm9KVy9tQWdEandi?=
 =?utf-8?B?NnFSR2Z5cU9PTnA5dnNmN3I5bUp6cTVhNHM1eHdKOFZwZmVkbUxkdk8yNUh3?=
 =?utf-8?B?dFZhREo1ZFBvWEY3eGRyb0Y3UTF0MStFVHVVOHlCeHhDMVVoVkdMWGFHMlRD?=
 =?utf-8?B?Wk81ZjhHS1RXRFF6aExDMzBXTUZObmZzaHdCbFB0c2VnWE5RZTFCMFZlUGRS?=
 =?utf-8?B?aDA5UGZWbThLODIyUEhaVHhJaTB5WXBXMzRITFd0RmRsd2FuYUMrZjFkYjJu?=
 =?utf-8?B?YlYyZ216cVJCNlE3cTJpenFRZndDTVowclFBZGJGQnV4Wkd5MEJwazhENGFB?=
 =?utf-8?B?SUhRbjVrdm9Ia0swVmZGeWpMWTRLenJ4VjZWSHhOWUlSRXBQRnk1ampTTnh5?=
 =?utf-8?B?Z1pNMElsVnh1SkliZnRZRnpaWDNQTzRHK2RlTUVHNGRCZElSTnVPa3lZU3Fn?=
 =?utf-8?B?cjFTMTNBakRydFU3emYzYVhqdCt4SGcyQ01ZNjlxQ0FHN083NWs0T2dqTTdz?=
 =?utf-8?B?VWNMVUlMYm03c3YrZUhETGRsSXpNWHFWTGFIanpVdjdRMWJLNGxYazFBWFAr?=
 =?utf-8?B?QVZaRno5RWRROXZwMGlTdW1uRk44NnVpUEtzUXJYbjUyQlI2UlZMMTJobkZ4?=
 =?utf-8?B?dHVadmNCTUFVSmhmWkpWaHh6QjlMTFFVUVc5cHNxeFlTYVo4NzlFODBFRzRJ?=
 =?utf-8?B?Y2djMFdvNXQyVDNjWVl0YVM1RmhGODJKL3UrVUdhQmxMbURVN2JEU2k0MEZR?=
 =?utf-8?B?S1B0Zityd3hxRmZ6dEVOOFE3Q1F2OVNvdnZsS0hDenZQM25WMXhvMnB3cW9v?=
 =?utf-8?B?R0VIWm9iNVBvZm0rYUQrTzI0UFVEVW9VeWhHNkNxUlhYb25nc0k3YzhlMzBW?=
 =?utf-8?B?eGhQL0dZY3BXUEM5VHhHMFFPb0RvV1l0eDAxaVdabCtJWjRRTEZYa3FWOFBL?=
 =?utf-8?B?a1dESEdXaG9tVm9tVnZKaWczYmRsb1FpZ3U1a0ZuVDVXSVVtd2VFd3Y1SGFJ?=
 =?utf-8?B?RG1maWZQZUdLRkRLMXR5ZHJPcmtGMmRoUFgvRWZOUkhwaHdQdk1aRzdQdWxS?=
 =?utf-8?B?YjE0RVBEWkc2RDJvL2VRdUpKYkVZWjNYaTNxRmFZYkl2L0ZiWmtkaVFvUGE3?=
 =?utf-8?B?STJjZDkxancxR3QyZmtMcWs2Z3ZwU1dJdU9CRXRYcGJqdW9NU0JjdXZjbjUy?=
 =?utf-8?B?K0lMbE5yaXZ0dk52WnRuMHk5RzROYXFVR1EwalJpTmRrT1NMWGxOVkNJQjRN?=
 =?utf-8?B?R0lPamN4REQ5Nmc0THZCdmhzQjE4T0N5ZkFrSTRiSnp0VkNqL0dweFJ2dVN3?=
 =?utf-8?B?dmVXYjBkaXFiL25FSmpmUEd3RFlMRWZYWSt1Y2p0YnNOWGRFOE5oMENrcE5U?=
 =?utf-8?B?NXE4ZzVzeTcwS0tsdHVxM0hTcnh0RWlCNEt6MUtZeVU2b2ttdjBmZ3pTelNm?=
 =?utf-8?B?dTVuek5DNmZyMENtdHpMUDQycWtxSnVCTDZqd3RzdzVodWRDOHpvTXZZc1Vv?=
 =?utf-8?B?UTVJT2lzUys2ZWt5ZXR0TTc0aGlCRUVEWVJZU1FJcjhwUVVwNDUxWVZoajdp?=
 =?utf-8?B?dHFPVk9YWjJWSElSUXpEdHh5L1BOZTRQOC9saTdvdmZCUmUrbEo3aGh5aHFo?=
 =?utf-8?B?MmZMeDBwSUU2UThFOWhWMWQ2WW15ZlBIR2x0WVJWbHRLSmFreWhwZmZQeEhW?=
 =?utf-8?B?cHJvR1NoSTFpUitFWUIzcERkR096SlE3NUJWRFN3ZmwyTStISThTTEhQckVY?=
 =?utf-8?B?UlNHMjFOWGpsU2M4T1d2bGVJNnRKTnVXbis1SHMrQndpRlo1c1lZUi9PWVpS?=
 =?utf-8?Q?P1fPQe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3lqdncrRGZGRUdxZHl3QjdVS3FjRm04eURzYVd2NUM5dkVPdEFJVHA5d2Ny?=
 =?utf-8?B?RFJyYTVZZ2d5ckVubjZONE5Tb1JQOU1oNEV5WFdMckdYalpET1JsOFo4OVlp?=
 =?utf-8?B?Vk9Cb1RER1JrU3FqQksyVERwdGsrUnhYNFBMSUxDUC9DbG5kVFBLYTgxeHZx?=
 =?utf-8?B?OUlwUUsya3F1eENxdS9LdDdna3Bpc3FQdk9FTEZyWVVIRitHQ0ZCdWpLdkJU?=
 =?utf-8?B?QWRxaitHdFFpa0lrWElXU1JsZFIrU2RNeUdrNlJna1BpQmNWa0toOVJ2aEQ4?=
 =?utf-8?B?YmVIY2JHbHdxSFdWWlppaDBOZ3J4VEUvaXluSkNqbVJLdFlNSUpvSmp6VEF5?=
 =?utf-8?B?ZjlNSVZPaG9hVlRIeUVJY1hkcmFoRVlLU1MybUV1eENVTTNTR3VMcG4xVTRo?=
 =?utf-8?B?bG5JRHFHcFJTVVdzRm1qV0RWQzdEdmdabm9kTzhWRTg4b2t0YlkvYVptSzV3?=
 =?utf-8?B?WFVlNFZhRGMrbi9MeVE5bTFGNGJxQ3hYT3ZPRWMvK21IL1loK0s3alYxcG55?=
 =?utf-8?B?UkdxdGtwTGF5UmRQU2JxN2c3c0hKT1BUSE1rREJrMCszY0JKM2tBaWtGNTFU?=
 =?utf-8?B?Ym1wT3h3bjcvK0hPSXFEdVk0K20zRmhzYTc1VFhRbzlWOFRURXY1b1ozek0v?=
 =?utf-8?B?ak51dEI4S1FFSUt3cCtvcEtrM1FzbWZOUHMvcTZmMEF4UFhHMFhsc0ZpQkg5?=
 =?utf-8?B?MURuaVlJV3hnTENHc0twWHdhQjlzZ3AzUlpFaStIVlVCRFdrb1hrRTFiUnNS?=
 =?utf-8?B?M3krajBIR25ZNEZiMVJVLzhYWXZnNWRMNHBEOFFKTzMrQ0VMaDVDQTBaSWp2?=
 =?utf-8?B?TlU0MVhZckIzV3EzcEFxOGZOT2VXUmZ1cFhHSWY5Ylp3NDQ5NXRRdFlhYS9P?=
 =?utf-8?B?Ty8zVTBsVXA2NmFYdUpUT2hxMktWUndZQW5mSDYxUHNZa1Y3TTFxc1Y3b0V3?=
 =?utf-8?B?V3Q1eXhCNHJuSjk3L0x0WjI0NStEcHlaSWQ4MW5wd29POU5nNXcrQ0daMC8r?=
 =?utf-8?B?WXhZbzI0cXVWdmtJcGR2K2FxblFHcDBlL2J4U0psSkQrS0l6bmoya2t1UTE5?=
 =?utf-8?B?dzc4clhqaWpFS1l5L1dFWXdNdGdCZjdrekxWMFlJS0JoQllLakZKNnN5Wmxk?=
 =?utf-8?B?OFRuTnlvNWtrWHhaM2k5VGtqNnJ0UXV0Q2g2eHN2UGZrQUNQR0IzcVVpNGZu?=
 =?utf-8?B?OS85dnVDOW9OaWZ3OHpPcXhNSGN1U3ZHdVA3eW1weE43bWJNSWxIbnQvbmJW?=
 =?utf-8?B?RVlZQnhVMjFsWVh3TkVsanRmNTFDSHd6TzRITW0wdlhhZHNkRDhOTlVhTzhv?=
 =?utf-8?B?NythazF5UUludVdCaEcwQWU0bGgwcXpGYmhRaEROV2NSbkZKSXBEVGJrd3Ax?=
 =?utf-8?B?aFBhZVRmUTRoRFUrbVR5STFZbUFhZ2lrbldpT016TkRwNWNWeFowMjVOUU9T?=
 =?utf-8?B?Nkw5TU5ramNvYUFnK2pyNlRaeFRweXRPcVNjZC9XdVlDS25vcXphaDhWRkZ4?=
 =?utf-8?B?cUNRRStIbGZVQUIzd1FmL0YvQU9qUGxKWm1HaUFVNUdmTmNuVC80bUZzTk1Z?=
 =?utf-8?B?Q1BVSUUxQ2tQbGdUb2dLY1g4UXlUQUM1ZWpTVDMrUHhndlFnUm5BSGx4a3Fo?=
 =?utf-8?B?N2p3T3BHdzdyOXlLRGZNMlkzZ3FsbHhLZU1lWVViTno2SXNCc0ZlSTVLTGFN?=
 =?utf-8?B?MWtUcCszUUQxNmRjblN0MWU2Y2tsb3IxZjR3VS93cStmTkNFdXJTanV5a3dD?=
 =?utf-8?B?NjlWZWVXeGFkVFN0WkFjS0hObitUNDl6U2tyb0NOaXZqSSttbkNXcDVZUkkv?=
 =?utf-8?B?VFBXbHlQRWp1TTVsdFFlVEt2RnlabXVuV0hRa202azFEMG9BOTBCc2VrRnFX?=
 =?utf-8?B?MUp3b2hRTy91cS90dFI1V3FqQ1JPdjJZdEp3ZzJOTnVzazUzMUhnazhSVXFW?=
 =?utf-8?B?cUt3UmlRNXVNWVhNYjM5MFV5SHFnUTlXUVd6WWcrTXgrc3ZxcUhNdHhOOUxP?=
 =?utf-8?B?NzFrTkdrVklZbXBpVVcya2pUMEVuVFFSeDJuUVNYUzVHY2p4OE9Cb0tHU3Iy?=
 =?utf-8?B?SStqbGxHZWUrbVBmODFzclB4bStEck5lT0dhVnlXRjA4TFE0clBLUktEMWNl?=
 =?utf-8?Q?Ng7F5IxpZFIlLUX4WVjVl5KBv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e534c15-c3d9-4617-754d-08de0b40610d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:40:26.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjrmcYASHTfSrqHIpJPo4o2aR9j3EsPXtlPlUnSfGmfL4ajK9PMG2SKHivCu6FfJwCTnMi74YYHlVUnYzj3jgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10946

Replace the bool rnw field with a union in preparation for adding HDR
support. HDR uses a cmd field instead of the rnw bit to indicate read or
write direction.

Add helper function svc_cmd_is_read() to check transfer direction.

Add a local variable 'rnw' in svc_i3c_master_priv_xfers() to avoid
repeatedly accessing xfers[i].rnw.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 701ae165b25b7991360f3a862b34cc1870a9a2ba..956172dc9d5f1f54d76b4c2917f2d9cf3bd21a85 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -165,7 +165,11 @@
 
 struct svc_i3c_cmd {
 	u8 addr;
-	bool rnw;
+	union {
+		bool rnw;
+		u8 cmd;
+		u32 rnw_cmd;
+	};
 	u8 *in;
 	const void *out;
 	unsigned int len;
@@ -383,6 +387,11 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 	return master->descs[i];
 }
 
+static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
+{
+	return rnw_cmd;
+}
+
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 {
 	writel(SVC_I3C_MCTRL_REQUEST_STOP, master->regs + SVC_I3C_MCTRL);
@@ -1272,10 +1281,11 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 }
 
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
-			       bool rnw, unsigned int xfer_type, u8 addr,
+			       u32 rnw_cmd, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued, bool repeat_start)
 {
+	bool rnw = svc_cmd_is_read(rnw_cmd, xfer_type);
 	int retry = repeat_start ? 1 : 2;
 	u32 reg;
 	int ret;
@@ -1463,7 +1473,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
-		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
+		ret = svc_i3c_master_xfer(master, cmd->rnw_cmd, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued, i > 0);
@@ -1656,14 +1666,15 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
+		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = xfers[i].rnw;
-		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
+		cmd->rnw = rnw;
+		cmd->in = rnw ? xfers[i].data.in : NULL;
+		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 

-- 
2.34.1


