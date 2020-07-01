Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D6210D1C
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgGAOH3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 10:07:29 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:50142 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbgGAOH2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jul 2020 10:07:28 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E4VVl030375;
        Wed, 1 Jul 2020 10:07:07 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-00128a01.pphosted.com with ESMTP id 31x2r74c68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 10:07:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1VMH+Azvoa7KISfFcmoas/4ffQh5+iN6+9+Fiab9db8X2AvyYAn/WAC4edHjk/y4hmbTyO0ybtM3r6I0KzJxuQGOMtW0Wb4PJP+ILaa3qpmZ9T+0WNHPVQ7JK9nVpmCq2p/01hiCsjKnXGQZurOlT36i3thRnKWGZpHo1/duh2vyqVhnHIOYifHYWBYOZFsihfomOKv84k6iaTf4dsMWWg8mzCAKOEZh1Im4Zw1/ro+ciIp7xH1IBTE5qdyMx7fRUbnMkjGRulGRAjglmzPiTj8Gm1aoO7/olDyCIt6qrDvf3cdicRRr4Z37R2FAcmgLo1Lk+n3ibPF6JZcFPjG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv9Ksp5fZKHzo2ckr8vRc+H/YVfoh9vFoIRLu/OjZ+0=;
 b=cTc8MYs3NolOED2hHFBDwmrKmjBtTDB/j8vXtQz0rCXrRxqzLMz5B2wOk6d4BduYwFIA6iPtnVDurOsZmQwYLWpGmVI/CgepoR+epOUOJrnEpvsVO5LWsHcaNMemhZ6ZcHYr8qb0B6kGTg3l1FmOXNaycGhyufBY5uwg2AyvvSfSQVq4N/h1iks5JQujzNGl5nMFhOTTR68wWfBsKa6xCBoD9uX7w8lGQ9lKFUmPVxpUeXqHSLX0cZQZl06eAkfwHQ3IRf4ZEiW0tDQiwk5m9Antt0oF8vcMsYBIyMlA1GndHrRJ2gaf1CNnwPt+/rIwIJpBl5hWQp5LnqZJzO9M/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv9Ksp5fZKHzo2ckr8vRc+H/YVfoh9vFoIRLu/OjZ+0=;
 b=F0I/Ju3xonCYOnWx4vPASXUHHxlEa2ts3zKzylJ78Gf1P3o6M48yOxu1UQ8pKdZgB2Pk5GBQUbZFLMrKEwefYq8OFQr2/P6/WiwTVMYF+gyc9kAoCS4wjOY9haM6eIRrCe18yqZNE8GkKAuLZ8jJ+n2XshNRb40OsyWzkob9p5E=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5002.namprd03.prod.outlook.com (2603:10b6:5:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 14:07:06 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 14:07:05 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 1/2] iio: adc: adi-axi-adc: Fix object reference counting
