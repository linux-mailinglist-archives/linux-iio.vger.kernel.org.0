Return-Path: <linux-iio+bounces-14289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26893A0B95E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13DE3A171E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3613235C1D;
	Mon, 13 Jan 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xXXAGy/l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF85233138;
	Mon, 13 Jan 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778209; cv=none; b=SHKcAMMRsS9OjopZdOr3o4b8FOxWdfpTt9sFixUh4za0ZGaBeBa3KonnQ6BpIqfT3hmn4t6Eupntt1Se/8zxZMj2Cry+a9W5kWxFvvMw3pmn4J0WRVtPCik2di4t5WxMm2ubzp2KMYjzCVEJiE13LnT5TysPhFLKqgXUJKINx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778209; c=relaxed/simple;
	bh=Ru0oDfDto3gB8gl0YDxbwmIV9n5p6XTZzJ+kfsRcS+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOo6T8VRDT+QU2XFNPMyDr1aJrUCDwIjrti7PzJpyWLSF+K/JNDi4OVpWC1hwCMyLJLXtXARH+f8IhVjJa8gQhtUbA8TYx1PnkbOHK6d3TNT8sg41bnMb4veuPzeh6uTShR2Qpd/5dtXVq71b9igesiss+9tCPZTiZBiQoJLfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xXXAGy/l; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE5FJm031757;
	Mon, 13 Jan 2025 09:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ru0oD
	fDto3gB8gl0YDxbwmIV9n5p6XTZzJ+kfsRcS+c=; b=xXXAGy/lPxJBrnLGEvXyi
	IUnUvXuHxcOJ9RfOvwwcxqdO6OyXOjRh+pUiopBTjvtM4tcRo69wkJxdjihc4kKw
	i4HiPpIr2ucODnynAKmcDKUSS4WFyJAirebTs3peNFTWMmkcqEskaKx6NmDBoBXC
	zXcLJei9gSmNhljuiiLOCBL9QyHGvjAe9fsfPzks+BTZOjvxUDNih9luGBZaY0la
	DMiyEuhpfam6xZJ5JoSzp8OWrmTZk0BOOZzIbWMw2iHgaTAznLTjk6CNsKxTQbdK
	5nkkWwcl/nv5qIZGua2xRsrOd5ICM36kXnIIODI+r9IvYZGNQAmEG1aVtLwJ8kRo
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44549p02cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 09:22:58 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50DEMv1P064569
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jan 2025 09:22:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 13 Jan
 2025 09:22:57 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::47f5:af96:747a:164e]) by
 ASHBMBX9.ad.analog.com ([fe80::47f5:af96:747a:164e%20]) with mapi id
 15.02.0986.014; Mon, 13 Jan 2025 09:22:57 -0500
From: "Budai, Robert" <Robert.Budai@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alex Lanzano
	<lanzano.alex@gmail.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
Thread-Topic: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
Thread-Index: AQHbYzNREcgyV+0AFUmPycm4yeoemLMToEwAgAEoegD//9uWAA==
Date: Mon, 13 Jan 2025 14:22:57 +0000
Message-ID: <d9bc40ab79a24045ae9ff627ff5d302a@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
		<20250110074254.38966-5-robert.budai@analog.com>
	 <20250112154836.47feeea8@jic23-huawei>
 <7a6290b673d8d9492418365392b2554e310ef557.camel@gmail.com>
