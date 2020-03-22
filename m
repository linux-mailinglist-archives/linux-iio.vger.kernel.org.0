Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0095D18E7B8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 10:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVJHk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 05:07:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49518 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgCVJHk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 05:07:40 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02M91tAR012077;
        Sun, 22 Mar 2020 05:02:18 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5u5sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 05:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWAvBGR/meSmimFo8lkzc2+JrJu8h9308cCWc+uIoOE188aB0OmlJls45cQtM3NP9bnC2cNQQi+ZgDULdO+f/MbzwBdWMCGWe2SvAUpoba2CHjwwkcRaqn7z4E9KUyqP0or4hR647JdEwSSk2rmTNgiPknK1oauLT1K5zU4kC9ozrxGXPuCMyvXj5UcwUe1+cYw4T/ROW19wEdErOLi5xxCXk0ATzUyU38YJWDH5CNElA90KMI9UEKY47FziOW5QdkZ+MZgXtWEMwl/DR+/B7zKCkzQPeAzp4l80c+si1KGgaP75x7BPJExuFUxPtEAm+28DPImmJ3yV6uJirkCvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ6XXth5JryQFTGY1uvhPqTT9XB6NCHiqc9HvsmaU3w=;
 b=IXL0jqxa7/w1SeoqZoMxkxcYu3lSeiiQ7g2T27gx1eWFeS45x6noEz4f/YDs/c4mPFL3vBlB6zt/RvPFXx0pO/ZxUGvF5sngA8+KBG+IeB+rt/wClDGUfA07ouRoHAv+jM1SNYk0JbkK/23K48N98f7lOjuNrDq0N828PuAwXAjh5GuWrdSb/90j3v8uuxK0563OX2mJNjBAxgD8Lru/7TEQVBk2i0j9lH2FRzQT9/jvPIR1xR2PpeFpGdyeQ2OELPN3Is6AwRdN8r7JaxnCbocyuV0SGk7waXJHcvsN1KXCGrJ7phdDkIIQYa55uDepc5sV3cX7ocdTvw5cW2eebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ6XXth5JryQFTGY1uvhPqTT9XB6NCHiqc9HvsmaU3w=;
 b=ydQ+IDpA1URPxxrYVNHp/nHRgj5cU3YAlxG+H/QGpES+ZjfdZ3p68nNSlEkNyJLZ2DodpxTC1IdXakEiWOluWuloxNbdpOIuCEnuztmc2U55ODbrSbEgz9nZclDdIfxFwd9GmdHPMne3ZLAr1e7S+VQt/dZbRzhb+BpTb4GAIuY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5370.namprd03.prod.outlook.com (2603:10b6:5:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Sun, 22 Mar
 2020 09:02:15 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 09:02:15 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "alazar@startmail.com" <alazar@startmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Topic: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Index: AQHV/sfRwss+Ix+Wf0OD4450lr/A0qhTUE4AgAAh8YCAAOFZAA==
Date:   Sun, 22 Mar 2020 09:02:15 +0000
Message-ID: <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
References: <20200320150114.9297-1-alazar@startmail.com>
         <20200320150114.9297-2-alazar@startmail.com>
         <20200321173412.52548ef1@archlinux> <20200321193541.GA16892@leena.republic>
In-Reply-To: <20200321193541.GA16892@leena.republic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d4aa8b0-5efa-410f-9980-08d7ce3fb7b3
x-ms-traffictypediagnostic: DM6PR03MB5370:
x-microsoft-antispam-prvs: <DM6PR03MB53703EDBF640AB787EA1BE79F9F30@DM6PR03MB5370.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39850400004)(366004)(396003)(199004)(6512007)(316002)(6506007)(110136005)(54906003)(91956017)(86362001)(76116006)(64756008)(66476007)(66946007)(66446008)(66556008)(71200400001)(2616005)(8676002)(966005)(8936002)(6486002)(36756003)(81166006)(81156014)(4326008)(2906002)(26005)(5660300002)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5370;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iaGwugT4lu/JsSZnn4Zd8nI2c3QZKddY+ERRpNxd6UZtFHA8C9PQsUBPlnmgNhucxL571raTG+P9RHHmlaW8hd5YI6Ve+9tpv0CGS34L+FHcdkWrwoC9ir6UEPTd8JslPSAm5YxUskN6NuK7XYPpFw7q1mGuC8bGdZySH4Uq3B6MxLTyiPJUq6xcLQ4T21TwrvaDN8FYKGaN0n+DvoUsoluTSB1p+8mW2FT//LKiuNlDzklxIsZyTHDIBIx4bTqvUck7jgfLuTEXmnCQmhcB4i6zyaMgRcWOlVugzyl+PSfjZcsK/lvfx8QSpNLo13jk83wDJgQn/DghTjz2w9n65GU68p2j5o34ERYJtfrclQ4iPJBH+xPreu4FR9Ch+IxnBQR3OcQenCJE01fdtTkgVM6NRZYAf+WPCuDeSt8k/1cUdy0+UyFajK5d39X08yAFk6G5vF4WSuzno2dokYROyUI6F4xi3Bwn/O5sxzgu82FuGLgondL+jcmWvZF2Nz6wub9IaILfw9hPyHNFNblsgg==
x-ms-exchange-antispam-messagedata: +bw797j1Tz3mGxhzmmkPnPJdXDhnDLBn2QkRdWy6nH6JO3lMsWVy7CTwfygYifTX35zg9bl4JHpF+n/yAlrwR2JlBTWkyxB/0YzFJ1APohYhBqu2Mh8LHcY8iAQDdc3uKhGKZuMHxpXNAzMNKmGzfg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD71A4379107D3469F0FF6E1DE3C04E8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4aa8b0-5efa-410f-9980-08d7ce3fb7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 09:02:15.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uo+YUk/wbTuXTmzMeC5JBFmoHu/QOPhQsqUd6mvIGpfh7V23PtAHRk6pTuE3jnP5kGZpGusp7413JIL4RdsExlVjgVuQ+q2OgcbD1RSrSYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5370
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_02:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220052
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTIxIGF0IDIxOjM1ICswMjAwLCBBbGV4YW5kcnUgTGF6YXIgd3JvdGU6
DQo+IEhpIEpvbmF0aGFuLA0KPiANCj4gPiBQbGVhc2UgY29uc2lkZXIgYWxzbyBhZGRpbmcgdGhl
IHZkZC1zdXBwbHkuDQo+ID4gSXQncyBub3QgcmVhbGx5IHJlcXVpcmVkLCBidXQgaWYgeW91IGRv
bid0IGFkZCBpdCBmcm9tIHRoZSBzdGFydA0KPiA+IGNoYW5jZXMgYXJlIGhpZ2ggdGhhdCBhdCBz
b21lIHBvaW50IHNvbWVvbmUgZWxzZSB3aWxsIG5lZWQgdG8NCj4gPiBhZGQgaXQuDQo+IA0KPiBT
b3JyeSBpZiBJJ20gbWlzc2luZyBzb21ldGhpbmcgb2J2aW91cyBoZXJlIC0tIHdoYXQgdmRkLXN1
cHBseSBpcw0KPiB0aGF0PyBBcmUgeW91IHRoaW5raW5nIG9mIHRoZSByZWd1bGF0b3IgdXNlZCBm
b3IgdGhlIEFEQydzIHJlZmVyZW5jZQ0KPiB2b2x0YWdlPyBUaGF0J3MgYWxyZWFkeSB0aGVyZSAo
dnJlZi1zdXBwbHkpLg0KPiANCj4gT3IgZGlkIHlvdSBtZWFuIEkgc2hvdWxkIGFkZCBhIGRlZmlu
aXRpb24gZm9yIHRoZSByZWd1bGF0b3Igb3V0cHV0IHVzZWQNCj4gZm9yIHRoZSBkZXZpY2UncyBW
ZGQgaW5wdXQgKGkuZS4gdGhlIHBvc2l0aXZlIHN1cHBseSB2b2x0YWdlKT8gTmVlZGxlc3MNCj4g
dG8gc2F5LCBJJ20gaGFwcHkgdG8gYWRkIGl0IGlmIHlvdSB0aGluayBpdCdzIGEgZ29vZCBpZGVh
LiBJdCdzIGp1c3QgSQ0KPiBkb24ndCB0aGluayBJJ3ZlIHNlZW4gaXQgaW4gb3RoZXIgZHJpdmVy
cyAoZXhjZXB0IG1heWJlIGFkNzE5Mj8pIC0tIHNvIEkNCj4gZmlndXJlZCBJJ2QgYXNrIGJlZm9y
ZSBzZW5kaW5nIGEgYm90Y2hlZCB2NS4NCj4gDQoNClllcC4NCkpvbmF0aGFuIHJlZmVycyB0byBW
ZGQgaW5wdXQvcGluIFtvbiB0aGUgY2hpcF0gd2hpY2ggaXMgZGlmZmVyZW50IGZyb20gVnJlZiBb
UkVGDQpwaW5dLg0KTm90IGFsbCBkcml2ZXJzIGRlZmluZSBWZGQuDQpTb21lIGNhbGwgaXQgQVZk
ZC4NCg0KWW91IGNhbiBjaGVjayB2aWE6ICBnaXQgZ3JlcCAtaSB2ZGQgfCBjdXQgLWQ6IC1mMSB8
IHNvcnQgfCB1bmlxIC1jDQppbiB0aGUgZHJpdmVycy9paW8gZm9sZGVyIA0KDQpJdCdzIGFuIGlk
ZWEgdG8gYWRkIGl0LCBhbmQgdGhhdCBjYW4gZ2l2ZSBjb250cm9sIHRvIHRoZSBkcml2ZXIgdG8g
cG93ZXItdXAgdGhlDQpBREMsIGJ5IGRlZmluaW5nIGEgcmVndWxhdG9yIFt2ZGQtc3VwcGx5XSBp
biB0aGUgZGV2aWNlLXRyZWUuDQoNCk1heWJlIGl0IGNvdWxkIGJlIGludGVyZXN0aW5nIHRvIG1v
dmUgdGhpcyB0byB0aGUgSUlPIGNvcmUgYXMgYW4gb3B0aW9uLWZsYWcuDQpbQnV0IHRoYXQncyBh
bm90aGVyIGRpc2N1c3Npb25dDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBBbGV4DQo+IA0KPiA+IE9u
ZSB0cml2aWFsIHRoaW5nIGlubGluZS4gIE90aGVyd2lzZSBsb29rcyBnb29kIHRvIG1lLg0KPiA+
IA0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2JpbmRpbmdzL2lpby9hZGMvbWF4aW0sbWF4MTI0MS55
YW1sICAgICAgIHwgNjEgKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA2MSBpbnNlcnRpb25zKCspDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9tYXhpbSxtYXgxMjQxLnlhbWwN
Cj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9paW8vYWRjL21heGltLG1heDEyNDEueWFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9tYXhpbSxtYXgxMjQxLnlhbWwNCj4gPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmRlNDFkNDIyY2UzYg0K
PiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9hZGMvbWF4aW0sbWF4MTI0MS55YW1sDQo+ID4gPiBAQCAtMCwwICsxLDYx
IEBADQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ID4gKyMg
Q29weXJpZ2h0IDIwMjAgSW9hbi1BbGV4YW5kcnUgTGF6YXINCj4gPiA+ICslWUFNTCAxLjINCj4g
PiA+ICstLS0NCj4gPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9h
ZGMvbWF4aW0sbWF4MTI0MS55YW1sIw0KPiA+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ID4gKw0KPiA+ID4gK3RpdGxlOiBNYXhp
bSBNQVgxMjQxIDEyLWJpdCwgc2luZ2xlLWNoYW5uZWwgYW5hbG9nIHRvIGRpZ2l0YWwgY29udmVy
dGVyDQo+ID4gPiArDQo+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiArICAtIElvYW4tQWxleGFu
ZHJ1IExhemFyIDxhbGF6YXJAc3RhcnRtYWlsLmNvbT4NCj4gPiA+ICsNCj4gPiA+ICtkZXNjcmlw
dGlvbjogfA0KPiA+ID4gKyAgQmluZGluZ3MgZm9yIHRoZSBtYXgxMjQxIDEyLWJpdCwgc2luZ2xl
LWNoYW5uZWwgQURDIGRldmljZS4gVGhpcw0KPiA+ID4gKyAgZHJpdmVyIHN1cHBvcnRzIHZvbHRh
Z2UgcmVhZGluZyBhbmQgY2FuIG9wdGlvbmFsbHkgYmUgY29uZmlndXJlZCBmb3INCj4gPiANCj4g
PiBEcml2ZXIgc2hvdWxkbid0IGJlIG1lbnRpb25lZCBpbiB0aGUgYmluZGluZy4gSXQncyBhIGRl
c2NyaXB0aW9uIG9mIHRoZQ0KPiA+IGhhcmR3YXJlIG9ubHkuDQo+ID4gDQo+ID4gPiArICBwb3dl
ci1kb3duIG1vZGUgb3BlcmF0aW9uLiBUaGUgZGF0YXNoZWV0IGNhbiBiZSBmb3VuZCBhdDoNCj4g
PiA+ICsgICAgaHR0cHM6Ly9kYXRhc2hlZXRzLm1heGltaW50ZWdyYXRlZC5jb20vZW4vZHMvTUFY
MTI0MC1NQVgxMjQxLnBkZg0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBj
b21wYXRpYmxlOg0KPiA+ID4gKyAgICBlbnVtOg0KPiA+ID4gKyAgICAgIC0gbWF4aW0sbWF4MTI0
MQ0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4g
Kw0KPiA+ID4gKyAgdnJlZi1zdXBwbHk6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4g
KyAgICAgIERldmljZSB0cmVlIGlkZW50aWZpZXIgb2YgdGhlIHJlZ3VsYXRvciB0aGF0IHByb3Zp
ZGVzIHRoZSBleHRlcm5hbA0KPiA+ID4gKyAgICAgIHJlZmVyZW5jZSB2b2x0YWdlLg0KPiA+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgc2hkbi1ncGlvczoNCj4gPiA+ICsg
ICAgZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgR1BJTyBzcGVjIGZvciB0aGUgR1BJTyBwaW4g
Y29ubmVjdGVkIHRvIHRoZSBBREMncyAvU0hETiBwaW4uIElmDQo+ID4gPiArICAgICAgc3BlY2lm
aWVkLCB0aGUgL1NIRE4gcGluIHdpbGwgYmUgYXNzZXJ0ZWQgYmV0d2VlbiBjb252ZXJzaW9ucywN
Cj4gPiA+ICsgICAgICB0aHVzIGVuYWJsaW5nIHBvd2VyLWRvd24gbW9kZS4NCj4gPiA+ICsgICAg
bWF4SXRlbXM6IDENCj4gPiA+ICsNCj4gPiA+ICtyZXF1aXJlZDoNCj4gPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ID4gKyAgLSByZWcNCj4gPiA+ICsgIC0gdnJlZi1zdXBwbHkNCj4gPiA+ICsNCj4g
PiA+ICtleGFtcGxlczoNCj4gPiA+ICsgIC0gfA0KPiA+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ID4gPiArICAgIHNwaTAgew0KPiA+ID4gKyAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiA+ID4gKyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ID4g
Kw0KPiA+ID4gKyAgICAgICAgYWRjQDAgew0KPiA+ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAibWF4aW0sbWF4MTI0MSI7DQo+ID4gPiArICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ID4g
KyAgICAgICAgICAgIHZyZWYtc3VwcGx5ID0gPCZ2ZGRfM3YzX3JlZz47DQo+ID4gPiArICAgICAg
ICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMD47DQo+ID4gPiArICAgICAgICAgICAg
c2hkbi1ncGlvcyA9IDwmZ3BpbyAyNiAxPjsNCj4gPiA+ICsgICAgICAgIH07DQo+ID4gPiArICAg
IH07DQo+ID4gPiArDQo+ID4gPiArDQo=
