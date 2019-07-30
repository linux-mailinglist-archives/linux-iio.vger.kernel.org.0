Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA83C7AD44
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfG3QIb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 12:08:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39978 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727698AbfG3QIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 12:08:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UG8HTn019173;
        Tue, 30 Jul 2019 18:08:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=202e2ADEbGgErr7GUznVXs+SjgZJ5xjYoKP3c3o5usM=;
 b=eBD75mvkSo6aIMmgFoFKXwgxPlsr1DpzTcO21IYpryZzCxbVMZHa+f4st8dECaJ6rusQ
 KKNaAgO0glCyDiEkc1aBSQgO29Iy5q3oNDpDPIIF+YVNh69uZ/7NSPoAguFBac9x4OWQ
 4nr8z1RQRHebNHaQjsD/ipr1bOIU76XWW6+cbHQJ0RVjkXraSyW8+mOanE/1Vtg7s7Py
 whEd5eNgrnYb2pSjXhi4uCyyAXELl8rF+NdfZmVMMURXLe9LfTVhxZ3XL/etUoSHt7FW
 ppI6lvfMjAZ8dExNQoGx3lR5u9DFoN+JZ2rUdHZWDd2lsRlCCEDDakDuPX5CvGvtauKn ng== 
Received: from eur02-he1-obe.outbound.protection.outlook.com (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56])
        by mx08-00178001.pphosted.com with ESMTP id 2u2jp4a4cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 18:08:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF4l+VjLOHrmkgr8Z5JdRvau9gIDGUD8lBbEP0JWqLsnK/ALBay+/8MPa1UplHn87CbhsGA6XHODV2maEWegOEtEI2hCSBlzY8H4xHuQtZspTkDdwih7lGLVqFnu7eRvv806WgSFMWIDK1Ud8thT6P3PhxSJwFtxdL+Y6tXb1cRKIFkJfs9SBh++yCG5g6i9y98OsEIf1321IC5YX8GLpjn5JtyuQhTDEXLyLpRn1M5ga7XuMYgV7lj1elZkfbvXB03rzwdMJlRLInBWc1+o1p7z//31Ij/BljR+JbNKy5nKBAl+p7+OWyvEHakd8vvx0tTR7AMu2XHzWdQiNbOR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=202e2ADEbGgErr7GUznVXs+SjgZJ5xjYoKP3c3o5usM=;
 b=WiXWfhy4TpR6VoBc/RQ9zRKZgjL6XPbCJBlXUd/fkf8csu+eTRCrNN1zvWGOjRrE0MZcppEutg4w+itEj+uW0i9pKm7qxPOnVXnHHVUiya9tZ4ZPznQcKOnVHiRhUiBiUYUtAvMuMYHXC1FO5dKBVvliC9R/C4OaY35EJh7sUbbrjl16Ohu8lGxBPgpCKY9DXpwszQ+cSwktq3Dj/V+9kj/beX2jGFadsCmy2Dve2/0K75kmrEb/8d2Nhp5UEZuyoH1HqKT3pCb8/pQCrvf/p3nSJLXpCsE9SFKzClVTZ8NMYwreN6/1j7On/WLG9KLe7bmxXwninmYuVkrdYwxJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=st.com;dmarc=pass action=none header.from=st.com;dkim=pass
 header.d=st.com;arc=none
Received: from VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM (10.255.158.157) by
 VE1PR10MB3054.EURPRD10.PROD.OUTLOOK.COM (20.179.30.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.11; Tue, 30 Jul 2019 16:08:19 +0000
Received: from VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e98c:3ebb:f5fd:89f3]) by VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e98c:3ebb:f5fd:89f3%6]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 16:08:19 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 4/4] iio:pressure: preenable/postenable/predisable fixup
 for ST press buffer
Thread-Topic: [PATCH 4/4] iio:pressure: preenable/postenable/predisable fixup
 for ST press buffer
Thread-Index: AQHVRmtQH5lKzSvTyU+qKfPA7gGdKabi3iYAgABz4bA=
Date:   Tue, 30 Jul 2019 16:08:19 +0000
Message-ID: <VE1PR10MB291275F4B3C439A1B86F8579EDDC0@VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM>
References: <20190730000305.30958-1-denis.ciocca@st.com>
         <20190730000305.30958-5-denis.ciocca@st.com>
 <c73657b4203d8112636751413c85f525f57dcc2a.camel@analog.com>
