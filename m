Return-Path: <linux-iio+bounces-12181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99E9C5BFD
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 16:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D43928347E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85321201113;
	Tue, 12 Nov 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FwAcnIOx"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9182010FB;
	Tue, 12 Nov 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425727; cv=fail; b=OTjx6lxXmHwytacPJ6UCANLmrlw3RkAiq2xfunSTClttrAZTBMXTNhvaGTqmKoDa4pfWdrz7DnJ2gy46k9kic/61t1K3/IL+qnXep36EzSyfdIEVnZvdVbA7xK0RTBpHTPKQVCxCO9B4Sfr9/00QMfM7NtFTuDvoTOfO78jSaOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425727; c=relaxed/simple;
	bh=2NfP612M40WygUGWb3auduWrDiDWediVy+EMNj1GmPY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OnuqSqQvcyTfMCJdDmQEwiKIz1gvlhgqoHnfXvRf/8d6xXtuBijqdwEVwnZDLlHDBReJ1t1QQKN7NeSHhjZHFXv36tGo6AjbdzDr+QSYXjILzaPRKV75WFVFIoVcWqKZJW07Xhi3okmAukpoxROg/vmQRdv6N6F9K3SskMHDhtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FwAcnIOx; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gseoILOtNnJ+MXVsXoruPsI6Pp/g2oUbh6JHPbSZn89wUdIvXug2BkNt1+G8PPw6DBN7gOpksyTDyXOfuSvUVcowRWrIVlBW3ZPafut8RPSEiwhlsGlHmyVGhjTCofWOzuhamHRxwtixL+FpmX4G1yzFH1nchptb3wpkaC3ds5D1JEcu7AB39kog7AwXzH5rXNk/U/66EQpDVCyAvwaGlMibi9mfpSf+n31pHSZRj7PbcPq/AybigR1HNCb1CPLI2u1qVw5DFNckCvQeLWA+x5eVL32AfI42mouuZBfukaI06vgVGy0vkmFSHCUNlHagTnWUhLG6VKuKHIQpKSyFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocFZxKn5mFltDR4m/tkJHQ+yZDpmnSgARskCSJ8fMYQ=;
 b=alssp0TmGqnB8R/Ud2yNvhaXZSVz5Yd1lpU0FwOhRMmdMCljBLt5OUVl3lnfMFtAQyi9cpfiHhNHFsDFCbd4Ouq1V+cJkfqx7ZmZXVRdMw2oFEzjiIu5xkZMbHEcgSnOFlfvP1638cMw5CTbO+vrUPtNJOOPdrAio6iNt0fao0NhuH1d8r2VEMBpiu4hqjMhuOvJnTzC2b3WYujVOHQBSsNEfkTaEn8AA4o1QFLPeHNT454fcM+3I/lyTGMln3Ow8UzAQR7yansP6lqWXLGv+XDV0GBATZykL87gQLtUxhp/M5ue2VUrZR5Ti0U+/eVT/RQ+bmCmACrr+pwzSZpRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocFZxKn5mFltDR4m/tkJHQ+yZDpmnSgARskCSJ8fMYQ=;
 b=FwAcnIOx6GEYeY428v8FpsHIuW/Y/ULN6mE0+sqTWLRBL+6QP9+uoVw9+DFPUZ/GQlTQGtRklik8bo34chNu0BaOm/DtPorYNcj786ISWdNkhAbWP9RxqanNuddOhHyaNiFoFMBTXyANceD8RuzSzytzSszVEHjit+td4Qixp0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by AM9PR02MB6580.eurprd02.prod.outlook.com (2603:10a6:20b:2cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:35:20 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:35:20 +0000
Message-ID: <303bd71a-bb38-4afa-a9e2-046425084b69@axis.com>
Date: Tue, 12 Nov 2024 16:35:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color
 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
References: <20241106120036.986755-1-perdaniel.olsson@axis.com>
 <20241106120036.986755-3-perdaniel.olsson@axis.com>
 <20241109150955.7526c416@jic23-huawei>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241109150955.7526c416@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::8) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|AM9PR02MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3a162c-307b-4dd8-71d4-08dd032f9dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MS9iOGZIKzR5WnVrckNqeEZ1M1l5aWl6S0E4TGNDbzBoUmVKbGNHcVhSM2JO?=
 =?utf-8?B?UHgyVm85T3pmWjdxdzdwRXBKL21xRWRHSzhMSmd3UWFidngwbHM4ekF5L21x?=
 =?utf-8?B?UmN3UjJsQ3dvODZhZXJyUDZQejRRbnpNUXk2V2lwSGdUZmtLQXROTUpsUEYr?=
 =?utf-8?B?QzVpU29HaVV2NGwwSnJLS0dKSUE1SldrTHpVMW1zRXpES1lqU1RuQXBqVWo0?=
 =?utf-8?B?SXJlVnloQUtLZTlQSXNaaWZ1N0FKV0hUeFp0b3R6K1hwRzhYS0JWR2RqVUtr?=
 =?utf-8?B?YjdaVmozMkhQYlVOKzJaU3BhUjlkWEFBVnRpKzNwcGtrdnJNU1BpdXk5bFZw?=
 =?utf-8?B?cHBtaXNqMVRTWXh0NlpSTWo5VHZLb2ZYb0JrY05TQVV4eU0rNEdsVjhjZGwr?=
 =?utf-8?B?ckQvODh6U0lEV0dUdFJOSXRLRmVDQkpmOUU4bElJQXFrT3U3MkluSU5VM24x?=
 =?utf-8?B?cy85c1lZSHNxRENmU24raWpCclZjbkdNMmViT1dqRjZFQzEzTjAyTXVhS2NU?=
 =?utf-8?B?MUVRN3d4bVROVWhpQnJKQzdzcnMxYm8yUys4S0RDT0FkZTU4RUhJTUtGREcx?=
 =?utf-8?B?NFNyM1VNcGxiV1BWL0JMMm1XcVlQN09HL2hqcUNiVTczamtTQjNXK0N2ZW1U?=
 =?utf-8?B?MjFJUWZQcGNDTTJzWXBmOUdWZVZjNFhNMFVuNjZVSnRhd1laOFpTSnIzZTlw?=
 =?utf-8?B?MW9waDhocitVZHVPL2ljU3puUDZtcDFjZXRwWVA0czMxaTUvbG44dFJCWi9M?=
 =?utf-8?B?WWlEWnl5RUM1QjUzVXZpSDU0aVRaVERJeDNhNXBlQnhRTllVNnMzZzBvUEM5?=
 =?utf-8?B?YStweFVJZ3BNQ3lXb0JOV05aRHNrcjBvZld4RXo5d1pRakZJWFBFMDFTQ09r?=
 =?utf-8?B?c1VwdTFuZm9YOTBZSU53THcrZE83REh0cHJzMFZKbVg2U0lIYkdaK0p5ZWdC?=
 =?utf-8?B?UTJwU0kyM21wcWpvY2kxOEpYV2VDSFgrekhVeXhyVTVPdVl0RjE4dVk0V2c2?=
 =?utf-8?B?K0hERXlmVktVYjk4Zk43NkRVc1dzb0ZBN2RuM0JTL043SXFobW9laXpGZEc0?=
 =?utf-8?B?WXBRb1lkL0ZDNDJ2dU1KaG5la1poaVRkTWdWUnZ3ekN5eXlZT1lDTkEzQXZz?=
 =?utf-8?B?WFNocVExc1NwOVdxVGE4b2NycG9qTWkzVlRqZ1czd2pDN2d4UmtTTmVjVTJ3?=
 =?utf-8?B?Z1ZSWGZnaTdiL2Mzb1dSQUhUZFZiQjlwc05zZWp1UGFQNlUrcjBmVWlSWm9i?=
 =?utf-8?B?aDhXcmdSbTlMT1hFak9rWm94TEl6SVZMNnJZbXdmSEp2dFhQdFJvZWVQWVdP?=
 =?utf-8?B?d0wzYnc2bm9tQzVWcitWUGVHK2NlY2k0NlR5ZnozVU9oYWc3NUNoejA0WXVw?=
 =?utf-8?B?dHdIQ2FGSEZYOGZqMWlkUG9YZTRueEk4bjJLeVVyblhFcUg2RG9JY0xSSnBJ?=
 =?utf-8?B?L21KNzNsamVxK3FFZFZpUjFsWUdScGNUenB3T2pXcm8wOGJoaWVtKzJrV2NZ?=
 =?utf-8?B?eWpFV0NPU0JmNFFReDFBN1IzejJmSGxRWjRUblB3b2hWbXVvOS9WeklLV2ZP?=
 =?utf-8?B?SUt2VEVLUzZiRFc0YUJTcTZXRlkrTlZKdXQzNWVCT2xNbTdGa0FpVklBZ0oz?=
 =?utf-8?B?SzNRUW9SVUN2SGpLSnZsZXBjV3hhb04yMTcvNWtaN0RZTStVYjU4ODJiUVRo?=
 =?utf-8?B?UUxnMGNUY0N5WTJ1cklDUDdoTjRsaGtnQzhRSmhYVFZJRjFWMzRlOUdCakdv?=
 =?utf-8?Q?pPmhkJ2viSyM8pYjeNE0BOydEhB95lnJUMGAcB/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW1ndC9jUmc1cGhKbUgzdUpYN21ZZTljbzd3dVJCZ3hTY2pTS2taR1NERElJ?=
 =?utf-8?B?em5tNm1SYnJSdkM0amhoRUIxZkxEQ2hxUklHYmdZSk80VzZEc3JwbGNuNkd0?=
 =?utf-8?B?OTFobGx3VXNCSmxaQVl2RDNrM3grRmNlMzFNYVVnbHlpTGViMGRNZklHTUNC?=
 =?utf-8?B?UDcrMVJ5a3NHVVZSZmpRNXE0aEZlNDhaQWt4RTNPZGl2SiszM2NCYUc2NC80?=
 =?utf-8?B?STA4WHFKTXd5VUp5UmUvUWhXUnFQejJaK3FJTzA1ZFJTdGQ5cXFmaVcveGRn?=
 =?utf-8?B?VHZjUVBFa29lK2plNGphK2lIMnlQcVJrU0VpSjE3cDFCR1p2cFVtK0xCSS92?=
 =?utf-8?B?WlR2SmV6S3duaDd0ZldCUmh5QUZNTHpXcnBqbnRySkdwZEJpOFU3SkhPaXN3?=
 =?utf-8?B?d0RpMXlGa2t3cXhOZ0J1bjkzaS9Ga1hFUVRad1liaytkeDVxSFV3d2Z4QUhL?=
 =?utf-8?B?cVNPaENLbTlmeFZ3N1FnVDdOaUpRR2NQQ21IRTB6VUNjSVRuTXR5SGF2N0N2?=
 =?utf-8?B?UzdVN3pTYUlDVE1LSDcxQ2ZVR2t3NmxIMmxpc3NsWGZtNUR1QTNwQkJlZGl1?=
 =?utf-8?B?bGF2Y0kwTkVvM1pMMkZKbGNVYkRPRmFTZE83RXNWUGlUM2M2ZDBNY3o0S0cv?=
 =?utf-8?B?bVM4NVBKR0t2azB1VXpabjBxRjlFQVB0dU12WUc0cWFQV2wySnlBTkxGTFNT?=
 =?utf-8?B?MytiMmhTRVJRSkFzZTVSazV5aHNsSXo4Qk16ZGtaK01YaEFnMDFtTkliQWpm?=
 =?utf-8?B?TjlBdkRZbGRCLzNkeUtXSnphSHpIMjRpUGhGbFdjeFAybjMwa3lWdU4zRGdE?=
 =?utf-8?B?c3VBNzhWMmk4SHBaYjdpRzFUcndTa3JlM3pnY3R5K2JDTGVmdHVSMTVhSlFN?=
 =?utf-8?B?ekN2alhUTEpXdGZXWkI5cEljZ0VJdDg0b0l6SGRPdlRYdWIvWUZ6b21oVERC?=
 =?utf-8?B?a0FYRlBMalB3TTlzT1dVSjV5Nzk4aUozVW1HNG9GblJtUVNPOWFiM01uMzB2?=
 =?utf-8?B?UWpwMVBEZURidzJFQm8zWUl4T29xSlJ3MkJNWUFNNWpabE9rZlZ1RXpjVDBU?=
 =?utf-8?B?ODhoN0R3ZHdmQkNPNmNsN1ZhekZYMDY1cEw5U2dsbGJJSTV4eTkybjVLeU5n?=
 =?utf-8?B?UERnb01kU1ZmTGNnWkJoQUlRRzZ5K0FNYlNubGxKbkdQQ0lJQjRYaVRMamJr?=
 =?utf-8?B?VG51Q1VCWW9rV1lxSFg5bzdESkdZR051NkQvdDNXNnhNdDNVK3VBdnZidmpy?=
 =?utf-8?B?eVJLcnI1MndWQk5lUVA1TkxhdU9IZnpIdmJ2Z0pmVG4xdE5BdWJZWG5NSzZr?=
 =?utf-8?B?UmNVdk12aDVqRjNPaFRGYUdQUnFQa1lUZXRIb1BrK3NLY1VqVUVGNm9zOU5Y?=
 =?utf-8?B?V2hvL202akxBU2thclJiSEtZNklLaWw5ckpQWHRaUm5XSnZ0aFJjSTlUcWgy?=
 =?utf-8?B?d3hrRGg1ZWM4eFg3Z1M1OVNNem5aSTl1QjRONG1NTE1oblR4Uy91UjdLK2g5?=
 =?utf-8?B?REpid0g1UTVSYTNTTmpqdWVFYlBsVUVBRmlNVkljQVhoY1hJZlVqOExKT2Jl?=
 =?utf-8?B?ME0xNjZPbjZvQVhXeUhaRzd2WXc3NjdJMzI3Tm1zdDVrNmgrR1l6dGZWNER2?=
 =?utf-8?B?YXhpMTZXNUk2VmVDSVdUd1R3VlpZUVV6Rlh1blFNTUhOeUFJTXRITSt6VTZy?=
 =?utf-8?B?Nlh3ZlBIZHBmQkE0VkgwUVlRZ0s0cTh6Um0zWmowK1JyNGtEL04ramhDK3RU?=
 =?utf-8?B?OVhjcGJtNmFneThRR0Q3N0EvbTlMNW9tMVVyMGl6d0Y3VThwanIxMkJDNTAz?=
 =?utf-8?B?ejZ6V1dHWXBuTnY1MnVxMkdxY0t6Ymk3bDQ4TXNZeS9wRTRiazBFeGp3MW11?=
 =?utf-8?B?a3NLNTVTL0pQQ3ZQaldlSmczelJsamdjcTN4VGhrNlNpaitVUzBkajFnSHY5?=
 =?utf-8?B?VU0xV3k2aWllV1NxWXVVdWpKL3JaQ0Vtc3BjNGp4cGZQMmlWbjdzZjJOZ0hC?=
 =?utf-8?B?Q2Q4RUZOekhBTGF0UFhkL2ltUUdETmV0dVdYdFR5N2NOa2IrbkFNUWdjazc2?=
 =?utf-8?B?cGViYUxzdEs0cDZCQlRhdFJBUkd3Q0Q0SEZmMThzMTc3NkRkSjZPd0lSWHFO?=
 =?utf-8?Q?wo9E=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3a162c-307b-4dd8-71d4-08dd032f9dd8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:35:20.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/QuWppBOnpZ2lYGvcvgF+euNAEc6rQT5xim5BiKMItMz+18pE7gcsH4yUTIJq0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6580

