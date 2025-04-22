Return-Path: <linux-iio+bounces-18490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560CA960AE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 10:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433BB179C54
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1E245012;
	Tue, 22 Apr 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xEXQlCiU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED8253B47;
	Tue, 22 Apr 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309568; cv=fail; b=GfOJzjhsgrPkZMBL/R0PaLFbODQ7uk2fHxZyZJkgc3z+l4wHRiYpKl4g5XXgT9/NpVaShHwlfm0JC0MmL3ugGXbwnJMfbdVafWgYyyUGGaKhUl6u8Adu7WeDRugQc75XWQW2IOjX3xJnatZ/s1QIBVd99M7v0YyF6Qz9Rr4nLxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309568; c=relaxed/simple;
	bh=qPrk5oL0qvlStHC5209TWfZHkorUqW3LjPRJPsyC4sA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=acM4wbATwtTGakMWmfwm56OB86FfW9wnPxXSJsNziASOisYrw4OwQdMYD7OnQ1u33cyj1vQyK68DwSLHZ/FByMo00ryJYY4EJ3zh9j3dUQE0N/h2NSyLE11Y9sUdWYAx+YN5iuwtlkAP/Ehri/QG6gzDL2t1YWIVtOesmp/Cqv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xEXQlCiU; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M80qKM029132;
	Tue, 22 Apr 2025 04:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qPrk5
	oL0qvlStHC5209TWfZHkorUqW3LjPRJPsyC4sA=; b=xEXQlCiUfv0OX5UTl/93o
	+0kLG3W0zjrliHKoiZ6d7PglAQ8N8qJE7yBPDJ0ArMCjPlq7lGFpi4f/Kl2PL9rv
	fIWaVuhZvDRWtcNP/8jyReaubY0eDXqpcTUGCXabvdH+eHWsfTE30aKNQ/yUTwji
	guRGecj7iqenNmLkue0pKFJGNa1jEDssqPRVkc0nYDsyO1/qsccTu3MKD87bmlXt
	WbfmqIFcqzE2tHB6oENSv1mAFrkvaXzNbAFqyCX30U0oQsYHihxpqs21dR2uQdSG
	Fnp9IoUh/+GxbkzHmlFEDBbivGYReXdC5c5GU+9/tsq2+sGLxKZfJEJHS/1mdVQC
	w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 464t5gjv7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 04:12:29 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAitw2c0UX7hEy+B2+w0iOC57HkLlmFgNeOzwtM0zOQtAhcWVaw7d+CnBB3P6/km6xkviliZv4g+2MHrLRi2lONyvHUZK85TTG54/dvSfqM6URgyO2XxIpBN9BoKJyNq4KuHKV7RCzWIGkhlVdXyGwbKGzZnShw71NhV20TgRn+BVJWS0+oR80FmpEtkJFutkcok9ZmLbXKYu9olH+G40qbaEwsA9cYOeTqPLEv6dahRwrawhw99UdlCzFFKJDvJj9tQIs5ayL/60uEnWH5BWEoE4Hz2Im0nOeskcFuvGEuXerTJze70haC2IVBFo1UFOUI+x/A8Z10mNc+kLFtzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPrk5oL0qvlStHC5209TWfZHkorUqW3LjPRJPsyC4sA=;
 b=ciRhiD9KOkn9pYNbk8Yc3FVR19VtvojfsEwV/UxS42Botj5Sw0+ILsX0HB0jRthyEsMHEUdkPHiGcU2zL/977hRYbd6cBKGkERiQiTCfvYJ8MxejowXDSMuFzpS6D0n5uPhk6wxjfLf1eFYDr9YqdYsEIFwwQ+6iGYF2EtNJVb9x+BhG2cllYrj7diIvVxW3Av34ox8QKqgTlxA86ebVfKJh9YnPKYNRk7YjC6BINe7D9/xc7eUMxyUZy7wY3JsjrulFCcpIfZxKvComRrlw30nSQ2eCaePHz/hYU+jJ9u6OMR3PwOxYydAaaLT+i+oWf76gK2Gz6Oc2p1mWkWtJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SJ0PR03MB7050.namprd03.prod.outlook.com (2603:10b6:a03:4d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 08:12:26 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%7]) with mapi id 15.20.8655.030; Tue, 22 Apr 2025
 08:12:26 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 13/13] iio: adc: ad4080: add driver support
