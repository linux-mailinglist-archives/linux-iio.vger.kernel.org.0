Return-Path: <linux-iio+bounces-7422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C0929BD4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 07:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6D28138F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 05:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F510953;
	Mon,  8 Jul 2024 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nmJNk/m7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D88BA5E;
	Mon,  8 Jul 2024 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418126; cv=fail; b=gALVJtnR+833+FHndQy/Nxe/sBVEnKjodm+HB6qFwDAxOecXjDYBO40Al5GTHuQOWqj77xeM5wgE3StfUUHvCRUOn4Q7Jq/ydFrFyIGXx/JA49A3OudunySdVVQcXSVaJXLEAM8MVeU2BWP+5AWgObuKO2YLQoBOv7y36eTrnGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418126; c=relaxed/simple;
	bh=0wS0V1RqJ530jHlq97dYazcvL2/Q3uxHSSTC/l4BI84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NU6KnkZGlxX5Njdfbzl509/M8onT52xRDPD/4n2uyWj1NTzfL4yEdXeWjLO9GHTO4xXZATJQuCq5MPMEKyrfun0BLUOVvrdbMWpTJpHEI+n1ong98SorOCW0Tn6PvQuxnWNVCreDUOHV8hHNZWa5d2NvvXaM4z9Lx3ge145x3lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nmJNk/m7; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4682tiN4022857;
	Mon, 8 Jul 2024 01:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0wS0V
	1RqJ530jHlq97dYazcvL2/Q3uxHSSTC/l4BI84=; b=nmJNk/m7KfdITpXLfcd8f
	OO3YzbGBSxCLCI2f99Rs3qvZ3CWVarRkb1w0bH1abB/fYbaAtksNx1xc+IJKbxXp
	mWmvoUhCHMep/kAmrDby6tsIc05byfc8yGxkQ0LlP3P67qrjbkg0HlOhG77TpOPl
	XkRg787svyiIG3QFpTztUY4euS6NORGHR4AP4+5PEPK085/11hkcKr37hCSRYQNi
	Hfn/mq6YLFVbH0oBDrr3Ftmqs6jBtxP+2N4UtGdt7yTfcYydYJXNsw/QrM+/3SA8
	VlKrMhBVlI28xPwGiyxilJPuMPlfa91uS8d072WtwRhHMNWqBRGIKm/3hsJHZSIo
	Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4087rsgdpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 01:55:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4OqV+BZfUYgyB+u5IxVlZzP9SMtLrs/3gkwEBBv9Adqel5RIM6wCoLVlkHUmRjzfLndHKNtgP2uRY2jHSBqN1qRaTVyHIMYWQS1kOPVzP3fd0JWIhcrRjYoTx24QJkVx/IGeYPBpT/9LuN2gt+NmtS6EOh0yvpvpAZ+UELh+MQMXn6hQh200q5NJldGw7VKvOPOwX21L8dGruci+th1plCIcrlS19jwvFiCqg0DV2vVF1yxeMOJ+/f6vlmufHRcfN3T1buV0jh2BBTPJ+Aum6Y02eZucBZmTLOcCF0IaxhYL/rP/QI2aTxDzQUY6GJNCzzvOZnR9qRB2x2/Tl41rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wS0V1RqJ530jHlq97dYazcvL2/Q3uxHSSTC/l4BI84=;
 b=dX1pSuUb7FygmslcSD+xJsuPDaGDAFhzH1GM0ingxA8UV8faynSfIfqN3Y9EL7EYOdipnIaTLZjJKMI0odtKoBEhIAZnti2rXaqqajVwCWYpewFGreV3CXFOkl/1Do+c9ZAJpKvjdMeHIaiQzs4MUicsdaK+qxSOMwagJJXpxBMWJzRu2rUApoUqOIy/gtowGUKH6vdcyw+a2XHLEKBlEqph60fdQDI8DgyL3mKQ6H2jORR+wPjTA0rAPnQNnmyk3nWziOc1GMDkZI78jh/Yx1F5tcZiZ9z+fK5kim8qPziMzFOXO0vecCULq2HmxEXt2a66AaCdb4NjHLA06/0NTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DM8PR03MB6232.namprd03.prod.outlook.com (2603:10b6:8:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 05:55:05 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7741.029; Mon, 8 Jul 2024
 05:55:05 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v5 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH v5 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHazCwcEXgGXk1JKUunDqCkQHNHm7Hjkt6AgAKTpICABjFb0A==
Date: Mon, 8 Jul 2024 05:55:05 +0000
Message-ID: 
 <PH0PR03MB7141B14FAC992C1BA0C95112F9DA2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
 <20240702030025.57078-5-kimseer.paller@analog.com>
 <bba8a12a-9d1e-467b-a7c1-8a027d5c2f89@baylibre.com>
 <PH0PR03MB71417A3455B24590982C0716F9DE2@PH0PR03MB7141.namprd03.prod.outlook.com>
In-Reply-To: 
 <PH0PR03MB71417A3455B24590982C0716F9DE2@PH0PR03MB7141.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA1WkdJNE5UZ3paUzB6WTJWbExURXhaV1l0WVdGbU55MW1PR1Uw?=
 =?utf-8?B?TTJJek0yUTJObVZjWVcxbExYUmxjM1JjT1dSaU9EVTROREF0TTJObFpTMHhN?=
 =?utf-8?B?V1ZtTFdGaFpqY3RaamhsTkROaU16TmtOalpsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNREE1TmlJZ2REMGlNVE16TmpRNE9URTNNREkzT1RVNE1qTTNJaUJvUFNK?=
 =?utf-8?B?bWJVMWhja3B2ZG1jM1YyMTJTelo2TjNSMmQyOUNNRGRQT0RROUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVSa1RGSkdaeXM1UkdGQlkwMUtablYzZWs1aE1r?=
 =?utf-8?B?NTNkMndyTjBSTk1YSlpNRVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJTRUZCUVVGRVlVRlJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlJVRkJVVUZDUVVGQlFUTk1hRk5tWjBGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VW8wUVVGQlFtaEJSMUZCWVZGQ1prRklUVUZhVVVKcVFVaFZRV05uUW14QlJq?=
 =?utf-8?B?aEJZMEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQldtZENhRUZIZDBG?=
 =?utf-8?B?amQwSnNRVVk0UVZwblFuWkJTRTFCWVZGQ01FRkhhMEZrWjBKc1FVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFXZEJRVUZCUVVGdVowRkJRVWRGUVZwQlFuQkJSamhCWTNkQ2JFRkhUVUZr?=
 =?utf-8?B?VVVKNVFVZFZRVmgzUW5kQlNFbEJZbmRDY1VGSFZVRlpkMEl3UVVoTlFWaDNR?=
 =?utf-8?B?akJCUjJ0QldsRkNlVUZFUlVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJV?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVU5CUVVGQlFVRkRaVUZCUVVGWlVVSnJRVWRyUVZoM1Fu?=
 =?utf-8?B?cEJSMVZCV1hkQ01VRklTVUZhVVVKbVFVaEJRV05uUW5aQlIyOUJXbEZDYWtG?=
 =?utf-8?B?SVVVRmpkMEptUVVoUlFXRlJRbXhCU0VsQlRXZEJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUWtGQlFVRkJRVUZCUVVGSlFVRkJRVUZCUVQwOUlpOCtQQzl0?=
 =?utf-8?B?WlhSaFBnPT0=?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DM8PR03MB6232:EE_
x-ms-office365-filtering-correlation-id: 3df047e6-0f9d-423b-543d-08dc9f1283e0
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?elFjNm5zenhpbGx1NlF3eWhZNVpoTVlXNXdIZE0xTENXZXJkYjJGVFBnVlEy?=
 =?utf-8?B?OEora0g5RHdNNUlkbzNWRThwN3N3MzdPK2lMcDNsanNmOVo2ZXNhN1NYNi9L?=
 =?utf-8?B?UU1NOUppZUN4alFLQTZnTkxpTXUwT0xwU3dUZ2hMaTNtN2l4UC9rQkxsWUx1?=
 =?utf-8?B?RG4rREZOMmJWbUxsTlV1bkJCOTRkUUpTS3FmMjZXbzA1UHFZM3FUT2c5RGl1?=
 =?utf-8?B?T04wanlYU0FKTEErUXJ4SmZzN3VoZHpGdkFoUkoyNTVkZHpXVGtIYW80QWtw?=
 =?utf-8?B?YXdQUGdaQTJOeWR3T0YvMjJwcVBKOVhPTTRGOTVzSjF3SVlTNFRmK3NEUHdQ?=
 =?utf-8?B?cDBzR2lsb3FhTm5GeW5WaXN0eitSRWUxdWg0Q2xYajR3emNvQXo3WGM0ekYy?=
 =?utf-8?B?WjVmTzhqUnd4elhvSGNDMFdFZHhrMjdvWEZCcm5mM3RXZTkxbzhKT2FDL0dC?=
 =?utf-8?B?ZWpuT20xUkQ3ZGROYjErazZNaDQ4OGpZcFB3SkhjQ2xkK0Q2M2lNNTZJdGYw?=
 =?utf-8?B?Vy9NTm5qd2RSbHo2YVF1SjZmREppSzI5MDI1WER2OTRtWVpRRWczZUFkSnk5?=
 =?utf-8?B?dmRWSEpoKzZidHh3RHpMVGRPdnRpOWhQUlU1b0t0TTJ5Y01ITEJhOHFHOWFC?=
 =?utf-8?B?UnNIZVBPZnpmU09xV0l1aXFpVStzMWU2ZTBtOHVDNFVCRTQ2czJxdDJzSlVk?=
 =?utf-8?B?cGVLVnd3K1BuM2pzb1k0VGFVa0kxSTFlZEcydXUrZ3hvb21YNVNqbGhPdFR5?=
 =?utf-8?B?aWpRdWlXNnRCdnFKdXhUV3BxSHNaZ3JDNFZXVXpoQ09OMTUvZFdBQy9YUXE2?=
 =?utf-8?B?cUwyWkNVRmFrTmg2L1cvclhvTVdTaWJkdU1ja3Y4d3RLOHhwdGxhajVmV2Rw?=
 =?utf-8?B?cEVFZTc0alZUcnhMQWJuUFI5WUlvTERLdTV5YU8xZHh5akNZMmY4SFh4OEtY?=
 =?utf-8?B?VkROc3FnNjlPSGYwYkcwcVZ6YjU3L0k3TjFMZlphS3B5Q2NoUEc0ZVUxODly?=
 =?utf-8?B?amx2RlhjWlEvR25VdnVhcjY5R0ZqR3o1WWdyaGFwVjZQSGpwQjNPZ3RpSThw?=
 =?utf-8?B?ZGJCR2xYRmlTOHZmdHRPQkMzRVZyL0RJYWo1UXpiSWlMbmU1U3ppaUl3dVNm?=
 =?utf-8?B?ZzB5V0tiSnJuMENqZzRjcndzbVcwOW5FMkdLZk1aT3BJRG5BR3pIRENPSHR3?=
 =?utf-8?B?Vk1XYmdPMTM0dTNnQk04TTVkMVR2dFByUGhqL3F6dmU5MERJWS9IY0lHR0lI?=
 =?utf-8?B?c1N0TDhTWkR0c05EcGxwc3FrMkZhOXhNOE95NlN2M1BralhXTng2MGtrUlZ3?=
 =?utf-8?B?ZmZaVG1rbjl5TVRCTzk5R3hVK0o3K1gvYVV0ZzlsU0l0Mmw3YkZEQitCby82?=
 =?utf-8?B?SDlNYTM4dHF4ZTNVVEJTV0J0MkhUZnVEYmxoclhVWmRITldVOTd2ZnM4MGRk?=
 =?utf-8?B?L3l2RlZLZ1NLVXRsczhieEE0b3NuUzNnRzYyd1NweCt6WWx4L1NQVGw5MkI3?=
 =?utf-8?B?ZHUrN3Y2YWY4YUZWSVlRRFk3Vi9QalAyMERDSnhDYi9jWTM1blBmWTNSM05C?=
 =?utf-8?B?TGE4aENrVWlpYnBPMFl2R2hjQTdMUFk2ZWQzQmY5M3hMMUM0WGpjTzlTck4x?=
 =?utf-8?B?ZjJUSkd6ckx0RVF6MTRWOUoxUmZkWlZZUFJ0UXRqWGlyU2paRDh1WDZHLzBJ?=
 =?utf-8?B?MnVCa2tKeFVsOEhlL0Zhd2tFbFM4Q0l1TlNxYWpwZWdWbjcxa203WXl0cXRK?=
 =?utf-8?B?a0RwbjRubXVMMlphMzdhRTBIZjI3YjNMN2FRbElGZHU1ejJ2dFVaNmZnYlZX?=
 =?utf-8?B?MFE1dWJCVldnQnBIdnZNMFFNejBZdzBJMW1sellVdCtYSVBZKzNlYW15QUVF?=
 =?utf-8?B?Z3U1d2szK01uRDlqT016NE93QzhUQ0xsRGlDQ29iaVB5cmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bWU0Vi9XRWdyTit1cE5TVWVoTTdQcnlXL0puL1FIaDVjemZLTnpTakdLTkVF?=
 =?utf-8?B?djFWNmJ6UkNiMEVVQjRIWktuMk5KNFd0SmFEdlQ1cmVBcTFZL3pCNkdLaHFW?=
 =?utf-8?B?bG00UFRKZEZCMWxUa0ZwYnJ0SDNocDJnaENCcXp6aFltZFh4U0lqUXhFaUlP?=
 =?utf-8?B?VXN2UEJIMVowOFp4bTFoTVk4aWhyZk45aCtDMk9FY1BiOHpqeWRaS1JDSWxh?=
 =?utf-8?B?OEUxR2pid0E0QW5DQXZ6cW9YWitoQys5RkswSnBMS2p6T1BaZjNqdy9RZU5O?=
 =?utf-8?B?Ny9kWGc4YW9lMXQvMEo1RGtNS3pBU0x6cE5JaWcwVmJpTDZrdUJDbXErSW9k?=
 =?utf-8?B?ZTg0SDB2bnRmL0lUYnNIZ1locWtXZEtxNEhIUE1DL00rd00zT1J3Y1ZpMmNn?=
 =?utf-8?B?eFR1OVhHNVY2MXVEN2hxTUIrWlZrc3JBTHBKam1UWjdCL0d2Tmpkc2kyK1RW?=
 =?utf-8?B?V0hNSjkwMGl0b0lERU9hNGE1d3VNVUpGVXZPUzU4OFJScDl3YjdGOWZ0dE9Y?=
 =?utf-8?B?RWdhUGxVNWpLUHN3WmNFL1N5bisrc0NLbTRIdnA1YzNTM2RWd0Y3dGxWSzdp?=
 =?utf-8?B?S3hFbk9KM0dmcCsyWUZUOEMzbmVHSnJIdmFXa3Q0Z3pDTG9zc2JKWVhhQmhq?=
 =?utf-8?B?NWhTMDBzM1dLYVJnOHE1UHFCb010Tk5jL2hUbVcwSlpLWVc2TEk2UUx1bEVS?=
 =?utf-8?B?NW1ISmM4YkllMHdiRDdZU2JUSGhCeVBleUIzT0NwMXR6Rkt1clgzM0pXRUE1?=
 =?utf-8?B?YWU0WTR0UEV2MGFqYTVpb2c4YlFSWEJDYmsrUVhkaURnUVppMmNjdFI3bVlJ?=
 =?utf-8?B?SGxRRS94d2JHK0JQWVhxYk44ay8yanA1SUpYVkloL1h1dmMrTkRsbUFTYzFM?=
 =?utf-8?B?Sjgvb1FPVVk0eWRCdnBKRTVraXJKamZpaDVSSUJSR3JpM1dROEMzdEx5Q2lY?=
 =?utf-8?B?WDltdFlIaUE4L2w2RHBQTGRhZmFVa2hYWU1JRWFCUFdoK3hHUk5xVlR6Szhq?=
 =?utf-8?B?T0IvK1M5TmJWNW5IdzBTKzd4REdHMGNZWVFJVUIyRGdiTkdCdi92NUhENUdi?=
 =?utf-8?B?UEVDSjNma2JMMFlNV014S0dMUmpJNzhRbERLZXFqUVZuVzRwOTVRZ0dqY2VW?=
 =?utf-8?B?NWZTZ0RGLzZQV2N5NlFuRVRYZStORnVUazAzZnA4UmU3bjI2ZGZ3c1pSWks2?=
 =?utf-8?B?WkdOMHZQZnljSERHczRhZ0dIRzVhWlpCQWdmRjRROHZhbU1QRkkwNmY5T1dE?=
 =?utf-8?B?NkJaK0ZsUi8rd0F3MkhNa3Z1RVVZV1YreGllV1dHbDNxc1ZRenIwVkRtNDlv?=
 =?utf-8?B?TGhNd2FZM3NyYVdsbHJqa21VT1R3WUtjRjRJbkgzdmgwcFNYdjF5MFlMM1N5?=
 =?utf-8?B?bWs5Yno4WWpMVXVNRlRwTU90S2YvSXlHQkJPMVAvMURBa2FtVktLZzcvOW90?=
 =?utf-8?B?aTJuN3c3NVJZbDdrRm9rRW5jMFBJWStuL0ExdTJSbUtRSUF4K3ZrQnhtdFhJ?=
 =?utf-8?B?TVFSRExLajJlL2hOQ09xa0MvNWR6NTZIK1dHa3BDWVk1VndtOFdZZE1uNlJn?=
 =?utf-8?B?a213SThXM3c3S01kZjFWVG5UcVhMVWorMThTV3c0U3M2dEZzamI0TGQ2MGpt?=
 =?utf-8?B?TXI0Q2FXR1FBR2FBcFNzbnBRSVhndHRUbzVZT3pRVWFyWG9Bd2xEK1AySnFw?=
 =?utf-8?B?NnNOeDRwVTBOSUovQURsWC82ZnVkK0tXWUt2U0lrZVY1dUthbDV1KzdtNVZk?=
 =?utf-8?B?T1NOc2lKd0ZJTWNJcU5IOWxtV1k1YXRqRzRuN25EdEJ0RHczVEV6b2RqUU1T?=
 =?utf-8?B?dnhQRUVwQy9QaGJzY2c4WFlTVEcwQUZWYkZtb3l4UFpZSG9nSmEwNi9ralND?=
 =?utf-8?B?YlRoTGdidGxmSE1rUStLc0dLY25TcUdTOWxSMU93Um90UHRtTlBPamhGcHlv?=
 =?utf-8?B?YkcwOHp3NXBNa2JaMTZnMlowbCs3ZXRjMHY3NmwrTzNXT3NlU294RXFrbG1a?=
 =?utf-8?B?SmxVeHJKZy8wM1BjT3E5bkwrczlJeE5ZcHJRcHEzemFuUjMzTUtqOFA4RTd0?=
 =?utf-8?B?Tk9ndzd5bE1DUGNYSXErRk5STUMxTHh3RGpzYzRBYmN6aHkwSmlEamE2dnZH?=
 =?utf-8?Q?pEhispMKNuoI3AkCSfiJjnP7R?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df047e6-0f9d-423b-543d-08dc9f1283e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 05:55:05.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oh4Ytpzvu+w/VToA+LJGkKavJBOs0tpptFY3S/i8eX2JbUs5stIBmGMf7ybnfIME+q2Ee+Z7+6hDi12J+lKhknNACFOTJY4zQkFBC26k7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR03MB6232
X-Proofpoint-GUID: XZhZNi70Uk-FdzCiPWDNDrxLxOGWbU-M
X-Proofpoint-ORIG-GUID: XZhZNi70Uk-FdzCiPWDNDrxLxOGWbU-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080043

Li4uDQo+ID4gPiArICBhZGksbWFudWFsLXNwYW4tb3BlcmF0aW9uLWNvbmZpZzoNCj4gPiA+ICsg
ICAgZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgVGhpcyBwcm9wZXJ0eSBtdXN0IG1pbWljIHRo
ZSBNU1BBTiBwaW4gY29uZmlndXJhdGlvbnMuIEJ5DQo+ID4gPiArIHR5aW5nIHRoZQ0KPiA+IE1T
UEFODQo+ID4gPiArICAgICAgcGlucyAoTVNQMiwgTVNQMSBhbmQgTVNQMCkgdG8gR05EIGFuZC9v
ciBWQ0MsIGFueSBvdXRwdXQNCj4gPiA+ICsgcmFuZ2UgY2FuDQo+ID4gYmUNCj4gPiA+ICsgICAg
ICBoYXJkd2FyZS1jb25maWd1cmVkIHdpdGggZGlmZmVyZW50IG1pZC1zY2FsZSBvciB6ZXJvLXNj
YWxlDQo+ID4gPiArIHJlc2V0DQo+ID4gb3B0aW9ucy4NCj4gPiA+ICsgICAgICBUaGUgaGFyZHdh
cmUgY29uZmlndXJhdGlvbiBpcyBsYXRjaGVkIGR1cmluZyBwb3dlciBvbiByZXNldCBmb3IgcHJv
cGVyDQo+ID4gPiArICAgICAgb3BlcmF0aW9uLg0KPiA+ID4gKyAgICAgICAgMCAtIE1QUzI9R05E
LCBNUFMxPUdORCwgTVNQMD1HTkQgKCstMTBWLCByZXNldCB0byAwVikNCj4gPiA+ICsgICAgICAg
IDEgLSBNUFMyPUdORCwgTVBTMT1HTkQsIE1TUDA9VkNDICgrLTVWLCByZXNldCB0byAwVikNCj4g
PiA+ICsgICAgICAgIDIgLSBNUFMyPUdORCwgTVBTMT1WQ0MsIE1TUDA9R05EICgrLTIuNVYsIHJl
c2V0IHRvIDBWKQ0KPiA+ID4gKyAgICAgICAgMyAtIE1QUzI9R05ELCBNUFMxPVZDQywgTVNQMD1W
Q0MgKDBWIHRvIDEwLCByZXNldCB0byAwVikNCj4gPiA+ICsgICAgICAgIDQgLSBNUFMyPVZDQywg
TVBTMT1HTkQsIE1TUDA9R05EICgwViB0byAxMFYsIHJlc2V0IHRvIDVWKQ0KPiA+ID4gKyAgICAg
ICAgNSAtIE1QUzI9VkNDLCBNUFMxPUdORCwgTVNQMD1WQ0MgKDBWIHRvIDVWLCByZXNldCB0byAw
VikNCj4gPiA+ICsgICAgICAgIDYgLSBNUFMyPVZDQywgTVBTMT1WQ0MsIE1TUDA9R05EICgwViB0
byA1ViwgcmVzZXQgdG8gMi41VikNCj4gPiA+ICsgICAgICAgIDcgLSBNUFMyPVZDQywgTVBTMT1W
Q0MsIE1TUDA9VkNDICgwViB0byA1ViwgcmVzZXQgdG8gMFYsDQo+ID4gPiArIGVuYWJsZXMNCj4g
PiBTb2Z0U3BhbikNCj4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5p
dGlvbnMvdWludDMyDQo+ID4gPiArICAgIGVudW06IFswLCAxLCAyLCAzLCA0LCA1LCA2LCA3XQ0K
PiA+ID4gKyAgICBkZWZhdWx0OiA3DQo+ID4gPiArDQo+ID4gPiArICBpby1jaGFubmVsczoNCj4g
PiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgQURDIGNoYW5uZWwgdG8gbW9uaXRv
ciB2b2x0YWdlcyBhbmQgdGVtcGVyYXR1cmUgYXQgdGhlIE1VWE9VVCBwaW4uDQo+ID4gPiArICAg
IG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArICAnI2FkZHJlc3MtY2VsbHMnOg0KPiA+ID4g
KyAgICBjb25zdDogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgJyNzaXplLWNlbGxzJzoNCj4gPiA+ICsg
ICAgY29uc3Q6IDANCj4gPiA+ICsNCj4gPiA+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4gPiA+ICsg
ICJeY2hhbm5lbEBbMC0zXSQiOg0KPiA+ID4gKyAgICAkcmVmOiBkYWMueWFtbA0KPiA+ID4gKyAg
ICB0eXBlOiBvYmplY3QNCj4gPiA+ICsgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+
ID4gPiArDQo+ID4gPiArICAgIHByb3BlcnRpZXM6DQo+ID4gPiArICAgICAgcmVnOg0KPiA+ID4g
KyAgICAgICAgZGVzY3JpcHRpb246IFRoZSBjaGFubmVsIG51bWJlciByZXByZXNlbnRpbmcgdGhl
IERBQyBvdXRwdXQNCj4gY2hhbm5lbC4NCj4gPiA+ICsgICAgICAgIG1heGltdW06IDMNCj4gPiA+
ICsNCj4gPiA+ICsgICAgICBhZGksdG9nZ2xlLW1vZGU6DQo+ID4gPiArICAgICAgICBkZXNjcmlw
dGlvbjoNCj4gPiA+ICsgICAgICAgICAgU2V0IHRoZSBjaGFubmVsIGFzIGEgdG9nZ2xlIGVuYWJs
ZWQgY2hhbm5lbC4gVG9nZ2xlIG9wZXJhdGlvbg0KPiBlbmFibGVzDQo+ID4gPiArICAgICAgICAg
IGZhc3Qgc3dpdGNoaW5nIG9mIGEgREFDIG91dHB1dCBiZXR3ZWVuIHR3byBkaWZmZXJlbnQgREFD
DQo+ID4gPiArIGNvZGVzDQo+ID4gd2l0aG91dA0KPiA+ID4gKyAgICAgICAgICBhbnkgU1BJIHRy
YW5zYWN0aW9uLg0KPiA+ID4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ID4gKw0KPiA+ID4g
KyAgICAgIG91dHB1dC1yYW5nZS1taWNyb3ZvbHQ6DQo+ID4NCj4gPiBDb3VsZCBiZSBoZWxwZnVs
IHRvIGFkZCBhIGRlc2NyaXB0aW9uIHRoYXQgc2F5cyB0aGlzIHByb3BlcnR5IGlzIG9ubHkNCj4g
PiBhbGxvd2VkIHdoZW4gU29mdFNwYW4gaXMgZW5hYmxlZCByYXRoZXIgdGhhbiByZXF1aXJpbmcg
cGVvcGxlIHRvDQo+ID4gcmVhc29uIHRocm91Z2ggdGhlIGxvZ2ljLg0KPiA+DQo+ID4gPiArICAg
ICAgICBvbmVPZjoNCj4gPiA+ICsgICAgICAgICAgLSBpdGVtczoNCj4gPiA+ICsgICAgICAgICAg
ICAgIC0gY29uc3Q6IDANCj4gPiA+ICsgICAgICAgICAgICAgIC0gZW51bTogWzUwMDAwMDAsIDEw
MDAwMDAwXQ0KPiA+ID4gKyAgICAgICAgICAtIGl0ZW1zOg0KPiA+ID4gKyAgICAgICAgICAgICAg
LSBjb25zdDogLTUwMDAwMDANCj4gPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IDUwMDAwMDAN
Cj4gPiA+ICsgICAgICAgICAgLSBpdGVtczoNCj4gPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6
IC0xMDAwMDAwMA0KPiA+ID4gKyAgICAgICAgICAgICAgLSBjb25zdDogMTAwMDAwMDANCj4gPiA+
ICsgICAgICAgICAgLSBpdGVtczoNCj4gPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IC0yNTAw
MDAwDQo+ID4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiAyNTAwMDAwDQo+ID4NCj4gPiAgICAg
ICAgICAgIGRlZmF1bHQ6IFswLCA1MDAwMDAwXQ0KPiANCj4gQWRkaW5nIGEgZGVmYXVsdCB2YWx1
ZSBkaXJlY3RseSB3aXRoaW4gdGhlIHNjaGVtYSBjYXVzZXMgdmFsaWRhdGlvbiBlcnJvci4NCj4g
R2l2ZW4gdGhpcywgaXMgaXQgYWNjZXB0YWJsZSBkb2N1bWVudGluZyB0aGUgaW50ZW5kZWQgZGVm
YXVsdCB2YWx1ZSB3aXRoaW4gdGhlDQo+IGRlc2NyaXB0aW9uPw0KDQpCZWZvcmUgc2VuZGluZyB0
aGUgcGF0Y2gsIEkgd291bGQgbGlrZSB0byBjb25maXJtIGlmIGl0IGlzIGFjY2VwdGFibGUgdG8g
anVzdA0KZG9jdW1lbnQgdGhlIGludGVuZGVkIGRlZmF1bHQgdmFsdWUgd2l0aGluIHRoZSBkZXNj
cmlwdGlvbiwgc2luY2UgYWRkaW5nIGEgZGVmYXVsdA0KdmFsdWUgZGlyZWN0bHkgdG8gdGhlIHNj
aGVtYSBjYXVzZXMgdmFsaWRhdGlvbiBlcnJvciBhbmQgY29uc2lkZXJpbmcgYWRkaW5nIHRoZSBs
b2dpYywNCg0KICAgICAtIGlmOg0KICAgICAgICAgbm90Og0KICAgICAgICAgICBwcm9wZXJ0aWVz
Og0KICAgICAgICAgICAgIGFkaSxtYW51YWwtc3Bhbi1vcGVyYXRpb24tY29uZmlnOg0KICAgICAg
ICAgICAgICAgY29uc3Q6IDcNCiAgICAgICAgIHRoZW46DQogICAgICAgICAgIHBhdHRlcm5Qcm9w
ZXJ0aWVzOg0KICAgICAgICAgICAgICJeY2hhbm5lbEBbMC0zXSQiOg0KICAgICAgICAgICAgICAg
cHJvcGVydGllczoNCiAgICAgICAgICAgICAgICAgb3V0cHV0LXJhbmdlLW1pY3Jvdm9sdDogZmFs
c2UNCg0KPiA+DQo+ID4gPiArDQo+ID4gPiArICAgIHJlcXVpcmVkOg0KPiA+ID4gKyAgICAgIC0g
cmVnDQo+ID4gPiArDQo+ID4gPiArICAgIGFsbE9mOg0KPiA+ID4gKyAgICAgIC0gaWY6DQo+ID4g
PiArICAgICAgICAgIHByb3BlcnRpZXM6DQo+ID4gPiArICAgICAgICAgICAgYWRpLG1hbnVhbC1z
cGFuLW9wZXJhdGlvbi1jb25maWc6DQo+ID4gPiArICAgICAgICAgICAgICBjb25zdDogNw0KPiA+
ID4gKyAgICAgICAgdGhlbjoNCj4gPiA+ICsgICAgICAgICAgcGF0dGVyblByb3BlcnRpZXM6DQo+
ID4gPiArICAgICAgICAgICAgIl5jaGFubmVsQFswLTNdJCI6DQo+ID4gPiArICAgICAgICAgICAg
ICByZXF1aXJlZDogW291dHB1dC1yYW5nZS1taWNyb3ZvbHRdDQo+ID4NCj4gPg0KPiA+IFRoaXMg
bG9naWMgZG9lc24ndCBsb29rIHJpZ2h0IHRvIG1lLiBJZg0KPiA+IGFkaSxtYW51YWwtc3Bhbi1v
cGVyYXRpb24tY29uZmlnIGlzIG5vdCA3LCB0aGVuIFNvZnRTcGFuIGlzIGRpc2FibGVkLCBzbyB3
ZQ0KPiBzaG91bGQgaGF2ZToNCj4gPg0KPiA+ICAgICBvdXRwdXQtcmFuZ2UtbWljcm92b2x0OiBm
YWxzZQ0KPiA+DQo+ID4gSW4gdGhhdCBjYXNlIHNpbmNlIGluZGl2aWR1YWwgY2hhbm5lbHMgY2Fu
J3QgaGF2ZSBhIHBlci1jaGFubmVsDQo+ID4gY29uZmlndXJhdGlvbiBiZWNhdXNlIFNvZnRTcGFu
IGlzIG5vdCBlbmFibGVkICh1bmxlc3MgSSBhbQ0KPiA+IG1pc3VuZGVyc3RhbmRpbmcgdGhlIGRh
dGFzaGVldD8pLg0KPiA+DQo+ID4gQWxzbywgb3V0cHV0LXJhbmdlLW1pY3Jvdm9sdCBzaG91bGQg
bmV2ZXIgYmUgcmVxdWlyZWQsIGV2ZW4gd2hlbg0KPiA+IGFkaSxtYW51YWwtc3Bhbi1vcGVyYXRp
b24tY29uZmlnIGlzIDcgYmVjYXVzZSB0aGVyZSBpcyBhbHJlYWR5IGENCj4gPiBkZWZhdWx0IHZh
bHVlIHJhbmdlICgwViB0byA1Vikgc3BlY2lmaWVkIGJ5IHRoZQ0KPiA+IGFkaSxtYW51YWwtc3Bh
bi1vcGVyYXRpb24tY29uZmlnIHByb3BlcnR5Lg0KPiA+DQo+ID4gSSB0aGluayB0aGUgY29ycmVj
dCBsb2dpYyB3b3VsZCBiZToNCj4gPg0KPiA+ICAgICAtIGlmOg0KPiA+ICAgICAgICAgbm90Og0K
PiA+ICAgICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgIGFkaSxtYW51YWwtc3Bh
bi1vcGVyYXRpb24tY29uZmlnOg0KPiA+ICAgICAgICAgICAgICAgY29uc3Q6IDcNCj4gPiAgICAg
ICAgIHRoZW46DQo+ID4gICAgICAgICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAg
ICAgICJeY2hhbm5lbEBbMC0zXSQiOg0KPiA+ICAgICAgICAgICAgICAgcHJvcGVydGllczoNCj4g
PiAgICAgICAgICAgICAgICAgb3V0cHV0LXJhbmdlLW1pY3Jvdm9sdDogZmFsc2UNCg0K

