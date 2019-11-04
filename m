Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85DEEE320
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfKDPIV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:08:21 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:47342 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbfKDPIU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:08:20 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4F4obL017240;
        Mon, 4 Nov 2019 10:08:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75hsgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:08:14 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4F8EjA020256;
        Mon, 4 Nov 2019 10:08:14 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75hsgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:08:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBbC6Acm3pRAxRjlgA0/UaifAsdtWv8gcQRbtc4/3TICddNd1g1kffQPwjWITZC7dzDlNSSlnKqOTPvxECR/VOlCN+B4Tw76j2cHUgrwJut/x+xx3n9W9rx6JIxNszeW7XPSLwSrleBRh/p9f6DPrqds2qHLTuxyJJKZFanfkcmSSFCK6Ph9D9R2hbSw4vN0dBCjVjHk3vjv8v1kRH+gW684j5VNRK4Ngvox+3QwLS+y+0SSDUSK8Qcrc/XhzdJl1Y1GwXUkwhOSpN24gceBE17oJc/RXMXGmVLf19tSy6wjnPVwTfsdSaOFLZx60rZQuc0K2esJwozx2FSmxefXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPtDiFMJdV1u1VBSx+9Fue8DgwSeZ40vJdalgJozlck=;
 b=S4E7U9wHht2mugChz5HOwIoUpyOhyd/eKwfowZkPW2WfClTOfaa4L5Oz4660//2IZOQkZSmkXjOJDB7Mv4rdPBHAfq01XCiNvko4SK+u5HTH3z00Mv897LGGT0r47mHh7Za6ZP4z1+M8VC3UhYrQP3q7VkzWHvSwlYW1HMoU78Skyc9flnJFK9Zf16uWZAFn6bkzvIohmp3IIwawCTJb6b3zqniXgc8RemPl2wgrv1kJM335TIqabpotqjrPGEOFebi7/SeL2F3WaQ3wz2wS8s0oRAvknak2MpTDMfCre4GrVDV0ljlk38QIge8imNB9p56i+N1CV8ziEMMZri/xFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPtDiFMJdV1u1VBSx+9Fue8DgwSeZ40vJdalgJozlck=;
 b=LmKL+M2Xw1lZ45Lpxzees26N/d0+5wmrDd53XiF4TsbBJFPFqYPBSZ4eu9lpMB26HbeKJVEaTXsruz5CyFj+vDOiC6pWEMBA7aiCTxTstCbgjhRdtNGVmcWCdkxvikJ7tMVNgMAE7tIgwJuCYBs2V+WrWAm6P5ysPzd56hTXbtA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5320.namprd03.prod.outlook.com (20.180.15.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:08:12 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:08:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "martenli@axis.com" <martenli@axis.com>
Subject: Re: [PATCH] iio:adc:ti-adc084s021: Endian casting tidy ups.
Thread-Topic: [PATCH] iio:adc:ti-adc084s021: Endian casting tidy ups.
Thread-Index: AQHVgauIp82dYghfEUO4ZtRv/khJ2qd7QAGA
Date:   Mon, 4 Nov 2019 15:08:12 +0000
Message-ID: <a07e927d00802115b17a5b01a3b0db245e776d7e.camel@analog.com>
References: <20191013094722.1429243-1-jic23@kernel.org>
In-Reply-To: <20191013094722.1429243-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcdca35f-f4fd-48ad-d5dc-08d76138cf8a
x-ms-traffictypediagnostic: CH2PR03MB5320:
x-microsoft-antispam-prvs: <CH2PR03MB53203A6405FC8F3BB962F1B3F97F0@CH2PR03MB5320.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(486006)(6246003)(110136005)(54906003)(99286004)(2616005)(478600001)(14454004)(36756003)(118296001)(76176011)(4001150100001)(86362001)(6506007)(26005)(102836004)(186003)(316002)(66574012)(5660300002)(14444005)(71190400001)(476003)(256004)(229853002)(6486002)(76116006)(2906002)(71200400001)(7736002)(6436002)(25786009)(11346002)(66946007)(66066001)(6512007)(6116002)(81166006)(3846002)(305945005)(2501003)(4326008)(446003)(8936002)(64756008)(66446008)(66556008)(81156014)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5320;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3VqMam6VOZ2k9RH455A8e+s09UHEjOJhedrWKh9zw7KpRCQneZyZCT7hKgUcsWjfYHKSXTWNqZOsp58BJkgyJhoBskoazR4nSRZ8OshMoYFsgPsTve6HiSpDAt3OOGeQAVmvv8W6qRv/BnYf3HC5YoNSGqn6ZBKkXL5jWmqA1w4uIi6MdGogRGVwevyL78C22rp/GXkVkPCTDW+77U/ErPkrQr2MZoauKyIngSG4FBwJ+MyXl2esdJlOSEuSXjNqn+UEYJDrysShItIzfZcFpPa3E1W+5b4DlxGxuWK31WR6RIfN3AK3ZsX9LAafE623xGjOEYo5FHH1glYNAYVxBJcCDLsSRzsFFIsyR9DT0q5ru2mCA6fA9TQkyxuLuGVPYFL4Vzcr4n8ZBYjqA0FSUS8L5Ur1/RFleV8ZKnOMdcnox7K1rmVgoW9lLZf6hQG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EA738C9178FDD48A639574363BFF8B3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdca35f-f4fd-48ad-d5dc-08d76138cf8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:08:12.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGbjBd/FMkrnvLpAzB4RQZKGAhc4QWccXj03bF4aN8xn6notDwirY3l5e4/dPiG1+NFQiFAuUow+nf/0yKX5gB3FsuFEzD80N1t0bpXc1SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5320
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040150
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDEwOjQ3ICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBIaWdobGlnaHRlZCBieSBzcGFyc2U6DQo+IENIRUNLICAgZHJpdmVycy9paW8vYWRj
L3RpLWFkYzA4NHMwMjEuYw0KPiBkcml2ZXJzL2lpby9hZGMvdGktYWRjMDg0czAyMS5jOjc5OjI2
OiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbg0KPiBhc3NpZ25tZW50IChkaWZmZXJlbnQgYmFz
ZSB0eXBlcykNCj4gZHJpdmVycy9paW8vYWRjL3RpLWFkYzA4NHMwMjEuYzo3OToyNjogICAgZXhw
ZWN0ZWQgdW5zaWduZWQgc2hvcnQNCj4gW3Vuc2lnbmVkXSBbc2hvcnRdIFt1c2VydHlwZV0gPG5v
aWRlbnQ+DQo+IGRyaXZlcnMvaWlvL2FkYy90aS1hZGMwODRzMDIxLmM6Nzk6MjY6ICAgIGdvdCBy
ZXN0cmljdGVkIF9fYmUxNiA8bm9pZGVudD4NCj4gZHJpdmVycy9paW8vYWRjL3RpLWFkYzA4NHMw
MjEuYzoxMTA6MjQ6IHdhcm5pbmc6IGNhc3QgdG8gcmVzdHJpY3RlZA0KPiBfX2JlMTYNCj4gZHJp
dmVycy9paW8vYWRjL3RpLWFkYzA4NHMwMjEuYzoxMTA6MjQ6IHdhcm5pbmc6IGNhc3QgdG8gcmVz
dHJpY3RlZA0KPiBfX2JlMTYNCj4gZHJpdmVycy9paW8vYWRjL3RpLWFkYzA4NHMwMjEuYzoxMTA6
MjQ6IHdhcm5pbmc6IGNhc3QgdG8gcmVzdHJpY3RlZA0KPiBfX2JlMTYNCj4gZHJpdmVycy9paW8v
YWRjL3RpLWFkYzA4NHMwMjEuYzoxMTA6MjQ6IHdhcm5pbmc6IGNhc3QgdG8gcmVzdHJpY3RlZA0K
PiBfX2JlMTYNCj4gDQoNClRoaXMgb25lIGxvb2tzIGEgYml0IHRyaWNreS4NCkFuZCBsb29rcyBs
aWtlIGl0IGNvdWxkIHVzZSBhIGJpdCBtb3JlIGNsZWFudXAgdGhhbiB0aGlzLg0KT3RoZXJ3aXNl
IHNwYXJzZSBtYXkgY29tZSBhbG9uZyBhbmQgY29tcGxhaW4gYWJvdXQgbW9yZSBzdHVmZi4NCg0K
T25lIHRoaW5nIHRoYXQgd291bGQgYmUgZ29vZCwgd291bGQgYmUgdG8gY2hhbmdlOg0KDQppbnQg
YWRjMDg0czAyMV9hZGNfY29udmVyc2lvbihzdHJ1Y3QgYWRjMDg0czAyMSAqYWRjLCB2b2lkICpk
YXRhKQ0KDQp0bw0KDQppbnQgYWRjMDg0czAyMV9hZGNfY29udmVyc2lvbihzdHJ1Y3QgYWRjMDg0
czAyMSAqYWRjLCBfX2JlMTYgKmRhdGEsIGludA0KYnVmX3NpemUpICAgWzFdDQoNCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IENjOiBNw6VydGVuIExpbmRhaGwgPG1hcnRlbmxpQGF4aXMuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvaWlvL2FkYy90aS1hZGMwODRzMDIxLmMgfCA3ICsrKystLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vYWRjL3RpLWFkYzA4NHMwMjEuYyBiL2RyaXZlcnMvaWlvL2FkYy90aS0NCj4g
YWRjMDg0czAyMS5jDQo+IGluZGV4IGJkZWRmNDU2ZWUwNS4uNDI5NjZmMmViM2Q4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvdGktYWRjMDg0czAyMS5jDQo+ICsrKyBiL2RyaXZlcnMv
aWlvL2FkYy90aS1hZGMwODRzMDIxLmMNCj4gQEAgLTY4LDcgKzY4LDcgQEAgc3RhdGljIGludCBh
ZGMwODRzMDIxX2FkY19jb252ZXJzaW9uKHN0cnVjdCBhZGMwODRzMDIxDQo+ICphZGMsIHZvaWQg
KmRhdGEpDQo+ICB7DQo+ICAJaW50IG5fd29yZHMgPSAoYWRjLT5zcGlfdHJhbnMubGVuID4+IDEp
IC0gMTsgLyogRGlzY2FyZCBmaXJzdCB3b3JkDQo+ICovDQo+ICAJaW50IHJldCwgaSA9IDA7DQo+
IC0JdTE2ICpwID0gZGF0YTsNCj4gKwlfX2JlMTYgKnAgPSBkYXRhOw0KPiAgDQo+ICAJLyogRG8g
dGhlIHRyYW5zZmVyICovDQo+ICAJcmV0ID0gc3BpX3N5bmMoYWRjLT5zcGksICZhZGMtPm1lc3Nh
Z2UpOw0KPiBAQCAtODcsNiArODcsNyBAQCBzdGF0aWMgaW50IGFkYzA4NHMwMjFfcmVhZF9yYXco
c3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gIHsNCj4gIAlzdHJ1Y3QgYWRjMDg0czAy
MSAqYWRjID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gIAlpbnQgcmV0Ow0KPiArCV9fYmUxNiB2
YWx1ZTsNCj4gIA0KPiAgCXN3aXRjaCAobWFzaykgew0KPiAgCWNhc2UgSUlPX0NIQU5fSU5GT19S
QVc6DQo+IEBAIC0xMDEsMTMgKzEwMiwxMyBAQCBzdGF0aWMgaW50IGFkYzA4NHMwMjFfcmVhZF9y
YXcoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gIAkJfQ0KPiAgDQo+ICAJCWFkYy0+
dHhfYnVmWzBdID0gY2hhbm5lbC0+Y2hhbm5lbCA8PCAzOw0KPiAtCQlyZXQgPSBhZGMwODRzMDIx
X2FkY19jb252ZXJzaW9uKGFkYywgdmFsKTsNCj4gKwkJcmV0ID0gYWRjMDg0czAyMV9hZGNfY29u
dmVyc2lvbihhZGMsICZ2YWx1ZSk7DQoNCkZvbGxvd2luZyBbMV0sIHRoaXMgY291bGQgYmUgY2Fs
bGVkIHdpdGggICJhZGMwODRzMDIxX2FkY19jb252ZXJzaW9uKGFkYywNCiZ2YWx1ZSwgMSkiIHRv
IG1ha2Ugc3VyZSBpdCdzIG5vdCBkb2luZyBhbnkgc3RhY2sgY29ycnVwdGlvbi4gSSBjYW4ndCB0
ZWxsDQppZiB0aGlzIGlzIGRvaW5nIGFueSBvciBub3Q7IHRoZSBjb2RlIGlzIGEgYml0IGZ1enp5
IHRvIG1lLg0KDQpUaGUgbmVhdCBwYXJ0IGlzIHRoYXQgbWVtY3B5KCkgY291bGQgYmUgdXNlZCB0
byB0aGVuIGFjY2VzcyB0aGUgZGF0YSBvbg0KcnhfYnVmLg0KDQoNCj4gIAkJaWlvX2RldmljZV9y
ZWxlYXNlX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+ICAJCXJlZ3VsYXRvcl9kaXNhYmxlKGFk
Yy0+cmVnKTsNCj4gIAkJaWYgKHJldCA8IDApDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0J
CSp2YWwgPSBiZTE2X3RvX2NwdSgqdmFsKTsNCj4gKwkJKnZhbCA9IGJlMTZfdG9fY3B1KHZhbHVl
KTsNCj4gIAkJKnZhbCA9ICgqdmFsID4+IGNoYW5uZWwtPnNjYW5fdHlwZS5zaGlmdCkgJiAweGZm
Ow0KPiAgDQo+ICAJCXJldHVybiBJSU9fVkFMX0lOVDsNCg==
