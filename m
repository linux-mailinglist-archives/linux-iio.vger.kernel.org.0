Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E681939B4
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 08:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZHnI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 03:43:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52056 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgCZHnI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 03:43:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q7g8TA032002;
        Thu, 26 Mar 2020 03:42:51 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywfu5ft3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 03:42:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EezwxOgOcVPD5n4yBAysxiydk88ZIGKLJU6m+4yN0xrfd7PT0RZw1db5/IMhbWYVxScUOTh3Oul/nYw8jLM7NvtetAqNWQBkXTV8d43SSDubQ0DCk3q/rbKsJ8Ru/7hE+Vo7+zZcwBnylGtdBL7eOHWX3KpG/D7sTpxJ+QaLLzLy5xu7a4kxCvXb2Xckra7W4hqGQHAUCbqvhXYfnGldI2GR7sr1gvLxRbf+et7bj3cYakpvjCTDdJj9+Wn21jj+1NBaQyTWbUnCsoa2SYgw6CzpeaNQE2R6iQY3Y4leHbs9XmMskexA0+t6R16okWGrXzc8MV4IvUzpYS/Ee61Q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cu7DFUgEnGuvVQLgD/gJu9lAoeZGi5bECqoqbHbZlw=;
 b=DPhvK4UQHEhKD91Ak6KhsG3yUW+veVpyYmovV+kCyJRKmVKhCfwbJVodY5+ZSgIB3HYHscxRmxxXDkgz8zEGN/8bTfI4NUFQi01Id2QFBN7lcyXWzmvXty3F+ao4oBp/NYLOvsrTQ40szMrNIMm/QFYDnZNLGsnyc8Wyvtpda/VR30AGzAe387y/xTeIbpRH99NF3fNlx+4fDWmuErU6uuukSiACFSP2C6sUAEbO20cHQDHKpAAZ65ytZNv/re+EwlTBmqmiifcC/m25F4VFqAPsdskopFwVP8IIg37CLDBXnghg/P3NZW2ShbLFttfPziemI/Hv+rR0Gsi0v3hv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cu7DFUgEnGuvVQLgD/gJu9lAoeZGi5bECqoqbHbZlw=;
 b=krIj11wnzT0uqXo8L0VGKkqYa4UW26r37ruX7l3m10BD8YxUdw3UNjy57d7xKGkUh/sPHZJDlEH1iKsCP2qH6HzUKlnsaLLLh5xgcpVI02330eBVjRTpvvQxf6m/KnqMItKL5fy6sksw5tFL0lxpd1aoaGMZ1mIYSTTKZM0dVE4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5274.namprd03.prod.outlook.com (2603:10b6:5:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 07:42:48 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 07:42:48 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "pmeerw@pmeerw.ne" <pmeerw@pmeerw.ne>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
Thread-Topic: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
Thread-Index: AQHWAoxiXsh0om2yLEiNKsKsJIqrVahZdywAgAEI/oA=
Date:   Thu, 26 Mar 2020 07:42:48 +0000
Message-ID: <62b90724f16fa3a2c54b7e7f2321587a328d7209.camel@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
         <20200325100112.85107-1-alexandru.ardelean@analog.com>
         <CAHp75VfVggWZ6WhOa=nUrxyd0dJrTbZd9NnUMhQ_S=kncrAhOw@mail.gmail.com>
In-Reply-To: <CAHp75VfVggWZ6WhOa=nUrxyd0dJrTbZd9NnUMhQ_S=kncrAhOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a61af63b-fd73-4e66-b220-08d7d15947ec
x-ms-traffictypediagnostic: DM6PR03MB5274:
x-microsoft-antispam-prvs: <DM6PR03MB5274E7A5DBBD183D1BF0F65DF9CF0@DM6PR03MB5274.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(366004)(346002)(6506007)(5660300002)(6916009)(8676002)(4326008)(6486002)(76116006)(186003)(66946007)(64756008)(316002)(66446008)(81156014)(81166006)(91956017)(66556008)(478600001)(36756003)(6512007)(66476007)(8936002)(86362001)(54906003)(71200400001)(2616005)(26005)(2906002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5274;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NRRoSIcRXqcUrlqXhgwjQ0sV5WNPeoXiOb/rxBI27BoiNt4OvzW9fE37eIaA/Qztg/SsuV2SHgzglAvPymTPYRY5cMS/aaeYRXiSPD03l6dfL6JHPzhAk1ue4i6pv71MzjCilLEkkybj0BlKT4eVZsmmjOHbHLu0imDI94gtJXNhAmtzBWTY+RiSzoOsvZafvl29hAOydFeLVRGuaWbhchAfiZ195DOyf87xHEOlobiNJF+LObU56z/JvM18NgYsySnHN5UTwQ9MIodpVMMsXNn4TEDidQEFQPDb2S2WZtru+EeaBaNQ9L/cEzCV5L8YC3xBxphQu6vW3YVkoAwDB4wBypfl9pkkKLmI+mS7CWsBkzOm9/j+WTZgocfD6LAYNFL9X5OmIt444Juw2Y+eklkYDDjIaZwLnVYFKupFcdZtIDOQuBV95A+EcTDObAEa
x-ms-exchange-antispam-messagedata: BhHTRTJL81rC7yciM2SoOFnL5mMRxkrolK0Lywl6yRh84Unp1IOfJ9uiB3+rx+lLk+RrdONI8rENpwyopA1ID2cgi/aMcCbySE7j2Atjcm3vHCmRR4dKvi3AzqpXh2Jf5h9TM0LIaz5/O7YBRkDdPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4EF3F8EC25E90489E89FAEEC2F00409@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61af63b-fd73-4e66-b220-08d7d15947ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 07:42:48.4753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbFuI5jtPRznoCg5P+WHzQOUOMYidOHj/3s4Pr5nAY94LSVCpqzUXbhS68XYY6/U5hk6shc7+EHgKVlC3Sp4xY+QnubTPK1QpfV9io4ZyVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003260054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDE3OjU3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFdlZCwgTWFyIDI1LCAyMDIwIGF0IDEyOjAyIFBNIEFs
ZXhhbmRydSBBcmRlbGVhbg0KPiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3Rl
Og0KPiA+IEZyb206IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+IA0K
PiA+IEJlZm9yZSBhY3RpdmF0aW5nIGEgYnVmZmVyIG1ha2Ugc3VyZSB0aGF0IGF0IGxlYXN0IG9u
ZSBjaGFubmVsIGlzIGVuYWJsZWQuDQo+ID4gQWN0aXZhdGluZyBhIGJ1ZmZlciB3aXRoIDAgY2hh
bm5lbHMgZW5hYmxlZCBkb2Vzbid0IG1ha2UgdG9vIG11Y2ggc2Vuc2UgYW5kDQo+ID4gZGlzYWxs
b3dpbmcgdGhpcyBjYXNlIG1ha2VzIHN1cmUgdGhhdCBpbmRpdmlkdWFsIGRyaXZlciBkb24ndCBo
YXZlIHRvIGFkZA0KPiA+IHNwZWNpYWwgY2FzZSBjb2RlIHRvIGhhbmRsZSBpdC4NCj4gPiANCj4g
PiBDdXJyZW50bHksIHdpdGhvdXQgdGhpcyBwYXRjaCBlbmFibGluZyBhIGJ1ZmZlciBpcyBwb3Nz
aWJsZSBhbmQgbm8gZXJyb3IgaXMNCj4gPiBwcm9kdWNlZC4gV2l0aCB0aGlzIHBhdGNoIC1FSU5W
QUwgaXMgcmV0dXJuZWQuDQo+ID4gDQo+ID4gQW4gZXhhbXBsZSBvZiBleGVjdXRpb24gd2l0aCB0
aGlzIHBhdGNoIGFuZCBzb21lIGluc3RydW1lbnRlZCBwcmludC1jb2RlOg0KPiA+ICAgIHJvb3RA
YW5hbG9nOn4jIGNkIC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpb1w6ZGV2aWNlMy9idWZmZXINCj4g
PiAgICByb290QGFuYWxvZzovc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlMy9idWZmZXIj
IGVjaG8gMSA+IGVuYWJsZQ0KPiA+ICAgIDA6IGlpb192ZXJpZnlfdXBkYXRlIDc0OCBpbmRpb19k
ZXYtPm1hc2tsZW5ndGggMiAqaW5zZXJ0X2J1ZmZlci0NCj4gPiA+c2Nhbl9tYXNrIDAwMDAwMDAw
DQo+ID4gICAgMTogaWlvX3ZlcmlmeV91cGRhdGUgNzUzDQo+ID4gICAgMjpfX2lpb191cGRhdGVf
YnVmZmVycyAxMTE1IHJldCAtMjINCj4gPiAgICAzOiBpaW9fYnVmZmVyX3N0b3JlX2VuYWJsZSAx
MjQxIHJldCAtMjINCj4gPiAgICAtYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJn
dW1lbnQNCj4gPiAxLCAyICYgMyBhcmUgZXhpdC1lcnJvciBwYXRocy4gMCB0aGUgZmlyc3QgcHJp
bnQgaW4gaWlvX3ZlcmlmeV91cGRhdGUoKQ0KPiA+IHJlcmdhcmRsZXNzIG9mIGVycm9yIHBhdGgu
DQo+ID4gDQo+ID4gV2l0aG91dCB0aGlzIHBhdGNoIChhbmQgc2FtZSBpbnN0cnVtZW50ZWQgcHJp
bnQtY29kZSk6DQo+ID4gICAgcm9vdEBhbmFsb2c6fiMgY2QgL3N5cy9idXMvaWlvL2RldmljZXMv
aWlvXDpkZXZpY2UzL2J1ZmZlcg0KPiA+ICAgIHJvb3RAYW5hbG9nOi9zeXMvYnVzL2lpby9kZXZp
Y2VzL2lpbzpkZXZpY2UzL2J1ZmZlciMgZWNobyAxID4gZW5hYmxlDQo+ID4gICAgMDogaWlvX3Zl
cmlmeV91cGRhdGUgNzQ4IGluZGlvX2Rldi0+bWFza2xlbmd0aCAyICppbnNlcnRfYnVmZmVyLQ0K
PiA+ID5zY2FuX21hc2sgMDAwMDAwMDANCj4gPiAgICByb290QGFuYWxvZzovc3lzL2J1cy9paW8v
ZGV2aWNlcy9paW86ZGV2aWNlMy9idWZmZXIjDQo+ID4gQnVmZmVyIGlzIGVuYWJsZWQgd2l0aCBu
byBlcnJvci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBldGVyIENsYXVzZW4gPGxh
cnNAbWV0YWZvby5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFs
ZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZWxv
ZyB2MSAtPiB2MjoNCj4gPiAqIG1vdmVkIGNoZWNrIGluIGlpb192ZXJpZnlfdXBkYXRlKCkNCj4g
PiAqIGFkZGVkIGRldl9kYmcoKSBtZXNzYWdlOyBzaG91bGQgaGVscCBzb21lIGZvbGtzIHVuZGVy
c3RhbmQgdGhlIG1lc3NhZ2UNCj4gPiAqIGRvY3VtZW50ZWQgc3RlcHMgdG8gcmVwcm9kdWNlDQo+
ID4gKiBhZGRlZCBGaXhlcyB0YWc7IGhvcGVmdWxseSB0aGUgdGFnIGlzIHRoZSBnb29kIG9uZTsg
aWYgbmVlZGVkLCBpdCBjYW4gYmUNCj4gPiAgIGRyb3BwZWQ7IHRoaXMgaGFzIGJlZW4gYXJvdW5k
IGZvciB+OCB5ZWFyczsgbm8gaWRlYSBpZiBpdCdzIHdvcnRoDQo+ID4gICBiYWNrcG9ydGluZw0K
PiANCj4gV2hlcmU/DQoNCnN0YWJsZS9maXhlcy9sdHMta2VybmVscw0KZG9uJ3QgaGF2ZSBhIHJl
YWxseSBnb29kIGNsdWUgYWJvdXQgd2hlcmUgdGhlc2UgdGhpbmdzIG5lZWQgYmFja3BvcnRpbmc7
DQoNCj4gDQo+ID4gIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYyB8IDcgKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYyBiL2RyaXZlcnMvaWlvL2lu
ZHVzdHJpYWxpby0NCj4gPiBidWZmZXIuYw0KPiA+IGluZGV4IDVmZjM0Y2U4YjZhMi4uZTZmYTFh
NGUxMzVkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYw0KPiA+IEBAIC02
ODYsNiArNjg2LDEzIEBAIHN0YXRpYyBpbnQgaWlvX3ZlcmlmeV91cGRhdGUoc3RydWN0IGlpb19k
ZXYgKmluZGlvX2RldiwNCj4gPiAgICAgICAgIGJvb2wgc2Nhbl90aW1lc3RhbXA7DQo+ID4gICAg
ICAgICB1bnNpZ25lZCBpbnQgbW9kZXM7DQo+ID4gDQo+ID4gKyAgICAgICBpZiAoaW5zZXJ0X2J1
ZmZlciAmJg0KPiA+ICsgICAgICAgICAgIGJpdG1hcF9lbXB0eShpbnNlcnRfYnVmZmVyLT5zY2Fu
X21hc2ssIGluZGlvX2Rldi0+bWFza2xlbmd0aCkpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2
X2RiZygmaW5kaW9fZGV2LT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIkF0IGxl
YXN0IG9uZSBzY2FuIGVsZW1lbnQgbXVzdCBiZSBlbmFibGVkDQo+ID4gZmlyc3RcbiIpOw0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+
ID4gICAgICAgICBtZW1zZXQoY29uZmlnLCAwLCBzaXplb2YoKmNvbmZpZykpOw0KPiA+ICAgICAg
ICAgY29uZmlnLT53YXRlcm1hcmsgPSB+MDsNCj4gPiANCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+
IA0KPiANCj4gDQo=
