Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAB19F158
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDFINH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 04:13:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37938 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgDFINH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 04:13:07 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03684WOu008166;
        Mon, 6 Apr 2020 04:12:45 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 306m366ggj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 04:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9gxCkeBV4FP1ovy0gTigejPEDMIDp2mTWTVT+w8hejJUxs4kWNRqYVzjR3VBMvlC3INs0HmkzmybNS3ciOWxH1ioKTxstuMUaOjlIW/DksloP4QlyeYXM2ItYG4JA0ZaL8qmHvnatllTyQIMVoNqmu9rHmFkplvBAQ4eD+Z1SOlAUqbnvdyT9qyQuzV5hS22kJgnF+BRIsOieENwdwrTt7z2aFSzl+7J2lMbWaMIe/OriZuycQjfGJq+pnDMx6GYsfUkcxjKB307ozKt5U76hIN8wj9xbmCg5KgRUFXI3Rwo3achyJedhP6oKecAmLkFQt7QcAFTg0iadnftJ1ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YkCiMoviSU6PLaQ4xJlVyXR7yhDxMeLVGCGuXSQX5k=;
 b=IiRmT+K4G9Z7oS9iavtBnBFctW5N2F14i6rusBfMvuTQZMapkz/+mxEJARdHcVz67Fh74zMjR/pRF2Bk486FzN88PXpHzKh7RE4JliJNyklFQGf8lxFOQoMt2TK4Ra4IqOq8DQ/mpnq5q2rjQNaKc3najyz44L0MrWlul/A5mrnPQMP21OljSsc8mnG8YtE4u7ETMLkclT3eiJjqzlbMsN9/UlWht5Epl7H6gtzvilqtGvlpdWToi/4bA/qQ+RFsq4CHpT+8zTt9thGWKpHdTXa9BH5y94WjislBAR7hky0A52eZ/1krB/ej9W4Tlm1xx8epRKajlNicpDQ/0Nd/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YkCiMoviSU6PLaQ4xJlVyXR7yhDxMeLVGCGuXSQX5k=;
 b=laOjN0VRwA/J8+1gJVJ44u3tNDUk8ENIJEzoBGrEKpWKsCODeGcxk1zbI5Y9KUZ67MQZiHy5BkGMU6ekl4t0lf7bXy1u1Z7btOJUNWjNpwGdXUmssLhA9NekxqxOB7hgRMjn1OgJqbsux5p1I4w2tQiRKsOVtjLgXKI/zUP7xHo=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4427.namprd03.prod.outlook.com (2603:10b6:5:10d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 08:12:44 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 08:12:44 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 1/3] iio: kfifo: add iio_device_attach_kfifo_buffer()
 helper
Thread-Topic: [PATCH 1/3] iio: kfifo: add iio_device_attach_kfifo_buffer()
 helper
Thread-Index: AQHWCCWGYhb0S8PCiE6zE1nPt+/QvahqXoEAgAFnfIA=
Date:   Mon, 6 Apr 2020 08:12:42 +0000
Message-ID: <48e7f8d5f090971e0c48c0134ebb2dca86a0f144.camel@analog.com>
References: <20200401125936.6398-1-alexandru.ardelean@analog.com>
         <20200405114602.160c690b@archlinux>
