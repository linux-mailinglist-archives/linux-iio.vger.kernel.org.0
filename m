Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08861CDAB8
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgEKNEM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 09:04:12 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16604 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgEKNEM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 09:04:12 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BCuRg6005049;
        Mon, 11 May 2020 09:03:57 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 30wp9b4yed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 09:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/p56jQMBtgF6ZYHg+yOQrnqZa/S5ll5hSoRT5Dat4LN7EVVY4D0RX1m3NlNEfRoM0Fh9SwwpVJeARc3vIl7H1VBdUndJ6BqnilTRGQrrn8239qwga00bSf11Byiy+OSRtUAlin0bk7j3/RSnWPSxvbeiurPRwWyp7QSa6hgfXt1sfP7aS/DMNQd3qWEs5wMIUrnlhw1EL2FnouIX8tEHmRropnUfF2mRBOG4rmw5LH0faJPEcXYWvGRr+MjDwCDzXayYagkSeKWNp4HjErSShKtjc3uMzPshbzqddiVnbUo9u36DUmB6kG65MF7S29/OuedfdGdcCgdD6ta6XPn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfW235MmW/US5pqH1U0XCy/Oj1icko3OxAlZIAqd/5U=;
 b=f1RkFlJkZljPjUDGtA5NbE/dmkBb90gmwWfaa2pBq5rpl5UZ7SVfCT573OZgvFlNoe+WJiqXEguRVyme1/yWKZdKiLK5eL5sVhL7oDXPu4LR/S/gSaZxJPC/RerAl1IsdXmA65AgPPVfiG0ussSPy5BioGQuZqluORfnhLpe0M5ROmEKVfn5o+2bhoMAk4AWqb9KCdvM5upDPYwIOOWb7jS7gQHAUsNuOJHAn3xVLbu2hjFbQwYweuYUbfzLyLdB0AcUpzXs7LVOurDZtGR5ePPV/1MNPh/7vfjB3mnuZ+daP+UU8v9KRQpSCuEzZ02NFmT4Hyj/2yAUWSEWcR+/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfW235MmW/US5pqH1U0XCy/Oj1icko3OxAlZIAqd/5U=;
 b=OfZ8r69+RUJPgoikQmzfkS+36phadNzXWKgk2jNiVOKoDRo93aUOFX8Z3QhkICQ4zBuigYPEELK//LDxNhayCCl1FzH4b0ilOX7dO6Uxvc+zNefhE0vrnlymaN8SR/hFSpkLXiL6lcKuSwhOTZY7b1JGIKB5I0t0nmX3tsiqhxs=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4217.namprd03.prod.outlook.com (2603:10b6:5:5a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Mon, 11 May
 2020 13:03:55 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 13:03:55 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Topic: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Index: AQHWJUAdPxP6vzcVf0GdP2M4m7Jctaifc8QAgAGoDQCAAZjjAIAAAUIAgAAoyAA=
Date:   Mon, 11 May 2020 13:03:55 +0000
Message-ID: <554fe46f0cdd1cafb313f534c0edd93f5686b806.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
         <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
         <20200510110958.29046a18@archlinux>
         <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
         <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
