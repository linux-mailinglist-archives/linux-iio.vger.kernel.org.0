Return-Path: <linux-iio+bounces-8416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E999F94EA91
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 12:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AD0280ECC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1B016EB77;
	Mon, 12 Aug 2024 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="A8/G/sLa"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3215F40D;
	Mon, 12 Aug 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457619; cv=fail; b=SmudB5wQaIjNkYDAy3uJclX8GhX9n5nfY+A+sEvPQtCFi5oRtFLGup/c5WfDr0uEageyuYtJoN+zF4ncZF2K83Xh8Kz0LGPv1MtssPgXJdq5c0bsd+I6J69aBsmaYr3XajpEOzWFiMpfdNexOGPOYDFMVBM9NcQlBIva7W/sfB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457619; c=relaxed/simple;
	bh=hBh/Sj7hYdG20p73JvZOettLtlJ6jMuMLAE9eNQTnco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mAPpjQaJkud7ZPTBmTGBjxvAvIuwSKSkiMEe8KHmWdtpIXQVAJ98YxUbjWOfFxGFmZQvFhyXMqZfIZRdQ12sbFPISoe6BQs67Rp/AkHh5A8kXrNA0ksRMo1iHOS5PRewJK6IEiMCOHgtEFIJoZzISi4ekhXRLTJt9ndgn71E+nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=A8/G/sLa; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTvLFn8LXwOQXoQ9PSdnEn8fI+CPVWvY6dbZgNXHToEtt0b5Rdfulj0YaVRbf/Au516KuMLdT63f3oL/fBL17A5wPZvFXmiDb1XX8tlqLikq88erRQ13+UdNKjXd4Ji5fPyYamMEWdtDL69VcTDUw+xhYkbgAZxrPgHEnPAHKWIxmeaTX9vhsyQS+PHq4LBHsP3VTsSHGam3PS4O+qtFFtj90qKKqI9q+p1sBx0eT4VgwHlhAYxgaIJjD4d2pIx9z3RLbhxxMk8VmhdGN6wd0yT3Efhv1Z010F1xahbY984PXisMpPkAAzndZxPvSRM4ktwkpH7554/g3n1fjCP4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBh/Sj7hYdG20p73JvZOettLtlJ6jMuMLAE9eNQTnco=;
 b=U04N39SfcXJHFVZoo4ZADjt1d9qMS/toC7kceZ3hhYvFl2Os7DWvma5z6jYH8gNzShI++SQ/P++WUdIr4pe5dYRqALLdt0deK4SIyZ2Ou4Vd9PIrZeHsRh7n7Wk/kWCZqOCEUvJ+OUqdVVTA0poVkOeCa5C2KqEAq1XaI2lF/j0R+YgGQUcgO12CNn1oZicXkQneA+W/F21wrI7ZJfe/oNR0MTTppgMTgzHIRiN9W6mf6X7PuOC5N+N02GrZRiZuOEos3adJDsWgM/a3kiVormw5qj3SBr7qT9IrrDv98hP1oXTH3ZLHHzi9zMzaLi4naoPhs0dbjM7pV25RwT+1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBh/Sj7hYdG20p73JvZOettLtlJ6jMuMLAE9eNQTnco=;
 b=A8/G/sLasglhIxyxUAfkfsufaiC7cqq6f3OuI1hb8af5G8KzTxcFLldUl697uhPBMs+H/haIlaJyKX4WqZ14Psu8/XdjZRYhomyVIKEkZV55QUUL6iZxgNRppnpmBO/LDjkPKSbNuNWE8PAwTA23Dt0I4eaXi8Ye/4JeFmTbuI7o4wl87RojYvEJvjs4PeMup6UpBpehsGg2IqBNyMEK82o+F4TSBkcogQ2ribGG9/J7sUXz7g1jdHYoLPA/a2c+/l9VUFN6HrhEjGrxtlhmaUaQy0O7kqXiMcK3CDBiPWBkMFCWHGG0hNTxtv8GTaPIyxfJk/IC7d/ZF6cRuCzzaQ==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by AS1PR10MB5723.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 10:13:32 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 10:13:32 +0000
