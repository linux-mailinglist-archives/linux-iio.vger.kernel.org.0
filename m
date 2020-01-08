Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93D133F04
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 11:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgAHKMp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 05:12:45 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18576 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbgAHKMp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 05:12:45 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008A7mJC025426;
        Wed, 8 Jan 2020 11:12:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=UYgNiksioEkvd3yt5yhovqZ6cC0hS5UsTf9lSkGod5M=;
 b=HbuwWotc6FuFw1ysJGHMXrNEJS9gRx4kwrn7Lk2ryQPGouacnG05B56xQjauQDy+4IYz
 lgTKNzkScsF+cqVtKMx4U+hEgBaOiqG0VhyPJg3eColIBE9mqx0YTtmh1QyUGgPPV43+
 tdelAEdsTp/DtoVagRJFLv25DKcMy3Tk3bILcUGMPTzEZtf6eZGD4I7soouZkfFn+rcV
 D8/6lypDhBg/MI1upugWc9Q38In9ZQ17y83bebVs9bumj+Bf6IlSW+DlDjUV4YQmkfYo
 BHwpO6GRT0CtLbHLUa+VfFkeAe/9PSp/LZm7ObcaswGH0l9n1tHTNeiVdd6egjGwkz9F Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2xakkaudb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 11:12:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAE5D100034;
        Wed,  8 Jan 2020 11:12:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D91F62A8A74;
        Wed,  8 Jan 2020 11:12:23 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 8 Jan
 2020 11:12:23 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Wed, 8 Jan 2020 11:12:23 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [Linux-stm32] [PATCH v2] iio: adc: stm32-dfsdm: Use
 dma_request_chan() instead dma_request_slave_channel()
Thread-Topic: [Linux-stm32] [PATCH v2] iio: adc: stm32-dfsdm: Use
 dma_request_chan() instead dma_request_slave_channel()
Thread-Index: AQHVxgwegqXMFmu60kK3qJzHfvmj/g==
Date:   Wed, 8 Jan 2020 10:12:23 +0000
Message-ID: <de420ff5-6513-4890-1dec-7253a3b0f903@st.com>
References: <20200107114532.6697-1-peter.ujfalusi@ti.com>
In-Reply-To: <20200107114532.6697-1-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6676CE30CC8664EA1C298C0E6F4514C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-08,2020-01-08 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

QWNrZWQtYnk6IE9saXZpZXIgTW95c2FuIDxvbGl2aWVyLm1veXNhbkBzdC5jb20+DQoNCk9uIDEv
Ny8yMCAxMjo0NSBQTSwgUGV0ZXIgVWpmYWx1c2kgd3JvdGU6DQo+IGRtYV9yZXF1ZXN0X3NsYXZl
X2NoYW5uZWwoKSBpcyBhIHdyYXBwZXIgb24gdG9wIG9mIGRtYV9yZXF1ZXN0X2NoYW4oKQ0KPiBl
YXRpbmcgdXAgdGhlIGVycm9yIGNvZGUuDQo+DQo+IEJ5IHVzaW5nIGRtYV9yZXF1ZXN0X2NoYW4o
KSBkaXJlY3RseSB0aGUgZHJpdmVyIGNhbiBzdXBwb3J0IGRlZmVycmVkDQo+IHByb2JpbmcgYWdh
aW5zdCBETUEuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZh
bHVzaUB0aS5jb20+DQo+IC0tLQ0KPiBIaSwNCj4NCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBG
YWxsIGJhY2sgdG8gSVJRIG1vZGUgZm9yIEFEQyBvbmx5IGluIGNhc2Ugb2YgRU5PREVWDQo+DQo+
IFJlZ2FyZHMsDQo+IFBldGVyDQo+DQo+ICAgZHJpdmVycy9paW8vYWRjL3N0bTMyLWRmc2RtLWFk
Yy5jIHwgMjEgKysrKysrKysrKysrKysrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lp
by9hZGMvc3RtMzItZGZzZG0tYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tYWRj
LmMNCj4gaW5kZXggZTQ5MzI0MmMyNjZlLi43NGEyMjExYmRmZjQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaWlvL2FkYy9zdG0zMi1kZnNkbS1hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMv
c3RtMzItZGZzZG0tYWRjLmMNCj4gQEAgLTEzODMsOSArMTM4MywxMyBAQCBzdGF0aWMgaW50IHN0
bTMyX2Rmc2RtX2RtYV9yZXF1ZXN0KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICAgew0K
PiAgIAlzdHJ1Y3Qgc3RtMzJfZGZzZG1fYWRjICphZGMgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0K
PiAgIA0KPiAtCWFkYy0+ZG1hX2NoYW4gPSBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsKCZpbmRp
b19kZXYtPmRldiwgInJ4Iik7DQo+IC0JaWYgKCFhZGMtPmRtYV9jaGFuKQ0KPiAtCQlyZXR1cm4g
LUVJTlZBTDsNCj4gKwlhZGMtPmRtYV9jaGFuID0gZG1hX3JlcXVlc3RfY2hhbigmaW5kaW9fZGV2
LT5kZXYsICJyeCIpOw0KPiArCWlmIChJU19FUlIoYWRjLT5kbWFfY2hhbikpIHsNCj4gKwkJaW50
IHJldCA9IFBUUl9FUlIoYWRjLT5kbWFfY2hhbik7DQo+ICsNCj4gKwkJYWRjLT5kbWFfY2hhbiA9
IE5VTEw7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiAgIA0KPiAgIAlhZGMtPnJ4X2J1ZiA9
IGRtYV9hbGxvY19jb2hlcmVudChhZGMtPmRtYV9jaGFuLT5kZXZpY2UtPmRldiwNCj4gICAJCQkJ
CSBERlNETV9ETUFfQlVGRkVSX1NJWkUsDQo+IEBAIC0xNTA5LDcgKzE1MTMsMTYgQEAgc3RhdGlj
IGludCBzdG0zMl9kZnNkbV9hZGNfaW5pdChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiAg
IAlpbml0X2NvbXBsZXRpb24oJmFkYy0+Y29tcGxldGlvbik7DQo+ICAgDQo+ICAgCS8qIE9wdGlv
bmFsbHkgcmVxdWVzdCBETUEgKi8NCj4gLQlpZiAoc3RtMzJfZGZzZG1fZG1hX3JlcXVlc3QoaW5k
aW9fZGV2KSkgew0KPiArCXJldCA9IHN0bTMyX2Rmc2RtX2RtYV9yZXF1ZXN0KGluZGlvX2Rldik7
DQo+ICsJaWYgKHJldCkgew0KPiArCQlpZiAocmV0ICE9IC1FTk9ERVYpIHsNCj4gKwkJCWlmIChy
ZXQgIT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCQlkZXZfZXJyKCZpbmRpb19kZXYtPmRldiwNCj4g
KwkJCQkJIkRNQSBjaGFubmVsIHJlcXVlc3QgZmFpbGVkIHdpdGggJWRcbiIsDQo+ICsJCQkJCXJl
dCk7DQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCQl9DQo+ICsNCj4gICAJCWRldl9kYmcoJmluZGlv
X2Rldi0+ZGV2LCAiTm8gRE1BIHN1cHBvcnRcbiIpOw0KPiAgIAkJcmV0dXJuIDA7DQo+ICAgCX0=
