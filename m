Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82548179763
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgCDSBB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 13:01:01 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25566 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgCDSBB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 13:01:01 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024Hw1Cs028653;
        Wed, 4 Mar 2020 13:00:42 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yfjkfwx20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 13:00:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+/kxrHEI/XCFJ1jv73jBHvZXqQEle+r11xwQPfgUEBItbDXL5kSsWzCn6xbIkikiLOwM8wqclx7iznzHB25HsjklLEfpGH30387QhvIeqq6tXyx+hAA2xCY+y+DvS2bGPxzqQi6JF3KoYMFfUQ/FxDZ5uiUmJrQFONshGZ2HeSsuaFFEOXUDYwqXwhR0FFK8L/IYE1poTvyAxW3g3ZZg3hfYksNg9egxs4+P3Np2/eVq10fgK853vAa9Qrm4IONQj6RTablFwKAper9Kg5n/oIKSe1zAv18ThnsiPgdKdJueHnY1WeG1OcnV+KosSRmEDYT5pbbi2fSiafVBYDQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWVHjxD1ao4dESq7xqAZ6izhrrF72dhunPxuymGJK7A=;
 b=a8G/uy8F5l5sUvfjBCvouIxtLeiHXu6RQShqHycBvPkQutIxC53Q4arhzey106OJSeQ6WZemMW7THf24z4scGikvDvkRm/6OXcZhfaANE2ek7q1Ebff0klTd9L7UCv9dP6CU9+ED1lg7NINubatLtnXpzuAXCshp2HR410Keiz+PweenSotPpJbSvTwiL3o9d6B2kEpAsXof5H4Kj+JIMIe08SFi9ROelVXKQDF8yhrHAT7Xe8GQFOXU2Qjo1HFQV3KvtooRLw319oQIspsMMDpt/uriatRFyEds4H334FdrvJ2cllDpMQWMEMsyG1Bo1L419fU4Lbb1Z2P3szPvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWVHjxD1ao4dESq7xqAZ6izhrrF72dhunPxuymGJK7A=;
 b=1+0ZZ0BcB9lwH97CcB2co4uIMhrZGQW9LHfTQem71RzlsCJfcL4FdzB1FcxF+lsmlDrnulvRryLONS9j29GycxkQ4LyfC3ClokszjgHmGaj0R2s3JOfM+u05vrOzZcg7503nrKCDd3ZdPhvuivvfY3UXx38FlMcxDUFd/tVzz6I=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2932.namprd03.prod.outlook.com (2603:10b6:404:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 18:00:41 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 18:00:41 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Topic: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Index: AQHV69jpKCRYfnfL+0eh49A+u9WwfKg3aLaAgAFdfAA=
Date:   Wed, 4 Mar 2020 18:00:41 +0000
Message-ID: <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-6-nuno.sa@analog.com>
         <20200303211045.31f977bb@archlinux>
In-Reply-To: <20200303211045.31f977bb@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8314dd76-accb-4432-fee2-08d7c065f3d5
x-ms-traffictypediagnostic: BN6PR03MB2932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2932F59EABA2E0F32619E22699E50@BN6PR03MB2932.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(8676002)(66476007)(66556008)(64756008)(81156014)(66446008)(8936002)(316002)(6916009)(54906003)(966005)(186003)(81166006)(26005)(6512007)(76116006)(66946007)(36756003)(478600001)(5660300002)(71200400001)(4326008)(2616005)(6506007)(6486002)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2932;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvt/5htOx5CdJcPqY7LmRKp3QV/WGUHvdLhhlah/SVTJegiAw52/wBNkvik175UyowhJ8D3h3NT1jKq+NjQlJxQCaFnruZWMTTW0Mlis+uu/tN+0e1oo8yqabUclxslrWiM6fNJ+HcxeGtD3gmKqlf0Nl2bC68eKjNAOd86C+bkRBkhA7h1+t0xjKjPbl3sPQ26f2Faa7VooEMJwpk45jcARrnhz7Glm0A7WrS/LJvbAaT31TH90V2GGPrOHHfF+8vK19OSEasusbUyX84SVICtKMpqYkG15heFH8JxOb7wq2t4UCfSmwrdbx/wjahlJntoLM7AzlMSmUS77aeOMr1dSSoyEtuKe9KRNdzB0VRc9y03so6e+xqaOFIwA1sHFNXgN2I6DruzuiAaEWn3+sl7tlMs8czq9XIoC6H0Ea4HA1CQS4Jo2nm6SvDh96srBE3mkZOF39zI8AP0VTjHHd6s7s5BFy+uSaF0v+o27lLh/4Ap2WATJ1ex98cPrfeF7P7pwer2lbuqGruEV4luKbg==
x-ms-exchange-antispam-messagedata: c6Y17R0hG5PWXbGQnf3NqRx88Sug9VvmZ97CCBp6Ex0vHx8gkDYTSckTjwowyLSI/4THDj5T2r8m+qhMqn5L9tyLz+IibYkSXqA2SRQGyxvg/Gt+bx4kKFaUoPrq4BemZUlsK6oIA7dYon0YYci/Lg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <79EFE18DAF36E542AF1D1AE313FE6949@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8314dd76-accb-4432-fee2-08d7c065f3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 18:00:41.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGwlg6cCivpFrb1OHCM5S7e31U1wFQyW5WhtOVZKHkpy3CTrqpbi2yjaohRgjbpPI9oQfPdoBro/58SFcyH96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2932
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDIxOjEwICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDI1IEZlYiAyMDIwIDEzOjQxOjUyICswMTAw
DQo+IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBEb2N1bWVu
dCB0aGUgQURJUzE2NDc1IGRldmljZSBkZXZpY2V0cmVlIGJpbmRpbmdzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+IA0KPiBPbmUgdGhp
bmcgaW5saW5lIG9uIHRoZSBidXJzdCBtb2RlIHN0dWZmLg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Sm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9paW8vaW11L2FkaSxhZGlz
MTY0NzUueWFtbCAgICAgICB8IDEzMA0KPiA+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDEzMSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2FkaSxhZGlz
MTY0NzUueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbA0KPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmMwZjIxNDZl
MDAwYw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaWlvL2ltdS9hZGksYWRpczE2NDc1LnlhbWwNCj4gPiBAQCAtMCwwICsxLDEz
MCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJT
RC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sIw0KPiA+ICsk
c2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4g
PiArDQo+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBBRElTMTY0NzUgYW5kIHNpbWlsYXIgSU1V
cw0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBOdW5vIFPDoSA8bnVuby5zYUBh
bmFsb2cuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBBbmFsb2cgRGV2
aWNlcyBBRElTMTY0NzUgYW5kIHNpbWlsYXIgSU1Vcw0KPiA+ICsgIA0KPiA+IGh0dHBzOi8vd3d3
LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMv
QURJUzE2NDc1LnBkZg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxl
Og0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSBhZGksYWRpczE2NDc1LTENCj4gPiArICAg
ICAgLSBhZGksYWRpczE2NDc1LTINCj4gPiArICAgICAgLSBhZGksYWRpczE2NDc1LTMNCj4gPiAr
ICAgICAgLSBhZGksYWRpczE2NDc3LTENCj4gPiArICAgICAgLSBhZGksYWRpczE2NDc3LTINCj4g
PiArICAgICAgLSBhZGksYWRpczE2NDc3LTMNCj4gPiArICAgICAgLSBhZGksYWRpczE2NDcwDQo+
ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ2NS0xDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ2NS0y
DQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ2NS0zDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ2
Ny0xDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ2Ny0yDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMx
NjQ2Ny0zDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjUwMA0KPiA+ICsgICAgICAtIGFkaSxhZGlz
MTY1MDUtMQ0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTY1MDUtMg0KPiA+ICsgICAgICAtIGFkaSxh
ZGlzMTY1MDUtMw0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTY1MDctMQ0KPiA+ICsgICAgICAtIGFk
aSxhZGlzMTY1MDctMg0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTY1MDctMw0KPiA+ICsNCj4gPiAr
ICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBzcGktY3BoYTogdHJ1
ZQ0KPiA+ICsNCj4gPiArICBzcGktY3BvbDogdHJ1ZQ0KPiA+ICsNCj4gPiArICBzcGktbWF4LWZy
ZXF1ZW5jeToNCj4gPiArICAgIG1heGltdW06IDIwMDAwMDANCj4gPiArDQo+ID4gKyAgaW50ZXJy
dXB0czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgb25l
T2Y6DQo+ID4gKyAgICAgIC0gY29uc3Q6IHN5bmMNCj4gPiArICAgICAgLSBjb25zdDogZGlyZWN0
LXN5bmMNCj4gPiArICAgICAgLSBjb25zdDogcHVsc2Utc3luYw0KPiA+ICsgICAgICAtIGNvbnN0
OiBzY2FsZWQtc3luYw0KPiA+ICsNCj4gPiArICByZXNldC1ncGlvczoNCj4gPiArICAgIGRlc2Ny
aXB0aW9uOg0KPiA+ICsgICAgICBNdXN0IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9m
IHRoZSBSRVNFVCBwaW4uIElmDQo+ID4gc3BlY2lmaWVkLA0KPiA+ICsgICAgICBpdCB3aWxsIGJl
IGFzc2VydGVkIGR1cmluZyBkcml2ZXIgcHJvYmUuIEFzIHRoZSBsaW5lIGlzDQo+ID4gYWN0aXZl
IGxvdywNCj4gPiArICAgICAgaXQgc2hvdWxkIGJlIG1hcmtlZCBHUElPX0FDVElWRV9MT1cuDQo+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBhZGksc2NhbGVkLW91dHB1dC1oejoN
Cj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGlzIHByb3BlcnR5IG11c3QgYmUg
cHJlc2VudCBpZiB0aGUgY2xvY2sgbW9kZSBpcyBzY2FsZWQtDQo+ID4gc3luYyB0aHJvdWdoDQo+
ID4gKyAgICAgIGNsb2NrLW5hbWVzIHByb3BlcnR5LiBJbiB0aGlzIG1vZGUsIHRoZSBpbnB1dCBj
bG9jayBjYW4gaGF2ZQ0KPiA+IGEgcmFuZ2UNCj4gPiArICAgICAgb2YgMUh6IHRvIDEyOEhaIHdo
aWNoIG11c3QgYmUgc2NhbGVkIHRvIG9yaWdpbmF0ZSBhbg0KPiA+IGFsbG93YWJsZSBzYW1wbGUN
Cj4gPiArICAgICAgcmF0ZS4gVGhpcyBwcm9wZXJ0eSBzcGVjaWZpZXMgdGhhdCByYXRlLg0KPiA+
ICsgICAgbWluaW11bTogMTkwMA0KPiA+ICsgICAgbWF4aW11bTogMjEwMA0KPiA+ICsNCj4gPiAr
cmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGlu
dGVycnVwdHMNCj4gPiArICAtIHNwaS1jcGhhDQo+ID4gKyAgLSBzcGktY3BvbA0KPiA+ICsNCj4g
PiAraWY6DQo+ID4gKyAgcHJvcGVydGllczoNCj4gPiArICAgIGNvbXBhdGlibGU6DQo+ID4gKyAg
ICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAtIGFkaSxh
ZGlzMTY1MDANCj4gPiArICAgICAgICAgIC0gYWRpLGFkaXMxNjUwNS0xDQo+ID4gKyAgICAgICAg
ICAtIGFkaSxhZGlzMTY1MDUtMg0KPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA1LTMNCj4g
PiArICAgICAgICAgIC0gYWRpLGFkaXMxNjUwNy0xDQo+ID4gKyAgICAgICAgICAtIGFkaSxhZGlz
MTY1MDctMg0KPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA3LTMNCj4gPiArDQo+ID4gK3Ro
ZW46DQo+ID4gKyAgcHJvcGVydGllczoNCj4gPiArICAgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAg
ICBvbmVPZjoNCj4gPiArICAgICAgICAtIGNvbnN0OiBzeW5jDQo+ID4gKyAgICAgICAgLSBjb25z
dDogZGlyZWN0LXN5bmMNCj4gPiArICAgICAgICAtIGNvbnN0OiBzY2FsZWQtc3luYw0KPiA+ICsN
Cj4gPiArICAgIGFkaSxidXJzdDMyLWVuYWJsZToNCj4gPiArICAgICAgZGVzY3JpcHRpb246DQo+
ID4gKyAgICAgICAgRW5hYmxlIGJ1cnN0MzIgbW9kZS4gSW4gdGhpcyBtb2RlLCBhIGJ1cnN0IHJl
YWRpbmcNCj4gPiBjb250YWlucyBjYWxpYnJhdGVkDQo+ID4gKyAgICAgICAgZ3lyb3Njb3BlIGFu
ZCBhY2NlbGVyb21ldGVyIGRhdGEgaW4gMzItYml0IGZvcm1hdC4NCj4gDQo+IFdoeSBpcyB0aGlz
IGluIERUPyAgSXMgaXQgbm90IGEgcnVudGltZSBkZWNpc2lvbg0KPiAoaWRlYWxseSBhdXRvbWF0
aWNhbGx5IHNlbGVjdGVkKQ0KDQpTbywgeW91IG1lYW4ganVzdCBoYXZlIHRoaXMgbW9kZSBieSBk
ZWZhdWx0IG9uIHBhcnRzIHRoYXQgc3VwcG9ydCBpdD8NCg0KLSBOdW5vIFPDoQ0KPiA+ICsgICAg
ICB0eXBlOiBib29sZWFuDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiAr
ICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4g
PiArICAgIHNwaSB7DQo+ID4gKyAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+
ICsgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
IGFkaXMxNjQ3NTogYWRpczE2NDc1LTNAMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJhZGksYWRpczE2NDc1LTMiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHJl
ZyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICBzcGktY3BoYTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICBzcGktY3BvbDsNCj4gPiArICAgICAgICAgICAgICAgICAgICBzcGktbWF4
LWZyZXF1ZW5jeSA9IDwyMDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1
cHRzID0gPDQgSVJRX1RZUEVfRURHRV9SSVNJTkc+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAg
IGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8+Ow0KPiA+ICsgICAgICAgICAgICB9Ow0KPiA+ICsg
ICAgfTsNCj4gPiArLi4uDQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5F
UlMNCj4gPiBpbmRleCBmMTEyNjJmMWYzYmIuLmY4Y2NjOTJhYjM3OCAxMDA2NDQNCj4gPiAtLS0g
YS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTEwMTUsNiArMTAx
NSw3IEBAIFc6CQ0KPiA+IGh0dHA6Ly9lei5hbmFsb2cuY29tL2NvbW11bml0eS9saW51eC1kZXZp
Y2UtZHJpdmVycw0KPiA+ICBTOglTdXBwb3J0ZWQNCj4gPiAgRjoJZHJpdmVycy9paW8vaW11L2Fk
aXMxNjQ3NS5jDQo+ID4gIEY6CURvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWlp
by1pbXUtYWRpczE2NDc1DQo+ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbA0KPiA+ICANCj4gPiAgQU5BTE9HIERFVklDRVMg
SU5DIEFETTExNzcgRFJJVkVSDQo+ID4gIE06CUJlbmlhbWluIEJpYSA8YmVuaWFtaW4uYmlhQGFu
YWxvZy5jb20+DQoNCg==
