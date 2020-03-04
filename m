Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1B178AA6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 07:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCDGft (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 01:35:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10764 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbgCDGft (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 01:35:49 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0246U8o0025658;
        Wed, 4 Mar 2020 01:35:31 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52a0wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 01:35:31 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0246ZUNd017235;
        Wed, 4 Mar 2020 01:35:30 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52a0wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 01:35:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4IC5HbO2hfz6q1kAw2A/00a1ofBCt5YiK9w3FZUQXEiq6ZI+f7lSVg3D4IRTj5fkQQnFYiA3gzn8H6MyDaQ3g5X77IZDLpeFzXJq5Hu4likkUXwWmr+yW/F79hnoB0WIzPGe/eQYwPDQB5MaiaMI5Z40QaNGbAogPPHZ8nNlNnV1NpauSwK/O1r7qcRWfc5mRSGSSvzmcAcIZy/DIg1d9fKt/NYzOmkGVHCmIHSYwXqRidbmg0AFUd90MDesLXP/GDfMEygf1QHDW+Q2cNZV6Ee6/rP7cU806JWP3VEfAOg2yw0sDnFqzaFCbiZm1AxAJZn/SduqkA9rBx4a0hIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGABZ9wflZW9RBMnSQfCWxA5KPsGuhYk+6oHuihVtew=;
 b=YeQ3u/7jB9FDNqxrt9OIUx7M7x5g5PrraON5Fr8wqXDY34asH731tfXeas5W5vb1uBMkm5GfNuKU4ZKiOGy0fABRMjml+B2fWxD2zw8drowC9hxOh5Nq4ZqjAJuyD5togL+MJZQr1k0Z13wnv6TeORfSG2bU06gSheOrYJtvAHFMHKYX9+AwRh5umd0NzSQ0Lh99IVLjk0uf7Kv2IfPyY0FuUejBJdIEScVAPeCpITOrgBphLBNVy/MqVBpnbI0wyDSBy9sAocO5aXV5sirU1Eu3dH4Xzk+S85ds5XsKZz2uz7Bu/iVdv/7TinlL7bYfTAza7P5+eEnuuqfP6JNfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGABZ9wflZW9RBMnSQfCWxA5KPsGuhYk+6oHuihVtew=;
 b=83HOrTPeq3HdpuLCuubLI8YXL7NR9aA/1eFIjrpZeyHT8/lsiL/ZmpxUf/ZW5fBD2Q0d599jMn1DfGNwkPUBq3QtigwEvw3e9LLUGrOkXB3TMsJLAkBNUFLAC7kEgFV4TCl2ORMXT0mGTgXUv8uaJNpCA4VYud+5lJzBBMMk7DI=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5288.namprd03.prod.outlook.com (2603:10b6:610:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 06:35:28 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 06:35:28 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio:ad7797: Use correct attribute_group
Thread-Topic: [PATCH -next] iio:ad7797: Use correct attribute_group
Thread-Index: AQHV8JcykIQvd1F1BESz2s3+VspUbqg3/d0A
Date:   Wed, 4 Mar 2020 06:35:28 +0000
Message-ID: <8d7a7062af94a3531dd519bd60fe26c8530c6a43.camel@analog.com>
References: <20200302133249.23152-1-yuehaibing@huawei.com>
In-Reply-To: <20200302133249.23152-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6ea24c1-d7c0-49c4-0360-08d7c0063ae6
x-ms-traffictypediagnostic: CH2PR03MB5288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5288A8ADF039AF13A2D74E54F9E50@CH2PR03MB5288.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(39860400002)(346002)(199004)(189003)(316002)(478600001)(8676002)(81156014)(8936002)(81166006)(86362001)(2616005)(36756003)(6512007)(26005)(110136005)(54906003)(66556008)(66446008)(2906002)(71200400001)(64756008)(4326008)(6486002)(66946007)(186003)(66476007)(76116006)(5660300002)(6506007)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5288;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HqxBpoES798/HV70j6bNv3ZQtd/4iDWF9JWkaVurTL41N5OGJXXhRU76oltTOwAoCeSaZWenVDbN3hJ71irc6cQszIG7AujGDgTKpBpCYrjHfA29Mj+VFLvQPrYzHTw4Ni20vrHfk/6loTCNa9cZXIuxu3hsjzTbHbuUXLpcw6HIgSL6Wo63SCB0gSCKunn9Ncm2FBcpNJ+KhcwUPfonuzWqSiH67Nt89xZSxoOr5NEgKyX784OcLyDgLUFWOrLmXlU/gSbgMtIgvZdm6SVYs38MCjhwOLKzfrFZptcwTv7rXGxYq8gLvw6MTjkdfwgHxGQAY2ZrTVZMckh9DzuHKWuw/ZWsjCYLqo/jM/hbfKFLw5/KcCOBHWO/q1wk0DqhxHFGi+3X8ubyDaRY8Di+sbZharjT0B7/YiCse0cP2yLFkis90am6AElwRE4qombh
x-ms-exchange-antispam-messagedata: /c2T0Q3P6FwzTWitRhNsBxjLdGRNHKyXLrVRE/XI6VCMjKNDlZz3COj3yvjDL4I5BQEfi/2TYVy8Z3lhvO4Z9QJ/GGYvG/nTBFlE9nqxjpiwTe10Pg8GNPFRxibEQXyn1YTKr0h5BgJD1ER8GPg9Gw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5CD79DF82943548B78547085A4DBD2C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ea24c1-d7c0-49c4-0360-08d7c0063ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 06:35:28.5957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+lfJ9dX5aJGlOoodgCoWIwuNQNGGxjLsEJiqW9kWS5YiQhMTUQ6oHI4BgGB2EF6Y6XvcOFp4fOrgiEhihYXqE4BzBIg1mIlMjxYeke43n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5288
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040049
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDIxOjMyICswODAwLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBJdCBzZWVtcyBhZDc3OTdfYXR0cmlidXRlX2dyb3VwIHNob3VsZCBi
ZSB1c2VkIGluIGFkNzc5N19pbmZvLA0KPiBhY2NvcmRpbmcgdG8gY29tbWl0ICgiaWlvOmFkNzc5
MzogQWRkIHN1cHBvcnQgZm9yIHRoZSBhZDc3OTYgYW5kIGFkNzc5NyIpLg0KDQpXaGlsZSB0aGUg
Y2hhbmdlIGxvb2tzIGdvb2QgYXQgZmlyc3QsIEkgYW0gdGhpbmtpbmcgdGhhdCB0aGlzIG1pZ2h0
IGludHJvZHVjZQ0KYW5vdGhlciBpc3N1ZSB3aGlsZSBmaXhpbmcgdGhpcyBvbmUuDQoNCkl0IGxv
b2tzIGxpa2UgdGhlIGFkNzc5N19hdHRyaWJ1dGVzW10gYXJyYXkgbWF5IGFsc28gcmVxdWlyZSB0
aGUNCiZpaW9fZGV2X2F0dHJfaW5fbV9pbl9zY2FsZV9hdmFpbGFibGUuZGV2X2F0dHIuYXR0ciBh
dHRyaWJ1dGUgYXMgd2VsbC4NCkl0IGxvb2tzIGxpa2UgdGhlIGF2YWlsYWJsZSBzY2FsZXMgc2hv
dWxkIGJlIHByaW50ZWQgZm9yIEFENzk5NyBhcyB3ZWxsLg0KDQpUaGF0IGJlaW5nIHNhaWQsIHRo
aXMgcGF0Y2ggaXMgZmluZSBhcy1pcy4NCkJ1dCBpdCB3b3VsZCByZXF1aXJlIGEgcGF0Y2ggW2Jl
Zm9yZS10aGlzLXBhdGNoXSB0byBmaXggdGhlIGFkNzc5N19hdHRyaWJ1dGVzDQphcnJheS4NCg0K
U29tZXRoaW5nIGxpa2UgdGhpczoNCg0Kc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmFkNzc5N19h
dHRyaWJ1dGVzW10gPSB7DQogICAgICAgICZpaW9fY29uc3RfYXR0cl9zYW1wbGluZ19mcmVxdWVu
Y3lfYXZhaWxhYmxlX2FkNzc5Ny5kZXZfYXR0ci5hdHRyLA0KKyAgICAgICAmaWlvX2Rldl9hdHRy
X2luX21faW5fc2NhbGVfYXZhaWxhYmxlLmRldl9hdHRyLmF0dHIsDQogICAgICAgTlVMTA0KfTsN
Cg0KSSdtIGhvcGluZyBJJ20gcmlnaHQgYWJvdXQgdGhpcyBvbmUuIEkgc29tZXRpbWVzIGRvbid0
IG5vdGljZSB0aGluZ3MgdG9vIHdlbGwuDQoNCj4gDQo+IEZpeGVzOiBmZDFhOGI5MTI4NDEgKCJp
aW86YWQ3NzkzOiBBZGQgc3VwcG9ydCBmb3IgdGhlIGFkNzc5NiBhbmQgYWQ3Nzk3IikNCj4gU2ln
bmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvaWlvL2FkYy9hZDc3OTMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2FkYy9hZDc3OTMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc3OTMuYw0KPiBpbmRleCBiNzQ3ZGI5
Li5lNTY5MWUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ3NzkzLmMNCj4gKysr
IGIvZHJpdmVycy9paW8vYWRjL2FkNzc5My5jDQo+IEBAIC01NDIsNyArNTQyLDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpaW9faW5mbyBhZDc3OTdfaW5mbyA9IHsNCj4gIAkucmVhZF9yYXcgPSAm
YWQ3NzkzX3JlYWRfcmF3LA0KPiAgCS53cml0ZV9yYXcgPSAmYWQ3NzkzX3dyaXRlX3JhdywNCj4g
IAkud3JpdGVfcmF3X2dldF9mbXQgPSAmYWQ3NzkzX3dyaXRlX3Jhd19nZXRfZm10LA0KPiAtCS5h
dHRycyA9ICZhZDc3OTNfYXR0cmlidXRlX2dyb3VwLA0KPiArCS5hdHRycyA9ICZhZDc3OTdfYXR0
cmlidXRlX2dyb3VwLA0KPiAgCS52YWxpZGF0ZV90cmlnZ2VyID0gYWRfc2RfdmFsaWRhdGVfdHJp
Z2dlciwNCj4gIH07DQo+ICANCg==
