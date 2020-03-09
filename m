Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F017DF04
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgCILvd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 07:51:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:53310 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgCILvc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 07:51:32 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029BndJb015496;
        Mon, 9 Mar 2020 07:51:17 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ym94cmhqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 07:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HonutNd4wE9hRPxGNAjWDccc3kcJsh+v2HQ+doAKu1lgDQbpoQhGyNa7TLmWgNtsJxDO0LXrkOjyrzwpkQ3eMyJjHcKjVZCW3PPnrXrPcmfXnZl31OEziv2kFbSevFJByOUy/68e9ZsEQ3rE//QWCG/OHLo9TZ8Z3JBUR606U0vwxj7Vkepe5kjcKQF4cw8DZS/idn5gvu1L3W5oTAt9aeTnaUZwIBSnR2G/GlTYfC5BYi/MKu7Fh8U7tPRKPcJI2i9+DYU69f7J3ZOdzcKK5Kcsh6pTbbfmdMK8WOQu1haa4BXOB9iJXzkJ850B4qh/XIadp4kmEz4iimUg8F2/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOmZHTyPIQoGPQjkEtYd6no5w5rjNI3/qmxn7jmUJG8=;
 b=Zd1NkP6WgsvRxI9xx324rD6lO1vGRvDsXAd49UUu9EcTW2EVmy7qLX0MTSXb1JLIE3jhNaUvovsotqjsbclZv+06YxMTYK6E/2rjZzSiFnWoyO/9xTATc/MPmrKDyQO36FATE6xXM3ypjOFBn34HQxe9O0jSxIYcB05YrsIqH0DGWQ8NABGziJxOfKKp3CTMA5rmainxJgaZHVvU1lvYeuhVb48b89HhOG8/ZxZwjRXGaMSnnwYUaYyJ9MKG7jzzSA9g/qmjkky541TS5q5zCCDnfjM/P2SLMtKog2hDc4/w5b6iVTqyzP4ZKtwJL7DAKitqFzvv39n2f8zo8ULYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOmZHTyPIQoGPQjkEtYd6no5w5rjNI3/qmxn7jmUJG8=;
 b=ZP6ZKs86BpyHZiNlPg7QrrE7MRzmdHvt/4r7ahG3LTx+yFqMSaGgfkMXNDon+6rx5sNTFd294Iv+WqygJ79Sp6oN4GV6l53/YHXUsuWRqm8um4antV9Ut/0IyWXL7U4zNCh8gWT6S5eELM/sHOltaynXw27+J7Qy+gljf3NgAr0=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4105.namprd03.prod.outlook.com (2603:10b6:5:5f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 11:51:13 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f8c4:f7f2:c7a0:cc19%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 11:51:13 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v8 7/8] iio: adc: ad9467: add support AD9467 ADC
Thread-Topic: [PATCH v8 7/8] iio: adc: ad9467: add support AD9467 ADC
Thread-Index: AQHV86YjlgUdRcwJn06pzHDhp7+VcKg9PE6AgALudAA=
Date:   Mon, 9 Mar 2020 11:51:12 +0000
Message-ID: <849280cfb709f14f6407925c750547ee4bfa8fff.camel@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
         <20200306110100.22092-8-alexandru.ardelean@analog.com>
         <20200307150513.053b198a@archlinux>