On 11/9/24 16:09, Jonathan Cameron wrote:
> On Wed, 6 Nov 2024 13:00:36 +0100
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> Add support for Texas Instruments OPT4060 RGBW Color sensor.
>>
>> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> Hi Per-Daniel
> 
> Main comment in here is that the ABI is standard (though oddly
> missing in some cases from the main ABI doc). Annoyingly the
> docs build process (try make htmldocs) does not work if there
> are multiple entries for the same ABI, so we need to ensure that
> the documentation for common ABI is in just one place.
> That makes device specific ABI docs tricky, so instead we tend
> to use extra rst files in Documentation/iio/ to provide more details.
> 
> Jonathan
> 
Hi Jonathan,

Thank you for your code comments, I will fix those in the next version.
I have been trying to understand what I should do in
Documentation/ABI/testing/sysfs-bus-iio but I don't really get it. See
my questions below.

/ P-D

> 
>> ---
>>  .../ABI/testing/sysfs-bus-iio-light-opt4060   |   66 +
>>  drivers/iio/light/Kconfig                     |   13 +
>>  drivers/iio/light/Makefile                    |    1 +
>>  drivers/iio/light/opt4060.c                   | 1282 +++++++++++++++++
>>  4 files changed, 1362 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
>>  create mode 100644 drivers/iio/light/opt4060.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060 b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
>> new file mode 100644
>> index 000000000000..187e750602ee
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
>> @@ -0,0 +1,66 @@
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw
> 
> Huh... This is general ABI but not present in the sysfs-bus-iio
> where it should be.  There are some control parameters on these channels
> but not the actual channels.
> 
> Please add them there instead of in a device specific file.
> Also group the 3 colors together as done for intensity_x, _y, _z
>