From: "Shen Jianping (ME-SE/EAD2)" <jianping.shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: "Lorenz Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>, "Dolde
 Kai (ME-SE/PAE-A3)" <Kai.Dolde@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>
Subject: RE: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Topic: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Index: AQHa6k2uA9cl/09kzkKzfXi0qtLeGbIe1LGAgAABl4CAAZuQgIAC9Upg
Date: Mon, 12 Aug 2024 10:13:32 +0000
Message-ID:
 <AM8PR10MB472160D07411EFB84C2B1F92CD852@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <16c09207-48c6-4988-873f-772fa277f3b8@wanadoo.fr>
 <AM8PR10MB47217E50E6A7E20DC5C89973CDBA2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <f890d760-9610-4e6e-aa7e-4920e25e936b@kernel.org>
In-Reply-To: <f890d760-9610-4e6e-aa7e-4920e25e936b@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|AS1PR10MB5723:EE_
x-ms-office365-filtering-correlation-id: a3eed346-1e34-47e6-6f4a-08dcbab76bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2hwamJUODdycTBXOXl3Z01CbFBWczJYTUV1NzQrUUpPZjh2WEFsYlR6cFhw?=
 =?utf-8?B?cEtocXBYZXIyZ3JkSnlrQ0xzQTlsWHpMOFV3a0p4ZzJoeHBYQjNpRjhJaFBZ?=
 =?utf-8?B?UHZoZlYrSjRjNDFndlpWelF2bzNXc25zY3diRHd4OWJGcTRSRHJWTzZyY3Iv?=
 =?utf-8?B?VVFqRXFZQ0dJakpmSy9rZlcrVnpJS3lheGNLck9MRUhxTFc2TGd3VCtGWVF4?=
 =?utf-8?B?dkFQU0lkZUtwTXFLV3dMenFRVXBxWENKVmRxenlXKzgrZVJydjJOc1pnVHcx?=
 =?utf-8?B?UnQxSDNQeTFUWFIxWUx6QmtPbEdQZCswMUhYRHZFWUZlZm5wKzFudDllTTNw?=
 =?utf-8?B?NTFuVmhPWFBVUVlZYTJ6TmJhZmxHOVJ5NllHMDROazNFaGU5YjF4WStCWldP?=
 =?utf-8?B?SnlNVmV2blQ4Qk4xQjdHME1GMjZyT3V6Z3NvbXY2TnBEcTlIZDRsa0tZZGgy?=
 =?utf-8?B?UkhkU3FZMUllbHI3WTBMaWdDamFpSTR0RkVMOWZhTGU4S1d1UVUwQWl6UGdB?=
 =?utf-8?B?K0Y4R3pQcWdlT1A0WlN6RUpHZE1nVHp4REx1T2lFa3dTdVVqNi9xamVINHkv?=
 =?utf-8?B?dHBnUDUxaWlZZmhoMGt5d2pJTTVCZ2FNRlhjZ3B1Z0FTb3BJRXZRVlVEU2tv?=
 =?utf-8?B?K3c2U2N1WUtOMEk5OUtFcTlmTzhKNEpSWWZtOTBwUEk1YnNKQTNQMVYzMHJG?=
 =?utf-8?B?QU45ckRTZ3ZWbkx4aXpxTFZlRTU0T1oyWWxHb2MybGxNOUUxaHc4b0Z2V2FJ?=
 =?utf-8?B?ZXZueWMza243WHRHV0Fsa1VPV2RydmF2VGg3UUM1SDJBdzJhMW1IOFhGb1lR?=
 =?utf-8?B?Y3hrcFVPK3paUXdwcGlaUG01V2xzckpTbHN5OGE5VlpOQjdMaThXOXBNa2Q1?=
 =?utf-8?B?ZFh6ckZPUzViTmF3VUF0YTVYdEJ6a3UraGRpbTVtNlFJRUNRbHpwN1IrUWwv?=
 =?utf-8?B?TmZJMHhsTmdEM25JMVN1VmkyaVlIVXFBWXRweHQ4YTJ1N3kvdkp1d0NPTnNS?=
 =?utf-8?B?cjVKR0RhRk5iOVdSbmhidzA4S2dwNVE3ZEltQ2tnbmQ4K2hiWitBZVFJZmhn?=
 =?utf-8?B?TGh1Zll3UkZiRVZzWG9iaTN1cGt4dmg1TmNaZ3RTUFFmaHVEbGpDU3lSNVVE?=
 =?utf-8?B?YkRROFhidFEzZXlMaktPOFF1RzBvNTBBY1pWcjNLWElBTXpGQTAyNVNDaFFa?=
 =?utf-8?B?WElCZm9jL0h5cUErclhkMFFTYmNGSDBubUt4alhuOVhJTDZLT2FnTTZQa3Z4?=
 =?utf-8?B?ZHBMOWc3enpJbVE3S2tZbEdjdkVuSlUxaGRoVVkxcHZ4NE1WT1pwMUhOd0I2?=
 =?utf-8?B?Y0tBL0xTQ1BsdjE3TGR3Q0Jab1JOei9VV1MvdmxrYW9xdDlBY3hibDRkVkpW?=
 =?utf-8?B?Njk2SmxFSGdJbmVuNkQycHBRbGp4SUYwbGxoK1ZFWHZjYlBxSS9FdzYxTHkz?=
 =?utf-8?B?a0hGVGFoNUdPYnVLOCs1TGRkRHVKN3dBd2djZ21OTk0wRGI0YXJKN2NlQi9C?=
 =?utf-8?B?d1NzbmtsOWF3UUZmbzdkd09YdlFmdStSWHgxVG56R3Bacm96cnlqMkp6Q0F3?=
 =?utf-8?B?R3pESkFYdFpTWUIwb2NPMi9GcmNSTm95ZXlsNFRhY1VuNTlESWVpSXBHN1dH?=
 =?utf-8?B?ZWpxZUxhMXMvQU9JbGh6dzBSdWNZOVlWd0ordkV1SjZyOFRDN3orSE92Rk5Q?=
 =?utf-8?B?czBpdGhFekl5YUxhcnRIYWRKNFhVQTRWZC8vMW95Ny9VM3AyWmRSeTlSSFMz?=
 =?utf-8?B?V1Y2Z0dvQjZVT0IySU9HUEI5Z08rSENQcE1SQVRFaGlMcE5pVnVMaHRCeEx6?=
 =?utf-8?B?ckludXJ0SlhTcVowSGhYTXFpN2hEMzNONmpabnRMc0hzUFNIWllIR2FsdVRI?=
 =?utf-8?B?NWpiQlpYeG1SaGpmeFVFZjk3bnRtc0NtVmcvODI0d2FCS1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFdDNm10ejBnVlhYYWRJcjZUOVZoc3hLVzhHeE5LaEVjYkswQVZBdnJFaWt0?=
 =?utf-8?B?Q2VHckR3Y3MwZkN2WndDVWNBSEppcnc0OFRBV1kwOGFSczFtTG55UzRFbStj?=
 =?utf-8?B?WnZOZ1BlNE05YnlmcXRNclp1M3hxQVhTbGdZREdkbkNIOWIrMGt4anltUllU?=
 =?utf-8?B?dU82aXoxbjJWaVNpQXBtV1pSSlY0azJNNTNwNmJHM0FRUHg0TEhTbkE0TU5P?=
 =?utf-8?B?M3BXTGZFUmZ1a1Z4WFlGTEJoM29pYXNUSGlIVjVEL09zR1EzVFdkT1A4aVFq?=
 =?utf-8?B?QzVSUDZDK3d6alZLSENQbFZnYVRBMTJnYm5RenJPdlQzQU9jTy9lWUFJZnpT?=
 =?utf-8?B?STBscm1sb2svRkh4R29DTzFBckNIaHgzMXU0ZHNQUGVZM0FPOGM2SGNPeitL?=
 =?utf-8?B?aW9VNjFocEl4SHR5MkJZbXdkY1ZVOUdWWjRLQStDOW15OUJQNlZJQUt4T3lr?=
 =?utf-8?B?WEFBY09uR3BCN1JZQmZrbEpDMksrVkxESldiVGMvZnRlNDU5MlBiWHMxd3pM?=
 =?utf-8?B?YUxTNHZRNEtWRXNOc2JRUkoyeDJnVk9oc3VLWmxqd3ZMbGkzbUptTEFldzhl?=
 =?utf-8?B?blFIR1JQK254TG8rdEUrZkFMMXZLWEV3SlZBVTFEb3FaNEpjVVVKeTQ5Z25R?=
 =?utf-8?B?aCs0WE01dm1tcmJmaVU5ckZlL0NyQkJtQUJwa0k5b3U4TWg3MjRFU3Via1BO?=
 =?utf-8?B?Kzh2d1htVWdXN2lqTE94K2pWZFZEU3ZlQStXNU5BZ0dWTkc0dlEwYUdrUGVh?=
 =?utf-8?B?d3hGUFJDSnowMmIwZktIQTBtYXdOcGFaS0JBNFhNdWNZc1pJejR2VzZnSkkx?=
 =?utf-8?B?N3RFc3pQcjlWcm1WZGpKWWdORDJ0azkvVW9BdVBUUnhkL3kxQnlQaHBxdEht?=
 =?utf-8?B?NkZqc1NmMUlEOEI0TG9ONk90aEEzSzFBZmZTZUVCTDU3dEY2NVJ4TnR4b3p3?=
 =?utf-8?B?SVlnZVQrNEQrNm9aYXlKUUtwdnRYdEYyVW1sc0NjdTUyalJ3SW9kd3ZlWWtz?=
 =?utf-8?B?U3VIejR4eGppeWJmeVJqZnVWVDgzV0VFUCs3R05MS1Z4a2VmVW41b0w2Nlo1?=
 =?utf-8?B?MVc3UWxIck5xdW1nbDJwZ2ljTXAwdHpDWWNQdWVZdkN0M01QTUdzUkRZbkw0?=
 =?utf-8?B?ZzRNdUtxYWhSTUIxUXkwZUlyb3RLL2Z4aWxIZlpxL3BSdGRoNmsydnpLM2Ja?=
 =?utf-8?B?VGU4NXVabEZidzZsbFpzc0hlL0xHVWsyQ3l4Q0h1ODIvSS9SZVEwakpEUEFE?=
 =?utf-8?B?YVlNTVV5Qzdmb2F2NUdhVWNVVXJhT1BPWEQ5Y21iSTVGY29JWGdiNmF0UlVx?=
 =?utf-8?B?b1Q4RThuczNHZi9qOWo0UzVqU2VHWkE2SFBNU1JOK2hkL1RCRWJxRVY3UmJJ?=
 =?utf-8?B?M2ZhMExJUVpobHR1dGhva1ZlbjIzempMZ0p0WjBSMitTdUNobkh3MmlVcXkw?=
 =?utf-8?B?RDR2TnZWNzd1QnZCeWc4TlBOakVFeGxBMjh0MURjQmNGOUhDd2U3SC8xZlVo?=
 =?utf-8?B?ckNuVGZpMWtvdE85MFVQcXQzNHIrQXpyQ3k3NXIzdWVwa2tFQWVSQjFPelJK?=
 =?utf-8?B?a2s2ZTMzUDRTNVNMaXVld01hMEdRaG5NNjZuSjNwTXptZnViVm1IQTRsb1I2?=
 =?utf-8?B?T3dKWDNYNXJSNk0rMzdFUk9MTHVxSkpSLzE1ZlpuclAwcmhVNlhOUmgvRGJD?=
 =?utf-8?B?OWw5NGpDa292WlJYS0Nlenl1OHlucjREZmo1NEFDcFZ3Q1RJb2dYcjJqd1hC?=
 =?utf-8?B?UFBYVkdXZzJCcnF0ZkF5ZWdEVXFEWnIwUDRRc1RHVjI4YWl0M3ZCK1VXaC9z?=
 =?utf-8?B?WE91YXFrKzl6bk94eVJCcUs4L0hqQXFaQTdJQ3B2SkY5TS9nZTNBTDJhY1p0?=
 =?utf-8?B?RFJRYkVEd0tnUXhPK2JiWFdZYnRySGcwNHpINlVQYU4wMFlTU1c3R3FjK1Vw?=
 =?utf-8?B?MDdkNTVzeWRXRU9WcjRhcGRqZlRzTlM0NkJ0NCtHZlkrRncvV1RHRXJmR09R?=
 =?utf-8?B?Rm5Xa3Jqc2FjZ2JOR2MvZFNXYnl4QXpZdis3Q3huV1IyWXJvTU1wM0laV25O?=
 =?utf-8?B?SjMrZEVKYWNuNVpBUFg2dVN4SnozZ1R3U0lZY1FKMUdjb21wYVg1Ulg1Rjk0?=
 =?utf-8?Q?Vhk8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eed346-1e34-47e6-6f4a-08dcbab76bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 10:13:32.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJ8W+U2PKoCV3gCj2ZPgu/4w13uB9S6rLkJQPlnqgeBUDTjbA94ujGk4ubE+G9I1/5v1pMioet/D2GQeuZLWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5723