In-Reply-To: <20200307150513.053b198a@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 881dbb29-09a3-4c29-f466-08d7c4202aac
x-ms-traffictypediagnostic: DM6PR03MB4105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4105179529B5B8E4D0B5D377F9FE0@DM6PR03MB4105.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(4326008)(186003)(54906003)(36756003)(6512007)(6916009)(966005)(478600001)(86362001)(26005)(81166006)(81156014)(5660300002)(64756008)(316002)(6506007)(66476007)(66556008)(2906002)(66446008)(8676002)(8936002)(2616005)(66946007)(76116006)(6486002)(91956017)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4105;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0VJ2eBBYCbo7k6RunkDcZ3U6Khovw5tGBYh8ATg65SkL3vRM1+UloVs61zClDR3jVF5T0anbnQGDDEQ7+QlIKOo3Ve6yuNcNBtmEwGo2ZFL4AYhehlRHIoc6Ea7C69a8YaGaYevnQVTAaIqI6bx9alfTtpdYf3tDF5lrxFyaJvRZUX6utoYJLtiY2/PnGqE563alqOCDz65H6FxxAJFM1lOOUYsIn61EbG9n3M3Ev93RwhKn7NVuqSpAXl00BWgkLLdZPngXfeF2b6P89OBCE16kH2qkdknXc8+cTKzfWAnHvft+eTN/MqQEbgxOfR4Uj1cXjrZpVzpBaltOSKhXej2GF7JFVqzGm3tN+2B/jSwweGCS4qcin/6YUUYOB5GqP+xBsAVFy4mStIokYVbdpZuj5HmZa1AxCwFRrJFOwQaZi2gSz7TB4e1VXO4wUkjNh7vqKPcFP2bD05QBdvLHrH8Alrr7Jiz9bnA8dZAvBB2ydBBLGbRQiie+2eM8Ad7kzCZe20jEViPmZBoRf1sWA==
x-ms-exchange-antispam-messagedata: xLK6mav/kG0ODU+sqv2jaOHVaqa2J5H7jNtOIP+loC7Q484AGpJGVdJdxO4PoFXZvSETfE76qpiOoA52m893pb8iywApDPGA47kyetDnQLzFQ+8zNNBENX6XBKRPGuIFvMsMgdp0caQn82SY9GuRIQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3AB8F125083FC4DA2EED68B3327A02E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881dbb29-09a3-4c29-f466-08d7c4202aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 11:51:12.8151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9N0zZYcSiI5iItu/Wa+ZWCzaAoPb0bMWfBotynT81zSJ26k9TeyCB2FWzeCkxmWBbyJbBBT5FB56GumvUMOlhw9bCcoau6j23Mbv9ZAm0ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4105
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_02:2020-03-08,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090084
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTA3IGF0IDE1OjA1ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDYgTWFyIDIwMjAgMTM6MDA6NTkgKzAyMDAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IEZyb206IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBh
bmFsb2cuY29tPg0KPiA+IA0KPiA+IFRoZSBBRDk0NjcgaXMgYSAxNi1iaXQsIG1vbm9saXRoaWMs
IElGIHNhbXBsaW5nIGFuYWxvZy10by1kaWdpdGFsIGNvbnZlcnRlcg0KPiA+IChBREMpLiBJdCBp
cyBvcHRpbWl6ZWQgZm9yIGhpZ2ggcGVyZm9ybWFuY2VvdmVyIHdpZGUgYmFuZHdpZHRocyBhbmQg
ZWFzZSBvZg0KPiA+IHVzZS4gVGhlIHByb2R1Y3Qgb3BlcmF0ZXMgYXQgYSAyNTAgTVNQUyBjb252
ZXJzaW9uIHJhdGUgYW5kIGlzIGRlc2lnbmVkIGZvcg0KPiA+IHdpcmVsZXNzIHJlY2VpdmVycywg
aW5zdHJ1bWVudGF0aW9uLCBhbmQgdGVzdCBlcXVpcG1lbnQgdGhhdCByZXF1aXJlIGEgaGlnaA0K
PiA+IGR5bmFtaWMgcmFuZ2UuIFRoZSBBREMgcmVxdWlyZXMgMS44IFYgYW5kIDMuMyBWIHBvd2Vy
IHN1cHBsaWVzIGFuZCBhIGxvdw0KPiA+IHZvbHRhZ2UgZGlmZmVyZW50aWFsIGlucHV0IGNsb2Nr
IGZvciBmdWxsIHBlcmZvcm1hbmNlIG9wZXJhdGlvbi4gTm8NCj4gPiBleHRlcm5hbCByZWZlcmVu
Y2Ugb3IgZHJpdmVyIGNvbXBvbmVudHMgYXJlIHJlcXVpcmVkIGZvciBtYW55IGFwcGxpY2F0aW9u
cy4NCj4gPiBEYXRhIG91dHB1dHMgYXJlIExWRFMgY29tcGF0aWJsZSAoQU5TSS02NDQgY29tcGF0
aWJsZSkgYW5kIGluY2x1ZGUgdGhlDQo+ID4gbWVhbnMgdG8gcmVkdWNlIHRoZSBvdmVyYWxsIGN1
cnJlbnQgbmVlZGVkIGZvciBzaG9ydCB0cmFjZSBkaXN0YW5jZXMuDQo+ID4gDQo+ID4gU2luY2Ug
dGhlIGNoaXAgY2FuIG9wZXJhdGUgYXQgc3VjaCBoaWdoIHNhbXBsZS1yYXRlcyAobXVjaCBoaWdo
ZXIgdGhhbg0KPiA+IGNsYXNzaWNhbCBpbnRlcmZhY2VzKSwgaXQgcmVxdWlyZXMgdGhhdCBhIERN
QSBjb250cm9sbGVyIGJlIHVzZWQgdG8NCj4gPiBpbnRlcmZhY2UgZGlyZWN0bHkgdG8gdGhlIGNo
aXAgYW5kIHB1c2ggZGF0YSBpbnRvIG1lbW9yeS4NCj4gPiBUeXBpY2FsbHksIHRoZSBBWEkgQURD
IElQIGNvcmUgaXMgdXNlZCB0byBpbnRlcmZhY2Ugd2l0aCBpdC4NCj4gPiANCj4gPiBMaW5rOiAN
Cj4gPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0
aW9uL2RhdGEtc2hlZXRzL0FEOTQ2Ny5wZGYNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMYXJz
LVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNo
YWVsIEhlbm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
Pg0KPiANCj4gQSBmZXcgbWlub3IgdGhpbmdzIGJ1dCBvdGhlcndpc2UgbG9va3MgZ29vZCB0byBt
ZS4uDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9hZGMvS2NvbmZpZyAgfCAgMTUgKysN
Cj4gPiAgZHJpdmVycy9paW8vYWRjL01ha2VmaWxlIHwgICAxICsNCj4gPiAgZHJpdmVycy9paW8v
YWRjL2FkOTQ2Ny5jIHwgNDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDQ0OCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2lpby9hZGMvYWQ5NDY3LmMNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vYWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiA+
IGluZGV4IDQ0NTA3MGFiZjM3Ni4uYTA3OTY1MTBmOWQ0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvaWlvL2FkYy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcNCj4g
PiBAQCAtMjQ2LDYgKzI0NiwyMSBAQCBjb25maWcgQUQ3OTlYDQo+ID4gIAkgIFRvIGNvbXBpbGUg
dGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZSBtb2R1bGUgd2lsbCBi
ZQ0KPiA+ICAJICBjYWxsZWQgYWQ3OTl4Lg0KPiA+ICANCj4gLi4uDQo+ID4gK3N0YXRpYyBpbnQg
YWQ5NDY3X3NwaV9yZWFkKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksIHVuc2lnbmVkIGludCByZWcp
DQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGNoYXIgYnVmWzNdOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArDQo+ID4gKwlidWZbMF0gPSAweDgwIHwgKHJlZyA+PiA4KTsNCj4gPiArCWJ1ZlsxXSA9IHJl
ZyAmIDB4RkY7DQo+ID4gKw0KPiA+ICsJcmV0ID0gc3BpX3dyaXRlX3RoZW5fcmVhZChzcGksICZi
dWZbMF0sIDIsICZidWZbMl0sIDEpOw0KPiANCj4gV2h5IG5vdCBzcGxpdCBidWYgaW50byBzZW5k
IHBhcnQgYW5kIHJlY2VpdmU/ICBNaWdodCBtYWtlIGl0IHNsaWdodGx5DQo+IG1vcmUgcmVhZGFi
bGUgZm9yIG5vIGFjdHVhbCBjb3N0Li4NCg0Kc3VyZQ0KDQo+IA0KPiA+ICsNCj4gPiArCWlmIChy
ZXQgPCAwKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGJ1ZlsyXTsN
Cj4gPiArfQ0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgYWQ5NDY3X3dyaXRlX3JhdyhzdHJ1
Y3QgYWRpX2F4aV9hZGNfY29udiAqY29udiwNCj4gPiArCQkJICAgIHN0cnVjdCBpaW9fY2hhbl9z
cGVjIGNvbnN0ICpjaGFuLA0KPiA+ICsJCQkgICAgaW50IHZhbCwgaW50IHZhbDIsIGxvbmcgbWFz
aykNCj4gPiArew0KPiA+ICsJY29uc3Qgc3RydWN0IGFkaV9heGlfYWRjX2NoaXBfaW5mbyAqaW5m
byA9IGNvbnYtPmNoaXBfaW5mbzsNCj4gPiArCXN0cnVjdCBhZDk0Njdfc3RhdGUgKnN0ID0gYWRp
X2F4aV9hZGNfY29udl9wcml2KGNvbnYpOw0KPiA+ICsJdW5zaWduZWQgbG9uZyByX2NsazsNCj4g
PiArDQo+ID4gKwlzd2l0Y2ggKG1hc2spIHsNCj4gPiArCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FM
RToNCj4gPiArCQlyZXR1cm4gYWQ5NDY3X3NldF9zY2FsZShjb252LCB2YWwsIHZhbDIpOw0KPiA+
ICsJY2FzZSBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUToNCj4gPiArCQlpZiAoIXN0LT5jbGspDQo+
ID4gKwkJCXJldHVybiAtRU5PREVWOw0KPiA+ICsNCj4gPiArCQlpZiAoY2hhbi0+ZXh0ZW5kX25h
bWUpDQo+IA0KPiBUaGlzIGlzIGEgdmVyeSAnb2RkJyB0ZXN0LiAgV2h5Pw0KDQpsZWZ0LW92ZXIg
ZnJvbSB0aGUgb3JpZ2luYWwgZHJpdmVyOyBhbmQgaXQgc2xpcHBlZCB3aGVuIGkgYWRhcHRlZCBm
cm9tIHRoYXQ7DQpubyBpZGVhIHdoeSBpdCB3YXMgYWRkZWQ7IGFuZCBnaXQgaGlzdG9yeSBpcyBu
b3QgaGVscGluZyBlaXRoZXI7DQp3aWxsIGRyb3A7DQoNCj4gDQo+ID4gKwkJCXJldHVybiAtRU5P
REVWOw0KPiA+ICsNCj4gPiArCQlyX2NsayA9IGNsa19yb3VuZF9yYXRlKHN0LT5jbGssIHZhbCk7
DQo+ID4gKwkJaWYgKHJfY2xrIDwgMCB8fCByX2NsayA+IGluZm8tPm1heF9yYXRlKSB7DQo+ID4g
KwkJCWRldl93YXJuKCZzdC0+c3BpLT5kZXYsDQo+ID4gKwkJCQkgIkVycm9yIHNldHRpbmcgQURD
IHNhbXBsZSByYXRlICVsZCIsIHJfY2xrKTsNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4g
KwkJfQ0KPiA+ICsNCj4gPiArCQlyZXR1cm4gY2xrX3NldF9yYXRlKHN0LT5jbGssIHJfY2xrKTsN
Cj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gK30N
Cj4gPiArDQo+IC4uLg0KPiA+ICtzdGF0aWMgaW50IGFkOTQ2N19wcm9iZShzdHJ1Y3Qgc3BpX2Rl
dmljZSAqc3BpKQ0KPiA+ICt7DQo+ID4gKwljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICpvaWQ7
DQo+ID4gKwlzdHJ1Y3QgYWRpX2F4aV9hZGNfY29udiAqY29udjsNCj4gPiArCXN0cnVjdCBhZDk0
Njdfc3RhdGUgKnN0Ow0KPiA+ICsJdW5zaWduZWQgaW50IGlkOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArDQo+ID4gKwlpZiAoIXNwaS0+ZGV2Lm9mX25vZGUpIHsNCj4gPiArCQlkZXZfZXJyKCZzcGkt
PmRldiwgIkRUIG5vZGUgaXMgbnVsbFxuIik7DQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+IA0K
PiBTaWxseSBxdWVzdGlvbiBmb3IgeW91LiAgQ2FuIHRoaXMgaGFwcGVuPyAgV2UgY2FuIG9ubHkg
cHJvYmUgdGhpcw0KPiBpZiBpdCBpcyBpbiBEVCBhbmQgaGVuY2UgdGhlcmUgbXVzdCBiZSBhIG5v
ZGUgdG8gZ2V0IGhlcmUgSSB0aGluay4NCg0KZ29vZCBwb2ludDsNCndpbGwgZHJvcDsNCmxvb2tz
IGxpa2Ugc29tZXRoaW5nIGkgYWRkZWQgaW5lcnRpYWxseQ0KDQo+IA0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCW9pZCA9IG9mX21hdGNoX25vZGUoYWQ5NDY3X29mX21hdGNoLCBzcGktPmRldi5vZl9u
b2RlKTsNCj4gPiArCWlmICghb2lkKQ0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiANCj4gWW91
IG9ubHkgZXZlciB3YW50IHRoZSBkYXRhIGZpZWxkIHNvIHlvdSBjYW4gZ2V0IHRoYXQgZGlyZWN0
bHkuDQo+IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YQ0KDQphY2sNCg0KPiANCj4gPiArDQo+ID4g
Kwljb252ID0gZGV2bV9hZGlfYXhpX2FkY19jb252X3JlZ2lzdGVyKCZzcGktPmRldiwgc2l6ZW9m
KCpzdCkpOw0KPiA+ICsJaWYgKElTX0VSUihjb252KSkNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihj
b252KTsNCj4gPiArDQo+ID4gKwlzdCA9IGFkaV9heGlfYWRjX2NvbnZfcHJpdihjb252KTsNCj4g
PiArCXN0LT5zcGkgPSBzcGk7DQo+ID4gKw0KPiA+ICsJc3QtPmNsayA9IGRldm1fY2xrX2dldCgm
c3BpLT5kZXYsICJhZGMtY2xrIik7DQo+ID4gKwlpZiAoSVNfRVJSKHN0LT5jbGspKQ0KPiA+ICsJ
CXJldHVybiBQVFJfRVJSKHN0LT5jbGspOw0KPiA+ICsNCj4gPiArCXJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShzdC0+Y2xrKTsNCj4gPiArCWlmIChyZXQgPCAwKQ0KPiA+ICsJCXJldHVybiByZXQ7
DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCZzcGktPmRldiwg
YWQ5NDY3X2Nsa19kaXNhYmxlLCBzdCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiBy
ZXQ7DQo+ID4gKw0KPiA+ICsJc3QtPnB3cmRvd25fZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlv
bmFsKCZzcGktPmRldiwgInBvd2VyZG93biIsDQo+ID4gKwkJCQkJCSAgIEdQSU9EX09VVF9MT1cp
Ow0KPiA+ICsJaWYgKElTX0VSUihzdC0+cHdyZG93bl9ncGlvKSkNCj4gPiArCQlyZXR1cm4gUFRS
X0VSUihzdC0+cHdyZG93bl9ncGlvKTsNCj4gPiArDQo+ID4gKwlzdC0+cmVzZXRfZ3BpbyA9IGRl
dm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCZzcGktPmRldiwgInJlc2V0IiwNCj4gPiArCQkJCQkJIEdQ
SU9EX09VVF9MT1cpOw0KPiA+ICsJaWYgKElTX0VSUihzdC0+cmVzZXRfZ3BpbykpDQo+ID4gKwkJ
cmV0dXJuIFBUUl9FUlIoc3QtPnJlc2V0X2dwaW8pOw0KPiA+ICsNCj4gPiArCWlmIChzdC0+cmVz
ZXRfZ3Bpbykgew0KPiA+ICsJCXVkZWxheSgxKTsNCj4gPiArCQlyZXQgPSBncGlvZF9kaXJlY3Rp
b25fb3V0cHV0KHN0LT5yZXNldF9ncGlvLCAxKTsNCj4gPiArCQltZGVsYXkoMTApOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCXNwaV9zZXRfZHJ2ZGF0YShzcGksIHN0KTsNCj4gPiArDQo+ID4gKwlp
ZCA9ICh1bnNpZ25lZCBpbnQpb2lkLT5kYXRhOw0KPiA+ICsJY29udi0+Y2hpcF9pbmZvID0gJmFk
OTQ2N19jaGlwX2luZm9fdGJsW2lkXTsNCj4gPiArDQo+ID4gKwlpZCA9IGFkOTQ2N19zcGlfcmVh
ZChzcGksIEFOODc3X0FEQ19SRUdfQ0hJUF9JRCk7DQo+ID4gKwlpZiAoaWQgIT0gY29udi0+Y2hp
cF9pbmZvLT5pZCkgew0KPiA+ICsJCWRldl9lcnIoJnNwaS0+ZGV2LCAiVW5yZWNvZ25pemVkIENI
SVBfSUQgMHglWFxuIiwgaWQpOw0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCWNvbnYtPnJlZ19hY2Nlc3MgPSBhZDk0NjdfcmVnX2FjY2VzczsNCj4gPiArCWNv
bnYtPndyaXRlX3JhdyA9IGFkOTQ2N193cml0ZV9yYXc7DQo+ID4gKwljb252LT5yZWFkX3JhdyA9
IGFkOTQ2N19yZWFkX3JhdzsNCj4gPiArCWNvbnYtPnByZWVuYWJsZV9zZXR1cCA9IGFkOTQ2N19w
cmVlbmFibGVfc2V0dXA7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGFkOTQ2N19zZXR1cChzdCwgaWQp
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgYWQ5NDY3X2Ry
aXZlciA9IHsNCj4gPiArCS5kcml2ZXIgPSB7DQo+ID4gKwkJLm5hbWUgPSAiYWQ5NDY3IiwNCj4g
PiArCQkub2ZfbWF0Y2hfdGFibGUgPSBhZDk0Njdfb2ZfbWF0Y2gsDQo+ID4gKwl9LA0KPiA+ICsJ
LnByb2JlID0gYWQ5NDY3X3Byb2JlLA0KPiA+ICt9Ow0KPiA+ICttb2R1bGVfc3BpX2RyaXZlcihh
ZDk0NjdfZHJpdmVyKTsNCj4gPiArDQo+ID4gK01PRFVMRV9BVVRIT1IoIk1pY2hhZWwgSGVubmVy
aWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPiIpOw0KPiA+ICtNT0RVTEVfREVTQ1JJ
UFRJT04oIkFuYWxvZyBEZXZpY2VzIEFEOTQ2NyBBREMgZHJpdmVyIik7DQo+ID4gK01PRFVMRV9M
SUNFTlNFKCJHUEwgdjIiKTsNCg==
