Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA604171135
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 08:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgB0HB7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 02:01:59 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4474 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727403AbgB0HB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 02:01:59 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R6tcS4017409;
        Thu, 27 Feb 2020 02:01:55 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrx28t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 02:01:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZxJML3Bu2gqEM6ED5hqM3D9MgJBC2psTi0d5EymW+beTS13abSJYHiAPL1J9roiy0mrDeVIP0ZxNP3llQJeFK4WMsAXI8fHl29hbhFDmJpfG/R/Z7xxqEt9MMOXy4NHleyPrM0MFgYJ+fgwWi7e2MhVvZqFzhAbBvFkyHjlWcbHzOtHoeSduPwn03osBQNZ09Q9NnF1c3SZzpr0wJyj4klLxx9VgA9DAEPVbl3v7bDsieIQvjCccRNeD7GcFXWnQvfljk74/kGrj0MUBdJeVYYzQSYvUVHrDrrVH6RA9qkKE47nlOw0TBVoUiaVrkA+kRPswJGcSdxPN4YGUclvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRfAG6EnZktb6BRxahmlv2OTyyX7g3ThOp/06o3dptk=;
 b=iHo1/7RsQWTZcBu3n5DrirHdAvGJbftYrR1NMqWQa2BNZInXUGseX28NzQoVM61xTv3g/wKjPAZNrnKrFGLeV9H4ruM4OFkM/C72IN/yj4D/CsOCJuqsklAmUcu9k1AKjJSX53DOh/TqTuI2oWgKDIirqqvQZfAv897eRFSE2VOnD+s+6DUaE89rNooGnvi5uk6y3ae/3jhy0XjHryYkjvSigJEyDBBje50JBi/4tptcpUWgBz345qw0fx7/mSN2qH96lgxzpeNhY+b5gQuAmmGNwrvqCnhbgWstao6Z7bAxRwdsfWt5mvmz1vYsSaZ142sEPB/ihkyj/fXgog5eiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRfAG6EnZktb6BRxahmlv2OTyyX7g3ThOp/06o3dptk=;
 b=DladdlIS91uO8KoPTsp78i66zHuEfSojWA9nMwdTFJRmAIQfnh51u0zhp/WqzRnfQf8JgNZyE2aD4Cb3BOYkQmHYPAvsktBtGD3JaQTA579NyB6l1PEn8VSm4ZOv+p4nvZ5JbK6ktkOdSoBfm9MR5h26F/im7XrQLnkTCHeM6aA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5160.namprd03.prod.outlook.com (2603:10b6:610:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 07:01:54 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 07:01:54 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lkp@intel.com" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iio: adc: adi-axi-adc: add support for AXI ADC IP
 core
Thread-Topic: [PATCH v2 4/7] iio: adc: adi-axi-adc: add support for AXI ADC IP
 core
Thread-Index: AQHV7LZPpjzMe/OlFkW3eC564DBIPKguGDGAgACGzAA=
Date:   Thu, 27 Feb 2020 07:01:54 +0000
Message-ID: <f2709033d98c34a92631d767fa116951a1390df1.camel@analog.com>
References: <20200226150835.19649-5-alexandru.ardelean@analog.com>
         <202002270620.mqsOhj9F%lkp@intel.com>
In-Reply-To: <202002270620.mqsOhj9F%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d085ebba-2f45-4ac9-77b5-08d7bb52ed90
x-ms-traffictypediagnostic: CH2PR03MB5160:
x-microsoft-antispam-prvs: <CH2PR03MB516068F8AECDFFD13502197EF9EB0@CH2PR03MB5160.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(186003)(5660300002)(2906002)(26005)(86362001)(478600001)(66446008)(64756008)(91956017)(76116006)(66476007)(66556008)(81156014)(966005)(81166006)(36756003)(8676002)(66946007)(2616005)(6506007)(4001150100001)(54906003)(6512007)(4326008)(8936002)(71200400001)(6486002)(316002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5160;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVrd+SPIlczMnLwRDAunNhX7jjkUxWKB9L28Ma91XLgjGv4uZReFRpTvKlYbmjtCXAGmRTIHY0FSdJ5GJpDxTvlTnjwB09yoQ3pFkqnY4XgANLd6Fx7b5eEZTSQQgWPXEJnWFWqpbbyqdmtz698RxgBGkgLiRP3Gdm2uiCoFEhCC206TRp6cpVI1mYz5QBQ0nh93bd2Jo3h4Cwua3q28hXMnYfkcpQCxaiOt5wrjpauviPh7OfgnRPgAJJnwSfdWHWmm8TdnbIJ3z1E0bDQjtYJj6ae+dyHi7SW8vHAUBsQXm6nnga0IAEd2ReKRO+7Rp1KOGl+kUBak27EECj1i1vWG9/fLkOZWJ5Qppb0H4hKEcxTQYwBugU1SbJmC+qh2iU8AkYY+/gMjqtwHyHS2EUV1Z3zJH9tuXRtuSJOQMq8bee2hTBjXj1SfGDaVBOiO/xkFQuigJj57Hvv17ngEqabGc8a7IgDhdMGRb21fBXS7i0ryEVlLODWff6lpN9OKcTVUicMojWtct2L6xZ8wvg==
x-ms-exchange-antispam-messagedata: e+xJkWccQh2X10bQVgD7Re5Mj+9mA5vqhrtHSgsXmQIq2stQiGOBMby3Su/HuwSliPS+eJ+s76VNIMeVZHz21m4j8iBsujv4aT5Ami6QS/YNdxBCBncZYn7pdxHLKjFwruUiXUk7gCNjSVe8bZTHZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <896EC40CF421D94C9D698B970A9FEB04@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d085ebba-2f45-4ac9-77b5-08d7bb52ed90
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 07:01:54.3266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGaNgBNeLNk8UjqUBcu3f3Q+ZAj/hN8MdYc3n8DyZghSThjqeWNL7jxZBdltGjnVBcl81D7qOM3oGu7qfSl43ecFGMLaKrozqofFQHSh4ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_01:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTI3IGF0IDA3OjAyICswODAwLCBrYnVpbGQgdGVzdCByb2JvdCB3cm90
ZToNCj4gW0V4dGVybmFsXQ0KPiANCj4gSGkgQWxleGFuZHJ1LA0KPiANCj4gSSBsb3ZlIHlvdXIg
cGF0Y2ghIFBlcmhhcHMgc29tZXRoaW5nIHRvIGltcHJvdmU6DQo+IA0KPiBbYXV0byBidWlsZCB0
ZXN0IFdBUk5JTkcgb24gaWlvL3RvZ3JlZ10NCj4gW2Fsc28gYnVpbGQgdGVzdCBXQVJOSU5HIG9u
IGxpbnVzL21hc3RlciB2NS42LXJjMyBuZXh0LTIwMjAwMjI2XQ0KPiBbY2Fubm90IGFwcGx5IHRv
IGxpbnV4L21hc3Rlcl0NCj4gW2lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3Jvbmcg
Z2l0IHRyZWUsIHBsZWFzZSBkcm9wIHVzIGEgbm90ZSB0byBoZWxwDQo+IGltcHJvdmUgdGhlIHN5
c3RlbS4gQlRXLCB3ZSBhbHNvIHN1Z2dlc3QgdG8gdXNlICctLWJhc2UnIG9wdGlvbiB0byBzcGVj
aWZ5IHRoZQ0KPiBiYXNlIHRyZWUgaW4gZ2l0IGZvcm1hdC1wYXRjaCwgcGxlYXNlIHNlZSBodHRw
czovL3N0YWNrb3ZlcmZsb3cuY29tL2EvMzc0MDY5ODINCj4gXQ0KPiANCj4gdXJsOiAgICANCj4g
aHR0cHM6Ly9naXRodWIuY29tLzBkYXktY2kvbGludXgvY29tbWl0cy9BbGV4YW5kcnUtQXJkZWxl
YW4vaWlvLWFkaS1heGktYWRjLWFkOTY0Ny1BZGQtc3VwcG9ydC1mb3ItQUQ5NDY3LUFEQy8yMDIw
MDIyNy0wMzA1NDYNCj4gYmFzZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9qaWMyMy9paW8uZ2l0IHRvZ3JlZw0KPiBjb25maWc6IHJpc2N2LWFsbHll
c2NvbmZpZyAoYXR0YWNoZWQgYXMgLmNvbmZpZykNCj4gY29tcGlsZXI6IHJpc2N2NjQtbGludXgt
Z2NjIChHQ0MpIDcuNS4wDQo+IHJlcHJvZHVjZToNCj4gICAgICAgICB3Z2V0IA0KPiBodHRwczov
L3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21hc3Rlci9zYmluL21h
a2UuY3Jvc3MgLU8NCj4gfi9iaW4vbWFrZS5jcm9zcw0KPiAgICAgICAgIGNobW9kICt4IH4vYmlu
L21ha2UuY3Jvc3MNCj4gICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGlu
dXggYnVpbGQgdHJlZQ0KPiAgICAgICAgIEdDQ19WRVJTSU9OPTcuNS4wIG1ha2UuY3Jvc3MgQVJD
SD1yaXNjdiANCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2lu
ZyB0YWcNCj4gUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0K
PiANCj4gQWxsIHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+IA0KPiAgICBk
cml2ZXJzL2lpby9idWZmZXIvaW5kdXN0cmlhbGlvLWJ1ZmZlci1kbWFlbmdpbmUuYzogSW4gZnVu
Y3Rpb24NCj4gJ2lpb19kbWFlbmdpbmVfYnVmZmVyX2dldF9sZW5ndGhfYWxpZ24nOg0KPiA+ID4g
ZHJpdmVycy9paW8vYnVmZmVyL2luZHVzdHJpYWxpby1idWZmZXItZG1hZW5naW5lLmM6MTM3OjI0
OiB3YXJuaW5nOiBmb3JtYXQNCj4gPiA+ICcldScgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICd1
bnNpZ25lZCBpbnQnLCBidXQgYXJndW1lbnQgMyBoYXMgdHlwZQ0KPiA+ID4gJ3NpemVfdCB7YWth
IGxvbmcgdW5zaWduZWQgaW50fScgWy1XZm9ybWF0PV0NCj4gICAgICByZXR1cm4gc3ByaW50Zihi
dWYsICIldVxuIiwgZG1hZW5naW5lX2J1ZmZlci0+YWxpZ24pOw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH5eICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICVsdQ0KDQpUaG91Z2ggdGhlIHdhcm5pbmcgbWF5IGJlIHZhbGlkLCBJIGFt
IGJpdCBwdXp6bGVkIGFzIHRvIHdoeSBpdCdzIGNvbXBsYWluaW5nIGZvcg0KdGhpcyBwYXRjaCBz
cGVjaWZpY2FsbHkuDQpUaGlzIHBhdGNoIGRvZXMgbm90IHRvdWNoIHRoZSBmaWxlIGRpcmVjdGx5
Lg0KDQpJJ2xsIHNlbmQgYSBmaXggZm9yIHRoaXMuDQoNCj4gDQo+IHZpbSArMTM3IGRyaXZlcnMv
aWlvL2J1ZmZlci9pbmR1c3RyaWFsaW8tYnVmZmVyLWRtYWVuZ2luZS5jDQo+IA0KPiAyZDZjYTYw
ZjMyODQ1MCBMYXJzLVBldGVyIENsYXVzZW4gMjAxNS0xMC0xMyAgMTI5ICANCj4gNDUzOGMxODU2
ODA5OTYgTGFycy1QZXRlciBDbGF1c2VuIDIwMTktMTItMTEgIDEzMCAgc3RhdGljIHNzaXplX3QN
Cj4gaWlvX2RtYWVuZ2luZV9idWZmZXJfZ2V0X2xlbmd0aF9hbGlnbihzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+IDQ1MzhjMTg1NjgwOTk2IExhcnMtUGV0ZXIgQ2xhdXNlbiAyMDE5LTEyLTExICAxMzEg
IAlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZQ0KPiAqYXR0ciwgY2hhciAqYnVmKQ0KPiA0NTM4YzE4
NTY4MDk5NiBMYXJzLVBldGVyIENsYXVzZW4gMjAxOS0xMi0xMSAgMTMyICB7DQo+IDQ1MzhjMTg1
NjgwOTk2IExhcnMtUGV0ZXIgQ2xhdXNlbiAyMDE5LTEyLTExICAxMzMgIAlzdHJ1Y3QgaWlvX2Rl
dg0KPiAqaW5kaW9fZGV2ID0gZGV2X3RvX2lpb19kZXYoZGV2KTsNCj4gNDUzOGMxODU2ODA5OTYg
TGFycy1QZXRlciBDbGF1c2VuIDIwMTktMTItMTEgIDEzNCAgCXN0cnVjdCBkbWFlbmdpbmVfYnVm
ZmVyDQo+ICpkbWFlbmdpbmVfYnVmZmVyID0NCj4gNDUzOGMxODU2ODA5OTYgTGFycy1QZXRlciBD
bGF1c2VuIDIwMTktMTItMTEgIDEzNSAgCQlpaW9fYnVmZmVyX3RvX2RtDQo+IGFlbmdpbmVfYnVm
ZmVyKGluZGlvX2Rldi0+YnVmZmVyKTsNCj4gNDUzOGMxODU2ODA5OTYgTGFycy1QZXRlciBDbGF1
c2VuIDIwMTktMTItMTEgIDEzNiAgDQo+IDQ1MzhjMTg1NjgwOTk2IExhcnMtUGV0ZXIgQ2xhdXNl
biAyMDE5LTEyLTExIEAxMzcgIAlyZXR1cm4gc3ByaW50ZihidWYsDQo+ICIldVxuIiwgZG1hZW5n
aW5lX2J1ZmZlci0+YWxpZ24pOw0KPiA0NTM4YzE4NTY4MDk5NiBMYXJzLVBldGVyIENsYXVzZW4g
MjAxOS0xMi0xMSAgMTM4ICB9DQo+IDQ1MzhjMTg1NjgwOTk2IExhcnMtUGV0ZXIgQ2xhdXNlbiAy
MDE5LTEyLTExICAxMzkgIA0KPiANCj4gOjo6Ojo6IFRoZSBjb2RlIGF0IGxpbmUgMTM3IHdhcyBm
aXJzdCBpbnRyb2R1Y2VkIGJ5IGNvbW1pdA0KPiA6Ojo6OjogNDUzOGMxODU2ODA5OTZkNzMyOGJl
YWM2MjlkYmRiN2RkM2Y4ZjM0ZSBpaW86IGJ1ZmZlci1kbWFlbmdpbmU6IFJlcG9ydA0KPiBidWZm
ZXIgbGVuZ3RoIHJlcXVpcmVtZW50cw0KPiANCj4gOjo6Ojo6IFRPOiBMYXJzLVBldGVyIENsYXVz
ZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gOjo6Ojo6IENDOiBKb25hdGhhbiBDYW1lcm9uIDxKb25h
dGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IA0KPiAtLS0NCj4gMC1EQVkgQ0kgS2VybmVsIFRl
c3QgU2VydmljZSwgSW50ZWwgQ29ycG9yYXRpb24NCj4gaHR0cHM6Ly9saXN0cy4wMS5vcmcvaHlw
ZXJraXR0eS9saXN0L2tidWlsZC1hbGxAbGlzdHMuMDEub3JnDQo=
