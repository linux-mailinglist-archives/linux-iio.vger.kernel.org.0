Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200C41B014A
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTGFT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:05:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:2990 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTGFT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:05:19 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K651G2005387;
        Mon, 20 Apr 2020 02:05:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fx6848ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:05:15 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K65FD2005488;
        Mon, 20 Apr 2020 02:05:15 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fx6848kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnMS7X1ZcudkDMiKggOlZwyrLN4Nb0lZa4rOmC4g6yxphfiBNmdpYXgoAauScgOIbv9HkJSjp+21tOr3ptT8Shqh9SOKIHS8b7RMtedGzB5hqfP0lwqJRGy3K7hhovYoQUHlpX+rRQG94ZK5nnGuQMFu6uEcRYWOwc42ad2u8V++sPusnu6tF/rE67MN2MpPgnN++Znx1hlJl01atVWU5WTMOER9dS/KmzkRv9MUSYxcVBC787ANMKXAo/EBPzguLQjv1L45bPcbUUM4ljs1M5ZRI7Igf9vl8SsS2rIxm942TygzFa+dzE5cypk8l0lcHJJDxpH23eGGKwOHaTZs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfOYlUjD3erY5gRHTZcHEs0QxiJneGxlCg5ZeBUu0vA=;
 b=byrxxFdGT7i5ijfHkywMd9gGiBTCDjvz3ZUBy1Fdqfc4v3CNgrQDHYueJFIzXoUhS56vk6iSGaLDWCOXr/FYSg5PMMcLquVWZYu7Jyg3wkH5rnV/6H2KrOjO7TCYdOZ8aPN9LdyqqpAUV4gs6k48d4lGy3on91ytSwVeupM7j6b05EBMY0ihrfh0qqUcEMmEhXfqkUYgdmnUQ5rhOnWrLf4EA7BQEvJoNzGXW9Fiu9h+f7NVGYsVj+hciEKJr8uq5m0wjOKmSDsrdZIXfsTBUBCmZXHp3SzQwjEZScmctK8O2EM4bL6mCpBFVM2qBZ8a1Qs2bSlgxO1fp+6xU5I4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfOYlUjD3erY5gRHTZcHEs0QxiJneGxlCg5ZeBUu0vA=;
 b=owjx3qkpPslQ45JWT/k1AXaEbhlWgNCyTgFT3TefNX21akduo8onNcUagR5IIKLboAMInrwOyvuzhxDr1Yf15HXVUTuipgziQwCXrWgiizPvVbYYVVQe2Zsp3n1/NU+SYRW8SJ6yd2eO76lIvGfYRDewmedfGQ2F+vmblGlhcaY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4153.namprd03.prod.outlook.com (2603:10b6:5:5c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:05:14 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:05:14 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/7] iio: light: bh1780: use mod_devicetable.h and drop
 of_match_ptr macro
Thread-Topic: [PATCH 1/7] iio: light: bh1780: use mod_devicetable.h and drop
 of_match_ptr macro
