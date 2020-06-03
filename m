Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85BD1ECD5E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgFCKTh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 06:19:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15530 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgFCKTf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 06:19:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053AJ364024266;
        Wed, 3 Jun 2020 06:19:14 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00128a01.pphosted.com with ESMTP id 31e4skrwxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 06:19:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw5a1DZ18Qzc/XAOh69EJJx98vha6Vs0qFNabwH4P/JU0odmeX+IRuogramKpgTwATBl8al1l4aiJnkYPpKLZ+hjvsvfnUmVDgxefSPpa6onrGghyseCY0Zdo3gEENkLnNCQ56ouFZBs+KahXbvqP/SKJ08jsVM0Q8PCDxN10s544g3pCpMtABMD+HCvh72YkIdUUdccuu7QvT5ZltFL1itvyCUdbRqrcKqsMYs3RiFwWlszE+bn9JquLGJHrvupdh0cwb3UKFdqi4KzjxKUOtTodgjphHfUuHfBcRRE/xw6hD15tkoCFbl+jZCtBSFauh+eEzVKFegHqjj8rs0Y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oID6TCyRvc2WXXxY4PnAIzJSsM2EC1d0o9xIqhLNkFE=;
 b=D8BwAa7SP/WE72aASbO5TpNFVytMLja4YuFo4ay3pcJNAups4i4sRlpYnUOFwKgDZ0IOJs9Fxr+5+h+S9zW9XmXSwvUDcoijjlBzpcYZC0/Cl53nxya2b74gdfSSVpaCcOIe8xwpHv/r0WTO47l/bE1PK+0TN6dLTAQkAkcCrIsaQ/UGjNy1w26zsV9ycz1cSsbb6wzwA7UrG02aeR7CKZt7AANkoPjS8EJWTr+6z+ZQ+L4yVhtIGXsGWYMQQOOSApG4j/iRB4n7ADEJ5DufaBmCIJPzNCXtxt9CDz98PVC701u7MzlgjAkEA8Ah/0VxHjzWiVRoMruIXM2xnfTwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oID6TCyRvc2WXXxY4PnAIzJSsM2EC1d0o9xIqhLNkFE=;
 b=66VWlnG+zlYwE41nSeo7JSXCi0RpYxQueoEhZ2JCuge//67MG9jtxsiYUWbBdaNEZvaGV74grWLRRHdgEiFHBJHcHfmxDGlMHP5y2dtAKJLIMT+rC9j0nD0yywcDkuQKA4BlYLwMivgx1wjJA2oVIQo6bzETrjI376IdwO08YvU=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3675.namprd03.prod.outlook.com (2603:10b6:5:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 10:19:12 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 10:19:12 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hslester96@gmail.com" <hslester96@gmail.com>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.cercueil@analog.com" <paul.cercueil@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v3] iio: amplifiers: ad8366: Change devm_gpiod_get() to
 optional and add the missed check
Thread-Topic: [PATCH v3] iio: amplifiers: ad8366: Change devm_gpiod_get() to
 optional and add the missed check
