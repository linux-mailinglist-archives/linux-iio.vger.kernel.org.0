Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AE515931A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgBKPYk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 10:24:40 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53993 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727862AbgBKPYk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 10:24:40 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BFClE1006474;
        Tue, 11 Feb 2020 16:24:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Ezoe/G+jJX5I3pY7QRbq/bcM4zPDwuqJPks4FpvMtAg=;
 b=LJQq/uiVV+asoDaiAIWJc4GnWWL1dMo86OQyN3S/EZepubJjjcFGw+/nO/8AwKkCz8Q8
 6jbAdWOtrTqk2wQN1FKPjpyiFHVO42Coaxy8UGb7jikQoJZf1B6Cxmzk2DbJF1Nnw5Yo
 gne+/y5LxnTcM1d/S5EGtdBc55790jTXh6krFOdWpEM++9AqxVoKoDrHspAhHTvXrcS8
 w3lGm+loV14d4GC2vnUVxtvuI98wU4jchGI4TwhiN3H243OjwK1YohlbULKLAneCEA0W
 vbT49ombzjku4t65J/VQ849dK2F1ooEZlDEsaB/1o3APzQmA+fEtN/TZkbhYHhvEFMLv /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1urh68mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 16:24:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6353110003A;
        Tue, 11 Feb 2020 16:24:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C9D12BEC69;
        Tue, 11 Feb 2020 16:24:20 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 11 Feb
 2020 16:24:19 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 11 Feb 2020 16:24:19 +0100
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
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: sd modulator: add vref support
Thread-Topic: [PATCH 1/4] dt-bindings: iio: adc: sd modulator: add vref
 support
Thread-Index: AQHV3qHoiCGlg6dSeUqjiNMk6pDzMqgWEKCA
Date:   Tue, 11 Feb 2020 15:24:19 +0000
Message-ID: <a2a738c1-4080-be91-a8bf-3aebe20b27f7@st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
 <20200204101008.11411-2-olivier.moysan@st.com>
 <20200208160454.0f153bfb@archlinux>
In-Reply-To: <20200208160454.0f153bfb@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB4AC24A2811754EA7AC0E65DB67844E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_04:2020-02-10,2020-02-11 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMi84LzIwIDU6MDQgUE0sIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFR1ZSwgNCBG
ZWIgMjAyMCAxMToxMDowNSArMDEwMA0KPiBPbGl2aWVyIE1veXNhbiA8b2xpdmllci5tb3lzYW5A
c3QuY29tPiB3cm90ZToNCj4NCj4+IEFkZCB2cmVmIHN1cHBseSBzdXBwb3J0IHRvIHNpZ21hIGRl
bHRhIG1vZHVsYXRvci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBPbGl2aWVyIE1veXNhbiA8b2xp
dmllci5tb3lzYW5Ac3QuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9hZGMvc2lnbWEtZGVsdGEtbW9kdWxhdG9yLnlhbWwgICAgfCA0ICsrKysNCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9zaWdtYS1kZWx0YS1tb2R1bGF0b3Iu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL3NpZ21hLWRl
bHRhLW1vZHVsYXRvci55YW1sDQo+PiBpbmRleCBhMzkwMzQzZDBjMmEuLjJhZmUwNzY1ZTk3MSAx
MDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRj
L3NpZ21hLWRlbHRhLW1vZHVsYXRvci55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9zaWdtYS1kZWx0YS1tb2R1bGF0b3IueWFtbA0KPj4gQEAg
LTgsNiArOCw3IEBAIHRpdGxlOiBEZXZpY2UtVHJlZSBiaW5kaW5ncyBmb3Igc2lnbWEgZGVsdGEg
bW9kdWxhdG9yDQo+PiAgIA0KPj4gICBtYWludGFpbmVyczoNCj4+ICAgICAtIEFybmF1ZCBQb3Vs
aXF1ZW4gPGFybmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPg0KPj4gKyAgLSBPbGl2aWVyIE1veXNhbiA8
b2xpdmllci5tb3lzYW5Ac3QuY29tPg0KPj4gICANCj4+ICAgcHJvcGVydGllczoNCj4+ICAgICBj
b21wYXRpYmxlOg0KPj4gQEAgLTIxLDYgKzIyLDkgQEAgcHJvcGVydGllczoNCj4+ICAgICAnI2lv
LWNoYW5uZWwtY2VsbHMnOg0KPj4gICAgICAgY29uc3Q6IDANCj4+ICAgDQo+PiArICB2cmVmLXN1
cHBseToNCj4+ICsgICAgZGVzY3JpcHRpb246IFBoYW5kbGUgdG8gdGhlIHZyZWYgaW5wdXQgYW5h
bG9nIHJlZmVyZW5jZSB2b2x0YWdlLg0KPiBJIG5vdGUgdGhpcyBpbiByZXZpZXcgb2YgcGF0Y2gg
MiBidXQgaW4gZ2VuZXJhbCBJJ20gbm90IHN1cmUgd2Ugc2hvdWxkDQo+IGJlIGludHJvZHVjaW5n
IHRoaXMgZm9yIGdlbmVyaWMgZGV2aWNlcy4gICBJdCdzIGZpbmUgaWYgd2UgaGF2ZSBhbg0KPiBl
eHBsaWNpdCBjb21wYXRpYmxlIGJ1dCB0aGVyZSBpcyBubyByZWFzb24gdG8gYXNzdW1lIGEgZ2Vu
ZXJpYyBzZC1tb2R1bGF0b3INCj4gdXNlcyBhbiBleHRlcm5hbCByZWZlcmVuY2UuDQo+DQo+IEpv
bmF0aGFuDQpPaywgSSB3aWxsIHJlbW92ZSByZWZlcmVuY2UgdG8gZXh0ZXJuYWwgdm9sdGFnZSBm
b3IgZ2VuZXJpYyANCnNkLW1vZHVsYXRvciwgaW4gdjIuDQpJIHdpbGwgYWRkIGl0IGZvciBhZHMx
MjAxIGNvbXBhdGlibGUsIGluc3RlYWQuDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcNCk9saXZp
ZXINCj4+ICsNCj4+ICAgcmVxdWlyZWQ6DQo+PiAgICAgLSBjb21wYXRpYmxlDQo+PiAgICAgLSAn
I2lvLWNoYW5uZWwtY2VsbHMnDQo=
