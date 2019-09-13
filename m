Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69AB19C6
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfIMIoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:44:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3828 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387561AbfIMIoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:44:09 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gstC001935;
        Fri, 13 Sep 2019 04:43:38 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfsa3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:43:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxlqmo3rN+3zPV1l/VAKzzuld3OP563upw10kI9+DhjLvgN7LW3NxovmeSTcI/bPp0E+aaSyOwUD4Cfk0YYe21ybGBcAOYFPsywwHs7h4ANTkRSPqZAufwJpgEpc0q+wKzEGu1jjsN3Y28QSxh3Rdv1/kq3fX5mNCFOb7TYv49RJg8iOg0q3Pjy4Kq2QPUB7G/36wm1yuX4ZBFQFa0V0iMpL3Uz2c7m09YkFEbZafRVNlxW71YQwB6b2FeiwYLELvAuFJx6uIroOqtIMi3fzhbbXxYLls56gVK0P1P+wZSE3W2dvOkZFc8LIyYJEtATI6wYlHcdwiDJXBqHqnmE3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2VLtiQYtt6RUUISphyR0TEyJVP4lhzOolF37rCIvJI=;
 b=aNqu6mXm/m0ZruGEgfe2aBbZu79zo6KNlqCoiucgcgB0sylDagSPYtOLnIBBLcVsTeM1IZQSXMdHqrn278MfGcgxDeY9W88BQO8AO4Zk0z/K9Qs0RLbI0oksIbLCGzA5Mh/pcTQEoPNjZlbjzXyp3+8Ph4qQJYvBoUap8zM9h7No5T5leGj5iXzQjdhbW3UjlsiMaT4FBqDC/LuoNXXNEh796Lz6jcTlSYJ/N4uHOT8E33zZQlijM5g9cpmYC1VPHk80bOeclBlRCF0jxBW8N3cdBmSG8FyFfqWL2YQWETgQ+BND+XWvgW9OfH+4Yx5y63PHKw8XG3mkeNGn2RjMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2VLtiQYtt6RUUISphyR0TEyJVP4lhzOolF37rCIvJI=;
 b=4BTONzGMban6KDX05dZUfFyOBnjOszx+1b6d+8IkiV8rwqwDhakrL9Cv4KGcqEmOgphzjPf3QWYuVThhBhapque1hOdtYk6LVMecXK2RDc/DpyBzMg1uQVQyI75VZfwlECozGyRVAI+gR0S5RUpxMBADmKnfIgKfxeEtTKBwKBI=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5157.namprd03.prod.outlook.com (20.180.15.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 13 Sep 2019 08:43:36 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.021; Fri, 13 Sep 2019
 08:43:36 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 3/4] iio: ad7949: fix SPI xfer delays
Thread-Topic: [PATCH 3/4] iio: ad7949: fix SPI xfer delays
Thread-Index: AQHVaXh8OMhRTRFePUqeWEVDuQD0yacpYQwA///lDwCAADflgA==
Date:   Fri, 13 Sep 2019 08:43:36 +0000
Message-ID: <9c5241fbb288992e43bf862a33673bdd6456c0f0.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <20190912144310.7458-4-andrea.merello@gmail.com>
         <794eb574e4bc9cb4f0b2723d72baeb8f63c07283.camel@analog.com>
         <CAN8YU5MBKsFyjbpWw5w41kerQwkOois_AU1OuV6aNX1_3LmSBQ@mail.gmail.com>
