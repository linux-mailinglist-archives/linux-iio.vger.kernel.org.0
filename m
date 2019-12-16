Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A411FF31
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLPHtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 02:49:23 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:39824 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbfLPHtW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2019 02:49:22 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBG7jpbI001451;
        Mon, 16 Dec 2019 02:49:19 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wvw8ck2pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 02:49:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9SSMLCcHoIX6s6m6i67KKnBNny/P35yDLxlJw+33zMsnpfjyjOQ2yIhHKlNNmC1XVmfz6UFOxnm5Xp4NO+LnJNTVJl1ASPROM3h2zDrWZpUQhtYR1a9EdFR7Zh+5Ow9Vhf+AHUBiuDMHXpVqlAkNd/owjzmldRWNVUYApTDVPMx6gWb9od3tTgiGbLzqGzpLY6jtRXetfvqMM04ZbzI1CvDlDfXWNVI09eTS4mYjp/BtbQWwXZf2Xu+HHgE2Teg0l7ROwuM7yiVF9tdpOBJG9DjMxFsl3jq8VPzbHyFBLGS9FgXrpDxaBPSAdfRT5qdurz6e7JVIOlSVcMC5Psshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzsfo4Kp29o8W3UyCAIT8nrkW32QdXVL+RqVZmXD3w8=;
 b=dLstU4uBJHhoe48UueAjaD+qzooudIurwBEz3dAmqZNCeNtATThAKWUP2Suq1ZS567VJCg2V1e6ibzSNWlJVD2leWGFZrH2bpkfmwB+HQ7JK1ttH+CAiRVfl36FFvHDCg6UYDBc3N9SmYntg+ZxiCRwBTIul16aZe3jdqYqEHx4R0neKsviL20NSlelHdOqNbixqQqHMsUluyOmySTEfOL3ewVsxe8z36jaHDAoqZ3hz+a5CuTfNgNOyELRubhlF34KDxTTahPHO+ABYPoLZuMQSa46nlpn0qkUnEXdtGBUJODnv1x4FCVHBxd9WGk40J25gFhSzxhpZ0UUS0c0qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzsfo4Kp29o8W3UyCAIT8nrkW32QdXVL+RqVZmXD3w8=;
 b=Gq+wmNYYG4ROGW2BOLDZUqH8Ao5vSe9gI00TZ9DWoU06qKj0QudK+DR8cc2DpilCwAZORnjXMV3wglCiGRVBLVenHYi109ZgD2TVGIbzkkqUXcRTQC0thHF4HpFfeRxvqcBi8H37feI/h2lLx4x4EZ2bnL1j8Gfuz0DpbZty6a0=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5287.namprd03.prod.outlook.com (20.180.4.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Mon, 16 Dec 2019 07:49:17 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 07:49:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: gyro: adi16136: construct adis data on probe vs
 static on driver
Thread-Topic: [PATCH 1/5] iio: gyro: adi16136: construct adis data on probe vs
 static on driver
Thread-Index: AQHVsc7h25ehVrdn/kuWYrak1+eUv6e7YwqAgAED+oA=
Date:   Mon, 16 Dec 2019 07:49:17 +0000
Message-ID: <2a5ffffea57ec97d7dde766fb88a8297c5f2d448.camel@analog.com>
References: <20191213160312.1834-1-alexandru.ardelean@analog.com>
         <20191215161847.21c67f00@archlinux>
In-Reply-To: <20191215161847.21c67f00@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 876ce295-a451-4a23-a46b-08d781fc742c
x-ms-traffictypediagnostic: CH2PR03MB5287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5287F7E7B645372785F91007F9510@CH2PR03MB5287.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(2616005)(6512007)(66946007)(66476007)(66556008)(2906002)(54906003)(64756008)(66446008)(6486002)(4326008)(71200400001)(186003)(4001150100001)(76116006)(8936002)(6506007)(5660300002)(26005)(6916009)(81156014)(81166006)(86362001)(478600001)(36756003)(8676002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5287;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1Na3uRPFD+HKriqfRFGbb4n35ewMP1tHPX7T8m/i8Iazl3FrmVd4E0Un3H/G8P0cV/sukajH9Jwyv/JRuTZajDLVtDY7IMVOQkWmKQylxnRmTJDS6i2jSE4osYoQFLSLgURaSYgBFy7IjTLSJd2OdVgkqTouozc6TLXVoSiMtKoc4yQHFgMK/c49gu06/nBaYHLcMHQGUr640aCXjORz0IU++fRslEXEDWaa/srQDY8xUsJsOg9SJEKvWSaik/KIXIJLMJerGf2evz/KmY18ktCvzS8+Tjy/+z+UpKkDxDc7kN35T82wdZApXJE5KRuFA1Ix3uhE9Mvgm+tkZNrRUipdzmiCfLPOtBjrKVpYvmO98QgJvbC5KYqn3uhIkslznkdRdze7xlPQCu7FtyFJMKqmvJmq2Ek66cjbuTEhDH9rIcV4SCeORGW45u+Z7Hd
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F62C4079A05EB4BB4351711FF99BC2F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876ce295-a451-4a23-a46b-08d781fc742c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 07:49:17.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVS4yv2LA76BMdLGIRUTti91vpDaZ8jYKjiwjLSYGHW9WnJxDEk/UYWvuQmtuzEjhoUfN6NYjQMD5VWemx4jOCGPtfsHP+mk58Wz+8SFbBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEyLTE1IGF0IDE2OjE4ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDEzIERlYyAyMDE5IDE4OjAzOjA4ICswMjAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGlzIGNoYW5nZSBpcyBkb25lIGluIHByZXBhcmF0aW9uIG9mIGFkZGlu
ZyBhbiBgc3RydWN0IGFkaXNfdGltZW91dGANCj4gPiB0eXBlLg0KPiA+IFNvbWUgQURJUyBkcml2
ZXJzIHN1cHBvcnQgbXVsdGlwbGUgZHJpdmVycywgd2l0aCB2YXJpb3VzIGNvbWJpbmF0aW9ucw0K
PiA+IG9mDQo+ID4gdGltZW91dHMuIENyZWF0aW5nIHN0YXRpYyB0YWJsZXMgZm9yIGVhY2ggZHJp
dmVyIGlzIHBvc3NpYmxlLCBidXQgdGhhdA0KPiA+IGFsc28NCj4gPiBjcmVhdGVzIHF1aXRlIGEg
bG90IG9mIGR1cGxpY2F0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8OhIDxu
dW5vLnNhQGFuYWxvZy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFu
IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gDQo+IFRoZXJlIGFyZSBjb25zaWRl
cmFibGUgYWR2YW50YWdlcyB0byB1c2luZyBjb25zdGFudCBzdHJ1Y3R1cmVzLA0KPiAoc2VjdXJp
dHkgLSBub3QgdGhhdCByZWxldmFudCBoZXJlIHByb2JhYmx5LCBYaVAsIGdlbmVyYWwgcmVhZGFi
aWxpdHkpDQo+IA0KPiBTbyB0byB0YWtlIGEgc2VyaWVzIGxpa2UgdGhpcyBJIHdhbnQgdG8gc2Vl
IGV2aWRlbmNlIHRoYXQgaXQgbWFrZXMNCj4gYSBzaWduaWZpY2FudCBkaWZmZXJlbmNlLiAgU28g
ZmFyIHlvdSBqdXN0IGhhdmUgY2FzZXMgd2hlcmUgd2UgZW5kIHVwDQo+IHdpdGggYSB3b3JzZSBy
ZXN1bHQuICBNb3JlIGNvZGUsIGhhcmRlciB0byByZWFkLi4uDQo+IA0KPiBIZW5jZSBpdCB3aWxs
IHRha2UgYSBsb3QgdG8gcGVyc3VhZGUgbWUgdG8gdGFrZSB0aGlzIHNlcmllcyB3aXRob3V0DQo+
IHRoZSBmb2xsb3cgdXAgcGF0Y2hlcyB3aGVyZSBJIGFzc3VtZSBzaWduaWZpY2FudCBhZHZhbnRh
Z2VzIGFyZSBzZWVuLg0KPiANCg0KV2VsbCwgd2UndmUgaGF2ZSBzb21lIGRpc2N1c3Npb24gYWJv
dXQgdGhpcywgYW5kIGhvdyB0byBkbyBpdC4NClRoZXJlIGFyZSBzZXZlcmFsIGFsdGVybmF0aXZl
cy4NCg0KU29tZSBvZiB0aGUgaWRlYXMgd2VyZToNCjEuIEtlZXAgdGhlIHN0YXRpYyBkYXRhIGFu
ZCBjbG9uZSBpdCArIHBvcHVsYXRlIHRoZSBhZGlzX3RpbWVvdXQgZGF0YSBhcw0KbmVlZGVkIGR1
cmluZyBwcm9iZSBbYmFzZWQgb24gZWFjaCBkZXZpY2UncyBjaGlwLWluZm9dDQoyLiBSZXdvcmsg
YWxsIHRoZSBjaGlwLWluZm8gZGF0YSB0byBpbmNsdWRlIHRoZSBhZGlzX2RhdGEgdHlwZXMvaW5m
bw0KDQoyLiBtYXkgcmVxdWlyZSBtb3JlIHdvcmsgOyAxLiByZXF1aXJlIGZld2VyIHBhdGNoZXMN
Cg0KVGhpcyBpbXBsZW1lbnRhdGlvbiBbaW4gdGhpcyBzZXJpZXNdIGlzIDEuIGJ1dCB3aXRob3V0
IGtlZXBpbmcgdGhlIHN0YXRpYw0KZGF0YSBhbmQgdGVtcGxhdGUuDQpJIGd1ZXNzIHRoZSBpZGVh
IHdhcyB0byByZWR1Y2UgbWVtb3J5IHVzYWdlIFtieSBrZWVwaW5nIHRoZSBzdGF0aWMgZGF0YV0u
IEkNCmFkbWl0IHRoZSBtZW1vcnkgdXNhZ2UgaXMgbm90IHRoYXQgYmlnLg0KDQpJJ2xsIHRha2Ug
YSBsb29rIGF0IHRoaXMgYWdhaW4sIGFuZCBzZWUgaWYgMi4gY2FuIHdvcmsgbW9yZSBuaWNlbHku
DQpJdCBtaWdodCBiZSB0aGF0IDEuIHdvdWxkIGJlIHRoZSBlbmQtcmVzdWx0LCBidXQgd2hvIGtu
b3dzPw0KDQpUaGFua3MNCkFsZXgNCg0KDQo+IEpvbmF0aGFuDQo+IA0KPiANCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9paW8vZ3lyby9hZGlzMTYxMzYuYyB8IDQ5ICsrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwg
MTkgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2d5cm8v
YWRpczE2MTM2LmMNCj4gPiBiL2RyaXZlcnMvaWlvL2d5cm8vYWRpczE2MTM2LmMNCj4gPiBpbmRl
eCBmMTBjNGYxNzM4OTguLjEyOWRlMmJkNTg0NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lp
by9neXJvL2FkaXMxNjEzNi5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vZ3lyby9hZGlzMTYxMzYu
Yw0KPiA+IEBAIC00NjUsMjQgKzQ2NSw2IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QNCj4g
PiBhZGlzMTYxMzZfc3RhdHVzX2Vycm9yX21zZ3NbXSA9IHsNCj4gPiAgCVtBRElTMTYxMzZfRElB
R19TVEFUX0ZMQVNIX0NIS1NVTV9GQUlMXSA9ICJGbGFzaCBjaGVja3N1bSBlcnJvciIsDQo+ID4g
IH07DQo+ID4gIA0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGFkaXNfZGF0YSBhZGlzMTYxMzZf
ZGF0YSA9IHsNCj4gPiAtCS5kaWFnX3N0YXRfcmVnID0gQURJUzE2MTM2X1JFR19ESUFHX1NUQVQs
DQo+ID4gLQkuZ2xvYl9jbWRfcmVnID0gQURJUzE2MTM2X1JFR19HTE9CX0NNRCwNCj4gPiAtCS5t
c2NfY3RybF9yZWcgPSBBRElTMTYxMzZfUkVHX01TQ19DVFJMLA0KPiA+IC0NCj4gPiAtCS5zZWxm
X3Rlc3RfbWFzayA9IEFESVMxNjEzNl9NU0NfQ1RSTF9TRUxGX1RFU1QsDQo+ID4gLQkuc3RhcnR1
cF9kZWxheSA9IDgwLA0KPiA+IC0NCj4gPiAtCS5yZWFkX2RlbGF5ID0gMTAsDQo+ID4gLQkud3Jp
dGVfZGVsYXkgPSAxMCwNCj4gPiAtDQo+ID4gLQkuc3RhdHVzX2Vycm9yX21zZ3MgPSBhZGlzMTYx
MzZfc3RhdHVzX2Vycm9yX21zZ3MsDQo+ID4gLQkuc3RhdHVzX2Vycm9yX21hc2sgPSBCSVQoQURJ
UzE2MTM2X0RJQUdfU1RBVF9GTEFTSF9VUERBVEVfRkFJTCkgfA0KPiA+IC0JCUJJVChBRElTMTYx
MzZfRElBR19TVEFUX1NQSV9GQUlMKSB8DQo+ID4gLQkJQklUKEFESVMxNjEzNl9ESUFHX1NUQVRf
U0VMRl9URVNUX0ZBSUwpIHwNCj4gPiAtCQlCSVQoQURJUzE2MTM2X0RJQUdfU1RBVF9GTEFTSF9D
SEtTVU1fRkFJTCksDQo+ID4gLX07DQo+ID4gLQ0KPiA+ICBlbnVtIGFkaXMxNjEzNl9pZCB7DQo+
ID4gIAlJRF9BRElTMTYxMzMsDQo+ID4gIAlJRF9BRElTMTYxMzUsDQo+ID4gQEAgLTUwOSwxMSAr
NDkxLDM2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRpczE2MTM2X2NoaXBfaW5mbw0KPiA+IGFk
aXMxNjEzNl9jaGlwX2luZm9bXSA9IHsNCj4gPiAgCX0sDQo+ID4gIH07DQo+ID4gIA0KPiA+ICtz
dGF0aWMgc3RydWN0IGFkaXNfZGF0YSAqYWRpczE2MTM2X2FkaXNfZGF0YV9hbGxvYyhzdHJ1Y3Qg
YWRpczE2MTM2DQo+ID4gKnN0LA0KPiA+ICsJCQkJCQkgICBzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ID4gK3sNCj4gPiArCXN0cnVjdCBhZGlzX2RhdGEgKmRhdGE7DQo+ID4gKw0KPiA+ICsJZGF0YSA9
IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZihzdHJ1Y3QgYWRpc19kYXRhKSwgR0ZQX0tFUk5FTCk7
DQo+ID4gKwlpZiAoIWRhdGEpDQo+ID4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ID4g
Kw0KPiA+ICsJZGF0YS0+bXNjX2N0cmxfcmVnID0gQURJUzE2MTM2X1JFR19NU0NfQ1RSTDsNCj4g
PiArCWRhdGEtPmdsb2JfY21kX3JlZyA9IEFESVMxNjEzNl9SRUdfR0xPQl9DTUQ7DQo+ID4gKwlk
YXRhLT5kaWFnX3N0YXRfcmVnID0gQURJUzE2MTM2X1JFR19ESUFHX1NUQVQ7DQo+ID4gKwlkYXRh
LT5zZWxmX3Rlc3RfbWFzayA9IEFESVMxNjEzNl9NU0NfQ1RSTF9TRUxGX1RFU1Q7DQo+ID4gKwlk
YXRhLT5yZWFkX2RlbGF5ID0gMTA7DQo+ID4gKwlkYXRhLT53cml0ZV9kZWxheSA9IDEwOw0KPiA+
ICsJZGF0YS0+c3RhdHVzX2Vycm9yX21zZ3MgPSBhZGlzMTYxMzZfc3RhdHVzX2Vycm9yX21zZ3M7
DQo+ID4gKwlkYXRhLT5zdGF0dXNfZXJyb3JfbWFzayA9DQo+ID4gQklUKEFESVMxNjEzNl9ESUFH
X1NUQVRfRkxBU0hfVVBEQVRFX0ZBSUwpIHwNCj4gPiArCQkJCUJJVChBRElTMTYxMzZfRElBR19T
VEFUX1NQSV9GQUlMKSB8DQo+ID4gKwkJCQlCSVQoQURJUzE2MTM2X0RJQUdfU1RBVF9TRUxGX1RF
U1RfRkFJTCkgfA0KPiA+ICsJCQkJQklUKEFESVMxNjEzNl9ESUFHX1NUQVRfRkxBU0hfQ0hLU1VN
X0ZBSUwpOw0KPiA+ICsNCj4gPiArCXJldHVybiBkYXRhOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBz
dGF0aWMgaW50IGFkaXMxNjEzNl9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiA+ICB7
DQo+ID4gIAljb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCAqaWQgPSBzcGlfZ2V0X2RldmljZV9p
ZChzcGkpOw0KPiA+ICAJc3RydWN0IGFkaXMxNjEzNiAqYWRpczE2MTM2Ow0KPiA+ICAJc3RydWN0
IGlpb19kZXYgKmluZGlvX2RldjsNCj4gPiArCWNvbnN0IHN0cnVjdCBhZGlzX2RhdGEgKmFkaXMx
NjEzNl9kYXRhOw0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gIAlpbmRpb19kZXYgPSBkZXZt
X2lpb19kZXZpY2VfYWxsb2MoJnNwaS0+ZGV2LCBzaXplb2YoKmFkaXMxNjEzNikpOw0KPiA+IEBA
IC01MzIsNyArNTM5LDExIEBAIHN0YXRpYyBpbnQgYWRpczE2MTM2X3Byb2JlKHN0cnVjdCBzcGlf
ZGV2aWNlICpzcGkpDQo+ID4gIAlpbmRpb19kZXYtPmluZm8gPSAmYWRpczE2MTM2X2luZm87DQo+
ID4gIAlpbmRpb19kZXYtPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7DQo+ID4gIA0KPiA+IC0J
cmV0ID0gYWRpc19pbml0KCZhZGlzMTYxMzYtPmFkaXMsIGluZGlvX2Rldiwgc3BpLCAmYWRpczE2
MTM2X2RhdGEpOw0KPiA+ICsJYWRpczE2MTM2X2RhdGEgPSBhZGlzMTYxMzZfYWRpc19kYXRhX2Fs
bG9jKGFkaXMxNjEzNiwgJnNwaS0+ZGV2KTsNCj4gPiArCWlmIChJU19FUlIoYWRpczE2MTM2X2Rh
dGEpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKGFkaXMxNjEzNl9kYXRhKTsNCj4gPiArDQo+ID4g
KwlyZXQgPSBhZGlzX2luaXQoJmFkaXMxNjEzNi0+YWRpcywgaW5kaW9fZGV2LCBzcGksIGFkaXMx
NjEzNl9kYXRhKTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo=
