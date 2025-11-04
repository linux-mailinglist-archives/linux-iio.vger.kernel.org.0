Return-Path: <linux-iio+bounces-25889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF8C31EC6
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 859AC4F7340
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10133254A7;
	Tue,  4 Nov 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lwqT8yi+"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE727FD59;
	Tue,  4 Nov 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271267; cv=fail; b=VawBV2r18DMRaAyJudBxmAKIH78eWUrf/2+DBUh9mys6XR6GiSZ2qkcT0AkzWe7b+9Ij4cDrbV6fuPTSL41VNQm/p6JTe9wqfWhGGY8IlLkZgNYAbbRqH0nxOQZ8Ywe/1QA3z9E7Ot1Tf8B30+qGxR+AqdKyGaAgQlG2SCPnhTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271267; c=relaxed/simple;
	bh=ffXg0kwStfghFn7Jx0IwhaYuYuN9+ZAr+/1/R/oYPUM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N04PJH+T03b/rIQjQvOyAcCPPW+xnD3RczbXh6jW63LQXC5uucgFswPR1WastAppayAeMG4xiu/b67HWD25NPuMxuM55GgbO3rKOCxFmITm/bz/2s2dcb173xuiXizZhiFq+9Gva705dpnBNbbM69sJFxMF4Y9wQVyrS1RJEgsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lwqT8yi+; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rH5AYD3pah/7GA8rcO/13Fn1QDFMggtNUX4erB45S9jV41X79ZBBuj8/MBLZpBF578WO/gxv0oB//azOYeBzSVe3GCaWW3U3YWStNRkuOw3iolHh5b+CghHgceZm7hFlYXyGznEkrAr1BgTWCzKYgt5ITyl+8hVuPHghMWkTD8r77xtyk9Q5xGFNcyTx/4nAzqzrXaaysP4Nk0m/BFGC7b6CvzWGF2Jqf8zagZkzg1BgzS/4V3M3UYi2PdP64DZzJkpfUSi/bwlXiAyc5b52yoOlwyBtr/INmlhOWlqCOyzOd324urLGR2fWlfJbC3eAyxawgKtVGGSeeVvMPV8Bkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqaAhxElLqpLLrKB8jdV3IwOmcE/reDMeRVDShYuFos=;
 b=gXmbtd8d7Cpy3jQWhqTwWtHPnb/Ksc2gdH7MkosUBlothQ+OcpzRHodFUsvE5y0AOl61ceIaqSqzUIc1xhtCorJ8K0aGhGfsoBRiD8mfI0dN3Wx33nk0rweLandgmHt9tiqrGVBSpaHunX53WyL0FF3oBujTa89LlVaJ/RF+kjjMLt8NJ1dELuklFbb1+DRwZHDC6H9M+SFDj843+0px7CedRTIIPP/V0qTziWDaKIDUM635pHxeob7A4IfnUr20rEIT1dP6Sy4T4wvf/aZ5qEVlBN3yMsqqFYh+oMFzgpIfmvIhI/HDzotBQ4Gl/s6ppWxtfj7y2ouTpbxEPS4Qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqaAhxElLqpLLrKB8jdV3IwOmcE/reDMeRVDShYuFos=;
 b=lwqT8yi+q0cg7aS6IDzaRqknQdOv1X8hFacasN/O4T+bJyCz7ScH5aoqX4k1QKld9qU6IeK0u7xloyTNs9hb80iPyUjTq4RU2QlIdIa4wsj22HCox9MOOEyJyZOqgSi6CYOw21+wpHpazycWNaaW9YV1w0VinsZnf3eyXMRQ3M16JxmzN00pTIiJAg/1WL9l78Nid0CIdnuo5ZbVpjsAbD7yEC6jhjtFd1+PX40b142/ZhkKEG41L/WYcV3VQ07k3v5DC2644krtvtntMpAO4uviXDeow9CjCT6osgm9SEfr6QEU8V48wahTWj/1AEg37miQWLirB9i+tW9NFjyDWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:47:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:47:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 10:46:44 -0500
