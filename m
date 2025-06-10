Return-Path: <linux-iio+bounces-20367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2FAD3E0B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3E3A2878
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A923BD09;
	Tue, 10 Jun 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WyXurDPC"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADC23A99D;
	Tue, 10 Jun 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571100; cv=fail; b=fKt11bz2NIybmLK0bX9l+fB1YCxTN7vpurE+03T9HRVW5i5yM/z/g0PSDNowEGCrRiCI/jLziW5HWwWMoFOTSPW8Gqs1xvrSN+awzd20i0g84nGIFYVMpVEJ7nRFUSf+dyy+BLuKydPs6kTnr9eVHhPbuHYl6VYldGnfwU26KdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571100; c=relaxed/simple;
	bh=LPeBaM1vFXDKWpNYNxIoDXcRKIQzSlh/hOqDvBthp0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNA2Hbz5EO48S3K6r98sjLaplUupdZer7pVShTSsP2XI8HoaUDkzB17ECfw1oU8E2cJAwO/wWpBcrbL0Bxds9z4mRAYD2f8tnFgvOFohkMMAdTUH8UALY2NxcKAEmqivQ6xUv+jk5Oh6C4x8u7ONuWPwqoSnZZKNG+wCNE/VqH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WyXurDPC; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdLD4+hu6MePROPm8UBE0+8FBrr5ZBdZ7M3ogwtMdtCyZdhf9kNhTY0BxoMSCPb6nIzXcnAc0McziWW9omcYG74cKufN1wdH4IaJTLAA/7jug2JlKq+DANBdaR8pu3qsfabmjtB91lXgKKEJ3bIPvntH/sIDDxFNe5ysUpAUWjtsfRUgw30Mp/ShOfHNK+6ImmPB1k4UtX4NGX2C0r+E29aBGwpdsSTRXnH+nPjRbyOxtXPPf1heVZAkfnkS4BwmytA15phBXkeV8a/mxtJx+4W4w8TmsEeXNiCjT06NnXzB7QlQkvK5zqjKLN2SS8VHLZzu72KqaynkRTt9EOYljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPeBaM1vFXDKWpNYNxIoDXcRKIQzSlh/hOqDvBthp0A=;
 b=jA8dqnofEMsGYL8wpOwxWjso/xfiBq81SKmGIEEATU/u0xBrg6H2BLcmznDCfUne70sLZLVe3DOfj06qD7m0Aym4xx5ZND6MonHqk3KHRCA6+EBO0JP3rvJdNAE23zR5AmRJ9VRF+gCFZ0012ZPs4IRn5BiXPCLczXi0/JzBkNuosQNpI9Jp+A+feBiXqeWVdOoRnJsxt2TXoxekniHOMRO1IAY3NgyFUw7L2ozsadP/JbGEn5o6oqshQc/V9N7QfRiJDZkOipfqQQg7H4OnrLTHqNWwXXJKvWeUWGU9ym6AywpHkQ5RFHLYwcLVsSPbEb69yFG+jWGYR9U2k1FCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPeBaM1vFXDKWpNYNxIoDXcRKIQzSlh/hOqDvBthp0A=;
 b=WyXurDPCyKRTuC6rI+is42qS6LHSHZGhdphEZ0t3fOcuJFywak7EFbgS0kJAMtKwFHZ2GGwEZWWYv4MywUEIChscSKa6NEXyvsmcC3eDf2I2sTh80mO4APYQ2aksB/v1EzbxIfpC19Sb9vufcdiR3FMfwbgjT/NARvMjq8wYXf0jTGnY7yje/KbZrKoiNa1Qa/QRIrlNt35m8U7nSTzfCbTN68YByMBedoWfzAQPonul2WhHtsXX1jnWxvppg5NojXhMXT/FA8zSpVHLnppr0G+OAUgjXzpM4q0EUJIOhD3XUbBtJfL8g7sb8ekPVg71K+64JRFPGouSPPyZlE6wFA==
Received: from BY5PR11MB4088.namprd11.prod.outlook.com (2603:10b6:a03:185::32)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 15:58:14 +0000
Received: from BY5PR11MB4088.namprd11.prod.outlook.com
 ([fe80::cd6c:df72:8d4c:16fa]) by BY5PR11MB4088.namprd11.prod.outlook.com
 ([fe80::cd6c:df72:8d4c:16fa%7]) with mapi id 15.20.8813.018; Tue, 10 Jun 2025
 15:58:14 +0000
