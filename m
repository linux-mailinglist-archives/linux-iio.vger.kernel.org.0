Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAE210CEF
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 15:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgGAN6C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 09:58:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56304 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730958AbgGAN6B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jul 2020 09:58:01 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061DURQk014663;
        Wed, 1 Jul 2020 09:57:40 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00128a01.pphosted.com with ESMTP id 31wyy6d4dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 09:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOtXiYIxsVnR592qoSBrIRtPkl69Xed+CfzUFp9vzmbZIIt7IFdXWS/dE7DxBT75aaXFfiEL7vBlSrxrmHk9KD0S1/ASuTvK9D7i85GRIUHnccNsQxoDoC3u/XRvJUteLOcdWjZyo6smMtOotvkZBSaozN8VIx7H5uqCova3cJDyl+kXOa33P43oat6JZ0ic4xIkxA+u0plsTcSHyNBcWFmb/TMrC3YUAmagSwN0JERxu6Ei/NhdKz0b+msPpgacZ+vzK37xfjmZEXLhNf7qdLTjCnm4Ss32iSjPQBVdcU/DRlvy6EKTFuT1Rop9sFarGR/kFBLgTVCXmzZvie0Kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znfaJWDR5yomvOwS2a8SOfpLqfMxa9wdrm4Z6o1gOh0=;
 b=ZHxQlhRMySbVAsdGI9Cs/P3pYUEogUhdb61oHS4QWDxZ385ph0jF65MW1+NiHWFwZrYxdrpFHvoXgiM0QlaFXmHnLM92zUcO3Gek+BrBBbIMPW1fIEKZvhuWZZrJHkV3qMBmCFSaIk1D1AoipwiK5PQDUjCywh9qTL4HVgiersZO4afNbnhVl/scX5S9UoPu6aKB6gRFbYS/ldjBLmG8FnF+x38fMPBAQmVjV5VdEjzR+GRZdGm/p+aB2ls2ophEDgFjQ6SUFmDj3UZwSu+eZmtJ8KnTlOStn0nwR9jgCaEKvsN+HHTQnawX0xCJ9Jrd5ooZUNYdYimMMaWffyc2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znfaJWDR5yomvOwS2a8SOfpLqfMxa9wdrm4Z6o1gOh0=;
 b=4tzboZC3nJ2u56/E4J1+gRSjI93++sZUYcjYw/CBQrj5ulaNfOjNIXBx6hIfyi68jQHK6/mfUW9tjOUKBkWIM8D/+3zgc2a00jJzlsc+rEDz0c+SUZgR+wZfzpSdfBFGWoDf4cZWA5vnIPVScHSCVFhw+Q2btoP/h+fB5AJUg9A=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM5PR03MB2746.namprd03.prod.outlook.com (2603:10b6:3:41::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 13:57:39 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 13:57:39 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/2] iio: adc: adi-axi-adc: Remove unneeded check
Thread-Topic: [PATCH 2/2] iio: adc: adi-axi-adc: Remove unneeded check
Thread-Index: AQHWT5/hMv0+5yuWEUSqpDweOs7F9qjyv+gA
Date:   Wed, 1 Jul 2020 13:57:38 +0000
Message-ID: <26b8c9a82d0f92976453d649d48698957ad2b5ed.camel@analog.com>
References: <20200701120442.258-1-nuno.sa@analog.com>
         <20200701120442.258-2-nuno.sa@analog.com>
