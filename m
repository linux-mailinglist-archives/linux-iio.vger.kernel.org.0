Return-Path: <linux-iio+bounces-5481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ADF8D4687
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B25D2838E3
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D72144312;
	Thu, 30 May 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dfOYXoQH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50A142E60;
	Thu, 30 May 2024 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055922; cv=fail; b=Wmr6oohYhRpVEv1Zt457751UcF8b28BvN32OIpRv4/uUZ6haPmYka56bViz/tZYx6GrUNhuZXjPLJOnNig1NEh1g6EV9ts0du6mmIp2rJkiYsP24Ll1ONAuH5eY5eHNq1CqKg1QPLGU4iwMnVsHpLL/OO/80N8Tn3ojHOUPpReo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055922; c=relaxed/simple;
	bh=REES1BNOGxItrAPA+LWEq1K71hXpLMSjYriTvF/qWdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XtO9rjdyNEsnJ1HFiUnVJUMwKsOxQW+/UixQXRMMke1ep2i8Ywk4gUDqkT2/2t/TSqGhtUbIpeuQz+VoPlDUqYtXcJPXz6IRvheUkP96J2Ixf6zuAa26MDD6RiXs/Ey/DmjCeqyhsS/GkgiOnV4Ug+/ikDJSYzsMrnTt52OXxk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dfOYXoQH; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U3iACi006279;
	Thu, 30 May 2024 03:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=REES1
	BNOGxItrAPA+LWEq1K71hXpLMSjYriTvF/qWdI=; b=dfOYXoQHcSht7o/v1UQT0
	E7Qhb84bEWuiCIAWLBpwwpCGM2jcabeU1N9dMQaqEiKxs7ts7t0tb9W2L+E3ax2B
	lCloARpy9S0Xt2rWYGpLwFUerBWfuLkgTlBFmqZyyU3Ma+Ug/LaoL+CGQLR/wNwo
	PpJMA7ZUzgagyx0xeZmJaWkuBdQuAuQiCI/7/9/BSDTOR0KCbsdemVLBIRM4ajW0
	pTgX0JCHnUs/6t+lBxYjHytyTJsMqBGg9r0pnrbsIAm9KQhSE53F3y3GxSAl17dV
	M48GXjHlQU/mhNdc12PKLU0exqTMsChf27ckxdkE9kxfMP3/IqfdqH96lSJdSvb0
	A==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yehtj0s8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 03:58:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOYrPEph+pY7nsg8s5fAlroqi7C27bAgvE+UMB4HPvZbNV1xhcwY4UzMVcpWM5rtPLNVe6AF/NbyJ33U7zEMp3uG9HoZtduguHBI6va5+mxpUIZ0v/Y7O8Olrqxygwy4csvEs4YWvm/Ym6OnQt+L19Gg9L3W786SqLyMnemvbX/2WjK48kTGtMwHecbOIuP8fYq1eqAeLhlJErjvsuxACHxz79N6SvEINrJc1SObFircmxTYaRXbLOwF/gjVGEfbzNs/GJw28MXLpgR5mD32xK/2MYGvkfN5FEJEnw1nQp/aRtfsM5xz+oGxdrp+To9YLSPuE8UxLQDXbJHRvsnRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REES1BNOGxItrAPA+LWEq1K71hXpLMSjYriTvF/qWdI=;
 b=fWhFvfDlDvabaD8gwGjedWQG7yPj/N0toMlnFvnZAihopefopuAcLn2JA/9FE9k9wptq2rpKrLa5W2YfC5M6Yo/hYn9AR039V+OjCS9zb3l2uULBGByUn0JEfJkEK9zV3nLySQ+ItbWLfYiOCq/zjndG9Qp6gk7eXLfHA/c+bd+Q2Q1LgJhfxI6rCvpq0FcJFNa0Xh1+7Z/GGGgiuDWu5ca9uMraQPM+wi65GwZw/oD757s+M+JZ+wAqpye6McD6rSnqcCZvZir5aKfMfs5MquGnDkLC2hzcNTkBHhw5ILReLob1qMQhVv8TM4biFN5zSuqlpAduVyH+kcABDS6oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by PH0PR03MB5783.namprd03.prod.outlook.com (2603:10b6:510:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 07:58:22 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 07:58:21 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: iio: adc: add a7779 doc
Thread-Topic: [PATCH v2] dt-bindings: iio: adc: add a7779 doc
Thread-Index: AQHaseFy2mJuEBXstEWBpaVEykm0WbGudsOAgADyF/A=
Date: Thu, 30 May 2024 07:58:21 +0000
Message-ID: 
 <SN6PR03MB4320F8629C98A89EAF4DBCB9F3F32@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240529160057.6327-1-ramona.nechita@analog.com>
 <171700355516.3194061.3370825262697979106.robh@kernel.org>
In-Reply-To: <171700355516.3194061.3370825262697979106.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY201bFkyaHBkR0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyTUdGaU0yUTVZaTB4WlRWaExURXhaV1l0WW1Jd1pDMHpZMlU1?=
 =?utf-8?B?WmpjME56VmlPR1ZjWVcxbExYUmxjM1JjTmpCaFlqTmtPV1F0TVdVMVlTMHhN?=
 =?utf-8?B?V1ZtTFdKaU1HUXRNMk5sT1dZM05EYzFZamhsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STFNekF5SWlCMFBTSXhNek0yTVRVeU9UUTVPVGsyT0RVM09EUWlJR2c5SW1S?=
 =?utf-8?B?dGJrY3JaelJvY21SdmJsTlNSVEJFZG5KdVJVNXRPVTF2Y3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTFrMlowMXFXamRNWVVGbFUxWlZiVWxvWm5ndmN6?=
 =?utf-8?B?VktWbE5aYVVZdlNDdDNSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQk0weG9VMlpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|PH0PR03MB5783:EE_
x-ms-office365-filtering-correlation-id: 2249b35c-2526-44ad-3b4d-08dc807e46a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V045MTVjb1hMY09iY0hOZGVoWFFuTXpqZFJjQW5xRzlpWFNyWHh2M2VIbmZ2?=
 =?utf-8?B?UXdnSGFJZEhGY1NWSmpleG5qRkZBakV6WXkvQTg0cVNBaTlERmltZ0FlYklq?=
 =?utf-8?B?dFpwUEZxb3k1c1M2R29zTWlrWThlaWdQVlIzVEtGTlVEUllualQ3M2xKaWRl?=
 =?utf-8?B?WXdrZGxXdHpyMFU1SkJtMUFkeW5OWTc0NEZ5TGJoSkNDVTNGUHUvSFhvQ3Nw?=
 =?utf-8?B?bGM3blRSSTQ0UDlMMENMclFVbko1bjlZTlIrRmJIVEZIUmFoa2xEcE0wdTVa?=
 =?utf-8?B?Y2cwYVIreHFzSUVPb2VHUGFTM2JVQ05ZQlNaK3dLYVV2azdrVDJYYW4wZzNQ?=
 =?utf-8?B?c2YzY3U4clVmenFrT2prWmJaTHBQbmZ1UHJqY0ZPeFA3ck0zZUlzc0VNNGh6?=
 =?utf-8?B?ZUhmd1hLYU41YzR4OHM5dkt2MmhCYTdxKytFV0RFMWJOS1FHZUx3ZXRvK3JN?=
 =?utf-8?B?cVRMUVMyR3R2UTZ1TEJ5VFpGcUpud2pTZU8wbGgyN2REV2FIeUIvQjRLbGhZ?=
 =?utf-8?B?Q0h2djRpZmFMbEdQeWhYN3ZFd0Vwb0N5TS9oUkxSdlVXWWU0OVA3Vk5Zd3hB?=
 =?utf-8?B?RFdFbUNPSjBiOWNzZ0Q3Zk9ySHMxRG5KbzZNSDFzNGVINFVxMTdCWTkzbTVL?=
 =?utf-8?B?ZVNnV3NTb3BUaHZQVUFtOG5TbVIwbW5aNlB4WnpEL3EySitTenlSWDFnWWxG?=
 =?utf-8?B?eGMzczJqelc5Y3FyM1oxOWhCcXBicmdMSjdDL2ZHUDlQdmRmNmk4RlduZ1FS?=
 =?utf-8?B?dDdWdkllK056RmI0S3FBczM3OEUrb2QwRjI4NCtsYmIrY2ZqNkRBTDJSZE5v?=
 =?utf-8?B?RjlUemRTOFV4ZFJqT0NTcmZCMzQ1d25pU3lCa1ltNUNjOTc5MWN4aXVZcU80?=
 =?utf-8?B?V3RoNUlPRXdJd2JuOTFXSktyWjZ6VnFrWU14TkJSTytMTVpLRGJZekNadjhS?=
 =?utf-8?B?N2kzQXp2UDg3UTNOV1hZQ1JKOGVYbCsrbFNlakNmdks2TXBROXBUczh4ME92?=
 =?utf-8?B?WlIrSHAvbWoxN1hmVXFQbjJ2ZERqTFBORGhMd1p2YXNQa0ExaFdiUnBNaU52?=
 =?utf-8?B?M2VjZlB0dGVIYlhOZEVLdlRiWkJZVXhmcU15ajMyTldIZ25jRXh3QWQzUW1l?=
 =?utf-8?B?ZUpqTDhKb3N0UzlZSm8vc3FqNmZjUnVkRHFMaExLbXMrQ3lPS0x1RjdhNUhl?=
 =?utf-8?B?d2psQXpwRUI2NkdnVXIzQjIwOW5JWndLMzhJdmJOeXZRWmhsZ1FMampVdklz?=
 =?utf-8?B?TWFlMTM5MkN4R2gwbE1LMVR6WWQ2bXJzMmZVM3BCengzMDlsemlSNXpWZGxz?=
 =?utf-8?B?Y056RlZZcWp3ZHVlYlBzVVR6d0ZRY3lTM3VDWlA4cktUSjcrVXgwMmZGaEk5?=
 =?utf-8?B?em9oM0piL0dhcWxscVhFRGViMkZmY0R3Q1pTUXRFUjdSZzFJdDZkT2M4aXRz?=
 =?utf-8?B?aGpKTVJlMm5PWWpGQk1FNzEyL0UybFNFMWxBMjYydDNsaGtMTzRTanFVSWJw?=
 =?utf-8?B?cjg2bG1mRDJBdnhsQmZjeFVjZXN2Nkg2UUtUT1F1S1oyVGFaZkw4RDNoaGR3?=
 =?utf-8?B?bUVSVmpkc1prWUpESks3aUlFa0ZmSHhXc3FXYWtianNVY2VwYTRVRTJrTlRo?=
 =?utf-8?B?YzY1SGJPaVYybHRJbkhWb1Nnbk5nZElUSGtudG5PaXNjVmdGb0NDeC9CSmtD?=
 =?utf-8?B?Y3hqUU9pRUFxaW1BYUxmRThPVWtSTzNySmNBQ3JhQnp4cmlFUUxXa0NnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TDMrdzBscFhsWFVCNk1pSDUxbTlMRXBOM1lBdEFTTFViWVUxYnY2Q2FVdzBa?=
 =?utf-8?B?K2E3U3JvZDJ0VGo1a0gyOWsrR2NRQjQySTB5Z1lEZld6Ylg1QlkyNmJQMmZJ?=
 =?utf-8?B?emtuak4wU29JYmFCdjd4TlVtWkhrYnNROC94ZFVDcGlIVXZla3pBeG9ZSEVS?=
 =?utf-8?B?K0xvRTRiNUgwdHdDQ1pCUTZFNWpObmMveHN2dnNURUM5dHBtOVQ5QmlXemxC?=
 =?utf-8?B?SkU5Sndpa2JVZE5wMkJrTWxsRWliVzN5NnIzS0dYYkFua2NVNGN5T09OLzV0?=
 =?utf-8?B?aHF6V0xBWTRVaDdpRVRaSXU2bUtSRXNhSStDWUNWNGxkQ2R5NnluWWx1Y2Fn?=
 =?utf-8?B?WGFTcWxvRDRSNElyTUJpVGlqdW9NQTJTWDZrTDhFOVlyUlFkemNTTEpFNXNY?=
 =?utf-8?B?WUsxSnpQVlJ6SGEvYzU0QmdpSEJjbDdNVkw3UHNVd1pJL1g3N01FLzY2TVdm?=
 =?utf-8?B?OGtiU1lSSzNvbHNlZ3dmVFFCUTFYZEJpUHNyYkZ5Mlc2d2NzTjdYS1duVkJz?=
 =?utf-8?B?ZTVrTEZGemxEczJIeEtpUXQxMjdMNnByUmswRXhVWjI4ZmRtVC9PUWVGY1Z1?=
 =?utf-8?B?U3U3YmZiOVBxeDgyczBYKzA5SzRVMm5acUx0clh0d21wM0plcG8reGovRjNN?=
 =?utf-8?B?S2dhZ0hhcWVtQ29TVW4rL1JLeDl4aFc5QUNyS0JCem1tamcwVjJMeFM5SUtJ?=
 =?utf-8?B?VFcrYjhGemxwME5idFMzTVh5RGlGaXJ2Z2JhWXd4NlZhYTh4VityQ3YzT0xp?=
 =?utf-8?B?NmsxeU5pUFhWSGQ1N3lEcGNKM3hacHFsSlBCNE5jdzFqRTlEcnlSN0JzWDBM?=
 =?utf-8?B?SXIvWDVpdW5wV1lqVGVqYm9sTU9GcFpaRFlLd1ZLbi9BL0dBVkR5UXVzRi9L?=
 =?utf-8?B?VGpSaUlXeXRNdURhR2dKQ052ZWlXUTJKYzk2Q3h5c1UrUWZyd3JmZitUdjRT?=
 =?utf-8?B?S2dkdkxsV0dsWFIzU01Dc3owTVJ3MGphaVFYNDdVbm1RelVWZ1RFdVBYMDZI?=
 =?utf-8?B?MHR1aFhsNkNpQTdXUGI4bStYVFBvUTlsOXdBU2lJbDRvSkUralpNOE14cDM2?=
 =?utf-8?B?RjRYSENicWJQZHBCWTBDSWdaSmlLaGx3OWdWV095LzRYT3piVmduN1BxaTVJ?=
 =?utf-8?B?N0pZbHY3RzlpdmpSNndqQjdVRStzZDA2VHRhdUMvZzNqeVM1RUx1eHp0VlNQ?=
 =?utf-8?B?Rkp5cm1ZelNDWXdFRGFDQ1duWDlJNFZtc2xNZDM4cXdxNUg1L0lSU2k5TWYy?=
 =?utf-8?B?bCtZaTV1WFRDQStYNXJhUUlSRFp2SXRLYy8zZllhUlZZTllPYXhEbDdqYXBu?=
 =?utf-8?B?aWI4ZG0vTDJYTkJKNjJJcGx0cmFtRGg0aWt0dkRUdW5nb045WjI1bHdsbEdE?=
 =?utf-8?B?TlB3QjlLTk9Nd1BNaG82L2tpSUxyUXNKMllyQ3VWWCt4ZzFzaE53ZHNGV0h0?=
 =?utf-8?B?ZHMwTVJFVnhnSWdPVjVrUkNiRzhNY0RwZXUwd3dZYVQ4M3Zsc203ZC9LT3RJ?=
 =?utf-8?B?QnNtdnM5Q3BuTEYzWFpMUTh6enZGQXk3K3JxUjhsYjhGK3dGN25OWlVRV2VI?=
 =?utf-8?B?dDR0REYycUEvdjBuaks2Qk9RVS9iSmpmb0RpVGZ2aGpSS1dIcWtiV1FVczd0?=
 =?utf-8?B?NFFpaVozT3VzK0RZUFQ3bUtjenZWMWUrZytlcG1GdXJrLzF2emd4SitLb3BX?=
 =?utf-8?B?cVBaTlRaOURYdi9wV21GajI3T0tVbTVyc0d0YTFDeFpyMFUwTjdmU09ENE53?=
 =?utf-8?B?bmVFNFIzbkFoZlRNeHVLVEloNnVaK3hKK0FKYW5iMVZiZmhHNmowREg4K0Qv?=
 =?utf-8?B?cHBjczdSYmZ2aU1FQ0IrU3VGSC9IakVSV2tPTk1icDhPSWZOUjMzYjJ6TUJI?=
 =?utf-8?B?NEVQMTRjUjhlY0wvSG04eGw3TTdmOWQ2ZVFMUTZoWld3Y0FFcFVydHlHbmkr?=
 =?utf-8?B?eDFUZUx0RTNub2ZmbnRPcUpRWlY2UzVubHZDc3NZK2h5Zkh6V1EzbzUxR3Yw?=
 =?utf-8?B?b0ZVT1FLOTBwY0FLZEJ0MnhyLzk0UjF2RGQyeHdzR0FCVjZYaUdVNnRsc1RB?=
 =?utf-8?B?aGNNcW5sSEdxZWtaSVpXUitpeEd6dHpKR1Z4dTdGY1dSQ1dDZ2hFeXV1aDgr?=
 =?utf-8?Q?8t5rtC/ouh002WdlKnegvXykA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2249b35c-2526-44ad-3b4d-08dc807e46a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 07:58:21.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRKlqw7M359QwXDkAtm3ZFGz/RqfPXZDdWiyionJk8zuOY7WI1hUYC1Gapmblrjb3jvdWxMn4VFG5YADuNXMD/1PJKwChb7fhh0mmNNAH8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5783
X-Proofpoint-GUID: zpWjFT86o808Uxpj6Wjv58leXznP7Wv4
X-Proofpoint-ORIG-GUID: zpWjFT86o808Uxpj6Wjv58leXznP7Wv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300058

SGVsbG8sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24sIEkgaGF2ZSBpbnN0YWxsZWQg
dGhlIGFwcHJvcHJpYXRlIHBhY2thZ2VzIGFuZCBub3cgJ21ha2UgZHRfYmluZGluZ19jaGVjaycg
d29ya3MgcHJvcGVybHkuICBJIHdpbGwgcmUtc3VibWl0IHRoaXMgcGF0Y2ggaW4gYSBzZXBhcmF0
ZSBlbWFpbC4NCg0KQmVzdCBSZWdhcmRzLA0KUmFtb25hDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBrZXJuZWwub3JnPiANClNlbnQ6
IFdlZG5lc2RheSwgTWF5IDI5LCAyMDI0IDg6MjYgUE0NClRvOiBOZWNoaXRhLCBSYW1vbmEgPFJh
bW9uYS5OZWNoaXRhQGFuYWxvZy5jb20+DQpDYzogSGVubmVyaWNoLCBNaWNoYWVsIDxNaWNoYWVs
Lkhlbm5lcmljaEBhbmFsb2cuY29tPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJu
ZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBD
bGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwu
b3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IGR0LWJpbmRpbmdzOiBpaW86IGFkYzogYWRkIGE3Nzc5IGRvYw0KDQpbRXh0ZXJuYWxdDQoNCg0K
T24gV2VkLCAyOSBNYXkgMjAyNCAxOTowMDo1MiArMDMwMCwgcmFuZWNoaXRhIHdyb3RlOg0KPiBB
ZGQgZHQgYmluZGluZ3MgZm9yIGFkYyBhZDc3NzkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiByYW5l
Y2hpdGEgPHJhbW9uYS5uZWNoaXRhQGFuYWxvZy5jb20+DQo+IC0tLQ0KPiAgLi4uL0FCSS90ZXN0
aW5nL3N5c2ZzLWJ1cy1paW8tYWRjLWFkNzc3eCAgICAgIHwgMjMgKysrKysNCj4gIC4uLi9iaW5k
aW5ncy9paW8vYWRjL2FkaSxhZDc3NzkueWFtbCAgICAgICAgICB8IDg5ICsrKysrKysrKysrKysr
KysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTEyIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tYWRjLWFk
Nzc3eA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3Nzc5LnlhbWwNCj4gDQoNCk15IGJvdCBmb3VuZCBlcnJv
cnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KDQp5YW1s
bGludCB3YXJuaW5ncy9lcnJvcnM6DQoNCmR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQov
YnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc3NzkuZXhhbXBsZS5kdGI6IGFkY0AwOiBVbmV2
YWx1YXRlZCBwcm9wZXJ0aWVzIGFyZSBub3QgYWxsb3dlZCAoJ2Nsb2NrLW5hbWVzJyB3YXMgdW5l
eHBlY3RlZCkNCglmcm9tIHNjaGVtYSAkaWQ6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vYWRjL2FkaSxhZDc3NzkueWFtbCpfXztJ
dyEhQTNOaThDUzB5MlkhNUxQYTRHRXBmdW1nUkNUaHp0X2xTclZGZ2I3ZENiX1RYT1dJczJiS1VN
d1I4VzdBX3djU3VaYWpyaFB3dC1GTm1WYndSUko4bnZmQTNXQSQgDQoNCmRvYyByZWZlcmVuY2Ug
ZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQoNClNlZSBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUtYmlu
ZGluZ3MvcGF0Y2gvMjAyNDA1MjkxNjAwNTcuNjMyNy0xLXJhbW9uYS5uZWNoaXRhQGFuYWxvZy5j
b21fXzshIUEzTmk4Q1MweTJZITVMUGE0R0VwZnVtZ1JDVGh6dF9sU3JWRmdiN2RDYl9UWE9XSXMy
YktVTXdSOFc3QV93Y1N1WmFqcmhQd3QtRk5tVmJ3UlJKOFVjUGVWZFEkIA0KDQpUaGUgYmFzZSBm
b3IgdGhlIHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIGxhdGVzdCByYzEuIEEgZGlmZmVyZW50IGRl
cGVuZGVuY3kgc2hvdWxkIGJlIG5vdGVkIGluICp0aGlzKiBwYXRjaC4NCg0KSWYgeW91IGFscmVh
ZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZSBl
cnJvcihzKSwgdGhlbiBtYWtlIHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNj
aGVtYSBpcyB1cCB0bw0KZGF0ZToNCg0KcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0K
DQpQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21t
YW5kIHlvdXJzZWxmLiBOb3RlIHRoYXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91
ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBjaGVja2luZyB5b3VyIHNjaGVtYS4gSG93ZXZlciwg
aXQgbXVzdCBiZSB1bnNldCB0byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIgc2NoZW1hLg0K
DQo=

