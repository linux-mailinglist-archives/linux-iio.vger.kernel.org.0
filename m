Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EFD198257
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgC3R1v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 13:27:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2862 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbgC3R1v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 13:27:51 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UH9up7013193;
        Mon, 30 Mar 2020 13:27:36 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6f99n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 13:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jky3BK7tScPxKCRwQqPYnpSW3YGwi0/xLomY7KHs9bvSUQ+HinP9dU5uvRdmF1vd8mVhptrbAvGwtVNwmqJGHCVsl6UxUUWZDp0F95b0leFrWQigk1rxQ1wqkOHBpOn6DTPqLggrSrH6aYZN2IGqZfYqDOK4MMUqk7s2FPpGosSU1NuE/ITqypv6XIDqmOfwULgiQ+QWKTcZwQp5tPRbkn+rd+OGjJNpgTS2JxXjq7wUJKbTWM1EcAT91Y/XRa6GjJQyTcDEc9qCIKcw6C1wG3NExlVg7Wdw2ZbYing99AfHjFcq0NTa1tvNsfNcSvFxvDXCDt9OLVARUsDndayKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TETmZKT4do3lRxm4j/4ZtzLLXG35RjB6zbsKzlSFBf0=;
 b=lYGbuB9kreZOwo4Fk8hijRo8jkq6bDJGMbAu8zyof6IzrCh24feUNW5jF+zW04kwisV7v0C+/godlOP0UvNbW8ycZoiqv5BeiwrH9Wr2hjJ20nMIdU5pLh0OLY4HExSqAprIWolWC969dptV1hNROQjfL8Lbeac3wcWyqFJdphXk7C2cktyYU/rjwOKpWTT3m+K9q1Ki5Jq+/hYuVnyv4xH36PPyvGtBulJlllqob6Ipfdak2TWoTnooy7exQAGKfwtSGu/YPfRtYpDWyARKs7rTljDF4fXhwvRe1yvwLp4FcHOmjo8L20K0N7TXRjsnFhSBRmqddFbcEqUwO49vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TETmZKT4do3lRxm4j/4ZtzLLXG35RjB6zbsKzlSFBf0=;
 b=YDN2TxFk7uMMhOXd89fQ8MI3iaQDRuZ71d3va6ahjfO69xqyZfxIwVPRrrrpGhbte84bAEgzq7Ze3mkQp39cx6wda3GAhznUnCngopOMOqzi4ZCnb9maTTnt/C+xhk4YGF4o+mcrCJ39mhHdRS3lv208QCS9PCHkrdo+Qh+l4cY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3580.namprd03.prod.outlook.com (2603:10b6:5:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Mon, 30 Mar
 2020 17:27:34 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 17:27:34 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [RFC PATCH 3/3] iio: buffer: add output buffer support for chrdev
Thread-Topic: [RFC PATCH 3/3] iio: buffer: add output buffer support for
 chrdev
Thread-Index: AQHWBqOE9oVQ7fNQqE2xB+Ffb30JdKhhSsUAgAAZ9AA=
Date:   Mon, 30 Mar 2020 17:27:34 +0000
Message-ID: <89f9cb7a7ea1b0cce1fcce77db9577b3e16b9287.camel@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
         <20200330145705.29447-4-alexandru.ardelean@analog.com>
         <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
In-Reply-To: <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bbe53256-79e0-431b-7812-08d7d4cfa2ac
x-ms-traffictypediagnostic: DM6PR03MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3580E5C81F69FFE0CD58FB28F9CB0@DM6PR03MB3580.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(91956017)(76116006)(2906002)(8676002)(2616005)(81166006)(8936002)(478600001)(66446008)(81156014)(66476007)(71200400001)(6506007)(64756008)(66946007)(5660300002)(53546011)(66556008)(36756003)(4326008)(6486002)(316002)(26005)(107886003)(86362001)(6512007)(186003)(110136005)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IR8QqJUmYJKxJ7P1l1mpWPYDdSPeSwwoj5F0pIwSOXdShio+YFadWKbhbfTuZvj1j8iO4luoD3e0zIDISOAZKUu1P3XQpgldVRcJHVGgNbABGEppKBOYdqaCyzrIHVe3QU4GDLi9A+WjbcTxLK3dabP3yc9dJqdcvF5AjLzVVApvFPmMbbjQ0dcUYnN8X4pPmucG3jKAY2oQLPKTwAK0oWVbjdUQ3IT9Q87tXKQjcHMByyp3ywHs7E0ktTCdk0St9vepNG0xRjkwsYFcPZQYGzcJpijo3jCmYIJAHrHahkaVPsREO1K926vQdeyB2coCaKghB1QqTUIoszyPPG4wKtMqAU3nXAHTQ5Y761YNycNAg8ZdAa7Gx7qRYWsLkTmgqHe5HN1hiA+L/U6kpCnMjOoPN2VwzEM6HE1I3TCdU2Q9ey8bnnDGK8cJ7zB9nLl9
x-ms-exchange-antispam-messagedata: p73sw5gpnk9LFwAfFR3caTp76qiZjkD1BKiqo75v1EM7DOpKxZuH1axNMlj5GfLuE4ZxkFNb1CeQXTb+DJvaOLFkZWXK5X8cBg7yvgiUa7wH4ZuhCYFB+eJFuPxI1q/yuYL0aJxll8pHpPv643ViAA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C85639AEDFB33A4A9CF3128E03EACC0B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe53256-79e0-431b-7812-08d7d4cfa2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 17:27:34.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbstxPuRK+PTXl5ft1IBOFkfP6oH2LtvRoHdVcwEw/ciYcY1LJcpX1X2EwkVoi3gSvbrshRc/TIycM5NWa8CUjwzprd+43LCSxOEgBK9DC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3580
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300153
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTMwIGF0IDE3OjU4ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDMvMzAvMjAgNDo1NyBQTSwgQWxleGFuZHJ1IEFy
ZGVsZWFuIHdyb3RlOg0KPiA+IFRoaXMgaXMgV0lQLg0KPiA+IEl0IGhhc24ndCBiZWVuIHRlc3Rl
ZCB5ZXQuIE1vc3RseSBzZXJ2ZXMgYXMgYmFzZSBmb3Igc29tZSBkaXNjdXNzaW9uLg0KPiA+IA0K
PiA+IFRoZXJlIGhhdmUgYmVlbiBzb21lIG9mZmxpbmUgZGlzY3Vzc2lvbnMgYWJvdXQgaG93IHRv
IGdvIGFib3V0IHRoaXMuDQo+ID4gU2luY2UgSSB3YXNuJ3QgaW52b2x2ZWQgaW4gYW55IG9mIHRo
b3NlIGRpc2N1c3Npb25zLCB0aGlzIGtpbmQgb2YgdHJpZXMgdG8NCj4gPiByZS1idWlsZCB0aGlu
Z3MgZnJvbSB2YXJpb3VzIGJpdHMuDQo+ID4gDQo+ID4gMS4gRmlyc3QgYXBwcm9hY2ggaXM6IHdl
IGtlZXAgMSBidWZmZXIgcGVyIGRldmljZSwgYW5kIHdlIG1ha2UgaXQgZWl0aGVyDQo+ID4gaW4v
b3V0LCB3aGljaCBtZWFucyB0aGF0IGZvciBkZXZpY2VzIHRoYXQgZm9yIGRldmljZXMgdGhhdCBo
YXZlIGJvdGggaW4vb3V0DQo+ID4gMiBpaW9fZGV2IGluc3RhbmNlcyBhcmUgcmVxdWlyZWQsIG9y
IGFuIEFEQyBuZWVkcyB0byBiZSBjb25uZWN0ZWQgb24gdGhlIGluDQo+ID4gcGF0aCBhbmQgYSBE
QUMgb24gb3V0LXBhdGguIFRoaXMgaXMgcHJlZG9taW5hbnRseSBkb25lIGluIHRoZSBBREkgdHJl
ZS4NCj4gPiANCj4gPiAyLiBPbmUgZGlzY3Vzc2lvbi9wcm9wb3NhbCB3YXMgdG8gaGF2ZSBtdWx0
aXBsZSBidWZmZXJzIHBlci1kZXZpY2UuIEJ1dCB0aGUNCj4gPiBkZXRhaWxzIGFyZSB2YWd1ZSBz
aW5jZSB0aGV5IHdlcmUgcmVsYXllZCB0byBtZS4NCj4gPiBPbmUgZGV0YWlsIHdhcywgdG8gaGF2
ZSBpbmRleGVzIGZvciBkZXZpY2VzIHRoYXQgaGF2ZSBtb3JlIHRoYW4gMQ0KPiA+IGJ1ZmZlcjoN
Cj4gPiANCj4gPiBJaW9fZGV2aWNlWDoNCj4gPiAgICAgICAgICBidWZmZXINCj4gPiAgICAgICAg
ICBzY2FuX2VsZW1lbnRzDQo+ID4gDQo+ID4gSWlvX2RldmljZVg6DQo+ID4gICAgICAgICAgQnVm
ZmVyWQ0KPiA+ICAgICAgICAgIHNjYW5fZWxlbWVudHNZDQo+ID4gICAgICAgICAgQnVmZmVyWg0K
PiA+ICAgICAgICAgIHNjYW5fZWxlbWVudHNaDQo+ID4gDQo+ID4gSSBhbSBub3Qgc3VyZSBob3cg
ZmVhc2libGUgdGhpcyBpcyBmb3IgYSBzaW5nbGUgY2hyZGV2LCBhcyB3aGVuIHlvdSBsb29rIGF0
DQo+ID4gdGhlIGZpbGVvcHMgdGhhdCBnZXQgYXNzaWduZWQgdG8gYSBjaHJkZXYsIGl0IGxvb2tz
IGxpa2UgaXQgY2FuIGhhdmUgYXQNCj4gPiBtb3N0IHR3byBidWZmZXJzIChvbmUgZm9yIGlucHV0
LCBvdXQgZm9yIG91dHB1dCkuDQo+ID4gDQo+ID4gTXVsdGlwbGV4aW5nIGlucHV0IGJ1ZmZlcnMg
Y2FuIHdvcmsgKGZyb20gQURDcyksIGJ1dCBkZW11bHRpcGxleGluZyBvdXRwdXQNCj4gPiBidWZm
ZXJzIGludG8gYSBEQUMsIG5vdCBzbyB3ZWxsLiBFc3BlY2lhbGx5IG9uIGEgc2luZ2xlIGNocmRl
di4NCj4gPiANCj4gPiBRdWVzdGlvbiAxOiBkbyB3ZSB3YW50IHRvIHN1cHBvcnQgbW9yZSB0aGFu
IDIgYnVmZmVycyBwZXIgY2hyZGV2Pw0KPiA+IA0KPiA+IFRoaXMgaXMgd2hhdCBBREkgY3VycmVu
dGx5IGhhcyBpbiBpdCdzIHRyZWUgKGFuZCB3b3JrcykuDQo+ID4gDQo+ID4gRXhhbXBsZSwgQURD
Og0KPiA+ICAgIyBscyBpaW9cOmRldmljZTMvYnVmZmVyLw0KPiA+ICAgZGF0YV9hdmFpbGFibGUg
IGVuYWJsZSAgbGVuZ3RoICBsZW5ndGhfYWxpZ25fYnl0ZXMgIHdhdGVybWFyaw0KPiA+ICAgIyAg
bHMgaWlvXDpkZXZpY2UzL3NjYW5fZWxlbWVudHMvDQo+ID4gIA0KPiA+IGluX3ZvbHRhZ2UwX2Vu
ICBpbl92b2x0YWdlMF9pbmRleCAgaW5fdm9sdGFnZTBfdHlwZSAgaW5fdm9sdGFnZTFfZW4gIGlu
X3ZvbHQNCj4gPiBhZ2UxX2luZGV4ICBpbl92b2x0YWdlMV90eXBlDQo+ID4gDQo+ID4gRXhhbXBs
ZSwgREFDOg0KPiA+ICAgIyAgbHMgaWlvXDpkZXZpY2U0L2J1ZmZlci8NCj4gPiAgIGRhdGFfYXZh
aWxhYmxlICBlbmFibGUgIGxlbmd0aCAgbGVuZ3RoX2FsaWduX2J5dGVzICB3YXRlcm1hcmsNCj4g
PiAgICMgbHMgaWlvXDpkZXZpY2U0L3NjYW5fZWxlbWVudHMvDQo+ID4gIA0KPiA+IG91dF92b2x0
YWdlMF9lbiAgICAgb3V0X3ZvbHRhZ2UwX3R5cGUgIG91dF92b2x0YWdlMV9pbmRleCAgb3V0X3Zv
bHRhZ2UyX2VuICANCj4gPiAgICBvdXRfdm9sdGFnZTJfdHlwZSAgb3V0X3ZvbHRhZ2UzX2luZGV4
DQo+ID4gIA0KPiA+IG91dF92b2x0YWdlMF9pbmRleCAgb3V0X3ZvbHRhZ2UxX2VuICAgIG91dF92
b2x0YWdlMV90eXBlICAgb3V0X3ZvbHRhZ2UyX2luZGUNCj4gPiB4ICBvdXRfdm9sdGFnZTNfZW4g
ICAgb3V0X3ZvbHRhZ2UzX3R5cGUNCj4gPiANCj4gPiBUaGUgZGlyZWN0aW9uIG9mIGVhY2ggZWxl
bWVudCBpcyBlbmNvZGVkIGludG8gdGhlIGZpbGVuYW1lIG9mIGVhY2ggY2hhbm5lbC4NCj4gPiAN
Cj4gPiBBbm90aGVyIHF1ZXN0aW9uIGlzOg0KPiA+ICAgRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGhh
dmUgbW9yZSB0aGFuIDEgJ3NjYW5fZWxlbWVudHMnIGZvbGRlcj8NCj4gPiAgIFRoYXQgaXMsIGZv
ciBkZXZpY2VzIHRoYXQgd291bGQgaGF2ZSBib3RoIGluICYgb3V0IGNoYW5uZWxzLg0KPiA+IA0K
PiA+IEZvciAnYnVmZmVyJyBmb2xkZXJzIEkgd2FzIHRoaW5raW5nIHRoYXQgaXQgbWF5IG1ha2Ug
c2Vuc2UgdG8gaGF2ZSwNCj4gPiAnYnVmZmVyX2luJyAmJiAnYnVmZmVyX291dCcuDQo+ID4gDQo+
ID4gU28sIG9uZSBpZGVhIGlzOg0KPiA+IA0KPiA+IElpb19kZXZpY2VYOg0KPiA+ICAgICAgICAg
IGJ1ZmZlcl9pbg0KPiA+ICAgICAgICAgIGJ1ZmZlcl9vdXQNCj4gPiAgICAgICAgICBzY2FuX2Vs
ZW1lbnRzDQo+ID4gDQo+ID4gQ3VycmVudGx5LCB0aGlzIHBhdGNoIGtpbmQgb2YgaW1wbGVtZW50
cyAyIGJ1ZmZlcnMgcGVyIGlpb19kZXYvY2hyZGV2Lg0KPiA+IEJ1dCB0aGUgZm9ybWF0IGlzOg0K
PiA+IA0KPiA+IElpb19kZXZpY2VYOg0KPiA+ICAgICAgICAgIGJ1ZmZlcl9pbg0KPiA+ICAgICAg
ICAgIGJ1ZmZlcl9vdXQNCj4gPiAgICAgICAgICBzY2FuX2VsZW1lbnRzX2luDQo+ID4gICAgICAg
ICAgc2Nhbl9lbGVtZW50c19vdXQNCj4gDQo+IEknZCBtYWtlIHNjYW5fZWxlbWVudHMgYXMgYSBz
dWItZm9sZGVyIG9mIHRoZSBidWZmZXIgZm9sZGVyLiBBbmQgaGF2ZSANCj4gc3ltbGluayBmb3Ig
dGhlIGxlZ2FjeSBjYXNlDQo+IA0KPiA+IE9idmlvdXNseSBpdCBzaG91bGRuJ3Qgd29yayBhcy1p
cyBbYXMgaXQgd2Fzbid0IHRlc3RlZF0sIGJ1dCBhdCBsZWFzdCBnaXZlcw0KPiA+IHNvbWUgZ2xp
bXBzZSBvZiB3aGVyZSB0aGlzIGNvdWxkIGdvLg0KPiANCj4gSSBiZWxpZXZlIHRoZSBiYXNpYyBp
ZGVhIGJlaGluZCB0aGUgbXVsdGlwbGUgYnVmZmVycyBwZXIgZGV2aWNlIHdhcywgDQo+IHRoYXQg
aWYgd2UgZG8gaXQsIHdlIHNob3VsZCBkbyBpdCBpbiBhIHdheSB0aGF0IHlvdSBjYW4gaGF2ZSBh
biANCj4gYXJiaXRyYXJ5IG51bWJlciBvZiBidWZmZXJzLiBFLmcuIG5vdCBqdXN0IG9uZSBpbnB1
dCBhbmQgb3V0cHV0IGJ1dCBhbHNvIA0KPiBtdWx0aXBsZSBpbnB1dCBidWZmZXJzLg0KPiANCj4g
PiAzLiBBIHNpZGUgcXVlc3Rpb24gaXMgYWJvdXQgdGhlICdpaW9fYnVmZmVyIC0+IHBvbGxxJyBm
aWVsZC4gSSB3YXMNCj4gPiB3b25kZXJpbmcgaWYgaXQgd291bGQgbWFrZSBzZW5zZSB0byBtb3Zl
IHRoYXQgb24gdG8gJ2lpb19kZXYgIHBvbGxxJyBpZg0KPiA+IGFkZGluZyBtdWx0aXBsZSBidWZm
ZXJzIGFyZSBhZGRlZCBwZXItZGV2aWNlLiBJdCBhbG1vc3QgbWFrZXMgc2Vuc2UgdG8NCj4gPiB1
bmlmeSB0aGUgJ3BvbGxxJyBvbiBpbmRpb19kZXYuDQo+ID4gQnV0LCBpdCBsb29rcyBhIGJpdCBk
aWZmaWN1bHQsIGFuZCB3b3VsZCByZXF1aXJlIHNvbWUgbW9yZSBjaGFuZ2UgW3doaWNoIGlzDQo+
ID4gZG9hYmxlXSBpZiBpdCBtYWtlcyBzZW5zZSBmb3Igd2hhdGV2ZXIgcmVhc29uLg0KPiA+IFRo
ZSBvbmx5IHJlYXNvbiB0byBkbyBpdCwgaXMgYmVjYXVzZSB0aGUgaWlvX2J1ZmZlcl9maWxlb3Bz
IGhhcyBhIC5wb2xsID0NCj4gPiBpaW9fYnVmZmVyX3BvbGwoKSBmdW5jdGlvbiBhdHRhY2hlZCB0
byBpdC4gQWRkaW5nIG11bHRpcGxlIGJ1ZmZlcnMgZm9yIGFuDQo+ID4gSUlPIGRldmljZSBtYXkg
cmVxdWlyZSBzb21lIGNvbnNpZGVyYXRpb24gb24gdGhlIGlpb19idWZmZXJfcG9sbCgpIGZ1bmN0
aW9uDQo+ID4gYXMgd2VsbC4NCj4gDQo+IEkgdGhpbmsgd2UgbmVlZCBvbmUgY2hhcmRldiBwZXIg
YnVmZmVyLiBDb25jZXB0dWFsbHkgdGhhdCBpcyB0aGUgcmlnaHQgDQo+IGFwcHJvYWNoIGluIG15
IG9wdGlvbiBzaW5jZSB0aGUgdHdvIGJ1ZmZlcnMgYXJlIGluZGVwZW5kZW50IHN0cmVhbXMuIEJ1
dCANCj4gYWxzbyBmcm9tIGEgcHJhY3RpY2FsIHBvaW50IG9mIHZpZXcgd2Ugd2FudCB0byBoYXZl
IHRoZSBhYmlsaXR5IHRvIGhhdmUgDQo+IHRoZSBidWZmZXJzIG9wZW5lZCBieSBkaWZmZXJlbnQg
YXBwbGljYXRpb25zLiBFLmcuIGlpb19yZWFkZGV2IG9uIHRoZSANCj4gaW5wdXQgYnVmZmVyIGFu
ZCBpaW9fd3JpdGVkZXYgb24gdGhlIG91dHB1dCBidWZmZXIuIEFuZCB0aGVyZSBtaWdodCBiZSAN
Cj4gc29tZSBvdGhlciBvcGVyYXRpb25zIHRoYXQgd29udCBtdWx0aXBsZXggYXMgbmljZWx5IGFz
IHJlYWQvd3JpdGUuIFRoZSANCj4gaGlnaCBzcGVlZCBpbnRlcmZhY2UgZm9yIGV4YW1wbGUgd291
bGQgbm90IHdvcmsgYXMgaXQgaXMgcmlnaHQgbm93Lg0KDQpGb3Igc29tZSByZWFzb24sIHRoZSBp
ZGVhIG9mIG1vcmUgdGhhbiAxIGNocmRldiBwZXIgSUlPIGRldmljZSBlc2NhcGVkIG1lLg0KSXQg
bWFrZXMgdGhpbmdzIGVhc2llci4NCkknbGwgdGFrZSBhIGxvb2suDQpJIHByb2JhYmx5IG5lZWQg
dG8gdGhpbmsgYWJvdXQgdGhlIG5hbWluZywgb3IgaG93IHRvIGlkZW50aWZ5IGNocmRldnMgcGVy
IElJTw0KZGV2aWNlLg0KDQpNYXliZSBzb21ldGhpbmcgbGlrZToNCi9kZXYvaWlvOmRldmljZTA6
MA0KL2Rldi9paW86ZGV2aWNlMDoxDQoNCndoZXJlIHRoZSAybmQgaW5kZXggaXMgDQovc3lzL2J1
cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlMC9idWZmZXIwDQovc3lzL2J1cy9paW8vZGV2aWNlcy9p
aW86ZGV2aWNlMC9idWZmZXIxDQoNCm9yIHNvbWV0aGluZyBsaWtlIHRoYXQNCg0Kbm90IHN1cmUg
eWV0IGhvdyBwb3NzaWJsZSBpdCBpcyB5ZXQ7IG5lZWQgdG8gY2hlY2sNCg0KPiANCg==
