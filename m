Return-Path: <linux-iio+bounces-27785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9FD1FC4B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AFD630A7BDC
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E538E11C;
	Wed, 14 Jan 2026 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="zvTTOuYx"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB92350285;
	Wed, 14 Jan 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404254; cv=fail; b=WMbCHTEk+2VszijRDU6OfRUYPTuIgJuqcptk4/xcXQiBLBC+zlI+RHfEna3AzSw5xQ4nsZXCxTAwDntCwA/v0b/EEi5UKgV8w2t0oh8mYv7URmn8hBXeQ4LqqQsY4u7lsyq5isqKA4mMZ3rqpE/viu36RUx2Xnun235pZnZXBXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404254; c=relaxed/simple;
	bh=TzmyemNPNfpccWVSFzLLe5fK/3GKDqGBE5UgZFTo/GQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGYKPBr8SX7UpeIUbN1Fk8K+UrHZ77T+ChIk1+3piAm+ycvTMrO5MEbC+Wt2+a1KP2+U+5cxB7qXhlcLFhAhPY+lScK8e44T+axIAeCnovb2kPV51o+4T0baGryXcDr74MoVt5vDzmMIubKRy8MtVOFcP1SVKBH+C8LSAaNXrOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=zvTTOuYx; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUYROqvJS5FCzk94cbODpSKoCkes6g70L0VNcK/yU1MbFwITFNb+OcDxUul3a9uIfRctdGG4Uw9FSZimkIezg3EPfF9G+QfiuBlktwPHtrJSE5MaHwle7fDaCpEY1veW6RnmQBUsTxc9PzpUc3+yKDKzMoB6EtJAJaJRiSGoPKX8x3g0izv/p3Ifb3cG9VIqXwVSdYs1QTpmUsetT4jq9up8UKIEbDbN0ZyP1THTpQkX63sDYJFUs2Z8l0NiaGHvEzMlc+VqJ2eeLOgn7a1wuwCnCsNkzkXlO/NEImJPH4yE4JyCGUmk0BJBmYLU9Zmn2dsxQSc6AbJlDriyyA6pEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZYayB7VoOq0wZElIdZr8X9XT2JrBTue11+beyubli0=;
 b=paLe7dX4zerEKHlRECGtMSrbhlbc7xVYp0RcS6Cs0MoSQ9m8E3PQ50brRt0hUPLYuBoxsNPJWKyl/2UnT+9NdxTAFxoJJ1tKs7doxlvbMoXrvqs4Xo4ybrtGlW+YGHWWQRofueN0zS6i5BP+56mIN6aAzhiIKBkrCPM9HPVu2bOhuupr+b22Qb7qsLf5uqgRSO+aHcNpNZwIO5VxjNasvPQU8ZiTFJBHxszgcULHcIMQpctNVpjl+AtTFXNLFjRXmWnbG5VcQdP9q/JbmAAKMzdhkA1VeZCg4oitTeBbz7q1/95661KwOEc4/SadFqFGFsJUbIszote9iDkiK/SOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZYayB7VoOq0wZElIdZr8X9XT2JrBTue11+beyubli0=;
 b=zvTTOuYx1wWuO30TBH7wdY8g4+ChQZN2+n+h2eR/zPaIEErFIfNYL69c9m3qEsh3jkn5FEF9bByYQX/dFFOnnjiOO+nqKCR13KqWKV8m7RWWIhIxmdalDtPMxedakWO3AtNtlcyy20Oej3PNiaSl3vwdzwAmWINrFPPqwCHYPuXwt2bSsd2BuV1vZWeGuFUQA3iPh5HGFc6gOSZ16KxtgMBvwNqAmcJALs1VbetG9w6L9Ey7HOGcg1t72cqqUx0j1wnQOvsrWycqkRVAFV3OESYSw3sx9pPH3llsCWP7YAyglTkuuEttL+9k2dL6YcuknGh0jPuL9frpnhy7XtBfSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10381.eurprd06.prod.outlook.com (2603:10a6:10:61a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 15:23:59 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:23:59 +0000
Message-ID: <68cee45e-4822-41af-a0da-d1b88166425d@vaisala.com>
Date: Wed, 14 Jan 2026 17:23:55 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
 <34e97dbb610e82953657d8354c0a343a9e1fa57a.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <34e97dbb610e82953657d8354c0a343a9e1fa57a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0000756D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3ef) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10381:EE_
