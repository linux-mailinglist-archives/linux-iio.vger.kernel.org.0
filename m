Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB195150534
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 12:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBCL0N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 06:26:13 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10396 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbgBCL0M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 06:26:12 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013BP5W2000652;
        Mon, 3 Feb 2020 06:25:49 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xw3yfbm5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 06:25:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OijYWjZbaqy1RDiuTjvYlrGxzghLmbaX5pcd4CxxwEC7+66d5QiH3V/o5saFjssNNv9ZfvMz1ASuGJbj/LUvY4xyfO124Rb/PIBi1dfbincmsdyU372DRZlBHKXJ5aF7K2m4CLpNtMdWoNLlwx8z0NAOyLqvlU0ZD5S3za5gohA18oFM2JLlGzAlSWNDFoMgMrq2h/M8Be6PG7SX1A0zRGuP2K14J2Ca+LCa+TkST6AoDmrKMWl9f5XJjlqynCoqkj2CVzDuUbD6hMh1HteiUAeS16VN+9IGkkxyDma/pCPqe5mu49StdQxq26vkkpDmuvwwoZybtaSPI3ExLYnFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32159XYL98OAOZ0L6LgpLCYfYodYtPeNzonixG3LboA=;
 b=n+25su4TfE3Dcwq8AwWGqqijJQKCHnMuvPeWnmflsxvQyWUI5ojMzwuxs+JTW12XXzxixVw07dxYBo22WRSdiZjNgHfjxFvlwQsydPYhYCwZyE3FZv26qMekDfITBxsMp0VtZYmpuDZuDnpSPkfmK5UYpC9iXhiUGQapcoqZqj5XGjAuJWfNR4R0w+EcfjmTJcmdcFH+8fSmz0t+I2J3iFHkiaYnKQ1uuxvSSzsj3g9AjzCABttB7XfVNSe8bc+ltBCtsX83gPZGzDHO/XN36YYcx9mPPOcVd4r2ZXL0yjsQWT09iymZHOqE1LdvYHSPcwjvJJ/E2kYvBPTa2sSOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32159XYL98OAOZ0L6LgpLCYfYodYtPeNzonixG3LboA=;
 b=H0uLzTXJane3ifYqcMg4iTtEC0EWMVheuvcd7Q5zUeR+inj8WhSFD4mf9neNfYLyZNGpjVJ8b7WR8hbceQiiHdSbwihGDK0VdKLzYLR571OKd3V5EiHR8Od85HVAPNdQd4q/nuBCnsjreTevEQY5GXqj6tyEyE7oJHEYa/RMVEs=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5302.namprd03.prod.outlook.com (20.180.4.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 11:25:48 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 11:25:48 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "Bia, Beniamin" <Beniamin.Bia@analog.com>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: amplifiers: Add docs for HMC425A
 Step Attenuator
Thread-Topic: [PATCH v4 4/5] dt-bindings: iio: amplifiers: Add docs for
 HMC425A Step Attenuator
Thread-Index: AQHV1q9zve533SRKIEWVRu1nSLh7VKgHwMQAgAGbOYA=
Date:   Mon, 3 Feb 2020 11:25:48 +0000
Message-ID: <17fefa85f2c441549bc07e08fb13994b10854fbf.camel@analog.com>
References: <20200129142301.13918-1-beniamin.bia@analog.com>
         <20200129142301.13918-5-beniamin.bia@analog.com>
         <20200202105358.27b6b8a6@archlinux>
In-Reply-To: <20200202105358.27b6b8a6@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68bb82a1-63d6-425f-cbcf-08d7a89bd17a
x-ms-traffictypediagnostic: CH2PR03MB5302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5302456774285B95D0921AD5F9000@CH2PR03MB5302.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(346002)(39860400002)(199004)(189003)(6512007)(4326008)(478600001)(81166006)(81156014)(2616005)(6636002)(8676002)(966005)(316002)(110136005)(54906003)(2906002)(76116006)(66446008)(64756008)(71200400001)(66476007)(66556008)(7416002)(6506007)(5660300002)(26005)(186003)(86362001)(36756003)(8936002)(66946007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5302;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/YDgLV+1KVHH1Z993W8gNPN9Yf3tSn2sZMFmQfVmPdcmseJyJmLovmTBUPyBTwIVRFUwy860PAYJD3raXHcFMoA3fxzaSQQObo3Kn9Wa9tZsS7yHjJIMVemeGl/C87NSXQqYy9RSdDquZxcSEGNFMED5Mb5M+2axc9Hp7H1Zxaq5BvZ18pYTUCyokMgorrDEMvZwZxL+sNStDc369SPGx6yoAJy9C2+vE+JIQcxnGsoKLxZzTnTb1yaCsm71dbTi8ebhHk18cL1WK7IXD4zjKxhpECdGGnb9ARF+N08BI5Rg8ERwTU17buyKMDdxzv4ujAtJQT5434ppyvMA0USEL7UwEfbw1iOwomAfmMvda1cVjUp0Mna7m0XqRQJHGoXt7/bvnsO06O880xyuKzWCjTUPDPsHVufxQrqUP/DgpBNu6uR1puudplbw1x4RIAJ/qxbQtiQkwhbwnQIvoLauXs7dWFE38hmjjNS37dR5Eh6zu5LaNm8qziQWqYNogcPViYo07cYzl/Ooj+ul1VR8g==
x-ms-exchange-antispam-messagedata: ALDo/13LTHMhFPq96SeHGZDG9cHN0MiA3jBdtBLY15LOpvsLs2P0zBksqJrfMQWWdhm8NJp8dhL7cVw3JPo6qpCmXrfv87zRgdZc4KK/iZKlLK72ZPCVWOL0rUDwxfKRH4Na0ti2MlnpwvgAkdzP6w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1491AAE00DC5340BFD6697DECFACC6F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bb82a1-63d6-425f-cbcf-08d7a89bd17a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 11:25:48.2882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQ9UqfieOQroPlr0NfAZrVGGZ6uqO8eKsNpD1nf5OasKzAwW95zWguFcQuEhnP7pfxzi5e/7FlgBG3WoiqMr6JSB/o/P+7TyFkV/ov1BsGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5302
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_03:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2002030087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTAyLTAyIGF0IDEwOjUzICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBXZWQsIDI5IEphbiAyMDIwIDE2OjIzOjAwICswMjAwDQo+IEJlbmlhbWluIEJpYSA8
YmVuaWFtaW4uYmlhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBNaWNoYWVsIEhl
bm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gPiANCj4gPiBEb2N1bWVu
dCBzdXBwb3J0IGZvciBBbmFsb2cgRGV2aWNlcyBNQzQyNUEgU3RlcCBBdHRlbnVhdG9yLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmlj
aEBhbmFsb2cuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlbmlhbWluIEJpYSA8YmVuaWFtaW4u
YmlhQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9paW8vYW1wbGlmaWVy
cy9hZGksaG1jNDI1YS55YW1sICB8IDQ4ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hbXBsaWZpZXJzL2FkaSxobWM0
MjVhLnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL2FtcGxpZmllcnMvYWRpLGhtYzQyNWEueWFtbA0KPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hbXBsaWZpZXJzL2FkaSxobWM0MjVh
LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4u
ZDgwMDYzOWMxNGE1DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYW1wbGlmaWVycy9hZGksaG1jNDI1YS55YW1sDQo+ID4g
QEAgLTAsMCArMSw0OCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICsk
aWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9hbXBsaWZpZXJzL2FkaSxobWM0
MjVhLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IEhNQzQyNUEgNi1iaXQgRGlnaXRhbCBT
dGVwIEF0dGVudWF0b3INCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICstIE1pY2hhZWwg
SGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiA+ICstIEJlbmlhbWlu
IEJpYSA8YmVuaWFtaW4uYmlhQGFuYWxvZy5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjog
fA0KPiA+ICsgIERpZ2l0YWwgU3RlcCBBdHRlbnVhdG9yIElJTyBkZXZpY2Ugd2l0aCBncGlvIGlu
dGVyZmFjZS4NCj4gPiArICBITUM0MjVBIDAuNSBkQiBMU0IgR2FBcyBNTUlDIDYtQklUIERJR0lU
QUwgUE9TSVRJVkUgQ09OVFJPTCBBVFRFTlVBVE9SLA0KPiA+IDIuMiAtIDguMCBHSHoNCj4gPiAr
ICANCj4gPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVu
dGF0aW9uL2RhdGEtc2hlZXRzL2htYzQyNUEucGRmDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0K
PiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGFkaSxobWM0
MjVhDQo+ID4gKw0KPiA+ICsgIHZjYy1zdXBwbHk6IHRydWUNCj4gPiArDQo+ID4gKyAgY3RybC1n
cGlvczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBNdXN0IGNvbnRhaW4gYW4g
YXJyYXkgb2YgNiBHUElPIHNwZWNpZmllcnMsIHJlZmVycmluZyB0byB0aGUgR1BJTw0KPiA+IHBp
bnMNCj4gPiArICAgICAgY29ubmVjdGVkIHRvIHRoZSBjb250cm9sIHBpbnMgVjEtVjYuDQo+ID4g
KyAgICBtYXhJdGVtczogNg0KPiANCj4gRG9lcyB0aGlzIGZvcmNlIGV4YWN0bHkgNj8NCg0KSSdt
IFthbHNvXSBhIGJpdCB1bnN1cmUgd2hldGhlciB0byBmb3JjZSB0aGlzIG51bWJlciBpbiBEVC4N
Ck9uZSBpZGVhIFt3aXRoIHRoaXMgZHJpdmVyXSB3b3VsZCBiZSB0byBtYXliZSBoYXZlIGl0IHN1
cHBvcnQgbXVsdGlwbGUgb2YgdGhlc2UNCkdQSU8tY29udHJvbGxlZCBhdHRlbnVhdG9ycy9hbXBs
aWZpZXJzLiBBbmQgdGhvc2UgY291bGQgaGF2ZSBhIGhpZ2hlci9sb3dlcg0KbnVtYmVyIG9mIEdQ
SU9zLg0KDQpJbiBhbnkgY2FzZSwgd2UgY291bGQgZW5mb3JjZSB0aGlzIGFzLWlzIFtmb3Igbm93
XSwgYW5kIHNlZSBsYXRlciB3aGVuL2lmIGFkZGluZw0KbmV3IHBhcnRzLg0KTm8gc3Ryb25nIG9w
aW5pb24gZnJvbSBteSBzaWRlIGFib3V0IHRoaXMgdGhvdWdoLg0KDQo+IA0KPiA+ICsNCj4gPiAr
cmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSBjdHJsLWdwaW9zDQo+ID4g
Kw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9ncGlvL2dwaW8uaD4NCj4gPiArICAgIGdwaW9faG1jNDI1YTogaG1jNDI1YSB7DQo+ID4g
KyAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGhtYzQyNWEiOw0KPiA+ICsgICAgICBjdHJsLWdwaW9z
ID0gPCZncGlvIDQwIEdQSU9fQUNUSVZFX0hJR0g+LA0KPiA+ICsgICAgICAgIDwmZ3BpbyAzOSBH
UElPX0FDVElWRV9ISUdIPiwNCj4gPiArICAgICAgICA8JmdwaW8gMzggR1BJT19BQ1RJVkVfSElH
SD4sDQo+ID4gKyAgICAgICAgPCZncGlvIDM3IEdQSU9fQUNUSVZFX0hJR0g+LA0KPiA+ICsgICAg
ICAgIDwmZ3BpbyAzNiBHUElPX0FDVElWRV9ISUdIPiwNCj4gPiArICAgICAgICA8JmdwaW8gMzUg
R1BJT19BQ1RJVkVfSElHSD47DQo+ID4gKyAgICAgIHZjYy1zdXBwbHkgPSA8JmZvbz47DQo+ID4g
KyAgICB9Ow0KPiA+ICsuLi4NCg==
