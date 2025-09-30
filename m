Return-Path: <linux-iio+bounces-24607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A514BBAE767
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7AB3B5F3F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692E28934D;
	Tue, 30 Sep 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KWOlNABi"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06E29ACD1;
	Tue, 30 Sep 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260911; cv=fail; b=hd51T+YVLSXZaC0z4lMfHakoosoGSdW4t3o7UwgrOX9VxdtBPT10fcGQcBkIT/IKIWch6VzAP2ztOZpl8PntTxcxIpbi5jR0/cMqA8aOW1qrCMjnDUXjNUvR9KIUchnt7/sZPKJY3SxTW6dBFHRtAtgfV6zJGWVqPmDyAIN142g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260911; c=relaxed/simple;
	bh=Z1yPclN8G3i4bVnNcm3/plSbgbwcdNiwoY/Ff/0uItQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AIzwm7k8hMRQqGNGvfMfsmf1sHPNLokEGT4cIdVyAfIMe26TomZ47LL//BgRWdCqU4tvLyX5t0krW/7+JNhQrXSENueDYX09qSoPlDqyC/zx5ViBlI/W4G6u15U6Y0+09CmwdFm7bpa3jGi+Zt405M52N2hGANCaNDXY29PIiJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KWOlNABi; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npmVgNooacXV3Wsm83O9ApqJmvP+HSXTLFCYcyMcQGIxgimI/GugZy/N9JhN40lK7/ZOKZtYT9zk/TCHf8YIVPqQzcc6tcb64V6new/ad2HmgnlFqBHiZB/nG9qKr1ZQTz+fqx0V1Rcacb7GGvX7NpNvoRK7XUGIQ0UlfW4OK9M/lk51gktfP/dD7kwt8V5LFzajI9AB3UtqkVaF6v5tPIJSI1NL0lVCjrFxg6OUFHBMmGruAaycs9uU3lsjwSOWipBsf/AtKE01+Ba3CZxg3TKIBOo2OqSPjSWOtBYzbU7Zs0aaRPLl7tdKe5Hrk4saSHy/qP9vVNxmk0EEs1lw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpA9MtyptaQHebzrERfthTTLFp5kiKRMtCIVCtOYGqU=;
 b=jrPCUv2kvCm9dUNTrxVmfr5hJfiBspySaCR0ypuR9JgNvPktr5RwnukkrwBx1YUEXjBIbMTqUMxeEJuYlw5t7x2D+0ocuULywVyHladOlNgirT4u1G9xzqMokt7vDHa+KkZhIhhowvmBjKkXID3FEynTaMv7S+yVKhxBtHEJ984w/aZhteTXNbmgLo+MhgtnfkGiSiCW4DT+2CEzxtgD9cpG0Tgx4C13VcO0KqqSQMQBjzp3rtsOFETFJPmZQtOGBeJPmKtdL/lWKG1gimlt1Tp2nbISnhflUp1vTwSpoFQdDEMwsarp7zGoE2g9/78wccASTsvu0RTtShjt/k5DjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpA9MtyptaQHebzrERfthTTLFp5kiKRMtCIVCtOYGqU=;
 b=KWOlNABi05NvpkzY/extYnqzyHpNeVsxGZF5njpjges5TEQhVF76o/oWWAQdqkqegY6XodlXHZhjBn3INj8V7DvyfUW4tXIuVjgUVZ88sHKmMAO/nI7BBmR3ufcVpsijYbHAaktz9jD5p3ksdhuhPVIoMhQdeX2OJe38MFi4G/zryZ0N0vYX3Xbo6a5kdbqa460gMqkziJPhjfZSDkWLG6eFH+aMS3HDKdapbVvwCR7jlg5odj4OCSCjN5sqtQEfTNFbKrBRwQyxmrUD9cmTElR3dO6yEKWCMKpb+3NSUpGnK+tQ2SJbZwzLo9Jnt6+j1j/ZPg+aIiF3TtB1bjDKYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10926.eurprd04.prod.outlook.com (2603:10a6:800:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:35:04 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:35:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Sep 2025 15:34:24 -0400
Subject: [PATCH v3 5/5] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-i3c_ddr-v3-5-b627dc2ef172@nxp.com>
References: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
In-Reply-To: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759260882; l=16252;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Z1yPclN8G3i4bVnNcm3/plSbgbwcdNiwoY/Ff/0uItQ=;
 b=Sj0Uy/FSfRxWckXoiLQjBie5lNMtKe25E03gyx+FGyV9DvQ169n47RmDICvh1fSm61scFtIel
 4fDwtWZMobEC6MRMiKRLbbATYcAwiTfHIa+92hnNfp17Bgi8WF1k/9l
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
X-MS-Office365-Filtering-Correlation-Id: 32c1f40a-4640-4110-4939-08de0058737c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHNkT0ZkeFphRVZpM3Y2TEIxd2tSTllNdzNyaytMcENjS1dzMDlCeWtRM2Ir?=
 =?utf-8?B?RWphUVRYS1FQaEdUZEMzZWo4aHg3VVVVbGxJUitkS3dyRmVCa05WUkFzYkg2?=
 =?utf-8?B?SkRHNGwzbE82bUtvVGdITkt3R3ZJaHpQdzg3WElFSTR2Nmwxc1JyVjFZOFFq?=
 =?utf-8?B?c09xOUV2SStNYkZmdkt4M0pTTWY1RWdTZzd4bG9WNWpYMFpXWDFQSCtxQXFK?=
 =?utf-8?B?RUlSWkpRenJnVVJsY3cvT29zK1dEZGVVK09JL3NIWVBqT1VNY3ZidVlDUXYw?=
 =?utf-8?B?NEd3Y1JjVzV2Y09FSXFjTXRzZUp0SEFEM3FIWUhlcy8vMVFtV2Q3MkNPbzZ4?=
 =?utf-8?B?UFVOTy8xZENjQnpyZ1JVdGR3bkcyQUFtRHN1c0VmSDNyUGVpeUY5N0VFaHda?=
 =?utf-8?B?M28yVVdpVlIxYnBWd0xGTXJwWUwxOFZNQ3FPWGpXR1lQZGRjTUIwcW4vMXNE?=
 =?utf-8?B?Q2cxUVpBZjZ0MXpHOFR0TzhVUm9yOFdsMDNrK0F4T0NsUytaRnFaM1JKc3lN?=
 =?utf-8?B?SmRZZks5aUU4STRVc1RhYkpoeUNHL2pKTWRqcGJiRFNBKy9xMnJlc2crSVZp?=
 =?utf-8?B?b05EV2pWKzdOR3U1RnJRc05HVENyUm44dUo2VUtsK3RjclJROHNPMUVDSWla?=
 =?utf-8?B?RThTbVYrU0doVVUrUFVyMC90S2ZvTVJuZjc4LzZyZEVQdjh3N0sxblgzdUNL?=
 =?utf-8?B?RmwwTGt0eitZcUIvRVl6cXZIQk5hUDJQZ2tCM2VKMnBkU0RpZ25lbmlGR3Nw?=
 =?utf-8?B?SkdXZ2g5ZjBVbXJaMUh1NGxEOUpaS0hxV1kzQkJJOUtSekZ0YUJHVGRaNFEy?=
 =?utf-8?B?alo1cEFvVHZhZDJtZEk3ZGJQbHRQZlIvdjJrcTJEOURKR1hmNDBrdkJlV05N?=
 =?utf-8?B?Vmp5SGZmWGlvN3NBV2R4YlVablBVdmE2dnRSbzhBZGN1NjZMTjVCaUxDR3Fp?=
 =?utf-8?B?ZmJ1bmlxSGFkUmZ3dWJXZkRHS0VEUUFybERMd1JNbStFSXhpenczcDlLNEZD?=
 =?utf-8?B?dDc0UXo0S1Fqejl1YzZyelBCTHNkckVkRmcxTjNPdTI4Ly9ETEhUNzg3OTRL?=
 =?utf-8?B?blc5OHFhbitIWVRQZDVHM211S2Q2c2JxcWgzcU1Dd1hoQWxIaEFoT3Y1NFFW?=
 =?utf-8?B?RUMyQllCWkVGeVRicjFveElrems5UVgvbk1TdUptZ3FTRldlREZZSExkUjZz?=
 =?utf-8?B?eGdPQWlnalRCTWEzRWgzeFlnMkd4ZS9zU21vMjJ6T05YNUx4aUI5VzlPUE9n?=
 =?utf-8?B?N2ExcHAzZlhabzA2NGZwdGtoUTMyVUd1aHVCdkVxSjVsU2R6U2Q2cU5oKytq?=
 =?utf-8?B?Rm0vT0VUTFZtMmY0MnZCZnRpMm44amJzV2xDdnovQ2dTM3QxT3VxNk1ueVZL?=
 =?utf-8?B?QiszcGYrSU9CRmRUMlh2eGVLeTFIT1F0enZCWGFOb0tWQUQxTHJQSEpDN2lI?=
 =?utf-8?B?MERPM3I5Tmd2dUJLc0RKQnl5N1lkWHpnZ1E5WWNvN2VKbXZ2cDQ2YjV0OEFP?=
 =?utf-8?B?ZlZUcjF2K0FrTU5pQVkwTG95Ukh0TjlXUmE0KzVaR05pK05FZ0FiSWRIVHlq?=
 =?utf-8?B?dzFmQmJsU0FRcDBIZ3Vaa1JaMmxlMEJUZXVjenZleDRlZGFzZjEvTEFQU0JJ?=
 =?utf-8?B?bHlPV0NXbHdJOGJTRHplZVV4b05pbTBvWjNjSW5Tejl4eVRPdWZJa2hrRm9H?=
 =?utf-8?B?TEF6TXlUclZ4K2x6UzJrQi9ydmRWeC9MUExNZmVQWll6REFKWEhhV3AvSTk0?=
 =?utf-8?B?NS91bU1VYitsQUYySHNSTEV1VHlwekt5dmlDY0hRL0ppT2J0ZUtQNDNoV2dQ?=
 =?utf-8?B?eDBDNUhCQXBYK05Tc3VNdmRqeEQzVGNQNnNQUTBlQ0dZY1ArcEhGaGRkczRI?=
 =?utf-8?B?NHRUbzM3TDRjSmhCamlJcnp5TXF1bEdKT3RiN0NwNXUrM1BuUFM0UTBVczBS?=
 =?utf-8?B?dkZmaXVvekMwZWlBRVlhSkRYRW11MkZjWjFsSS91VnhiU3NETWJMM2dVRGNB?=
 =?utf-8?B?ZVF2TWpOc2VtT3JsaXV3VUVid3lKUG03cEhrUjlZVWYzdmlXelNvQ1ErNmsv?=
 =?utf-8?Q?hz8A8h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zy9SNGpjYU1zQjl5OTlaalg0UmFNTmU2djRvM0pIYmUvM3dGenRrd0JoaFRw?=
 =?utf-8?B?ZXYzb2pCOEJ4dGw1K3ZLSkx4bWlKbU9Gb3BtN09QVkZLTHBDME5SN3RVeFRv?=
 =?utf-8?B?Smpaek9FaG80VS95MDNRTlAvaG4vVVByZ2dlUzRCNmgwRnY4anQrSldpWUgy?=
 =?utf-8?B?KzZGWHhQaDRST0VCVStDdnRVa29kYUt1OFoycC9aRDF5RFlOZ2dpN2ZlNmdU?=
 =?utf-8?B?dTlRdHVNU1FoQnh5LzlianpBeTN6eWtlOXZmZm1hRG9FUEhxTCt6ZDRNU1JT?=
 =?utf-8?B?Z0FCV0lVSGgyOVNDbXkyRzRxVDd5bnZRQkMvbnFGbFJ1d2dWb25WQ0Z6M1hQ?=
 =?utf-8?B?WjFsSzdIckFuTzRFbTZvamdIc0wrRUFPa3lZaFNmOFRaZXZsRytoWlRVbzVa?=
 =?utf-8?B?Y3QyT3NlTXZYL3NKajJvMmFUV3luL0JLWmdYRVFlU0o5R0FKcjlOYzVmbklN?=
 =?utf-8?B?RTcyZWFLMWFXZDBobWpyVkk2Wk5qV2UvVzVaelZLUEhncExla0lMMFZDQVNt?=
 =?utf-8?B?VEYwZVhUeS93dytHNTlsR1dXeG1LYjV1VGMwQTM4YlZ3VDBCVTRLZlRaaXhS?=
 =?utf-8?B?V2tHUU4rOHdkdGs5ME43elE3NjdBd3hDVHZLSzY2WHVvaFo2RVBVdnhZU0VT?=
 =?utf-8?B?SnN6YjVjbE1uVWloVDl0L3owWEsya2t0K1FhWDZrbGY1SlBSNnlCd09pd2xJ?=
 =?utf-8?B?bThxRldNZ1YwQUd2QWtNK1ZlRXhldEdwY2drc3g0dDRycUd1b1hpS2xqV1pa?=
 =?utf-8?B?TDJ4RTdGdktOaE9TbmNIQ2hPcUQ4WVhBaGFOTXY2b3IrbGYrRmdMbUYxT090?=
 =?utf-8?B?cEt1a0RnOWtVSjlIUVR1Y1Fta2VBVUhpOWIzTzBYQkZUNTNEbUoxS3l4bW9I?=
 =?utf-8?B?czRXdFFtcG0vdlVUNlU4WkhwYS8yazhzeEY1YmpyNXE4ZGJUS2tKbHpVcjBr?=
 =?utf-8?B?Nm1JNFp4ZTBHM3hPazhpMDVKRGJ0OTBnRmRlRE40QmN3eVBpU0xzbVRpaXdz?=
 =?utf-8?B?cUREcGg5ZnNNaGo1cnVDNGdLS3ppUmt1WEtkRGY3bjV4SHVPNnY1Y3NHU0ZK?=
 =?utf-8?B?OW9VNU5qN3NDMzl0MmF2T2hvdGE4dk83VC9GcmFxb3NlbTUxQWNFOFFFeHdj?=
 =?utf-8?B?MnhSd1JjL2h4eXN3Y012TVNCOEZaTUZ5YmtERzNNeEdMOUQzL1F6ODlqYlFX?=
 =?utf-8?B?cWFCM3BTTzZBYTRwYytHMDAyTm9NRlVjblJtMFkwRUcrbHhmWHd2M0VzZ0Q1?=
 =?utf-8?B?SEZiS2VzUEpvRTlhbGN2QW5UaElMZnBXQUFTY3J4QnRoMVhZaGZYUEJkcmQw?=
 =?utf-8?B?MGNmdG8vR2hrS3QyVHlxbmpCcjNrZTdkbHBsYkRvbnVaMDIwRFkxc2IrcnpP?=
 =?utf-8?B?RHliU0h4cnQ5RllxTXFtY2NLb0VDZ1hwSnBYZzZORTU2L1Q3eGR2YU9ZOU12?=
 =?utf-8?B?b0FvWFpiQmJGa2J5R3RkYVZjL1A2N3JmTWhiNVVlOFdSR0xzbmNLeXFmMGx4?=
 =?utf-8?B?QzNDcUQrQkdpcjI1bnJxZC9BTkszeVVkQnJvYlQ4dTA5ZktIdGdsRS9GMXpS?=
 =?utf-8?B?c3ZMVWhYczM2QTVEM01mbk90NDZBekJxQXllUlowR05NQUNxTFEwLzFiT0U5?=
 =?utf-8?B?cHNwYlJvUHdFRlIvR2lVS0ZjNVBDK05KS09MMmwvV2taQkZ0SldoM3YvMWln?=
 =?utf-8?B?cDV1WlRMS0lSdHZSaEdkbGlNVHpWOGE1OFVCU0hhdGVNbUF6dTNsUlc3RzVH?=
 =?utf-8?B?WmQ4bWtrS1lxcC9ucTFKVUdqTVNvZ2VlOXpwaGZXb0dRemtJc2xzZkFwbjlT?=
 =?utf-8?B?aDBTRlcwOTc1aTFkQktjT1lneTl2RWhraGJMZ1pBUzRscXpMOWhXS3FvanNH?=
 =?utf-8?B?THc2Q0ljQmpmL1NIcnF1NVRpV1JLSHlMYVpRcEluYkh6OVZtaktCVlNFd2pa?=
 =?utf-8?B?cGdVTVFWblU2S01pWkg3QkVIQWtQSDlGNU1SaVp2K21ENjBKWHN3ekd0QnFC?=
 =?utf-8?B?Znc1eE9BSUR6a3BCTnI0elZUVnJpaG94aklXSXNoV2dOR0JneU41NlJQREdN?=
 =?utf-8?B?Vk1SSkc0bmI0LzFsVWhlYkMrRFFJNzFtOGppZWdmY2h5blFVOTY5Zlo1SWFP?=
 =?utf-8?Q?AoK8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c1f40a-4640-4110-4939-08de0058737c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:35:04.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbEoO/trsDM0B3HwCOqsEqSEefpBi1RjCCyF01dRCXuadn0zoXMC6GV6F42QmowLQ2IVHQ9+NhYLv8mcM6XEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10926

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/iio/magnetometer/mmc5633.c | 534 +++++++++++++++++++++++++++++++++++++
 3 files changed, 547 insertions(+)

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
index 0000000000000000000000000000000000000000..bcd79ab6053d50026961f7cf9da296c30c720399
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,534 @@
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
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/unaligned.h>
+
+#define MMC5633_REG_XOUT_L	0x00
+#define MMC5633_REG_XOUT_H	0x01
+#define MMC5633_REG_YOUT_L	0x02
+#define MMC5633_REG_YOUT_H	0x03
+#define MMC5633_REG_ZOUT_L	0x04
+#define MMC5633_REG_ZOUT_H	0x05
+#define MMC5633_REG_XOUT_2	0x06
+#define MMC5633_REG_YOUT_2	0x07
+#define MMC5633_REG_ZOUT_2	0x08
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
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
+#define MMC5633_CTRL1_BW0_BIT		BIT(0)
+#define MMC5633_CTRL1_BW1_BIT		BIT(1)
+
+#define MMC5633_CTRL1_BW_MASK		(MMC5633_CTRL1_BW0_BIT | \
+					 MMC5633_CTRL1_BW1_BIT)
+
+#define MMC5633_WAIT_CHARGE_PUMP	50000	/* us */
+#define MMC5633_WAIT_SET_RESET		1000	/* us */
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0X05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+struct mmc5633_data {
+	struct device *dev;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+	struct regmap *regmap;
+};
+
+static const struct {
+	int val;
+	int val2;
+} mmc5633_samp_freq[] = {
+	{1, 200000},
+	{2, 0},
+	{3, 500000},
+	{6, 600000},
+};
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+};
+
+static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
+				       int val, int val2)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i].val == val &&
+		    mmc5633_samp_freq[i].val2 == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id, ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret,
+				     "Error reading product id\n");
+
+	/*
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(MMC5633_WAIT_SET_RESET, MMC5633_WAIT_SET_RESET + 1);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* set default sampling frequency */
+	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				  MMC5633_CTRL1_BW_MASK,
+				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data)
+{
+	unsigned int reg_status;
+	int ret;
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_MEAS_M);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & MMC5633_STATUS1_MEAS_M_DONE_BIT,
+				       10000, 10000 * 100);
+	if (ret) {
+		dev_err(data->dev, "data not ready\n");
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
+	return !!(i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR));
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, void *buf, size_t sz)
+{
+	u8 data_cmd[2], status[2];
+	int ret, val;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
+
+		struct i3c_xfer xfers_rd_data_cmd[] = {
+			{
+				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
+				.len = sz,
+				.data.in = buf,
+			},
+		};
+
+		data_cmd[0] = 0;
+		data_cmd[1] = MMC5633_HDR_CTRL0_MEAS_M;
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val ||
+					status[0] & MMC5633_STATUS1_MEAS_M_DONE_BIT,
+					10000, 10000 * 100, 0,
+					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
+
+		if (ret || val) {
+			dev_err(data->dev, "data not ready\n");
+			return ret ? ret : -EIO;
+		}
+
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
+}
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = get_unaligned_be16(buf + 2 * index) << 4;
+	*val |= buf[index + 6] >> 4;
+
+	return 0;
+}
+
+#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
+
+static int mmc5633_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	char buf[MMC5633_ALL_SIZE];
+	unsigned int reg;
+	int ret, i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = mmc5633_read_measurement(data, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 62500;
+		return IIO_VAL_INT_PLUS_NANO;
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
+		*val = mmc5633_samp_freq[i].val;
+		*val2 = mmc5633_samp_freq[i].val2;
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
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = mmc5633_get_samp_freq_index(data, val, val2);
+		if (i < 0)
+			return -EINVAL;
+
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+						 MMC5633_CTRL1_BW_MASK,
+						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
+			if (ret)
+				return ret;
+		};
+		return ret;
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
+	case MMC5633_REG_XOUT_L:
+	case MMC5633_REG_XOUT_H:
+	case MMC5633_REG_YOUT_L:
+	case MMC5633_REG_YOUT_H:
+	case MMC5633_REG_ZOUT_L:
+	case MMC5633_REG_ZOUT_H:
+	case MMC5633_REG_XOUT_2:
+	case MMC5633_REG_YOUT_2:
+	case MMC5633_REG_ZOUT_2:
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
+	.cache_type = REGCACHE_FLAT,
+
+	.writeable_reg = mmc5633_is_writeable_reg,
+	.readable_reg = mmc5633_is_readable_reg,
+	.volatile_reg = mmc5633_is_volatile_reg,
+
+	.reg_defaults = mmc5633_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
+};
+
+static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
+				char *name, struct i3c_device *i3cdev)
+{
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
+	data->dev = dev;
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
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+
+	regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	regcache_mark_dirty(data->regmap);
+	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
+				   MMC5633_REG_CTRL1);
+	if (ret < 0)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(data->regmap, false);
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
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return mmc5633_common_probe(dev, regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend,
+				mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5633", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5633" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe	  = mmc5633_i2c_probe,
+	.id_table       = mmc5633_i2c_id,
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
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


