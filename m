Return-Path: <linux-iio+bounces-15243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B900A2E772
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 10:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB057188BD55
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD09A18CC1D;
	Mon, 10 Feb 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qAhs1dZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9D19D072;
	Mon, 10 Feb 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179030; cv=fail; b=WZDx1/9GqrVWxh9iH/RrxYsf8zdUzhfvaovzA6BAveP8pdQsTv1bpSdFx1WS0+FSUZibu0JbIERfsuTCf1ZQDzkD4kwa47PymAFns0vBnZ7MxvoZAKwEASnitKMIQApOwQisS6zI0WFhVPGWItmnki8aFns/aP8XEkufQMhEAME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179030; c=relaxed/simple;
	bh=aUE22ndlzqHV/HlFlOmaLMwfk3LAnApVwEdUR6meAsI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KABpR1aW180B3SvgbW/v+yBsEDK+wCN0olN0JM8DwwAz/4cPkpxcW6mKlZ/XrZuUWHE8tYtKsgkvF0TicQ1Voge+/DriQWM0cb0ofb3uQQa8LByhsUys9Ml9Uh9OdxeQFXgX8eFe3dR8V8J1jSi15eGcyKTMjinY2DofcHF81PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qAhs1dZA; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCIrSs9BgyQmvIh4D8uBUmWkUCLuTIlqOa200jAJxGgJnzcwj7GSSs7muemWm3WiuWzsqrO1LuPJnRJuYKOBG8lSnxiu5gSCzLZFRFuqbAb0NSeL9C4WCIj80bfWhSbIwBiMdL5CuUsrugc1JpyHAuXXOPvySw4PWC6znxLLlrWvXqqGDGGBp2clvMEk3CBdxVmVIsGhxYwk6y003+DNHxTYD0A2qWN2wkXYZvswszaeVMK+bzJ4LVIuF4Grsi47xAB8HwWGviPsqTaoYE/Mqj/ns8PSLWSFr92490Y8lsTJAufBBj/lkafTgItbvd2i4BYYRR8pmTdyFwzJVDv8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc5iegRqgw8CWa8cfBR6C/K2dU/i4vCEyGROjwkebjE=;
 b=dYM38ftOsvkNA1+INrJIPOnd1HQ5HXfMXaYdeAYEdAV51Gu4MrYnBpyOsXwMkcLbGsWlCfrPcmDRbO2oiwelyrac7zDJklI4EXPATJ+PYicmlJIgzlGyrWDdFT0ihATOn9A4I+xkrSregLkqVcAtmEkSTiNM6ClR0iFEZTZbD0Y1Sf9EERR9VRZwpSizijrQUHe2EAekeVkoqUHVf0AItlPPOkC0kpDGjCzQQ9imcakUnfbQ2vqqfa1+UPFKoLiZpJm8k6Ls3WNXO2kCPprq9/OEqJ2WT+g2zvtp5PFBvb2s69Ec3FRW4jGhpEsv2vBbzt6mh3P847pZIh9FqsIhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc5iegRqgw8CWa8cfBR6C/K2dU/i4vCEyGROjwkebjE=;
 b=qAhs1dZA/o8SHG4hVfN/F95v9i2zVD+rM+KxL7LLSegd1qAhGsvWarQOSJHALhr0xdMWAaBv/v9WVcAJoCFhpWNoC70vgCfL2aHEaR5Rn4v03DzRL4HETpsI1ZYr9iJim4DKUXgc8+WGYniZocwcrfFsM5snW0/1kQIwqJJXtW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by AS1PR02MB8004.eurprd02.prod.outlook.com
 (2603:10a6:20b:4c4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:17:04 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9%3]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:17:04 +0000