In-Reply-To: <20200405114602.160c690b@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79dc745c-ac1e-4a2e-480f-08d7da0248b0
x-ms-traffictypediagnostic: DM6PR03MB4427:
x-microsoft-antispam-prvs: <DM6PR03MB44276B425733D066408B7944F9C20@DM6PR03MB4427.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(76116006)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(81166006)(86362001)(8676002)(478600001)(71200400001)(36756003)(81156014)(8936002)(6512007)(26005)(6506007)(2906002)(54906003)(6916009)(2616005)(186003)(316002)(66446008)(4326008)(6486002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6AZQc+X8oPQdNfeEmTPTYZOwUImcuLqZ567gNucj77fgD21PAw62eVorICK4Oi6+oM0Nvom5JhEuh9BTn2wrCJ/WRKmWybUgwpTegUgbrRNCwXTLZaF7aK7OefHGmllrpP55yZEqTlSkCMekI8IBbg8nIlp80i64FVfAMfr8Ye2aBaM6aFhvQxCJXTOgdU8UowGktTB2hjOxu/ERmKKCojp+fpwAKZwxvBOvIxd3RZxKG5yDU6N1roO7gNiRGAttQUEgpEapvP2Efcc1jy8RVc7JU/Xl2kmIkLRkv4i7yxbonnclBngHnWNIZvnisMUTFlQw+GPAMC8vD9UqiSDmdTTswytb+Twi7DgcLHDXpWbgRwTWW5hr20ZeprDYY+MJvrcRfSd0suTDdK/Ukb+zYeoNzxj7JeYP/JmUuVS30424VOtXc0JyjNKD75YDb5x
x-ms-exchange-antispam-messagedata: DtCCrnDSKHHMX3Cgp4E+edIMAL9AjiYCwqkaiIGHi1jtfmV2mEfvOkivafdu0apetRsl+msCAhqtMbvvs/s4rRd5nf6/lyJMWeDkqaFCTB75qHjjEHQJywXtgnzob52IN3C3x4633DmvExOIwPFBHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B8BD079FF9825488EE053B0E46C165F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dc745c-ac1e-4a2e-480f-08d7da0248b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 08:12:43.9507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxDkNwv6TyhO9jtnTZtf/KmXAWCVa23K0tSAHToN8Afdy9RJj5VJXjI3BGK3SDq6BlZ0MhE/0jud2FVsUJg10qOrScIpFxh2YGZSRFejggE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4427
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_04:2020-04-03,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060068
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTA1IGF0IDExOjQ2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBXZWQsIDEgQXByIDIwMjAgMTU6NTk6MzQgKzAzMDAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGlpb19kZXZpY2VfYXR0YWNoX2tmaWZv
X2J1ZmZlcigpIGhlbHBlci9zaG9ydC1oYW5kLA0KPiA+IHdoaWNoIGdyb3VwcyB0aGUgc2ltcGxl
IHJvdXRpbmUgb2YgYWxsb2NhdGluZyBhIGtmaWZvIGJ1ZmZlcnMgdmlhDQo+ID4gZGV2bV9paW9f
a2ZpZm9fYWxsb2NhdGUoKSBhbmQgY2FsbGluZyBpaW9fZGV2aWNlX2F0dGFjaF9idWZmZXIoKS4N
Cj4gPiANCj4gPiBUaGUgbW9kZV9mbGFncyBwYXJhbWV0ZXIgaXMgcmVxdWlyZWQuIFRoZSBzZXR1
cF9vcHMgcGFyYW1ldGVyIGlzIG9wdGlvbmFsLg0KPiA+IA0KPiA+IFRoaXMgZnVuY3Rpb24gd2ls
bCBiZSBhIGJpdCBtb3JlIHVzZWZ1bCB3aGVuIG5lZWRpbmcgdG8gZGVmaW5lIG11bHRpcGxlDQo+
ID4gYnVmZmVycyBwZXIgSUlPIGRldmljZS4NCj4gPiANCj4gPiBPbmUgcmVxdWlyZW1lbnQgW3Ro
YXQgaXMgbW9yZSBhIHJlY29tbWVuZGF0aW9uXSBmb3IgdGhpcyBoZWxwZXIsIGlzIHRvIGNhbGwN
Cj4gPiBpdCBhZnRlciAnaW5kaW9fZGV2JyBoYXMgYmVlbiBwb3B1bGF0ZWQuDQo+ID4gDQo+ID4g
QWxzbywgb25lIGNvbnNlcXVlbmNlIHJlbGF0ZWQgdG8gdXNpbmcgdGhpcyBoZWxwZXIgaXMgdGhh
dCB0aGUgcmVzb3VyY2UNCj4gPiBtYW5hZ2VtZW50IG9mIHRoZSBidWZmZXIgd2lsbCBiZSB0aWVk
IHRvICdpbmRpb19kZXYtPmRldicuIFByZXZpb3VzbHkgaXQNCj4gPiB3YXMgb3Blbi1jb2RlZCwg
YW5kIGVhY2ggZHJpdmVyIGRvZXMgaXQgc2xpZ2h0bHkgZGlmZmVyZW50bHkuIE1vc3Qgb2YgdGhl
bQ0KPiA+IHRpZWQgaXQgdG8gdGhlIHBhcmVudCBkZXZpY2UsIHNvbWUgb2YgdGhlbSB0byAnaW5k
aW9fZGV2LT5kZXYnLg0KPiA+IFRoaXMgc2hvdWxkbid0IGJlIGEgcHJvYmxlbSwgYW5kIG1heSBi
ZSBhIGdvb2QgaWRlYSB3aGVuIGFkZGluZyBtb3JlDQo+ID4gYnVmZmVycyBwZXItZGV2aWNlLg0K
PiANCj4gSSdtIGdsYWQgeW91IGhpZ2hsaWdodGVkIHRoaXMgc3VidGxldHkuICBJJ20gbm90IHN1
cmUgaXQncyBzYWZlIGluIGFsbCBjYXNlcw0KPiBiZWNhdXNlIHRoZSByZXN1bHQgaXMgdGhhdCB0
aGUgbWFuYWdlZCBjbGVhbnVwIGZvciB0aGlzIHdpbGwgb2NjdXIgb25jZSB3ZQ0KPiBnZXQgdG8g
dGhlIGNsZWFudXAgZm9yIGRldm1faWlvX2RldmljZV9hbGxvYyBhbmQgd2UgcmVsZWFzZSB0aGUg
aW5kaW9fZGV2LT5kZXYNCj4gDQo+IFRoYXQgd291bGQgcHV0IGl0ICdhZnRlcicgYW55IG90aGVy
IGRldm0gY2FsbHMgdGhhdCBhcmUgc3RpbGwgaHVuZyBvZmYgdGhlDQo+IHBhcmVudA0KPiBkZXZp
Y2UuDQo+IA0KPiBOb3cgdGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgdGhhdCBldmVyIGNhdXNlcyB1
cyBwcm9ibGVtcy4uLiBTZWUgbmV4dCBwYXRjaC4NCj4gSXQgcG90ZW50aWFsbHkgZG9lcy4gIEkg
dGhpbmsgd2UgbmVlZCB0byBwcm92aWRlIHRoZSBkZXYgc2VwYXJhdGVseSBldmVuDQo+IGlmIGl0
IGZlZWxzIGEgYml0IHNpbGx5IHRvIGRvIHNvLiAgU2NvcGUgbWFuYWdlbWVudCBpcyBjb21wbGV4
IHNvIEkgZG9uJ3QNCj4gcmVhbGx5IHdhbnQgdG8gZm9yY2UgcGVvcGxlIHRvIG1peCBhbmQgbWF0
Y2ggYmV0d2VlbiBkaWZmZXJlbnQgZGV2aWNlcw0KPiBhbmQgc28gZ2V0IGl0IHdyb25nIGJ5IGFj
Y2lkZW50Lg0KPiANCj4gVGhlIG90aGVyIGlzc3VlIGlzIHRoYXQgaXQncyBub3QgcmVhZGlseSBh
cHBhcmVudCBmcm9tIHRoZSBuYW1pbmcgdGhhdA0KPiB0aGlzIGZ1bmN0aW9uIGlzIHJlZ2lzdGVy
aW5nIHN0dWZmIHRoYXQgaXMgY2xlYW5lZCB1cCBhdXRvbWF0aWNhbGx5IG9yDQo+IHRoYXQgaXQg
ZXZlbiBhbGxvY2F0ZXMgYW55dGhpbmcgdGhhdCBtaWdodCBuZWVkIHRoYXQuLg0KPiANCj4gZGV2
bV9paW9fZGV2aWNlX2F0dGFjaF9uZXdfa2ZpZm9fYnVmZmVyIG1heWJlPw0KPiANCj4gSSdtIHNv
cnQgb2Ygd29uZGVyaW5nIGlmIHdlIHNob3VsZCBkbyB3aGF0IGRtYSBkaWQgYW5kIGhhdmUNCj4g
DQo+IGlpb21fZGV2aWNlX2F0dGFjaF9uZXdfa2ZpZm9fYnVmZmVyIHRvIGluZGljYXRlIGl0J3Mg
bWFuYWdlZCBpbiB0aGUNCj4gc2NvcGUgb2YgdGhlIGlpbyBkZXZpY2U/DQo+IA0KPiBXaGF0IGRv
IHBlb3BsZSB0aGluaz8NCj4gDQo+IEhvd2V2ZXIsIHNlZSBwYXRjaCAyIGJlZm9yZSBjb21tZW50
aW5nLiAgUmVhbGl0eSBpcyBJJ20gbm90IHN1cmUgZm9yY2luZw0KPiBtYW5hZ2VkIGNhbGxzIHRv
IGhhbmcgb2ZmIGlpb19kZXYtPmRldiBpcyBhIGdvb2QgaWRlYSAoYXQgdGhpcyBzdGFnZSBnaXZl
bg0KPiB3aGVyZSB3ZSBhcmUpLg0KDQpXaGF0IEkgYW0gcmVhbGx5IGFmdGVyIHdpdGggdGhpcyBw
YXRjaCBpcyB0byBoaWRlIGF3YXkgdGhlc2U6DQogICAgIGlpb19rZmlmb19mcmVlKGluZGlvX2Rl
di0+YnVmZmVyKTsNCiAgICAgaWlvX2J1ZmZlcl9zZXRfYXR0cnMoaW5kaW9fZGV2LT5idWZmZXIs
IHh4eHhfZmlmb19hdHRyaWJ1dGVzKTsgDQppLmUuIG5vdCBoYXZlICdpbmRpb19kZXYtPmJ1ZmZl
cicgb3Blbi1jb2RlZCBpbiBkcml2ZXJzLCBhbmQgaGlkZSBpdCBpbiBJSU8gY29yZQ0Kc29tZXdo
ZXJlLg0KU29tZSBpZGVhcyBjYW4gZ28gaW4gcGFyYWxsZWwgW2xpa2UgdGhpcyBvbmVdIHRvIGFk
ZCBzdXBwb3J0IGZvciBtdWx0aXBsZQ0KYnVmZmVycy4NCg0KU28sIEkgd2lsbCB0aGluayBvZiBh
IGJldHRlciBbbGVzcyBzbG9wcHldIFYyIGZvciB0aGlzLg0KDQpPbmUgaW50ZXJtZWRpYXRlIGFs
dGVybmF0aXZlIGlzIHRvIGRvICdpaW9fZGV2aWNlX2tmaWZvX2ZyZWUoaW5kaW9fZGV2KScsIGJ1
dA0KSSdsbCBzdGlsbCB0cnkgdG8gdGhpbmsgb2YgYSBiZXR0ZXIgZGV2bV8gYXBwcm9hY2guDQpk
ZXZtX2lpb19kZXZpY2VfYXR0YWNoX25ld19rZmlmb19idWZmZXIoKSBzb3VuZHMgYSBiaXQgbG9u
ZyBidXQgbWF5IHdvcmsuDQppaW9tX2RldmljZV9hdHRhY2hfbmV3X2tmaWZvX2J1ZmZlcigpIGNh
biBhbHNvIHdvcmsuDQoNCldoYXQgaWYgd2UganVzdCBkZWZhdWx0IGF0dGFjaGluZyB0byB0aGUg
cGFyZW50IGRldmljZT8NCg0KV291bGQgaXQgd29yayB0byBhbHNvIGF0dGFjaCB0aGUgcGFyZW50
IGRldmljZSBpbiBkZXZtX2lpb19kZXZpY2VfYWxsb2MoKSBieQ0KZGVmYXVsdD8NCk9yIGNoYW5n
ZSAnaWlvX2RldmljZV9hbGxvYygpJyB0byB0YWtlIGEgcGFyZW50IGRldmljZSBhcyBhcmd1bWVu
dD8NCldoaWNoIGZvciBkZXZtX2lpb19kZXZpY2VfYWxsb2MoZGV2LC4uLikgd291bGQgaW1wbGlj
aXRseSBtZWFuIHRoYXQgJ2RldicgaXMNCidwYXJlbnQnPw0KDQpUaGVzZSBhcmUganVzdCBzb21l
IHRob3VnaHRzLg0KDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gSm9uYXRoYW4NCj4gDQo+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFu
YWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2J1ZmZlci9rZmlmb19idWYuYyB8
IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51
eC9paW8va2ZpZm9fYnVmLmggIHwgIDQgKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQxIGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYnVmZmVyL2tm
aWZvX2J1Zi5jIGIvZHJpdmVycy9paW8vYnVmZmVyL2tmaWZvX2J1Zi5jDQo+ID4gaW5kZXggMzE1
MGY4YWI5ODRiLi4wNWI3YzVmYzZmMWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYnVm
ZmVyL2tmaWZvX2J1Zi5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYnVmZmVyL2tmaWZvX2J1Zi5j
DQo+ID4gQEAgLTIyOCw0ICsyMjgsNDEgQEAgdm9pZCBkZXZtX2lpb19rZmlmb19mcmVlKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gaWlvX2J1ZmZlciAqcikNCj4gPiAgfQ0KPiA+ICBF
WFBPUlRfU1lNQk9MKGRldm1faWlvX2tmaWZvX2ZyZWUpOw0KPiA+ICANCj4gPiArLyoqDQo+ID4g
KyAqIGlpb19kZXZpY2VfYXR0YWNoX2tmaWZvX2J1ZmZlciAtIEFsbG9jYXRlIGEga2ZpZm8gYnVm
ZmVyICYgYXR0YWNoIGl0IHRvDQo+ID4gYW4gSUlPIGRldmljZQ0KPiA+ICsgKiBAaW5kaW9fZGV2
OiBUaGUgZGV2aWNlIHRoZSBidWZmZXIgc2hvdWxkIGJlIGF0dGFjaGVkIHRvDQo+ID4gKyAqIEBt
b2RlX2ZsYWdzOiBUaGUgbW9kZSBmbGFncyBmb3IgdGhpcyBidWZmZXIgKElORElPX0JVRkZFUl9T
T0ZUV0FSRQ0KPiA+IGFuZC9vcg0KPiA+ICsgKgkJSU5ESU9fQlVGRkVSX1RSSUdHRVJFRCkuDQo+
ID4gKyAqIEBzZXR1cF9vcHM6IFRoZSBzZXR1cF9vcHMgcmVxdWlyZWQgdG8gY29uZmlndXJlIHRo
ZSBIVyBwYXJ0IG9mIHRoZQ0KPiA+IGJ1ZmZlciAob3B0aW9uYWwpDQo+ID4gKyAqDQo+ID4gKyAq
IFRoaXMgZnVuY3Rpb24gYWxsb2NhdGVzIGEga2ZpZm8gYnVmZmVyIHZpYSBkZXZtX2lpb19rZmlm
b19hbGxvY2F0ZSgpIGFuZA0KPiA+ICsgKiBhdHRhY2hlcyBpdCB0byB0aGUgSUlPIGRldmljZSB2
aWEgaWlvX2RldmljZV9hdHRhY2hfYnVmZmVyKCkuDQo+ID4gKyAqIFRoaXMgaXMgbWVhbnQgdG8g
YmUgYSBiaXQgb2YgYSBzaG9ydC1oYW5kL2hlbHBlciBmdW5jdGlvbiBhcyBtYW55IGRyaXZlcg0K
PiA+ICsgKiBzZWVtIHRvIGRvIHRoaXMuDQo+ID4gKyAqLw0KPiA+ICtpbnQgaWlvX2RldmljZV9h
dHRhY2hfa2ZpZm9fYnVmZmVyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gKwkJCQkg
ICBpbnQgbW9kZV9mbGFncywNCj4gPiArCQkJCSAgIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3Nl
dHVwX29wcyAqc2V0dXBfb3BzKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVm
ZmVyOw0KPiA+ICsNCj4gPiArCWlmIChtb2RlX2ZsYWdzKQ0KPiA+ICsJCW1vZGVfZmxhZ3MgJj0g
a2ZpZm9fYWNjZXNzX2Z1bmNzLm1vZGVzOw0KPiA+ICsNCj4gPiArCWlmICghbW9kZV9mbGFncykN
Cj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlidWZmZXIgPSBkZXZtX2lpb19r
Zmlmb19hbGxvY2F0ZSgmaW5kaW9fZGV2LT5kZXYpOw0KPiA+ICsJaWYgKCFidWZmZXIpDQo+ID4g
KwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJaWlvX2RldmljZV9hdHRhY2hfYnVmZmVy
KGluZGlvX2RldiwgYnVmZmVyKTsNCj4gPiArDQo+ID4gKwlpbmRpb19kZXYtPm1vZGVzIHw9IG1v
ZGVfZmxhZ3M7DQo+ID4gKwlpbmRpb19kZXYtPnNldHVwX29wcyA9IHNldHVwX29wczsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChpaW9fZGV2
aWNlX2F0dGFjaF9rZmlmb19idWZmZXIpOw0KPiA+ICsNCj4gPiAgTU9EVUxFX0xJQ0VOU0UoIkdQ
TCIpOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9rZmlmb19idWYuaCBiL2lu
Y2x1ZGUvbGludXgvaWlvL2tmaWZvX2J1Zi5oDQo+ID4gaW5kZXggNzY0NjU5ZTAxYjY4Li4yMzYz
YTkzMWJlMTQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8va2ZpZm9fYnVmLmgN
Cj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9rZmlmb19idWYuaA0KPiA+IEBAIC0xMSw0ICsx
MSw4IEBAIHZvaWQgaWlvX2tmaWZvX2ZyZWUoc3RydWN0IGlpb19idWZmZXIgKnIpOw0KPiA+ICBz
dHJ1Y3QgaWlvX2J1ZmZlciAqZGV2bV9paW9fa2ZpZm9fYWxsb2NhdGUoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gPiAgdm9pZCBkZXZtX2lpb19rZmlmb19mcmVlKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGlpb19idWZmZXIgKnIpOw0KPiA+ICANCj4gPiAraW50IGlpb19kZXZpY2VfYXR0YWNo
X2tmaWZvX2J1ZmZlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+ICsJCQkJICAgaW50
IG1vZGVfZmxhZ3MsDQo+ID4gKwkJCQkgICBjb25zdCBzdHJ1Y3QgaWlvX2J1ZmZlcl9zZXR1cF9v
cHMNCj4gPiAqc2V0dXBfb3BzKTsNCj4gPiArDQo+ID4gICNlbmRpZg0K
