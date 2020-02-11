Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAC159302
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 16:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgBKPWh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 10:22:37 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36652 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730353AbgBKPWg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 10:22:36 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BFESwq030309;
        Tue, 11 Feb 2020 16:22:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=8FH4GMVMTuncapNMvYvyQMea4jBp3XjADEQ2jECszFU=;
 b=ScAg1fvLVaFAAZXimfYb21JBP1d4QQQj1s0uks6rBNnzfQLuHQXsUNtylpyjkgcUYJVn
 Njozwi8ONYzJLKyL6RX2VwsabBjM0dLcKHN4yDkcU/wFf8tQAO0QZiQ6HZJyvG068lDh
 EyUzGDrvKSYPJqdsdJup1blUtb2C+ISMFrgKwXAKsFs1NqakT6y9w4AJU4NXLVLpBH1v
 Ly/dg27xrTNb4rlIa+asVVTsMWHm5rYf4ICihUnXU8+PoomtKJypfKrJfXpVSOPA4uUa
 fErCgGiQUud1hIk1p/LpbfohBl6F+a8/6MTLbcUQneLQF2NVlKMlLYKZpVRTG744wVFo ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufh6cdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 16:22:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAF28100034;
        Tue, 11 Feb 2020 16:22:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A50532BEC61;
        Tue, 11 Feb 2020 16:22:10 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 11 Feb
 2020 16:22:10 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 11 Feb 2020 16:22:10 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] iio: adc: sd modulator: add scale support
Thread-Topic: [PATCH 2/4] iio: adc: sd modulator: add scale support
Thread-Index: AQHV3plRO+Mdv2KS6Eiey+LjbbRUC6gWEBeA
Date:   Tue, 11 Feb 2020 15:22:10 +0000
Message-ID: <740eb007-3428-f336-fbe5-3713faaa6f4c@st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
 <20200204101008.11411-3-olivier.moysan@st.com>
 <20200208160327.334da020@archlinux>
