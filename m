Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1742B4BA6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 17:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgKPQuB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 11:50:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22742 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730741AbgKPQuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Nov 2020 11:50:01 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AGGkgAp023614;
        Mon, 16 Nov 2020 17:49:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 mime-version; s=STMicroelectronics;
 bh=rYRJZ49QcAZwB4o2MqZDUumC64EEBv4BZDOzMB69Xsk=;
 b=gK8NrsOfviYydH1bfQhBNibHjF4QpDAtBtGWDDA4l1aev2m76DnfGRsDCa59ibWs+DYm
 dvEtmMkhFP2pVbCtjx0rvO4s+y+PG/FPVFmW5FQyWh6ortanXmD1ELmdDHZFUOgsqsTC
 xMEG0dqhp9ItXfHrnkNmehZnLUU9Hg4tWdZOvSqfFAr1ulwiguh8ZYzPi3Iau/0ly+1r
 +IWYBHCdf0+6tR9JJPifx5kvQjplchqJAX6HRjoEiegTtuTEPufJ4+ekQxaA/yALL0ua
 ynzI+FfCQcGH13J0HZw1HfFue9g8FShqIC9xut/B3B3EhzD4i0KLDsnQlbsoE5V4qFSC +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t58cccvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 17:49:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 45F67100038;
        Mon, 16 Nov 2020 17:49:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2F2C022AD85;
        Mon, 16 Nov 2020 17:49:37 +0100 (CET)
Received: from SFHDAG2NODE2.st.com (10.75.127.5) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 17:49:36 +0100
Received: from SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b]) by
 SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b%20]) with mapi id
 15.00.1473.003; Mon, 16 Nov 2020 17:49:36 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>
Subject: Re: [RFC PATCH 0/1] Sanity check buffer callback
Thread-Topic: [RFC PATCH 0/1] Sanity check buffer callback
Thread-Index: AQHWuqPie8q4juzwKUC+UM6PovKBwKnK6uKA
Date:   Mon, 16 Nov 2020 16:49:36 +0000
Message-ID: <c5ab447f-e7d2-c406-b392-ca8bacd94052@st.com>
References: <20201112151334.32167-1-nuno.sa@analog.com>
 <20201114163321.53881139@archlinux>
In-Reply-To: <20201114163321.53881139@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: multipart/mixed;
        boundary="_002_c5ab447fe7d2c406b392ca8bacd94052stcom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_08:2020-11-13,2020-11-16 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--_002_c5ab447fe7d2c406b392ca8bacd94052stcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <98E537853D595E44BDE5C5ED53624DF0@st.com>
Content-Transfer-Encoding: base64

