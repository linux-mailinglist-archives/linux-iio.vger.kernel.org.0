Return-Path: <linux-iio+bounces-12053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4AE9C2785
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 23:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E40B224BE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 22:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4A820B7E9;
	Fri,  8 Nov 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l4ROD/yr"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F21F9414;
	Fri,  8 Nov 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104842; cv=fail; b=qj3I6eeKo4GgXc3paljvHz1fYiGYPFzW/MaeMAzR+oq3oND0uwS7u3D5ig7AYKOJ6Z6XdTdIjKjCDgR84BDX40jA6hrfLKnqQ2+Sb6dPayaLgx/aKV1S+ZCJbDlpucB+XCGfbL4+NIrJcMYLu4XRyadhn2JE7E9Mhfs4b/WY2W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104842; c=relaxed/simple;
	bh=7vqUo8jS1tJGYAA/RPchhwptChqKVdHqHfWjBgds2OY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AV8Wc7g9utpmyH9kAC7cPfJxEALSC9zune5HkTL3AxGaGAVBN5R3PNxCLKyiJCW9h2DwLATO3VsBkyQ8Efv6d86OgV6BUdVJfhSf0pFTv4HuBrlIuZwy5qu3Xop5J7We5XtHnNDB5+NmYNWcpiNx5ReHal7gDXZTihsFXFSXOAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l4ROD/yr; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQCOKadvvjCrpApWobOIAK+rk9H30+4C7yqdAna+h2pr7W3apSEsed5o1w7OlBTyokQkh+2PuT8rpUTE67o+cLX8d5MVyhepvytdmtoZCdhIWuqKSanxlpCRhdbdo8dxTNZZutEF6R752JLdkdKzfH2lPO3KTG1WoJNNMaJAMeH7cd3ieGcFEZdIxcBegUeT7CfZlJJJaj5dj2v3ESzLoabNLPTBgGkYh8jrZcMtIbGeatYrWmUfX2wnXdAJXuZkwTiZnJUWsMUw46IGDvFCEEwc0G25hjpBY+9mD2+ayVcarpq5TEf9DF8ENXdGQ33c5noqXuHUvCKnYUrApWpKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQxxB2o2JSHVWvb0oARWH5ibKPXi3Q/FGDb0iu0rvFQ=;
 b=exnn/gzOGArB8rIJh10KylMSQgVJfX28kxBog7WJHUTwJkJybC6mUfX2Jxb9D7xHzojIVoAu0bKGttYNAGcJVRR6eSllIu7h5vLgToKEMy/KoMBgjiB/FhmUSg4IbDcS94uaAgkVVKWtvKgQ4BZr8t6ghKJFta2MYY/+RqJPe0W3qmwxGmL2EFyc9jLiIHCq2ZVm4B0liUw8irikiQq1B9KA0pUxqZXlLLdqomeYSE+t5JrsqvY3YAAi6XCFc3CDyCMguqv5pysoCoN8dYdB+iRTBdu5TJXC9yjOle820K8Kromc1m0CeCfjBYx8t3qD9zy+Jd9d9bbar8yZXjl94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQxxB2o2JSHVWvb0oARWH5ibKPXi3Q/FGDb0iu0rvFQ=;
 b=l4ROD/yru64ZeLjg6D+4n8mMZk2gGqXnn05ACMa1VN+HIaLdiLBOgkml3HPb8//veK1q6lztE3EmmxioOfXcD2wIrClTmhDNUU1QPee4gesQ9ITDAMosG2sAyJFTcPvS8pio+qIt5r0Tjccb40vHJ35Fu3A3q5Y6coiyfIy9qbYVmjVat5s4XfJT5I7Z73My6veJcRZEoPk/0eeEJsBAITtZv5+XqKN33UIUZydIFG/hRmKh8WZQq01zzMKzMX5+Owu+qeJG2hQeiTRcRxqd9KSI/psW2zJWeK9teEyxS5yH0AZBVRVGx5b0L6kWAvPU55t1WAG6Wy1wh1VBapwL7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 22:27:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 22:27:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 17:26:56 -0500
