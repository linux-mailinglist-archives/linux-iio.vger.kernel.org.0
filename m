Return-Path: <linux-iio+bounces-10988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E1E9ACDA2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D691C25859
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490011F5848;
	Wed, 23 Oct 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BCdZj1Cw"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4E1F4732;
	Wed, 23 Oct 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694638; cv=fail; b=nnu5Xojce/fDZk95O1qVHW8UmEv1+yPgI4AIfQQieusqzwO1Qt9bnKFHkvm0rlcS772m73Fb39fZI1lgT9Skq8TjTx5H6HzluCxi7URKFEbwIX7vREu8D6qkazLcoQHqNLrFkAYcgsa42n/yzdGQELizQzVud1w2txZtOBG/CiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694638; c=relaxed/simple;
	bh=2j8F6Bx+64AuGBqjcjWUzQF6lkrN9GagkbnbCLJlNkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwCGDrPZ3fhSkO819dSNegz7acrPMT7P4yrXUl2XaqEXd+joKxxeiOngDafNl1z8jllH4WEFYM4XiUo7snKYbwaXdaXOY9KDe6NXmj46OoO6FaF/ql6AXTXAeki+r59w857e/rmWpPf4jgkl+Gcp8JOLjwI1kIzb9NPPgAoll70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BCdZj1Cw; arc=fail smtp.client-ip=40.107.249.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWdEEnhg+5skRbEl69qV3gz0z5xkn/3POYoim9kGTwBmx3SfuyBqpAsaaQ+uSFROoxQkNFiD6Xsx3YJMkeNBxLep76bW1seCUxh7dQhZ4Ml+qgANr0KpV5lvMY8E4Hfi7XnXmFFPWvaFRPTC39g8J3KhcwhWlEC/AWKRDttXNLx7h82blmMd6V5TneqAS8hLSAfEs5kSFV0j/8n+Z55DY+nYZWSZxSPcPu+S+sP5OLg2TTgDlUid9ClKu6EnUXN1lc2UrAgrWCyuQWTHU+jW9kC2hkyWW5q/hOoxp5eP3LdBw/kBVIHEv0bXxAyuTGpReoppeon5NVZ0qRX/p80vCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLoOfLquWZFVOTNKLhquZMh4FpGrfaol01Reca4DY2I=;
 b=YgbMkt4wAopwwRKI4BfrvkA0EQbjevZqXFrXc+zLCYH5NAYgQ0g2UqpC7bzq6TJF1cNISaaRNDi9H9hNE+HfsbbLLnib/wixWpNOXjmA6W8SYjipv9eaq1mU6N9MlWBn/YjKaJuLLG/fukwU1YCFswB8Jr5B0yxRc+VpwIJNlA675husKg40KnREA2hNy9bLdqWpDxYrx/GkgogzFBrBXH6QmjeKeYiMLLw3o7L1l2SWkV94mKl9B/1sLonzM9jDn0ynBob361xTAtykoxVxLTbkN/BB600Nxiv4QOjrHhYRGY7CDTxwFsYVBuiG01ep+4/GJDmJOll6A7ZeLUsHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLoOfLquWZFVOTNKLhquZMh4FpGrfaol01Reca4DY2I=;
 b=BCdZj1CwkhP56m1yakFOBMNo0CLTzB2j+8kmEeKbfCizP+thaAVHFlCXrGrVIBb/vdPIU7cl2VlGRIb0GGKOMHfrs3eX8gp3kz2/QXthSDzLUDYHv12YRC2HRHlYGi9gdbA5glSZbvKYkBEFzeI4oev4x+N/iuCDECjaI/C9ThY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by AS8PR02MB9789.eurprd02.prod.outlook.com (2603:10a6:20b:61e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 14:43:51 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 14:43:51 +0000
Message-ID: <75c205a0-1621-4bb9-8aa4-2bf43478bad9@axis.com>
Date: Wed, 23 Oct 2024 16:43:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: Add support for TI OPT4060 color
 sensor
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
References: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
 <20241016213409.3823162-3-perdaniel.olsson@axis.com>
 <20241020135105.36b29fe8@jic23-huawei>
 <10d6bba4-4d25-4ee0-877e-48a27c622bde@axis.com>
 <20241023142735.000018cb@Huawei.com>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241023142735.000018cb@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|AS8PR02MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: db6217e2-1457-4ca1-d14d-08dcf3711be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QldsZzZpWHBIeVlPSENNSk5lWkZGUHhKWWZlZzdqWjViYUNObnNVQ3Q3aEU2?=
 =?utf-8?B?M1Rkb015MHVRR0xJMzJWZTJ5RklVN1N1dk9jSU8yZ2E4b1c3VHE5aGNIUURY?=
 =?utf-8?B?bEpadk9OaVo1MHk5bnFlWVUzSlNTYUxJQkUvSkFSdVhnU2tVWE5pQWpXcTdC?=
 =?utf-8?B?dlFtNk1ha0Judm5FVmVsNGtYZ1kxRURkekxVb3FuRjRkM0Q5RTNnUW1UVStl?=
 =?utf-8?B?V3lybW8rN2dZZGZhM3lraVVZUWFlVEd2RVFHZ2gxSDVTTmtpU1UyNjVScjQ5?=
 =?utf-8?B?WVUrV1hqUGFLK21DL25WZ0xLZURTbkpVS0xPN01pZ0R3VnVDMW8vZUZsOENT?=
 =?utf-8?B?UEtFU25qVUZkR2ZuY3BVQXV1ZWVBNjNSK3l1VU9JZkpmNXRxOVpORWw1cUdB?=
 =?utf-8?B?UnJrNVhrTm1GNHdZNG56KzRqQlJkWmRPVzVBL3N4Zkg2KzdzNDdGNEc0Q3VM?=
 =?utf-8?B?RFZDUFAwc21lajl6M1I0TTB1Z0JvUkFFZ1FpZzZEQ1p3M0RmZ3NzemhDRDVH?=
 =?utf-8?B?Q09JWFl6QmdDTnVvcnRPWUpVYVlqYUI5bnQwWkdJNXowOHgvcEZOcmhvYmty?=
 =?utf-8?B?TStucngxTTczYWRmWFA2RWtJRTZQTDd3dnRTWlF2amNVNU15V3RJc3VUaDRX?=
 =?utf-8?B?RnVvbHFPZVUrRUp0SXhSMkpMdVpIZzJKeEQ2cTljODl6alNBMzNyMkpDRVJR?=
 =?utf-8?B?WklCUkhVbWljQmtWVXJlejNMdzIxN2pyWkZzemRYVlZXdk5kREJlZlRMcXNT?=
 =?utf-8?B?bjFVQUlicUNRSzhmZzQrTGlYYmk2d29uZlJzZXM2T1QyNjRSaU5WL0ZQeHZ5?=
 =?utf-8?B?K1FCdDVva3dqdDJQaWRtN20rQzk2c0RCbmMvUEk2MXdhTEVWWEZDYzJ6d3Zl?=
 =?utf-8?B?eE9MbjIvak9uUURpN0FmN25WbWU1a0E5VzM1UHhORk1WVnFQQ1pnOUFVaFY2?=
 =?utf-8?B?bXQ2M0w4U2RrTlRrN2gzVTYraTVQMGdiUndtbldOeWRDYjVSa3NtMXorUkxn?=
 =?utf-8?B?TnhHcVlOQ1gvclcvSVBxTkh5VGZmVi9KdUQyUWFTUFFEaGV2bmJKTVpQOXVK?=
 =?utf-8?B?RDBPSk44aTU1dG4zTmpoSGdlT0gybWZXVER0RUwxN2Y5bnp5REY5SmNlWE1Z?=
 =?utf-8?B?WDZ4cWU3TjcyMFA0VG82Zis5ZXZaQnNJd3JtQ2dGQjBuUXlDS2lyMFVFbzBO?=
 =?utf-8?B?eFRDbVdZbDczZ1hqeXZCY0Nya05ZMTFxZ0RWTEdNT0FLQ0QwV3hOZjlXdEVs?=
 =?utf-8?B?c3NBdys0REpXdmdjbVUra010WHpiWk10OU9DZDVpd29iajNsUXlJcDhUcXVM?=
 =?utf-8?B?c3lvNzkreUZmeXBoN2tMd055T2hjTzF4emI1TFFQb1Yyazh4SnhiV2MrOXBu?=
 =?utf-8?B?Q0IxcWNHdlh6T216RlFyd3BJd245eW5XOHRHSjVFMXpHSmtKcGh6eWNUWTd0?=
 =?utf-8?B?R2E4aVhWUDNhV3Fra1ptb0JpRWJ1L3VPb2NHRjNHdEZwb3hWb2orcWlpckZ6?=
 =?utf-8?B?K25yMWpzRXVrTXlmT2kveUhRSGV4SjROa09tRnl6ZnVRL1FjZHFEc1VmQWpB?=
 =?utf-8?B?eFJkME5VRHJKWU1CK2hLbE1MaXZMeGViZnl3TEJrTHBPakNoODlid0l5T1U3?=
 =?utf-8?B?MG9XeGxTcFhaU3p0MXdiSVloZ01jeEExNWN2eUxCRko1eVR0eTQ2YU5zaWRU?=
 =?utf-8?B?U0V2M01mQ3ZaSDFNcmF5K001YXNaTU11TmNTL2phbVpuUlk1SHFoc3VJVVVE?=
 =?utf-8?Q?y7iaEytodYZF6rqOTIo/j4S3pqvYLY7Awk7ugnC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2lBUy9LVU42UysrZG1kS0hGS0l0SG1rQVlKUjdJbG9FaEZWbTEwMHE2Ymtp?=
 =?utf-8?B?L01OYlNoQ2d1U2NtcVkvUEhJN2VNSjZMUlJiVTg2bkZwWkNFOXNRVXN6S0Qr?=
 =?utf-8?B?VGdLc3BqU2JQZ3h3NjNYR0NFQ1BMUjA3b1B2VlNlZWx2MXdnRFlNV0xtbXh3?=
 =?utf-8?B?dG13R0hlaWJaQkF2bkQrOWYxdkN1YXMySEF5Q0Fscmc2ZU13ZG85L3AwZHk0?=
 =?utf-8?B?MnN6K3VTdDRDNjliNXhCY1R5RVV5UHdnYk1vYXNzdE8weE5ZUnNYeVg0dGZZ?=
 =?utf-8?B?Q25QWjZienBqZzkwVm9McUxtOWY5UTJzeDJVcjlDRURub1piUzA5bnVieXFX?=
 =?utf-8?B?eEV6YUtWd29yTEpNemJJdzRmU1VYa3NNSUplV3lJSnlDWGdPeURDZFRRVURl?=
 =?utf-8?B?OVo5eVc5d2ticzZNcDUvN2NjTnpGZndsUnBNUnVKUUpZU0RDU3NnWERnU054?=
 =?utf-8?B?K1RPYks2UFI0MzNoQkdpaXZaNndjOHZkSWZiQnZHM0k2aUJRUUdFUUNLUEtu?=
 =?utf-8?B?ZENWT2Y0WTArMGR5V3FTSGJBU2xKMlpUSEVDaER1VVRNTW5lR2FmbDJST2VG?=
 =?utf-8?B?V1d2dGxid1RaV0x2dnNRbXdSWHZ2aWptTEM2dnBBNVZqVi9TQ29TWFk3S2lW?=
 =?utf-8?B?OVlZdDY0WUFBN2pFbDdCcDBIZTRCeXNHOXBXNzdjVXA2dG56dzFXMG1xMjFC?=
 =?utf-8?B?NmxZWmJRT0psRUxYVjBZaTh0OXlBTUNSSm5vZ2NmRUZuNWRhL0lRVHhORURK?=
 =?utf-8?B?cDArakhjWkY2YXJlWlFTMkdWUWJyM1RkNGt0cDBoRGFNT0NhUzFqN2ZXMWFU?=
 =?utf-8?B?SWZTYjdhQm1zQnFRNEN5Z0ovQnk5Tm4xNkQzQWdXQlhOZGtiZVYrTGZTdzgw?=
 =?utf-8?B?UmVnTWpPREFFSU1VUEgzUE16UUMxZzIxNC9VZEkzZENlZHhBcE0rMTI0aFFZ?=
 =?utf-8?B?cFJCWW44RCtLQVZ2VHplZTlpc3pkMWNkUXYydU0zZWU5RTZtOUtmYjJsVWtV?=
 =?utf-8?B?Wi9rNkMrSW1vb3cyMWFMdythS1VlaEZlaG9HMzdkcGhYMWJVWjJHK0pHalpZ?=
 =?utf-8?B?eWNNa0wwTXhaKzhxaTR5L0ZvTnJhUDh0cklMOE4wRzl2UzlnVDN0cS83eklL?=
 =?utf-8?B?ejdER1hXL2pGc3dkQjN6V25kQVRLdHJQMVNpOXYxRWw5cm5Ca1VTNTdwREJj?=
 =?utf-8?B?UTVRMitEVnJ4dmZKOTlTSndmRWt2cW9sa1RxVlp3S3RDZk42V25DV1lmbnpa?=
 =?utf-8?B?dGlUUXdZWTBKTlVPNWNQVXZDY01uOXVGQ0lrcEVYTUVleURDTGlVWUtoSDNp?=
 =?utf-8?B?QmowOXQxQWNNQytyNUd6Ti9ncko1dWRPSmZTZmhmcktkTGRMNk9MQ3lBZDFx?=
 =?utf-8?B?MkxYbmVOM3h3b3RXL25vZCtSTFQvMWp3WHZUUVdzenFnMDIrUi9jRU85Y2Vl?=
 =?utf-8?B?cnFsaVF5c3k4eThsRW43cGlpMkppWG1ubU5ZVDB2OXh0UXJKT0JGSGRuM2kx?=
 =?utf-8?B?VysxRHV4dFkrb0xGVlM5cGFZU0tVNS90WDBkODRHUGFNdDZaZzNNN1B5eGYv?=
 =?utf-8?B?ZmJKaStGOVpST1JySzNLb0xGdmVnTEd2YlBDMnlLQlFUR01VRVQvZjh3dEll?=
 =?utf-8?B?SGtsbFRYMUJXSm5oUXJoZ01DWitFTFAzV1BhNHptdU9MU2F6a3ZQeDVqTGFF?=
 =?utf-8?B?NWw2b3BKR09CeXZobkRkamJlNkdyQW0zWUdwZkFHbXgyTGZPdzlmeE9oQW1L?=
 =?utf-8?B?UU9WL1NZdk5zYWVLLytnWXNjWVZJV3N3eWFScys0Sll6dE1jek5iOXA5ZThr?=
 =?utf-8?B?d2FZNEtONEJLR1Z0UFE4b0VYbUtCOHhMZVZNNy9YdW5KRS9NVEt3MTREMGQw?=
 =?utf-8?B?ZHlWVVcxWEp1cDIzV08wK0ZYS05tL2pvUTFUMStMOSs1eDJFMkJ0Y0V6a1Vl?=
 =?utf-8?B?dEo2WU91S2kwZjJ3Q202RnNFY0hvZTJxZloxa2Z0WHNGNzhPdDhmRklzU1ls?=
 =?utf-8?B?bkpDcmVlSE9UbVRsZFc3dlNSZjZCdDBMWlQxbTZRWU5DODdaTzZsdElPNjRV?=
 =?utf-8?B?SWViaFN2YzlwQWF4QWNyUGRmMUFYb2I1TXAyN0hTSllMbzNNN00rbVkraDIr?=
 =?utf-8?Q?7E50=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6217e2-1457-4ca1-d14d-08dcf3711be3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:43:51.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+N23MjTq04Gm1w+F4np4BnQX1qQ7w5MTdS5pBJ5zxLEUBQKbVfAZ8r1MqlxI0Zi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9789

On 10/23/24 15:27, Jonathan Cameron wrote:
> On Wed, 23 Oct 2024 09:29:08 +0200
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> Hi Jonathan,
>>
>> Thank you for your feedback, much appreciated. I have added questions and
>> comments inline below regarding channels and triggers. I will address the other
>> comments in the next patch.
>>
>> Best regards / Per-Daniel
>>
>> On 10/20/24 14:51, Jonathan Cameron wrote:
>>> On Wed, 16 Oct 2024 23:34:09 +0200
>>> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
>>>   
>>>> Add support for Texas Instruments OPT4060 RGBW Color sensor.
>>>>
>>>> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>  
>>>
>>> Hi Per-Daniel,
>>>
>>> Comments inline.
>>>
>>> Jonathan
>>>   
>>>> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
>>>> new file mode 100644
>>>> index 000000000000..2c3761ec423a
>>>> --- /dev/null
>>>> +++ b/drivers/iio/light/opt4060.c
>>>> @@ -0,0 +1,1259 @@  
>>>
>>> ...
>>>   
>>>> +
>>>> +struct opt4060_buffer {
>>>> +	u32 chan[OPT4060_NUM_CHANS];
>>>> +	s64 ts __aligned(8);  
>>>
>>> aligned_s64 is now available in linux-next + the IIO tree.
>>>   
>>>> +};
>>>> +
>>>> +static const struct opt4060_channel_factor opt4060_channel_factors[] = {
>>>> +	{
>>>> +		/* RED 2.4 * 2.15e-3 */  
>>> This needs more details on wrt to what standard etc.
>>>
>>> The datasheet is a little vague, but it seems to me like TI invented their
>>> own standard. To use this stuff in a consistent ABI we need to have
>>> a common standard or at least an approximation of one.
>>> The illuminance estimates from some devices are bad approximations, but they
>>> are at least attempting to approximate a well defined standard.  
>>
>> I have read the datasheet again to try to figure out what TI means. When I read
>> it now with your remarks from this email and previous emails in mind, I think I'm
>> starting to understand more.
>>
>> I think we should expose the data from the sensor in the following way:
>> - Four raw channels (R, G, B and Clear)
>> - Three processed IIO_INTENSITY channels with normalized values (R, G, B)
>>   to get the relative color components independent of light intensity.
>> - One IIO_LIGHT channel giving the lux value.
>>
>> This is basically what TI is stating in chapter 8.4.5.2. I know that you don't
>> like how TI are calculating the lux value using the green channel. But after
>> reading the description and detailed description parts of the datasheet again,
>> I think it sort of makes sense. Looking at the spectral response curves on the
>> first page, the green curve covers the whole visible spectrum. It seems like this
>> is what the sensor is actually designed for, measuring light intensity in lux and
>> color independent of the light intensity.
>>
>> Does this sound like a way forward you think?
> Not keen on the colour part.
> 
> As far as I can tell TI made up a colour standard.  If it were
> CIE 1931 RGB or then 'maybe' we could consider presenting them as processed,
> though as they are linear scales even then should present _raw and _scale, not
> _input (processed).  We would still need to figure out if we needed to handle
> multiple colour space definitions.
> As it is, if we have two different colour sensors, there is no way to compare the
> values.  In particular that Green is way too broad for the colour standards
> I quickly compared this with.
> 
> The green curve does (based on eyeballing it rather than anything formal)
> look much closer to the luminosity function (one used for illuminance)
> than I was assuming (given it's called green!)
> 
> So not ideal but that one feels ok (with comments in the code explaining
> this) to use for illuminance.
> 
> 
> For the color channels maybe we could present with _scale provided
> if we add suitable documentation to say that the scaling is to arbitrary
> datasheet specified normalization and that the resulting _raw * _scale
> values cannot be compared across different sensors. I don't like that
> but it does seem silly to not present the scaling if it might be useful
> to someone.  So if you want to do this, propose some additions
> to Documentation/testing/ABI/sysfs-bus-iio
> to cover this for in_intensity_red_scale
> etc.
> 
> Jonathan
> 
> 

Ok, great. Thank you for responding so quickly. I will try to implement it
according to your suggestions in the next patch and also patch the
documentation.

/ P-D