In-Reply-To: <20200701120442.258-2-nuno.sa@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b87f36ea-38f2-4113-b66d-08d81dc6b76c
x-ms-traffictypediagnostic: DM5PR03MB2746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR03MB27462ED8A0E0EB0741534345F96C0@DM5PR03MB2746.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5MfOK2Vz3W2Y6YxbYZdlqF4wCpJ9iPOVQTiq1P6S79G4w9iiKkQ0mAsUYolTHB1fGQ1Iadow1ooXZObgCoMWWLuEXXIDbjwpgTbq+7HLr7rdyzas2tTbou6Seibb7pCUGgAWC+i9ySS2wb42FY9T7x+pJMhdyhi/CBgRmW0zAmnekdvdUUjadh4Z4jNuc46X2nMoSn5HJUuR/Bff29ZPBJ/2e3yqkV+cSJ6gP3kyYob14Kr+P/IHFG/splIfuBRDbE/WZKkT3J7x4/9jHqWaIImJgWLqHajFsKIIHOFXwtZFpQBjJmO29xgDFwsBzGS/dMNk/2vH74cbor48bfpqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(4326008)(83380400001)(6512007)(76116006)(66446008)(66556008)(66946007)(64756008)(66476007)(91956017)(36756003)(2616005)(6486002)(54906003)(8936002)(110136005)(186003)(8676002)(71200400001)(26005)(2906002)(4744005)(86362001)(6506007)(316002)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VjjoAcnUBnkvvN4xS0dzfvP29eZIZK5aVG02Qo3O9BgCfqaboPYBzklrBAgnfQUi9bIP5nhVBCoIssbW6XXM+qzvA0e1SzfxFMEnYeSnbCJZlPzbi920GtSh0NPv+G1zZIMkzntJuflbFEOdtAVRe1ryL36B8qMStVjNXRXGAkAT0RwgwaaT+70zg/dV2uFmJecS9ZlKSSAruw9Aakmqh2hHy10GG5RMqQbTCsRqPT+HGxnZqc9zobACl1al2Oa9XtM5MkH+Dxl0ag/MMucc6VaxB8k8qBkRgF0cHr/PBz7jzf9FEg/zvVz8DaBggDT+G4ZB/mdvc0uSxb9DFOUjJU1MmW/HJPTCn4OIq9ULj/e4Y0iZOkT3nt3mBwqMBwGDo2p1fUYg64oW4F9cepvTUlDziwQ5699lDF4WD7jCm4numd+o3lvIlMQLffrM34N2jzVUEiJtnfGvQ6BN8hPeHhfEtM51FuVNrqmZjgQTQKM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECE4F88F7D5AE549908FD2AA3A605A39@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87f36ea-38f2-4113-b66d-08d81dc6b76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 13:57:39.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzYkEJdPtJMvlERMkpPO2JPyQOV7TZ/m+jVijdPqR5mJ4fllKBFwU1+A5cqI4ESvmlIGp/qW6EC39LGIsSNydBSCUCjl3RpZYZHD7xSbXdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2746
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 cotscore=-2147483648 adultscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTAxIGF0IDE0OjA0ICswMjAwLCBOdW5vIFPDoSB3cm90ZToNCj4gW0V4
dGVybmFsXQ0KPiANCj4gTG9va2luZyBhdCB0aGUgcmVnaXN0ZXIgcGF0aCwgdGhlcmUgd2lsbCBi
ZSBiaWdnZXIgaXNzdWVzIGlmIGBkZXZgIGlzDQo+IE5VTEwuIEhlbmNlLCB3ZSBjYW4gZHJvcCB0
aGlzIGNoZWNrIGFuZCBhc3N1bWUgdGhlcmUncyBubyB3YXkgdGhhdCBgZGV2YA0KPiBjYW4gYmUg
TlVMTCBhdCB0aGlzIHBvaW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8u
c2FAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvYWRpLWF4aS1hZGMuYyB8
IDMgLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9hZGMvYWRpLWF4aS1hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZGkt
YXhpLQ0KPiBhZGMuYw0KPiBpbmRleCA4NmI2YjY1OTE2ZWUuLmUyMTZlMzdlOGM4YyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkaS1heGktYWRjLmMNCj4gKysrIGIvZHJpdmVycy9p
aW8vYWRjL2FkaS1heGktYWRjLmMNCj4gQEAgLTMyNiw5ICszMjYsNiBAQCBzdGF0aWMgc3RydWN0
IGFkaV9heGlfYWRjX2NsaWVudA0KPiAqYWRpX2F4aV9hZGNfYXR0YWNoX2NsaWVudChzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ICAJbXV0ZXhfbG9jaygmcmVnaXN0ZXJlZF9jbGllbnRzX2xvY2spOw0K
PiAgDQo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShjbCwgJnJlZ2lzdGVyZWRfY2xpZW50cywgZW50
cnkpIHsNCj4gLQkJaWYgKCFjbC0+ZGV2KQ0KPiAtCQkJY29udGludWU7DQo+IC0NCg0KSSBtYXkg
bmVlZCB0byBjaGVjayB0aGlzIGFnYWluLg0KSSB0aGluayB0aGlzIG1heSBiZSBhIGxlZnQtb3Zl
ciwgb2Ygd2hlbiB0aGVyZSB3YXMgdW4tbWFuYWdlZA0KYWRpX2F4aV9hZGNfY29udl9yZWdpc3Rl
cigpDQoNCg0KPiAgCQlpZiAoY2wtPmRldi0+b2Zfbm9kZSAhPSBjbG4pDQo+ICAJCQljb250aW51
ZTsNCj4gIA0K
