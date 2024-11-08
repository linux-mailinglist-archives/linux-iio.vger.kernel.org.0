Return-Path: <linux-iio+bounces-12052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5279C2780
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 23:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C602838FD
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D71F5833;
	Fri,  8 Nov 2024 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fKy5qCi0"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE41F26C9;
	Fri,  8 Nov 2024 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104838; cv=fail; b=QMNmqU37CAAHnPsOxL8PR/bdgyj4r7s9W2d/IWzWnCDXpCq94QxX9Ualhih0+c3t7qz1PIJPAjOMuIooenu2cRp9amLljfcvmig2I2/G3T4f7GYnKVu7Z0GxmciFBJbg4aVUMp1QmEkRs11vdEh9kypE8EZNprDatzDi1MEyRfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104838; c=relaxed/simple;
	bh=yKTmdgZeGX9ZNm2ZnoQZDnLmrbSo6KeIAsCYqGlF2H4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DPdwUtQ26PSzWnfKPcfT1iIf2+lHXK7shMM/N9FcNy++5c5xdHHf+xFjONf28HrUUKu8rVQKGYHg2SBnRaEzzKBo1pe2F8QeRNRn+X5BijnSnieEf7qF25nD0/8TRqyhxnlN7I+355QjMECY6HA3pK4S6uNCSOff8jcy3K2wNko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fKy5qCi0; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghukNqO6wErpEx4rVIqb2MhOk+eQKh9NSV757N+0oNiSQVgyWxtcBkrucaZKgByFebrAJN0gI0DeJaDA7OvUA3UkpNA4/pd5WRn9czAiXI42q7eH++S3db7hMdrQulCOzazBOWOQDGYAW6o9sY/V3vJkYiTTkqAlqmKwbpib7orpaahiXMFtDwIuZgv69JIgswVSUxBDsAuwra96P9HAfiyuPis7HHB/2fVbqubiV1ojLjIQm91+Sd1N1+Uyp/v2wsY3Q8m/TF4OY3hJ4gENH8HN4ew6vsocXQsnpBbdBJOJm606EE2fAFHCCl4Jr1oUw45kvoq40IEFcFPf1fNqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYICUX76/jyUsnQ76DelVK2BasLoIdiGAFMxDTnqTVA=;
 b=i+Pvp+XgkmekOYz/9DnSQ7hEUe3gLQOTjDK/XCNWpBFq5kZsIRnKW2kxrhAQNfR/rd5dbxDm4WG11eIvwswKQp0WvuzymuDf283NmbvHWaZ9D8KrDxJip99gGjIDMlUUPJBEjz/xAWHAzLVu9w4dp9tPm+Q+kFuE33OQlCGrd0NP8h/xQtR/vuOoH/jsym0NxxcrPBOIWKrkJ8lmwmDC3dKBzP7lBh2qy6H2Mt6MQIUxfgltCoaUqAb+JM2RJEVYcNn7T0oB1XEhtsn7xI/nZBpSvBLicf5TwT/chIzhrF4e84ax/sqQaC2hKjzZDgopLF49Mb+LgAz/hz/3KDArIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYICUX76/jyUsnQ76DelVK2BasLoIdiGAFMxDTnqTVA=;
 b=fKy5qCi0ya2jeUbWeJ6Cg2FW0fEklZPvMsc3/aOluUvXJI5IiOt5riFEK+K+MQUgZXK0bivYaVpgjybdHxnzCJF1GlaRCx6Y7aV/hwGe5gNHObleBRxjRJ7JmoDIFaQGEzy0QGcjGg7XhJEYE6Fk4DwzHLDn5BDNooc18tpvprzKh9/QNhsivqNprTEF3ZtETrcu0fN44Cb+6RSoTj7ZOXAa7IqKMtxMHv7A9KyEOqObR/yDEJ7ec+Vsj5T1bqf8qG8SvKicyLWgtGepg8ZGqiDy6lFX/1uVfTM9sknPWPhrsIk/MBzZQBArMkgcstZ24t4yaOU2FfnoOb8uiT6ptg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 22:27:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 22:27:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 17:26:55 -0500