Subject: [PATCH v2 2/4] hwmon: tmp108: Add help function
 tmp108_common_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-p3t1085-v2-2-6a8990a59efd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731104824; l=2932;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7vqUo8jS1tJGYAA/RPchhwptChqKVdHqHfWjBgds2OY=;
 b=IzeN1oI+bStNzAHrZzCbhvDeXZKvG3ArBDR+V7az5kHvP7mUDXeOCV05iQzqu7DkFkc5pzTsV
 mpom4z2QDnrD/9eq1qguYClJtv6IS4enJd/4qt66CFLmiNDeQ9EdAgR
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
X-MS-Office365-Filtering-Correlation-Id: 99662ea3-c3ce-4687-1053-08dd00448112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGdpNnRVL201N2tlRkhodkNXU0M0VFF5bVkvZjVZbkFLY2tQTFk5ZkcwQlFw?=
 =?utf-8?B?RlFidWFjeVd0U0RKQ2MxVk82Q0lzanJILzRhTmROQzJva0hxdDlKak1WNFhO?=
 =?utf-8?B?S1E5aitGVGJEK2grVkNyT3FRYThmZnYzOEVETDlaTUQyaWQxaC8ybklILzJn?=
 =?utf-8?B?eUhsNlJyNjVoaGpJN3JrVHZIRGNhc0tOSWJLU3J1VU5yUGF5L1ZKazFWZFA1?=
 =?utf-8?B?WE9mZGtvZzlDOFZzNUgvekpxb0VVKzFkSEsxd1REYVVrcTI4OE12bmJkeDBF?=
 =?utf-8?B?cXJDcjA0VEZCUUJWcmFlc3JiSWRmT3BqUDk1OXpDMzRPUDhJeDd0Q2lneW1S?=
 =?utf-8?B?QjJUUUNkcUVzNTJvT0ZKM0w4V0ZLYXhuTzhYM3lRUzM5bnlZV1hkaXIyaW02?=
 =?utf-8?B?Tko4S0RKbzZHNXB1aEd4c1M2RWdYZzNNd0Y4TFZhSE5vOEl0SnFSci9BdVZE?=
 =?utf-8?B?bWd6aXZyRTFFeTlLdkdkWW5EVE9mYjBwMDFYWkxrN1dNV0NqdlVKWStIeDNH?=
 =?utf-8?B?WTR6dnVaZ2VKZEo0MmljZ01DeDVRbW5kNjY0dTNraVJHQjFaWVM0QlBhQlVM?=
 =?utf-8?B?aFUzMi8vVDhXdmpIR0g4SjlqclJyOEpsQVZiblRwNHFsOFJSQmx0NHZNM1hX?=
 =?utf-8?B?YXpkUGdtdE1OUHJkU2pKK05pMW1teUhZcmsvNUJ1MENHUVhra0ZHT1A2RHBa?=
 =?utf-8?B?Z2dsZHBKRHhPOUlOaC9uVGZ2U0d3SW1sTE5NR3JmWUE4akZvVFRKaEhQV0ZB?=
 =?utf-8?B?TXByekMyME1zMWU0QlF4SXJPVElrK1doVzlUeElVYXowTys3TUU0S29YdDh6?=
 =?utf-8?B?dDZxM3UybHhsQnU5b29RLyt3NWVTNk93YVl6VVppUnh6bVp2ZkpsZWp2ZS9j?=
 =?utf-8?B?SVl6Y0JsQUpnRk84RU13Z0dMNzVuTVA0bFZxeFozNjE4RVNkYW5yVkF5RUxJ?=
 =?utf-8?B?QThQWHNadmVZMU1TYXJPUmFHdzVGUUNnVXgzM1JYTEdkbm5GY2hUTzF6bHE0?=
 =?utf-8?B?WDljMWNnZ04xSC9tVk9pUXFRNEFCZDUvN3dQYlljQWo5bnYvZDJ0cnFvQjZT?=
 =?utf-8?B?L0xlb2NKWUJmN0ZPekc2RFRhV3F4dTdSbzhBT0VPWkFVV2crUjdPZGVjeGg5?=
 =?utf-8?B?L2RvNHcwaTRoMTg4TmNnb1gzcU1pZ0VNUS9rTC9tUXQrOVFKTWR6Y2IzS1V0?=
 =?utf-8?B?WlpIWVNxN2pmdVJlWnVzMmJueHVGZ3pxSCs1eUdTd0RQeUZWRktnWmVvYk9t?=
 =?utf-8?B?QlAvNVp2OTBjVkFDQW85MFp4TUljd0FOMzQwYXdJWGNwdWhKYy9xdkF2QlFT?=
 =?utf-8?B?MG5LT2t4YXJiSWFXM0g0ZGZmRnVTWE9LTmNSV2FXVFZ2UEJLaituU05XWnJ0?=
 =?utf-8?B?OU44Tkx4NDdmdkk5cEhSOTN5UEtaeVZGL25GVE0xV09VT0lUQWhLeWhqMmht?=
 =?utf-8?B?THlvNWduRVR4UmM0RWlsVzJNSUltQm5CRW4vNmFTVC9LRnIvaDFsVTY4TmJQ?=
 =?utf-8?B?Vk9OeFJKL2Q3eTA1YzBaWjlTYWJDMlhDMGJoNXp1aUxkY041dDZIMk5lVnVK?=
 =?utf-8?B?WVR0aXlVQXBsOGQ1c05VV05jLzFmMWhmaDZDRUNrWVRhakFxdkh3bi9PdnpW?=
 =?utf-8?B?aWx6UTdSdHNKVmFzcGoyMklEN08zditSckJkVzd1citDUjNveHlWV2FxVVUx?=
 =?utf-8?B?V1d4ZjdNWVZqaUpjSWNUYlNITHhGdDZHeFVKZ1prQTBQZy9ydE5JTnBTZk40?=
 =?utf-8?B?dHoxcjk2RFdBeS91S3lnclFZVEM3NkRBWjFQa3JiVGdhSDcxaVpIK1laS2dQ?=
 =?utf-8?B?OW13S2hKQ0kvUnB3VXo3Z2txd0pwWWhFdGNYVGNOZDlxdVZhcWNWOEJzMmdw?=
 =?utf-8?Q?UoYHfijYqvNNh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVd4NG9OMm5yNG00L2JRUjAvUVhIN0NkcElabXZIN0I4dlFQTFlKQ3QxZk54?=
 =?utf-8?B?Y3ZLN2RjV1FMcld1NGZkU2ZVNWwwZlplbEhBSUhvYnZ5YkNmaU9yWjBxQjQr?=
 =?utf-8?B?K0FMcGJZUmpLTGZWRm8yNE04MWd4WUwzdFdwN1pvR3NMQkdFakxoN1NZMDcz?=
 =?utf-8?B?N0VtSEFGRVVjTWxOR2o1RE01bWZ0Y0VNR2VEbUhBeGNDcXhlM2VnMHhXeGFN?=
 =?utf-8?B?UnNjbGdqblYycjZWbGcwOFB0eVhhdW81aWFkS09uZklhNWY4bGNUQWhvd1NK?=
 =?utf-8?B?dThOblNLK3RzK21lSDFBRml4Z1Z1bkh0SjJscEhVdUhtRTlWUW9vSGRyVWxD?=
 =?utf-8?B?Wi9QRTJCckF4dUViVFBQUXBmV3VPKzNnbTNNN2JjM0Q5VkxDYXRJWnNaN05L?=
 =?utf-8?B?SDdIcGpXaitVVHVGWDZiWG9jSCtEb3RFWEVBektOK3FrOVJUZG8veG0vNUlD?=
 =?utf-8?B?ei9QSUR3aFlCa0U1WWFYRmZ4TDFIMlB5UVZBRy9rTTlMbXpHUnVJSktvTE1q?=
 =?utf-8?B?cTEwc2Y1bUZJeHNWN0Uxa0tsRGlwNVEzcUFheTUrREMrTzYxZTE4NTVWQklX?=
 =?utf-8?B?bUFIL1VycjdGc3IvMXBoWjhLR1A0NFhSWDZFN0RiT2xCUmM3MytnakFXWXpB?=
 =?utf-8?B?aXJEdzA3Y0MyVXpoODlqZ2k3M3dUZGtCWUkxanRjenB3ZVVoVWhRTE1BaUpN?=
 =?utf-8?B?dUFHOWJqSXcxejRGUE45MmwzV3VFTGZHYnBYNSs5NUh4UjNlbGhMS2FnNzVs?=
 =?utf-8?B?a09Sa3pSSFFlS0d0Z3U3VGp5Wjc1NGhnaGpFaC9VUTRYUzNkY1VYYWNHdTBN?=
 =?utf-8?B?NjkxektJUEI2UFdjSjBKejVJdERCSC82WDhHb3NMSHJwUlhVMEtiaWpiRGhI?=
 =?utf-8?B?eVlkTk55ZTJMemdoQnQvL3ZJVnVLMUZEbER5OHJ2ODhaQW5QVzVxR1JqU2Ri?=
 =?utf-8?B?eHRFYkU2WGdEQlJZM2RqdEw3NGw2eE1TZEZXYTY5NzdlZUFwTFp3eFJBakov?=
 =?utf-8?B?cWtNZXZzNTNSanYvaHBvNWtrRVdmdURnekNpVTFCUHJ4MTRPR2UveW5oUVJG?=
 =?utf-8?B?bmRjd0hOWWR2YktwL1VmbWdJNHI0MWoyUmkrdXQzeXVvSVV4QXhKVWUwU1U0?=
 =?utf-8?B?bHBmSTVMR2tld205YW1kN1JVaU51dkU3VHNpL3RJa2l1alR6ZkFjNHVobHps?=
 =?utf-8?B?S2ZTRU9oZGdHUkFOVjdua2NFZGRtTUpFT1VGQi9KaFpKei9oeldESmVWT0xW?=
 =?utf-8?B?U0d0SEhvcHRyQWVWTTFhUDkyNHZRVHFSM2FkYmVJRFRtcGx2QVZuYldCeW9v?=
 =?utf-8?B?eTR1QVg4Rm1tc1IzcEtGNFF6VVRTMnJMbGk3R1pBQUtDMHdNdm5DaWFZTlNt?=
 =?utf-8?B?T2hxWCsxeDFxQzNZYk1JNjBacWNEY3luQkRYdER4MHJxSUJtWnkvRDFEc3FY?=
 =?utf-8?B?R3dRek02eDcxSEVxRjJOSzg5Q3ozenIzTEFUaEJxL3RBUlJMQjBlWUlaZjlG?=
 =?utf-8?B?azcxTFVJS0F0Q0RUUnJldDducGUzTDBwQVZKb0JGUy9QbCtGSjVxOExObFFz?=
 =?utf-8?B?TFdaWnNMS0c1UmJyT0E5Z1krRjhZWmFjZ2djVGpxUEIvSFcwMXMxK21iNmYv?=
 =?utf-8?B?dlBkSHFIWkJJaGFaVE9ZZDhOcTVESG9WRklKR0g2NWw3VHRseWFZa1BZb1lo?=
 =?utf-8?B?a3FnTkFhWEd5dUJqOUJOUmtFcWorQi9EMGt3OWNiRzZsa2kzd2huWVdROExu?=
 =?utf-8?B?VjMzMWtWeGFzaVJORTlTTmpOZUlmQVBZTzh1aFhLdWtDZjZsTGkwd2tRTU0z?=
 =?utf-8?B?aU9tTVZsY3daWU1wbkhMbDBQTmNtZHRVeklrck5FVHBnLzk4SlhzTlp1S2l1?=
 =?utf-8?B?U3c5ME0zZHhHajlqaGE2bnQvaTRCc2RrRVVKdzdEUFFXcjh1SjYzbWFTcFJn?=
 =?utf-8?B?OEVUNFpEL1ZucnprdlRZUEN5Vi9oUjZoMmpNMURPRkREMENyd1FKckdZK3gr?=
 =?utf-8?B?NkhwbnpCQzRXeVhpZHRuT1FYeEZNZ1dHQTgrVEpKRVczOHh3K0U0Q2NOTU9Y?=
 =?utf-8?B?b054c2tiV1Z2Q3FUVW05VTg1WjBhdXJ2T01wNXovbytHMk9VaGR1cjhTWFpj?=
 =?utf-8?Q?46DA0oFG5dHCpt5aM8HYy/edB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99662ea3-c3ce-4687-1053-08dd00448112
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 22:27:18.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMjZM2xMQqpf3FUR9Zd6A1ZgiZcAaJMyu5PZb1tghRFA1OtALOEXFlRjRsnROKwt9pYChJF/N4KQzhDsGlHeaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318

