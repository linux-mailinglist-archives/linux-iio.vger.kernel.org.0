Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE9188488
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgCQMxf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 08:53:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46566 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgCQMxf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 08:53:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HCm0WZ029717;
        Tue, 17 Mar 2020 08:53:19 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yrv64t0ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 08:53:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk8RiDgrcY0w+0k3aBilRO5cCosYAOkGIq9I87DWD6wKtORmMeJ0vMv44NmQ2QWG51JTnGDGTghWbTn54wVOCS83i7C5UXtyRDoRhYp2/KQtnUgOS5OxZbV+I8/gbQBhHSJrNNfr/s6QME5LZBhXc9dF+1vkpb1Ep+r1i5JoKDlFgxpvECCmmsV2IahAl8iOLXh839b7eG494x+6QthlPW0pJymNaX9B3OUEuZLdQLRkXE5BKdzk0dOQYssgtzmM90IS3k8cBVScXK9mNiab38lLB/mJivIoGdB71FekhVEuxqmhY1ozwOIC6SLduhC9hO1OK1JSWa3k9daAFDlc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2tuZcGgTThbAh3y2Rxc8N9tiQEhiBoTePFgsSojcsE=;
 b=DoYEe92kS6jn/Fa4evdSc3b46qya9Gx1D3heTwOKOyaho+XExxtO8bjlTREQku576aq4YqYpKmCL586lLFQkrQJNVfRymcM9VoZIq0GxImq55pD1DUffSqn8J+4npfpMhxbdXxgvzj9QPPJUFSNqqTPkN/ZtdhKpSjjaRsX4mQVZHY/GEdFjS0i9BqPY3Rt3Mxymokgoq5hxTGRSosnzm8cz0kCh+AAhn/NEf68phkzOX6o+drnlFDR04WKOwBbN8fagEEPKxtjXx1iDY4DCtmSksT/tuTTKw6HqH2jHz9GPivC6kLvBM1vDWyVg9hqYaZgEu8X5ZWK67K642niPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2tuZcGgTThbAh3y2Rxc8N9tiQEhiBoTePFgsSojcsE=;
 b=LT44SIm2klx8X5/vgcsJRLFYsesYA3b9yMM6bfhWAB+Y719RqkKXTvnti0isDVcM2lTTQcOg0yb/fkGNDWtWDXFnoaHL7a6yPIEf4wKCd5UA///s2zMIKqKQarJZ6hhSynrB9NnXVXYPghCewjfCM6EiupFWouczv8ii6g2qbek=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3433.namprd03.prod.outlook.com (2603:10b6:5:ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Tue, 17 Mar
 2020 12:53:17 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 12:53:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: re-introduce bitmap_zalloc() for trialmask
Thread-Topic: [PATCH] iio: buffer: re-introduce bitmap_zalloc() for trialmask
Thread-Index: AQHV/FjAxnlCYHIcM0GH/BQ/0KfFJqhMvRyAgAAAPwA=
Date:   Tue, 17 Mar 2020 12:53:16 +0000
Message-ID: <cb09b6f882a786a74919eda8812f27d502363150.camel@analog.com>
References: <20200317123621.27722-1-alexandru.ardelean@analog.com>
         <20200317125223.GC1922688@smile.fi.intel.com>
