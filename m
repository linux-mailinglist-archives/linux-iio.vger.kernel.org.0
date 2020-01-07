Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4ABA132299
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgAGJgq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 04:36:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8410 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgAGJgp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jan 2020 04:36:45 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0079TxTi002880;
        Tue, 7 Jan 2020 04:36:43 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xaneaenfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 04:36:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0HsXCsziZyNdgyIPpBys4c487GTBHhDf4wOcqPNdaADQkMrkUz/fD/rjpMb58ofsNBz6zCyqWtVwNwBIAbJ2QqDnemJlGHnW0qmN36uqSK4SwPkkaNd00ekeDN+hFdWzfn4A+f1zh2x+h3THMJnHeAUBkGJPdkZ2qF/u89WvAuscslG9n2ffRYuc5pIMnYqmeRNnXpERIucrj8/cg8b6zAtwp524CvHNCc/ssTcAf3a9Jj4j58HwUykM6t4fKYFpzmk/4KfAueTgVYmss2NVhBVqgsRM5Sy5HMaZQ44+o2QnHELByqRbgFqBGBX+Ow+0D1velOOBYSHyu0PrLaQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP7oLjeZUvWthHSR01GGgTPwZjKhAXEVFc/06W0YZ9E=;
 b=aS5vd4eLoJr6kM/RYYN9UbgIuEpA9O4tucqs06qwLYFWsDUGTHD3LY0enh3Gk+oqmGGgPSloiX6iyDni808NhpzmL1b5XyWe18cGirq4XXSQBDAaOonuqIakP2GoTSv11OYHA0PmH+/0/cKn9ExcYSAf+OKzqA/z1XdsVeB4a74NUow5k1olnPxVFdtsEO+GC85AJOeE/ltJColmCwzHq5/eHZX0pMQhsssJbpc8tUMVrw9r0Hjhciv29B3Uf89j+LPjiXTq9kgpq3SHu19HD3CF/lbKM4FgO5rXKnIGlTa78wislJE1i2qUI25smVG8kZvnSYcVtQg+Q4UFGamxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP7oLjeZUvWthHSR01GGgTPwZjKhAXEVFc/06W0YZ9E=;
 b=K1SJzptCfyUKnLuuUhWO7nePYXxAdl/wlpvoHd+aQEd36Bor/L67BseU3J4CAb2Yv4Fpgx9aVDbpqoC3N6b2YoTkvtGHx8ozukha266NiYTJOx+E/dIgnLdoqquVpzyCynL27OtiDiSGYXb9a2LIONhOyGYaEde+33TpI+IFwo0=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (10.174.94.163) by
 BN6PR03MB3235.namprd03.prod.outlook.com (10.174.235.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 09:36:41 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 09:36:41 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: gyro: adi16136: construct adis data on probe vs
 static on driver
Thread-Topic: [PATCH 1/5] iio: gyro: adi16136: construct adis data on probe vs
 static on driver
Thread-Index: AQHVsc7hkRpTGyvey0WEfc10BPgG9ae7YwqAgAED+oCAIrGCAA==
Date:   Tue, 7 Jan 2020 09:36:41 +0000
Message-ID: <02afd05b9d1563bd1bb1bedf231e20c8363f23d3.camel@analog.com>
References: <20191213160312.1834-1-alexandru.ardelean@analog.com>
         <20191215161847.21c67f00@archlinux>
         <2a5ffffea57ec97d7dde766fb88a8297c5f2d448.camel@analog.com>
In-Reply-To: <2a5ffffea57ec97d7dde766fb88a8297c5f2d448.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0aac3032-1ec5-4794-0758-08d793551a23
x-ms-traffictypediagnostic: BN6PR03MB3235:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB3235359D6831126C663DEAA7993F0@BN6PR03MB3235.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(366004)(396003)(53754006)(199004)(189003)(81156014)(81166006)(2616005)(316002)(4001150100001)(8676002)(2906002)(110136005)(186003)(71200400001)(76116006)(86362001)(8936002)(5660300002)(66946007)(54906003)(64756008)(478600001)(66476007)(6636002)(6486002)(6512007)(66446008)(36756003)(4326008)(66556008)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3235;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m03mPmJxPy56r44ICi4bvkRn2QuECIt2uxsG/qv5Cp24BsDw3Co+WG4gUpPdWTwELOQ4SvPOUboyinhxFB2TuakIuUqLvwh6FTiRXizicgkDybDIrOWcwXN0XFtnS92aA4y1Q5IVolIqdbPOwqSamp98OZFtx5Eh9L4vvavZI4B7s42f9py27zk5PdLI29T37l9WBMdk7vjY9L/SKBCt9PBG7wwREA04ZWoOY6MQqHoZnkUK8gY13kNjIHvhZfQDNZYQWIkQW2D7cff66TqZEnS7vKGqcwMfgHUuVrh9phXIao0VOf5HlwoUjIywmgfN+aNTTxHUlO1DHicCL+tlVRfn1k+ONdNK2NEGMZVAMQHok1dM8zbDxAWtJKl1acIoehW+oZ5uoXJT7qmytbO3urd/QQ+VRisXfdDkBYz25B18Q2YLx/eT99asdrpXP9C3FT9Vvan9IQC6slutHpYYzG6DkrGOaK9vFTZuHl2vFm+EIzAliSKaiNPwJbRIu/C7
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D82380EF0F9034A9893327F1A4144A6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac3032-1ec5-4794-0758-08d793551a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 09:36:41.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNPubAHENE81frOqV3T5e+eO6CCqPIcWEbDd10ugx2nwzhr0g8ZjCrskqhILon/3M9MDwDtATqcGn9AKk3BvIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3235
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_02:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070078
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgYWxsLA0KDQpPbiBNb24sIDIwMTktMTItMTYgYXQgMDc6NDkgKzAwMDAsIEFyZGVsZWFuLCBB
bGV4YW5kcnUgd3JvdGU6DQo+IE9uIFN1biwgMjAxOS0xMi0xNSBhdCAxNjoxOCArMDAwMCwgSm9u
YXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIDEzIERlYyAyMDE5IDE4OjAz
OjA4ICswMjAwDQo+ID4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5h
bG9nLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBUaGlzIGNoYW5nZSBpcyBkb25lIGluIHByZXBh
cmF0aW9uIG9mIGFkZGluZyBhbiBgc3RydWN0DQo+ID4gPiBhZGlzX3RpbWVvdXRgDQo+ID4gPiB0
eXBlLg0KPiA+ID4gU29tZSBBRElTIGRyaXZlcnMgc3VwcG9ydCBtdWx0aXBsZSBkcml2ZXJzLCB3
aXRoIHZhcmlvdXMNCj4gPiA+IGNvbWJpbmF0aW9ucw0KPiA+ID4gb2YNCj4gPiA+IHRpbWVvdXRz
LiBDcmVhdGluZyBzdGF0aWMgdGFibGVzIGZvciBlYWNoIGRyaXZlciBpcyBwb3NzaWJsZSwgYnV0
DQo+ID4gPiB0aGF0DQo+ID4gPiBhbHNvDQo+ID4gPiBjcmVhdGVzIHF1aXRlIGEgbG90IG9mIGR1
cGxpY2F0aW9uLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPDoSA8bnVuby5z
YUBhbmFsb2cuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxh
bGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiANCj4gPiBUaGVyZSBhcmUgY29uc2lk
ZXJhYmxlIGFkdmFudGFnZXMgdG8gdXNpbmcgY29uc3RhbnQgc3RydWN0dXJlcywNCj4gPiAoc2Vj
dXJpdHkgLSBub3QgdGhhdCByZWxldmFudCBoZXJlIHByb2JhYmx5LCBYaVAsIGdlbmVyYWwNCj4g
PiByZWFkYWJpbGl0eSkNCj4gPiANCj4gPiBTbyB0byB0YWtlIGEgc2VyaWVzIGxpa2UgdGhpcyBJ
IHdhbnQgdG8gc2VlIGV2aWRlbmNlIHRoYXQgaXQgbWFrZXMNCj4gPiBhIHNpZ25pZmljYW50IGRp
ZmZlcmVuY2UuICBTbyBmYXIgeW91IGp1c3QgaGF2ZSBjYXNlcyB3aGVyZSB3ZSBlbmQNCj4gPiB1
cA0KPiA+IHdpdGggYSB3b3JzZSByZXN1bHQuICBNb3JlIGNvZGUsIGhhcmRlciB0byByZWFkLi4u
DQo+ID4gDQo+ID4gSGVuY2UgaXQgd2lsbCB0YWtlIGEgbG90IHRvIHBlcnN1YWRlIG1lIHRvIHRh
a2UgdGhpcyBzZXJpZXMgd2l0aG91dA0KPiA+IHRoZSBmb2xsb3cgdXAgcGF0Y2hlcyB3aGVyZSBJ
IGFzc3VtZSBzaWduaWZpY2FudCBhZHZhbnRhZ2VzIGFyZQ0KPiA+IHNlZW4uDQo+ID4gDQo+IA0K
PiBXZWxsLCB3ZSd2ZSBoYXZlIHNvbWUgZGlzY3Vzc2lvbiBhYm91dCB0aGlzLCBhbmQgaG93IHRv
IGRvIGl0Lg0KPiBUaGVyZSBhcmUgc2V2ZXJhbCBhbHRlcm5hdGl2ZXMuDQo+IA0KPiBTb21lIG9m
IHRoZSBpZGVhcyB3ZXJlOg0KPiAxLiBLZWVwIHRoZSBzdGF0aWMgZGF0YSBhbmQgY2xvbmUgaXQg
KyBwb3B1bGF0ZSB0aGUgYWRpc190aW1lb3V0IGRhdGENCj4gYXMNCj4gbmVlZGVkIGR1cmluZyBw
cm9iZSBbYmFzZWQgb24gZWFjaCBkZXZpY2UncyBjaGlwLWluZm9dDQo+IDIuIFJld29yayBhbGwg
dGhlIGNoaXAtaW5mbyBkYXRhIHRvIGluY2x1ZGUgdGhlIGFkaXNfZGF0YSB0eXBlcy9pbmZvDQo+
IA0KPiAyLiBtYXkgcmVxdWlyZSBtb3JlIHdvcmsgOyAxLiByZXF1aXJlIGZld2VyIHBhdGNoZXMN
Cj4gDQo+IFRoaXMgaW1wbGVtZW50YXRpb24gW2luIHRoaXMgc2VyaWVzXSBpcyAxLiBidXQgd2l0
aG91dCBrZWVwaW5nIHRoZQ0KPiBzdGF0aWMNCj4gZGF0YSBhbmQgdGVtcGxhdGUuDQo+IEkgZ3Vl
c3MgdGhlIGlkZWEgd2FzIHRvIHJlZHVjZSBtZW1vcnkgdXNhZ2UgW2J5IGtlZXBpbmcgdGhlIHN0
YXRpYw0KPiBkYXRhXS4gSQ0KPiBhZG1pdCB0aGUgbWVtb3J5IHVzYWdlIGlzIG5vdCB0aGF0IGJp
Zy4NCj4gDQo+IEknbGwgdGFrZSBhIGxvb2sgYXQgdGhpcyBhZ2FpbiwgYW5kIHNlZSBpZiAyLiBj
YW4gd29yayBtb3JlIG5pY2VseS4NCj4gSXQgbWlnaHQgYmUgdGhhdCAxLiB3b3VsZCBiZSB0aGUg
ZW5kLXJlc3VsdCwgYnV0IHdobyBrbm93cz8NCj4gDQo+IFRoYW5rcw0KPiBBbGV4DQoNCkkgZ3Vl
c3Mgd2UgYWxzbyBuZWVkIHRvIHByZXBhcmUvc2VuZCB0aGUgZm9sbG93aW5nIHBhdGNoZXMgdG8g
c2hvdw0KSm9uYXRoYW4gd2h5IHdlIG5lZWQgdG8gZHluYW1pY2FsbHkgYWxsb2NhdGUgdGhlIGRh
dGEgc3RydWN0dXJlIGluIHNvbWUNCmRyaXZlcnMuIEluIHRoZSBlbmQgaXMgYmVjYXVzZSBzb21l
IGRldmljZXMgcmVxdWlyZSBkaWZmZXJlbnQgdGltZW91dHMNCihoYW5kbGVkIGJ5IHRoZSBhZGlz
IGNvcmUgbGlicmFyeSkgdGhhbiB0aGUgb3RoZXJzIGFuZCwgaW4gc29tZSBjYXNlcw0KdGhlc2Ug
ZGlmZmVyZW5jZXMgYXJlIHF1aXRlIHNpZ25pZmljYXRpdmUuIEl0IHdhcyBldmVuIGhhcHBlbmlu
ZyB0aGF0DQppbiBzb21lIGNhc2VzLCB3ZSB3ZXJlIG5vdCBzbGVlcGluZyBlbm91Z2ggdGltZSAo
ZWc6IGFmdGVyIGEgcmVzZXQNCmNvbW1hbmQpLiBJbiB0aGUgbmV4dCBwYXRjaGVzLCBhIHRpbWVv
dXQgc3RydWN0dXJlIGlzIGluY2x1ZGVkIHRoYXQNCm5lZWRzIHRvIGJlIGZpbGxlZCBmb3IgZWFj
aCBkZXZpY2UuDQoNCkFsZXgsIG1heWJlIHdlIHNob3VsZCBpbmNsdWRlIG1vcmUgcGF0Y2hlcyBp
biB0aGlzIHNlcmllcyB0byBzaG93IHRoZQ0KImJpZyBwaWN0dXJlIiBhbmQgdGhlbiB3ZSBjYW4g
ZGlzY3VzcyBpZiB0aGlzIGlzIHRoZSBiZXN0IGFwcHJvYWNoLg0KDQpOdW5vIFPDoQ0K
