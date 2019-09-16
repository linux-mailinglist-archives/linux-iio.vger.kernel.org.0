Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A82B35F5
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfIPHwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:52:09 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54008 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbfIPHwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:52:09 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G7m4a6014212;
        Mon, 16 Sep 2019 03:51:34 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0vu6b7x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 03:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzwZoUTln/CO2eyBHPl4bo5WHiaS6+o/Liy9YqvTJ/n7/hSGiRWqISEjdV/iUkPF8+pYVFCN3a6u6rOKWxP3KV+95rCJ0MX5ne/20K2xOXxK+Q8b1FmH2agDtT4YKxPVXVj5Cb6U94veeW9P7awUp6xJ7/ZVJB5j4LC7yCNOrJnqo3CvLSG+MeGYqsQTHD5qGPXzGTNOhCp2qu3EfRuKKfnUxOpR+sYqFsTLZ7Uvn/nUCdYEMbTRC0safKZgSj3hPz4McOqMYoaVMYF3gtb9HjWYIyKvk58XqtdIjP0HicWwOq5RPSChCQF1SP38NFPM2tktXk/k12Pngp/FmKM0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZO4VVWqmGjdjRu/ZvnzNL99cZWR9trKZLqaA1Vf5X8=;
 b=Oj/x2Y0hsVXpe9qZ3gIuXTJcSPpCxgJLiG9NkG7iVjTDdd2gcaCZYb71i25WJ6H7GM8hlJRdWE6fwXF3B9SOs2pIpDFulI33psXHFxLk7hNexEhGGcxBeP/Xw5kRHKGUll40Voxg8iQp8fvfFWlXvBHmG7yZRpnJI43yHy9rsEK1WxvhrcpxfsJzRHU+Kx73YmMhaC8HIv9ZEtdOlI5LBDv6R50+fk6EUwUWfZ42xnhMncSbNHcC00gghVa7ZsSrHK1zXAKI4NI/cRbHIowT7nWSbwsEfiZYi5XH27uKZnbxGj45VZR9lWcFJtoezihKm5O1OJpvfZN2qM0dB+f/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZO4VVWqmGjdjRu/ZvnzNL99cZWR9trKZLqaA1Vf5X8=;
 b=dnV0n4ondyoOjC2PrwsOEASpA1O8Ja6jTs8w40NpnJ0QvrHoPqnRIY+BdqJ1hrXncMrWYE6WK9kXgdt0qx0AYU/dM0ZnL4bwJ6vFLHGjvhfOxkXwVx77nASp8KEjybkSh8dnbrCvQLOy2FMkDIXFNb3lpDIt/P9YJdzZL32IP5o=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5287.namprd03.prod.outlook.com (20.180.4.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Mon, 16 Sep 2019 07:51:30 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 07:51:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>
CC:     "antoine.couret@essensium.com" <antoine.couret@essensium.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Thread-Topic: [PATCH 2/4] iio: ad7949: fix incorrect SPI xfer len
Thread-Index: AQHVaXh7nFtQMJGG0EuSl7ibaCkViqcpXS6A///hgQCAA1EbAIABZF2A
Date:   Mon, 16 Sep 2019 07:51:30 +0000
Message-ID: <961ddc8a028cb683ba6706e2f8a23fbd7bf68651.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <20190912144310.7458-3-andrea.merello@gmail.com>
         <3fe869be01ce7c81fd463158c05e0a4a115bdd6a.camel@analog.com>
         <CAN8YU5MpLDVEfVBUBe9XsuYT6yohruiHAMQgOVjZs-2JyO=NNQ@mail.gmail.com>
         <20190915113600.26fe4987@archlinux>
In-Reply-To: <20190915113600.26fe4987@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eeca0ef-5fc9-4919-79a5-08d73a7aafc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5287;
x-ms-traffictypediagnostic: CH2PR03MB5287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5287250E61072114086D6EF1F98C0@CH2PR03MB5287.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(376002)(39860400002)(43544003)(189003)(199004)(25786009)(476003)(53936002)(6512007)(118296001)(36756003)(11346002)(446003)(2616005)(54906003)(81166006)(66556008)(64756008)(66446008)(66476007)(81156014)(5660300002)(6246003)(4326008)(8936002)(561944003)(6436002)(99286004)(6486002)(186003)(7736002)(305945005)(26005)(86362001)(478600001)(229853002)(76176011)(110136005)(6506007)(76116006)(102836004)(14454004)(316002)(3846002)(71190400001)(71200400001)(6116002)(486006)(66946007)(2501003)(2906002)(66066001)(14444005)(8676002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5287;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vfPcry3mIbzdRltWqiC01oJ67hO7fXXNyW1Bzrm8VQeWCIPQdXhN7+aot9eTz6NpwkXHpRChsxS7NIkmoUsAh7Qzc6FHx2stL35pDnyMXrCejcXklJci+f1vWURPeSO7AjbR93d5S+GxFOM7i+1OUV9+V/MytXbb9shL3cJf3Cdoa3OThccWo8nXA8PVOlq9/R9dagJgPUcbpcG4cuXPrlYVUg5YlmQdIxZLKRh7ZjL1o9BTlq0nW+qd8Z71OVJfj6KM6qpiqLLVzntR0qLOrB5EZKGN5+iIOCy1ryhokRaU2HtqfnnlBub5FD9SVMx+zH12UzbEc8PhWKUwyS1JR+ovNG9n0Kz2KGMCbtsnRcdqJGCOMYcoyleP7cQVTEG+HQa0Oq6bT6gdoCN1ypYJLKeZNepWsFRdfDcE4/LHKyg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A18A55D971872745A0DEFEB8BF88EA62@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeca0ef-5fc9-4919-79a5-08d73a7aafc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 07:51:30.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQw7nyaNM87LG9IlXbru8lspYOaSWM8WwacxgYNk06S4u2MKrSp6LTK0W1/ZHVDWrgpRnQnzlVwqqv1Wth8Abanqa0rgL+7Edkqo1q9XsAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_04:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTA5LTE1IGF0IDExOjM2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDEzIFNlcCAyMDE5IDA5OjU2OjU2ICswMjAwDQo+IEFuZHJlYSBNZXJlbGxv
IDxhbmRyZWEubWVyZWxsb0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gPiBJbCBnaW9ybm8gdmVu
IDEzIHNldCAyMDE5IGFsbGUgb3JlIDA4OjQ2IEFyZGVsZWFuLCBBbGV4YW5kcnUNCj4gPiA8YWxl
eGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IGhhIHNjcml0dG86DQo+ID4gPiBPbiBUaHUsIDIw
MTktMDktMTIgYXQgMTY6NDMgKzAyMDAsIEFuZHJlYSBNZXJlbGxvIHdyb3RlOiAgDQo+ID4gPiA+
IFtFeHRlcm5hbF0NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgZHJpdmVyIHN1cHBvcnRzIDE0LWJp
dHMgYW5kIDE2LWJpdHMgZGV2aWNlcy4gQWxsIG9mIHRoZW0gaGF2ZSBhIDE0LWJpdA0KPiA+ID4g
PiBjb25maWd1cmF0aW9uIHJlZ2lzdGVycy4gQWxsIFNQSSB0cmFzZmVycywgZm9yIHJlYWRpbmcg
QUQgY29udmVyc2lvbg0KPiA+ID4gPiByZXN1bHRzIGFuZCBmb3Igd3JpdGluZyB0aGUgY29uZmln
dXJhdGlvbiByZWdpc3RlciwgZml0IGluIHR3byBieXRlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRo
ZSBkcml2ZXIgYWx3YXlzIHVzZXMgNC1ieXRlcyB4ZmVycyB3aGljaCBzZWVtcyBhdCBsZWFzdCBw
b2ludGxlc3MgKG1heWJlDQo+ID4gPiA+IGV2ZW4gaGFybWZ1bCkuIFRoaXMgcGF0Y2ggdHJpbXMg
dGhlIFNQSSB4ZmVyIGxlbiBhbmQgdGhlIGJ1ZmZlciBzaXplIHRvDQo+ID4gPiA+IHR3byBieXRl
cy4NCj4gPiA+ID4gIA0KPiA+ID4gDQo+ID4gPiBUaGUgbGVuZ3RoIHJlZHVjdGlvbiBwcm9wb3Nh
bCBpcyBmaW5lLg0KPiA+ID4gDQo+ID4gPiBCdXQsIHRoaXMgcGF0Y2ggcmFpc2VzIGEgcXVlc3Rp
b24gYWJvdXQgZW5kaWFuZXNzLg0KPiA+ID4gSSdtIGFjdHVhbGx5IHdvbmRlcmluZyBoZXJlIGlm
IHdlIG5lZWQgdG8gc2VlIGFib3V0IG1heWJlIHVzaW5nIGEgX19iZTE2IHZzIHUxNi4NCj4gPiA+
IA0KPiA+ID4gSSdtIG5vdCB0aGF0IGtlcm5lbC1zYXZ5IHlldCBhYm91dCBzb21lIG9mIHRoZXNl
IGxvdy1sZXZlbCB0aGluZ3MgdG8gYmUgY29tcGxldGVseSBzdXJlIGhlcmUuDQo+ID4gPiBTbywg
SSdkIGxldCBzb21lb25lIGVsc2UgbWF5YmUgaGFuZGxlIGl0LiAgDQo+ID4gDQo+ID4gR29vZCBw
b2ludC4uIEl0IHNlZW1zIHRoYXQgaW5kZWVkIG5vdCBtdWNoIGNhcmUgaGFzIGJlZW4gdGFrZW4g
YWJvdXQNCj4gPiBlbmRpYW5lc3MgaGVyZS4uIFByb2JhYmx5IHdlIG5lZWQgYWxzbyBzb21lIGxl
MTZfdG9fY3B1KCkgYW5kDQo+ID4gZmlyZW5kcy4uDQo+IA0KPiBNb3JlIGNvbXBsZXhpdHkgaGVy
ZSA6KSAgU28gYSBsb3Qgb2YgZWFybGllciBTUEkgZHJpdmVycyBkaWRuJ3Qgc2V0IGJpdHNfcGVy
X3dvcmQsDQo+IHRoZSByZXN1bHQgb2YgdGhpcyBpcyB0aGF0IGEgcmVhZCBoYWQgbm8gd2F5IHRv
IGtub3cgaG93IHRvIHVud2luZCB0aGUgZW5kaWFuDQo+IG5hdHVyZSBvZiB0aGUgZGF0YS4gIElm
IHlvdSBkbyBhIDQgYnl0ZSByZWFkLCBpcyB0aGF0IDR4IDEgYnl0ZSwgMnggMiBieXRlcyBvcg0K
PiAxeCA0IGJ5dGVzLiAgVGh1cyB0aGUgU1BJIHN1YnN5c3RlbSBoYWQgbm8gd2F5IG9mIGtub3dp
bmcgaG93IHRvIGNvbnZlcnQgZnJvbQ0KPiB3aXJlIG9yZGVyIG9mIGJpZyBlbmRpYW4gdG8gY3B1
IGVuZGlhbm5lc3MuICBUaGlzIGlzIHBhcnRpY3VsYXJseSBmdW4gYXMgaXQNCj4gaXMgY29tbW9u
IHRvIGhhdmUgdmFyaWFibGUgbGVuZ3RoIHJlZ2lzdGVycyBvbiBTUEkgZGV2aWNlcyAoYmUgaXQg
ZGVzY3JpYmVkDQo+IG9uIHRoZSBkYXRhc2hlZXQgYXMgc29tZSByZWdpc3RlcnMgaGF2ZSBoaWdo
IGFuZCBsb3cgYnl0ZSBhZGRyZXNzZXMpLg0KPiANCj4gSW4gZHJpdmVycyB3aGVyZSB0aGlzIGNh
biBiZSBzZXQgdG8gb25lIGNvbnNpc3RlbnQgdmFsdWUsIHRoZW4gdGhlIFNQSSBzdWJzeXN0ZW0N
Cj4gc2hvdWxkIGRvIHRoZSB3b3JrIGZvciB1cy4gSGVuY2UgdGhpcyBvbmUgc2hvdWxkIGJlIGZp
bmUuICggSSB0aGluayA6KQ0KPiANCg0KQmFzZWQgb24gb3RoZXIgaW5wdXQ6DQoNClJldmlld2Vk
LWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0K
DQo+ID4gTWF5YmUgYW5vdGhlciBzZXBhcmF0ZSBwYXRjaCBjYW4gYmUgbWFkZSB0byB0YWtlIGNh
cmUgYWJvdXQgZW5kaWFuZXNzIGxhdGVyIG9uPw0KPiA+IA0KPiA+IEJUVyBBbHNvLCB0aGUgIF9f
X19jYWNoZWxpbmVfYWxpZ25lZCBpcyBhIGJpdCBzY2FyaW5nIDopIEkgZG9uJ3Qga25vdw0KPiA+
IHdoYXQgaXMgdGhhdCBmb3IuLi4NCj4gPiANCj4gPiA+IFRoYW5rcw0KPiA+ID4gQWxleA0KPiA+
ID4gIA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgTWVyZWxsbyA8YW5kcmVhLm1lcmVs
bG9AZ21haWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvaWlvL2FkYy9hZDc5
NDkuYyB8IDYgKysrLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2FkYy9hZDc5NDkuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDkuYw0KPiA+ID4gPiBpbmRl
eCA1MTgwNDRjMzFhNzMuLjVjMmIzNDQ2ZmE0YSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9paW8vYWRjL2FkNzk0OS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDku
Yw0KPiA+ID4gPiBAQCAtNTQsNyArNTQsNyBAQCBzdHJ1Y3QgYWQ3OTQ5X2FkY19jaGlwIHsNCj4g
PiA+ID4gICAgICAgdTggcmVzb2x1dGlvbjsNCj4gPiA+ID4gICAgICAgdTE2IGNmZzsNCj4gPiA+
ID4gICAgICAgdW5zaWduZWQgaW50IGN1cnJlbnRfY2hhbm5lbDsNCj4gPiA+ID4gLSAgICAgdTMy
IGJ1ZmZlciBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ID4gPiA+ICsgICAgIHUxNiBidWZmZXIg
X19fX2NhY2hlbGluZV9hbGlnbmVkOw0KPiA+ID4gPiAgfTsNCj4gPiA+ID4gDQo+ID4gPiA+ICBz
dGF0aWMgaW50IGFkNzk0OV9zcGlfd3JpdGVfY2ZnKHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAgKmFk
Nzk0OV9hZGMsIHUxNiB2YWwsDQo+ID4gPiA+IEBAIC02Nyw3ICs2Nyw3IEBAIHN0YXRpYyBpbnQg
YWQ3OTQ5X3NwaV93cml0ZV9jZmcoc3RydWN0IGFkNzk0OV9hZGNfY2hpcCAqYWQ3OTQ5X2FkYywg
dTE2IHZhbCwNCj4gPiA+ID4gICAgICAgc3RydWN0IHNwaV90cmFuc2ZlciB0eFtdID0gew0KPiA+
ID4gPiAgICAgICAgICAgICAgIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIC50eF9i
dWYgPSAmYWQ3OTQ5X2FkYy0+YnVmZmVyLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAg
LmxlbiA9IDQsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAubGVuID0gMiwNCj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgIC5iaXRzX3Blcl93b3JkID0gYml0c19wZXJfd29yZCwN
Cj4gPiA+ID4gICAgICAgICAgICAgICB9LA0KPiA+ID4gPiAgICAgICB9Ow0KPiA+ID4gPiBAQCAt
OTUsNyArOTUsNyBAQCBzdGF0aWMgaW50IGFkNzk0OV9zcGlfcmVhZF9jaGFubmVsKHN0cnVjdCBh
ZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMsIGludCAqdmFsLA0KPiA+ID4gPiAgICAgICBzdHJ1
Y3Qgc3BpX3RyYW5zZmVyIHR4W10gPSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgew0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgLnJ4X2J1ZiA9ICZhZDc5NDlfYWRjLT5idWZmZXIsDQo+
ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAubGVuID0gNCwNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIC5sZW4gPSAyLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgLmJp
dHNfcGVyX3dvcmQgPSBiaXRzX3Blcl93b3JkLA0KPiA+ID4gPiAgICAgICAgICAgICAgIH0sDQo+
ID4gPiA+ICAgICAgIH07ICANCg==