From: <Marius.Cristea@microchip.com>
To: <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <broonie@kernel.org>,
	<linux-iio@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC194X
Thread-Topic: [PATCH v3 2/2] iio: adc: adding support for PAC194X
Thread-Index: AQHb1scEgfOm29yMSUyi0CDB7r2o8rP308SAgAS/nQA=
Date: Tue, 10 Jun 2025 15:58:13 +0000
Message-ID: <a2d9c24e2f72378d445b40d24bd808f29b87d122.camel@microchip.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
		<20250606093929.100118-3-marius.cristea@microchip.com>
	 <20250607162721.0142ba42@jic23-huawei>
In-Reply-To: <20250607162721.0142ba42@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4088:EE_|SA2PR11MB4796:EE_
x-ms-office365-filtering-correlation-id: 619942f4-170c-41d1-3a9f-08dda8379b6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGt0TU5hS0E2QXZYTG5NeUExcDRjdTg5VUZuQTUyT3FWTDFIdGxGbSthYnJk?=
 =?utf-8?B?K0YyTjJTTzlRSVlTZm93aFplQUJwU0hKeElhMVROQjRrTVNHcDZhd3ZFenJy?=
 =?utf-8?B?aVp6NTJOMmY1eXRpUS8zb2MvdU1lU0kzTzBYN1d5TldiTjFGVWJvSGJXcUQ0?=
 =?utf-8?B?V29vVlNtTWNHaEtnN0tyZFo5QytwTElrQVF0ZS9YenZlRlFWSHhMTHJFbVNX?=
 =?utf-8?B?bG5nVFk4L1FZZEx1V20zbktnVFFEL3dXWG5QZnZNdFJ0M2Y5WWhRVTUzOS92?=
 =?utf-8?B?MGZEampmR1BZSS80Nk5OU2gxSHhZbmFmMnNXdXdYWmpjd0JMT0tBbEdwdlYz?=
 =?utf-8?B?Zkd6MVBzQllpQ0gwRVBoNDVSWGxacUFTc3pXQ2pqV3kwU252UjFicWgxT3Ba?=
 =?utf-8?B?djJuWDh1ejlzVkhwOGh6SU9LaDhacnFYblNaR2NDQ3ArVlB6KzF6dWU3ejFW?=
 =?utf-8?B?b0puaVR3SWJqYk10Z1NVRWc1aTh6UnlET1VOTXVrV3RQbHkxTU1UWjZEWFpY?=
 =?utf-8?B?MFpSUHZBWWZ4Sm1VZlE0c3NSNTZwVkYwaUQ3ZTdtS2s1bnJoSUx3OENVVFRC?=
 =?utf-8?B?UjBBcEc0aTZsTlVkQW5vdndTVXZDMzlvVjRHSkpzUFlOelRobS9JdmtpelAz?=
 =?utf-8?B?QnNQaDMreUZHb0lsMkMzOTlQRGUyRnE0SERxeE85TW9GTWxMdCt2QmkwMnhF?=
 =?utf-8?B?cWE4eGhPUUcvYmFQMGNoRVMzem9kZDZqVElFeDgySG9YZDNhQWpkRmxRL28v?=
 =?utf-8?B?SVEweW93QmxYUFZTYnA1ejJVSjE4YmM1NmwyMkFoTkhxZlcvK3lYTUk2cGVv?=
 =?utf-8?B?MFFySUU5ZXVyek5KNWdTQ2NpQk1JTlJicURaVTkya1M4dDN3SVlxMjBGdUV2?=
 =?utf-8?B?QUoxMlUzQnNpQTZ0cUdFKys3MUdqV1dtV2g3eXY1eTZFL1RaNVJPa1ZOT3B6?=
 =?utf-8?B?TlVla2lnakhWbVlUc21CVjhqTmt5QStFa21BajVybG5pUElLbDB0REJPdUdn?=
 =?utf-8?B?bmFZNjc1MjQ1VWJCWFVzazErdGI5S3JPdTJBUklDczQxT0RNanhpMGRaZkUx?=
 =?utf-8?B?THJ6YlNoQ1NodkZOenVhOUlOcVhHeXBoZ0tSK1c2dm1Nci9KNk5yK1F2d2N1?=
 =?utf-8?B?Smt5ZkIyRWtUU1VKTjhDZ3ZWM05GdzdKUEZNL1hGNXVFQmllOE5VUmZBV0Nj?=
 =?utf-8?B?RVNmaTAyb3BFKzc2NHFuOGFGLzRNeTlubTB1MnJpRHl5emNaWGFpajNrTE84?=
 =?utf-8?B?QWltVXFtVkpSYjR5WnlIM0FVc0N2M1djMUxRS0xQeURJYVdiOW5zcHFPU3V5?=
 =?utf-8?B?UXdBNlFSa0Zpbk1ad2djMVFtZDQxZDE5cHZDaTZNMkJxVGlUMFpwTmU5THFq?=
 =?utf-8?B?K0NrSUx3dnZ1ZXhWOVBtS2QybzIzL0x2VjRvRzdkL0dQK1pBYnh1TTdMMUNp?=
 =?utf-8?B?WTFJQXVmK1hpNlBBZDhLVzEwQkhHYUcyMkpvMnphVDBzVEphMXJVdEhVUm93?=
 =?utf-8?B?NlplVEN2N1RVNnZYZ2gwb2VlclBaZERVRk5zTmlHRW9ac0pHSmV4Zk43S2tx?=
 =?utf-8?B?TTlva3VXcUpmeHBhMmk1M0Y2ZjI0cnQ5T1IwWE5laXV2QVkwLzlRWnV1L3R3?=
 =?utf-8?B?dVJMQmlTVGh4NzU5aWtybURBNlp3dU9DWU55RmRVaXFhV0RhMTFnMWNpamc4?=
 =?utf-8?B?ajFNRDBOelM0bFo2ekl6UkxaODR5bE03MjgvV0N0WjZKRTYzaDZSVmdrREl1?=
 =?utf-8?B?bG5KTEhqZUFDTWlTZmpQRnAybTlWclNqT3NKMTFiL3JFNjZlUFB0aTNhQXhw?=
 =?utf-8?B?T0RvVVkxYUpiSmJ2aGFCT3hiY3ZvMlVvcnpaVFU0Q2NOMnBxOHlHZGFjSnFT?=
 =?utf-8?B?Ky9NeWxzWGoxWG4rVnR6Q2JsQ3RhL290bGZvSm5wVUFTNFJzMC9kY3JGV29m?=
 =?utf-8?B?aVJvZElQTjVibUp3ZWdFMTVsNzJSeE9yOWNNeHlFR2czSkNraUJjSnNvSzFO?=
 =?utf-8?B?bFZFam5FZHV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4088.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlJsWUtlcVBlNmJVTDV1OVU0QTJ5YXhkRlN0OGdBK1g0OUJWRDFZcysrU3pK?=
 =?utf-8?B?WGRxeEdtalB6bHpUOFBld1lJODhibjdtek1XYkhLVVQ1aEpJZkNrQko2ai82?=
 =?utf-8?B?WDloNmhWMm1Pd0dLNlZUcExVak9ka2prZjVMd25xQ2RuT2xvQlBDb3BLZlpY?=
 =?utf-8?B?a0VCcmhwZ1BCQjFkWHc4ellWZ0NCODBMejBzYkpWMVU2Tlg1cDJ0WHFWWTNJ?=
 =?utf-8?B?d29XTE91Uzltd0c3ZlE1WkxJN2RTZ3JTUE8xcjRWZmpVTm9UL1ZsWTNHdGNn?=
 =?utf-8?B?RUlTcDZqc1hOTGI0V2h3bkQxc0pwMHVQaHduWmdMczVtMDdkNTlTeFE3c29q?=
 =?utf-8?B?SEhPdm1GTmdjdXQvTjhETVRIZHpRN0gwbWdIb2dOSVZFWG5OeXJDWUlVTEpr?=
 =?utf-8?B?VHRkZjRydjc3cFpNNFh4dVU3TUZNQXQzNjNMTUJoWmxOc3hvSmsxL0tzQkJD?=
 =?utf-8?B?SFh3UzNvQWxJdjRDOVVCMVdjNk1DL3NITk80aFZGUVlzN0N5T0F0bGFoaFc4?=
 =?utf-8?B?TE4yTStQUzdFZTRDK1BYSjkwamVVdzlnUC9MUk1pekVSU3h0YVVxRlc0L0wr?=
 =?utf-8?B?dTFJb0ZnSEVFYzR4ZWxBRUtuN0x2cTFKdUtjWERZYlhHUlVacmQ3SlUvTEkz?=
 =?utf-8?B?U1hSYlN2M0ZWNTZpQ0t0ZXFjWmYzWVZtc2JmcWdYRFRDcExDekg0dUFqYVZD?=
 =?utf-8?B?Y0NNL3piRUpFcmk1YkN1dWJhR1I4akQraWpqdERjRmJOa3Z6RXFWMVBIUDNP?=
 =?utf-8?B?TUJWRnFmVTBUaVJQVDJKYmRPZExVeWxlWGdZRlorQTJPVk5ycGJSUS9jRlB1?=
 =?utf-8?B?RElzYnlLRER6dStEQW5tUWwrT2xlaVJpNGJjQ1dSbEJiY3RDUEQxVTNtTWEx?=
 =?utf-8?B?TzVuUWR5VHRDOVU3YzV2b0Z2UHR3N1cxSmk5dERFdFFjbTIxczhkQmJPODdN?=
 =?utf-8?B?QTdUanBhVi9CMUNGdldNdmVRVVlDbUdCeWI1VVd1bExyV1A4bUFyVzJsNlVK?=
 =?utf-8?B?cERzMUdDazBqRlFnMERvaHY1aTJSMldYM2dQcDBjOFV2NzAyWjVYeGpnc2hN?=
 =?utf-8?B?RXIvdnUyalp1eU9MRlg2bmxLYi8xTnFzMWpWTTZRMXN5WWlVc2N0UzlVMXlz?=
 =?utf-8?B?NVMyUmNxT2hKZUpaWXk0SjVCMTN4WlZFdWtTenRXa25ncklKU2FFQlpTM1Vx?=
 =?utf-8?B?MDRPbzZBVmNWN2FZUjBlVE90bkxkbVVEMXRZYmt5dW43WnJyc21PMDBJZzJJ?=
 =?utf-8?B?YzdMVXRIVTZBMU42SXRKOGNRNTl5MGJtZUNsM0ZqT3ZxMzlMVFl4NTZPVWZM?=
 =?utf-8?B?OFhoNDkyNFZBa0pQcFR3Z3pJOW1LKzY1SHkyT3MzSU5EUkQzeGV4RTNtYmpU?=
 =?utf-8?B?cTZjNEdobTBmZ3lOOXZNZmJiKzVWOU5GZmJMek5JRTViR09aK3dXb1ptT3F1?=
 =?utf-8?B?TWJCaEVucERFTXl0UkVNZlRxeWJMSFlPcENPbzZwa2VVek9pYmQ0T3RCeDhQ?=
 =?utf-8?B?OFhXanhhTXBueHRKcXp6bktnZGV1ZnRxZFpOYVA4UjBrN3JuU1dQNXdweXFX?=
 =?utf-8?B?V1NaM1Fob0lpYXJ5VkRDakhTblFPRGcyNGRNU3N4OEx5allQMEgrMklab204?=
 =?utf-8?B?RU00U01LZUw2akt3SEJ6Mjg4eTQ0Zk93a3RZOG5WYkhzVVdWMk44WW02U2h0?=
 =?utf-8?B?eVB2NWpudGtzQVY0WTlxQ3NKSklPMXJYd281dGI2WWR1TkZxNnU1VENSQVVN?=
 =?utf-8?B?RUduUlZuTWdHMEpPUVpOQlFvcmFxNGJ1WXJmTUZQV3RkamFERnYrd281NHVz?=
 =?utf-8?B?WHBTNlRja0REUlJ0bVc5WGVRdFRoR055am1GeEZHcFNKTWxFUnpMOEVKcjZN?=
 =?utf-8?B?bGFIYUxtRnNBYzd2MDZxUURtVXpOQmhTblIrQVhYZWVHTksyL1FnS2RTN0hI?=
 =?utf-8?B?aU42TXM0MjQ4QzNPOFFSZEdPK09mU2tpSTBRUXVNUTh5UEJsS3g4OVlJREhN?=
 =?utf-8?B?b05WSmVWNmoyTFhHR1NNUk5yVGg4RU1iMHZxeVgwblJyZ254SHpDMHVYWVI3?=
 =?utf-8?B?eG9hN2pYQkdaWDJXbmZtTTAwdFNLa256bDRNNDdkN2paZkJlR2NWZDFNNzBQ?=
 =?utf-8?B?ZVJUOEtEZlNoeXdSb0h3b0Z3M1NTcmUyaU9rYWZOQlNta0RIVUVUSUhvUnAr?=
 =?utf-8?Q?/s8sz3JulKpfqq06szaBjmc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <463F39CA54054A4F97B7A353AB87481E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4088.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619942f4-170c-41d1-3a9f-08dda8379b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 15:58:14.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mKxsmVv+9SipA544ZwZC3irYWL6aCeEKqgqjBmSsEbz6vaTzAmwqRW1Fi9UB8xD0vMcrR4B36/qlfW5UhJFnwuYuSBU6O2IDS/T2+FqUzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796