Add help function tmp108_common_probe() to pave road to support i3c for
P3T1085(NXP) chip.

Using dev_err_probe() simple code.

Add compatible string "nxp,p3t1085".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
dev_err_probe() have not involve addition diff change. The difference
always list these code block change regardless use dev_err_probe().
---
 drivers/hwmon/tmp108.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a82bbc959eb15..bfbea6349a95f 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_config = {
 	.use_single_write = true,
 };
 
-static int tmp108_probe(struct i2c_client *client)
+static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *name)
 {
-	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct tmp108 *tmp108;
-	int err;
 	u32 config;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(dev,
-			"adapter doesn't support SMBus word transactions\n");
-		return -ENODEV;
-	}
+	int err;
 
 	tmp108 = devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, tmp108);
-
-	tmp108->regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
-	if (IS_ERR(tmp108->regmap)) {
-		err = PTR_ERR(tmp108->regmap);
-		dev_err(dev, "regmap init failed: %d", err);
-		return err;
-	}
+	tmp108->regmap = regmap;
 
 	err = regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
 	if (err < 0) {
@@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, name,
 							 tmp108,
 							 &tmp108_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+static int tmp108_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -ENODEV,
+				     "adapter doesn't support SMBus word transactions\n");
+
+	regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return tmp108_common_probe(dev, regmap, client->name);
+}
+
 static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 = dev_get_drvdata(dev);
@@ -420,6 +423,7 @@ MODULE_DEVICE_TABLE(i2c, tmp108_i2c_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id tmp108_of_ids[] = {
+	{ .compatible = "nxp,p3t1085", },
 	{ .compatible = "ti,tmp108", },
 	{}
 };

-- 
2.34.1