In-Reply-To: <7a6290b673d8d9492418365392b2554e310ef557.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYSEppZFdSaGFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxURmtOell5TXpJMExXUXhZVGt0TVRGbFppMWlZV1pt?=
 =?utf-8?B?TFdSak1XSmhNVGd4TVROalpWeGhiV1V0ZEdWemRGd3haRGMyTWpNeU5pMWtN?=
 =?utf-8?B?V0U1TFRFeFpXWXRZbUZtWmkxa1l6RmlZVEU0TVRFelkyVmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpFd09USXdJaUIwUFNJeE16TTRNVEkwTkRVM05UWXdOalF6TURN?=
 =?utf-8?B?aUlHZzlJbmRxY2toU2JTdEtRa1pvT0M4MVIzbHBPVlV2TW1WR2JqQm1PRDBp?=
 =?utf-8?B?SUdsa1BTSWlJR0pzUFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklW?=
 =?utf-8?B?VEZTVTFKVlJrNURaMVZCUVVSblJFRkJRWFpCZEVobWRGZFlZa0ZaT1doUlNV?=
 =?utf-8?B?WldlVzFVWjJveVJrRm5WbGhMV2s5QlJFRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGSVFVRkJRVVJoUVZGQlFWTm5TVUZCVHpSQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZGUVVGUlFVSkJRVUZCWm5CNVkxZG5RVUZCUVVGQlFVRkJR?=
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
x-dg-refone: d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: oJsTMxq2RfUB2etGxO7Cv_owvz7jjb2-
X-Proofpoint-GUID: oJsTMxq2RfUB2etGxO7Cv_owvz7jjb2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130120

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDEzLCAyMDI1IDExOjMw
IEFNDQo+IFRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgQnVkYWksIFJv
YmVydA0KPiA8Um9iZXJ0LkJ1ZGFpQGFuYWxvZy5jb20+DQo+IENjOiBTYSwgTnVubyA8TnVuby5T
YUBhbmFsb2cuY29tPjsgR3JhZGluYXJpdSwgUmFtb25hDQo+IDxSYW1vbmEuR3JhZGluYXJpdUBh
bmFsb2cuY29tPjsgTWljbGF1cywgQW50b25pdQ0KPiA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5j
b20+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IEhlbm5lcmljaCwg
TWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxy
b2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+
OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb25hdGhhbiBDb3JiZXQg
PGNvcmJldEBsd24ubmV0PjsgQWxleCBMYW56YW5vDQo+IDxsYW56YW5vLmFsZXhAZ21haWwuY29t
PjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC82XSBkdC1iaW5kaW5nczogaWlvOiBB
ZGQgYWRpczE2NTUwIGJpbmRpbmdzDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIDIw
MjUtMDEtMTIgYXQgMTU6NDggKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gT24g
RnJpLCAxMCBKYW4gMjAyNSAwOTo0Mjo1MiArMDIwMA0KPiA+IFJvYmVydCBCdWRhaSA8cm9iZXJ0
LmJ1ZGFpQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBEb2N1bWVudCB0aGUgQURJUzE2
NTUwIGRldmljZSBkZXZpY2V0cmVlIGJpbmRpbmdzLg0KPiA+ID4NCj4gPiA+IENvLWRldmVsb3Bl
ZC1ieTogQW50b25pdSBNaWNsYXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5hbG9nLmNvbT4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5j
b20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYW1vbmEgR3JhZGluYXJpdSA8cmFtb25hLmdyYWRp
bmFyaXVAYW5hbG9nLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBCdWRhaSA8cm9i
ZXJ0LmJ1ZGFpQGFuYWxvZy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+DQo+ID4gPiA0Og0KPiA+ID4g
LSBhcHBsaWVkIHN0eWxpbmcgY2hhbmdlcyB0byB0aGUgYmluZGluZ3MgZmlsZQ0KPiA+ID4gLSBy
ZXN0cmljdGVkIHN5bmMtbW9kZSB0byBpbnRlcnZhbHMgMS0yDQo+ID4gPg0KPiA+ID4gwqAuLi4v
YmluZGluZ3MvaWlvL2ltdS9hZGksYWRpczE2NTUwLnlhbWzCoMKgwqDCoMKgwqAgfCA5NiArKysr
KysrKysrKysrKysrKysrDQo+ID4gPiDCoE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysN
Cj4gPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vaW11L2FkaSxhZGlzMTY1NTAueWFtbA0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQNCj4gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9hZGksYWRpczE2NTUwLnlh
bWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRp
LGFkaXMxNjU1MC55YW1sDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5lN2NjZjM4ODNlNTUNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2FkaSxhZGlzMTY1
NTAueWFtbA0KPiA+ID4gQEAgLTAsMCArMSw5NiBAQA0KPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gPiA+ICslWUFNTCAxLjINCj4g
PiA+ICstLS0NCj4gPiA+ICskaWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vaW11L2FkaSxhZGlzDQo+IDE2NTUwLnlhbWwq
X187SXchIUEzTmk4Q1MweTJZITc0S0hhanI3aUtaUTdMZDVkZWI0THl0VkZja09fT2c4dElHDQo+
IFVrZjIzM09McmVnTTZBcXROLXYtSUJSZkFuLTRaMXRDMGJ3YmNFcE5PN0dsdjhZamlYV0kkDQo+
ID4gPiArJHNjaGVtYTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLQ0KPiBzY2hlbWFzL2NvcmUueWFtbCpfXztJdyEhQTNOaThDUzB5MlkhNzRL
SGFqcjdpS1pRN0xkNWRlYjRMeXRWRmNrT18NCj4gT2c4dElHVWtmMjMzT0xyZWdNNkFxdE4tdi1J
QlJmQW4tNFoxdEMwYndiY0VwTk83R2x2TkFWNUVSSSQNCj4gPiA+ICsNCj4gPiA+ICt0aXRsZTog
QW5hbG9nIERldmljZXMgQURJUzE2NTUwIGFuZCBzaW1pbGFyIElNVXMNCj4gPiA+ICsNCj4gPiA+
ICttYWludGFpbmVyczoNCj4gPiA+ICvCoCAtIE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4N
Cj4gPiA+ICvCoCAtIFJhbW9uYSBHcmFkaW5hcml1IDxyYW1vbmEuZ3JhZGluYXJpdUBhbmFsb2cu
Y29tPg0KPiA+ID4gK8KgIC0gQW50b25pdSBNaWNsYXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5hbG9n
LmNvbT4NCj4gPiA+ICsNCj4gPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ID4gK8KgIGNvbXBhdGlibGU6
DQo+ID4gPiArwqDCoMKgIGVudW06DQo+ID4gPiArwqDCoMKgwqDCoCAtIGFkaSxhZGlzMTY1NTAN
Cj4gPiA+ICvCoMKgwqDCoMKgIC0gYWRpLGFkaXMxNjU1MHcNCj4gPiA+ICsNCj4gPiA+ICvCoCBy
ZWc6DQo+ID4gPiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArwqAgc3BpLWNw
aGE6IHRydWUNCj4gPiA+ICsNCj4gPiA+ICvCoCBzcGktY3BvbDogdHJ1ZQ0KPiA+ID4gKw0KPiA+
ID4gK8KgIHNwaS1tYXgtZnJlcXVlbmN5Og0KPiA+ID4gK8KgwqDCoCBtYXhpbXVtOiAxNTAwMDAw
MA0KPiA+ID4gKw0KPiA+ID4gK8KgIHZkZC1zdXBwbHk6IHRydWUNCj4gPiA+ICsNCj4gPiA+ICvC
oCBpbnRlcnJ1cHRzOg0KPiA+ID4gK8KgwqDCoCBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4g
K8KgIHJlc2V0LWdwaW9zOg0KPiA+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjoNCj4gPiA+ICvCoMKg
wqDCoMKgIFJFU0VUIGFjdGl2ZSBsb3cgcGluLg0KPiA+ID4gK8KgwqDCoCBtYXhJdGVtczogMQ0K
PiA+ID4gKw0KPiA+ID4gK8KgIGNsb2NrczoNCj4gPiA+ICvCoMKgwqAgbWF4SXRlbXM6IDENCj4g
PiA+ICvCoMKgwqAgZGVzY3JpcHRpb246IElmIG5vdCBwcm92aWRlZCwgdGhlbiB0aGUgaW50ZXJu
YWwgY2xvY2sgaXMgdXNlZC4NCj4gPiA+ICsNCj4gPiA+ICvCoCBhZGksc3luYy1tb2RlOg0KPiA+
ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjoNCj4gPiA+ICvCoMKgwqDCoMKgIENvbmZpZ3VyZXMgdGhl
IGRldmljZSBTWU5DIHBpbi4gVGhlIGZvbGxvd2luZyBtb2RlcyBhcmUgc3VwcG9ydGVkDQo+ID4g
PiArwqDCoMKgwqDCoCAwIC0gb3V0cHV0X3N5bmMNCj4gPiA+ICvCoMKgwqDCoMKgIDEgLSBkaXJl
Y3Rfc3luYw0KPiA+ID4gK8KgwqDCoMKgwqAgMiAtIHNjYWxlZF9zeW5jDQo+ID4NCj4gPiBBIGxp
dHRsZSBtb3JlIG9uIHRoZXNlIHdvdWxkIGJlIGdvb2QuwqAgVGhleSBhcmUgJ3dlaXJkJyBvcHRp
b25zDQo+ID4gdGhhdCBhcmUgbm90IGNvbW1vbmx5IHNlZW4gc28gaGVscCB0aGUgcmVhZGVyIG91
dC4NCj4gPg0KPiA+IEZvciBzY2FsZWRfc3luYyBkb24ndCB3ZSBuZWVkIGluZm9ybWF0aW9uIG9u
IHRoZSBzY2FsZSBmb3IgaXQgdG8gYmUgdXNlZnVsPw0KPiA+IElmIHdlIGhhZCB0aGF0IHRoZW4g
YSB2YWx1ZSBvZiAxIHdvdWxkIG1lYW4gZGlyZWN0IHN5bmMgYW5kIHdvdWxkbid0IG5lZWQNCj4g
PiBhbm90aGVyIGNvbnRyb2wuDQo+ID4NCj4gPiBJJ20gbm90IGZ1bGx5IHVuZGVyc3RhbmRpbmcg
dGhlIHVzZWNhc2VzIGZvciB0aGlzLg0KPiA+DQo+ID4gSWYgd2UgaGF2ZSBhIHNheSBhIHB1bHNl
IHBlciBzZWNvbmQgaW5wdXQsIHRoZSBjb250cm9sIG9mIHRoZSBzY2FsZSBzaG91bGQNCj4gPiBi
ZSB1c2Vyc3BhY2UgYW55d2F5LsKgIFNvIG1heWJlIHRoaXMgbWFwcyB0byB0aGUgaW5wdXQgY2xv
Y2sgdGhhdCB3ZSBjYW4NCj4gZWxlY3QNCj4gPiB0bw0KPiA+IHVzZSBhbmQgY29udHJvbCB0aGUg
ZWZmZWN0aXZlIGZyZXF1ZW5jeSBvZiBieSB1c2luZyBzY2FsZWQgc3luYz8NCj4gDQo+IEkgZ3Vl
c3MgeW91IGxpa2VseSBhbHJlYWR5IHNhdyBpdCBpbiB0aGUgZHJpdmVyLiBUaGUgc2NhbGUgdmFs
dWUgaXMNCj4gYXV0b21hdGljYWxseSBzZXQgYnkgdGhlIGRyaXZlciBkZXBlbmRpbmcgb24gdGhl
IGRlc2lyZWQgT0RSIChzYW1wbGluZw0KPiBmcmVxdWVuY3kpLg0KPiANCj4gPg0KPiA+IEknbSBu
b3Qgc3VyZSB3aGF0IHB1bHNlIHN5bmMgaXMuIEdyZXBwaW5nIHRoZSBkYXRhc2hlZXQgZGlkbid0
IGdpdmUgbWUNCj4gPiBhbnl0aGluZyB0aGF0IHNlZW1lZCByZWxhdGVkLsKgwqAgVGhlIHN5bmMg
cGluIGlzIGlucHV0IG9ubHkgc28gSSdtIGFsc28NCj4gPiBub3Qgc3VyZSBvbiBvdXRwdXQgc3lu
Yy4NCj4gDQo+IEkgdGhpbmsgdGhpcyBpcyBhIGNvcHkgcGFzdGUgZnJvbSB0aGUgYWRpczE2NDc1
IGJpbmRpbmdzLiBGb3IgdGhpcyBkZXZpY2UsIGl0DQo+IHNlZW1zIHdlIG9ubHkgaGF2ZToNCj4g
ICogaW50ZXJuYWwgY2xvY2s7DQo+ICAqIGV4dGVybmFsOg0KPiAgICAqIGRpcmVjdCBtb2RlDQo+
ICAgICogc2NhbGVkIG1vZGUNCj4gDQo+IEJ1dCB5ZWFoLCBhcyB5b3UgcG9pbnRlZCBvdXQgSSB0
aGluayB3ZSBkbyBub3QgbmVlZCB0aGUgYmluZGluZy4gVGhlIHByZXNlbmNlDQo+IG9mDQo+IGFu
IG9wdGlvbmFsIGlucHV0IGNsb2NrIHBsdXMgdGhlIGZyZXF1ZW5jeSBzaG91bGQgYmUgYWxsIHdl
IG5lZWQgaW4gb3JkZXIgdG8gc2V0DQo+IHRoZSBkZXNpcmVkIGNvbmZpZ3VyYXRpb24uIEl0IHNo
b3VsZCBhbHNvIGJlIHBvc3NpYmxlIHRvIGFkZCB0aGUgYWxsb3dlZCByYW5nZXMNCj4gdG8gdGhl
IGV4dGVybmFsIGlucHV0IGNsb2NrIGluIHRoZSBiaW5kaW5ncy4uLg0KPiANCj4gDQo+IC0gTnVu
byBTw6ENCj4gDQpXaWxsIGRyb3AgdGhpcyBiaW5kaW5nIHRoYW4gYW5kIGFkZCBhIGZyZXF1ZW5j
eSBvbmUgdGhhdCBpcyBkZXBlbmRlbnQgb24gY2xvY2sgDQp3aXRoIHNwZWNpZmllZCByYW5nZXMu
DQoNCi0gUm9iZXJ0IEJ1ZGFpDQoNCg==

