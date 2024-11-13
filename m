Return-Path: <linux-iio+bounces-12215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77D9C7A56
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB4D284EFD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192F202631;
	Wed, 13 Nov 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YA8jo8Fn"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFE2022E4;
	Wed, 13 Nov 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520500; cv=fail; b=KgoEmuYM5vj9R2P4o2eVsKvjabPAqpSWhY06OjSNa6IkO1xENH5YyGCKJpJT3a0OlnYyva0yzbi586x0DpycX8wy8+IYgjSzWimuj6d+OELZ7c9MWIaGyHI1p90JBq4NDl/1NCi6HhjQE/4rLdy4brpeapCNruu62z7AKjzMoU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520500; c=relaxed/simple;
	bh=FcSX8AL2964+XiRawj4b9wELyZWpvop7uUO54djUL4c=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nLc/jchC+b1l9fusMkQiJjJvlZvOpWZCbx07aLfgRJ1XLF7EmToYtMhSvHeL2/JyTzP+QH3j5mwQVyZwltEswOdMCCb+aqkUro+bM2Xm67TxOJEVJpizbl1RJEahfyhNT4jtEwK5YGOQehdqbspFKA/NugQXPxiCrvcQ4Pvjj+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YA8jo8Fn; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUyUU3yutqjLmbGgx6UAR7/uiHsSdclwfO6AeuiWTDCHQd9maTqVD4jL1AGme7ihprGv21ESBQlnRpQXfl5hVfCxrKo3L2Ltbisxp4TIeiSbNG1tRAovZt6tHBYHxF6+BWxcn+mhGbaWR9R9Rof7f+fKdtXZ1bnG34PZ69cn6gFHIzOXE7JoLYfaiP1LiFHyubb9qEJL+lMn943y+2rOX3OgSP+1tNoiehGp8DArBCDg8vY0YA/ESm4VW6Z/RssDujgC6T2ytiIhzs0Hqm3SLRA4Gvynk1ArKubSHwe96i3gd78ZYLb0zA2BzLXu448p9eOKhk2Z3CA3ZZ9/5RinPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRNrw0ti8bR0J+BiM6g3keHBUAKzAgNnxB6RYJasqFw=;
 b=Ey4xV4Kdj/+nNCWS/m014TXf+GiD+AisR+IxKH4z8K4CLxu1yyMBCNEZxlVY7xcy4VBRREzI5FJthMyNWfyTjMHZ/tJoa5RYL5jTJArpiYW/u9gaW0EOzMi1a/7jbYoI9K+0NnyZEgBwTVSmkqSsRHTeFQtqJJnhp5GwOnJ51J2AZH4HqFAcepOlhTOr4YB0xX9Lov2FT/HzqZpxECBI93xp+4jUjK5U1XmVOKmRI7B6ewXApzzd36mmZJAmzJR5KE4Q2vj2MAjQ6ZWsGzmTldpJsIK3670EmMTORjCOCHF/+bZNdKj9NCRugGzvzVQO1Zs9aPApiqzuxaiWUfBlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRNrw0ti8bR0J+BiM6g3keHBUAKzAgNnxB6RYJasqFw=;
 b=YA8jo8FntNoCTNGxkC7pBhbgssQ0vFngv+GOety+Vr3AodUPcgm8CdGX8a2+BhooOPwtmLX+gcpN1j3I6fsUR3WWakADctx1f1y7aHzT0tkThaoiJaBesLHnWwhgYOQ3BaOlACAZbLlh+pO9+uigeJwnbQGcZLtC8s9ZK44losfzSOteCXb/JsDHAqfM9yJXzNiyH3AzaH+8Ge30OpMk7r2gwm+U9eWO7xqresmAAHSIm2kZir/UAked3/3mU1eAiaxNk95tAiDjQrKY+JmwKQo8+51z9bCKYCOk8CCIykAv6+S6PESzXe8m2F2TyH5o96usUA5grjwKr9sMPtUZjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10577.eurprd04.prod.outlook.com (2603:10a6:102:493::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 17:54:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:54:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] iio: accel: fxls8962af: add fxls8967af and fxls8974cf