Thread-Topic: [PATCH v2 13/13] iio: adc: ad4080: add driver support
Thread-Index: AQHbqt5ozCVpuxNfo0GDvpSFpnGry7Okc1GAgArwG+A=
Date: Tue, 22 Apr 2025 08:12:25 +0000
Message-ID:
 <CY4PR03MB3399B23673D9C3210C8CE9B99BBB2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
	 <20250411123627.6114-14-antoniu.miclaus@analog.com>
 <4e7100b945e542f675c6a506bc6431ad46cf6d84.camel@gmail.com>
In-Reply-To: <4e7100b945e542f675c6a506bc6431ad46cf6d84.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA0TkRZM1ltVmlaaTB4WmpVeExURXhaakF0WWpBMk15MWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjT0RRMk4ySmxZekF0TVdZMU1TMHhN?=
 =?utf-8?B?V1l3TFdJd05qTXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STFOVGc1SWlCMFBTSXhNek00T1RjNE16RTBNell3TWpJNU1Ua2lJR2c5SW1o?=
 =?utf-8?B?QlJsaEVkbFpQV2xkR2FWaG5MM0pWT1dGVlVuZGxUamRRWnowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVOW5RMEZCUTBoa1VFSkhXSEpRWWtGbFduTmpVVUpIY1ZjelV6?=
 =?utf-8?B?VnRlSGhCUldGd1ltUkpSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVJMFFXZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmFqSTRjM3AzUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSm9RVWRS?=
 =?utf-8?B?UVdGUlFtWkJTRTFCV2xGQ2RVRklUVUZoVVVJd1FVZHJRV1JuUW14QlJqaEJZ?=
 =?utf-8?B?MEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQlpFRkNjRUZIVlVGalow?=
 =?utf-8?B?RjRRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQklp?=
 =?utf-8?B?OCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SJ0PR03MB7050:EE_
