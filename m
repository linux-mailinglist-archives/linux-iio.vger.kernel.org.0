Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C841FCEDE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 15:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFQNxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 09:53:11 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:64690 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbgFQNxK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2020 09:53:10 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HDjXdd020968;
        Wed, 17 Jun 2020 09:52:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 31q64v29re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 09:52:39 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HDqdfJ028642;
        Wed, 17 Jun 2020 09:52:39 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 31q64v29ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 09:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU00gBt7LOVgxhXPyoXwxHNrpKzosG+U5hXxMKOOWjEE7nKtQSr9+VZ3jwKzpkx5FNkDw/Zic8Lo7WwWU14mhDFGn9eGhqONmywBmyQp5aNfyPOZvQ+lbBe2IFgVMpXoUiQyS+F7FfTsdQ/8QQpJrDLLDXLaslVIb1OJ1I38k4b4qNJimAoKGHyT7MVHST0qbymBX8pxRSlinDKYAmed3AkXuv6rQW1JYVBl7+4vaOzCWjiH2Y6glWuZCag+og5tAgyzGA0/JUP7WTfiyKVuby5bSliz2UYsIRej1qtZ8uewy6r66NtGlExQUMNQUhEi4xhPnSKWzZ+FkAYfBips+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxrlPdcZi9XB0ktRpTqucbfjtiSTKEgPyOV9Q3whs+k=;
 b=XmrLbeJfraoP0xVkpdAh/c8eYeKTFoKxwvi51AobNVlerPVOCWzkEno+MCN8MKAT37Z/6E0OctsCDbY0sGpRBTQ+jw4kw+lA3yzNeuS47zNBD7UTGojlZ4/oKad0LTyEMeXs0r6S4sc0YoDFOFC8ApXYXf6RhObptEE3qfX2vJjo77yT/r1hJsTypDSA0fsUdO0PR4XwqfEQD3FJkfOrnL7stzXY6UJoVpFKnb742KX643WMvhxiY3bZdqTTRLyb7T2wl82mQdEXIUJjEy5YFJ5WjfTYW7LkTfsMM6yp5Hfl5+/S2pY34uzJv5oEA+HGBV157DEdc2QLcSfVhBD9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxrlPdcZi9XB0ktRpTqucbfjtiSTKEgPyOV9Q3whs+k=;
 b=rfjEiE8HuMyWTs3oG5ahjddt4EjHa3MorpVHkA0pF21YVpaj8eZKgx/5ZfC6xvRLz96CO37EdzB4PKGaygqSMplXdorQatJ1hqknV4BLrXEowzqSDeCKHNpb+meXas9KKa4awxToKjQHCnO9a+EoKSn5e4RKchulm9g286JIqJo=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM5PR03MB2427.namprd03.prod.outlook.com (2603:10b6:3:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Wed, 17 Jun
 2020 13:52:37 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 13:52:37 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "songqiang1304521@gmail.com" <songqiang1304521@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Topic: [PATCH v2 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Thread-Index: AQHWMosiebcsgWLmWUu0dbt01y27SqjCXn4AgAKhWwCAABHOAIAX4hsAgAAEbQA=
Date:   Wed, 17 Jun 2020 13:52:37 +0000
Message-ID: <0eeae8e8c2c1a3f21e15c1931bacb197a8245104.camel@analog.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
         <20200525113855.178821-3-alexandru.ardelean@analog.com>
         <20200531164020.765822dc@archlinux>
         <a0253d719a4390f65668789e5fc182ec19355f17.camel@analog.com>
         <20200602095406.00005add@Huawei.com>
         <37ef45f4-9330-86ea-77c1-3138bb88601b@microchip.com>
In-Reply-To: <37ef45f4-9330-86ea-77c1-3138bb88601b@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27d821c3-8996-4626-e87f-08d812c5b1fa
x-ms-traffictypediagnostic: DM5PR03MB2427:
x-microsoft-antispam-prvs: <DM5PR03MB24273C5F91A52F8AA63BE08BF99A0@DM5PR03MB2427.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keL2ccCBHfOu0mDkpE9KnSHxx5Zld/aoIaaQvlB8LZdCWgSusN4ySy1mhFbLgtedIyMeq5SJtEUuoVQAl1kq69DXuA6qbBa8nfIWKloX7kvF757zbOJb4shdhkbzYKQckwUQBd0GgZ1QTI/mdwDf8kM53yyLxMgFlgQshwoXbpY82P216FnoV4JmZuEQ0mR+VoZyAJYh6z5q0+PywAEPAQBuTFZrSKF8Hj2ZPFmMt2Lu5D0kY9RJo4sCF4HccU08Admx/WFt+oZjz4BwreR4dODXDd7BJ1jj1wYV4twydsnYNRl9XgjkDZC0lkgOhjgbPFkG5ayx/PGGzpnBn3YBzqLow0mPOT+UL3Sp/+EMifxXW+rmtCjMc0mCeeNd8XoAwjBb8GnbV7iA97aPx9Qhvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(376002)(39860400002)(366004)(6486002)(8936002)(53546011)(6506007)(83380400001)(4326008)(86362001)(36756003)(316002)(8676002)(2906002)(76116006)(91956017)(26005)(186003)(66476007)(66446008)(64756008)(6512007)(2616005)(478600001)(7416002)(54906003)(66946007)(5660300002)(71200400001)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c4b98K1rkPENED0QAhd5k51XyWQaa7szKM+1anvo57NOKpiu5QkZ8FGkUeAAZilwPh9yORn6RS/tPmsMqaXaRl+ChBZiMLqBV58yCF6D8cs94Ws9aTF0ykU/xqO7VFM4j541VwtQveZ5iAl+kN/g+4cdMneQtz3YUEshN5dwgM5iC0miFt3ppq4fGRhQmOl2rlo6BumgCAZytNPVadN8AtAnOhZ4lx5Oozn8r3TxclFnmf2to8rjmAEphMyy/UchxCn8VDx1jvWOYYgAjSIx+WhxofEak25ErSxQY2rg4ej0gfkHTrAORPHEFcSrpCU74uce4VQTT5JyyVM+2Y1OPBPXioa9LW0F23aUaRNCa4ehOisQ9dt1oBAU9k0EpVLY31WMrkMVKGgwYLmNcFW0N0T1YH+AnpwubsCQG/lVi4IfNlBnB2MZ6OUoBSDmnxDZlTkzUgmGj2cJTTJ2Fv/6iFwR+CbJjNIxTMn0F01T6ZQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B22721042D510B4B8DEF4ECD8FF6481B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d821c3-8996-4626-e87f-08d812c5b1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 13:52:37.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdLmnjTgdzZDAWhI2FwbuisxOQEulBK0+54UNSS6vtQAHOgUZ0Il1xr4HYg9W5IxH8WrwjPNR7L4syZygVo0Sg7L/fVSVPYivtMHHXjXJoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2427
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_04:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170107
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDEzOjM3ICswMDAwLCBFdWdlbi5IcmlzdGV2QG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDAyLjA2LjIwMjAgMTE6NTQsIEpv
bmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gT24gVHVlLCAyIEp1biAyMDIwIDA3OjUwOjIzICsw
MDAwDQo+ID4gIkFyZGVsZWFuLCBBbGV4YW5kcnUiIDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9n
LmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBTdW4sIDIwMjAtMDUtMzEgYXQgMTY6NDAgKzAx
MDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjUgTWF5IDIwMjAg
MTQ6Mzg6NTUgKzAzMDANCj4gPiA+ID4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJk
ZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IEZyb206IExhcnMt
UGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRo
aXMgcGF0Y2ggc2hvdWxkIGJlIHNxdWFzaGVkIGludG8gdGhlIGZpcnN0IG9uZSwgYXMgdGhlIGZp
cnN0IG9uZSBpcw0KPiA+ID4gPiA+IGJyZWFraW5nIHRoZSBidWlsZCAoaW50ZW50aW9uYWxseSkg
dG8gbWFrZSB0aGUgSUlPIGNvcmUgZmlsZXMgZWFzaWVyDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4g
PiByZXZpZXcuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRl
ciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxl
eGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gDQo+ID4gPiA+IEZyaWVuZCBwb2tlLiAgVmVyc2lvbiBsb2c/DQo+ID4g
PiANCj4gPiA+IFZlcnNpb24gbG9nIGlzIGluIHRoZSBmaXJzdCBwYXRjaC4NCj4gPiA+IEkgd2Fz
IHdvbmRlcmluZyBpZiBJIG9taXR0ZWQgaXQuDQo+ID4gPiBTZWVtcywgdGhpcyB0aW1lIEkgZGlk
bid0LiBCdXQgSSBhZG1pdCwgaXQgcHJvYmFibHkgd291bGQgaGF2ZSBiZWVuIGJldHRlcg0KPiA+
ID4gaGVyZS4NCj4gPiBBaCBmYWlyIGVub3VnaC4gIFRoYXQgd29ya3MgZmluZSBpZiB0aGVyZSBp
cyBhIGNvdmVyIGxldHRlciBidXQgbm90DQo+ID4gc28gbXVjaCBqdXN0IHB1dHRpbmcgdGhpbmdz
IGluIHRoZSBmaXJzdCBwYXRjaCENCj4gPiA+ID4gT3RoZXIgdGhhbiB0aGUgd2lzdGZ1bCBjb21t
ZW50IGJlbG93ICh3aGljaCBJJ20gbm90IGV4cGVjdGluZyB5b3UgdG8NCj4gPiA+ID4gZG8gYW55
dGhpbmcgYWJvdXQgYnR3ISkgd2hvbGUgc2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUuDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGVzZSBhcmUgb2J2aW91c2x5IG5vIGZ1bmN0aW9uYWwgY2hhbmdlcyAoSSB0
aGluaykgc28gaXQncyBvbmx5IHJlYWxseQ0KPiA+ID4gPiBwYXRjaCAyIHRoYXQNCj4gPiA+ID4g
Y291bGQgZG8gd2l0aCBtb3JlIGV5ZXMgYW5kIGFja3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBGYXIg
YXMgSSBjYW4gdGVsbCB0aGF0IGNhc2UgaXMgZmluZSBhcyB3ZWxsIGJlY2F1c2Ugb2YgdGhlIHBy
b3RlY3Rpb25zDQo+ID4gPiA+IG9uIGJlaW5nIGluIHRoZSByaWdodCBtb2RlLCBidXQgbW9yZSBl
eWVzIG9uIHRoYXQgd291bGQgYmUgZ3JlYXQuDQo+ID4gPiA+IA0KPiA+ID4gPiBTbyBhc3N1bWlu
ZyB0aGF0J3MgZmluZSwgd2hhdCBjb21taXQgbWVzc2FnZSBkbyB5b3Ugd2FudCBtZSB0byB1c2Ug
Zm9yDQo+ID4gPiA+IHRoZSBmdXNlZCBzaW5nbGUgcGF0Y2g/DQo+ID4gPiANCj4gPiA+IENvbW1p
dCBtZXNzYWdlLXdpc2U6IEkgdGhpbmsgdGhlIG1lc3NhZ2UgaW4gdGhlIGZpcnN0IGNvbW1pdCB3
b3VsZCBiZQ0KPiA+ID4gbW9zdGx5IHN1ZmZpY2llbnQuDQo+ID4gPiBObyBpZGVhIHdoYXQgb3Ro
ZXIgZGVzY3JpcHRpb24gd291bGQgYmUgbmVlZGVkLg0KPiA+ID4gDQo+ID4gPiBTbywgbWF5YmUg
c29tZXRoaW5nIGxpa2U6DQo+ID4gPiANCj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IEFsbCBk
ZXZpY2VzIHVzaW5nIGEgdHJpZ2dlcmVkIGJ1ZmZlciBuZWVkIHRvIGF0dGFjaCBhbmQgZGV0YWNo
IHRoZSB0cmlnZ2VyDQo+ID4gPiB0byB0aGUgZGV2aWNlIGluIG9yZGVyIHRvIHByb3Blcmx5IHdv
cmsuIEluc3RlYWQgb2YgZG9pbmcgdGhpcyBpbiBlYWNoIGFuZA0KPiA+ID4gZXZlcnkgZHJpdmVy
IGJ5IGhhbmQgbW92ZSB0aGlzIGludG8gdGhlIGNvcmUuDQo+ID4gPiANCj4gPiA+IEF0IHRoaXMg
cG9pbnQgaW4gdGltZSwgYWxsIGRyaXZlcnMgc2hvdWxkIGhhdmUgYmVlbiByZXNvbHZlZCB0bw0K
PiA+ID4gYXR0YWNoL2RldGFjaCB0aGUgcG9sbC1mdW5jdGlvbiBpbiB0aGUgc2FtZSBvcmRlci4N
Cj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCByZW1vdmVzIGFsbCBleHBsaWNpdCBjYWxscyBvZiBp
aW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKCkNCj4gPiA+ICYgaWlvX3RyaWdnZXJlZF9i
dWZmZXJfcHJlZGlzYWJsZSgpIGluIGFsbCBkcml2ZXJzLCBzaW5jZSB0aGUgY29yZSBoYW5kbGVz
DQo+ID4gPiBub3cgdGhlIHBvbGxmdW5jIGF0dGFjaC9kZXRhY2guDQo+ID4gPiANCj4gPiA+IFRo
ZSBtb3JlIHBlY3VsaWFyIGNoYW5nZSBpcyBmb3IgdGhlICdhdDkxLXNhbWE1ZDJfYWRjJyBkcml2
ZXIsIHNpbmNlIGl0J3MNCj4gPiA+IG5vdCBvYnZpb3VzIHRoYXQgcmVtb3ZpbmcgdGhlIGhvb2tz
IGRvZXNuJ3QgYnJlYWsgYW55dGhpbmcqKg0KPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gDQo+
ID4gDQo+ID4gTG9va3MgZ29vZC4NCj4gPiANCj4gPiA+ICoqIGZvciB0aGUgY29tbWVudCBhYm91
dCAnYXQ5MS1zYW1hNWQyX2FkYycsIHdlIHJlYWxseSBkbyBuZWVkIHRvIGdldCBzb21lDQo+ID4g
PiB0ZXN0aW5nOyBvdGhlcndpc2UgdGhpcyByaXNrcyBicmVha2luZyBpdC4NCj4gDQo+IEhpLA0K
PiANCj4gSSBjYW4gdGVzdCBpdCwgZG8gd2UgaGF2ZSBhbnkgcGF0Y2h3b3JrIHNvIEkgY2FuIGVh
c2lseSBkb3dubG9hZCB0aGUgDQo+IHBhdGNoZXMgPw0KPiBJIGhhdmUgaXNzdWVzIHdoZW4gYXBw
bHlpbmcgdGhlbS4NCg0KSXMgdGhpcyBnb29kPw0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3BhdGNoLzExNTY4NzQzLw0KU2VyaWVzOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LWlpby9saXN0Lz9zZXJpZXM9MjkzMTQxDQoNCk1hbnkgdGhhbmtzDQpB
bGV4DQoNCj4gDQo+IFRoYW5rcyAhDQo+IA0KPiA+IEFncmVlZC4NCj4gPiANCj4gPiA+IA0KPiA+
ID4gPiBUaGFua3MsDQo+ID4gPiA+IA0KPiA+ID4gPiBKb25hdGhhbg0KPiA+ID4gPiANCj4gPiA+
ID4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX3RyaWdnZXJfb3BzIGF0bGFzX2ludGVycnVw
dF90cmlnZ2VyX29wcyA9IHsNCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vZHVt
bXkvaWlvX3NpbXBsZV9kdW1teV9idWZmZXIuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy9paW8vZHVt
bXkvaWlvX3NpbXBsZV9kdW1teV9idWZmZXIuYw0KPiA+ID4gPiA+IGluZGV4IDE3NjA2ZWNhNDJi
NC4uOGUxM2M1M2Q0MzYwIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2R1bW15
L2lpb19zaW1wbGVfZHVtbXlfYnVmZmVyLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2lpby9k
dW1teS9paW9fc2ltcGxlX2R1bW15X2J1ZmZlci5jDQo+ID4gPiA+ID4gQEAgLTk5LDIwICs5OSw2
IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBpaW9fc2ltcGxlX2R1bW15X3RyaWdnZXJfaChpbnQNCj4g
PiA+ID4gPiBpcnEsIHZvaWQgKnApDQo+ID4gPiA+ID4gICB9DQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzDQo+ID4gPiA+ID4g
aWlvX3NpbXBsZV9kdW1teV9idWZmZXJfc2V0dXBfb3BzID0gew0KPiA+ID4gPiA+IC0gLyoNCj4g
PiA+ID4gPiAtICAqIGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGU6DQo+ID4gPiA+ID4g
LSAgKiBHZW5lcmljIGZ1bmN0aW9uIHRoYXQgc2ltcGx5IGF0dGFjaGVzIHRoZSBwb2xsZnVuYyB0
byB0aGUNCj4gPiA+ID4gPiB0cmlnZ2VyLg0KPiA+ID4gPiA+IC0gICogUmVwbGFjZSB0aGlzIHRv
IG1lc3Mgd2l0aCBoYXJkd2FyZSBzdGF0ZSBiZWZvcmUgd2UgYXR0YWNoIHRoZQ0KPiA+ID4gPiA+
IC0gICogdHJpZ2dlci4NCj4gPiA+ID4gPiAtICAqLw0KPiA+ID4gPiA+IC0gLnBvc3RlbmFibGUg
PSAmaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSwNCj4gPiA+ID4gPiAtIC8qDQo+ID4g
PiA+ID4gLSAgKiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlOg0KPiA+ID4gPiA+IC0g
ICogR2VuZXJpYyBmdW5jdGlvbiB0aGF0IHNpbXBsZSBkZXRhY2hlcyB0aGUgcG9sbGZ1bmMgZnJv
bSB0aGUNCj4gPiA+ID4gPiB0cmlnZ2VyLg0KPiA+ID4gPiA+IC0gICogUmVwbGFjZSB0aGlzIHRv
IHB1dCBoYXJkd2FyZSBzdGF0ZSBiYWNrIGFnYWluIGFmdGVyIHRoZSB0cmlnZ2VyDQo+ID4gPiA+
ID4gaXMNCj4gPiA+ID4gPiAtICAqIGRldGFjaGVkIGJ1dCBiZWZvcmUgdXNlcnNwYWNlIGtub3dz
IHdlIGhhdmUgZGlzYWJsZWQgdGhlIHJpbmcuDQo+ID4gPiA+ID4gLSAgKi8NCj4gPiA+ID4gPiAt
IC5wcmVkaXNhYmxlID0gJmlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUsDQo+ID4gPiA+
ID4gICB9Ow0KPiA+ID4gPiA+IA0KPiA+ID4gPiBIbW0uIEd1ZXNzIHdlIHNob3VsZCBwcm9iYWJs
eSAnaW52ZW50JyBhIHJlYXNvbiB0byBpbGx1c3RyYXRlIHRoZSBidWZlcg0KPiA+ID4gPiBvcHMg
aW4gdGhlIGR1bW15IGV4YW1wbGUuICBBbnlvbmUgZmVlbGluZyBjcmVhdGl2ZT8NCj4gPiA+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gPiBsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnDQo+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsX187ISFB
M05pOENTMHkyWSF1bEg5MlMzb19KV0xNUWZnNVZCckZrbndjXy1hMEs1QUhwSkJyVEVCLVJ0WUVw
N1BuUko5akFfRWFjT3pGUW1iTklLTy1RJCANCg==
