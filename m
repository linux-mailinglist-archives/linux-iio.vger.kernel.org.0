Return-Path: <linux-iio+bounces-15855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5EA3DB8D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0863719C25D4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3361F9A90;
	Thu, 20 Feb 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Z9a1EfA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750501F76C0;
	Thu, 20 Feb 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059005; cv=none; b=kmxms1c1Y9+/L8x3x6IpnD0bLxAMeqVEM1T1+9FLcRMmfkgKGU3I+OyL5G67li6AstR0XJ7sxsa8IUIXLrVqCkmsqJWpt9RyN47Bo7yGTelo2PVBuJ6K8QBuoso+MGi9ddLrLx/Iu78CuEu7doSpkKNQ+sEKZD8F0jrHB7MonLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059005; c=relaxed/simple;
	bh=D2FcBDeuGwHsiFlE5LsVOdNR9u94mmxTJwaL5dNzU5k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paF6lo+cXo3bgyda5UIwFNyqKpIIzT+pMJZN4wxm4LwGMZoHTjY0HvqH3uu6u8g9Som13whXhfOFlG4cIFgJfPFvF4idG7sDbbEkboHia7F+eg4tMrVIoOxaf3t0VNC0eVocKUnXNUNOsumBFa78zCLwGZldt0wNdaMqaBO2H1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Z9a1EfA0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBLvUC023645;
	Thu, 20 Feb 2025 08:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D2FcB
	DeuGwHsiFlE5LsVOdNR9u94mmxTJwaL5dNzU5k=; b=Z9a1EfA0X/b9e7/b6aGNr
	TT4NbnRtRhX57eUOBU0QQJrPD0g2H6KwCgPx8RHNoDvKauZIZPJY9I8ApCpueO/U
	d7TaiC5ONlsWe1CH6uFvPhOcy1TMDYtqFKtO08xt/Qs9Rj2RdQrehgWnTvF43rj1
	izk5RiGT5XX7FQSZxGGnLRVLBW7nlSKCFPinZB2HntGEO5AY5U4fKiUe3Lh2+bWH
	t6dcxvn6N3VOSKy9Dw7UaQpnVRaVLZ7bss7tNnpeyZONEQ/mW6FeytGZsSVlNW2D
	FgvsnFPt8HRvawsRoj32Ojbmy64gAcKytru0GvlnueaMx066w+eTEgSr9PT4WBRK
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44x3f40fq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:43:06 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51KDh5VN043954
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:43:05 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:43:04 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::1cb6:4851:5392:54cf]) by
 ASHBMBX9.ad.analog.com ([fe80::1cb6:4851:5392:54cf%20]) with mapi id
 15.02.0986.014; Thu, 20 Feb 2025 08:43:04 -0500
From: "Budai, Robert" <Robert.Budai@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [RESEND PATCH v8 5/6] iio: imu: adis16550: add adis16550 support
Thread-Topic: [RESEND PATCH v8 5/6] iio: imu: adis16550: add adis16550 support
Thread-Index: AQHbgTvPfw471rqSUk6RU/zKwUC+57NQMlsAgAADUNA=
Date: Thu, 20 Feb 2025 13:43:04 +0000
Message-ID: <45d64de8a1074788b7c4bffc29788742@analog.com>
References: <20250217105753.605465-1-robert.budai@analog.com>
	 <20250217105753.605465-6-robert.budai@analog.com>
 <aee93ef96e71adf70a48ee5877bd75966d9c78c1.camel@gmail.com>
