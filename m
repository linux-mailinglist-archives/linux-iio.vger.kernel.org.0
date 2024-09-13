Return-Path: <linux-iio+bounces-9516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041097824A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8261C21032
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7341DB543;
	Fri, 13 Sep 2024 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gpRSL2tM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314221C2DD4;
	Fri, 13 Sep 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236462; cv=fail; b=KEfugoWWPplecYkI2FL73kmmzG04BGKcJKCKMXFz7kC1/2Yc+uABxGvm3q8K7DnkEQ1tonl522OOA8miZf4VoBTa/VYzt2xpMMgxrJ1Xs4oxGb5/7lkT/txvslEWu56yEjypn/jfBDiyh1rkMhXdw//P4E8qBGj6mLBQ/VAOnv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236462; c=relaxed/simple;
	bh=2qwc2FzyEZd/u65zUYNpvAjOkvQzVGvEUkz0wWKXXco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCPuDt+qLRN7sOYYFudZ6l2L1qhYuEhZQxkMPAQZU0JIUUz3Q+/ZhVXa/biN1hfYyOCsUYI6qUB65sUhn/MJOGCOx+VQfWZqwABcLjx6c+1O/WMpBQ1QltO+o2X8lY49d+WcqyX+XzG9ymGVQ3SpYkm9yzVMeHL1Hf3O9TlVWUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gpRSL2tM; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DCWdTM020326;
	Fri, 13 Sep 2024 10:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2qwc2
	FzyEZd/u65zUYNpvAjOkvQzVGvEUkz0wWKXXco=; b=gpRSL2tMnfKYp8aBMNqFf
	4I1vxXNHfYlontibpGo09SsGWnqcWjFbRf0fuHH4RBdrRp9Hl2dw2d0OIPXD2QQY
	1Hn1LGA4Lw7Qc1PjtPbf+ZqMtw8uW21TkSgdmQv5EbTyii1EysytQF53lmSWinAC
	VDDc6pQVsUfcDXCOZw5pZSqmIADlMWx2Ea83jJE8gsY5bddd54lVyzVq+WLZ8lli
	2hPC1qjnrTp0PAfWT4N/YKVdCw4eVJMGWNyeI7IwgNwhMwXtDkPAySNi/YbcHsTz
	7th75wdLWjQD1eoSjoubtAJoIm86MnjV7Gv562Z1MfkV7L1byOBg9TLbJaRnxFNW
	Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41jkfr73pa-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 10:07:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2FQQGpFDfylLT+duPrABS0FhEW7l/364YeG79K9InANzzfTW6kygRoIA7dpLTvg/XjKZ3idSOYgixme18pD/OOVc/oiRUc8ryDyal2ycCYzOZbzWSofhGxqgeWLIxZekyK0LWBsqX/rvD5SwdEnxyUD7fd3uvrhF1nUfOdbrXyiVt6dauijWsVIAwor29L91RWiysOcVbsTtcNu648D+86nc8l/JpCY6bqiYm1DzRPkD/U1LSVnVHSovHbXheYhc1c9RyoQPllFwYbCQ4EfxMOlE+ttfup9El/KiBDM35UrBoDj9XHzpvT+afKeyr8gV2qP+wOw44+srpdL3r4fHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qwc2FzyEZd/u65zUYNpvAjOkvQzVGvEUkz0wWKXXco=;
 b=Snll2DIhLj2lrZst2faB7TmqSwW0jfhXmVXNtbnw64OrcQLp1VssncyW57AE2PKDiEATpRW4v1z9H1ps0/sCqpaaI1ubxjo7MANKPwZnlGjbmZcq1U+UkVWfLMGV5aKlgzReBtYTOQe6NTuRRo9fJkLA8Cm2QTXwWUZ6FGN1DiTHcsKvlgOe/J6I2ghTcPdAFDgBJg8hKXiZvtpTGSDE/rd1Ft4pjEi6ppihz9Ao+L25RmMlbLQB6VYHUbzfJOC2K1SdUkEY6GIvsd+uC05SNNGyRw2iZzRLcoLGCDoolKV1LIhbsNEySfU/pU00fkP4EEDZ18W1dOdFBLHTwHyWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by SJ0PR03MB5487.namprd03.prod.outlook.com (2603:10b6:a03:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Fri, 13 Sep
 2024 14:06:48 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%6]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 14:06:48 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Mike Looijmans
	<mike.looijmans@topic.nl>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Thread-Topic: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Thread-Index: AQHbBRalVBsNDWcZbkipJdTYWUDYULJUOz2AgAGEqFA=
