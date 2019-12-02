Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32710E70F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLBIub (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:50:31 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:62294 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfLBIua (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:50:30 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB28mBmo001014;
        Mon, 2 Dec 2019 03:50:07 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2055.outbound.protection.outlook.com [104.47.41.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wknx8mcd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 03:50:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJBZvcO9jx/Y4rlXmP92d+Q/9stjQW7rOYucvjWeeu+cO12pCyhIbBJX4Xp6WFBKo0iR6oU2grEhs/7lr208hhLhZ6z8DaWVB4N7fZfvA4zHxkRipTAArv5KbXEccCtKexvF9L1dqBxrBmZk+h7J2CPAk0KYDBdyGkz8FF2bo5dxMFHJSeUMUdtOKyiaOXJZEgAMMyZCwtcGTk2TK+yjK3wFT+kwJpEhPHNrwbopekGw1BfkyxNsRGcXMZKgqzs/08XKGJ3L+WsZGavlKmjQiE8WoBc+vVogs970b302058GPZg0jJ0M3xVoHxx+O5mcRkqclIcguIxRmOLm3twq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXhllXp34ThINK6YKsY8SdRmrc+k0D9kMFHjAEfGXYc=;
 b=X77Mmo/IjqVi3ewIMX+J9FlomjpUbl6YzHZQ6yBRaNxc/vmQU/AtKr4xdhFEA4lLB1Dx29v3tf+lhRB8F2foAVzHvP9eEn0qFpvxEazikNKFYEUNFEzy5l0n04rWs20lcg+F5arKZ+v786wPWqGar5aJsdVTuEfUmh5nW8ogPMutweZVqEUuKTp6VuVUW2QgiYFWKZPhf7Yk4txBLHONzMO09EpJ46xGfdSu6/MmO6jqAEHerfupNlNX4lj4/+owURo4bjCNoQ4sTuzUfj7M3GbAg1HP3glJFNxa85kur42s+vH1Lb9TsQCFf66J8AwRFbv+BEmiVbOGh04RJH6IOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXhllXp34ThINK6YKsY8SdRmrc+k0D9kMFHjAEfGXYc=;
 b=dnsCGYOuM5aSzb6eYcZE6foqr5mRxNkXcMT2EFmf0yOC4imQKHHZaNi487x2biYMxUaBMmrWP68LtDDuqxWebnxTEtwFepIeBJfJDn3VPFEF/EwFqikoGYLfrGKT0NxgYfU94TywtsJuhckNDB0SU+a2sy5W/ycYRYcXfUYouVo=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5255.namprd03.prod.outlook.com (20.180.5.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 08:50:05 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 08:50:05 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adf4350: Convert to use GPIO descriptor
Thread-Topic: [PATCH] iio: adf4350: Convert to use GPIO descriptor
Thread-Index: AQHVqOv1cwNidedCWUeTjYwZZfnRfKemiXyA
Date:   Mon, 2 Dec 2019 08:50:05 +0000
Message-ID: <a1be250ce3e9a89e5a352390e16504ce8e017dbe.camel@analog.com>
References: <20191202083830.71572-1-linus.walleij@linaro.org>
In-Reply-To: <20191202083830.71572-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8db10667-1210-4dfa-e6ac-08d77704a0de
x-ms-traffictypediagnostic: CH2PR03MB5255:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5255D42DA372F0340EE4D2D8F9430@CH2PR03MB5255.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(51914003)(66066001)(14454004)(2201001)(26005)(4326008)(71200400001)(6506007)(478600001)(305945005)(6116002)(7736002)(2906002)(102836004)(5660300002)(11346002)(2616005)(2501003)(6246003)(14444005)(256004)(36756003)(54906003)(110136005)(316002)(8676002)(6486002)(446003)(3846002)(71190400001)(229853002)(6512007)(6436002)(86362001)(8936002)(76176011)(81156014)(66946007)(76116006)(66556008)(186003)(66476007)(64756008)(66446008)(118296001)(99286004)(25786009)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5255;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUv3+IDbBvalo6ZFUJR6j7rfbA0nuEJW5BGMIYWgrggdNQ9cy0RrhRScAiCU+qGIG/SLmWSuG5POzrlFv2TQi3fHQzAf6WFUEBi//56Cg5wA2uIvniLVYhVez+OPdQ4RgY3P7TNMVJP/4lK/s/Hvn8qNOZH+vdAGDYwqIrRbSY+29qt4yhf8KJ9dxXM8qKBg5WfbVKgIxtoSww8oQALoml+BtbfpfFA0+U0MdGeYTSkYOkjxR8V3pj/fdSoSeONKnX8vyMl7nnxIS6Z/BsBEA1+jqqoxXNuPtN14XwbuhtjOjGTu3x/Mb0BnNGT6tFinl01Nw8WmHWYbjlXNnaKqW3UbZTeK2Tgi7t4uA+Xo7lfYWFKQw64cOJrp2bjhAz6iEk6T+4r3Rl6Shd9+fWVwwWIvd15UystMHFuMSWVNuBilS5+wa26D0OoRHsBzHGdS
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E6A87B2AA965E4A9A18D91822366DAC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db10667-1210-4dfa-e6ac-08d77704a0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 08:50:05.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHs1RJOwPAu29dFxD10/Spe3uD4yRO3r8MI3fXAPERVSrTwUqcyjh6q8mnYGzTU74QreE9NwsDmFgXrcwS/UHwQybS3vwcZcwg7n76uYpuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5255
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_01:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTAyIGF0IDA5OjM4ICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBUaGUgbG9jayBkZXRlY3QgR1BJTyBsaW5lIGlzIGJldHRlciB0byBncmFiIHVzaW5nDQo+IGEg
R1BJTyBkZXNjcmlwdG9yLiBXZSBkcm9wIHRoZSBwZGF0YSBmb3IgdGhpczogY2xpZW50cyB1c2lu
ZyBib2FyZA0KPiBmaWxlcyBjYW4gdXNlIG1hY2hpbmUgZGVzY3JpcHRvciB0YWJsZXMgdG8gcGFz
cyB0aGlzIEdQSU8gZnJvbQ0KPiBzdGF0aWMgZGF0YS4NCg0KSGV5LA0KDQpUaGFua3MgZm9yIHRo
ZSBwYXRjaC4NCkEgcXVlc3Rpb24gaW5saW5lLiBNYXliZSB0byBKb25hdGhhbiBhcyB3ZWxsLg0K
T3RoZXIgdGhhbiB0aGF0IHRoaXMgbG9va3MgZ29vZC4NCg0KPiANCj4gQ2M6IE1pY2hhZWwgSGVu
bmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBM
aW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9paW8vZnJlcXVlbmN5L2FkZjQzNTAuYyAgICAgICB8IDMwICsrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgaW5jbHVkZS9saW51eC9paW8vZnJlcXVlbmN5L2FkZjQzNTAuaCB8ICA0IC0t
LS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9mcmVxdWVuY3kvYWRmNDM1MC5jDQo+IGIv
ZHJpdmVycy9paW8vZnJlcXVlbmN5L2FkZjQzNTAuYw0KPiBpbmRleCBhZTBjYTA5YWUwNjIuLjFj
MmRjOWIwMGYzMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vZnJlcXVlbmN5L2FkZjQzNTAu
Yw0KPiArKysgYi9kcml2ZXJzL2lpby9mcmVxdWVuY3kvYWRmNDM1MC5jDQo+IEBAIC0xNCwxMSAr
MTQsMTAgQEANCj4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9nY2QuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9n
cGlvLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiAgI2luY2x1ZGUg
PGFzbS9kaXY2NC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAgI2luY2x1ZGUgPGxp
bnV4L29mLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvb2ZfZ3Bpby5oPg0KPiAgDQo+ICAjaW5jbHVk
ZSA8bGludXgvaWlvL2lpby5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9zeXNmcy5oPg0KPiBA
QCAtMzQsNiArMzMsNyBAQCBlbnVtIHsNCj4gIHN0cnVjdCBhZGY0MzUwX3N0YXRlIHsNCj4gIAlz
dHJ1Y3Qgc3BpX2RldmljZQkJKnNwaTsNCj4gIAlzdHJ1Y3QgcmVndWxhdG9yCQkqcmVnOw0KPiAr
CXN0cnVjdCBncGlvX2Rlc2MJCSpsb2NrX2RldGVjdF9ncGlvZDsNCj4gIAlzdHJ1Y3QgYWRmNDM1
MF9wbGF0Zm9ybV9kYXRhCSpwZGF0YTsNCj4gIAlzdHJ1Y3QgY2xrCQkJKmNsazsNCj4gIAl1bnNp
Z25lZCBsb25nCQkJY2xraW47DQo+IEBAIC02MSw3ICs2MSw2IEBAIHN0YXRpYyBzdHJ1Y3QgYWRm
NDM1MF9wbGF0Zm9ybV9kYXRhIGRlZmF1bHRfcGRhdGEgPSB7DQo+ICAJLnIzX3VzZXJfc2V0dGlu
Z3MgPSBBREY0MzUwX1JFRzNfMTJCSVRfQ0xLRElWX01PREUoMCksDQo+ICAJLnI0X3VzZXJfc2V0
dGluZ3MgPSBBREY0MzUwX1JFRzRfT1VUUFVUX1BXUigzKSB8DQo+ICAJCQkgICAgQURGNDM1MF9S
RUc0X01VVEVfVElMTF9MT0NLX0VOLA0KPiAtCS5ncGlvX2xvY2tfZGV0ZWN0ID0gLTEsDQo+ICB9
Ow0KPiAgDQo+ICBzdGF0aWMgaW50IGFkZjQzNTBfc3luY19jb25maWcoc3RydWN0IGFkZjQzNTBf
c3RhdGUgKnN0KQ0KPiBAQCAtMzE3LDggKzMxNiw4IEBAIHN0YXRpYyBzc2l6ZV90IGFkZjQzNTBf
cmVhZChzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiAgCQkJKHU2NClzdC0+ZnBmZDsN
Cj4gIAkJZG9fZGl2KHZhbCwgc3QtPnIxX21vZCAqICgxIDw8IHN0LT5yNF9yZl9kaXZfc2VsKSk7
DQo+ICAJCS8qIFBMTCB1bmxvY2tlZD8gcmV0dXJuIGVycm9yICovDQo+IC0JCWlmIChncGlvX2lz
X3ZhbGlkKHN0LT5wZGF0YS0+Z3Bpb19sb2NrX2RldGVjdCkpDQo+IC0JCQlpZiAoIWdwaW9fZ2V0
X3ZhbHVlKHN0LT5wZGF0YS0+Z3Bpb19sb2NrX2RldGVjdCkpIHsNCj4gKwkJaWYgKHN0LT5sb2Nr
X2RldGVjdF9ncGlvZCkNCj4gKwkJCWlmICghZ3Bpb2RfZ2V0X3ZhbHVlKHN0LT5sb2NrX2RldGVj
dF9ncGlvZCkpIHsNCj4gIAkJCQlkZXZfZGJnKCZzdC0+c3BpLT5kZXYsICJQTEwgdW4tbG9ja2Vk
XG4iKTsNCj4gIAkJCQlyZXQgPSAtRUJVU1k7DQo+ICAJCQl9DQo+IEBAIC0zODEsNyArMzgwLDYg
QEAgc3RhdGljIHN0cnVjdCBhZGY0MzUwX3BsYXRmb3JtX2RhdGENCj4gKmFkZjQzNTBfcGFyc2Vf
ZHQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYt
Pm9mX25vZGU7DQo+ICAJc3RydWN0IGFkZjQzNTBfcGxhdGZvcm1fZGF0YSAqcGRhdGE7DQo+ICAJ
dW5zaWduZWQgaW50IHRtcDsNCj4gLQlpbnQgcmV0Ow0KPiAgDQo+ICAJcGRhdGEgPSBkZXZtX2t6
YWxsb2MoZGV2LCBzaXplb2YoKnBkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFwZGF0YSkN
Cj4gQEAgLTQwMSwxMiArMzk5LDYgQEAgc3RhdGljIHN0cnVjdCBhZGY0MzUwX3BsYXRmb3JtX2Rh
dGENCj4gKmFkZjQzNTBfcGFyc2VfZHQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCW9mX3Byb3Bl
cnR5X3JlYWRfdTMyKG5wLCAiYWRpLHJlZmVyZW5jZS1kaXYtZmFjdG9yIiwgJnRtcCk7DQo+ICAJ
cGRhdGEtPnJlZl9kaXZfZmFjdG9yID0gdG1wOw0KPiAgDQo+IC0JcmV0ID0gb2ZfZ2V0X2dwaW8o
bnAsIDApOw0KPiAtCWlmIChyZXQgPCAwKQ0KPiAtCQlwZGF0YS0+Z3Bpb19sb2NrX2RldGVjdCA9
IC0xOw0KPiAtCWVsc2UNCj4gLQkJcGRhdGEtPmdwaW9fbG9ja19kZXRlY3QgPSByZXQ7DQo+IC0N
Cj4gIAlwZGF0YS0+cmVmX2RvdWJsZXJfZW4gPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsDQo+
ICAJCQkiYWRpLHJlZmVyZW5jZS1kb3VibGVyLWVuYWJsZSIpOw0KPiAgCXBkYXRhLT5yZWZfZGl2
Ml9lbiA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwNCj4gQEAgLTU2MSwxNiArNTUzLDEwIEBA
IHN0YXRpYyBpbnQgYWRmNDM1MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgDQo+
ICAJbWVtc2V0KHN0LT5yZWdzX2h3LCAweEZGLCBzaXplb2Yoc3QtPnJlZ3NfaHcpKTsNCj4gIA0K
PiAtCWlmIChncGlvX2lzX3ZhbGlkKHBkYXRhLT5ncGlvX2xvY2tfZGV0ZWN0KSkgew0KPiAtCQly
ZXQgPSBkZXZtX2dwaW9fcmVxdWVzdCgmc3BpLT5kZXYsIHBkYXRhLT5ncGlvX2xvY2tfZGV0ZWN0
LA0KPiAtCQkJCQlpbmRpb19kZXYtPm5hbWUpOw0KPiAtCQlpZiAocmV0KSB7DQo+IC0JCQlkZXZf
ZXJyKCZzcGktPmRldiwgImZhaWwgdG8gcmVxdWVzdCBsb2NrIGRldGVjdA0KPiBHUElPLSVkIiwN
Cj4gLQkJCQlwZGF0YS0+Z3Bpb19sb2NrX2RldGVjdCk7DQo+IC0JCQlnb3RvIGVycm9yX2Rpc2Fi
bGVfcmVnOw0KPiAtCQl9DQo+IC0JCWdwaW9fZGlyZWN0aW9uX2lucHV0KHBkYXRhLT5ncGlvX2xv
Y2tfZGV0ZWN0KTsNCj4gLQl9DQo+ICsJc3QtPmxvY2tfZGV0ZWN0X2dwaW9kID0gZGV2bV9ncGlv
ZF9nZXRfb3B0aW9uYWwoJnNwaS0+ZGV2LCBOVUxMLA0KDQpXb3VsZCBpdCBtYWtlIHNlbnNlIHRv
IG5hbWUgdGhlIEdQSU8gaGVyZT8NCk1heWJlIG5hbWUgaXQgImxvY2stZGV0ZWN0Ij8NCg0KSSBk
byByZWFsaXplIHRoYXQgdGhpcyBnb2VzIGludG8gdGhlIHJlYWxtIG9mIGNoYW5naW5nIHNvbWUg
ZGVmYXVsdA0KYmVoYXZpb3IuDQpBbmQgSSBhbSBub3Qgc3VyZSBob3cgYWNjZXB0YWJsZSB0aGlz
IGlzIFtnZW5lcmFsbHldLg0KDQpUaGFua3MNCkFsZXgNCg0KPiArCQkJCQkJCUdQSU9EX0lOKTsN
Cj4gKwlpZiAoSVNfRVJSKHN0LT5sb2NrX2RldGVjdF9ncGlvZCkpDQo+ICsJCXJldHVybiBQVFJf
RVJSKHN0LT5sb2NrX2RldGVjdF9ncGlvZCk7DQo+ICANCj4gIAlpZiAocGRhdGEtPnBvd2VyX3Vw
X2ZyZXF1ZW5jeSkgew0KPiAgCQlyZXQgPSBhZGY0MzUwX3NldF9mcmVxKHN0LCBwZGF0YS0+cG93
ZXJfdXBfZnJlcXVlbmN5KTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaWlvL2ZyZXF1
ZW5jeS9hZGY0MzUwLmgNCj4gYi9pbmNsdWRlL2xpbnV4L2lpby9mcmVxdWVuY3kvYWRmNDM1MC5o
DQo+IGluZGV4IGNlOTQ5MGJmZWI4OS4uZGU0NWNmMmVlMWU0IDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2lpby9mcmVxdWVuY3kvYWRmNDM1MC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgv
aWlvL2ZyZXF1ZW5jeS9hZGY0MzUwLmgNCj4gQEAgLTEwMyw5ICsxMDMsNiBAQA0KPiAgICogQHIy
X3VzZXJfc2V0dGluZ3M6CVVzZXIgZGVmaW5lZCBzZXR0aW5ncyBmb3IgQURGNDM1MC8xDQo+IFJF
R0lTVEVSXzIuDQo+ICAgKiBAcjNfdXNlcl9zZXR0aW5nczoJVXNlciBkZWZpbmVkIHNldHRpbmdz
IGZvciBBREY0MzUwLzENCj4gUkVHSVNURVJfMy4NCj4gICAqIEByNF91c2VyX3NldHRpbmdzOglV
c2VyIGRlZmluZWQgc2V0dGluZ3MgZm9yIEFERjQzNTAvMQ0KPiBSRUdJU1RFUl80Lg0KPiAtICog
QGdwaW9fbG9ja19kZXRlY3Q6CU9wdGlvbmFsLCBpZiBzZXQgd2l0aCBhIHZhbGlkIEdQSU8gbnVt
YmVyLA0KPiAtICoJCQlwbGwgbG9jayBzdGF0ZSBpcyB0ZXN0ZWQgdXBvbiByZWFkLg0KPiAtICoJ
CQlJZiBub3QgdXNlZCAtIHNldCB0byAtMS4NCj4gICAqLw0KPiAgDQo+ICBzdHJ1Y3QgYWRmNDM1
MF9wbGF0Zm9ybV9kYXRhIHsNCj4gQEAgLTEyMSw3ICsxMTgsNiBAQCBzdHJ1Y3QgYWRmNDM1MF9w
bGF0Zm9ybV9kYXRhIHsNCj4gIAl1bnNpZ25lZAkJcjJfdXNlcl9zZXR0aW5nczsNCj4gIAl1bnNp
Z25lZAkJcjNfdXNlcl9zZXR0aW5nczsNCj4gIAl1bnNpZ25lZAkJcjRfdXNlcl9zZXR0aW5nczsN
Cj4gLQlpbnQJCQlncGlvX2xvY2tfZGV0ZWN0Ow0KPiAgfTsNCj4gIA0KPiAgI2VuZGlmIC8qIElJ
T19QTExfQURGNDM1MF9IXyAqLw0K