Thread-Topic: [PATCH 1/2] iio: adc: adi-axi-adc: Fix object reference counting
Thread-Index: AQHWT5/hfL7cA94OPUezn1vw8YehE6jywosA
Date:   Wed, 1 Jul 2020 14:07:05 +0000
Message-ID: <8f297dda580043fc5a9c5bae53139c8aa74dd666.camel@analog.com>
References: <20200701120442.258-1-nuno.sa@analog.com>
In-Reply-To: <20200701120442.258-1-nuno.sa@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 624e2133-7e97-421f-09b5-08d81dc8094f
x-ms-traffictypediagnostic: DM6PR03MB5002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB50028E8965AF8FB9808D8E52F96C0@DM6PR03MB5002.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eC3XYA73CfZbZHLn7HGX+1rvXm0HeEw7hGghGhF8qyL7ZMln3NnmYR00m+IW2fqWeTYDn1SkKiVTK143j9jVSyuDZ9TAvPA1cbn5XgwxstzcOsPcDymaGJwC6w+piKyFnu3LrI6b7Gl+W0r7sygWLgNALLSe3BTuQb6APEM86D5dCzPRtQzDK0vJnnglPtqPlmz7ngOSBI7J4GZiFWsDzEh+QjW+S4egA9CZRHyvRpk/oEzscHo5X9qYqTuG0tCGVYVW3l4Y/hOLEr+HhfbGu1bWGdAGPkq6f8OwDHy1UkPmlT4eiKfyk9nko54pj5KLda8D8JPbo+6YO5UfWXUZgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(54906003)(26005)(2906002)(36756003)(86362001)(2616005)(5660300002)(110136005)(316002)(4326008)(91956017)(83380400001)(6486002)(8676002)(186003)(66946007)(66446008)(64756008)(66556008)(66476007)(6512007)(8936002)(76116006)(478600001)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UaDFSDbMxErsWn7w32n7diql0QAoLFhK3fjTS+WPAhRvI4V27JCvQ7c6wIWxzd5/ZZE5hgM3+uHGJZ9xSIJqVDhWOCpwCJTX1sDSO/M7jdlTpfgHJWbufdK8z+uk2yRW84DS96iwX6gVM2CU3qZzvehDve0i6gfCDWPsHHiLyo+h5J7LTUMOXpsuTP0lU63cncBFfOdZuKQ5ZCZ4rkQSBJR2f/31kjfYucWKOTikbPqzWBs1sbOIbKwTr5r0xPR9fERlKunmk/j2EfR5vcyGGMPTTezngRxpLjTNhUUf+Maug27i6aZTMkqPRLBvmfWLZUo7K1Iq13NvwoL9ib9dEojFzHxcv0Df3l8ng3vIcYb3dEBSMMzhS4gf3VmtSMjAcQDbh+Y0NRTVIMw9nmhV4e+B9yQEc2Pgzfqkx7iuoO/Ga9QkwHt7sVxMuc/JTsB8pJLzGoPes4wVZao/xQFK87IzghGfmTDYsOcoe3Z+fEI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <776FB5B50E05C24BAD13A42794CA0E9A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624e2133-7e97-421f-09b5-08d81dc8094f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 14:07:05.8205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwMX4w0E+xGbq23lepqI7zgIexpqm9zmJBtz+U3/hHARe8VDEVk2/MqZsqBEnzUftLIkakSOzmdha4PMmJFwxTCWm5VjUnIxCS6v7TZdRAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5002
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 cotscore=-2147483648 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTAxIGF0IDE0OjA0ICswMjAwLCBOdW5vIFPDoSB3cm90ZToNCj4gW0V4
dGVybmFsXQ0KPiANCj4gV2hlbiBsb29raW5nIGZvciBhIHJlZ2lzdGVyZWQgY2xpZW50IHRvIGF0
dGFjaCB3aXRoLCB0aGUgd3JvbmcgcmVmZXJlbmNlDQo+IGNvdW50ZXJzIGFyZSBiZWluZyBncmFi
YmVkLiBUaGUgaWRlYSBpcyB0byBpbmNyZW1lbnQgdGhlIG1vZHVsZSBhbmQNCj4gZGV2aWNlDQo+
IGNvdW50ZXJzIG9mIHRoZSBjbGllbnQgZGV2aWNlIGFuZCBub3QgdGhlIGNvdW50ZXJzIG9mIHRo
ZSBheGkgZGV2aWNlDQo+IGJlaW5nDQo+IHByb2JlZC4NCj4gDQoNClllcC4NCkdvb2QgY2F0Y2gg
aGVyZS4NCg0KQWNrZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFu
QGFuYWxvZy5jb20+DQoNCj4gRml4ZXM6IGVmMDQwNzA2OTJhMiAoaWlvOiBhZGM6IGFkaS1heGkt
YWRjOiBhZGQgc3VwcG9ydCBmb3IgQVhJIEFEQyBJUA0KPiBjb3JlKQ0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lp
by9hZGMvYWRpLWF4aS1hZGMuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9h
ZGMvYWRpLWF4aS1hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZGktYXhpLQ0KPiBhZGMuYw0KPiBp
bmRleCA2M2Q5MjZlODY3OTguLjg2YjZiNjU5MTZlZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
aW8vYWRjL2FkaS1heGktYWRjLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkaS1heGktYWRj
LmMNCj4gQEAgLTMzMiwxMiArMzMyLDEyIEBAIHN0YXRpYyBzdHJ1Y3QgYWRpX2F4aV9hZGNfY2xp
ZW50DQo+ICphZGlfYXhpX2FkY19hdHRhY2hfY2xpZW50KHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
IAkJaWYgKGNsLT5kZXYtPm9mX25vZGUgIT0gY2xuKQ0KPiAgCQkJY29udGludWU7DQo+ICANCj4g
LQkJaWYgKCF0cnlfbW9kdWxlX2dldChkZXYtPmRyaXZlci0+b3duZXIpKSB7DQo+ICsJCWlmICgh
dHJ5X21vZHVsZV9nZXQoY2wtPmRldi0+ZHJpdmVyLT5vd25lcikpIHsNCj4gIAkJCW11dGV4X3Vu
bG9jaygmcmVnaXN0ZXJlZF9jbGllbnRzX2xvY2spOw0KPiAgCQkJcmV0dXJuIEVSUl9QVFIoLUVO
T0RFVik7DQo+ICAJCX0NCj4gIA0KPiAtCQlnZXRfZGV2aWNlKGRldik7DQo+ICsJCWdldF9kZXZp
Y2UoY2wtPmRldik7DQo+ICAJCWNsLT5pbmZvID0gaW5mbzsNCj4gIAkJbXV0ZXhfdW5sb2NrKCZy
ZWdpc3RlcmVkX2NsaWVudHNfbG9jayk7DQo+ICAJCXJldHVybiBjbDsNCg==
