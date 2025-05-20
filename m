Return-Path: <linux-iio+bounces-19740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDBABDCCD
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845CC188CEBC
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417A248F63;
	Tue, 20 May 2025 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sBxPiVim"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39102243371;
	Tue, 20 May 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750996; cv=fail; b=p8kHc7D24EkLuhQjEpCsimprFgquuY9H2lCITX1YgA50a4Eaj6smGilIMEQX9wSNSncYPiMTiTJU3QFv/NTgNTDkClxFwqoMsNpvoewBm3qQ75+yO8sMLKA86DuRwpbEv6Qw8fWpw3El8/Ls5djN0CTZxppSkrXrzXl1caguY6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750996; c=relaxed/simple;
	bh=/dQ5tLqLnZZOxMuZWju/JXj5s/CPMFaUdgtzJVLfO8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PEa6+GyHLbv9IQtvd0zAxJn8y8KKxNg9yxgXBrWXVNdT02inTu0p4AYshWnXDUimQmmQ2PxPCbTUtBDFUJMvIXZs2HYPxPlVc+xVUkVvzLa/PhUM0lunEEXwguD7lr1mtalxM6rmgYWds6+LMNm28KiFzKsxLRFRNhVcQuBOlq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sBxPiVim; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSlSIMIVdMtq074fodOf3ZESkIiJ9dhZ/ukrpB1gJ1nBv2mC7yTRVkZODqZrIs/6NUj3TzQjqjtgLvViaRmAE9bxaji9Kk+L0/cwupzx+Se6lqKSo2I3qg5Eb9/+DR02ApzX7iTuZ40WGMgAdloHZmb0R379WyZtk/cnw9iq+Il0zfzDSofHAk6mVnKJMVO96ymOd/rwRpyB4xuc2Q2kSQqamgZzn+CMebpHHURXvFyh18QNe9u14kTqz+XT9VMbb3fGaRyA+ecPAC3BCOLvlg2ftidPcsEo25wh02ox4U9jVbYphQTrDZP49sQ2w45xPyxhvjhTeFR5hGC5kxDBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dQ5tLqLnZZOxMuZWju/JXj5s/CPMFaUdgtzJVLfO8M=;
 b=n++MBPtRd6ix1OqbB+FTnjeQz5Le7tNM8WAz2RkHz+jEmtwTMA0wrOU3MEs87Qa8StyfgvriuWs3x+dQUKCbrOTw6/j20VnQl38mF3tq0qnv+X5mse4SQBIeQD1hf+u61crQag07iLwu4BX182iG9ag9WSckZNKojRbGXIs+PYJ/no5pXm68KYKWoWFqzNdzO3CI0DZu0CMMPKuGg5XMp5IfjC4Rz2SttAmK0YhaXk/6BkxPwwNHMLQPSKuwKyF1Nau3ebXNMUl/xcbFgv0dV7iBrxAnpeZsc33twYe8PiooZD89dfE1F+6c7fnMtH6qMKUVEQcjERz3b+szQ62NDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dQ5tLqLnZZOxMuZWju/JXj5s/CPMFaUdgtzJVLfO8M=;
 b=sBxPiVimdIWePI3AYt0XORtjuJguT/PWdXTQ8tNjEhVkbzZ5D2mAq03JMNWxMGNHmRA82Eg1xk4wbRcD7mbq9Kh7eo9cPU1Hb6xOLAX7rhe/LBqTNjMKvm6DNpWK19ZhsbCiXrKgv7+dpKydW6+pmZNiE3KI560+eLoUoC2bN9mmtNnCQNcmRXzBv1Lox2yKOqTVQM37QqRoNMu5LgIPFV3mECzyL+FO+TfW/gzG5gqF5nYeAcCQWYg6qrgg85MCbgUfTFQATKQBYi9+y/A3vM5dB6DZlrS+aV8KQIlvSzcgdSjags3zCZqIxD/6vEqiOu8uc62eLgiR28/lTBmC0Q==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 20 May
 2025 14:23:11 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 14:23:11 +0000
