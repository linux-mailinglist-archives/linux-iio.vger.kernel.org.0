Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338EE1A9CF7
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897416AbgDOLll (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 07:41:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:50738 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2897398AbgDOLlc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 07:41:32 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FBcOSN011127;
        Wed, 15 Apr 2020 07:41:26 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2052.outbound.protection.outlook.com [104.47.45.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn9a9x8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 07:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeRPFlnGdQl9Os2w+YerXaTZBxdvko3Xi3NayxM18F4sSgry8ps5xfzmC+m8CYFmCOkbyEZBvpuHSUDrgDzohqSzhlAQbyGOSMwWTNmHO0SqTTtHYv8bUE+mIw8umrPuIUhHbL+m+BYG4U5zRzqs45IZ42LzLu1P46MFwyI2sg0R9gJP4aBcFda3BwBy+VvqQ/pWcZDi5pmWh0asAPR3cn0BsK9SLyYzC1HWJ5H7EEk/+yVudKS0dCB/xlfm/VhTlwl9ugmivWtJElsoOd/2RHDVYgDarcYl0H0GzpYxejlzgsX0C/pgsDu4hD+em/+wQSLxFPY/EyYwL8OccjKjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O90I+SD7bP6i+nzCJwOOyzJo2VC0BCIC3p0YIbsFZu0=;
 b=KfaJNESgk4v7ln3NxIgxUej9U5cShhV3Wpba9lP8RLiGDuDhc+hr1cqbQr2LeYk3Cu/9mcvIxfZYv1W8wJB0owoScbhDT8twgGHle493qiflzmp154C0+qCOkJ5pwL3jN9tsvC526+TaoXzByMuUXIl05ortQmTNajs5awL6BaeU1TilWXpfbzJTOHhc+c6xKvZ1Hh4NNuci/9HTU9mR1hoVngjo6gG8K7ck0k11fn5+RytOwN8jaTyWBgROOGpsuqj3cxEFlz/rtxfXbNb8pmlr4QlAmbI9dGm/ZQ9guSNQlt3JafBh+wK+DGjb6Le2g8+dw+eOMq03+tSqdjK/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O90I+SD7bP6i+nzCJwOOyzJo2VC0BCIC3p0YIbsFZu0=;
 b=V+HwPQ0qs4RXnYOuvumpnKrDePrtNU8eR5ivHJcm+4Tf7R4d+EqBHRuCUy/G9lrjOCiFdnufcHdrn3rBwOVPLfw+BUDUk7703Lf+YB5StKK2wvO1j/6a4jdbLDpY4nBbGPzZi2IXxtWPkGuUfStGmI5fe+sK9t0LHrHmsmL1fzM=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4026.namprd03.prod.outlook.com (2603:10b6:5:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Wed, 15 Apr 2020 11:41:24 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.024; Wed, 15 Apr 2020
 11:41:24 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@engebretsen.ch" <lars@engebretsen.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v2] iio: core: remove extra semi-colon from
 devm_iio_device_register() macro
Thread-Topic: [PATCH v2] iio: core: remove extra semi-colon from
 devm_iio_device_register() macro
Thread-Index: AQHWEw4+9liLbi+vUEi/aqJ2LKRNT6h6D3eA
Date:   Wed, 15 Apr 2020 11:41:24 +0000
Message-ID: <526f58cee9ef50cfb13af4b25d215735985cce9a.camel@analog.com>
References: <20200415101043.32050-1-lars@engebretsen.ch>
In-Reply-To: <20200415101043.32050-1-lars@engebretsen.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 999620f4-09db-46e8-10f8-08d7e131ed2b
x-ms-traffictypediagnostic: DM6PR03MB4026:
x-microsoft-antispam-prvs: <DM6PR03MB40264FAAEA31D79DB472E610F9DB0@DM6PR03MB4026.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:343;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(6486002)(186003)(71200400001)(6512007)(5660300002)(478600001)(26005)(316002)(110136005)(8936002)(4326008)(36756003)(6506007)(91956017)(66946007)(81156014)(76116006)(8676002)(64756008)(66446008)(66556008)(66476007)(2616005)(86362001)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYQbHxQbLUEHUSslhRhhNXfk71ZeNsG6STCM8CiERTYh83FFrDUOyZfHKZKevfWRt6oXK7zA8n6OE4AW5waK+b47ZUUqV+UjdAdrbLwXOOYGa2VpZIr0Gc4LOTXSLFplyblfJ4oCNkDTskQlVBp7zRZPj8PDXiLl/VPe14RDyFK/Ba57Rk5XtmMLx7itrtDxQcmXeW89Khb0/9OvYqJ7Pj4qoX/2kS6D9mDUtqi8LutQMQOoJrjC4tSyBF4y81lCS1dqhff/Yrd1GZR9/nks+Cl/Q04+4KcHO3Je65VgV+tbNs2T4YCnUtVjLpqL1j7g8IaXFvOnMw2S7B3kafsD5jx2LBJ/IDfJ7CyusGUgWowXP+M9KrIgapOFOm2GxFTnRIyThcSt+fzF9rnqXoTJkcQFNfHgRQdA5zbljpc/dB92qnjK8dgspEYI28SozCP4
x-ms-exchange-antispam-messagedata: xypWV5z8rCjhjND2SUYpmoFEpNn6gbGa1VFHxoDbovaxbbj608eRTSPgTvEOatOqMZI15cLfpskQwHxGMkKX7vzWi+QoBrDkRhB5cdqCsnYjeXEt+OdjvwDA5bvokRKRApr+hweeYqWs+u1mkDoQdw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <41C99CA42C969E49942CD7ED53A12B1B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999620f4-09db-46e8-10f8-08d7e131ed2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 11:41:24.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //VZGPemkBThORselqDmpKOKGzDsvCstCk5yyuIsvNaYuCyNexnVrMZWk3Q+kK8iwT5F8qgg0aOeO11L57djXHjdi7OOJSUHmodpSESNWKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4026
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_03:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTE1IGF0IDEyOjEwICswMjAwLCBMYXJzIEVuZ2VicmV0c2VuIHdyb3Rl
Og0KPiBUaGlzIGNoYW5nZSByZW1vdmVzIHRoZSBzZW1pLWNvbG9uIGZyb20gdGhlIGRldm1faWlv
X2RldmljZV9yZWdpc3RlcigpDQo+IG1hY3JvIHdoaWNoIHNlZW1zIHRvIGhhdmUgYmVlbiBhZGRl
ZCBieSBhY2NpZGVudCB2aWEgY29tbWl0IDYzYjE5NTQ3Y2MzZDkNCj4gKCJpaW86IFVzZSBtYWNy
byBtYWdpYyB0byBhdm9pZCBtYW51YWwgYXNzaWduIG9mIGRyaXZlcl9tb2R1bGUiKS4NCj4gDQoN
ClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFs
b2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IExhcnMgRW5nZWJyZXRzZW4gPGxhcnNAZW5nZWJy
ZXRzZW4uY2g+DQo+IC0tLQ0KPiBDaGFuZ2Vsb2cgdjEgLT4gdjI6DQo+ICogYWRkZWQgY29tbWl0
IGNoYW5nZSBkZXNjcmlwdGlvbg0KPiANCj4gIGluY2x1ZGUvbGludXgvaWlvL2lpby5oIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9paW8vaWlvLmggYi9pbmNsdWRlL2xpbnV4L2lp
by9paW8uaA0KPiBpbmRleCBkNjM4ODRhNTQ5MzkuLjc2YmE3YzlmZDNlMCAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9paW8vaWlvLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9paW8vaWlv
LmgNCj4gQEAgLTU5Nyw3ICs1OTcsNyBAQCB2b2lkIGlpb19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2KTsNCj4gICAqIDAgb24gc3VjY2VzcywgbmVnYXRpdmUgZXJy
b3IgbnVtYmVyIG9uIGZhaWx1cmUuDQo+ICAgKi8NCj4gICNkZWZpbmUgZGV2bV9paW9fZGV2aWNl
X3JlZ2lzdGVyKGRldiwgaW5kaW9fZGV2KSBcDQo+IC0JX19kZXZtX2lpb19kZXZpY2VfcmVnaXN0
ZXIoKGRldiksIChpbmRpb19kZXYpLCBUSElTX01PRFVMRSk7DQo+ICsJX19kZXZtX2lpb19kZXZp
Y2VfcmVnaXN0ZXIoKGRldiksIChpbmRpb19kZXYpLCBUSElTX01PRFVMRSkNCj4gIGludCBfX2Rl
dm1faWlvX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYsDQo+ICAJCQkgICAgICAgc3RydWN0IG1vZHVsZSAqdGhpc19tb2QpOw0KPiAg
aW50IGlpb19wdXNoX2V2ZW50KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHU2NCBldl9jb2Rl
LCBzNjQgdGltZXN0YW1wKTsNCg==
