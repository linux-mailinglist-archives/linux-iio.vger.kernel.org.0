Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A997A4CBE4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 12:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfFTKa7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 06:30:59 -0400
Received: from mail-eopbgr800051.outbound.protection.outlook.com ([40.107.80.51]:39583
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfFTKa7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 06:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt8V9YW9O0iBvJsOOt5IPG3CNgAUHEoIeeeZNrv13VQ=;
 b=behCThtoEc5L+jkLS/vapW6rST5GFt48ZqORv6vH8ILGkPiWjN9N09jt+wbZE/qrFPrCye8Ebz8CiP4fKQeiWi9Hu8cXwhRBO5KwJ7G+tX3atnZzk9IMT//9Ydnqp8nV90nu2Kej+C7YkHqZRcMi+hEhUcLia5JLxOGRv560SYk=
Received: from DM6PR03MB3658.namprd03.prod.outlook.com (20.176.85.151) by
 DM6PR03MB4172.namprd03.prod.outlook.com (20.176.121.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Thu, 20 Jun 2019 10:30:58 +0000
Received: from DM6PR03MB3658.namprd03.prod.outlook.com
 ([fe80::3d04:7ea3:14e6:de91]) by DM6PR03MB3658.namprd03.prod.outlook.com
 ([fe80::3d04:7ea3:14e6:de91%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 10:30:57 +0000
From:   "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: adc: ad7124: Remove input number limitation
Thread-Topic: [PATCH 1/4] iio: adc: ad7124: Remove input number limitation
Thread-Index: AQHVJ0lQ77pdw0fiUkSRz3sjfeNnS6akV+AA
Date:   Thu, 20 Jun 2019 10:30:57 +0000
Message-ID: <0183e4e49732e3de44fe9229c45764b307af8838.camel@analog.com>
References: <20190620091908.12041-1-mircea.caprioru@analog.com>
In-Reply-To: <20190620091908.12041-1-mircea.caprioru@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mircea.Caprioru@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bdb5eb1-e33d-4fae-5fac-08d6f56a620a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR03MB4172;
x-ms-traffictypediagnostic: DM6PR03MB4172:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-microsoft-antispam-prvs: <DM6PR03MB4172B48FDC4ED83E29D7632A81E40@DM6PR03MB4172.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(37524003)(68736007)(316002)(26005)(186003)(446003)(11346002)(305945005)(7736002)(102836004)(6246003)(256004)(476003)(2616005)(486006)(99286004)(478600001)(6116002)(3846002)(54906003)(53936002)(6506007)(76176011)(66066001)(2906002)(2351001)(6436002)(25786009)(8936002)(118296001)(4326008)(91956017)(76116006)(73956011)(66446008)(66946007)(64756008)(66476007)(66556008)(6486002)(71200400001)(72206003)(14454004)(86362001)(36756003)(5660300002)(81156014)(2501003)(8676002)(6512007)(229853002)(5640700003)(71190400001)(81166006)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4172;H:DM6PR03MB3658.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3mEPjUtJtzHb1VYyVlyrJ6BLhxz/Ht/FKqJYKhyRdJ9anT3Zw+yXCuOPuF/MUYQwD/EiWmasVO0QaMkohA7ARYP4vo2nHp+1QecumZsdMBr7jwdAKKJ12DJsBKS+OFZpjMhuAXSJJxjgSc5Puy6cnJIj4OKhjRmRFIFVTvSaBDO1Z3J5Zam84ZrwaboyNvqo6i9j6dkDGb3WCoomQuKYKJsMrycg65PPVx9abv6BV7NPOd344/TBFeOs5+z2C907ONBhjk/H5lpczVpW8IoF8jY3BVFGcypLvgSP3VK86O+1UZtNTKIfMZiahGhSkOqnQC+z9lXyseSuy0EhAZcMgHfoWGJpe7Ro+9e9uFBpsDJHWpi0nMN1QSXyn2G6kqfLeQgWY3mSGiEa23x6aXtVdKqmKnBc3pU0cjw/N+Mhxsc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D4D1A5E822D3D4B8CADB6EEC2AC50E6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb5eb1-e33d-4fae-5fac-08d6f56a620a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 10:30:57.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mircea.Caprioru@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4172
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA2LTIwIGF0IDEyOjE5ICswMzAwLCBNaXJjZWEgQ2FwcmlvcnUgd3JvdGU6
DQo+IFRoZSBkcml2ZXIgbGltaXRzIHRoZSB1c2VyIHRvIHVzZSBvbmx5IDQvOCBkaWZmZXJlbnRp
YWwgaW5wdXRzLCBidXQNCj4gdGhpcw0KPiBkZXZpY2UgaGFzIHRoZSBvcHRpb24gdG8gdXNlIHBz
ZXVkby1kaWZmZXJlbnRpYWwgY2hhbm5lbHMuIFRoaXMgd2lsbA0KPiBpbmNyZWFzZSB0aGUgbnVt
YmVyIG9mIGNoYW5uZWxzIHRvIGJlIGVxdWFsIHdpdGggdGhlIG51bWJlciBvZiBpbnB1dHMNCj4g
c28gOA0KPiBjaGFubmVscyBmb3IgYWQ3MTI0LTQgYW5kIDE2IGZvciBhZDcxMjQtOC4NCj4gDQo+
IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgY2hlY2sgYmV0d2VlbiBjaGFubmVsIG5vZGVzIGFuZCBu
dW1faW5wdXRzDQo+IHZhbHVlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlyY2VhIENhcHJpb3J1
IDxtaXJjZWEuY2FwcmlvcnVAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMv
YWQ3MTI0LmMgfCA3IC0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDcxMjQuYyBiL2RyaXZlcnMvaWlv
L2FkYy9hZDcxMjQuYw0KPiBpbmRleCA2NTllZjM3ZDVmZTguLjgxMDIzNGRiOWMwZCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzEyNC5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2Fk
Yy9hZDcxMjQuYw0KPiBAQCAtNDYyLDEzICs0NjIsNiBAQCBzdGF0aWMgaW50IGFkNzEyNF9vZl9w
YXJzZV9jaGFubmVsX2NvbmZpZyhzdHJ1Y3QNCj4gaWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgCQlp
ZiAocmV0KQ0KPiAgCQkJZ290byBlcnI7DQo+ICANCj4gLQkJaWYgKGFpblswXSA+PSBzdC0+Y2hp
cF9pbmZvLT5udW1faW5wdXRzIHx8DQo+IC0JCSAgICBhaW5bMV0gPj0gc3QtPmNoaXBfaW5mby0+
bnVtX2lucHV0cykgew0KPiAtCQkJZGV2X2VycihpbmRpb19kZXYtPmRldi5wYXJlbnQsDQo+IC0J
CQkJIklucHV0IHBpbiBudW1iZXIgb3V0IG9mIHJhbmdlLlxuIik7DQo+IC0JCQlyZXQgPSAtRUlO
VkFMOw0KPiAtCQkJZ290byBlcnI7DQo+IC0JCX0NCj4gIAkJc3QtPmNoYW5uZWxfY29uZmlnW2No
YW5uZWxdLmFpbiA9DQo+IEFENzEyNF9DSEFOTkVMX0FJTlAoYWluWzBdKSB8DQo+ICAJCQkJCQkg
IEFENzEyNF9DSEFOTkVMX0FJTk0oYQ0KPiBpblsxXSk7DQo+ICAJCXN0LT5jaGFubmVsX2NvbmZp
Z1tjaGFubmVsXS5iaXBvbGFyID0NCg0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoIHNlcmllLCBq
dXN0IGRpZCBhIFJFU0VORC4NCg0KVGhhbmtzLA0KTWlyY2VhDQo=
