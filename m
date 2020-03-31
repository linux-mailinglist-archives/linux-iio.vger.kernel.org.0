Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D391994D0
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgCaLLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:11:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44568 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730380AbgCaLLK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:11:10 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VB6Yn7029533;
        Tue, 31 Mar 2020 07:10:51 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 3023g58qy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 07:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUzW3rVAdO1Esj6LEesgvFvuOgH1O+olFybuz/Wb8zylR6Oe1BiES0vyY66lmWDLJz39MlvDTUypcA/As9wEeoIWU4bEuYOMW+8IvO8Mhy61ZRvGtljcQa9AW+u0Evn6um8XZV08kiflMMpO1I/mySgoVqAPyz20tlUciIalESEzLBjOAnyoCndx5vlBf8nnMYGtkp1AbbwnvpDp9RAUxSXCWNmeS4SZ291ZS4wZdPHj3tmHnn/XzpYoCflG3Btd7IEchWUlnr9EA99SS133RkhPNku9oXtkkS1pqE8XIGOY/ED4c4ksG2jyF0hW6UXLEDlxFF4CowaUdUkpWVJoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ1MtVLdV7WWH7hnmXSdNTzM1BPEDwfP3khxTPh3Vu0=;
 b=bK2BnQiEBj/c/E/WDXRQohQtPIJNs7LJpUNU5kFg38Ak4N1nzg3Wcnr7JsiSgT9xVqrk0YTCWnsJHBD1Oc538Rx65WObJD4yfQOn37NbmBiTyO4s1lh2qD+MpENv566PkFHc7l31/RdqpT/6S3XBP0voFy+NZ1uoSjAOInOjITojmWUyPgiPhzYOGySTsMDU3AEzTuFsqOG4jUj/lyAuDiMZJlRqYOGLUMzueLhExFsz+4X4FWrmxUOgXrZ8hwjODUiQV1zE1CAoFf1vcERXH+znkKBIOF7EDFWTMIMMyftIBZOzKzCjo/SklaY2uSxb7A9Wf3D1ezcPvLJ7dWtMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ1MtVLdV7WWH7hnmXSdNTzM1BPEDwfP3khxTPh3Vu0=;
 b=fBi5PI2piNSEx13TSYyyMgsuDdE8yRqNaUcbjU+im7ay4neZBu/8rKPt8GxrOO/va9ounx7Uy8F2AW3psx9IweyrYapAOnB+3mM7nMW/MBzGj6MKLDtWdCGPTlxHYx5fpY/v8QF5ks9cPKa5ASDthCLjBmrCdPDBiF7GjwzyREU=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3674.namprd03.prod.outlook.com (2603:10b6:5:aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 11:10:50 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 11:10:49 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "michael.auchter@ni.com" <michael.auchter@ni.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: adc: ad7291: convert to device tree
Thread-Topic: [PATCH v2 1/2] iio: adc: ad7291: convert to device tree
Thread-Index: AQHV/GursHVFjL005EaNs+NaBeBxoqhioTmA
Date:   Tue, 31 Mar 2020 11:10:49 +0000
Message-ID: <fe501cc7247c3454c21d6c27832d0925f70cfce8.camel@analog.com>
References: <20200317135649.8876-1-michael.auchter@ni.com>
         <20200317145113.12413-1-michael.auchter@ni.com>
In-Reply-To: <20200317145113.12413-1-michael.auchter@ni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b22f6595-2bc8-4b3e-8e31-08d7d5642b7d
x-ms-traffictypediagnostic: DM6PR03MB3674:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3674A1AC489572045A24A98CF9C80@DM6PR03MB3674.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(86362001)(6512007)(4326008)(6486002)(6506007)(316002)(66476007)(91956017)(64756008)(66446008)(66946007)(66556008)(76116006)(2616005)(54906003)(110136005)(478600001)(26005)(5660300002)(2906002)(71200400001)(8936002)(36756003)(81156014)(81166006)(186003)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92rlvEBB4LoGkLQxt1oMoD/pOt4nkXfOFhnDhRFpFnA/LKlbCxFtMqtE4l0TgN7yId1Uy5GdZLU0/V4R/PbbRd4Iho0nQ2rx0jXp6bvHHyxY23XLMNWyNdUbyQ9KtCvAMewCBtE3r8/43I9zp5PGsGRGnIPx2bQRO7h39Vv6TFlfnZp0jy24eYashVM4WzL9WRCpKQHXwEkijWYdUb/McpavgcBOKaNowufEGUzPwpG83BkOG5vlKMMFic8My0NrQS6u3Y58cUG87sIYHzjhIc5piQ+drHxkqbCngBfgJh6sK7jth1F9SuIA7x6k4M027vLBZ11W/hD9dhvokLL8ok1GpM2iEGl7GGfn+bePXyLrLSH1q+PHQHYHkbB5hY9tuvURdEWujxW435fl/KjJxL/B2FQqwdWVif9OiQMoRRQcdrWbcl6jhP46VnS6iQMt
x-ms-exchange-antispam-messagedata: u3gN9hHACjtm6qUssMOJZ94VMa2PJJAZTrtiq3q7QEGzS92lnwNKD8LqJps0J0zIhJymFUwaRrD3HlJoUKRmDKB/yIL1CARVS7x6PpDjeFVlQgaRWQmGphRUQHrSLIXcWA9iB/AO7fXGWPF22oWybQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <661CE39F78F8B94DAD9AEDEFF56755DB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22f6595-2bc8-4b3e-8e31-08d7d5642b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 11:10:49.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dJEz2G8uCRUceKm2MU1HuX3ATCq5pXQ1uhG2Qce0Qc2WQLkkb2YMMQRwVBDG2SqPtEFzkC+bN2lCJYBuM+aD07poGUt0Q7WpPXU0DSxwgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3674
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003310101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTE3IGF0IDA5OjUxIC0wNTAwLCBNaWNoYWVsIEF1Y2h0ZXIgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IFRoZXJlIGFyZSBubyBpbi10cmVlIHVzZXJzIG9mIHRoZSBw
bGF0Zm9ybSBkYXRhIGZvciB0aGlzIGRyaXZlciwgc28NCj4gcmVtb3ZlIGl0IGFuZCBjb252ZXJ0
IHRoZSBkcml2ZXIgdG8gdXNlIGRldmljZSB0cmVlIGluc3RlYWQuDQo+IA0KDQpBIGZldyBjb21t
ZW50cyBpbmxpbmUgZm9yIHRoaXMuDQpTb3JyeSBpZiB0aGlzIGlzIGEgYml0IGxhdGUsIGJ1dCBz
aW5jZSB0aGVyZSB3aWxsIGJlIGEgVjMgYmFzZWQgb24gdGhlIERUDQpiaW5kaW5ncyBwYXRjaCwg
aXQncyBzdGlsbCBub3QgdG9vIGxhdGUuDQoNCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBBdWNo
dGVyIDxtaWNoYWVsLmF1Y2h0ZXJAbmkuY29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgc2luY2Ug
djE6DQo+IC0gRml4IHJlZ3VsYXRvciBoYW5kbGluZyBhcyBzdWdnZXN0ZWQgYnkgTGFycw0KPiAN
Cj4gIGRyaXZlcnMvaWlvL2FkYy9hZDcyOTEuYyAgICAgICAgICAgICB8IDMzICsrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZDcyOTEu
aCB8IDEzIC0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyks
IDI3IGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvcGxh
dGZvcm1fZGF0YS9hZDcyOTEuaA0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9h
ZDcyOTEuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcyOTEuYw0KPiBpbmRleCBiMmIxMzdmZWQyNDYu
LjQzYTIwMWZiNGYzNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzI5MS5jDQo+
ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcyOTEuYw0KPiBAQCAtMjAsOCArMjAsNiBAQA0KPiAg
I2luY2x1ZGUgPGxpbnV4L2lpby9zeXNmcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9ldmVu
dHMuaD4NCj4gIA0KPiAtI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RhdGEvYWQ3MjkxLmg+DQo+
IC0NCj4gIC8qDQo+ICAgKiBTaW1wbGlmaWVkIGhhbmRsaW5nDQo+ICAgKg0KPiBAQCAtNDY1LDcg
KzQ2Myw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gYWQ3MjkxX2luZm8gPSB7DQo+
ICBzdGF0aWMgaW50IGFkNzI5MV9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KPiAg
CQkJY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmlkKQ0KPiAgew0KPiAtCXN0cnVjdCBhZDcy
OTFfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBjbGllbnQtPmRldi5wbGF0Zm9ybV9kYXRhOw0KPiAg
CXN0cnVjdCBhZDcyOTFfY2hpcF9pbmZvICpjaGlwOw0KPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXY7DQo+ICAJaW50IHJldDsNCj4gQEAgLTQ3NSwxNiArNDcyLDYgQEAgc3RhdGljIGludCBh
ZDcyOTFfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gIAkJcmV0dXJuIC1FTk9N
RU07DQo+ICAJY2hpcCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICANCj4gLQlpZiAocGRhdGEg
JiYgcGRhdGEtPnVzZV9leHRlcm5hbF9yZWYpIHsNCj4gLQkJY2hpcC0+cmVnID0gZGV2bV9yZWd1
bGF0b3JfZ2V0KCZjbGllbnQtPmRldiwgInZyZWYiKTsNCj4gLQkJaWYgKElTX0VSUihjaGlwLT5y
ZWcpKQ0KPiAtCQkJcmV0dXJuIFBUUl9FUlIoY2hpcC0+cmVnKTsNCj4gLQ0KPiAtCQlyZXQgPSBy
ZWd1bGF0b3JfZW5hYmxlKGNoaXAtPnJlZyk7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4g
cmV0Ow0KPiAtCX0NCj4gLQ0KPiAgCW11dGV4X2luaXQoJmNoaXAtPnN0YXRlX2xvY2spOw0KPiAg
CS8qIHRoaXMgaXMgb25seSB1c2VkIGZvciBkZXZpY2UgcmVtb3ZhbCBwdXJwb3NlcyAqLw0KPiAg
CWkyY19zZXRfY2xpZW50ZGF0YShjbGllbnQsIGluZGlvX2Rldik7DQo+IEBAIC00OTUsOCArNDgy
LDE5IEBAIHN0YXRpYyBpbnQgYWQ3MjkxX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQs
DQo+ICAJCQlBRDcyOTFfVF9TRU5TRV9NQVNLIHwgLyogVHNlbnNlIGFsd2F5cyBlbmFibGVkICov
DQo+ICAJCQlBRDcyOTFfQUxFUlRfUE9MQVJJVFk7IC8qIHNldCBpcnEgcG9sYXJpdHkgbG93IGxl
dmVsICovDQo+ICANCj4gLQlpZiAocGRhdGEgJiYgcGRhdGEtPnVzZV9leHRlcm5hbF9yZWYpDQo+
ICsJY2hpcC0+cmVnID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKCZjbGllbnQtPmRldiwg
InZyZWYiKTsNCj4gKwlpZiAoIUlTX0VSUihjaGlwLT5yZWcpKSB7DQo+ICsJCXJldCA9IHJlZ3Vs
YXRvcl9lbmFibGUoY2hpcC0+cmVnKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQ7
DQo+ICsNCj4gIAkJY2hpcC0+Y29tbWFuZCB8PSBBRDcyOTFfRVhUX1JFRjsNCj4gKwl9IGVsc2Ug
ew0KPiArCQlpZiAoUFRSX0VSUihjaGlwLT5yZWcpICE9IC1FTk9ERVYpDQo+ICsJCQlyZXR1cm4g
UFRSX0VSUihjaGlwLT5yZWcpOw0KPiArDQo+ICsJCWNoaXAtPnJlZyA9IE5VTEw7DQo+ICsJfQ0K
PiAgDQo+ICAJaW5kaW9fZGV2LT5uYW1lID0gaWQtPm5hbWU7DQo+ICAJaW5kaW9fZGV2LT5jaGFu
bmVscyA9IGFkNzI5MV9jaGFubmVsczsNCj4gQEAgLTU2OSw5ICs1NjcsMTYgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIGFkNzI5MV9pZFtdID0gew0KPiAgDQo+ICBNT0RVTEVf
REVWSUNFX1RBQkxFKGkyYywgYWQ3MjkxX2lkKTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgYWQ3MjkxX29mX21hdGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJsZSA9
ICJhZGksYWQ3MjkxIiwgfSwNCj4gKwl7fSwNCg0KWzJdDQppZiB1cGRhdGluZyBbMV0sIG1heWJl
IHJlbW92ZSB0aGUgdHJhaWxpbmcgY29tbWEgZm9yIHRoZSBudWxsLXRlcm1pbmF0b3I7DQpzbywg
IHt9LCAgLT4gIHt9DQpub3QgYSBiaWdneSwgYnV0IHRoZXJlIGFyZSBjaGFuY2VzIHRoYXQgc29t
ZW9uZSBlbHNlIG1pZ2h0IGNvbXBsYWluIGFib3V0IGl0DQpiZWZvcmUgSm9uYXRoYW4gZ2V0cyBh
IGNoYW5jZSB0byBsb29rIG92ZXIgdGhpczsNCg0KPiArfTsNCj4gK01PRFVMRV9ERVZJQ0VfVEFC
TEUob2YsIGFkNzI5MV9vZl9tYXRjaCk7DQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZl
ciBhZDcyOTFfZHJpdmVyID0gew0KPiAgCS5kcml2ZXIgPSB7DQo+ICAJCS5uYW1lID0gS0JVSUxE
X01PRE5BTUUsDQo+ICsJCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cihhZDcyOTFfb2Zf
bWF0Y2gpLA0KDQpbMV0NCm5vdCBzdXJlIGlmIHRoZXJlIHdhcyBhIGNvbW1lbnQgYWJvdXQgdGhp
cywgYnV0IEknZCByZW1vdmUgdGhlIG9mX21hdGNoX3B0cigpDQphbmQganVzdCBhc3NpZ24gdGhp
cyBkaXJlY3RseTsNCmkuZS4gIC5vZl9tYXRjaF90YWJsZSA9IGFkNzI5N19vZl9tYXRjaCwNCg0K
dGhlcmUgaXMgc29tZSBjb2RlIHRoYXQgY2FuIGFsc28gaGFuZGxlIHRoaXMgT0YtdGFibGUgZm9y
IEFDUEkgYXMgd2VsbDsgSSBkb24ndA0Ka25vdyBpZiB0aGlzIGlzIHN1ZmZpY2llbnQgZm9yIEFD
UEkgW3dpdGggdGhpcyBwYXRjaF0sIGJ1dCBpdCdzIGEgZ29vZCBpZGVhIHRvDQpwcmVwYXJlIGZv
ciB0aGF0Ow0KDQoNCj4gIAl9LA0KPiAgCS5wcm9iZSA9IGFkNzI5MV9wcm9iZSwNCj4gIAkucmVt
b3ZlID0gYWQ3MjkxX3JlbW92ZSwNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZv
cm1fZGF0YS9hZDcyOTEuaA0KPiBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZDcyOTEu
aA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggYjFmZDE1MzBjOWE1Li4wMDAw
MDAwMDAwMDANCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2FkNzI5MS5oDQo+
ICsrKyAvZGV2L251bGwNCj4gQEAgLTEsMTMgKzAsMCBAQA0KPiAtLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gLSNpZm5kZWYgX19JSU9fQUQ3MjkxX0hfXw0KPiAtI2Rl
ZmluZSBfX0lJT19BRDcyOTFfSF9fDQo+IC0NCj4gLS8qKg0KPiAtICogc3RydWN0IGFkNzI5MV9w
bGF0Zm9ybV9kYXRhIC0gQUQ3MjkxIHBsYXRmb3JtIGRhdGENCj4gLSAqIEB1c2VfZXh0ZXJuYWxf
cmVmOiBXaGV0aGVyIHRvIHVzZSBhbiBleHRlcm5hbCBvciBpbnRlcm5hbCByZWZlcmVuY2UNCj4g
dm9sdGFnZQ0KPiAtICovDQo+IC1zdHJ1Y3QgYWQ3MjkxX3BsYXRmb3JtX2RhdGEgew0KPiAtCWJv
b2wgdXNlX2V4dGVybmFsX3JlZjsNCj4gLX07DQo+IC0NCj4gLSNlbmRpZg0K
