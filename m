Return-Path: <linux-iio+bounces-8443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B09950833
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655E61C23EEA
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3E19EEB1;
	Tue, 13 Aug 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="CIIdJ74w"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C119E81D;
	Tue, 13 Aug 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560675; cv=fail; b=AWI77GojaYWJioEtQrANE959vl8HQmhH9XIw0YZhT1z1FMa4xWoVuUpZ61ex5M7rOC0/IAbPWG79pTcct3cHpRcK54MYWxeFR3LhqgbfIIDvPPDWIleqKK0OMHdGAvL59NMMUTYSCUy92/8RjHpOCww/VqbZ/0vw9W1ELqFFy5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560675; c=relaxed/simple;
	bh=7g9LlmztazU2zNgHLENlMLwLb7JNEJldk/zgNAZsYMA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S56hmn4L6FbRcZIn3ZhHbfLlDQZMI6Imc7vsIkbObRvqUxep5j0TemKzRWXwhGRWEWNXSXJv5ZFTBUnaIuMFvazOK9DwaL0VLSukjRxU5ynEOKQvuZJBEkRD06YcLawq/S/sJbWNMhywtLF3NSaLkO4ioQbqTBBfrJXspDXFQFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=CIIdJ74w; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmJohUjY7jGdmcaBh504JR2BBT2ceMoTYNMYj0+3whormPZC2/XKlwgK+8KRCKt3IRCG+Q49sc453IqqeO9cEZt9Hf7igff9lg4J7eeZLgmS/i1mAqTeHerwEWhxG/PrJHcNS70ZN2qks6G3KO2j4jdRzK12iFTou5TERqhzY3vaWN2LX9n0ov0mVkED3MDaWpRRNzFbV2DJ2a87TNGXzCVSuNjr64wNdHQqKbq68zCohITjWLeIEnOeMQiTgdRf0gRAJ3V6RLBGti05Gb0rzB5gvAFcOX6T0LmFkkT8UkK48tXDeZthR7f24A4O3S4LlW/+kP88BLXKa8sJ3c4tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g9LlmztazU2zNgHLENlMLwLb7JNEJldk/zgNAZsYMA=;
 b=flI8LwKddGq9zrq3K0A4QAZ4SGJMKsyJgdjitgpqeqVRL+/7gjbTYe84Y+EsfjzNCY9R3ytW+OLVEDOA5U2c5kwgIstgkUnClfuujisMLlo+mHv4oVJLDBXnQ8SA7L/rxp/WsC7lqbXfcj00oUQO8wodR+T6LHMt9bkNJImF4QqO/swd0UepTDSQzrKKEv2oBsQS3YQV7i/f9BQHZIPizP8cimrMUHU1+F9XkpjTFUilB0q6gg1ZzBuaTgUpAmZnYjoCypCZdMxstf+M79La2/1sQveKr9jrmOrZT2ZEOBKfDpGvoZWZHEE/lVnR2q3Je2Hd4K88n+x6pJql514Hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g9LlmztazU2zNgHLENlMLwLb7JNEJldk/zgNAZsYMA=;
 b=CIIdJ74w4ImxwONHkXUK2/qSCYDIbeFTpPhrdKXTWT+t5lk5mca5a1sg7jC7Ao6kaOqhPp/bSN2KQftysWAF2IBoKzPu4MN8/Dj6oLUpaYtIJXHNKBnjPFQ8DcTyQGSTvRqkhMiNQlAseYzMdTk98/kjYuUUHddvy9JED9w8uFjB4Gd2j4IjPkOcYJPV1BBcO+vfBcNkHEEfmzv83wv28GQvHx6IYSsAjOGHsALYKof+juVmPlLPOI1JgTckGYObEN6+tS/1FUhEoNYrV6U4qbl8QfxujVMVH4vr1FM7OcLUCsre/CtifiozEErPrlU6A8/ZszrvYgTy2W/zw8Mxrw==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by VI1PR10MB8158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 14:51:08 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 14:51:07 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Topic: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Index:
 AQHa6k2uA9cl/09kzkKzfXi0qtLeGbIgcW+AgAR0C2CAABFFAIAAQhZAgAAPEgCAAAIx0A==