In-Reply-To: <c73657b4203d8112636751413c85f525f57dcc2a.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.34.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e8aadfc-2d49-4bcd-a38b-08d7150823b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VE1PR10MB3054;
x-ms-traffictypediagnostic: VE1PR10MB3054:
x-microsoft-antispam-prvs: <VE1PR10MB3054ACA20B397234916FA2F0EDDC0@VE1PR10MB3054.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(13464003)(7736002)(66476007)(316002)(53936002)(76176011)(66066001)(5660300002)(2501003)(68736007)(6116002)(3846002)(6436002)(7696005)(81166006)(99286004)(9686003)(55236004)(186003)(86362001)(26005)(81156014)(55016002)(110136005)(2201001)(52536014)(102836004)(8676002)(53546011)(8936002)(6506007)(71190400001)(25786009)(256004)(11346002)(71200400001)(446003)(6246003)(478600001)(486006)(74316002)(305945005)(14454004)(33656002)(76116006)(66946007)(66446008)(64756008)(66556008)(476003)(2906002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB3054;H:VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: st.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2FURmAD8P58bUZem8X9QSYotxRON4cnN1oXRYZ6nP0cQoXapXzU44MgqmusqnKREojdtQEzV+DscceGpOS64Sdl6ebprNEpVzOJg30v919fDuJRWioDLwNoU5eGg4eHw/sFwyrsobZ71+fgWr0Jq3RwVU6cbRDWw6nxFkneecdaQ5xS92/8lEsOFVIyWPCotx/lG9QjbI5kHT0Mdy1FHamwKA7SvNtMX2dzFQgITBG5+GeGs/jOuv7n4ym0583v8JYyGFsUt8whIXv+vSNK2TMDRUFc8KA2Mr6egvNO5WU0UC7CcHuXgyedY3u/zUnMrdpIC8/gZFkRCnx05RLLHXiiKDBX2SLrU25DPuSwRr9eNswgtv5PWHR3SfzSFljFJIIFEsTQN9YQNBbuHi5WflaHaGbUr1M/oNpQ4y036dkk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8aadfc-2d49-4bcd-a38b-08d7150823b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 16:08:19.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: denis.ciocca@st.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300167
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQWxleGFuZHJ1LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFy
ZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDE5IDI6MDIgQU0NCj4gVG86IGppYzIzQGtlcm5lbC5vcmc7
IERlbmlzIENJT0NDQSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT47IGxpbnV4LQ0KPiBpaW9Admdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBpaW86cHJlc3N1cmU6IHByZWVu
YWJsZS9wb3N0ZW5hYmxlL3ByZWRpc2FibGUNCj4gZml4dXAgZm9yIFNUIHByZXNzIGJ1ZmZlcg0K
PiANCj4gT24gTW9uLCAyMDE5LTA3LTI5IGF0IDE3OjAzIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3Jv
dGU6DQo+ID4gW0V4dGVybmFsXQ0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gY2xl
YW51cCBmb3IgZ29vZCB0aGUgYnVmZmVycyBvcGVyYXRpb24gZnVuY3Rpb25zLg0KPiA+IFRoZXJl
IGlzIG5vIG5lZWQgb2YgdXNpbmcgcHJlZW5hYmxlLCBhbGwgY2FuIGJlIGRvbmUgaW50byBwb3N0
ZW5hYmxlLg0KPiA+IExldCdzIGFsc28gdXNlIGxvZ2ljYWwgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9u
cyBhcyBhbHJlYWR5IGRvbmUgaW4gYWNjZWwNCj4gPiBkcml2ZXIuDQo+ID4gRmluYWxseSBhbHNv
IHJlbmFtZSB0aGUgZ290byBsYWJlbCB1c2luZyBvcGVyYXRpb24gdG8gcGVyZm9ybSBhbmQgbm90
DQo+ID4gd2hlcmUgaXQgZmFpbHMuDQo+ID4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcnUg
QXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiANCj4gDQo+IFVucmVs
YXRlZCB0byB0aGlzIHBhdGNoLCBJIHdhcyB0aGlua2luZyB0aGF0IGl0IHdvdWxkIGJlIGEgbmVh
dCBpZGVhIHRvIG1vdmUNCj4gdGhlIGBidWZmZXJfZGF0YWAgYWxsb2NhdGlvbiBpbg0KPiBgZHJp
dmVycy9paW8vY29tbW9uL3N0X3NlbnNvcnMvc3Rfc2Vuc29yc19idWZmZXIuY2ANCj4gDQo+IFRo
aXMgd291bGQgcmVtb3ZlIHNvbWUgZHVwbGljYXRpb24gb2YgdGhpcyBhbGxvYyArIGZyZWUgaW4g
ZHJpdmVycy4NCj4gDQo+IE1heWJlIGluIHN0X3NlbnNvcnNfdHJpZ2dlcl9oYW5kbGVyKCkgc29t
ZXRoaW5nIGxpa2U6DQo+IA0KPiBpZiAoIXNkYXRhLT5idWZmZXJfZGF0YSkgew0KPiAgICAgc2Rh
dGEtPmJ1ZmZlcl9kYXRhID0gZGV2bV9rbWFsbG9jKCkNCj4gICAgIGlmICghc2RhdGEtPmJ1ZmZl
cl9kYXRhKSB7DQo+ICAgICAgICAgZGV2X2VycihpbmRpb19kZXYtPmRldiwgIkZhaWxlZCB0byBh
bGxvY2F0ZSBidWZmZXIgZGF0YVxuIik7DQo+ICAgICAgICAgZ290byBzdF9zZW5zb3JzX2dldF9i
dWZmZXJfZWxlbWVudF9lcnJvcjsNCj4gICAgIH0NCj4gfQ0KPiANCj4gVXNpbmcgZGV2bV9rbWFs
bG9jKCkgb3IgYSBzaW1pbGFyIGRldm1fIHZhcmlhbnQgd291bGQgYmUgbmVhdCwgc2luY2UgaXQg
Z2V0cw0KPiBmcmVlJ2Qgd2hlbiB0aGUgZGV2aWNlIGdldHMgcmVtb3ZlZC4NCg0KTm90IHN1cmUg
YWJvdXQgdGhlIHNvbHV0aW9uIHByb3Bvc2VkLg0KTWVtb3J5IGFsbG9jYXRpb24gaXMgYWN0dWFs
bHkgcmVsYXRlZCB0byBob3cgbWFueSBjaGFubmVscyBhcmUgZW5hYmxlZCwNCm9uZSBwb3NzaWJp
bGl0eSBjb3VsZCBiZSB0byBhbGxvY2F0ZSB0aGUgbWF4aW11bSBidXQgbm90IHN1cmUgaXQncyB3
b3J0aC4uLg0KTW9yZW92ZXIgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIHRoZXJlIGNvdWxkIGxldCBk
cml2ZXIgbWlzcyB0aGUgZmlyc3Qgc2FtcGxlIEkgZ3Vlc3MuDQoNCg0KPiANCj4gVGhhbmtzDQo+
IEFsZXgNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVuaXMgQ2lvY2NhIDxkZW5pcy5jaW9jY2FA
c3QuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9i
dWZmZXIuYyB8IDMyDQo+ID4gKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL3ByZXNzdXJlL3N0X3ByZXNzdXJlX2J1ZmZlci5jDQo+ID4gYi9k
cml2ZXJzL2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9idWZmZXIuYw0KPiA+IGluZGV4IGYyMWI2
MzBhYmFhMC4uNTQ4MjNjZmNmYWI1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL3ByZXNz
dXJlL3N0X3ByZXNzdXJlX2J1ZmZlci5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vcHJlc3N1cmUv
c3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gPiBAQCAtMjksNTMgKzI5LDQzIEBAIGludCBzdF9wcmVz
c190cmlnX3NldF9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcsDQo+IGJvb2wgc3RhdGUp
DQo+ID4gIAlyZXR1cm4gc3Rfc2Vuc29yc19zZXRfZGF0YXJlYWR5X2lycShpbmRpb19kZXYsIHN0
YXRlKTsgIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW50IHN0X3ByZXNzX2J1ZmZlcl9wcmVlbmFibGUo
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldikgLXsNCj4gPiAtCXJldHVybiBzdF9zZW5zb3JzX3Nl
dF9lbmFibGUoaW5kaW9fZGV2LCB0cnVlKTsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgc3RhdGljIGlu
dCBzdF9wcmVzc19idWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KSAg
ew0KPiA+IC0JaW50IGVycjsNCj4gPiAgCXN0cnVjdCBzdF9zZW5zb3JfZGF0YSAqcHJlc3NfZGF0
YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKwlpbnQgZXJyOw0KPiA+DQo+ID4gIAlwcmVz
c19kYXRhLT5idWZmZXJfZGF0YSA9IGttYWxsb2MoaW5kaW9fZGV2LT5zY2FuX2J5dGVzLA0KPiA+
ICAJCQkJCSAgR0ZQX0RNQSB8IEdGUF9LRVJORUwpOw0KPiA+IC0JaWYgKHByZXNzX2RhdGEtPmJ1
ZmZlcl9kYXRhID09IE5VTEwpIHsNCj4gPiAtCQllcnIgPSAtRU5PTUVNOw0KPiA+IC0JCWdvdG8g
YWxsb2NhdGVfbWVtb3J5X2Vycm9yOw0KPiA+IC0JfQ0KPiA+ICsJaWYgKCFwcmVzc19kYXRhLT5i
dWZmZXJfZGF0YSkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPg0KPiA+ICAJZXJyID0gaWlv
X3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZShpbmRpb19kZXYpOw0KPiA+ICAJaWYgKGVyciA8
IDApDQo+ID4gLQkJZ290byBzdF9wcmVzc19idWZmZXJfcG9zdGVuYWJsZV9lcnJvcjsNCj4gPiAr
CQlnb3RvIHN0X3ByZXNzX2ZyZWVfYnVmZmVyOw0KPiA+DQo+ID4gLQlyZXR1cm4gZXJyOw0KPiA+
ICsJcmV0dXJuIHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiA+DQo+
ID4gLXN0X3ByZXNzX2J1ZmZlcl9wb3N0ZW5hYmxlX2Vycm9yOg0KPiA+ICtzdF9wcmVzc19mcmVl
X2J1ZmZlcjoNCj4gPiAgCWtmcmVlKHByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhKTsNCj4gPiAtYWxs
b2NhdGVfbWVtb3J5X2Vycm9yOg0KPiA+ICAJcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+DQo+ID4g
IHN0YXRpYyBpbnQgc3RfcHJlc3NfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldikNCj4gPiAgew0KPiA+IC0JaW50IGVycjsNCj4gPiAgCXN0cnVjdCBzdF9zZW5zb3Jf
ZGF0YSAqcHJlc3NfZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gLQ0KPiA+IC0JZXJy
ID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiA+IC0JaWYg
KGVyciA8IDApDQo+ID4gLQkJZ290byBzdF9wcmVzc19idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjsN
Cj4gPiArCWludCBlcnIsIGVycjI7DQo+ID4NCj4gPiAgCWVyciA9IHN0X3NlbnNvcnNfc2V0X2Vu
YWJsZShpbmRpb19kZXYsIGZhbHNlKTsNCj4gPg0KPiA+IC1zdF9wcmVzc19idWZmZXJfcHJlZGlz
YWJsZV9lcnJvcjoNCj4gPiArCWVycjIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxl
KGluZGlvX2Rldik7DQo+ID4gKwlpZiAoIWVycikNCj4gPiArCQllcnIgPSBlcnIyOw0KPiA+ICsN
Cj4gPiAgCWtmcmVlKHByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhKTsNCj4gPiAgCXJldHVybiBlcnI7
DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBf
b3BzIHN0X3ByZXNzX2J1ZmZlcl9zZXR1cF9vcHMgPSB7DQo+ID4gLQkucHJlZW5hYmxlID0gJnN0
X3ByZXNzX2J1ZmZlcl9wcmVlbmFibGUsDQo+ID4gIAkucG9zdGVuYWJsZSA9ICZzdF9wcmVzc19i
dWZmZXJfcG9zdGVuYWJsZSwNCj4gPiAgCS5wcmVkaXNhYmxlID0gJnN0X3ByZXNzX2J1ZmZlcl9w
cmVkaXNhYmxlLA0KPiA+ICB9Ow0K
