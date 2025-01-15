Return-Path: <linux-iio+bounces-14374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B63A124E0
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 14:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6887D168753
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A5243858;
	Wed, 15 Jan 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l0FzLp5D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB0242264;
	Wed, 15 Jan 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948141; cv=none; b=nXQYiaWnXU3ke69VsbObn0cvhDn3cdTgpoK5TpPfRhMSBKJlZxEpdxU5uhwoJy5BBEzsznZvltjHkwgT1rbhZkgR4GqW0m2AOLJL8hMJIA8F358ZsGXAHE6KW9EaTVBDHfSdkkG6GolbeWGcavn8wf6TUXqNd9j6th/LJmKQyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948141; c=relaxed/simple;
	bh=CKb3gP3I6xyWDSCtbWc0xKBFHwP9Wt1604HljACdQUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FqiwnpJomRfGKsXPV5m6E8Yx9sPrzTOH+Qzh8Y0FIaNg+CrzGgJ/sHkb7VxojVwSZ/I++zL652Kgky8/u0EydXAUGg7cfxEVST+WqPr9zylkh43FL693aJHAozt/WA1syAQDKyUihZr2QTnYeeK6AER+LO7q6lpisvJG/iJ//QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l0FzLp5D; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FBCjpU023909;
	Wed, 15 Jan 2025 08:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CKb3g
	P3I6xyWDSCtbWc0xKBFHwP9Wt1604HljACdQUs=; b=l0FzLp5DiuR4pbfJ4Hx5K
	GTIbQXJi9gbhFDieowTIqLL8asBV3jOxZqDm3B/mZweM0z4s1CvPI3khRA1ZTLP8
	ke09h0ObFjVumfv0yAjHAHsoaJHCSOUqeisHPw3uA8KLs2D385ywc1z83QrHgi8G
	K2AREPEA2UbaLSUtrjLv7Bgj1g9KOVTtw34y1uu/vvq4Ij8LMK0Lw0xxSMD9j5Ez
	TCPxUILL2yBZ4A26d8EWdP9Xo1FYtKxSp+nqcRvh9Z+RrU9mlty41Ky+SzLVJ/8t
	Lz9OIl9XQ/hg+Oo5YMdhxGUQ6qbvv0jBfDkgl2iTAK2y0XUFoQFls7TCCfbrhPos
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 446bxq0jk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 08:35:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50FDZMfY046718
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jan 2025 08:35:22 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 15 Jan
 2025 08:35:22 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::47f5:af96:747a:164e]) by
 ASHBMBX9.ad.analog.com ([fe80::47f5:af96:747a:164e%20]) with mapi id
 15.02.0986.014; Wed, 15 Jan 2025 08:35:22 -0500
From: "Budai, Robert" <Robert.Budai@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
Thread-Topic: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
Thread-Index: AQHbYzNREcgyV+0AFUmPycm4yeoemLMUu+AAgAL/8lA=
Date: Wed, 15 Jan 2025 13:35:22 +0000
Message-ID: <6ba74e1ea2a44c7f9a4ea74b2dce1118@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
 <20250110074254.38966-5-robert.budai@analog.com>
 <y54kfnkbuugvsgfzufhk3mmwmmzbko47fg3jxw36sefzxaxcz6@znigvgdcljeq>
In-Reply-To: <y54kfnkbuugvsgfzufhk3mmwmmzbko47fg3jxw36sefzxaxcz6@znigvgdcljeq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYSEppZFdSaGFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxXTmpPVEJqTldKakxXUXpNelF0TVRGbFppMWlZakF5?=
 =?utf-8?B?TFdSak1XSmhNVGd4TVROalpWeGhiV1V0ZEdWemRGeGpZemt3WXpWaVpTMWtN?=
 =?utf-8?B?ek0wTFRFeFpXWXRZbUl3TWkxa1l6RmlZVEU0TVRFelkyVmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpJNU56UWlJSFE5SWpFek16Z3hOREUwTlRJd05qRTROVEl4TVNJ?=
 =?utf-8?B?Z2FEMGlVWEJqUWtsU2VrWm1kamRLWm0xR0t6aFdVSGxEVUZaRFlXUmpQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUkdkRVFVRkVOemRQSzA5UlYyWmlRVlJOVVd4UlRp?=
 =?utf-8?B?dHBlR2RXVFhoRFZrRXpOa3hIUWxWRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlUyZEpRVUZQTkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZtY0hsalYyZEJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVODBRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRMEZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVUZCUVdkQlFVRkJR?=
 =?utf-8?B?VUZCUVVGNlowRkJRVUZOUVVGQlFrOUJRVUZCUVVGQlFVRkhSVUZhUVVKd1FV?=
 =?utf-8?Q?Y4QWN3?=
x-dg-rorf: true
x-dg-refone: QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0JtQUdFQWJBQnpBR1VBWHdCbUFHOEFjd0JwQUhRQWFRQjJBR1VBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURJQUFBQT0iLz48L21ldGE+
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: FouZGSm6xAwBM4kPB8fY67oudxkgXGZb
X-Proofpoint-ORIG-GUID: FouZGSm6xAwBM4kPB8fY67oudxkgXGZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150103

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMTMsIDIwMjUg
MTA6NDQgQU0NCj4gVG86IEJ1ZGFpLCBSb2JlcnQgPFJvYmVydC5CdWRhaUBhbmFsb2cuY29tPg0K
PiBDYzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT47IEdyYWRpbmFyaXUsIFJhbW9uYQ0K
PiA8UmFtb25hLkdyYWRpbmFyaXVAYW5hbG9nLmNvbT47IE1pY2xhdXMsIEFudG9uaXUNCj4gPEFu
dG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFm
b28uZGU+Ow0KPiBIZW5uZXJpY2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5j
b20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcg
PHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2VybmVs
Lm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEpvbmF0aGFuDQo+IENv
cmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBBbGV4IExhbnphbm8gPGxhbnphbm8uYWxleEBnbWFpbC5j
b20+OyBsaW51eC0NCj4gaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWRvY0B2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA0LzZdIGR0LWJpbmRpbmdzOiBpaW86
IEFkZCBhZGlzMTY1NTAgYmluZGluZ3MNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIEZyaSwg
SmFuIDEwLCAyMDI1IGF0IDA5OjQyOjUyQU0gKzAyMDAsIFJvYmVydCBCdWRhaSB3cm90ZToNCj4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+
ID4gKyAgLSBSYW1vbmEgR3JhZGluYXJpdSA8cmFtb25hLmdyYWRpbmFyaXVAYW5hbG9nLmNvbT4N
Cj4gPiArICAtIEFudG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVt
Og0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTY1NTANCj4gPiArICAgICAgLSBhZGksYWRpczE2NTUw
dw0KPiANCj4gV2hlcmUgaXMgdGhlIGFuc3dlciBmb3IgbXkgcXVlc3Rpb25zIGF0IHYxPyBObyBy
ZXNwb25zZXMgb24gZW1haWwsDQo+IG5vdGhpbmcgaW1wcm92ZWQgaW4gdGhlIHBhdGNoc2V0LiBH
byBiYWNrIHRvIG15IGNvbW1lbnRzIGFuZCByZXNwb25kIHRvDQo+IHRoZW0gb3IgaW1wbGVtZW50
IHRoZW0uDQo+IA0KW1JvYmVydCBCdWRhaQ==

