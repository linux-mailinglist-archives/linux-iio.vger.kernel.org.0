Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EAFB3A74
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfIPMhW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 08:37:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23104 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727950AbfIPMhV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 08:37:21 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8GCXUaS027290;
        Mon, 16 Sep 2019 08:37:15 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0w47k8t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 08:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJTaRgp0NKimqGsaRKkq1FV/NlKEWjOyJ76j0BrbjhrHbTgm+q1xV9ETikvOPT6sMq/9KXCVCcWJAg58lRYOi7u+RdrJNQ0OFnuztDTpHb3Pj8kPSEx2TyHxVKFMMVq53CSeiUPCYkAF5zpquL1zfSVDY+SOP+hDBwrgBfQlT2erSsKIaOJhpxhggXFSAfwTkm1UFxiOnC5+C67xrdBgV/kxZciZgBm/fC0FuWcjjrTTt/VoKnT6euEAAKlmXQXA/G5KEpaeRu/H1ZTi08AKk30mb0CrQiAnCz/WCwAJ6YRjA90nzPPYxDKjS8VqcfIyDmjiLRzYUh+G65YDm9stYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8d+FetZkSSGwp6YOGs4EWjSIgxhfzO5JTzMsDevBFs=;
 b=gjCzywTZp7TD3rAcRrL2swUbRzmDPUIEct1TaYETksRoD3q5UxfjheyWQt2fkaDsnA6o5WMtRwoAdiWvvK6w8vCnLTFFxOAFyAhc0YMekKJxPRdUK6kYafoFahRmgs2ueQirMzlmKgkf+X8p7locIYknoEaPbn4T4MlZ5xN1bMH59/MwgKBpGayEkyp3jP3JkklPiER329troUtEwxuvkdPQuM+PerlC/iWm9XEDuRUlmeW3in8/V54gFu8LCPrAQ7obpe+vlhFLE1qRpCCDW7+bKCgA7O8LHcfPxhhSWkjl3LWevCPFB4YYBx7cxU7u7NUrEkZmhWr0YR6ze/FAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8d+FetZkSSGwp6YOGs4EWjSIgxhfzO5JTzMsDevBFs=;
 b=ObJ98P4eM6F0dA6tZVVII24Zl7/SanjydPRskcp33GwkSn060bd5Rk3vh+QlwDXeUYe0qPkX6h6v/fxQch91k8iAtH8bdQt0wxyxo6iyOVavjdiKZZaaDnps832oZKa5/cLjPhSJoMeBhkxx8rIUUoJIxss90UZSIqT/MmXaggc=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5320.namprd03.prod.outlook.com (20.180.15.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 12:37:12 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 12:37:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Thread-Topic: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Thread-Index: AQHVag+8uWmQQq3ExEyRd/qnwNwICqcuP2sAgAADYYA=
Date:   Mon, 16 Sep 2019 12:37:12 +0000
Message-ID: <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
         <20190913114550.956-4-alexandru.ardelean@analog.com>
         <20190916122505.GC4352@sirena.co.uk>
In-Reply-To: <20190916122505.GC4352@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0360b10-fa26-4134-a48a-08d73aa29941
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5320;
x-ms-traffictypediagnostic: CH2PR03MB5320:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CH2PR03MB532072F146D11435FA38CB7AF98C0@CH2PR03MB5320.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(189003)(199004)(1730700003)(81156014)(6246003)(11346002)(446003)(478600001)(71190400001)(71200400001)(186003)(4744005)(2616005)(25786009)(66066001)(36756003)(6506007)(4326008)(3846002)(6116002)(102836004)(99286004)(2906002)(2351001)(2501003)(316002)(6306002)(486006)(256004)(476003)(66476007)(66946007)(76116006)(66446008)(64756008)(66556008)(8936002)(54906003)(26005)(76176011)(6512007)(53936002)(5660300002)(14454004)(6436002)(7736002)(229853002)(6916009)(7416002)(8676002)(5640700003)(305945005)(86362001)(118296001)(966005)(6486002)(81166006)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5320;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mxb7KMFr9O24E5aIo6aUbObI0QL1UVf8VAJ20MtfNhVenjDk9Da8ScVrVCo1mQKPqaOoefQ/vSaR6EACUiLANzkVyRgXcW5IKzTHrcDgC7B1ngOEU05GONcCl4CmkcUMf96Vn13Jd8VqYFtkN247hwE1a7zqY1yuKpY97uLZv4/+/81WmjCQa17pG7+9owZC2pdqyLFV4yElTaTU0A4gBdDH+qcxdoNIYV2Wg5PHENLEvOyWnD33Lz9hredwkpCaItZ1DKrJjrIKQnmToD3ksDETDiZV+ZzZa8JC/fCM0ajpLAt0veGHxhjmo6sGnaTeXPLYZU5JGRm5dPa3PkJzLEpCGiwQIOCGsv9wfpeoDuwrjxyx2MgGM2DMvfBv0+b9r8Z/mSq9ljBOONuhnVhYZbTVgUMq9rdCsP/WbkiKPbk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A207019A739BF4BB5EC44846BC146A6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0360b10-fa26-4134-a48a-08d73aa29941
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 12:37:12.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPCkEFEDvKiLto+zUPkEHfo6nU7EejwVsO9HqpIDScljev3n8IzsVKbQahrolw985wTDcTyPeoW0O7CS06yE3prMcIZBbCoW2lw/QK9+5f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5320
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_06:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160134
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDEzOjI1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIFNlcCAxMywgMjAxOSBhdCAwMjo0NTozOFBNICswMzAw
LCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+IA0KPiA+IC0JdTE2CQljc19jaGFuZ2VfZGVs
YXk7DQo+ID4gLQl1OAkJY3NfY2hhbmdlX2RlbGF5X3VuaXQ7DQo+ID4gKwlzdHJ1Y3Qgc3BpX2Rl
bGF5CWNzX2NoYW5nZV9kZWxheTsNCj4gDQo+IFRoaXMgYnJlYWtzIHRoZSBidWlsZCBhcyB0aGVy
ZSBpcyBhIHVzZXIgb2YgdGhpcyBpbnRlcmZhY2UuDQoNCg0KQWNrLg0KSm9uYXRoYW4gcG9pbnRl
ZCB0aGlzIG91dC4NClRoZXJlJ3MgYSBWMyB0aGF0IGNoYW5nZXMgYm90aCB0aGlzIGFuZCBpdCdz
IHVzZXIgKGluIElJTykuDQoNClYzOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlv
LzIwMTkwOTE2MDcxMDI0LjIxNDQ3LTEtYWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20vVC8j
dA0KDQpWMjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlpby8yMDE5MDkxMzExNTU0
OS4zODIzLTEtYWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20vVC8jdA0KDQpbIGFyY2hpdmUg
aXMgZnJvbSB0aGUgSUlPIGxpc3QgXQ0KDQpXZWxsLCBJJ20gaG9waW5nIHlvdSBhcmUgcmVmZXJy
aW5nIHRvIHRoZSBzYW1lIHVzZXIuDQoNCk9uIGEgZ2VuZXJhbCBub3RlOiBJIGFwb2xvZ2lzZSBm
b3IgdGhlIGFtb3VudCBvZiBub2lzZS9zcGFtIEkgYW0gZG9pbmcgaGVyZS4gU3RpbGwgYWRqdXN0
aW5nIHRvIGhvdyB0byBkbyB0aGluZ3MvY2hhbmdlcw0KdGhhdCB0b3VjaCAyIHN1YnN5c3RlbXMs
IGVzcGVjaWFsbHkgd2hlbiB0cmVlcyBhcmUgbm90IHF1aXRlIGluLXN5bmMuDQo=