Thread-Index: AQHWFlvSl2bZIxAzVUW4/SEPWhrWjKiBh7YA
Date:   Mon, 20 Apr 2020 06:05:14 +0000
Message-ID: <c3ac11b79d4d0bb27f3c6ca94a74384f5a111f5e.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-2-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-2-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f3ab182-b134-4da5-e99f-08d7e4f0cad5
x-ms-traffictypediagnostic: DM6PR03MB4153:
x-microsoft-antispam-prvs: <DM6PR03MB41530A3C47E9C301C5EFC076F9D40@DM6PR03MB4153.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(86362001)(36756003)(6512007)(186003)(26005)(71200400001)(6506007)(478600001)(110136005)(2616005)(4326008)(2906002)(66946007)(76116006)(91956017)(8676002)(5660300002)(8936002)(316002)(66446008)(6486002)(64756008)(66556008)(66476007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yYtX+ib9F2hygNFhm9nLE138aVvXeadYyIibT3kPa/bAstTmnfnN9npgT+rmpMdHdokjX93wxoJ075AavcsVMF+KWhRK4vyVrGxk/kPNgNcHAiI2RlhxAOg58J6VUxSvCGyBGsGACHcGm5//cEINQf3Ns3fdz+BsVnef8+vx2GObl+RE136iUy+4IDzhgsilP2W4vTHBXSbokF7BPBHqMCr9/cb5afVpEJ+BGh0OISlJxgcoF4uwbwv/FIc7LaELPehMEGSpJEPDWXjoGjsmHw3++xb8TKLxmOe13/Cq2Vh2oromXNzEhjNbanhcnftVOx97yESrVZ1Vxf/wsVt9vGKXPimrZrUmSwbnGn4RdikxHUYKJuv+bKwSQwbO3Wj0Z37uWKgOWMGXUtjBbu+DeJhErKpuEcN182D3wdGzE/lfltnDa5rTdtjYYXVkPq7
x-ms-exchange-antispam-messagedata: b9bKuGkgAjGcM1TxxtduQtdc45cpKGOXC1NPPkN17tboZwfuPbDP5Ch5L4la5K+Ou4Nh4TiK0f9r5ZPnzIFqQFYboInRNk4xwh39aAjwPFYHqhmzKJdZR6pJtKbGKyJXMJMByKezFlCXwdfaKVqg5g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <27A4DADB460B3C42BB3A22644BC740A5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3ab182-b134-4da5-e99f-08d7e4f0cad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:05:14.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyyG+YeRnMw0z4rDs0bH/xTbqdtR4b8Qf/1hhC/rxWrPpzBI1hGW0zAEKzdxuVEc/+CzYST7b8/UbTmrhYDE2Q8HW9GJlkIzmTR8GVWVMVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBXaGlsc3QgdGhpcyBlbmFibGVzIEFDUEkgYmluZGluZyBvciB0aGUgZGV2aWNlIHZp
YSBQUlAwMDAxIHRoZQ0KPiBwcmltYXJ5IGFpbSBpcyB0byByZW1vdmUgcG90ZW50aWFsIGZvciB0
aGVzZSB0d28gdGhpbmdzIHRvIGJlDQo+IGN1dCBhbmQgcGFzdGUgaW50byBuZXcgZHJpdmVycy4N
Cg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFu
YWxvZy5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0
aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9saWdodC9iaDE3
ODAuYyB8IDYgKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L2JoMTc4MC5j
IGIvZHJpdmVycy9paW8vbGlnaHQvYmgxNzgwLmMNCj4gaW5kZXggYTgzNjEwMDZkY2Q5Li4wM2Yy
ZDhkMTIzYzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L2JoMTc4MC5jDQo+ICsr
KyBiL2RyaXZlcnMvaWlvL2xpZ2h0L2JoMTc4MC5jDQo+IEBAIC0xMyw3ICsxMyw3IEBADQo+ICAj
aW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZGVs
YXkuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9v
Zi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9paW8vaWlvLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvaWlvL3N5c2ZzLmg+DQo+IEBAIC0yNzMsMTMgKzI3MywxMSBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgYmgxNzgwX2lkW10gPSB7DQo+ICANCj4gIE1P
RFVMRV9ERVZJQ0VfVEFCTEUoaTJjLCBiaDE3ODBfaWQpOw0KPiAgDQo+IC0jaWZkZWYgQ09ORklH
X09GDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9iaDE3ODBfbWF0Y2hb
XSA9IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gInJvaG0sYmgxNzgwZ2xpIiwgfSwNCj4gIAl7fSwN
Cj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBvZl9iaDE3ODBfbWF0Y2gpOw0KPiAt
I2VuZGlmDQo+ICANCj4gIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBiaDE3ODBfZHJpdmVyID0g
ew0KPiAgCS5wcm9iZQkJPSBiaDE3ODBfcHJvYmUsDQo+IEBAIC0yODgsNyArMjg2LDcgQEAgc3Rh
dGljIHN0cnVjdCBpMmNfZHJpdmVyIGJoMTc4MF9kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsN
Cj4gIAkJLm5hbWUgPSAiYmgxNzgwIiwNCj4gIAkJLnBtID0gJmJoMTc4MF9kZXZfcG1fb3BzLA0K
PiAtCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIob2ZfYmgxNzgwX21hdGNoKSwNCj4g
KwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfYmgxNzgwX21hdGNoLA0KPiAgCX0sDQo+ICB9Ow0KPiAg
DQo=