In-Reply-To: <CAN8YU5MBKsFyjbpWw5w41kerQwkOois_AU1OuV6aNX1_3LmSBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60668415-bc39-4b4e-1cb6-08d738267792
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5157;
x-ms-traffictypediagnostic: CH2PR03MB5157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5157AABF947003019EA65002F9B30@CH2PR03MB5157.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(26005)(66556008)(6916009)(76176011)(66476007)(53936002)(2906002)(2501003)(54906003)(2351001)(66946007)(7736002)(14454004)(8936002)(4326008)(476003)(102836004)(71190400001)(66066001)(6506007)(11346002)(86362001)(186003)(1361003)(305945005)(99286004)(316002)(71200400001)(81166006)(5640700003)(8676002)(81156014)(25786009)(3846002)(36756003)(5660300002)(14444005)(6116002)(256004)(478600001)(6436002)(6486002)(118296001)(2616005)(446003)(64756008)(6246003)(6512007)(66446008)(76116006)(486006)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5157;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o5+xZakL65xqTAPIrP4nVFlIwp8lfTjCIN8HBJcjxaSWqzvKZcHxm/1IWyKTtuppLp65Ue44ApYvrQmZWzx3NSnaig3/zOrk2PcNYfENNJ9rwMgIItNiA6Gw30QjXMPNviWquNJ1pAVopEUHAEQnbdQiOfN94JgxltKjklUuXmFXq4KIWYCzaMFdj6LHjDPLhCFh+SH/BtvlHbxrgLsZP0cwnwRj/6wY7A3I1b2Ap8Wa4hMwdfPbw4kyiiM77oUwp5bVQ+bxI6NqQ2gWGFYj2cY3a9jvKmoc/VhSK2tPQrdK1rg5iQytMIksz8rNaxM9Ji+LcgUQyRuIZeCuVKHyvH5DBOeZ3eZbzmg1LinFG4+Ok9MyPbmXKgI1VMW4xpSO0jejwsw9T2On+Ok07A1tnOzcDWxDra8d3QcEt2D6Jl0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2F642881EA2C247BF224412B75C1FB2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60668415-bc39-4b4e-1cb6-08d738267792
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 08:43:36.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nl6T4P3xper7e063ddu49xlySwDTYT+sM1SeyIuleJJDWjGa+bi2vSyFngn2co9Tpc2xAof7e5btO444+hRC1UPZBpCt6k7Fs4it1dpb1FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5157
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTEzIGF0IDEwOjIzICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gSWwgZ2lvcm5vIHZlbiAxMyBzZXQgMjAxOSBhbGxlIG9yZSAwOTowMCBBcmRlbGVhbiwgQWxl
eGFuZHJ1DQo+IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4gaGEgc2NyaXR0bzoNCj4g
PiBPbiBUaHUsIDIwMTktMDktMTIgYXQgMTY6NDMgKzAyMDAsIEFuZHJlYSBNZXJlbGxvIHdyb3Rl
Og0KPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gDQo+ID4gPiBUaGUgZHJpdmVyIGNhbGxzIHVkZWxh
eSgyKSBhZnRlciBlYWNoIFNQSSB4ZmVyLiBIb3dldmVyLCBhY2NvcmRpbmcgdG8NCj4gPiA+IHRo
ZSBzcGVjaWZpY2F0aW9ucywgdGhlIFNQSSB0aW1pbmcgc2hvdWxkIGJlIGFzIGZvbGxvd3M6DQo+
ID4gPiANCj4gPiA+IDEtIFRoZSBlbmQgb2YgU1BJIHhmZXIgKENOVi9DUyByaXNpbmcgZWRnZSkg
Y2F1c2VzIHRoZSBkZXZpY2UgdG8gaW5pdGlhdGUNCj4gPiA+ICAgIHRoZSBjb252ZXJzaW9uIHBo
YXNlLCB3aGljaCB0YWtlcyB1cCB0byAyLjJ1Uy4NCj4gPiANCj4gPiBZZXMsIGJ1dCB0aGVyZSBk
b2VzIG5vdCBzZWVtIHRvIGJlIGEgbWluaW11bSB0aW1lIGZvciBjb252ZXJzaW9uLg0KPiA+ICgg
Mi4yIHVTIGlzIHRoZSBtYXggdmFsdWUgKQ0KPiA+IA0KPiA+IFRoaXMgY2FuIGJlIGNvbmZ1c2lu
ZyBhIGJpdCAoSSBrbm93KS4NCj4gPiBJZiB5b3UgZG8gc2VlIGlzc3VlcyB3aXRoIDIgdVMsIHdl
IGNhbiBwcm9iYWJseSB0cnkgMyB1UyAoKzEgdVMgd2hpY2ggaXMgcm91Z2hseSBoYWxmIHRoZSBt
YXggdmFsdWUpLg0KPiA+IFRob3VnaCwgd2UgYXJlIGFscmVhZHkgZ2FpbmluZyBtaW4gMjAwIG5T
IGZyb20gdGhlIGZhY3QgdGhhdCB0aGUgYWNxdWlzaXRpb24gdGltZSBpcyAxLjggdVMgYW5kIHRo
ZSBkZWxheSBpcyAyIHVTLg0KPiA+IA0KPiA+IEJ1dCBpZiB0aGVyZSBhcmVuJ3QgYW55IHZpc2li
bGUgaXNzdWVzLCBJIHdvdWxkIGxlYXZlIDIgdVMuDQo+ID4gSW5jcmVhc2luZyB0aGlzIGRlbGF5
IGNhbiBhbm5veSBwZW9wbGUgdGhhdCB3b3VsZCBsaWtlIHRvIGhhdmUgc29tZSBzcGVlZCB3aGVu
IHJlYWRpbmcgc2FtcGxlcy4NCj4gDQo+IEkgYWRtaXQgdGhhdCBJIGdvdCBzb21lIGhhcmQgdGlt
ZSB0cnlpbmcgdG8gZnVsbHkgdW5kZXJzdGFuZCB0aGUNCj4gdGltaW5nIHNwZWNpZmljYXRpb25z
OyBzbyBpdCdzIHBlcmZlY3RseSBwb3NzaWJsZSB0aGF0IEkndmUgZ290DQo+IHNvbWV0aGluZyB3
cm9uZyBoZXJlLi4gTXkgaW50ZXJwcmV0YXRpb24gd2FzIHRoYXQgdGhlIEhXIHRha2VzIHVwIHRv
DQo+IDIuMnVTICh0aHVzIGl0J3MgYSBtYXggdmFsdWUsIGFzIHlvdSBzYWlkKSBhbmQsIHNpbmNl
IHdlIGFyZSBub3QgdXNpbmcNCj4gdGhlIGJ1c3kgaW5kaWNhdGlvbiB0byBjaGVjayB3aGVuIHRo
ZSBIVyByZWFsbHkgZmluaXNoZWQsIEkgc3RheWVkIG9uDQo+IHRoZSBzYWZlIHNpZGUuDQo+IA0K
PiBJJ3ZlIGRvbmUgdGhpcyBjaGFuZ2Ugd2hpbGUgSSB3YXMgc2VhcmNoaW5nIGZvciB0aGUgY2F1
c2Ugb2Ygc29tZQ0KPiByZWFkaW5nIGlzc3VlcyB0aGF0IHR1cm5lZCBvdXQgdG8gYmUgYWN0dWFs
bHkgZml4ZWQgd2l0aCB0aGUgbGFzdA0KPiBwYXRjaCBvZiB0aGUgc2VyaWVzLCBzbyBJIGhhdmUg
bm8gcmVhbCBldmlkZW5jZSBvZiAgaXNzdWVzIGNhdXNlZCBieQ0KPiB0aGUgMnVTIGRlbGF5LiBI
b3dldmVyLCBpZiBJIHVuZGVyc3Rvb2QgY29ycmVjdGx5IHRoZSBkYXRhc2hlZXQsIHRoZQ0KPiBl
ZmZlY3Qgb2YgcGVyZm9ybWluZyBhbiBlYXJseSBTUEkgeGZlciBkdXJpbmcgdGhlIGNvbnZlcnNp
b24gcGhhc2UgLQ0KPiBzcGVjaWZpY2FsbHkgaWYgaXQgaGFwcGVucyBhZnRlciB0REFUQSBhbmQg
YmVmb3JlIEVuZE9mQ29udmVyc2lvbiAtDQo+IG1pZ2h0IGJlIG1pbGQsIHNvIG5vdCBpdCBtaWdo
dCBiZSBub3Qgb2J2aW91cyB0byBub3RpY2UgKG1heWJlIGFmZmVjdHMNCj4ganVzdCBMU0JzKSBp
dCB3aXRoIG15IGJhc2ljIHRlc3RpbmcuIFF1b3RpbmcgdGhlIGRhdGFzaGVldDogIlRoZSB0aW1l
DQo+IGJldHdlZW4gdERBVEEgYW5kIHRDT05WIGlzIGEgc2FmZSB0aW1lIHdoZW4gZGlnaXRhbCBh
Y3Rpdml0eSBzaG91bGQNCj4gbm90IG9jY3VyLCBvciBzZW5zaXRpdmUgYml0IGRlY2lzaW9ucyBt
YXkgYmUgY29ycnVwdGVkLiAiLi4NCj4gDQo+ID4gSSBrbm93IDEtMiB1UyBpc24ndCBtdWNoIG9m
IGEgcGVyZm9ybWFuY2Uga2lsbGVyLCBidXQgaWYgdGhlcmUgYXJlbid0IHJlYXNvbnMgdG8gY2hh
bmdlIGl0LCBJIHdvdWxkbid0Lg0KPiANCj4gSSBndWVzcyB5b3Uga25vdyB0aGUgSFcgYnkgZmFy
IGJldHRlciB0aGFuIG1lLCBzbyBpZiB5b3Ugc2F5IHRoYXQgMnVTDQo+IGlzIE9LIHRoZW4gSSB3
aWxsIG5vdCBpbnNpc3QgYW55bW9yZSBoZXJlIDopDQoNCldlbGwsIHllcyAmIG5vLg0KVG8gZ2V0
IHRoZSBiZXN0IHBvc3NpYmxlIGFuc3dlciwgd2Ugd291bGQgbmVlZCB0byBhc2sgbW9yZSBkaXJl
Y3RseSB0byB0aGUgYnVzaW5lc3MtdW5pdCB0aGF0IGhhcyByZWxlYXNlZCB0aGUgcGFydCwNCndo
aWNoIGlzIGEgYml0IGRpc2Nvbm5lY3RlZCBmcm9tIHRoZSBncm91cCB0aGF0IHdyaXRlcyAmIHVw
c3RyZWFtcyBMaW51eCBkcml2ZXJzLg0KRGVwZW5kaW5nIG9uIHRoZSBlZmZvcnQgcmVxdWlyZWQg
dG8gZ28gdGhyb3VnaCB0aGlzLCBvciBkZXBlbmRpbmcgaG93IGltcG9ydGFudCB0aGlzIGl0ZW0g
aXMsIHdlIGNhbiBkbyB0aGF0Lg0KDQpCdXQsIGlmIHRlc3Rpbmcgc3VnZ2VzdHMgdGhhdCAyIHVT
IHdvcmtzLCB0aGVuIGl0J3MgYWxzbyBmaW5lIHRvIHVzZSBpdC4NCg0KPiANCj4gPiA+IDItIEF0
IHRoZSBlbmQgb2YgdGhlIGNvbnZlcnNpb24gcGhhc2UsIHRoZSBkZXZpY2Ugc3RhcnRzIHRoZSBh
Y3F1aXNpdGlvbg0KPiA+ID4gICAgcGhhc2UgZm9yIHRoZSBuZXh0IGNvbnZlcnNpb24gYXV0b21h
dGljYWxseSAocmVnYXJkbGVzcyB0byB0aGUgc3RhdGUgb2YNCj4gPiA+ICAgIENOViBwaW4pOyB0
aGUgY29udmVyc2lvbiBwaGFzZSBzaG91bGQgbGFzdCBhdCBsZWFzdCAxLjggdVMNCj4gPiA+IA0K
PiA+ID4gVGhlIHdob2xlIGN5Y2xlIHRpbWluZyBpcyB0aHVzIDR1UyBsb25nLiBUaGUgU1BJIGRh
dGEgaXMgcmVhZCBkdXJpbmcgdGhlDQo+ID4gPiBhY3F1aXNpdGlvbiBwaGFzZSAoUkFDIG1vZGUs
IG5vIG5lZWQgdG8gd29ycnkgYWJvdXQgIlRkYXRhIikuDQo+ID4gPiANCj4gPiA+IEluIG9yZGVy
IHRvIGJlIGNvbXBsaWFudCB3cnQgdGhlc2UgdGltaW5nIHNwZWNpZmljYXRpb25zIHdlIHNob3Vs
ZCB3YWl0DQo+ID4gPiA0dVMgYWZ0ZXIgZWFjaCBTUEkgeGZlciAodGhhdCBpcyBjb25zZXJ2YXRp
dmUsIGJlY2F1c2UgdGhlcmUgaXMgYWxzbyB0aGUNCj4gPiA+IFNQSSB4ZmVyIGR1cmF0aW9uIGl0
c2VsZiAtIHdoaWNoIGF0IHRoZSBtYXhpbXVtIHN1cHBvcnRlZCBjbG9jayBzaG91bGQgYmUNCj4g
PiA+IGFib3V0IDMyMG5TKS4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBlbmxhcmdlcyB0aGUg
ZGVsYXkgdXAgdG8gNHVTIGFuZCBpdCBhbHNvIHJlbW92ZXMgdGhlIGV4cGxpY2l0DQo+ID4gPiBj
YWxscyB0byB1ZGVsYXkoKSwgcmVseWluZyBvbiBzcGlfdHJhbnNmZXItPmRlbGF5X3VzZWNzLg0K
PiA+ID4gDQo+ID4gDQo+ID4gSSBsaWtlIHRoZSBzd2l0Y2ggZnJvbSBleHBsaWNpdCB1ZGVsYXko
KSB0byBzcGlfdHJhbnNmZXItPmRlbGF5X3VzZWNzLg0KPiA+IFRoZSBjb2RlIGxvb2tzIGNsZWFu
ZXIuDQo+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgTWVyZWxsbyA8YW5kcmVhLm1l
cmVsbG9AZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9paW8vYWRjL2FkNzk0
OS5jIHwgMTMgKystLS0tLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL2FkNzk0OS5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jDQo+ID4gPiBpbmRl
eCA1YzJiMzQ0NmZhNGEuLjI1ZDFlMWIyNDI1NyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
aWlvL2FkYy9hZDc5NDkuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jDQo+
ID4gPiBAQCAtNjksNiArNjksNyBAQCBzdGF0aWMgaW50IGFkNzk0OV9zcGlfd3JpdGVfY2ZnKHN0
cnVjdCBhZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMsIHUxNiB2YWwsDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgLnR4X2J1ZiA9ICZhZDc5NDlfYWRjLT5idWZmZXIsDQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgLmxlbiA9IDIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
LmJpdHNfcGVyX3dvcmQgPSBiaXRzX3Blcl93b3JkLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIC5kZWxheV91c2VjcyA9IDQsDQo+ID4gPiAgICAgICAgICAgICAgIH0sDQo+ID4gPiAgICAg
ICB9Ow0KPiA+ID4gDQo+ID4gPiBAQCAtNzcsMTEgKzc4LDYgQEAgc3RhdGljIGludCBhZDc5NDlf
c3BpX3dyaXRlX2NmZyhzdHJ1Y3QgYWQ3OTQ5X2FkY19jaGlwICphZDc5NDlfYWRjLCB1MTYgdmFs
LA0KPiA+ID4gICAgICAgc3BpX21lc3NhZ2VfaW5pdF93aXRoX3RyYW5zZmVycygmbXNnLCB0eCwg
MSk7DQo+ID4gPiAgICAgICByZXQgPSBzcGlfc3luYyhhZDc5NDlfYWRjLT5zcGksICZtc2cpOw0K
PiA+ID4gDQo+ID4gPiAtICAgICAvKg0KPiA+ID4gLSAgICAgICogVGhpcyBkZWxheSBpcyB0byBh
dm9pZCBhIG5ldyByZXF1ZXN0IGJlZm9yZSB0aGUgcmVxdWlyZWQgdGltZSB0bw0KPiA+ID4gLSAg
ICAgICogc2VuZCBhIG5ldyBjb21tYW5kIHRvIHRoZSBkZXZpY2UNCj4gPiA+IC0gICAgICAqLw0K
PiA+ID4gLSAgICAgdWRlbGF5KDIpOw0KPiA+ID4gICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICB9
DQo+ID4gPiANCj4gPiA+IEBAIC05Nyw2ICs5Myw3IEBAIHN0YXRpYyBpbnQgYWQ3OTQ5X3NwaV9y
ZWFkX2NoYW5uZWwoc3RydWN0IGFkNzk0OV9hZGNfY2hpcCAqYWQ3OTQ5X2FkYywgaW50ICp2YWws
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgLnJ4X2J1ZiA9ICZhZDc5NDlfYWRjLT5idWZm
ZXIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgLmxlbiA9IDIsDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgLmJpdHNfcGVyX3dvcmQgPSBiaXRzX3Blcl93b3JkLA0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIC5kZWxheV91c2VjcyA9IDQsDQo+ID4gPiAgICAgICAgICAgICAg
IH0sDQo+ID4gPiAgICAgICB9Ow0KPiA+ID4gDQo+ID4gPiBAQCAtMTEyLDEyICsxMDksNiBAQCBz
dGF0aWMgaW50IGFkNzk0OV9zcGlfcmVhZF9jaGFubmVsKHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAg
KmFkNzk0OV9hZGMsIGludCAqdmFsLA0KPiA+ID4gICAgICAgaWYgKHJldCkNCj4gPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+IA0KPiA+ID4gLSAgICAgLyoNCj4gPiA+IC0gICAg
ICAqIFRoaXMgZGVsYXkgaXMgdG8gYXZvaWQgYSBuZXcgcmVxdWVzdCBiZWZvcmUgdGhlIHJlcXVp
cmVkIHRpbWUgdG8NCj4gPiA+IC0gICAgICAqIHNlbmQgYSBuZXcgY29tbWFuZCB0byB0aGUgZGV2
aWNlDQo+ID4gPiAtICAgICAgKi8NCj4gPiA+IC0gICAgIHVkZWxheSgyKTsNCj4gPiA+IC0NCj4g
PiA+ICAgICAgIGFkNzk0OV9hZGMtPmN1cnJlbnRfY2hhbm5lbCA9IGNoYW5uZWw7DQo+ID4gPiAN
Cj4gPiA+ICAgICAgICp2YWwgPSBhZDc5NDlfYWRjLT5idWZmZXIgJiBtYXNrOw0K
