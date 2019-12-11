Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0338611A50C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 08:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfLKH0f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 02:26:35 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56266 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfLKH0e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 02:26:34 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB7OjVj026967;
        Wed, 11 Dec 2019 02:26:10 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wraq3kg10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 02:26:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8JuO+NRlsxxWgn3gpJkgCH6VOTaH30WpRHpVj45ByLZRdhKP2hGap+hh1R7ROMCA9lwFTpcWhusLYzYxQ8c2P4wS3TgK/fFHMBW7zNxC1xp2NaUwrpDXAfBjVwD2FJEm57UNHknY+Iz+jf7dEKHQf8sfuWgR7y27MoYX0ooWXJ3Qm8wa78NV57DnPOuxeWtpOc25W1m+2sgRmbE2xFHyxCGnVzaXzVEeTSbTS/YNA0g3Qbx5bS+Jm8w2KJTaA5LL3xjYiZur5kMmZr1QrWDdejoXt1yBK4k6AiEfKFSw03krVOBQMenbZK9cnesFM3Lrs7MEcg+7aEokHWi+diTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lN0bKtPCDt+aOqdOCLTqL7uA9tPLMoii9bnQZ3KLco=;
 b=cOBbObhD0ksyPLevU2pMWuDLB5aNL04FeC6GXatpcuVd0lCAhziIrszbqUfwxp/1iaiOYl8Coy5IW0OwtPkUzXgYy58pT5YBSvOK9XqwBb00pXfx0SIUn9FrYQ690qyZiWIAfyJ8koMwI+W9aLOOieiSFZaB8t3j5F2z89qsgMEeoFOACBdIiN1AD70tSKdxAikKPqjnLKjEOh2YXt4QBP2YwImaJL5XIpy3EFNclqWqvgS4jdAK61gJQwIHyJfYWpIRMrk3wd0Dw30CxmW215L4HHODFUnwyvjzbKkGTJ82WRUEOBFNrt/Y3MIu3sigH84thLXTrQDQU56SAENJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lN0bKtPCDt+aOqdOCLTqL7uA9tPLMoii9bnQZ3KLco=;
 b=wwR1G2T7AV3phMxvMFV2Ab3OZ/63WvTg1+NaqclvVFKW0VGG2oe7xHS1Es0IThWWWIbaRzMyGXmVD1KBPcAmgrpb/MpVNS/oGQW7gEclUEfLgBUBROibAFrT4MUFGxUzH4Pcr1jhGW7lJAMSqoUBXZ+lOszHmfRBfUHgfSjgCcs=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5174.namprd03.prod.outlook.com (20.180.4.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 07:26:07 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 07:26:07 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7923: Remove the unused defines
Thread-Topic: [PATCH v2 1/4] iio: adc: ad7923: Remove the unused defines
Thread-Index: AQHVr2vDDdAuPewyhUOxauGuFUCnUae0ig8A
Date:   Wed, 11 Dec 2019 07:26:07 +0000
Message-ID: <17193a42835f41b4352855b1cbd1cb5cf74a6d66.camel@analog.com>
References: <20191210150811.3429-1-djunho@gmail.com>
         <20191210150811.3429-2-djunho@gmail.com>
In-Reply-To: <20191210150811.3429-2-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82b82a6d-e7d4-4445-d153-08d77e0b638b
x-ms-traffictypediagnostic: CH2PR03MB5174:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB517490648F798E59BE1395DAF95A0@CH2PR03MB5174.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(186003)(2906002)(478600001)(316002)(86362001)(66946007)(81166006)(2616005)(26005)(110136005)(36756003)(6512007)(8936002)(76116006)(5660300002)(6486002)(66476007)(8676002)(4001150100001)(71200400001)(66446008)(81156014)(64756008)(66556008)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5174;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DajIQEbxXrmuJtbkPAkpxSwQ98EHPlyDbXVC6COCPlVanFD++HwuDLl5aSQTCQSWA6FHd6U6sMzfkRGl6ImWhlQaYn+cC/5HIHrJfuNRRsIUa717Z8OwLl9b+B59S0URYJn8gvq3iTDXLFGxibDtVGzIdm7pyHUdlR4kQN90cLzBGi0JGO0pgaiHbnxiiEhfyoIWebluWttOo113mJNk1OhwCa6ez+tthmLe6BO/CucGMPZ41Ju+l2LYQLwMIr8N7w9Ghubc9MXCD/FJMy2qUW8Vk/WnqZJzMbovAgXWiwC34OWOrsyKM2QxONGrWpVCAle5jPEA3uEz2egKOL9mO4QOGM1r1upsP/FeosSded7nY1bxLx5Y1HW5YEZQwlLS+ms4TJPgZ/diJclyAhzWV7n6egquIfz553bS9xb6i1x7FGPydbkevPZKZ5hkGPr10bLigfI15ZCyzpZEDQ/IEqlBYDe0t3qq9jCk8fvzppBKy8cNCzvOhZacqqNZWISB
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8620022217BE4C9AFF3910779D8AA3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b82a6d-e7d4-4445-d153-08d77e0b638b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 07:26:07.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/zPs+iRahHNHqpq1FNWUyb2nPbtaHU0fQuqy9uUUmuCRiDmZVCbNoHzq9EmupFvcu4rrZ460gkuoNnqX1aFvHipfySGAIsQukB34jZIFFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5174
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_01:2019-12-10,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 mlxlogscore=811 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110063
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTEwIGF0IDEyOjA4IC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFJlbW92ZXMgdGhlIHVudXNlZCBkZWZpbmUgQUQ3OTIzX0NIQU5O
RUxfeCBmcm9tIHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEp1bmhvIDxk
anVuaG9AZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9hZDc5MjMuYyB8IDQg
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+
IGluZGV4IDMyMTJlYjRjMGYyNS4uOTY5YzA2YjdkMmI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2lpby9hZGMvYWQ3OTIzLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IEBA
IC0yOSwxMCArMjksNiBAQA0KPiAgI2RlZmluZSBBRDc5MjNfUE1fTU9ERV9BUwkoMSkJCS8qIGF1
dG8gc2h1dGRvd24gKi8NCj4gICNkZWZpbmUgQUQ3OTIzX1BNX01PREVfRlMJKDIpCQkvKiBmdWxs
IHNodXRkb3duICovDQo+ICAjZGVmaW5lIEFENzkyM19QTV9NT0RFX09QUwkoMykJCS8qIG5vcm1h
bCBvcGVyYXRpb24gKi8NCj4gLSNkZWZpbmUgQUQ3OTIzX0NIQU5ORUxfMAkoMCkJCS8qIGFuYWxv
ZyBpbnB1dCAwICovDQo+IC0jZGVmaW5lIEFENzkyM19DSEFOTkVMXzEJKDEpCQkvKiBhbmFsb2cg
aW5wdXQgMSAqLw0KPiAtI2RlZmluZSBBRDc5MjNfQ0hBTk5FTF8yCSgyKQkJLyogYW5hbG9nIGlu
cHV0IDIgKi8NCj4gLSNkZWZpbmUgQUQ3OTIzX0NIQU5ORUxfMwkoMykJCS8qIGFuYWxvZyBpbnB1
dCAzICovDQoNClRoZSBmYWN0IHRoYXQgaXMgbm90IHVzZWQsIGlzIG5vdCBhIHByb2JsZW0gcmVh
bGx5Lg0KVGhpcyBjYW4gc2VydmUgYXMgYSAic2hvcnRjdXQiIGZvciB0aGUgZGF0YXNoZWV0Lg0K
DQpXZSBjYW4gbGVhdmUgdGhpcyBhcy1pcyBbMV0sIG9yIHJlbW92ZSBpdCBhcyB5b3UgZG8gWzJd
LCBvciBhbiBhbHRlcm5hdGl2ZQ0Kd291bGQgYmUgWzNdOg0KI2RlZmluZSBBRDc5MjNfQ0hBTk5F
TCh4KSAgICAgICh4KSAgICAgICAvKiBhbmFsb2cgY2hhbm5lbCBpbnB1dCAqLw0KDQpJIGRvbid0
IG1pbmQgZWl0aGVyIG9mIHRoZXNlIDMgdmVyc2lvbnMgKFsxXSwgWzJdIG9yIFszXSkuDQoNCkkn
bGwgbGVhdmUgaXQgdG8gSm9uYXRoYW4ncyBwcmVmZXJlbmNlLg0KDQo+ICAjZGVmaW5lIEFENzky
M19TRVFVRU5DRV9PRkYJKDApCQkvKiBubyBzZXF1ZW5jZSBmb25jdGlvbg0KPiAqLw0KPiAgI2Rl
ZmluZSBBRDc5MjNfU0VRVUVOQ0VfUFJPVEVDVAkoMikJCS8qIG5vIGludGVycnVwdA0KPiB3cml0
ZSBjeWNsZSAqLw0KPiAgI2RlZmluZSBBRDc5MjNfU0VRVUVOQ0VfT04JKDMpCQkvKiBjb250aW51
b3VzIHNlcXVlbmNlICovDQo=
