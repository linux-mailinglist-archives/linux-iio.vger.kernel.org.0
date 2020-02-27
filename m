Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F417113B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 08:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgB0HGP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 02:06:15 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:34134 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726999AbgB0HGP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 02:06:15 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R76CFe027841;
        Thu, 27 Feb 2020 02:06:12 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ydtrv1yah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 02:06:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/J5u5ugNO6tvLjB6GXF2BB5Y6rCF0ZoO9yM9qJ1y3NSreqemvMzCDufg/Tq2CP/4xmq9raiPpMxaQJFqD7hpHMGODg5qz1XNumNOeAFqonJHweu5nqCL7UOL4KeiJ2GjMlsbJIugZfFh9OOfwrwlptAbd/hgkCKGV0egyw2LBIXg7UH6tSptWdlGeoa2l4qgSOyUhuK6cS76v3onL9btXc9sxXL6q6J/LQSBBoxSrL2I3QSHOALj9JXXz2nhf6LKYb4mSjfnQn11SHrbl5xyUT1qsyBZg1nNY0fA4E4Q/ZToCMqwIUY86zgkrSWu/pwmS/WW4HK2Qavuqd5sLXwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFKszjP5CXew27/I1fdJ1SLb28GJPfzsDPVz/mLDdY0=;
 b=RKpYCGbc8lOjlXe0RFVXoaaSSwiU/ENon0/k6puPNDmLXUWMh4rqGj8tTXAYrLpqvABVgLcxL2rU/8yW8tyJ5mWvRkhBjxz68VNDHwnTABTwPLpCNet6avapXpe2SFs+UGNEFNHBuQHNphiJWzlc77Zy8pcWdWzv/LR7tljHc5pzdEOXx8rx1xRt9CfArtWt+jCTnPuxCerP4r4rwuMq2wsqDvWKeCztcr4cUq0zI59VNP236ec37CCWiUO0YvAMWUFTzXuXAClgS7Oxggj/XZTnExsWVRc/qfIvITo1lvPRri8qka774oN94O0Lc4JScFmnVSzRuxn5mVtHTQvfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFKszjP5CXew27/I1fdJ1SLb28GJPfzsDPVz/mLDdY0=;
 b=lzB/eUIkA2SFudqA9Tg2f27F3ZuLFPcTh5n4D3m4gLGGUczmjXpGop+XVkwHc0aSByb9EG4ETvNphA284Jn+xVqHI8M3bs3gJkx91wHty8PwQ8pS321tSLrrzgqEDLR88SMRB5gAbvYUAF4209M3yGdJQ0pzIcL2wskRbSOBG0k=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5335.namprd03.prod.outlook.com (2603:10b6:610:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Thu, 27 Feb
 2020 07:06:10 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 07:06:10 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Thread-Topic: [PATCH v2 5/7] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Thread-Index: AQHV7LZAUHkfKh6E3E6cV1PG9gIjV6guoC4A
Date:   Thu, 27 Feb 2020 07:06:10 +0000
Message-ID: <bae96d470b4c1db7f1289866975913278e3b8ad1.camel@analog.com>
References: <20200226150835.19649-1-alexandru.ardelean@analog.com>
         <20200226150835.19649-6-alexandru.ardelean@analog.com>
In-Reply-To: <20200226150835.19649-6-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8fe9571-5ada-48b8-1759-08d7bb538674
x-ms-traffictypediagnostic: CH2PR03MB5335:
x-microsoft-antispam-prvs: <CH2PR03MB5335BBBBFDCB7A1195DDBF1FF9EB0@CH2PR03MB5335.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(136003)(396003)(366004)(346002)(199004)(189003)(54906003)(5660300002)(2616005)(86362001)(64756008)(66946007)(91956017)(66476007)(76116006)(66446008)(66556008)(2906002)(966005)(186003)(36756003)(316002)(6506007)(81156014)(81166006)(4326008)(110136005)(8676002)(6512007)(26005)(8936002)(6486002)(71200400001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5335;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqPulf6JXvqRXHRu1ChHeFkY2GIY4cR9SGLiZhZs8CBdOyY4vz24YFBt7VjvcVLJ8Pt77tUIBB+wPitRVkQosmvuZhDOytrhbaBMs2JhAxeioUYU0l4RlMAJVa+YarqHGdpSzVyPJhxsySm+/Gz/JtNuWEb30CFyvVYh7z1mzj9zhVqnHFkXxQOEZfTA2icsNiZpJ+W1VG0zH2wMewmF3t4dATy+bG+Mi9tc2ydjY9ezECbcUuKUkgDcDCL8BU7XM8U3pwUxUH6JsQ4c48ukthYP7vKjowfoNU8ct6cS8MNIeZVyCngfSV/zaKhrf0ZIOv0HkaqHwXed8McPvXOHxzD8dqVWAZEHkBmQKQC6fj3dU/Mc5PxITg3+N4y8lZlGQX1L6eXargN0SC9hFiOyXfVX9YjPrEOzbdMcbiaabajZHBCeVNrkY6AyEKsGq/xMSj2zCZ7M6ehR522ZmFMNWCBogpN9Z4N/8nr4aBj1VgKva1AcbthtPDLkukFCTmcH
x-ms-exchange-antispam-messagedata: uQVCmCxNICKYOUmxosSHEHNH81czDMyqE1D5BxrYhZS3QCt1j5Y+gzMcYEyPem5/JPeT5yq5gSh8S/GD8vAVfzHM4UM9bbC65igY4EpgoAMlLUbuCbg0fAFtxFROJDi7W8zJO7Z+O1DL9ht9pzDwZg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <38350A5FC3CA2C4ABE56D4EDD582D85C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fe9571-5ada-48b8-1759-08d7bb538674
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 07:06:10.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCvmX90aBtQktCUWAGPZlkpuJKsWjV+8GM/qrkWXYSYIhFEgkdMSda2Gxqg+GygkjzkhA4L9UWw3rusQKCuV86UkMcDBmxtLifIzXoXeJYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_01:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTI2IGF0IDE3OjA4ICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGJpbmRpbmdzIGRv
Y3VtZW50YXRpb24gZm9yIHRoZSBBWEkgQURDIGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IC0t
LQ0KPiAgLi4uL2JpbmRpbmdzL2lpby9hZGMvYWRpLGF4aS1hZGMueWFtbCAgICAgICAgIHwgNjkg
KysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aWlvL2FkYy9hZGksYXhpLWFkYy55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGF4aS1hZGMueWFtbA0KPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxheGktYWRjLnlhbWwNCg0K
SSBqdXN0IGhhZCBhIHRob3VnaHQuDQpTaW5jZSB0aGUgZHJpdmVyIG5hbWUgaXMgbm93IGNhbGxl
ZCBhZGktYXhpLWFkYy5jLCBtYXliZSBpdCdzIGEgZ29vZCBpZGVhIHRvDQphbHNvIGNoYW5nZSB0
aGlzIHRvIGFkaS1heGktYWRjLnlhbWwNCg0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjY1ZmZkMzM3Y2QyZg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxheGktYWRjLnlhbWwN
Cj4gQEAgLTAsMCArMSw2OSBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0y
LjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vYWRjL2FkaSxheGktYWRjLnlhbWwjDQo+
ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
Cj4gKw0KPiArdGl0bGU6IEFuYWxvZyBEZXZpY2VzIEFYSSBBREMgSVAgY29yZQ0KPiArDQo+ICtt
YWludGFpbmVyczoNCj4gKyAgLSBNaWNoYWVsIEhlbm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hA
YW5hbG9nLmNvbT4NCj4gKyAgLSBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVh
bkBhbmFsb2cuY29tPg0KPiArDQo+ICtkZXNjcmlwdGlvbjogfA0KPiArICBBbmFsb2cgRGV2aWNl
cyBHZW5lcmljIEFYSSBBREMgSVAgY29yZSBmb3IgaW50ZXJmYWNpbmcgYW4gQURDIGRldmljZQ0K
PiArICB3aXRoIGEgaGlnaCBzcGVlZCBzZXJpYWwgKEpFU0QyMDRCL0MpIG9yIHNvdXJjZSBzeW5j
aHJvbm91cyBwYXJhbGxlbA0KPiArICBpbnRlcmZhY2UgKExWRFMvQ01PUykuDQo+ICsgIFVzdWFs
bHksIHNvbWUgb3RoZXIgaW50ZXJmYWNlIHR5cGUgKGkuZSBTUEkpIGlzIHVzZWQgYXMgYSBjb250
cm9sDQo+ICsgIGludGVyZmFjZSBmb3IgdGhlIGFjdHVhbCBBREMsIHdoaWxlIHRoaXMgSVAgY29y
ZSB3aWxsIGludGVyZmFjZQ0KPiArICB0byB0aGUgZGF0YS1saW5lcyBvZiB0aGUgQURDIGFuZCBo
YW5kbGUgdGhlIHN0cmVhbWluZyBvZiBkYXRhIGludG8NCj4gKyAgbWVtb3J5IHZpYSBETUEuDQo+
ICsNCj4gKyAgaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL2ZwZ2EvZG9jcy9heGlf
YWRjX2lwDQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgZW51
bToNCj4gKyAgICAgIC0gYWRpLGF4aS1hZGMtMTAuMC5hDQo+ICsNCj4gKyAgcmVnOg0KPiArICAg
IG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgZG1hczoNCj4gKyAgICBtaW5JdGVtczogMQ0KPiArICAg
IG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgZG1hLW5hbWVzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+
ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiByeA0KPiArDQo+ICsgIGFkaS1heGktYWRj
LWNsaWVudDoNCg0KTWF5YmUgb25lIGZvciBSb2IgaGVyZS4NClsgSSBhbHNvIG5vdGljZWQgdGhh
dCBJIGZvcmdvdCB0byBhZGQgdGhlIERUIGxpc3Q7IHdpbGwgZG8gdGhhdCBvbiBWMyBdDQoNClRo
ZSByZWFzb24gSSBuYW1lZCB0aGlzIGZpZWxkICdhZGktYXhpLWFkYy1jbGllbnQnIGFuZCBub3Qg
J2FkaSxheGktYWRjLWNsaWVudCcNCmlzIGJlY2F1c2UgSSB3b3VsZCBnZXQ6DQoNCkRvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxheGktYWRjLnlhbWw6IHByb3Bl
cnRpZXM6YWRpLGF4aS0NCmFkYy1jbGllbnQ6IHsnZGVzY3JpcHRpb24nOiAnQSByZWZlcmVuY2Ug
dG8gYSB0aGUgYWN0dWFsIEFEQyB0byB3aGljaCB0aGlzIEZQR0ENCkFEQyBpbnRlcmZhY2VzIHRv
LicsICdtYXhJdGVtcyc6IDF9IGlzIG5vdCB2YWxpZCB1bmRlciBhbnkgb2YgdGhlIGdpdmVuIHNj
aGVtYXMNCihQb3NzaWJsZSBjYXVzZXMgb2YgdGhlIGZhaWx1cmUpOg0KCS9ob21lL3NhbmR1L3dv
cmsvbGludXgvdXBzdHJlYW0vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9h
ZA0KYy9hZGksYXhpLWFkYy55YW1sOiBwcm9wZXJ0aWVzOmFkaSxheGktYWRjLWNsaWVudDogJ25v
dCcgaXMgYSByZXF1aXJlZCBwcm9wZXJ0eQ0KDQptYWtlWzFdOiAqKiogW0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9NYWtlZmlsZToxMjoNCkRvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxheGktYWRjLmV4YW1wbGUuZHRzXSBFcnJvciAxDQoNCg0K
PiArICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgQSByZWZlcmVuY2UgdG8gYSB0aGUgYWN0dWFs
IEFEQyB0byB3aGljaCB0aGlzIEZQR0EgQURDIGludGVyZmFjZXMgdG8uDQo+ICsgICAgbWF4SXRl
bXM6IDENCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIGRtYXMN
Cj4gKyAgLSByZWcNCj4gKyAgLSBhZGktYXhpLWFkYy1jbGllbnQNCj4gKw0KPiArYWRkaXRpb25h
bFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICBm
cGdhX2F4aSB7DQo+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAj
c2l6ZS1jZWxscyA9IDwxPjsNCj4gKw0KPiArICAgICAgICBheGktYWRjQDQ0YTAwMDAwIHsNCj4g
KyAgICAgICAgICBjb21wYXRpYmxlID0gImFkaSxheGktYWRjLTEwLjAuYSI7DQo+ICsgICAgICAg
ICAgcmVnID0gPDB4NDRhMDAwMDAgMHgxMDAwMD47DQo+ICsgICAgICAgICAgZG1hcyA9IDwmcnhf
ZG1hIDA+Ow0KPiArICAgICAgICAgIGRtYS1uYW1lcyA9ICJyeCI7DQo+ICsNCj4gKyAgICAgICAg
ICBhZGktYXhpLWFkYy1jbGllbnQgPSA8JnNwaV9hZGM+Ow0KPiArICAgICAgICB9Ow0KPiArICAg
IH07DQo+ICsuLi4NCg==
