Return-Path: <linux-iio+bounces-26945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EF2CADBB6
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DEB8300CBAB
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB152DA77F;
	Mon,  8 Dec 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="dDngfic+"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021099.outbound.protection.outlook.com [52.101.65.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC5225403;
	Mon,  8 Dec 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210896; cv=fail; b=nFpwlpynsF6ON7FOX4SdZE0TzVI4GPuISE2veefi3v/Fv6J/KPgE0xap1iep1ys9EnPDWcudMjFf0kEe98zbBYk45KJI1+ctTVQ153qISmZMNTid22n806vEL68rBgd9g7fEmjpPMRNdKw33cRT2VgeqGB6tw0RRXoiTUc7FrO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210896; c=relaxed/simple;
	bh=yDj9Y0oMg8RE/9EsNlTEH1LcXWlvEeqpXWdJz1bVHVw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsqxi1a4OZ/kuAhQFVklhheHeZ6/bqitwcA8HuCiOV9QOao32237u2wIpyRQFa4MSV5hGEdLwBtKnv48B88E5QosA0JEF12p8vfH19SEcjfcLgdCIOv87ZKnlArZ9R9s0xYg7aHHC/m5Ps7ZxuznHE8kAGMT+OaIIxF1qwp6Z6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=dDngfic+; arc=fail smtp.client-ip=52.101.65.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj7dHyhRSD8ADxfBcvFjFxNsOHl5dwbWdtxAZKw2ve5vqNVxEFZOYgiKz6WRCw3n1IOW71M/B7L1n47QPtLAfoBYmflwhriP/1gisRBsXSNqNfwb4U4uBap30kQRoqNZT9Eyhja2i/zSjL/uAu33svYKdMYQ3/8S3aHVgXsMbfvI/NB3IrrXq9CHUECfzscJ0k5qFJgwXlFsLgyisc1LYJH0gy2GmDD6ArcopUQu5+RWFbpJUQ8KE1YBx3JTyRKceyDPHXccxh8IhJhHzpBPY9nKinsmAYE7BFilT9QRGvKOxkbTV8lQnSJDV1a362aQhDmsxW9aR0RnXffo2DHl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8fvmAjkcFkfNYZg/TKwrIMPD5tRRoSdjzdyMhvmWOM=;
 b=FkaYjxp3BNNZm5D/Xd0BNEvYAYQMiF8DTkyYymLF9PJC0nO9pVDpbewQMKWwG5zVJbgZraicgHsKj4zjHU7qlrJJG2Hk+vY1u+CYpwKQQpi4+Jxwn80RYiinMNFhEIivxin5EtdNANs3TOvnzFJqCxiWrxPQbdVI7wOAx+UdM66ynTz4GYiPkwI+JaYAkX6/stwV1b2z+Pf0ElOOgeKNldWNKMfM/BhtCWvXU+5bDqZDpsEuAi+tCgaZpS+cyqaE9cwblCylLx7Q3rTnDX+7vEt2a25aCezsct+VG8Mw4McAitnDktcbV0ybJuExBj8ub2IalkFJxBhPYV2q8kA5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8fvmAjkcFkfNYZg/TKwrIMPD5tRRoSdjzdyMhvmWOM=;
 b=dDngfic+hfN0JLK+jXnhkl58cnMag+0ypObuW0a0fR9CRwcV5RmL13TFpi9eEMvtPWh7bu/kLNwRdVulQgFbafFkBjmjhAMikWzQriUzOD7+n/EITNJ9WabF5Y8pToPGV9uPYSqiVvZJQphI3Z2k4Affn/qe8NdKKShBgLj07s58v5HxMoCfiQJvyNhRgThNKhR3WRhKdsihA27LOwxoechQ83kEwDotWENQ+oHNj4TNNbzJsI2okLnqcqF7G13krQRHKuV9ekzMiOqVQlQ6brm3k3Au6xxz7M7ZwXtLrP1+C9J9AwvDfqwZlyYzW3HUMTge7fOkQ9flEyyWGGfHbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB8PR06MB6492.eurprd06.prod.outlook.com (2603:10a6:10:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 16:21:27 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 16:21:27 +0000
Message-ID: <905d3a14-1e78-469f-99f1-4c1d2299d97c@vaisala.com>
Date: Mon, 8 Dec 2025 18:21:25 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v3 3/3] iio: adc: ad9467: drop kernel.h in favor of
 array_size.h
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
 <20251208-add-ad9211-v3-3-c49897fa91c4@vaisala.com>
 <aTbQmOpMfQnYkeLT@smile.fi.intel.com>
 <1467f6e5-9d50-4b51-a283-aec19c031470@vaisala.com>
 <aTb1vEEJRY6Uom2l@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <aTb1vEEJRY6Uom2l@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF000167FD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::67b) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB8PR06MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 225811ee-e00d-4d2b-82bf-08de3675d6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHB0TDd0NzZQbFZ5YUdHN3hWK0JNZDVmV0ZZNk56K2tVQUZlMEVvMk5GdmtU?=
 =?utf-8?B?bWg4R2xWVitHdXVJM0RYSlFMVUhvaUlMVndmNTNwQkVJYlkycjdyOUdvYUtm?=
 =?utf-8?B?Sk84a1pXMm4weUMvcDhESTdRT25jeUpzWDdlSHpBaUhDaFlHbE5QL3BUNjE2?=
 =?utf-8?B?NHRnbXZMa2dyTjhBMjVvQmYvclR2TnNEYmhjcFB3d2tDck9IaHRkR202K1hF?=
 =?utf-8?B?d2ZRbjBaamlMVU5sY3ZoWDBYeVNOYzlLT3JFZGN1VEo0TU12WVBTUzVQWWx6?=
 =?utf-8?B?dytNWnZTdXRCZnArcFo5ZDlwbFVhYkJLRytXa3pDdWI2dUlsa2h0dm9Ibld3?=
 =?utf-8?B?cTM3dE9XUVVFR2NpR0QyUEs1Q2JJVGdIUFZrNGZTVnBYcnozZmtNcW41dFUz?=
 =?utf-8?B?REpwZE9oN290dnNzQ2JYREVNQkEyT1lrcm1OcEpIa1Znd2JtanA2TWo3OUhj?=
 =?utf-8?B?TnZnd3BYNEJwTkduUVpjZmU1WkNMY3I1aVEwWlpJZk5JNDJMWGxJcm9nT1RT?=
 =?utf-8?B?K2NRZnozWEhqL2lLemc1VllWaUx5TUVId1kxb2VWQ0JZc2ExZGNsMWNabkJP?=
 =?utf-8?B?bGVkTk1McTM3TTN2REhHSE5jTjlnQi9HR0dFRmdLTVRyL2tpbno3ZGptRGFa?=
 =?utf-8?B?bEgxTHpSV1JCZmFaSXJ0R0FJcGFuMnp4dzdZazhhMWExRXd0MWxsczJ0bXkz?=
 =?utf-8?B?L3gxNEVkTkJmZjYrY3d1M1lWbmN6d3cxbzgwWU01Z2hDSmVaWjhONVRWK014?=
 =?utf-8?B?VGY2cERUdzl3Y3RTN3NtY0JLbHBWN0EyZmk2YlU1RGFmanlteFExWktlbGlZ?=
 =?utf-8?B?d2NyZEhUL3JhbTQ1TGoxUjhwV0x1ZkNoVFRlK1NZYzZTMGRONjM3aTVsSWRv?=
 =?utf-8?B?b1gvVDEzK1hyL05qbDdFcTlzK2NGNzFzZFJBVlo1ajZ3bnIwMXJaNnFrVW5t?=
 =?utf-8?B?WVRyVXhDeDNQSkdRbDFLNEs4dzNMcWlUOVY2aWNYNUM3ekd4QzlDN1hkVi9v?=
 =?utf-8?B?S255T1ZST0s1WHR5YjNZWUtsNVRhU1VVWWNCNFh2cExwcUNhcExuVGlIWm1n?=
 =?utf-8?B?TnJoTkQwdUJVQVl1Qjl6am5TeUpQMTUwcDZKSmw5QnJScnpabXBYamFPV0pw?=
 =?utf-8?B?OXdETE8zRUpHVHNtUUZDNU5qSG5KK2JuaHlyZ0UvbTJ6RkVYM25uL2RTQnM3?=
 =?utf-8?B?dmlLOFRiVTIzektmTmtvc3lNNW02cEw2cDhLaFMxTno1Nk1jcTl5L01IZFkz?=
 =?utf-8?B?cWlxMG1ZenJlTEMzUjY4OUkwc2dqSFgyTHNtOUpNSGxqeTZiTFNmUG80ZmVI?=
 =?utf-8?B?TnZVMncwNkZicFJodFFjUkpOOGhhNnZidlFkS25MaExtZ0wxZHlCaGxvNmI0?=
 =?utf-8?B?OFV5YmkxY2JEb3JOTHlKM2hRYm9OYUZsejlkY1VETnZyMkR1R05BRko4dXhI?=
 =?utf-8?B?bVdFTCs0SExvVlZUSTFxc1VMb3g4WGlMZmxjcEwvejFtNmlNUzl4bmlHREQ3?=
 =?utf-8?B?WldVVU1wU0J3NWcwWnRwWTBBT1l4MlZmUlRtbVNWVW1PeUozQTRXakMrWm10?=
 =?utf-8?B?ODgxNU5NYzdMUmVmUUNvVDRuNWRhemRNb242OGxhSEN4bG8yRkc4ZUVUWjJo?=
 =?utf-8?B?WGllRGlOUkxEdU5nQ2dKWm0yN1ZBZEhWNThvOVJwUEZUeVFlM1JNTkk2cHJP?=
 =?utf-8?B?OG5UMURmOFBxc04xdFNab2NKMHpZVEg1M3NqYTllandnVXhsWVB2dVFUSE1X?=
 =?utf-8?B?VlpnZjdObUxubGZiWGh2Z3ZLYVNWUGlZQWxWdzJ2L1dCb0JsMm5QRE1YVFln?=
 =?utf-8?B?cDFKNjdMbjJxeVBaWC8rQnFZMDRzdEI3cGlsOGh3RERmNHlmYXFuOHZldENn?=
 =?utf-8?B?US9hd3I2SEZ2cUFkMEQ0dTdPTVBEVUhIT08xMS9HN0ptTXo2ekpiaThTM002?=
 =?utf-8?Q?r5IRnMtSsSChaO2ae1MFLQllwpUkxCoH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVRkSUMwQUQydXYwTVRsOWVadldrMmhwdWxtaEdaS0NDSzF4b1Z4QXVxaXBl?=
 =?utf-8?B?NFdacDVQTDd3N0QwR3VRbmJwME95bk4vRFk4ZTVCNmpXNHlkUHRZcXJIWEJR?=
 =?utf-8?B?V0Z1V2ZoM2NDL2dvRUdZMHFuOXNOeVcyWndvSlF6SEs3WS80ZHY4WXQ1UDFz?=
 =?utf-8?B?ZmwrRXR5bHc4VVgrQkJiR0puS2FNT01BeFJlUHMwNmJDQ2t1YUg2bWtXSmZz?=
 =?utf-8?B?VnlBRTVTQ1p0T1NkbnhjVXRFS2YwYk1rTG4xWEI2UW1LMGs1Y1BEVDRmQkZ2?=
 =?utf-8?B?L0FHbGdPdkxaVUVtRlNveXZ2UHh6d1Y0N0dXT2J6dlRISTk4OFlvQnVvOGtI?=
 =?utf-8?B?L0JkeEluYithMVY3Q0s0dDYrdzJzMGNJMGQ3eHAxUS80Mk5yanEreWRndWlO?=
 =?utf-8?B?SXJ0WlFRSkVHTXBXZEgvSFFESGEvNlo3QnBNV2FlNUFnNXI1Qnhmb1dQL21J?=
 =?utf-8?B?RVhuZWcza2g0bDAzSFN2VXEwTzkxcXh5dzZucVkvOEJYK08rdHduRlFzcEtD?=
 =?utf-8?B?eElaNkJJc0FDM2U1YVg1UmxpN0k3R0FsdkFsckZYTEdnUGRyMUZpbGVSZ3hp?=
 =?utf-8?B?dmNxZmlha1RlaEdXNGlzd2RicUlFZlVsb0J6M0pnN084cVNBWVFIdFcxWGhB?=
 =?utf-8?B?dHNjL2RURlp3b0ZRUnp1Q1FBUzYrcTh0VmRqRHR5bVBZVkkvd1R5cXc3QkhK?=
 =?utf-8?B?allvcm1vUHlnV0l1c3I5VjNmQWV6TUZSYzZhTmlTMFNNTFpRaUdnMVREQjJn?=
 =?utf-8?B?am92UVdDMjRtTzBvUGI5NEV6L0RURzRTcStvZy9SZzROOXVDQUhnRnFrN0Y0?=
 =?utf-8?B?a1k2Y3l0SngyWWJ5U0VISWlBc1R1SGRISHROL2xhTk8xRFRmVWJkejBxRDdY?=
 =?utf-8?B?V2c0U1JsamRMcW9oblNvMVg1MTdPQnRjOGVtN3pOKzdtaGcwVFNqYlV0SGFs?=
 =?utf-8?B?em41dEVzNG1iSnBLdjdtUWhVTG1UNll2NFo4VmdtYTF2bnd4ckUyM0tUY0xY?=
 =?utf-8?B?OFNSUDEwcmNSdUE5cXBDN3VZUmw1NEVMUnhrL3kyZTRIeFZVcTRzajViMnpk?=
 =?utf-8?B?VnZ1bmdoc2t5TnJoQm5PQVpDWitnL1lFdjZjNC9JbFB6MHdHWHlwcEJUYlVY?=
 =?utf-8?B?ek5vZENkWGE4dTBPY2owclVtU1c5VGREMDhSQ1NUS3V2TXFLM0VwTEIwRXdG?=
 =?utf-8?B?b2p4SXpLVVpPQ1pNY0FHZEpqNTF5aHRacXFLYUlVM1UxS3lUVTFhRHFVK1Vz?=
 =?utf-8?B?MkhHUWliaVdxS1RhcGk0RXhmQWhuZWw1allZVHo1d0lKK0p3YTM3aVcyUklU?=
 =?utf-8?B?MEQ4ako5SnJxSGt2RUdpNEVhR1V1MlJNZUwvbG9YbzFUdkFNTVB2dFpYMlNB?=
 =?utf-8?B?Sk40aE5idnQrdEtBdlNBYlhHSXUray9EUVVoZm5pQW00R3dHSlFYWGZzdXZK?=
 =?utf-8?B?M0pqTmRnS0svUGE3ekhIYTFha3JsZ3RQbjJRWnVYRFIvMm4raGMxZldzeWow?=
 =?utf-8?B?WmQ0S0pGMVJkVG9ndTNlWE5IMG9SQmczL20zZ1dPT1g0VUZxV3pZcVRTRXQ4?=
 =?utf-8?B?SWs1TXljOEpoUEN6TWlOYWZEOTFvOVFvVjdkMk9WN3RubHpJMVBUeC9rMFhN?=
 =?utf-8?B?cy8xOFl6RWNiNFhkSzByMlcwbGlVTUpyd2prem5tMldWeWUya0hJcGxXVEU5?=
 =?utf-8?B?RWxuckNwaHFlQkRVL2ZmYkpmcWc5WjFoaitTYjBoYWVGSjBYb1lrYllwWU0r?=
 =?utf-8?B?WHZPbWQ2MDQ4V0ZsQ3lsRzZSZXRqVmJmT3UxWUtMb0UzNFgxRWNDWnZQdmkv?=
 =?utf-8?B?Zkp1R1Z5Q3ZrdW90QXVXanNQYkJrSTdZVFplTXNsYjk4TzdIMzc3WC8xNTlK?=
 =?utf-8?B?eDd0RGR3N2NrYlRKT2M5YzhhZ0hRTm9YdS9tRG1mVTU3R2xzcS84RllzWGJy?=
 =?utf-8?B?RytwTkJuekNWR0dVQWM1MUFZUk15eklZTk93cHZYcjNMeVNHZ0RON0pmUE55?=
 =?utf-8?B?NS9IMkFpT2x5TXBaR1RhQ0d6MUFzY3lPcVkrMDlKZHBVT0d1RDRhaTd0aEs3?=
 =?utf-8?B?QklweTNRSEliUG1OYXBlZlJSNTg0OXVETXNoQ1pNa0VIcXo2RXY4MnU1ZktI?=
 =?utf-8?B?UDlSeGtCWmpGQVJxOFlqN1AvUkRTQno1STlDTklBaERjVmwvZUtoQWVQcE13?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225811ee-e00d-4d2b-82bf-08de3675d6b2
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 16:21:27.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqvAudw/86HScpDz8S/zZfRU30BTCjpfZBll9Sk0NORDoAtdRrplEwUps5UEAkw6++BTrRQCHldGEAG2TlKeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6492