In-Reply-To: <20200208160327.334da020@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FAC793B44188043905F2B2F239FEEA3@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_04:2020-02-10,2020-02-11 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCk9uIDIvOC8yMCA1OjAzIFBNLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDQgRmViIDIwMjAgMTE6MTA6MDYgKzAxMDANCj4gT2xpdmllciBNb3lzYW4g
PG9saXZpZXIubW95c2FuQHN0LmNvbT4gd3JvdGU6DQo+DQo+PiBBZGQgc2NhbGUgc3VwcG9ydCB0
byBzaWdtYSBkZWx0YSBtb2R1bGF0b3IuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogT2xpdmllciBN
b3lzYW4gPG9saXZpZXIubW95c2FuQHN0LmNvbT4NCj4gSSBub3RlIGJlbG93IHRoYXQgdGhlcmUg
YXJlIHByb2JhYmx5IHNvbWUgY29tcGxleGl0aWVzIGFyb3VuZA0KPiB3aGV0aGVyIHZyZWYgaXMg
dXNlZCBhcyB5b3UgaGF2ZSBpdCBoZXJlIG9yIG5vdC4NCj4NCj4gQSBmZXcgb3RoZXIgYml0cyBp
bmxpbmUgYXJvdW5kIGEgcmFjZSBjb25kaXRpb24gaW50cm9kdWNlZCBpbiBwcm9iZSAvIHJlbW92
ZS4NCj4NCj4gVGhhbmtzLA0KPg0KPiBKb25hdGhhbg0KPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMv
aWlvL2FkYy9zZF9hZGNfbW9kdWxhdG9yLmMgfCAxMDggKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvc2RfYWRjX21vZHVsYXRv
ci5jIGIvZHJpdmVycy9paW8vYWRjL3NkX2FkY19tb2R1bGF0b3IuYw0KPj4gaW5kZXggNTYwZDhj
N2Q5ZDg2Li5hODNmMzU4MzIwNTAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvc2Rf
YWRjX21vZHVsYXRvci5jDQo+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvc2RfYWRjX21vZHVsYXRv
ci5jDQo+PiBAQCAtMTAsOCArMTAsNyBAQA0KPj4gICAjaW5jbHVkZSA8bGludXgvaWlvL3RyaWdn
ZXJlZF9idWZmZXIuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4gICAjaW5j
bHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+PiAtDQo+PiAtc3RhdGljIGNvbnN0IHN0cnVjdCBp
aW9faW5mbyBpaW9fc2RfbW9kX2lpb19pbmZvOw0KPj4gKyNpbmNsdWRlIDxsaW51eC9yZWd1bGF0
b3IvY29uc3VtZXIuaD4NCj4+ICAgDQo+PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5f
c3BlYyBpaW9fc2RfbW9kX2NoID0gew0KPj4gICAJLnR5cGUgPSBJSU9fVk9MVEFHRSwNCj4+IEBA
IC0yMSwzNCArMjAsMTI2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBpaW9f
c2RfbW9kX2NoID0gew0KPj4gICAJCS5yZWFsYml0cyA9IDEsDQo+PiAgIAkJLnNoaWZ0ID0gMCwN
Cj4+ICAgCX0sDQo+PiArCS5pbmZvX21hc2tfc2hhcmVkX2J5X3R5cGUgPSBCSVQoSUlPX0NIQU5f
SU5GT19TQ0FMRSksDQo+IFRoaXMgcmVsaWVzIG9uIGdlbmVyaWMgc2lnbWEgZGVsdGEgbW9kdWxh
dG9ycyB1c2luZyBhbiBleHRlcm5hbCB2cmVmLg0KPiBUaGV5IG1pZ2h0IGhhdmUgYW4gaW50ZXJu
YWwgYWx3YXlzIG9uIHJlZ3VsYXRvci4uLg0KPiBJIHdvdWxkIHN1Z2dlc3Qgd2Ugb25seSBzdXBw
b3J0IHNjYWxlIGZvciBkZXZpY2VzIHdpdGggZXhwbGljaXRseQ0KPiBkZWZpbmVkIGNvbXBhdGli
bGVzIHdoZXJlIHdlIGNhbiBrbm93IHdoYXQgcmVndWxhdG9ycyBhcmUgdXNlZCBldGMuDQo+DQo+
IEZvciBtYW55IGRldmljZXMsIHRoZXJlIHdpbGwgYmUgYSBzaW5nbGUgcG93ZXJzdXBwbHkgY2Fs
bGVkIHZkZC1zdXBwbHkNCj4gb3Igc2ltaWxhciBpbiBEVC4gIEl0IG1heSBhbHNvIHByb3ZpZGUg
YSByZWZlcmVuY2Ugdm9sdGFnZS4NCkkgd2lsbCByZW1vdmUgc2NhbGUgc3VwcG9ydCBmb3IgZ2Vu
ZXJpYyBzZC1tb2R1bGF0b3IsDQphY2NvcmRpbmcgdG8geW91ciBjb21tZW50IG9uIHNkIG1vZHVs
YXRvciBiaW5kaW5ncy4NClRoZSBERlNETSBkcml2ZXIgZXhwZWN0cyBzY2FsZSBhdHRyaWJ1dGUg
ZnJvbSBzZC1tb2R1bGF0b3IuDQpTbywgc29tZSByZXdvcmsgb2YgREZTRE0gZHJpdmVyIHdpbGwg
YmUgcmVxdWlyZWQNCnRvIGFsc28gc3VwcG9ydCByYXcgZGF0YSByZWFkaW5nLg0KDQo+PiArfTsN
Cj4+ICsNCj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgaWlvX3NkX21vZF9j
aF9hZHMgPSB7DQo+PiArCS50eXBlID0gSUlPX1ZPTFRBR0UsDQo+PiArCS5pbmRleGVkID0gMSwN
Cj4+ICsJLnNjYW5fdHlwZSA9IHsNCj4+ICsJCS5zaWduID0gJ3UnLA0KPj4gKwkJLnJlYWxiaXRz
ID0gMSwNCj4+ICsJCS5zaGlmdCA9IDAsDQo+PiArCX0sDQo+PiArCS5pbmZvX21hc2tfc2hhcmVk
X2J5X3R5cGUgPSBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSksDQo+PiArCS5kaWZmZXJlbnRpYWwg
PSAxLA0KPj4gK307DQo+PiArDQo+PiArc3RydWN0IGlpb19zZF9tb2RfcHJpdiB7DQo+PiArCXN0
cnVjdCByZWd1bGF0b3IgKnZyZWY7DQo+PiArCWludCB2cmVmX212Ow0KPj4gK307DQo+PiArDQo+
PiArc3RhdGljIGludCBpaW9fc2RfbW9kX3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19k
ZXYsDQo+PiArCQkJICAgICAgIHN0cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFuLCBpbnQg
KnZhbCwNCj4+ICsJCQkgICAgICAgaW50ICp2YWwyLCBsb25nIG1hc2spDQo+PiArew0KPj4gKwlz
dHJ1Y3QgaWlvX3NkX21vZF9wcml2ICpwcml2ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4+ICsN
Cj4+ICsJc3dpdGNoIChtYXNrKSB7DQo+PiArCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4+
ICsJCSp2YWwgPSBwcml2LT52cmVmX212Ow0KPj4gKwkJKnZhbDIgPSBjaGFuLT5zY2FuX3R5cGUu
cmVhbGJpdHM7DQo+PiArCQlyZXR1cm4gSUlPX1ZBTF9JTlQ7DQo+PiArCX0NCj4+ICsNCj4+ICsJ
cmV0dXJuIC1FSU5WQUw7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlv
X2luZm8gaWlvX3NkX21vZF9paW9faW5mbyA9IHsNCj4+ICsJLnJlYWRfcmF3ID0gaWlvX3NkX21v
ZF9yZWFkX3JhdywNCj4+ICAgfTsNCj4+ICAgDQo+PiAgIHN0YXRpYyBpbnQgaWlvX3NkX21vZF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPj4gKwlzdHJ1Y3QgaWlvX3NkX21vZF9wcml2ICpw
cml2Ow0KPj4gICAJc3RydWN0IGlpb19kZXYgKmlpbzsNCj4+ICsJaW50IHJldDsNCj4+ICAgDQo+
PiAtCWlpbyA9IGRldm1faWlvX2RldmljZV9hbGxvYyhkZXYsIDApOw0KPj4gKwlpaW8gPSBkZXZt
X2lpb19kZXZpY2VfYWxsb2MoZGV2LCBzaXplb2YoKnByaXYpKTsNCj4+ICAgCWlmICghaWlvKQ0K
Pj4gICAJCXJldHVybiAtRU5PTUVNOw0KPj4gICANCj4+ICsJaWlvLT5jaGFubmVscyA9IChjb25z
dCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqKQ0KPj4gKwkJCQkJb2ZfZGV2aWNlX2dldF9tYXRjaF9k
YXRhKCZwZGV2LT5kZXYpOw0KPj4gKw0KPj4gKwlwcml2ID0gaWlvX3ByaXYoaWlvKTsNCj4+ICsN
Cj4+ICAgCWlpby0+ZGV2LnBhcmVudCA9IGRldjsNCj4+ICAgCWlpby0+ZGV2Lm9mX25vZGUgPSBk
ZXYtPm9mX25vZGU7DQo+PiAgIAlpaW8tPm5hbWUgPSBkZXZfbmFtZShkZXYpOw0KPj4gICAJaWlv
LT5pbmZvID0gJmlpb19zZF9tb2RfaWlvX2luZm87DQo+PiAgIAlpaW8tPm1vZGVzID0gSU5ESU9f
QlVGRkVSX0hBUkRXQVJFOw0KPj4gLQ0KPj4gICAJaWlvLT5udW1fY2hhbm5lbHMgPSAxOw0KPj4g
LQlpaW8tPmNoYW5uZWxzID0gJmlpb19zZF9tb2RfY2g7DQo+PiAgIA0KPj4gICAJcGxhdGZvcm1f
c2V0X2RydmRhdGEocGRldiwgaWlvKTsNCj4+ICAgDQo+PiAtCXJldHVybiBkZXZtX2lpb19kZXZp
Y2VfcmVnaXN0ZXIoJnBkZXYtPmRldiwgaWlvKTsNCj4+ICsJcHJpdi0+dnJlZiA9IGRldm1fcmVn
dWxhdG9yX2dldF9vcHRpb25hbChkZXYsICJ2cmVmIik7DQo+PiArCWlmIChJU19FUlIocHJpdi0+
dnJlZikpIHsNCj4+ICsJCXJldCA9IFBUUl9FUlIocHJpdi0+dnJlZik7DQo+PiArCQlpZiAocmV0
ICE9IC1FTk9ERVYpIHsNCj4+ICsJCQlpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+PiArCQkJ
CWRldl9lcnIoZGV2LCAidnJlZiBnZXQgZmFpbGVkLCAlZFxuIiwgcmV0KTsNCj4+ICsJCQlyZXR1
cm4gcmV0Ow0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+PiArCWlmICghSVNfRVJSKHByaXYtPnZy
ZWYpKSB7DQo+PiArCQlyZXQgPSByZWd1bGF0b3JfZW5hYmxlKHByaXYtPnZyZWYpOw0KPj4gKwkJ
aWYgKHJldCA8IDApIHsNCj4+ICsJCQlkZXZfZXJyKGRldiwgInZyZWYgZW5hYmxlIGZhaWxlZCAl
ZFxuIiwgcmV0KTsNCj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4gKwkJfQ0KPj4gKw0KPj4gKwkJcmV0
ID0gcmVndWxhdG9yX2dldF92b2x0YWdlKHByaXYtPnZyZWYpOw0KPj4gKwkJaWYgKHJldCA8IDAp
IHsNCj4+ICsJCQlkZXZfZXJyKGRldiwgInZyZWYgZ2V0IGZhaWxlZCwgJWRcbiIsIHJldCk7DQo+
PiArCQkJZ290byBlcnJfcmVndWxhdG9yX2Rpc2FibGU7DQo+PiArCQl9DQo+PiArDQo+PiArCQlw
cml2LT52cmVmX212ID0gcmV0IC8gMTAwMDsNCj4+ICsJCWRldl9kYmcoZGV2LCAidnJlZis9JWRt
VlxuIiwgcHJpdi0+dnJlZl9tdik7DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0ID0gZGV2bV9paW9f
ZGV2aWNlX3JlZ2lzdGVyKCZwZGV2LT5kZXYsIGlpbyk7DQo+IFRoaXMgZXhwb3NlcyB0aGUgdXNl
cnNwYWNlIGFuZCBpbiBrZXJuZWwgaW50ZXJmYWNlcy4gIFRob3NlDQo+IGFyZSBwYXJ0bHkgZGVw
ZW5kZW50IG9uIHRoZSByZWd1bGF0b3IgZW5hYmxlIHlvdSBoYXZlIGFib3ZlLg0KPg0KPiBVc2lu
ZyBkZXZtXyB2ZXJzaW9uIGZvIHRoaXMgaW50ZXJmYWNlIGxlYXZlcyB5b3Ugd2l0aCBhIHJhY2Ug
aW4gcmVtb3ZlLg0KPiBUaGUgcmVndWxhdG9yIGlzIGRpc2FibGVkIGJlZm9yZSB5b3UgaGF2ZSBy
ZW1vdmUgdGhlIGludGVyZmFjZXMgdGhhdA0KPiB3aWxsIG9ubHkgd29yayBpZiB3ZSBhc3N1bWUg
aXQgaXMgc3RpbGwgb24uDQo+DQo+IEhlbmNlLCB5b3Ugc2hvdWxkIGVpdGhlciB1c2UgZGV2bV9h
ZGRfYWN0aW9uX29yX3Jlc2V0IG1hZ2ljDQo+IHRvIGVuc3VyZSB3ZSBzdGlsbCBkbyBldmVyeXRo
aW5nIGluIHRoZSByaWdodCBvcmRlciwgb3IgZG8gaXQNCj4gbWFudWFsbHkgYnkgdXNpbmcgaWlv
X2RldmljZV9yZWdpc3RlciBhbmQgaWlvX2RldmljZV91bnJlZ2lzdGVyLg0KPg0KSSB3aWxsIGZp
eCB0aGlzIGluIHYyLg0KDQpSZWdhcmRzDQpPbGl2aWVyDQo+PiArCWlmIChyZXQgPCAwKSB7DQo+
PiArCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZWdpc3RlciBzZC1tb2R1bGF0b3IsICVkXG4i
LCByZXQpOw0KPj4gKwkJZ290byBlcnJfcmVndWxhdG9yX2Rpc2FibGU7DQo+PiArCX0NCj4+ICsN
Cj4+ICsJcmV0dXJuIDA7DQo+PiArDQo+PiArZXJyX3JlZ3VsYXRvcl9kaXNhYmxlOg0KPj4gKwly
ZWd1bGF0b3JfZGlzYWJsZShwcml2LT52cmVmKTsNCj4+ICsNCj4+ICsJcmV0dXJuIHJldDsNCj4+
ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBpaW9fc2RfbW9kX3JlbW92ZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPj4gK3sNCj4+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9
IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPj4gKwlzdHJ1Y3QgaWlvX3NkX21vZF9wcml2
ICpwcml2ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4+ICsNCj4+ICsJaWYgKHByaXYtPnZyZWYp
DQo+PiArCQlyZXR1cm4gcmVndWxhdG9yX2Rpc2FibGUocHJpdi0+dnJlZik7DQo+PiArDQo+PiAr
CXJldHVybiAwOw0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBzZF9hZGNfb2ZfbWF0Y2hbXSA9IHsNCj4+IC0JeyAuY29tcGF0aWJsZSA9ICJzZC1t
b2R1bGF0b3IiIH0sDQo+PiAtCXsgLmNvbXBhdGlibGUgPSAiYWRzMTIwMSIgfSwNCj4+ICsJeyAu
Y29tcGF0aWJsZSA9ICJzZC1tb2R1bGF0b3IiLCAuZGF0YSA9ICZpaW9fc2RfbW9kX2NoIH0sDQo+
PiArCXsgLmNvbXBhdGlibGUgPSAiYWRzMTIwMSIsIC5kYXRhID0gJmlpb19zZF9tb2RfY2hfYWRz
IH0sDQo+PiAgIAl7IH0NCj4+ICAgfTsNCj4+ICAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc2Rf
YWRjX29mX21hdGNoKTsNCj4+IEBAIC01OSw2ICsxNTAsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciBpaW9fc2RfbW9kX2FkYyA9IHsNCj4+ICAgCQkub2ZfbWF0Y2hfdGFibGUgPSBv
Zl9tYXRjaF9wdHIoc2RfYWRjX29mX21hdGNoKSwNCj4+ICAgCX0sDQo+PiAgIAkucHJvYmUgPSBp
aW9fc2RfbW9kX3Byb2JlLA0KPj4gKwkucmVtb3ZlID0gaWlvX3NkX21vZF9yZW1vdmUsDQo+PiAg
IH07DQo+PiAgIA0KPj4gICBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGlpb19zZF9tb2RfYWRjKTsN
Cg==
