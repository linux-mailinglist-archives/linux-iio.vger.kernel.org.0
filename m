Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63EAEE372
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDPRv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:17:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27464 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfKDPRu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:17:50 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FAARc010795;
        Mon, 4 Nov 2019 10:17:49 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:17:48 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4FHm1A016314;
        Mon, 4 Nov 2019 10:17:48 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2059.outbound.protection.outlook.com [104.47.40.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rhk97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 10:17:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvTUkZnVsQSD5jzWamN3oB+8rZ5x5MoQQkFzTubwhZZmNYtQjoMNKTTL3rfdTZeEulzOO4Vn1OcetvvmVRYEbW4c6YupMeLE6cRH2ib91FSOfpjxeY+ZJHNNK8nDQpDbwLzHi3+SDyJTVseEtpKEIY/OwbF4gBVkesOOz37l0UoH7VL8NgSpAZYVesqraoLcOfKozZl/JpMiCL3xcRkrENDo+AivuYlF6+PBoXjCjb8vQFhc9tG2jMgGFIMoVQZsGdO8RJgBsCWsguF5YUhUJ1487mwG0LJWAa77ckmNtI/KdZdP5diIfa/m/4FM87UwC69UiNXe5lYFwQfW1BeYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzX6U71Wt4OEDDlIPV0sGimVhVaoy5vIJjf+sVqnczM=;
 b=NNJuxzRaezgHMU9uJ6tPmwWBjfEz/pSOwnUz2eBpmShogupZHZhtl9XgA2PUEaIE2TlVyY2FAFOJStwiCO+2kL/oX5cVb0ZlFExw24xX50ssE38tS2SAAt5TVZdQXl18UN+HTFrGDGcZgbNXMNj5RuG5qgFlg8xyKU9afXA7OCR21Pe+L5ZGRdvQoYwE6I70WvXYg9X8Cf4xOjBz8BEwilLLdKl9+FZKh8WOt0ag2mGzZvvC1G0YywC4m1NRswPhFyCzDl5bQjFcVUI86jG/BTt3DC9ktnXvEgFiVtBLfS1lMO0JDZ8DJiLzD9grQBj8350ccypQd4gNV798Eh+s6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzX6U71Wt4OEDDlIPV0sGimVhVaoy5vIJjf+sVqnczM=;
 b=gdOZhmx4kdlZ2BZqj52pbJVObwt1FR1zjHL4zQI1WNQPvCpukSyg7x8rlXkGK8fiPYbQG5gTsLcL1OG9zG5+cVyJ1episFIbQnoOMrzwI8DaPpqa2J+nQTKa8DWlOwiFcrGP0JM3M1JT+471LTHdTioDbhKGZMipHJShOJ8yE3U=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5224.namprd03.prod.outlook.com (20.180.13.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:17:47 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:17:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: spear_adc: Use devm_platform_ioremap_resource
Thread-Topic: [PATCH] iio: adc: spear_adc: Use devm_platform_ioremap_resource
Thread-Index: AQHVgd6NHkt1MEzViE6eoCR/dIp34Kd7QkgA
Date:   Mon, 4 Nov 2019 15:17:47 +0000
Message-ID: <5069830d6f6b8ed3794efdd21c76afdf0f0d5072.camel@analog.com>
References: <20191013155239.1868818-1-jic23@kernel.org>
In-Reply-To: <20191013155239.1868818-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb309a5d-742e-450a-1a97-08d7613a2631
x-ms-traffictypediagnostic: CH2PR03MB5224:
x-microsoft-antispam-prvs: <CH2PR03MB5224C17FFC6267C23794108CF97F0@CH2PR03MB5224.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(3846002)(76116006)(66476007)(66556008)(66446008)(66946007)(256004)(2906002)(64756008)(99286004)(26005)(6506007)(102836004)(305945005)(2616005)(2501003)(14444005)(316002)(76176011)(446003)(11346002)(118296001)(110136005)(36756003)(71200400001)(71190400001)(86362001)(478600001)(14454004)(6512007)(186003)(229853002)(6486002)(7736002)(486006)(476003)(4326008)(5660300002)(25786009)(8676002)(8936002)(81156014)(81166006)(6436002)(66066001)(6246003)(4001150100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5224;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSVSboatOegfO57j3ur6/+n9dCRrZCO2pFtP2eLyNqT8wiXEMqNJMXHC/07tPnqOk+7QLILMqCp4eEGkgq3N5u/H43WSY2ILStxn8qMnAvs0HBBEJ4aKrNobHPLRizJfsNbUZqSpM/pMqssxxgjVxQSTCUCPaz256DqjjxcvCBPXKd6aB+HCBhuzs2pK7j6gafTB+SKXvJymZ1OIl2jmMdmdaLLfzyveIOHLty1YQLaycdsst6HDZBiS0c9zxyDUtzRf3y4nvd+5HmXHVhIZd1KKU4VBqrqgpB2/dEroNKOMNVtDrP4cnyW9RUqkgu9K2gLVSR+yg+sX6USqzh8NeDYmQzCuUHoWAJ1+vddz99/oYS52H1H+XoE7xK/Rv6d1h0Oh5dy7+MaLtGWo00NU6zUtftz9NDX7T17ezTg17+bQds17PyWi3/OAxXmc+kcJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D907278EC7EC64C8B9029455C290697@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb309a5d-742e-450a-1a97-08d7613a2631
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:17:47.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Prr/brlnbM3itVZDzyaGmtrC2GX3RfpegP4Aofm89e7cH9/c9cEKOxC1Mffv3E33IxbEmu2+a/AHu/ha3Ctjnp5NcjVmBBvXftaiaBerZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTEzIGF0IDE2OjUyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBBdm9pZHMgbG9jYWwgYm9pbGVycGxhdGUgZG9pbmcgdGhlIHNhbWUgdGhpbmcuDQo+
IFN1Z2dlc3RlZCBieSBjb2NjaW5lbGxlDQo+IA0KPiBDSEVDSyAgIGRyaXZlcnMvaWlvL2FkYy9z
cGVhcl9hZGMuYw0KPiBkcml2ZXJzL2lpby9hZGMvc3BlYXJfYWRjLmM6MjgzOjEtMjI6IFdBUk5J
Tkc6IFVzZQ0KPiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UgZm9yIHN0IC0+IGFkY19i
YXNlX3NwZWFyNnh4DQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4
YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBD
YW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9p
aW8vYWRjL3NwZWFyX2FkYy5jIHwgNCArLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L3NwZWFyX2FkYy5jIGIvZHJpdmVycy9paW8vYWRjL3NwZWFyX2FkYy5jDQo+IGluZGV4IDU5MmI5
N2M0NjRkYS4uMGFkNTM2NDk0ZThmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvc3Bl
YXJfYWRjLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL3NwZWFyX2FkYy5jDQo+IEBAIC0yNjAs
NyArMjYwLDYgQEAgc3RhdGljIGludCBzcGVhcl9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9m
X25vZGU7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gIAlzdHJ1Y3Qg
c3BlYXJfYWRjX3N0YXRlICpzdDsNCj4gLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gIAlzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gTlVMTDsNCj4gIAlpbnQgcmV0ID0gLUVOT0RFVjsNCj4g
IAlpbnQgaXJxOw0KPiBAQCAtMjc5LDggKzI3OCw3IEBAIHN0YXRpYyBpbnQgc3BlYXJfYWRjX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJICogKGUuZy4gU1BFQXIz
eHgpLiBMZXQncyBwcm92aWRlIHR3byByZWdpc3RlciBiYXNlIGFkZHJlc3Nlcw0KPiAgCSAqIHRv
IHN1cHBvcnQgbXVsdGktYXJjaCBrZXJuZWxzLg0KPiAgCSAqLw0KPiAtCXJlcyA9IHBsYXRmb3Jt
X2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+IC0Jc3QtPmFkY19iYXNl
X3NwZWFyNnh4ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ICsJ
c3QtPmFkY19iYXNlX3NwZWFyNnh4ID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBk
ZXYsIDApOw0KPiAgCWlmIChJU19FUlIoc3QtPmFkY19iYXNlX3NwZWFyNnh4KSkNCj4gIAkJcmV0
dXJuIFBUUl9FUlIoc3QtPmFkY19iYXNlX3NwZWFyNnh4KTsNCj4gIA0K
