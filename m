Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C588A18E7C3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 10:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVJSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 05:18:30 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:41138 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726797AbgCVJSa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 05:18:30 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02M9DCGX002821;
        Sun, 22 Mar 2020 05:18:15 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9jwa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 05:18:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRpaRbHBQvYgif1takmYgjGH7vt/h9/BiG5TgetaxFEtFbbaJWPRLo+L4zq7QTe09W4nHBIAmTCAFvOIHEDeJlc5r+3BDiAIlx20XFyR/cSLf3iT3rKa1XyHQnUf53643hb33IMH+dFwWDYKu7FB5LxMgWrgx0tLiPqLEebIPnxhJxQYKin3uzocp0XrIGbfw+PGXiC0u5+jP+kZKRLf0k7yiny4GcZ4ufdf+FiFkWRRAwknE5j2egLQE70VlIHoAUq7QCdMJQcxDTJtKbKOaUnc6CC9gs0YTFZc3sZMHpvXvxR7VGimdnGpmzvtAghXekt/9Zt4M6Fvbwjz4dYr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k3bxlZJimeKkZrJj2WfmxG2Cw+ULL7Qa6uKMuZAQ10=;
 b=gQkUEqCTp6JOcT4hH8Zpk0RHNa6RESLGPYUL/2HQyhf4yZ54lOmc7z5puUFM6XjUQLhaVcVGDHqkH69dUrJy7YSLghF7+VkVXN0fusQGQnzOAhuvl8C+PoXNu6jYHR/Rg/hictMmJyfi0VMPfY9RRYF8JoPDvdVg1JjdCzyuotV7cXXoSKFpuTuFYlE6/pANZrUcXYEdnva5FyqBQl9ybJI1bxVUx50Sn6z7mdmkshf2pO88EfDnmjv7Hjnv31gs/e9+yMLFE3QI6ahKivVtlp22JrnJR91XRLTyACa8rrMShA1kH3G51e/b71BKPrtYK732NT6TdE3UkE2IIhIalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k3bxlZJimeKkZrJj2WfmxG2Cw+ULL7Qa6uKMuZAQ10=;
 b=IqWpK8nOd08XfYeiutgIfhTcl+jgoB3Gd10BYpqcCowE7/6dlf0ucTRPSXHdmIpzR27+WBmCnorwNOpvl4PF5TGxM7Ceb29lmyYAV4w5w0uPoq3sNHNvJ73fPI30EFSJRIUrB70hV33V1lIUtAMqyUMEVfyWcB9eG5akwbmj4M4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4812.namprd03.prod.outlook.com (2603:10b6:5:189::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Sun, 22 Mar
 2020 09:18:14 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 09:18:14 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7793: use read_avail iio hook for
 scale available
Thread-Topic: [PATCH v2 5/5] iio: adc: ad7793: use read_avail iio hook for
 scale available
Thread-Index: AQHV/2BQOhkk6JaXP0ey2wVMJn6Iw6hTcYwAgADlU4A=
Date:   Sun, 22 Mar 2020 09:18:13 +0000
Message-ID: <5ae09f8526a8847cb45435aa5280f905956ff588.camel@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
         <20200321090802.11537-5-alexandru.ardelean@analog.com>
         <20200321193726.GA2813151@smile.fi.intel.com>
In-Reply-To: <20200321193726.GA2813151@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75938c49-8626-4d83-01a9-08d7ce41f305
x-ms-traffictypediagnostic: DM6PR03MB4812:
x-microsoft-antispam-prvs: <DM6PR03MB481255A56D522CABD1CBD68BF9F30@DM6PR03MB4812.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(396003)(366004)(346002)(136003)(199004)(6512007)(91956017)(66446008)(66556008)(2616005)(6916009)(54906003)(8936002)(8676002)(6486002)(81166006)(6506007)(81156014)(4326008)(478600001)(71200400001)(5660300002)(66946007)(76116006)(64756008)(66476007)(26005)(316002)(36756003)(86362001)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4812;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwQIQPd5wznYeFJTWF0vIJonpgvOCQYeaEhaFErTJUq+0LYdr/fc4KPM7lH9gGZJAh5o95AQWbFomLpabjvTGgVzIlfREVYi9L5j0+cFkv29zZiDDDrvIajESbE6QKdD/HM+KUbksLQ4iBYvQikM8pnWA3L5GiX4UcQD9/rGHqSAcXCPQ6aRpDM7at8zXHmevCENi4hwrbM51K2beei/8Lp6JC7tMBINHNhiK2vttjT0H2GDBznSneqzfqKtWMRT1eQ177ox2K61BDrcKjASEtwnoic+tus06b6vuODzwxBJzUhRya4eKDPZwaul8hF8E4/avj6KNnfD0fjaEIIfvX+tSz1pkfCPw6EW9a6uTSlVvpQPPHjaGRpBQSAGVT0lz6MUCBPF1HmWyWrA4vC2ruoMq2GXKZv6sdDVHPMwCbWg4o5BKXMTV+tw+uSyqHOy
x-ms-exchange-antispam-messagedata: 3YIsAyFthAkLX89BzkSAieXUzuk15O1rUyfpTct6ZSNjx2XmbZzLagO3wz88wMWLhPuQFHN0Jp3q2rJAus285CWYk4gRgOLOMfcjyaOuRK0+YVn4CDHVHNzDOwuZlFFFAK6gfGEdXc6B/SJERj3RWw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E705FEE269894896F1FFD0F01BB723@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75938c49-8626-4d83-01a9-08d7ce41f305
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 09:18:13.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqMJN5y8FWgkf/Mo/p04Nd/ncW7xAKB/abUB3P4DWTTjbj+vuFBZMGhPU/0yxlQDVHJjyqGfqyrGEQoNdASjzDBZQIGgQYur6T7NV0VRHaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_02:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTIxIGF0IDIxOjM3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFNhdCwgTWFyIDIxLCAyMDIwIGF0IDExOjA4OjAyQU0g
KzAyMDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiBUaGlzIGNoYW5nZSB1c2VzIHRo
ZSByZWFkX2F2YWlsIGFuZCAnLmluZm9fbWFza19zaGFyZWRfYnlfdHlwZV9hdmFpbGFibGUnDQo+
ID4gbW9kaWZpZXIgdG8gc2V0IHRoZSBhdmFpbGFibGUgc2NhbGUuDQo+ID4gRXNzZW50aWFsbHks
IG5vdGhpbmcgY2hhbmdlcyB0byB0aGUgZHJpdmVyJ3MgQUJJLg0KPiA+IA0KPiA+IFRoZSBtYWlu
IGlkZWEgZm9yIHRoaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIHRoZSBBRDc3OTMgZHJpdmVyIGZyb20N
Cj4gPiBjaGVja3BhdGNoJ3MgcmFkYXIuIFRoZXJlIGhhdmUgYmVlbiBhYm91dCB+MyBhdHRlbXB0
cyB0byBmaXgvYnJlYWsgdGhlDQo+ID4gJ2luX3ZvbHRhZ2Utdm9sdGFnZV9zY2FsZV9hdmFpbGFi
bGUnIGF0dHJpYnV0ZSwgYmVjYXVzZSBjaGVja3BhdGNoIGFzc3VtZWQNCj4gPiBpdCB0byBiZSBh
biBhcml0aG1ldGljIG9wZXJhdGlvbiBhbmQgcGVvcGxlIHdlcmUgdHJ5aW5nIHRvIGNoYW5nZSB0
aGF0Lg0KPiA+ICtzdGF0aWMgaW50IGFkNzc5M19yZWFkX2F2YWlsKHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYsDQo+ID4gKwkJCSAgICAgc3RydWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4s
DQo+ID4gKwkJCSAgICAgY29uc3QgaW50ICoqdmFscywgaW50ICp0eXBlLCBpbnQgKmxlbmd0aCwN
Cj4gPiArCQkJICAgICBsb25nIG1hc2spDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBhZDc3OTNfc3Rh
dGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiAgDQo+ID4gKwlzd2l0Y2ggKG1hc2sp
IHsNCj4gPiArCWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4gPiArCQkqdmFscyA9IChpbnQg
KilzdC0+c2NhbGVfYXZhaWw7DQo+ID4gKwkJKnR5cGUgPSBJSU9fVkFMX0lOVF9QTFVTX05BTk87
DQo+ID4gKwkJLyogVmFsdWVzIGFyZSBzdG9yZWQgaW4gYSAyRCBtYXRyaXggICovDQo+ID4gKwkJ
Kmxlbmd0aCA9IEFSUkFZX1NJWkUoc3QtPnNjYWxlX2F2YWlsKSAqIDI7DQo+ID4gIA0KPiA+ICsJ
CXJldHVybiBJSU9fQVZBSUxfTElTVDsNCj4gPiArCX0NCj4gPiAgDQo+ID4gKwlyZXR1cm4gLUVJ
TlZBTDsNCj4gDQo+IFdvdWxkbid0IGJlIGJldHRlciBtb3ZlIHRoaXMgdW5kZXIgZGVmYXVsdCBj
YXNlPw0KPiANCg0KVW1tbSwgc3VyZS4NCkknbSBhIGJpdCB2YWd1ZSBob3cgd2UgZG8gZnJvbSBo
ZXJlIHNpbmNlIEpvbmF0aGFuIGFjY2VwdGVkIHRoaXMgYW5kIHRoZQ0KcGF0Y2hzZXQuDQpJJ2xs
IHNlbmQgYSBWMyBvZiB0aGUgd2hvbGUgc2V0IFtpbiBhIGZldyBkYXlzIG1heF0uDQo=
