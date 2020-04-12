Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB81A5EF3
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgDLOVg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 10:21:36 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:62370 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbgDLOVg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 10:21:36 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03CELXEX011172;
        Sun, 12 Apr 2020 10:21:33 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7najden-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Apr 2020 10:21:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJQiUs2ga83W/7hJMYbBAHm8v+Yj8JR/b3CuaFNV4wVs5RIz1fpN7FmroooX4zRNBZZ3obzQF/s2hzjP7oBAuWXXUlYiSPmtiJDYMrF8Q0rh4clYNcdt6raZXCNPZK25Yb/QhkPkKO+heDvKlVxNTTjjJlXsSsZ05vdkWtiE+aVRmS63MEGP4mMdTo+0W+xTCdhaeS4zEGSvWpAIBx6j3LnbFfalYoGJ2hAbUrte1fPD9FXkOdzQy7GBDnNcBacX8ZEpi74HFBs0jlmLnm45wlCrO0st+BDx3EYJ1b3N78LBswYF7SOVc9cQPv/VBvywGaY3vOt89vcNnNLsHS4YdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Twu+SLtsq5CKTUf7CPieBFBSiO3evonOCSDNgAJek=;
 b=WzDa31xWlA0bahudnFmQ1IpoJcQn+q0n6iuIqepOZD8nK6KTCD3Ng5ZHpwbAVhojtX0Jn9p0Zg8a4ODs5kngTXaMoCHT06VraoCgM5qd4QwC0OoeN/q1cyF+fW9SUPCv1v/3SerHdLHiLrq5IZKNIVi+DY1LSEdvzZcAkLCajBxxCLCFOslzSsWUTGumBxXyhMS+/65bbgbFv/FyF9Z+raQuj//XN9+9mReSEHkJS9fjLkSkbTBxO10w5I1ywiEvAN/m9Bim7PQ4Rf47uIdgiIhcNd1tnkQ/xj+LCpZJ9iiYGJVTKe+Yqgej40KYOukTcWvLDJYAVXifwriKhPExFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Twu+SLtsq5CKTUf7CPieBFBSiO3evonOCSDNgAJek=;
 b=83NPBz1NSVW7qHrTdFPcm6BuCVmOqQcEwi6znnAF6Ng5Xjw9brrqfSgpmFsqe8otMKRYqdNgTcexiCr/B3hVUuWj7JFdfGO2zEQYmB1lJpftKpgJysgrsEV2q97NAHu+cVNK/UwBzQ8EFgLObPctGw4gKFchYywlqZ3NGkl/9Ko=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3466.namprd03.prod.outlook.com (2603:10b6:5:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sun, 12 Apr
 2020 14:21:30 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 14:21:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 8/8] iio: buffer: drop devm_iio_kfifo_free() API call
Thread-Topic: [PATCH 8/8] iio: buffer: drop devm_iio_kfifo_free() API call
Thread-Index: AQHWEMpyNS2su2vqxE+utAAXG3Qm7Kh1itCA
Date:   Sun, 12 Apr 2020 14:21:30 +0000
Message-ID: <cb04d59306f79d0d978d22f545a2b129e82e9738.camel@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
         <20200227135227.12433-8-alexandru.ardelean@analog.com>
         <20200412140104.0f30a475@archlinux>
