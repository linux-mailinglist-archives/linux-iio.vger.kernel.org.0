Return-Path: <linux-iio+bounces-12216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADBA9C7A58
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 18:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A81F2679E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAC203711;
	Wed, 13 Nov 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lsaJJSUe"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079B374C4;
	Wed, 13 Nov 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520509; cv=fail; b=hXOMqOpvFU8k7vwjWeQkIz4P8ZnLbyYrV6s/Wf4z/SpkVeZCLMNx8q3+ae2tMnC+HSh6VSW+Q2uBVY0Knq5AFSnuC5RLdxzOmHeUfpUXcd/hnyz5WcS39JtfW557v3I2+gElWzjkB55Jgi17txmYiE6oh50mATV29JiGemj/odU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520509; c=relaxed/simple;
	bh=Eq/XxbngI58zdhNIUWKaJEx3Mekpn3CT2N0um8hm7UQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hDSR8aCbqipxt6Lbrb7ZSVxEDYURg2s7CLIumSoSp3QdRii2DRQB9f4+oBcG3EvtmcDb4gbS93/FasSab6olZZALqqkwHhK8WD4gArD659rqcH2hGk4qS0SyGVX6ECNmwZhafaW8PN/8MF4UqSDLIbpqcWYZlAexyMpXIwT47ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lsaJJSUe; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWsZ8qAGA7B15czY87pSf/d1VCmgduwWzzkiSeR3chugtH+sqDXkK8TYfJpdjWg9lcD+YgPMR496eGLyYTEOmfeXKnxlPJ9+43Y8gYDb6O+SrZ4uN0pu8/PXksmA9qO2Tr8YAJHnlWPiMol3XTwmHc9ZtJET74eBH5+6igoDkVtuXVnFYk0lZlmUZGVC2PnuDM9juqOtMu9cf+g3ovilYaZuQ1YfGXnqh86oRdT2zuYlhwwXZ1kt+097kPlxaAEbzLRI+r6Jt+QaAcZKqQ4YlW8xIH4WresgCbFeNRY8Y5FdNjdt8Ec/jpxCiVzg5gXA61IfBNt4Hq+NauP9SAmUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N7ozbupOqoFwd361LuZBrV/HUSgvH+mmbFTKWeeN5s=;
 b=HdSGCo7NxaF9YdWRCI0Wa4gQ5jGYWeymJsI80qtLeKbmkwpKi76Ma8oLM+6sx25oITS3+/OOoS1n29GjuWjdi8Tj/z9Bm6Y6Po9tZmtoy75ZlPUsN8nJfdtys+8n2eyxgJKimd1eW9XZ8TPe503MkciYnm+5eU+RTz/2ZEsZLCQn9Lp/vquh0p7efSUCXrIp0U/sIvkaZHECSaHFBtD5LZZPiMuSyZc1r2504aASzjG4yVS/mY6htUe+yYOrzyBOhtNiNvIxPDo0KQkOaNqSbGeVwpjqlfEYu+F22c/e2EArPsCv08N3mCrJlrYMP8E7Sp8JLoU2fIgxfB8e8Tq/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N7ozbupOqoFwd361LuZBrV/HUSgvH+mmbFTKWeeN5s=;
 b=lsaJJSUejfmitKaoR7T8KclVW/uk+Zm6h1x+O1kDQlMr8HGxBgp1JeJ8uDN8BBE8+xRpOcts1zcs7KUVHbF/w1imRF4TpKIYMddaQD46FJrKeLTm7b7nAoZMCkVYvEU+gW1fI/owOJMjUdUtuQRsc1AWy3ub4kaKYLltghLqzKgdEm7PC2mW4KrBU1kGdhKDc/De6tg0gbJkFtctzJqKGQSG51+nr4TmTxLRxdZqzucsbon7UDHgTij+9RkTpuVeoqHMsoOY16eXGfk3uSKWhg4nz/JmEViYPHxDx8oUUQhV5nCYchSrfrahZe2f+jsLHrpi73H17hB7gXmM7rLcdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 17:54:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:54:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 13 Nov 2024 12:54:39 -0500
