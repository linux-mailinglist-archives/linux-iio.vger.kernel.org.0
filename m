Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE27122A0A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLQLam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:30:42 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7794 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfLQLam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:30:42 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHBRI04028114;
        Tue, 17 Dec 2019 06:30:21 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wvw8cp4h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 06:30:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAZFipvieJauZDwyb2ammxG8zktHDBQOwm8N6kphdvUisYTJIalp3PNDFDJ+QL/7nCPO3AZNhc6i1tWyuOF76O6Nfez0vGnOYVrHMbF7mc+dGMNuSeN3Z6pWDrj5q+TMllO85gsWZFPgodjQ9UXmGp5D1aJNTlJ3xidUtnHqk9vcXDP0cskoDoPX+sILFa5ead2YJs12JmZItNxA0xgzz5BW5ggm8kHLWjLqtknEY7rt3e4nAdkmfgqjE69y6xsC5oanaJsK+IPESPSKkJdLeYxsnwjU7It4XrCO626WZmegN3tmgLti2zChx+tw7LbOWyNqTrG78EYOni32i5ioIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/oLYtirlzclQyxmDMJ5b/vlFy8h7hb5ox+PjV/oCH0=;
 b=CpfKFDGfKpakhdeMRPJLfVAt53/eqDT8Rl0h03TyyMG+Q1gBHy14XtCyQ5wKO9l7TKMOYUFx2s1+A7DaTD1GgmhwdQMismkp3DSlH86c+m7ZYUQBfMgkkHHqlDftl9CE38gbp8ogLOoSZI+YBfaOviHwNdeWy5W+i1konP2XLuY6eNJqt9p2BU95PWU6nXA0i9duY3Dgj2riaaLXsSFppS98D1u14Ev66wgvpwWehpsLNEJALV+CWwUuSN4HV8kJrm6K1zAVHSRkEPgVIJ4BvYCaXJQYd2/Bc4OChhb08zhKSVWbNOsoU7ga2LahDng1/RRoU+KIhB73KyLVg3bDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/oLYtirlzclQyxmDMJ5b/vlFy8h7hb5ox+PjV/oCH0=;
 b=7CSbNotmUMe5led+ff9FFrgMXK+AyzoHXZvwdWCaORqCvlsaIoh9NVPeI9Hjwo9RgOZLMBE/ha8xetJPcRxcrRnhqnNcpyClmgYyYaRYCw+8PcGI+skcxmgsxObwrE6rkDlEg6Szic0Th4u6Ap1Ubz47Aj9tuGIIR8jD3ag1+Dk=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5256.namprd03.prod.outlook.com (20.180.15.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 11:30:09 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 11:30:09 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] iio: adc: ad7923: Fix checkpatch warning
Thread-Topic: [PATCH v3 2/4] iio: adc: ad7923: Fix checkpatch warning
Thread-Index: AQHVtMraQKbFW1Y8DEuUfPj7IXov+qe+MRYA
Date:   Tue, 17 Dec 2019 11:30:09 +0000
Message-ID: <d2d3c5ce9015d00c5b3c82bfffd3f3e03b4246b7.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
         <20191217111158.30888-3-djunho@gmail.com>
In-Reply-To: <20191217111158.30888-3-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 764d357c-ce5a-4817-85a1-08d782e47926
x-ms-traffictypediagnostic: CH2PR03MB5256:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB52566804243AB1FB51F6F924F9500@CH2PR03MB5256.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(199004)(189003)(71200400001)(6512007)(6506007)(316002)(66946007)(76116006)(8936002)(4001150100001)(4744005)(2616005)(6486002)(81166006)(478600001)(110136005)(81156014)(8676002)(66476007)(66556008)(66446008)(36756003)(64756008)(26005)(86362001)(2906002)(5660300002)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5256;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4sd+Wt1sIgRUyL5DR0zhQLEc0oJ5zdrvd4Dbv876kXtZXtF2Xe2IX6hr+rrD3m9O/uuK+iD8YB/BMC4UQ7Z36Ti4zze3rG8sVZwO4zM6ZzM6aPDZ+PzPeeWdrcDGSEbqmoZtCX/+otEqMMTJ+uNbRbqwmQJ7Y7+K0ZyleCP5u1KYI4RWvw/HB1xNj05/tt6pHLTBhQ2j4n+CxU0Jfl3JdEhaQHTSkEOC78MywevbXz53kY0vTO7/x2U+AOpYMYqiiJgbhnSHX1ynFEMK5M2IWTA8dLw4LLjoo7k5CEJ12lhE/8FoXnsVdEvjnopd2/nZC05XExE8Js8p7GSF1z/92eGjMLIcaDbZnm6jUckyuMpjNwzAA/8SPF+iQo6V+adY9Sdl61KaAF3q4x6HsdR1R8QFSNOcbJt7jEkq3RaxfAvtQIJzU3v/EuShZGY2ut9zPcGK62U87pHST7OVaY+a+qYZEG1CEbLahWZic3AwP4p6eVyqSVKtmGhjz47Juuu6
Content-Type: text/plain; charset="utf-8"
Content-ID: <C339373D8CEBAB4CBF60FB8B6980E669@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764d357c-ce5a-4817-85a1-08d782e47926
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 11:30:09.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEYubzndAbKb3OCTwEY7gbNgWFbaswm1PdP6tC+gCAwl3vffPWduVlNkrtAFTAH1cIgsJKTEX4tJLx4sQOmfJeBIzUFtcntTBovbiu7TEC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5256
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-16,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDA4OjExIC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IEZpeCBjaGVja3BhdGNoIHdhcm5pbmc6DQo+IFdBUk5JTkc6IFByZWZlciAndW5zaWduZWQgaW50
JyB0byBiYXJlIHVzZSBvZiAndW5zaWduZWQnDQo+ICtzdGF0aWMgaW50IGFkNzkyM19zY2FuX2Rp
cmVjdChzdHJ1Y3QgYWQ3OTIzX3N0YXRlICpzdCwgdW5zaWduZWQgY2gpDQo+IA0KDQpSZXZpZXdl
ZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4N
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSnVuaG8gPGRqdW5ob0BnbWFpbC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL2FkNzkyMy5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IGluZGV4IDk2
OWMwNmI3ZDJiNy4uZTUzNWNlYzlmYzAyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMv
YWQ3OTIzLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IEBAIC0xODQsNyAr
MTg0LDcgQEAgc3RhdGljIGlycXJldHVybl90IGFkNzkyM190cmlnZ2VyX2hhbmRsZXIoaW50IGly
cSwNCj4gdm9pZCAqcCkNCj4gIAlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICB9DQo+ICANCj4gLXN0
YXRpYyBpbnQgYWQ3OTIzX3NjYW5fZGlyZWN0KHN0cnVjdCBhZDc5MjNfc3RhdGUgKnN0LCB1bnNp
Z25lZCBjaCkNCj4gK3N0YXRpYyBpbnQgYWQ3OTIzX3NjYW5fZGlyZWN0KHN0cnVjdCBhZDc5MjNf
c3RhdGUgKnN0LCB1bnNpZ25lZCBpbnQgY2gpDQo+ICB7DQo+ICAJaW50IHJldCwgY21kOw0KPiAg
DQo=
