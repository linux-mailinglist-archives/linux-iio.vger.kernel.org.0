Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2816C20032C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jun 2020 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgFSIEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Jun 2020 04:04:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11368 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729548AbgFSIDG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jun 2020 04:03:06 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J80OYC010258;
        Fri, 19 Jun 2020 04:02:57 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 31q670haqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 04:02:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEJ4gdmL+QHNFpQH+7yCN/yuEfG4HZ80rAwhyfUouD1NjgrQdh+LsulSST9J9xwof/OsEetoPb7B5ov+GxLXXxif9YtgugO0L7DdlLIMEYzWt01007ZrBvXBM0OAG+a5ZfHxbuoBm4GKDH53JOxX69liuISvEOJ6SG2lBxwIixs1bRNPusc+BtKjSiQSOAwH0MTgBvT0prn87g8Lkl3esx1QBZMx83BcqGttEMFIuinprBkf17RWzsZdy3fIwXdsZShcWjJC0UZI0oMDd7JgAMfYmI76NBclxoXZQ+orLFgT4kNOQyL5XcrkYPr2Jbe33kjPtgBrm7RXAbrSUYOBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsWogUIjrXwccX6knFYZj6v9YW+TyQQjwR/WvYVcYY0=;
 b=O5oD7hd0QDQKIf+F+4fXNuGlEjJ9fBSMcJ+ddmNfy1VdHviDzZ7V2Oxggocx+hFYuBFTzqu/SpiD8Tx3t90e2eDftXXh9Pi+9WGCl3bUY2COLZAUaaVOAs7GXuJZKYNivgu6Ao5g53gR58FeBejPjOtPgG1IMBUlIrp4BN0n0itutEQiIbYnIi0mMGaNiwgWeefN/vs2VN97ls+1/H5J3tvPuaQaEwFGEIYMYsz4BpG/VkPzZ8SHDK3GchiTN+GHRqU6XnuTndM8bzXXbUseKv4MqlYyxCzxEkMJPHnKufxGMMFC/feB4zWUgMEp6suLRGuGiZzB492XkqUZRvZZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsWogUIjrXwccX6knFYZj6v9YW+TyQQjwR/WvYVcYY0=;
 b=0S9cQHoLYv/ha9SFh2zMwElDUtyBdg3d7sbLxmwczRiK4g2vZgXYk51OWlIRSiBvNPR+YUKDbRQdoZXsjZXLGLpNl3fQMcQxT1LnC4fuKB4yeiie3CVoRXnz5l0n15aEhFqYod4KZn25rbv+drzZWuBCLtJt5LCESAFsyLql5hM=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5004.namprd03.prod.outlook.com (2603:10b6:5:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 08:02:56 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 08:02:56 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] iio: at91_adc: remove usage of iio_priv_to_dev() helper
Thread-Topic: [PATCH] iio: at91_adc: remove usage of iio_priv_to_dev() helper
Thread-Index: AQHWMn7K4yTlHQlmxkeIus5AucCcIKjCTl0AgB1suIA=
Date:   Fri, 19 Jun 2020 08:02:55 +0000
Message-ID: <4b07863e8312e2abd0169a456f230a025621419c.camel@analog.com>
References: <20200525102513.130664-1-alexandru.ardelean@analog.com>
         <20200531154216.361285c6@archlinux>