Subject: [PATCH v10 6/6] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-i3c_ddr-v10-6-e3e4cbc17034@nxp.com>
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
 Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762271233; l=19369;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ffXg0kwStfghFn7Jx0IwhaYuYuN9+ZAr+/1/R/oYPUM=;
 b=DGiij4cLGTfaZfFHnCGfpOHbe4zO5hNArJDOqHiDg9W3BkDAps7T7ORG0BCBp1O0fRWj2506W
 aovoPOiMi23C0uXDCCsg3G6xtsRJMBrBW/bSTEcm7n2IE9MUiNI8H6Y
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
X-MS-Office365-Filtering-Correlation-Id: dc21f2c2-9423-4d8c-5a10-08de1bb97d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkdwVHdYYTF6aFpHa3drMm1CWFJKRmoxd29MY05nVFhYRXZZRHlxWDJTM0Jk?=
 =?utf-8?B?a09ka2JSUHh4K3k5a1F5R2FscHZBS3llL2ZIR2tVbFNxaEtKQ0RRRDBmaHVS?=
 =?utf-8?B?Uk1HYTh4c3p1cCtlUHg0dENCZUpkMndqTDNlWU16azF0L3lxQzZEZUZscGRo?=
 =?utf-8?B?RTQydWlDQ0lGOW9pTm9RN29hRzhjL1NFOVJZSFpKdDkvYnl4b0dDcHdtUWxQ?=
 =?utf-8?B?WGNrZ0lwK0d2eThmb2hmR3FuZGRYVWcvTEN5c0Z5RzlYWUFBSmlLblpSbGl6?=
 =?utf-8?B?SVRwTGV1ZWZHYmFJbkhrYlpkTjhCQTIxdVhJUUJLdnI0Ni9UTzFaVks5WjZO?=
 =?utf-8?B?TEpBYlBDS1BKbjAwcTlhZndLcU1yL3MwNWxhS1B2M1dNZ2lQQjBiK2VzZXd3?=
 =?utf-8?B?MzVIc1l6T0hPUTJlN01iK0txelhsQnRxVXJiSGpPZXFQSDlZdFR1SUp4dVlw?=
 =?utf-8?B?NDlxVTBwMzdFbi83Lzl1Y2gyd1RRVmxRbE5uOEo3WklqSVpOQi95RVhRSUE2?=
 =?utf-8?B?UFB6MVpKVGhzSGxmMEZZTkpXNDQ0b2FRUDBHcXJKNnhEcXVGbC8wc09yUVBp?=
 =?utf-8?B?ZFQ5VHB6aWtnb3o1NG0vazV5VUwxcmJpU3VueUtBdm14emZzZjZmVHRjVmRI?=
 =?utf-8?B?azFLeVlDcjVpOHRzQmRiclBTd2NaVGlNbUQ0ckluRjlWcXBHSWdkd0xPeFV0?=
 =?utf-8?B?dW82MFYxVlZLc3Z1NGZkTW5xcEVlSk0rbzVJM01IZ1VQTGt6bkVkRDJ1NWJK?=
 =?utf-8?B?eTBpZHdnTkxkVjR6QytzVzd1ZmYwT25qa0VncU51RjRhWnM5d2VmSlRSaHVo?=
 =?utf-8?B?Rm5WVTNFcG1Jem9IQzBSSlpUenVCaXlEQm5oM2t1aHB5cHg4Z3J4ZzhkM1Ay?=
 =?utf-8?B?Z2c0UmtIcGhVNGlnaXAzM29QYitNUndwa1VVUDNTZzloRm8wcmZ2TW5JU05T?=
 =?utf-8?B?c2ZHQjg2NGFOTFVGN3RIOXBCcVBVYkk5cFJMRkRHMCtnemRKbjZ6YUhaRys3?=
 =?utf-8?B?d1BjeStIVFk5N0R2OTRCMTc2TmlPcHNmcWhJUzZKbHZkeitaYXR6dHpEMWxj?=
 =?utf-8?B?UGhtZWRUS0lnUmxrTmVxUTl5enlPeVc3WEFTNDlBTXV1YXZydW96R1F0RG85?=
 =?utf-8?B?VVpTeTBHNHFFeUV2RUwvSUZmYlllWWdEL2djcURXSjdwdyt5MWk5Mk42V0pp?=
 =?utf-8?B?MFRUOWNacjVIVU9BVDBGakdUUk1yeFI3ZjZZK0ViTjBtc1BJc0RnUXQrdmNO?=
 =?utf-8?B?V2ZjdFVPdm9sUHNPbDE3MmdwOCtmNGVNVzB2L21iUUZvMlM1a05oZXBYSFNI?=
 =?utf-8?B?SG1FNkI3bFZOeW1JMlRSTTVJcG1oVHQ3MlZtdE9CSWlEVmlQT3ExRXlEaHdY?=
 =?utf-8?B?U1VXY2ErYjUyUlFsWHBtdHd5eC9uRVpWa3lQczN5aVZWOVgxOVlka2EyZUF3?=
 =?utf-8?B?N21EN1dmN3dCTUdNVVhwdUlWekQwMVUrMnU0bHN1ZitMcEhLdFhoeVg2dW1o?=
 =?utf-8?B?RTBYOWpRblNCem9WQy8xZU5RRi84eEZRU2xsVDJvOVR0KzkycjVJM1BtbXor?=
 =?utf-8?B?RVV1bDQvaTJTaG41a0hBOFJCb0FJOWVmTDVFdWxxaTBmQjJhOU94YTYxZWR3?=
 =?utf-8?B?OHJuYVNlSWxxaVNURHhIa3d5eUxEdURseTJwcE50SHVML1VGaTBkWkQvV2xP?=
 =?utf-8?B?dzNQTGtkN3FHeXNJUDdLaDJjUjR6ZkllYVFUTVJIMWVLT1JQdVp2TjczTFpz?=
 =?utf-8?B?NG1vVCt3TWVmSTBQS0hxNSt2OUpaYjJ4VnpjMDNST1phMFBRQWRKUE9uekxr?=
 =?utf-8?B?bHgzM0J4cDI5NlZKOFZvT2kxcHRKOVNOeUF2T0lvbU84QUV0M1dPaUdiRGRG?=
 =?utf-8?B?V0gzQVpIa1NWWnp5TFRGNFhCR3BkS3ltOFBhY2tSazl1dFVML0ZHbWpsK0ZJ?=
 =?utf-8?B?aGx3dENuTTFPYXRRQ2wxWjBmYkQ2RXN2dGZNeHNXK0srMVhYaWlYR0FMVUhJ?=
 =?utf-8?B?ZC9MTy82VTNWWEpsMHVWWWhLMGd6SjNmbjBKemFRWDNtc3BjM2x2UzA5bExL?=
 =?utf-8?Q?NyaQLn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGNCcVZISmdIOCtkaDRBcWFETS9JRmxzMEVWbGo5R3B6QWprazRqMEtyNC9s?=
 =?utf-8?B?RDhWTjhUcm1BOStKTi80YTdkdmNrRHlvbGdQK2F3a0RhNVNsalhhWVBtekl0?=
 =?utf-8?B?ZTVwN1dCV1QvekV4SUJ4cThRZWF1amlXc3Z2Nk5YMERGT1RCVGdKR2hzbWlQ?=
 =?utf-8?B?RXUvTE5XZXVtQndUMzBxc3d3Q1JhUEdQeGVhN2pYM3RYM3lIMlprOXNEdysz?=
 =?utf-8?B?cmRTbmdqQkZzcjc1TmJ3T3U5QkxlR1pjMTU3SVpOMTBNN1kvWXlsanI1M0JZ?=
 =?utf-8?B?U1pndHc4N2RRZHAzNFJLR3p1d3JQcWZIZ1AzUHpXUEE1WkhWclFHRXFFaWVt?=
 =?utf-8?B?MG1mOVB1RW82SmEwYWd4S2JjUndoRkw3cThmYkphTlVxa1VLTlJFcm1jSGpW?=
 =?utf-8?B?ZGJJalNRTzIvZFNUQ1BHRUIrc0RDSHI5ZVpCWG90dmdMZkVhcVBYbHNMTzlx?=
 =?utf-8?B?WERYRUErVmtYa3ZOZXRxcjJJTjhyY250MjJiUjVzWXpwS3NrY2ZyS3N6T3lX?=
 =?utf-8?B?M3NhMG03THlSSEFBNXE0OWNkU2UrUkthb2FpOFVIOVd1WTVQTStHT0ZyVGY1?=
 =?utf-8?B?WURYaVVvOWozZDN6VVVLbVVqcTd0d3lqTG94QUJUNDdXMkoxZGgxU3JBWUoz?=
 =?utf-8?B?OFBiTkRNOFZHdHpJQ0dYeU5tcytJbDVScWtXWXRmVlQ3dEQwQ2tKUkY5RUFa?=
 =?utf-8?B?UWd3RVVMNitFdUp3dGMvREhnN3E1Y0V5b1ZORXhTR25GSUlCTUttU0JFd1pW?=
 =?utf-8?B?T2ZKMytwbFdtMEJOZzdad1RmQkJrYmYzQW5IZU5NTUJjSllidE9PbWlEc1BZ?=
 =?utf-8?B?ZHp1VXFyQUZyUDd6QjhKdDJCK01FaEk3RnZTK3JPNDJrc3h0dWJWOGlVVjJ5?=
 =?utf-8?B?T1ROSk5BMUoybFJXUThkV0dxS2VlWWw2WGtCbXZVSHhGWmQyZ2FjTU1Qd3lJ?=
 =?utf-8?B?WVZKNnIwdTgvSDkvWmo2TXo2YmZUUERDMzlVeTdBa2diU2lMdC84cm9yZjBX?=
 =?utf-8?B?UGN6eXJUSTJDWUFIYW1STjJaaUp5WXN1S1hYTk80bjhYMEVyQ1lOSXk3aVZu?=
 =?utf-8?B?RFBzcUVDL2tWUzgwWTVneGVsRkNrNHlYZzB4bmZqK2Q2N0k0NWhvaFhGeEZV?=
 =?utf-8?B?T1RTMmZEMzZENTFIQk9nMWdvWG1QdmFFZ240b0ZlN0dEZHpZL0RoM1ZaNWF3?=
 =?utf-8?B?NFFVVzNETTNkcS9vYXc3L3h2bDRpSGVqbkFDUHUrUFRORVdUajJhWU0raW9W?=
 =?utf-8?B?R0JTNnpWNldzVUFWTkNQWE01M2l1dGNWL3RxZ2JoOHhxZEM4NnBYejNHcUFm?=
 =?utf-8?B?TkJSNFpJR0pBbVFER09HVlFtWmhEaWZrcFhIdGc4K1dWVnd1SkdRRHdaQmdk?=
 =?utf-8?B?d1lwRjFWZTIvV0QvbVIxTXJlTW9tMm41RVBJR05DdzhTY2hLSVlqakxTMlpr?=
 =?utf-8?B?ZURiWld0NFBlUWpHTm1Cc1N6cG1HeU05T1ZLVkVTc21EbFo3NkhRZVd5WEJw?=
 =?utf-8?B?QTVPYnpJbXcybkpJby9wNUZmYzQ3SDR5dUZxeUREOEhhN3M4ZHdNeWFBd1Z2?=
 =?utf-8?B?aGpqcG43azhkOXUwbGhsVW8xa01EeFErRDJPVXM5dTZ0Y2JiNCtaVWgwSWhq?=
 =?utf-8?B?bk9sK1FVc2tXYnBQZTZ3Z1NQcndzb3NPMmhFU1FyM1FEQkpjaEVXcnhSNitT?=
 =?utf-8?B?OC9idUozZHo0R0tCVG5BektoNU5peTNoMHdWSEYrRXNmcE5xMjFRK01IY25o?=
 =?utf-8?B?cVRydXorU3M4SjNiTkFrZmVmNHpjS251TjlXSXBXV1FwOFQ4K2FYWjl1aSs4?=
 =?utf-8?B?eVRoSGlGVjFTLzdhcTdyY0pvTGRSdTZJc2FiL0VSZjV5eFRNQXNZaG1HVFEx?=
 =?utf-8?B?Y09YSjloSXZyb0FEcFVLNUZxa2I0K2s5ZlIrMTlZVS83R2w3Rk5zZ0hZaTFE?=
 =?utf-8?B?ZFJMaTdJM1AyZDZyRTFxMmthRnA1cEpubmE2WVRlUTRPNVlrZmpWOG5jU09p?=
 =?utf-8?B?RFFZQlFCNUp6V1pJc0Yzczc1cTUwYlNsTGtxT2NmcDIwaFlUZGVma1JMdExj?=
 =?utf-8?B?WmREYnlBS1dhUmpveVl0bDRuVm1seHhNcEdWQ2RnQlhwY2g1eTIySFlnVXBv?=
 =?utf-8?Q?i474=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc21f2c2-9423-4d8c-5a10-08de1bb97d15
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:47:41.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmE7+mOx44vaoXc7OHyP5XGBWLM6+RZ9mwx1fjImlP9iPLY4UBxuXaEa4p9kPLMjqgru2sZiWxqb10lMy7Vt6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v10
- align datasheet register name
- remove reduntant regmap_attach_dev()
- add missed \n at error message
- move *regmap to first member.