So you want me to add 4 lines for in_intensity_X_raw where X is red, green,
blue and clear? Should I add those together with a description in the end of
the file or some place where I find similar definitions? The closest I can
find is in_intensityY_raw (line 1629 in the version of the file I'm looking at).
I also can't find the entries for in_intensity_red/green/blue_scale? I can find
in_intensity_x/y/z_scale but those were added in a commit for the as73211 driver
and as far as I can understand from the driver, x, y and z are coordinates and
not some kind of unknown variables in that context. I'm sorry for what I assume
are really stupid questions, but I just don't get it...

Basically I think I need to add the following 7 lines to the file:

What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw
What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale

Is that correct? Should the _raw ones be added in the groups starting on line 1629?
Should the _scale ones be added to the group starting on line 469?

>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Unit-less raw value for red intensity.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Decimal value for the red component of the light. The value
>> +		is normalized to give the relative red component
>> +		independently of the light intensity.
> 
> I'm not sure I understand this text.   Also why Decimal?
> Maybe something like:
> 
> "Scales the raw value so that for a particular test light source, typically
> white, the measurement intensity is the same across different colour channels."
> 

Your text is also not totally correct, but probably better. The parameters are
first scaled the way you describe but then divided by the sum of the 3 RGB channels.
This to give an estimate of the color ratio between the three color components
independently of the light intensity. A decimal value between 1.0 and 0 will be
returned. Is this the type of oddity that should be documented in an rst file, the
way you described further down?

>>  The raw value for red
>> +		is multiplied by 2.4 before being normalized, this to adapt
>> +		to the relative sensitivity of the red filter of the sensor.
>> +		The factor for green is 1.0 and the factor for blue is 1.3.
> An unfortunately characteristic of the ABI docs is we can't have duplication so
> once this is moved to the general docs this detail will have to go in favour
> of generality.  You could add a little 'footnote' to the entry to say that
> for this particular device the meaning is this.
> 
> 
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Unit-less raw value for green intensity.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Decimal value for the green component of the light. The
>> +		value is normalized to give the relative green component
>> +		independently of the light intensity. The raw value for
>> +		green is multiplied by 1.0 before being normalized, this to
>> +		adapt to the relative sensitivity of the green filter of
>> +		the sensor. The factor for red is 2.4 and the factor for
>> +		blue is 1.3.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Unit-less raw value for blue intensity.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Decimal value for the blue component of the light. The
>> +		value is normalized to give the relative blue component
>> +		independently of the light intensity. The raw value for
>> +		blue is multiplied by 1.3 before being normalized, this to
>> +		adapt to the relative sensitivity of the blue filter of the
>> +		sensor. The factor for red is 2.4 and the factor for green
>> +		is 1.0.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Unit-less raw value for clear intensity.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_input
> This is already in the main ABI doc. 
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Lux value for the light illuminance. The value is
>> +		calculated using the wide spectrum green channel and
>> +		multiplied by 2.15e-3.
> It may be worth capturing these details in an rst file under 
> Documentation/iio/  Just remember to add an entry in the index.rst file
> there so that they get included in the docs buidl.
>

Ok, I can describe this in an rst file.
 
...

