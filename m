Return-Path: <linux-iio+bounces-28035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EEFD3BFE1
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3475C3C321E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816FE3793D5;
	Tue, 20 Jan 2026 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="u+CmK1sP"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022096.outbound.protection.outlook.com [52.101.66.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5538B7CB;
	Tue, 20 Jan 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891577; cv=fail; b=Xtb3CpgxU8EJfUYICAn8Z7sf+nygkDtq2xJX1roHBgJReXiJGlI1fc4sA5RAjKgilpRebmAt2tKHcMAbxTR7n8hwUEURMHEypuvhGVpXnw+368iGHenhWEFnNew4CmqLoAie5MTDf09pKfe2CdrjO0LxoQkWNDFx+0ERs0yz4Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891577; c=relaxed/simple;
	bh=sfJeVUMivwQXYd61phMzIbH3tmPpSSbK0RjC/XSVSTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7BGRcUk912OS0cOFF3ccMsfog2CczHDKe4iUAusFRS1rpBPu6f4OUIJmPW80PjUjtyPYtHqR7r15zDXsptdGkWP7gRLTPXAvuecADtbk3uTpJDdezkSTSpVQjVnA1c0W7+kOQPnkOEe/jwEehEuzikhDe8DUKakpaj7YL/D250=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=u+CmK1sP; arc=fail smtp.client-ip=52.101.66.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0cTJCUo3DeIib4NU8R94IAGTIXLoKdTz0/EeJPfbzuos7Xrm4vtb1Dhbl/RIQ/Jlg6/w/3LJZE5y+PMC6exwruEh8kBdyt9J7zQrTmz7wdxwEVosh1pF1yBzZ/A6qn9pr20JqEwnvX37dJ9lNpi+KtILhAwVymDV3zJZqBN2GCao1E7qK78QPbeJwXfuNHz8cAsOW3zZnl3bXore6XwaYa9eLqTA3Q9th6FUxjnVPAjEIFIT5stNquV50ScQmbtru3MePap7AwAWWK62HfQVmEoOYzmn4fH2TlLlBV5C7M8ENpn5YjXRogXmv3lCSm5DqBFQaZohUicJSJAxwM3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GLP3gJh+cgmpMbIfNTsiNCpYXCIkIkmmsiW61AjWEM=;
 b=eErcfTuTka8eJbSeTmUvoIix99DII4/XZhPOT0TawqNE5fW6sujrmmaLqQ6OGvZXD9RInBxf967KLsvTr+77As8LcuXLFqaIJa9RKy24btLAqAOvSwUDStkf/YwFgemczPI6ZVwkp40mCegw16p6N7R/6y7ERbtnehijeT6n7bhletPolSGDnQaJgdeIlgPmSP6M+POS5kFay21Gqd4nnMY1Dbs3S3VwC4/IellAwI2X6Oe0LylCjRLiopuYo3sKnwN3HnHX8SNTQ5kVwiYSCd9D3YFmK4jaGRDPCqh0XnMx4qBhHyA1SDL67y9vZjgTZ93jo9uNkW1+sMUxYofuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GLP3gJh+cgmpMbIfNTsiNCpYXCIkIkmmsiW61AjWEM=;
 b=u+CmK1sPJJMuq0URwmoiIKDur8rulzNUPBfkqY+4zqhgn6ZDLyMoIJSq+r8Bfmb9hX6W65R/zQSdNA8zCJ/SidD8trdq2t6CEBd7fbTrGJKEwjAcRhLgeOBHhBD5FMbEl7bfarfrDX7/V9pVtr9aJ1ZFbox87IM20lbWQ6Tcx9MjpWN28rrFr12cRWu9xl+F5lKNPUomDH5RmYXbwFW7qVf5KR4EmPobiPAS8GiPbqIfVtjTLmWMqNhqQNjmXNU1HvUMyMv5BSgqN/dtt1XCIL3zEnGTJBGIgvStevlizllPT7lAvPdlTTU2MNLyAAypvRL5UIXLkNgdVONTxV2EpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by MRWPR06MB10137.eurprd06.prod.outlook.com (2603:10a6:501:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 20 Jan
 2026 06:46:00 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 06:45:59 +0000
Message-ID: <f8fbb23a-b197-46dc-b32d-10c37434c67c@vaisala.com>
Date: Tue, 20 Jan 2026 08:45:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
 <fda7d715e2cab2545c9ecdeead22d8a58ae5032d.camel@gmail.com>
 <1f431375-f2cb-49a7-a0bd-6c00273a3c92@vaisala.com>
 <69c4bf5a-e081-4660-a4ef-a92e9b081b41@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <69c4bf5a-e081-4660-a4ef-a92e9b081b41@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00014AEF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::31d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|MRWPR06MB10137:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db51ee7-21d1-4956-1e31-08de57ef9256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djVWZDNGei9VNXhEc2V4aEgwOHVUaHVjL2srTGU3QU1JRWt6SWxraXlGMEMx?=
 =?utf-8?B?Yk02aHhreU5kcnVvNU9hcnlrcVpuUjJNV2lyL09JMVlRRDhqM1NLb2VFVk9H?=
 =?utf-8?B?Yk5pTmhIWUttaExCYmVKSUt6MHYxeG1GMmh1c0VkTVZ0dmhxNEtKUk03MWJY?=
 =?utf-8?B?c0pkdEI1MFNhT3A3ejY2cHJET2o1bGUyNCtaMXJzWitNNjc0WTBKa21odjZm?=
 =?utf-8?B?aWF6Q0pYMWd6RGF4dEtUc0l0NTk5U0NkNHFvSGNHK2FNTW1PZi9OWmF6emJy?=
 =?utf-8?B?eTJiaW5peVBEaDJ2VEpScnJ0NGVNYnR5Nm90UHJVY1crWEYyZHhkTGFOVHZI?=
 =?utf-8?B?YmRUbzREYmcvZ3Z5QjJjc3AzTUh3ditMb0FGWkYyWHBxUXVKOUFVUzQ5ZVh6?=
 =?utf-8?B?cU9UaE1pMG1PeUVRNXJHc0dKZ2VWMDE0WmlEbkxoeU1KKzF0WGNSMGU5b2hX?=
 =?utf-8?B?RS9GY0JJOUFjRGZjYU5CQ0xpYkxleGozSXlIMUZDTWN0eVdpNVBIdUVwRm1E?=
 =?utf-8?B?bGs3bEM5YlVBZm8zY0lQMTlhMkpJUEVHaUlWY2NvdGVEaXBwc0N5bllmN3ZJ?=
 =?utf-8?B?UG9NU3F2dGo4WWo4Q1ArZUJOSFdZZzMwTmIxM0FrUkVzQStDN1BLVXdrczI2?=
 =?utf-8?B?NWJzR3hrUzFLQ2NGNG9BalJjcnFsSll0WWsxLzhNc2Z2dmdIbHlmYnZXT2xL?=
 =?utf-8?B?SERweWdoekF2T21IM0hycFVJZjFraERYK0FlSHczQ21hQlN0OVJRaHZLeE1j?=
 =?utf-8?B?Q3lObTdEYTRSRTJ2VzMvMExna2JoaVJibmg1bTBucU5YcHF1TDR3aTUrS2hz?=
 =?utf-8?B?WkMrdGN6TkdNTEtkVk5JdHYrMHY4TFRFZmpYeWF2a3VJU3ZDWUhuY3Uwa2s2?=
 =?utf-8?B?TVg3YXFRUlZRaEd3ODZEblYxR25oRm1QeWpKQTBkeVNUWXZpRXlieHdaa0hn?=
 =?utf-8?B?V1VyS1hYVmhoUEVGVkRHNjJrNWtRbUgrR2Nxb25IZ2NIRENUMDFLVko2NTZh?=
 =?utf-8?B?SzVOZ05SbjM1S09sMUNnMW9mYzRXajVDQnRNSUxDVEl2cW1FczMxUWYwbE1Z?=
 =?utf-8?B?WDl4ZENjZkJGWXNHVkgxcDhsNkVpaE1LU2g3QlFxMFpPbnc3RndtV1JDNnBG?=
 =?utf-8?B?NUNHYStLeUF4V0sxSlY3NkhYcnYyTk1HOEZDbGJHRys1WjNyMTFxOTJ0TFRM?=
 =?utf-8?B?S2xBL0ROenhXNDMvTmMrSExpR1dZTitoeHQvU1RybTJXcWJYNThYRFFZVFhI?=
 =?utf-8?B?K3lmaVhieDQvWjRmREUxYlEvYjRXS3ZTNGo2Mm12a1V5Y2V4ZUZnd1JHRDRH?=
 =?utf-8?B?a2MvWllPNEIzdVRQaVVzY1pTUXpNRlRhb244NzFuOUE2bEJKeTJQOE8xRU53?=
 =?utf-8?B?TnZZbGFWemVXcEUzbWcybVpaa3h1M0VHUnJlbERkOW9QaTRuZHNITUpXVHlm?=
 =?utf-8?B?c2N1ZmkrUWx3dUZKdmExK09Qa1pzdkxiUEExUStKS3BiVUJnb2VJb0lDb21Q?=
 =?utf-8?B?VmU3OGdnb2xVdzY2aEpWeEUrTjV5d3JrNTE3eHVuOHNSSC81Nlk1emJ4V1Vj?=
 =?utf-8?B?V0JpMDFQMTNNM0JMbWlra3k2SGhZRWVSQ0lBSEE3MGdyTTdIUWcxWDBZUHVL?=
 =?utf-8?B?QUFZSS9QSGh6U0pGQkg0cTNycXc2OERFdmNOb2tjSEhHWndNMVhYWkpwZTBI?=
 =?utf-8?B?MGlFTEQvUzBuc2RWc3JWUVJFeHhNWjUvUWJwNnZvTWpzYjl5TWFpTmNsNHZh?=
 =?utf-8?B?RXBRcll6K2E1NlJNbGJmV0tVOWlXb0VIUXRlY3Mrd2RJRWtsY3M4NHJrM3pB?=
 =?utf-8?B?UzdpVnNPbmc5ZFNWNFg1RHBXWGo2aTBxcFJzdm5BcE1ramdtblFFZnJ0N2hy?=
 =?utf-8?B?Q2tKQVMrK052b3lHN3ZnVUJiaGdKNkpIRVQ3Zk9BZUlBdXUydXRwakttYjUw?=
 =?utf-8?B?YXNFU3NlbzZ5NUltNm9TbnArbnVFZmp6MlRaamg4d1A4dmVNK0Y3SDBlb1dL?=
 =?utf-8?B?U1l4OUJuU1BQUzEyOTYvT09ZaVRZSWZUcUd4ejF4dE51MkU4NTN0NWtleS9o?=
 =?utf-8?B?WDlRekVTRmRYbldTMlpBY3ZtMWY0clF2ZnpjVmkzZlAzMEpqdXZBa2RBaU93?=
 =?utf-8?Q?pJ8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2ZPaEIrNm5nYUd3R2tGdlBwb0djc0RaTXhaWmFtdEFXZm9aL0lXMndXUEFl?=
 =?utf-8?B?c3lPR21JRFlSZ3g5N1dmWThmcFpTeEllUVJVaEFYbWpySFpUaU5JTDBYc25P?=
 =?utf-8?B?YWJYMXl1c01sZTIyT2l4SkVGcDZCMXlKNTI0S2ZoL1NQOXVuaWFxcDVYL3RQ?=
 =?utf-8?B?Z09venBPVks3d3pnRCt1WjJhK2NKd2tXVUcybWpCYjVWMS85RFRZeDdHWkg0?=
 =?utf-8?B?YWJNQmN2bVJ3UWxqL29PdEtxNkdwS1J2c29WVEFVWFVTMExBazhVeTZtRVVK?=
 =?utf-8?B?WmtjTldlWHdzL2dSN254MW1QaTlITE5kZk5TR0lOam5OUlFSUkVIWDRNRlBz?=
 =?utf-8?B?WHdDQkszMUJlK0VmcVZjWWxFV211ZCtwT1lrTE9NZDFMdVI2UHRiWHEzVzNS?=
 =?utf-8?B?U25hbG02M0Z1VmJOT3loWjlKVCtHN2VVeUMwbGJEV3Y2Z0cwSDVCNksreS84?=
 =?utf-8?B?cTdSV1R5QTBYZG1XTStDNVZJYi95UnVJZFI0d0REdk1oWmV4dFJTU3VLTUN1?=
 =?utf-8?B?Wk5UOHkzWVdOTHNDTWl2OUZZeGFmeWJrV05zSlRmTCtPTEl0V2dTTXdoRFhz?=
 =?utf-8?B?SXFyLzdtdTdrV1dvRGNSMHJSZXo2M1hMcjdYOTExRi9wTXZxKzBQVGRaUFFl?=
 =?utf-8?B?bjNmSlpUaEJpVU1EbENHVzZ0RWduQ1VTM1Y0SjUvRnYyTlkyYTZCOUY5WlYv?=
 =?utf-8?B?UTZxdkJjeHJENmZGVCs4Znd3VVh4SGFJWVJNcElkSWpkVVArNUNPMkhDdmwy?=
 =?utf-8?B?dFFrYS9NcWZpNm9FK3RjSXR0VTVJSExWOWdmaEZ0Q1NEWTB3NUF5ZlhsWnlx?=
 =?utf-8?B?dW1zTEhQSlZZV1VweXhUZTJpNEFUQlY2eEpUYnoyV0hoOUtjUVFOVXp5ak9R?=
 =?utf-8?B?RG1ia1hZT3RYWldYZ0hOWEpqWmt0RjRzRWRlZ1BVTE8rZ0tkdHE0emVmYUhs?=
 =?utf-8?B?cWU0YTQ1NndiZ1B2UTJZN09jeXpHd1RadjZrZFl1blBoT3c0ZzJlMEN1R05y?=
 =?utf-8?B?WWc3M0FDZnF0RXEwZWpVMWpXY0tjTnl1c2NKTDEzTXIwcUN0WVFCNFNEam0v?=
 =?utf-8?B?TjZMRXlMdHk3RWlSQzVWaldVSHpCcW9nQ0lLc2xpZzg4N21DTzJKS2E0M1B1?=
 =?utf-8?B?cyt4RG5KT3k0QU5nVHpucW9sTFBYV1dNQUxGRE1DenRYVHZqSnd0bXFkWDhG?=
 =?utf-8?B?dk1KL0Q5UTFsYStSK2dpbzkyMmorSkpoWEhwNFdNYmg3YTc5ZUFCQ1N4MmVH?=
 =?utf-8?B?aEZQMkFWNmt3Yi9TSEo3V3F3a1dQSEZwOGlsaVlUeGQ0cys3Lzk2a3plMHZr?=
 =?utf-8?B?cmFGa1RNY3ZLb0xsUTZhbFdvQllWa0x4ZFRuYmdJVXlqdFI0ajZ0Vm41THpP?=
 =?utf-8?B?VS8vYlBkK0pLMnFLMzVYdmJuUDFLcmd1blhrOG14WnpOdkR0YS9ib1BRTitL?=
 =?utf-8?B?a0swT2JQTnVxSW9ESjdWK1B3RHNMQmNmZHlYOG5WSjVBSk80N2tRK0ZMYmg3?=
 =?utf-8?B?VDc2UmxHQlJ2WlBTT2MyOHFudDFKc2ZaTU1hbXlSOXhaUUhyQVFEbG4vN3Jp?=
 =?utf-8?B?cHVFcU9NbWFxK2ZuU2VJV1MxVmY3V0dhYzJFNUxTWnNXc0o3M2VDR1RMcVFY?=
 =?utf-8?B?a1dpN0s3amhJelduQjBOb1Y4cVlsaXFJUC9XK056VzZEK0F3R2o2OUhWRUFO?=
 =?utf-8?B?M2ZONWdIR3ZLaDRaSE5GZnhPM2JUWDRZSWx3cUxEZlladmxDaGVSaTNvczdL?=
 =?utf-8?B?TUlFTk0zOHRwNmVlcFg2RmRyYm5KeHAwcnpuK2wzcG9ueHplblAyZ044Zy8r?=
 =?utf-8?B?OThXd3J0YkRaZGFoU3ZHWVBSSGJRdjQ3MVBValVVeVBGTGZnWWhiWjFQeXha?=
 =?utf-8?B?Z2JQb3JCT3BEWE9QTlNWVUVtRkxZR2dIMm5aN2VOS1lMUnlDNzI0WHp0cXEy?=
 =?utf-8?B?dG9nUjRBWGRiVkZ3Q2RGZnNYOUNkQjdoL0pYSkRWdkRwNnY3VE9XK1gxYnNn?=
 =?utf-8?B?YmJTaURObkNUM0VLclpLZkFPMDVVVHNEUVdnN20yaFNUZ25lS2dDMk5BM0pN?=
 =?utf-8?B?bmJQTFVGWWRVekkxTEt2ajJjRGZLVEVSZnFhbzhGVUEyd0ZRWUhPVGVBT0xq?=
 =?utf-8?B?b2RORkFuU0JsZ2plaUVrRGczb21mNVlqb0xBNG5sclU2aWliR05waDdKVWI2?=
 =?utf-8?B?RHdxUVVIMnhub3QyQnhydkU0TmpReVhTc0RYY01jTzlvZlpTYnZXaXAzbnJz?=
 =?utf-8?B?YmlweE52ZkdYOFMwVkhRTXlDdVFoZzQxRm1jOXR3R1FxNVBKNEkwSS8vNDZh?=
 =?utf-8?B?eXltNHV5b3Noc0sxc0hmTHF3MHVubkVtbUtqM3pkZjFSOS9veUJ3d0VEWG5i?=
 =?utf-8?Q?xRYUErr4s+G0zm7U=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db51ee7-21d1-4956-1e31-08de57ef9256
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:45:59.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0i5+LrjBmn4OukCudSOePOQfdgA2fpp59K8mXe/I4anBA2d0tPSX7r1v0li0J9jZARgyKWM8k8jfjHnHXIOzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR06MB10137

Hi,

On 19/01/2026 17:00, David Lechner wrote:
> On 1/19/26 7:49 AM, Tomas Melin wrote:
> 
> ...
> 
>>>>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
>>>> @@ -235,6 +251,7 @@ int iio_backend_read_raw(struct iio_backend *back,
>>>>  			 long mask);
>>>>  int iio_backend_extend_chan_spec(struct iio_backend *back,
>>>>  				 struct iio_chan_spec *chan);
>>>> +int iio_backend_has_caps(struct iio_backend *back, u32 caps);
>>>
>>> Not what David suggested and I do agree with him FWIW.
>> AFAIU this was exactly what was suggested. Citing:
> 
> Slight difference. Should return bool instead of int.
Yes absolutely, perhaps it was about the signature. That is on the
change list for next version.

Thanks,
Tomas

> 
>>
>>>> bool iio_backend_has_capabilities(struct iio_backend *back, u32 flags)
>>>> (caps is fine too if we want to keep it short)
>>
>> Using the longer format is not very practical. Can we keep it as
>> iio_backend_has_caps ?
> 
> Yes, I said as much already. But I guess you are asking Nuno. ;-)