Hi,

On 08/12/2025 17:58, Andy Shevchenko wrote:
> On Mon, Dec 08, 2025 at 05:41:20PM +0200, Tomas Melin wrote:
>> On 08/12/2025 15:20, Andy Shevchenko wrote:
>>> On Mon, Dec 08, 2025 at 12:30:59PM +0000, Tomas Melin wrote:
>>>> No need to include the entire kernel.h when the only thing needed
>>>> is the ARRAY_SIZE macro.

>>> While this change is almost (*) okay per se, I think we can address more
>>> while at it.
>>> - Make the header inclusions ordered (also fix the location of clk.h)
>>> - drop other proxy (device.h) or unneeded headers (bitops.h as it's implied by bitmap.h)
>>> - add missing ones (dev_printk.h, device/devres.h, ...)
>>
>> As this change (kernel.h) does not seem at all as straightforward as I
>> envisoned based on your initial request, I will likely change this patch
>> to instead just sort the headers. Reworking the includes is separate
>> topic from the intent of this patch series.
> 
> If you don't feel going that deep, than it's a (small) problem.
> 
> As the author of a driver feature one should understand slightly more about
> this (yeah, currently mess) header stuff. So, your first patch should add
> missed headers, if any, that's required to your changes, this one can be
> omitted after all.
Well, I think reworking the headers is a sane idea, but it is not the
topic of this series.

> 
> But on some day you will still need to understand a bit more about headers...
> 
> TL;DR: make sure you have all needed headers for your changes in the previous
> patch and drop this one.

Hope we mean the same thing, I was thinking more like
   1. sort current headers
   2. add feature which adds the new header in correct location


Thanks,
Tomas


> 
>>> (*) no, kernel.h provides more for this driver, for example, your patch
>>> misses types.h.
> 