Date: Tue, 13 Aug 2024 14:51:07 +0000
Message-ID:
 <AM8PR10MB4721373BE7846741A2EC66DACD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
 <AM8PR10MB47217665274B9848EB21FA65CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <bb33aeb0-7134-45ec-8536-47c524ec9e4b@kernel.org>
 <AM8PR10MB472146AA446E64C63DE3BF31CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <67255497-7bc9-4392-ab32-d0a6af75f5b0@kernel.org>
In-Reply-To: <67255497-7bc9-4392-ab32-d0a6af75f5b0@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|VI1PR10MB8158:EE_
x-ms-office365-filtering-correlation-id: 1e2333c7-e7fc-4a27-0054-08dcbba75d53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlJJbUUwWjQrcUxybm4xbVp3K2RYdHRLbVFkUmltQ0pMSzVSWHp3T3dSY1dB?=
 =?utf-8?B?UmNwQUhBY29KazRZTm41a0R6Y040VWg0V1kxYUlERjN2cjAvOEpFaTl4MXZT?=
 =?utf-8?B?NVFEZmM2M1EvT1FMd2sreXZsVWw0bWlQR1RKN09HS05vbUlPUFRVSzBKRTZh?=
 =?utf-8?B?aXk4bWVPT09PSENzY1lNd0lyZVpkY3lOSktzWWp0clQ1YUhhNllFMUQ2Q2tm?=
 =?utf-8?B?cjh3c0dnbG45RUVHZzRlYmVoVFJQRW1DdWhPaFg2ODVXTlM1QVFmK3RMSXp0?=
 =?utf-8?B?R2Z5YkFCcDdWWGFqdTluZ2ZFMFVaY2hRdmlvNCtIb1QrNzYwU1U4eEc5Q3Jz?=
 =?utf-8?B?OFRSa3Q0bEx4cDJhcW43UTJCZXdVbnpUZHZYdGFQU0piUWRuektsdzhYSklF?=
 =?utf-8?B?RElIS1ZKczVEWE9lMzJ6STR6aDd4ZU13N3ZpYzhLL0U5WnJJRkFKczJ3UjFj?=
 =?utf-8?B?WkltbGJmVUd0dFZQQ3lpaU9WVlAxbHl3N0wvUXNzZTZjWDhZMVpVbndvMmhn?=
 =?utf-8?B?L2VWTGpBUUNQYXFFVlhaTnpCYmlIY2k1VE0xaXhlc0lQbXBtK1A1UDdnS0JG?=
 =?utf-8?B?WFZKaDZ4VTJDSHVlSTE3d2VrSE1wb08rMW1HMjlZOXFjeUdySXRtZU8yRExw?=
 =?utf-8?B?UWVadVBOOENNTUtDcktpWWNuZnZEU2ZXNk00NVNBWWcxVkVYZ2xKa2w2a3lm?=
 =?utf-8?B?WXZReFY4Z3VGeVdzMWEvaTRham9iVTdva1RoOFFueG9HcmpMZ3hXN3o2L1JQ?=
 =?utf-8?B?ck82Y3pJM3Bzbkdzei9Tb2xSQUdBNlByNWo3eWdLUjNzMG1LYnFPeisrNldK?=
 =?utf-8?B?SUZlL052c3B5SUt6b3VyNElXTERKbnE1Rk14ZHRLYzgveU84SHFyNTl2Y0c2?=
 =?utf-8?B?TWN1N3JYQ3BNekJPeTMraDJvbk55R2szVUY0SWRkL3pjcVhzbzVLcktJSjgx?=
 =?utf-8?B?cm4rcGtDeTBZRmg1VnBKZDZIcU14TU9WZ2wzNzFLOWM1ZERSYTNFM3NaZ3V5?=
 =?utf-8?B?dzFqMngrd0FUYVE4bUxIM0EyQmNTVnNOZS9ZUWVUYXk5bzF4a3J0TEFCbTZu?=
 =?utf-8?B?cmkzZDg2TUtYVlhWVTRHaDRvSVFQeVhua2N2K2xTOVh5bk92QjArMEo1dDNa?=
 =?utf-8?B?NmVicWdZUm1pTDVpOUVEVVZDRDZoZm14NTI2bTZrUWFwK3Ftby9aMVhHcEdP?=
 =?utf-8?B?SVppQVU5LzBVaTRYT0JxVTJRUkFHV3BqYWdVWDZ6TUc0QWpjNUttZFdaTFpC?=
 =?utf-8?B?bU9hbnRQeXNSRUpuclFEcXVYeG95MHhWYmRmQlJCZFhjb1NjZnU2RTB5SXN0?=
 =?utf-8?B?RWoyM1hXZ1FJRURybnVQVUZJbEJNM0p6a0tmYW0zMGVkVm42aHJtL3ZZWGRm?=
 =?utf-8?B?ZnhwYnZhYnFnQjRtQ2FRdEprcjA0MHNwaG1MOVl1Q3Zya1ovWGUwV2tLS0VC?=
 =?utf-8?B?d2xObXc0RGRaOEE2VTFTOE9pZVBwQzVqa1JTR2hyV01HU1JKSHZ6ZTVDd0hR?=
 =?utf-8?B?UkVjdWZQMnJYOVFsVm1BbFRyR3RHc1EvWHV4UVJ2MGJMdDJ6NzZXdyt6ZXJ0?=
 =?utf-8?B?ZFlHOEUvY2lhN0w0cWphWGM0Qk15bHNzZmRmaW14dEZPbzMxRzZNYWJsMFlE?=
 =?utf-8?B?enF1RlNlMEk3RHRqVUMyL3NCeWthcDRvcDQ0VHAxZGQvTHB1QVlFNDZ2Wlhh?=
 =?utf-8?B?NS9IY3M2cm9HREl2WG1tdFFZOTBhR2g2cHA3WWxHSEFwUHVmcWxoUHhSNFlr?=
 =?utf-8?B?Rkk5RWVwRmpsZTEyTzZVUXdWcC9pQjQxZHo0VTNLWnJhbjRocWtSSHdLNXRI?=
 =?utf-8?B?T2pwdVhiV2tIUnRGTGVEZTdXMC8zYU93LzdJTnIxc0lXQjBhZGp4SzJnekw3?=
 =?utf-8?B?d2kycGdsMHdnS0VSOXhCeW5SaElLQkVQTmxSV0E1NXZnK2dROWZVeDhrbndh?=
 =?utf-8?Q?A3Y7i0eIyJ8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2ZUVWc3elc5WTRwZ3kxaE5zSUs3M2UyNTJUN0hRTkJPY3VOMURvckhacjF3?=
 =?utf-8?B?eWtHTWthaGt6RHJrQzlCMGMxS21GaElXQU9ZbXhkRXlYUFZmRVZrZEtQeUtn?=
 =?utf-8?B?aysrYkFRMzdzYlRnNnBCRFN4YkNkVnQ3OGZWbE1KTnFEQzUzZExHUU1uY1BS?=
 =?utf-8?B?bkd1RnhzMWRvM0Y2WXF4RWtpSGhGbzhZSnROekwvTHEwTkhYblg5L0JFV2FE?=
 =?utf-8?B?Si9GbEF4R05Pb0llNUxJTjl5aHhmd0w1OWlKSVM3Zk0xYmJpYWpVeTZrS21j?=
 =?utf-8?B?NjkwckpHWi8zTWJwdExqUEtGUGZxNk5aSHB4aHdhcGUrZmRONkc5Y2ovTDdV?=
 =?utf-8?B?Ny9OVFdCSlJRaG43MjJPR2xGQ0lSVTZwS0RZTVU2cXEvQnpqMCtTcVlxVWxt?=
 =?utf-8?B?RU9vdUJ2NUdYOWs1ZUcwTTIwdWhPQ2tFUllkR1NwdStjMTgzc0hRVGZGdzNo?=
 =?utf-8?B?OXpnTXI1TU5yY3lZRHZRQVNHM0FVMm8ya25DUEFxSmtGbUJIRnVlK0ppNTVG?=
 =?utf-8?B?eTZRQkk3Rng3OUxHZHJ3Um0rdVpGSTZPdFI0YlVYVTl0NHU3WXB1U1gyM1Er?=
 =?utf-8?B?dWRTRW5ITEpRY1RyMmJZc1RUcVhNancwQ0RyNWQ5R2Z1SlMwc0tMTVBmU1Mx?=
 =?utf-8?B?aWUxcjBqUG1IVnJBbTl1Tlp4U2lNTWplemFJcW5sTTQ2LzRFVE4wVXd0TVYx?=
 =?utf-8?B?YWtnS2VSdU96bys2WnJ3ZE5RU0gzQTRtblMzWGVRdXJsUzdhOGZZRXpLRitB?=
 =?utf-8?B?VnlYS2ltT3RydFhyNFFaZDBaSzZ4dVduRWZHZkVLNE1FZWhKbjdKL0I3eFlj?=
 =?utf-8?B?QnEzcU94QmxZZjNjcEJTNDdnTEdQQ1NQMWJ0Mmh0OXkxaWhpVkhsZWhpSUpS?=
 =?utf-8?B?Z0hOT0NYcmRTaE5sOUNVYmozRElZMlZIZm44bnZQMzg0cU9BRHJLdE9IWHA5?=
 =?utf-8?B?MDYveGhNdTlZYXZXRzhoeWVlcnpXaE92L0gxWTJYSWhoLzJ4cXlpSS9zOWVu?=
 =?utf-8?B?NHUwTGZ2YVU2ZHpUTGdYWEx6VkRTMWNmV2RsVUdrZmZTamo0a1ptWjRFM3pL?=
 =?utf-8?B?bVpRRU5OajlCK2pSb1BTNFdpcG1XZ2k2V1dqazhUTlYrNHFaZ0pPTC9pVjVt?=
 =?utf-8?B?cHoyLzBzUnRZbXVwUWpTelh6RWovU2Z2ZXNTSys3ODhLWW81WTN4YkJRNFM0?=
 =?utf-8?B?czFxcGJSQU9EcG5FZU1HaDR1WjZSWTRKaDNYMEd0Z2JmMjRNRjlZVkw5eU5E?=
 =?utf-8?B?YTFnaVNWeWphaUtpRHl3QmJHVy82R283ZjNTZkxlaTRKSCtSdnQ4NXg2Qmw4?=
 =?utf-8?B?ZGo4TUREMzA5RUhrbG43cVl2a1hkVm4raWdUcS9yN1ZBVWZkR0RGVFRRWDZZ?=
 =?utf-8?B?QlFQbkJXOVg4Mm5NbTZzRm53TmM0MW1tT3FkODhibmFPS3MvUzJFUnd3T1Ro?=
 =?utf-8?B?TnR6R1c2Sm0xdEZ5dlBpd0ovbHk2WWUxU0JyeDBFZXRtN0piYVl2TW1Dbzhk?=
 =?utf-8?B?YWdrS1lFTTY5K0pmUU5OcEk4M1BVSmszVE1FbmxYb1pVdmJGcUNBUWpmZzNw?=
 =?utf-8?B?QlFGbGRXQ3QzSE81Y2FLWWVDZ0pXemJ3Vnd0RkVLQlRBc0E0TmswbmFnWlo2?=
 =?utf-8?B?SHc0a1lqL2JLV3JVa3JwdzZudG05NTY4Q3JSVmdoNkRVSVVjTUFvM2o1OFhK?=
 =?utf-8?B?ekhmdXZBOHMyc1krTE5YNE5TNkZEWHVnL1R2cHQ5WUMyazBwUFpTTVB0YlQz?=
 =?utf-8?B?akVLc1JzbGhSRURrNDhhTHU4VGFpR0tOV0JSOGlRMlRFbFNtZkEyTzNtaE5w?=
 =?utf-8?B?TDRQdVNXOXlwSXRLZDZNaC9pM2RtOE5yTUx6dnhKRE4xVnhRb1h0bGJvZTk4?=
 =?utf-8?B?Z1RNWlNBZ0hHTmprQUlDcEx3RWZuc05zNlZLWTlWWDBrZFQzTUFCZzBWNi9o?=
 =?utf-8?B?Q1ppMW1zclMzdlFyNkFNOEFQWjg1dzM0WG1hYm5YUnpFNzN1aTR6SHEzS3Q3?=
 =?utf-8?B?UlI4c1ZrdVZDRmlTSFdwcjVTTFBweTBMai9ubW9NaFRqdkNGT0kxTWF2V2lu?=
 =?utf-8?B?MWYxQ1diRFhFTjFmczdaaE9ockZtYW1QcDFjaGJrMi95TXpMUHh1NGt0Tlc1?=
 =?utf-8?Q?T4uc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2333c7-e7fc-4a27-0054-08dcbba75d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 14:51:07.9382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMFqQkOcu8dCrAIH/bmzM5oS9rTRSuzTmmkxZXYO2ZhJPhAdB538RLG/gW33mlruOntUpmgZ96SUjGVOUJhOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8158

