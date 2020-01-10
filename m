Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121DF136A80
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2020 11:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgAJKGi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jan 2020 05:06:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44732 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727451AbgAJKGi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jan 2020 05:06:38 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AA3GGC022000;
        Fri, 10 Jan 2020 11:06:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=X/IKNq/8pJeoSL1pB8WIriwvGpAf8+royPr4JdN4o5o=;
 b=OskxaP71K4BlIRa4w8IX7yvBVUjgYvCXCPe6onm4asE5Z2uFKOyXq6A9UVk6RbpffuYO
 SpEXuRkdYlY6uZ28Ng//3Z/U2GYITL8TmyjXzM1sd7H1OcGHAh3UWkwMMRsN1gVU9AIl
 6Ddhpa/wP/vVZUkSd49BN0Bcr72Abq7e4a7HdpBzf7eUGjQSTmcejs8BInztc+NwPn8t
 EC6bcfBjOlHjDMSwg+w21utR4+Wu162jkNU/Q/g97m/m6n6R5IizQlylL2sr+tXK/BZ7
 rwnwMTvh9rLq65E98OIroTteb34sflFTLgTO0RyVQcubEJCZ1MAdqdkqchw+WZb+Kn33 Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xdw8b7jex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:06:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42754100042;
        Fri, 10 Jan 2020 11:06:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 348E72A6199;
        Fri, 10 Jan 2020 11:06:14 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 11:06:13 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 10 Jan 2020 11:06:13 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: adapt sampling rate to
 oversampling ratio
Thread-Topic: [PATCH v2] iio: adc: stm32-dfsdm: adapt sampling rate to
 oversampling ratio
