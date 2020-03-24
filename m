Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C2A19135A
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 15:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgCXOgl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 10:36:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44176 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727507AbgCXOgk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 10:36:40 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OEZCE9007090;
        Tue, 24 Mar 2020 10:36:20 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs62bkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 10:36:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P82Tk22Okt+BjzO/IATGE/SSydt1SvuR1TtpQ1AOapCn+aomBjQ2vv9rknyMNXcPpngO6wQZA/q9kD9vwrfkKfz7iAd0+tCqBJ8+EdS+51PbKY5S0KhCgAk2hqEzZNMhso8XDIzxzenwzT9x7WSJwOch614ONpvwEt5Aej0FJRaLSg3cB7wzxDX78a7hIa+TEr+jSa91qFSgFRINJONMj+QRsqo7iEEeM0jsfQF2IjdPvsslLRIb6Jb+Bnh9iU+jR9LkSv++wYiSZ8ZTfANNpodHuxfu+ss6LmOL1ko9rBjcKMEyacCOmfArZ9iaZkVIueEG/MVu9uf/LbQk+7l9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs3htKWHjEWv/5W0mDUbJ4SXHyiXI6F586YgoOx1Qfg=;
 b=aZlXHJ3bv8uIKq90LNjT3oVPY3idazaOHKw4MWRJ/mL+ViuZHOABvFedFg2Vt5aqXiXtcgcoE12HF/nGQIJQSnut4KjN3PZTGVOECaKcSnfagk25JWFAeVhnd0KeuQ+KnlNs6agqR0yVIRjQVxaBE/O1vxdPwjmKh8NvbhOjpDzAxeqYCvWMY8ypfKypRy6kzheUfkBTpytzM4TazJ+98G4HVWRRC7/bWBcJFb/rkiGWRTefFYMhyIlt21kpFojyV5i7I5zxgOB1xvP0VYlHcOAKP7XKlEEVXIIe6kyKea9Y9b/DRlTQ8QqJmB9v3zYVwjGIDJEAOnxRMAWmV9Rq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs3htKWHjEWv/5W0mDUbJ4SXHyiXI6F586YgoOx1Qfg=;
 b=xtPbFPywQRjO5v9RbWmBqQnIhu440/uTZ7b4gTVz/Ur57HhDzzQvfj7W41XnD96JG2Km0hnYOpNmP5S+/h3icpOftQ7tnJn4DEiJ0SNqM0v8q7FQ9emKnNO4XjyUV7txK/pYD20SIos4LDApPdgueqHcnyD8zJQ3A72FUCJqxDE=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4779.namprd03.prod.outlook.com (2603:10b6:5:183::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Tue, 24 Mar
 2020 14:36:17 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 14:36:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
Thread-Topic: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
Thread-Index: AQHWAebi7aO41Y5x5k6gn74zl2E1tahXz1SA
Date:   Tue, 24 Mar 2020 14:36:17 +0000
Message-ID: <9f86acf4eb5a3bea823797705108e16949e89e34.camel@analog.com>
References: <20200324141624.30597-1-lars@metafoo.de>
In-Reply-To: <20200324141624.30597-1-lars@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c52d5fbd-84c2-44d7-1d45-08d7d000b646
x-ms-traffictypediagnostic: DM6PR03MB4779:
x-microsoft-antispam-prvs: <DM6PR03MB4779FBD7352E65840BED0FC0F9F10@DM6PR03MB4779.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(81166006)(5660300002)(81156014)(8936002)(186003)(26005)(36756003)(6506007)(86362001)(8676002)(71200400001)(2906002)(316002)(110136005)(6486002)(2616005)(478600001)(6512007)(66446008)(66556008)(64756008)(66946007)(76116006)(91956017)(66476007)(4326008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4779;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUUNw6xMijgrerHxR4BW/5ixNP+gynNv+3htEReumqNdhP00787NvxU2HTPSbKJrv3VMTxWhGJMFsTP5+Tnwodpi3Q9XGMgHmCFPlm/zfoUljWI7Z4bXsUp2Zy86K5RYdcWxK9twJlUisJOMv6xFfdNSKBVbhEwbphHc1Efb3ohSwyuLLzO4IYsqrXSLVgsGA3rc21lp3nTdJshIHTEO6jcZtx5rz4CsS0urB6xClX1m6x10L1U08nk9QFJNu31fKK6xdeNDRKBLjHR5k3EvIn7QoLnNc9AxrGss3oejqAzfvezYpTyGvTigB6MMBjFOi8SnlPUS/rEUOD1Y/r5snCQfblR/tPBKmg70G0HgWIm+qdEaeeAzyOFWPpQJUqgZxQb2lNrhUz1O1ZG3SIh4gBfesYYgnQG/s+FOVnVnuCFJcZbjM+0aJOhGuqzcXSHe
x-ms-exchange-antispam-messagedata: GbqpsnzR4UXtnnmvDw8HLe6Ho02X/47k8IYur/Y5BWBqjIE3kQdhhHnMpTAuKtr73ubxL64/4g0QVlQXDmqJdnE6kuKGlL9V65PlzukV1aLHCo1K4YOtmFvKSk+aF1yUcbbrvRHa5olvcqQNhJK8tQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A789DF118877C2478378ACB29F012658@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52d5fbd-84c2-44d7-1d45-08d7d000b646
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 14:36:17.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEkV7gNGfwJvpUotIToeqfrzNRDOc1Rw6CgknIwcYoxDw4KjNgviJh7K0Fp1vkykesANFu8SmnWiytQ53yv21DUAsLOTz36t+a6ie1gb0Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4779
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTI0IGF0IDE1OjE2ICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IFRoZSBJSU8gRE1BIGJ1ZmZlciBpcyBhIERNQSBidWZm
ZXIgaW1wbGVtZW50YXRpb24uIEFzIHN1Y2ggaXQgc2hvdWxkDQo+IGluY2x1ZGUgYnVmZmVyX2lt
cGwuaCByYXRoZXIgdGhhbiBidWZmZXIuaC4NCj4gDQo+IFRoZSBpbmNsdWRlIHRvIGJ1ZmZlci5o
IGluIGJ1ZmZlci1kbWEuaCBzaG91bGQgYmUgYnVmZmVyX2ltcGwuaCBzbyBpdCBoYXMNCj4gYWNj
ZXNzIHRvIHRoZSBzdHJ1Y3QgaWlvX2J1ZmZlciBkZWZpbml0aW9uLiBUaGUgY29kZSBjdXJyZW50
bHkgb25seSB3b3Jrcw0KPiBiZWNhdXNlIGFsbCBwbGFjZXMgdGhhdCB1c2UgYnVmZmVyLWRtYS5o
IGluY2x1ZGUgYnVmZmVyX2ltcGwuaCBiZWZvcmUgaXQuDQo+IA0KPiBUaGUgaW5jbHVkZSB0byBi
dWZmZXIuaCBpbiBpbmR1c3RyaWFsaW8tYnVmZmVyLWRtYS5jIGFuZA0KPiBpbmR1c3RyaWFsaW8t
YnVmZmVyLWRtYWVuZ2luZS5jIGNhbiBiZSByZW1vdmVkIHNpbmNlIHRob3NlIGZpbGVzIGRvbid0
DQo+IHJlZmVyZW5jZSBhbnkgb2YgYnVmZmVyIGNvbnN1bWVyIGZ1bmN0aW9ucy4NCg0KUmV2aWV3
ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9v
LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVmZmVyLWRt
YS5jICAgICAgIHwgMSAtDQo+ICBkcml2ZXJzL2lpby9idWZmZXIvaW5kdXN0cmlhbGlvLWJ1ZmZl
ci1kbWFlbmdpbmUuYyB8IDEgLQ0KPiAgaW5jbHVkZS9saW51eC9paW8vYnVmZmVyLWRtYS5oICAg
ICAgICAgICAgICAgICAgICAgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2J1ZmZl
ci9pbmR1c3RyaWFsaW8tYnVmZmVyLWRtYS5jDQo+IGIvZHJpdmVycy9paW8vYnVmZmVyL2luZHVz
dHJpYWxpby1idWZmZXItZG1hLmMNCj4gaW5kZXggYTc0YmQ5YzA1ODdjLi5kMzQ4YWY4Yjk3MDUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVmZmVyLWRt
YS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVmZmVyLWRtYS5j
DQo+IEBAIC0xMiw3ICsxMiw2IEBADQo+ICAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BvbGwuaD4NCj4gLSNp
bmNsdWRlIDxsaW51eC9paW8vYnVmZmVyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaWlvL2J1ZmZl
cl9pbXBsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaWlvL2J1ZmZlci1kbWEuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYnVm
ZmVyL2luZHVzdHJpYWxpby1idWZmZXItZG1hZW5naW5lLmMNCj4gYi9kcml2ZXJzL2lpby9idWZm
ZXIvaW5kdXN0cmlhbGlvLWJ1ZmZlci1kbWFlbmdpbmUuYw0KPiBpbmRleCBiMTI5NjkzYWYwZmQu
LjhiNjBkZmY1MjdjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJp
YWxpby1idWZmZXItZG1hZW5naW5lLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYnVmZmVyL2luZHVz
dHJpYWxpby1idWZmZXItZG1hZW5naW5lLmMNCj4gQEAgLTE0LDcgKzE0LDYgQEANCj4gIA0KPiAg
I2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMu
aD4NCj4gLSNpbmNsdWRlIDxsaW51eC9paW8vYnVmZmVyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
aWlvL2J1ZmZlcl9pbXBsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaWlvL2J1ZmZlci1kbWEuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9paW8vYnVmZmVyLWRtYWVuZ2luZS5oPg0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9paW8vYnVmZmVyLWRtYS5oIGIvaW5jbHVkZS9saW51eC9paW8vYnVm
ZmVyLWRtYS5oDQo+IGluZGV4IDAxNmQ4YTA2ODM1My4uZmYxNWM2MWJmMzE5IDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2lpby9idWZmZXItZG1hLmgNCj4gKysrIGIvaW5jbHVkZS9saW51
eC9paW8vYnVmZmVyLWRtYS5oDQo+IEBAIC0xMSw3ICsxMSw3IEBADQo+ICAjaW5jbHVkZSA8bGlu
dXgva3JlZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvbXV0ZXguaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9paW8vYnVmZmVyLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvaWlvL2J1ZmZlcl9pbXBsLmg+DQo+ICANCj4gIHN0cnVjdCBpaW9fZG1hX2J1
ZmZlcl9xdWV1ZTsNCj4gIHN0cnVjdCBpaW9fZG1hX2J1ZmZlcl9vcHM7DQo=