In-Reply-To: <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ccec8a3-0e5a-499e-70e9-08d7f5abc315
x-ms-traffictypediagnostic: DM6PR03MB4217:
x-microsoft-antispam-prvs: <DM6PR03MB421785D6338BEF163F7F6BFDF9A10@DM6PR03MB4217.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KfGo6kZSv22mPqgBgP8GBiJVoSJD6hB6aIvEUYoZy8r9y95+lLhlU8uex1sVKIPSnXjK5cOXvcRmzGUUPNjxxq2Ro2AHvFPERGAa9/3ErKrQ4oi8PT59ZwTwroaEV1Jm8S94xv4uDYkisYPWZNPRxv5f8znvda35Z0BZft2+wAHUms1CoQmuSnuVpyXZANmuIaMXoF8CR0jeVuQw8H4FI4muBlzAcBxVS9MC3lkboCR22+lACYfXAnrCDI84HnYENoJNyx0lLePVIGwlbcf4PP672TYVnZ0KPGCYoviwAgEeeIM8fJFkUwJdZ1F1tv7Wf1w0xzBZA98ZBoZyEhKCJVNyHpsdpeZIQAO4lop4/hUqcuAVAoeDrts4NpnnLU2ZbB09Ao7fDs0C3vP2/I5zWjr+KNNHlxeK7gzD96WmEuWkpy910xrjSW5czjYzcGC3SB5xQ+T9nVtuWnPT4kXxaMO6DDET4b7HKWLIzG3DdAubZzVDiDjVvqGaEUDkDZQaFxLmGwNOmIQ60uzK47z+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(33430700001)(478600001)(5660300002)(8676002)(33440700001)(71200400001)(2616005)(4326008)(26005)(6486002)(54906003)(316002)(110136005)(8936002)(6512007)(86362001)(2906002)(66446008)(66556008)(64756008)(66476007)(66946007)(186003)(91956017)(36756003)(76116006)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2TaywtndGf7KVCt4nz98zBtwWRDS5C6bHWkb5NBcVe4LcWdch+4cZRJDhxGBmWcgspjA1jfjb/GRHclofalGqXovdpLA2X1oMOrhQmlgMoBxyzbFiYzW+ZPPtn+RL19w/3A2yDA/HiYXSDOzDdOidkPUh5pdP20zhthpfcRX6T7HCK+LX7VhDt2FwF8soGLUqfwWQS34Qac9Pid8e6XJj+qZ97EZymscBhiMgYPU/zkoNs6uMaIkG5/ar/IsE15FpCBc+w0Tq8bl56fZHvZC7gYR9em7Drog0DiHJuLx2+CLCmtp8m2LsKmmN6vJ/J8aIBZw2V2v6pvc5JsAGYUW5XcEJ+vi0OnDOdBEKgkhZdvqaO2wMmgju6r4XH3rAIxnYlANUcOACmRUeCQXi7YEnoESLO6O4Jm06Q+FuNPfkScqINnhLNkiIf2ltvgg382Yh4suyIQtwoeC1w5xdMsoyesmPpAC1O+RnIUNQOaAa6o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <24AC1D32C3189F4C8B2276BABE8BD2E3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccec8a3-0e5a-499e-70e9-08d7f5abc315
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 13:03:55.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cwm6HwqPTjmNI3lsStnMrgit+gJdEqG9fBqs8zp4r0zqpZ4CXtWdCMAO3oG6qJLvZo2tdlYteTfo0yMnVCnUQcaKsFtuQyi1d6CWL+1cxDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4217
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110107
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTExIGF0IDEyOjM3ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDUvMTEvMjAgMTI6MzMgUE0sIEFyZGVsZWFuLCBB
bGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gU3VuLCAyMDIwLTA1LTEwIGF0IDExOjA5ICswMTAwLCBK
b25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gDQo+ID4gPiBP
biBTYXQsIDkgTWF5IDIwMjAgMTA6NTI6MTQgKzAyMDANCj4gPiA+IExhcnMtUGV0ZXIgQ2xhdXNl
biA8bGFyc0BtZXRhZm9vLmRlPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBPbiA1LzgvMjAgMzo1
MyBQTSwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+ID4gPiA+IFsuLi5dDQo+ID4gPiA+
ID4gV2hhdCBJIGRvbid0IGxpa2UsIGlzIHRoYXQgaWlvOmRldmljZTMgaGFzIGlpbzpidWZmZXIz
OjAgKHRvIDMpLg0KPiA+ID4gPiA+IFRoaXMgaXMgYmVjYXVzZSB0aGUgJ2J1ZmZlci0+ZGV2LnBh
cmVudCA9ICZpbmRpb19kZXYtPmRldicuDQo+ID4gPiA+ID4gQnV0IEkgZG8gZmVlbCB0aGlzIGlz
IGNvcnJlY3QuDQo+ID4gPiA+ID4gU28sIG5vdyBJIGRvbid0IGtub3cgd2hldGhlciB0byBsZWF2
ZSBpdCBsaWtlIHRoYXQgb3Igc3ltbGluayB0bw0KPiA+ID4gPiA+IHNob3J0ZXINCj4gPiA+ID4g
PiB2ZXJzaW9ucyBsaWtlICdpaW86YnVmZmVyMzpZJyAtPiAnaWlvOmRldmljZTMvYnVmZmVyWScu
DQo+ID4gPiA+ID4gVGhlIHJlYXNvbiBmb3IgbmFtaW5nIHRoZSBJSU8gYnVmZmVyIGRldmljZXMg
dG8gJ2lpbzpidWZmZXJYOlknIGlzDQo+ID4gPiA+ID4gbW9zdGx5IHRvIG1ha2UgdGhlIG5hbWVz
IHVuaXF1ZS4gSXQgd291bGQgaGF2ZSBsb29rZWQgd2VpcmQgdG8gZG8NCj4gPiA+ID4gPiAnL2Rl
di9idWZmZXIxJyBpZiBJIHdvdWxkIGhhdmUgbmFtZWQgdGhlIGJ1ZmZlciBkZXZpY2VzICdidWZm
ZXJYJy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTbywgbm93IEknbSB0aGlua2luZyBvZiB3aGV0
aGVyIGFsbCB0aGlzIGlzIGFjY2VwdGFibGUuDQo+ID4gPiA+ID4gT3Igd2hhdCBpcyBhY2NlcHRh
YmxlPw0KPiA+ID4gPiA+IFNob3VsZCBJIHN5bWxpbmsgJ2lpbzpkZXZpY2UzL2lpbzpidWZmZXIz
OjAnIC0+ICdpaW86ZGV2aWNlMy9idWZmZXIwJz8NCj4gPiA+ID4gPiBXaGF0IGVsc2Ugc2hvdWxk
IEkgY29uc2lkZXIgbW92aW5nIGZvcndhcmQ/DQo+ID4gPiA+ID4gV2hhdCBtZWFucyBmb3J3YXJk
Pw0KPiA+ID4gPiA+IFdoZXJlIGRpZCBJIGxlYXZlIG15IGJlZXI/DQo+ID4gPiA+IExvb2tpbmcg
YXQgaG93IHRoZSAvZGV2LyBkZXZpY2VzIGFyZSBuYW1lZCBJIHRoaW5rIHdlIGNhbiBwcm92aWRl
IGEgbmFtZQ0KPiA+ID4gPiB0aGF0IGlzIGRpZmZlcmVudCBmcm9tIHRoZSBkZXZfbmFtZSgpIG9m
IHRoZSBkZXZpY2UuIEhhdmUgYSBsb29rIGF0DQo+ID4gPiA+IGRldmljZV9nZXRfZGV2bm9kZSgp
IGluIGRyaXZlcnMvYmFzZS9jb3JlLmMuIFdlIHNob3VsZCBiZSBhYmxlIHRvDQo+ID4gPiA+IHBy
b3ZpZGUgdGhlIG5hbWUgZm9yIHRoZSBjaGFyZGV2IHRocm91Z2ggdGhlIGRldm5vZGUoKSBjYWxs
YmFjay4NCj4gPiA+ID4gDQo+ID4gPiA+IFdoaWxlIHdlIGFyZSBhdCB0aGlzLCBkbyB3ZSB3YW50
IHRvIG1vdmUgdGhlIG5ldyBkZXZpY2VzIGludG8gYW4gaWlvDQo+ID4gPiA+IHN1YmZvbGRlcj8g
U28gaWlvL2J1ZmZlcjA6MCBpbnN0ZWFkIG9mIGlpbzpidWZmZXIwOjA/DQo+ID4gPiBQb3NzaWJs
eSBvbiB0aGUgZm9sZGVyLiAgSSBjYW4ndCBmb3IgdGhlIGxpZmUgb2YgbWUgcmVtZW1iZXIgd2h5
IEkgZGVjaWRlZA0KPiA+ID4gbm90IHRvIGRvIHRoYXQgdGhlIGZpcnN0IHRpbWUgYXJvdW5kIC0g
SSdsbCBsZWF2ZSBpdCBhdCB0aGUNCj4gPiA+IG15c3RlcmlvdXMgIml0IG1heSB0dXJuIG91dCB0
byBiZSBoYXJkZXIgdGhhbiB5b3UnZCB0aGluay4uLiINCj4gPiA+IEhvcGVmdWxseSBub3QgOykN
Cj4gPiBJIHdhcyBhbHNvIHRoaW5raW5nIGFib3V0IHRoZSAvZGV2L2lpbyBzdWJmb2xkZXIgd2hp
bGUgZG9pbmcgdGhpcy4NCj4gPiBJIGNhbiBjb3B5IHRoYXQgZnJvbSAvZGV2L2lucHV0DQo+ID4g
VGhleSBzZWVtIHRvIGRvIGl0IGFscmVhZHkuDQo+ID4gSSBkb24ndCBrbm93IGhvdyBkaWZmaWN1
bHQgaXQgd291bGQgYmUuIEJ1dCBpdCBsb29rcyBsaWtlIGEgZ29vZCBwcmVjZWRlbnQuDQo+IA0K
PiBBbGwgeW91IGhhdmUgdG8gZG8gaXMgcmV0dXJuICJpaW8vLi4uIiBmcm9tIHRoZSBkZXZub2Rl
KCkgY2FsbGJhY2suDQoNCkkgYWRtaXQgSSBkaWQgbm90IGxvb2sgY2xvc2VseSBpbnRvIGRyaXZl
cnMvaW5wdXQvaW5wdXQuYyBiZWZvcmUgbWVudGlvbmluZyB0aGlzDQphcyBhcyBnb29kIHByZWNl
ZGVudC4NCg0KQnV0LCBJIGxvb2tzIGxpa2UgL2Rldi9pbnBwdXQgaXMgYSBjbGFzcy4NCldoaWxl
IElJTyBkZXZpY2VzIGFyZSBhIGJ1c190eXBlIGRldmljZXMuDQpTaG91bGQgd2Ugc3RhcnQgaW1w
bGVtZW50aW5nIGFuIElJTyBjbGFzcz8gb3I/DQoNCg0KPiANCj4gPiBNeSBjb25jZXJuIHJlZ2Fy
ZGluZyBnb2luZyB0byB1c2Ugc3R1ZmYgZnJvbSBjb3JlIFtsaWtlDQo+ID4gZGV2aWNlX2dldF9k
ZXZub2RlKCldIGlzDQo+ID4gdGhhdCBpdCBzZWVtcyB0byBieXBhc3Mgc29tZSBsYXllcnMgb2Yg
a2VybmVsLg0KPiA+IElmIEkgZG8gJ2dpdCBncmVwIGRldmljZV9nZXRfZGV2bm9kZScsIEkgZ2V0
Og0KPiA+IA0KPiA+IGRyaXZlcnMvYmFzZS9jb3JlLmM6ICAgICAgICAgICAgbmFtZSA9IGRldmlj
ZV9nZXRfZGV2bm9kZShkZXYsICZtb2RlLCAmdWlkLA0KPiA+ICZnaWQsICZ0bXApOw0KPiA+IGRy
aXZlcnMvYmFzZS9jb3JlLmM6ICogZGV2aWNlX2dldF9kZXZub2RlIC0gcGF0aCBvZiBkZXZpY2Ug
bm9kZSBmaWxlDQo+ID4gZHJpdmVycy9iYXNlL2NvcmUuYzpjb25zdCBjaGFyICpkZXZpY2VfZ2V0
X2Rldm5vZGUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+IGRyaXZlcnMvYmFzZS9kZXZ0bXBmcy5j
OiAgICAgICAgcmVxLm5hbWUgPSBkZXZpY2VfZ2V0X2Rldm5vZGUoZGV2LA0KPiA+ICZyZXEubW9k
ZSwNCj4gPiAmcmVxLnVpZCwgJnJlcS5naWQsICZ0bXApOw0KPiA+IGRyaXZlcnMvYmFzZS9kZXZ0
bXBmcy5jOiAgICAgICAgcmVxLm5hbWUgPSBkZXZpY2VfZ2V0X2Rldm5vZGUoZGV2LCBOVUxMLA0K
PiA+IE5VTEwsDQo+ID4gTlVMTCwgJnRtcCk7DQo+ID4gaW5jbHVkZS9saW51eC9kZXZpY2UuaDpl
eHRlcm4gY29uc3QgY2hhciAqZGV2aWNlX2dldF9kZXZub2RlKHN0cnVjdCBkZXZpY2UNCj4gPiAq
ZGV2LA0KPiA+IChFTkQpDQo+ID4gDQo+ID4gU28sIGJhc2ljYWxseSwgbW9zdCB1c2VzIG9mIGRl
dmljZV9nZXRfZGV2bm9kZSgpIGFyZSBpbiBjb3JlIGNvZGUsIGFuZCBJDQo+ID4gZmVlbA0KPiA+
IHRoYXQgdGhpcyBtYXkgYmUgc2FuY3Rpb25lZCBzb21ld2hlcmUgYnkgc29tZSBjb3JlIHBlb3Bs
ZSwgaWYgSSBkbyBpdC4NCj4gPiBJIGNvdWxkIGJlIHdyb25nLCBidXQgaWYgeW91IGRpc2FncmVl
LCBJJ2xsIHRha2UgeW91ciB3b3JkIGZvciBpdC4NCj4gWW91IGFyZSBub3Qgc3VwcG9zZWQgdG8g
dXNlIHRoZSBmdW5jdGlvbiBpdHNlbGYsIHlvdSBzaG91bGQgaW1wbGVtZW50IA0KPiB0aGUgZGV2
bm9kZSgpIGNhbGxiYWNrIGZvciB0aGUgSUlPIGJ1cywgd2hpY2ggaXMgdGhlbiB1c2VkIGJ5IHRo
ZSBjb3JlIA0KPiBkZXZpY2VfZ2V0X2Rldm5vZGUoKSBmdW5jdGlvbi4NCj4gDQo=