In-Reply-To: <20200412140104.0f30a475@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 421ca5da-ae57-402c-ad64-08d7deeccb83
x-ms-traffictypediagnostic: DM6PR03MB3466:
x-microsoft-antispam-prvs: <DM6PR03MB3466479D7DD504181BA8215BF9DC0@DM6PR03MB3466.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39850400004)(346002)(396003)(376002)(136003)(366004)(26005)(4326008)(6916009)(186003)(2906002)(36756003)(6512007)(478600001)(6486002)(6506007)(316002)(5660300002)(66446008)(81156014)(86362001)(64756008)(66946007)(54906003)(8676002)(2616005)(71200400001)(8936002)(66476007)(66556008)(91956017)(76116006);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNUETmOsStIEFgYp6R/Rm8kVMenR9Xfl4ae6vh3dUxW1lThymzs2G8S5r3x/pxg2CMgL3sqQl+QW2DBck9t9r3AEtcpK5arDSbBtKVOnzqwjcKnorZNAb681bOdeWpBvL2NCLMGOu4bVyTjp5GcaWCBaudVPbookW9rrvwcyF9xB8fzJ2A0533St0Q6lmb7MqBUZCCizbo7Hdm/EGYxgyL4wA0bPnePF3mrB8I1tGO3BaVGU6qN5V5EWu2SuL4W2ey7zYUTc8uucCznJCLfQRnTYxbXHDyZ22qFppEOgvopxEKVWs2IvNBb1ScAGT6CpwrC4T9aObvvprXq8MfzVLh4RS12YDqN3bnAfO2nWTfT8yDFuHwEdYnj3FHUwNRIMXI5myrsdyK0zbEGSR7+d8ajvxl5reBuoGuG2arUba2ofdLeaOlKvr+Zcgw3DlA64
x-ms-exchange-antispam-messagedata: EFdHLo/Uwe11xMLMltYlOyLMcNaH23QUw5Y7765bxpWl9tn0OJAJEX1lATuAIS/F7BwDT7c80zdj1Pk7oVi5DVe7cwufk5P+WD/t4VkJXr1OWA9b+jhUkpuGSvoFBaYnex11+gr5CTeyipTlG8I9xA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8109743335FDF4AB48843657B85D655@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421ca5da-ae57-402c-ad64-08d7deeccb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2020 14:21:30.3707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yi4xaolkyEx1z8nG7/BSUPEM8NfcW31RZ5lDTVicEAB6S3AsqlVpWVAMQ+F2DKPvOVWhD5Tj1Ccan68OC3HIvGCRu8x1TgwgxrXwLnGSjqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3466
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-12_02:2020-04-11,2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTEyIGF0IDE0OjAxICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUaHUsIDI3IEZlYiAyMDIwIDE1OjUyOjI3ICswMjAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBJdCdzIHVudXNlZCBzbyBmYXIsIHNvIGl0IGNhbid0IGJlIHJlbW92ZWQu
IEFsc28gbWFrZXMgc2Vuc2UgdG8gcmVtb3ZlIGl0DQo+ID4gdG8gZGlzY291cmFnZSB3ZWlyZCB1
c2VzIG9mIHRoaXMgY2FsbCBkdXJpbmcgcmV2aWV3Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IEFw
cGxpZWQgd2l0aCB0aGUgY2FuJ3QgLT4gY2FuIGFib3ZlIGZpeGVkIHVwLg0KPiANCg0KVGhhbmtz
IGZvciBub3RpY2luZyB0aGUgdHlwby4NCkkgc2hvdWxkIHJlYWxseSBhbGxvY2F0ZWQgbW9yZSBi
cmFpbiBwb3dlciB0byBjb21taXQgY29tbWVudHMuDQpJIHRoaW5rIEkgaGF2ZSBhIGJhZCBoYWJp
dCBvZiBwb3dlcmluZyBkb3duIG15IGJyYWluIGZvciB0aGUgY29tbWVudHMsIGFmdGVyDQpkb2lu
ZyB0aGUgY29kZS4NCg0KDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0K
PiA+ICAuLi4vZHJpdmVyLWFwaS9kcml2ZXItbW9kZWwvZGV2cmVzLnJzdCAgICAgICAgfCAgMSAt
DQo+ID4gIGRyaXZlcnMvaWlvL2J1ZmZlci9rZmlmb19idWYuYyAgICAgICAgICAgICAgICB8IDIy
IC0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8va2ZpZm9fYnVmLmgg
ICAgICAgICAgICAgICAgIHwgIDEgLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI0IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZHJp
dmVyLW1vZGVsL2RldnJlcy5yc3QNCj4gPiBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kcml2
ZXItbW9kZWwvZGV2cmVzLnJzdA0KPiA+IGluZGV4IDEwY2NlYmU5ZjdjMS4uOTFiMGI4ZTU1NTZj
IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kcml2ZXItbW9kZWwv
ZGV2cmVzLnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kcml2ZXItbW9k
ZWwvZGV2cmVzLnJzdA0KPiA+IEBAIC0yODYsNyArMjg2LDYgQEAgSUlPDQo+ID4gICAgZGV2bV9p
aW9fZGV2aWNlX2FsbG9jKCkNCj4gPiAgICBkZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoKQ0KPiA+
ICAgIGRldm1faWlvX2tmaWZvX2FsbG9jYXRlKCkNCj4gPiAtICBkZXZtX2lpb19rZmlmb19mcmVl
KCkNCj4gPiAgICBkZXZtX2lpb190cmlnZ2VyZWRfYnVmZmVyX3NldHVwKCkNCj4gPiAgICBkZXZt
X2lpb190cmlnZ2VyX2FsbG9jKCkNCj4gPiAgICBkZXZtX2lpb190cmlnZ2VyX3JlZ2lzdGVyKCkN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYnVmZmVyL2tmaWZvX2J1Zi5jIGIvZHJpdmVy
cy9paW8vYnVmZmVyL2tmaWZvX2J1Zi5jDQo+ID4gaW5kZXggMzE1MGY4YWI5ODRiLi4xMzU5YWJl
ZDNiMzEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYnVmZmVyL2tmaWZvX2J1Zi5jDQo+
ID4gKysrIGIvZHJpdmVycy9paW8vYnVmZmVyL2tmaWZvX2J1Zi5jDQo+ID4gQEAgLTE3OSwxNiAr
MTc5LDYgQEAgc3RhdGljIHZvaWQgZGV2bV9paW9fa2ZpZm9fcmVsZWFzZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+ID4gdm9pZCAqcmVzKQ0KPiA+ICAJaWlvX2tmaWZvX2ZyZWUoKihzdHJ1Y3QgaWlv
X2J1ZmZlciAqKilyZXMpOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC1zdGF0aWMgaW50IGRldm1faWlv
X2tmaWZvX21hdGNoKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqcmVzLCB2b2lkICpkYXRhKQ0K
PiA+IC17DQo+ID4gLQlzdHJ1Y3QgaWlvX2J1ZmZlciAqKnIgPSByZXM7DQo+ID4gLQ0KPiA+IC0J
aWYgKFdBUk5fT04oIXIgfHwgISpyKSkNCj4gPiAtCQlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gLQly
ZXR1cm4gKnIgPT0gZGF0YTsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgLyoqDQo+ID4gICAqIGRldm1f
aWlvX2ZpZm9fYWxsb2NhdGUgLSBSZXNvdXJjZS1tYW5hZ2VkIGlpb19rZmlmb19hbGxvY2F0ZSgp
DQo+ID4gICAqIEBkZXY6CQlEZXZpY2UgdG8gYWxsb2NhdGUga2ZpZm8gYnVmZmVyIGZvcg0KPiA+
IEBAIC0yMTYsMTYgKzIwNiw0IEBAIHN0cnVjdCBpaW9fYnVmZmVyICpkZXZtX2lpb19rZmlmb19h
bGxvY2F0ZShzdHJ1Y3QNCj4gPiBkZXZpY2UgKmRldikNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lN
Qk9MKGRldm1faWlvX2tmaWZvX2FsbG9jYXRlKTsNCj4gPiAgDQo+ID4gLS8qKg0KPiA+IC0gKiBk
ZXZtX2lpb19maWZvX2ZyZWUgLSBSZXNvdXJjZS1tYW5hZ2VkIGlpb19rZmlmb19mcmVlKCkNCj4g
PiAtICogQGRldjoJCURldmljZSB0aGUgYnVmZmVyIGJlbG9uZ3MgdG8NCj4gPiAtICogQHI6CQkJ
VGhlIGJ1ZmZlciBhc3NvY2lhdGVkIHdpdGggdGhlIGRldmljZQ0KPiA+IC0gKi8NCj4gPiAtdm9p
ZCBkZXZtX2lpb19rZmlmb19mcmVlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGlpb19idWZm
ZXIgKnIpDQo+ID4gLXsNCj4gPiAtCVdBUk5fT04oZGV2cmVzX3JlbGVhc2UoZGV2LCBkZXZtX2lp
b19rZmlmb19yZWxlYXNlLA0KPiA+IC0JCQkgICAgICAgZGV2bV9paW9fa2ZpZm9fbWF0Y2gsIHIp
KTsNCj4gPiAtfQ0KPiA+IC1FWFBPUlRfU1lNQk9MKGRldm1faWlvX2tmaWZvX2ZyZWUpOw0KPiA+
IC0NCj4gPiAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2lpby9rZmlmb19idWYuaCBiL2luY2x1ZGUvbGludXgvaWlvL2tmaWZvX2J1Zi5oDQo+
ID4gaW5kZXggNzY0NjU5ZTAxYjY4Li4xZmMxZWZhNzc5OWQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5j
bHVkZS9saW51eC9paW8va2ZpZm9fYnVmLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9r
Zmlmb19idWYuaA0KPiA+IEBAIC05LDYgKzksNSBAQCBzdHJ1Y3QgaWlvX2J1ZmZlciAqaWlvX2tm
aWZvX2FsbG9jYXRlKHZvaWQpOw0KPiA+ICB2b2lkIGlpb19rZmlmb19mcmVlKHN0cnVjdCBpaW9f
YnVmZmVyICpyKTsNCj4gPiAgDQo+ID4gIHN0cnVjdCBpaW9fYnVmZmVyICpkZXZtX2lpb19rZmlm
b19hbGxvY2F0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+IC12b2lkIGRldm1faWlvX2tmaWZv
X2ZyZWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgaWlvX2J1ZmZlciAqcik7DQo+ID4gIA0K
PiA+ICAjZW5kaWYNCg==
