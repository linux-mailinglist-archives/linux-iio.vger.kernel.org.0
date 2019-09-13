Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5BB18EC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 09:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfIMH3f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 03:29:35 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:31396 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbfIMH3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 03:29:35 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D7SFcM001689;
        Fri, 13 Sep 2019 03:29:03 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h5xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 03:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax7d2zf3S3h+d3MTcu3emP+SR8yV7uovvYBMCxcqsXPfw6J4ddsQId68GneSAHVStwHGbEJxp7XDEZ4ho9uXlihNrszDxvv4A70psN86QRSQEr590sHkA87lG15U8gTPvWnZv5Ok9KD0wEu/ROKn51YFLkFliT6M3eEaT7W7G9DGQFlA2EqyV6qTY0lONgw/3GMceViyxrYtyhtU0szi8LGbrOVyUJJ6fV7vKEQ2tYemaWaChpfa6yz0xuqzIZwCxNYbsUFAQIoBNpsR1xq/u1PO+KlxYjcFO+9QP7reKXbbDI+84YVQctOWpOYokNB/9+Unsgq6AurhpRjQrEYDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL7NPljmm8DcRfa+AuskgAwthfkNob/Gb3CLWGGC57k=;
 b=gc614ENRUYLWK3tuk15FA9xFr2TOvhdUzVlz4ck8FkYzjrjtIigO0TrLdijWe2ujBNbNNUPaj9Pd6FBJVbrXuaFq0syRj4gS9xn36qrGovAwiDbmqYswd6WofbeQBgzMyV8rlt3A8kYDJ3zYB12f4mL+lj0HYto8zhBtJ5/GWgLAL+lt6XtlZK0CUgQfPzkHN6CxZGj9TDQtPEuTHS3RG7V9o1VAKFhyv6u0LXNY831FNB5+TeZipV2CFDLKQxTLXTBRqj2n3qPE6qAFppARM74wGcsLrWPYsm7uc2BEk5zDjZHG2a9rwcOE0+fYxtT9bbEGKbU7/TBVic992YWlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL7NPljmm8DcRfa+AuskgAwthfkNob/Gb3CLWGGC57k=;
 b=ZfiNFf4rJYK9BxiUiWmCrp9kcYxMNLokoB1+8mQx50K94cBRofzr4A4doR3ZwLEqLkwg7GSEu9c9FvK6E5NZe+1hPAoUKsvs/Uyof8ci0hXBo60ohIRvYHrz9TU5dBQyT+U/jbnePeFcX10fkXe95GEvAfTLNWq1fpNnrjmEsGY=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5302.namprd03.prod.outlook.com (20.180.4.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 13 Sep 2019 07:28:59 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.021; Fri, 13 Sep 2019
 07:28:59 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: accel: add binding documentation for
 ADIS16240
Thread-Topic: [PATCH v2] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Thread-Index: AQHVacOcZ+EBrVimJUWZCKviGbZRIKcpaJGA
Date:   Fri, 13 Sep 2019 07:28:59 +0000
Message-ID: <448e180cc41bfc748d729f3269376b14ba6d3ac9.camel@analog.com>
References: <20190912213929.3664-1-rodrigorsdc@gmail.com>
In-Reply-To: <20190912213929.3664-1-rodrigorsdc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4a4e44a-f464-44af-d8c3-08d7381c0b44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5302;
x-ms-traffictypediagnostic: CH2PR03MB5302:
x-ms-exchange-purlcount: 3
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5302A291ADB0BCBEFF2BCC7CF9B30@CH2PR03MB5302.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(4326008)(53376002)(81156014)(476003)(66476007)(6246003)(76116006)(7736002)(64756008)(66556008)(2616005)(66446008)(6116002)(6306002)(256004)(229853002)(102836004)(54906003)(25786009)(66946007)(6486002)(53936002)(14454004)(81166006)(118296001)(3846002)(186003)(6512007)(478600001)(305945005)(6436002)(316002)(2906002)(36756003)(2501003)(6506007)(71200400001)(446003)(11346002)(8936002)(2201001)(66066001)(99286004)(5660300002)(76176011)(86362001)(71190400001)(110136005)(966005)(486006)(26005)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5302;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kotw3p9SuCkSImXeC0CNGej466iZRkc4fTXXwxc1d3Tz+o5tE9aV9PMCuU+4IZHDr8tUVn7iqKwAiENA5jnjdNbayYiqThAQZ58fxdQscbcUh/Uz7mn8igVbTqMcWe+zZnxxtEXIrpd/vm4wn1y3PWX7fsni8hobHXuFoyrqL6XeSK350wrX++zHnopxMUbWrz8K4hPyYtjDl/F+0Q1H1hp884svRmMC6XQeaGpR9Er6in2Ee1Zt9oFphbAWBNUsiqTVlg2RtruRe7LMB5m/txzOku9T1LqEhMIcOUsAYwNOSo2FqWkUV4Sp4UCznvCVusHsUbkE9uoaZ2ivmpRe3Ghc+SCdG6CKv/1E7Fg3RWf9iyYcO+Th6YjJkQ9huDVANCStZUCWlpS2odqkWI/J+oLySNqlnoxt8/VGUtY9sJ8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <769044C9B6C1114E9BCBB0B9DF4CBEE7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a4e44a-f464-44af-d8c3-08d7381c0b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 07:28:59.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjWNTCRbB1zGEE5JNFrhv8GMHVPsJVrLwuMHS/OHFUbt8d1Jh0K+pEYRTVh5ujM/zIYxAKDCz2P4k0CQu7gNnirdttnVjNymwl2tUDJjdqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5302
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_04:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130070
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDE4OjM5IC0wMzAwLCBSb2RyaWdvIENhcnZhbGhvIHdyb3Rl
Og0KPiBUaGlzIHBhdGNoIGFkZCBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9y
IEFESVMxNjI0MC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvZHJpZ28gUmliZWlybyBDYXJ2YWxo
byA8cm9kcmlnb3JzZGNAZ21haWwuY29tPg0KPiAtLS0NCj4gVjI6DQo+ICAgLSBSZW1vdmUgdHJ1
ZSBjb25zdGFudCBmb3Igc3BpLWNwaGEgYW5kIHNwaS1jcG9sDQo+ICAgLSBBZGQgZGVzY3JpcHRp
b24gZmllbGQgZm9yIHNwaS1jcGhhIGFuZCBzcGktY3BvbA0KPiAgIC0gQWRkIG1heEl0ZW1zIGZp
ZWxkIGZvciBzcGktY3BoYSBhbmQgc3BpLWNwb2wNCj4gDQo+ICAuLi4vYmluZGluZ3MvaWlvL2Fj
Y2VsL2FkaSxhZGlzMTYyNDAueWFtbCAgICAgfCA2MSArKysrKysrKysrKysrKysrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwvYWRpLGFkaXMxNjI0MC55
YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9hY2NlbC9hZGksYWRpczE2MjQwLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaWlvL2FjY2VsL2FkaSxhZGlzMTYyNDAueWFtbA0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjRiMWJkMjQxOTYwNA0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWNjZWwv
YWRpLGFkaXMxNjI0MC55YW1sDQo+IEBAIC0wLDAgKzEsNjEgQEANCj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9hY2NlbC9hZGksYWRpczE2MjQwLnlhbWwjDQo+
ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
Cj4gKw0KPiArdGl0bGU6IEFESVMxNjI0MCBQcm9ncmFtbWFibGUgSW1wYWN0IFNlbnNvciBhbmQg
UmVjb3JkZXIgZHJpdmVyDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIEFsZXhhbmRydSBB
cmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0
aW9uOiB8DQo+ICsgIEFESVMxNjI0MCBQcm9ncmFtbWFibGUgSW1wYWN0IFNlbnNvciBhbmQgUmVj
b3JkZXIgZHJpdmVyIHRoYXQgc3VwcG9ydHMNCj4gKyAgU1BJIGludGVyZmFjZS4NCj4gKyAgICBo
dHRwczovL3d3dy5hbmFsb2cuY29tL2VuL3Byb2R1Y3RzL2FkaXMxNjI0MC5odG1sDQo+ICsNCj4g
K3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgZW51bToNCj4gKyAgICAgIC0g
YWRpLGFkaXMxNjI0MA0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+
ICsgIHNwaS1jcGhhOg0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBTZWUgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY29udHJvbGxlci55YW1sDQo+ICsg
ICAgbWF4SXRlbXM6IDENCg0KRGVzY3JpcHRpb24gZm9yIHN0YW5kYXJkIHByb3BlcnRpZXMgaXMg
bm90IHJlcXVpcmVkLg0KDQpGb3Igc3BpLWNwaGEvY3BvbCBqdXN0ICJ0cnVlIiBzZWVtcyBzdWZm
aWNpZW50Lg0KDQpTbw0KDQogICAgIHNwaS1jcGhhOiB0cnVlDQoNCiAgICAgc3BpLWNwb2w6IHRy
dWUNCg0KPiArDQo+ICsgIHNwaS1jcG9sOiB8DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAg
ICAgIFNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jb250cm9s
bGVyLnlhbWwNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsg
ICAgbWF4SXRlbXM6IDENCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiAr
ICAtIHJlZw0KPiArICAtIGludGVycnVwdHMNCj4gKw0KDQpJZiBzcGktY3BoYSAmIHNwaS1jcG9s
IGFyZSB0cnVlLCB0aGV5IHNob3VsZCB0eXBpY2FsbHkgYmUgYWxzbyByZXF1aXJlZC4NClRob3Vn
aCwgSSB0aGluayBSb2Igd291bGQgYW5zd2VyIHRoaW5ncyBiZXR0ZXIgaGVyZS4NCg0KPiArZXhh
bXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8u
aD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJx
Lmg+DQo+ICsgICAgc3BpMCB7DQo+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAr
ICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKw0KPiArICAgICAgICAvKiBFeGFtcGxlIGZv
ciBhIFNQSSBkZXZpY2Ugbm9kZSAqLw0KPiArICAgICAgICBhY2NlbGVyb21ldGVyQDAgew0KPiAr
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWRpczE2MjQwIjsNCj4gKyAgICAgICAgICAg
IHJlZyA9IDwwPjsNCj4gKyAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDI1MDAwMDA+
Ow0KPiArICAgICAgICAgICAgc3BpLWNwb2w7DQo+ICsgICAgICAgICAgICBzcGktY3BoYTsNCj4g
KyAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8wPjsNCj4gKyAgICAgICAgICAg
IGludGVycnVwdHMgPSA8MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKyAgICAgICAgfTsNCj4g
KyAgICB9Ow0K
