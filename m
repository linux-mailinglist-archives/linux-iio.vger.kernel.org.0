Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127C11A6234
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 06:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgDMEe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 00:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgDMEe7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 00:34:59 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27680C008681
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 21:34:59 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D4TVTZ018359;
        Mon, 13 Apr 2020 00:34:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:34:54 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03D4Ys7I022891;
        Mon, 13 Apr 2020 00:34:54 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F99Iuh8PfwLXRK+DrGMRyeVvl2iqEQVz3GmH7OyLLqWBDnxaXMX73T/3MVKxkhz5DVD8cjBDn3Q2xFVrF8Y8NPuejhl27euUG7tZtzRKbUx2k3xsartnrTjrrbSDGHxXOCLGaYpR43PxecuD3utFd5b7H9f0Vtnz1zxomeQetaFAWwb0TypLlnjTk4BP9sP4uUgHv5zpv577kvDLgSKPFVrMRX3HhTbXqJn1BiOjGlbtcwmGH29Kesa7qhHLPhLX2Rytrg+iHkA3UafmTrggbX1jIuD1SE7ZFilKNkfcFwQk6ItAiWOknMnjg+/hTYTqc3pfw7WCvea/z4MxebNMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgkv6kDVLx+R4aK+6SQajWvi4Ugm2h6bcgBxJYlnAb0=;
 b=OvJ2GqPk+AMsql0XX3FqMPeETrxueDxfUO3wgIMVhDufjhDVusoV3cH6wmwtDwVAbrM3CG10X43uHAKLSd+xhwiWC3LmDrB/erKn3TXEJlzNfAkL/fB56i1zuk52bipc8MsW5g5TSop8MMDkQq4wAROUhO2+D5PJ8lrElSrAbFhJMWKK/+LxuJ9zXD8Oaho4PaRT+Vj7evXlbXybWgUEFrqxn4vQPZ6Mw+o9cIjh6qwbLhugTuf4hlLp1oKAa8SLzmrZDxd6f8Mil2C9TlHKD2YdD7RIGG18HJr7dMNMk+xcAPfyNQAXhunPHAor6ErwcxIjoa8+grQCbJ/Fs6wWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgkv6kDVLx+R4aK+6SQajWvi4Ugm2h6bcgBxJYlnAb0=;
 b=417eBArEwYrQ7RuLmSkLxpQg3mnA8wcXIg2z/mccMmPWRA+55fxWetgnFL+rOIz0NWuukVQfDv5phqwp9xE2TTty9x8cdvS8RbQznmwQc1GLPK+LBsyJnXdlNmx6EulNtp9Vy27ux/hkmtIBNoysbSBh50BiiAY7HImAsOsiQzs=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3787.namprd03.prod.outlook.com (2603:10b6:5:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 04:34:52 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 04:34:51 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/6] IIO: Tidy up parameters to regmap_bulk_* calls
Thread-Topic: [PATCH 0/6] IIO: Tidy up parameters to regmap_bulk_* calls
Thread-Index: AQHWC3TUgYilrRTGjEW5Liy5Nf17Eqh1ixoAgAB4dQCAAIBZgA==
Date:   Mon, 13 Apr 2020 04:34:50 +0000
Message-ID: <6f82392031e95a39a63d9fed87f94961cd8ae12c.camel@analog.com>
References: <20200405180321.1737310-1-jic23@kernel.org>
         <20200412144812.1c65e88a@archlinux>
         <CAHp75Vc87TNTx-jVS-YmFcxVe3Y0FfxWZsFT2SpuMM8dsfdxMA@mail.gmail.com>
