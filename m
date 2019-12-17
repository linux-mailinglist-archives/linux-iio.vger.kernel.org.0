Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14F4122A08
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfLQLaW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:30:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48778 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfLQLaW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:30:22 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHBSgqk016987;
        Tue, 17 Dec 2019 06:30:00 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvwhex1dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 06:30:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCwcL6uaE83NlqnoDzGc0fuHI7ES0qKHZSkX3fVx1vpxFLVoDVqjeA8yh5CeyKi7o1uL61TDNfORfHXP+RfQriie9VfKxOXDpqD8SNlR02ZY5d313uTjFngihXFy+YdaM/7ki/8TcjAexy9aDUHJcKVMZTQFz9/sAdCUBL9R8Hbe0jrsWb8iuMn0ujv7yfvzoBa2yPUQcPbl6peNE/7TikZye1xot71mPnbykz8+XQclczWxAW/9rce2ZY0TKwjJb1E4Z3dXDInUkHOgdQMNSyQzaL4efWrBZ+KeoCz4V/KeEtFsU4Xf8a6SQscG8LOM+4WeW9sjmUZ/6v9zWFCmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoWZJHhenBjJzWCgdz/cNSBno67OGBkjMEIsCSvEQSA=;
 b=H/qiANAUXcANEcQKNpEXfBRde/mKCdbpFWQ7IWn+OCvIaAleUjtX2bLN+rEX2hL1f+rbx8qJpZTMUOK417DQZeK6QUi5StKvLmHL9L6VADEs/BPmsiliNMMJe++W+5pJ2kHeK7fuyernzyEzaqtz+iee+3wATwg46+HTrckFNVPed5/XC8euc7HWCm0hFN8fFEUMWk2ALT9k8/d3Ya9xwBSli7nevpcljmnqDcAgz32ortbqitfDaRUVA+vs9QPhOGgB1U9dAj7QnmbBp9fy7Yp1JKfL42muDTzmLj9kvZNKGWvE4sdDqcijndiSdMB/ZgIDtGmGPllOdr24A2H3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoWZJHhenBjJzWCgdz/cNSBno67OGBkjMEIsCSvEQSA=;
 b=EltegmT6oP1BpPLBPtvNLfNnP4SFIjWCPyl0KYIygnMSvEPoKnJs/OrEfZi8uBAJ4hNL2PJuzqk9gCtjZth4YHtTw1/9ai8g09clCo6hNAjcSiHraQ/s/WKtpji8JvMIq4qUnfWHpslOV2dgtQMa6V4QMpz/nrMGEnxyxBTQons=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5318.namprd03.prod.outlook.com (20.180.15.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 11:29:58 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 11:29:57 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio: adc: ad7923: Remove the unused defines
Thread-Topic: [PATCH v3 1/4] iio: adc: ad7923: Remove the unused defines
Thread-Index: AQHVtMrWJ7us2o+YJk2iXo/iLbWLKae+MQcA
Date:   Tue, 17 Dec 2019 11:29:57 +0000
Message-ID: <ce7183bb25c987687a130cb7541a2552cebbf213.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
         <20191217111158.30888-2-djunho@gmail.com>
In-Reply-To: <20191217111158.30888-2-djunho@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e051955d-bbda-42f5-650e-08d782e4726a
x-ms-traffictypediagnostic: CH2PR03MB5318:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB53180F81DFC17EE0E3312119F9500@CH2PR03MB5318.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(71200400001)(2906002)(6512007)(66556008)(4744005)(66476007)(5660300002)(86362001)(64756008)(2616005)(478600001)(110136005)(26005)(186003)(8676002)(81166006)(8936002)(4001150100001)(6486002)(76116006)(6506007)(36756003)(316002)(66946007)(66446008)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5318;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJDv7YD1icbPat5lz/bQG2D9Bm/9AM2/n6fBIzUVD6ZlGtk04KRLW0LtpC0UEmJ3moeKGG+GoBR110tbYxdd7JNFYEpFdPMEmxMBDdvisNuPMHgkkT1RhArMpsFc8vw9fMOAzBozUKY+UwOeeERrQqGV84axbN00mgkUVWiOyg9yqcRbgxI70/rCVQdDaqW2SoJ0ywA27IhF7kD7YsIMrpy84AYP8hNhZvciujjq1C5ZlTfPLK93O630ZXwJc+Bg9DqPLhAhgb3aWEvAtdTjSq0sMHn0jvSYRVXa1AUm/X5CYJI5zosc+bsPDthpyEAzq76W9Kg4a26TEoDezj6jLK13jwVttDOS82SG8HxgTIpDziZSHHOT6WJozwx4O/4q20Vs5gKYhAKh7P0xReAJJgzgCu+hx5yPEcxZ84Oy+ptLoGo6hCuUtyWxIOqVyy/4WtPccZldNAdUnL5U1KeAtGhBenH7kBIS7tSBzBBLQdKWBADu5/4y7ORGk/qvPvtF
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBA74771AD108D4BB8944B592EB34F6E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e051955d-bbda-42f5-650e-08d782e4726a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 11:29:57.9197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwFaKYoMziFUqUndplLmB3EciLBr/xUnqbEE+JhHD7HwM3bNywOM8yAYkKPP28A7hZ3db4/Yp0Tb15ZcXhrp9Vil8sU9dpLRgi2dDIKGqJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5318
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-16,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=904
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912170098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDA4OjExIC0wMzAwLCBEYW5pZWwgSnVuaG8gd3JvdGU6DQo+
IFJlbW92ZXMgdGhlIHVudXNlZCBkZWZpbmUgQUQ3OTIzX0NIQU5ORUxfeCBmcm9tIHRoZSBjb2Rl
Lg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVs
ZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEp1bmhvIDxkanVuaG9A
Z21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9hZDc5MjMuYyB8IDQgLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vYWRjL2FkNzkyMy5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IGluZGV4
IDMyMTJlYjRjMGYyNS4uOTY5YzA2YjdkMmI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9h
ZGMvYWQ3OTIzLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzkyMy5jDQo+IEBAIC0yOSwx
MCArMjksNiBAQA0KPiAgI2RlZmluZSBBRDc5MjNfUE1fTU9ERV9BUwkoMSkJCS8qIGF1dG8gc2h1
dGRvd24gKi8NCj4gICNkZWZpbmUgQUQ3OTIzX1BNX01PREVfRlMJKDIpCQkvKiBmdWxsIHNodXRk
b3duICovDQo+ICAjZGVmaW5lIEFENzkyM19QTV9NT0RFX09QUwkoMykJCS8qIG5vcm1hbCBvcGVy
YXRpb24gKi8NCj4gLSNkZWZpbmUgQUQ3OTIzX0NIQU5ORUxfMAkoMCkJCS8qIGFuYWxvZyBpbnB1
dCAwICovDQo+IC0jZGVmaW5lIEFENzkyM19DSEFOTkVMXzEJKDEpCQkvKiBhbmFsb2cgaW5wdXQg
MSAqLw0KPiAtI2RlZmluZSBBRDc5MjNfQ0hBTk5FTF8yCSgyKQkJLyogYW5hbG9nIGlucHV0IDIg
Ki8NCj4gLSNkZWZpbmUgQUQ3OTIzX0NIQU5ORUxfMwkoMykJCS8qIGFuYWxvZyBpbnB1dCAzICov
DQo+ICAjZGVmaW5lIEFENzkyM19TRVFVRU5DRV9PRkYJKDApCQkvKiBubyBzZXF1ZW5jZSBmb25j
dGlvbg0KPiAqLw0KPiAgI2RlZmluZSBBRDc5MjNfU0VRVUVOQ0VfUFJPVEVDVAkoMikJCS8qIG5v
IGludGVycnVwdA0KPiB3cml0ZSBjeWNsZSAqLw0KPiAgI2RlZmluZSBBRDc5MjNfU0VRVUVOQ0Vf
T04JKDMpCQkvKiBjb250aW51b3VzIHNlcXVlbmNlICovDQo=