Date: Wed, 13 Nov 2024 12:54:38 -0500
Message-Id: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7nNGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Nj3bSKnGLdFEvjRAsQsEwzVwIqLShKTcusABsTHVtbCwBEON3mVgA
 AAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731520491; l=911;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FcSX8AL2964+XiRawj4b9wELyZWpvop7uUO54djUL4c=;
 b=RJgH3IZ1+ILedM5Jwm6kytm+BYmcFRqJXpJev4I3UPJyNDDqQMDfiW7Q5mIDYF78LagtZQigh
 CstfGjtUXz4ALo8odl2YWT0bV2Yh7NJhDfq65omjE/Gu8tlUQgP1J9+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10577:EE_
X-MS-Office365-Filtering-Correlation-Id: 194a2bc5-e5ad-4823-faa8-08dd040c481a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTl6dTBDT1FlT0hNdlIrbVJ6MVp4TEg0S2VtTW5kL3Era2lpYmZWUmZOdzJm?=
 =?utf-8?B?TWdNZ1J1alI0dzJ3dGhncm56MWY1VTNyck5BRHR3bVFhT1lNNWFZTVRlZThX?=
 =?utf-8?B?V1NHaFVtRUp0UktFekIxMWxVeWZWeXB1UkNBOUJHVWp5MkFIRFIzSXpEY1NN?=
 =?utf-8?B?bVJJZVpNWitpM2tmdjMvNW9ybVJkbWRnVDBTOTVaOElidFpXTjhwS2dETEF0?=
 =?utf-8?B?dUU4cHdlWVdCRDhDQVJaQ2NJTjRENXhKRW5GbElIS05XQjAvOVdnKytWRXRS?=
 =?utf-8?B?UEYvMENpeFhUL21RL2RpOEFPUUc1TEx3QXprK3ZlNFAvK2VuL0JlK2UyT01t?=
 =?utf-8?B?RHJ3dHhmcUtxakw0dEJqNEpuZGZ5NWRoM09PY1d0TXdiMHoxdzVMMGJxb3NT?=
 =?utf-8?B?UEIybGZlSE5oekVOV2N1N0FyUTI1NTZ1ckc0aUxEeG1iSnVQcXlPbnAveWRG?=
 =?utf-8?B?azgwbXhrRHZYNzZINGdSdVVEeFlESmpySURkVERBN0pBWGlMRURQL0dnajda?=
 =?utf-8?B?UUJuSDZJQU54cEVmaWJIenBsVTBNekRWTEdUK2FnRUNOUzJJSGZrZWpjR0FB?=
 =?utf-8?B?cmIvSXV0b3JhTHpvT1BUc1FPYmJMZmR4eUgzb25xa21kSGtieHBrR3ZZdllh?=
 =?utf-8?B?UzQ4cXF4aHNnY1JqMnlCUEJRWGYyaEhhS21zdlhSZHQwWUUydkpzNzc3bElH?=
 =?utf-8?B?aHg3ckNmbW4rcmkwT1R6aE1FYWp0VWdCei9IdW1kT0pVekN5RTRwOHBrMFFr?=
 =?utf-8?B?RGFNNEY5SEs4OTdhUkFPZm4zK0haRWl0RWNaS0Y4QUtWVVk4NXpkcmJDOEs4?=
 =?utf-8?B?NCtLSXFSM3AraFBpNzVjWHhGUE9UOW5XOU9MeG9JeTVTMHd6Yis5OGVhNTNH?=
 =?utf-8?B?eGVXZHlzdHZZclFGNm9LaGhvMzlBOTE2ME04clVqRzlNcFB3OEp5TmlxbWZu?=
 =?utf-8?B?d0JWQ1pmUldUbTZ1RUkyeUxSQWtESEhvUDIweU12b2tlRHdhd05weENLZWtr?=
 =?utf-8?B?MzU2bFhnYkZpS0UzOU1MeVdtWHRzank2MnU5RzVUcjR6ZFBsVExoLzBsdTJI?=
 =?utf-8?B?STZPZFo4b0pDYW0wb2VwNzc0ZlFra3JCek5hUVZxVXNIUitSMHJoUjlrdStK?=
 =?utf-8?B?aGNjQ3hsdytjSXAzWjNmcnFWQmxpUStNNTRYc1Bka2dUSGZoalVSN3FzajdK?=
 =?utf-8?B?WlJNNTlNaXZsczd0Q3J6ci8vMGpYL2taS0lSanluaEJYd21kc2cvcUdUTCt3?=
 =?utf-8?B?TlhWQWcrdVdJbWZHUTk3NjhkOWxxSmZ4OGhmSm94UDFJdDEyZ25CTDJnN3NH?=
 =?utf-8?B?TElaRG1lRCt0ejh1UEszM1FUUm56ZnE0M1F1cGhZanBlT0NNbmwrcEphdWFT?=
 =?utf-8?B?VWdYUUMySmdDdGdHd2kveURjSE9BTDRDTCtQalh5MHlkeGlJbmkzbHRVRTJv?=
 =?utf-8?B?bWozOStML0Fkanc1WWxUZ2VjVWJ5eFNIK09wWkc0SFArQ0dVeU11OUZsajZY?=
 =?utf-8?B?M0V6SVlUTDdrUTNoRkZGZGVueThTREtFQmh0V0IxRGo2Q3dGVlZTYXdKRFBB?=
 =?utf-8?B?K1IrMlh4dys2enRyUkV3RktQWUVOUldZT1BOWUxCS2xPQllHSWlhYTdHZHc2?=
 =?utf-8?B?VlRZdkdUWEJoTkZESTFJNXlyU25aWkt0dlhOL0lER2R4MmVCYzZaVHMxZTl3?=
 =?utf-8?B?NVYwUTYzbzJ4U2wzM3ZwdnowRFpLdS95WE85UExHMHUzYkYzK2RYdHpXUmZC?=
 =?utf-8?B?RFZiZDJrOGptMjZlMTM5QWt1UzhtTTFXZnF6UnpmV0xybS9uSXNNSWxjNlN1?=
 =?utf-8?Q?rLbLBuc4CrcdkpiUgG+k+QRCesxMW4xIsjekQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlpPUThzaUE3dkR0VHpKUHRGNDZtbkMxZFFQQnd6K3MvUm5rV0YwbW5yRUta?=
 =?utf-8?B?VlVNenhiSFNpbHpIanovNThKMm9PdllPZ1NPNFZSKzEzR3IzTUlYd2o4WGxw?=
 =?utf-8?B?dmVqWUp0dXYrRWdySm0waVpta1ZLcHYzdFdoSjZkL1g4U0lYcDlrMjlIRlgr?=
 =?utf-8?B?czgxZjJnc3o5OGl3dmNGeDJkQVJrSEtlMXRFNmZ4WlFzb0phTHg2ZE9idnEz?=
 =?utf-8?B?blFtNTE3RnFqMmVJV3FtVUFDT3FZRTluek4xemM4UGdiSmtoQXFtQmViMVVs?=
 =?utf-8?B?YXFXTG9MNnZoT0Z1OTI1TVkvOUU3bXNNWTVWT0RKTWJPRnlUZlBlN2wxQXpx?=
 =?utf-8?B?QmpVNDdZMHdkNUJGdktoZ0xuNHM0WnY0VXczSmpqcVV1cUwraS9ROEdUQUk3?=
 =?utf-8?B?NHhPNGRWZE1YdWxvN2pWb1FxSGl1WENtZThpRHVSaWY0MWNlUVBWSWJoTjAr?=
 =?utf-8?B?b05ySEVsZEtqQWJhUlNyaEx6L21QZ1JrVitueFM3dDZYc1JPTy85Q1FJWjRJ?=
 =?utf-8?B?dExJR3MzUHd6aW5HZC84VEJHRUtpTUdRMHFJUGdzeWJQS3p2UHZ5SkZmUTZU?=
 =?utf-8?B?RjJYTUt6VDdLUTJCTGlXd254QVRBZEVKd3QxOWR2RHh0L0g2MjgxQnVpdTFs?=
 =?utf-8?B?Z1FBY2ZaNWhQS3AxVHRyUjFZSjNsNmNUL0l4K3pPT0xSYisxS0Y1OFZCaGFP?=
 =?utf-8?B?RWQ2QmQyRjRRa25YamlTM1JyYlQ0T3FsQll0M0xUY29SU1ZqSVVWK3pkRGY0?=
 =?utf-8?B?bmdHR0pZcVRPNkxWeWd2dkNkbkZ5enFRSVRNNC9sY1BxRUFOeFdHQXYwVnl3?=
 =?utf-8?B?ekdRNkpFYmVZb1lMRTYrNVduUWFFbm92V0ZmV0dTbmFId1Q1TTEraE9yRlFw?=
 =?utf-8?B?dGtzZldPT2xLSnFXUUwwWFk5QVBXQWUxOHdBT3pOdng4U1FKNzNsTjVGN1ZK?=
 =?utf-8?B?MW5tLzhEOFpad1JiUXFDUUtnSm9pVytwbm5pWm5vdnh3ZjZsNy9RaHdSNWlk?=
 =?utf-8?B?QnRRUWorMks2N1pHZk1ZaS9uUHUyZEEzajdkSHc1MHZWenpEMHVEa0xNOXJB?=
 =?utf-8?B?QUtlbnpxRGZGQ1NTYWRaL2xKVWxzWHVJNnluZFlUM2dHUW5TUnJ6NUdEMktL?=
 =?utf-8?B?aUhPYjNCUTRoSjlPL1J6R1NMWHU4Vmx5Sk5CQTFKOHJJZUZMVTdBenc1M3VT?=
 =?utf-8?B?c0lFWW9BRGdnM1ZGTUtUcUJFVVJrVkQzbjJrREFQQ1c0c2M0Qi9Vbnk3enpT?=
 =?utf-8?B?STlld0k1MlRSNHd0d0Q2ZVJWem9EU3pxdFJYYXF5ZGU2R3FTdjFOWUhFVnd5?=
 =?utf-8?B?V2t3SDhVTGo0N3oybU5naVFTRjI4VG5ZQ2lQN05iRzUxUThKekNaRklnbTYz?=
 =?utf-8?B?Nm9reHlYTkFtUHlwaEJ5ZUpEMVZIYXJ3OVBwRU12N20zUXQrQ1h0SC9jNi8w?=
 =?utf-8?B?ZG5PZ2tYZGJQZldzY05xTFVzRzJueXRiTjRJQjdCbVJyNkNnbDFsV25RUi8w?=
 =?utf-8?B?R1IwTDdsZlFmNjgrWlFwVXUzVzlNZ0dMUWQ3RDBYZXFjZjU2eXBtbTc5OTlZ?=
 =?utf-8?B?UTNwKzlxOG5VTjE0OVFubFFFcEhhWW1ZYmVlTGJiazlZWndsLzJYS096emFa?=
 =?utf-8?B?cy96R2xZa2dFNUtKaUlxclkxT2ZoOEVkTCtGUlcvUm1sT0ovbEZhMUtEVmNU?=
 =?utf-8?B?WUxWYVg4SFNhQlFpclZSaEpDcHhsQm9rWlBIT01XYnRDWlh0THd6ZnNSQlBJ?=
 =?utf-8?B?b1E0dENOQWc1dTdMWmRDRzlWQVRMUzhDVVc3SHI0QzdCTlRWeXRVS3I2bC9j?=
 =?utf-8?B?cElOaldyVC92VjZYTkZTajJvU2trcktxbWlmZzd5NHhEUHhIOFdYUkxYQklo?=
 =?utf-8?B?SDFMUHZSMFEyQ05YNG5IVUlsa2I2cEpxc2pDa1VCY09QKzNBMFpxczA1cUNF?=
 =?utf-8?B?R2h1K0ltVDFydmRQc1dFYklaUnhxVU4yd2Z1OEx6UGdzWjBOUmxvRHU5ZE4z?=
 =?utf-8?B?UVk4Z1lwWTZldjd3REVLQllPQVcveGxmMXVma2ltS2lCMk5ScFdoNTlITFYw?=
 =?utf-8?B?ZHBtT3BUNDJXQkNaY0xmUmlJWERUdmpMSEc5eXJpSmo2emJuY2wva1pqdENI?=
 =?utf-8?Q?ji9ZfCKN/Qh+ATTq9bkb960t6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194a2bc5-e5ad-4823-faa8-08dd040c481a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:54:55.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q1eJv+0wZejt7N9D0K58C01G0mfRwX3NJ2SzUV4qYQTtmjjQujTRCiXgAqYyGqVvS3tmv1b14DzKZHl4gvMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10577

fxls8967af and fxls8974cf are similar with fxls8962af, only change ID.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Haibo Chen (1):
      iio: accel: fxls8962af: add fxls8974cf support

Han Xu (3):
      dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8967af'
      dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8974cf'
      iio: accel: fxls8962af: add fxls8967af support

 .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml      |  6 ++++++
 drivers/iio/accel/fxls8962af-core.c                        | 14 ++++++++++++++
 drivers/iio/accel/fxls8962af-i2c.c                         |  4 ++++
 drivers/iio/accel/fxls8962af.h                             |  2 ++
 4 files changed, 26 insertions(+)
---
base-commit: bd05b9a700c10473c2f52bf12c5c5938c30e80b0
change-id: 20241113-fxls-d93a888889f7

Best regards,
---
Frank Li <Frank.Li@nxp.com>