In-Reply-To: <aee93ef96e71adf70a48ee5877bd75966d9c78c1.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 403pa-rlJEkUba881PoH13AW3JLeP6Bj
X-Proofpoint-GUID: 403pa-rlJEkUba881PoH13AW3JLeP6Bj
X-Authority-Analysis: v=2.4 cv=DuKs+H/+ c=1 sm=1 tr=0 ts=67b7316a cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=xqWC_Br6kY4A:10 a=ejxIebdwriEA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=uherdBYGAAAA:8 a=P-IC7800AAAA:8
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=07d9gI8wAAAA:8 a=0fo_jfcGDxs3koMwgKEA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=oVHKYsEdi7-vN-J5QA_j:22 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200099

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDIwLCAyMDI1IDEw
OjIyIEFNDQo+IFRvOiBCdWRhaSwgUm9iZXJ0IDxSb2JlcnQuQnVkYWlAYW5hbG9nLmNvbT47IExh
cnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVs
IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsNCj4gU2EsIE51bm8gPE51bm8uU2FAYW5h
bG9nLmNvbT47IEdyYWRpbmFyaXUsIFJhbW9uYQ0KPiA8UmFtb25hLkdyYWRpbmFyaXVAYW5hbG9n
LmNvbT47IE1pY2xhdXMsIEFudG9uaXUNCj4gPEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPjsg
Sm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IFJvYg0KPiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBD
b25vcg0KPiBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb25hdGhhbiBDb3JiZXQgPGNv
cmJldEBsd24ubmV0PjsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1k
b2NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5EIFBBVENIIHY4IDUvNl0g
aWlvOiBpbXU6IGFkaXMxNjU1MDogYWRkIGFkaXMxNjU1MA0KPiBzdXBwb3J0DQo+IA0KPiBbRXh0
ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDIwMjUtMDItMTcgYXQgMTI6NTcgKzAyMDAsIFJvYmVydCBC
dWRhaSB3cm90ZToNCj4gPiBUaGUgQURJUzE2NTUwIGlzIGEgY29tcGxldGUgaW5lcnRpYWwgc3lz
dGVtIHRoYXQgaW5jbHVkZXMgYSB0cmlheGlzDQo+ID4gZ3lyb3Njb3BlIGFuZCBhIHRyaWF4aXMg
YWNjZWxlcm9tZXRlci4gRWFjaCBpbmVydGlhbCBzZW5zb3IgaW4gdGhlDQo+ID4gQURJUzE2NTUw
IGNvbWJpbmVzIGluZHVzdHJ5IGxlYWRpbmcgTUVNUyBvbmx5IHRlY2hub2xvZ3kgd2l0aCBzaWdu
YWwNCj4gPiBjb25kaXRpb25pbmcgdGhhdCBvcHRpbWl6ZXMgZHluYW1pYyBwZXJmb3JtYW5jZS4g
VGhlIGZhY3RvcnkgY2FsaWJyYXRpb24NCj4gPiBjaGFyYWN0ZXJpemVzIGVhY2ggc2Vuc29yIGZv
ciBzZW5zaXRpdml0eSwgYmlhcywgYW5kIGFsaWdubWVudC4gQXMgYQ0KPiA+IHJlc3VsdCwgZWFj
aCBzZW5zb3IgaGFzIGl0cyBvd24gZHluYW1pYyBjb21wZW5zYXRpb24gZm9ybXVsYXMgdGhhdA0K
PiA+IHByb3ZpZGUgYWNjdXJhdGUgc2Vuc29yIG1lYXN1cmVtZW50cy4NCj4gPg0KPiA+IENvLWRl
dmVsb3BlZC1ieTogUmFtb25hIEdyYWRpbmFyaXUgPHJhbW9uYS5ncmFkaW5hcml1QGFuYWxvZy5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFtb25hIEdyYWRpbmFyaXUgPHJhbW9uYS5ncmFkaW5h
cml1QGFuYWxvZy5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBBbnRvbml1IE1pY2xhdXMgPGFu
dG9uaXUubWljbGF1c0BhbmFsb2cuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWlj
bGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTnVu
byBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgQnVk
YWkgPHJvYmVydC5idWRhaUBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+DQo+IA0KPiBJIGd1ZXNz
IGl0IHdvdWxkIG1ha2Ugc2Vuc2UgYSBDby1kZXZlbG9wZWQtYnk6IGZvciBSb2JlcnQ/DQo+IA0K
PiBBbnl3YXlzLCBhbGwgbG9va3MgZ29vZCBleGNlcHQgZm9yIG9uZSB0aGluZyB0aGF0IEkganVz
dCBzcG90dGVkLi4uDQo+IA0KPiA+IHY4Og0KPiA+IC0gcmVtb3ZlZCBfX2FsaWduZWQgZnJvbSBz
dHJ1Y3QgYWRpczE2NTUwLCBhcyBzdWdnZXN0ZWQNCj4gPiAtIGNyYyBidWZmZXIgZXh0cmFjdGlv
biBpbnRvIHRoZSBjcmMgY2hlY2sgZnVuY3Rpb24NCj4gPiAtIHBhc3NlZCBidWZmZXIgaW50byBj
cmMgdmFsaWRhdGlvbiBhcyBvcmlnaW5hbCwgX19iZTMyIGFuZCBwZXJmb3JtZWQgY2hlY2sNCj4g
PiB1c2luZyBiZTMyX3RvX2NwdSBjb252ZXJzaW9uIG9mIHRoZSBidWZmZXINCj4gPiAtIGFkZGVk
IHRyYWlsaW5nIGNvbW1hIHRvIGxpbmUgOTkzDQo+ID4gLSByZW1vdmVkIHRyYWlsaW5nIGNvbW1h
IGZyb20gbGluZSA4NzcNCj4gPg0KPiA+IMKgZHJpdmVycy9paW8vaW11L0tjb25maWfCoMKgwqDC
oCB8wqDCoCAxMyArDQo+ID4gwqBkcml2ZXJzL2lpby9pbXUvTWFrZWZpbGXCoMKgwqAgfMKgwqDC
oCAxICsNCj4gPiDCoGRyaXZlcnMvaWlvL2ltdS9hZGlzMTY1NTAuYyB8IDExNDkNCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTE2
MyBpbnNlcnRpb25zKCspDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9paW8vaW11
L2FkaXMxNjU1MC5jDQo+ID4NCj4gDQo+IC4uLg0KPiANCj4gPg0KPiA+ICtzdGF0aWMgaW50IGFk
aXMxNjU1MF9zZXRfZnJlcV9oeihzdHJ1Y3QgYWRpczE2NTUwICpzdCwgdTMyIGZyZXFfaHopDQo+
ID4gK3sNCj4gPiArCXUxNiBkZWM7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJdTMyIHNhbXBsZV9y
YXRlID0gc3QtPmNsa19mcmVxX2h6Ow0KPiA+ICsJLyoNCj4gPiArCSAqIFRoZSBvcHRpbWFsIHNh
bXBsZSByYXRlIGZvciB0aGUgc3VwcG9ydGVkIElNVXMgaXMgYmV0d2Vlbg0KPiA+ICsJICogaW50
X2NsayAtIDEwMDAgYW5kIGludF9jbGsgKyA1MDAuDQo+ID4gKwkgKi8NCj4gPiArCXUzMiBtYXhf
c2FtcGxlX3JhdGUgPSBzdC0+aW5mby0+aW50X2NsayAqIDEwMDAgKyA1MDAwMDA7DQo+ID4gKwl1
MzIgbWluX3NhbXBsZV9yYXRlID0gc3QtPmluZm8tPmludF9jbGsgKiAxMDAwIC0gMTAwMDAwMDsN
Cj4gPiArDQo+ID4gKwlpZiAoIWZyZXFfaHopDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4g
Kw0KPiA+ICsJYWRpc19kZXZfYXV0b19sb2NrKCZzdC0+YWRpcyk7DQo+ID4gKw0KPiA+ICsJaWYg
KHN0LT5zeW5jX21vZGUgPT0gQURJUzE2NTUwX1NZTkNfTU9ERV9TQ0FMRUQpIHsNCj4gPiArCQl1
bnNpZ25lZCBsb25nIHNjYWxlZF9yYXRlID0gbGNtKHN0LT5jbGtfZnJlcV9oeiwgZnJlcV9oeik7
DQo+ID4gKwkJaW50IHN5bmNfc2NhbGU7DQo+ID4gKw0KPiA+ICsJCWlmIChzY2FsZWRfcmF0ZSA+
IG1heF9zYW1wbGVfcmF0ZSkNCj4gPiArCQkJc2NhbGVkX3JhdGUgPSBtYXhfc2FtcGxlX3JhdGUg
LyBzdC0+Y2xrX2ZyZXFfaHogKiBzdC0NCj4gPiA+Y2xrX2ZyZXFfaHo7DQo+ID4gKwkJZWxzZQ0K
PiA+ICsJCQlzY2FsZWRfcmF0ZSA9IG1heF9zYW1wbGVfcmF0ZSAvIHNjYWxlZF9yYXRlICoNCj4g
PiBzY2FsZWRfcmF0ZTsNCj4gPiArDQo+ID4gKwkJaWYgKHNjYWxlZF9yYXRlIDwgbWluX3NhbXBs
ZV9yYXRlKQ0KPiA+ICsJCQlzY2FsZWRfcmF0ZSA9IHJvdW5kdXAobWluX3NhbXBsZV9yYXRlLCBz
dC0NCj4gPiA+Y2xrX2ZyZXFfaHopOw0KPiA+ICsNCj4gDQo+IEkgd291bGQgaW1hZ2luZSB0aGUg
YWJvdmUgaXMgdGhlIHNhbWUgZGVhbCBhcyBpbiBvdGhlciBkZXZpY2VzIFsxXSBvciBkbyB5b3UN
Cj4ga25vdyBmb3IgYSBmYWN0IHRoaXMgb25lIGlzIGRpZmZlcmVudD8gTWF5YmUgaXQncyBzaW1w
bGUgZW5vdWdoIGZvciBKb25hdGhhbiB0bw0KPiB0d2VhayB3aGlsZSBhcHBseWluZy4uLg0KPiAN
Cj4gWzFdOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjYuMTMuMy9zb3VyY2UNCj4gL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0
NzUuYypMMzY0X187SXchIUEzTmk4Q1MweTJZITdZNzF5UGFRQXhWek5SZA0KPiBPX2pUN3dFejRr
LQ0KPiBzNno0dEpIT2NFUzg0SFlrcThxTkdzZ0pIN3p4d2pmUE5qTEYzT0VHVkluU29sbzFlbm5M
VV9td3BtRWJvJA0KPiANCj4gLSBOdW5vIFPDoQ0KDQpbUm9iZXJ0IEJ1ZGFpXSANCk5vIGRpZmZl
cmVuY2VzIHdlcmUgZm91bmQgaW4gdGhlIHNjYWxlZF9zeW5jIGJlaGF2aW9yIG9mIHRoZSBBRElT
MTY0NzUgYW5kDQpBRElTMTY1NTAuIEl0IGlzIHNhZmUgdG8gYWRkIGZyb20gbXkgc2lkZS4NCg0K
QmVzdCByZWdhcmRzLA0KUm9iZXJ0IEINCg==

