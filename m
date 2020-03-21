Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E049018DE83
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 08:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgCUHaT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 03:30:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25348 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727961AbgCUHaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 03:30:19 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L7UF7q008721;
        Sat, 21 Mar 2020 03:30:15 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-00128a01.pphosted.com with ESMTP id 2yw4eb1jd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 03:30:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOcT5kr5sgWAE8cNtEic0Z3R5tj+5N2BifoF8Y/ZZJ6EEaygSVpnIaNz+cb6W1JrW2+NJ4IOSyHFLUCRZOnpgA2ae5qH3s3L6e7vJo3g0lMVDEu5aYmyCJxJTom1f093pJp/j4CLdw+UtwDJibkb4h8vTDLIvrI3XFECR0Rsk2rntNcpSOOxywNCN3U4IFfwtDZIReHtxBnznKb3rUo7V4i4wLEz5br3j5qmIVE9i+ofM2wvWYpBybH5MYq2ZaaOuahKVAJgBv4gOR+cz9ovtWWFbpBMOvalpfxlaFcJqe8pGkdbgDwPRWB3ED4mzcA72HsrOsYG4ZxHqQ5BtTfA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSvrzrTgfjd2Xnp2bS9fkJVVqIoU50huAuQEPCTpxqM=;
 b=ZMh4xM0VjWvuI+c6e9hTgJyi/2ut4CLOCKSmX8qj8y9DkUOupMpcbEJJ50MnpG3r6WcXxsBzT/6bKtEWjVx9FVZtC8uhAqJHFhp2Rvzjti81SKuPEkxlxYovQTNUrCaoI5GYRpSBYs5euXNw569jGf7VIyNkS5IUQyEdE1FFDTcabPneJJJaiD2hgQIgm1mGFC1qh/8T22G8Oh6alGrDZ4i0M7LDo2ahsZ1EZU2Z8gxY9fjtqkJN3zsy/fFVeuBuSvSaWiKRqg3SozEG07pmSlSNdyiv4NcGCce2JiJKqxZ4apuIVuYzXrkbr5vD5owP0UfUCCmHutz1CK2H4BUSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSvrzrTgfjd2Xnp2bS9fkJVVqIoU50huAuQEPCTpxqM=;
 b=7PUa5aDHQIf8cn/zi9lNvqp75lpW0mOchbJajOE/415nTeFTDw0Amdbr+K5gp06XBc4EW259VWN6AOCNfeI4LU51SWMxPlsJOQj09B8IViDvHkE18gDpUmfDAesnvJq5a2j/pufbRuX4GN6fd2P6hYCNBIA8sJlA23Dto5JNlYs=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4617.namprd03.prod.outlook.com (2603:10b6:5:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Sat, 21 Mar
 2020 07:30:13 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sat, 21 Mar 2020
 07:30:13 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v10 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Thread-Topic: [PATCH v10 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Thread-Index: AQHV+6rcE0YESrPUb0Khuhl6hTX7PahRyaOAgADlFwA=
Date:   Sat, 21 Mar 2020 07:30:12 +0000
Message-ID: <ec6b94df12bb1726357f78da32387a7a237a26b9.camel@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
         <20200316155035.25500-7-alexandru.ardelean@analog.com>
         <20200320175339.GA24239@bogus>
In-Reply-To: <20200320175339.GA24239@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ed1ca5f-f3ef-4bb1-ead3-08d7cd69b1cd
x-ms-traffictypediagnostic: DM6PR03MB4617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB461746282BEE96BC6627D40EF9F20@DM6PR03MB4617.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(186003)(26005)(316002)(86362001)(76116006)(91956017)(66446008)(110136005)(64756008)(66476007)(6512007)(66946007)(54906003)(107886003)(4326008)(2616005)(66556008)(966005)(2906002)(8676002)(36756003)(71200400001)(81166006)(5660300002)(6486002)(81156014)(8936002)(6506007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4617;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyLZlFPhLnM6WGZ/uJahVtqeUs+xV7n7z5k5ZdyGanfqj1ZFOjr20qA7y57meUjB2SVEXisjCAdr/0YpFHDm0BI0fIwflDNRDpB6y64LdyZF1CRl7ZhfNpwl/eABnehpGuilbt5W/fyVFKkS5kanwVEJCq6LB6XiMvNh5MHaYOCW0R2vdTyPaYniae2xRyy195fxDRTruci7D2Qs4zRW+UuCwZnfEOChZ7LBUjJXnrcQsRqaNl6H0SnzsEoaQqtYnH7XVoTXNXECg7tNbSBEk9eDukk/8WdB7Rb/wSBBebqlARl0KcML6WGJlocIrvfMLvKf1Xa24L6pfrunsNw2zxen7l4qllPNtY8CpJsX66+jLlwAgcj7ZV5noCLlruDL59Z6sWNCff3b4CRvbGZ6DUOMWeA74OH5f3kyB28x3LvZg2AaKqAsnvBLkhP/wtoH/MXs6U0igsXe5oJssplxGivA3625cyNH9Ns+92wwMDf1LVf35exb1jnurrKEUOhZEjHoZUc5N+f746egATy1Ew==
x-ms-exchange-antispam-messagedata: uyaiyELgUFYbAQFKUkewIGAVbm9b107v/C6IE/0R5NgkzETsgPO6Z3dKjHpdby6ELYLSrCb28xxBqkTZVqn01I6c8BpbB54kYxOgQnWYtwO7gNODaqB1OhJouR8B4O/gjQ/pRtKmGeXUxPQfifyXfQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AC3DA3302188643BCBE85F51D251CD9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed1ca5f-f3ef-4bb1-ead3-08d7cd69b1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 07:30:13.2917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dP7vqJVOY+W9PQoa6x64fqxK1mK6YVbfYT6odNWXvf6LJJWkClROypzl+zHuxd/pEUs9NIwmlYF2uGUVzwVerhZOtcuMVpIAH13DCMMEU0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4617
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_01:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210043
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTIwIGF0IDExOjUzIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBNYXIgMTYsIDIwMjAgYXQgMDU6NTA6MzNQTSArMDIwMCwgQWxleGFuZHJ1IEFyZGVs
ZWFuIHdyb3RlOg0KPiA+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGJpbmRpbmdzIGRvY3VtZW50YXRp
b24gZm9yIHRoZSBBWEkgQURDIGRyaXZlci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiANCj4gWW91
ciBhdXRob3IgYW5kIFMtby1iIGVtYWlscyBkb24ndCBtYXRjaC4NCg0KSG1tLCBjcmFwLg0KSSBz
ZW50IGl0IGZyb20gbXkgR01haWwgYWNjb3VudCwgc2luY2UgdXNpbmcgdGhlIGNvbXBhbnkgb25l
IGlzIGEgYml0IG1vcmUNCmRpZmZpY3VsdCB0aGVzZSBkYXlzIFt3aXRoIFdGSCwgVlBOLCBldGNd
Lg0KDQpJJ2xsIHRyeSB0byBkbyBzb21lIHdvcmsgdG8gYWNjZXNzIHRoZSBjb21wYW55IG9uZS4N
Cg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2lpby9hZGMvYWRpLGF4aS1hZGMueWFt
bCAgICAgICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NjMgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGF4aS0NCj4gPiBhZGMueWFtbA0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2Fk
Yy9hZGksYXhpLWFkYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL2FkYy9hZGksYXhpLWFkYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjZiZDgwZTI0MWY0MA0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYXhp
LWFkYy55YW1sDQo+ID4gQEAgLTAsMCArMSw2MyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+
ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9hZGMv
YWRpLGF4aS1hZGMueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogQW5hbG9nIERldmljZXMg
QVhJIEFEQyBJUCBjb3JlDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIE1pY2hh
ZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiA+ICsgIC0gQWxl
eGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiArDQo+
ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgQW5hbG9nIERldmljZXMgR2VuZXJpYyBBWEkgQURD
IElQIGNvcmUgZm9yIGludGVyZmFjaW5nIGFuIEFEQyBkZXZpY2UNCj4gPiArICB3aXRoIGEgaGln
aCBzcGVlZCBzZXJpYWwgKEpFU0QyMDRCL0MpIG9yIHNvdXJjZSBzeW5jaHJvbm91cyBwYXJhbGxl
bA0KPiA+ICsgIGludGVyZmFjZSAoTFZEUy9DTU9TKS4NCj4gPiArICBVc3VhbGx5LCBzb21lIG90
aGVyIGludGVyZmFjZSB0eXBlIChpLmUgU1BJKSBpcyB1c2VkIGFzIGEgY29udHJvbA0KPiA+ICsg
IGludGVyZmFjZSBmb3IgdGhlIGFjdHVhbCBBREMsIHdoaWxlIHRoaXMgSVAgY29yZSB3aWxsIGlu
dGVyZmFjZQ0KPiA+ICsgIHRvIHRoZSBkYXRhLWxpbmVzIG9mIHRoZSBBREMgYW5kIGhhbmRsZSB0
aGUgc3RyZWFtaW5nIG9mIGRhdGEgaW50bw0KPiA+ICsgIG1lbW9yeSB2aWEgRE1BLg0KPiA+ICsN
Cj4gPiArICBodHRwczovL3dpa2kuYW5hbG9nLmNvbS9yZXNvdXJjZXMvZnBnYS9kb2NzL2F4aV9h
ZGNfaXANCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiAr
ICAgIGVudW06DQo+ID4gKyAgICAgIC0gYWRpLGF4aS1hZGMtMTAuMC5hDQo+ID4gKw0KPiA+ICsg
IHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGRtYXM6DQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBkbWEtbmFtZXM6DQo+ID4gKyAgICBtYXhJdGVt
czogMQ0KPiANCj4gRHJvcCB0aGlzLiBJbXBsaWVkIGJ5ICdpdGVtcycgbGVuZ3RoLg0KPiANCj4g
V2l0aCB0aG9zZSAyIHRoaW5ncyBmaXhlZCwNCj4gDQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPg0KPiANCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNv
bnN0OiByeA0KPiA+ICsNCj4gPiArICBhZGksYWRjLWRldjoNCj4gPiArICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gPiArICAgIGRlc2NyaXB0aW9u
Og0KPiA+ICsgICAgICBBIHJlZmVyZW5jZSB0byBhIHRoZSBhY3R1YWwgQURDIHRvIHdoaWNoIHRo
aXMgRlBHQSBBREMgaW50ZXJmYWNlcyB0by4NCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsg
IC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gZG1hcw0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBhZGks
YWRjLWRldg0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0K
PiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIGF4aS1hZGNANDRhMDAwMDAgew0K
PiA+ICsgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYXhpLWFkYy0xMC4wLmEiOw0KPiA+ICsg
ICAgICAgICAgcmVnID0gPDB4NDRhMDAwMDAgMHgxMDAwMD47DQo+ID4gKyAgICAgICAgICBkbWFz
ID0gPCZyeF9kbWEgMD47DQo+ID4gKyAgICAgICAgICBkbWEtbmFtZXMgPSAicngiOw0KPiA+ICsN
Cj4gPiArICAgICAgICAgIGFkaSxhZGMtZGV2ID0gPCZzcGlfYWRjPjsNCj4gPiArICAgIH07DQo+
ID4gKy4uLg0KPiA+IC0tIA0KPiA+IDIuMjAuMQ0KPiA+IA0K