In-Reply-To: <20200317125223.GC1922688@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a060e85-e881-4b3d-ed21-08d7ca7229b2
x-ms-traffictypediagnostic: DM6PR03MB3433:
x-microsoft-antispam-prvs: <DM6PR03MB343352A24CFB8817B4EDA20EF9F60@DM6PR03MB3433.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(316002)(5660300002)(8936002)(71200400001)(4326008)(6486002)(478600001)(2906002)(91956017)(36756003)(86362001)(76116006)(26005)(2616005)(66946007)(81166006)(110136005)(81156014)(66446008)(66556008)(64756008)(66476007)(8676002)(186003)(6506007)(54906003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3433;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3NTwVsNjQ49fsSluXl3qp8vP5bZXtbzGfP1ON00m47XAC3W9jWD3hr4reu3RlPmesFjb/Ye+qlp55gwWf0JgAlK9uzyoB9xOdMRhsNWkT6v8WBMPglSy9YNsB78+MZCoLqCPKvl4mZxuCToXI8vMVnVakqxVtuY08+/dUUZYIrH1KUT6CEw7kuhvpMgxd+oe2RKkll6u9u3/b2SMUAfmCnXOBC019qHm8+/mTjtruXT55RYNCXufGpf+YE7PFXga4TUA2pyMGvdbbKHTT3gszXzSRGlPzNDC6Z7lcMMCtBZWL81jpRpFwLVEOzwswvpe5SkAhz4umwUov3IgDWwX6uhxcMqKXX/4DqxDIPutiDgkwbLKJPyhYEuRHYHt41xumUUgMo63LkWZqhRCoaaCveJFm31nEVWl2gem7nuNxk51Y2o8N0PuCRhcEXsvqgP
x-ms-exchange-antispam-messagedata: SMO7C3prmbDyqNApbPI/tGu3PsM29Dx5Bf2SzoM54KPW62QR+jhb1NcbQC1flEd6Ennjb6SZpy8lxO3w5klLcMDdk9hn3VA7+8c/c0Nxj0u0RvvMPO9n1iGvGAXPMqzNcVW/YkeQVpcf7sEuzGOsEw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95042886F224444DBCA1848A31ACE7C4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a060e85-e881-4b3d-ed21-08d7ca7229b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 12:53:16.9949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed0IUlHilXjp6rWKnTSIv2xmN5fM6HdRyE4le3O+g5O6XZOAyr/QW4JEuuathQB7y9EjwHBduTjSKdLvJVHPXDJ3v9hgbHmPeUY42Q8aFQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3433
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_04:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170057
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTE3IGF0IDE0OjUyICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgTWFyIDE3LCAyMDIwIGF0IDAyOjM2OjIxUE0g
KzAyMDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiBDb21taXQgMzg2MjgyOGE5MDNk
MyAoImlpbzogYnVmZmVyOiBTd2l0Y2ggdG8gYml0bWFwX3phbGxvYygpIikgaW50cm9kdWNlZA0K
PiA+IGJpdG1hcF9hbGxvYygpLCBidXQgY29tbWl0IDIwZWEzOWVmOWYyZjkgKCJpaW86IEZpeCBz
Y2FuIG1hc2sgc2VsZWN0aW9uIikNCj4gPiByZXZlcnRlZCBpdC4NCj4gPiANCj4gPiBUaGlzIGNo
YW5nZSBhZGRzIGl0IGJhY2suIFRoZSBvbmx5IGRpZmZlcmVuY2UgaXMgdGhhdCBpdCdzIGFkZGlu
Zw0KPiA+IGJpdG1hcF96YWxsb2MoKS4gVGhlcmUgbWlnaHQgYmUgc29tZSBjaGFuZ2VzIGxhdGVy
IHRoYXQgd291bGQgcmVxdWlyZQ0KPiA+IGluaXRpYWxpemluZyBpdCB0byB6ZXJvLiBJbiBhbnkg
Y2FzZSwgbm93IGl0J3MgYWxyZWFkeSB6ZXJvLWluZyB0aGUNCj4gPiB0cmlhbG1hc2suDQo+IA0K
PiBGV0lXLA0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5r
b0BsaW51eC5pbnRlbC5jb20+DQoNClRoYW5rcy4NCkFuZCBzb3JyeSBmb3IgdGhlIGhpY2N1cCBi
YWNrIHRoZXJlLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8
YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlv
L2luZHVzdHJpYWxpby1idWZmZXIuYyB8IDMgKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLQ0K
PiA+IGJ1ZmZlci5jDQo+ID4gaW5kZXggNGFkYTU1OTJhYTJiLi41ZmYzNGNlOGI2YTIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gKysrIGIv
ZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4gQEAgLTMxNiw4ICszMTYsNyBA
QCBzdGF0aWMgaW50IGlpb19zY2FuX21hc2tfc2V0KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYs
DQo+ID4gIAljb25zdCB1bnNpZ25lZCBsb25nICptYXNrOw0KPiA+ICAJdW5zaWduZWQgbG9uZyAq
dHJpYWxtYXNrOw0KPiA+ICANCj4gPiAtCXRyaWFsbWFzayA9IGtjYWxsb2MoQklUU19UT19MT05H
UyhpbmRpb19kZXYtPm1hc2tsZW5ndGgpLA0KPiA+IC0JCQkgICAgc2l6ZW9mKCp0cmlhbG1hc2sp
LCBHRlBfS0VSTkVMKTsNCj4gPiArCXRyaWFsbWFzayA9IGJpdG1hcF96YWxsb2MoaW5kaW9fZGV2
LT5tYXNrbGVuZ3RoLCBHRlBfS0VSTkVMKTsNCj4gPiAgCWlmICh0cmlhbG1hc2sgPT0gTlVMTCkN
Cj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgCWlmICghaW5kaW9fZGV2LT5tYXNrbGVuZ3Ro
KSB7DQo+ID4gLS0gDQo+ID4gMi4yMC4xDQo+ID4gDQo=
