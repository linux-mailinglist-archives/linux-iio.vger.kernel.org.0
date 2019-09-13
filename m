Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26EBB1864
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 08:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfIMGh4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 02:37:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61808 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbfIMGh4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 02:37:56 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D6XEtq028460;
        Fri, 13 Sep 2019 02:37:19 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2050.outbound.protection.outlook.com [104.47.40.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfs4sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 02:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnK+2x+18037em7Bnlf9gNYcmMF2lq5ozQenG6fqSGnRrADTlKBFo2PQjcomof3pfrYEP16woUGfh62vD3a98ck2IkPinChPqTH2iaQxlqyC0+UH8pglQDhfo7gMJWvdGjL4o8YJZDPp2xB/AMER5lNa/aPFTJGS2AeHV9UEeC2hB1wGpIS/8/4zsHWNdNPOuqwfRJi5rGzov63aax1ow0333jbG0/lfSshnrcRPSFg0pvcbT93S9MdSP65tZ0Wpksf5Id0loWaXJsSgjyV11l+MNPcsbVvy2pD/nod1+/LQFSfbEywZzuacxNXLIaw5Jxyj3QnbKpIWTvMu4N6apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9/tGmswxqgya2/s9lwZX2NVoNBpz/a5Qx8Dl9rF6ao=;
 b=Ep4HSf10gvU/SATD51w/MFvmQsdmjEUEPyR63gbLeXhKXvkpgE/0Pv0SAjlsVX1Li0v99WVArM3e6WI/+rORygMUJtm25S7H60v7H6Nq09Zvey+FATVzNZUSHIYBqvSAkRW5a2FzOY6bh+8n7Ia3k0JJfJGPzLa+KVrtbREWRoFEYCxdS9oeTEfh9OhdVvXO5nkfe9m4a652hnio63riSjkITfbr8GpD5dPiQM/QnnQ4SJvyIg2GFMXjbhxPrDSxIvrzDBO1hNQgL9ehp5OizBVDkIO4ZxhYbl39HHk53Sb5/JTN9wrdfcb6ECFXtgwNSRRvyn794lI/CctR1h1CFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9/tGmswxqgya2/s9lwZX2NVoNBpz/a5Qx8Dl9rF6ao=;
 b=UkI5f9yL/MvPuNOY5r8VoE90n7I0tSM+BsG05inHhwNxucBUIhjAa3eB1tc3lmk0zWMrmZVIb9vJyOGGwKSd3mgD8U0RBZXhzk1B8V99PtlOSp8As2z/mxTM/LRw3RdNka0dZsinwtV7zl4fqh6r83xxB/SgLwLRwYIiLwYK2pk=
Received: from MN2PR03MB5200.namprd03.prod.outlook.com (10.186.144.199) by
 MN2PR03MB5264.namprd03.prod.outlook.com (10.186.145.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 06:37:17 +0000
Received: from MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::e8d8:1709:332a:fed6]) by MN2PR03MB5200.namprd03.prod.outlook.com
 ([fe80::e8d8:1709:332a:fed6%3]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 06:37:17 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: ad7949: kill pointless "readback"-handling code
Thread-Topic: [PATCH 1/4] iio: ad7949: kill pointless "readback"-handling code
Thread-Index: AQHVaXh74ZeP0zj7xkGlcB0c6scOiKcpWraA
Date:   Fri, 13 Sep 2019 06:37:17 +0000
Message-ID: <e592cdc194cfa0ac0eb1a9539d890a1e5f70feb1.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <20190912144310.7458-2-andrea.merello@gmail.com>
In-Reply-To: <20190912144310.7458-2-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bf1f725-2474-448a-f79b-08d73814d288
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR03MB5264;
x-ms-traffictypediagnostic: MN2PR03MB5264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5264B09B5E3703163A443688F9B30@MN2PR03MB5264.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(6436002)(305945005)(7736002)(5660300002)(76176011)(478600001)(110136005)(6506007)(118296001)(81166006)(8936002)(8676002)(81156014)(86362001)(25786009)(316002)(4326008)(229853002)(6486002)(2201001)(2906002)(14454004)(71190400001)(71200400001)(99286004)(66556008)(66476007)(64756008)(66446008)(66946007)(3846002)(6116002)(91956017)(76116006)(256004)(486006)(476003)(36756003)(2616005)(66066001)(6246003)(446003)(53936002)(11346002)(2501003)(6512007)(186003)(102836004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5264;H:MN2PR03MB5200.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pq0www4t/cutHBoG+H21PWRFTRViXyvNxiI0intPwlB9yGjcUPJ+YNkBxJP2+pFLqNzfTAtlCBRoHU4hl21wbkHNrV2DOBZ1M23MvpWPbisNAT9ttqFSZrN0D7LfLyjSSqXh/TttdBh2nS60RVoaPM43R+XanAByI/x16ww91Y29Z7GMrcDSSPEM0WeyBKce1A2ilZvEDlT1U1+9Q142DJfsnIWmxgasJ3u9omHA9c2zh5LW+0gu+8d4Bt5wFCVz3qEpceF7FUBStd7oN0JXjGLop/W2jH6DqZzbGV0ym0UxmhGBAmOJoKszjbTDtg9swFXZDcUbgMs9GJu9Aq488SzMVVOCBxsqDEX/7pXJoxIKYWL4ymLx14oBIlpPPr3Hw7mA+ZzigBLWfMkgyM/Srg4V++/dzdbJlz+fN8HWJd0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34958B4E27736A42ACED89AFBF8FA088@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf1f725-2474-448a-f79b-08d73814d288
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 06:37:17.7796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gx9PqQzOqZY+TFWMbHlbp650Ses3Ru8C3FSfJjdwdncuKxAqQEe/+++Qt/IQLLPaBkQoijqxs9RJcKfveYFE/YVlKcmUl5BJ8Ra5qehAQPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5264
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_04:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDE2OjQzICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gVGhlIGRldmljZSBjb3VsZCBiZSBjb25maWd1cmVkIHRvIHNw
aXQgb3V0IGFsc28gdGhlIGNvbmZpZ3VyYXRpb24gd29yZA0KPiB3aGlsZSByZWFkaW5nIHRoZSBB
RCByZXN1bHQgdmFsdWUgKGluIHRoZSBzYW1lIFNQSSB4ZmVyKSAtIHRoaXMgaXMgY2FsbGVkDQo+
ICJyZWFkYmFjayIgaW4gdGhlIGRldmljZSBkYXRhc2hlZXQuDQo+IA0KPiBUaGUgZHJpdmVyIGNo
ZWNrcyBpZiByZWFkYmFjayBpcyBlbmFibGVkIGFuZCBpdCBldmVudHVhbGx5IGFkanVzdHMgdGhl
IFNQSQ0KPiB4ZmVyIGxlbmd0aCBhbmQgaXQgYXBwbGllcyBwcm9wZXIgc2hpZnRzIHRvIHN0aWxs
IGdldCB0aGUgZGF0YSwgZGlzY2FyZGluZw0KPiB0aGUgY29uZmlndXJhdGlvbiB3b3JkLg0KPiAN
Cj4gVGhlIHJlYWRiYWNrIG9wdGlvbiBpcyBhY3R1YWxseSBuZXZlciBlbmFibGVkICh0aGUgZHJp
dmVyIGRpc2FibGVzIGl0KSwgc28NCj4gdGhlIHNhaWQgY2hlY2tzIGRvIG5vdCBzZXJ2ZSBmb3Ig
YW55IHB1cnBvc2UuDQo+IA0KPiBTaW5jZSBlbmFibGluZyB0aGUgcmVhZGJhY2sgb3B0aW9uIHNl
ZW1zIG5vdCB0byBwcm92aWRlIGFueSBhZHZhbnRhZ2UgKHRoZQ0KPiBkcml2ZXIgZW50aXJlbHkg
c2V0cyB0aGUgY29uZmlndXJhdGlvbiB3b3JkIHdpdGhvdXQgcmVseWluZyBvbiBhbnkgZGVmYXVs
dA0KPiB2YWx1ZSksIGp1c3Qga2lsbCB0aGUgc2FpZCwgdW51c2VkLCBjb2RlLg0KDQpSZXZpZXdl
ZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4N
Cg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIE1lcmVsbG8gPGFuZHJlYS5tZXJlbGxvQGdt
YWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvYWQ3OTQ5LmMgfCAyNyArKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDI0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDc5
NDkuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDkuYw0KPiBpbmRleCBhYzBmZmZmNmM1YWUuLjUx
ODA0NGMzMWE3MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jDQo+ICsr
KyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDkuYw0KPiBAQCAtNTcsMjkgKzU3LDExIEBAIHN0cnVj
dCBhZDc5NDlfYWRjX2NoaXAgew0KPiAgCXUzMiBidWZmZXIgX19fX2NhY2hlbGluZV9hbGlnbmVk
Ow0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGJvb2wgYWQ3OTQ5X3NwaV9jZmdfaXNfcmVhZF9iYWNr
KHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMpDQo+IC17DQo+IC0JaWYgKCEoYWQ3
OTQ5X2FkYy0+Y2ZnICYgQUQ3OTQ5X0NGR19SRUFEX0JBQ0spKQ0KPiAtCQlyZXR1cm4gdHJ1ZTsN
Cj4gLQ0KPiAtCXJldHVybiBmYWxzZTsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIGludCBhZDc5NDlf
c3BpX2JpdHNfcGVyX3dvcmQoc3RydWN0IGFkNzk0OV9hZGNfY2hpcCAqYWQ3OTQ5X2FkYykNCj4g
LXsNCj4gLQlpbnQgcmV0ID0gYWQ3OTQ5X2FkYy0+cmVzb2x1dGlvbjsNCj4gLQ0KPiAtCWlmIChh
ZDc5NDlfc3BpX2NmZ19pc19yZWFkX2JhY2soYWQ3OTQ5X2FkYykpDQo+IC0JCXJldCArPSBBRDc5
NDlfQ0ZHX1JFR19TSVpFX0JJVFM7DQo+IC0NCj4gLQlyZXR1cm4gcmV0Ow0KPiAtfQ0KPiAtDQo+
ICBzdGF0aWMgaW50IGFkNzk0OV9zcGlfd3JpdGVfY2ZnKHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAg
KmFkNzk0OV9hZGMsIHUxNiB2YWwsDQo+ICAJCQkJdTE2IG1hc2spDQo+ICB7DQo+ICAJaW50IHJl
dDsNCj4gLQlpbnQgYml0c19wZXJfd29yZCA9IGFkNzk0OV9zcGlfYml0c19wZXJfd29yZChhZDc5
NDlfYWRjKTsNCj4gKwlpbnQgYml0c19wZXJfd29yZCA9IGFkNzk0OV9hZGMtPnJlc29sdXRpb247
DQo+ICAJaW50IHNoaWZ0ID0gYml0c19wZXJfd29yZCAtIEFENzk0OV9DRkdfUkVHX1NJWkVfQklU
UzsNCj4gIAlzdHJ1Y3Qgc3BpX21lc3NhZ2UgbXNnOw0KPiAgCXN0cnVjdCBzcGlfdHJhbnNmZXIg
dHhbXSA9IHsNCj4gQEAgLTEwNyw3ICs4OSw3IEBAIHN0YXRpYyBpbnQgYWQ3OTQ5X3NwaV9yZWFk
X2NoYW5uZWwoc3RydWN0IGFkNzk0OV9hZGNfY2hpcCAqYWQ3OTQ5X2FkYywgaW50ICp2YWwsDQo+
ICAJCQkJICAgdW5zaWduZWQgaW50IGNoYW5uZWwpDQo+ICB7DQo+ICAJaW50IHJldDsNCj4gLQlp
bnQgYml0c19wZXJfd29yZCA9IGFkNzk0OV9zcGlfYml0c19wZXJfd29yZChhZDc5NDlfYWRjKTsN
Cj4gKwlpbnQgYml0c19wZXJfd29yZCA9IGFkNzk0OV9hZGMtPnJlc29sdXRpb247DQo+ICAJaW50
IG1hc2sgPSBHRU5NQVNLKGFkNzk0OV9hZGMtPnJlc29sdXRpb24sIDApOw0KPiAgCXN0cnVjdCBz
cGlfbWVzc2FnZSBtc2c7DQo+ICAJc3RydWN0IHNwaV90cmFuc2ZlciB0eFtdID0gew0KPiBAQCAt
MTM4LDEwICsxMjAsNyBAQCBzdGF0aWMgaW50IGFkNzk0OV9zcGlfcmVhZF9jaGFubmVsKHN0cnVj
dCBhZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMsIGludCAqdmFsLA0KPiAgDQo+ICAJYWQ3OTQ5
X2FkYy0+Y3VycmVudF9jaGFubmVsID0gY2hhbm5lbDsNCj4gIA0KPiAtCWlmIChhZDc5NDlfc3Bp
X2NmZ19pc19yZWFkX2JhY2soYWQ3OTQ5X2FkYykpDQo+IC0JCSp2YWwgPSAoYWQ3OTQ5X2FkYy0+
YnVmZmVyID4+IEFENzk0OV9DRkdfUkVHX1NJWkVfQklUUykgJiBtYXNrOw0KPiAtCWVsc2UNCj4g
LQkJKnZhbCA9IGFkNzk0OV9hZGMtPmJ1ZmZlciAmIG1hc2s7DQo+ICsJKnZhbCA9IGFkNzk0OV9h
ZGMtPmJ1ZmZlciAmIG1hc2s7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCg==