Changes in v9
- add time.h
- remove dev from mmc5633_data
- remove struct {val, val2}
- regmap return value check use if (ret) ...
- 1 -> ARRAY_SIZE()
- use guard() replace scoped_guard()
- use regmap stored dev
- i3c device use bus assigned name.
- use devm_kasprintf() to combine friend name with device ID from i3c bus
  and it will avoid build warning to discard const return from dev_name().

Change in v7
- add missed *.h file
- remove reduntant empty line
- add comments about delay 1us after SET
- use USEC_PER_MSEC for timeout value

Change in v6:
- remove acpi part
- return 0 for success path at mmc5633_write_raw

Change in V4
- use { 1, 2000 }
- Add _US for timeout
- Use GEN_MASK for MMC5633_CTRL1_BW_MASK
- Use { } for terminator.
- remove !!
- fix mix tab and space
- add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
- add tempature measure support

Change in v3
- remove mmc5633_hw_set
- make -> Make
- change indention for mmc5633_samp_freq
- use u8 arrary to handle dword data
- get_unaligned_be16() to get raw data
- add helper function to check if i3c support hdr
- use read_avail() callback

change in v2
- new patch
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5633.c | 588 +++++++++++++++++++++++++++++++++++++
 3 files changed, 601 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,18 @@ config MMC35240
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc35240.
 
