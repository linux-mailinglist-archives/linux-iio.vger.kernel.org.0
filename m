Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C35F893C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 07:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLG6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 01:58:23 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38194 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbfKLG6W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 01:58:22 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAC6qWdp016956;
        Tue, 12 Nov 2019 01:57:52 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2051.outbound.protection.outlook.com [104.47.49.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prk83fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 01:57:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjMCSAdWaA0l8MGDlcW3nWP3Y2LwHgzKoOJkANM8gMfcvEOhK/Ew2RahrrPlwqUPs6GGCBOqweDaniPubzpnTO4J2EKPrlq64OpPUnTRlGCgQQDtDgVEfQl80+EVQWBWyT25h6cn4oQzoEvBzyZVRtf9oCG5GIBv5hBqEpvCSmgZzHJjeup81CjLC4NIn4lknF68GEMIHkTkPdknrFZ9ABW32ZrtgvL/1MEAOVEjuMabhiaD/Xl/PxGKa+lY/ce2RGrtHbz9iyoLHJtvywzEhKcftAszTAYeZOqGYqDXSMTRXvqKntcinkN5uPIKsBRDiwJbXC9MF5habeIYVzU8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rivbxBiTHO92jdkgc13+PJeFCWugRKrL1/0vyAuq0Xk=;
 b=NKbvXkg9CKb+zdtDFmt/TYj5D0g/XDqiTgmCmmu3yNuoYvAK21D6mjn+V/KuwDSBjK1lmvZ+Lp6jO0PERKPjSLD9Hun0A/HQzvl8vHrgRk0Gj7ByKTpekLFsCSNVbtmu6rgHhR6TvCjmveCbjhTFsXx9AxufOvGzV9uGdbciptowNz3b7KXDb4U0uKAMXDVBPjbjqjwO5wnnSX35ecZniflCVzjFhKXmnptMSUMjHbx0aDqUQgYifbNf/dof/cwwrDeY3svFEkaN7kXmlERJzHykbg2JZAiZePcH4vlRQuV4oTwFB1Q6V7feNzYV02+OF1ZU6okS0pxLuNP/4u7N+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rivbxBiTHO92jdkgc13+PJeFCWugRKrL1/0vyAuq0Xk=;
 b=BR+rEpykWzPOi6AIFxMAKHpYzUDd1JU9kX26JDya5EYRe6tMm+UDvFQVGtB4XLirCG+jl2TytxUCEwR5k9XECosuPS250j5QhLAF+Q7Xje33qbw7ZV+Tzl6G/kxASPCIbaCSLg96+hGgPfza4btYpPlgqyW+NscFPu7Tw/MKTac=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5301.namprd03.prod.outlook.com (20.180.15.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 06:57:49 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 06:57:49 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ltc2496: provide device tree binding
 document
Thread-Topic: [PATCH 1/3] iio: adc: ltc2496: provide device tree binding
 document
Thread-Index: AQHVmNs1F8/40KLd8kC0t9/fsa+nz6eHG4MA
Date:   Tue, 12 Nov 2019 06:57:49 +0000
Message-ID: <b6ed43afbfb0128301f11198eb83a8f72b7661e9.camel@analog.com>
References: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93f3aaf9-a17b-4d37-27b7-08d7673da199
x-ms-traffictypediagnostic: CH2PR03MB5301:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5301B9BEFC8F6B8D3EDD2F58F9770@CH2PR03MB5301.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(51914003)(199004)(189003)(6116002)(5660300002)(4001150100001)(256004)(76116006)(8936002)(2906002)(66476007)(66446008)(8676002)(81156014)(64756008)(66946007)(66556008)(3846002)(81166006)(2501003)(66066001)(71200400001)(71190400001)(4326008)(6506007)(6246003)(6436002)(99286004)(478600001)(36756003)(2201001)(118296001)(102836004)(6512007)(54906003)(6486002)(186003)(86362001)(7416002)(316002)(76176011)(25786009)(110136005)(14454004)(2616005)(26005)(229853002)(476003)(11346002)(7736002)(446003)(305945005)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5301;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9cA4K/Nu+SquSgBjo5N69xp/T+gmsvHO1SHstg8q8CjammRDIyQyraSXnGrkTdJS0tpGdKwkbvcbnYDk8beN8/jy7pz832n3q5bLgOVeI+T8999Opcb6f8r7cBYtzBuseoCmuhMl5B1zxzuAlwz9dywkd8mQGAw+1dKb62QCGJieAxTv4+oOiDnN8O8SVyOCYPcvp+UFIwxsAigpXChOo35y59sylXLPBSwtwY+y5VSla0I7C8DTzjH1XENIjE+RM14jZUl942GMh3UABYJFLrt/hC4OttJQjpRbyMKe9QsjbzeiI3nMtq1Xl5NPDUNhRrNxQeiutdTHMfYNeyPhOnYPyoJtfHlYbkah+umOkC2sWFK3cDaTr2ezkGKieZT1+J3IpNddLprqCdMMnde2+IwHwUjUVCQd2iH3zBN2brF1zNG1gIdGcP1ewMSvtyid
Content-Type: text/plain; charset="utf-8"
Content-ID: <20797E2DEAE25646823F8806BD28A8EC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f3aaf9-a17b-4d37-27b7-08d7673da199
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 06:57:49.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zs0Cr81iOTfsLB/c1Rd366Qoc5sv1VOX3NW06Hm2+xzpPzGoobw7f077h8dC0wI+GSbGjaaSWI8zJ29Pa1BzDYDUQEfJ/BECVPVhQKSqIAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_01:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120062
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTExIGF0IDIyOjQwICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gVGhlIEFEQyBvbmx5IHJlcXVpcmVzIHRoZSBzdGFuZGFyZCBzdHVmZiBmb3Igc3BpIGRl
dmljZXMgYW5kIGEgcmVmZXJlbmNlDQo+IHZvbHRhZ2UuDQo+IA0KDQpIZXksDQoNClRoYW5rcyBm
b3IgdGhlIHBhdGNoLg0KDQpEVCBiaW5kaW5ncyBtdXN0IGJlIGluIFlBTUwgZm9ybWF0Lg0KQnV0
IGluIHRoaXMgY2FzZSwgeW91IGNhbiBwcm9iYWJseSBleHRlbmQgdGhlIGV4aXN0aW5nDQoiRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbHRjMjQ5Ny50eHQiLg0KDQpZ
b3UgZG9uJ3QgbmVlZCB0byBjcmVhdGUgbmV3IGZpbGUgYWx0b2dldGhlci4NCg0KPiBTaWduZWQt
b2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRl
Pg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbHRjMjQ5Ni50eHQg
ICAgICAgfCAxNSArKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hZGMvbHRjMjQ5Ni50eHQNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9sdGMyNDk2LnR4dA0KPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2x0YzI0OTYudHh0DQo+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDQ0YWI0NWIyNmVhDQo+IC0tLSAv
ZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9h
ZGMvbHRjMjQ5Ni50eHQNCj4gQEAgLTAsMCArMSwxNSBAQA0KPiArKiBMaW5lYXIgVGVjaG5vbG9n
eSAvIEFuYWxvZyBEZXZpY2VzIExUQzI0OTYgQURDDQo+ICsNCj4gK1JlcXVpcmVkIHByb3BlcnRp
ZXM6DQo+ICsgLSBjb21wYXRpYmxlOiBNdXN0IGJlICJsbHRjLGx0YzI0OTYiDQo+ICsgLSB2cmVm
LXN1cHBseTogVGhlIHJlZ3VsYXRvciBzdXBwbHkgZm9yIEFEQyByZWZlcmVuY2Ugdm9sdGFnZQ0K
PiArIC0gZnVydGhlciBwcm9wZXJ0aWVzIHJlcXVpcmVkIGZvciBzcGkgZGV2aWNlIG5vZGVzIGFj
Y29yZGluZyB0bw0KPiArICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9z
cGktY29udHJvbGxlci55YW1sDQo+ICsNCj4gK0V4YW1wbGU6DQo+ICsJbHRjMjQ5NzogYWRjQDc2
IHsNCj4gKwkJY29tcGF0aWJsZSA9ICJsbHRjLGx0YzI0OTYiOw0KPiArCQlyZWcgPSA8MD47DQo+
ICsJCXZyZWYtc3VwcGx5ID0gPCZsdGMyNDl4X3JlZz47DQo+ICsJCXNwaS1tYXgtZnJlcXVlbmN5
ID0gPDIwMDAwMDA+Ow0KPiArCX07DQo=