Thread-Index: AQHVpSQGsx9/ld0UD0mL7CjGbR/bFqfj4CGA
Date:   Fri, 10 Jan 2020 10:06:13 +0000
Message-ID: <9b7e2161-1a31-8d69-52f9-ae9dedc902e3@st.com>
References: <20191127131008.18896-1-olivier.moysan@st.com>
In-Reply-To: <20191127131008.18896-1-olivier.moysan@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C2AA4C736BB8E4387DC1A086E9FE594@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sIGFsbCwNCg0KS2luZCByZW1pbmRlciBvbiB0aGlzIHBhdGNoLg0KUmVnYXJk
cw0KT2xpdmllcg0KDQpPbiAxMS8yNy8xOSAyOjEwIFBNLCBPbGl2aWVyIE1veXNhbiB3cm90ZToN
Cj4gVXBkYXRlIHNhbXBsaW5nIHJhdGUgd2hlbiBvdmVyc2FtcGxpbmcgcmF0aW8gaXMgY2hhbmdl
ZA0KPiB0aHJvdWdoIHRoZSBJSU8gQUJJLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBPbGl2aWVyIE1v
eXNhbiA8b2xpdmllci5tb3lzYW5Ac3QuY29tPg0KPiAtLS0NCj4gY2hhbmdlcyBpbiB2ZXJzaW9u
IDI6DQo+IC0gY29ycmVjdCB0aXRsZQ0KPiAtLS0NCj4gICBkcml2ZXJzL2lpby9hZGMvc3RtMzIt
ZGZzZG0tYWRjLmMgfCAzMiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3N0bTMyLWRmc2RtLWFkYy5jIGIvZHJpdmVycy9paW8v
YWRjL3N0bTMyLWRmc2RtLWFkYy5jDQo+IGluZGV4IDAzMzllY2RkMDZiZC4uODdhODQyNTA3NTA5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tYWRjLmMNCj4gKysr
IGIvZHJpdmVycy9paW8vYWRjL3N0bTMyLWRmc2RtLWFkYy5jDQo+IEBAIC0xMjIxLDE0ICsxMjIx
LDMyIEBAIHN0YXRpYyBpbnQgc3RtMzJfZGZzZG1fd3JpdGVfcmF3KHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYsDQo+ICAgCXVuc2lnbmVkIGludCBzcGlfZnJlcTsNCj4gICAJaW50IHJldCA9IC1F
SU5WQUw7DQo+ICAgDQo+ICsJc3dpdGNoIChjaC0+c3JjKSB7DQo+ICsJY2FzZSBERlNETV9DSEFO
TkVMX1NQSV9DTE9DS19JTlRFUk5BTDoNCj4gKwkJc3BpX2ZyZXEgPSBhZGMtPmRmc2RtLT5zcGlf
bWFzdGVyX2ZyZXE7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgREZTRE1fQ0hBTk5FTF9TUElfQ0xP
Q0tfSU5URVJOQUxfRElWMl9GQUxMSU5HOg0KPiArCWNhc2UgREZTRE1fQ0hBTk5FTF9TUElfQ0xP
Q0tfSU5URVJOQUxfRElWMl9SSVNJTkc6DQo+ICsJCXNwaV9mcmVxID0gYWRjLT5kZnNkbS0+c3Bp
X21hc3Rlcl9mcmVxIC8gMjsNCj4gKwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJc3BpX2Zy
ZXEgPSBhZGMtPnNwaV9mcmVxOw0KPiArCX0NCj4gKw0KPiAgIAlzd2l0Y2ggKG1hc2spIHsNCj4g
ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX09WRVJTQU1QTElOR19SQVRJTzoNCj4gICAJCXJldCA9IGlp
b19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUoaW5kaW9fZGV2KTsNCj4gICAJCWlmIChyZXQpDQo+
ICAgCQkJcmV0dXJuIHJldDsNCj4gKw0KPiAgIAkJcmV0ID0gc3RtMzJfZGZzZG1fY29tcHV0ZV9h
bGxfb3NycyhpbmRpb19kZXYsIHZhbCk7DQo+IC0JCWlmICghcmV0KQ0KPiArCQlpZiAoIXJldCkg
ew0KPiArCQkJZGV2X2RiZygmaW5kaW9fZGV2LT5kZXYsDQo+ICsJCQkJIlNhbXBsaW5nIHJhdGUg
Y2hhbmdlZCBmcm9tICgldSkgdG8gKCV1KVxuIiwNCj4gKwkJCQlhZGMtPnNhbXBsZV9mcmVxLCBz
cGlfZnJlcSAvIHZhbCk7DQo+ICAgCQkJYWRjLT5vdmVyc2FtcCA9IHZhbDsNCj4gKwkJCWFkYy0+
c2FtcGxlX2ZyZXEgPSBzcGlfZnJlcSAvIHZhbDsNCj4gKwkJfQ0KPiAgIAkJaWlvX2RldmljZV9y
ZWxlYXNlX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+ICAgCQlyZXR1cm4gcmV0Ow0KPiAgIA0K
PiBAQCAtMTI0MCwxOCArMTI1OCw2IEBAIHN0YXRpYyBpbnQgc3RtMzJfZGZzZG1fd3JpdGVfcmF3
KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ICAgCQlpZiAocmV0KQ0KPiAgIAkJCXJldHVy
biByZXQ7DQo+ICAgDQo+IC0JCXN3aXRjaCAoY2gtPnNyYykgew0KPiAtCQljYXNlIERGU0RNX0NI
QU5ORUxfU1BJX0NMT0NLX0lOVEVSTkFMOg0KPiAtCQkJc3BpX2ZyZXEgPSBhZGMtPmRmc2RtLT5z
cGlfbWFzdGVyX2ZyZXE7DQo+IC0JCQlicmVhazsNCj4gLQkJY2FzZSBERlNETV9DSEFOTkVMX1NQ
SV9DTE9DS19JTlRFUk5BTF9ESVYyX0ZBTExJTkc6DQo+IC0JCWNhc2UgREZTRE1fQ0hBTk5FTF9T
UElfQ0xPQ0tfSU5URVJOQUxfRElWMl9SSVNJTkc6DQo+IC0JCQlzcGlfZnJlcSA9IGFkYy0+ZGZz
ZG0tPnNwaV9tYXN0ZXJfZnJlcSAvIDI7DQo+IC0JCQlicmVhazsNCj4gLQkJZGVmYXVsdDoNCj4g
LQkJCXNwaV9mcmVxID0gYWRjLT5zcGlfZnJlcTsNCj4gLQkJfQ0KPiAtDQo+ICAgCQlyZXQgPSBk
ZnNkbV9hZGNfc2V0X3NhbXBfZnJlcShpbmRpb19kZXYsIHZhbCwgc3BpX2ZyZXEpOw0KPiAgIAkJ
aWlvX2RldmljZV9yZWxlYXNlX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+ICAgCQlyZXR1cm4g
cmV0Ow0K
