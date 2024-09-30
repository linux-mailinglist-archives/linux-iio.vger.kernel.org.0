Return-Path: <linux-iio+bounces-9905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F99989A25
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 07:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F94C280D89
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F17DA6D;
	Mon, 30 Sep 2024 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pDCIqVxY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C326AD9;
	Mon, 30 Sep 2024 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674340; cv=fail; b=HTOdVyu7VA1Rnyq492LlOwNCJuWA1h5rT2+joFTlDTnyqUarXutcuGZHehDBedGw9CLpR8fwTN+pDjFOURWcz5l8kUC9f2P7ZiyWrKHlLncVA+dp/n4e6hZsnAw3adWmFE98L9QM3uPh8ph4lFdoqVkds7EMOz9Qf+/UThkuOTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674340; c=relaxed/simple;
	bh=wbEV1pbYtuG2h0Cw+W5WOFR//A4ZD25AeyoCbg9jWPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3EA3XGKyrEbaZoW3u6/iwb6F1cEjRMneUbJLJ2QTm1oLevkSnnCg7JorqX/ewKSiw2+MTcorbHtL7ZDYq7lyA5Yc5GhNAyMEc6pzo48NL5NYb0oF9ukgOEqz/1DmdU/ihZv8YBWPagP9eFlE1li4d1pJuRR7JAkbAR5f+d0LmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pDCIqVxY; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48TNkuep007726;
	Mon, 30 Sep 2024 00:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wbEV1
	pbYtuG2h0Cw+W5WOFR//A4ZD25AeyoCbg9jWPQ=; b=pDCIqVxY5nP6mEgK7+SmP
	dmKTfA4AZZ/oWbZNRTgtoSoUGmDSgHVhQEDonkZIdD1ozGQfCj2JTuH4h3isLfe+
	r0C0n9T6pRHRdP3MsuFp6s0UZ5W+jvTwgV85gb4pMd15R++PSlFcF4+VcQdO8Uo/
	12SAVn17G1oJCMGb8oICZFiqFriZ5oK7jNcHYCnAu185a3UtXucTOJ6lYXww09SC
	RczzIruIHdCcOendBbdTnnXSK97SCwzTrE2eQ0xK+MFDXxQC2ruRJt47dqp+CsWa
	HsBi153Qnlt6/bFtRV6S1yP7JUNi+Y3t2SEElcbsoY+9xjHeFyHMweIWQBhJthGo
	w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41y3uftjh6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 00:28:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbZGUCu7FW+CWkScgMqcImBtrdPyna1OXzo80uuFpi9bDZFayfOqejb6rtRrUMxWTFuLuZz/Xu4coJJBn8x0r1oBt7iSxfJsn8B0Bpz5Njp+7s8TAcVyvNGZiuM7ru6VrzPMYd9WbA5NKW1dRf6gqjfohjcO4QntDNpc1JIHDcG2igno6ousAci2M5NFhOeV5P6uX3Xx9hnkuRGRjC8iY3OdfAgekKyrxQG7yE8stiOpdbpSWWjJrEGkmlXssqiokGfFrLPYdPoNEVLtj+xhcsCkawxz4wK9K7pnX879mej8kdYe0A17A1DPNOqby6ctCef3/hw2Tw9Nhe0NqVLuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbEV1pbYtuG2h0Cw+W5WOFR//A4ZD25AeyoCbg9jWPQ=;
 b=jpNwZ76YDKwMj74IwlX7Mi+OdqbZ9f3AIzoL2D5T2nXmpctO4Hmrrxxai4/jPzcwE06Ko4f0tf5xvwA+x5JFuH/tcQnEtNdYWWLAhMD0EnnqHqHQR8/ue1SQr7tLGk0fvjWmGw+BSASObubddI22m4A3pUV420HM1ub54ZuoND5W4P6G7X6hQc3tDfPUegFsBNvR/EerNPeBX6dZpg5q6NDpC4eTyeESYcJD12N7rf9Qwbt6+ydSx46ttYz/4u1sxQbm7EW4xdMpnLd12WYydcdzUX8rOSq0tECBAKbblPb0UVX8VnaiDqGcKRpnoglV1Vwy8gJnONnNJ390rJE6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by CH7PR03MB7929.namprd03.prod.outlook.com (2603:10b6:610:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 04:28:10 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 04:28:09 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Topic: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Index: AQHbBtL64dQMY8uE30mRU9akCX0yb7JtVTcAgAJ42fA=
Date: Mon, 30 Sep 2024 04:28:09 +0000
Message-ID:
 <SJ0PR03MB6224756A0B570A8CCAEF021091762@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
	<20240912095435.18639-3-Mariel.Tinaco@analog.com>
	<8f869b3b-df3f-49a9-9b6e-640697aa91dd@wanadoo.fr>
 <20240928151930.0c22e5e9@jic23-huawei>
In-Reply-To: <20240928151930.0c22e5e9@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MDJNamswTVdVME5pMDNaV1UwTFRFeFpXWXRPR016?=
 =?utf-8?B?T1MwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNOakk1TkRGbE5EZ3RO?=
 =?utf-8?B?MlZsTkMweE1XVm1MVGhqTXprdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJM05EZzRJaUIwUFNJeE16TTNNakUwTkRBNE5qQTJOekUyTlRr?=
 =?utf-8?B?aUlHZzlJblZUYjFkYVJXODRUV3BUYVN0U1RrbGxUMVZGVFU5WFVYbDFNRDBp?=
 =?utf-8?B?SUdsa1BTSWlJR0pzUFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklW?=
 =?utf-8?B?VEZTVTFKVlJrNURaMVZCUVVSblJFRkJRM0pxYkc5c09GSk1Za0ZqUjBvMlJr?=
 =?utf-8?B?c3dObFIxV25kWmJtOVZjbFJ3VHpWclJFRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGSVFVRkJRVVJoUVZGQlFWTm5TVUZCVHpSQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZGUVVGUlFVSkJRVUZCTTB4b1UyWm5RVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlNqUkJRVUZDYUVGSFVVRmhVVUptUVVoTlFWcFJRbXBCU0ZWQlky?=
 =?utf-8?B?ZENiRUZHT0VGalFVSjVRVWM0UVdGblFteEJSMDFCWkVGQ2VrRkdPRUZhWjBK?=
 =?utf-8?B?b1FVZDNRV04zUW14QlJqaEJXbWRDZGtGSVRVRmhVVUl3UVVkclFXUm5RbXhC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIwVkJXa0ZDY0VGR09FRmpkMEpz?=
 =?utf-8?B?UVVkTlFXUlJRbmxCUjFWQldIZENkMEZJU1VGaWQwSnhRVWRWUVZsM1FqQkJT?=
 =?utf-8?B?RTFCV0hkQ01FRkhhMEZhVVVKNVFVUkZRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZCUVVObFFVRkJRVmxSUW10QlIy?=
 =?utf-8?B?dEJXSGRDZWtGSFZVRlpkMEl4UVVoSlFWcFJRbVpCU0VGQlkyZENka0ZIYjBG?=
 =?utf-8?B?YVVVSnFRVWhSUVdOM1FtWkJTRkZCWVZGQ2JFRklTVUZOWjBGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkNRVUZCUVVGQlFVRkJRVWxCUVVGQlFVRlBORUZC?=
 =?utf-8?B?UVVGQlFVRkJRVU5CUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUZCUVVGblFVRkJR?=
 =?utf-8?B?VUZCUVVGQmVtZEJRVUZCVFVGQlFVSlBRVUZCUVVGQlFVRkJSMFZCV2tGQ2NF?=
 =?utf-8?Q?FGOEFj?=
x-dg-rorf: true
x-dg-refone:
 d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|CH7PR03MB7929:EE_
x-ms-office365-filtering-correlation-id: 7c59deee-ad60-4db0-f38a-08dce1084a19
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y202RzNWZ000bkxUYjc5WUQxamtRT1FyUXMraEkzd0tpcEwyY2NwTUNpdkRm?=
 =?utf-8?B?K0ZQNXpwRXcrZTVqZVVvU0gvaE0yUWdZUkxMY0VVblZCenA0WEVQSVgyT2Nu?=
 =?utf-8?B?aUJvNmduWHF0QUFpc210SEpCMEtVT2dmdXVDUXpHTkNSOHhFYTF4RjlFdVVm?=
 =?utf-8?B?QytMQzdiaDlSYWtRd1F4cVZJSFlEQ2xLWUU2MThjK0w5d3ZNWHEyQ29KTUNU?=
 =?utf-8?B?RE5tdS9FUUtDQWcyaElmc29lQ3hVSkplNHhaemVvRWRyYzFPM0JFNklBRE9V?=
 =?utf-8?B?WHpERHZaSUg0UzdrQ041bmVtNlhzRnY4UGdEMExhQUV5Q3NCb1k1UXR5a0pj?=
 =?utf-8?B?RVJKZTNJU0pTaS9NR2FleDlZYlJ1RTJ0c1NHT3Q5aTg4TjNrWWxlbVNGMmJx?=
 =?utf-8?B?NzJwWVJaTzN5Ull3M2FyMW5uUW8yUXI0NTk1Uy84MDhtamdCU1VjbXdpRkk3?=
 =?utf-8?B?amtaczdxYjR2ZlZzSVVpV0pyVS9XNDhIWFJSZWx3NDloVHBlZ29lY2FZQVh6?=
 =?utf-8?B?eXc4Q0lOdXc4RkJHcFg1RjBDRER4amVTN1lUcjJqSTFvR21hS01VcUoyVDBK?=
 =?utf-8?B?akIxdXZMb0E0cVFKL1Y1R29IeW5Ib29uWHRTSS9aUmNJcDF0SWdMSG1BT3dn?=
 =?utf-8?B?NnN0Ym9WY3lwWW5DTTF0MjNnaThkeFR4cXNNQURmUmVvd1A2c05KYU5EYUZM?=
 =?utf-8?B?Y0hhTjd3VWJmQk01MHd2S0FWNHZjR1lISjVicjlCOVA0TUlXSWxPb1RQbkUx?=
 =?utf-8?B?czRhYUJDS0NxNUJOamtnNDYxd1czSklORVZQN25yZ3Fiam5SRzhZeUkvWlg1?=
 =?utf-8?B?bmZGYWdzYW5ScG1sVERwQ1FMRUZMSFZvNDVUVzM0TFFFdDl4OUpmckNHcHJD?=
 =?utf-8?B?WVRoaUw1bS9hdW1VeTg0STF4VzR4Z0pLU3J0dmxJbFFxMDBJMFVsSm1Xckhq?=
 =?utf-8?B?YWhCVnU4a1lmRnJmL2JuVmpXdFBrMlp5TGFXb3Z3SHJkbDVVNnRIOFFsNTdG?=
 =?utf-8?B?SmRzNndjU1hiY1VrRG9tSHhuKzRjREtiSVJnSjMyd2tGa1pocUpOaUYwSjNL?=
 =?utf-8?B?cHVyNFV2ci9jR3ZSODdMc1hKaC9zRnA0ZW5aNkNSUnFnQklQWTZKdkowK3Fh?=
 =?utf-8?B?Y1RKMEhNRndKTC9lZWc0bVJwT0dwUThOSzZuOEVLRm0xUXgvaE1vUXpocWMy?=
 =?utf-8?B?cnFmTDUyTUJ4U0ZVWjV6ZW1ZN3Q4bUVrcmxUM0psL3dXd1JzSlhvWE9YM1dv?=
 =?utf-8?B?UUdEa1g2L3NrVnRQTThNL2R5eTNGcnBybUJTYk5qM2c5ZzNEUTYxSE5zSWFK?=
 =?utf-8?B?Vkdna2lmWFZuMzBrZHVNbmlwMkk2a2FUOEIzQkZoU0U3eEREd0UrdlFDbElY?=
 =?utf-8?B?ZFk1RHJ4S2RwYUZyYnU2eUphMHpGYVAvS0NFKyt0YnFlcWp5QUdCVnZiS0FN?=
 =?utf-8?B?TGRSWnpLdmdMV1M4eFpIRXNBK2pEVUhlWHlYakpTSE9YZ0EyQ3ozTGNUV25W?=
 =?utf-8?B?MGNwM09nRDNEVngzbElXVnBEY0RmLzl6aEVXeWt1ZHV5OEFPUU5ta0kxZjdB?=
 =?utf-8?B?K3Rlano4OW93RlFHOTdEbDNqWGtsd3dYVHpvS0JFR1c3ODh0czNUYjdpelRZ?=
 =?utf-8?B?RWNQODJQODltOXFyNW41NUFNWHd4clY2VHczUDc5K3NvTmlxMithVlZNc1Qy?=
 =?utf-8?B?bFZpc1BxejhrZ3gyRWNrbUx3Q3lZNzlYdkNSMVRxNllSUmsxSUkzcm1TTHVI?=
 =?utf-8?B?OS94OElJeUxQZHFkL2NodVRjdGkwVFovTy91QXRIRjF3U29hbzNuK1JYajUz?=
 =?utf-8?B?UjFGbGd4SGVFY0JvMThPcHlmUDIwZ2VnbmJJREIybUpSNlhrSHlLdzZFeGo1?=
 =?utf-8?B?b0ppV2c2amxkT1l6Y3VUUnBFMFRadE1UdTh6SGg4TDZVZlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUJ4cWNGQnV5Qm1VSTJqM0ZwQUUwQUtvVUc0R0Q3OFNUbFFpS3VUdUwrME9q?=
 =?utf-8?B?RXY4RWEvMzdZUlR1OVZTbFo0NFE1WWtoNVRlS1FsbHVFdVo2WnFMNFEwR3c4?=
 =?utf-8?B?Uk5Od21meU9rTDlwVkRCcTMzUXgwelNob240UlIveXFhR3ZLdTl3U1ViTEZJ?=
 =?utf-8?B?TlE0bTd1U1F4S1NUM0prTDZhcWpicnVjK3JZYjVPYXlMUkE2MlBpVzRjdTN3?=
 =?utf-8?B?QjdEUUxzQVAveTRxSFVXcmVKNnRVa1BFbVR3c0xVYVNxUkdPNnAwdit2QzFz?=
 =?utf-8?B?eWcrMFdlU1BHQmU3RHJRbnlVVTAxR3cyQTlNRkt0dzZZbzdNd3prWTU2THVL?=
 =?utf-8?B?Ym5OaWQycE5yODZKODFIYXQ3TndML1loRmN5dkI0N0hDMnRWUFU1aGRCb05G?=
 =?utf-8?B?VXNldWh4bm8zRGlUUzNTK0ZoK1IrV1RnUUhlWlNPOXJZbEUwWVNnNmhPanEz?=
 =?utf-8?B?WW9rSC9FMlcrVndTM0hMNm5XVE9QdThQYWJ5NzR2OVZrcndtSTlNd3hwaWNl?=
 =?utf-8?B?dzYzWDZZTDhEUEFXcTF4YnhSakRtVHFiam1Kc29iUWVKenFMNWJVQUxsY2hr?=
 =?utf-8?B?ZURQVnhUQ25hQWNsSTRwejVDVUdwWXdRS1E4TEUrYVkrS2VOVFloY09tcnNw?=
 =?utf-8?B?cE9UcS9qblZWbUdzUndaZjlqeW1YS0ZYSlJFR3l6TE9HaXVmUWxHamJhbnZD?=
 =?utf-8?B?V1FYRmF0WVpLUnFJVUlPV0ZnVmJWbC8zUHlYeGJ2RGhpMG9pS203Um5SZEdr?=
 =?utf-8?B?Wjg4NWk1T3JMdnBhZmZRT2FMQUEzT2VoZWdNM3FjaGU5VUdmdnhVWGZVTEtF?=
 =?utf-8?B?c2c1T2xWaWw3YVNKa2ZoSGNRa1dEeU5TVEtRQXRQRlVXWHRVRzJDR1VKczNz?=
 =?utf-8?B?V0pRKzZmYWIxcGVIdzNIQWxWVUY0ak9aOENBZkdUMDFGckxxZ2lmQmxtK3k4?=
 =?utf-8?B?KzF6Ulp0T0piSVoxWEYzNlhmWkhUM3d5d2xZTVI4cHEwNXNsNHR0Vnp6dlVE?=
 =?utf-8?B?T0xpbTdPajlVT0ZIcXpMb2pUOUtGZlNTU3dCNlNBVW1PYTl6eGJlU1NGcE1B?=
 =?utf-8?B?ZUJjb2tYeWlFNWVIY3hqMWNnWktxdHVObW1lWUd1U3p1bVcvWm81N0MxTWxU?=
 =?utf-8?B?dlgrNFVUT3ZodzRvKzVSbDlmb1lFUm5LMzFKaWpqMkJkeVlYSHgwTlc5L1h3?=
 =?utf-8?B?S1NtUnpQakpoRzJKK2VJbm5aQXBkWHc2b1ZvRktVS0szT1VIdzZLS3puZFlE?=
 =?utf-8?B?VDNCOTFwNUQwZHljcHYzTGY1UXZYWVdhbVFiUkdKdnpMa1FlUkVFQlZXR2hh?=
 =?utf-8?B?NUc0eTJJUEdyQ1VOUjlEYWwrQjNZeDEwMjh0dGxaZG1XVUtqdVRnWi9TbXFr?=
 =?utf-8?B?UDkrZUNWbTM1WTJxYXJxc1UyODRwSVdSY1RjRVBkSHdsOVNDWVZ5MVFmanBr?=
 =?utf-8?B?NEdsbUd2dnBoZHVlS0hTNDNvS25qNFVneStWNzd4V21pTjhCWGVUckxXTGxw?=
 =?utf-8?B?cUl2Nk9HTUlLMzdzbDlMYVNWSFB1SXJYUTkxNDJuNElPV0pTWHN3Ym5NZTZF?=
 =?utf-8?B?bHFibU8wcExuM1AzTVhjbS9RbGlCcGN0WmJRZGljaTZSSG4wTDBjMmNwNjVq?=
 =?utf-8?B?OERURXhKUnZmSFNobnRUeng3aVErdnprb2FFUVpaZkF0SG1HUCt1RHFXeHYw?=
 =?utf-8?B?ZlNaVlF4aE9UbWtWYlo4MThrUmlQYmJNK1dOYVYyR0FsbFhNd2dtaTdvT0Z1?=
 =?utf-8?B?M2EvdHJtMVlSU0FSb3VLY1Y4K2V4MXdIZ1RBY08rV2ZhNDh4T21qKzNaSWE3?=
 =?utf-8?B?SDBSbDg3U3JDNS8wNkovRVJWdlNHMWczU1ZoUGlSdGZSTk0waVR2SmxuTm43?=
 =?utf-8?B?SFJwaDIxWElCZ0xlMWpJUHlCNTFsVHRCUCs4UFNGMnMvUlNLN1NuUDU5YlRF?=
 =?utf-8?B?ZG8rVXhmeHk0MDQrbjhycVgrQ2d6VVd5S0l1WGo1NFRUS2p6WGpFOGxybWdN?=
 =?utf-8?B?THBRQ25DWVF0YkFENWxTZm00OVpUd2x2NVlJR3hFbE4vbTVnbzU0WkpYSGRt?=
 =?utf-8?B?UUVCTms2aHV3YlozNm9aQ1VDU1QxWTBtYnBsMGRyNERFMklaK0c5T2ZDUGpX?=
 =?utf-8?Q?QMBoVCrJ+rTPJIqEV2s2fzefF?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c59deee-ad60-4db0-f38a-08dce1084a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 04:28:09.8578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCR7DUxhi3Rl+CriIaxXe1VUfYRK1rrLzBdKug0+gMV3J0e9I1esjLvmmmqapn6xa77DiwM7ukttnX90dKHMmmSZnm7KIgcLsrom5Nt8hC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7929
X-Proofpoint-GUID: uPuugSL3FYEuICuG7-w_0hYYSM-OeOUd
X-Proofpoint-ORIG-GUID: uPuugSL3FYEuICuG7-w_0hYYSM-OeOUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300029

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciAyOCwgMjAy
NCAxMDoyMCBQTQ0KPiBUbzogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRA
d2FuYWRvby5mcj4NCj4gQ2M6IFRpbmFjbywgTWFyaWVsIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5j
b20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuDQo+
IDxsYXJzQG1ldGFmb28uZGU+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6
dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVs
DQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTWFyY2VsbyBTY2htaXR0IDxtYXJjZWxvLnNjaG1pdHQxQGdtYWls
LmNvbT47IERpbWl0cmkgRmVkcmF1DQo+IDxkaW1hLmZlZHJhdUBnbWFpbC5jb20+OyBEYXZpZCBM
ZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoQ0KPiA8bm9uYW1lLm51bm9A
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gaWlvOiBkYWM6IHN1cHBv
cnQgdGhlIGFkODQ2MCBXYXZlZm9ybSBEQUMNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFNh
dCwgMTQgU2VwIDIwMjQgMjA6MjE6NTYgKzAyMDANCj4gQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJp
c3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4gd3JvdGU6DQo+IA0KPiA+IExlIDEyLzA5LzIwMjQg
w6AgMTE6NTQsIE1hcmllbCBUaW5hY28gYSDDqWNyaXTCoDoNCj4gPiA+IFRoZSBBRDg0NjAgaXMg
YSDigJxiaXRzIGluLCBwb3dlciBvdXTigJ0gaGlnaCB2b2x0YWdlLCBoaWdoLXBvd2VyLA0KPiA+
ID4gaGlnaC1zcGVlZCBkcml2ZXIgb3B0aW1pemVkIGZvciBsYXJnZSBvdXRwdXQgY3VycmVudCAo
dXAgdG8gwrExIEEpDQo+ID4gPiBhbmQgaGlnaCBzbGV3IHJhdGUgKHVwIHRvIMKxMTgwMCBWL868
cykgYXQgaGlnaCB2b2x0YWdlICh1cCB0byDCsTQwIFYpDQo+ID4gPiBpbnRvIGNhcGFjaXRpdmUg
bG9hZHMuDQo+ID4gPg0KPiA+ID4gQSBkaWdpdGFsIGVuZ2luZSBpbXBsZW1lbnRzIHVzZXItY29u
ZmlndXJhYmxlIGZlYXR1cmVzOiBtb2RlcyBmb3INCj4gPiA+IGRpZ2l0YWwgaW5wdXQsIHByb2dy
YW1tYWJsZSBzdXBwbHkgY3VycmVudCwgYW5kIGZhdWx0IG1vbml0b3JpbmcgYW5kDQo+ID4gPiBw
cm9ncmFtbWFibGUgcHJvdGVjdGlvbiBzZXR0aW5ncyBmb3Igb3V0cHV0IGN1cnJlbnQsIG91dHB1
dCB2b2x0YWdlLA0KPiA+ID4gYW5kIGp1bmN0aW9uIHRlbXBlcmF0dXJlLiBUaGUgQUQ4NDYwIG9w
ZXJhdGVzIG9uIGhpZ2ggdm9sdGFnZSBkdWFsDQo+ID4gPiBzdXBwbGllcyB1cCB0byDCsTU1IFYg
YW5kIGEgc2luZ2xlIGxvdyB2b2x0YWdlIHN1cHBseSBvZiA1IFYuDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogTWFyaWVsIFRpbmFjbw0KPiA+ID4gPE1hcmllbC5UaW5hY28tT3lMWHVPQ0s3
b3JRVDBkWlIrQWxmQUBwdWJsaWMuZ21hbmUub3JnPg0KPiA+ID4gLS0tDQo+IA0KPiBSYXRoZXIg
dGhhbiBnbyBhcm91bmQgYWdhaW4sIEkgZml4ZWQgdXAgYWxsIHRoZSBjb21tZW50cyBtYWRlIGFu
ZCB0aGUNCj4gYXV0b2J1aWxkZXIgaXNzdWVzIHRoZW4gYXBwbGllZCB0aGlzLg0KPiANCj4gRGlm
ZiBmb2xsb3dzLiBUaGUgb25seSBiaXQgSSdtIG5vdCAxMDAlIHN1cmUgb24gd2FzIHlvdXIgaW50
ZW50IHdpdGggdGhlDQo+IHRlbXBlcmF0dXJlIGNoYW5uZWwuIEkndmUgbWFkZSBpdCBhbiBpbnB1
dCBidXQgc2hvdXQgaWYgSSdtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiANCj4gV2l0aCB0aGlzIGRp
ZmYgYXBwbGllZCBvbiB0b3AsIGFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdp
dCB3aGljaCBpcw0KPiBvbmx5IHB1c2hlZCBvdXQgYXMgdGVzdGluZyBmb3Igbm93IGFzIEknbGwg
cmViYXNlIG9uIHJjMSBvbmNlIGF2YWlsYWJsZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0
aGFuDQo+IA0KDQpIaSBKb25hdGhhbiwNCg0KVGhhbmsgeW91IGZvciBmaW5kaW5nIHRoZSB0aW1l
IHRvIGZpeCB1cCB0aGUgaW5saW5lIGNvbW1lbnRzIGZyb20gdGhlDQpwcmV2aW91cyByb3VuZHMh
IEkgaGF2ZSBjcmVhdGVkIGEgcGF0Y2ggZm9yIHRoYXQgYnV0IHdhcyB1bmFibGUgdG8gc2VuZCBp
dA0KeWV0IGJlY2F1c2UgSSdtIHN0aWxsIGNsdWVsZXNzIGFib3V0IHRoZSB0ZW1wIGNoYW5uZWwu
IEFwb2xvZ2llcyBhYm91dCB0aGF0DQoNCkFib3V0IHRoZSB0ZW1wZXJhdHVyZSBjaGFubmVsLCBp
dCBkb2VzIG1ha2Ugc2Vuc2UgdG8gc2V0IGl0IGFzIGlucHV0IHNpbmNlIHRoZQ0KdmFsdWUgaXMg
cmVhZC1vbmx5LiBBYm91dCB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGNoYW5uZWwsIEknbSB3
b25kZXJpbmcNCndoYXQgd291bGQgaGFwcGVuIGlmIHRoZSBjb25zdW1lci1nZXQtY2hhbm5lbCB3
b3VsZCB0aHJvdyAtRVBST0JFX0RFRkVSDQpoYWxmIHRoZSB0aW1lPyBJcyBpdCBub3QgcG9zc2li
bGUgdG8gc2tpcCBpdCBvdmVyIHNpbmNlIHRoZSBjaGFubmVsIGlzIG9wdGlvbmFsDQphbnl3YXk/
IE9yIGRvZXMgdGhpcyBkZWZlciBlcnJvciBmcm9tIHRoZSBjb25zdW1lciBtZWFuIHRoYXQgdGhl
IG90aGVyDQpjb25maWd1cmF0aW9ucyBmb3IgdGhlIHN1Y2NlZWRpbmcgYXR0cmlidXRlcyB3aWxs
IGJlIGJsb2NrZWQsIHdoaWNoIGlzIHdoeSB3ZQ0KaGF2ZSB0byByZXR1cm4gcHJvYmUgaW5zdGFu
dGx5Pw0KDQoJc3RhdGUtPnRtcF9hZGNfY2hhbm5lbCA9IGRldm1faWlvX2NoYW5uZWxfZ2V0KGRl
diwgImFkODQ2MC10bXAiKTsNCglpZiAoSVNfRVJSKHN0YXRlLT50bXBfYWRjX2NoYW5uZWwpKSB7
DQoJCXN0YXRlLT50bXBfYWRjX2NoYW5uZWwgPSBOVUxMOw0KCQlpbmRpb19kZXYtPmNoYW5uZWxz
ID0gYWQ4NDYwX2NoYW5uZWxzOw0KCQlpbmRpb19kZXYtPm51bV9jaGFubmVscyA9IEFSUkFZX1NJ
WkUoYWQ4NDYwX2NoYW5uZWxzKTsNCgl9IGVsc2Ugew0KCQlyZXQgPSBpaW9fZ2V0X2NoYW5uZWxf
dHlwZShzdGF0ZS0+dG1wX2FkY19jaGFubmVsLCAmdGVtcCk7DQoJCWlmIChyZXQgPCAwKQ0KCQkJ
cmV0dXJuIHJldDsNCg0KCQlpZiAodGVtcCAhPSBJSU9fVEVNUCkNCgkJCXJldHVybiBkZXZfZXJy
X3Byb2JlKGRldiwgLUVJTlZBTCwNCgkJCQkJICAgICAiSW5jb21wYXRpYmxlIGNoYW5uZWwgdHlw
ZSAlZFxuIiwgdGVtcCk7DQoNCgkJaW5kaW9fZGV2LT5jaGFubmVscyA9IGFkODQ2MF9jaGFubmVs
c193aXRoX3RtcF9hZGM7DQoJCWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShh
ZDg0NjBfY2hhbm5lbHNfd2l0aF90bXBfYWRjKTsNCgl9DQoNCkkgYWxzbyBmb3VuZCBvdGhlciBp
bXBsZW1lbnRhdGlvbnMgd2hlcmUgdGhlIHR5cGUgb2YgY2hhbm5lbCBpcyBjaGVja2VkLiBUaG91
Z2h0DQpUaGF0IG1heWJlIGl0J3MgYSBnb29kIGFkZGl0aW9uIGZvciBzZWN1cml0eS4NCg0KVGhh
bmtzLA0KDQpNYXJpZWwNCg==

