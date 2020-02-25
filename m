Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407AC16E9E6
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgBYPVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 10:21:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26978 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731009AbgBYPVl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 10:21:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PFEtqS011888;
        Tue, 25 Feb 2020 10:21:24 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yay1bs8y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 10:21:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNp6WZs9BDZfTaODPi31ehgHxxu7GujzyRxLTyHxPeJ4ek9QD20qUfaXTB7RR6tu0I+rdcb7HQJ7G5Wo6K3yepiH0mJoIbhEj8PtE54e6EA2F8vdE+hVT3NNfTNsdR5CYdv/MhoL+KB8GlN6h8lAPV1O2ExBjOWstqaEQzHbdCr70WfQ5n/NO0658Vb2o0csDL9k67/mWaZVxSfi4P08iZlf7AqA7FyzYmCUhMKYa9hd05ZTXtP1/h84Cfu+IjIw6PrTib2tjg59ndyG5k+Wc2g8WWQisDV5payffUZBSMAb4UTrhjHgMGQHMbFxiMgDZZVE0do5Qagvfqfg2OTJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zil8GdiDx6W7ukTPG4XwLaoyP4XodaC/N+An9i75OI4=;
 b=l82mXKLWkyh1Cicf1TytSdtiuDcF50GAWEQrqebXM11hqUVP/dxxjZLVZLV65aePFQ69umdWOsPCx8L7735MWTVXT1scGTNFEFIvr4CU/qMsnA2chv0X0gQeM1MvnH17Aqy7IAL+MSaZfI7RSkpQNs5lnAjzz7DFDKPgbgJE+IeLsjWks8SbPvK2HYwzSltyxaLKnrCUDL1nAk5hjKOtM8fhFp6RZPfx7jZrS/GXOmpyV3Q5n+BE1CW4e+G9kzHtUdxwjJ/OjIe0Oot0yHdC54IF/IK02Ma1Kq5HIipGORtZGoK0/+j6WFBxi9PYAaiIM4F4v6NWyVqE/ySJ0Ai0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zil8GdiDx6W7ukTPG4XwLaoyP4XodaC/N+An9i75OI4=;
 b=ccKGMKayUa37eodQjZ0+Rmug4VjYenZnWyZL5d3VNyjuYL6kXF+dOM0xHnsoTcnHvkQp6X1y3NPO4LShPtTt6EagbxBALuA9oEE7SwECEAt+zDerQ9D4Zzi5+PW03MNTY3KjyEYZXW8ojzXGLclfbg2qK9Fu48PtOUQaXyGErDE=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5175.namprd03.prod.outlook.com (2603:10b6:610:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 15:21:22 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 15:21:22 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 4/5] iio: adc: ad9467: add support AD9467 ADC
Thread-Topic: [PATCH 4/5] iio: adc: ad9467: add support AD9467 ADC
Thread-Index: AQHV5/6TmWt0qrGUXEeLBNPyiRywf6glnRUAgAZxZgA=
Date:   Tue, 25 Feb 2020 15:21:22 +0000
Message-ID: <85922ce6cd037958e5c53138be8219141d00f699.camel@analog.com>
References: <20200220150317.1864-1-alexandru.ardelean@analog.com>
         <20200220150317.1864-4-alexandru.ardelean@analog.com>
         <20200221125756.77e1e098@archlinux>