x-ms-office365-filtering-correlation-id: 84928bcd-2ced-4164-d45c-08dd81756ad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWxkcENMbFRSSTFGYVFWdnh0aStKdHpzSE1PRlZHZ2x1SjdzVFk5ZnRoTGlX?=
 =?utf-8?B?Rjg5TkRWbW9zQ0xVaGZnOEJOMUF2N25hZUlSRnIyR3oxbWlqcEdFbU85Sis0?=
 =?utf-8?B?UjIvZVZJWkRzYzBYZXJkOGNHZmFTb3FLRXVRcDZibWhzSlJVM0lweVo0RlRH?=
 =?utf-8?B?cEkrYjc4dzNIVmNaNXZtNTI2NGxJaXRncmR3RHpSNzlkS0xaQmNxZ0JzRmFh?=
 =?utf-8?B?YlR1aHhhclRDMWtkMWVaUzRQdi9yLzNjQjhnbGNPZUR6cy8yYytnaXZpdGQ4?=
 =?utf-8?B?SzRVQXVzOXdnTXdMQUFScTkveXdJblBaTDdIMDVoUmxabm9LNGFFZHZUMWNF?=
 =?utf-8?B?ZUFOYVljQWJEWlVXM2hIcnUxS0ZxL0lWelpXN2tGQlBDRnZFTmpaVzB3TDlE?=
 =?utf-8?B?RmpxVmZDdWJTWlR3KzNVdzU2aEg0amRhN1hzMnNEZ296RDJ0dTFDZ1BnNmFz?=
 =?utf-8?B?QzJXMXVPUTlqWDB4OHhFRGZEZStMV2QvRXREaGgybkpNYlVEOUZidlJSM1BO?=
 =?utf-8?B?bWR4TzgyR2F1RytWclpNbWxzRWsxMmZEbUZZTGRFUmh1eEtPMlBLOFFISFVP?=
 =?utf-8?B?amEvSTVURkNXcFk1WWJCUW5IMDlvYjBoWFdQNExqM1M5Ykt2VGRhdnBhWU45?=
 =?utf-8?B?RkVUS2ozTlVSZEtHMXVlTHBFeDRQR2NrTW5XZHIyOWkzOVRuekd4dFZHVWxn?=
 =?utf-8?B?MGxPWVh6U0FMZVV6eUt0bmhwZDNRRStHTFRBYi91S3VETmtwMkh5WVZkdUF4?=
 =?utf-8?B?UlNMVE05VWNVaFNnakNBUlpRM0JjSzZUeTQzbGNwY3U4OVM1UWIrYlFPQURC?=
 =?utf-8?B?cnJYTDhFWTkvVFExcDVITzdUWEFhUTgzcVNqYkExdmE2YmFMQVhpNWZQOGZY?=
 =?utf-8?B?RHUwL2hsdWppSmNYWnBjQ2dSendmajBkNnZjcW1keHlXNWdCMDNaR3YzQk04?=
 =?utf-8?B?RndiNW1hejVneWJRSHpwU2FDU2JrYVUvOXh1VFIrQmM5dzRJOC94MWdPM2R6?=
 =?utf-8?B?QmROMGpvaDI3Q1dDNjF5NDZMcDFSb21TcUNZU256dnA0bElJb1I5eHY1ampT?=
 =?utf-8?B?TDJiMk1mU2RRTEErOFdzQXg0OTd6czJ6S0VOUGN6am5nbGNDUFZkOExvMFZm?=
 =?utf-8?B?YmRnUzhoek5Eb1Y0MGxBQnB5K01DdUZES2pocGRET1d2YzhLek9jWmE4YVJB?=
 =?utf-8?B?TURCbWtDTi96RGpyYzVPTnh6dHRhNERkSGJOSjZQWlA4M3lVaDE3Ny9jTUpX?=
 =?utf-8?B?Y2tSQUk5NzNnWEhYUmdRSjJzL1RsYURUUS9PZzRIUndvY0UyQTNHa0ZxYkJx?=
 =?utf-8?B?MkMvOTZHL0prNGhvNXNMdmZLTnIxbzZCeE5jV1JwWFdJQ083Z2NNK1pnQTdr?=
 =?utf-8?B?bWlyQWxyRmtBQWpXUlhGSHVrU3BSaEJoWnlwdE81dk5TUnQyc3pBQkt3cytn?=
 =?utf-8?B?ZHJWY2VRU3RQbkkzWVg4QXJGTWhiRERFWkcvcnIxaUw5M2UvTDFJcnVPRTEz?=
 =?utf-8?B?VjNDQ3U1RzFIZmF6ZGM2akFlNjFjYVhVTTZEd0gxYzNBc3dFNnZsTWRSKzZE?=
 =?utf-8?B?bkxuc1FkaCtuNEhoWDRESGxOazNoUDlORC92ZnIxTmpZL2FqeUV5Q0RkZHk4?=
 =?utf-8?B?QVM0OTBzSXNKVzlOdUpNYVJkR3o3N2dQM2dOSVdvQWtnYWNiMnJrTFZ6TWNL?=
 =?utf-8?B?Rm1HZzJMbWJ4d2xvcForcXI1Qko4RHhqdEdpVHlhTzdUdG1HUjBicDZvMWVq?=
 =?utf-8?B?R3lVeUY0NktNZXZhNTRjTVVCYzNtam96NXBBb0srclRyNER2eExrWUlWMDZz?=
 =?utf-8?B?RDRnWWVLTDJqc3pLTys0QW10UXpEYVFqY09CS1pUNW93ODZQRFRtYm9zNFEw?=
 =?utf-8?B?UWh4ZUpXZFFOdFlkTXZUQjZIV3p4R3FsZDFnQW1Vb2lPL1RheDlEV2trVWh5?=
 =?utf-8?B?SmxKNEMrUERaUUw1ZjVjd1lEaGxFeE4xS1E0WGUwalhOZ0tEZy82dVllRXIv?=
 =?utf-8?Q?ASUzQuzs8R7WUgIy8jQwQusNQxfq0Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFFKNGRXOXZNcWhCUjhtY1N6ZytoRnczYStzYlZMY1hndFQ3WGlxQ09vK1dp?=
 =?utf-8?B?Tms5SWlWcHQyc1prSFhXdEp3ZjdUckgxT2xBVGtnd2hMMlZSaW55Q0hhbzcw?=
 =?utf-8?B?YmpXc1FZc0pCT2JGTUxVeHhPYXowUm4rMmlsVS90ekhxYzIxd3FnVmpPOHNm?=
 =?utf-8?B?YmdXRkhVTnFxaDhYSjhhYU9SKzVUaW9uL0d5WTlKYm1nZGV6M3RCWXJuTVdt?=
 =?utf-8?B?V25ISmhGcWZBTURqMWNLdytLdmE3N0h2SVp1MHRrNzBJWXFmMWFNYmlpWVdu?=
 =?utf-8?B?QlJHNE9UWG8yL2h0aG9oWFhEeXpUUnU1TDRoVHF6dUhSYVRMYUJRWjlJVldL?=
 =?utf-8?B?dzRtcHRhUkxTUGNXVk1MNko0anAySDNjM21tYlgrZ212Tk9XMUFDaE9peUVN?=
 =?utf-8?B?aUxkLzNvbjMvNmVETVNVcTJYZlpkWEpUUG45UU1YdXlwTVNxRU1VQlV3SE1U?=
 =?utf-8?B?ZkI0MUVsdmJUakcwVnZ5a1Y4MnZVVzF2YmlrZDdTYnpGMnk0M0hpTkIyT2FM?=
 =?utf-8?B?STAwVmo3Tncra0o4SkY2M2pKQ1hVcHpsbU1BTkdabjV4TDcyWlpMaWE1QUp6?=
 =?utf-8?B?eFlFREVKZis2YzkrZ1NGZnYvNUxRTEIrdWVkWm9MOXZWTkI1MGp2eEhDYysv?=
 =?utf-8?B?VFh2d2kwR2tjalE2ZktMV2dpVmYzOHAwU0NLUEdtOC93eTVwMWxJWFo4MXBl?=
 =?utf-8?B?cU1EUXVwNTNJTnYwWmFPZlFwbjMxdmFhYVRuUWRyVzg4encvMTBsQm51Q0ZO?=
 =?utf-8?B?dyt1NHRLUTNVMnBzbzFBYUlsMFMxOTBJRGFRd0dNVWpDd2dGRXBBN2VYUG5Z?=
 =?utf-8?B?SS9iOUtac1pUWVpqUUViSGRxSUhzWXlZM3RhRTR1aU02alk3c1UzdStLbmVk?=
 =?utf-8?B?ZXJUcmFhZ2tURUNKSEFORElvQzZQTVlUQzEwek1ueVA1bUwxNDNtVlJ3aTFM?=
 =?utf-8?B?dy8vU0ZrUUk0WGoraUwvUVBDNVdoOWpUdVEzVUxEbTBEQlYvMSt0WDhjOGNH?=
 =?utf-8?B?WkZoejlzSWVaL2JjNEJKenJ1Q1pvWGtySGFhUEQ2S2ZMbkIzNWNPM3NLamVh?=
 =?utf-8?B?a2l2QjMvNGNTYXBwbjdLMFFjTkQ0eTdaajRvQnRwZlc0dzlmcFRiRjByKy9K?=
 =?utf-8?B?bllZRHB3cGxvWXlUb091Q3JRaXVZc3VWcXAwYVFROTh1eUNLbS8wSGJxTk5N?=
 =?utf-8?B?a1g3RlFmQ040em1OLzlnSGpLeFlGa3ZVaFVLcXhkNkJWOGpkdE5RdTBVWXp3?=
 =?utf-8?B?UWdHZElndzAvWURUaXBwSDFoN2E4RG5hUnRGNGRTelZtQXQyUkdEOWw2MHBJ?=
 =?utf-8?B?NHFKdGtaOXFISkUvWjluNGhvOUY0RjFsdDVDa1k0L3FhRWdMRTFzQXRvWm0v?=
 =?utf-8?B?NG1yMU5aVVNhSDQ4L2NrK0ovTnlPUUxGRzhoRlhHVGRrQzBPNjNlMlczeGE2?=
 =?utf-8?B?Zkd1MzRua2NZZkN4WGdkbFRiR09iME00QjFNckhLV1ZvZGZYWXRxTFg0UytS?=
 =?utf-8?B?SHNOaGFlQ1lScnozSDZzUWhUb0dLL01YMFFVS3R5N0poTSsvMHJzRVVCQ0ps?=
 =?utf-8?B?ZlVqRDlJZDh5MGlNNkxWeEdTdmxmZkNGYm5MQzEweEc4cjlHRE52cm13eHVR?=
 =?utf-8?B?MTFyUlpweVlJTVcxWWVyajN5blMyTGJaR1JTVEZlVWkzSURVZE9ZK2FqeUhH?=
 =?utf-8?B?bEZsNitZT3d6RzliQjhXVENDVnpkb0l1WG5kUFI4TU1MQkxKYzBQbkFRMmRK?=
 =?utf-8?B?K0NGMmRuUE12VDVYWE4ySndrVDZvUHF1N1hOMG5OUmphQ2hxaGxwQWhOUHJ3?=
 =?utf-8?B?WVFLampDdllFeHorU21naGtTWCtKSExuQzlvS1hWaDJiZlRJSXJqaitMZWFJ?=
 =?utf-8?B?UGFRb01wa05yMHppRG1qVHhDOGhwTWJrRUpnd0Vjbms0Qnh0QjdKUVl4Wml6?=
 =?utf-8?B?cEY4SW5jN3E5MzVVa3JxM2ZQdFZKbS9vbVZOZHl1dkxDcUxvNzRVNzZvTFd6?=
 =?utf-8?B?ZFNrdEVRUVd4Q1hyWWlxdW5xL29oQzA1SkRMemgxR0RSeHZHTUovTXNLcEhi?=
 =?utf-8?B?RjJINGdlR2tYWGhBbW1jNWJYeS9UMlpXd3Y1M1p1Q2pTMFFCd3A5N0tVdFZQ?=
 =?utf-8?B?WENDbWZieG0xb3ljd3JqT2NEdVJpU3J2V2FEM1JhMVRoeGJjOVEzZHBKU0FD?=
 =?utf-8?B?Snc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84928bcd-2ced-4164-d45c-08dd81756ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 08:12:26.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkfPCyUjhX36OJKyNHehhZKHNi7whXA4y5ZuS9VhgGx48jMOWiw4M6Y0WWHmV83F6u+FA34gOWzwiXQVLMGnQ8YMH7hOWqFWHXG7JJX6jzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7050