Subject: [PATCH v2 1/4] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-p3t1085-v2-1-6a8990a59efd@nxp.com>
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
In-Reply-To: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731104824; l=1414;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yKTmdgZeGX9ZNm2ZnoQZDnLmrbSo6KeIAsCYqGlF2H4=;
 b=zuI80QDliI8LcoXM1rAarjNK3g9vDcs9gOte2R4DT9IWoHCudPCNy/+4NbUnbtz3qUXK52LR9
 937rR40vCwBDNZDeOKn69vjGD7+4HOmXi+4jVj7wJVApkgu8uNLo/Wz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bea73f-2176-4f4b-56fe-08dd00447e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDZvOW9ITVc4RmNVZmtaOGpBbGM4Y0F2TmlrKzdWNFBWVG02NEc1RnJ2ZTNi?=
 =?utf-8?B?YlgxblkzMkF5T0FLK3NIenpZSzNxK3FDbEY2UmpiQmRTMlJFaWNVU3ZJWkJC?=
 =?utf-8?B?MC9ZdUc1eHB2OUw5SHF1Ulhob0ZjVExLaEN2cGNIMnVGdUNSMTlLbUNIUUgr?=
 =?utf-8?B?WW5WNzBNMjA5aGdGT3NqUlRyOFYwOHNBZlo2VDR3ci9jRTBnUmlzZzBHK3ND?=
 =?utf-8?B?b1UzbzdCamZxWkxoSXp6RHlkaWFVUXpKbHRkeXo0Yjhjc0VxcXI5UEJ0VnpT?=
 =?utf-8?B?TlAyVytJTjkyOGI2TzhUMG56Rnk0dlFXNEE2RUw4OVI5cExEdjZ4QWtaSnh0?=
 =?utf-8?B?aHhXQjNBUEZRRWVYMDhWK1hhcjdjZmo5WTZKMGpaS1h4Z2lWT2Njc1E2UXZS?=
 =?utf-8?B?aE1nQWQ2bVlKWkZLRUpWMFlKV3Z3RzM4R0hCR3ludU00TVhicGozSGE4SVV6?=
 =?utf-8?B?WHpqU1NVc2cxS2lOUzREY0dZb1VTUlZ4cE1DckZDU05xTGZuQU5vVlgyVVRa?=
 =?utf-8?B?QzhQLzY3K3JxRjV4L3A5S2FITGZxODVGMWlTWjJxV3k5SjZMcWEwUTdRWElC?=
 =?utf-8?B?dHdWcjJQMUpOOW5wZ2lBVko2Q0kybW5uOVdMQXhrQ0tZOUlmVFJGZFpRRHEz?=
 =?utf-8?B?bGFRY21MRWNubWFEcU9vM0k2R0MycXQzcnZKT2RHNWNwM3R4dXJXeEZhSGR1?=
 =?utf-8?B?RDNpN2oyNXdkOU9nREQ4VUM2L2F0czV4emdlSlVNNFhhRFB3Q0dXeEtpTmRD?=
 =?utf-8?B?QkIwMUczcGhVTmE4WE1lQ1FqeDZ5OWZxdXl6Q1F2bEFsc3Fsc1lJWTBsbHZt?=
 =?utf-8?B?K0NvZzUxcU5aQmJLMUR5clhERTJVTllYVEcwbnZ1RVhIemNUNGVwbXRkalVK?=
 =?utf-8?B?VnNTcnFCbEt0cWc4ZG5McnZKMG1WanNLSHpHUjlwMk9NU0FGTEpRQTRzN0x3?=
 =?utf-8?B?SEJVVzJnd0RmNWE0bXRUYU5RTWx2cWNrVzVLMHNvT1ExSzlCZWdUTVFIS0hp?=
 =?utf-8?B?eHRWZ2ovV3JjZWpVWlB3OFFoV2kvdlNLRytSTU94Y2hid0ZDZWRnY2xnUkRk?=
 =?utf-8?B?NUh3TmdNQ2dCSHlqdkdPRGFJcEpXK1FwUXlIZFUySDdETTYxM1U0bkFZaVR0?=
 =?utf-8?B?TzArQXdoQkhrNXJMUDc0TFJFTTFVc3h4K1FIRUw3eVNrd0V1VzY2Y21XUDJK?=
 =?utf-8?B?UWdaZmlEWDgzMVFSTkVsa0RYdCtFbzhrNnkyYllVbTVRYlJhaEpGdTFHTUc0?=
 =?utf-8?B?cDJzSW9tRzJWdDZJckxZMUZVV3NORy83M0Y2d2J1NUJuSndHcVYyd0JMNzla?=
 =?utf-8?B?aHRnSGFYaEJRZW84TTRtRXZvMjQ4dTN0MW5UdDVabzdrbzEvZENwOHByMWpP?=
 =?utf-8?B?MTgxai9KNlNaUkE1YmtGeDlvaUwvTkdTMUZMemRiSEtWRThDN2RPVGc5MDZ6?=
 =?utf-8?B?dCs0VmJQSDI4djJmajFZdytnbFFIU2RqY3lkZmU3dzBFV1d2QWVnQzM0anRO?=
 =?utf-8?B?bTBlc1lNSEhLYURvcjRrc1hjT1p2RGVsVWFoNVAxaFBOYXVWMHAxNE1Hak9x?=
 =?utf-8?B?bTdMWkl2WTlHMzlBVVl0Y0N6YlFJT2xWcHUxVFU4TGphZGlVM0o1dEg2YXYv?=
 =?utf-8?B?eGdOZ0s4YU9LWWhFNllzcjlFanNOTkI0Z2dwelFFZHNiQklXWnFuVUVNNTFl?=
 =?utf-8?B?cHljZ0RVNWZCRkUxbW5CUHBVTFJ4alE3TElSbE5BRmNEb0s3NDRiSExQY3Jo?=
 =?utf-8?B?U0ZYZGQrZ0xkMk84aGdZY3J1Y1FETHd6a0VHQ0UzWmUzenpDWHVwcHNCb25h?=
 =?utf-8?B?MGZ4dWRMUHUrYkpiYkc0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVo3SXlrVXpCeFVtNGg5STA3ck1yTUV2S1lLZmJOREFqQS9jamFYejJ5SXpW?=
 =?utf-8?B?TEg4QVNjM0M4cE5vUkNESzA3UXVxNGlEN3k1SlBjTEloMHBWZHFiSXJEcXhS?=
 =?utf-8?B?V3kvTDJzcnhkZlVCZGdFVjVvMVozQ3htbEw5Y25JZUtPMW1KQ1lKcmtXa0xu?=
 =?utf-8?B?VmF1d01KRVZ2TnBNK1k4MkZmQmdWaE1Qam1tU295NG15dFFxT2k1Y0liSlF5?=
 =?utf-8?B?YmtVZXErVzZpMnRObW1EQkVXdVNaZStSWFV2VUNncS9zbGpkTWJGeU1hUldX?=
 =?utf-8?B?TmVha2tLOUNZUmh6QjYwRXdnMjZJMlhPODNtdzFkM1FIOXlPYUJTVWhXVUNp?=
 =?utf-8?B?MUdsVStxTzk1V1NsWkF6SUpUdTU2Zkxtd1pTaVBZZWNDRXFiZ05rOEV4Y3pR?=
 =?utf-8?B?QUpmN2Z5ZTl1YjJOVUs0QjhvenlxeDJvZlEva2QyNU4xOGl0RHlrMnNpM05h?=
 =?utf-8?B?V25NRlJ1d2dKc1VLTzJGYkdVSmpyalNoMkQxYlc0b0xJM0V5SHNpdlViRElt?=
 =?utf-8?B?UHF2SkJ4ZDU0U0FyMG11SXhFZ0YxSDROTVhnbnNWbnViOUc0aUQ3aCtCWmVi?=
 =?utf-8?B?RDNOdWZjU1RqcnRLL0ZnVlV6NjVralF2VmR3U3RzWitIV0NOM3MzUkpBWXVQ?=
 =?utf-8?B?TjJobFRrTHJRZmMwTEFwWThjc0kyM2IxWHVkRDdXVmVDVEtlc3JXVmJRRlpM?=
 =?utf-8?B?WmgvN2hBamxpUjZkbHVmMzBVRGxwTnZnaGZzUGJoYXI4ZDhFSm5DS3N5cUZw?=
 =?utf-8?B?RkZhK0FBb1MyaTV0ZTl1bzhNYnJQaW9jRTBtaHNVenU2ZUt6MDhXWFVRcEtJ?=
 =?utf-8?B?QXhaUXB2NFJXMndSeUlkRkswaEFnQk43QUJuZC9SN1ZLV2hiRG14TnFRODJ0?=
 =?utf-8?B?YzhqUVptVU1RRmd6SHdraHlpZnI1NG04dFBaNFNhTjBSNnJPN1d5OG5Lc1Jh?=
 =?utf-8?B?bXZxQXUyN2NpUENFOW1ZWHF2YVZuRHY3b1Z2M29BbGV1eHF2MzE2dDY4U3FG?=
 =?utf-8?B?S0JtK2xoUFlIVzY0UGErZkRNM1NFeS9wWElrL1Z6NXYyWkZnM01PdmNESk1m?=
 =?utf-8?B?Zi96T1BMQWRDaWJXeGx3VkJ2YUlYUXRBRnVTa2JwZWthaEcxLzlvK2thSnRM?=
 =?utf-8?B?cG02RDl1elBMQ2ZMY2hRTDNjd0J2SW5jd1NiNnhzalUwa1psLzZvMkpRNEZz?=
 =?utf-8?B?RmJRcE52Q2NiYVg1TVlaZE9aMWZWWVQrM0YxTnowZXU3bVZ2WVVaQzVCYlds?=
 =?utf-8?B?d244QVA2c0YxbW42QXAyY2RkL0NxM1BDT1U0YmhBb2hGdHBpSHFBMWFIbU8x?=
 =?utf-8?B?bXRsRWdLTGYxWGJCaWs4RUFKMjhPTVN0ZWtBZHlCa2lwNDRlM0toejlqR09I?=
 =?utf-8?B?M085cTN1d2pOSTBtMjM3RDhsbXRqcGVFVnlhK3BDTk5rQlFjWjdIQVZtakhH?=
 =?utf-8?B?b09DZFlLOGlLTUx6SVBrU2lWb1NTL2NsNmhWWWJJSnhxdXdMZ2VYTnNSL0Vv?=
 =?utf-8?B?SlpraGpGNmNBaElsVDluUmZ4cVdqUVBmVFZicG1CRmVxdG4rOENhT3hUWkV2?=
 =?utf-8?B?S2hmc2VlQ0dSaFBiRGpzanlnZmd4SklVNENOUXFNYmFGZmV4VzJ1aVJQRVFU?=
 =?utf-8?B?VmJMaTdQOE56YWtKL01KQ0piNG9CT2hvcjdjTFNEeTh4YVZ2dmNIMkl5RDFO?=
 =?utf-8?B?TlVZdmF0NXpmM0NGUUJRR3VkM1h5UHJJOHRPbHpwZ2xhYjJBYm5tdUo5R241?=
 =?utf-8?B?M1pTZWlOeXhCMVNNUldpL0lHLzl6TGhweVU4L1pOUXJzd1UwUmowQUtwZldB?=
 =?utf-8?B?QVhDKzNCY1MxK1ZiaTdQaXVTN2kraUZNZSt0ZHRaRk5SdVBxUFNrZ2VxL2c3?=
 =?utf-8?B?QTRKenR1enN3TXFBS2dKOFhjYnlhQlh5Tno0aDJPNE9EVTBROUlsWFQ5cGFp?=
 =?utf-8?B?bUFJN2g0ckp4Si9JZDdFL3dDWktGZzlrVkFVNVBFVG5GakM0Y0tlVUNqMzR5?=
 =?utf-8?B?ay9QU0MvcWlUSnh6TStqTHNsYnhxYmErT3lERFlyVWhPODNTL3dFMWJKbjhI?=
 =?utf-8?B?ZENReUxyT3d0RGNpa0R6Mk95RHBtb0NKcXNXY1QyTDR3NlQrcEJZVklSTW5L?=
 =?utf-8?Q?RQ5Hqk2q8rkn8G4ws53z7WllU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bea73f-2176-4f4b-56fe-08dd00447e50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 22:27:13.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x12DuUw6mwIpwbNiTIzE2H+XswfhRCw6724rnfGyqodUc8cJFh7UEaK8r4coApnrwlAA1rRBGKQeFi30nHGUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318

The register layout of P3T1085 is the same as ti,tmp108. Add compatible
string nxp,p3t1085 for it. The difference of P3T1085 is support I3C.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
index 0ad10d43fac0c..a6f9319e068d4 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -4,22 +4,26 @@
 $id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TMP108 temperature sensor
+title: TMP108/P3T1085(NXP) temperature sensor
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
-  The TMP108 is a digital-output temperature sensor with a
+  The TMP108/P3T1085(NXP) is a digital-output temperature sensor with a
   dynamically-programmable limit window, and under- and overtemperature
   alert functions.
 
+  P3T1085(NXP) support I3C.
+
   Datasheets:
     https://www.ti.com/product/TMP108
+    https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
 
 properties:
   compatible:
     enum:
+      - nxp,p3t1085
       - ti,tmp108
 
   interrupts:

-- 
2.34.1


