Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043871A5EF9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDLOXu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 10:23:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25528 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgDLOXu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 10:23:50 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03CEF3qb010218;
        Sun, 12 Apr 2020 10:23:48 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 30b7r5tpsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Apr 2020 10:23:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb/d6clRqqtwREZjGMSzrlpJ8+7wXJ3HMTjNsZSp9O0AVHxjPGCUQB3aogMONmZDxOxs4VbYYt4kI+/osG/cbWP6Dl5gqOi2iHVK4u/+jIyZsKVCf1y18F/peU6uAanWnyxAMwD3jz/ZmthclXHAnhu0aLv6TILhZB6zyFuZmw2PSJSWZGoyVOzw8QnXbsZYBbrxFJOIP6gkIw2HRJFRC6x+lilR6/8wLYmZfKiSK3tFMxEz70h4pl56zNtWRDsle7csUbl2haluXPQ4kdWKJCw8HsyGEalb3Fb8B3M2CAo+LaYnL4ljRNj3ifJrHyQFt5ThpM6k+CCo5ZcsQ//2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZk0lU489Lu2YU8nnfysLHevKaVaUX5H3C/4iH4CQc8=;
 b=oO9ydb5wJxLtU0G8oKlpugOQv1H99thnYhalW346ZkAKNZgH0T4yHb6co/uglsTYgqpmR5EhqdPGL5D/EDJSHrJnwvQgcgGiOKi1JVy/NAeShTmTY3WUk37tkhWdd6BbKUkRIcKM4StDtWjvDVXaMN5PvEMNHWLY3UwqvETIvzAlB+trHpBGLCDGCssgpbS9Wt9VS2iaiQ+z8jfHBeT0aPsD+1WskQEODakBjFtMZfVjBVFrmLTmbdkG4C6box8bpKD5tCUtYGjJoVcYCXKfsWunngBE4PqbGQNiciRR4mgUakufCgQQYcuXEGB464LkCt8HStGDQUENKdJaYh7zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZk0lU489Lu2YU8nnfysLHevKaVaUX5H3C/4iH4CQc8=;
 b=ZOD/PvBVgXWGJD5NwhJqvHvsdH1QRaDy7z1H5E0RBlVKAI/1i1HBBBagVDtZ3eqj7cGZKeu4RkXQ00mcGGNwgZoBwg57s52gw5HTQZLotoOnF6NcRIXSgHi4RfSjLBeXCZqFbQwUGzb8NDEAjYP3khHfUDWcY7YfmpI0E6vUaw0=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5321.namprd03.prod.outlook.com (2603:10b6:5:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sun, 12 Apr
 2020 14:23:45 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 14:23:45 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ad7192: fix null pointer de-reference crash
 during probe
Thread-Topic: [PATCH v2] iio: adc: ad7192: fix null pointer de-reference crash
 during probe
Thread-Index: AQHWEL7oPwlkSMrc+EWqAlalDvmxCqh1i4mA
Date:   Sun, 12 Apr 2020 14:23:45 +0000
Message-ID: <16dbf099b4f9e026b141ae26661d2615084e3016.camel@analog.com>
References: <20200406123109.56947-1-alexandru.ardelean@analog.com>
         <20200407063310.85466-1-alexandru.ardelean@analog.com>
         <20200412123828.6fa25008@archlinux>
In-Reply-To: <20200412123828.6fa25008@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e6a513b-2f7e-4d9e-89d1-08d7deed1c35
x-ms-traffictypediagnostic: DM6PR03MB5321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB53213BAB3FDC7DC4C0F32FF9F9DC0@DM6PR03MB5321.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(346002)(376002)(39850400004)(366004)(136003)(8936002)(316002)(64756008)(66476007)(66446008)(66556008)(2616005)(91956017)(2906002)(71200400001)(5660300002)(8676002)(76116006)(66946007)(478600001)(6506007)(86362001)(6486002)(6512007)(186003)(4326008)(54906003)(26005)(36756003)(6916009)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qg1eqRjl5USxpvJLiiLXGyUrfEYvi7ptLVR6olStJfMyAQDc1Iae5/FD7VcGxCrriWHq4mtofqCc9OO8R/cSM0E1+kogKwhYPHmFF3f/3lYONypZ/RQDySgSRLI+h+Tq/nUPEhrxUzo8rT2ftlu2J6KPbAJ2QQacgmqH7v5vpIMLjFqStM0yMlzQ3dm+GIojvzjtK8azwXjhlKqrKVtCTg1iFh6mRSIo7SM5aPwfhbourGXlKEimcfBJd3dahhVayVmvd4yt2HXZN5oCr72nZEv9Nt12ec/HdbInuBFPbOR4ft8bETizZrv+1oxcjOxDvZ0wjLtG+scD4VQkRYMDROMwC9CMtzBcd6/5UtSay6UoUAOKh1hNai7Ivh4fHuU1iANBZnnJ1PmUvO83RBE6xvplELRoF8TiW7DZMFlIZB8yUSnMT99TGiM10G/P9wMq
x-ms-exchange-antispam-messagedata: AsQFTP0JplGHko09+xhb5JZZIb0K4o4pYh38pbm25D4q2AlN9XRAKsT2R6lXs3i9uCmIt6ZxmPgNa+LY12w6EMiwf3BLNAAZM+SpSZxzl6ycrnzeVAF45ddeUzzeNcqIGhS9Ni3RpMVHeMPb5eFaUg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BEF79AE77F144687ADE12CA6C078FA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6a513b-2f7e-4d9e-89d1-08d7deed1c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2020 14:23:45.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vdtSQJHVl1RaAwdRXN3HEAmviLiOgnbh/LX9JTCzbO97DKoYkKwGAwIJ4A8aoVLBVEIzz5xJLLvGOqArqxNQSszw16OFMzjo0IMLkYnx3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5321
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-12_02:2020-04-11,2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120129
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTEyIGF0IDEyOjM4ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDcgQXByIDIwMjAgMDk6MzM6MTAgKzAzMDAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IFdoZW4gdGhlICdzcGlfZGV2aWNlX2lkJyB0YWJsZSB3YXMgcmVtb3ZlZCwg
aXQgb21pdHRlZCB0byBjbGVhbnVwL2ZpeCB0aGUNCj4gPiBhc3NpZ25tZW50Og0KPiA+ICAgJ2lu
ZGlvX2Rldi0+bmFtZSA9IHNwaV9nZXRfZGV2aWNlX2lkKHNwaSktPm5hbWU7Jw0KPiA+IA0KPiA+
IEFmdGVyIHRoYXQgcGF0Y2ggJ3NwaV9nZXRfZGV2aWNlX2lkKHNwaSknIHJldHVybnMgTlVMTCwg
c28gdGhpcyBjcmFzaGVzDQo+ID4gZHVyaW5nIHByb2JlIHdpdGggbnVsbCBkZS1yZWYuDQo+ID4g
DQo+ID4gVGhpcyBjaGFuZ2UgYXNzaWducyB0aGUgJ2NvbXBhdGlibGUnIHN0cmluZyBmcm9tIHRo
ZSBEVCB0YWJsZSwgYXMgdGhlIG5ldw0KPiA+ICdpbmRpb19kZXYtPm5hbWUnLiBBcyBzdWNoLCB0
aGUgbmV3IGRldmljZS9wYXJ0IG5hbWUgbm93IGxvb2tzIGxpa2UNCj4gPiAnYWRpLGFkNzE5eCcs
IGFuZCBub3cgaGFzIHRoZSB2ZW5kb3IgcHJlZml4Lg0KPiA+IA0KPiA+IE5vdGUgdGhhdCB0aGlz
IGNoYW5nZSBpcyBub3QgZG9pbmcgYW55IE5VTEwgY2hlY2sgdG8gdGhlIHJldHVybiB2YWx1ZSBv
Zg0KPiA+ICdvZl9tYXRjaF9kZXZpY2UoKScuIFRoaXMgc2hvdWxkbid0IGhhcHBlbiwgYW5kIGlm
IGl0IGRvZXMgaXQncyBsaWtlbHkgYQ0KPiA+IGZyYW1ld29yayBlcnJvciBvbiB0aGUgcHJvYmUg
c2lkZS4NCj4gPiANCj4gPiBGaXhlczogNjY2MTRhYjJiZTM4ICgic3RhZ2luZzogaWlvOiBhZGM6
IGFkNzE5MjogcmVtb3ZlZCBzcGlfZGV2aWNlX2lkIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiANCj4gSG1t
LiBSZXR1cm5pbmcgdGhlIGNvbXBhdGlibGUgaXNuJ3QgY29tcGF0aWJsZSB3aXRoIHRoZSBBQkku
DQoNCmkgd2FzIGEgYml0IHZhZ3VlIG9uIHdoZXRoZXIgcGFydC1uYW1lIGNhbiBjb250YWluIHZl
bmRvciBwcmVmaXggW2luIHRlcm1zIG9mDQpBQkldOw0KY2hhbmNlcyBhcmUgcmVhbGx5IGxvdyB0
aGF0IGEgcGFydC1uYW1lIGZyb20gdmVuZG9yIEEgY291bGQgY29sbGlkZSB3aXRoIHBhcnQtDQpu
YW1lIGZyb20gYSB2ZW5kb3IgQg0KDQo+IA0KPiBJIHRoaW5rIHdlIHdpbGwgaGF2ZSB0byBpbnRy
b2R1Y2UgYSBiaXQgb2YgaW5kaXJlY3Rpb24gaGVyZSB0bw0KPiBhbGxvdyBmb3IgYSAnY2hpcCBp
bmZvJyB0eXBlIHN0cnVjdHVyZSB3aXRoIHRoZSBuYW1lIGFuZCB0aGUgbWFnaWMgSUQgdmFsdWUN
Cj4gdGhhdCBpcyBjdXJyZW50bHkgaW4gdGhlIGRhdGEgZmllbGQgb2YgdGhlIG9mX2RldmljZV9p
ZCB0YWJsZS4NCg0KaSdsbCBkbyB0aGF0IGZvciBWMg0KDQo+IA0KPiBUaGF0IHdheSB3ZSBjYW4g
aGF2ZSB0aGUgbmFtZSBleHBsaWNpdC4gICBOb3RlIEkgZG9uJ3Qgd2FudCB0bw0KPiBtZXNzIGFy
b3VuZCB3aXRoIHN0cmlwcGluZyB0aGUgcHJlZml4IG9mZiB0aGUgY29tcGF0aWJsZSBhcyB0aGF0
IHNvcnQgb2YNCj4gdGhpbmcgaXMgaGFyZCB0byByZWFkLg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+
ID4gLS0tDQo+ID4gDQo+ID4gQ2hhbmdlbG9nIHYxIC0+IHYyOg0KPiA+ICogZml4IGNvbG9uIGZv
ciBGaXhlcyB0YWcNCj4gPiAqIHVwZGF0ZWQgY29tbWl0IHRpdGxlIGEgYml0OyB0byBtYWtlIGl0
IGxvbmdlcg0KPiA+IA0KPiA+ICBkcml2ZXJzL2lpby9hZGMvYWQ3MTkyLmMgfCA3ICsrKysrLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jIGIvZHJpdmVycy9p
aW8vYWRjL2FkNzE5Mi5jDQo+ID4gaW5kZXggOGVjMjhhYThmYThhLi4wMDM5YTQ1ZTFmMzMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jDQo+ID4gKysrIGIvZHJpdmVy
cy9paW8vYWRjL2FkNzE5Mi5jDQo+ID4gQEAgLTg4OCw2ICs4ODgsNyBAQCBNT0RVTEVfREVWSUNF
X1RBQkxFKG9mLCBhZDcxOTJfb2ZfbWF0Y2gpOw0KPiA+ICANCj4gPiAgc3RhdGljIGludCBhZDcx
OTJfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiAgew0KPiA+ICsJY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCAqb2ZfaWQ7DQo+ID4gIAlzdHJ1Y3QgYWQ3MTkyX3N0YXRlICpzdDsN
Cj4gPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ID4gIAlpbnQgcmV0LCB2b2x0YWdl
X3V2ID0gMDsNCj4gPiBAQCAtOTM3LDEwICs5MzgsMTIgQEAgc3RhdGljIGludCBhZDcxOTJfcHJv
YmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiAgCQlnb3RvIGVycm9yX2Rpc2FibGVfYXZk
ZDsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gKwlvZl9pZCA9IG9mX21hdGNoX2RldmljZShhZDcxOTJf
b2ZfbWF0Y2gsICZzcGktPmRldik7DQo+ID4gKw0KPiA+ICAJc3BpX3NldF9kcnZkYXRhKHNwaSwg
aW5kaW9fZGV2KTsNCj4gPiAtCXN0LT5kZXZpZCA9ICh1bnNpZ25lZCBsb25nKW9mX2RldmljZV9n
ZXRfbWF0Y2hfZGF0YSgmc3BpLT5kZXYpOw0KPiA+ICsJc3QtPmRldmlkID0gKHVuc2lnbmVkIGxv
bmcpb2ZfaWQtPmRhdGE7DQo+ID4gIAlpbmRpb19kZXYtPmRldi5wYXJlbnQgPSAmc3BpLT5kZXY7
DQo+ID4gLQlpbmRpb19kZXYtPm5hbWUgPSBzcGlfZ2V0X2RldmljZV9pZChzcGkpLT5uYW1lOw0K
PiA+ICsJaW5kaW9fZGV2LT5uYW1lID0gb2ZfaWQtPmNvbXBhdGlibGU7DQo+ID4gIAlpbmRpb19k
ZXYtPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7DQo+ID4gIA0KPiA+ICAJcmV0ID0gYWQ3MTky
X2NoYW5uZWxzX2NvbmZpZyhpbmRpb19kZXYpOw0K
