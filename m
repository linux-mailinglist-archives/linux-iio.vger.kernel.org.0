Return-Path: <linux-iio+bounces-27156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B338DCCA131
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 03:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60A263011BDB
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD72F618B;
	Thu, 18 Dec 2025 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="C6ZPt1WN"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023131.outbound.protection.outlook.com [52.101.83.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2832C327D;
	Thu, 18 Dec 2025 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024464; cv=fail; b=rczXOFqMxHzhsbKgjP/ywRwTPXH1UW7MxPLmpTIySypctc/ejELSi75bBcuI5QctcRQh4dRn03aD4Lomy9WmMoYTl7G3I7VWhaxCf67BcPZ5Dw19/ERkEyaf5EA4s9WXMGwyRYNgSA824Dgpxa27Oz+Z6mNzc0FYRZ7yZFNlhGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024464; c=relaxed/simple;
	bh=3tC8fhJ6lVwnHvYuoZygH7OPs9JjXg/QtVJGjvXF0YM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ow8p67zOD4yx6QsJsuSk/R1+f1RXDRLW8ykSW4auzcZBBHrZF6aJhC1Rxk75jb+pE3TuqDXnvkPkr3hS3SCCB2HHV3gyd78zSozFsDRj8GVn/EsaUzPZ1qJngf75n0sGmPTBzUN7TqjoMZHfF/XJtCb9BmmUImNmbnBBU42SUfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=C6ZPt1WN; arc=fail smtp.client-ip=52.101.83.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Received: from DU2PR06MB8333.eurprd06.prod.outlook.com (2603:10a6:10:2e4::6)
 by DB9PR06MB8583.eurprd06.prod.outlook.com (2603:10a6:10:369::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 22:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF/hvg9XzSKTWpy0JgKyxCLqS1EaLcJSgoZrxTIHUfu0cHrzEkCAqGpROk4xJBEDTOvXBV2KWKlwvQtWTy4JyhJ3kq0oD6zsFMpJO/drMscqZZ464YBGVW18xkB+m5AJtoFRt7YFhZim5drEVKtF0J8xftqVAqwARa6aybqe0r3ZN5WT+WK332sQOAf6RYjVC9i9LWf0Q/wCVMAfdDQfJVDDmXUkMY+vFqnIdlMAyq0gw+9guEoG+X58rZSBM0KmAgNN+6lwxHO0HcSpMdRDnx8aJ1pobADrYWPli/rZJsE+iXpvtQNJkFeIpT4jAFXTUfWousCoV3p9iYawF22Z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ9fPZunvrgDbSo5IK1qa4gAmKPebXapihRUCEem4TI=;
 b=hj1n95cTrtmtGF2mOCvvtf+tluOZIHIz4qZWan3da3HL/XYODdJi4FoDu1qcCQZxDZNSyzUHi4Tg7ZxF1pVyxnx1tVvbQQqTOtJCFoZZOqlHc362qKA9C6udjaZ/IWc85NqOoeFFFks8u7+afSjHOrZ4TC/h/fEE5QPfyCf7eNM/dYOvElhNLFqicS9lTtoJ5vfNS4PhsACYovvyPMoOmXDIg0wHP8NbI8RbPUvtis6YpvJzOJBj23GSEtUsxjt6Ps0nwdMvLvnSb5vtCtBrnZUo6/e+6BVXmUJUjVa/lbHUUmSnZx0XIWQwYTlMd4C6ji0+9YMxYehd7G2zIAczjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ9fPZunvrgDbSo5IK1qa4gAmKPebXapihRUCEem4TI=;
 b=C6ZPt1WNa6LUxKbX9L/aKsjzAEFpQkYOVkRC3FwN2mCPi7BismAR3TAxhZT6Fmz5KZP26AJI4tivySix2PUkLRV+0swxkL5Jk64YQNVNPCGxrDMwrvMiaR1rXQoMVsp7+jfwF9Ix1Nqp3SixcHsJUduuhve/WVdxfS4vp/Aesq9htXFxQtfTyIidvrCNuWp/29MsAcu0umCR4CEE4JOCBYDA3qkp3zmGlcU1/5yxpox330ezS/R01WmQIVNpu+95XEMPHKnidD1VSm9zaQ5/KHE26+KL9CYlCAa3jrBcUlAJgJzTC0wZXL76D8OVLEDk0BDF5Gfw7Lwf7VP8hJb5tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU2PR06MB8333.eurprd06.prod.outlook.com (2603:10a6:10:2e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 11:44:07 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 11:44:06 +0000
Message-ID: <5fa44e46-2d94-47dd-8429-9748aa28f908@vaisala.com>
Date: Wed, 17 Dec 2025 13:44:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
 <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
 <c3ed08159082c15f8804c6963b4422bbbf2039ab.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <c3ed08159082c15f8804c6963b4422bbbf2039ab.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00003833.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:1a) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	AMBPR06MB10365:EE_|DU2PR06MB8333:EE_|DB9PR06MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: de1fd3dc-83b4-4e9f-0871-08de3d6195c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ajR2ZUppZ1IyZjF1ZGZ3OHdScEp4MmdCSlVzOGpMaG5xN1VQazhzU1NHeDFQ?=
 =?utf-8?B?YlNmRkFFS2NsZ3QwN3BtN04veHB6cS90eE8ydFZ1ZG9pNU1yUHdKWXhERWdy?=
 =?utf-8?B?UGpQbVRZWXlhU25UR3RQbDFlKzZqTE9IT0orY29jSVQ3RFMvZUk2dkdMeHFz?=
 =?utf-8?B?MnFSWGhtVkRoYyt2Z2x3WDJGY05DOVYxMlhyL2l2Z0ZyRzBOelhOYUVsZDda?=
 =?utf-8?B?MkM2eFNwSjd6bU1mc3g1cU9ka0oyRGhMZTRHZm52OSsyL2FPVW1vYmxLN3ZE?=
 =?utf-8?B?RENHeUlIZVlvdWQvck5SOTRwdjRmQWlNclZKd005VkNZMW5GK0x6MmJ0dnAv?=
 =?utf-8?B?TXNkaXpUSHd1K1JWQUxvNi9HZFRDK0xGRmZZNjJIV0xsSXlPZU1LU3NQTXFE?=
 =?utf-8?B?NHJkUmNUbFpJY1dNRmd4dERWcUhnMldvU2cxNlNpTmlTSGpVZ25nelpJbDNC?=
 =?utf-8?B?UWRJd2hMSjNyWU5NWGtKbmVKby9xVk1BbjB3YlAwek4wUU1ZSXU3a0owcUVO?=
 =?utf-8?B?TnFTVWZBZGdOdjFWV3BNN05RdkNkK082cWEvSEhScm80Z2RQWDNHVHFLUWti?=
 =?utf-8?B?dzdJbDh1eER2aHFSdnJ6d1plZzhrRitOSi83SmdWZHF6QXd1ZHY3OFRVSEV0?=
 =?utf-8?B?MmM0UnNmLy9SNnV4WlREL2JDYUJ4a1VQWEMzc2FxNzhHaG9iY1BxMkt0NG1o?=
 =?utf-8?B?OHZCc0dOQUNGeGlkTHlwMzNGQnlsQnlMbXhaVHRHYUgrQUNuY3YxcjArZlVY?=
 =?utf-8?B?aWZZd1IvZU1uRXE0cFBKRTlaQ3ptbVlSK3ZLdWFydzJ0bCttbVVKbTk0cWpZ?=
 =?utf-8?B?SitlcjBWVUpvM1pHZGRtQ2lZZXh1bHNNZHQxVmFWVXZPOGRyTEM4N2RpZEJE?=
 =?utf-8?B?Y2wzdU9pTVBGZUg5bTJLUEJ4dTFxa2dGZ3JoMkRYRW41NXA0QlViZWlYckw2?=
 =?utf-8?B?NFlpZnMyYVBiSnZrS05YNmdhS1h0QzIwMjJFOWR1NFhLamFxTURHY21GWS9r?=
 =?utf-8?B?Mmp2REM4elQ1bzB0SFBqMmZxLytrQXE0OElTVHRTcUpBc2h1SSsxek5NY2d0?=
 =?utf-8?B?VFU5dFhtVmZ5Mm50TVJpeHR5dmFyaThtdVdwTGNYVXpzN1Y4Z3AxTE9nL1g1?=
 =?utf-8?B?V1E4cE82QmExNGZ4VEs2cHp5TVJjSnArTWpwWGg3Q2J4TXFjbDNiUE5uR0ZR?=
 =?utf-8?B?K2tEQ3I2U0FIbGszUDE3M2tkVHM4RjhEZWJIOUp6Vm1JemF3UEFHR2hLZ1hN?=
 =?utf-8?B?OHdYK3VzSzh6a2YxTWZNd0xncU1wZjU5RDdyVGlaMEhOdXJacEZHaHlxV0Vx?=
 =?utf-8?B?aDFxVzFPbEd0aFJZWFpSQTlnMmZKcklmODQ4UDVJb01sYk9sQS92bGx0dmc4?=
 =?utf-8?B?azFkYTJPZzlpN3lSSzVsM1lhZlNtUnRMaHZoY2ZNcWxCUTVjWGFpRzJLVnBi?=
 =?utf-8?B?bHFibHNWOFZyQXV0Yy9aNnYyWEtZYU00a0RNY3ArbktLN0RuRnlvNGJGYTE0?=
 =?utf-8?B?NUJQYnQ0YWNLRG1HcGJwSnhITC9kRlN0VXRCRFhMNEI1L3VHNDFRNmtSZ0F2?=
 =?utf-8?B?VFhWWExnazIwaEY3anJqSVNJcUR4TFltWVdyaVdOL0lZNWdoZnQwS0ZzWlNz?=
 =?utf-8?B?VWFYU3RTMHNrQUlUakpvbkQ0cXVwOFhKdkJyaGwrVlkvQkdnRmJTQ3J6ZjhZ?=
 =?utf-8?B?aVA4ZTYzaG95TDVMaWdoeTdNNklTdlQ0bU0rN2RCN01kaVpIdTlpUU9mUVJh?=
 =?utf-8?B?c08zTHRuOUs1UGsxMGwxZmlZZk4yU29qNzBhOEVMRXNoSGtCcDZCQkhtMVQx?=
 =?utf-8?B?eHpMc1ZzM2ZPYW1LTER6UDdFTDF0Vmp3WGxxRFdzYnZqOUFCUlBadFdORUtN?=
 =?utf-8?B?SWJPSjFPV0FZQXRaY2k1bUZKTG5uNVliM1AwTytzWWRQWnoxRjZ3dGxPMVRP?=
 =?utf-8?Q?1+ShaLyu7jGCEiUWj/TnPNqfeGYY9lho?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WkthSEJPOWtBZ3g2ZFJ3OFJqcFI3Q2QrYTFjOU9McC9YbkZnWE1MRlh3WWFS?=
 =?utf-8?B?cWxqUWZWbUc1V1d3QVhxZlJIejNyL08wYVRZVkV3UWdmeW9IRE1abEtxQkZ3?=
 =?utf-8?B?aHFOVkVXdWlXMVMyWnc4RlFBRmdLTVByYWF0MUs2Ykp5YVMvY0ZrbG5qU2JX?=
 =?utf-8?B?Tm9uWlZ1aGt4aml4SnRRSFlYa1dkK1VrNEp2Ym11cVozU3Y4NHIwMllub2ti?=
 =?utf-8?B?R21YTjNvaTlUd05NN2prSWFpVFhUNkNMeGptYVp5U08zdm11RzFBMkxsMkdu?=
 =?utf-8?B?ajY0dTMvVkoreENYc2ZJY3hsRUtTcFE4VmJwSzQ4Und5VVB6TXRTZ0J6Y3ZP?=
 =?utf-8?B?U09MVWVLeVJQTEJ3TWRsb1BWaWF6aTlUVm1kaGVZTm9WYW9aOE8rNjJnd2tE?=
 =?utf-8?B?b2Q2WjM5TEVsaEZWM2xZMlN0ZDNpLytUZlpVOTVWdDFmSC9DM1JHUWprRW9X?=
 =?utf-8?B?R05BOE9XZFpyNEdSaGRqN2QwNVE5Q3o1SVNsV09kUEJkM3g1ZkN1SDMyZ2RC?=
 =?utf-8?B?aXNzN2ErZS9JdU5leUZTaDhUcE1nQzJPeDB3VVA3RWhnWWVyazhhQkJjTFZH?=
 =?utf-8?B?ZVE0NDhoSWR1RTM2RDNwMGRaNGhNSzV2WnEyU3g0bnE4T2FMRjZYOUlhVHN2?=
 =?utf-8?B?bzUvS2V2OGlpVHhwNWVGdnFPUEJuYzRadWRienIzMFFQSlloUmd4Q1VjOFBw?=
 =?utf-8?B?R2l5OU83T1VodDBiWGc2TmlxdWk2SUN0KzA4bTlqZzRGdm80ZUtpMVJ6WDFW?=
 =?utf-8?B?ZXJpQXRQWkh6UzhFRmNxeXNYbFE3MlpzY3VSSTJmUHNXN2FKekJsSkFwR3J6?=
 =?utf-8?B?OVpuZDhZODRzZlh4WUVUVVdEME9KNHE2MWluUCszZVV3SWlLam0rUTVZUFZM?=
 =?utf-8?B?WnVwamdEOFl2VEd1T0ZqV0x1a3c0Y1F6RlM3QnNNejFxZkQ1SFkvZHFaTzVD?=
 =?utf-8?B?ekRha2FpL3QrWlBCSURMQmNkOGp6ZHZ4R0lqLzg4ejBXNUVHdXc4cVk5a1Jk?=
 =?utf-8?B?cVR4cWR2Q2VTLzZMSHRteEE3TGcySjRIRXlDRXR2cHY4QURVbHBDcjZleUxM?=
 =?utf-8?B?ODlicVlFRWVTR3lSdWlpbFM3NXdqOTVldnZFUUJOWG9JcVUwU1pNTytIbm1y?=
 =?utf-8?B?R1ZKdzk2Y0dEWjA0VnNvNitCVjd6cnJmbkNQRmQ0V3Y0Skw0MStaNlRXZWJR?=
 =?utf-8?B?dDMvdDNpWnhBNURqZjIwZzNtTGxUSnZBOGJVd2hUMDBxVXIyVXVJTkNwejJW?=
 =?utf-8?B?OGdFMXp2dXVGUHNtZy9zSDN1czd0TkFsVGV2cFcxTzdLWGNnQWtYN0ZPOXFn?=
 =?utf-8?B?VnEzelJJUTNmSUVIV1lMamNRQjJOYXYvL2FyemMybXpneTlIMlFkVG9yNWdZ?=
 =?utf-8?B?Z2JoY2Eyc2MvbHE1dnZORWF5ckk4R2gzUlVFQkxHV1lGeWFtVmQyRUNaOWJn?=
 =?utf-8?B?aTg4TFd0V0hsZ1BVVlpEWjRkcEI3NnZ0Y1VNekdwK1dWT2pSUUx2WG1LU0Jl?=
 =?utf-8?B?azNwZUZ1V2JxUFVOZGZOUERnODd5K1lTajN1aFhYZEY1d0Nld1N2bVpLcmpI?=
 =?utf-8?B?YUM0b0FtVXRvNU9PbnFOV0FGNmJrb25NWjk0RnBEOFo1VEJxS2FUUHpxYTFu?=
 =?utf-8?B?Z0Q2aVhuR2RvamcrL2RLSHMwU0RMcElKaWhXNHVQQ3hPTGxpR1oyYzAxbHRV?=
 =?utf-8?B?Rk5GMEk4YmYwekdtRDBOS2FSODhzVENmK2NXN2lEbElUZlZ2NGlvQkJHU1E2?=
 =?utf-8?B?ekViUytZV2VmaFlDMzRpeEl1WCsySi9rb2taWkVPWmhmS3FOMHFZZUNQOHFt?=
 =?utf-8?B?N01pZmVIZFI4V0JIY0JiWWFoKzUrUElCT2wxK1NDc1hkaWxUTVJUWEVucWh1?=
 =?utf-8?B?UnhDMEI0bnl0bzZUR3M5b3JldFFEeXRPVVpLNVNDTlVXUWQvT0dzeVYvTm9z?=
 =?utf-8?B?T21qc2dmWmtGeU9jUytCeGxEa1dWN24rQ29SYldnZStidkhVNFk5RGxzRnVC?=
 =?utf-8?B?KzZ0TFkxaXJJQVBrek8vcEh5RVlGQ2F2dHV4eXc1dWxlZkVBRlJ1bGxBV1FK?=
 =?utf-8?B?M011RXdtSE0rakJDeUk5SE1hcE9GeGNZdWtRY0ZyMVREYmRzeWNLRGxLTnVU?=
 =?utf-8?B?MGNLKzZTdTdoS25MMitlVUlrM2dpNE9DL0puSEx5L3pIaWlrTDhZV2I0NU0v?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de1fd3dc-83b4-4e9f-0871-08de3d6195c2
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 11:44:06.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9eYkAf++Fq28vWSqleL+QI5M26tq+lk/cmL8DIrPi1eESROds1lsSNz9ng7fDTEhCxusMhU+Phml5fMUzP1LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR06MB8333
X-OriginatorOrg: vaisala.com

[resend, I think there was some problem with my first reply]

Hi,

On 17/12/2025 11:26, Nuno Sá wrote:
> On Tue, 2025-12-16 at 15:39 +0000, Tomas Melin wrote:
>> Hi,
>>
>> On 16/12/2025 14:56, Nuno Sá wrote:
>>> On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
>>>> Not all users can or want to use the device with an iio-backend.
>>>> For these users, let the driver work in standalone mode, not coupled
>>>> to the backend or the services it provides.
>>>>
>>>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>>>> ---
>>>
>>> Which users? The only usecases (for all the supported devices) we have require
>>> the FPGA backend. So do you have a specific usecase for a specific device? If so, I would
>>> prefer an explicit boolean in the chip_info struture for the device(s) we know this
>>> can happen (unless you have a usecase for all :)).
>>
>> This is generically for all the devices supported by the ad9467, not
>> only a specific device. So it's about how this is used as part of the
>> design.
>>
>> This is aimed at users that do not use the ADI HDL reference backend
>> with these devices, but instead have custom backends suited for their
>> own needs.
> 
> Hmm, ideally I would then like to see the backend driver upstreamed...

First of all, as I responded in another thread, there is certainly real
use case behind this, I would not be suggesting it otherwise.

Driver for custom backend would not be of any interest for mainline
kernel as the IP would not be publicly available. So nobody could really
use such a driver, nor would it be accepted. The default ADI backend is
 a different story, as it is available and documented.

> 
>> In that case, we need to be able to skip the backend registration and
>> register device as a standalone iio device.
>>
>> Hopefully this made the use case clearer?
>>
> 
> I mean, I don't love this and I'm not really sure I'm ok with it. These are fairly
> high speed devices which often do require an FPGA IP to handle the data flow. Now
> we can ignore the backend device (which is an essential piece) being it
> expected or not.
> 
> Or maybe we can just do something like regulators and get a dummy backend or just add
> some fixed kind of backend. Bottom line is, it still seems the backend device is a core
> piece in your design and we're just hacking around the driver in way that conceptually
> doesn't make sense to me.

I considered the idea of dummy backend, but in the end it doesn't make
much sense to me.
These ADCs can work perfectly fine with a minimalistic custom backend
that does exactly what the design needs, without the need for basically
any configuration. So the ADCs rely on some sort of backend, ofcourse,
but they are in the end standalone devices that can be integrated in
many ways, the adi backend being only one such option.

Another problem with a dummy backend is that for example calibration
cannot really work. It expects certain features from the backend to be
available, etc. Similarly would a custom backend connected need to
implemented exactly same test features as the backend now assumes.

> 
> Other question that comes to mind (I guess I was not that clear)... Do you have a real
> usecase with your own custom backend IP or is this just theoretical?

This dependency on the adi hdl has been causing me problems over the
years for a number of adi devices, and the iio-backend has been a step
in the right direction.
I hope we can take this further in direction that allows use cases that
were not expected from the beginning but are still valid.

Thanks,
Tomas

> 
> - Nuno Sá