Date: Fri, 13 Sep 2024 14:06:48 +0000
Message-ID:
 <SN6PR03MB4320EC2760F85BB6B0DDEED4F3652@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
 <20240912121609.13438-3-ramona.nechita@analog.com>
 <CAHp75VdOjodDaz6J4sWOiT2HHmdXpOPcWeS5kz4e3rB_=gh3xw@mail.gmail.com>
In-Reply-To:
 <CAHp75VdOjodDaz6J4sWOiT2HHmdXpOPcWeS5kz4e3rB_=gh3xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYSEp1WldOb2FYUmhYR0Z3Y0dSaGRHRmNjbTloYldsdVox?=
 =?utf-8?B?d3dPV1E0TkRsaU5pMHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dV?=
 =?utf-8?B?ek5XSmNiWE5uYzF4dGMyY3ROamRsTmpVeE9HWXROekZrT1MweE1XVm1MV0pp?=
 =?utf-8?B?TkRRdE0yTmxPV1kzTkRjMVlqaGxYR0Z0WlMxMFpYTjBYRFkzWlRZMU1Ua3hM?=
 =?utf-8?B?VGN4WkRrdE1URmxaaTFpWWpRMExUTmpaVGxtTnpRM05XSTRaV0p2WkhrdWRI?=
 =?utf-8?B?aDBJaUJ6ZWowaU5EZzJPQ0lnZEQwaU1UTXpOekEzTVRBd01EVXlNamMyTWpZ?=
 =?utf-8?B?MklpQm9QU0pwTXpoTmNHaFZaWFo0YTFKbU0zUldkVkk1U2xkc09YZG5kMVU5?=
 =?utf-8?B?SWlCcFpEMGlJaUJpYkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNT?=
 =?utf-8?B?RlV4VWxOU1ZVWk9RMmRWUVVGRVowUkJRVUZ4VWtwQmNUVm5XR0pCV2paalls?=
 =?utf-8?B?QkVlRFZHYlRGdWNIaHpPRkJJYTFkaVZVUkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlNFRkJRVUZFWVVGUlFVRlRaMGxCUVU4MFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUlVGQlVVRkNRVUZCUVROTWFGTm1aMEZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVbzBRVUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFX?=
 =?utf-8?B?Tm5RbXhCUmpoQlkwRkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21k?=
 =?utf-8?B?Q2FFRkhkMEZqZDBKc1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpz?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVdkQlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RD?=
 =?utf-8?B?YkVGSFRVRmtVVUo1UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdR?=
 =?utf-8?B?VWhOUVZoM1FqQkJSMnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlVVRkJRVUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFV?=
 =?utf-8?B?ZHJRVmgzUW5wQlIxVkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5?=
 =?utf-8?B?QldsRkNha0ZJVVVGamQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJUelJC?=
 =?utf-8?B?UVVGQlFVRkJRVUZEUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUVVGQlowRkJR?=
 =?utf-8?B?VUZCUVVGQlFYcG5RVUZCUVUxQlFVRkNUMEZCUVVGQlFVRkJRVWRGUVZwQlFu?=
 =?utf-8?Q?BBRjhB?=
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|SJ0PR03MB5487:EE_
x-ms-office365-filtering-correlation-id: 75062aaf-2e5c-4215-8b55-08dcd3fd4ef6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHF4NU5hTUtRV2w2MDhoQXBERXFMb1c4dDVyUU9UQjF2UzFPU2k3eGMvdFI4?=
 =?utf-8?B?UC81K0xwK0w3bDQwbEMzbjVHMi93cmw3SHg4UEQzQTVxellJcXpubkJYYXhH?=
 =?utf-8?B?V1pEa013eEpuUDF1TnMxS0hPUTBSNGRTbUMxUU5TbUNNdlFxdlNlZUtNbVZP?=
 =?utf-8?B?Q1l2QzdFVG1QNVlTZzI2QkJpZWZtRGhLRy9HTVJhL0hNeWhMNE4zMDArY3Zh?=
 =?utf-8?B?Tk5YTU0zVWI0aHFDeWlSc2c4aXphSklNcVI0enI2Y0RDVUdJYVI4UlliOGNy?=
 =?utf-8?B?RzQyQzc0c2Fnb1FSUmV6OFhKbjB1QXNOQ29TK0lmcFVDK05TUWc2aUZuMzFw?=
 =?utf-8?B?MW9YMFgzZlAyaDJkWlJlTS9LRUNMMng1OHpXZ2M5TEprQnU5Yk9ud2pVMENh?=
 =?utf-8?B?NFBlblUwS1M0RWx3am9naU9VeGpIbVZ4KzZhSjJSbUpodDJHTWdPcTZvcWF2?=
 =?utf-8?B?bDlMT3NjSjVtOVlTeUw2b3MzN1d6WUpxNldXVDdTVHpxNW1QNGs1U1lNUjFy?=
 =?utf-8?B?OHIweituWXlvUG9VRDRjbExxMmpWbkVROVZRYVZVdkdyUVhyazcwclNHZTkw?=
 =?utf-8?B?UUVwY1JYT2dad2l1bGwzNisrUUZZZGxwWnhXL0ZrZWJPNUZJS0xlN3doVWNU?=
 =?utf-8?B?bmtZYzE2Vng3cmRnWmYvUVF3NHZBaHdIb2pUUmxBRkRvQ1llbDZNOUxFZUZZ?=
 =?utf-8?B?K25ZeFZPSWJUeGNhT0xaQ1IxYmxxcms0dU84NE0ydTFpOVZGczVxL1E1RHpM?=
 =?utf-8?B?TnZCbWtrQkZlQlpieTMrcEs1SUpBUFpYSjlJcUl3TElWVG9BcEorenYyUG14?=
 =?utf-8?B?cG5XdnRkVVdRQ0NJQWRhTHVYNm5DU0RKK0wrS1Z4ZmI0Y0NobGNvTHg0LzJP?=
 =?utf-8?B?NHBreVFXcXdUNmk4NFpVRWpmV2ZwR3ZpZnJMaXJ2RW84WnlDZzdjM0VIcUhP?=
 =?utf-8?B?dGlXZXlDOUYrbm1nREcza1IwVVNOQXpzR2FKcTk2MDJLTVZaVERVbyt2R1Fq?=
 =?utf-8?B?UVA2cGpGUVd0bHhtM2RwaDFaeUlHanZsbGJJNjFRWFozYisxd1l5UVFSOVVs?=
 =?utf-8?B?VTJ5em5QdmZFOWxuWDg5K1g4TU9TUDZGbTRnbGJ5d2U0cEdUcGdaR2hEanJJ?=
 =?utf-8?B?Q1BLTVBvZFNMVWh4eGo1Z3d5dHhneW56Zktad05BaitzTThhS21sK1RwWWRa?=
 =?utf-8?B?dFRwL3JyaThIZVhTWVljM2VPMm8vZjNFaUE3RVE3SDRmTGoveFoycWFxM0xW?=
 =?utf-8?B?TUdMRldmQklNOVkrMlhSb0hSUjB3UE5xemlmYVptbjJtNENBMUFKYmhCOXE0?=
 =?utf-8?B?VFF5Z2U4VnhhTHg3SDFUOGlMeStLYUx0ZVJydmJhaFpVZXg1M2dyQm9HVWZn?=
 =?utf-8?B?Wk5JTy9oai9wY3JDZFRFZU8rekVxa3IybTFMY1dyRVRZcUxFNnNRcHJDOUU2?=
 =?utf-8?B?K0QxVWtFWFk3UWJ1UStOd3ZpTnN0bWFPVmVTaXJuSGtFcEpJaU1YTCtYaFE4?=
 =?utf-8?B?UkZ6cWl0VzA1RkNRb0ovellScHI4aElNTG9qS0JZNjBMeGNkcGdlcHA2SS9J?=
 =?utf-8?B?YS9iMzZPbDFXeWJwekRtWWxKRC96ZXJzZEdSNlk4TzF4dFBIbHJBN1NQZzhU?=
 =?utf-8?B?NGowdVcyS0VRUWswb010ZzdmWDhDcHJoSlNuTml5dE94KzkyV3NjcEZkdUtU?=
 =?utf-8?B?bkR0WEdINFZmUTROQTRHY2JveTVTYnB6TEJUODV3MS8xNlZJa0pUUjQyc09l?=
 =?utf-8?B?STRWRW02dTZ4OVJEVzd5ZXd3RU1jSGlxVjd2alpzWDA4Z2t1d0hkcEJEbjJY?=
 =?utf-8?B?MTZQOTAyeHpWWXR6V3VrRWJMcGlFbG85ZVVGbnlkT3pxejRiZXpRUWJlSE5W?=
 =?utf-8?B?eCtOd3NDcVVKZ0kra1V0MGZEUUpDdmJQVENtYUpDRThvTGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0FMVHQxdWFCSHBNWnJLci93WGIwdElSeHV2QW50ME9QNWRaTFRXMXRuSnVu?=
 =?utf-8?B?cnF6RmRFWG9WTW94aDlvOEZadTBUdC9tajA4NXRwRGZCZnJrb1c4WjZ4aVhS?=
 =?utf-8?B?bmtsaThoaG93ZDNTVUV4WkZNejdLUDdqUGZGZ1k2YkJnTVIwaWVsRmw3ZlRO?=
 =?utf-8?B?OGtpclNjbnMrNzhXdG9TWmpTQ3NiRFczakgzQzZOaTM5T2JEdWw4akRBeGwv?=
 =?utf-8?B?Tmwwd0Y4VzdKQnU4WkRqQzJjcGVXSUNWdGtoWTA1K1pjb0pBRDJkZ3BNZ3Z5?=
 =?utf-8?B?dXQ1OFVwT0VaT2JCS1FjZmF0aUo5SDNYa3I4MXdqYjM3K1lVYVBkMDg3VHM5?=
 =?utf-8?B?bmNZbDhqTUdWSFlGVTUwaU9YTU5Wak4wYlBhamhQb0s5bXJucUhvRWloajdX?=
 =?utf-8?B?VmkrRmxJRmxmeEltYnl3R1JhY2ZFdGZvUjArWnhXUzRHT3gzelZmQVNaU2pW?=
 =?utf-8?B?YTFaRTZINTNoQkZ4WGJ3dDM4MFI4L3QwNHhKc2ZweUdHbzVQSTRSbTBLbEZI?=
 =?utf-8?B?L01nVmdZMEZYTFZPdk5YMlI4UVd1TnZPWnkwOXdXSTVGVGFKQW1qdFN2T2hw?=
 =?utf-8?B?YWdSSWkwcWt4anB5bk5ETzJVcXBHdS9FOTVSSWRqU0JmQ1RQTlZYREYrZ0FJ?=
 =?utf-8?B?cGNCcituVHVNRUtLMGJsSTJmWHlqZTRMeWVkYmFvdVFaTG45bFlBMUF1QTNm?=
 =?utf-8?B?aC9VZkk5Tm5nUUJQRXd6anQxaW15YkFuc0FaQzF5ci9MMWdOam9ZQVdSSnR2?=
 =?utf-8?B?M0F5MG5aVHk5UFVERnJJbUZxd1BzWnh5dHpVYU1YZXpKK2dPanZuZmtXRkJW?=
 =?utf-8?B?RmQvT0Zlc0E2YTh0OGx0SHNHL0ZBVy8rNm12RlFmdGFqdGVsWlQ2eHV0WStz?=
 =?utf-8?B?NG42NWJGUzMycTBvZ3BvWDVpbjRzaFhpdU5WY2ZkYmVZbzJjREZwenpYVTla?=
 =?utf-8?B?UmhRTGVMWnRYejNGOG5jNmRrMDJWMUErRDJpVXd1WHl4NHIzMnFkZHZUeTNj?=
 =?utf-8?B?U3FnK0oyRk1tcXYybm5JWmppNGYyWS82L2VoSUJsVmRuUGFCc3hoMlR4SitK?=
 =?utf-8?B?eW52cGo2Tno5TmxiMjJFYUdXRm50Rzc5elNQbWxZcXdlQTFYRGJ6WE91WWVt?=
 =?utf-8?B?bjBtYnlhYk9NYzVybnQwQWNSdTBsenRyYk5aK3AxZEI0NGJqbjFoWm03UzJ4?=
 =?utf-8?B?YndmNUs3L3ZIQzZBUlRiRG00dFkrTE1QM2kvbnMrdXZQV3VXc25MU2VJYnUw?=
 =?utf-8?B?WjF3MTlTZEhQUDNnU2hSVEh0NnhIU21IODBkMDBCR3Y3ZDJaVlhnNkc5NzFx?=
 =?utf-8?B?ZDZGbXZzZlpCODVEQmF1L2lzNWhTN2pWQ3A0TzFvMDFIZ3pNSXZVUXFmU0s4?=
 =?utf-8?B?WjVjQlozZTJzU3kxRzJBNWpHUlI5ZW9lTG1wZnFwZWkxMy9PSkdMZVdoSFRE?=
 =?utf-8?B?NXVXK2pjVVNmNmJTdkcrQTNvaWhnc2VJV2pDZVhBZVdmMUVrZXltazRYN3lD?=
 =?utf-8?B?UnFjOWU1Y1YwMDdEWGYwMXBkd1hOTUlMV0JHTU9ML2YydTF6UW5OTXY5UDU5?=
 =?utf-8?B?NU5VMkM4QWgrbjNUY0MxUHVLeGRhRGhDZWdSak9XVEZkZG1VdFAyWlY0Njdr?=
 =?utf-8?B?bkExT295VURuSkF4R2xHRkE0T1NjTGdYTkUyVHdiY3c5TFZ1K3lBaVhrTjlt?=
 =?utf-8?B?VW15ZnBZTG9HWUVXOGpXSnhtV01tbm9pSEZ1ajBkWHFXdjA1ZmxwV0p6eEpi?=
 =?utf-8?B?R2pkN1FSYjZzZk9MOVVxS1psUVBBWGhrWGttQTY3cUIvaEZpTVlyY05UelNF?=
 =?utf-8?B?MXJvaGo3bmk5bVRFY0loN2toNS9mNENScFM5WXpCVHlhTStka3Z6S1cwVnUv?=
 =?utf-8?B?VVVjVE1kYm9KNGgzV3k1OFEyTW5oM29qeDhsUENybThZL0xLYzNYMlExb3pT?=
 =?utf-8?B?ZjUrY2FEbUFXMXRXcjA3N0d0Si9sVnIrMEU2K3VkcEdkcDlmMkg2U0pORDZx?=
 =?utf-8?B?eGNjTTZLUFlscUx5S05xZDRXTFIzd2VqS3EwREJuSGEvR0JiVkJjc3ZkcTMy?=
 =?utf-8?B?N1pFZXIwZUFreFBBQkJrbi9jb2lPOVFMK09Gek1DckZkZUozQnFiN3FuQ1VD?=
 =?utf-8?Q?Fy8RRym0wnpe5XvN9c4HGFh8O?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75062aaf-2e5c-4215-8b55-08dcd3fd4ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 14:06:48.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CL2JhZqtLET7MwRvyomg0N+7GIWbVP8yl0SRmPq1u7SNyA9MyZ2XqTAR5FmtagLMDZPLe7tnMqN052LkG3YblU3+huM35OYk5j8SwRm95C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5487
