Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D239519D788
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403834AbgDCN0Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 09:26:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21300 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgDCN0Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 09:26:25 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033DKFBa001951;
        Fri, 3 Apr 2020 09:26:04 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2054.outbound.protection.outlook.com [104.47.45.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6uq5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Apr 2020 09:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dlv3RWuQ/iKm01d323yaCauTrF1w1Lq9KYzana1LF01iQH9QNWeK8Rz5L9IYq3l3aDnwyi2r5pJqjC+GsZuawd+83EGXP0FeujxmdAbGoOY2E7TbhogvVgNMtktNGKpT1tBKOP9jBJBb5IjNo5FVQ1cAEM/YdukIdywwmZ8UgF/LWZv537ocOgbWEmzjxX07jgyUzPuk61vhVGQ2yqiWeuDWTL6pJBYvtNs9Fvqpdi5aT3RGQoQGXivN+DdGmUeyDH6g3+Sy/fwfa2tVTXs1J2KyCnGLUpQrq0MAf0AMWAd1qfx4APtca3wPva8+mKatIMs8qDJOAd1jlJ6eFANPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZDsdeRU5Iu7EFrnNTq/s6c0xgEnOdcZSDiB1rGjWsI=;
 b=UWspVUG0vT9e11VqY6zmLAiWQ007tOgU14NWI/T0jk46+Hh8fZ+tKZmELCGE9FNDO0dF24KnLHZUT2mRg4YzSVvZOrZuY+Jvi0p7y2rBi4rzCsxMd87hW8lsg43C40QYzkIaNqEHM2JekOkpjAXDFSKNsS9tGkX4NGs6auLtYFEx5lIHfRUUD9GCzvp2gfudKoOCcxWhHYVFvEgggj/FTJ+qHidYeU5mX65bA31V4inA9mEMWsqDeOt43khnJ1asEglh5bzFTxySR5uvFr5vbdDqkNXWVovttFB9ynHLXQ6sAtqOg55nt/dao2ey13muRLsnie5h6oQVvBpa5lEX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZDsdeRU5Iu7EFrnNTq/s6c0xgEnOdcZSDiB1rGjWsI=;
 b=rClZkZqgruCg1Al8KNxZnpGGMh60WkKhZ7f/bNmb2j0FguYAjjasAjNa1aH1zSiYUMk7bE1JHC55liQNisg4OlkyDoaQCy2gE/jT5CitLDDfSxjyYXYgxm3VF9CYKDBCaMWu/G+8h8CN/sGBqPOqSVXGkQtvD68MWhXbsbS7Lio=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4524.namprd03.prod.outlook.com (2603:10b6:5:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 13:26:01 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 13:26:01 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: dac: ad5770r: fix off-by-one check on maximum
 number of channels
Thread-Topic: [PATCH][next] iio: dac: ad5770r: fix off-by-one check on maximum
 number of channels
Thread-Index: AQHWCbemaYLKa3hl2U6vSvhXLgXhkKhnY2UA
Date:   Fri, 3 Apr 2020 13:26:00 +0000
Message-ID: <84628ce3f18d1a1ab50f76d04386dbef46f151b3.camel@analog.com>
References: <20200403125838.71271-1-colin.king@canonical.com>
In-Reply-To: <20200403125838.71271-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79d4fa41-e390-4bb2-ad3f-08d7d7d28d78
x-ms-traffictypediagnostic: DM6PR03MB4524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB4524EE1942627361A90303A5F9C70@DM6PR03MB4524.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(2616005)(6486002)(91956017)(64756008)(76116006)(316002)(66446008)(66946007)(478600001)(66556008)(66476007)(8936002)(54906003)(36756003)(86362001)(26005)(71200400001)(2906002)(81166006)(110136005)(5660300002)(8676002)(81156014)(4326008)(6512007)(186003)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KvWl/5Knk7SifqoZpVQoNHDt9g7jgiKw8rYiJgm1AraZNDdSF5jFsu//2kPJk1Q1tyDkESMWVTdXEc/39wxJhrpBUuipoGH52O3xPau5uEzkpBBsbr4cwPMUHsvppvWNRagU6QFM9+G7mcwbGAuWmWeFwO+74XUwEQxg8TTNZmncSxvZdl4DKr5nPybU/wF2MSuZIiQlyqObDITFNQqQ3wTRmsoqLPM+Bnuj3RxL+nI5ocOkGqbzEaSuy7f+R5+/LakJ6IWzDWzIFAYNrTUMn1OKc2bl3+zwttMKcSxl0hPNMDGben5fhHozVsDFOEKw1vFUlkMkA447Mr1wd8EtpvqZXB/yNZS+OKg8dXqVdtMYsOuy4NB7DHZMWcfz6O0u2aVwnHXOd5okkCp6sKApglSN3KevZ4N5ywDp1rEAY+fSnUws1YEfriqdh6nQ+xl8gvJZr32gK4xElN6wA2qasDUWwrcXckh/QhoAh71DhG/Ne9s0thxt6AT2mJMZ7Cz
x-ms-exchange-antispam-messagedata: i9AYYNQY8yqf9d6wl/bFRlsmWAUPqofKxs9lOWhVEhrVZPj1DDssXYYVVooL//2/9beTZMaoR3tdvDGrvtwaA0wjTG1MMequVNqIzu3npKSLGiZo2AxND7n1XiYJKETElMwTSA50WBRIuUQ1iOJugw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <555608290CAFE541BD979239B22E67A1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d4fa41-e390-4bb2-ad3f-08d7d7d28d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 13:26:00.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8aMKTXZx/xk7uMFTRQrGicnls7FyfYGtwX9HfzmJAR8SDQMrHZF0bd2S35XENWv6/xJsOQRHeAzJPefvEim2btbNjjMw4285aleqp+tiDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4524
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_10:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1011 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTAzIGF0IDEzOjU4ICswMTAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPg0KPiANCj4gQ3VycmVudGx5IHRoZXJlIGlzIGFuIG9mZi1ieS1vbmUgY2hlY2sgb24g
dGhlIG51bWJlciBvZiBjaGFubmVscyB0aGF0DQo+IHdpbGwgY2F1c2UgYW4gYXJyeSBvdmVycnVu
IGluIGFycmF5IHN0LT5vdXRwdXRfbW9kZSB3aGVuIGNhbGxpbmcgdGhlDQo+IGZ1bmN0aW9uIGQ1
Nzcwcl9zdG9yZV9vdXRwdXRfcmFuZ2UuIEZpeCB0aGlzIGJ5IHVzaW5nID49IHJhdGhlciB0aGFu
ID4NCj4gdG8gY2hlY2sgZm9yIG1heGltdW0gbnVtYmVyIG9mIGNoYW5uZWxzLg0KPiANCg0KUmV2
aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5j
b20+DQoNCj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIk91dC1vZi1ib3VuZHMgYWNjZXNzIikNCj4g
Rml4ZXM6IGNiYmI4MTk4MzdmNiAoImlpbzogZGFjOiBhZDU3NzByOiBBZGQgQUQ1NzcwUiBzdXBw
b3J0IikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25p
Y2FsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9kYWMvYWQ1Nzcwci5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9paW8vZGFjL2FkNTc3MHIuYyBiL2RyaXZlcnMvaWlvL2RhYy9hZDU3
NzByLmMNCj4gaW5kZXggYTk4ZWE3NjczMmU3Li4yZDc2MjNiOWIyYzAgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaWlvL2RhYy9hZDU3NzByLmMNCj4gKysrIGIvZHJpdmVycy9paW8vZGFjL2FkNTc3
MHIuYw0KPiBAQCAtNTI1LDcgKzUyNSw3IEBAIHN0YXRpYyBpbnQgYWQ1Nzcwcl9jaGFubmVsX2Nv
bmZpZyhzdHJ1Y3QgYWQ1Nzcwcl9zdGF0ZQ0KPiAqc3QpDQo+ICAJCXJldCA9IGZ3bm9kZV9wcm9w
ZXJ0eV9yZWFkX3UzMihjaGlsZCwgIm51bSIsICZudW0pOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJ
cmV0dXJuIHJldDsNCj4gLQkJaWYgKG51bSA+IEFENTc3MFJfTUFYX0NIQU5ORUxTKQ0KPiArCQlp
ZiAobnVtID49IEFENTc3MFJfTUFYX0NIQU5ORUxTKQ0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+
ICANCj4gIAkJcmV0ID0gZndub2RlX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KGNoaWxkLA0K
