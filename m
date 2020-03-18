Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01079189616
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 08:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRHBG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 03:01:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44552 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgCRHBF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 03:01:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I6wT0O010217;
        Wed, 18 Mar 2020 03:00:42 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu9jas0hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 03:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoHUOdkgN7cn9FnKpJVaNZn8rbxHBIYCckfCcxivk5i1Cf1b6mdJlPOC2aeusqcf1AUf1GCtWDFFQzx3zxPgi14Of6BkgcWCQz2oaeF/c1ErpV1yYtUm75IbCZ3EUYOzB46bnpIGCrOYdb1KdqF/CrnYizbPmD0RE/P8j4RUa/RfwJhXu03p4ej7baUpiT+RKLPjRwEhv0EBCwfatmmWkjd+bS3cZIsd/fm4ejVwJD/tGf7iNt86MXniAI6wYL5bp4pQtLGHo0mvl522D9F2cmh23VD0y8cZeoIu81CEPukwpTW3iphoDjqXoPFGFZNUTK6gmkZ7B9ZsvFRCJWNBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfKFvB3HL2F3UWjXIcas/7WcY+eQMr9Z4HuQvkPmDD0=;
 b=axJVhRElO2Ia45jdgzpFCp3uEWPAkuWtQpPVya3hyPQSqF2EYdof/eN0D/R1wPw1NsaDVejTH+d/4+riBbY1qeprRlGdRSqiPwXzUZF8K6R3l93gzC7xqhml3R1AE6c4qibhPyM9ULmrZ1kcrcq+5UO+YSbzR844z9jWQ4HwKzCZRaMIZmLw3sgizZFqnWPK+Mpz5zL3fPdexthUKIxYJqC/1H3dwHEbQlnb6oj4FwW4rgFDhi7NCvdg/HT8/T5dfuNqQ6MZQaXrHMfZ12yp9XYVWAcdPChHEl4qi0bLUCVg02j18RKcw+1HntS2HNxSbFqoMtb/utDxYKsqC2qsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfKFvB3HL2F3UWjXIcas/7WcY+eQMr9Z4HuQvkPmDD0=;
 b=dEDiiU/OQC/i5bvFMkXDH8mlYqjD0serXalARDwrtWzK4l1nNXA8v5bjCwk5k0BrpcwJ1woGQSm+3nIjbAgxenaBnEPK3Ug9hvKcIws7RD1JTP7ltYkv9tIuWVXDei4pzDv23DcBr7y7fSqr/iUzZljVXea00KBYlfyORES/jV4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5337.namprd03.prod.outlook.com (2603:10b6:5:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 07:00:41 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 07:00:41 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "alazar@startmail.com" <alazar@startmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Topic: [PATCH 2/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Index: AQHV/Jm3+s1YcEOgTkiO6TGvJdmAx6hN7ZqA
Date:   Wed, 18 Mar 2020 07:00:41 +0000
Message-ID: <e7205997042058f38d926f2e38b0f8331dd8aea6.camel@analog.com>
References: <20200317201710.23180-1-alazar@startmail.com>
         <20200317201710.23180-3-alazar@startmail.com>
In-Reply-To: <20200317201710.23180-3-alazar@startmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cc01858-67a8-43e4-cf5b-08d7cb0a124e
x-ms-traffictypediagnostic: DM6PR03MB5337:
x-microsoft-antispam-prvs: <DM6PR03MB5337A3849540ED603DAECF0AF9F70@DM6PR03MB5337.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(6506007)(6486002)(186003)(8936002)(6512007)(91956017)(66556008)(64756008)(76116006)(81166006)(81156014)(8676002)(66946007)(66446008)(66476007)(5660300002)(54906003)(110136005)(966005)(26005)(478600001)(36756003)(2906002)(71200400001)(2616005)(86362001)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5337;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3XKhnSWWUdYg4NYxa+WsQUVxOdBtCEDgAPqaIaq2SJLzGVWhMDHjKRlhVxEOHwFVnrb10avr4r0/2EBHWkXS20aLZ/iM+MFxEguBRC44L94mPEAIS//3r33XKdsdawwJC5kY9ggg4w9XpS1a7kDxSh8jAxpzU7X2h6nCM/lYS9dnnRtzqrRqDTVMxMf8P8QugPVkmFFfH9TZtM332hJ61MGaQ+QCOlDBw6+DYwTCSMzZvKxWF0ZyacG7hY+/yHXQo2isDvJsbnO4xrtIc7FpS2srJcLDifMWj4WwX2rwWCshAvTNKwVDNCiHahYJOkVF8rmltdrKYzSZiJpYO6xCuftlInZqp7WmSlwkkFGGN90qPbwzqzUG7Mr0E62TH78eqYUVYwsMBiehhDzQ5mOGLFBITywJ4LzAzjGK2k9ZmEiM5tif0SQi+vbOaqKhFPZAKZG5Fi+bGv+Fiw+DQtPESrzd1/EMWj4tdvOKp7du/bkUyLkx6IPZhnkIVMQtyXUA/hQ7EOkZMwgrt81iqMrKg==
x-ms-exchange-antispam-messagedata: 0dRYsNc3+B5/3gYudNz/mqY2SaTnIpUTuhz47zEonuqZEPWZzWD7iimD7Z4Zt8IpLgAmhDTr5esK3AabE2bPZtQuBiiSc5hse/owiLCGv4EjW+C62A8iYdBTYXkW0dmVsgNgb5fU4ykApo2kzCS/eg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBD9C459F980B24189E7B6C32BD87F0C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc01858-67a8-43e4-cf5b-08d7cb0a124e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 07:00:41.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwMVmG0EZaUHDAgB3beCiUKKyURMmdCLrlh54lfen4O0QRNZVsYgfH0PTjE5ESDrjzGVH1MWS7CHD2hqaBcXLE1Ci5Twe3hojHrIUtFEYOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5337
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_02:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180034
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTE3IGF0IDIyOjE3ICswMjAwLCBBbGV4YW5kcnUgTGF6YXIgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IEFkZCBkZXZpY2UtdHJlZSBiaW5kaW5ncyBkb2N1bWVudGF0
aW9uIGZvciB0aGUgTUFYMTI0MSBkZXZpY2UgZHJpdmVyLg0KPiANCg0KY3VyaW91czogZGlkIHlv
dSBydW4gZHRfYmluZGluZ19jaGVjayAgPw0KDQp0eXBpY2FsbHkgd2hhdCBpIGRvIGlzOg0KDQpB
UkNIPWFybSBtYWtlIGRlZmNvbmZpZyAgICMgbm8gaWRlYSB3aHkgdGhpcyBpcyBzdGlsbCBuZWVk
ZWQgZm9yIGJpbmRpbmdzIGNoZWNrIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAjIGkgbWVh
biwgaSBzZWUgdGhlIGRlcHMsIGJ1dCBpIGRvbid0IGZlZWwgaXMgbmVlZGVkIA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAjIMKvXF8o44OEKV8vwq8NCg0KQVJDSD1hcm0gbWFrZSBkdF9iaW5k
aW5nX2NoZWNrIFwNCiAgICBEVF9TQ0hFTUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9hZGMvbWF4aW0sbWF4MTI0MS55YW1sDQoNCiMgc2hvdWxkIGJlIG9uIG9u
ZSBsaW5lDQoNCg0KIyBmb3IgZGVwZW5kZW5jaWVzLCBzZWUgDQpodHRwczovL2dpdGh1Yi5jb20v
dG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL3dyaXRp
bmctc2NoZW1hLnJzdCNkZXBlbmRlbmNpZXMNCg0KSXQgbWlnaHQgYmUgdGhhdCBSb2IncyBib3Qg
d2lsbCBjb21lIGJhY2sgYW5kIHRlbGwgdXMgYW55dGhpbmcgd3Jvbmcgd2l0aCB0aGlzDQpmaWxl
Lg0KDQoNCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IExhemFyIDxhbGF6YXJAc3RhcnRtYWls
LmNvbT4NCj4gLS0tDQo+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9tYXhpbSxtYXgxMjQxLnlhbWwg
ICAgICAgfCA2MCArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjAgaW5z
ZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vYWRjL21heGltLG1heDEyNDEueWFtbA0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21heGltLG1heDEy
NDEueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21h
eGltLG1heDEyNDEueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmFiYjkwZDM4MjA2Nw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21heGltLG1heDEyNDEueWFtbA0KPiBAQCAt
MCwwICsxLDYwIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsl
WUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9p
aW8vYWRjL2FkaSxhZDc3ODAueWFtbCMNCg0KVGhpcyBpc24ndCBBRDc3ODAgOnANCg0KYWRpLGFk
Nzc4MC55YW1sIyAgLT4gbWF4aW0sbWF4MTI0MS55YW1sIw0KDQoNCj4gKyRzY2hlbWE6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTog
TWF4aW0gTUFYMTI0MSAxMi1iaXQsIHNpbmdsZS1jaGFubmVsIGFuYWxvZyB0byBkaWdpdGFsIGNv
bnZlcnRlcg0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBJb2FuLUFsZXhhbmRydSBMYXph
ciA8YWxhemFyQHN0YXJ0bWFpbC5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOiB8DQo+ICsgIEJp
bmRpbmdzIGZvciB0aGUgbWF4MTI0MSAxMi1iaXQsIHNpbmdsZS1jaGFubmVsIEFEQyBkZXZpY2Uu
IFRoaXMNCj4gKyAgZHJpdmVyIHN1cHBvcnRzIHZvbHRhZ2UgcmVhZGluZyBhbmQgY2FuIG9wdGlv
bmFsbHkgYmUgY29uZmlndXJlZCBmb3INCj4gKyAgcG93ZXItZG93biBtb2RlIG9wZXJhdGlvbi4g
VGhlIGRhdGFzaGVldCBjYW4gYmUgZm91bmQgYXQ6DQo+ICsgICAgaHR0cHM6Ly9kYXRhc2hlZXRz
Lm1heGltaW50ZWdyYXRlZC5jb20vZW4vZHMvTUFYMTI0MC1NQVgxMjQxLnBkZg0KPiArDQo+ICtw
cm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGVudW06DQo+ICsgICAgICAtbWF4
aW0sbWF4MTI0MQ0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsg
IHZyZWYtc3VwcGx5Og0KPiArICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgRGV2aWNlIHRyZWUg
aWRlbnRpZmllciBvZiB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgdGhlIGV4dGVybmFsDQo+
ICsgICAgICByZWZlcmVuY2Ugdm9sdGFnZS4NCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsg
IHNwaS1tYXgtZnJlcXVlbmN5Og0KPiArICAgIG1heEl0ZW1zOiAxDQoNCnRoaXMgY291bGQgcHJv
YmFibHkgYmUgb21pdHRlZDsNCml0J3MgZG9jdW1lbnRlZCBpbiBzb21lIHNwaS55YW1sIGZpbGUg
YW5kIGlzIGNvbnNpZGVyZWQgYSBzdGFuZGFyZCBwcm9wZXJ0eQ0KDQo+ICsNCj4gKyAgc2hkbi1n
cGlvczoNCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgIEdQSU8gc3BlYyBmb3IgdGhlIEdQ
SU8gcGluIGNvbm5lY3RlZCB0byB0aGUgQURDJ3MgL1NIRE4gcGluLiBJZg0KPiArICAgICAgc3Bl
Y2lmaWVkLCB0aGUgL1NIRE4gcGluIHdpbGwgYmUgYXNzZXJ0ZWQgYmV0d2VlbiBjb252ZXJzaW9u
cywNCj4gKyAgICAgIHRodXMgZW5hYmxpbmcgcG93ZXItZG93biBtb2RlLg0KPiArICAgIG1heEl0
ZW1zOiAxDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcN
Cj4gKyAgLSB2cmVmLXN1cHBseQ0KPiArDQo+ICtleGFtcGxlczoNCj4gKyAgLSB8DQo+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiArICAgIHNwaTAgew0KPiArICAg
ICAgICBhZGNAMCB7DQo+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1heGltLG1heDEyNDEi
Ow0KPiArICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiArICAgICAgICAgICAgdnJlZi1zdXBwbHkg
PSA8JnZkZF8zdjNfcmVnPjsNCj4gKyAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDEw
MDAwMDA+Ow0KPiArICAgICAgICAgICAgc2hkbi1ncGlvcyA9IDwmZ3BpbyAyNiAxPjsNCj4gKyAg
ICAgICAgfTsNCj4gKyAgICB9Ow0KPiArDQo+ICsNCg==