+config MMC5633
+	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
+	select REGMAP_I2C
+	select REGMAP_I3C
+	depends on I2C || I3C
+	help
+	  Say yes here to build support for the MEMSIC MMC5633 3-axis
+	  magnetic sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mmc5633
+
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
+obj-$(CONFIG_MMC5633)	+= mmc5633.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
new file mode 100644
index 0000000000000000000000000000000000000000..1bae6ffe3f18315ce079cb08c2286653cf71c9a4
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5633 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ * Copyright (c) 2025, NXP
+ *
+ * IIO driver for MMC5633, base on mmc35240.c
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define MMC5633_REG_XOUT0	0x00
+#define MMC5633_REG_XOUT1	0x01
+#define MMC5633_REG_YOUT0	0x02
+#define MMC5633_REG_YOUT1	0x03
+#define MMC5633_REG_ZOUT0	0x04
+#define MMC5633_REG_ZOUT1	0x05
+#define MMC5633_REG_XOUT2	0x06
+#define MMC5633_REG_YOUT2	0x07
+#define MMC5633_REG_ZOUT2	0x08
+#define MMC5633_REG_TOUT	0x09
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
+#define MMC5633_STATUS1_MEAS_T_DONE_BIT	BIT(7)
+#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
+
+#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
+#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
+#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
+#define MMC5633_CTRL0_RESET		BIT(4)
+#define MMC5633_CTRL0_SET		BIT(3)
+#define MMC5633_CTRL0_MEAS_T		BIT(1)
+#define MMC5633_CTRL0_MEAS_M		BIT(0)
+
+#define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
+
+#define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0x05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	MMC5633_AXIS_X,
+	MMC5633_AXIS_Y,
+	MMC5633_AXIS_Z,
+	MMC5633_TEMPERATURE,
+};
+
+struct mmc5633_data {
+	struct regmap *regmap;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+};
+
+int mmc5633_samp_freq[][2] = {
+	{ 1, 200000 },
+	{ 2, 0 },
+	{ 3, 500000 },
+	{ 6, 600000 },
+};
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = MMC5633_AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = MMC5633_TEMPERATURE,
+	},
+};
+
+static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
+				       int val, int val2)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i][0] == val &&
+		    mmc5633_samp_freq[i][1] == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id;
+	int ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret)
+		return dev_err_probe(regmap_get_device(data->regmap), ret,
+				     "Error reading product id\n");
+
+	/*
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret)
+		return ret;
+
+	/*
+	 * Minimum time interval between SET or RESET to other operations is
+	 * 1ms according to Operating Timing Diagram in datasheet.
+	 */
+	fsleep(MMC5633_WAIT_SET_RESET_US);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret)
+		return ret;
+
+	/* set default sampling frequency */
+	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				  MMC5633_CTRL1_BW_MASK,
+				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
+{
+	unsigned int reg_status;
+	int ret;
+	int val;
+
+	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
+	if (ret < 0)
+		return ret;
+
+	val = (address == MMC5633_TEMPERATURE) ?
+	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & val,
+				       10 * USEC_PER_MSEC,
+				       100 * 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(regmap_get_device(data->regmap), "data not ready\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
+{
+	if (!data->i3cdev)
+		return false;
+
+	return i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR);
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 data_cmd[2], status[2];
+	int ret, val, ready;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
+		struct i3c_xfer xfers_rd_data_cmd[] = {
+			{
+				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
+				.len = sz,
+				.data.in = buf,
+			},
+		};
+
+		data_cmd[0] = 0;
+		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
+			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
+					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ready = (address == MMC5633_TEMPERATURE) ?
+			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val ||
+					status[0] & ready,
+					10 * USEC_PER_MSEC,
+					100 * 10 * USEC_PER_MSEC, 0,
+					data->i3cdev, xfers_rd_sta_cmd,
+					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
+		if (ret) {
+			dev_err(dev, "data not ready\n");
+			return ret;
+		}
+		if (val) {
+			dev_err(dev, "i3c transfer error\n");
+			return val;
+		}
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd,
+					   ARRAY_SIZE(xfers_rd_data_cmd), I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data, address);
+	if (ret < 0)
+		return ret;
+
+	if (address == MMC5633_TEMPERATURE)
+		/*
+		 * Put tempeature to last byte of buff to align HDR case.
+		 * I3C will early terminate data read if previous data is not
+		 * available.
+		 */
+		return regmap_bulk_read(data->regmap, MMC5633_REG_TOUT, buf + sz - 1, 1);
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT0, buf, sz);
+}
+
+/* X,Y,Z 3 channels, each channel has 3 byte and TEMP */
+#define MMC5633_ALL_SIZE (3 * 3 + 1)
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	if (index == MMC5633_TEMPERATURE) {
+		*val = buf[MMC5633_ALL_SIZE - 1];
+		return 0;
+	}
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = get_unaligned_be16(buf + 2 * index) << 4;
+	*val |= buf[index + 6] >> 4;
+
+	return 0;
+}
+
+static int mmc5633_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	char buf[MMC5633_ALL_SIZE];
+	unsigned int reg, i;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = mmc5633_read_measurement(data, chan->address, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_MAGN) {
+			*val = 0;
+			*val2 = 62500;
+		} else {
+			*val = 0;
+			*val2 = 800000000; /* 0.8C */
+		}
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = -75;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
+		if (i >= ARRAY_SIZE(mmc5633_samp_freq))
+			return -EINVAL;
+
+		*val = mmc5633_samp_freq[i][0];
+		*val2 = mmc5633_samp_freq[i][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = mmc5633_get_samp_freq_index(data, val, val2);
+		if (ret < 0)
+			return ret;
+
+		guard(mutex)(&data->mutex);
+
+		return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+					  MMC5633_CTRL1_BW_MASK,
+					  FIELD_PREP(MMC5633_CTRL1_BW_MASK, ret));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)mmc5633_samp_freq;
+		*length = ARRAY_SIZE(mmc5633_samp_freq) * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5633_info = {
+	.read_raw	= mmc5633_read_raw,
+	.write_raw	= mmc5633_write_raw,
+	.read_avail	= mmc5633_read_avail,
+};
+
+static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_XOUT0:
+	case MMC5633_REG_XOUT1:
+	case MMC5633_REG_YOUT0:
+	case MMC5633_REG_YOUT1:
+	case MMC5633_REG_ZOUT0:
+	case MMC5633_REG_ZOUT1:
+	case MMC5633_REG_XOUT2:
+	case MMC5633_REG_YOUT2:
+	case MMC5633_REG_ZOUT2:
+	case MMC5633_REG_TOUT:
+	case MMC5633_REG_STATUS1:
+	case MMC5633_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct reg_default mmc5633_reg_defaults[] = {
+	{ MMC5633_REG_CTRL0,  0x00 },
+	{ MMC5633_REG_CTRL1,  0x00 },
+};
+
+static const struct regmap_config mmc5633_regmap_config = {
+	.name = "mmc5633_regmap",
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MMC5633_REG_ID,
+	.cache_type = REGCACHE_MAPLE,
+
+	.writeable_reg = mmc5633_is_writeable_reg,
+	.readable_reg = mmc5633_is_readable_reg,
+	.volatile_reg = mmc5633_is_volatile_reg,
+
+	.reg_defaults = mmc5633_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
+};
+
+static int mmc5633_common_probe(struct regmap *regmap, char *name,
+				struct i3c_device *i3cdev)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &mmc5633_info;
+	indio_dev->name = name;
+	indio_dev->channels = mmc5633_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = mmc5633_init(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int mmc5633_suspend(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+
+	regcache_cache_only(regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	int ret;
+
+	regcache_mark_dirty(regmap);
+	ret = regcache_sync_region(regmap, MMC5633_REG_CTRL0, MMC5633_REG_CTRL1);
+	if (ret)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(regmap, false);
+
+	return 0;
+}
+
+static int mmc5633_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
+
+	return mmc5633_common_probe(regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend, mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5603" },
+	{ .compatible = "memsic,mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5603" },
+	{ "mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe = mmc5633_i2c_probe,
+	.id_table =  mmc5633_i2c_id,
+};
+
+static const struct i3c_device_id mmc5633_i3c_ids[] = {
+	I3C_DEVICE(0x0251, 0x0000, NULL),
+	{ }
+};
+MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
+
+static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "mmc5633(%s)", dev_name(dev));
+	if (!name)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(regmap, name, i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


