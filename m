Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628CF2C01A1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgKWIln (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 03:41:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16082 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728018AbgKWIln (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 03:41:43 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AN8VfXn009764;
        Mon, 23 Nov 2020 09:40:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=QAa2GnmQAiWoa2+YVF7t7OcyZCsfIr9pWcyDLYCfUkA=;
 b=UhKsJoxFGSvG1f4curcr6LGdt1iUa76MDjniqftNWXHsi9Ly/WBHeVpe55bqJol+nt+B
 6VFew3zTJOvN2AWpYSjLoZuppzCZSdrGXCqOZvhyBT6EYew34t3bev5cF5b2Q+WSvChI
 JeO3VYEFpuIQpiL4Y6eqafORKttyFpsLZCckRvZJKXeW/epYONTWSLpKoXN7K0ZiIUFf
 IyYuYGoo/FAZM/MIETpwVs7fRkqX4isOZSppRAVH412/FiZw4qu/XfXohum2k7W7Ygxq
 vsYzrPE4ZwfKobujUHalTM5mOA5Vo4ZajUnPxY+VfYKSlLU28Wf6NX2x62wQMsCs/jgL qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0hj1159-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 09:40:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BFB610002A;
        Mon, 23 Nov 2020 09:40:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1FB6A22A4BE;
        Mon, 23 Nov 2020 09:40:34 +0100 (CET)
Received: from SFHDAG2NODE2.st.com (10.75.127.5) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 09:40:33 +0100
Received: from SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b]) by
 SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b%20]) with mapi id
 15.00.1473.003; Mon, 23 Nov 2020 09:40:33 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] iio: buffer: Return error if no callback is given
Thread-Topic: [PATCH 2/2] iio: buffer: Return error if no callback is given
Thread-Index: AQHWwCGO6/PRziE1cU6P4ncVwkQG56nVV5QA
Date:   Mon, 23 Nov 2020 08:40:33 +0000
Message-ID: <79057dac-66d0-4e2d-b720-7b6bfbbb8157@st.com>
References: <20201121161457.957-1-nuno.sa@analog.com>
 <20201121161457.957-3-nuno.sa@analog.com>
In-Reply-To: <20201121161457.957-3-nuno.sa@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4271702028E7447A489EB1307131F3C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_02:2020-11-20,2020-11-23 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDExLzIxLzIwIDU6MTQgUE0sIE51bm8gU8OhIHdyb3RlOg0KPiBSZXR1cm4gZXJyb3Ig
aW4gY2FzZSBubyBjYWxsYmFjayBpcyBwcm92aWRlZCB0bw0KPiBgaWlvX2NoYW5uZWxfZ2V0X2Fs
bF9jYigpYC4gVGhlcmUncyBubyBwb2ludCBpbiBzZXR0aW5nIHVwIGEgYnVmZmVyLWNiDQo+IGlm
IG5vIGNhbGxiYWNrIGlzIHByb3ZpZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6Eg
PG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9paW8vYnVmZmVyL2luZHVz
dHJpYWxpby1idWZmZXItY2IuYyB8IDUgKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJp
YWxpby1idWZmZXItY2IuYyBiL2RyaXZlcnMvaWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVmZmVy
LWNiLmMNCj4gaW5kZXggNDdjOTZmN2Y0OTc2Li40YzEyYjdhOTRhZjUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVmZmVyLWNiLmMNCj4gKysrIGIvZHJp
dmVycy9paW8vYnVmZmVyL2luZHVzdHJpYWxpby1idWZmZXItY2IuYw0KPiBAQCAtNTQsNiArNTQs
MTEgQEAgc3RydWN0IGlpb19jYl9idWZmZXIgKmlpb19jaGFubmVsX2dldF9hbGxfY2Ioc3RydWN0
IGRldmljZSAqZGV2LA0KPiAgIAlzdHJ1Y3QgaWlvX2NiX2J1ZmZlciAqY2JfYnVmZjsNCj4gICAJ
c3RydWN0IGlpb19jaGFubmVsICpjaGFuOw0KPiAgIA0KPiArCWlmICghY2IpIHsNCj4gKwkJZGV2
X2VycihkZXYsICJJbnZhbGlkIGFyZ3VtZW50czogQSBjYWxsYmFjayBtdXN0IGJlIHByb3ZpZGVk
IVxuIik7DQo+ICsJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiArCX0NCj4gKw0KPiAgIAlj
Yl9idWZmID0ga3phbGxvYyhzaXplb2YoKmNiX2J1ZmYpLCBHRlBfS0VSTkVMKTsNCj4gICAJaWYg
KGNiX2J1ZmYgPT0gTlVMTCkNCj4gICAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiANCg0K
UmV2aWV3ZWQtYnk6IE9saXZpZXIgTW95c2FuIDxvbGl2aWVyLm1veXNhbkBzdC5jb20+DQoNCkJl
c3QgcmVnYXJkcywNCk9saXZpZXI=
