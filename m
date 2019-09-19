Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF3B736D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 08:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfISGwK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 02:52:10 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22066 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388141AbfISGwK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 02:52:10 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J6luWO013990;
        Thu, 19 Sep 2019 02:51:42 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v3vb5sdwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 02:51:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJpMrYEoW44Ru4LhMxtlMvIgV9/AdNpYN3m6ReKYFAshKJlmSUN1S4AskqedLTaskUFtxNBuoWMAC/FCL60GsgmBnOWnCbn5HQZ/mmekzWdE2Rg7RnOAgALk48L4ahxjU5LtWumB5M4xrjlAQ5SEXD06zlLoXFDWaKbJQ3QO2kF+h7CCHtgASxpNlnPYtg2v1lQvuC+2rFso0N7Gb7DoqP44sMd74D3lN0incozgl39XNfsCWfdfCqSBFVn1CGlLCSWgFIEZ0mfhnXBc/ZRSlYsPK/vpMaDiNNjR/X3uYPfu7qTZINOQQRmewzSNup099vQ44Qmx5a4wQeyprvWJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvKojq4CHdDdhXsYW4QvFlTRosWCTSk7M27BtA12mq0=;
 b=ZOEcjo746+tLLVBNm3+5AmWxm8dmHBtJdOOpBgVeu6eYnRNVIb1WyRI6JFS+fYMuM9xkSK7uQcTugKx5v+5kHECD+/jDi0LUMuX9Y9K+kOadPH0UsNInyskBlfvpSPULj+ITZ0nXmiIXe2ZsmEZaUD6gsgr6UG9xwUYxvOjhA04fOhL0tpuwZp/E1p5Dj57r5qmxf78dfOuQrSW1dqOnlm1Gqt3fGlK9svMvfThN/zeS/cSuStV0Z0Wy56Qb8cLSnkNjgyCpJ0ubvutTIfxQVoqPlQx6KEbXxhzKxeIZ+DNNQgpK2avyzwk4w7vdi/7NLSWSJ8iKBB6LjqsEClgW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvKojq4CHdDdhXsYW4QvFlTRosWCTSk7M27BtA12mq0=;
 b=pgmsssewsIQYp9SZNbe+y/rufqS2XAlnzRBDLmT7GsummUCamWo6+IhZNtSKpPolcfOEknMfbtqtElJnbhhs5RBx7wlizvjp+A2AJmGuG3P+iUxGFXBFVmaWErzifBzvbV1yqqUg+VpZab4m5GGm0xL9Ppf9nmb0mRZHJU37Pmw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5349.namprd03.prod.outlook.com (20.180.14.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 06:51:40 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 06:51:40 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "navid.emamdoost@gmail.com" <navid.emamdoost@gmail.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: imu: adis16400: release allocated memory on failure
Thread-Topic: [PATCH] iio: imu: adis16400: release allocated memory on failure
Thread-Index: AQHVbkIxN9Yuz2SolUuNa8M9AMyJ76cywyOA
Date:   Thu, 19 Sep 2019 06:51:40 +0000
Message-ID: <84e2832b52cc88665ff071942c1545b83eeb5602.camel@analog.com>
References: <20190918165724.3758-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190918165724.3758-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2678cb7-178d-4e20-83f0-08d73ccdd354
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5349;
x-ms-traffictypediagnostic: CH2PR03MB5349:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB53491E10B718A58CFB47A79EF9890@CH2PR03MB5349.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(54906003)(66066001)(86362001)(6246003)(478600001)(7736002)(2616005)(71190400001)(8676002)(36756003)(71200400001)(14454004)(305945005)(7416002)(118296001)(316002)(1361003)(229853002)(6486002)(14444005)(81156014)(256004)(6916009)(6436002)(5640700003)(6512007)(486006)(26005)(186003)(11346002)(99286004)(76176011)(102836004)(446003)(66476007)(66946007)(476003)(66556008)(64756008)(6506007)(5660300002)(66446008)(4326008)(6116002)(2351001)(76116006)(2501003)(3846002)(25786009)(2906002)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5349;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KQhvtjduNTjEK7hnMT74tQFz/4oUimo13DnHJ9mI2vNM/u7FNz0waFzwauXtgG5IR+0aMVj+K656F/UcYmNy7bBB1+3X6hCCWYlMskJDesXUFkHvVvZNm2oPW5iod67GjMmRHBBPYA70t29/n+4rhSURJWgcMoc6Eng4pYLCchd1ysP4PRW5C8tqX3EZQtPm7TOnT451syYsGP8zaxRt9ypohkdeTGzAvhNeX4PZRYo3MJNYc9QW9TId4upSe0nhrjXeaz+QQxwiyXpRkgtAUfXQgg5INCYJH6RkL1PAkA2boghFomMgdk4UIFknJGw76TcsQnMnHDmtxMXR0Mzpe+fcYR6U9qK/D9Gy5sbDbp4tLKwPz5jDrlJH20gmmKN/9eALNs5zUemQL3CpZUYndVl19Xo3cRD0R2M0dpPWp0g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D8FCC9474A6EB4E8B0276774E600F60@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2678cb7-178d-4e20-83f0-08d73ccdd354
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 06:51:40.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/JX8I90/T6Zzge/nyf2y7pb4Yv7c1aMlYnjpjSoNCNSxjTrNwx8ErUr4+7M1BSf/63yTD4H10nQKJiPrFW82o8PMWmFO57p9X6GYCNuyYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_02:2019-09-18,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=914 spamscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909190063
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA5LTE4IGF0IDExOjU3IC0wNTAwLCBOYXZpZCBFbWFtZG9vc3Qgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQoNCkhleSwNCg0KR29vZCBjYXRjaC4NCk9uZSBjb21tZW50IGlu
bGluZS4NCg0KPiBJbiBhZGlzX3VwZGF0ZV9zY2FuX21vZGUsIGlmIGFsbG9jYXRpb24gZm9yIGFk
aXMtPmJ1ZmZlciBmYWlscywNCj4gcHJldmlvdXNseSBhbGxvY2F0ZWQgYWRpcy0+eGZlciBuZWVk
cyB0byBiZSByZWxlYXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hdmlkIEVtYW1kb29zdCA8
bmF2aWQuZW1hbWRvb3N0QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9pbXUvYWRp
c19idWZmZXIuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1
ZmZlci5jDQo+IGIvZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gaW5kZXggOWFjODM1
NmQ5YTk1Li5jNWQ3ZTM2OGE2MzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlz
X2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+IEBAIC03
OCw4ICs3OCwxMCBAQCBpbnQgYWRpc191cGRhdGVfc2Nhbl9tb2RlKHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYsDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+ICAJYWRpcy0+YnVmZmVyID0g
a2NhbGxvYyhpbmRpb19kZXYtPnNjYW5fYnl0ZXMsIDIsIEdGUF9LRVJORUwpOw0KPiAtCWlmICgh
YWRpcy0+YnVmZmVyKQ0KPiArCWlmICghYWRpcy0+YnVmZmVyKSB7DQo+ICsJCWtmcmVlKGFkaXMt
PnhmZXIpOw0KDQpNYXliZSBhbHNvIGRvICAiYWRpcy0+eGZlciA9IE5VTEwiIGhlcmUuDQpUaGUg
aWRlYSBpcyB0byBtYWtlIHN1cmUgdGhhdCB0aGUgcG9pbnRlciBpcyBub3QgZG91YmxlLWZyZWUn
ZCBieSBzb21lDQpvdGhlciBmdW5jdGlvbiAoaS5lLiBhZGlzX2NsZWFudXBfYnVmZmVyX2FuZF90
cmlnZ2VyKCkgb3IgYW5vdGhlcg0KYWRpc191cGRhdGVfc2Nhbl9tb2RlKCkgY2FsbCkuDQoNCj4g
IAkJcmV0dXJuIC1FTk9NRU07DQo+ICsJfQ0KPiAgDQo+ICAJcnggPSBhZGlzLT5idWZmZXI7DQo+
ICAJdHggPSByeCArIHNjYW5fY291bnQ7DQo=