X-MS-Office365-Filtering-Correlation-Id: afb28af2-2d3c-45fd-cdaa-08de5380f094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnFZUWp0cHMrdlRZaGQvNUQxbFZZR1pENXdwRHExZ0QybzJFbElIOW5EeERq?=
 =?utf-8?B?UVFIK2VVdlFzVzZWaVRSUjRyWE03T01IK2tHVHJlUEJUVktjRVdEcFRCc1h3?=
 =?utf-8?B?cnVNaWRMbHVkRktzSnRaUk9sYi9pVVVGcWpXbkpmQlg4R2pMTDBVc3d1VEpu?=
 =?utf-8?B?UlFpMTRreTgrTGRURzVEdnRFQSsrdU9jWWJTVm02STNjeHVINlB4dUVqYmt2?=
 =?utf-8?B?OHpWYlU5d0xzdEpPSkpJUjl3VDMrT25pL1dDVFRIZjBuVHFCZE5wanVRZS9O?=
 =?utf-8?B?Z0VXSkY5ajF0RmdvVkoxL2p1cHlYYXZwa2hKV1RkVmlqUUk0bVBjL1M2QUU4?=
 =?utf-8?B?V1BDUk5uc1FITWtkQ1dxcnpVMU1YejFlUUFrLzlJOHpLcUlTaHBFWVZCTVpj?=
 =?utf-8?B?aXRKc1VaYjZHT2tXVmRVd0dCcUM3Q25UYUp4dm05TU1nb096TFZGOEJ3ZHZS?=
 =?utf-8?B?SzRVRTlaK0JrUUg5TVc1SCtlVnIwRlkvWTFkTTVaNnZxbW51QS9md2VvRVJN?=
 =?utf-8?B?VFlDaExlTER4OGFUelVGVWYrQkVXSDk3UzRWbjdJVExhRWROR1pYeUlWK09u?=
 =?utf-8?B?TTcvZldlamhGR1pVRUZJcjlCaXA1akU5YWt3SW81d3Z4NEZPMWthWVdSdFlJ?=
 =?utf-8?B?OW5ENjNmMnU3Nyt6VHhsdkVWTWhjQXhXdzlrZFhHT2RnWW81K1c5R0NPNXdW?=
 =?utf-8?B?amxWUHVCaktLVVNLc0c5SHFkUk5CaGlPRm52OTVtd2J4Y3JMQzFEVmtJUm83?=
 =?utf-8?B?cSthM0xZdG5RV2J0Vkp3dVhVTURLTGF3eE5kbGYwMy9ndGM2QlJBOTJkakFt?=
 =?utf-8?B?cGIzQVBpS1VRVFhrVEM5K08vMDdTanBNOGVNZXQ0dEE1Tm9DRjMrc2pyTmg0?=
 =?utf-8?B?cTlhRXF4S00zSWRqcTJnc0JnWU1UYnFvMTJXSVdNRjh3V0phM2ZRWW5uSFlQ?=
 =?utf-8?B?YkRZQnZBbEk4ck1NdDhkNUZISG1lT3BRdUtFRURqeUdNNjN4TCt4VGhnbmJu?=
 =?utf-8?B?WXhOcm5oSzZBUUliZ3NBcnhrMjhpQzFpT0xrZ3NWQzFJVEM1N2d5SmVwWGdP?=
 =?utf-8?B?eHF1VWJRa2ZJOCtxTDZHWkVJRmxXNzFhTlA1dEtRZkUyWTNxU3hVNnVjY3l6?=
 =?utf-8?B?UUlLaFpPbU50SW9JOU9TTHVWRUpkZVR1NDZhQmtFempWbDZSbnUzQmlCaW1M?=
 =?utf-8?B?STYrTWVkU05JNzdJRFVMcHZvSm15aXdrVXZ2LzczV04wc2tSbWJ6enBFeGl5?=
 =?utf-8?B?T01SRHMwYjg3eEVuR2tMbzBqazlWcDBXLys4aVZLa05iaDdteFJSbGRZcjhI?=
 =?utf-8?B?bGZEaXNSOFUyZFhYVk41RnhFTjVIdnN0N080bHQ4Q2picmYxdFBNVE8vOXQ0?=
 =?utf-8?B?MkhlMWdjbUlKb01sVGdnKzBNbVcwZlM2enl4OXoxdHJweFdHMDNDajFSWjFU?=
 =?utf-8?B?T0x6WERzL2g3UHBjNU1Xd2NSVWFrdlFjZEt6bm04T3RBVEUyb1pYVXduWEs2?=
 =?utf-8?B?Z2N4ZERTb2tDclFDZEdhZDQyUkJsbmJ0T2c1clpQbWlFR3pucjBzUmoxY2xt?=
 =?utf-8?B?bERlTzlOZHZLWC9BblQ1SW9mV3ptalNWb0lXZ3N1bXZnOG42SVEwdGYrVnNj?=
 =?utf-8?B?TVZsU1JYVFZUOWtyYy9aNXJlVHNsTHZCS1JXRmppYVZ3RTRCWFRIOS8ra1FU?=
 =?utf-8?B?QU5VS09OT2tucTM4QzB5YVVTcHNBeTM5YitYZXJlckpkc0MxR0pzaE9pQzhp?=
 =?utf-8?B?cmV0M29ZUDFDcmhHQ05DWUxLblNnM2lkVXZDQmZ2SHdzdk84T25iK3NNck1S?=
 =?utf-8?B?SFl4NnhaR1V3SWZ5Y0o5ZUUyd0JXeWVQQXhpbjBXK0Q3NGFXekVCOUlzVDRr?=
 =?utf-8?B?dE0zM0dWc0EvL3NXMEdSaVZOMnlpdk5nR1owQTRXVkpoaW1PVEF3UGxLYTg1?=
 =?utf-8?B?a0hjM2dMZEgydGdoY2cycjVkaDNUeU40ZVlINmYxTWxVc2lINk1ENWNyOXhY?=
 =?utf-8?B?M0tEemlSd096RlZncWNuWloxRWlrVXBvQkxZNmpPejh2b0JFbFVXOE9DQ3VS?=
 =?utf-8?B?M2RVRHZrTnFzOW9YSXZXVC9XVGVhb29OeW5JMWMzSDI0ZWdRYmFXTUllYWdB?=
 =?utf-8?Q?BQXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0h5WEFMUUlId0t4V2FPdG1aZHM3Yk5NLzFHcksvbDQ0MTBHUnJIalJSU1ky?=
 =?utf-8?B?UXFOaXowZGVvMzg1WnMrdTlRcElya3J4MVpQK1dSY2RhaDNJdXlDRlhPcVV4?=
 =?utf-8?B?aXVUUUh6QXVNOFJUTHYwaDVGSG9qWHBrTGcvejR5c05nQm1OR2NpWTJLSlFz?=
 =?utf-8?B?S1FnQm0xN0RxMFYzb09BRUhyMk9mVlZCU1c3K3V6YkRLR1RFaHJieUxZSkdL?=
 =?utf-8?B?MWY4QUJwQ3RIOGhEZmZKYjVzQmtXMjllSkYvOEliWnlYZjh2M0txdUVrdWJr?=
 =?utf-8?B?UmgweEUrRE96NE9DR0YyTENwNXIybUJRaGFFNlpQeUFSeTNWblFBOGtRNWly?=
 =?utf-8?B?RDRiR05CNm11QzArK25INzlqQU9mL0dXc2hJL3h4M0xqQnJMMlhyQTVEY2xU?=
 =?utf-8?B?by9HK3BwbTBtNWVwV28yeDM1b1pMRmtnaWFJdm1NUzJRSmFaa0RZcVQyQ3lT?=
 =?utf-8?B?djdaRUVqeDR0K1RlTWVQMGtYVHl1L1hRYitQNnZpTVJyYjU3UTdkZE0zRTZ4?=
 =?utf-8?B?SStZTUY5QkprTVNIOG0yNEM1NDEzMVF4WDhrZ1pIa3VMUldLM3pNT1htMTVX?=
 =?utf-8?B?YjBtcHlnUUREdHk2ejRsNWxISlZRQmxwanNBRFVoWkxvcHVKWjN1ODFIWlBU?=
 =?utf-8?B?K2luVzlJVnVOSldISXdET21iaEhDbDlzcCtYVGoyckM3bUVBZ3JFOUo4VUFz?=
 =?utf-8?B?ZkhJTWZkS2NjSXJPVEdOcDJNMEdQaWtNOGFEUXdYZkdsV2lWMU9JczRubVBX?=
 =?utf-8?B?WENMN3R5NTJNSEJGeUZWSGE1azdGb2dERzIxZ0Q4bmdweUk1akp4U2JrL3Iy?=
 =?utf-8?B?dFhCSmtuOEVUSW95a2tFS3BwMUIwVzNocmw1cEI0Qjh2bTB4aFhLeTRON1RK?=
 =?utf-8?B?UGwxbTh4a2V3OGhGZU5qVGljcFE2V2ROL0lPaTJpVys3Mk1jR3Frb0R4d0JB?=
 =?utf-8?B?dS9yU2xwOHBNekl5WHR4K0IzdnE3S0VDOWNlZXJLd2JCNW5PdVN5Tk12bTFQ?=
 =?utf-8?B?ckVjbW5DeEpycUJYcE9hYTc2anJMdndHdGp0c2pPVHRtTTJ2K016RGc2MXpY?=
 =?utf-8?B?NFI4eFVNNWNoeElOLzZESGpaUGhISFZPSDhhTEE1TlZxaXozSXQwZkhVMWpj?=
 =?utf-8?B?Wm8xMjZycGdMWnhHMThZeDZGb3J4dW8rRUlFQ3AyVHBSTDFEK01LdWVsSmF2?=
 =?utf-8?B?K1MzTTRLZFdsNmRDVDZNVXdmNndiMGRtUk9vYzdEbFV3NDh6OExJcDhDSWZI?=
 =?utf-8?B?Zms1WER2S2p1SzV6dGZMZFFneUZMUTVxU2IyL3k0U3JqM2pTS1pVcUZhN0Zl?=
 =?utf-8?B?aXdpR0JYMWNQWnMvTkdhSzhqWElsK2cwV0RzZm92K0FnNnZJZks5aEI2SWQr?=
 =?utf-8?B?VGZ2eUtBMTBwRWd5YTIwUm0xWnVzeDlwNVhDd1N1dndpZlJMdUpORlgrTlZv?=
 =?utf-8?B?Z3gxWW82UnNYYnhYU3pzMTljQUxLL1VMRG1pTTBKdXFvR2NpZzRoTEdRR1dj?=
 =?utf-8?B?UkdpaTJBczQ2cE81OS81OU5odHhrZHNMQmR3Rm5xcnRIZkR3eDBlek5EV3lH?=
 =?utf-8?B?bmNJZVZKMkhZTHNzMnMyTDREOTQzSGFWcUNqbTY3dFMrVmJHeFg4ekd6SFhx?=
 =?utf-8?B?Y0VCTHRvd1c3Mm1IdmJONG1rd0dFWG16TTlyck84Q1AvMWlhMlBwUXF6NXRu?=
 =?utf-8?B?ajBSYUQ5WDBJN1g2a01ZZVlxdldxZjZLOVcvUmFiKzM5TEFBbnNzeFR3TW9M?=
 =?utf-8?B?K0J5SmlSdmZ3RDZHc0pNek56WDdZN29lZkJiM3piMklPRmR1dkNvSWJkNjNs?=
 =?utf-8?B?QVVOdkROaXQyUHAwSkFud1BTUVBVRFJqZHN1bHdQc09rZzlIdWJEMmhuUS90?=
 =?utf-8?B?ZytlR2d0QWduWmFFekRaWGpwNGM1YWhvL0cyUTZzblllQm9aRWgyWFE3SUtD?=
 =?utf-8?B?c1ljWFhFcW9IbVFHOUYrUzE2bzVyd0l2emNyK2dhcWxmak1ISmhnV3ozZVBq?=
 =?utf-8?B?TFlXVVJDVnpnOWNhdnh2TVg4dTlDTWI2TUxNbU05cFBEdUwwS0JkSktCN0Vh?=
 =?utf-8?B?UE9CeDZrbGtvRnZCZmJOTW5QVWNZZlZmaXdMRHBzRFNrYmhOUFJMR01iU21V?=
 =?utf-8?B?WmtaRWRNd1dRaWljZ3I5eEtjeUNYKy9VdFVyTVFGQTBveEZuWURZSkRLUXJN?=
 =?utf-8?B?RzIydU1vWUsySVVNdFNramc4c0xRMmVXU24zN0ZtaW5HWHBtOGsxRkhMckJH?=
 =?utf-8?B?aFhkM3pyTVk4dENZdXFpeWNodzdFNnJMRXYxVjJUOXhmeWZVTXJ3a1dGRVl4?=
 =?utf-8?B?WlZPRWlOcG01aCtnckdGMElrU1V3cDhtTW12Ti9NQzJ6Nm9PZUdaTi82dVFh?=
 =?utf-8?Q?pylPvzMnplQjNitA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb28af2-2d3c-45fd-cdaa-08de5380f094
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:23:59.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGlS2YzUUtpQv9hLQqWu2SbD13LvG/vH3Vw214kSP8nsclnRvjvVXNnbSynoOP3SFJeFe93kf0nGej8wnJUP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10381