Message-ID: <1237314b-78a8-a871-ea24-f3011766606b@axis.com>
Date: Mon, 10 Feb 2025 17:16:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] iio: chemical: add support for Sensirion SEN5x/SEN6x
To: Jonathan Cameron <jic23@kernel.org>, Hermes Zhang <Hermes.Zhang@axis.com>
Cc: robh@kernel.org, lars@metafoo.de, krzk+dt@kernel.org, kernel@axis.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
 <20250206061521.2546108-4-Hermes.Zhang@axis.com>
 <20250208161501.7b6c6c17@jic23-huawei>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <20250208161501.7b6c6c17@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::10) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|AS1PR02MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5c325d-5246-48ff-325e-08dd49b3aee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTFVRHFWWW5Oc3FEMXpDUGJmSHg3UkxJZHVVMFVrU0FlM1RINExCaXFibDhR?=
 =?utf-8?B?c1ZHS0NEUlZRWmZ6a1RkYkVkbkovZFh6T2FaK2NpVUlUSCt1MXdqbjRHVi9X?=
 =?utf-8?B?NUhSSHhObXRidkg2TU1PdHFScElOdExzZngvMzkxRjdrTUNqdm0yQU9ZYksr?=
 =?utf-8?B?d3VBcFdwYkNFamJ6NHdwckxVWnlLL2oxUDRYU0xudi9RRkw3UWdnS3A5ZlFl?=
 =?utf-8?B?SDAxTGVtR0pqblp1TnA0K253UTZvVyttbHIvRnhId0ladzl6UlpmV2EwaXJz?=
 =?utf-8?B?YjA4Z0tvWHNEczdQMDRmZ1lEaXFkdXBkeFRBeDZhakE2MDBaeUxtWVNDaHBq?=
 =?utf-8?B?TlpLNVEzZlh2eWRuVzhXUGNGUi85amtLeWRRMWlzN3dSbkVZbXRCMC9vaTZR?=
 =?utf-8?B?RThmZmdjazFaK1FzTS9OTDh5cjJlUlR6bDlsUXJ0ZTFYdlZmNTA5M2JRL0pC?=
 =?utf-8?B?Z1IyMFlHdWw0bm1XcWVQK3NrZjl2SEJ5NjJxNngwNzNCajdsYzM2ODBYRHQx?=
 =?utf-8?B?dWxZOHpWL0xJb3BCYTMzRXl4NGs1cHdKMTJ1SU5waFZkaFFoeTluTjNlM1VP?=
 =?utf-8?B?VWpYRjdqZUFpQldhMlcra3lJdnVZZk5HeVJZWkVXL2tzMTRRalNmRmt4Rzd5?=
 =?utf-8?B?Rmp2dkljL25mVzBHWHV1TTdleDEzMTJYSTc4Syt6OHdlVzdsVnJGcjR6WUNU?=
 =?utf-8?B?dzY4aThlT3QvRlpoU2d2aDB0YkVrWTdFVXZEdUh1T0FDZFBOa1JlZVBhSEJH?=
 =?utf-8?B?S1JvNWs3dFVBQXBiZzZVRHFJS3BlU1ZzOTR5U0xHcGRWODJ5V0lsTXFMbTgw?=
 =?utf-8?B?djFPNUFheTZwK05KdXFzUEh5bHd6RVpVZHN1ak1UMFgrRHJtbVg0d1RwMG1v?=
 =?utf-8?B?QjAvN050SElESHFkeW5JNFcxazB0dit2dkVXeHA4UHB2djFXQzJRbkxiTmZw?=
 =?utf-8?B?ZGJrRVVpOURjSG8yVkp6ZkhYTENIWi9YYVpvSjlsZzYzcFR6aXFGZ2huMzl4?=
 =?utf-8?B?TkpRWTdhcVhrTjZEWWt6TWhpNVhwOU1ReWZqUDMxT2E3TmlsTDZ3UGc2VFZJ?=
 =?utf-8?B?ODdhVmtlMG11eEU1cHNldjlJSEN1NVo1YWxHNklhdGFDN0hDaGtVVUc4dXJ4?=
 =?utf-8?B?QjNVRDFSMzZ6MFg1akZuL1dKazRpakFVeEJlQWZMVUNsMjVCNTEvSGNaNk5h?=
 =?utf-8?B?WWZZQ3ZraG1kdVBmdmFCL3NvUnRYSjJSN2F4dWpqbWFkRHZMOWh2NXNQeTgy?=
 =?utf-8?B?c2Iwem9lR1ZIbmdKMWhyVDl6UDQycjRhTTRPL3FTSCs5Z29kWFB3UUtGK01u?=
 =?utf-8?B?WnV5VzVsa3dxQ0wxU3dNdGdoeGM1dzB5YjdIaDgzMW40anlhOEJMYWxOTTN3?=
 =?utf-8?B?a0VJcFRnZUxveTAwUTlDNTZMVGNKdGlnNWFUbHpSVTF5OS9UWU1XUXJnRlJ2?=
 =?utf-8?B?YVVDN3F0SFVCNWVvcWZ1RnNxWW9WN2h6aWpvN3lNZ3ptMnFOMGR2OTh5WllR?=
 =?utf-8?B?amJVZmlGVWhIem0wdzRwdEJIU0p2SlRETyszdnkvQkZlekExMWZ2c2taY3k3?=
 =?utf-8?B?Wis0clhxVGk4Ni9tOHc5WnEyTW1Uei9BT1BxTGY0WFRKb2h6WW9yZk8rVkFl?=
 =?utf-8?B?R2h5QW5vbklWVzdpVmJxVmNhTlQ5TzJjNjY5QythN1JwRDJ1V2F1ektkZjFl?=
 =?utf-8?B?UTRjejV2akYvRkYwUWIrczM5S3BzRTBySk15VmFpMG1LYzBiWFlFNTFJM0c5?=
 =?utf-8?B?ZlJmbUU1Tk5McldyUWdYS0pHclJrS0ZBbjdYMGZsOGFRVlppQkxIb3QrVlpJ?=
 =?utf-8?B?OVFOcDlyaEt2QzJYL2NDcTI2ektQbEJuUFpsMnFHcTc5TVMybURxZ1l4NEpI?=
 =?utf-8?Q?PMy+3DBIZqsLD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDZBUXh2amRIbEVLZmNRL21wb29nMjFEUEJwY3dXQXRRRE8vZUxrYnk3dWlw?=
 =?utf-8?B?dnBhWG9EMjJmOFpmeDVtaVRYTlc3VEZSckczWGFSY2k4bkRtSERmbWxCc3ZB?=
 =?utf-8?B?VXU3Z2tWWHFpQTF1bG9ReDRCdW0rUVpmS0ZGVTF2bGl2dkptV1BINmcrNzhT?=
 =?utf-8?B?cElHYXBFbXpPTDJFSmQ0QVR0NU5nVU8zSUp4MmFrNzVnd3F0eHRuUmo1b0lr?=
 =?utf-8?B?akZoQXhzdE5yNnJJdUZLa2pjdmRWTHBRcEszdEhDdW0rY0RjNTRFL3lSaFpj?=
 =?utf-8?B?QmpseDE2cnl5NzFZYTk0d1haZGNHWGN2N3Vvdm5uQ0I3dms4VWFzZS9HbU1X?=
 =?utf-8?B?bjVTVWJOMWFabzgvWitYNkh6YVhqa3hxVEIraS9hVCszUzdiaVplUGNIcjdU?=
 =?utf-8?B?UzVsODVaaVRzM253djJTR1lubTdha0JMdUZDcnljT1FOZjBoTXpJVTJyZE5N?=
 =?utf-8?B?Zmdhd1VJVEJsNzhaUkNXUW9UUjJlRUpGNThZN3dYbXJRcnRMMVBocmNSeUlR?=
 =?utf-8?B?MXpOb2MrSWZaSloxejVuc2FzaGJtOWZOSDdPNkx4K08wbWlNWkRHZTZoVU53?=
 =?utf-8?B?SS9UcDhMNnN6Nm1WUmVHYVkxdTRpcklHem9SUlh4Vm5wWGpJdnFoV242bVU0?=
 =?utf-8?B?U1BtVkxuU1dMZDRuWHA3NmhmOU50bFh4Q1RDTHpyQ0UvWnNtaE5BQml5WTVR?=
 =?utf-8?B?NHVjMmNOcjk4d1p6Y28xVDUzcVhRQWRsOHZwU3k0SUFhVktkYW9MN0Z2M0pN?=
 =?utf-8?B?K2xFelNWdDJDcHZGMG1jSnhFU2lBaGdqVTNSU0d6KzlwYlErYTBuSFpPbkJD?=
 =?utf-8?B?REJCRU9Ea2tMRDBXV2l2SDFjRkVBb0ppQXJ3YmhCTzJzMzZxekZML2NhQkRC?=
 =?utf-8?B?bFcxajQ0T1pSa0pVeVpqNHV0cEpjREllbnN0bGFtNk9GNjJYbGF4cDM4REpZ?=
 =?utf-8?B?cnNzdU1HQ2kydFJCU0Z1SkdrOXF1eXBUM3Z2MEtuU0VzZXlZeWpEOG45Umxj?=
 =?utf-8?B?Y29PcnZ5cEJwdW90UmFjckNuNHo0WVJrOHQxckhtS24yNURGU3RhOEw4R2xY?=
 =?utf-8?B?anVhOGs0MDVVeEYyaHlHczlBN2locFB6ZTZydjYwUHFmOGVJdTQ5dk4yVkdD?=
 =?utf-8?B?blhxRzdrcngrM21yQ1JVTjIweExJMS9UN2hNQkRrTHIxSTNteDhlaXdNZ3FW?=
 =?utf-8?B?MndYWlVtOXBmUTFqOFo1U0N3K2xxSGZGa2QvNVFla21ma0JlS1FsYlBVZDU2?=
 =?utf-8?B?YzFBVzlrRjZFeTYrdGV5Y0Q4eDdqdHZJVmE4M2NIMTlKUklSN2ZlNm9hQ3pG?=
 =?utf-8?B?aTA0UmRiOEk4Q1dwVkZDRGR4ZGZLQzhRVWJKRXR0QXVjUis3TkNJZGg3enJq?=
 =?utf-8?B?OURFUDNpTklYSTZNaXdMMWM5R0F4UkwrL25RZFkyaTNhdktTUlR1T3dmOU9H?=
 =?utf-8?B?WFJKSlpsWGMwS1lkeUdwVWlGN1F5V1VLdG9KUWw2K1VOcTVQa0hCa3NqbDVG?=
 =?utf-8?B?L3Q1VEg4SlYwWk1nZ1Jua2xwcUFJZE9DdTczbFJXUVA0VnFzYjJjRFRSa0NB?=
 =?utf-8?B?Sy9vNUF6U1hXNGgyc3lmTEorRlk1Sk5QMGZIb3haN01nelljZHhOa2RMTUgv?=
 =?utf-8?B?MFF6TlNpc3VhVnJjK3EyQ0k5QnQ5OE5hRHVvVGs2dU45S2l4VGpGd2Z3Y0Zo?=
 =?utf-8?B?M0ZJbWdpcndtMlZjUEFnVXpJYStWSjZMeXpROEZaUFk1WFRQWWM2NXJoSldi?=
 =?utf-8?B?V2FrQ0Rxc1ZWY25VUURMUVpISEN4d1hlWlRoS1BLNTIvWWpuMjR6TDh2WEhM?=
 =?utf-8?B?WFN6Rks1cWF0bzJsSkMxTFhIUXFucUw1REkzeFNxaklYbHZaUWpIM1dOaWMw?=
 =?utf-8?B?c3pMcTJoZ0IwMy9tbWlZcU9iOFdvUFVMQXJmM0QrZ2ZFeGg5L01sQlQ2YW81?=
 =?utf-8?B?cTJnOHd1RFBpY0ZuQmxCVEhyWkd1dGdGWXV0b2dJOE0zSVFnOHE4SSszT2JH?=
 =?utf-8?B?YWpEQzlRYzBIVkI5Ym9vZHQwdURLQnBVT09TTFdhditRUWlyYUs5Qng0b3pn?=
 =?utf-8?B?NU1rUURCUWdKZmM1NlRJRkJHS3hqT21MOE9DRWwvRWIxV1VUUUtSOEdoNURG?=
 =?utf-8?Q?ekTe9kblTNohUMspYWAFbTx+j?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5c325d-5246-48ff-325e-08dd49b3aee5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:17:04.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKqLgsb9OhjwkY6m/Zcm7JUgh4HcyXvWCQWSKQjz+KpMd8lms+rJ4UwWxy5/BSGLgyRC3wR8hR2PNYiCc0unVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8004

Hi Jonathan,

Thanks a lot for your review. I will fix most of them in v2, just one 
question below.

Best Regards,
Hermes


On 2025/2/9 0:15, Jonathan Cameron wrote:
> On Thu, 6 Feb 2025 14:15:17 +0800
> Hermes Zhang <Hermes.Zhang@axis.com> wrote:
>
>
>> +
>> +	state->last_update = jiffies;
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>> +			   char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct sen_common_state *state = iio_priv(indio_dev);
>> +	int status;
>> +	int ret;
>> +
>> +	ret = sen_common_status(state->client, &status);
> This is custom ABI. So it would need documentation and will need
> to overcome quite a high barrier.
>
> Superficially this looks like debug perhaps that should be
> in debugfs?

The status is one of the support commands from the chip, we (from 
userspace) could read it and notify customer if the sensor is wrong or 
not. So it is ued in normal usage, regarding the ABI, I see your point, 
so instead of my way, do you have any suggestion for how to handle it in 
iio? Thanks.

Best Regards,

Hermes