In-Reply-To: <20200531154216.361285c6@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb42468c-5d19-4871-77db-08d814272ce2
x-ms-traffictypediagnostic: DM6PR03MB5004:
x-microsoft-antispam-prvs: <DM6PR03MB5004DB19DE9CB9C463910EFAF9980@DM6PR03MB5004.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoC21om3eedLsc8WN5N7r9kRHGoN/w80O/4xiv8TWf78YxVPEtrMR+Y4pknnHj+OgNdyF5dkSSoxvieGdfj2HRHb063d5soYzZW1bEfRGMj1RH9B0N2veF72s5EGyLBWeYe/a+K8bLU0VxaioosTj6LYbAj/41TEiuni+7VrMk5VMVXStd7gkqr/p/SCsimp4NshWMaFxKjsJNKw+y7Dlk48Wg9a6iwQMdSZ3LoDdEg2xZqsc6sRkusWwdSYrWeDUnwlF9/idkEVzO4kmqul6x9jVBCiavpNhYdWyANfWuegmv5LldZF7qBLe8aWfQ/DCwDAL0x/s41Nd90ZKfBCxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(6506007)(5660300002)(2616005)(76116006)(91956017)(66476007)(66556008)(66446008)(66946007)(64756008)(26005)(71200400001)(316002)(54906003)(36756003)(4326008)(186003)(83380400001)(8936002)(6486002)(6916009)(2906002)(86362001)(8676002)(6512007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PXWzzyrvemSFBeJg0i7ZKnCY8F1dGF3GCNRB9wZNkg7fEsTG/h7RiQczKVg7SJfwaem/Qn90n6ejjvTa7hfzbGQyTV6+C8kMAH8p+QCkzlZmoYh53BvRllecu5M+M7INXeTXRWC8Fi3zhH5tUdgEJOdSakZ00gittbJXNMr4ZkZBfw5B6MRhbKsTolbpLGfV8PdDDPH5xCccZ1rZfMqs1/WkXqNKRFDSye2XAFQr9Sn8X7wHt5M6tmg9WIUPzSWfVCO9ICjBxJqQxcwBmB1pDzG/3o8zP9MP/VUSwb6DAzS7GtW5ZcYcKflrEcDIA2UEbM68y1RftmqfOWOft6X0S+DphV7g+Gj2uYV0+38DnCnEdh4JXuWZXTAUVsjgIDtJ2B61HOZ1HBZdJMZl5LM6TgkUxGcUQ23cqrFCYZiRDwqSrETyDEqCm01mivntyvJVQPh7XhkQ5v1wxzhirKfaSXsPprRlHZ0SS8cqvKblM18=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1335B1FAF2624478991F36E522360E5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb42468c-5d19-4871-77db-08d814272ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 08:02:56.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLr0l+zLN/zM/MAMHasJlm/J3neOWjmDcKUsQ0mvsgzFTgQbD////sh/QFKteLILC0mAEORo4c6cs/qlwJ5ZS+grPyDeC07TxS06eBhD02I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5004
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_04:2020-06-18,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 cotscore=-2147483648 spamscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190058
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTMxIGF0IDE1OjQyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIDI1IE1heSAyMDIwIDEzOjI1OjEzICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBXZSBtYXkgd2FudCB0byBnZXQgcmlkIG9mIHRoZSBpaW9fcHJpdl90b19k
ZXYoKSBoZWxwZXIuIFRoZSByZWFzb24gaXMNCj4gPiB0aGF0DQo+ID4gd2Ugd2lsbCBoaWRlIHNv
bWUgb2YgdGhlIG1lbWJlcnMgb2YgdGhlIGlpb19kZXYgc3RydWN0dXJlICh0byBwcmV2ZW50DQo+
ID4gZHJpdmVycyBmcm9tIGFjY2Vzc2luZyB0aGVtIGRpcmVjdGx5KSwgYW5kIHRoYXQgd2lsbCBh
bHNvIG1lYW4gaGlkaW5nDQo+ID4gdGhlDQo+ID4gaW1wbGVtZW50YXRpb24gb2YgdGhlIGlpb19w
cml2X3RvX2RldigpIGhlbHBlciBpbnNpZGUgdGhlIElJTyBjb3JlLg0KPiA+IA0KPiA+IEhpZGlu
ZyB0aGUgaW1wbGVtZW50YXRpb24gb2YgaWlvX3ByaXZfdG9fZGV2KCkgaW1wbGllcyB0aGF0IHNv
bWUgZmFzdC0NCj4gPiBwYXRocw0KPiA+IG1heSBub3QgYmUgZmFzdCBhbnltb3JlLCBzbyBhIGdl
bmVyYWwgaWRlYSBpcyB0byB0cnkgdG8gZ2V0IHJpZCBvZiB0aGUNCj4gPiBpaW9fcHJpdl90b19k
ZXYoKSBhbHRvZ2V0aGVyLg0KPiA+IFRoZSBpaW9fcHJpdigpIGhlbHBlciB3b24ndCBiZSBhZmZl
Y3RlZCBieSB0aGUgcmV3b3JrLCBhcyB0aGUgaWlvX2Rldg0KPiA+IHN0cnVjdCB3aWxsIGtlZXAg
YSByZWZlcmVuY2UgdG8gdGhlIHByaXZhdGUgaW5mb3JtYXRpb24uDQo+ID4gDQo+ID4gRm9yIHRo
aXMgZHJpdmVyLCBub3QgdXNpbmcgaWlvX3ByaXZfdG9fZGV2KCksIG1lYW5zIHJld29ya2luZyBz
b21lDQo+ID4gcGF0aHMgdG8NCj4gPiBwYXNzIHRoZSBpaW8gZGV2aWNlIGFuZCB1c2luZyBpaW9f
cHJpdigpIHRvIGFjY2VzcyB0aGUgcHJpdmF0ZQ0KPiA+IGluZm9ybWF0aW9uLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFu
YWxvZy5jb20+DQo+IExvb2tzIGdvb2QgdG8gbWUuICBXaWxsIGxlYXZlIGl0IGEgYml0IGxvbmdl
ciB0aG91Z2ggdG8gcG90ZW50aWFsbHkNCj4gZ2V0IHNvbWUgcGVvcGxlIG1vcmUgZmFtaWxpYXIg
d2l0aCB0aGUgZHJpdmVyIHRvIHNhbml0eSBjaGVjayBpdC4NCj4gDQo+IFBva2UgbWUgYWZ0ZXIg
dGhlIHVzdWFsIGNvdXBsZSBvZiB3ZWVrcyBpZiBJIHNlZW0gdG8gaGF2ZSBsb3N0IGl0DQo+IGRv
d24gdGhlIGJhY2sgb2YgdGhlIHNvZmEuDQo+IA0KDQpwaW5nIG9uIHRoaXMNCg0KPiBUaGFua3Ms
DQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vYWRjL2F0OTFf
YWRjLmMgfCAzMCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MV9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkx
X2FkYy5jDQo+ID4gaW5kZXggMDM2OGI2ZGM2ZDYwLi44OTZhZjU4ZTg4YmMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9paW8vYWRjL2F0OTFfYWRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9h
ZGMvYXQ5MV9hZGMuYw0KPiA+IEBAIC0yODcsMTMgKzI4NywxMyBAQCBzdGF0aWMgdm9pZCBoYW5k
bGVfYWRjX2VvY190cmlnZ2VyKGludCBpcnEsDQo+ID4gc3RydWN0IGlpb19kZXYgKmlkZXYpDQo+
ID4gIAl9DQo+ID4gIH0NCj4gPiAgDQo+ID4gLXN0YXRpYyBpbnQgYXQ5MV90c19zYW1wbGUoc3Ry
dWN0IGF0OTFfYWRjX3N0YXRlICpzdCkNCj4gPiArc3RhdGljIGludCBhdDkxX3RzX3NhbXBsZShz
dHJ1Y3QgaWlvX2RldiAqaWRldikNCj4gPiAgew0KPiA+ICsJc3RydWN0IGF0OTFfYWRjX3N0YXRl
ICpzdCA9IGlpb19wcml2KGlkZXYpOw0KPiA+ICAJdW5zaWduZWQgaW50IHhzY2FsZSwgeXNjYWxl
LCByZWcsIHoxLCB6MjsNCj4gPiAgCXVuc2lnbmVkIGludCB4LCB5LCBwcmVzLCB4cG9zLCB5cG9z
Ow0KPiA+ICAJdW5zaWduZWQgaW50IHJ4cCA9IDE7DQo+ID4gIAl1bnNpZ25lZCBpbnQgZmFjdG9y
ID0gMTAwMDsNCj4gPiAtCXN0cnVjdCBpaW9fZGV2ICppZGV2ID0gaWlvX3ByaXZfdG9fZGV2KHN0
KTsNCj4gPiAgDQo+ID4gIAl1bnNpZ25lZCBpbnQgeHl6X21hc2tfYml0cyA9IHN0LT5yZXM7DQo+
ID4gIAl1bnNpZ25lZCBpbnQgeHl6X21hc2sgPSAoMSA8PCB4eXpfbWFza19iaXRzKSAtIDE7DQo+
ID4gQEAgLTQ0OSw3ICs0NDksNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYXQ5MV9hZGNfOXg1X2lu
dGVycnVwdChpbnQgaXJxLA0KPiA+IHZvaWQgKnByaXZhdGUpDQo+ID4gIA0KPiA+ICAJCWlmIChz
dGF0dXMgJiBBVDkxX0FEQ19JU1JfUEVOUykgew0KPiA+ICAJCQkvKiB2YWxpZGF0ZSBkYXRhIGJ5
IHBlbiBjb250YWN0ICovDQo+ID4gLQkJCWF0OTFfdHNfc2FtcGxlKHN0KTsNCj4gPiArCQkJYXQ5
MV90c19zYW1wbGUoaWRldik7DQo+ID4gIAkJfSBlbHNlIHsNCj4gPiAgCQkJLyogdHJpZ2dlcmVk
IGJ5IGV2ZW50IHRoYXQgaXMgbm8gcGVuIGNvbnRhY3QsIGp1c3QNCj4gPiByZWFkDQo+ID4gIAkJ
CSAqIHRoZW0gdG8gY2xlYW4gdGhlIGludGVycnVwdCBhbmQgZGlzY2FyZCBhbGwuDQo+ID4gQEAg
LTczNywxMCArNzM3LDEwIEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcmVhZF9yYXcoc3RydWN0IGlp
b19kZXYNCj4gPiAqaWRldiwNCj4gPiAgCXJldHVybiAtRUlOVkFMOw0KPiA+ICB9DQo+ID4gIA0K
PiA+IC1zdGF0aWMgaW50IGF0OTFfYWRjX29mX2dldF9yZXNvbHV0aW9uKHN0cnVjdCBhdDkxX2Fk
Y19zdGF0ZSAqc3QsDQo+ID4gK3N0YXRpYyBpbnQgYXQ5MV9hZGNfb2ZfZ2V0X3Jlc29sdXRpb24o
c3RydWN0IGlpb19kZXYgKmlkZXYsDQo+ID4gIAkJCQkgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3QgaWlvX2RldiAqaWRldiA9IGlpb19wcml2
X3RvX2RldihzdCk7DQo+ID4gKwlzdHJ1Y3QgYXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3ByaXYo
aWRldik7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7
DQo+ID4gIAlpbnQgY291bnQsIGksIHJldCA9IDA7DQo+ID4gIAljaGFyICpyZXNfbmFtZSwgKnM7
DQo+ID4gQEAgLTg2NiwxMCArODY2LDEwIEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcHJvYmVfZHRf
dHMoc3RydWN0DQo+ID4gZGV2aWNlX25vZGUgKm5vZGUsDQo+ID4gIAl9DQo+ID4gIH0NCj4gPiAg
DQo+ID4gLXN0YXRpYyBpbnQgYXQ5MV9hZGNfcHJvYmVfZHQoc3RydWN0IGF0OTFfYWRjX3N0YXRl
ICpzdCwNCj4gPiArc3RhdGljIGludCBhdDkxX2FkY19wcm9iZV9kdChzdHJ1Y3QgaWlvX2RldiAq
aWRldiwNCj4gPiAgCQkJICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICB7
DQo+ID4gLQlzdHJ1Y3QgaWlvX2RldiAqaWRldiA9IGlpb19wcml2X3RvX2RldihzdCk7DQo+ID4g
KwlzdHJ1Y3QgYXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaWRldik7DQo+ID4gIAlzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPiAgCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqdHJpZ19ub2RlOw0KPiA+ICAJaW50IGkgPSAwLCByZXQ7DQo+ID4gQEAgLTkx
MCw3ICs5MTAsNyBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX3Byb2JlX2R0KHN0cnVjdCBhdDkxX2Fk
Y19zdGF0ZQ0KPiA+ICpzdCwNCj4gPiAgCX0NCj4gPiAgCXN0LT52cmVmX212ID0gcHJvcDsNCj4g
PiAgDQo+ID4gLQlyZXQgPSBhdDkxX2FkY19vZl9nZXRfcmVzb2x1dGlvbihzdCwgcGRldik7DQo+
ID4gKwlyZXQgPSBhdDkxX2FkY19vZl9nZXRfcmVzb2x1dGlvbihpZGV2LCBwZGV2KTsNCj4gPiAg
CWlmIChyZXQpDQo+ID4gIAkJZ290byBlcnJvcl9yZXQ7DQo+ID4gIA0KPiA+IEBAIC0xMDEwLDkg
KzEwMTAsOSBAQCBzdGF0aWMgdm9pZCBhdG1lbF90c19jbG9zZShzdHJ1Y3QgaW5wdXRfZGV2ICpk
ZXYpDQo+ID4gIAkJYXQ5MV9hZGNfd3JpdGVsKHN0LCBBVDkxX0FEQ19JRFIsIEFUOTFSTF9BRENf
SUVSX1BFTik7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLXN0YXRpYyBpbnQgYXQ5MV90c19od19pbml0
KHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QsIHUzMiBhZGNfY2xrX2toeikNCj4gPiArc3RhdGlj
IGludCBhdDkxX3RzX2h3X2luaXQoc3RydWN0IGlpb19kZXYgKmlkZXYsIHUzMiBhZGNfY2xrX2to
eikNCj4gPiAgew0KPiA+IC0Jc3RydWN0IGlpb19kZXYgKmlkZXYgPSBpaW9fcHJpdl90b19kZXYo
c3QpOw0KPiA+ICsJc3RydWN0IGF0OTFfYWRjX3N0YXRlICpzdCA9IGlpb19wcml2KGlkZXYpOw0K
PiA+ICAJdTMyIHJlZyA9IDA7DQo+ID4gIAl1MzIgdHNzY3RpbSA9IDA7DQo+ID4gIAlpbnQgaSA9
IDA7DQo+ID4gQEAgLTEwODUsMTEgKzEwODUsMTEgQEAgc3RhdGljIGludCBhdDkxX3RzX2h3X2lu
aXQoc3RydWN0DQo+ID4gYXQ5MV9hZGNfc3RhdGUgKnN0LCB1MzIgYWRjX2Nsa19raHopDQo+ID4g
IAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtc3RhdGljIGludCBhdDkxX3RzX3JlZ2lz
dGVyKHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QsDQo+ID4gK3N0YXRpYyBpbnQgYXQ5MV90c19y
ZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaWRldiwNCj4gPiAgCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3QgYXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlv
X3ByaXYoaWRldik7DQo+ID4gIAlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dDsNCj4gPiAtCXN0cnVj
dCBpaW9fZGV2ICppZGV2ID0gaWlvX3ByaXZfdG9fZGV2KHN0KTsNCj4gPiAgCWludCByZXQ7DQo+
ID4gIA0KPiA+ICAJaW5wdXQgPSBpbnB1dF9hbGxvY2F0ZV9kZXZpY2UoKTsNCj4gPiBAQCAtMTE2
MSw3ICsxMTYxLDcgQEAgc3RhdGljIGludCBhdDkxX2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4gIAlzdCA9IGlpb19wcml2KGlkZXYpOw0KPiA+ICANCj4g
PiAgCWlmIChwZGV2LT5kZXYub2Zfbm9kZSkNCj4gPiAtCQlyZXQgPSBhdDkxX2FkY19wcm9iZV9k
dChzdCwgcGRldik7DQo+ID4gKwkJcmV0ID0gYXQ5MV9hZGNfcHJvYmVfZHQoaWRldiwgcGRldik7
DQo+ID4gIAllbHNlDQo+ID4gIAkJcmV0ID0gYXQ5MV9hZGNfcHJvYmVfcGRhdGEoc3QsIHBkZXYp
Ow0KPiA+ICANCj4gPiBAQCAtMTMwMSwxMSArMTMwMSwxMSBAQCBzdGF0aWMgaW50IGF0OTFfYWRj
X3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCQkJZ290byBl
cnJvcl9kaXNhYmxlX2FkY19jbGs7DQo+ID4gIAkJfQ0KPiA+ICAJfSBlbHNlIHsNCj4gPiAtCQly
ZXQgPSBhdDkxX3RzX3JlZ2lzdGVyKHN0LCBwZGV2KTsNCj4gPiArCQlyZXQgPSBhdDkxX3RzX3Jl
Z2lzdGVyKGlkZXYsIHBkZXYpOw0KPiA+ICAJCWlmIChyZXQpDQo+ID4gIAkJCWdvdG8gZXJyb3Jf
ZGlzYWJsZV9hZGNfY2xrOw0KPiA+ICANCj4gPiAtCQlhdDkxX3RzX2h3X2luaXQoc3QsIGFkY19j
bGtfa2h6KTsNCj4gPiArCQlhdDkxX3RzX2h3X2luaXQoaWRldiwgYWRjX2Nsa19raHopOw0KPiA+
ICAJfQ0KPiA+ICANCj4gPiAgCXJldCA9IGlpb19kZXZpY2VfcmVnaXN0ZXIoaWRldik7DQo=