DQo+IEhpIENocmlzdG9waGUsDQo+IA0KPiAuLi4uDQo+PiArDQo+PiArCWRhdGEgPSBpaW9fcHJp
dihpbmRpb19kZXYpOw0KPj4gKwlkZXZfc2V0X2RydmRhdGEoZGV2LCBpbmRpb19kZXYpOw0KPj4g
KwlkYXRhLT5yZWdtYXAgPSByZWdtYXA7DQo+PiArCWRhdGEtPmNhcHR1cmUgPSAwOw0KPiANCj4g
Tm8gbmVlZCB0byBleHBsaWNpdGx5IGluaXRpYWxpemUgJ2NhcHR1cmUnLCBkZXZtX2lpb19kZXZp
Y2VfYWxsb2MoKSBhbHJlYWR5IHplcm9lcyB0aGUgYWxsb2NhdGVkIGVtbW9yeS4NCj4gSXQgZG9l
c24ndCBodXJ0IHRvIGJlIGV4cGxpY2l0LCBidXQgd2h5IHRoaXMgZmllbGQgYW5kIG5vdCB0aGUg
b3RoZXIgb25lcz8NCj4gDQo+IC0+IFRoaXMgaXMgdGhlIGZsYWcgdG8gZW5hYmxlIGNhcHR1cmUg
bW9kZS4gSXQgaXMgaW1wb3J0YW50IHRvIGJlIGRpc2FibGVkIGJ5IGRlZmF1bHQsIHRoZXJlZm9y
ZSByYXRoZXIgbWFrZSB0aGlzIGV4cGxpY2l0bHkuDQoNCkl0J3MgcmVkdW5kYW50Lg0KDQotPiBX
ZSB3b3VsZCBsaWtlIG5vdCB0byBtYWtlIG91ciBpbXBvcnRhbnQgc2Vuc29yIGxvZ2ljIGRlcGVu
ZGVudCBvbiB0aGUgdW5kZXJseWluZyBpbmZyYXN0cnVjdHVyZSBiZWhhdmlvci4gT3RoZXJ3aXNl
IGlmIHRoZSBuZXcgdmVyc2lvbiBkb2VzIG5vdCB6ZXJvIHRoZSBhbGxvY2F0ZWQgbWVtb3J5ICAo
YWx0aG91Z2ggdGhpcyBpcyB2ZXJ5IHVubGlrZWx5IHRvIGhhcHBlbiksIHRoZSBkcml2ZXIgd29u
J3Qgd29yayAsIGFuZCBpdCBpcyBkaWZmaWN1bHQgdG8gZmluZCB0aGUgcm9vdCBjYXVzZS4gVG8g
ZXhwbGljaXRseSBzZXQgdGhlIGluaXRpYWwgdmFsdWUsIG1ha2VzIHRoZSBkcml2ZXIgbW9yZSBy
b2J1c3QuDQoNCkFueXdheSwgaXQncyBub3Qgc3VwcG9zZSB0byBiZSB1aW50OCBhbnl3YXksIGJ1
dCBib29sIG9yIGVudW0uDQoNCi0+V2Ugd2lsbCBjaG9vc2UgdGhlIGJlc3QgZGF0YXR5cGUuDQoN
Cg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg==

