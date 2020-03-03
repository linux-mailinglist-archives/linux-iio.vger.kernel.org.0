Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1021772C8
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 10:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgCCJoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 04:44:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20522 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbgCCJoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2020 04:44:09 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0239XJWC031743;
        Tue, 3 Mar 2020 04:43:46 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnrahs7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 04:43:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MShXs11qpLI9MG+9dbLgNDcNZRid2mpy7c425AYqHqKEoDKaFhbBpysZC6aqSjjvlKawujnbKd2JboQXJpoPJvTaDkKd74L+xIchpF8wLfdhdyTuNpQCMHgLc+8cd93vCmPrOVbtFBgQCbnWS7lDgC54c1S1gCaVs9VH2xrLHb4cFdj1W6uQceHL88dXuibB9TldAjoANdIb/dVjzCvo6Iv4BRnnWmho6EhaVshC8YhCkh2my81YZFS1Nu9MEo8kA8WuSCo0rQeTB4RYvXfexHKDXy+KT5059eEAK0ja/dS3QNN9A0PA17gh2i+Rrml3CpNdczMlY1X3Hf9xGjWC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XldTf04GjmYkXs6VraqDtSop+1FqifuoE6ysFpXYPt8=;
 b=QVUEIN/aI5+EtbbuLtdvt8LmVVNEFATTNuMHAZfiU8jZMtsRyjfe0JpUCB+mEV/Pgb2KIcXXFdskAGpwN+VpGXQAGXrxVtXRq2gA9f00iuqVoBZrfe/QC9WduWhFHIVmEvJeloAgzZLMXrcjLy7AZ6WhS1pbG551oWDVBdQh0dndLFUqNB40/2AdrIVJy5nj8bC++kUL5Ke9mepkMN4hPsnJzgCldIMPqZTA+ApTgQI3P6z4GzNBCcVDOa/U3rHs/UuEzvXBg7B6c1kISudcJmIc3Na0ekDUfRmbOw7kcUBmf+MNbLtuqCG9fF0pP+erjwmB3yE5CgFpofyLVyzKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XldTf04GjmYkXs6VraqDtSop+1FqifuoE6ysFpXYPt8=;
 b=D1RT81CGwBF8YiSw0dMYdj2uyuWX6KMe0NWaJ+9WDqGivqTMrO2jNHdXeo7kkvMUhgT4/yGf3upGb9p+1aj99ns4/AfIzLaVtWjBYxlWLoSgj36nLNKNkoPMtylqlT6tq7+Dc2XnCxmQtDkdrlbltgzhkviU/EoqqVsbegWRkaQ=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3316.namprd03.prod.outlook.com (2603:10b6:405:42::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Tue, 3 Mar
 2020 09:43:44 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::80b6:bfbd:9b6d:710a%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 09:43:44 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Topic: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Thread-Index: AQHV69jpKCRYfnfL+0eh49A+u9WwfKg16ooAgAC+fAA=
Date:   Tue, 3 Mar 2020 09:43:44 +0000
Message-ID: <1054e87af61518d73dfcb0995e7aab7484e81630.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
         <20200225124152.270914-6-nuno.sa@analog.com> <20200302222254.GA27619@bogus>
In-Reply-To: <20200302222254.GA27619@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f2dd79f-f238-4683-6cec-08d7bf575d4c
x-ms-traffictypediagnostic: BN6PR03MB3316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB3316CA563525196EA246D21599E40@BN6PR03MB3316.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(366004)(396003)(199004)(189003)(66446008)(71200400001)(36756003)(66476007)(76116006)(66556008)(64756008)(54906003)(6506007)(66946007)(6512007)(2616005)(5660300002)(107886003)(6486002)(8676002)(966005)(186003)(4326008)(26005)(478600001)(8936002)(81156014)(2906002)(81166006)(316002)(6916009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3316;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BuJ8J4fwoF7JEm4p94gOTzgaNOV4UERjNFx6YRAaj9Ui3g9fqcxSAv7TOKc4Q9Ri29QFEErFbL0FtGCpSgZ3Dl3iKFRgcAy6QAERZqdbthJysdOZodq2GCQSqAyiW7ke5D3/zcE6hRiowqzBCNNHNX/byAeDvsF2dYggdHMmul36ZdQ5seh9l6d1Ja1j4sgAdIzryxHAU11+p3H+BcXCKmqSmlq9u3kNnZMndFZ7msz4pgkS1a/ERIPyNmpxqbiuc53/HyJVRU/krrylZb0ckd7DvW2pKxfG3KBeE+/p631t+Cr0H8WcNzWwmbvA+er6VLfMPbXvuBhxR12XDp/mKLWkwxe/XZKVrtpyVy9RIyIX0yA6HTxP18MhjFCL3EXIpChqMoA4dlk2LlCxQ0fsJHcvJHAxg0Vjk2nHJfYy4Yo8N+D3XLpU4I7VwDUh3Em8u3oHCaSVQ5+Ko5PxnNMTkjQgr9/v5Xjhp6dpvD1tFXxBlaR5GR6KFugwa8fcPdJ
x-ms-exchange-antispam-messagedata: MfSy+uxBpBRcNsFPFa+Ru3xbo6d1j/PxmQhIiLWSdrboSgz4b3N31AGSITtU16JEhJ3EmWbfgxozNvk5VuC5fyJI5RT9GujacpPGSlLi0hIJyyZIsa1JFXJZBdNgKons+wfiSmXr+JxZVE7tIU6lwA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8E4092DA03DD84F989C74680A0D6470@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2dd79f-f238-4683-6cec-08d7bf575d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 09:43:44.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FJfFTmiedOwEfRvRt2i4qqSM17nRP9pEgYsy/fIUg5hpoT0d3y9TBPfygmJpjhk7hX459aNS8+8MDKZR9I0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3316
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_02:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDE2OjIyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBGZWIgMjUsIDIwMjAgYXQgMDE6NDE6NTJQTSArMDEwMCwgTnVubyBTw6Egd3JvdGU6
DQo+ID4gRG9jdW1lbnQgdGhlIEFESVMxNjQ3NSBkZXZpY2UgZGV2aWNldHJlZSBiaW5kaW5ncy4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0K
PiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvaWlvL2ltdS9hZGksYWRpczE2NDc1LnlhbWwgICAg
ICAgfCAxMzANCj4gPiArKysrKysrKysrKysrKysrKysNCj4gPiAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMzEgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9hZGksYWRpczE2NDc1LnlhbWwNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL2ltdS9hZGksYWRpczE2NDc1LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbA0KPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5jMGYyMTQ2ZTAwMGMNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9pbXUvYWRpLGFkaXMxNjQ3NS55YW1sDQo+ID4gQEAgLTAsMCArMSwxMzAgQEANCj4gPiArIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+
ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRs
ZTogQW5hbG9nIERldmljZXMgQURJUzE2NDc1IGFuZCBzaW1pbGFyIElNVXMNCj4gPiArDQo+ID4g
K21haW50YWluZXJzOg0KPiA+ICsgIC0gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4g
PiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgQW5hbG9nIERldmljZXMgQURJUzE2NDc1
IGFuZCBzaW1pbGFyIElNVXMNCj4gPiArICANCj4gPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21l
ZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hlZXRzL0FESVMxNjQ3NS5wZGYN
Cj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVu
dW06DQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ3NS0xDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMx
NjQ3NS0yDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ3NS0zDQo+ID4gKyAgICAgIC0gYWRpLGFk
aXMxNjQ3Ny0xDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ3Ny0yDQo+ID4gKyAgICAgIC0gYWRp
LGFkaXMxNjQ3Ny0zDQo+ID4gKyAgICAgIC0gYWRpLGFkaXMxNjQ3MA0KPiA+ICsgICAgICAtIGFk
aSxhZGlzMTY0NjUtMQ0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NjUtMg0KPiA+ICsgICAgICAt
IGFkaSxhZGlzMTY0NjUtMw0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NjctMQ0KPiA+ICsgICAg
ICAtIGFkaSxhZGlzMTY0NjctMg0KPiA+ICsgICAgICAtIGFkaSxhZGlzMTY0NjctMw0KPiA+ICsg
ICAgICAtIGFkaSxhZGlzMTY1MDANCj4gPiArICAgICAgLSBhZGksYWRpczE2NTA1LTENCj4gPiAr
ICAgICAgLSBhZGksYWRpczE2NTA1LTINCj4gPiArICAgICAgLSBhZGksYWRpczE2NTA1LTMNCj4g
PiArICAgICAgLSBhZGksYWRpczE2NTA3LTENCj4gPiArICAgICAgLSBhZGksYWRpczE2NTA3LTIN
Cj4gPiArICAgICAgLSBhZGksYWRpczE2NTA3LTMNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgc3BpLWNwaGE6IHRydWUNCj4gPiArDQo+ID4g
KyAgc3BpLWNwb2w6IHRydWUNCj4gPiArDQo+ID4gKyAgc3BpLW1heC1mcmVxdWVuY3k6DQo+ID4g
KyAgICBtYXhpbXVtOiAyMDAwMDAwDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtYXhJdGVtczog
MQ0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIG9uZU9mOg0KPiA+ICsgICAg
ICAtIGNvbnN0OiBzeW5jDQo+ID4gKyAgICAgIC0gY29uc3Q6IGRpcmVjdC1zeW5jDQo+ID4gKyAg
ICAgIC0gY29uc3Q6IHB1bHNlLXN5bmMNCj4gPiArICAgICAgLSBjb25zdDogc2NhbGVkLXN5bmMN
Cj4gDQo+IEFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0IEkgbG9va2VkIGF0LCB0aGUgaW5wdXQg
aXMgY2FsbGVkICdzeW5jJy4NCj4gSXQgDQo+IGxvb2tzIGxpa2UgeW91IGFyZSBtaXhpbmcgb3Bl
cmF0aW5nIG1vZGUgYW5kIGNsb2NrIGNvbm5lY3Rpb24uDQoNClRoZSBzeW5jIHBpbiBpcyB3aGVy
ZSB0aGUgZXh0ZXJuYWwgY2xvY2sgc2hvdWxkIGJlIGNvbm5lY3RlZCAod2hlbg0KYXZhaWxhYmxl
KS4gSSdtIGtpbmRhIG9mIHVzaW5nIHRoZSBjbG9jay1uYW1lIHByb3BlcnR5IGFzIGEgd2F5IG9m
DQpzZWxlY3RpbmcgdGhlIG1vZGUgdGhlIHVzZXIgd2FudHMgdG8gdXNlIGFzIGRvbmUgaW4gb3Ro
ZXIgZGV2aWNlcyAoDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaWlvL2ltdS9hZGksYWRpczE2NDgwLnR4dA0KKS4gSW4gdGhlIGVuZCwgd2hhdCB3ZSBz
aG91bGQgaGF2ZSBpbiB0aGUgc3luYyBwaW4gaXMgYW4gZXh0ZXJuYWwgY2xvY2sNCndpdGggdGhl
IGV4Y2VwdGlvbiBvZiB0aGUgYHN5bmNgIG1vZGUuIEkgZ3Vlc3MgdGhpcyBvbmUgY291bGQgYmUg
Y2FsbGVkDQpvdXRwdXQtc3luYyBhbmQsIGluIHRoaXMgY2FzZSwgdGhlIHN5bmMgcGluIGlzIGFj
dHVhbGx5IGFuIG91dHB1dCBwaW4NCnB1bHNpbmcgd2hlbiB0aGUgaW50ZXJuYWwgcHJvY2Vzc29y
IGNvbGxlY3RzIGRhdGEuDQoNCkknbSBvayBpbiBjaGFuZ2luZyBpdCBpZiB0aGVyZSdzIGEgYmV0
dGVyIHdheSBvZiBkb2luZyBpdC4uLiBEbyB5b3UNCmhhdmUgYW55IHN1Z2dlc3Rpb24/DQoNCi1O
dW5vIFPDoQ0KPiA+ICsNCj4gPiArICByZXNldC1ncGlvczoNCj4gPiArICAgIGRlc2NyaXB0aW9u
Og0KPiA+ICsgICAgICBNdXN0IGJlIHRoZSBkZXZpY2UgdHJlZSBpZGVudGlmaWVyIG9mIHRoZSBS
RVNFVCBwaW4uIElmDQo+ID4gc3BlY2lmaWVkLA0KPiA+ICsgICAgICBpdCB3aWxsIGJlIGFzc2Vy
dGVkIGR1cmluZyBkcml2ZXIgcHJvYmUuIEFzIHRoZSBsaW5lIGlzDQo+ID4gYWN0aXZlIGxvdywN
Cj4gPiArICAgICAgaXQgc2hvdWxkIGJlIG1hcmtlZCBHUElPX0FDVElWRV9MT1cuDQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBhZGksc2NhbGVkLW91dHB1dC1oejoNCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGlzIHByb3BlcnR5IG11c3QgYmUgcHJlc2Vu
dCBpZiB0aGUgY2xvY2sgbW9kZSBpcyBzY2FsZWQtDQo+ID4gc3luYyB0aHJvdWdoDQo+ID4gKyAg
ICAgIGNsb2NrLW5hbWVzIHByb3BlcnR5LiBJbiB0aGlzIG1vZGUsIHRoZSBpbnB1dCBjbG9jayBj
YW4gaGF2ZQ0KPiA+IGEgcmFuZ2UNCj4gPiArICAgICAgb2YgMUh6IHRvIDEyOEhaIHdoaWNoIG11
c3QgYmUgc2NhbGVkIHRvIG9yaWdpbmF0ZSBhbg0KPiA+IGFsbG93YWJsZSBzYW1wbGUNCj4gPiAr
ICAgICAgcmF0ZS4gVGhpcyBwcm9wZXJ0eSBzcGVjaWZpZXMgdGhhdCByYXRlLg0KPiA+ICsgICAg
bWluaW11bTogMTkwMA0KPiA+ICsgICAgbWF4aW11bTogMjEwMA0KPiA+ICsNCj4gPiArcmVxdWly
ZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGludGVycnVw
dHMNCj4gPiArICAtIHNwaS1jcGhhDQo+ID4gKyAgLSBzcGktY3BvbA0KPiA+ICsNCj4gPiAraWY6
DQo+ID4gKyAgcHJvcGVydGllczoNCj4gPiArICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgIGNv
bnRhaW5zOg0KPiA+ICsgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAtIGFkaSxhZGlzMTY1
MDANCj4gPiArICAgICAgICAgIC0gYWRpLGFkaXMxNjUwNS0xDQo+ID4gKyAgICAgICAgICAtIGFk
aSxhZGlzMTY1MDUtMg0KPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA1LTMNCj4gPiArICAg
ICAgICAgIC0gYWRpLGFkaXMxNjUwNy0xDQo+ID4gKyAgICAgICAgICAtIGFkaSxhZGlzMTY1MDct
Mg0KPiA+ICsgICAgICAgICAgLSBhZGksYWRpczE2NTA3LTMNCj4gPiArDQo+ID4gK3RoZW46DQo+
ID4gKyAgcHJvcGVydGllczoNCj4gPiArICAgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgICBvbmVP
ZjoNCj4gPiArICAgICAgICAtIGNvbnN0OiBzeW5jDQo+ID4gKyAgICAgICAgLSBjb25zdDogZGly
ZWN0LXN5bmMNCj4gPiArICAgICAgICAtIGNvbnN0OiBzY2FsZWQtc3luYw0KPiA+ICsNCj4gPiAr
ICAgIGFkaSxidXJzdDMyLWVuYWJsZToNCj4gPiArICAgICAgZGVzY3JpcHRpb246DQo+ID4gKyAg
ICAgICAgRW5hYmxlIGJ1cnN0MzIgbW9kZS4gSW4gdGhpcyBtb2RlLCBhIGJ1cnN0IHJlYWRpbmcN
Cj4gPiBjb250YWlucyBjYWxpYnJhdGVkDQo+ID4gKyAgICAgICAgZ3lyb3Njb3BlIGFuZCBhY2Nl
bGVyb21ldGVyIGRhdGEgaW4gMzItYml0IGZvcm1hdC4NCj4gPiArICAgICAgdHlwZTogYm9vbGVh
bg0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKyAgICBzcGkgew0K
PiA+ICsgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAg
I3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICBhZGlzMTY0NzU6IGFk
aXMxNjQ3NS0zQDAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRp
LGFkaXMxNjQ3NS0zIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgc3BpLWNwaGE7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
c3BpLWNwb2w7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8
MjAwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDw0IElSUV9U
WVBFX0VER0VfUklTSU5HPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZncGlvPjsNCj4gPiArICAgICAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gKy4u
Lg0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+ID4gaW5kZXgg
ZjExMjYyZjFmM2JiLi5mOGNjYzkyYWIzNzggMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMN
Cj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0xMDE1LDYgKzEwMTUsNyBAQCBXOgkNCj4g
PiBodHRwOi8vZXouYW5hbG9nLmNvbS9jb21tdW5pdHkvbGludXgtZGV2aWNlLWRyaXZlcnMNCj4g
PiAgUzoJU3VwcG9ydGVkDQo+ID4gIEY6CWRyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiA+
ICBGOglEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8taW11LWFkaXMxNjQ3
NQ0KPiA+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2ltdS9hZGks
YWRpczE2NDc1LnlhbWwNCj4gPiAgDQo+ID4gIEFOQUxPRyBERVZJQ0VTIElOQyBBRE0xMTc3IERS
SVZFUg0KPiA+ICBNOglCZW5pYW1pbiBCaWEgPGJlbmlhbWluLmJpYUBhbmFsb2cuY29tPg0KPiA+
IC0tIA0KPiA+IDIuMjUuMQ0K
