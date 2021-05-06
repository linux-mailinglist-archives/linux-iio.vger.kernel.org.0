Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E408A374EA9
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 06:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEFEqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 00:46:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:37365 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhEFEpU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 May 2021 00:45:20 -0400
IronPort-SDR: m1CuzAg28OU3tw98QXMpe6g3Y//iUI51iqcUkp7Y9ENrxcbmnHRkr0CINCRNjzGHc9rsTHPeMh
 rIfsUGJR1I5g==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="198428304"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208,223";a="198428304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 21:44:22 -0700
IronPort-SDR: K8Al2qKKncwZZatEYKU+cZ9YtcFO8Td89KFmdA0qBa9uKwWTBVFr7X9CWZedcvy+i1cm2Ja9V/
 KbNeKPmbAd7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208,223";a="434157331"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2021 21:44:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 21:44:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 21:44:21 -0700
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.2106.013;
 Wed, 5 May 2021 21:44:21 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     "jiapeng.chong@linux.alibaba.com" <jiapeng.chong@linux.alibaba.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "abaci@linux.alibaba.com" <abaci@linux.alibaba.com>
Subject: Re: [PATCH 2/2] HID: hid-sensor-custom: Process failure of
 sensor_hub_set_feature()
Thread-Topic: [PATCH 2/2] HID: hid-sensor-custom: Process failure of
 sensor_hub_set_feature()
Thread-Index: AQHXQjJ7Ab0U0kZDTUSvrj1FeMdqGQ==
Importance: high
X-Priority: 1
Date:   Thu, 6 May 2021 04:44:21 +0000
Message-ID: <7d2c6d4e918485cba09d43702a2a78ae68550ab2.camel@intel.com>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
         <20210415185232.2617398-2-srinivas.pandruvada@linux.intel.com>
         <nycvar.YFH.7.76.2105051437420.28378@cbobk.fhfr.pm>
         <CAO-hwJJM5F-1PAh62JSW+GAivMRpgjBiPT2Jvf7+vNcL=HRhGw@mail.gmail.com>
In-Reply-To: <CAO-hwJJM5F-1PAh62JSW+GAivMRpgjBiPT2Jvf7+vNcL=HRhGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
x-originating-ip: [10.22.254.132]
Content-Type: multipart/mixed;
        boundary="_002_7d2c6d4e918485cba09d43702a2a78ae68550ab2camelintelcom_"
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--_002_7d2c6d4e918485cba09d43702a2a78ae68550ab2camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BECED45DA318147AFE5A0716465458D@intel.com>
Content-Transfer-Encoding: base64

SGkgQmVuamFtaW4sDQoNCk9uIFdlZCwgMjAyMS0wNS0wNSBhdCAxNToyOCArMDIwMCwgQmVuamFt
aW4gVGlzc29pcmVzIHdyb3RlOg0KPiBPbiBXZWQsIE1heSA1LCAyMDIxIGF0IDI6MzggUE0gSmly
aSBLb3NpbmEgPGppa29zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRodSwgMTUg
QXByIDIwMjEsIFNyaW5pdmFzIFBhbmRydXZhZGEgd3JvdGU6DQo+ID4gDQo+ID4gPiBXaGVuIHVz
ZXIgbW9kaWZpZXMgYSBjdXN0b20gZmVhdHVyZSB2YWx1ZSBhbmQNCj4gPiA+IHNlbnNvcl9odWJf
c2V0X2ZlYXR1cmUoKQ0KPiA+ID4gZmFpbHMsIHJldHVybiBlcnJvci4NCj4gPiA+IA0KPiA+ID4g
UmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEgPA0KPiA+ID4gc3Jpbml2YXMucGFu
ZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IFJlcGxhY2VzIHBhdGNo
OiBISUQ6IGhpZC1zZW5zb3ItY3VzdG9tOiByZW1vdmUgdXNlbGVzcyB2YXJpYWJsZQ0KPiA+ID4g
YnkgSmlhcGVuZyBDaG9uZyA8amlhcGVuZy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4NCj4gPiA+
IA0KPiA+ID4gwqBkcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jIHwgMiArKw0KPiA+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jIGIvZHJpdmVycy9oaWQvaGlkLQ0K
PiA+ID4gc2Vuc29yLWN1c3RvbS5jDQo+ID4gPiBpbmRleCAyNjI4YmM1M2VkODAuLjU4YjU0YjEy
N2NkZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMNCj4gPiA+IEBAIC00
MDYsNiArNDA2LDggQEAgc3RhdGljIHNzaXplX3Qgc3RvcmVfdmFsdWUoc3RydWN0IGRldmljZQ0K
PiA+ID4gKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oA0KPiA+ID4gcmVwb3J0X2lkOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
ID0gc2Vuc29yX2h1Yl9zZXRfZmVhdHVyZShzZW5zb3JfaW5zdC0+aHNkZXYsDQo+ID4gPiByZXBv
cnRfaWQsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5kZXgsIHNpemVvZih2
YWx1ZSksDQo+ID4gPiAmdmFsdWUpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAocmV0KQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHJldDsNCj4gPiANCj4gPiBXaGF0IHRyZWUgaXMgdGhpcyBwYXRjaCBhZ2FpbnN0PyBJ
biBteSB0cmVlLCB3ZSdyZSBub3QgZXZlbg0KPiA+IGFzc2lnbmluZw0KPiA+IHNlbnNvcl9odWJf
c2V0X2ZlYXR1cmUoKSByZXR1cm4gdmFsdWUgdG8gYW55dGhpbmcuDQo+ID4gDQo+IA0KPiBJIGd1
ZXNzIHRoZXJlIHdhcyBhICJjb2xsaXNpb24iLiBBdCByb3VnaGx5IHRoZSBzYW1lIHRpbWUgSSBt
ZXJnZWQNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWlucHV0
L2xpc3QvP3Nlcmllcz00NTYyNjkNCj4gcGVvcGxlIHdlcmUgc3RhcnRpbmcgdG8gc2VuZCB2YXJp
b3VzIHBhdGNoZXMgZm9yIHRoZSBzYW1lIHRoaW5nLg0KPiANCj4gU3Jpbml2YXMsIGVpdGhlciB0
aGUgY2hhbmdlIGluIGZvci1uZXh0IChhbmQgcHJvYmFibHkgTGludXMnIG1hc3Rlcg0KPiBub3cp
IGlzIGZpbmUsIG9yIGNvdWxkIHlvdSByZWJhc2Ugb24gdG9wIG9mIGhpZC5naXQ/DQo+IA0KDQpS
ZWJhc2VkIGFuZCBhdHRhY2hlZCBiYXNlZCBvbiB0b3Agb2YgdGhlIGxhdGVzdCBtYWlubGluZS4N
Cg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0KDQo+IENoZWVycywNCj4gQmVuamFtaW4NCj4gDQoNCg==

