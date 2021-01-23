Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA830140C
	for <lists+linux-iio@lfdr.de>; Sat, 23 Jan 2021 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbhAWI5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Jan 2021 03:57:00 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:22554 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbhAWI46 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jan 2021 03:56:58 -0500
X-Greylist: delayed 1646 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jan 2021 03:56:57 EST
Received: from pps.filterd (m0135534.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10N8Rhev006243;
        Sat, 23 Jan 2021 08:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=28082020;
 bh=DZ8KioJUOVnVLtXrYrjAS4tslBp0x8bz6f7YrGxdj4c=;
 b=NzyZ9ieA/wtfBMH6LAs61kPEOBj0cQKT4I7eULsu8ojp2aE2D4HKoBgEnLWmkPB4KEO+
 DgbsccVDsCh+SP05FoygMMcA8I+4UYfBV0zBSjigM3ufTLQrzPthHM+rn+8DLio9EX/j
 oNZ4OD/fKFyMgVyu1PlSNNMwg+8yPgaWWvRw4v51OAsKlWslupLHtOb4ik+R1d51W4ki
 36gq3hUIpMhga40POZA9+fPfmpC/0utb3hRXKpDDUI7WUE6yUMLwgHLsfv+eXYrNO/T7
 Wqmszwjp1SiQ9pK/vzamZlrahL96plmdzMf+FdcJwSjnKtqL4zmqmGmhumD28jMOsq6n zA== 
Received: from atgrzso8133.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 368a1c8b0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 08:28:44 +0000
Received: from pps.filterd (atgrzso8133.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8133.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 10N8ShcP021802;
        Sat, 23 Jan 2021 09:28:43 +0100
Received: from atgrzsw3762.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8133.avl01.avlcorp.lan with ESMTP id 368b8pr1cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 09:28:43 +0100
Received: from atgrzsw3758.avl01.avlcorp.lan (10.37.149.11) by
 atgrzsw3762.avl01.avlcorp.lan (10.37.149.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Sat, 23 Jan 2021 09:28:43 +0100
Received: from atgrzsw3758.avl01.avlcorp.lan ([fe80::14f0:7a25:9759:e330]) by
 atgrzsw3758.avl01.avlcorp.lan ([fe80::14f0:7a25:9759:e330%6]) with mapi id
 15.01.2044.012; Sat, 23 Jan 2021 09:28:43 +0100
From:   "Denis, Tomislav AVL DiTEST" <Tomislav.Denis@avl.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] iio: adc: Add driver for Texas Instruments
 ADS131E0x ADC family
Thread-Topic: [PATCH v3 1/2] iio: adc: Add driver for Texas Instruments
 ADS131E0x ADC family
Thread-Index: AQHW6MiBIvJeN/5N9Em2fnxAURj3QaoyRmaAgAG9XlA=
Date:   Sat, 23 Jan 2021 08:28:42 +0000
Message-ID: <7474dd07191545b0bb9ae091e54c2013@avl.com>
References: <20210112095128.7112-1-tomislav.denis@avl.com>
 <20210112095128.7112-2-tomislav.denis@avl.com>
 <CAHp75VfNweJyXgzCcvZUWj=3mCVkP=+HaFmG2XaKmKP1cATa=Q@mail.gmail.com>
In-Reply-To: <CAHp75VfNweJyXgzCcvZUWj=3mCVkP=+HaFmG2XaKmKP1cATa=Q@mail.gmail.com>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.100.12]
x-exclaimer-md-config: f9e74532-fb7d-4806-8539-2b9574eafa9a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-23_04:2021-01-22,2021-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101230046
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-23_04:2021-01-22,2021-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230046
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KRmlyc3QsIHRoYW5rcyBmb3IgdGhlIGdyZWF0IHJldmlldy4gSSBhZ3JlZSB3
aXRoIGFsbCBvZiB5b3VyIGNvbW1lbnRzLCBqdXN0IG9uZSBxdWVzdGlvbi9jb21tZW50IGlubGlu
ZS4NCg0KQmVzdCBSZWdhcmRzLA0KVG9taXNsYXYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+
DQo+IFNlbnQ6IDIxIEphbnVhcnkgMjAyMSAxNzo0Mg0KPiBUbzogRGVuaXMsIFRvbWlzbGF2IEFW
TCBEaVRFU1QgPFRvbWlzbGF2LkRlbmlzQGF2bC5jb20+DQo+IENjOiBKb25hdGhhbiBDYW1lcm9u
IDxqaWMyM0BrZXJuZWwub3JnPjsgbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
PjsNCj4gZGV2aWNldHJlZSA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjMgMS8yXSBpaW86IGFkYzogQWRkIGRyaXZlciBmb3IgVGV4YXMgSW5zdHJ1
bWVudHMNCj4gQURTMTMxRTB4IEFEQyBmYW1pbHkNCj4gDQo+IE9uIFR1ZSwgSmFuIDEyLCAyMDIx
IGF0IDI6MzcgUE0gPHRvbWlzbGF2LmRlbmlzQGF2bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJv
bTogVG9taXNsYXYgRGVuaXMgPHRvbWlzbGF2LmRlbmlzQGF2bC5jb20+DQo+ID4NCj4gPiBUaGUg
QURTMTMxRTB4IGFyZSBhIGZhbWlseSBvZiBtdWx0aWNoYW5uZWwsIHNpbXVsdGFuZW91cyBzYW1w
bGluZywNCj4gPiAyNC1iaXQsIGRlbHRhLXNpZ21hLCBhbmFsb2ctdG8tZGlnaXRhbCBjb252ZXJ0
ZXJzIChBRENzKSB3aXRoIGENCj4gPiBidWlsdC1pbiBwcm9ncmFtbWFibGUgZ2FpbiBhbXBsaWZp
ZXIgKFBHQSksIGludGVybmFsIHJlZmVyZW5jZSBhbmQgYW4NCj4gPiBvbmJvYXJkIG9zY2lsbGF0
b3IuDQo+IA0KDQouLi4NCg0KPiANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhZHMxMzFlMDhf
ZGF0YV9yYXRlX2Rlc2MgYWRzMTMxZTA4X2RhdGFfcmF0ZV90YmxbXSA9IHsNCj4gPiArICAgICAg
IHsgLnJhdGUgPSA2NCwgICAucmVnID0gMHgwMCB9LA0KPiA+ICsgICAgICAgeyAucmF0ZSA9IDMy
LCAgIC5yZWcgPSAweDAxIH0sDQo+ID4gKyAgICAgICB7IC5yYXRlID0gMTYsICAgLnJlZyA9IDB4
MDIgfSwNCj4gPiArICAgICAgIHsgLnJhdGUgPSA4LCAgICAucmVnID0gMHgwMyB9LA0KPiA+ICsg
ICAgICAgeyAucmF0ZSA9IDQsICAgIC5yZWcgPSAweDA0IH0sDQo+ID4gKyAgICAgICB7IC5yYXRl
ID0gMiwgICAgLnJlZyA9IDB4MDUgfSwNCj4gPiArICAgICAgIHsgLnJhdGUgPSAxLCAgICAucmVn
ID0gMHgwNiB9LA0KPiA+ICt9Ow0KPiANCj4gQ2FuJ3QgeW91IHVzZSBzaW1wbGUgYml0IG9wZXJh
dGlvbnMgb24gdGhpcz8NCj4gDQo+IHJhdGUgPSBCSVQoNiAtIGluZGV4KQ0KPiByZWcgPSBpbmRl
eA0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFkczEzMWUwOF9wZ2Ff
Z2Fpbl9kZXNjIGFkczEzMWUwOF9wZ2FfZ2Fpbl90YmxbXSA9IHsNCj4gPiArICAgICAgIHsgLmdh
aW4gPSAxLCAgIC5yZWcgPSAweDAxIH0sDQo+ID4gKyAgICAgICB7IC5nYWluID0gMiwgICAucmVn
ID0gMHgwMiB9LA0KPiANCj4gcmVnID09IDMgdmFsaWQ/DQo+IA0KPiA+ICsgICAgICAgeyAuZ2Fp
biA9IDQsICAgLnJlZyA9IDB4MDQgfSwNCj4gPiArICAgICAgIHsgLmdhaW4gPSA4LCAgIC5yZWcg
PSAweDA1IH0sDQo+ID4gKyAgICAgICB7IC5nYWluID0gMTIsICAucmVnID0gMHgwNiB9LA0KPiA+
ICt9Ow0KPiANCj4gQWxzbyBjYW4gYmUgY2hhbmdlZCBieSBmb3JtdWxhLCBidXQgSSByZW1lbWJl
ciB0aGF0IGluIHNvbWUgY2FzZXMgdGFibGVzIGFyZQ0KPiBwcmVmZXJhYmxlLg0KPiANCj4NCg0K
SSB3b3VsZCBsaWtlIHRvIGtlZXAgdGhvc2UgdGFibGVzIGFzIHRoZXkgYXJlLCBiZWNhdXNlIEkg
ZmluZCB0aGVtIG1vcmUgaW50dWl0aXZlIGFuZCBlYXN5IHVuZGVyc3RhbmRhYmxlIT8NCg0KPg0K
PiA+ICtzdGF0aWMgaW50IGFkczEzMWUwOF9leGVjX2NtZChzdHJ1Y3QgYWRzMTMxZTA4X3N0YXRl
ICpzdCwgdTggY21kKSB7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCg0KLi4uLg0KDQo+
IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