In-Reply-To: <20200221125756.77e1e098@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1624d5eb-da9b-449a-db70-08d7ba065f4b
x-ms-traffictypediagnostic: CH2PR03MB5175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5175EFEB59D1800B83590064F9ED0@CH2PR03MB5175.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(30864003)(64756008)(6486002)(6512007)(316002)(71200400001)(66556008)(2616005)(91956017)(5660300002)(76116006)(66446008)(36756003)(186003)(2906002)(6916009)(86362001)(966005)(8676002)(66946007)(66476007)(81156014)(54906003)(478600001)(8936002)(4326008)(26005)(6506007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5175;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HctvI36sYXcCkVlH+8mvI6WI/8NB+Tphh1rFVqG4VhlsygZJYGIQnLU3o2rN4y1oO8kM6NXbey8bMIY35SgjRL/noDsewWjh/ZFuCRgtzhUnEHPpv3hEzTa6AZV9hmrwaUAkZtTP/HEXqQuRKPUD6txTs3XEAABD5GkLQvdKUcr1GraP1kPP8jM95trJjfbYfip20YOVoP9QISSPDKDcIrYgac5W1eM/Y71xIZMQEM0X0TcRiXSTwiDI+oPBTvyeItkNlrOlIl/1OKF160X4OtANqjsgjpwn3Z/Py4PPVhPnTPUOyLt+feU9IAcROXcwRRhsJUgkpmz5Gdz2JhMIbGxi4pVA17zPQt/IaXlAilvq7gEcBSp50EgfeFRB2OxNykw57YIT3FJJGvGoM3C0Muf/7rDF+dztcS61h8tBpwePjolChha8yQrOVabUt7S4R5B/R5zta2ANP07S17zPClCkSP5I0CnbhZMp25zqKJVlTgvG45ezdMCyj8IfRIrqowbGNyCCyo+dd9sLOsFBUQ==
x-ms-exchange-antispam-messagedata: Jj1hLMLBVk4n33FhmEnHzlPZwI/j5/akeYjbY9TJl8HLcrfgxHKHFYz8xr+LB7mAWDVF1eF2Bl5xLmaxPAXslnrEFhiQ4P/1TzXmZwm9tPqpvGMQZ/aS36tv95+YmEvogbZtEfZtRdJtzr+JprNN9g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <24F84D860EADC54FA51EF3BB1601D212@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1624d5eb-da9b-449a-db70-08d7ba065f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 15:21:22.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 739b6pAmHhzVeGaql6SK5zZ5PqYAU64PIK0WQbOxq2SJ5GDyq1jVUm3ZV8T8DzhZ/vj1PQi13X9vuxPXwHgVA4c5zUTugN3b+4FrhTCgaxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5175
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_05:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTIxIGF0IDEyOjU3ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUsIDIwIEZlYiAyMDIwIDE3OjAzOjE2ICswMjAwDQo+IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9t
OiBNaWNoYWVsIEhlbm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gPiAN
Cj4gPiBUaGUgQUQ5NDY3IGlzIGEgMTYtYml0LCBtb25vbGl0aGljLCBJRiBzYW1wbGluZyBhbmFs
b2ctdG8tZGlnaXRhbCBjb252ZXJ0ZXINCj4gPiAoQURDKS4gSXQgaXMgb3B0aW1pemVkIGZvciBo
aWdoIHBlcmZvcm1hbmNlb3ZlciB3aWRlIGJhbmR3aWR0aHMgYW5kIGVhc2Ugb2YNCj4gPiB1c2Uu
IFRoZSBwcm9kdWN0IG9wZXJhdGVzIGF0IGEgMjUwIE1TUFMgY29udmVyc2lvbiByYXRlIGFuZCBp
cyBkZXNpZ25lZCBmb3INCj4gPiB3aXJlbGVzcyByZWNlaXZlcnMsIGluc3RydW1lbnRhdGlvbiwg
YW5kIHRlc3QgZXF1aXBtZW50IHRoYXQgcmVxdWlyZSBhIGhpZ2gNCj4gPiBkeW5hbWljIHJhbmdl
LiBUaGUgQURDIHJlcXVpcmVzIDEuOCBWIGFuZCAzLjMgViBwb3dlciBzdXBwbGllcyBhbmQgYSBs
b3cNCj4gPiB2b2x0YWdlIGRpZmZlcmVudGlhbCBpbnB1dCBjbG9jayBmb3IgZnVsbCBwZXJmb3Jt
YW5jZSBvcGVyYXRpb24uIE5vDQo+ID4gZXh0ZXJuYWwgcmVmZXJlbmNlIG9yIGRyaXZlciBjb21w
b25lbnRzIGFyZSByZXF1aXJlZCBmb3IgbWFueSBhcHBsaWNhdGlvbnMuDQo+ID4gRGF0YSBvdXRw
dXRzIGFyZSBMVkRTIGNvbXBhdGlibGUgKEFOU0ktNjQ0IGNvbXBhdGlibGUpIGFuZCBpbmNsdWRl
IHRoZQ0KPiA+IG1lYW5zIHRvIHJlZHVjZSB0aGUgb3ZlcmFsbCBjdXJyZW50IG5lZWRlZCBmb3Ig
c2hvcnQgdHJhY2UgZGlzdGFuY2VzLg0KPiA+IA0KPiA+IFNpbmNlIHRoZSBjaGlwIGNhbiBvcGVy
YXRlIGF0IHN1Y2ggaGlnaCBzYW1wbGUtcmF0ZXMgKG11Y2ggaGlnaGVyIHRoYW4NCj4gPiBjbGFz
c2ljYWwgaW50ZXJmYWNlcyksIGl0IHJlcXVpcmVzIHRoYXQgYSBETUEgY29udHJvbGxlciBiZSB1
c2VkIHRvDQo+ID4gaW50ZXJmYWNlIGRpcmVjdGx5IHRvIHRoZSBjaGlwIGFuZCBwdXNoIGRhdGEg
aW50byBtZW1vcnkuDQo+ID4gVHlwaWNhbGx5LCB0aGUgQVhJIEFEQyBJUCBjb3JlIGlzIHVzZWQg
dG8gaW50ZXJmYWNlIHdpdGggaXQuDQo+ID4gDQo+ID4gTGluazogDQo+ID4gaHR0cHM6Ly93d3cu
YW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRhLXNoZWV0cy9B
RDk0NjcucGRmDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxs
YXJzQG1ldGFmb28uZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBIZW5uZXJpY2ggPG1p
Y2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1
IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gDQo+IEEgZmV3IG1p
bm9yIHRoaW5ncyBpbmxpbmUuDQo+IA0KPiBKb25hdGhhbg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2lpby9hZGMvS2NvbmZpZyAgfCAgMTUgKysNCj4gPiAgZHJpdmVycy9paW8vYWRjL01ha2VmaWxl
IHwgICAxICsNCj4gPiAgZHJpdmVycy9paW8vYWRjL2FkOTQ2Ny5jIHwgNDQ3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDQ2MyBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lpby9hZGMvYWQ5
NDY3LmMNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL0tjb25maWcgYi9k
cml2ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiA+IGluZGV4IDZjZDQ4YTI1NjEyMi4uMjI5YjhiYzZm
OWI2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9LY29uZmlnDQo+ID4gKysrIGIv
ZHJpdmVycy9paW8vYWRjL0tjb25maWcNCj4gPiBAQCAtMjQ2LDYgKzI0NiwyMSBAQCBjb25maWcg
QUQ3OTlYDQo+ID4gIAkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29z
ZSBNIGhlcmU6IHRoZSBtb2R1bGUgd2lsbCBiZQ0KPiA+ICAJICBjYWxsZWQgYWQ3OTl4Lg0KPiA+
ICANCj4gPiArY29uZmlnIEFEOTQ2Nw0KPiA+ICsJdHJpc3RhdGUgIkFuYWxvZyBEZXZpY2VzIEFE
OTQ2NyBIaWdoIFNwZWVkIEFEQyBkcml2ZXIiDQo+ID4gKwlkZXBlbmRzIG9uIFNQSQ0KPiA+ICsJ
c2VsZWN0IEFYSV9BREMNCj4gPiArCWhlbHANCj4gPiArCSAgU2F5IHllcyBoZXJlIHRvIGJ1aWxk
IHN1cHBvcnQgZm9yIEFuYWxvZyBEZXZpY2VzOg0KPiA+ICsJICAqIEFEOTQ2NyAxNi1CaXQsIDIw
MCBNU1BTLzI1MCBNU1BTIEFuYWxvZy10by1EaWdpdGFsIENvbnZlcnRlcg0KPiA+ICsNCj4gPiAr
CSAgVGhlIGRyaXZlciByZXF1aXJlcyB0aGUgYXNzaXN0YW5jZSBvZiB0aGUgQVhJIEFEQyBJUCBj
b3JlIHRvIG9wZXJhdGUsDQo+ID4gKwkgIHNpbmNlIFNQSSBpcyB1c2VkIGZvciBjb25maWd1cmF0
aW9uIG9ubHksIHdoaWxlIGRhdGEgaGFzIHRvIGJlDQo+ID4gKwkgIHN0cmVhbWVkIGludG8gbWVt
b3J5IHZpYSBETUEuDQo+ID4gKw0KPiA+ICsJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEg
bW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwgYmUNCj4gPiArCSAgY2FsbGVk
IGFkOTQ2Ny4NCj4gPiArDQo+ID4gIGNvbmZpZyBBU1BFRURfQURDDQo+ID4gIAl0cmlzdGF0ZSAi
QXNwZWVkIEFEQyINCj4gPiAgCWRlcGVuZHMgb24gQVJDSF9BU1BFRUQgfHwgQ09NUElMRV9URVNU
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9NYWtlZmlsZSBiL2RyaXZlcnMvaWlv
L2FkYy9NYWtlZmlsZQ0KPiA+IGluZGV4IGUxNGZhYmQ1MzI0Ni4uNTAxODIyMGI4ZWM3IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMv
aWlvL2FkYy9NYWtlZmlsZQ0KPiA+IEBAIC0yNiw2ICsyNiw3IEBAIG9iai0kKENPTkZJR19BRDc3
OTMpICs9IGFkNzc5My5vDQo+ID4gIG9iai0kKENPTkZJR19BRDc4ODcpICs9IGFkNzg4Ny5vDQo+
ID4gIG9iai0kKENPTkZJR19BRDc5NDkpICs9IGFkNzk0OS5vDQo+ID4gIG9iai0kKENPTkZJR19B
RDc5OVgpICs9IGFkNzk5eC5vDQo+ID4gK29iai0kKENPTkZJR19BRDk0NjcpICs9IGFkOTQ2Ny5v
DQo+ID4gIG9iai0kKENPTkZJR19BU1BFRURfQURDKSArPSBhc3BlZWRfYWRjLm8NCj4gPiAgb2Jq
LSQoQ09ORklHX0FUOTFfQURDKSArPSBhdDkxX2FkYy5vDQo+ID4gIG9iai0kKENPTkZJR19BVDkx
X1NBTUE1RDJfQURDKSArPSBhdDkxLXNhbWE1ZDJfYWRjLm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vYWRjL2FkOTQ2Ny5jIGIvZHJpdmVycy9paW8vYWRjL2FkOTQ2Ny5jDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmYyNjhiYmI2YmNmNg0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ5NDY3LmMNCj4g
PiBAQCAtMCwwICsxLDQ0NyBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5DQo+ID4gKy8qDQo+ID4gKyAqIEFuYWxvZyBEZXZpY2VzIEFEOTQ2NyBTUEkgQURD
IGRyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAxMi0yMDIwIEFuYWxvZyBEZXZp
Y2VzIEluYy4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2tl
cm5lbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvc3BpL3NwaS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9kZWxheS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9p
aW8vaWlvLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMuaD4NCj4gPiArDQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9paW8v
YWRjL2F4aS1hZGMuaD4NCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIEFESSBIaWdoLVNwZWVkIEFE
QyBjb21tb24gc3BpIGludGVyZmFjZSByZWdpc3RlcnMNCj4gPiArICogU2VlIEFwcGxpY2F0aW9u
LU5vdGUgQU4tODc3Og0KPiA+ICsgKiAgIA0KPiA+IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVk
aWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vYXBwbGljYXRpb24tbm90ZXMvQU4tODc3LnBk
Zg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNkZWZpbmUgQURJX0FEQ19SRUdfQ0hJUF9QT1JUX0NP
TkYJCTB4MDANCj4gDQo+IFRoZXNlIHByZWZpeGVzIHNob3VsZCByZWZsZWN0IHRoZSBjaGlwIHdl
IGFyZSBzdXBwb3J0aW5nIGhlcmUuDQo+IFRoZXkgYXJlbid0IHRydWUgZm9yICdhbGwnIEFESSBw
YXJ0cy4gIA0KPiANCj4gWW91IGNvdWxkIGNvbWUgdXAgd2l0aCBzb21lICdnZW5lcmljJyBidXQg
bm90IHRvIGdlbmVyaWMgcHJlZml4DQo+IGlmIHlvdSBwcmVmZXIuDQoNClRoZSByZWdzIGFyZSBk
ZWZpbmVkIGluIHRoZSBBTi04NzcgZG9jIHJlZmVyZW5jZXMgYWJvdmUsIGJ1dCB5ZWFoLi4uIHRo
ZXkncmUgbm90DQp2ZXJ5IGdlbmVyaWMgdG8gYWxsIEFEQ3MuDQpNb3N0bHkgdG8gdGhpcyBmYW1p
bHkgW3N1cHBvcnRlZCBieSB0aGlzIGRyaXZlcl0uDQpJJ2xsIGNoYW5nZSBpdC4NCg0KPiANCj4g
PiArI2RlZmluZSBBRElfQURDX1JFR19DSElQX0lECQkJMHgwMQ0KPiA+ICsjZGVmaW5lIEFESV9B
RENfUkVHX0NISVBfR1JBREUJCQkweDAyDQo+ID4gKyNkZWZpbmUgQURJX0FEQ19SRUdfQ0hBTl9J
TkRFWAkJCTB4MDUNCj4gPiArI2RlZmluZSBBRElfQURDX1JFR19UUkFOU0ZFUgkJCTB4RkYNCj4g
PiArI2RlZmluZSBBRElfQURDX1JFR19NT0RFUwkJCTB4MDgNCj4gPiArI2RlZmluZSBBRElfQURD
X1JFR19URVNUX0lPCQkJMHgwRA0KPiA+ICsjZGVmaW5lIEFESV9BRENfUkVHX0FEQ19JTlBVVAkJ
CTB4MEYNCj4gPiArI2RlZmluZSBBRElfQURDX1JFR19PRkZTRVQJCQkweDEwDQo+ID4gKyNkZWZp
bmUgQURJX0FEQ19SRUdfT1VUUFVUX01PREUJCQkweDE0DQo+ID4gKyNkZWZpbmUgQURJX0FEQ19S
RUdfT1VUUFVUX0FESlVTVAkJMHgxNQ0KPiA+ICsjZGVmaW5lIEFESV9BRENfUkVHX09VVFBVVF9Q
SEFTRQkJMHgxNg0KPiA+ICsjZGVmaW5lIEFESV9BRENfUkVHX09VVFBVVF9ERUxBWQkJMHgxNw0K
PiA+ICsjZGVmaW5lIEFESV9BRENfUkVHX1ZSRUYJCQkweDE4DQo+ID4gKyNkZWZpbmUgQURJX0FE
Q19SRUdfQU5BTE9HX0lOUFVUCQkweDJDDQo+ID4gKw0KPiA+ICsvKiBBRElfQURDX1JFR19URVNU
X0lPICovDQo+ID4gKyNkZWZpbmUgQURJX0FEQ19URVNUTU9ERV9PRkYJCQkweDANCj4gPiArI2Rl
ZmluZSBBRElfQURDX1RFU1RNT0RFX01JRFNDQUxFX1NIT1JUCQkweDENCj4gPiArI2RlZmluZSBB
RElfQURDX1RFU1RNT0RFX1BPU19GVUxMU0NBTEUJCTB4Mg0KPiA+ICsjZGVmaW5lIEFESV9BRENf
VEVTVE1PREVfTkVHX0ZVTExTQ0FMRQkJMHgzDQo+ID4gKyNkZWZpbmUgQURJX0FEQ19URVNUTU9E
RV9BTFRfQ0hFQ0tFUkJPQVJECTB4NA0KPiA+ICsjZGVmaW5lIEFESV9BRENfVEVTVE1PREVfUE4y
M19TRVEJCTB4NQ0KPiA+ICsjZGVmaW5lIEFESV9BRENfVEVTVE1PREVfUE45X1NFUQkJMHg2DQo+
ID4gKyNkZWZpbmUgQURJX0FEQ19URVNUTU9ERV9PTkVfWkVST19UT0dHTEUJMHg3DQo+ID4gKyNk
ZWZpbmUgQURJX0FEQ19URVNUTU9ERV9VU0VSCQkJMHg4DQo+ID4gKyNkZWZpbmUgQURJX0FEQ19U
RVNUTU9ERV9CSVRfVE9HR0xFCQkweDkNCj4gPiArI2RlZmluZSBBRElfQURDX1RFU1RNT0RFX1NZ
TkMJCQkweEENCj4gPiArI2RlZmluZSBBRElfQURDX1RFU1RNT0RFX09ORV9CSVRfSElHSAkJMHhC
DQo+ID4gKyNkZWZpbmUgQURJX0FEQ19URVNUTU9ERV9NSVhFRF9CSVRfRlJFUVVFTkNZCTB4Qw0K
PiA+ICsjZGVmaW5lIEFESV9BRENfVEVTVE1PREVfUkFNUAkJCTB4Rg0KPiA+ICsNCj4gPiArLyog
QURJX0FEQ19SRUdfVFJBTlNGRVIgKi8NCj4gPiArI2RlZmluZSBBRElfQURDX1RSQU5TRkVSX1NZ
TkMJCQkweDENCj4gPiArDQo+ID4gKy8qIEFESV9BRENfUkVHX09VVFBVVF9NT0RFICovDQo+ID4g
KyNkZWZpbmUgQURJX0FEQ19PVVRQVVRfTU9ERV9PRkZTRVRfQklOQVJZCTB4MA0KPiA+ICsjZGVm
aW5lIEFESV9BRENfT1VUUFVUX01PREVfVFdPU19DT01QTEVNRU5UCTB4MQ0KPiA+ICsjZGVmaW5l
IEFESV9BRENfT1VUUFVUX01PREVfR1JBWV9DT0RFCQkweDINCj4gPiArDQo+ID4gKy8qIEFESV9B
RENfUkVHX09VVFBVVF9QSEFTRSAqLw0KPiA+ICsjZGVmaW5lIEFESV9BRENfT1VUUFVUX0VWRU5f
T0REX01PREVfRU4JCTB4MjANCj4gPiArI2RlZmluZSBBRElfQURDX0lOVkVSVF9EQ09fQ0xLCQkJ
MHg4MA0KPiA+ICsNCj4gPiArLyogQURJX0FEQ19SRUdfT1VUUFVUX0RFTEFZICovDQo+ID4gKyNk
ZWZpbmUgQURJX0FEQ19EQ09fREVMQVlfRU5BQkxFCQkweDgwDQo+ID4gKw0KPiA+ICsvKg0KPiA+
ICsgKiBBbmFsb2cgRGV2aWNlcyBBRDk0NjcgMTYtQml0LCAyMDAvMjUwIE1TUFMgQURDDQo+ID4g
KyAqLw0KPiA+ICsNCj4gPiArI2RlZmluZSBDSElQSURfQUQ5NDY3CQkJMHg1MA0KPiA+ICsjZGVm
aW5lIEFEOTQ2N19ERUZfT1VUUFVUX01PREUJCTB4MDgNCj4gPiArI2RlZmluZSBBRDk0NjdfUkVH
X1ZSRUZfTUFTSwkJMHgwRg0KPiA+ICsNCj4gPiArZW51bSB7DQo+ID4gKwlJRF9BRDk0NjcsDQo+
ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYWQ5NDY3X3N0YXRlIHsNCj4gPiArCXN0cnVjdCBz
cGlfZGV2aWNlCQkqc3BpOw0KPiA+ICsJc3RydWN0IGNsawkJCSpjbGs7DQo+ID4gKwl1bnNpZ25l
ZCBpbnQJCQlvdXRwdXRfbW9kZTsNCj4gPiArDQo+ID4gKwlzdHJ1Y3QgZ3Bpb19kZXNjCQkqcHdy
ZG93bl9ncGlvOw0KPiA+ICsJc3RydWN0IGdwaW9fZGVzYwkJKnJlc2V0X2dwaW87DQo+ID4gK307
DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkOTQ2N19zcGlfcmVhZChzdHJ1Y3Qgc3BpX2Rldmlj
ZSAqc3BpLCB1bnNpZ25lZCBpbnQgcmVnKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBjaGFyIGJ1
ZlszXTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJYnVmWzBdID0gMHg4MCB8IChyZWcg
Pj4gOCk7DQo+ID4gKwlidWZbMV0gPSByZWcgJiAweEZGOw0KPiA+ICsNCj4gPiArCXJldCA9IHNw
aV93cml0ZV90aGVuX3JlYWQoc3BpLCAmYnVmWzBdLCAyLCAmYnVmWzJdLCAxKTsNCj4gPiArDQo+
ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXJldHVy
biBidWZbMl07DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYWQ5NDY3X3NwaV93cml0
ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCB1bnNpZ25lZCBpbnQgcmVnLA0KPiA+ICsJCQkgICAg
dW5zaWduZWQgaW50IHZhbCkNCj4gPiArew0KPiA+ICsJdW5zaWduZWQgY2hhciBidWZbM107DQo+
ID4gKw0KPiA+ICsJYnVmWzBdID0gcmVnID4+IDg7DQo+ID4gKwlidWZbMV0gPSByZWcgJiAweEZG
Ow0KPiA+ICsJYnVmWzJdID0gdmFsOw0KPiA+ICsNCj4gPiArCXJldHVybiBzcGlfd3JpdGUoc3Bp
LCBidWYsIEFSUkFZX1NJWkUoYnVmKSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQg
YWQ5NDY3X3JlZ19hY2Nlc3Moc3RydWN0IGF4aV9hZGNfY29udiAqY29udiwgdW5zaWduZWQgaW50
IHJlZywNCj4gPiArCQkJICAgICB1bnNpZ25lZCBpbnQgd3JpdGV2YWwsIHVuc2lnbmVkIGludCAq
cmVhZHZhbCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGFkOTQ2N19zdGF0ZSAqc3QgPSBheGlfYWRj
X2NvbnZfcHJpdihjb252KTsNCj4gPiArCXN0cnVjdCBzcGlfZGV2aWNlICpzcGkgPSBzdC0+c3Bp
Ow0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlpZiAocmVhZHZhbCA9PSBOVUxMKSB7DQo+
ID4gKwkJcmV0ID0gYWQ5NDY3X3NwaV93cml0ZShzcGksIHJlZywgd3JpdGV2YWwpOw0KPiA+ICsJ
CWFkOTQ2N19zcGlfd3JpdGUoc3BpLCBBRElfQURDX1JFR19UUkFOU0ZFUiwNCj4gPiArCQkJCSBB
RElfQURDX1RSQU5TRkVSX1NZTkMpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gYWQ5NDY3X3NwaV9yZWFkKHNwaSwgcmVnKTsNCj4gPiArCWlmIChyZXQg
PCAwKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwkqcmVhZHZhbCA9IHJldDsNCj4gPiArDQo+
ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHVuc2lnbmVk
IGludCBhZDk0Njdfc2NhbGVfdGFibGVbXVsyXSA9IHsNCj4gPiArCXsyMDAwLCAwfSwgezIxMDAs
IDZ9LCB7MjIwMCwgN30sDQo+ID4gKwl7MjMwMCwgOH0sIHsyNDAwLCA5fSwgezI1MDAsIDEwfSwN
Cj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIF9fYWQ5NDY3X2dldF9zY2FsZShzdHJ1
Y3QgYXhpX2FkY19jb252ICpjb252LCBpbnQgaW5kZXgsDQo+ID4gKwkJCSAgICAgICB1bnNpZ25l
ZCBpbnQgKnZhbCwgdW5zaWduZWQgaW50ICp2YWwyKQ0KPiA+ICt7DQo+ID4gKwljb25zdCBzdHJ1
Y3QgYXhpX2FkY19jaGlwX2luZm8gKmluZm8gPSBjb252LT5jaGlwX2luZm87DQo+ID4gKwljb25z
dCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hhbiA9ICZpbmZvLT5jaGFubmVsc1swXS5paW9fY2hh
bjsNCj4gPiArCXVuc2lnbmVkIGludCB0bXA7DQo+ID4gKw0KPiA+ICsJdG1wID0gKGluZm8tPnNj
YWxlX3RhYmxlW2luZGV4XVswXSAqIDEwMDAwMDBVTEwpID4+DQo+ID4gKwkJCWNoYW4tPnNjYW5f
dHlwZS5yZWFsYml0czsNCj4gPiArCSp2YWwgPSB0bXAgLyAxMDAwMDAwOw0KPiA+ICsJKnZhbDIg
PSB0bXAgJSAxMDAwMDAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsjZGVmaW5lIEFEOTQ2N19DSEFO
KF9jaGFuLCBfc2ksIF9iaXRzLCBfc2lnbikJCQkJDQo+ID4gXA0KPiA+ICt7CQkJCQkJCQkJXA0K
PiA+ICsJLnR5cGUgPSBJSU9fVk9MVEFHRSwJCQkJCQlcDQo+ID4gKwkuaW5kZXhlZCA9IDEsCQkJ
CQkJCVwNCj4gPiArCS5jaGFubmVsID0gX2NoYW4sCQkJCQkJXA0KPiA+ICsJLmluZm9fbWFza19z
ZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX0NBTElCU0NBTEUpIHwJCVwNCj4gPiArCQlCSVQo
SUlPX0NIQU5fSU5GT19DQUxJQkJJQVMpIHwJCQkJXA0KPiA+ICsJCUJJVChJSU9fQ0hBTl9JTkZP
X0NBTElCUEhBU0UpIHwJCQkJXA0KPiANCj4gVGhlc2UgZG9uJ3Qgc2VlbSB0byBiZSBoYW5kbGVk
IHRoYXQgSSBjYW4gc2VlLi4uDQo+IA0KDQpZZWFoLg0KTXkgYmFkLg0KTGVmdC1vdmVyIGZyb20g
dGhlIHJlLXdyaXRlLg0KVGhlIGluaXRpYWwgZHJpdmVyIEkgd2FudGVkIHRvIHNlbmQgaGFkIHRo
ZXNlIGltcGxlbWVudGVkLCBidXQgZGVjaWRlZCB0byBkZWZlcg0KdGhlbS4NClRoZSBkcml2ZXIv
Y2hhcCBjYW4gb3BlcmF0ZSB3aXRob3V0IHRoZXNlLg0KDQo+ID4gKwkJQklUKElJT19DSEFOX0lO
Rk9fSElHSF9QQVNTX0ZJTFRFUl8zREJfRlJFUVVFTkNZKSwJXA0KPiA+ICsJLmluZm9fbWFza19z
aGFyZWRfYnlfdHlwZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1NDQUxFKSB8CQlcDQo+ID4gKwkJQklU
KElJT19DSEFOX0lORk9fU0FNUF9GUkVRKSwJCQkJXA0KPiA+ICsJLnNjYW5faW5kZXggPSBfc2ks
CQkJCQkJXA0KPiA+ICsJLnNjYW5fdHlwZSA9IHsJCQkJCQkJXA0KPiA+ICsJCS5zaWduID0gX3Np
Z24sCQkJCQkJXA0KPiA+ICsJCS5yZWFsYml0cyA9IF9iaXRzLAkJCQkJXA0KPiA+ICsJCS5zdG9y
YWdlYml0cyA9IDE2LAkJCQkJXA0KPiA+ICsJCS5zaGlmdCA9IDAsCQkJCQkJXA0KPiANCj4gc2hp
ZnQgb2YgMCBpcyB0aGUgIm9idmlvdXMiIGRlZmF1bHQgc28gbm8gbmVlZCB0byBzcGVjaWZ5IGl0
Li4uDQoNCmFjaw0KDQo+IA0KPiA+ICsJfSwJCQkJCQkJCVwNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBheGlfYWRjX2NoYW5fc3BlYyBhZDk0NjdfY2hhbm5lbHNbXSA9
IHsNCj4gPiArCXsNCj4gPiArCQkuaWlvX2NoYW4gPSBBRDk0NjdfQ0hBTigwLCAwLCAxNiwgJ1Mn
KSwNCj4gPiArCQkubnVtX2xhbmVzID0gOCwNCj4gPiArCX0sDQo+ID4gK307DQo+ID4gKw0KPiA+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF4aV9hZGNfY2hpcF9pbmZvIGFkOTQ2N19jaGlwX2luZm9f
dGJsW10gPSB7DQo+ID4gKwlbSURfQUQ5NDY3XSA9IHsNCj4gPiArCQkuaWQgPSBDSElQSURfQUQ5
NDY3LA0KPiA+ICsJCS5tYXhfcmF0ZSA9IDI1MDAwMDAwMFVMLA0KPiA+ICsJCS5zY2FsZV90YWJs
ZSA9IGFkOTQ2N19zY2FsZV90YWJsZSwNCj4gPiArCQkubnVtX3NjYWxlcyA9IEFSUkFZX1NJWkUo
YWQ5NDY3X3NjYWxlX3RhYmxlKSwNCj4gPiArCQkuY2hhbm5lbHMgPSBhZDk0NjdfY2hhbm5lbHMs
DQo+ID4gKwkJLm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoYWQ5NDY3X2NoYW5uZWxzKSwNCj4g
PiArCX0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkOTQ2N19nZXRfc2NhbGUo
c3RydWN0IGF4aV9hZGNfY29udiAqY29udiwgaW50ICp2YWwsIGludCAqdmFsMikNCj4gPiArew0K
PiA+ICsJY29uc3Qgc3RydWN0IGF4aV9hZGNfY2hpcF9pbmZvICppbmZvID0gY29udi0+Y2hpcF9p
bmZvOw0KPiA+ICsJc3RydWN0IGFkOTQ2N19zdGF0ZSAqc3QgPSBheGlfYWRjX2NvbnZfcHJpdihj
b252KTsNCj4gPiArCXVuc2lnbmVkIGludCBpLCB2cmVmX3ZhbCwgdnJlZl9tYXNrOw0KPiA+ICsN
Cj4gPiArCXZyZWZfdmFsID0gYWQ5NDY3X3NwaV9yZWFkKHN0LT5zcGksIEFESV9BRENfUkVHX1ZS
RUYpOw0KPiA+ICsNCj4gPiArCXN3aXRjaCAoaW5mby0+aWQpIHsNCj4gPiArCWNhc2UgQ0hJUElE
X0FEOTQ2NzoNCj4gPiArCQl2cmVmX21hc2sgPSBBRDk0NjdfUkVHX1ZSRUZfTUFTSzsNCj4gPiAr
CQlicmVhazsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJdnJlZl9tYXNrID0gMHhGRkZGOw0KPiA+
ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXZyZWZfdmFsICY9IHZyZWZfbWFzazsN
Cj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgaW5mby0+bnVtX3NjYWxlczsgaSsrKSB7DQo+
ID4gKwkJaWYgKHZyZWZfdmFsID09IGluZm8tPnNjYWxlX3RhYmxlW2ldWzFdKQ0KPiA+ICsJCQli
cmVhazsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoaSA9PSBpbmZvLT5udW1fc2NhbGVzKQ0K
PiA+ICsJCXJldHVybiAtRVJBTkdFOw0KPiA+ICsNCj4gPiArCV9fYWQ5NDY3X2dldF9zY2FsZShj
b252LCBpLCB2YWwsIHZhbDIpOw0KPiA+ICsNCj4gPiArCXJldHVybiBJSU9fVkFMX0lOVF9QTFVT
X01JQ1JPOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkOTQ2N19zZXRfc2NhbGUo
c3RydWN0IGF4aV9hZGNfY29udiAqY29udiwgaW50IHZhbCwgaW50IHZhbDIpDQo+ID4gK3sNCj4g
PiArCWNvbnN0IHN0cnVjdCBheGlfYWRjX2NoaXBfaW5mbyAqaW5mbyA9IGNvbnYtPmNoaXBfaW5m
bzsNCj4gPiArCXN0cnVjdCBhZDk0Njdfc3RhdGUgKnN0ID0gYXhpX2FkY19jb252X3ByaXYoY29u
dik7DQo+ID4gKwl1bnNpZ25lZCBpbnQgc2NhbGVfdmFsWzJdOw0KPiA+ICsJdW5zaWduZWQgaW50
IGk7DQo+ID4gKw0KPiA+ICsJaWYgKHZhbCAhPSAwKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0K
PiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBpbmZvLT5udW1fc2NhbGVzOyBpKyspIHsNCj4g
PiArCQlfX2FkOTQ2N19nZXRfc2NhbGUoY29udiwgaSwgJnNjYWxlX3ZhbFswXSwgJnNjYWxlX3Zh
bFsxXSk7DQo+ID4gKwkJaWYgKHNjYWxlX3ZhbFswXSAhPSB2YWwgfHwgc2NhbGVfdmFsWzFdICE9
IHZhbDIpDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ICsNCj4gPiArCQlhZDk0Njdfc3BpX3dyaXRl
KHN0LT5zcGksIEFESV9BRENfUkVHX1ZSRUYsDQo+ID4gKwkJCQkgaW5mby0+c2NhbGVfdGFibGVb
aV1bMV0pOw0KPiA+ICsJCWFkOTQ2N19zcGlfd3JpdGUoc3QtPnNwaSwgQURJX0FEQ19SRUdfVFJB
TlNGRVIsDQo+ID4gKwkJCQkgQURJX0FEQ19UUkFOU0ZFUl9TWU5DKTsNCj4gPiArCQlyZXR1cm4g
MDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gLUVJTlZBTDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBhZDk0NjdfcmVhZF9yYXcoc3RydWN0IGF4aV9hZGNfY29udiAqY29u
diwNCj4gPiArCQkJICAgc3RydWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4sDQo+ID4gKwkJ
CSAgIGludCAqdmFsLCBpbnQgKnZhbDIsIGxvbmcgbSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGFk
OTQ2N19zdGF0ZSAqc3QgPSBheGlfYWRjX2NvbnZfcHJpdihjb252KTsNCj4gPiArDQo+ID4gKwlz
d2l0Y2ggKG0pIHsNCj4gPiArCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4gPiArCQlyZXR1
cm4gYWQ5NDY3X2dldF9zY2FsZShjb252LCB2YWwsIHZhbDIpOw0KPiA+ICsJY2FzZSBJSU9fQ0hB
Tl9JTkZPX1NBTVBfRlJFUToNCj4gPiArCQlpZiAoIXN0LT5jbGspDQo+ID4gKwkJCXJldHVybiAt
RU5PREVWOw0KPiA+ICsNCj4gPiArCQkqdmFsID0gY2xrX2dldF9yYXRlKHN0LT5jbGspOw0KPiA+
ICsNCj4gPiArCQlyZXR1cm4gSUlPX1ZBTF9JTlQ7DQo+ID4gKw0KPiA+ICsJfQ0KPiA+ICsJcmV0
dXJuIC1FSU5WQUw7DQo+IA0KPiBJJ2QgcHV0IHRoYXQgaW4gYSBkZWZhdWx0IGluIHRoZSBzd2l0
Y2ggYXMgeW91IG1heSBnZXQgd2FybmluZ3MNCj4gZnJvbSBzb21lIHN0YXRpYyBjaGVja2VycyBv
dGhlcndpc2UuDQoNCmFjaw0KDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFk
OTQ2N193cml0ZV9yYXcoc3RydWN0IGF4aV9hZGNfY29udiAqY29udiwNCj4gPiArCQkJICAgIHN0
cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFuLA0KPiA+ICsJCQkgICAgaW50IHZhbCwgaW50
IHZhbDIsIGxvbmcgbWFzaykNCj4gPiArew0KPiA+ICsJY29uc3Qgc3RydWN0IGF4aV9hZGNfY2hp
cF9pbmZvICppbmZvID0gY29udi0+Y2hpcF9pbmZvOw0KPiA+ICsJc3RydWN0IGFkOTQ2N19zdGF0
ZSAqc3QgPSBheGlfYWRjX2NvbnZfcHJpdihjb252KTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgcl9j
bGs7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCXN3aXRjaCAobWFzaykgew0KPiA+ICsJ
Y2FzZSBJSU9fQ0hBTl9JTkZPX1NDQUxFOg0KPiA+ICsJCXJldHVybiBhZDk0Njdfc2V0X3NjYWxl
KGNvbnYsIHZhbCwgdmFsMik7DQo+ID4gKwljYXNlIElJT19DSEFOX0lORk9fU0FNUF9GUkVROg0K
PiA+ICsJCWlmICghc3QtPmNsaykNCj4gPiArCQkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+
ICsJCWlmIChjaGFuLT5leHRlbmRfbmFtZSkNCj4gPiArCQkJcmV0dXJuIC1FTk9ERVY7DQo+ID4g
Kw0KPiA+ICsJCXJfY2xrID0gY2xrX3JvdW5kX3JhdGUoc3QtPmNsaywgdmFsKTsNCj4gPiArCQlp
ZiAocl9jbGsgPCAwIHx8IHJfY2xrID4gaW5mby0+bWF4X3JhdGUpIHsNCj4gPiArCQkJZGV2X3dh
cm4oJnN0LT5zcGktPmRldiwNCj4gPiArCQkJCSAiRXJyb3Igc2V0dGluZyBBREMgc2FtcGxlIHJh
dGUgJWxkIiwgcl9jbGspOw0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQl9DQo+ID4g
Kw0KPiA+ICsJCXJldCA9IGNsa19zZXRfcmF0ZShzdC0+Y2xrLCByX2Nsayk7DQo+ID4gKwkJaWYg
KHJldCA8IDApDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+IHJldHVybiBjbGtfc2V0X3JhdGUoc3Qt
PmNsaywgcl9jbGspIGlzIHByb2JhYmx5IHRoZSBzYW1lLg0KPiBNaWdodCBhcyB3ZWxsIGRvIGVh
cmx5IHJldHVybnMgZXZlcnl3aGVyZS4NCg0KYWNrDQoNCj4gDQo+ID4gKw0KPiA+ICsJCWJyZWFr
Ow0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZDk0Njdf
b3V0cHV0bW9kZV9zZXQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgdW5zaWduZWQgaW50IG1vZGUp
DQo+ID4gK3sNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gYWQ5NDY3X3NwaV93
cml0ZShzcGksIEFESV9BRENfUkVHX09VVFBVVF9NT0RFLCBtb2RlKTsNCj4gPiArCWlmIChyZXQg
PCAwKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGFkOTQ2N19zcGlf
d3JpdGUoc3BpLCBBRElfQURDX1JFR19UUkFOU0ZFUiwNCj4gPiArCQkJCUFESV9BRENfVFJBTlNG
RVJfU1lOQyk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYWQ5NDY3X3ByZWVuYWJs
ZV9zZXR1cChzdHJ1Y3QgYXhpX2FkY19jb252ICpjb252KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qg
YWQ5NDY3X3N0YXRlICpzdCA9IGF4aV9hZGNfY29udl9wcml2KGNvbnYpOw0KPiA+ICsNCj4gPiAr
CXJldHVybiBhZDk0Njdfb3V0cHV0bW9kZV9zZXQoc3QtPnNwaSwgc3QtPm91dHB1dF9tb2RlKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZDk0Njdfc2V0dXAoc3RydWN0IGFkOTQ2
N19zdGF0ZSAqc3QsIHVuc2lnbmVkIGludCBjaGlwX2lkKQ0KPiA+ICt7DQo+ID4gKwlzd2l0Y2gg
KGNoaXBfaWQpIHsNCj4gPiArCWNhc2UgQ0hJUElEX0FEOTQ2NzoNCj4gPiArCQlzdC0+b3V0cHV0
X21vZGUgPSBBRDk0NjdfREVGX09VVFBVVF9NT0RFIHwNCj4gPiArCQkJCSAgQURJX0FEQ19PVVRQ
VVRfTU9ERV9UV09TX0NPTVBMRU1FTlQ7DQo+ID4gKwkJYnJlYWs7DQo+IA0KPiByZXR1cm4gMCB1
bmxlc3MgeW91IGFyZSBnb2luZyB0byBhZGQgYW55dGhpbmcgYWZ0ZXIgdGhlIHN3aXRjaCBzdGF0
ZW1lbnQuDQo+IA0KDQpobW1tOyBpIHRoaW5rIHRoZSB3YXkgaSByZXdvcmtlZCBpdCwgaSBjYW4g
bW92ZSByZXR1cm4gMCBoZXJlDQp0aGFua3MNCg0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIHZvaWQgYWQ5NDY3X2Nsa19kaXNhYmxlKHZvaWQgKmRhdGEpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBhZDk0Njdfc3RhdGUgKnN0ID0gZGF0YTsNCj4gPiArDQo+ID4gKwlj
bGtfZGlzYWJsZV91bnByZXBhcmUoc3QtPmNsayk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyBpbnQgYWQ5NDY3X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4gK3sNCj4gPiAr
CXN0cnVjdCBheGlfYWRjX2NvbnYgKmNvbnY7DQo+ID4gKwlzdHJ1Y3QgYWQ5NDY3X3N0YXRlICpz
dDsNCj4gPiArCXVuc2lnbmVkIGludCBpZDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJ
Y29udiA9IGRldm1fYXhpX2FkY19jb252X3JlZ2lzdGVyKCZzcGktPmRldiwgc2l6ZW9mKCpzdCkp
Ow0KPiA+ICsNCj4gDQo+IE5vIGJsYW5rIGxpbmUgYmV0d2VlbiBhIGNhbGwgYW5kIGl0J3MgZXJy
b3IgaGFuZGxlci4NCg0KYWNrDQoNCj4gDQo+ID4gKwlpZiAoSVNfRVJSKGNvbnYpKQ0KPiA+ICsJ
CXJldHVybiBQVFJfRVJSKGNvbnYpOw0KPiA+ICsNCj4gPiArCXN0ID0gYXhpX2FkY19jb252X3By
aXYoY29udik7DQo+ID4gKwlzdC0+c3BpID0gc3BpOw0KPiA+ICsNCj4gPiArCXN0LT5jbGsgPSBk
ZXZtX2Nsa19nZXQoJnNwaS0+ZGV2LCAic2FtcGxlLWNsb2NrIik7DQo+ID4gKwlpZiAoSVNfRVJS
KHN0LT5jbGspKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKHN0LT5jbGspOw0KPiA+ICsNCj4gPiAr
CXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShzdC0+Y2xrKTsNCj4gPiArCWlmIChyZXQgPCAwKQ0K
PiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29y
X3Jlc2V0KCZzcGktPmRldiwgYWQ5NDY3X2Nsa19kaXNhYmxlLCBzdCk7DQo+ID4gKwlpZiAocmV0
KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJc3QtPnB3cmRvd25fZ3BpbyA9IGRl
dm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCZzcGktPmRldiwgInBvd2VyZG93biIsDQo+ID4gKwkJCQkJ
CSAgIEdQSU9EX09VVF9MT1cpOw0KPiA+ICsJaWYgKElTX0VSUihzdC0+cHdyZG93bl9ncGlvKSkN
Cj4gPiArCQlyZXR1cm4gUFRSX0VSUihzdC0+cHdyZG93bl9ncGlvKTsNCj4gPiArDQo+ID4gKwlz
dC0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCZzcGktPmRldiwgInJlc2V0
IiwNCj4gPiArCQkJCQkJIEdQSU9EX09VVF9MT1cpOw0KPiA+ICsJaWYgKElTX0VSUihzdC0+cmVz
ZXRfZ3BpbykpDQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIoc3QtPnJlc2V0X2dwaW8pOw0KPiA+ICsN
Cj4gPiArCWlmIChzdC0+cmVzZXRfZ3Bpbykgew0KPiA+ICsJCXVkZWxheSgxKTsNCj4gPiArCQly
ZXQgPSBncGlvZF9kaXJlY3Rpb25fb3V0cHV0KHN0LT5yZXNldF9ncGlvLCAxKTsNCj4gPiArCQlt
ZGVsYXkoMTApOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXNwaV9zZXRfZHJ2ZGF0YShzcGksIHN0
KTsNCj4gPiArDQo+ID4gKwlpZCA9IHNwaV9nZXRfZGV2aWNlX2lkKHNwaSktPmRyaXZlcl9kYXRh
Ow0KPiA+ICsJY29udi0+Y2hpcF9pbmZvID0gJmFkOTQ2N19jaGlwX2luZm9fdGJsW2lkXTsNCj4g
PiArDQo+ID4gKwlpZCA9IGFkOTQ2N19zcGlfcmVhZChzcGksIEFESV9BRENfUkVHX0NISVBfSUQp
Ow0KPiA+ICsJaWYgKGlkICE9IGNvbnYtPmNoaXBfaW5mby0+aWQpIHsNCj4gPiArCQlkZXZfZXJy
KCZzcGktPmRldiwgIlVucmVjb2duaXplZCBDSElQX0lEIDB4JVhcbiIsIGlkKTsNCj4gPiArCQly
ZXR1cm4gLUVOT0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwljb252LT5yZWdfYWNjZXNzID0g
YWQ5NDY3X3JlZ19hY2Nlc3M7DQo+ID4gKwljb252LT53cml0ZV9yYXcgPSBhZDk0Njdfd3JpdGVf
cmF3Ow0KPiA+ICsJY29udi0+cmVhZF9yYXcgPSBhZDk0NjdfcmVhZF9yYXc7DQo+ID4gKwljb252
LT5wcmVlbmFibGVfc2V0dXAgPSBhZDk0NjdfcHJlZW5hYmxlX3NldHVwOw0KPiA+ICsNCj4gPiAr
CXJldHVybiBhZDk0Njdfc2V0dXAoc3QsIGlkKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGFkOTQ2N19pZFtdID0gew0KPiA+ICsJeyAiYWQ5
NDY3IiwgSURfQUQ5NDY3IH0sDQo+ID4gKwl7fQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNF
X1RBQkxFKHNwaSwgYWQ5NDY3X2lkKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIGFkOTQ2N19vZl9tYXRjaFtdID0gew0KPiA+ICsJeyAuY29tcGF0aWJsZSA9
ICJhZGksYWQ5NDY3IiB9LA0KPiA+ICsJe30NCj4gPiArfTsNCj4gPiArTU9EVUxFX0RFVklDRV9U
QUJMRShvZiwgYWQ5NDY3X29mX21hdGNoKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc3Bp
X2RyaXZlciBhZDk0NjdfZHJpdmVyID0gew0KPiA+ICsJLmRyaXZlciA9IHsNCj4gPiArCQkubmFt
ZSA9ICJhZDk0NjciLA0KPiA+ICsJCS5vZl9tYXRjaF90YWJsZSA9IGFkOTQ2N19vZl9tYXRjaCwN
Cj4gPiArCX0sDQo+ID4gKwkucHJvYmUgPSBhZDk0NjdfcHJvYmUsDQo+ID4gKwkuaWRfdGFibGUg
PSBhZDk0NjdfaWQsDQo+IA0KPiBUaGlzIGlzIHNvbWV0aGluZyBJJ3ZlIG9ubHkganVzdCBzdGFy
dGVkIHJhaXNpbmcgaW4gcmV2aWV3cy4NCj4gSWYgYSBkcml2ZXIgY2FuJ3QgcmVhbGlzdGljYWxs
eSBiZSBpbnN0YW50aWF0ZWQgd2l0aG91dCBmaXJtd2FyZQ0KPiBiaW5kaW5ncywgdGhlcmUgaXNu
J3QgcmVhbGx5IGFueSBwb2ludCBpbiBwcm92aWRpbmcgdGhlIGlkX3RhYmxlDQo+IHRoYXQgSSBj
YW4gdGhpbmsgb2Ygc28gcGxlYXNlIHJlbW92ZS4NCg0KYWNrDQp3aWxsIGhhbmRsZSB0aGlzOw0K
aSdsbCBuZWVkIHRvIHJlcGxhY2UgJ2lkID0gc3BpX2dldF9kZXZpY2VfaWQoc3BpKS0+ZHJpdmVy
X2RhdGE7JyBidXQgaXQncyBkb2FibGUNCg0KPiANCj4gPiArfTsNCj4gPiArbW9kdWxlX3NwaV9k
cml2ZXIoYWQ5NDY3X2RyaXZlcik7DQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJNaWNoYWVs
IEhlbm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4iKTsNCj4gPiArTU9EVUxF
X0RFU0NSSVBUSU9OKCJBbmFsb2cgRGV2aWNlcyBBRDk0NjcgQURDIGRyaXZlciIpOw0KPiA+ICtN
T0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo=