Hi,

On 14/01/2026 14:29, Nuno Sá wrote:
> On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
>> Add capability checks for operation with backends that do not support
>> full set of features, but are otherwise compatible with the device.
>>

>> +		return 0;
>> +
> 
> As David suggested, it might make more sense to do the check from the callers. Not as
> important as within the backend functions though.
> 
>>  	/* all points invalid */
>>  	bitmap_fill(st->calib_map, st->calib_map_size);
>>  
>> @@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *spi)
>>  		return ret;
>>  
>>  	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
>> -	if (ret)
>> +	if (ret && ret != -EOPNOTSUPP)
>>  		return ret;
> 
> Don't agree with the above. I would prefer to see a dedicated CAP for buffering
> otherwise I would argue why not doing the same for everything? While it might
> be acceptable merging IIO_BACKEND_CAP_TEST_PATTERNS and IIO_BACKEND_CAP_CALIBRATION
> (given they are related to some extent), that does not apply to buffering.

Okay perhaps we first need to agree on how we define a capability;)

So my thinking here was that calibration capability expands across
several or even many op calls, so it's a feature level thing and
requires several coordinated functions. So does the test pattern, but
it's a sub entity of the calibration so I merged the two together. So
checking for a capability in these cases makes sense, since checking
against a single operation call for determining if the capability is
present is not easy and which function would it be, etc.

The backend buffer on the other hand maps to a single op call (in theory
two). So checking for that buffering capability can be done by checking
if the op call is supported (eopnotsupp). I was kindof thinking that why
need a capability if the mapping is 1:1 and the information is available
through that error value directly?

On frontend level, like here it is known that the driver can function
without that buffering, so if the backend does not supported it can be
okay to proceed.
If we add a capability for a single operation that has 1:1 mapping then
basically we should map all and that is not really the point?

I see the capability like a contract between the backend and frontend on
feature level, that the feature is there but the implementation of a
specific capability might actually differ depending on the use case
(like we see with ad9467 and ad485x calibration and their backends)

What are your thoughts about this?

Thanks,
Tomas


> 
> - Nuno Sá