--_002_7d2c6d4e918485cba09d43702a2a78ae68550ab2camelintelcom_
Content-Type: text/x-patch;
	name="0001-HID-hid-sensor-custom-Process-failure-of-sensor_hub_.patch"
Content-Description: 0001-HID-hid-sensor-custom-Process-failure-of-sensor_hub_.patch
Content-Disposition: attachment;
	filename="0001-HID-hid-sensor-custom-Process-failure-of-sensor_hub_.patch";
	size=1640; creation-date="Thu, 06 May 2021 04:44:21 GMT";
	modification-date="Thu, 06 May 2021 04:44:21 GMT"
Content-ID: <88B431456AF02043A1F4DCC5BD436051@intel.com>
Content-Transfer-Encoding: base64

RnJvbSA0NjFiODVkNTg2OWJkYzJkYTg0ZGY4YWNlZDhhMTgxNjQ3MDgyZWE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogVGh1LCAxNSBBcHIgMjAyMSAxMTo1MjozMiAtMDcw
MApTdWJqZWN0OiBbVVBEQVRFRF1bUEFUQ0ggMi8yXSBISUQ6IGhpZC1zZW5zb3ItY3VzdG9tOiBQ
cm9jZXNzIGZhaWx1cmUgb2YKIHNlbnNvcl9odWJfc2V0X2ZlYXR1cmUoKQoKV2hlbiB1c2VyIG1v
ZGlmaWVzIGEgY3VzdG9tIGZlYXR1cmUgdmFsdWUgYW5kIHNlbnNvcl9odWJfc2V0X2ZlYXR1cmUo
KQpmYWlscywgcmV0dXJuIGVycm9yLgoKUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBs
aW51eC5hbGliYWJhLmNvbT4KU2lnbmVkLW9mZi1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jp
bml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Ci0tLQpVcGRhdGVzOgoJUmViYXNlZCBv
biB0b3Agb2YgdGhlIGxhdGVzdCBtYWlubGluZQoKIGRyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3Vz
dG9tLmMgfCA4ICsrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMg
Yi9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jCmluZGV4IDJlNjY2MjE3M2E3OS4uMzJj
MjMwNmUyNDBkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jCisr
KyBiL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMKQEAgLTM4Nyw3ICszODcsNyBAQCBz
dGF0aWMgc3NpemVfdCBzdG9yZV92YWx1ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLAogCXN0cnVjdCBoaWRfc2Vuc29yX2N1c3RvbSAqc2Vuc29yX2lu
c3QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIAlpbnQgaW5kZXgsIGZpZWxkX2luZGV4LCB1c2Fn
ZTsKIAljaGFyIG5hbWVbSElEX0NVU1RPTV9OQU1FX0xFTkdUSF07Ci0JaW50IHZhbHVlOworCWlu
dCB2YWx1ZSwgcmV0OwogCiAJaWYgKHNzY2FuZihhdHRyLT5hdHRyLm5hbWUsICJmZWF0dXJlLSV4
LSV4LSVzIiwgJmluZGV4LCAmdXNhZ2UsCiAJCSAgIG5hbWUpID09IDMpIHsKQEAgLTQwMyw4ICs0
MDMsMTAgQEAgc3RhdGljIHNzaXplX3Qgc3RvcmVfdmFsdWUoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKIAogCQlyZXBvcnRfaWQgPSBzZW5zb3JfaW5z
dC0+ZmllbGRzW2ZpZWxkX2luZGV4XS5hdHRyaWJ1dGUuCiAJCQkJCQkJCXJlcG9ydF9pZDsKLQkJ
c2Vuc29yX2h1Yl9zZXRfZmVhdHVyZShzZW5zb3JfaW5zdC0+aHNkZXYsIHJlcG9ydF9pZCwKLQkJ
CQkgICAgICAgaW5kZXgsIHNpemVvZih2YWx1ZSksICZ2YWx1ZSk7CisJCXJldCA9IHNlbnNvcl9o
dWJfc2V0X2ZlYXR1cmUoc2Vuc29yX2luc3QtPmhzZGV2LCByZXBvcnRfaWQsCisJCQkJCSAgICAg
aW5kZXgsIHNpemVvZih2YWx1ZSksICZ2YWx1ZSk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0
OwogCX0gZWxzZQogCQlyZXR1cm4gLUVJTlZBTDsKIAotLSAKMi4yNy4wCgo=

--_002_7d2c6d4e918485cba09d43702a2a78ae68550ab2camelintelcom_--