In-Reply-To: <CAHp75Vc87TNTx-jVS-YmFcxVe3Y0FfxWZsFT2SpuMM8dsfdxMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45212c6d-c9a3-4485-799b-08d7df6401cf
x-ms-traffictypediagnostic: DM6PR03MB3787:
x-microsoft-antispam-prvs: <DM6PR03MB3787F40935554317B74FF5C8F9DD0@DM6PR03MB3787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39850400004)(478600001)(110136005)(5660300002)(6512007)(36756003)(54906003)(2906002)(186003)(76116006)(26005)(316002)(91956017)(66946007)(66476007)(64756008)(66556008)(66446008)(4326008)(81156014)(2616005)(86362001)(8936002)(6486002)(71200400001)(53546011)(6506007)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/J7kbYHlUnFP53J4/tVsenRl2o1ofbECKesYLkTX+QOgqs8+Cp0r45PF8t9H2og9N4tM+SPlLQbcmdWzUB0TKWcPsheQVptHgg6MmCbA3zEXo+tCosXcUa2Pl+J5TCmcBOrTjyOzAByf8ydP6DA8jIn9mTaHqHRnEa/5G76dSg4GfOLSyHT1p/0nvK7GjnteJXid/CgDaQ00ojZsdAa9p4Q09pdUPIueK1avVGshr/WkG0AKFzD0jBCp24uwPufMKH3lA59n+0FaVNkdr5zo7RO5SCwT1pGpqJ4/8H78IqDDZW/ec0kW9F/t4Ov3PXlP+QHa6JCiFsrvVXtTXy4/UAmpFZN7BEVhT7GiBZc0ft5aiIEE8b1BLDsP+y7IY4fvLulL/4H5b/IRcL0lsRy5FNlgi2U6Hs017kBATxWF9hjFxpcfdUBGIowMFTPQLtQ
x-ms-exchange-antispam-messagedata: ejEcv+Yoe2xlWmBJSWUEyEXhIKWBnxPyeyD6Anlof1aOzEDKYgPr3Q3Yov2LYxUBOVw//Htv0e4cyiXdBu7EAho9BaRrG5gbayocViMqaz0Td90BAfXrDP2laxnAi3BA8x04QfLRJQcw3+CqLpIgow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB36EBA3D3500243A476B5E49848415D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45212c6d-c9a3-4485-799b-08d7df6401cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 04:34:51.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkdecPvI6HFsD8Eto/uaSUFdAgGqBrK1aAneE4zolzfww4TFegx5lzADvOhxUka+VHdVuHyrx28D3vlhRVkwS9evH5p9q991CniJffURDJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_01:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130040
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTEyIGF0IDIzOjU5ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIFN1biwgQXByIDEyLCAyMDIwIGF0IDQ6NDggUE0gSm9uYXRoYW4gQ2FtZXJvbg0KPiA8
amljMjNAamljMjMucmV0cm9zbnViLmNvLnVrPiB3cm90ZToNCj4gPiBJZiBhbnlvbmUgaXMgYm9y
ZWQgYW5kIGZhbmNpZXMgc2FuaXR5IGNoZWNraW5nIHRoZSBvbmVzIGluIHRoaXMgc2VyaWVzDQo+
ID4gdGhhdCBoYXZlIGhhZCBubyBleWVzIG9uIHRoZW0geWV0LCBpdCB3b3VsZCBiZSBtdWNoIGFw
cHJlY2lhdGVkIQ0KPiANCj4gVGhlIHNlcmllcyBtYWtlcyBzZW5zZSB0byBtZS4gRmVlbCBmcmVl
IHRvIGFkZCBteSBSYiB0YWcgdG8gaXQgaWYgeW91IGxpa2UuDQo+IA0KDQpTYW1lIGZyb20gbXkg
c2lkZS4NCkkgYWRkZWQgbXkgdGFnIG9uIHRoZSBwYXRjaGVzLg0KSSB3YWl0ZWQgYSBiaXQgdW50
aWwgc29tZSBkcml2ZXIgYXV0aG9ycyByZXBsaWVkIGJhY2suDQoNCg0KPiA+IE9uIFN1biwgIDUg
QXByIDIwMjAgMTk6MDM6MTUgKzAxMDANCj4gPiBqaWMyM0BrZXJuZWwub3JnIHdyb3RlOg0KPiA+
IA0KPiA+ID4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tPg0KPiA+ID4gDQo+ID4gPiBPbmUgb2YgQW5keSBTaGV2Y2hlbmtvJ3MgcmVjZW50IHBhdGNo
ZXMgdGlkaWVkIGEgY2FzZSBvZiB0aGlzIHVwDQo+ID4gPiBhbmQgYSBxdWljayBncmVwIHNob3dl
ZCB3ZSBoYWQgc29tZSBtb3JlLg0KPiA+ID4gDQo+ID4gPiBUaGUgbWFpbiBmb2N1cyBvZiB0aGlz
IHNldCBpcyBjYWxscyB0byByZWdtYXBfYnVsa19yZWFkIC8NCj4gPiA+IHJlZ21hcF9idWxrX3dy
aXRlLiAgQm90aCBhcmUgdXNlZCB3aXRoIGJ1ZmZlcnMgb2YgbWFueSBhbmQgdmFyaWVkIHR5cGUs
DQo+ID4gPiBidXQgYXMgdGhleSB0YWtlIGEgdm9pZCAqIHRoZXJlIGlzIG5ldmVyIGFueSBuZWVk
IHRvIGNhc3QgYSBwb2ludGVyDQo+ID4gPiB0byBzYWlkIGJ1ZmZlcnMgdG8gYW55dGhpbmcgZXhw
bGljaXRseS4NCj4gPiA+IA0KPiA+ID4gV2hpbHN0IEkgd2FzIGhlcmUgSSB1c2VkIHNpemVvZihi
dWYpIGluIHZhcmlvdXMgcGxhY2VzIHRvIHJlZHVjZQ0KPiA+ID4gdGhlIHVzZSBvZiBleHBsaWNp
dCB2YWx1ZXMgd2hlbiB3ZSBjb3VsZCBkZXJpdmUgaXQgZnJvbSB0aGUgc291cmNlDQo+ID4gPiAv
IGRlc3RpbmF0aW9uIGJ1ZmZlci4NCj4gPiA+IA0KPiA+ID4gVGhpcyBpc24ndCByZW1vdGVseSB1
cmdlbnQsIGJ1dCBJJ2QgbGlrZSB0byBjbGVhbiB0aGVzZSBvdXQgdG8gYXZvaWQNCj4gPiA+IHJl
cGxpY2F0aW9uIGluIGZ1dHVyZS4gIE5vdCBJIGRpZG4ndCBnbyBhZnRlciBhbnkgb3RoZXIgdW5u
ZWNlc3NhcnkNCj4gPiA+IGNhc3RzIGluIHRoZSBmaWxlcyBiZWNhdXNlIHRoYXQgd291bGQgaGF2
ZSB0YWtlIHRob3VnaHQgYW5kIGl0cyBTdW5kYXkNCj4gPiA+IGV2ZW5pbmcgYW5kIGFib3V0IHRp
bWUgZm9yIGEgYmVlci4NCj4gPiA+IA0KPiA+ID4gSm9uYXRoYW4gQ2FtZXJvbiAoNik6DQo+ID4g
PiAgIGlpbzphY2NlbDpteGM0MDA1OiBEcm9wIHVubmVjZXNzYXJ5IGV4cGxpY2l0IGNhc3RzIGlu
IHJlZ21hcF9idWxrX3JlYWQNCj4gPiA+ICAgICBjYWxscw0KPiA+ID4gICBpaW86Y2hlbWljYWw6
YXRsYXMtc2Vuc29yOiBEcm9wIHVubmVjZXNzYXJ5IGV4cGxpY2l0IGNhc3RzIGluDQo+ID4gPiAg
ICAgcmVnbWFwX2J1bGtfcmVhZCBjYWxscw0KPiA+ID4gICBpaW86Y2hlbWljYWw6Ym1lNjgwOiBU
aWR5IHVwIHBhcmFtZXRlcnMgdG8gcmVnbWFwX2J1bGtfcmVhZA0KPiA+ID4gICBpaW86aW11Om1w
dTYwNTA6IFRpZHkgdXAgcGFyYW1ldGVycyB0byByZWdtYXBfYnVsayBmdW5jdGlvbnMuDQo+ID4g
PiAgIGlpbzptYWduOm1tYzM1MjQwOiBEcm9wIHVubmVjZXNzYXJ5IGNhc3RzIG9mIHZhbCBwYXJh
bWV0ZXIgaW4NCj4gPiA+ICAgICByZWdtYXBfYnVsayoNCj4gPiA+ICAgaWlvOmxpZ2h0Omx0cjUw
MTogRHJvcCB1bm5lY2Vzc2FyeSBjYXN0IG9mIHBhcmFtZXRlciBpbg0KPiA+ID4gICAgIHJlZ21h
cF9idWxrX3JlYWQNCj4gPiA+IA0KPiA+ID4gIGRyaXZlcnMvaWlvL2FjY2VsL214YzQwMDUuYyAg
ICAgICAgICAgICAgICB8ICA0ICstLQ0KPiA+ID4gIGRyaXZlcnMvaWlvL2NoZW1pY2FsL2F0bGFz
LXNlbnNvci5jICAgICAgICB8ICA3ICsrLS0tDQo+ID4gPiAgZHJpdmVycy9paW8vY2hlbWljYWwv
Ym1lNjgwX2NvcmUuYyAgICAgICAgIHwgMzYgKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ID4g
IGRyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2NvcmUuYyB8ICA0ICstLQ0KPiA+
ID4gIGRyaXZlcnMvaWlvL2xpZ2h0L2x0cjUwMS5jICAgICAgICAgICAgICAgICB8ICAyICstDQo+
ID4gPiAgZHJpdmVycy9paW8vbWFnbmV0b21ldGVyL21tYzM1MjQwLmMgICAgICAgIHwgIDQgKy0t
DQo+ID4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMo
LSkNCj4gPiA+IA0KPiANCj4gDQo=
