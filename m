Return-Path: <linux-iio+bounces-6557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F86E90E4BB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DF32820EB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CB4770F7;
	Wed, 19 Jun 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Fz2dgdRZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2108.outbound.protection.outlook.com [40.92.23.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED026770E3;
	Wed, 19 Jun 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782832; cv=fail; b=Z3bHx/LqT+ckHqiTeEtheKQD65JdPwH2CtX3rJNblDM9DlR9vMU7i65TC3Q+VwYM523xxLtodk6S78TlIwUVY2bOqvU6OUKaWDTTsLv8Uy/z9T2/gI/Cz1zSk5+ZmuV9AZ+3GF6JluWw0Cq3+7q2YzEyZ4wFmIerbayPI+Utc2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782832; c=relaxed/simple;
	bh=JheW1/NZ4BfSbnDq+ShPgF5GAzlaDFrIX8koOyGAwhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qtwoXdMrC3hPBnNjqHSSXj03XtFHyFRkQE1X9zdB+8XOslWOcS5wyhZpgzxZvXElbQj7sQD7X9sGwxXEGJTR5TDEr4+Z4coHQ29S/lqkDOholz6zAIyc4FH9dcfhw6YgOvyE/tOt6uZwlbMmLP+Bw8gXWXDXUVjQzL5qJopTPfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Fz2dgdRZ; arc=fail smtp.client-ip=40.92.23.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBmk7e5nfXdVS/4Gn742Z1lWX/dGZUu22aNgB78YL+WaZiMZQkWGpe6Soh5aW2tAN0fc3tV+i8mdn9lWhqr5/eaCBkrgnZ8Du+cGMExHIC3F8YfeZSlWSNcEx09m0Xy6KEh2mTpHSrDnkUqv47c/irY4qYrPC+M8KR0LLIyN/zZsBLpN0+WRVLhCpAvACPTQAaSp8Kkhq0n4N/+pdUOzfcYSMnTsAzNeatOZyeoMuj8d9/TcW2OOTd4g6ZZJtzX7l1MwzRq2VzkVs9JOc5TjCOMli9hLHqE8dZOlZxBx0nT2vPeKyovuFc4VngidyCRRXJexo4hlRJK/bIoRQh0W5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znKX1JDbGZUxRnTos81at4bsR/gk+Yv+nFwciTcPppQ=;
 b=QxCJ/zBfi+upAO2F7zq1EnwGJbfognfUg8ZymDyGOWs9mgAlKmoG+w0eAbr6yUwN5IaSl62esCIpGFPZRM4oIoVRK2FnTsM86wSlUnSIWJkqQJOXPHesy7yHWz/R3Y5WcJ+fkBqjhUMt8wi7N+He3izXsr2HjO9qsSxmkrnBdEIBikJ0osgbm26we3c8CkctF/sj1j7N5NPORfYNx4rZ4M9CJi1V7w0sQBAqe/dL6LgkFAvE1cG4Q+cd9WDZtIHqPDXUKULVb8j2ncfhXwwJoukrkGaDr7fW7t9zex24as2H6VwfFB6rZLXwg6781rLd4KQ1AMdunKgCgwf8Kg0YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znKX1JDbGZUxRnTos81at4bsR/gk+Yv+nFwciTcPppQ=;
 b=Fz2dgdRZ/1pGVpCJ3OKcPnmGWFQNbDpocOcI3KX68jSJkSX5XKxp8oNlxZ8nQc7s5uqWvdfJIz0zjENFAE2dFi19Zzg8j5pL9mlAPZq/WREMM2MJai/LmceJgUS10VRQ0ghy+B5CeATqKu3L9OV2ffKUWatM5cZpLW9z1zT+X40ODpXIqeaemaun/2dfzzz/2X1dmI6cdoZ5Obndz6M9lipX3LIT+iqQVP1sWwxLXUVF0KpA04Ox6KyjflcoR8ktsxqM/HAT7fhQd721fXFmd9+Drany5HFChbxwV+ZGEihpRj3730CGG1zfQB3A8mOWd9gJpNYFzd6fmYXl6R2QoQ==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 07:40:26 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 07:40:26 +0000
Message-ID:
 <SN7PR12MB81013C6AFD0EE0DE356151FDA4CF2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Wed, 19 Jun 2024 15:40:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
 nuno.a@analog.com, andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
 <2hcbvnykofspgrn47u56qfan767qiifkyf2agq76npg6lkvx3u@dwagb7j5jx3x>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <2hcbvnykofspgrn47u56qfan767qiifkyf2agq76npg6lkvx3u@dwagb7j5jx3x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [y8l4LU2kLcmb9JZYCFPiC30pPQTufw3icQP7HZrqKxz4PzkVDX7oc7HWHSY66F4t]
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <26ffce1e-a528-4192-9aea-65b630b65d11@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a8a8a5-0753-4054-b328-08dc9033154e
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KPMQo9j5K0HtvaWeD2cvSqEquXOc2196lYMxEU7G5rq5t+MpqRL0SUmmlqxzU4117H4PkJiXkFN+X1clXqX9tZfdym5sv4JJsEQUkyQLbDX3G3NaewSd99l1vNscjo4BmNGF95asQWCTYgLJBkrxmjq6mSELtNbXH5Vu4Xg/sIzrTzM4yb+yNFV7oXQREe1j4Rx2I3OVCBNGIyMOs1MT5UpehV/piIyIEElbqA+SSdKc4Z43Yu0qfSDHVwBvbnSQJZcaffgER8pkWPp+bEoddmEqrELKVIoz71N+kxy+LogksvxN6U4Ir7gaUh7Ac3L0mI8ba+J9N3VBhRJSJ/gbp1XOC11ZbNsojwaHrF3HBfFEOKYE//VsqlZWMlc6+az1TC09UCHHG6CPrGInHMv1xBMg3jCCUO5fn1qfJU/BamnenIRQcL768ayeozW4YLha2QV7KuvY0XmHVteL0nuTAtq+ZvO6Y9SxvO2loQ9SPElx7ERdJFiQDQLNKZ8pknYYJxqLq3LvzAfX96ifk8oFJbWkFzq2XU4YW1tRdxMLr6UyCemqFHUAmPS/j0/oyPdikQ6s78giUbDN1nFXsjq9mRiVIXzoM453iqPPCrUDPk6GK1wcLofbQpyInS0DYn7Ku8Yl2wrCUUZGqjDLc251GOV4JIrPszLjbjfsQwriMHvMCQX7f0XUu1cPI+lUYhqJ99O+0ul8tP3Wh/1SnUAz2Vk5MmD82u/JUsYGeKWCpGmQcFqQQfQvP/91xckZkD5VHsiV58w9xSC64GOWFNPSYZo8DgnpnECIrw2NHjNnuAp24SZZj57AqZKaQQyCi7KMrJR9IUMLLgKSzO1NKa39zmSc9F5P+c3K1hUISc1tNSuyw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|1602099009|3412199022|440099025|4302099010;
X-Microsoft-Antispam-Message-Info:
	bWifID3sbXL8lGf4R8t+2axG3s2XaLESJm4+FO5ffCu+Z7lI53t5ez64DDGEuQpmcvpcqtSOmQrp8EqZtZDcc3StS/bAOskX8aunKc3d30t6lHdwLPVoHTKfTfwi6YPKFLmuAHmpJoM0s06szapZeIb3xPRwA3r9w7TW4QXgxxF92VN7KVrsXWXs/GBcQ152gUiBAll77i4DrgiGAn+Gvxs5nQzyT4vHxMt8ttaFe0T8gytaI4N88p/xDdqiEhzt/PvZEE0zWrdlYj6IH2Ybkl8vcBQhJG3vyNmYSwWGLnIUNEIi8H7SyAxDmG2QHYWiyWRYgtQdbvN8m//h4lfwSxTB8B7aUoLzB0tl1ekWBgkFaibcE5KEANIvLfV7pO0B2EPZ3rBdPSUWLJq+Fhe3xbV+CKkSqgTKEahl5sOji1a1H0CCly+hfAkZhf43t91cp8YFNZo8c462X9g3NxXsDkoc1JgDPJgap+ZxP8PKi5EYvDguhBhZFZxmmw2UCAegjEG1yyNxpdbTRraFOM+YLbWb7SNFzLPOOvG3ewVQorknbfGRSJXzwgYTPJxqJii+/dtM9iyjI2LSl4a4B7xaJBi6f7S3Z2tK6NMrOndepcRPub48YgLSvWbIFPqZmK6tMjl6MadNTU4A5OddYq1H69mBTmF3glAkie1K8sRwveCbrD3pmfUeP2otlCQqCfkP0nF0hGvWCSofhTV+r+WRZA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFg4aklhdy9OYnh1RHRudmR2NFlWMmxpT3ZHR2VaTDJaNzNTRytTZWhuL2tK?=
 =?utf-8?B?ZWVrTzRvQnFwZnJuZU54VlA5ZXU5VzBzVUhwSUpzUzZWMVZTYkRza0xqU0dI?=
 =?utf-8?B?aDZTV3Y5Y0hJM01UTEJLNGlHVmozODVkeHFod2NhY2RIdFJxK2lscU54M2hw?=
 =?utf-8?B?c2cyODZSNjI0YTdQNkhvVm9kZ08rZUoxeEJFRWJpS2kzbDA4L1lpK29pdzdm?=
 =?utf-8?B?ZTcvNHJhbWg1TDFVL3c1d21hMjdsVFcrTm9WNTRxMW11NlNFWHdxelhpRndP?=
 =?utf-8?B?ZjM4Wjl5N2dLSkRINDE5am1ocmorQklPUndZUXljRWM1bjNtVTh3U0RIOTdM?=
 =?utf-8?B?NkVhakJQN05OZXA5M0F0YjZmdlk5eDNXNGVNeFNyWVFLMFdYWWMzWk1WRS9j?=
 =?utf-8?B?anUyekc4REsvRkVSd1RtUzBIejZaOUdnQmJrNFZFQTJidEJnU1V4M2p1Mjdz?=
 =?utf-8?B?VXIydG50aHh6TDJoWE5BeUZITkt3bkFXUVd2cG9NTWhqdjBuZ0pDVnM2ZWVM?=
 =?utf-8?B?Rk82QW9SQ2tTK3pZZVpDVXpKQXQ0M1RqS3pqWXl5eTNsNWQwb1BLRGdmUDFr?=
 =?utf-8?B?eVV6b0thME13NHMvUEpvRGtvNFV5dkpUM0tnKzd5WVVZdEJibE8ycUt2MWNF?=
 =?utf-8?B?bjhOUDNqcDNiV05lSjdkS21Ca2VIdGpHZWZPVlhPbC9pZWEyY2xSQnEyUWFC?=
 =?utf-8?B?MDFlNmhEaUdTWEp0dVRRTzdNdjZEVzQwUWpmTkEwRVNpLzMzREJFbFdUSEM4?=
 =?utf-8?B?N2dsTXhtUWlpUUtpYm1FYW11MGxMNTByUENERlpWZDNjTFk5U0svN0dENWhJ?=
 =?utf-8?B?WU10K2djSHcyL2hwQk5Kb1RoMmdFNEZYRnoxWHU4dy9kaC9TMWFRcjZoRGJL?=
 =?utf-8?B?YUZuUHZEL2lSdUZTaUYzQjFaRjBKcHphb2xsMmZNb0laYUtncG00V3RTQXVi?=
 =?utf-8?B?TEEwZndkelFjTlFQZ3gzZllpRUlWK2tzWDZHVzRhcWFyeThvMFlrcHJyempV?=
 =?utf-8?B?Nm8vVkVDYnk2dzRCZ0toUTFxUGJlVzlQems5MkRBMGdNSFNkbGROY2xpVGhQ?=
 =?utf-8?B?cEw3TkhFUmxJa2dNWVVjYk9WblY4WkJuWEg0ZUs2VFBIR2VpVXNrNnd3UWIr?=
 =?utf-8?B?dmo3M2tVWVF5bDBxWVI5WEw2bVducWJrdk9YRDl4Yy93enlIUEJRVnVoeUZi?=
 =?utf-8?B?ZnZhOGRwSGxHdklud1N3RVllZTJPNStOZGkrRFpNT3hJZDhoTk9aT1BvSnFQ?=
 =?utf-8?B?cXlJK0YxV0xqdy9zZWZQTHhXa0VtUmdDRUhsa3d2QjN5QmJYOTFzMzRKOWha?=
 =?utf-8?B?K2o3MmQzemRUQ1gycVR1alN4eWJQV1NVVUpaT2NITDgwMEVwRzIzSEVlYnB1?=
 =?utf-8?B?UTU1RXlreGxIZzRVNENYaWJpOC9wdlBPQTEwQWswRStJc3F5RXdtcFFoVDRh?=
 =?utf-8?B?VWdSekRiRndSZGhpbVUzbXoxbXJFNFA2WGdKRVBKL3RpVVVlcXVTaHF6eHhw?=
 =?utf-8?B?czNSZXp6QVZzK1I2MHllTzQ5dkxGUUYxUE90MFp1bmJZQUVGcXAyc0twWmNs?=
 =?utf-8?B?WkJBeEgyaG9rdUtUY3ozWFhma1RLZU1iaCt2SWNLL2MvUlNTUGVOeWNoSVRr?=
 =?utf-8?B?alllN3FLNGNNZ3ZSdXRyMXVOaEJlckdIS2tqNUZMc0pVa3hoVmNSbnNYNkhR?=
 =?utf-8?B?OElOck9oKzBlZm9HeVYxcStMaXR3L2w1UC9vQy9aQ0h5TGZrTVY3OWdqU3J3?=
 =?utf-8?Q?1cvof0hJtd7NYbulKQ0oECOmXqC0AvT6xRNDT7D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a8a8a5-0753-4054-b328-08dc9033154e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 07:40:25.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

Hi Uwe，

Thank you for your suggestions. This is my first submission for review. 
Based on your numerous suggestions, I have removed a lot of redundant 
code and made structural changes to the code in the subsequent version. 
Please review the updated version.

Best regards

Yasin Lee


On 2024/5/10 18:26, Uwe Kleine-König wrote:
> Hello,
>
> there are quite some checkpatch warnings that trigger for your patch:
>
> 	$ curl -s https://lore.kernel.org/all/SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com/raw | scripts/checkpatch.pl  -
> 	...
> 	total: 1 errors, 95 warnings, 2179 lines checked
>
> Mostly line length and spelling mistakes.
>
> A few more notes in the quote below:
>
> On Fri, May 10, 2024 at 05:37:32PM +0800, Yasin Lee wrote:
>> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
>> index f36598380446..cf020d74f761 100644
>> --- a/drivers/iio/proximity/Makefile
>> +++ b/drivers/iio/proximity/Makefile
>> @@ -21,4 +21,5 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>>   obj-$(CONFIG_SX9500)		+= sx9500.o
>>   obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>>   obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
>> +obj-$(CONFIG_HX9031AS)		+= hx9031as.o
>>   
>> diff --git a/drivers/iio/proximity/hx9031as.c b/drivers/iio/proximity/hx9031as.c
>> new file mode 100644
>> index 000000000000..fa129e19452d
>> --- /dev/null
>> +++ b/drivers/iio/proximity/hx9031as.c
>> @@ -0,0 +1,2142 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
>> + * http://www.tianyihexin.com
>> + *
>> + * Driver for NanjingTianyihexin HX9031AS & HX9023S Cap Sensor
>> + * Author: Yasin Lee <yasin.lee.x@gmail.com>
>> + *
> This line can/should be dropped.
>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/version.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/irq.h>
>> +#include <linux/acpi.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/pm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/debugfs.h>
>> +
>> +#define HX9031AS_DRIVER_VER "iio-1.0"
>> +#define ENTER \
>> +dev_info(hx9031as_pdata.pdev, "[%04d][%s]\n", __LINE__, __func__)
>> +#define PRINT_DBG(format, x...) \
>> +dev_info(hx9031as_pdata.pdev, "[%04d][%s] " format, __LINE__, __func__, ## x)
>> +#define PRINT_INF(format, x...) \
>> +dev_info(hx9031as_pdata.pdev, "[%04d][%s] " format, __LINE__, __func__, ## x)
>> +#define PRINT_ERR(format, x...) \
>> +dev_err(hx9031as_pdata.pdev, "[%04d][%s] " format, __LINE__, __func__, ## x)
> I personally find those disturbing. Not only is dev_info too verbose
> (use dev_dbg), but also the call sides looks strange and add a burden to
> the reader.


Delete the wrappers.


>> +
>> +#define HX9031AS_TEST_CHS_EN 0             //test
> test? Don't use C++ style comments.


Deleted.


>> +#define HX9023S_ON_BOARD 0
>> +#define HX9031AS_ON_BOARD 1
>> +#define HX9031AS_DRIVER_NAME "hx9031as"    //i2c addr: HX9031AS=0x28
>> +#define HX9031AS_CHIP_ID 0x1D
>> +#define HX9031AS_CH_NUM 5
>> +#define HX9031AS_CH_USED 0x1F
>> +#define HX9031AS_DATA_LOCK 1
>> +#define HX9031AS_DATA_UNLOCK 0
>> +#define CH_DATA_2BYTES 2
>> +#define CH_DATA_3BYTES 3
>> +#define CH_DATA_BYTES_MAX CH_DATA_3BYTES
>> +#define HX9031AS_ODR_MS 200
>> +#define TYHX_DELAY_MS(x) msleep(x)
>> +#define BUF_SIZE 512
>> +
>> +#define RW_00_GLOBAL_CTRL0                   0x00
>> +#define RW_01_GLOBAL_CTRL1                   0x01
>> +#define RW_02_PRF_CFG                        0x02
>> +#define RW_03_CH0_CFG_7_0                    0x03
>> +#define RW_04_CH0_CFG_9_8                    0x04
>> +#define RW_05_CH1_CFG_7_0                    0x05
>> +#define RW_06_CH1_CFG_9_8                    0x06
>> +#define RW_07_CH2_CFG_7_0                    0x07
>> +#define RW_08_CH2_CFG_9_8                    0x08
>> +#define RW_09_CH3_CFG_7_0                    0x09
>> +#define RW_0A_CH3_CFG_9_8                    0x0A
>> +#define RW_0B_CH4_CFG_7_0                    0x0B
>> +#define RW_0C_CH4_CFG_9_8                    0x0C
>> +#define RW_0D_RANGE_7_0                      0x0D
>> +#define RW_0E_RANGE_9_8                      0x0E
>> +#define RW_0F_RANGE_18_16                    0x0F
>> +#define RW_10_AVG0_NOSR0_CFG                 0x10
>> +#define RW_11_NOSR12_CFG                     0x11
>> +#define RW_12_NOSR34_CFG                     0x12
>> +#define RW_13_AVG12_CFG                      0x13
>> +#define RW_14_AVG34_CFG                      0x14
>> +#define RW_15_OFFSET_DAC0_7_0                0x15
>> +#define RW_16_OFFSET_DAC0_9_8                0x16
>> +#define RW_17_OFFSET_DAC1_7_0                0x17
>> +#define RW_18_OFFSET_DAC1_9_8                0x18
>> +#define RW_19_OFFSET_DAC2_7_0                0x19
>> +#define RW_1A_OFFSET_DAC2_9_8                0x1A
>> +#define RW_1B_OFFSET_DAC3_7_0                0x1B
>> +#define RW_1C_OFFSET_DAC3_9_8                0x1C
>> +#define RW_1D_OFFSET_DAC4_7_0                0x1D
>> +#define RW_1E_OFFSET_DAC4_9_8                0x1E
>> +#define RW_1F_SAMPLE_NUM_7_0                 0x1F
>> +#define RW_20_SAMPLE_NUM_9_8                 0x20
>> +#define RW_21_INTEGRATION_NUM_7_0            0x21
>> +#define RW_22_INTEGRATION_NUM_9_8            0x22
>> +#define RW_23_GLOBAL_CTRL2                   0x23
>> +#define RW_24_CH_NUM_CFG                     0x24
>> +#define RW_25_DAC_SWAP_CFG                   0x25
>> +#define RW_28_MOD_RST_CFG                    0x28
>> +#define RW_29_LP_ALP_4_CFG                   0x29
>> +#define RW_2A_LP_ALP_1_0_CFG                 0x2A
>> +#define RW_2B_LP_ALP_3_2_CFG                 0x2B
>> +#define RW_2C_UP_ALP_1_0_CFG                 0x2C
>> +#define RW_2D_UP_ALP_3_2_CFG                 0x2D
>> +#define RW_2E_DN_UP_ALP_0_4_CFG              0x2E
>> +#define RW_2F_DN_ALP_2_1_CFG                 0x2F
>> +#define RW_30_DN_ALP_4_3_CFG                 0x30
>> +#define RW_31_INT_CAP_CFG                    0x31
>> +#define RW_33_NDL_DLY_4_CFG                  0x33
>> +#define RW_35_FORCE_NO_UP_CFG                0x35
>> +#define RW_38_RAW_BL_RD_CFG                  0x38
>> +#define RW_39_INTERRUPT_CFG                  0x39
>> +#define RW_3A_INTERRUPT_CFG1                 0x3A
>> +#define RW_3B_CALI_DIFF_CFG                  0x3B
>> +#define RW_3C_DITHER_CFG                     0x3C
>> +#define RW_40_ANALOG_MEM0_WRDATA_7_0         0x40
>> +#define RW_41_ANALOG_MEM0_WRDATA_15_8        0x41
>> +#define RW_42_ANALOG_MEM0_WRDATA_23_16       0x42
>> +#define RW_43_ANALOG_MEM0_WRDATA_31_24       0x43
>> +#define RW_48_ANALOG_PWE_PULSE_CYCLE7_0      0x48
>> +#define RW_49_ANALOG_PWE_PULSE_CYCLE12_8     0x49
>> +#define RW_4A_ANALOG_MEM_GLOBAL_CTRL         0x4A
>> +#define RO_4B_DEBUG_MEM_ADC_FSM              0x4B
>> +#define RW_4C_ANALOG_MEM_GLOBAL_CTRL1        0x4C
>> +#define RO_5F_VERION_ID                      0x5F
>> +#define RO_60_DEVICE_ID                      0x60
>> +#define RO_61_TC_FSM                         0x61
>> +#define RO_66_FLAG_RD                        0x66
>> +#define RO_6A_CONV_TIMEOUT_CNT               0x6A
>> +#define RO_6B_PROX_STATUS                    0x6B
>> +#define RW_6C_PROX_INT_HIGH_CFG              0x6C
>> +#define RW_6D_PROX_INT_LOW_CFG               0x6D
>> +#define RW_6E_CAP_INI_CFG                    0x6E
>> +#define RW_6F_INT_WIDTH_CFG0                 0x6F
>> +#define RW_70_INT_WIDTH_CFG1                 0x70
>> +#define RO_71_INT_STATE_RD0                  0x71
>> +#define RO_72_INT_STATE_RD1                  0x72
>> +#define RO_73_INT_STATE_RD2                  0x73
>> +#define RO_74_INT_STATE_RD3                  0x74
>> +#define RW_80_PROX_HIGH_DIFF_CFG_CH0_0       0x80
>> +#define RW_81_PROX_HIGH_DIFF_CFG_CH0_1       0x81
>> +#define RW_82_PROX_HIGH_DIFF_CFG_CH1_0       0x82
>> +#define RW_83_PROX_HIGH_DIFF_CFG_CH1_1       0x83
>> +#define RW_84_PROX_HIGH_DIFF_CFG_CH2_0       0x84
>> +#define RW_85_PROX_HIGH_DIFF_CFG_CH2_1       0x85
>> +#define RW_86_PROX_HIGH_DIFF_CFG_CH3_0       0x86
>> +#define RW_87_PROX_HIGH_DIFF_CFG_CH3_1       0x87
>> +#define RW_88_PROX_LOW_DIFF_CFG_CH0_0        0x88
>> +#define RW_89_PROX_LOW_DIFF_CFG_CH0_1        0x89
>> +#define RW_8A_PROX_LOW_DIFF_CFG_CH1_0        0x8A
>> +#define RW_8B_PROX_LOW_DIFF_CFG_CH1_1        0x8B
>> +#define RW_8C_PROX_LOW_DIFF_CFG_CH2_0        0x8C
>> +#define RW_8D_PROX_LOW_DIFF_CFG_CH2_1        0x8D
>> +#define RW_8E_PROX_LOW_DIFF_CFG_CH3_0        0x8E
>> +#define RW_8F_PROX_LOW_DIFF_CFG_CH3_1        0x8F
>> +#define RW_9E_PROX_HIGH_DIFF_CFG_CH4_0       0x9E
>> +#define RW_9F_PROX_HIGH_DIFF_CFG_CH4_1       0x9F
>> +#define RW_A2_PROX_LOW_DIFF_CFG_CH4_0        0xA2
>> +#define RW_A3_PROX_LOW_DIFF_CFG_CH4_1        0xA3
>> +#define RW_91_DSP_CONFIG_CTRL4               0x91
>> +#define RW_93_DSP_CONFIG_CTRL6               0x93
>> +#define RW_94_DSP_CONFIG_CTRL7               0x94
>> +#define RW_95_DSP_CONFIG_CTRL8               0x95
>> +#define RW_96_DSP_CONFIG_CTRL9               0x96
>> +#define RW_97_DSP_CONFIG_CTRL10              0x97
>> +#define RW_98_DSP_CONFIG_CTRL11              0x98
>> +#define RW_A0_LP_OUT_DELTA_THRES_CH1_CFG0    0xA0
>> +#define RW_A1_LP_OUT_DELTA_THRES_CH1_CFG1    0xA1
>> +#define RW_A4_LP_OUT_DELTA_THRES_CH3_CFG0    0xA4
>> +#define RW_A5_LP_OUT_DELTA_THRES_CH3_CFG1    0xA5
>> +#define RW_A6_LP_OUT_DELTA_THRES_CH4_CFG0    0xA6
>> +#define RW_A7_LP_OUT_DELTA_THRES_CH4_CFG1    0xA7
>> +#define RW_A8_PROX_THRES_SHIFT_CFG0          0xA8
>> +#define RW_A9_PROX_THRES_SHIFT_CFG1          0xA9
>> +#define RW_AA_PROX_THRES_SHIFT_CFG2          0xAA
>> +#define RW_AB_PROX_THRES_SHIFT_CFG3          0xAB
>> +#define RW_AC_PROX_THRES_SHIFT_CFG4          0xAC
>> +#define RW_AD_BL_IN_NO_UP_NUM_SEL0           0xAD
>> +#define RW_AE_BL_IN_NO_UP_NUM_SEL1           0xAE
>> +#define RW_AF_BL_IN_NO_UP_NUM_SEL2           0xAF
>> +#define RW_B2_BL_ALPHA_UP_DN_SEL             0xB2
>> +#define RW_BF_CH0_SAMP_CFG                   0xBF
>> +#define RW_C0_CH10_SCAN_FACTOR               0xC0
>> +#define RW_C1_CH32_SCAN_FACTOR               0xC1
>> +#define RW_C2_OFFSET_CALI_CTRL               0xC2
>> +#define RW_90_OFFSET_CALI_CTRL1              0x90
>> +#define RW_C3_DSP_CONFIG_CTRL0               0xC3
>> +#define RW_92_DSP_CONFIG_CTRL5               0x92
>> +#define RW_C4_CH10_DOZE_FACTOR               0xC4
>> +#define RW_C5_CH32_DOZE_FACTOR               0xC5
>> +#define RW_C6_CH10_PROX_FACTOR               0xC6
>> +#define RW_C7_CH4_FACTOR_CTRL                0xC7
>> +#define RW_C8_DSP_CONFIG_CTRL1               0xC8
>> +#define RW_C9_DSP_CONFIG_CTRL2               0xC9
>> +#define RW_CA_DSP_CONFIG_CTRL3               0xCA
>> +#define RO_CB_DEC_DATA0                      0xCB
>> +#define RO_CC_DEC_DATA1                      0xCC
>> +#define RO_CD_DEC_DATA2                      0xCD
>> +#define RO_CE_DEC_DATA3                      0xCE
>> +#define RO_E0_CAP_INI_CH0_0                  0xE0
>> +#define RO_E1_CAP_INI_CH0_1                  0xE1
>> +#define RO_99_CAP_INI_CH0_2                  0x99
>> +#define RO_E2_CAP_INI_CH1_0                  0xE2
>> +#define RO_E3_CAP_INI_CH1_1                  0xE3
>> +#define RO_9A_CAP_INI_CH1_2                  0x9A
>> +#define RO_E4_CAP_INI_CH2_0                  0xE4
>> +#define RO_E5_CAP_INI_CH2_1                  0xE5
>> +#define RO_9B_CAP_INI_CH2_2                  0x9B
>> +#define RO_E6_CAP_INI_CH3_0                  0xE6
>> +#define RO_E7_CAP_INI_CH3_1                  0xE7
>> +#define RO_9C_CAP_INI_CH3_2                  0x9C
>> +#define RO_B3_CAP_INI_CH4_0                  0xB3
>> +#define RO_B4_CAP_INI_CH4_1                  0xB4
>> +#define RO_9D_CAP_INI_CH4_2                  0x9D
>> +#define RO_E8_RAW_BL_CH0_0                   0xE8
>> +#define RO_E9_RAW_BL_CH0_1                   0xE9
>> +#define RO_EA_RAW_BL_CH0_2                   0xEA
>> +#define RO_EB_RAW_BL_CH1_0                   0xEB
>> +#define RO_EC_RAW_BL_CH1_1                   0xEC
>> +#define RO_ED_RAW_BL_CH1_2                   0xED
>> +#define RO_EE_RAW_BL_CH2_0                   0xEE
>> +#define RO_EF_RAW_BL_CH2_1                   0xEF
>> +#define RO_F0_RAW_BL_CH2_2                   0xF0
>> +#define RO_F1_RAW_BL_CH3_0                   0xF1
>> +#define RO_F2_RAW_BL_CH3_1                   0xF2
>> +#define RO_F3_RAW_BL_CH3_2                   0xF3
>> +#define RO_B5_RAW_BL_CH4_0                   0xB5
>> +#define RO_B6_RAW_BL_CH4_1                   0xB6
>> +#define RO_B7_RAW_BL_CH4_2                   0xB7
>> +#define RO_F4_LP_DIFF_CH0_0                  0xF4
>> +#define RO_F5_LP_DIFF_CH0_1                  0xF5
>> +#define RO_F6_LP_DIFF_CH0_2                  0xF6
>> +#define RO_F7_LP_DIFF_CH1_0                  0xF7
>> +#define RO_F8_LP_DIFF_CH1_1                  0xF8
>> +#define RO_F9_LP_DIFF_CH1_2                  0xF9
>> +#define RO_FA_LP_DIFF_CH2_0                  0xFA
>> +#define RO_FB_LP_DIFF_CH2_1                  0xFB
>> +#define RO_FC_LP_DIFF_CH2_2                  0xFC
>> +#define RO_FD_LP_DIFF_CH3_0                  0xFD
>> +#define RO_FE_LP_DIFF_CH3_1                  0xFE
>> +#define RO_FF_LP_DIFF_CH3_2                  0xFF
>> +#define RO_B8_LP_DIFF_CH4_0                  0xB8
>> +#define RO_B9_LP_DIFF_CH4_1                  0xB9
>> +#define RO_BA_LP_DIFF_CH4_2                  0xBA
>> +#define RW_50_REG_TO_ANA2                    0x50
>> +#define RW_51_REG_TO_ANA3                    0x51
>> +#define RW_52_REG_TO_ANA4                    0x52
>> +#define RW_53_REG_TO_ANA5                    0x53
>> +#define RW_82_REG_TO_ANA6                    0x82
>> +
>> +struct hx9031as_threshold {
>> +	int32_t near;
>> +	int32_t far;
>> +};
>> +
>> +struct hx9031as_addr_val_pair {
>> +	uint8_t addr;
>> +	uint8_t val;
>> +};
>> +
>> +struct hx9031as_channel_info {
>> +	char name[20];
>> +	bool enabled;
>> +	bool used;
>> +	int state;
>> +};
>> +
>> +struct hx9031as_platform_data {
>> +	struct i2c_client *i2c_client;
>> +	struct hx9031as_data *iio_data;
>> +	uint8_t chip_select;
>> +	uint8_t ch_en_stat;
>> +	int polling_period_ms;
>> +	int32_t raw[HX9031AS_CH_NUM];
>> +	int32_t diff[HX9031AS_CH_NUM];
>> +	int32_t lp[HX9031AS_CH_NUM];
>> +	int32_t bl[HX9031AS_CH_NUM];
>> +	uint16_t dac[HX9031AS_CH_NUM];
>> +	uint8_t accuracy;
>> +	atomic_t polling_flag;
>> +	atomic_t irq_en;
>> +	struct hx9031as_threshold thres[HX9031AS_CH_NUM];
>> +
>> +	struct device *pdev;
>> +	struct delayed_work polling_work;
>> +	struct hx9031as_channel_info *chs_info;
>> +	uint32_t channel_used_flag;
>> +	int irq;
>> +	int irq_gpio;
>> +	char irq_disabled;
>> +	uint32_t prox_state_reg;
>> +	bool sel_bl[HX9031AS_CH_NUM];
>> +	bool sel_raw[HX9031AS_CH_NUM];
>> +	bool sel_diff[HX9031AS_CH_NUM];
>> +	bool sel_lp[HX9031AS_CH_NUM];
>> +
>> +	uint8_t chs_en_flag;
>> +	uint8_t cali_en_flag;
>> +	uint8_t device_id;
>> +	uint8_t version_id;
>> +
>> +	struct dentry *debugfs_dir;
>> +};
> Please double check if you really need all these. E.g. debugfs_dir is
> only used in hx9031as_debug_for_iio().
>

Deleted the debug-related code.


>> +
>> +static struct hx9031as_addr_val_pair hx9031as_reg_init_list[] = {
>> +	{RW_24_CH_NUM_CFG,                 0x00},
>> +	{RW_00_GLOBAL_CTRL0,               0x00},
>> +	{RW_23_GLOBAL_CTRL2,               0x00},
>> +
>> +	{RW_02_PRF_CFG,                    0x17},
>> +	{RW_0D_RANGE_7_0,                  0x11},
>> +	{RW_0E_RANGE_9_8,                  0x02},
>> +	{RW_0F_RANGE_18_16,                0x00},
>> +
>> +	{RW_10_AVG0_NOSR0_CFG,             0x71},
>> +	{RW_11_NOSR12_CFG,                 0x44},
>> +	{RW_12_NOSR34_CFG,                 0x00},
>> +	{RW_13_AVG12_CFG,                  0x33},
>> +	{RW_14_AVG34_CFG,                  0x00},
>> +
>> +	{RW_1F_SAMPLE_NUM_7_0,             0x65},
>> +	{RW_21_INTEGRATION_NUM_7_0,        0x65},
>> +
>> +	{RW_2A_LP_ALP_1_0_CFG,             0x22},
>> +	{RW_2B_LP_ALP_3_2_CFG,             0x22},
>> +	{RW_29_LP_ALP_4_CFG,               0x02},
>> +	{RW_2C_UP_ALP_1_0_CFG,             0x88},
>> +	{RW_2D_UP_ALP_3_2_CFG,             0x88},
>> +	{RW_2E_DN_UP_ALP_0_4_CFG,          0x18},
>> +	{RW_2F_DN_ALP_2_1_CFG,             0x11},
>> +	{RW_30_DN_ALP_4_3_CFG,             0x11},
>> +
>> +	{RW_38_RAW_BL_RD_CFG,              0xF0},
>> +	{RW_39_INTERRUPT_CFG,              0xFF},
>> +	{RW_3A_INTERRUPT_CFG1,             0x3B},
>> +	{RW_3B_CALI_DIFF_CFG,              0x07},
>> +	{RW_3C_DITHER_CFG,                 0x21},
>> +	{RW_6C_PROX_INT_HIGH_CFG,          0x01},
>> +	{RW_6D_PROX_INT_LOW_CFG,           0x01},
>> +
>> +	{RW_80_PROX_HIGH_DIFF_CFG_CH0_0,   0x40},
>> +	{RW_81_PROX_HIGH_DIFF_CFG_CH0_1,   0x00},
>> +	{RW_82_PROX_HIGH_DIFF_CFG_CH1_0,   0x40},
>> +	{RW_83_PROX_HIGH_DIFF_CFG_CH1_1,   0x00},
>> +	{RW_84_PROX_HIGH_DIFF_CFG_CH2_0,   0x40},
>> +	{RW_85_PROX_HIGH_DIFF_CFG_CH2_1,   0x00},
>> +	{RW_86_PROX_HIGH_DIFF_CFG_CH3_0,   0x40},
>> +	{RW_87_PROX_HIGH_DIFF_CFG_CH3_1,   0x00},
>> +	{RW_9E_PROX_HIGH_DIFF_CFG_CH4_0,   0x40},
>> +	{RW_9F_PROX_HIGH_DIFF_CFG_CH4_1,   0x00},
>> +	{RW_88_PROX_LOW_DIFF_CFG_CH0_0,    0x20},
>> +	{RW_89_PROX_LOW_DIFF_CFG_CH0_1,    0x00},
>> +	{RW_8A_PROX_LOW_DIFF_CFG_CH1_0,    0x20},
>> +	{RW_8B_PROX_LOW_DIFF_CFG_CH1_1,    0x00},
>> +	{RW_8C_PROX_LOW_DIFF_CFG_CH2_0,    0x20},
>> +	{RW_8D_PROX_LOW_DIFF_CFG_CH2_1,    0x00},
>> +	{RW_8E_PROX_LOW_DIFF_CFG_CH3_0,    0x20},
>> +	{RW_8F_PROX_LOW_DIFF_CFG_CH3_1,    0x00},
>> +	{RW_A2_PROX_LOW_DIFF_CFG_CH4_0,    0x20},
>> +	{RW_A3_PROX_LOW_DIFF_CFG_CH4_1,    0x00},
>> +
>> +	{RW_A8_PROX_THRES_SHIFT_CFG0,      0x00},
>> +	{RW_A9_PROX_THRES_SHIFT_CFG1,      0x00},
>> +	{RW_AA_PROX_THRES_SHIFT_CFG2,      0x00},
>> +	{RW_AB_PROX_THRES_SHIFT_CFG3,      0x00},
>> +	{RW_AC_PROX_THRES_SHIFT_CFG4,      0x00},
>> +
>> +	{RW_C0_CH10_SCAN_FACTOR,           0x00},
>> +	{RW_C1_CH32_SCAN_FACTOR,           0x00},
>> +	{RW_C4_CH10_DOZE_FACTOR,           0x00},
>> +	{RW_C5_CH32_DOZE_FACTOR,           0x00},
>> +	{RW_C7_CH4_FACTOR_CTRL,            0x00},
>> +	{RW_C8_DSP_CONFIG_CTRL1,           0x00},
>> +	{RW_CA_DSP_CONFIG_CTRL3,           0x00},
>> +};
>> +
>> +static struct hx9031as_platform_data hx9031as_pdata = {
>> +	.i2c_client = NULL,
>> +	.ch_en_stat = 0x00,
>> +	.polling_period_ms = 0,
>> +	.accuracy = 16,
>> +	.polling_flag = ATOMIC_INIT(0),
>> +	.irq_en = ATOMIC_INIT(0),
>> +	.thres = {
>> +		{.near = 320, .far = 320},
>> +		{.near = 320, .far = 320},
>> +		{.near = 640, .far = 640},
>> +		{.near = 640, .far = 640},
>> +		{.near = 960, .far = 960}
>> +	}
>> +};
>> +
>> +static DEFINE_MUTEX(hx9031as_ch_en_mutex);
>> +static DEFINE_MUTEX(hx9031as_cali_mutex);
>> +
>> +struct hx9031as_data {
>> +	struct mutex mutex;
>> +	struct i2c_client *client;
>> +	struct iio_trigger *trig;
>> +	struct regmap *regmap;
>> +	struct regulator_bulk_data supplies[1];
>> +	unsigned long chan_prox_stat;
>> +	bool trigger_enabled;
>> +	struct {
>> +		__be16 channels[HX9031AS_CH_NUM];
>> +
>> +		s64 ts __aligned(8);
>> +
>> +	} buffer;
>> +	unsigned long chan_read;
>> +	unsigned long chan_event;  //channel en bit
>> +};
>> +
>> +static const struct iio_event_spec hx9031as_events[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_EITHER,
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>> +#define HX9031AS_NAMED_CHANNEL(idx, name)                    \
>> +{                                                            \
>> +	.type = IIO_PROXIMITY,                                   \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
>> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>> +	.indexed = 1,                                            \
>> +	.channel = idx,                                          \
>> +	.extend_name = name,                                     \
>> +	.address = 0,                                            \
>> +	.event_spec = hx9031as_events,                           \
>> +	.num_event_specs = ARRAY_SIZE(hx9031as_events),          \
>> +	.scan_index = idx,                                       \
>> +	.scan_type = {                                           \
>> +		.sign = 's',                                         \
>> +		.realbits = 12,                                      \
>> +		.storagebits = 16,                                   \
>> +		.endianness = IIO_BE,                                \
>> +	},                                                       \
>> +}
>> +
>> +static const struct iio_chan_spec hx9031as_channels[] = {
>> +	HX9031AS_NAMED_CHANNEL(0, "ch0"),
>> +	HX9031AS_NAMED_CHANNEL(1, "ch1"),
>> +	HX9031AS_NAMED_CHANNEL(2, "ch2"),
>> +	HX9031AS_NAMED_CHANNEL(3, "ch3"),
>> +	HX9031AS_NAMED_CHANNEL(4, "ch4"),
>> +	IIO_CHAN_SOFT_TIMESTAMP(5),
>> +};
>> +
>> +static const uint32_t hx9031as_samp_freq_table[] = {
>> +	2, 2, 4, 6, 8, 10, 14, 18, 22, 26,
>> +	30, 34, 38, 42, 46, 50, 56, 62, 68, 74,
>> +	80, 90, 100, 200, 300, 400, 600, 800, 1000, 2000,
>> +	3000, 4000
>> +};
>> +
>> +static const struct regmap_config hx9031as_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.cache_type = REGCACHE_NONE,
>> +};
>> +
>> +static int hx9031as_read(uint8_t addr, uint8_t *rxbuf, int count)
>> +{
>> +	return regmap_bulk_read(hx9031as_pdata.iio_data->regmap, addr, rxbuf, count);
>> +}
>> +
>> +static int hx9031as_write(uint8_t addr, uint8_t *txbuf, int count)
>> +{
>> +	return regmap_bulk_write(hx9031as_pdata.iio_data->regmap, addr, txbuf, count);
>> +}
>> +
>> +static void hx9031as_data_lock(uint8_t lock_flag)
>> +{
>> +	int ret = -1;
>> +	uint8_t rx_buf[1] = {0};
>> +
>> +	if (lock_flag == HX9031AS_DATA_LOCK) {
>> +		ret = hx9031as_read(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
>> +		if (ret != 0)
>> +			PRINT_ERR("hx9031as_read failed\n");
>> +
>> +		rx_buf[0] = rx_buf[0] | 0x10;
>> +		ret = hx9031as_write(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
>> +		if (ret != 0)
>> +			PRINT_ERR("hx9031as_write failed\n");
>> +	} else if (lock_flag == HX9031AS_DATA_UNLOCK) {
>> +		ret = hx9031as_read(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
>> +		if (ret != 0)
>> +			PRINT_ERR("hx9031as_read failed\n");
>> +
>> +		rx_buf[0] = rx_buf[0] & 0xE7;
>> +		ret = hx9031as_write(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
>> +		if (ret != 0)
>> +			PRINT_ERR("hx9031as_write failed\n");
>> +	} else {
>> +		PRINT_ERR("ERROR!!! wrong para. now do data unlock!\n");
>> +		ret = hx9031as_read(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
>> +		if (ret != 0)
>> +			PRINT_ERR("hx9031as_read failed\n");
>> +
>> +		rx_buf[0] = rx_buf[0] & 0xE7;
>> +		ret = hx9031as_write(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
>> +		if (ret != 0)
>> +			PRINT_ERR("hx9031as_write failed\n");
>> +	}
>> +}
>> +
>> +static int hx9031as_id_check(void)
>> +{
>> +	int ret = -1;
>> +	uint8_t rxbuf[1] = {0};
>> +
>> +	ret = hx9031as_read(RO_60_DEVICE_ID, rxbuf, 1);
>> +	if (ret < 0) {
>> +		PRINT_ERR("hx9031as_read failed\n");
>> +		return ret;
>> +	}
>> +	hx9031as_pdata.device_id = rxbuf[0];
>> +	rxbuf[0] = 0;
>> +
>> +	if (hx9031as_pdata.device_id == HX9031AS_CHIP_ID) {
> There is no way this check could fail today, is there? If you agree,
> please drop this (until more variants are added?).


This function has been rewritten in subsequent versions.


>> +		ret = hx9031as_read(RO_5F_VERION_ID, rxbuf, 1);
>> +		if (ret < 0)
>> +			PRINT_ERR("hx9031as_read failed\n");
>> +		hx9031as_pdata.version_id = rxbuf[0];
>> +		PRINT_INF("success! device_id=0x%02X(HX9031AS) version_id=0x%02X\n",
>> +				hx9031as_pdata.device_id, hx9031as_pdata.version_id);
>> +	} else {
>> +		PRINT_ERR("failed! device_id=0x%02X(UNKNOW_CHIP_ID) version_id=0x%02X\n",
>> +				hx9031as_pdata.device_id, hx9031as_pdata.version_id);
>> +		return -1;
> Huh, even if this if branch is only theoretic, a function should *never*
> return -1 if other exit paths return an errno (from hx9031as_read()
> above).
>
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void hx9031as_ch_cfg(uint8_t chip_select)
>> +{
>> +	int ret = -1;
>> +	int ii = 0;
>> +	uint16_t ch_cfg = 0;
>> +	uint8_t cfg[HX9031AS_CH_NUM * 2] = {0};
>> +
>> +	uint8_t cs0 = 0;
>> +	uint8_t cs1 = 0;
>> +	uint8_t cs2 = 0;
>> +	uint8_t cs3 = 0;
>> +	uint8_t cs4 = 0;
>> +	uint8_t na = 16;
> Ist there a more speaking name for "na"?
>
>> +	uint8_t ch0_pos = na;
>> +	uint8_t ch0_neg = na;
>> +	uint8_t ch1_pos = na;
>> +	uint8_t ch1_neg = na;
>> +	uint8_t ch2_pos = na;
>> +	uint8_t ch2_neg = na;
>> +	uint8_t ch3_pos = na;
>> +	uint8_t ch3_neg = na;
>> +	uint8_t ch4_pos = na;
>> +	uint8_t ch4_neg = na;
>> +
>> +	ENTER;
>> +	if (chip_select == HX9023S_ON_BOARD) {
>> +		cs0 = 0; //Lshift0
>> +		cs1 = 2; //Lshift2
>> +		cs2 = 4; //Lshift4
>> +		cs3 = 6; //Lshift6
>> +		cs4 = 8; //Lshift8
>> +		na = 16; //Lshift16
>> +		PRINT_INF("HX9023S_ON_BOARD\n");
>> +	} else if (chip_select == HX9031AS_ON_BOARD) {
>> +		cs0 = 4; //Lshift4
>> +		cs1 = 2; //Lshift2
>> +		cs2 = 6; //Lshift6
>> +		cs3 = 0; //Lshift0
>> +		cs4 = 8; //Lshift8
>> +		na = 16; //Lshift16
>> +		PRINT_INF("HX9031AS_ON_BOARD\n");
>> +	}
>> +
>> +	ch0_pos = cs0;
>> +	ch0_neg = na;
>> +	ch1_pos = cs1;
>> +	ch1_neg = na;
>> +	ch2_pos = cs2;
>> +	ch2_neg = na;
>> +	ch3_pos = cs3;
>> +	ch3_neg = na;
>> +	ch4_pos = cs4;
>> +	ch4_neg = na;
> na got initialized with = 16, then in both if branches got reassigned =
> 16 and then several variables that were already assigned = na above the
> "ENTER" get reassigned = na? This is hard to follow.
>
>> +	ch_cfg = (uint16_t)((0x03 << ch0_pos) + (0x02 << ch0_neg));
> This looks as if it should be wrapped in a macro or static inline
> function.



This function has been rewritten in subsequent versions.


>> +	cfg[ii++] = (uint8_t)(ch_cfg);
>> +	cfg[ii++] = (uint8_t)(ch_cfg >> 8);
>> +
>> +	ch_cfg = (uint16_t)((0x03 << ch1_pos) + (0x02 << ch1_neg));
>> +	cfg[ii++] = (uint8_t)(ch_cfg);
>> +	cfg[ii++] = (uint8_t)(ch_cfg >> 8);
>> +
>> +	ch_cfg = (uint16_t)((0x03 << ch2_pos) + (0x02 << ch2_neg));
>> +	cfg[ii++] = (uint8_t)(ch_cfg);
>> +	cfg[ii++] = (uint8_t)(ch_cfg >> 8);
>> +
>> +	ch_cfg = (uint16_t)((0x03 << ch3_pos) + (0x02 << ch3_neg));
>> +	cfg[ii++] = (uint8_t)(ch_cfg);
>> +	cfg[ii++] = (uint8_t)(ch_cfg >> 8);
>> +
>> +	ch_cfg = (uint16_t)((0x03 << ch4_pos) + (0x02 << ch4_neg));
>> +	cfg[ii++] = (uint8_t)(ch_cfg);
>> +	cfg[ii++] = (uint8_t)(ch_cfg >> 8);
>> +
>> +	ret = hx9031as_write(RW_03_CH0_CFG_7_0, cfg, HX9031AS_CH_NUM * 2);
>> +	if (ret != 0)
>> +		PRINT_ERR("hx9031as_write failed\n");
>> +}
>> +
>> +static void hx9031as_reg_init(void)
>> +{
>> +	int ii = 0;
>> +	int ret = -1;
>> +
>> +	while (ii < (int)ARRAY_SIZE(hx9031as_reg_init_list)) {
>> +		ret = hx9031as_write(hx9031as_reg_init_list[ii].addr, &hx9031as_reg_init_list[ii].val, 1);
>> +		if (ret != 0)
>> +			PRINT_ERR("hx9031as_write failed\n");
>> +		ii++;
>> +	}
> Should a failure from hx9031as_write better be propagated to the caller?
>

Yes,  and I have rewritten in subsequent versions.


>> +}
>> [...]
>> +static int hx9031as_probe(struct i2c_client *client)
>> +{
>> +	int ret;
>> +	struct device *dev = &client->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct hx9031as_data *data;
>> +
>> +	PRINT_INF("driver version:%s\n", HX9031AS_DRIVER_VER);
>> +	PRINT_INF("client->name=%s, client->addr=0x%02X, client->irq=%d\n",
>> +				client->name, client->addr, client->irq);
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->client = client;
>> +	data->supplies[0].supply = "vdd";
>> +	mutex_init(&data->mutex);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &hx9031as_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return PTR_ERR(data->regmap);
>> +	hx9031as_pdata.iio_data = data;
> Having a global variable assumes there is only a single instance of this
> chip. If there are two (or more) this yields all kind of surprises.
>

The subsequent versions use a dynamic allocation scheme.


>> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies), data->supplies);
>> +	if (ret) {
>> +		PRINT_ERR("regulator bulk get failed\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
>> +	if (ret) {
>> +		PRINT_ERR("regulator bulk enable failed\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Must wait for Tpor time after initial power up */
>> +	usleep_range(1000, 1100);
>> +
>> +	ret = devm_add_action_or_reset(dev, hx9031as_regulator_disable, data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	hx9031as_debug_for_iio(client);
>> +
>> +	ret = hx9031as_id_check();
>> +	if (ret != 0) {
>> +		PRINT_ERR("hx9031as_id_check failed\n");
>> +		return ret;
>> +	}
>> +
>> +	indio_dev->channels = hx9031as_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(hx9031as_channels);
>> +	indio_dev->info = &hx9031as_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->name = HX9031AS_DRIVER_NAME;
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret = hx9031as_init_device(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (client->irq) {
>> +		ret = devm_request_threaded_irq(dev, client->irq,
>> +										hx9031as_irq_handler,
>> +										hx9031as_irq_thread_handler,
>> +										IRQF_ONESHOT,
>> +										"hx9031as_event", indio_dev);
>> +		if (ret)
>> +			return ret;
>> +		atomic_set(&hx9031as_pdata.irq_en, 1);
>> +
>> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
>> +											indio_dev->name,
>> +											iio_device_id(indio_dev));
>> +		if (!data->trig)
>> +			return -ENOMEM;
>> +
>> +		data->trig->dev.parent = dev;
>> +		data->trig->ops = &hx9031as_trigger_ops;
>> +		iio_trigger_set_drvdata(data->trig, indio_dev);
>> +
>> +		ret = devm_iio_trigger_register(dev, data->trig);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>> +										iio_pollfunc_store_time,
>> +										hx9031as_trigger_handler,
>> +										&hx9031as_buffer_setup_ops);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
> I suggest error messages in the error paths of this function.
>
>> +}
>> +
>> +static int __maybe_unused hx9031as_suspend(struct device *dev)
>> +{
>> +	//struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	//struct hx9031as_data *data = iio_priv(indio_dev);
> Drop these comments.
>
>> +
>> +	ENTER;
>> +	hx9031as_disable_irq(hx9031as_pdata.irq);
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused hx9031as_resume(struct device *dev)
>> +{
>> +	//struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	//struct hx9031as_data *data = iio_priv(indio_dev);
>> +
>> +	ENTER;
>> +	hx9031as_enable_irq(hx9031as_pdata.irq);
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(hx9031as_pm_ops, hx9031as_suspend, hx9031as_resume);
> SIMPLE_DEV_PM_OPS is deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() and drop
> the __maybe_unused for the related functions.


Fixed.


>> +
>> +static const struct acpi_device_id hx9031as_acpi_match[] = {
>> +	{ HX9031AS_DRIVER_NAME, HX9031AS_CHIP_ID },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, hx9031as_acpi_match);
>> +
>> +static const struct of_device_id hx9031as_of_match[] = {
>> +	{ .compatible = "tyhx,hx9031as", (void *)HX9031AS_CHIP_ID },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, hx9031as_of_match);
>> +
>> +static const struct i2c_device_id hx9031as_id[] = {
>> +	{ HX9031AS_DRIVER_NAME, HX9031AS_CHIP_ID },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, hx9031as_id);
> Can you please initialize these device_id structs with named
> designators. (i.e.
>
> 	{ .name = HX9031AS_DRIVER_NAME, .driver_data = HX9031AS_CHIP_ID },


Fixed


> )
>
> Best regards
> Uwe
>

