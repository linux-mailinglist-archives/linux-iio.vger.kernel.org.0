Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36416827D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 16:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBUP7j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 10:59:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16992 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728235AbgBUP7j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 10:59:39 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LFiFn3018109;
        Fri, 21 Feb 2020 10:59:37 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8ucu7juy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 10:59:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv6gT8d3VCZ3pisH52iOjLlpyfUI5NJqOpDdeHQ2ApU2VikQkWwJpnXqoI08nx0+pRjnUkywE4Tqtdwu/rr7xeXmIzbIHnHf8lYDqE5gRV3gJUrBcM5Cq3PW5EtKRpR79b8cnl3Bo11Oq1/ENVW5Z4FWVeymylLxVy+IAfHx0eC71KzyH9h7va9HKcnPc9lYRluKs/kIYZ95oFTs35CSj1cqZDK7Oq2CgG9vneftgyl2czwKTUh7GoN7sOlC5j/LsDTJGig9DM5AROtpP+80EI6kcGD/XHm58a/25Z++IeqkLlUbkOC+h93KTDovcHCkllHE22elEDVHbdlVU1uyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98QCTJjbVsN2gR3Op8+mpd/gmOdTs1fDfBxqky5ZbPQ=;
 b=l6XnNwLFfUfmMaRw/uhK3vRzOLgiukObEkQASFqa7ATJRqf1gTurm24kilaVGzwY888F8Qygd7nY31jp03uhLT9aocBQvDltkGDptNyXShmKw3Z53UhdqTQzOXEXmya5OfDhk6cvOg4QvlnB5E9fOvpgBYHPuyYu0WIjv9pXHwu6KWfIp8IQqV7p67/8S6fwSCu+/fyLVUIrJEvCktLPXztp5kGDsUMYkgzMtyqfv/8jrae88Dfvzk5JFi5B8w9FYrvbV3bsebCvNcS+T3Nz79HEKmdnU9dB4pjWAxWM9kl4fPgC/PZ2JNiCTwPWw+4UatCc1QPxEZCXFslYudXckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98QCTJjbVsN2gR3Op8+mpd/gmOdTs1fDfBxqky5ZbPQ=;
 b=79ii5LQVfo2k9jc+ttyJl/4c5QRbuocOFVTZtUJg9FtaSuM8f4GKpjxTNcokiOBSsw+X/oZ/l+j+q48l206CdPJThV8X2gIdyT+wqtuRAaaBbiFn3jgPAROdps+ABJBUAWPNnfKjt5gpmDuFzexIyCAgHRkB1Z7EoQTW9rS76mw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5317.namprd03.prod.outlook.com (2603:10b6:610:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 21 Feb
 2020 15:59:35 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 15:59:35 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: imu: adis: add doc-string for 'adis' struct
Thread-Topic: [PATCH 1/3] iio: imu: adis: add doc-string for 'adis' struct
Thread-Index: AQHV6Kyqh2DoHgggAUWjgbyiyGgv6Kgln5YAgAAu4gA=
Date:   Fri, 21 Feb 2020 15:59:35 +0000
Message-ID: <414d7e293b75e556ce857e0ce985a0f89fb24ffd.camel@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
         <20200221131146.2213e8e1@archlinux>
In-Reply-To: <20200221131146.2213e8e1@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e03b09dc-414e-413d-667e-08d7b6e70c07
x-ms-traffictypediagnostic: CH2PR03MB5317:
x-microsoft-antispam-prvs: <CH2PR03MB5317C2AABDA2ED3F819DBAEDF9120@CH2PR03MB5317.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(26005)(186003)(81156014)(6916009)(2906002)(4326008)(81166006)(6506007)(6486002)(8676002)(5660300002)(71200400001)(36756003)(54906003)(91956017)(76116006)(6512007)(66476007)(478600001)(66446008)(86362001)(316002)(64756008)(8936002)(66556008)(2616005)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5317;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2HVrWNkRx0HVrLJdHKHtkQC+fbJMph5igCvkxl6AKfd4UVoCN4MO5SyVbfLpJz+J5XZ/Z2LU1qDaAr5Csl42cGByDrh28P3fwVCr1m2607qnxG8SbMMfb/o0SIWA30+fR9GMtfPDAe74oqkP7P1rSEInDNOfndV8Ievh9tFdWoFSFJIvgqbbziPCLRbZ/H8I7v611gQobWFWXTr8OGIwBSQMTaMStiOYQV/hrwwbJ2KjHWJsbMaZNBBCgutLIlf+JbJX86QevXYU/UowTWIpxH5Jah6ahB2mJ56XRSVcs+lgt0zyzGE+HvFhaIIRlltnLsY08wX7tktA4U/gnANJhmj4kPZexaTbn1wB84OXIo+A32hZ39zGlJnFhWjpIezVqoRmIbu6puMZa+r/6nhYfDvlye4mAg9HHATaSsSv/WmRak33gGUCUafPc9fe2qH
x-ms-exchange-antispam-messagedata: jIrwcK+7d8jYVqx9dR59JIsI4hatASNtQmVvB5naDAaPGCE6z1E1wrHgbYqFN9lTXsgdLIc/cr+fZgKlEy5yxr5WnsOICNb3A3ghfXL7a3DxyNQelP1kjOobjfeIxxExYx7IXHSoPn8a1umwEHIYwg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <03275B5AD207B345B40FD8F7AB89A246@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03b09dc-414e-413d-667e-08d7b6e70c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 15:59:35.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmWUHfmmijqzSqJUbTeNLKc8B6CYPkO26M3WM+ldBWuwlXuOuMuzuG3kWfULJLEBVa2tyi4pjJPkMHZ6NxlItlyKBqsd7jbTvFliK80xbkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_05:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTIxIGF0IDEzOjExICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDIxIEZlYiAyMDIwIDEzOjQ5OjQxICswMjAwDQo+IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlz
IGNoYW5nZSBhZGRzIGEgZG9jLXN0cmluZyBmb3IgdGhlICdhZGlzJyBzdHJ1Y3QuIEl0IGRldGFp
bHMgdGhlIGZpZWxkcw0KPiA+IGFuZCB0aGVpciByb2xlcy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0K
PiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oIHwgMTQgKysrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMuaCBiL2luY2x1ZGUvbGludXgv
aWlvL2ltdS9hZGlzLmgNCj4gPiBpbmRleCBhYzdjZmQwNzM4MDQuLjA3ODdhM2FhYmQwNSAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9paW8vaW11L2FkaXMuaA0KPiA+IEBAIC03Myw2ICs3MywyMCBAQCBzdHJ1Y3Qg
YWRpc19kYXRhIHsNCj4gPiAgCWJvb2wgaGFzX3BhZ2luZzsNCj4gPiAgfTsNCj4gPiAgDQo+ID4g
Ky8qKg0KPiA+ICsgKiBzdHJ1Y3QgYWRpcyAtIEFESVMgZGV2aWNlIGluc3RhbmNlIGRhdGENCj4g
PiArICogQHNwaTogUmVmZXJlbmNlIHRvIFNQSSBkZXZpY2Ugd2hpY2ggb3ducyB0aGlzIEFESVMg
SUlPIGRldmljZQ0KPiA+ICsgKiBAdHJpZzogSUlPIHRyaWdnZXIgb2JqZWN0IGRhdGENCj4gPiAr
ICogQGRhdGE6IEFESVMgY2hpcCB2YXJpYW50IHNwZWNpZmljIGRhdGENCj4gPiArICogQGJ1cnN0
OiBBRElTIGJ1cnN0IHRyYW5zZmVyIGluZm9ybWF0aW9uDQo+ID4gKyAqIEBzdGF0ZV9sb2NrOiBM
b2NrIHVzZWQgYnkgdGhlIGRldmljZSB0byBwcm90ZWN0IHN0YXRlDQo+ID4gKyAqIEBtc2c6IFNQ
SSBtZXNzYWdlIG9iamVjdA0KPiA+ICsgKiBAeGZlcjogU1BJIHRyYW5zZmVyIG9iamVjdHMgdG8g
YmUgdXNlZCBmb3IgYSBAbXNnDQo+ID4gKyAqIEBjdXJyZW50X3BhZ2U6IFNvbWUgQURJUyBkZXZp
Y2VzIGhhdmUgcmVnaXN0ZXJzLCB0aGlzIHNlbGVjdHMgY3VycmVudA0KPiA+IHBhZ2UNCj4gPiAr
ICogQGJ1ZmZlcjogRGF0YSBidWZmZXIgZm9yIGluZm9ybWF0aW9uIHJlYWQgZnJvbSB0aGUgZGV2
aWNlDQo+ID4gKyAqIEB0eDogQ2FjaGVsaW5lIGFsaWduZWQgVFggYnVmZmVyIGZvciBTUEkgdHJh
bnNmZXJzDQo+ID4gKyAqIEByeDogQ2FjaGVsaW5lIGFsaWduZWQgUlggYnVmZmVyIGZvciBTUEkg
dHJhbnNmZXJzDQo+IA0KPiBUaGlzIGxhc3Qgb25lIGlzbid0IHRydWUuLiANCg0KT2ggcmlnaHQu
DQpJIG5vdGljZWQgdGhpcyBhdCBzb21lIHBvaW50LCB0aGVuIGZvcmdvdCBhYm91dCBpdC4NClsg
VGhlICJqb3lzIiBvZiBtdWx0aS10YXNraW5nOyBzb3JyeSBhYm91dCBpdCA6KSBdDQpJIGd1ZXNz
IEkgc2hvdWxkIGFsc28gYWRkIGEgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgbWFraW5nIGl0IGNhY2hl
bGluZS1hbGlnbmVkLg0KSSBkb24ndCBzZWUgYSByZWFzb24gd2h5IG5vdC10byBbdW5sZXNzIEkg
YW0gbWlzdW5kZXJzdGFuZ2luZyBzb21ldGhpbmddDQoNCg0KPiANCj4gPiArICovDQo+ID4gIHN0
cnVjdCBhZGlzIHsNCj4gPiAgCXN0cnVjdCBzcGlfZGV2aWNlCSpzcGk7DQo+ID4gIAlzdHJ1Y3Qg
aWlvX3RyaWdnZXIJKnRyaWc7DQo=
