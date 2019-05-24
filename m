Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFBB29977
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbfEXNyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 09:54:54 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com ([40.107.78.88]:56581
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403976AbfEXNyx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 May 2019 09:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhsQ9Zmu7jpHhDDaEuu4j/MgVT8yY29rZQaLXOwM/Ac=;
 b=znzXftnz5rM5j7ooxg+o1zToFQUjSfA8e2NaLEhouIONvxTUID+GYj5qKsY4+AicHupJ2Ql/FeL6UXqSWq3Xlyt0AgfW2x4JMdo4BNJRERgA2CpNgsC+E86bK+kEVOrwypTvAf6wOKbKW8akKQxvjNY3/dCQQeRTf8qVQRdCFt0=
Received: from CY4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:910:4d::19)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Fri, 24 May
 2019 13:54:51 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by CY4PR03CA0078.outlook.office365.com
 (2603:10b6:910:4d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Fri, 24 May 2019 13:54:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Fri, 24 May 2019 13:54:50 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4ODsoTd030068
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 24 May 2019 06:54:50 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Fri, 24 May 2019 09:54:49 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: iio: adis16240: add of_match_table entry
Thread-Topic: [PATCH] staging: iio: adis16240: add of_match_table entry
Thread-Index: AQHVEfq6uvppH90jDke8Urfy897lKKZ6jmuAgAABL4A=
Date:   Fri, 24 May 2019 13:54:49 +0000
Message-ID: <11a0315e01b80a3a9eb4e81e1b018a2bff7ae559.camel@analog.com>
References: <20190524032950.2398-1-rodrigorsdc@gmail.com>
         <CA+U=DspqLFBMrRcV6VmypHOpE6Qs7OqmiDzWAd6pxpA7B=4S4g@mail.gmail.com>
         <20190524135034.u2mbtq2jwhp6ent7@smtp.gmail.com>
In-Reply-To: <20190524135034.u2mbtq2jwhp6ent7@smtp.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCDA9C1FD24472459D4D2FD0595CCA79@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(189003)(199004)(11346002)(86362001)(356004)(70586007)(5660300002)(2501003)(305945005)(47776003)(36756003)(118296001)(14454004)(478600001)(70206006)(229853002)(2616005)(7636002)(7736002)(476003)(50466002)(4326008)(126002)(486006)(2906002)(76176011)(53546011)(110136005)(26005)(106002)(186003)(8676002)(6246003)(426003)(436003)(14444005)(336012)(54906003)(246002)(316002)(3846002)(6116002)(102836004)(7416002)(7696005)(2486003)(23676004)(8936002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cafc7d-562d-41cf-f36f-08d6e04f6431
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BL2PR03MB546;
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Antispam-PRVS: <BL2PR03MB546730183EE5E096874724BF9020@BL2PR03MB546.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0047BC5ADE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ljrquUm2wqFKy9FA6Ss17Ib6kSGCTjV26qgP3fzqoBQIuoHWTcwsjZ8tV6dswC2UyFh0wEkxcS9vHFHZF1YBbCJhDzBVhW8L8+MedIF4S9szSdI+EbT7zZ94EMDgq5bpcHVGOpqFVR/+R6ox+Vs6qJdjabhQwJNAEfGmFdNwhu/BqL8cT4kSIB4LHdGjla50Vh9MJmVANocLP7t4MDZhtrA1LHTH/zpSuc9NpaWPqqWefkfc4dNMWk6VyS3oZ0j9m5sRCYBT/MhoV/4D1d2ljEh6kGOPQzjFRH7MbHUo9sxNmH0QbWJc3OIxyRIW1AQdxiTFA5eZbZqYb+mrn+9+vRqsZMP4YPKT0e0ZNZsC7CPHLkjPKuRLM6qCqcc6Cii105g9kOLJkcTrAsH+pHSnqWzia9pHzm1Z5cvLyp7hk3Q=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2019 13:54:50.6606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cafc7d-562d-41cf-f36f-08d6e04f6431
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA1LTI0IGF0IDEwOjUwIC0wMzAwLCBNYXJjZWxvIFNjaG1pdHQgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBIaSBBbGV4YW5kcnUsDQo+IA0KPiBPbiAwNS8yNCwg
QWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWF5IDI0LCAyMDE5IGF0IDY6
MzAgQU0gUm9kcmlnbyBSaWJlaXJvIDxyb2RyaWdvcnNkY0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgb2ZfbWF0Y2hfdGFibGUgZW50cnkgaW4gZGV2aWNl
IGRyaXZlciBpbiBvcmRlciB0bw0KPiA+ID4gZW5hYmxlIHNwaSBmYWxsYmFjayBwcm9iaW5nLg0K
PiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSb2RyaWdvIFJpYmVpcm8gPHJvZHJpZ29yc2Rj
QGdtYWlsLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBNYXJjZWxvIFNjaG1pdHQgPG1hcmNlbG8u
c2NobWl0dDFAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9zdGFnaW5nL2lp
by9hY2NlbC9hZGlzMTYyNDAuYyB8IDEgKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9h
Y2NlbC9hZGlzMTYyNDAuYyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWNjZWwvYWRpczE2MjQwLmMN
Cj4gPiA+IGluZGV4IDhjNmQyMzYwNGVjYS4uYjgwYzg1Mjk3ODRiIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hY2NlbC9hZGlzMTYyNDAuYw0KPiA+ID4gKysrIGIvZHJp
dmVycy9zdGFnaW5nL2lpby9hY2NlbC9hZGlzMTYyNDAuYw0KPiA+ID4gQEAgLTQ0NCw2ICs0NDQs
NyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhZGlzMTYyNDBfb2ZfbWF0Y2gpOw0KPiA+ID4g
IHN0YXRpYyBzdHJ1Y3Qgc3BpX2RyaXZlciBhZGlzMTYyNDBfZHJpdmVyID0gew0KPiA+ID4gICAg
ICAgICAuZHJpdmVyID0gew0KPiA+ID4gICAgICAgICAgICAgICAgIC5uYW1lID0gImFkaXMxNjI0
MCIsDQo+ID4gPiArICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gYWRpczE2MjQwX29m
X21hdGNoLA0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggaXMgbWlzc2luZyB0aGUgYWN0dWFsIHRhYmxl
Lg0KPiANCj4gU3RydWN0IHdpdGggY29tcGF0aWJsZSBkZXZpY2VzIHRhYmxlIHdhcyBpbmNsdWRl
ZCBzZXBhcmF0ZWx5IGluIGENCj4gcHJldmlvdXMgcGF0Y2ggYXQgY29tbWl0IGQ5ZTUzM2I2YzBh
MjZjN2VmODExNmI3ZjM0NzdjMTY0YzA3YmI2ZmIuDQo+IFllYWgsIEkgYWxzbyB0aG91Z2h0IGl0
IHdhcyBtaXNzaW5nIHRoZSBtYXRjaCB0YWJsZSB0aGUgZmlyc3QgdGltZSBJIHdhcw0KPiB0aGlz
IHBhdGNoLiBJdCdzIHJlYWxseSBjb25mdXNpbmcgd2hlbiB3ZSBoYXZlIHR3byBwYXRjaGVzLCBv
bmUNCj4gZGVwZW5kaW5nIG9uIGFub3RoZXIsIHRoYXQgYXJlIG5vdCBwYXJ0IG9mIHRoZSBzYW1l
IHBhdGNoIHNldC4gV2UncmUNCj4gdHJ5aW5nIHRvIGF2b2lkIHRoaW5ncyBsaWtlIHRoaXMgdGhl
IG1vc3QgYnV0IHRoYXQgc2xpcHBlZCBvdXQgZnJvbSBvdXINCj4gaW50ZXJuYWwgcmV2aWV3LiBX
ZSdyZSBzb3JyeSBhYm91dCB0aGF0Lg0KDQpObyB3b3JyaWVzLg0KDQpJdCBoYXBwZW5zIHRvIG1l
IHRvby4NCg0KVGhhbmtzDQpBbGV4DQoNCj4gDQo+ID4gDQo+ID4gPiAgICAgICAgIH0sDQo+ID4g
PiAgICAgICAgIC5wcm9iZSA9IGFkaXMxNjI0MF9wcm9iZSwNCj4gPiA+ICAgICAgICAgLnJlbW92
ZSA9IGFkaXMxNjI0MF9yZW1vdmUsDQo+ID4gPiAtLQ0KPiA+ID4gMi4yMC4xDQo+ID4gPiANCg==