T24gMTEvMTQvMjAgNTozMyBQTSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVGh1LCAx
MiBOb3YgMjAyMCAxNjoxMzozMyArMDEwMA0KPiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29t
PiB3cm90ZToNCj4gDQo+PiBXaGVuIGdvaW5nIHRocm91Z2ggdGhlIGNvZGUgb2YgdGhlIGJ1ZmZl
ci1jYiBpbnRlcmZhY2UgYW5kIGFsbCBpdCdzDQo+PiB1c2VycywgSSByZWFsaXplZCB0aGF0IHRo
ZSBzdG0zMl9hZGZzZG0gZHJpdmVyIGlzIGNhbGxpbmcNCj4+IGBpaW9fY2hhbm5lbF9nZXRfYWxs
X2NiKClgIHdpdGggTlVMTCBmb3IgdGhlIGNiLiBBZnRlciBnb2luZyBhIGJpdA0KPj4gdHJvdWdo
IHRoZSBzdG0gZHJpdmVycywgaXQgbG9va3MgbGlrZSB0aGlzIGlzIGFjdHVhbGx5IGludGVudGlv
bmFsLg0KPj4gSG93ZXZlciwgaXQgaXMgY2xlYXIgdGhhdCB3ZSBoYXZlIGEgY2xlYXIvZGlyZWN0
IHJvdXRlIGhlcmUgZm9yIGEgTlVMTA0KPj4gcG9pbnRlciBkZXJlZmVyZW5jZS4gSSdtIGJlaW5n
IGxhenkgaW4gdGhpcyBSRkMgYW5kIGp1c3QgZG9pbmcgYQ0KPj4gc2FuaXR5IGNoZWNrIGluIHRo
ZSBgaWlvX2J1ZmZlcl9jYl9zdG9yZV90bygpYCBzbyB0aGF0IHdlIGRvbid0IGhhdmUgdG8NCj4+
IGNoYW5nZSB0aGUgc3RtIGRyaXZlci4uLiBUaGUgcG9pbnQgaXMganVzdCB0byBicmluZyB0aGlz
IHVwIGFuZCBzZWUgaWYNCj4+IHdlIHdhbnQgdG8gZG8gc29tZXRoaW5nIGFib3V0IHRoaXMuDQo+
Pg0KPj4gVG8gYmUgY2xlYXIsIHRoZSB3YXkgSSB0aGluayB0aGlzIHNob3VsZCBnbyBpcyBqdXN0
IHRvIHJldHVybiAtRUlOVkFMIGluDQo+PiBgaWlvX2NoYW5uZWxfZ2V0X2FsbF9jYigpYCBpZiBh
IE5VTEwgcHRyIGlzIHBhc3NlZC4gV2hhdHMgdGhlIHBvaW50IG9mIGENCj4+IGJ1ZmZlci1jYiBp
ZiBjYiBpcyBOVUxMLCByaWdodD8gVGhpcyB3b3VsZCBuYXR1cmFsbHkgYnJlYWsgdGhlIHN0bQ0K
Pj4gZHJpdmVyLCBidXQgSSBndWVzcyB3ZSBjb3VsZCBqdXN0IGRlZmluZSBhIGR1bW15IGhhbmRs
ZXIgdGhlcmUgdGhhdA0KPj4gd291bGQgbm90IGJlIHVzZWQgKG9yIGNvdWxkIHRoZSBIVyBjb25z
dW1lciBiZSBhbiBvcHRpb24gaGVyZT8pLi4uDQo+Pg0KPj4gVGhvdWdodHM/DQo+IA0KPiBHb29k
IGRlc2NyaXB0aW9uIHRoYW5rcy4gIEkgdGhpbmsgeW91IGFyZSByaWdodCBhbmQgYmV0dGVyIG9w
dGlvbiBpcw0KPiB0byByZXR1cm4gLUVJTlZBTCBpbiBpaW9fY2hhbm5lbF9nZXRfYWxsX2NiKCkg
YW5kIGFkZCBhIGR1bW15ICBoYW5kbGVyIHRvIHRoZQ0KPiBzdG0gZHJpdmVyLg0KPiANCj4gY2Mg
QXJuYXVkIGFuZCBPbGl2aWVyIHRvIHNlZSBpZiB0aGV5IGFyZSBmaW5lIHdpdGggdGhlIGR1bW15
IGhhbmRsZXIuDQo+ICh3aXRoIGFwcHJvcHJpYXRlIGNvbW1lbnQgb24gd2h5IGl0IGlzIHRoZXJl
KS4NCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiANCg0KSGkgSm9uYXRoYW4sDQoNClRoYW5rcyBmb3Ig
eW91ciBub3RpY2UuIEFybmF1ZCBhbmQgbXlzZWxmIGFncmVlIHdpdGggdGhpcyBzb2x1dGlvbi4N
CkkgYXR0YWNoIHRvIHRoaXMgbWFpbCBhIHBhdGNoIHdoaWNoIGltcGxlbWVudHMgdGhpcyBkdW1t
eSBoYW5kbGVyDQphbmQgY2FuIGJlIGFkZGVkIHRvIE51bm8ncyBwYXRjaHNldCwgdG8gYXZvaWQg
YSByZWdyZXNzaW9uIG9uIHN0bSBkcml2ZXIuDQoNClJlZ2FyZHMsDQpPbGl2aWVyDQoNCj4+DQo+
PiBOdW5vIFPDoSAoMSk6DQo+PiAgICBpaW86IGJ1ZmZlcjogU2FuaXR5IGNoZWNrIGJ1ZmZlciBj
YWxsYmFjaw0KPj4NCj4+ICAgZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJpYWxpby1idWZmZXIt
Y2IuYyB8IDQgKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0K
PiANCg==

--_002_c5ab447fe7d2c406b392ca8bacd94052stcom_
Content-Type: text/x-patch;
	name="0001-ASoC-stm32-dfsdm-add-stm32_adfsdm_dummy_cb-callback.patch"
Content-Description: 0001-ASoC-stm32-dfsdm-add-stm32_adfsdm_dummy_cb-callback.patch
Content-Disposition: attachment;
	filename="0001-ASoC-stm32-dfsdm-add-stm32_adfsdm_dummy_cb-callback.patch";
	size=1787; creation-date="Mon, 16 Nov 2020 16:49:36 GMT";
	modification-date="Mon, 16 Nov 2020 16:49:36 GMT"
Content-ID: <5220260991B77B479FDD20E6CAA0F0C6@st.com>
Content-Transfer-Encoding: base64