Thread-Index: AQHWOYkQTe2ar2DxB0uchj/PiWxC56jGrdmA
Date:   Wed, 3 Jun 2020 10:19:12 +0000
Message-ID: <36f033adf9b53adb289e7569ea5fca647c0dbb7a.camel@analog.com>
References: <20200603092610.1424489-1-hslester96@gmail.com>
In-Reply-To: <20200603092610.1424489-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2262a0a2-27ce-4ed4-6107-08d807a78f89
x-ms-traffictypediagnostic: DM6PR03MB3675:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB3675983D7BF51B412B7B45DFF9880@DM6PR03MB3675.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KS7S9v47VL4+DWAxcuA/pNXoGHXT5dlOm/vRaQbe43k0ahVA/ywFmV8xmV2WggZYxunEYpRUKD3OcdoGt50IbQYhxYfNzjf8Xcnrw63GNV9WyZGLoJgIPSnv9kLMPVQZS7Z02MjrDDt9mcwXBbw37phbHVowkNYar3yy/UqW7IwrxRICrydYS/z/rK/KCyurhd3RQVziRgj05L1PEOu3w5O8uE2WmuvW/Vz/Msq/pjs7JkBB/8m6PIrafHUIN8he6d3AEScYAKPuLtJ6BRI74J4HaCM73aE58bybkzhd245THMPjmzgZSZQVRI48Rhso93fqIipqlkdT9PDAILyXYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(6506007)(6486002)(26005)(186003)(8936002)(2616005)(316002)(8676002)(478600001)(54906003)(6916009)(6512007)(66446008)(83380400001)(71200400001)(4326008)(2906002)(76116006)(91956017)(66946007)(66556008)(66476007)(86362001)(64756008)(36756003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1CtvPm2H26PeZpGyYeMTTv7iG47a90Wq1h/fNRISrBLUEqO/VsOcf+76166xMk9pzyLJa7HF+wIR6KM/yBM5/8fKRxHn6Rjs5/GHnxf+db2HP+icRqPCrHlTkQ7xM+l4PM0ZMkzPtx0vaoOwiPDEu9uQmxqBCFoi0ggQ2y9i/MFghnQmLsLNgYXx5Chci1U9OjbmortUwf3BK+4wl1n1e/r0ivTIGopX0bSDVhSwNf5pkVaBcoxODIpk9yWcZmwa+PLVOQGuXDnqnLjaF6BWjB6+qJHBgzgbLrAnKUAd7H2jqBZtUUp7bcDGuR68Cb84tDRaBuG6Njq/9vtyITRg0b6Df6bfwTAhYYJpU4SskqOHMENYtp0AGQLodynFnbqq2OFO/d1jg+H3tNQswam11wQ1iRn7vE5WT6SyPmx0g6vUv54e02JnHf9Tg5C8nhnbAC+lMe52qLEF8+r87zzG/ma862boinF/XduB4IV02ss=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7574E6F69FDC854BBC756F3A37DD13BA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2262a0a2-27ce-4ed4-6107-08d807a78f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 10:19:12.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsgRuCBMkBwFGENvFgpjFMzTxCm6XTMRE8SP+5OPAh0r7yMmEFlP225YhV1Up70LSW/3YpzquuPf6mPthNBt/IHJEWPqj+rQQit9njYslys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3675
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_11:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 cotscore=-2147483648 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030080
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTAzIGF0IDE3OjI2ICswODAwLCBDaHVob25nIFl1YW4gd3JvdGU6DQo+
IFNpbmNlIGlmIHRoZXJlIGlzIG5vIEdQSU8sIG5vdGhpbmcgaGFwcGVucywgcmVwbGFjZSBkZXZt
X2dwaW9kX2dldCgpDQo+IHdpdGggZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoKS4NCj4gQWxzbyBh
ZGQgSVNfRVJSKCkgdG8gZml4IHRoZSBtaXNzaW5nLWNoZWNrIGJ1Zy4NCj4gDQoNCkFja2VkLWJ5
OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+
IEZpeGVzOiBjZWUyMTFmNGU1YTAgKCJpaW86IGFtcGxpZmllcnM6IGFkODM2NjogQWRkIHN1cHBv
cnQgZm9yIHRoZSBBREE0OTYxDQo+IERHQSIpDQo+IFNpZ25lZC1vZmYtYnk6IENodWhvbmcgWXVh
biA8aHNsZXN0ZXI5NkBnbWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAgIC0g
Q2hhbmdlIGRldm1fZ3Bpb2RfZ2V0KCkgdG8gb3B0aW9uYWwuDQo+ICAgLSBNb2RpZnkgZGVzY3Jp
cHRpb24uDQo+IA0KPiAgZHJpdmVycy9paW8vYW1wbGlmaWVycy9hZDgzNjYuYyB8IDYgKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYW1wbGlmaWVycy9hZDgzNjYuYyBiL2RyaXZlcnMv
aWlvL2FtcGxpZmllcnMvYWQ4MzY2LmMNCj4gaW5kZXggNjIxNjdiODdjYWVhLi44ODE5ZTg5OTdm
NzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FtcGxpZmllcnMvYWQ4MzY2LmMNCj4gKysr
IGIvZHJpdmVycy9paW8vYW1wbGlmaWVycy9hZDgzNjYuYw0KPiBAQCAtMjYyLDggKzI2MiwxMiBA
QCBzdGF0aWMgaW50IGFkODM2Nl9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgCWNh
c2UgSURfQURBNDk2MToNCj4gIAljYXNlIElEX0FETDUyNDA6DQo+ICAJY2FzZSBJRF9ITUMxMTE5
Og0KPiAtCQlzdC0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0KCZzcGktPmRldiwgInJlc2V0
IiwNCj4gKwkJc3QtPnJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCgmc3BpLT5k
ZXYsICJyZXNldCIsDQo+ICAJCQlHUElPRF9PVVRfSElHSCk7DQo+ICsJCWlmIChJU19FUlIoc3Qt
PnJlc2V0X2dwaW8pKSB7DQo+ICsJCQlyZXQgPSBQVFJfRVJSKHN0LT5yZXNldF9ncGlvKTsNCj4g
KwkJCWdvdG8gZXJyb3JfZGlzYWJsZV9yZWc7DQo+ICsJCX0NCj4gIAkJaW5kaW9fZGV2LT5jaGFu
bmVscyA9IGFkYTQ5NjFfY2hhbm5lbHM7DQo+ICAJCWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0g
QVJSQVlfU0laRShhZGE0OTYxX2NoYW5uZWxzKTsNCj4gIAkJYnJlYWs7DQo=