From: <Dharma.B@microchip.com>
To: <wbg@kernel.org>
CC: <kamel.bouhara@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Topic: [PATCH v2] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Index: AQHbyTyx4y4oi/BWI0W8VrDH78iOXrPbaVyAgAAplwA=
Date: Tue, 20 May 2025 14:23:11 +0000
Message-ID: <8335a35f-e111-4a53-83ac-e671d570dace@microchip.com>
References:
 <F_LcZtjhYzQUlCmEka_20DiefdWFYYoq-u3JOct5ctrcMrJfTi3APjAWNAK97Mpluwkqgr9rQ-35KzO0Uuifow==@protonmail.internalid>
 <20250520-counter-tcb-v2-1-a0617d2d220a@microchip.com>
 <aCxtaya-1SXkPiob@ishi>
In-Reply-To: <aCxtaya-1SXkPiob@ishi>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|CY8PR11MB7779:EE_
x-ms-office365-filtering-correlation-id: 6ae82837-5e90-4eff-30eb-08dd97a9d991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXhQSkhkQ2NFOVJDcnNJelJoWWZ5MFF2OFY0Si9UMTFNTEhJSzMrOGw4K3oy?=
 =?utf-8?B?RFA4SVFnYjBJNTlLQ21VdE15SlRhMHdYblF6NTVwTEdqUGZ1ZWhKeGhLK0tn?=
 =?utf-8?B?b0FuOGZJSmk5cktVRGFzTERrWHdDSnl6Q0pjUSszSDlHSVc4WSs2d21zaldY?=
 =?utf-8?B?YU5OU1AwYXJYejRYMlJhRUQySXIwZkNsdldYVmFkOUpxdjVVWFVtNm9lL0c1?=
 =?utf-8?B?NnlZUzFzSlFIRmFORW12UHNrYitXdDM3dzhxa2ZyTzkwTDYyS1E0NGNwLzF0?=
 =?utf-8?B?cURNVWhvQUhIQ0EvR1UvV3FmcHpHZm9pNDRYdTdrUmVrZFNSRXBaNDRiS0lQ?=
 =?utf-8?B?K0RlUW4yaS9mbUNqWkxnR1pWc0Z3QUhlWGlDRi8yalFubnpBRmpaNktwSlZa?=
 =?utf-8?B?TmlrRGFYakhaMkZoMzZsdHBvU2RGMU5rSXFWQU55S0VKOTk1eHVacTJ1Lzd0?=
 =?utf-8?B?NTFGZS9ST3U3alBqOGRlc3hVTTZQQlpXTi9aZld6dVBZMkVFWXNmS3gzMzEx?=
 =?utf-8?B?Uk1JNHlkU3dPdnh5QWVSenBKYVhXNFJoSzA4RTRUS3gwV01OTVlTN0VSa012?=
 =?utf-8?B?am1ZNDdUK2R6WkJ4b3N5YUVCYWtzeGFnWGFOZzdtdW1RZ1MweGozdXJFcko4?=
 =?utf-8?B?TWIyc1YwMzJudzRnV1ZmMnN1YzBNZ0xWdzF3dXIwOFdlVnpjSW02aUhKRGlJ?=
 =?utf-8?B?SkMybkNhSGFwVEc3UTUxRERCRk9jK2VGMDdqdnVRT3B2cyswUWhtWWdJekdL?=
 =?utf-8?B?ckM3ZFQ4emZjU3FiYnBlQUpreFVNOHF0SURNRGxBaWpyYndLM1BlMXVBVkp1?=
 =?utf-8?B?R05nVlR2K3I4cldJSUlzL2w1aUo3OWJVVEtRL0hLMDZ6azdqQXlnR1dhbk9T?=
 =?utf-8?B?RnZKYlRqQWI5bHo3a29MZ09xSzkycjczV2RXb3ltbTNkQ0V2dUNGbFo5WXJP?=
 =?utf-8?B?cms2OS81OG9CaFZJTTlpUEc5VzdYc3FqbUVZMEs5OFpheGkyZFNZSkQzamdL?=
 =?utf-8?B?cVpqbGJwWkcxZXNJYncrQVM3TnMrQWpTVkdheFJhRVpRcy9mdzc4YVJEZkNu?=
 =?utf-8?B?eXJNbkJvaXNJaTZTS1EvVG5SdnVuRFFPM1FjSXFQMGVxSExOYjBqb000Yjdo?=
 =?utf-8?B?dSsyaDRTMGdyY0w3bWtTMVJPbWZDMlNkYUJmSDMyMGxFMG4yTkpCOWtGUW9t?=
 =?utf-8?B?alRsaXUrOXl6MzlUMldJZGxjaDFFc25tK3RmTzBkc1pWZlJYTGlLU0c2T1RR?=
 =?utf-8?B?Q3JZMmFpMVpyZ3kwVGp0NWlnQkhIeUZUaDFlaC9SZHlMWTYxVXQ0SVRIRlEz?=
 =?utf-8?B?aUovWWtuNVNjYnZyLzBxOU5HL3ZGNFdMRE5YQnQrSElnV0hCc1hwSlJTeGNN?=
 =?utf-8?B?UjBPWkdWM0Qxb0g5RlVmOTlSZ3BFUTdHTFpZMnhhWS9EU3IwRjlDWm4ybTBw?=
 =?utf-8?B?dlA1dEE2K2FTd08welN2SWNiZ0ZPN1hXdWNZNmNKZDBZOGRyQjFmaUhOWlo2?=
 =?utf-8?B?dWN2a2grcGI1dGwrYmUwTUhHcHBhYUM3NEVaZ0tHanp2RkUzalJ5dDFxMVoy?=
 =?utf-8?B?aGJaUE5DWjVpMlFpZlZmZHk3c3BjeHRmRElRK2I4MkthS01jcTYxTHlyaENQ?=
 =?utf-8?B?OFE5cmh4TTlQdWkwMHhQQWxtVXFVMlU5NFQ1VjBuZXlxOFZ3MDJvdFJOa3BL?=
 =?utf-8?B?ZlQybUNjcTR1c3czWWkrc3Noc21lVjFKMFVpa1cwWTQzYVJ4YkVwMStCSVk1?=
 =?utf-8?B?aDZQc09DQlJjU0hvZStsc0dSUWtWZGdHUEM1N29hVHlmMGxwa1pIelNWMFNH?=
 =?utf-8?B?ek43T3FXRnUyS3pIQ3hhbHM5eHdQc3BuYnhwZlVzeGEreDlIWXFMeC81aDdS?=
 =?utf-8?B?dGZBTHNWMjl6c1FQQ2J4U0VnRTByeVRoVEpUSll1WlFQSXdaK25qeCtvQ3Bx?=
 =?utf-8?B?SjhBWWxPMGlpSXdMRGNsTVZNYkgyTDZPczA0d0swa3hobldXbW9SWlRuTTg5?=
 =?utf-8?B?NTdQN0FRZTVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MitlcTFyVUF6VjFuTW4rRmdMVXA5a3ZYSmxsQjZFOE9PY3RqejhiSDZzTG5q?=
 =?utf-8?B?bkZyRWRKRUM2bEJESXVhV2Z3UThUTktaZFVESUZZalVYd0lqd1E4S2ZQa2RT?=
 =?utf-8?B?OHlHeHBIWGU0SisvaVVSTzJwT09aMGZnS0ZWUnJLT0Y0endSYVFnWmhHUXNR?=
 =?utf-8?B?ZkxQZzNIM1E2djRjNkpjN3M4T1JHa2dZMXJkZENBUzJzV3oxSjh3NVJvVWQ0?=
 =?utf-8?B?TkVLSnQ5N0pnUVJ4ZzhWMEdUUVZVMURuZHlvNXAyVTM0RHlvVTZDMTlZZHhD?=
 =?utf-8?B?aGRZTHFpcWpYbUxjc3NRaDhwVm9sRGplczg4ek5BRnVwOEFOaW8vNlMwdGFQ?=
 =?utf-8?B?VDRqL0VrZVdlc09aRmo5cFBINkc1T2VidXVjeC9LdjloR3I4NGRMS1hiVnFI?=
 =?utf-8?B?ZXdhTXJ3NkxCWmd0MmplUVNpcnovMnVRSjl3Nzg2ZEhvbEg5N0dkV0ZqZ2hR?=
 =?utf-8?B?Vkl5K25DRFh5YWg0d1FZSTBudVZIaXVUanF0a1lFaEpNbExydGExcnNTc2k1?=
 =?utf-8?B?RWs3Vko1cXN4T2E4SERreE0vQmQxdkVGN3BlRDI3S2k4eDN2SU1JcHdQSTNC?=
 =?utf-8?B?OWxjb0RndUFyeHArYnVLWVlMdi9TRmVlK0R1SGdJdDNkeDloeVdSMGZyUk1r?=
 =?utf-8?B?VW1aaWxFVm1lNlMzbEtEaVAwcVhkRUFSRnhwQ05oZEI5UUw1QlM3RVJxeTgz?=
 =?utf-8?B?eEFUckFvNjZrcktPcmNIUFVSUGFUaStTZ1dRSFpIV2g4ZDlaMEhicysxVGQz?=
 =?utf-8?B?U1FEQTdyRFQ5TzZ3dUxSeit5am9DQzhnMG5MbnRWdW5OQndxbWZHcm92dDNV?=
 =?utf-8?B?MElpcGl0MStEdFpBUnkvc1FHNzQ3L2hpL3hVYVFIeHh5OUdLVlBheS9lUy9U?=
 =?utf-8?B?aWNGaTBpRjlJczc0ckRITFZxRG9mZVo0UXFxKzVnK2JydWl5L016MWk5RHRV?=
 =?utf-8?B?WEs4ZkRvUkh0anZ6N1VxUHV2OHVOWmR1b240c0NSbUlEb3R6WkdjcC9xRUdV?=
 =?utf-8?B?STgrTlQ4bHRuYjgrcU9SbllzeStpdVhROFVETUlGRmcxemV2SXZkOXVNOHNZ?=
 =?utf-8?B?amRPaHN5ZStrZkhHQUhOenZLYWJDOHF6dVA2YXpraTlSamlMYUNnb2FXSGQx?=
 =?utf-8?B?YWcxZnZFc2MwUm0rODBhdUdhL2ZGZkl3YmRjV1ZsOWRhQ2puWVJwMS9OdFg5?=
 =?utf-8?B?WW4vcDRYbFR6M3E5TlJSOXhXZ2pjNXJpTnBmSkc5ZlpNVmZJdFpaUmpMbnBB?=
 =?utf-8?B?WVM4ZFMzclhsQ1phUUVrN20yRzhFWmJCUEZQUjF1YzlzZVR0NWZJMW4vTVc3?=
 =?utf-8?B?SHBvK2hFQWUvN3BuQ2k0UnlZL21YYlN3MUVZTVBLUXJ2bzhPMjhHdXFtcUxB?=
 =?utf-8?B?ZitZQmtZQ1lCUTJiWHBMVm5ZcklCQTBYSGhIcVUvRG9OcEY0Njg2SGZkN0pI?=
 =?utf-8?B?NHpnclVXMzZwWmFIb0txbFM2TnVHN0hSYXA4M0VZZVJWRXR4Lys2ZUxwYURX?=
 =?utf-8?B?MkNUdFV6ZUhlVUNxT0tiNTA4ODN1SWw4NjJ0N01OOHpKNTZ4S0NMelN2b21s?=
 =?utf-8?B?MmJZZWRzbFpNSVlrVnE2cnNyQy9yT0Z3SXFrK0FWV0daSDBYajFKWEtGZE52?=
 =?utf-8?B?SWNEUEkzY3JKQ1J6eFZzL1VvOHA3Z1JBOFkwVS8xVjk4SmhHQ2lUWmNsTUhG?=
 =?utf-8?B?VDljbkxOMGFDU0xndmw5VHZWdUhrSk5kUUVBVWU5TDBVTFVBQ3BQdCsvdDVQ?=
 =?utf-8?B?NHFVZ0tGUmxZaHdvdVpsc0kyRGdkaEdsUVVlYTRWeUQ5UjFnOGgzd1ZtanlK?=
 =?utf-8?B?d2hWNXN4Z255OURGbVVobWxnS20rcHR2OE9PR0NJWFFkNlBxRVhxRzhQWUNS?=
 =?utf-8?B?N2tENmFRTGduNHRxUkxQRXkwZ2dvbDlyaUh6SWdOMENYaGFjNE1EUFdzSG1O?=
 =?utf-8?B?WjJJRFRlbWN6b1B1akI3RHg5YjNBcFdhTmhReWVnMjJCVytNcmJ0M2R1K0xp?=
 =?utf-8?B?clpsR1pSVTBjQUV0RFZkcXVVZUhCR3hLeUFybVNieFZoeXdQRzliOS90SXdT?=
 =?utf-8?B?QUZsSGVZTDBua2dQNXBzTWZMUmFVaW1BRmt3ZlBHb2gybXJEaW1iNzkxbm03?=
 =?utf-8?B?QzJYNXAzTG50enh6ZGp3WWV1M1NldHB1RU5kMEpFZjhackhTazEwdG0vcHBl?=
 =?utf-8?Q?98DKD7LKj49Qik1YP1MbA15hxYRtbjSDqiURRA0Iu0G4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9495BDD1A799541B19A85AE2D20C54C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae82837-5e90-4eff-30eb-08dd97a9d991
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 14:23:11.1524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ot+BJpU+B0KisES9oAbgPwcjrlMcBLZCCKPpID5ge2n6g52Y3fQZz1rEHkC6aeQdoXexr7jfq+a6NfkzOCio5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7779