SGkNCg0KDQouLi4NCj4+Pj4+ICsNCj4+Pj4+ICtNT0RVTEVfQVVUSE9SKCJNYXJrdXMgTG9jaG1h
bm4NCj48bWFya3VzLmxvY2htYW5uQGRlLmJvc2NoLmNvbT4iKTsNCj4+Pj4+ICtNT0RVTEVfQVVU
SE9SKCJTdGVmYW4gR3V0bWFubiA8c3RlZmFuLmd1dG1hbm5AZGUuYm9zY2guY29tPiIpOw0KPj4+
Pj4gK01PRFVMRV9ERVNDUklQVElPTigiQm9zY2ggU01JMjQwIGRyaXZlciIpOyBNT0RVTEVfTElD
RU5TRSgiRHVhbA0KPj4+Pj4gK0JTRC9HUEwiKTsNCj4+Pj4NCj4+Pj4gSG0/IEhvdyBtYW55IG1v
ZHVsZXMgZG8geW91IGhhdmUgaGVyZT8gV2hhdCBhcmUgdGhlaXIgbmFtZXM/DQo+Pj4+DQo+Pj4+
IFdlIGhhdmUgb25lIG1vZHVsZSwgbmFtZWQgICJCb3NjaCBTTUkyNDAgZHJpdmVyIi4gQW55IHBy
b2JsZW0gaGVyZT8NCj4+Pg0KPj4+IFllcywgeW91IHB1dCBNT0RVTEVfKiB0byBob3cgbWFueSBm
aWxlcz8gVHdvPyBUaHJlZT8gV2h5IGlzIGl0IG5lZWRlZA0KPj4+IGV2ZXJ5d2hlcmU/DQo+Pg0K
Pj4gV2UgcHV0IE1PRFVMRV8qIGluIGFsbCB0aGUgKi5jICwganVzdCBsaWtlIHRoZSBvdGhlciBJ
TVUgZHJpdmVycyBhbHJlYWR5IGluIHNvdXJjZQ0KPnRyZWUuIFRoZXkgZG8gdGhlIHNhbWUuDQo+
DQo+VGhhdCdzIG5vdCB0cnVlLiBGaXJzdCwgbG9vayBhdCBhZGlzX2J1ZmZlci5jLiBubyBNT0RV
TEVfWFhYLiBTZWNvbmQsIG1heWJlIHRoZXkNCj5oYXZlIG11bHRpcGxlIG1vZHVsZXMsIHNvIHRo
ZSBtYWNyb3MgYXJlIGV4cGVjdGVkLiBUaGF0J3Mgd2h5IEkgYXNrZWQgeW91IGFuZA0KPnlvdSBz
YWlkIHlvdSBkbyBub3QgaGF2ZSBtb3JlIHRoYW4gb25lIG1vZHVsZS4NCj4NCiANCk5vdyBJIGdl
dCB0aGUgcG9pbnQgLCB3aGF0IHlvdSBtZWFuIGZvciAibW9kdWxlIi4gIFllcyB3ZSBoYXZlIHR3
byBtb2R1bGVzLiANCk9uZSBtb2R1bGUgbmFtZWQgIkJvc2NoIFNNSTI0MCBkcml2ZXIiIHRoZXJl
Zm9yZSB3ZSBwdXQgTU9EVUxFXyogaW4gc21pMjQwX2NvcmUuYyANCkFuZCB3ZSBoYXZlIHRoZSBz
ZWNvbmQgbW9kdWxlIG5hbWVkICIgQm9zY2ggU01JMjQwIFNQSSBkcml2ZXIgIiBhbmQgd2UgcHV0
IHRoZXJlZm9yZSBNT0RVTEVfKiBpbiBzbWkyNDBfc3BpLmMNCg==