X-Proofpoint-ORIG-GUID: ZFbXpEoWfKrqlA6sNp-ZV__MnwBDf0bH
X-Proofpoint-GUID: ZFbXpEoWfKrqlA6sNp-ZV__MnwBDf0bH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130098

Pj4NCj4+IFRoZSBmaWx0ZXIgbW9kZSAvIGZpbHRlciB0eXBlIHByb3BlcnR5IGlzIHVzZWQgZm9y
IGFkNDEzMCBhbmQgYWQ3Nzc5IA0KPj4gZHJpdmVycywgdGhlcmVmb3JlIHRoZSBBQkkgZG9jIGZp
bGUgZm9yIGFkNDEzMCB3YXMgcmVtb3ZlZCwgbWVyZ2luZyANCj4+IGJvdGggb2YgdGhlbSBpbiB0
aGUgc3lzZnMtYnVzLWlpby4NCj4NCj4uLi4NCj4NCj4+ICtXaGF0OiAgICAgICAgICAvc3lzL2J1
cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlWC9maWx0ZXJfdHlwZV9hdmFpbGFibGUNCj4+ICtXaGF0
OiAgICAgICAgICAvc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlWC9pbl92b2x0YWdlLXZv
bHRhZ2VfZmlsdGVyX21vZGVfYXZhaWxhYmxlDQo+PiArS2VybmVsVmVyc2lvbjogNi4xDQo+DQo+
SSBiZWxpZXZlIEkgaGF2ZSBhbHJlYWR5IGNvbW1lbnRlZCBvbiB0aGlzLiBUaGUgY29tbWl0IG1l
c3NhZ2Uga2VlcHMgc2lsZW50IGFib3V0IHZlcnNpb24gY2hhbmdlcy4gV2h5Pw0KDQpJIG1lbnRp
b25lZCBpdCBpbiB0aGUgY292ZXItbGV0dGVyLCBzaW5jZSB0aGUgYXR0cmlidXRlcyBvZiB0d28g
ZGV2aWNlcyB3ZXJlIG1lcmdlZCwgYW5kIG9uZSBvZiB0aGVtIHdhcyBhdmFpbGFibGUgaW4gNi4x
IGFkIHRoZSBvdGhlciBpbiA2LjIsIGl0IGZlbHQgYXBwcm9wcmlhdGUgdG8gbGVhdmUgaXQgYXMg
Ni4xLg0KSSB3YXMgd29uZGVyaW5nIGlmIHRoaXMgaXMgb2sgb3IgaWYgaXQgc2hvdWxkIGJlIGtl
cHQgYXMgNi4yLiBTaG91bGQgdGhpcyBiZSBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
IGFzIHdlbGw/DQoNCj4NCj4+ICtDb250YWN0OiAgICAgICBsaW51eC1paW9Admdlci5rZXJuZWwu
b3JnDQo+PiArRGVzY3JpcHRpb246DQo+PiArICAgICAgICAgICAgICAgUmVhZGluZyByZXR1cm5z
IGEgbGlzdCB3aXRoIHRoZSBwb3NzaWJsZSBmaWx0ZXIgbW9kZXMuIE9wdGlvbnMNCj4+ICsgICAg
ICAgICAgICAgICBmb3IgdGhlIGF0dHJpYnV0ZToNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICogInNpbmMzIiAgICAgICAtIFRoZSBkaWdpdGFsIHNpbmMzIGZpbHRlci4gTW9kZXJhdGUgMXN0
IGNvbnZlcnNpb24gdGltZS4NCj4+ICsgICAgICAgICAgICAgICAgICAgR29vZCBub2lzZSBwZXJm
b3JtYW5jZS4NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICogInNpbmM0IiAgICAgICAtIFNp
bmMgNC4gRXhjZWxsZW50IG5vaXNlIHBlcmZvcm1hbmNlLiBMb25nDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAxc3QgY29udmVyc2lvbiB0aW1lLg0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgKiAic2luYzUiICAgICAgIC0gVGhlIGRpZ2l0YWwgc2luYzUgZmlsdGVyLiBFeGNlbGxlbnQg
bm9pc2UgcGVyZm9ybWFuY2UNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICogInNpbmM0K3Np
bmMxIiAtIFNpbmM0ICsgYXZlcmFnaW5nIGJ5IDguIExvdyAxc3QgY29udmVyc2lvbg0KPj4gKyAg
ICAgICAgICAgICAgICAgICB0aW1lLg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgKiAic2lu
YzMrcmVqNjAiIC0gU2luYzMgKyA2MEh6IHJlamVjdGlvbi4NCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICogInNpbmMzK3NpbmMxIiAtIFNpbmMzICsgYXZlcmFnaW5nIGJ5IDguIExvdyAxc3Qg
Y29udmVyc2lvbg0KPj4gKyAgICAgICAgICAgICAgICAgICB0aW1lLg0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgKiAic2luYzMrcGYxIiAgIC0gU2luYzMgKyBkZXZpY2Ugc3BlY2lmaWMgUG9z
dCBGaWx0ZXIgMS4NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICogInNpbmMzK3BmMiIgICAt
IFNpbmMzICsgZGV2aWNlIHNwZWNpZmljIFBvc3QgRmlsdGVyIDIuDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAqICJzaW5jMytwZjMiICAgLSBTaW5jMyArIGRldmljZSBzcGVjaWZpYyBQb3N0
IEZpbHRlciAzLg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgKiAic2luYzMrcGY0IiAgIC0g
U2luYzMgKyBkZXZpY2Ugc3BlY2lmaWMgUG9zdCBGaWx0ZXIgNC4NCj4NCj5BbHNvLCB0aGUgb3Jp
Z2luYWwgZmlsZSB3YXMgbW9yZSB2ZXJib3NlIGZvciB0aGUgY29tcGxleCBjYXNlcywgbGlrZSAi
c2luYzMrcGZYIiwgd2h5IGhhcyB0aGlzIGJlZW4gY2hhbmdlZD8NCg0KU2luY2UgdGhpcyBpcyBh
IG1vcmUgZ2VuZXJpYyBmaWxlIEkgd2FzIGFkdmlzZWQgdG8gbGVhdmUgb3V0IHNwZWNpZmljIGRl
dGFpbHMsIHNob3VsZCBJIGluY2x1ZGUgdGhlbSBqdXN0IGFzIHRoZXkgd2VyZSBpbiB0aGUgb3Jp
Z2luYWwgZmlsZT8NCg0KDQotLQ0KQmVzdCBSZWdhcmRzLA0KUmFtb25hDQo=