Subject: [PATCH 1/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8967af'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-fxls-v1-1-5e48ff1b1fb8@nxp.com>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
In-Reply-To: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731520491; l=1121;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7KQe+AGwYCwfjweCCQs5l46okN0EV/DigQpulL3q13E=;
 b=ZVbzVwDZqSKLWgaxySAm3JvwyPAzgFJHOfhohFf1bMH6wUErM4Z8P/uJ/x9ktNIVzAOQUwF8l
 3oRY50DWqqWCD+QnKXOaxlOVf7+EjWnRYvtBhLucmEy6jKIhen1oniu
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 13646368-edcb-491a-63f3-08dd040c4a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFpGRHBVdDlEZnYrQ3B6d2o1bDJmNjhSaUk3TnBMM0tDSlVCcE41SVN4UUlI?=
 =?utf-8?B?azgyR2xiVU1udU5JUEFnMTNra0dtNWNFL1RhSDYrOXg1Mm5IOE9vYUVDdzNV?=
 =?utf-8?B?dlUzanl4dVl4QW9qcG9BZ25YTk1nUFMxd2JFOStkM2M3cWpIakhnTnp5UFBW?=
 =?utf-8?B?REgzaGpWZGU0cmN1SXhKSzgxeUtHbmJQbHI2bUhZZWZzL29Oc29hSVh5VHNV?=
 =?utf-8?B?bUtTQlBxNGxNZzhuWUdjaWtub0cvWkZDYkJ6a2RhdDVvUDF3ZGdrZW9uRDNG?=
 =?utf-8?B?MjFBLzVIUndHN1lqT3NrSkxCamFESzF3aUVJVndqWHhDK3RXL1JPby9FUWha?=
 =?utf-8?B?R1RXNWhVT1BLMmx2eWsvR3BYem1wZUZGVVp3d3YxbGVoWDJ5V053ZGt0Qm9V?=
 =?utf-8?B?bzhKbURSRitTRjRhZWNhZ0Nyc3lKMW9Kd2lOT1lVa1B5YXd4ay9HL1VzT2lW?=
 =?utf-8?B?OGRQdDJwS2hGd0srN25hOHh0OGNVU1l4Wm1ndGd3Ukl0K2t5dFlJQVZnSUZo?=
 =?utf-8?B?QjJhY2svb2w3d3dOK0hQaFhBSFVwTHBGT1YxUHFwT08yemJPSnpScG9XWkdi?=
 =?utf-8?B?cDUvZ0JkQ2UwQ2duM1k3YU44b20yWXVGWHZnZW11ZUR3QlN3NzVvcXg4a1RK?=
 =?utf-8?B?SkMxYkUrNnhOek5vQ1ZjUjVsUGNrSFRreC92czBhTnhiR1lOOFZiSE9JUW9s?=
 =?utf-8?B?QnRZejkrZkhaalZEM29EckdrbWdSSzV0R0dlaGZnRGE1aDRvMHplcWpiMzc0?=
 =?utf-8?B?ZFVOR3Z0S3k4clVWRVJERVh0WUtKdlA2eVJTVWdhdnlvTk9EcTNFTjdMV0hZ?=
 =?utf-8?B?Si8xMXlYN3ZhSENqNWFGUGpQMW1SeWxPMHNYR1BFNDJOV1FSMnYwdE1LWWor?=
 =?utf-8?B?VGdGMnZuYjJpNzY4OWJtSlVLWDZqRlU4SnBmQ3oyMGFDbmhLWXlhM1JZM3Ro?=
 =?utf-8?B?OUVPWHBtQkMxSEEwOW1BeTVPSHdGRGM3WjZnNXJLWTh5c01HUnorMEdIaS9p?=
 =?utf-8?B?eEdRWjFCc2xmbXBMVUgzOStOR0VkSlRnbVlraUhWbEJQME1OZ2NKU3Q4V3VK?=
 =?utf-8?B?OG83emsweFZxamlFNjVJOTZDdll4Ni92ZW1XeEJaZ25FRnl3YnVMRW1HMTZI?=
 =?utf-8?B?TGdJdWN5N1pUR0pMaU9YU1N5Tjg5WkJHbjFSTlZWTTRDekc3QjRLTlhsOEdx?=
 =?utf-8?B?MjVFenV3TkFmb1pPc0MxelF5VXYyUVJmYlVzaHNiU08xWHFOdWpoZHFnOWJm?=
 =?utf-8?B?OGlrYVBSOFdMVjd4VndnQllyZ3B0YnJYNXJUL29nV2J4amptS2pjLzJIQXNP?=
 =?utf-8?B?cnZmY1JRRjYzRExEby9FNEp1WldpcHhQQ0RWUldNbXFJNSs0WWczM2J5Sm5S?=
 =?utf-8?B?Yi9JbTFIMVptL2tJekw2WjBaL1R5aVN2bi9wVzM2T25GL1ZEYmtTUUFSOW5S?=
 =?utf-8?B?SGZvZXhXcGwrYjJXcUhERjhNaldVTS9QQmI1aXJXWjB1VzVVYndrc2pKT1NZ?=
 =?utf-8?B?VE5hUHpWRjR0UnZIRHIxTzRUdzNKbnVLNFRDOFNqMGFBUWZBd3B1dThRSXBS?=
 =?utf-8?B?dHU2ZjF5N213VTJtMEZsbnJkSmpLelppQzlvdm45dmEvcjFxMm14UjBZSG5Q?=
 =?utf-8?B?WXlpK2Z6cTFtVUxtLzZxaUpmWE4rQmhHWTdaS3kxZk9LSG9TTXVINWkxQkx0?=
 =?utf-8?B?Vm9iZ0duQ3FUNjhDZzN2NnJVUGU1UEl4bkZlNDd1em9mdDFRTUdwSlVobmlP?=
 =?utf-8?B?WGFHR1VIUEZoYnlPT2owT0wyUTRCRkQ0RWpFeUNxQ0E2TFlyd3Zkdk9MbUVM?=
 =?utf-8?B?cDVRaHFJS0l2V0t6NUg1TjkyMTl3NE1ZUmVmdXJTLytrQmxtRDBGWjNUcllo?=
 =?utf-8?Q?o9cWtuZMvVDtq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWxhdjF2VnJqQytTc3EwMG05YUJpdzNSNFRRSFBla0xIdzJLVWtPK1I3VkVz?=
 =?utf-8?B?MW03K2x2WE1BZzhINlpyNkFYcXNWZm52aHBHTk9ONHZFUzVaZmJsZHJmWklE?=
 =?utf-8?B?YVNTWFRHS3REYW5XTGg2SmJ1MWl6dkpSY3BBcUo4SDkvVFhaZ21Pckd4UThO?=
 =?utf-8?B?d2NKcW1SUys0ZmhJYVU0L2JtZk9IYUd5WmNrOW9MRW1UcW1MWmJ0TDRIUk83?=
 =?utf-8?B?OUlvbUhTZm1HY2lkdWsrS1hpTTBHN0JJVVdWUDV6UXVaZDNpTDc1dnd6Zi9Y?=
 =?utf-8?B?RS9PdXFBTzYzYUtRMFBsbFlNOGtLYThDTzFML1JEOWNEeXRpcmV4N0VUTlZw?=
 =?utf-8?B?MDNSWS9IdHYreU8rbTJHQ0FqdjJ1RzI4c0ZSRmVmeEpjODUxQkZOMm9Yd2Vu?=
 =?utf-8?B?OEV6L0lOWkFLZWRQVHpOZGJrU0VsUDRDbjdqUTRkTlg2T3UvbmxGZ2hoQkd0?=
 =?utf-8?B?S0FGMHR4OXVZZGpKd3dXbEtzZGdFeE1WOG5IZU50ZU1QOUwwWlpLcjc1THZq?=
 =?utf-8?B?QzZHVlBXWjZQL2drc3gzRE1xcjlZbE9xUlVHSS93N1BzYWhDYUFjaG5iWG5r?=
 =?utf-8?B?OU8vQURlMWtpQ01xQjUwZWY3ZHNDZWVPdTllLzk4azNHczNsbEFnTFNuemIr?=
 =?utf-8?B?U01aK1haNTlFWmJwbDNKYjZIaURJb05kVEpOL2puSXFCQmNRRzRoWDBkdSt5?=
 =?utf-8?B?bFdGTmlWaWo1akF6WklscmRoNFJQemJPUzVaM1pSaFExenZ1S2VmVEZYOFJh?=
 =?utf-8?B?anp0UlN2b0NicTFMemwvekJuQlVneHFhdGpMTERHNTFqMjdSZ0hwUG52NmRK?=
 =?utf-8?B?Tk5TcnB6dnpSSXRzN21HS0ZPOWNwS1lZYWZibVZCdi85Q21NU3ZMUEtUTWpq?=
 =?utf-8?B?OU5zU2JZVENyS1NZOWZ2bEVuS0VHRlBFazZ1OERjZ0k1eE05YkN0dDdrVCtZ?=
 =?utf-8?B?R3ZjTEo0S2RVcDdwd0JmTkpGWVo3TWE3VVdDSHFvdTVSVGFSdm5Ha3IzaEdv?=
 =?utf-8?B?Yytob2xzVm5IVDZPd24xcmVoMHRWMEEzQjFlSitXMi9LcklXVHNTTXZIUkF0?=
 =?utf-8?B?dXNqcEFuZ21iVnV5bW9qeFNQaXhVdHFhWWJ2Y0NSYTA0YVlxTXhkWTlpQ3dx?=
 =?utf-8?B?QXQyUUR5eXM4R3JCNm92NFB0Sk56dEVPVDFNblNHYVIyek9rdlk2aVlLMXZj?=
 =?utf-8?B?VHcydWtvTnFtVTk1TUlUb1d1L3dwbGQ0MUMrd0NpSE4vb092OFAvazZmVmUw?=
 =?utf-8?B?TmdLMmRpOUJnbkZOV3d6K3dDUE45SXZubllLUlRqRndRcXRYQVVtZ2g2L3ZW?=
 =?utf-8?B?L0tqSU9SYmJrTWVCR2R5V01LUzM4c2IvUzRXT2pqZlU3QjZiMzJzQVJHVzBt?=
 =?utf-8?B?c014Q3F4U0RBUEtSUTY3cGJ3eEg2d09yN0NHNC9mTGlxY3RYd3F5WWd1RVdE?=
 =?utf-8?B?QXpIVGc2ZzkxeWVFak1Qbzhmdk5ZWTlYQmNDTjZxaC9aNllLSjAyNnI5QThG?=
 =?utf-8?B?Zm1oNGxRQ1M1cXRmWkJHZ0JNV2NtTUw2b2FxSWwvbHJMblVhY1RNbmRJWU4r?=
 =?utf-8?B?dkEwdTRjV0xwZjZXNENFSmxXYm4yeWtsMnVneXR1VDVNZzgyYlE3M2l4RzN3?=
 =?utf-8?B?ZDJEb3o3Zk1lYjhyNWVUNmFzbFByZHY5TlR0SmtieDF3Qnh6WnNYSjRiTWtP?=
 =?utf-8?B?a25sZWVYc3VlVERRZE8xR2lGR0owbFQ4S3FtRUo5M0h3eUVtR2sxckdaSU9O?=
 =?utf-8?B?QjVpNjloY0lMcWQ2SVozV0Y4ZmxITUhvcFlmYXNxeG9hdW00MjNHS0hYa3ZY?=
 =?utf-8?B?b1d6MkFjeVdrVlVNcHlTWUpRYWhVVFozUHFxb09HQkxNaENIR2c2bWljRnEx?=
 =?utf-8?B?andKZmNlR2NLV1ZvQ01VYVJVVnlTUFdFMUxYdFFsd0hRSk1aMlhXWDd6NU0v?=
 =?utf-8?B?QkZpUjlmNC8yTE5mL21xOVFmU01UL3pJYVNtUk1OQ0RaUlZ2VjFzUXAxTGRK?=
 =?utf-8?B?NUYrYTNpT080d291dDRCWFEyVFBocTlXREpQbWJJOEI4WEVBWE9GOEgwaXMz?=
 =?utf-8?B?SEprN3RubDFXaUtIV1Npd3BOam1EcmVldkI0N2RTVGpqb3BhaThqOVJZSTBu?=
 =?utf-8?Q?DLOxrjOZ39e0QTVXU2WF7AXYq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13646368-edcb-491a-63f3-08dd040c4a0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:54:58.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmNBOuhBIS6GxOb+NjalNKu6+QDGb9jFk6fuhLPv2zUjExLvTGuulPRf7SF6UQZWHHBDh9aSHr0Kneb5bbY0lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656

From: Han Xu <han.xu@nxp.com>

Add compatible string 'nxp,fxls8967af' for the NXP FXLS8967AF accelerometer
sensor.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 783c7ddfcd90a..c375ef1bd083f 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -14,12 +14,16 @@ description: |
   SPI and I2C interface.
     https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
 
 properties:
   compatible:
+    description:
+      These chips are compatible with each other, just have different IDs.
     enum:
       - nxp,fxls8962af
       - nxp,fxls8964af
+      - nxp,fxls8967af
 
   reg:
     maxItems: 1

-- 
2.34.1