RnJvbSA5OGQzMDA4YmIyY2RlZTc1YjJlZmI0MmE3ZDNhNWFmOWJlZDQ3ZTljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogT2xpdmllciBNb3lzYW4gPG9saXZpZXIubW95c2FuQHN0LmNv
bT4NCkRhdGU6IE1vbiwgMTYgTm92IDIwMjAgMTc6MjM6NDMgKzAxMDANClN1YmplY3Q6IFtQQVRD
SF0gQVNvQzogc3RtMzI6IGRmc2RtOiBhZGQgc3RtMzJfYWRmc2RtX2R1bW15X2NiKCkgY2FsbGJh
Y2sNCg0KQWRhcHQgU1RNMzIgREZTRE0gZHJpdmVyIHRvIGEgY2hhbmdlIGluIGlpb19jaGFubmVs
X2dldF9hbGxfY2IoKSBBUEkuDQpUaGUgY2FsbGJhY2sgcG9pbnRlciBiZWNvbWVzIGEgcmVxdWVz
dGVkIHBhcmFtZXRlciBvZiB0aGlzIEFQSSwNCnNvIGFkZCBhIGR1bW15IGNhbGxiYWNrIHRvIGJl
IGdpdmVuIGFzIHBhcmFtZXRlciBvZiB0aGlzIGZ1bmN0aW9uLg0KSG93ZXZlciwgdGhlIHN0bTMy
X2Rmc2RtX2dldF9idWZmX2NiKCkgQVBJIGlzIHN0aWxsIHVzZWQgaW5zdGVhZCwNCnRvIG9wdGlt
aXplIERNQSB0cmFuc2ZlcnMuDQoNClNpZ25lZC1vZmYtYnk6IE9saXZpZXIgTW95c2FuIDxvbGl2
aWVyLm1veXNhbkBzdC5jb20+DQotLS0NCiBzb3VuZC9zb2Mvc3RtL3N0bTMyX2FkZnNkbS5jIHwg
MTIgKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zdG0vc3RtMzJfYWRmc2RtLmMgYi9z
b3VuZC9zb2Mvc3RtL3N0bTMyX2FkZnNkbS5jDQppbmRleCBjNDAzMTk4OGY5ODEuLjQ3ZmFlOGRk
MjBiNCAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9zdG0vc3RtMzJfYWRmc2RtLmMNCisrKyBiL3Nv
dW5kL3NvYy9zdG0vc3RtMzJfYWRmc2RtLmMNCkBAIC0yOTMsNiArMjkzLDE2IEBAIHN0YXRpYyBp
bnQgc3RtMzJfYWRmc2RtX3BjbV9uZXcoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25l
bnQsDQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0aWMgaW50IHN0bTMyX2FkZnNkbV9kdW1teV9j
Yihjb25zdCB2b2lkICpkYXRhLCB2b2lkICpwcml2YXRlKQ0KK3sNCisJLyoNCisJICogVGhpcyBk
dW1tbXkgY2FsbGJhY2sgaXMgcmVxdWVzdGVkIGJ5IGlpb19jaGFubmVsX2dldF9hbGxfY2IoKSBB
UEksDQorCSAqIGJ1dCB0aGUgc3RtMzJfZGZzZG1fZ2V0X2J1ZmZfY2IoKSBBUEkgaXMgdXNlZCBp
bnN0ZWFkLCB0byBvcHRpbWl6ZQ0KKwkgKiBETUEgdHJhbnNmZXJzLg0KKwkgKi8NCisJcmV0dXJu
IDA7DQorfQ0KKw0KIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnRfZHJpdmVyIHN0bTMy
X2FkZnNkbV9zb2NfcGxhdGZvcm0gPSB7DQogCS5vcGVuCQk9IHN0bTMyX2FkZnNkbV9wY21fb3Bl
biwNCiAJLmNsb3NlCQk9IHN0bTMyX2FkZnNkbV9wY21fY2xvc2UsDQpAQCAtMzM1LDcgKzM0NSw3
IEBAIHN0YXRpYyBpbnQgc3RtMzJfYWRmc2RtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogCWlmIChJU19FUlIocHJpdi0+aWlvX2NoKSkNCiAJCXJldHVybiBQVFJfRVJSKHBy
aXYtPmlpb19jaCk7DQogDQotCXByaXYtPmlpb19jYiA9IGlpb19jaGFubmVsX2dldF9hbGxfY2Io
JnBkZXYtPmRldiwgTlVMTCwgTlVMTCk7DQorCXByaXYtPmlpb19jYiA9IGlpb19jaGFubmVsX2dl
dF9hbGxfY2IoJnBkZXYtPmRldiwgJnN0bTMyX2FkZnNkbV9kdW1teV9jYiwgTlVMTCk7DQogCWlm
IChJU19FUlIocHJpdi0+aWlvX2NiKSkNCiAJCXJldHVybiBQVFJfRVJSKHByaXYtPmlpb19jYik7
DQogDQotLSANCjIuMTcuMQ0KDQo=

--_002_c5ab447fe7d2c406b392ca8bacd94052stcom_--