T24gU2F0LCAyMDI1LTA2LTA3IGF0IDE2OjI3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwg
NiBKdW4gMjAyNSAxMjozOToyOSArMDMwMA0KPiA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBt
aWNyb2NoaXAuY29tPg0KPiA+IA0KPiA+IFRoaXMgaXMgdGhlIGlpbyBkcml2ZXIgZm9yIE1pY3Jv
Y2hpcCBQQUMxOTRYIGFuZCBQQUMxOTVYIHNlcmllcyBvZg0KPiA+IFBvd2VyIE1vbml0b3JzIHdp
dGggQWNjdW11bGF0b3IuIFRoZSBQQUMxOTRYIGZhbWlseSBzdXBwb3J0cyA5Vg0KPiA+IEZ1bGwt
U2NhbGUgUmFuZ2UgYW5kIHRoZSBQQUMxOTVYIHN1cHBvcnRzIDMyViBGdWxsLVNjYWxlIFJhbmdl
Lg0KPiA+IA0KPiA+IFRoZXJlIGFyZSB0d28gdmVyc2lvbnMgb2YgdGhlIFBBQzE5NFgvNVg6IHRo
ZSBQQUMxOTRYLzVYLTEgZGV2aWNlcw0KPiA+IGFyZSBmb3IgaGlnaC1zaWRlIGN1cnJlbnQgc2Vu
c2luZyBhbmQgdGhlIFBBQzE5NFgvNVgtMiBkZXZpY2VzIGFyZQ0KPiA+IGZvciBsb3ctc2lkZSBj
dXJyZW50IHNlbnNpbmcgb3IgZmxvYXRpbmcgVkJVUyBhcHBsaWNhdGlvbnMuIFRoZQ0KPiA+IFBB
QzE5NFgvNVgtMSBpcyBuYW1lZCBzaG9ydGx5IFBBQzE5NFgvNVguDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+DQo+
IEhpIE1hcml1cywNCj4gDQo+IEkgZW50aXJlbHkgYWdyZWUgd2l0aCBEYXZpZCBvbiB0aGlzIHdh
bnRpbmcgc3BsaXR0aW5nIHVwIGludG8NCj4gYSBiYXNlIGRyaXZlciArIHBhdGNoZXMgdGhhdCBh
ZGQgZmVhdHVyZXMgdG8gdGhhdCBpbiBvcmRlciB0bw0KPiBtYWtlIGl0IGVhc2llciB0byByZXZp
ZXcuwqAgVGhhdCBhbHNvIHBvdGVudGlhbGx5IGFsbG93cyBtZSB0byBwaWNrIHVwDQo+IHRoZSBi
YXNpYyBzdXBwb3J0IHdoaWxzdCBhbnkgbW9yZSBjb250cm92ZXJzaWFsIHBhcnRzIGFyZSBzdGls
bCB1bmRlcg0KPiBkaXNjdXNzaW9uLg0KPiANCj4gSm9uYXRoYW4NCg0KSSB3aWxsIHRyeSB0byBt
YWtlIGl0IHNtYWxsZXIgYW5kIGJ1aWxkIG9uIHRoYXQuDQoNCj4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2FkYy9NYWtlZmlsZSBiL2RyaXZlcnMvaWlvL2FkYy9NYWtlZmlsZQ0KPiA+
IGluZGV4IDA5YWU2ZWRiMjY1MC4uZWU0N2Q4ODBiYWJmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvaWlvL2FkYy9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9NYWtlZmlsZQ0K
PiA+IEBAIC0xMDMsNiArMTAzLDcgQEAgb2JqLSQoQ09ORklHX05DVDcyMDEpICs9IG5jdDcyMDEu
bw0KPiA+IMKgb2JqLSQoQ09ORklHX05QQ01fQURDKSArPSBucGNtX2FkYy5vDQo+ID4gwqBvYmot
JChDT05GSUdfUEFDMTkyMSkgKz0gcGFjMTkyMS5vDQo+ID4gwqBvYmotJChDT05GSUdfUEFDMTkz
NCkgKz0gcGFjMTkzNC5vDQo+ID4gK29iai0kKENPTkZJR19QQUMxOTQ0KSArPSBwYWMxOTQ0Lm8N
Cj4gPiDCoG9iai0kKENPTkZJR19QQUxNQVNfR1BBREMpICs9IHBhbG1hc19ncGFkYy5vDQo+ID4g
wqBvYmotJChDT05GSUdfUUNPTV9QTThYWFhfWE9BREMpICs9IHFjb20tcG04eHh4LXhvYWRjLm8N
Cj4gPiDCoG9iai0kKENPTkZJR19RQ09NX1NQTUlfQURDNSkgKz0gcWNvbS1zcG1pLWFkYzUubw0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvcGFjMTk0NC5jIGIvZHJpdmVycy9paW8v
YWRjL3BhYzE5NDQuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAw
MDAwMDAwLi5jZTA5MzM0YjA3NmENCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVy
cy9paW8vYWRjL3BhYzE5NDQuYw0KPiA+IEBAIC0wLDAgKzEsMjg0MSBAQA0KPiANCj4gDQo+ID4g
Ky8qIEF2YWlsYWJsZSBTYW1wbGUgTW9kZXMgKi8NCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBj
b25zdCBwYWMxOTQ0X2ZyZXF1ZW5jeV9hdmFpbFtdID0gew0KPiA+ICvCoMKgwqDCoCAiMTAyNF9B
REFQIiwNCj4gPiArwqDCoMKgwqAgIjI1Nl9BREFQIiwNCj4gDQo+IFRoaXMgYWRhcHRpdmUgbW9k
ZSBzaG91bGRuJ3QgYmUgY29udHJvbGxlZCB2aWEgdGhpcyBzdGFuZGFyZA0KPiBBQkkuwqAgVGhh
dCBuZWVkcyB0byBiZSBjb25zaWRlcmVkIHNlcGFyYXRlbHkuDQo+IA0KPiA+ICvCoMKgwqDCoCAi
NjRfQURBUCIsDQo+ID4gK8KgwqDCoMKgICI4X0FEQVAiLA0KPiA+ICvCoMKgwqDCoCAiMTAyNCIs
DQo+ID4gK8KgwqDCoMKgICIyNTYiLA0KPiA+ICvCoMKgwqDCoCAiNjQiLA0KPiA+ICvCoMKgwqDC
oCAiOCIsDQo+IFRoaXMgZG9lcyBub3QgbG9vayBldmVuIGNsb3NlIHRvIEFCSSBjb21wbGFpbnQu
DQo+IA0KPiBUaGUgbnVtYmVycyBjYXNlcyBhcmUgZmluZS4gVGhlIG90aGVycyBub3QgcmVhbGx5
Lg0KPiA+ICvCoMKgwqDCoCAic2luZ2xlX3Nob3RfMXgiLA0KPiANCj4gVGhhdCBoYXMgbm90aGlu
ZyBkaXJlY3RseSB0byBkbyB3aXRoIHRoZSBzYW1wbGluZyBmcmVxdWVuY3kuDQo+IFNvbWUgb3Ro
ZXJzIGxvb2sgc3VzcGljaW91cy7CoCBJJ2Qgc3RpY2sgdG8gbm9ybWFsDQo+IHNhbXBsaW5nX2Zy
ZXF1ZW5jeSBoYW5kbGluZyBhbmQgaGF2ZSB0aGUgZGlzY3Vzc2lvbiBhYm91dCB0aGUgb3RoZXIN
Cj4gbW9kZXMgaW4gaGVyZSBhdCBhIGxhdGVyIGRhdGUuDQo+IA0KPiA+ICvCoMKgwqDCoCAic2lu
Z2xlX3Nob3RfOHgiLA0KPiA+ICvCoMKgwqDCoCAiZmFzdCIsDQo+ID4gK8KgwqDCoMKgICJidXJz
dCIsDQo+ID4gK307DQoNClRoZSBhZGFwdGl2ZSBtb2RlIGlzIHVzZWQgdG8gbG93ZXIgdGhlIHBv
d2VyIGNvbnN1bXB0aW9uIG9mIHRoZSBkZXZpY2UNCmFuZCBrZWVwIHRoZSAic2FtZSIgY2FsY3Vs
YXRpb24gaW50byB0aGUgZHJpdmVyLiBJIHdpbGwgdHJ5IHRvIGxvb2sNCm92ZXIgYW4gQUJJIHRv
IHB1dCB0aGUgZGV2aWNlIGludG8gYSBsb3cgcG93ZXIgbW9kZSBhbmQgaW4gdGhpcyB3YXkgSQ0K
Y291bGQgY2hhbmdlIHRoZSBmcmVxdWVuY3kgdG8gQURBUFRJVkUuDQoNClRoZSAic2luZ2xlX3No
b3RfMXgiIGFuZCAic2luZ2xlX3Nob3RfOHgiIGlzIGEgc3BlY2lhbCBjYXNlIHdoZW4gdGhlDQp1
c2VyIGNvdWxkIHRha2Ugb25seSBvbmUgbWVhc3VyZW1lbnQgYW5kIHRoYXQgbWVhc3VyZW1lbnQg
Y291bGQgYmUNCnRyaWdnZXJlZC9zeW5jaGVkLg0KDQo+ID4gDQo+ID4gDQouLi4NCg0KPiANCj4g
DQo+IA0KPiANCj4gDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpwYWMxOTQ0X3Bvd2Vy
X2FjY19hdHRyW10gPSB7DQo+ID4gK8KgwqDCoMKgICZpaW9fZGV2X2F0dHJfaW5fZW5lcmd5MV9y
YXcuZGV2X2F0dHIuYXR0ciwNCj4gPiArwqDCoMKgwqAgJmlpb19kZXZfYXR0cl9pbl9lbmVyZ3ky
X3Jhdy5kZXZfYXR0ci5hdHRyLA0KPiA+ICvCoMKgwqDCoCAmaWlvX2Rldl9hdHRyX2luX2VuZXJn
eTNfcmF3LmRldl9hdHRyLmF0dHIsDQo+ID4gK8KgwqDCoMKgICZpaW9fZGV2X2F0dHJfaW5fZW5l
cmd5NF9yYXcuZGV2X2F0dHIuYXR0ciwNCj4gPiArwqDCoMKgwqAgJmlpb19kZXZfYXR0cl9pbl9l
bmVyZ3kxX3NjYWxlLmRldl9hdHRyLmF0dHIsDQo+ID4gK8KgwqDCoMKgICZpaW9fZGV2X2F0dHJf
aW5fZW5lcmd5Ml9zY2FsZS5kZXZfYXR0ci5hdHRyLA0KPiA+ICvCoMKgwqDCoCAmaWlvX2Rldl9h
dHRyX2luX2VuZXJneTNfc2NhbGUuZGV2X2F0dHIuYXR0ciwNCj4gPiArwqDCoMKgwqAgJmlpb19k
ZXZfYXR0cl9pbl9lbmVyZ3k0X3NjYWxlLmRldl9hdHRyLmF0dHIsDQo+IA0KPiBUaGVzZSBsb29r
IGxpa2Ugc3RhbmRhcmQgcmVhZF9yYXcgLyBpbmZvX21hc2sgYmFzZWQgYXR0cmlidXRlcyB3aWxs
DQo+IHdvcmsuDQo+IFNvIGRvIHRoYXQsIG5vdCBjdXN0b20gYXR0cmlidXRlcyB0aGF0IGFyZSBi
b3RoIGhhcmRlciB0byByZXZpZXcgYW5kDQo+IGRvbid0IHdvcmsgd2l0aCBpbiBrZXJuZWwgY29u
c3VtZXJzICh3aGljaCB3ZSBtYXkgd2VsbCBzZWUgZm9yIGENCj4gcG93ZXINCj4gbW9uaXRvcmlu
ZyBjaGlwKS4NCj4gDQoNCkJlY2F1c2UgdGhlIGRldmljZSBjb3VsZCBzdXBwb3J0IGRpZmZlcmVu
dCBtb2RlcyBvZiBvcGVyYXRpb24gZm9yIHRoZQ0Kc2FtZSBhY2N1bXVsYXRvciwgYnV0IG9ubHkg
b25lIGF0IGEgdGltZS4gSSB3YXMgdHJ5aW5nIHRvIGFkZCB0byB0aGUNCnN5c2ZzIG9ubHkgdGhl
IG1vZGUgdGhhdCB3YXMgc2V0IGZyb20gdGhlIGRldmljZSB0cmVlLg0KDQo+IA0KPiANCg==