X-Authority-Analysis: v=2.4 cv=RaiQC0tv c=1 sm=1 tr=0 ts=68074f6d cx=c_pps a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=aFvlrBd0gxw3Ndf2jx8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8l7K-wvHtEAf-U7tfZFN2CgCNTqPeqe7
X-Proofpoint-ORIG-GUID: 8l7K-wvHtEAf-U7tfZFN2CgCNTqPeqe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220061

PiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlndWFyZChtdXRleCkoJnN0LT5sb2NrKTsNCj4g
PiArCWlmIChzdC0+bnVtX2xhbmVzID09IDEpDQo+ID4gKwkJcmV0ID0gcmVnbWFwX3dyaXRlKHN0
LT5yZWdtYXAsDQo+ID4gQUQ0MDgwX1JFR19BRENfREFUQV9JTlRGX0NPTkZJR19BLA0KPiA+ICsJ
CQkJwqDCoCBBRDQwODBfUkVTRVJWRURfQ09ORklHX0FfTVNLIHwNCj4gPiArCQkJCcKgwqAgQUQ0
MDgwX0lOVEZfQ0hLX0VOX01TSyk7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0ID0gcmVnbWFwX3dy
aXRlKHN0LT5yZWdtYXAsDQo+ID4gQUQ0MDgwX1JFR19BRENfREFUQV9JTlRGX0NPTkZJR19BLA0K
PiA+ICsJCQkJwqDCoCBBRDQwODBfUkVTRVJWRURfQ09ORklHX0FfTVNLIHwNCj4gPiArCQkJCcKg
wqAgQUQ0MDgwX0lOVEZfQ0hLX0VOX01TSyB8DQo+ID4gKwkJCQnCoMKgIEFENDA4MF9TUElfTFZE
U19MQU5FU19NU0spOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArCXJldCA9IGlpb19iYWNrZW5kX2RhdGFfYWxpZ25tZW50X2VuYWJsZShzdC0+YmFjayk7
DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJZG8gew0K
PiA+ICsJCXJldCA9IGlpb19iYWNrZW5kX3N5bmNfc3RhdHVzX2dldChzdC0+YmFjaywgJnN5bmNf
ZW4pOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJ
CWlmICghc3luY19lbikNCj4gPiArCQkJZGV2X2RiZygmc3QtPnNwaS0+ZGV2LCAiTm90IExvY2tl
ZDogUnVubmluZyBCaXQNCj4gPiBTbGlwXG4iKTsNCj4gPiArCX0gd2hpbGUgKC0tdGltZW91dCAm
JiAhc3luY19lbik7DQo+ID4gKw0KPiA+ICsJaWYgKHRpbWVvdXQpIHsNCj4gPiArCQlkZXZfaW5m
bygmc3QtPnNwaS0+ZGV2LCAiU3VjY2VzczogUGF0dGVybiBjb3JyZWN0IGFuZA0KPiA+IExvY2tl
ZCFcbiIpOw0KPiA+ICsJCWlmIChzdC0+bnVtX2xhbmVzID09IDEpDQo+ID4gKwkJCXJldHVybiBy
ZWdtYXBfd3JpdGUoc3QtPnJlZ21hcCwNCj4gPiBBRDQwODBfUkVHX0FEQ19EQVRBX0lOVEZfQ09O
RklHX0EsDQo+ID4gKw0KPiAJwqDCoMKgIEFENDA4MF9SRVNFUlZFRF9DT05GSUdfQV9NU0spOw0K
PiA+ICsJCWVsc2UNCj4gPiArCQkJcmV0dXJuIHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLA0KPiA+
IEFENDA4MF9SRUdfQURDX0RBVEFfSU5URl9DT05GSUdfQSwNCj4gPiArDQo+IAnCoMKgwqAgQUQ0
MDgwX1JFU0VSVkVEX0NPTkZJR19BX01TSyB8DQo+ID4gKwkJCQkJwqDCoMKgIEFENDA4MF9TUElf
TFZEU19MQU5FU19NU0spOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlkZXZfaW5mbygmc3QtPnNw
aS0+ZGV2LCAiTFZEUyBTeW5jIFRpbWVvdXQuXG4iKTsNCj4gPiArCQlpZiAoc3QtPm51bV9sYW5l
cyA9PSAxKSB7DQo+ID4gKwkJCXJldCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLA0KPiA+IEFE
NDA4MF9SRUdfQURDX0RBVEFfSU5URl9DT05GSUdfQSwNCj4gPiArDQo+IAnCoMKgIEFENDA4MF9S
RVNFUlZFRF9DT05GSUdfQV9NU0spOw0KPiA+ICsJCQlpZiAocmV0KQ0KPiA+ICsJCQkJcmV0dXJu
IHJldDsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQlyZXQgPSByZWdtYXBfd3JpdGUoc3QtPnJl
Z21hcCwNCj4gPiBBRDQwODBfUkVHX0FEQ19EQVRBX0lOVEZfQ09ORklHX0EsDQo+ID4gKw0KPiAJ
wqDCoCBBRDQwODBfUkVTRVJWRURfQ09ORklHX0FfTVNLIHwNCj4gPiArCQkJCQnCoMKgIEFENDA4
MF9TUElfTFZEU19MQU5FU19NU0spOw0KPiA+ICsJCQlpZiAocmV0KQ0KPiA+ICsJCQkJcmV0dXJu
IHJldDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXJldHVybiAtRVRJTUVET1VUOw0KPiANCj4g
U28sIGZpcnN0IHRoZSB0aGluZ3MgdGhhdCBJIGRvbid0IHJlYWxseSBnZXQgKGFsc28gdGhlIGhk
bCBkb2NzIG5lZWQgdG8gYmUNCj4gaW1wcm92ZWQgRldJVyk6DQo+IA0KPiAqIEl0IHNlZW1zIHRo
YXQgd2UgY2FuIGhhdmUgZGF0YSBhbGlnbm1lbnQgb3IgZGF0YSBjYXB0dXJlIHN5bmNocm9uaXph
dGlvbg0KPiB0aHJvdWdoIGFuIGludGVybmFsIEFNRCBGUEdBIHRlY2huaXF1ZSBjYWxsZWQgYml0
LXNsaXAgb3IgYW4gZXh0ZXJuYWwgc2lnbmFsLA0KPiByaWdodD8gSW4gaGVyZSwgaXQgc2VlbXMg
dGhhdCB3ZSBvbmx5IHVzZSBiaXQtc2xpcCBhbmQgbmV2ZXIgZGlzYWJsZSBpdC4gSXMgdGhhdA0K
PiByZWFsbHkgdGhlIGdvYWw/DQo+IA0KPiAqIFRoaXMgd2hvbGUgcHJvY2VzcyBzZWVtcyB0byBi
ZSBzb21lIGtpbmQgb2YgY2FsaWJyYXRpb24gYXQgdGhlIGludGVyZmFjZQ0KPiBsZXZlbCwgcmln
aHQ/DQo+IA0KPiAqIFdoYXQncyB0aGUgcG9pbnQgb2YgdGhlIGNvbnYgY2xvY2s/IElzIGl0IG9u
bHkgdXNlZCB0byBnZXQgdGhlIHNhbXBsZSByYXRlPyBJZg0KPiBzbywgdGhlIGhkbCBkb2NzIGFy
ZSBtaXNsZWFkaW5nIGFzIGl0IHNlZW1zIHRoYXQgaXQgY2FuIGJlIHVzZWQgaW5zdGVhZCBvZiBi
aXQtDQo+IHNsaXAgZm9yIGRhdGEgY2FwdHVyZSBhbGlnbm1lbnQ/DQo+IA0KPiBOb3csIHNwZWFr
aW5nIGFib3V0IHRoZSBiYWNrZW5kIEFQSSdzLCBpdCBsb29rcyBsaWtlIHRoYXQNCj4gaWlvX2Jh
Y2tlbmRfc2VsZl9zeW5jX2VuYWJsZSgpIGFuZCBpaW9fYmFja2VuZF9kYXRhX2FsaWdubWVudF9l
bmFibGUoKQ0KPiBjb3VsZCBiZQ0KPiBtZXJnZWQgaW50byBvbmUgQVBJLiBGcm9tIHdoYXQgSSBj
YW4gdGVsbCwNCj4gaWlvX2JhY2tlbmRfZGF0YV9hbGlnbm1lbnRfZW5hYmxlKCkNCj4ganVzdCBl
bmFibGVzIHRoZSBiaXQtc2xpcCBwcm9jZXNzIGJ1dCB0aGF0IGxpa2VseSBkb2VzIG5vdGhpbmcg
dW5sZXNzIHRoZQ0KPiBTRUxGX1NZTkMgYml0IGlzIGFsc28gc2V0IHRvIGJpdC1zbGlwLCByaWdo
dD8gSW4gZmFjdCwgd2UgY291bGQgdGhpbmsgYWJvdXQgYQ0KPiBtb3JlIGdlbmVyaWMgKGxlc3Mg
ZmxleGlibGUgdGhvdWdoKSBBUEkgbGlrZToNCj4gDQo+ICogaWlvX2JhY2tlbmRfaW50Zl9kYXRh
X2FsaWduKGJhY2ssIHRpbWVvdXRfdXMpLCBvcg0KPiAqIGlpb19iYWNrZW5kX2ludGZfY2FsaWIo
YmFjaywgdGltZW91dF91cyksIG9yDQo+ICogaWlvX2JhY2tlbmRfaW50Zl9kYXRhX2NhcHR1cmVf
c3luYyhiYWNrLCB0aW1lb3V0X3VzKQ0KPiANCj4gT24gdGhlIGJhY2tlbmQgc2lkZSwgeW91IGNv
dWxkIHRoZW4gZW5hYmxlIGJpdC1zbGlwIGFuZCBkbyB0aGUgc3RhdHVzIHJlYWQNCj4gKHdpdGgN
Cj4gdGltZW91dCkgYW5kIHJldHVybiBzdWNjZXNzIG9yIGFuIGVycm9yIGNvZGUuDQo+IA0KPiBU
aGUgYWJvdmUgc2VlbXMgdG8gYmUgcHJldHR5IG11Y2ggd2hhdCB5b3UncmUgZG9pbmcgYnV0IGlu
IGp1c3Qgb25lIEFQSSB0aGF0DQo+IG1ha2VzIHNlbnNlIHRvIG1lLg0KPiANCj4gT2YgY291cnNl
IHRoYXQgdGhlIGZvbGxvd2luZyBxdWVzdGlvbnMgc3RpbGwgY29tZSB0byBtaW5kOg0KPiANCj4g
KiBEbyB3ZSBuZWVkIHRvIGRpc2FibGUgYml0LXNsaXAgYWZ0ZXIgd2UncmUgZG9uZSAoc3RpbGwg
Zml0cyBpbnRvIHRoZSBvbmUgQVBJDQo+IG1vZGVsKT8NCj4gKiBEbyB3ZSBuZWVkIGEgbWVhbmlu
Z2Z1bCBBUEkgdG8gY2hhbmdlIGJldHdlZW4gdGhlIHN5bmNpbmcvYWxpZ25tZW50DQo+IG1ldGhv
ZHM/DQo+IEV4dGVybmFsIHNpZ25hbCB2cyBiaXQtc2xpcD8NCj4gDQo+IFRoZSBhYm92ZSBpcyBr
ZXkgdG8gYmV0dGVyIHRoaW5rIG9mIGFuIEFQSS4gUmlnaHQgbm93IGl0IGZlZWxzIHRoYXQgeW91
J3JlIGp1c3QNCj4gYWRkaW5nIGFuIEFQSSBmb3IgZXZlcnkgYml0IHlvdSB3YW50IHRvIGNvbnRy
b2wgaW4gdGhpcyBwcm9jZXNzLi4uDQo+IA0KPiBJZiB3ZSBlbmQgdXAgbmVlZGluZyBtb3JlIGZs
ZXhpYmlsaXR5IGZvciB0aGlzLCB3ZSBjYW4gYWxzbyBjb25zaWRlciB0aGUNCj4gZXhpc3Rpbmcg
aWlvX2JhY2tlbmRfZGF0YV9zYW1wbGVfdHJpZ2dlcigpIEFQSS4gSSBrbm93IGlzIGFidXNpbmcg
YSBiaXQgYW5kIGENCj4gc3RyZXRjaCBidXQgaW4gdGhlIGVuZCBvZiB0aGUgZGF5IHRoZSB3aG9s
ZSB0aGluZyBpcyByZWxhdGVkIHdpdGggYWxpZ25pbmcsDQo+IHN5bmNpbmcsIGNhbGlicmF0aW5n
IHRoZSBpbnRlcmZhY2UgZm9yIHByb3Blcmx5IHNhbXBsaW5nIGRhdGEuIEV2ZW4gYml0LXNsaXAN
Cj4gKHdoaWxlIG5vdCBhIHRyYWRpdGlvbmFsIGV4dGVybmFsIHRyaWdnZXIpIGxvb2tzIGxpa2Ug
c29tZSBraW5kIG9mIHNlbGYtDQo+IGFkanVzdGluZywgZGF0YS1kcml2ZW4gdHJpZ2dlciBtZWNo
YW5pc20gdG8gZXN0YWJsaXNoIHRoZSBjb3JyZWN0IHN0YXJ0aW5nDQo+IHBvaW50DQo+IGZvciBj
YXB0dXJpbmcgZGF0YS4gU28gaGF2aW5nIHR3byBuZXcgZW51bXMgbGlrZToNCj4gDQo+IElJT19C
QUNLRU5EX1NBTVBMRV9UUklHR0VSX0VYVF9TSUdOQUwsDQo+IElJT19CQUNLRU5EX1NBTVBMRV9U
UklHR0VSX0JJVF9TTElQIC8vIG9yIG1heWJlIGEgbW9yZSBnZW5lcmljIG5hbWUNCj4gbGlrZQ0K
PiBzL0JJVF9TTElQL0lOVEVSTkFMDQo+IA0KPiBJIGRvIG5vdCB0aGluayB0aGUgYWJvdmUgaXMg
dGhhdCBob3JyaWJsZSA6UC4uLiBCdXQgSSB3b3VsZCByZWFsbHkgbGlrZSB0byBnZXQNCj4gbW9y
ZSBvcGluaW9ucyBhYm91dCB0aGlzLg0KDQpUaGVyZSd2ZSBiZWVuIHNvbWUgdXBkYXRlIG9uIHRo
ZSBIREwgc2lkZSBjaGFuZ2luZyBhIGJpdCB0aGUgYmVoYXZpb3I6DQotIGJpdHNsaXBfZW5hYmxl
IGlzIHJlbW92ZWQsIGluc3RlYWQgdGhlIGBzeW5jYCBiaXQgaXMgdXNlZCB3aGljaCBpcyBhbHJl
YWR5IHBhcnQNCiAgb2YgdGhlIGFkYyBjb21tb24gY29yZS4NCiBTWU5DOg0KICAgICAgIFRoaXMg
Yml0IGVuYWJsZXMgY2FwdHVyZSBzeW5jaHJvbml6YXRpb24uIFdoZW4gYWN0aXZhdGVkLCBpdCBp
bml0aWF0ZXMNCiAgICAgICBhbiBIREwgcHJvY2VzcyB0aGF0IGFsaWducyB0aGUgc2FtcGxlJ3Mg
bW9zdCBzaWduaWZpY2FudCBiaXQgKE1TQikgYmFzZWQNCiAgICAgICBzb2xlbHkgb24gdGhlIGNh
cHR1cmVkIGRhdGEsIHdpdGhvdXQgY29uc2lkZXJpbmcgdGhlIEFENDA4MCdzIENOViBzaWduYWwu
DQogICAgICAgVGhpcyBiaXQgaXMgc2VsZi1jbGVhcmluZyBhbmQgc2hvdWxkIGJlIHRvZ2dsZWQg
d2hlbmV2ZXIgc3luY2hyb25pemF0aW9uDQogICAgICAgaXMgbmVlZGVkIChlLmcuLCBhdCBib290
IG9yIGFmdGVyIHVwZGF0aW5nIHRoZSBzYW1wbGluZyByYXRlKS4NCg0KVGhlIFNFTEZfU1lOQyBi
aXQgd2FzIHJlbW92ZWQuDQoNClNZTkNfU1RBVFVTIGJpdCAod2hpY2ggaXMgYWxzbyBwYXJ0IG9m
IHRoZSBjb21tb24gY29yZSkgaGFzIHRoZSBmb2xsb3dpbmcgYmVoYXZpb3I6DQogICAgICBUaGlz
IGJpdCBpbmRpY2F0ZXMgd2hldGhlciB0aGUgc2FtcGxlJ3MgTVNCIGFsaWdubWVudCBoYXMgYmVl
biBjb3JyZWN0bHkNCiAgICAgIHBlcmZvcm1lZCBhbmQgdGhlIGNhcHR1cmUgaXMgc3luY2hyb25p
emVkLiBJZiBzdWNjZXNzZnVsLCB0aGlzIGJpdCB3aWxsDQogICAgICBiZSBzZXQgdG8gMS4NCg==

