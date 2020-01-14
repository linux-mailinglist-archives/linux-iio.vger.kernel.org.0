Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC213A21A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 08:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgANH1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 02:27:32 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:2584 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbgANH1b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 02:27:31 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00E7QLjw029195;
        Tue, 14 Jan 2020 02:27:09 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb6xqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 02:27:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoFPOxgjyjkX+VQruGxb4nnBt9wpqkgRFLDCZ73uwvYc6I0NKrsxUJFgx9ewVYxrLpoxT+5M0rTMx3wERhhomk1ExJ9jgCBWL/F00dpGEha2AGREVKtopD1MBlHbbEdQNtHmPUdMZsPsMBuyxTtkiFHpGF4JS4nV4iGvsKgDjGSHHTSACrwV7/QKJL0P7qne5OT0ATgGKeQzMJ2PxyU5+vzTVtjbCZc/WvtwRShwP0BJ7A820xHr+HvtGlTK9h4csx/zB35pkqxbtwRKoNggs0L1YB/ImSxOFKuw994r9I6X/cDmMIC3yOkIeMT1GYe0Flig4DRaqVT17REDmOtCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXv3V7i8gxyrH/8nZ7nvF+9GgDcdQ6ODxN+ENSOO6F4=;
 b=bi/b83c7v4v0wB092i9XdLCXZgCVM5srxWTGvDW/5FEAd96weEmuD4M/mD127xOFuq4pBGi4CYO4qbHt9d+/fSSLmEnKEKOXDkEZ6Gsr3U06uvRq6RbJQhV83uwR+B6JM+iYRMR42Irw2YsLKDp+yXB/GWJQiiSxU9RWaENNvz2hbiokqSImcuI29pPr8jiqk87GLdOTQ0OFvcFKBFjEWxJ1zYIBl8WbZW3A8aHJVkL5E0Z/s+Xjy83cxEXl8rdA7XMM5fITFYknnScAwttPrcSzcgf+2V0KIaghdaS49m1DoNjJz+O45/g7itRPRCgoVLfrJrUtcvRQkuURgsH5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXv3V7i8gxyrH/8nZ7nvF+9GgDcdQ6ODxN+ENSOO6F4=;
 b=WzQ93q0E8mOdXRN5OjBpp+8h2FcefEd+sVZ95y58iS+X8SCQK9pAUntoY3L+OEBG+PggiMStqYXfD2iveXB0TT9GFFyoMeG6s55N+Cj9OhQEAoPEUnCH/wEIAG6K9wMiOk865QT1tpJdWo+WsAf6e19m9qPSmm0QKXZQ5oEgwZ8=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5272.namprd03.prod.outlook.com (20.180.4.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 07:27:08 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 07:27:08 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Bia, Beniamin" <Beniamin.Bia@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>
Subject: Re: [PATCH 1/3] iio: amplifiers: hmc425a: Add support for HMC425A
 step attenuator with gpio interface
Thread-Topic: [PATCH 1/3] iio: amplifiers: hmc425a: Add support for HMC425A
 step attenuator with gpio interface
Thread-Index: AQHVyhvEEIAnedXVb0WyMiMRJByquKfpE+4AgACwfgA=
Date:   Tue, 14 Jan 2020 07:27:08 +0000
Message-ID: <5925b4f1d47306ec4376a296a1146ff024239044.camel@analog.com>
References: <20200113141555.16117-1-beniamin.bia@analog.com>
         <5ae63616-5749-da51-b0b2-85cdcaa948f3@metafoo.de>
In-Reply-To: <5ae63616-5749-da51-b0b2-85cdcaa948f3@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93d07e32-63a5-4af4-a2ef-08d798c329b1
x-ms-traffictypediagnostic: CH2PR03MB5272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB52722574CA650F723DC022CDF9340@CH2PR03MB5272.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(64756008)(6506007)(478600001)(5660300002)(66476007)(966005)(2906002)(6486002)(66556008)(8676002)(81156014)(66446008)(81166006)(53546011)(76116006)(4326008)(86362001)(66946007)(7416002)(110136005)(54906003)(2616005)(36756003)(71200400001)(6512007)(26005)(316002)(186003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5272;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pT2dyXY/vUtuRvloq0waWIeBA2j6OpgloVC2CunuEZs2En0udlQYg9Pig+HgwanB22JajQQQ0cmWa4HNFubz0W6mZhY337+b/b4D6tR2sThkIfrWGfEQTZydMKWwdU+q/upioRQ5HEGGp4UDFvJ3LfG512sg6PVk1zcJXubTSxk+41PQY827uxeCXtF07COGFV8VO6YKK5bknsVqN43H0VqBfizXfH/gD6DPN4Z0paihbkEIRjUEP8XXept7Lb4yp9voQVO+uiISjfX4e7XGSBotmIanWPJnMxjeuOwHcqc87YO3dUQolKF97TBT2946j4yuMebhzCvYdSXXxW58xMJVdXtVhuT5k/nSGM9We3scp2Kw2P6ip93Oc26vycvF4PQj6hQ6e12tKNgpz2bTugu+SQRMkxI0kpMkEODRJ1PDm9Y9LscW57L/LxAGSTJqbObTrX2pl/+wnN7pXMEp0K6GibKn5f/ljyvx4/+4myo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <492776969DF61D4EB8807DF9477039AB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d07e32-63a5-4af4-a2ef-08d798c329b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 07:27:08.0203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oP3fg7wqqj1FOZHlSkmfscv3DTg3OJQjhQxrfRykfyYVMOaDydgXo3PLB4ArP8KiVLODnk2lTLffg40kiAKlRCVTaXasoynqgSfa1py2PyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_01:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTEzIGF0IDIxOjU3ICswMTAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDEvMTMvMjAgMzoxNSBQTSwgQmVuaWFtaW4gQmlh
IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ICtzdGF0aWMgaW50IGhtYzQyNWFfd3JpdGUoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldiwgdTMyIHZhbHVlKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaG1jNDI1
YV9zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICsJaW50IGksICp2YWx1ZXM7
DQo+ID4gKw0KPiA+ICsJdmFsdWVzID0ga21hbGxvY19hcnJheShzdC0+Y2hpcF9pbmZvLT5udW1f
Z3Bpb3MsIHNpemVvZihpbnQpLA0KPiA+ICsJCQkgICAgICAgR0ZQX0tFUk5FTCk7DQo+ID4gKwlp
ZiAoIXZhbHVlcykNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlmb3IgKGkg
PSAwOyBpIDwgc3QtPmNoaXBfaW5mby0+bnVtX2dwaW9zOyBpKyspDQo+ID4gKwkJdmFsdWVzW2ld
ID0gKHZhbHVlID4+IGkpICYgMTsNCj4gPiArDQo+ID4gKwlncGlvZF9zZXRfYXJyYXlfdmFsdWVf
Y2Fuc2xlZXAoc3QtPmdwaW9zLT5uZGVzY3MsIHN0LT5ncGlvcy0+ZGVzYywNCj4gPiArCQkJCSAg
ICAgICB2YWx1ZXMpOw0KPiANCj4gVGhpcyBBUEkgZ290IGNoYW5nZWQgYSB3aGlsZSBhZ28gaW4g
dXBzdHJlYW0sIHNlZQ0KPiBodHRwczovL2dpdGh1Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9saW51
eC9jb21taXQvYjk3NjJiZWJjNjMzMmI0MGMzM2UwM2RlYTAzZTMwZmExMmQ5ZTNlZA0KPiANCj4g
PiArCWtmcmVlKHZhbHVlcyk7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiBbLi4uXQ0KPiA+
ICtzdGF0aWMgaW50IGhtYzQyNWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPiArew0KPiBbLi4uXQ0KPiA+ICsNCj4gPiArCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IGluZGlvX2Rldik7DQo+IA0KPiBkcnZkYXRhIGlzIG5ldmVyIGFjY2Vzc2VkLCBubyBuZWVkIHRv
IHNldCBpdC4NCj4gDQo+ID4gKwltdXRleF9pbml0KCZzdC0+bG9jayk7DQo+ID4gKw0KPiA+ICsJ
aW5kaW9fZGV2LT5kZXYucGFyZW50ID0gJnBkZXYtPmRldjsNCj4gPiArCWluZGlvX2Rldi0+bmFt
ZSA9IG5wLT5uYW1lOw0KPiANCj4gSSBrbm93IEFESSBsaWtlcyB0byBkbyB0aGlzIGluIGl0cyBu
b24gdXBzdHJlYW0gZHJpdmVycywgYnV0IHRoZSBhYm92ZQ0KPiBpcyBub3QgSUlPIEFCSSBjb21w
bGlhbnQuIFRoZSBuYW1lIGlzIHN1cHBvc2VkIHRvIGlkZW50aWZ5IHRoZSB0eXBlIG9mDQo+IHRo
ZSBkZXZpY2UsIHdoaWNoIG1lYW5zIGZvciB0aGlzIGRyaXZlciBzaG91bGQgYmUgc3RhdGljICJo
bWM0MjVhIi4NCj4gTWF5YmUgY29uc2lkZXIgYWRkaW5nIGEgZmllbGQgdG8gdGhlIGhtYzQyNWFf
Y2hpcF9pbmZvIGZvciB0aGlzLg0KDQpXZSd2ZSBhY3R1YWxseSBbcmVjZW50bHldIGhhZCBhIGRp
c2N1c3Npb24gYWJvdXQgdGhpcyBpbnRlcm5hbGx5IHJlZ2FyZGluZw0KdGhlICdpbmRpb19kZXYt
Pm5hbWUnLg0KDQpNYXliZSBpdCdzIGEgZ29vZCB0aW1lIHRvIGFzayBoZXJlIChub3cpLg0KQSBs
b3Qgb2Ygb3VyIHVzZXJzcGFjZSBzdHVmZiBoYXZlIGJlZW4gc2VhcmNoaW5nIElJTyBkZXZpY2Vz
IHZpYSB0aGUgJ25hbWUnDQpmaWVsZCBpbiBzeXNmcywgd2hpY2ggaXMgdGhlIG5hbWUgYXNzaWdu
ZWQgaGVyZS4NClRoYXQgY3JlYXRlcyBhIHByb2JsZW0gd2hlbiB5b3UgaGF2ZSBtdWx0aXBsZSBk
ZXZpY2VzIHdpdGggdGhlIHNhbWUgZHJpdmVyLg0KV2hpY2ggaXMgd2h5LCBvbmUgDQoNClNvLCB0
aGVuIHNvbWUgcXVlc3Rpb25zIHdvdWxkIGJlOg0KSXMgYSBzZWFyY2hpbmcgZm9yIElJTyBkZXZp
Y2VzIFtpbiB1c2Vyc3BhY2VdIGJhc2VkIG9uIElJTyBkZXZpY2UtbmFtZSBub3QNCnJlY29tbWVu
ZGVkPyBJZiBub3QsIHdoYXQgd291bGQgYmU/IE9yIHdoYXQgd291bGQgYmUgYSBiZXR0ZXIgaWRl
YT8NCg0KVGhlIEFCSSByZWFkcyBbaG9wZWZ1bGx5IEkgcHVsbGVkIHVwIHRoZSByaWdodCBmaWVs
ZF06DQpXaGF0OiAgICAgICAgICAgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZVgvbmFt
ZQ0KS2VybmVsVmVyc2lvbjogIDIuNi4zNQ0KQ29udGFjdDogICAgICAgIGxpbnV4LWlpb0B2Z2Vy
Lmtlcm5lbC5vcmcNCkRlc2NyaXB0aW9uOg0KICAgICAgICAgICAgICAgIERlc2NyaXB0aW9uIG9m
IHRoZSBwaHlzaWNhbCBjaGlwIC8gZGV2aWNlIGZvciBkZXZpY2UgWC4NCiAgICAgICAgICAgICAg
ICBUeXBpY2FsbHkgYSBwYXJ0IG51bWJlci4NCg0KVGhlIHRleHQgaW4gZGVzY3JpcHRpb24gaXMg
YSBiaXQgb3BlbiB0byBpbnRlcnByZXRhdGlvbiwgc28gSSBjYW4ndCBtYWtlIGFuDQphc3Nlc3Nt
ZW50IG9mIHdoYXQgaXMgY29ycmVjdC4NCkluIGNhc2UgdGhlcmUgd2FzIGEgZGlzY3Vzc2lvbiBh
Ym91dCB0aGlzLCBzb3JyeSBmb3IgcmVwZWF0aW5nIHNvbWUgdGhpbmdzDQpub3cuDQoNCg0KPiAN
Cj4gPiArCWluZGlvX2Rldi0+aW5mbyA9ICZobWM0MjVhX2luZm87DQo+ID4gKwlpbmRpb19kZXYt
Pm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGRldm1faWlv
X2RldmljZV9yZWdpc3RlcigmcGRldi0+ZGV2LCBpbmRpb19kZXYpOw0KPiA+ICt9DQo=