T24gMjAvMDUvMjUgNToyNCBwbSwgV2lsbGlhbSBCcmVhdGhpdHQgR3JheSB3cm90ZToNCj4gT24g
VHVlLCBNYXkgMjAsIDIwMjUgYXQgMDk6MzY6NDJBTSArMDUzMCwgRGhhcm1hIEJhbGFzdWJpcmFt
YW5pIHdyb3RlOg0KPj4gVGhlIFRpbWVyIENvdW50ZXIgQmxvY2sgKFRDQikgZXhwb3NlcyBzZXZl
cmFsIGtpbmRzIG9mIGV2ZW50cyB0byB0aGUNCj4+IENvdW50ZXIgZnJhbWV3b3JrLCBidXQgbm90
IGV2ZXJ5IGV2ZW50IGlzIG1lYW5pbmdmdWwgb24gZXZlcnkgaGFyZHdhcmUNCj4+IGNoYW5uZWwu
IEFkZCBhIGB3YXRjaF92YWxpZGF0ZSgpYCBjYWxsYmFjayBzbyB1c2Vyc3BhY2UgbWF5IHJlZ2lz
dGVyIG9ubHkNCj4+IHRoZSBjb21iaW5hdGlvbnMgYWN0dWFsbHkgc3VwcG9ydGVkOg0KPj4NCj4+
ICogQ2hhbm5lbCAwIChDT1VOVEVSX01DSFBfRVZDSE5fQ1YsIENPVU5URVJfTUNIUF9FVkNITl9S
QSkNCj4+ICAgICAtIENPVU5URVJfRVZFTlRfQ0FQVFVSRQ0KPj4gICAgIC0gQ09VTlRFUl9FVkVO
VF9DSEFOR0VfT0ZfU1RBVEUNCj4+ICAgICAtIENPVU5URVJfRVZFTlRfT1ZFUkZMT1cNCj4+DQo+
PiAqIENoYW5uZWwgMSAoQ09VTlRFUl9NQ0hQX0VWQ0hOX1JCKQ0KPj4gICAgIC0gQ09VTlRFUl9F
VkVOVF9DQVBUVVJFDQo+Pg0KPj4gKiBDaGFubmVsIDIgKENPVU5URVJfTUNIUF9FVkNITl9SQykN
Cj4+ICAgICAtIENPVU5URVJfRVZFTlRfVEhSRVNIT0xEDQo+Pg0KPj4gQW55IG90aGVyIHJlcXVl
c3QgaXMgcmVqZWN0ZWQgd2l0aCBgLUVJTlZBTGAsIHByZXZlbnRpbmcgdW5kZWZpbmVkDQo+PiBi
ZWhhdmlvdXIgaW4gdXNlcnNwYWNlLg0KPiANCg0KSGkgV2lsbGlhbSwNCg0KPiBIaSBEaGFybWEN
Cj4gDQo+IFRoZSByZXF1ZXN0aW5nIGFuIGludmFsaWQgd2F0Y2ggY29uZmlndXJhdGlvbiB3b3Vs
ZG4ndCBuZWNlc3NhcmlseSBsZWFkDQo+IHRvIHVuZGVmaW5lZCBiZWF2aW91ciBpbiB1c2Vyc3Bh
Y2UgLS0gYXQgbGVhc3QgYXMgZmFyIGFzIHRoZSBDb3VudGVyDQo+IGNoYXJhY3RlciBkZXZpY2Ug
aW50ZXJmYWNlIGlzIGNvbmNlcm5lZC4gV2hhdCB3b3VsZCBoYXBwZW4gaXMgdGhhdCB0aGUNCj4g
cmVxdWVzdGVkIGV2ZW50IGlzIG5ldmVyIHB1c2hlZCB0byB0aGF0IHBhcnRpY3VsYXIgY2hhbm5l
bCwgc28gdXNlcnNwYWNlDQo+IGlzIGxlZnQgd2F0Y2hpbmcgZm9yIGFuIGV2ZW50IHRoYXQgbmV2
ZXIgYXJyaXZlcyBmb3IgdGhhdCBwYXJ0aWN1bGFyDQo+IHdhdGNoOiBub3QgYW4gaWRlYWwgc2l0
dWF0aW9uLCBidXQgbm90IHVuZGVmaW5lZC4NCg0KR290IGl0LCBUaGFua3MuIChJJ2xsIHJlcGhy
YXNlIHRoZSBjb21taXQgbWVzc2FnZSBpbiB0aGUgbmV4dCByZXZpc2lvbikNCg0KPiANCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBEaGFybWEgQmFsYXN1YmlyYW1hbmkgPGRoYXJtYS5iQG1pY3JvY2hp
cC5jb20+DQo+PiAtLS0NCj4+IFRlc3RlZCB0aGUgY29kZSBvbiB0YXJnZXQgKHNhbTl4NjBfY3Vy
aW9zaXR5KSB1c2luZyB0aGUgZm9sbG93aW5nIGNvbW1hbmRzDQo+Pg0KPj4gdmFsaWQgb25lczoN
Cj4+IC4vY291bnRlcl93YXRjaF9ldmVudHMgLWQgLXdldnRfY2hhbmdlX29mX3N0YXRlLGNoYW49
MA0KPj4gLi9jb3VudGVyX3dhdGNoX2V2ZW50cyAtZCAtd2V2dF9vdmYsY2hhbj0wDQo+PiAuL2Nv
dW50ZXJfd2F0Y2hfZXZlbnRzIC1kIC13ZXZ0X2NhcHR1cmUsY2hhbj0wDQo+PiAuL2NvdW50ZXJf
d2F0Y2hfZXZlbnRzIC1kIC13ZXZ0X2NhcHR1cmUsY2hhbj0xDQo+PiAuL2NvdW50ZXJfd2F0Y2hf
ZXZlbnRzIC1kIC13ZXZ0X3RocmVzaG9sZCxjaGFuPTINCj4+DQo+PiBpbnZhbGlkIG9uZXM6DQo+
PiAuL2NvdW50ZXJfd2F0Y2hfZXZlbnRzIC1kIC13ZXZ0X3RocmVzaG9sZCxjaGFuPTANCj4+IC4v
Y291bnRlcl93YXRjaF9ldmVudHMgLWQgLXdldnRfdGhyZXNob2xkLGNoYW49MQ0KPj4gRXJyb3Ig
YWRkaW5nIHdhdGNoZXNbMF06IEludmFsaWQgYXJndW1lbnQNCj4+IC0tLQ0KPj4gQ2hhbmdlcyBp
biB2MjoNCj4+IC0gSW5jbHVkZSBDT1VOVEVSX01DSFBfRVZDSE5fQ1YgYXMgd2VsbCBmb3IgdGhl
IHNha2Ugb2YgY29tcGxldGVuZXNzLg0KPj4gLSBBZGp1c3QgdGhlIGNvZGUgdG8gZW5zdXJlIGNo
YW5uZWwgbGltaXRhdGlvbnMuDQo+PiAtIERyb3Agc29ydGluZyBpbiB0aGlzIHBhdGNoLCB3aWxs
IGJlIHRha2VuIGNhcmUgc2VwZXJhdGVseS4NCj4+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDI1MDUxNS1jb3VudGVyLXRjYi12MS0xLWU1NDcwNjFlZDgwZkBtaWNy
b2NoaXAuY29tDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBjaGFuZ2VzLiBJIGhhdmUgYSBtaW5v
ciBhZGp1c3RtZW50IHN1Z2dlc3Rpb24gYmVsb3cNCj4gdGhhdCBJIGJlbGlldmUgbWFrZXMgdGhl
IGNvZGUgbG9vayBhIGxpdHRsZSBuaWNlci4NCj4gDQo+PiAtLS0NCj4+ICAgZHJpdmVycy9jb3Vu
dGVyL21pY3JvY2hpcC10Y2ItY2FwdHVyZS5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKyst
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY291bnRlci9taWNyb2NoaXAtdGNiLWNhcHR1cmUu
YyBiL2RyaXZlcnMvY291bnRlci9taWNyb2NoaXAtdGNiLWNhcHR1cmUuYw0KPj4gaW5kZXggMWRl
M2M1MGI5ODA0Li5mZTgxN2Y0ZjFlZGMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2NvdW50ZXIv
bWljcm9jaGlwLXRjYi1jYXB0dXJlLmMNCj4+ICsrKyBiL2RyaXZlcnMvY291bnRlci9taWNyb2No
aXAtdGNiLWNhcHR1cmUuYw0KPj4gQEAgLTMzNyw2ICszMzcsMjcgQEAgc3RhdGljIHN0cnVjdCBj
b3VudGVyX2NvbXAgbWNocF90Y19jb3VudF9leHRbXSA9IHsNCj4+ICAgCUNPVU5URVJfQ09NUF9D
T01QQVJFKG1jaHBfdGNfY291bnRfY29tcGFyZV9yZWFkLCBtY2hwX3RjX2NvdW50X2NvbXBhcmVf
d3JpdGUpLA0KPj4gICB9Ow0KPj4NCj4+ICtzdGF0aWMgaW50IG1jaHBfdGNfd2F0Y2hfdmFsaWRh
dGUoc3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLA0KPj4gKwkJCQkgIGNvbnN0IHN0cnVj
dCBjb3VudGVyX3dhdGNoICp3YXRjaCkNCj4+ICt7DQo+PiArCWlmICh3YXRjaC0+Y2hhbm5lbCA9
PSBDT1VOVEVSX01DSFBfRVZDSE5fQ1YgfHwgd2F0Y2gtPmNoYW5uZWwgPT0gQ09VTlRFUl9NQ0hQ
X0VWQ0hOX1JBKSB7DQo+PiArCQlzd2l0Y2ggKHdhdGNoLT5ldmVudCkgew0KPj4gKwkJY2FzZSBD
T1VOVEVSX0VWRU5UX0NIQU5HRV9PRl9TVEFURToNCj4+ICsJCWNhc2UgQ09VTlRFUl9FVkVOVF9P
VkVSRkxPVzoNCj4+ICsJCWNhc2UgQ09VTlRFUl9FVkVOVF9DQVBUVVJFOg0KPj4gKwkJCXJldHVy
biAwOw0KPj4gKwkJZGVmYXVsdDoNCj4+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsJCX0NCj4+
ICsJfSBlbHNlIGlmICh3YXRjaC0+Y2hhbm5lbCA9PSBDT1VOVEVSX01DSFBfRVZDSE5fUkIpIHsN
Cj4+ICsJCXJldHVybiAod2F0Y2gtPmV2ZW50ID09IENPVU5URVJfRVZFTlRfQ0FQVFVSRSkgPyAw
IDogLUVJTlZBTDsNCj4+ICsJfSBlbHNlIGlmICh3YXRjaC0+Y2hhbm5lbCA9PSBDT1VOVEVSX01D
SFBfRVZDSE5fUkMpIHsNCj4+ICsJCXJldHVybiAod2F0Y2gtPmV2ZW50ID09IENPVU5URVJfRVZF
TlRfVEhSRVNIT0xEKSA/IDAgOiAtRUlOVkFMOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJcmV0dXJu
IC1FSU5WQUw7DQo+PiArCX0NCj4gDQo+IFlvdSBjYW4gdXNlIHRoZSBlYXJseSByZXR1cm5zIHRv
IGF2b2lkIHRoZSBlbHNlIHN0YXRlbWVudHMsIGFuZCBzb21lDQo+IG90aGVyIGFkZGl0aW9uYWwg
Y2xlYW51cHMgY2FuIGJlIGRvbmUgYXMgd2VsbDoNCj4gDQo+ICAgICAgaWYgKHdhdGNoLT5jaGFu
bmVsID09IENPVU5URVJfTUNIUF9FVkNITl9DViB8fCB3YXRjaC0+Y2hhbm5lbCA9PSBDT1VOVEVS
X01DSFBfRVZDSE5fUkEpDQo+ICAgICAgCXN3aXRjaCAod2F0Y2gtPmV2ZW50KSB7DQo+ICAgICAg
CWNhc2UgQ09VTlRFUl9FVkVOVF9DSEFOR0VfT0ZfU1RBVEU6DQo+ICAgICAgCWNhc2UgQ09VTlRF
Ul9FVkVOVF9PVkVSRkxPVzoNCj4gICAgICAJY2FzZSBDT1VOVEVSX0VWRU5UX0NBUFRVUkU6DQo+
ICAgICAgCQlyZXR1cm4gMDsNCj4gICAgICAJZGVmYXVsdDoNCj4gICAgICAJCXJldHVybiAtRUlO
VkFMOw0KPiAgICAgIAl9DQo+ICAgICAgDQo+ICAgICAgaWYgKHdhdGNoLT5jaGFubmVsID09IENP
VU5URVJfTUNIUF9FVkNITl9SQiAmJiB3YXRjaC0+ZXZlbnQgPT0gQ09VTlRFUl9FVkVOVF9DQVBU
VVJFKQ0KPiAgICAgIAlyZXR1cm4gMDsNCj4gICAgICANCj4gICAgICBpZiAod2F0Y2gtPmNoYW5u
ZWwgPT0gQ09VTlRFUl9NQ0hQX0VWQ0hOX1JDICYmIHdhdGNoLT5ldmVudCA9PSBDT1VOVEVSX0VW
RU5UX1RIUkVTSE9MRCkNCj4gICAgICAJcmV0dXJuIDA7DQo+ICAgICAgDQo+ICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+IA0KPiBJIHRoaW5rIHNvbWV0aGluZyBsaWtlIHRoYXQgbG9va3MgYSBiaXQg
Y2xvc2VyIHRvIHRoZSBMaW51eCBrZXJuZWwgc3R5bGUNCj4gcHJlc2VudCBpbiB0aGUgb3RoZXIg
ZHJpdmVycywgc28gdGhhdCB3ZSdyZSBhbGwgY29uc2lzdGVudC4NCg0KVGhhbmtzLCBJIHdpbGwg
c3RpY2sgdG8gaXQuDQoNCj4gDQo+IFdpbGxpYW0gQnJlYXRoaXR0IEdyYXkNCg0KDQotLSANCldp
dGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=

