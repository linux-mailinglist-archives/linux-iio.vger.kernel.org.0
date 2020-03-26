Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA51939CE
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 08:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCZHrC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 03:47:02 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16022 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgCZHrC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 03:47:02 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q7egrG002629;
        Thu, 26 Mar 2020 03:46:46 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj6xd5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 03:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF/jIwAi6G6Nsgfw6Y4SWrGb0sGwEiE4+CbUEzCMMmfB0BsxvE8cHUcuSlk7tT8s1xvaetJi1fyJHiB2i+FLgOhNgfi4XnuUyrXPtNoahbZkKAI2A20E6PsM98pkNvehHP9shWmNvPA9FpgExpMGzzeEytflz3BZFTmVQKQvfdIlz3W48VH2QKiyIKfFLmMD/6C4L9KLR7UlbFpDk6nuSSi03YwzAEJX/gqMO/yFbyhLQtktrBLtHg1urUVCMHR/LA7TDiv9NypvsVaMjo2ymY716ahmYfprmNWpscHSAdBjLB5WbOAmJDNvsGZDGqjFqVOw6EB/iilDVw6SvgFJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDw2gmIjaUlBecsvWMCmUDdUQ3z7WRooHrYrBIAKbJE=;
 b=PnUxZ2u8+ckdS2JVdY+MjjTAxk70eCNkdKlgBtOzwzsQhxsi+TOOevl+5Y5zC3mGc6makyKI7Fobf3OB8lFIl9IlZlT7HZxLU/psQYoZxvGqjMwOuaU7VAfkLI2hVkNCGj4lKy0uGlWtXIlDxzC7pDYIYXJr3Q9s5LQa+RLCiQpHJf58vE2p7Y9xsX2aEoQDDu1upPQSj5T9fR5ruWB4BRWthtgzpeFBAm+DevFiWUTKpn1Rc+fGxJ97zqUsbhlsbEUSR1mYVYaQvJwvonOZcFIkdYhQY2fvGtFbg5jhH9tet2M+vI+JVyiBvz/zfgasrb6Y4Cdx0Usy1JFktWwSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDw2gmIjaUlBecsvWMCmUDdUQ3z7WRooHrYrBIAKbJE=;
 b=rdG/NiqVjdUga6gvt1ZIBbqAIr20E4GqwwcwciG69PwF0ttR5jCBvdhHd6SQJRWgqRtjuwxNrXVyOpEmkObsFyIkfiE8NYJbjnvO8xwVIYp+wrp88fsYa+/f53Z9El1YNAfKfHcJY6t+k57OqOYsM7d/fwTGf1sTkFW2YUCbQ4o=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5274.namprd03.prod.outlook.com (2603:10b6:5:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 07:46:44 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 07:46:44 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "pmeerw@pmeerw.ne" <pmeerw@pmeerw.ne>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
Thread-Topic: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
Thread-Index: AQHWAoxiXsh0om2yLEiNKsKsJIqrVahZdywAgAEI/oD///99gIAAAZ4A
Date:   Thu, 26 Mar 2020 07:46:44 +0000
Message-ID: <7f131ff7c29fe36f56dc2892945d7a7d9c63b433.camel@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
         <20200325100112.85107-1-alexandru.ardelean@analog.com>
         <CAHp75VfVggWZ6WhOa=nUrxyd0dJrTbZd9NnUMhQ_S=kncrAhOw@mail.gmail.com>
         <62b90724f16fa3a2c54b7e7f2321587a328d7209.camel@analog.com>
         <f74263bc-5d42-db67-942e-f5970c71381e@metafoo.de>
In-Reply-To: <f74263bc-5d42-db67-942e-f5970c71381e@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4666e00-be02-4506-5f5b-08d7d159d4b7
x-ms-traffictypediagnostic: DM6PR03MB5274:
x-microsoft-antispam-prvs: <DM6PR03MB52743D235A71E6C09D5F0067F9CF0@DM6PR03MB5274.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(366004)(346002)(6506007)(5660300002)(8676002)(4326008)(6486002)(76116006)(186003)(66946007)(64756008)(316002)(66446008)(81156014)(81166006)(91956017)(66556008)(478600001)(110136005)(36756003)(6512007)(66476007)(8936002)(86362001)(54906003)(71200400001)(2616005)(26005)(2906002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5274;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQkf2i2FuorO5LAGNNIiWLHJ2Lky2Q7ptvLIbpPEdUw9f03k6UEs9qIrorjaHag2wRnoiOlj32ecw2YFp6joFSvrEoWd/5yyzsHlbXbv47YtCqQK3lTfJUsuC6nQhUlcpwsCoGnDWlgt1f5YF2C/1WuNhgpPl+fM1QdZ6yg8UfkaubIsG4njs8++jjPYi4pvcC8shoa+xb47HDr3LHclXXh/KWOMYr6QqwrEKP+Ey13woc8omFsgtB7cyscoho6THfqe0rRxZfOfOToa3ftyn+UOLdVCRgnhzMO5q5joK846VzvQFuzJzstkiZJcGGmMeC/ENfF9ITObPrfotGYR0iCvpflv//kVTPG3eILCbKF9HGwJFjzLWQja+xf0Wt82ykP/CBJrduMNfAYS8rBCfRsJ1R02RjbywTBpsgxITOUf2v935BETY6hrUxZQp7Qx
x-ms-exchange-antispam-messagedata: qDMmJoOFCrOJM6IN9iYzqh28+mS9djEGmELBdX+zDejaNU+LaHWPvaA45Wqm5nH/yNjYGvuF5kI+ZROWuLzhrJcx6mkrwv/P5Y+hbJmaEW11BsqiiD7MMy5lpcQiTSrPx7Ffokvs9oiAws3F9f15TQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF3DAAA65C768E47B1B55B47128A1B9F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4666e00-be02-4506-5f5b-08d7d159d4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 07:46:44.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuAwExMo+AzC+0HlM0a7raTw1LkpqEr0QwPbblna89ynOySVzoXp3ElHSJn32KTWHPqnzVFIUdB1SKNStHLX9tg5E4XTmPcX1LCw4QEK3SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=875 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTI2IGF0IDA4OjQ0ICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDMvMjYvMjAgODo0MiBBTSwgQXJkZWxlYW4sIEFs
ZXhhbmRydSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjAtMDMtMjUgYXQgMTc6NTcgKzAyMDAsIEFu
ZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+IFtFeHRlcm5hbF0NCj4gPiA+IA0KPiA+ID4gT24g
V2VkLCBNYXIgMjUsIDIwMjAgYXQgMTI6MDIgUE0gQWxleGFuZHJ1IEFyZGVsZWFuDQo+ID4gPiA8
YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBMYXJz
LVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiA+ID4gDQo+ID4gPiA+IEJlZm9y
ZSBhY3RpdmF0aW5nIGEgYnVmZmVyIG1ha2Ugc3VyZSB0aGF0IGF0IGxlYXN0IG9uZSBjaGFubmVs
IGlzDQo+ID4gPiA+IGVuYWJsZWQuDQo+ID4gPiA+IEFjdGl2YXRpbmcgYSBidWZmZXIgd2l0aCAw
IGNoYW5uZWxzIGVuYWJsZWQgZG9lc24ndCBtYWtlIHRvbyBtdWNoIHNlbnNlDQo+ID4gPiA+IGFu
ZA0KPiA+ID4gPiBkaXNhbGxvd2luZyB0aGlzIGNhc2UgbWFrZXMgc3VyZSB0aGF0IGluZGl2aWR1
YWwgZHJpdmVyIGRvbid0IGhhdmUgdG8NCj4gPiA+ID4gYWRkDQo+ID4gPiA+IHNwZWNpYWwgY2Fz
ZSBjb2RlIHRvIGhhbmRsZSBpdC4NCj4gPiA+ID4gDQo+ID4gPiA+IEN1cnJlbnRseSwgd2l0aG91
dCB0aGlzIHBhdGNoIGVuYWJsaW5nIGEgYnVmZmVyIGlzIHBvc3NpYmxlIGFuZCBubyBlcnJvcg0K
PiA+ID4gPiBpcw0KPiA+ID4gPiBwcm9kdWNlZC4gV2l0aCB0aGlzIHBhdGNoIC1FSU5WQUwgaXMg
cmV0dXJuZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBBbiBleGFtcGxlIG9mIGV4ZWN1dGlvbiB3aXRo
IHRoaXMgcGF0Y2ggYW5kIHNvbWUgaW5zdHJ1bWVudGVkIHByaW50LQ0KPiA+ID4gPiBjb2RlOg0K
PiA+ID4gPiAgICAgcm9vdEBhbmFsb2c6fiMgY2QgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvXDpk
ZXZpY2UzL2J1ZmZlcg0KPiA+ID4gPiAgICAgcm9vdEBhbmFsb2c6L3N5cy9idXMvaWlvL2Rldmlj
ZXMvaWlvOmRldmljZTMvYnVmZmVyIyBlY2hvIDEgPiBlbmFibGUNCj4gPiA+ID4gICAgIDA6IGlp
b192ZXJpZnlfdXBkYXRlIDc0OCBpbmRpb19kZXYtPm1hc2tsZW5ndGggMiAqaW5zZXJ0X2J1ZmZl
ci0NCj4gPiA+ID4gPiBzY2FuX21hc2sgMDAwMDAwMDANCj4gPiA+ID4gICAgIDE6IGlpb192ZXJp
ZnlfdXBkYXRlIDc1Mw0KPiA+ID4gPiAgICAgMjpfX2lpb191cGRhdGVfYnVmZmVycyAxMTE1IHJl
dCAtMjINCj4gPiA+ID4gICAgIDM6IGlpb19idWZmZXJfc3RvcmVfZW5hYmxlIDEyNDEgcmV0IC0y
Mg0KPiA+ID4gPiAgICAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50
DQo+ID4gPiA+IDEsIDIgJiAzIGFyZSBleGl0LWVycm9yIHBhdGhzLiAwIHRoZSBmaXJzdCBwcmlu
dCBpbiBpaW9fdmVyaWZ5X3VwZGF0ZSgpDQo+ID4gPiA+IHJlcmdhcmRsZXNzIG9mIGVycm9yIHBh
dGguDQo+ID4gPiA+IA0KPiA+ID4gPiBXaXRob3V0IHRoaXMgcGF0Y2ggKGFuZCBzYW1lIGluc3Ry
dW1lbnRlZCBwcmludC1jb2RlKToNCj4gPiA+ID4gICAgIHJvb3RAYW5hbG9nOn4jIGNkIC9zeXMv
YnVzL2lpby9kZXZpY2VzL2lpb1w6ZGV2aWNlMy9idWZmZXINCj4gPiA+ID4gICAgIHJvb3RAYW5h
bG9nOi9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2UzL2J1ZmZlciMgZWNobyAxID4gZW5h
YmxlDQo+ID4gPiA+ICAgICAwOiBpaW9fdmVyaWZ5X3VwZGF0ZSA3NDggaW5kaW9fZGV2LT5tYXNr
bGVuZ3RoIDIgKmluc2VydF9idWZmZXItDQo+ID4gPiA+ID4gc2Nhbl9tYXNrIDAwMDAwMDAwDQo+
ID4gPiA+ICAgICByb290QGFuYWxvZzovc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlMy9i
dWZmZXIjDQo+ID4gPiA+IEJ1ZmZlciBpcyBlbmFibGVkIHdpdGggbm8gZXJyb3IuDQo+ID4gPiA+
IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZv
by5kZT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5k
cnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IA0KPiA+ID4gPiBD
aGFuZ2Vsb2cgdjEgLT4gdjI6DQo+ID4gPiA+ICogbW92ZWQgY2hlY2sgaW4gaWlvX3ZlcmlmeV91
cGRhdGUoKQ0KPiA+ID4gPiAqIGFkZGVkIGRldl9kYmcoKSBtZXNzYWdlOyBzaG91bGQgaGVscCBz
b21lIGZvbGtzIHVuZGVyc3RhbmQgdGhlIG1lc3NhZ2UNCj4gPiA+ID4gKiBkb2N1bWVudGVkIHN0
ZXBzIHRvIHJlcHJvZHVjZQ0KPiA+ID4gPiAqIGFkZGVkIEZpeGVzIHRhZzsgaG9wZWZ1bGx5IHRo
ZSB0YWcgaXMgdGhlIGdvb2Qgb25lOyBpZiBuZWVkZWQsIGl0IGNhbg0KPiA+ID4gPiBiZQ0KPiA+
ID4gPiAgICBkcm9wcGVkOyB0aGlzIGhhcyBiZWVuIGFyb3VuZCBmb3IgfjggeWVhcnM7IG5vIGlk
ZWEgaWYgaXQncyB3b3J0aA0KPiA+ID4gPiAgICBiYWNrcG9ydGluZw0KPiA+ID4gV2hlcmU/DQo+
ID4gc3RhYmxlL2ZpeGVzL2x0cy1rZXJuZWxzDQo+ID4gZG9uJ3QgaGF2ZSBhIHJlYWxseSBnb29k
IGNsdWUgYWJvdXQgd2hlcmUgdGhlc2UgdGhpbmdzIG5lZWQgYmFja3BvcnRpbmc7DQo+IFdoYXQg
QW5keSBtZWFucyBpcyB0aGF0IHRoZXJlIGlzIG5vIEZpeGVzIHRhZyA6KQ0KDQpvaCBjcmFwLi4u
Lg0KaSBhZGRlZCBvbmUgYnV0IHNlZW0gdG8gaGF2ZSBsb3N0IGl0IHdoZW4gbW92aW5nIHRoZSBw
YXRjaCB0byB0aGUgc2VydmVyIGZyb20NCndoZXJlIGkgZG8gZ2l0LXNlbmQNCmknbGwgYWRkIG9u
ZTsNCg==
