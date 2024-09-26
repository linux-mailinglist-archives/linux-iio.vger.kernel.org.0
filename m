Return-Path: <linux-iio+bounces-9783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C734986F84
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 11:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FB3283A18
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B21AB52A;
	Thu, 26 Sep 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ze/CLS7P"
X-Original-To: linux-iio@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2051.outbound.protection.outlook.com [40.107.117.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7D208CA;
	Thu, 26 Sep 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341452; cv=fail; b=ulBBuyNZPVH/A5Wi4o7PyJN2DwX6rUMJCVaR+wEyrwDorBt1i0QXM0wlURZhy8s1uQDdMjJEXIN4dcDIZTfMCMdZDWkMI6s2+j1HJRFLww+EhDHfAdCf4W6aIEC5BEZRNC7a5G0Pn2rHcJsDeNN4R/JtBsruzwH/DrVJgE2xzqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341452; c=relaxed/simple;
	bh=yr3fZhLd36i3fF9MYVSoyxk7WlRm4P7kca8PHCK6vNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bZzKzLZZInyCccm/tS5ydviM6uXVlAwYCM4b/t+AwTKhXml39y7QW8eVW8OFgnaA2aWkQlbhp/6tfcIeMsE67ZoH3b8DwTyUFWhMxuHWhBr7S/A3fRw5rtIet8psrz0AxDe6I97uNEPuchmIcpKfQ4NypanB2M6UCN1wD9lMmOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ze/CLS7P; arc=fail smtp.client-ip=40.107.117.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bycC7DWNXLr1KQzUtyfDhLIFhgxA3BXKBbmq12JE+AmM7eC91X4hqh5PwAulqYcAw+d8b2rQBrJihDuJWetUogOoGGqmiyCd0ecX2wur8qD+g0d6T4zeEicbSW8MbOItSIK59seI1oAMRGUElvN8b3Go/NIhnicRR5HuYsiAB3UlZGXhiR1hIFzXNbDmvtTotYV7w2bSemGphhQ7S5BC3Ue9di9ZVk8T6KzzbJHduho2dx4bgoq86TTimy/aK5rCQQMBZGaJZYcD5V1w0Gw+QUuu94kshWkz4T4DsbPY5F/PB3rvcVXilToDZ2/EZtI4ZM49wPv+vAy0ApdMadimkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPeSy7xEMrEnWppOC+tY4YRCuvLmFj/eEpfj4VKggT4=;
 b=i1Bppb0P1q7PtvJptBKdH377OJrZ4mBTXvoShp/Qd6L6XxuPM+ppN+jPVLh/CxsT/oigqjkPOR4trpF2YcENYeoeJexlgj3gckz7iDRssjb0+IVA1lGMjjisTBBVkCgJMrqDsYgrjslt3d9o1NS73By7zjhveX4ZheTQCVpqI/rNvdImCNWp79eVqUyojoPYfwIbrOHyxfpqET2E6rRGG6mrajgGCS4Wd1KpWksqhuUiDV3Pj//qiTZrZFNTy9sTC5IhJk6OXonHzR22yS64PWV9JPzFh3+8SknHyFQ1pMtsgfjYS4Qjp+qHsjRxt24kZyk5O1fPMASloc7oN/ZD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPeSy7xEMrEnWppOC+tY4YRCuvLmFj/eEpfj4VKggT4=;
 b=Ze/CLS7PZVD5ZFe+9o4um4Bq5XBh0mTP3mCRKXdfeYK6MwVrjcp+b4U+yWK5nFcpG2SIx4P0EPVWgfr23+5HBGYOlQYdxWyK5o6ctyBp+dlw9orgkxxuzuq13lVrPcN8rsbzaIHBCEkPex9ya6AelVaLMW+SqbIr8iayhihQ6Rye1iN9Vuj767a57HMhMF4DmKxLDtMyf8L5j+nfe58YWPhf2cwnJx8MryratG0HF30ZLD9sCML2dfp930oA8BLYcsJ8FHyg66l7u5+6Lqjkj3JuRH3LjHgGIfr/8QmNc3kJDQhGAGs4MwNWEIuPbVzK5gaYewvfQXnjpQVdfTBzlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by KL1PR06MB6260.apcprd06.prod.outlook.com (2603:1096:820:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 09:04:07 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 09:04:07 +0000
Message-ID: <5d896b89-1f81-40b7-b2b7-a2867b4a8129@vivo.com>
Date: Thu, 26 Sep 2024 17:03:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iio: adc: Fix typos in comments across various files
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Dan Carpenter <dan.carpenter@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 Richard Leitner <richard.leitner@linux.dev>, Stephen Boyd
 <sboyd@kernel.org>, Wadim Egorov <w.egorov@phytec.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
References: <20240926034411.3482986-1-yujiaoliang@vivo.com>
 <20240926101940.22bbc3fe@booty>
From: Yu Jiaoliang <11172850@vivo.com>
In-Reply-To: <20240926101940.22bbc3fe@booty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:404::16)
 To TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|KL1PR06MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: bb25e1c8-2561-4b61-6452-08dcde0a2d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXE3UDNDVE50YXhWc3R3bllXaVdhdk9JeXRsL1Ira2FhVDhFOHJuMWNtNjdP?=
 =?utf-8?B?T2pBNVFFUWFReVZUcGpjUEloK1oxd1hyZXdJbGhrYVMrL1VjZkFmUXNITkpv?=
 =?utf-8?B?UHVVVU5IY0tEOHNpT3NsUHBqVzhzQ0dKSGdoWnRrNTVIcHl0YnBuOGxDYm9N?=
 =?utf-8?B?NDRNK2pybXF6ZFhxQ1AzTVdSYmtJRzV4Zk44NHlaTzFmQWttaGh4WHJaRGhs?=
 =?utf-8?B?TERsQnNYanpHTjBYM0NhR2dBeGo4L0VGRzdzMVVxdmozNUhoNnp1enRHZXZE?=
 =?utf-8?B?cndvb1BLVU5CUGh6eDdOc3N4aDBoNEZWVGJBUlhtWnVlR0NLd2lnREZXR0V6?=
 =?utf-8?B?emIzN2Y2V2lOWTgvWFFvL0lHalpidTVRSVFIQkVVZDIzT3FrT2duK1QxNmJL?=
 =?utf-8?B?ajNxVnAzN0gwZFpiODdDekQ1bWxnQTMxTW5EWnVXb1FveDgrUCtlcFppazQ2?=
 =?utf-8?B?OTI2VDkwRUV0STM2cmRCSXRXd0dSZ1g4ZjFMOTBXdGd4N0xyeDd4RnAyV1ds?=
 =?utf-8?B?eXdMT1B1V2pKRzZZNnEyQ0RPSytsRmdaNVR1N2xsWG53SjhDZGFJajUzOWE3?=
 =?utf-8?B?SG0zV0ZuZnllbHVBN2lmN2lwbndaalBzRHVNQ29zV1V5RDlqek15c0xjQzIz?=
 =?utf-8?B?Y2Zwc083TkF0S2FPdnQ2MmxtdjU1WHpNb0ZycU5mRUNkbmxqdCtoNVZRTjBk?=
 =?utf-8?B?dXhKSmJBQlhpcVVscU5FOVdwTDA4a0J4dm50ZFJENE1nSFVDbmFNRWNiTlRQ?=
 =?utf-8?B?NUI3dW5tRDV2WUQvaVhnSjB5ZEZkWVl0SkpVQU4rOWJJd1hacENSVDl3ZVFD?=
 =?utf-8?B?aDBYVTVtdkRES0ZZYXd1cktobXF2aWVCMlhqVFhZZTBDVm15S1lpUGozTndk?=
 =?utf-8?B?VDE3RVRuK3ZYdnMrVkt1RVNNbG1nSW5wMXVYRWpiVjM2aFhIRXdZUzB4TGs3?=
 =?utf-8?B?ZTUyNVVqYWR5M0ppL2JVQit2a1E0ZzBjYlQ4cUR6c29SQTE0YVcrU0lUZURP?=
 =?utf-8?B?d3VpWjFGWWl0WW9Lc0NqWllIR1ppbVc0bXR1UUh4V09uWHlCL1hTL05yMzRt?=
 =?utf-8?B?TVpqNG1JV0I0Z21iN1NMb2JIRE9yYUxQRE0xNjFKd2VYLzMrYm9qeGlPankv?=
 =?utf-8?B?T3g1cnZwbE1ZSHl2Mkhjb0FLYWRLLytYUVdYcGJFdmQ0SmZTYlNZcTliWU9T?=
 =?utf-8?B?N3RKVm9iTVNwTDB0OW4wa3ZYR3BoSFF0dklPQ0E4b1NQSkp3bjkweENVSmpp?=
 =?utf-8?B?am1WTkZzcHlOUVp3KzBOQkNGWDU1dHc3QU9wZ2FqQWJUVXJzRG0rMWltL0x5?=
 =?utf-8?B?N2ZjTzRVbWtxaXdBdnM2a0tmY2tOYjFTOXpYNXd6alV3VG1ZWGV5akRpR3h1?=
 =?utf-8?B?S3ROSFVZQXQvc3JWbkNjVUl1NUMyTURCWnQrY245dUQ1MGFwWlJOV0lOdWRn?=
 =?utf-8?B?ZndJZWJJaEhwd1lmaU9rYmJnczI4bG9aVHlEalN2c3FDYzlkVDFoU3JQUEU3?=
 =?utf-8?B?elduUFFKK09VT2VrV2M1WGNMK2ZGUzVUQlBXV3VBRi8vZlhsa2xTeE5HcVFh?=
 =?utf-8?B?emZITHdaYy95K1JFVzlicXE0N2NkaVR4VWtzSlJWRisrM21FaExyanVKK1Va?=
 =?utf-8?B?cXB4SkFXSkpid1JrL1pFVVlpbG1lTEgwM2JYVm44bVRGSVMwN2M3cUxtMWxX?=
 =?utf-8?B?L2s0SlQySTliMURDenU2ekgrN2E2SklDdmF0RGNOMkVUR3cwendoMCtDcFB0?=
 =?utf-8?B?aWE3QTlqSVFIS1UzVSt6R0wwREx4YlQ1cDRlTTU2Y1F2VHUrcGs1eFJjZmJY?=
 =?utf-8?B?aXlDN3lIdXU1MGwxSDhMdjFqdTZFRzhSRHluYmNFRDZwTllqMmZDVTlJODRz?=
 =?utf-8?B?SkxGeDJKSStHdjVkYkNhMWlVRHNQdGRPMFBXM20vcTVFaVhSYXlZK3h6SHVo?=
 =?utf-8?Q?Q3B70jRnROE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDRqemN0SUUrOEFJU0lSeSttbnZFR0hYY0hTUWcvQ0poUkIyNng2YkEzaUNn?=
 =?utf-8?B?SU55Q1ZNb3BhU2tXbkRKeDNkQzM4ZkdOTFJzeTFHQnNjcXFnNnpuZzZCWUo2?=
 =?utf-8?B?NTBhT3RlUnNRZk1veUxIVzZmdjFrcm9mdVpQV2Jka0VPSnR4R01BeVlzM3FN?=
 =?utf-8?B?RXFOd1ZnalM5OElZY2Rlb1N0amJtb0Z2dEtNMkE0ZHdRbFlTbDFEUjNSUm52?=
 =?utf-8?B?ZnQ0eU9JVVFQRnRrYVhycFNGa1BOYkNVZWJyVStMc3pDZEFPQm5VV0tvdE1C?=
 =?utf-8?B?U25oQjdJcXJLRnVqTUN6VW9CNDdNS0owWWRxSDl6SWorNXAxWEZUWUlNdHAv?=
 =?utf-8?B?WEFlVUdxT2Z0MTE4cDgyMWE5MTBjL0FCSnpYeUpNMlNqRkUzQU50Z2gzRTJ1?=
 =?utf-8?B?UDVsVEl1RlRLUDNFbmVrRC9ndHJ2ZVFTZ3NxR3htVElZU1JkQWdGMmtOdnlO?=
 =?utf-8?B?a1c3aTNCb0dod3I0Y1hkRjlyR3VVYXY0Q1l6QXFwN0pYVXBPbVRxRlh2cTFY?=
 =?utf-8?B?TTF5blZ6S0MxT3dmcWV2Y1ljWk1ZcnZ3YlVSNmJmWnY3c2RTRDA5SXJPVjk1?=
 =?utf-8?B?NlRhSlVpcVdFNm1GamxIQWVseFE0OHFBMWYweGVYODY0Z2t1NSsraHpzQUVl?=
 =?utf-8?B?MEJZNzUvN2pjelRtdzg2aVphUUMrSG9uZnBacXM3bXYxZWpqVnk1OTNDcElB?=
 =?utf-8?B?a0tzd05UNWkyUEpWZFBKWWg5akVGdGNQd1dPVjZSMUx3TUdxdmRHSFY4VDZt?=
 =?utf-8?B?TEZHeUlPbnBRdHlvb0VteUwzWEtmdEtBbTRTL0hla3hVZmNBSDc2Y29mTFhx?=
 =?utf-8?B?eVZXSnh2K3B1MEIyV2NJYjY5QWp6S0V1YThRTmNENDlnNTkwajl0Z1p5QUxK?=
 =?utf-8?B?akRHRW5aZUMzZGd5ZXBLNmtBTEJzb0UvQUUwS3pJVmV4blJyUG10TkNtWnZS?=
 =?utf-8?B?cXAwVEx2Z0dFdk52T0cyRGl3SGUzbzJqZElyNFhlSW5OaW9QeDNTR1ZKMHRm?=
 =?utf-8?B?ckxoc01GZjZTUVBOZjFacmYwUi9oNWVlNExnOEo4ZUdiUnB1UitSUXQwT1VQ?=
 =?utf-8?B?a0t1MkZ0K1VCN0RDclRkbFRzRDErQ0pwOFFtaFV4SDZrMk1WZkR5Z1I0QWhx?=
 =?utf-8?B?Y3ZlQW9DQ01TQ2R3ampYUUUrODFHVk5vUndrYTRqNDZxSkR6Q3RIU0V6c1dP?=
 =?utf-8?B?bXJCL2N6S0dvTHRlRnE3eHhZZ1IweGJMaUcyRUdWdHVKR1Ywd3o3SU93cUtS?=
 =?utf-8?B?a0NWMUNlaHlzSGdnMElJbjJUL0JrZlNTY2NZOXp3c3FmSWcwMkNjWjVndk1n?=
 =?utf-8?B?L2lxSHVaTmxSV1ZCeTFyMnA0UFVENXJpM1FXYkxlNSthczE3Tm1ORXkvN2xP?=
 =?utf-8?B?TzhlWExRRGF5ZWphd3B4Y1ZVa21WaWh0U0YzOEpmY0hxK1BOUTNDQUtKMWZl?=
 =?utf-8?B?QU5HWCt0c1FxN3hxSTNwV1NXMmZjdjNXRGNrZzZQZzhuTEJFa2toUm5LVlRn?=
 =?utf-8?B?M0owMitLb3Eya0REUkdzRTJCVGZhei85WStVK3h4c2d2bDhaYW5oNGlYN2ZB?=
 =?utf-8?B?bW9zajdveHUrOGUvc3had3pSeDRmMERQeE5UOFF3OFNlSldNR21QbWc4NEdO?=
 =?utf-8?B?MHNXYVMvT0lrcmJ1WXFUemh0RzJiMjhNejlnbXZuRWJpOXdPQjZRWklZbUJr?=
 =?utf-8?B?WjBmcW00cGRTOW85cGt1Rk1EN0xyVCtmQjBEdDFBZXBTOXRHL1pGKzlVOEgz?=
 =?utf-8?B?VHpWbXBKVXU4UEppMVk1ZUJmSGhRY0VLWVgxZGZPaE8yWnVLMGRRWTBNUlp5?=
 =?utf-8?B?WWIvNkl6TGc4blJwNHRPajJiYnBjcFhUQzNPbkdDalVieEZWN3drelEwSkhl?=
 =?utf-8?B?YWROQmFwWTNkWnpEZDBoUWtVV2hvNVZnTEQzc2VuOC9OWkY2ajFJNWFCc1Jy?=
 =?utf-8?B?enFwNzlUQ0JDeUF4VHZnUHFwQXlVZ2xEYXUxSnBZU0QwYUhOUFdjS1l3ek0v?=
 =?utf-8?B?YXVpNk9OZkZhOG5MYWN2cURoU1RIZHhHNXcvUU8wRW5vZHdLRm9wZkM5NHVl?=
 =?utf-8?B?WHhncFM0R2RCUlFhbVZnR01qVWFXcmZTMDdmeUY4T3pNUUFsVkNGNnBDa2F4?=
 =?utf-8?Q?1KTg3u0Ms9PzLEowU1gS5r776?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb25e1c8-2561-4b61-6452-08dcde0a2d80
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:04:07.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T/bYngJB0mPmVP9ysFVcl1vB7X2/s1SdzYTs+HuNI6dVL8bsyxlyUh3GD9+yvQw16UeV19+5FLOTNzM/z8l2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6260


在 2024/9/26 16:19, Luca Ceresoli 写道:
> Hello Yu,
>
> On Thu, 26 Sep 2024 11:43:54 +0800
> Yu Jiaoliang <yujiaoliang@vivo.com> wrote:
>
>> This commit fixes several typographical errors in comments within
>> the drivers/iio/adc directory. No functional changes are made.
> I think it would be useful to add those typo patterns to
> scripts/spelling.txt, so checkpatch.pl will check them, preventing the
> same typos from happening in the future.
>
> With that added (perhaps in a separate patch), looks good.

Hi Luca,

Thanks for the suggestion. I'll prepare a new patch that collects the 
typos we've encountered so far and adds them to |scripts/spelling.txt|.

>
> Luca

Best regards,
Yu


