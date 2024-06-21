Return-Path: <linux-iio+bounces-6675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE9912265
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 12:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA0E1F250F0
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3B17165F;
	Fri, 21 Jun 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Lcm6LJO3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCC17109B;
	Fri, 21 Jun 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965758; cv=fail; b=B1uB4tX3918/mO3Cb/3gNmdlPtu0C1TTl1eYkX8FwIMRpIhlXUOy8ea5zwBDhv1Gd5suRvfj0RKNpXB3YFnaLiPRPY8i5b7EnccVyF8QoAhanRnBYPBqmUk0HnXDikMlvb6C6xDRYq5Dz7pOJV8Umcs6Gt1wtROJgabYvb4/kkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965758; c=relaxed/simple;
	bh=hBhG/CkQbBH9CX0n7WzT/HMJAO9A2VQt+1AD/CzPySU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+Fg34/nzP8no4YqPV413W+6901L5kGCT2HkPqNAKPp5cW1WRmj5bXLEbmMwIrpw+uxTgpylZSQCC5GTzBxfLymxe0Moq6lNdbvKOH+0NUsn8OG+iDjyInCCODDHbrYv1q8ltvrQ8R+jEFrncMDgfSxB63QNfzSc9zmARPRbZuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Lcm6LJO3; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L8LOeP004059;
	Fri, 21 Jun 2024 06:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hBhG/
	CkQbBH9CX0n7WzT/HMJAO9A2VQt+1AD/CzPySU=; b=Lcm6LJO3Bzm1jQSZtEfVm
	TTFn1gXQM9Sabyq4AE00i2KBBJPRYM/28C3UhqJ/5diOcH3wD5zR5lZRjpd7A3Eb
	DyU1n0sJrHgtbQRqJmGsIaLdjkM+9/JZ7zChleFJCSz3H7/Qt34fsVlZEXKdcqIJ
	IY+Y+7ECYFYcIBBwW1Ep+gAoYDj91EicH1K2SBLLh01GCFr4ENpfXOwQAwi2szjE
	fRmc8yEOJt5br38XEa5Mz5KIrEteEFLvTfZPhI1LDr8XovrW/rH+VhzdJ0ULwONx
	xWlbk8GmK96AGrd66mKqcdhO3dTCQECDkplCsDNpRGR5xjMPUCQrGwmintQQKcAP
	w==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yvrjqk509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 06:28:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVBOMwP5ApGHRpwYA3mCzZim093A5Bos9jOCCoiy7q26WmAttCMgnEYiZC9Qxzww4oF7MtjLHxH40txptdHiqtzXtgEY4trvL6Y7mRqq4IeGu41GimRRu7DxI/8udwubHUq4xSQzfwAWIVb3HZeMp8enwOv9kcY26gEoAPwYtuv27xRMtpXxa00LD8zzp9qmXuc+10X95f5ynDU/4VRdwfPh5RebHJsdwdvxs+Kf1j+Zw979lGe49Tkfk4qsLRExQTE8GBF2e2U+CoE7l7EJwNx9Kt0aS52HF9OwUZAFV+6uT0UABHwTs3ze7zo4lgQAR4fBkfHFeyHnb9VtN5sLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBhG/CkQbBH9CX0n7WzT/HMJAO9A2VQt+1AD/CzPySU=;
 b=iu+VoVLkENCvX8v+EPVwKwjT8DQCp51SRs0PJ6rz0BuMAyIOoq2Ra8SUxs+dcg1ZesxX78Rw18r9xT/j1ydfbspLE7Dnh576BMbu80kfVKJpN6I4GimMqikDvDuR4ubtRy28jNVfSkxU7bdZDm9ETMej6/JDJmdcVCOdpcqbACg/iZha/pGuLUNdpJNGQh01Y42YA/97xA66vsqjhCN1lXFboXFvMtsiQ15J8DjijrSENZg0U+vq9mZVHDuhyJnPTc8X3pVDQIIWmKP0vYQJuYmUtroQ+N+mbGsb6vxfmGo1pfLNfLcmhAiIEatoWH8W/ek1S/7E5kzVvhp/PmXHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by PH0PR03MB5925.namprd03.prod.outlook.com (2603:10b6:510:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:28:43 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.7677.029; Fri, 21 Jun 2024
 10:28:42 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jun Yan
	<jerrysteve1101@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Mario
 Limonciello <mario.limonciello@amd.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: iio: accel: add ADXL380
Thread-Topic: [PATCH v2 1/3] dt-bindings: iio: accel: add ADXL380
Thread-Index: AQHaw8RfWEkArv6y7UaHAYNoUW4DXrHSAckAgAABC3A=
Date: Fri, 21 Jun 2024 10:28:42 +0000
Message-ID: 
 <CY4PR03MB3399FA758EBC15E4EAB14F6E9BC92@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240621101756.27218-1-antoniu.miclaus@analog.com>
 <7bee89c6-605e-4ac6-ab4c-e1c0b68e6a77@kernel.org>
In-Reply-To: <7bee89c6-605e-4ac6-ab4c-e1c0b68e6a77@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB3TmpVd1pEUTBPUzB5Wm1JNUxURXhaV1l0WVdZME9TMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTURZMU1HUTBOR0V0TW1aaU9TMHhN?=
 =?utf-8?B?V1ZtTFdGbU5Ea3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhPRE0zSWlCMFBTSXhNek0yTXpRek9UTXlNRGN3TURZek1qY2lJR2c5SW5N?=
 =?utf-8?B?MGNHcFdUSGRCUWtKRmVsTnliMUp0VFRnMWNuWmpOR2R4VVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWpNMVQwUkplR05RWVVGWlkxQTJTSGsyYVdaR1VH?=
 =?utf-8?B?aDNMMjltVEhGS09GVTRSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQldWQlVTVEpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|PH0PR03MB5925:EE_
x-ms-office365-filtering-correlation-id: 5ed35b15-ec81-4071-472a-08dc91dcecaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|7416011|1800799021|376011|366013|38070700015|921017;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cEZwZjNmVnJTa0RWY3g5dVZhRDZCUWt4d05rOVQ0K0wyRE94aFlXMnJGVFVm?=
 =?utf-8?B?KzE0Q0tyQ2V0Yjl1Q1dWdGdwQzgwUHE2TjltbTRRSnJXV0padFdaVC9HODM2?=
 =?utf-8?B?ZGNzdVFmT0lROTVIQkJWeEdTSnJFakswdmxTTzV2akE3TldpcXp4ZmdCT3Ux?=
 =?utf-8?B?cU5hbCt5WUxiMjNJdEZpSTJtQ213OUpHemlRRWw2em0rY01RT0lDT2xzakhr?=
 =?utf-8?B?OEJIWWo3RlhPa3JQajY0WnU3SW1QWVJzSkZ2RXloekNpaFdDQkk2WndzN2FO?=
 =?utf-8?B?di8rYmJnUGZyZ2w4VGxlZW1WR2YwOGFqSWZzR3hvN3RpRHJqTE9sR3JxZ2xC?=
 =?utf-8?B?RWVUdlcrakVGQmY1VHZkTnpvZFE2QTlaWlFNRUFUZzFwb2lYQVU1WUhLZDNV?=
 =?utf-8?B?eEJVWk15U0s4QnozUTZJRVNUcTFOM3ZSVGlHajVQaE13b2VDZ1FnYmN2aWNS?=
 =?utf-8?B?N2pueTNxUGFpYTFIRS94eThTRXlVWEFoNDh3Y0ZnMnI1cldlbzJRZ0JXclp1?=
 =?utf-8?B?eEVZL3dwNzVTalA2MktjeWhUOTg4dzJ2V0VMYXBMU2l4Rmprb3hudWFBRHVI?=
 =?utf-8?B?VWtmQ3hQRzVzbVR0THR0YTk4NGFmMVcrclRzb0l6MDFpOXkra0F1c1hSVHZl?=
 =?utf-8?B?aWR2NmJFT3FHMHRCbjhkTTN4RDBwSUhRNFhMT3h4SUJKUzVTSnUrakhYZWJ0?=
 =?utf-8?B?dFhKd1QwVythM01nc1ZHSzZ1anBrN29maGlhS3dkdzJHL1BnTEw2S2h4ZE9C?=
 =?utf-8?B?Y1dpcmdmSjhaYXRaMTdOUWFYMC9VZGMrbFUyQ3F5MEtyVllxZlBWRk54M1Ew?=
 =?utf-8?B?Y0oyMy9YZ3dnUU5FcExTcmZXR2VSbGlOZ204UXpacS94bzFhZHE4a0ZqWXEy?=
 =?utf-8?B?dUJKYjVWSjQyd3dzRzFJdUNFMXRmTDQ3aC9aSXliSGRoeGN4UU9SS2ZIQzhy?=
 =?utf-8?B?cDQxVENLbkVSTFlxTUxYcUt3OE1EazQ0ejhEWThROUhtQm1lZ1B6dXhYY0Nz?=
 =?utf-8?B?endJcEZJd0t1K2xxYXVOQmIzdVRVd2J6TU1JWHVwQUhsSFlnR3pzdHBEYnRD?=
 =?utf-8?B?L1B0Q3I4WWtTelpGUTFBUmhlY0dManBPNDZTL2U5YTVHN1FLc2NEdWJLaE5Q?=
 =?utf-8?B?QUM1NDdQWWpQZDNJc29ON0ZkSlZMMWNEZEJuVzhRRXVBbmQ5K01zeVc2WkF5?=
 =?utf-8?B?NENKNzRQczJTQWx0dWE0Wllqd1J0N2tHSEUyUGhsYVRRSnBMWTluQWdEVkV3?=
 =?utf-8?B?SGZtV0NsNUtqM1Z5Q3IzeWd3UjZLQmpNZit0RTBBWFFjRWtlZlhBMm9nTDBw?=
 =?utf-8?B?ZnJWbzZMcncxNHJKd1NFK2JISnh5ZEphWGkvbWpTaURVWEFDTUZseXpKd096?=
 =?utf-8?B?b3R4cGN5YmZMNWNYeU0yb0tjMXRMeHBsRzE1MWdrQlZ4ZytpS3lHUDlxcnVp?=
 =?utf-8?B?ZGt2TVNEQytQRXJNRldXa0twTWFmUGxmUTRyazdtczJ4UkxQcHN1ZWlSRkR4?=
 =?utf-8?B?YVF1b2w3NTJrRnN3aVRBRjZGVUZXT2hpSk1sQjVIR0IxS1F1MVBOUWFkWS9s?=
 =?utf-8?B?aHlwYXFyOFZQUmV3aHUwU0NnbEFxNTAyL0plc2VLeVlFb1c0d0VGQncvNjJz?=
 =?utf-8?B?dERrVlJ5Ri9nbERkbHk5SXZ3WXNpbk1LNXRDa2lENkJLWXhkTk1vQk4wamFO?=
 =?utf-8?B?RDNtL3VibkhzOTFjczQvMy91UWRVOHRUNWF1MEV2bWZ2S09rUFNGQWJlSWwr?=
 =?utf-8?B?Z2dDbTBtSUlhTFBPYVJ3aTJnamhDa2NYVGE5M0YrM1FqeUFjeE1MeFFQaFZF?=
 =?utf-8?B?dTFaakFKVnEwMHBWdjFsUWZBSUh6S2prQ1EwN1VhZm5OeUlNNWx4eHM3RXR0?=
 =?utf-8?Q?5MQbUn/N0IzwT?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(376011)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RGE2Wk5Ydmk2emYreFVkNGk2eXhUM3JtQ1IyR3pMR21hQjFtazNaYVJFV1h0?=
 =?utf-8?B?c1RCTWsvNjlReW1RZU03aHlNUGt1VURjWUFIb3JCdWVOWXp2bURoYVY3clhz?=
 =?utf-8?B?dC84Mmx3cWFsZDFuU010Wk5WUjQxWGhzdG15dTVYYjg2N1FlcUpMb0E5QTBF?=
 =?utf-8?B?aS90eHdpTXZidHh6Z1U5RnM3SHl4dzFPZGVhVFZRZDZ2YzB6dWh1UHd3V1BB?=
 =?utf-8?B?TU5xejYxanI1MkpxeDQzSXZsRCtXR1ZQSHYxTEovVzdKYThMUU02THVxQU0w?=
 =?utf-8?B?a08ybktudDlNUTRPU0JOdkpDZHl3K25mb3JXSDBIUlBZeCtuS0ZXakVabFJy?=
 =?utf-8?B?Zy8zSStBSkI4bW96MUpTaGZCdVRhZDN6cVdMRU1YMitrcVI5RzNWUHBNbG1D?=
 =?utf-8?B?TTVlQi9RMkNWaUkvQW9GVzRtVFpjQlFRVjZaNFJuNzlWOGNYbU91bzRQZFRy?=
 =?utf-8?B?cmcwS3RHeW9GMGxES0lnaFgyM3hHbmtZb1VsT0VzenRoeEJVcnNYSFZSODdR?=
 =?utf-8?B?WVFHcDVVcm85YWJYQjNTaEZ4eU9VcEMyWWdlNWZJdXU2MHU5eG83c3dkdkEw?=
 =?utf-8?B?VnJzL21QMzVnZFM4b2I5Z1p6bU1Ra2pLYWpnSjBoallrNDZSWTl2Tm9FWkhx?=
 =?utf-8?B?TXlmNDh1V3BtWndteHVPMno2WDQ2REpUVXlwL0Jnb0dxNGt4S0FVc3Ntb0ow?=
 =?utf-8?B?bzZGRzFhdURzWUhpRjJZWE9EZ1VzQXRkMU9nWkpQVXViZkhyeWRRY0tpQStr?=
 =?utf-8?B?emQwVG52MWlKRmlqS1ZkUGVpZ3dsOU50cFpBZXJrUHUweVRNWmJPOFZiUE4y?=
 =?utf-8?B?Slp1Wm1aYXd0Vml5d1NiOWNkRjg4UEtkS0lyTEVsWC82TjlRR2FoWDdFc04z?=
 =?utf-8?B?eVpaNHpWSElZdjZkRFVpQzhQVHRydm5kK3NnbWkxZlc3VkpiZVdHcDJlbkxs?=
 =?utf-8?B?bGpCYUxLeW80S1Z0QTNFYlBjcU5zWVNFMUtIVTJvVHBjODJlOUVjaWlySTdJ?=
 =?utf-8?B?aDRlZHFDd2Z1U2pMckVSQmdFSmxmdWRlVFQ2TXdzSk9wTEtTZllRUUs2ZUU1?=
 =?utf-8?B?UTI0ekpESVB0NFVlVHUvVFlsUlphQzJvV2tpRUhlRXd5N1pyVDJFa0VORTl3?=
 =?utf-8?B?QlVTN3ZFdkUzc3IxV05jUEdvQkdxTUZPenJuOEllSVRQbWhrbXBOc08xWlhJ?=
 =?utf-8?B?UHh2bVFVdjAzNGFaNW5GNVRZdnppOENqYXBoengyZWVleUt4UVFkQVVkUTVm?=
 =?utf-8?B?VjRXSXE1OEo5RnZyTWxxMFExNXo1dGNtVVdldXgrZVlXeUw3SjhNZXdja1NC?=
 =?utf-8?B?Z0Q2LzZKR2lka2xYK0kvVVoxSE1obGV2RFA2bkdOMW5TcU43SVNiSFg2aFRr?=
 =?utf-8?B?TDRGdUFET242Vjk1aWF4citITWtvY0x4cTBvQXRrSGhoM01sNVlKKzdaaWk1?=
 =?utf-8?B?TVBXcTFxbjhPMDQxZks5Y0lLREh2UGE3ZFlpYXpacnRMWml6N3hXUzZlTlhx?=
 =?utf-8?B?SjhsV1pnV29nUFdxbjRBNXNIbGxDTUJyZWVLWkFYamQyOFlCNlBrUlpjQjZ5?=
 =?utf-8?B?T0IxWnBtckZDSWQ5THU4bkFFUGF6RFFMdHEzWXRkVWtUWjhXTXV0SnZ6TWFm?=
 =?utf-8?B?R0wxUEpkVHEzU1JJK01KQXhReDBsa2NWRzZBSTNmN2p6c2U1bmtrRDlMOERx?=
 =?utf-8?B?QTFUVi9PMUpTL1NBWCtZWEpzUkd3TVZYbk1BZVU5NlhSZVV5b1E4MW1FaUZw?=
 =?utf-8?B?QU1BQ0JKQzZKblBiYWlOczdmemlocFRkWGxlRzR3cnB2T0lYTEtrTjVjK3Va?=
 =?utf-8?B?bHM0V3JGRFVuQVVlSTFzWnhzVTl4NG1TVm9mVlZsanFyVFpITzF5VGlpYmYr?=
 =?utf-8?B?TWZkcndJTStxMTcvWHJUcDV1QVhOSnd2TG9HVTNxYnp3cTZZQVZnWDh0Z2NT?=
 =?utf-8?B?QmU2MHVHelJKMllUVUpBSDZVTmFpdEZ4R2xmcEFYSEZzNzExRGs2MmJIbGhh?=
 =?utf-8?B?S253ZzZ6T0pqQmpBall2SWV6ZXVZblJHVC9CbzJLSDVJcmw1Sk1RR3NnNUlR?=
 =?utf-8?B?cTNhKzJKK1NyeWp5bFJGRS9vdnRGVUhEMlVxb1IycVI5QlFoRmNEeER0THdW?=
 =?utf-8?B?eVgvZ1JJeklxUTFIN2pQTFJSS0JCQWJ1cTJoZkl0YUUrRFZLU0VwQm5maUdY?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed35b15-ec81-4071-472a-08dc91dcecaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 10:28:42.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYQy3FEJUagje4J+Ov/x2phkqR3aR1+eekgMtHAu9RrDXZmPXgMNeHHpAGuj8oMs3Ft480O66nNmZnWmICjJxft1Ynfb8CzTcYobxkCieuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5925
X-Proofpoint-GUID: hC8lColgwJwvK5rP_niTtyAfISHnQhg1
X-Proofpoint-ORIG-GUID: hC8lColgwJwvK5rP_niTtyAfISHnQhg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210078

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyMSwgMjAyNCAxOjIxIFBN
DQo+IFRvOiBNaWNsYXVzLCBBbnRvbml1IDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNvbT47IEdy
YWRpbmFyaXUsIFJhbW9uYQ0KPiA8UmFtb25hLkdyYWRpbmFyaXVAYW5hbG9nLmNvbT47IExhcnMt
UGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsNCj4gSGVubmVyaWNoLCBNaWNoYWVsIDxN
aWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amljMjNA
a2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296
bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtl
cm5lbC5vcmc+OyBKb25hdGhhbg0KPiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgTWF0dGkgVmFp
dHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+OyBKdW4NCj4gWWFuIDxqZXJyeXN0ZXZl
MTEwMUBnbWFpbC5jb20+OyBNZWhkaSBEamFpdCA8bWVoZGkuZGphaXQua0BnbWFpbC5jb20+Ow0K
PiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT47IGxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IGlpbzogYWNjZWw6IGFkZCBB
RFhMMzgwDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAyMS8wNi8yMDI0IDEyOjE3LCBBbnRv
bml1IE1pY2xhdXMgd3JvdGU6DQo+ID4gRnJvbTogUmFtb25hIEdyYWRpbmFyaXUgPHJhbW9uYS5n
cmFkaW5hcml1QGFuYWxvZy5jb20+DQo+ID4NCj4gPiBBZGQgZHQtYmluZGluZ3MgZm9yIEFEWEwz
ODAvQURMWDM4MiBsb3cgbm9pc2UgZGVuc2l0eSwgbG93DQo+ID4gcG93ZXIsIDMtYXhpcyBhY2Nl
bGVyb21ldGVyIHdpdGggc2VsZWN0YWJsZSBtZWFzdXJlbWVudCByYW5nZXMuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSYW1vbmEgR3JhZGluYXJpdSA8cmFtb25hLmdyYWRpbmFyaXVAYW5hbG9n
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbml1IE1pY2xhdXMgPGFudG9uaXUubWljbGF1
c0BhbmFsb2cuY29tPg0KPiANCj4gSXQncyB2MiBidXQgbm8gY2hhbmdlbG9nIChubyBjb3ZlciBs
ZXR0ZXIgZWl0aGVyKS4gV2VyZSBhbGwgcHJldmlvdXMNCj4gaXNzdWVzIHNraXBwZWQgYW5kIGNv
bW1lbnRzIGlnbm9yZWQ/IFBsZWFzZSBwcm92aWRlIHByb3BlciBjaGFuZ2Vsb2cuDQoNCkZvcmdv
dCB0byBzYXZlIGxvY2FsbHkgdGhlICJubyBjaGFuZ2VzIGluIHYyIiBmb3IgdGhpcyBwYXJ0aWN1
bGFyIHBhdGNoLiBNeSBiYWQuDQpUaGUgb3RoZXIgMiBwYXRjaGVzIGZyb20gdGhpcyBzZXJpZXMg
aGF2ZSB0aGVpciBjaGFuZ2Vsb2cuDQoNCkJlc2lkZXMgdGhlIGNoYW5nZSBpbiBwYXRjaCBuci4y
LCBJIGp1c3QgcmViYXNlZCB3aXRoIHRoZSB0b2dyZWcgYnJhbmNoIHRvDQpob3BlZnVsbHkgZml4
IHRoZSBvdGhlciBib3QgZGV0ZWN0ZWQgaXNzdWUgKHRoZSBpaW9fdG9vbHMucnN0IGZpbGUgbWlz
c2luZykuDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

