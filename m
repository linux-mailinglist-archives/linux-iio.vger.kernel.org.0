Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACDB4778
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 08:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbfIQGY5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 02:24:57 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:23572 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733156AbfIQGY4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 02:24:56 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8H6MZ6L023172;
        Tue, 17 Sep 2019 02:24:54 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0vu6d8db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 02:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP3h/8YcLc1isuQV6lltF4Y9RhaTGYqwIgBJCbNLzrRp0mqWe/fMw5K0k9yzh4o/gWgfYVLrxaqhhDrGNSyyRg7XNmlETmZEUFrwxQoeLhRwT45USyw9BA8ibb4yoz0HBQ/0FR/EtXOlMS99x4hOH0Y3wEJjhT824AsTnn4jxzGsT97d2PDMHOaCh3ceJ1M2i74SVGvZqTash/gFEuxj7R/IRxlewhCEhFmEclZX9y0CVWW7Gx//7NcW+zUagjkbINFH3hLedZ3zVrCteLLtBQaBR2mc7WVAIaz3XZqlYNEKh/x681u7N9jPaTpyAEkGWhTjL+vtRVbPk0DDQlyLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Um2WtADRRejlQnjEdwWsHok6vDW5ldTPDyeo1F1tYE=;
 b=MfcJvgRB8UDnA8+gy1jJ4yAgtq42bv/ZsXT/2U249K4tJ7hMtZMxUV+36q9F1eEVGdclyNJs71+InaV4IibCZqEnFiGfHSoOfxrgzUuvlohB4zyLtegWym6+q0XPoQ8Ld2vZJ58uSvwefgioelFhw2Clh538aSECEwAbWm2KIJiS9y8B6x+9W9j+Rb1F8p8QpisD81OSJXtO4xC17rLF2Tng7Z0gPngj6l2vahRKMSrsJoqv3sFLP4WJLKOHe0uOiHJqe5IP0Gcez6mtH5CnbVtIlRu7foFYGEGWgm4R7coF5u8o+hdkKP++MuZ8y+wJJJeMOwwkFhhj06LQGe8Vpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Um2WtADRRejlQnjEdwWsHok6vDW5ldTPDyeo1F1tYE=;
 b=GHyhTyLS3bNryFroZYX/2PI9RLvj+kL22uu8sKiCORxlfrSXaryzZMwxwO0htPtl53AqSLqLF3f26hygeWTS35VY1kCIU2LaiGDtWkvdQoUSqYvYHnCPr1hJc9y2qXiJM1F7a/SOKDDR6gDcDHrNI1fsymMU0Q8MmWmokCFKE0g=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5272.namprd03.prod.outlook.com (20.180.4.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Tue, 17 Sep 2019 06:24:52 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Tue, 17 Sep 2019
 06:24:52 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>
CC:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>
Subject: Re: Doubts in getting started with the Analog AD7928 driver
Thread-Topic: Doubts in getting started with the Analog AD7928 driver
Thread-Index: AQHVbOmDJqvXZ8MIiE2nOdnvDHBUzKcvma8A
Date:   Tue, 17 Sep 2019 06:24:52 +0000
Message-ID: <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com>
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
         <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com>
In-Reply-To: <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94f85383-c377-47c1-bfd3-08d73b37bfce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5272;
x-ms-traffictypediagnostic: CH2PR03MB5272:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <CH2PR03MB527260CD5E68E776EE737898F98F0@CH2PR03MB5272.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(366004)(51914003)(189003)(199004)(53754006)(76176011)(71200400001)(66066001)(2616005)(110136005)(6306002)(76116006)(6246003)(11346002)(64756008)(6486002)(66946007)(229853002)(66556008)(486006)(6436002)(66476007)(186003)(8936002)(36756003)(99286004)(6512007)(8676002)(81156014)(81166006)(118296001)(26005)(966005)(102836004)(25786009)(6506007)(66446008)(7736002)(476003)(446003)(305945005)(14454004)(478600001)(5660300002)(4326008)(3846002)(6116002)(2501003)(2906002)(316002)(86362001)(256004)(71190400001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5272;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IXPtzzYxgYKYabdDUASK15vtZBzz9TKBxMD3/AA0izosjThGhmMKRFI4fcimmLhRXPr2atViNSmtx2po8tKjfSpNwgcD1P8RRUbSL6TNXcjc2nAfdtTHumuyJ9N+f03xY4ibdqMQl+Nitt6KvruzD+JJMobV58BKOohjxHe7W77c5ZDPVKxRfZDkxGmArEuosTw2apxYrbt/xmo++5jADmfR4W28EEOGkJldKulBvt9YACvZi0gG6M7Vi1IK026H9VGH0SfdNawxYTQtdyHUcO3FAL7f/VlJVq9tUk9tOM8LuWi8rDl8r4ItdZ4A5LCfgRspXz+hwHFS7OFPnAz41PI3kDh04myznelOEdYiPVU8yH9F/yt7UsBchdhM8e30YHaJtbLX3Llchw/WqJbsSG41d5IKRqD8qckyTlJFbsY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33557CBB6F80B441A00BF2C6B987E844@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f85383-c377-47c1-bfd3-08d73b37bfce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 06:24:52.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3vBDHS/CCo5U/U2lIxa12Nwt6DSMhWYZfiAGjT8wEcUjg149oabLhO+c75PIciWAZYyRiPeuRcvcEJU9diJHC2oEcLnEbxHoC/TqQRFwDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_03:2019-09-11,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909170070
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDIwOjUwIC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IEhlbGxvIGV2ZXJ5Ym9keS4NCj4gDQo+IEkgYW0gc3RpbGwgbGVh
cm5pbmcgYWJvdXQga2VybmVsIGRldmVsb3BpbmcuIEkgd291bGQgbGlrZSB0byB0cnkgdG8NCj4g
ZGV2ZWxvcCBhIGRldmljZSBkcml2ZXIgZm9yIHRoZSBBRDc5MjggWzFdLCBmcm9tIEFuYWxvZyBE
ZXZpY2UuDQo+IA0KPiBDYW4gc29tZW9uZSBnaXZlIHNvbWUgd29yZHMgdG8gZ3VpZGUgbWU/DQo+
IA0KPiBJIHdhcyB0aGlua2luZyBhYm91dCBmb3JraW5nIHRoZSBhbmFsb2cga2VybmVsIHJlcG8g
WzJdIGJ1dCBJIGRvbid0DQo+IGtub3cgdG8gd2hpY2ggYnJhbmNoIHNob3VsZCBJIGNvbW1pdCB0
byB3aGVuIGRvaW5nIGEgcHVsbCByZXF1ZXN0LiBPcg0KPiBpZiB0aGlzIGlzIHRoZSBjb3JyZWN0
IHdheSBmb3IgdGhlIGRldmljZXMgZnJvbSBBbmFsb2cuDQo+IA0KDQpIZXksDQoNClRoYW5rcyBm
b3IgdGhlIGludGVyZXN0IGluIHdyaXRpbmcgdGhlIGRyaXZlciBmb3IgdGhpcy4NCg0KSW4gc29t
ZSBjYXNlcywgc29tZSBuZXcgcGFydHMgbWF5IGhhdmUgYW4gZXhpc3RpbmcgZHJpdmVyIGF2YWls
YWJsZSBhbHJlYWR5DQp0aGF0IGNhbiBiZSByZS11c2VkIHBhcnRpYWxseSBvciBjb21wbGV0ZWx5
Lg0KDQpZb3UncmUgaW4gbHVjay4NClRoZXJlIGlzIGRyaXZlciBzZWVtcyB0byBiZSBwYXJ0aWFs
bHkgaW1wbGVtZW50ZWQgdmlhIA0KZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQoNCkkndmUgZG9u
ZSBvbmx5IGEgbWlub3IvcXVpY2sgY2hlY2sgYnV0IHRoZSBjb250cm9sIHJlZ2lzdGVyIGJpdHMg
YXJlDQpjb21wYXRpYmxlIGZvciB0aGUgQUQ3OTI4IGFzIHdlbGwuDQoNClR5cGljYWxseSwgeW91
IGNhbiBleHRlbmQgdGhhdCBkcml2ZXIgYW5kIGFkZCB0aGUgbmV3IHBhcnRzIGFuZCB0ZXN0IHRo
ZW0uDQoNClNvLCBteSBzdWdnZXN0aW9uIHdvdWxkIGJlOg0KMS4gR2V0IGFuIGV2YWwtYm9hcmQg
b3IgYSBBRDc5MjggcGFydDsgZGVwZW5kaW5nIG9uIHRoZSBjYXNlIHdlIGNvdWxkIGhlbHANCndp
dGggdGhpcw0KMi4gVHJ5IHRvIHNldCBpdCB1cCB3aXRoIGEgUmFzcGJlcnJ5IFBpIHdpdGggdGhl
IGV2YWwgYm9hcmQNCiAgIGEuIGl0IGxvb2tzIHRvIG1lIHRoYXQgeW91IG5lZWQgYSA3Vi05ViBw
b3dlci1zdXBwbHkNCiAgIGIuIHlvdSBjYW4gaG9vayB0aGUgU1BJIHRvIHRoZSB0ZXN0LXBvaW50
cyBvbiB0aGUgZXZhbCBib2FyZA0KMy4gV3JpdGUgYSBiYXNpYyBkZXZpY2UtdHJlZSBvdmVybGF5
IDsgeW91IGNhbiBhZGFwdCBzb21ldGhpbmcgZnJvbSBvdGhlcg0KZXhhbXBsZXMuDQpMb29rIGhl
cmU6DQpodHRwczovL2dpdGh1Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9saW51eC9ibG9iL3JwaS00
LjE5LnkvYXJjaC9hcm0vYm9vdC9kdHMvb3ZlcmxheXMvTWFrZWZpbGUNClVzdWFsbHkgIHJwaS1h
ZFhYWC5kdHMgIGFyZSBBREkgcGFydHMuDQo0LiBFbmFibGUgdGhlIGRyaXZlciBmb3IgdGhlIGtl
cm5lbC4NCklmIHVzaW5nIHRoZSBBREkga2VybmVsLCB0aGVyZSdzIGEgZ3VpZGUgaGVyZSBmb3Ig
UlBpLg0KaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL3Rvb2xzLXNvZnR3YXJlL2xp
bnV4LWJ1aWxkL2dlbmVyaWMvcmFzcGJlcnJ5cGkNCkNoZWNrIHRoZSBicmFuY2ggdGhhdCBtYXRj
aGVzIHlvdXIgUmFzcGJpYW4gaW1hZ2UgKHJwaS00LjE5LnkgaXMgdGhlDQpsYXRlc3QpDQo1LiBC
dWlsZCB0aGUga2VybmVsDQo2LiBXcml0ZSBpdCB0byB0aGUgU0QtY2FyZCBpbWFnZQ0KNy4gVGVz
dA0KOC4gTW9kaWZ5ICYgcmVwZWF0DQoNClRoYW5rcw0KQWxleA0KDQo+IFsxXSBodHRwczovL3d3
dy5hbmFsb2cuY29tL2VuL3Byb2R1Y3RzL2FkNzkyOC5odG1sDQo+IFsyXSBodHRwczovL2dpdGh1
Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9saW51eA0KPiANCj4gRGFuaWVsIEp1bmhvDQo=
