Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC303172D3
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 09:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfEHHuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 03:50:16 -0400
Received: from mail-eopbgr700052.outbound.protection.outlook.com ([40.107.70.52]:21440
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbfEHHuP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 May 2019 03:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oq0gIqipBZriyxeQpa6NYSmnWoyGHaohhxiL2LPJlo=;
 b=XP1A4RIZbLyjzrbsjxhl+XDRPDmFLVn5jxtaRg5fXAbrS0/GXoCkMyUZpMMzpfOJ+eeTGtdl5hHNTUZr/DKtcidyE6MiOPOmH6KLsXPCZqzTGBkFGotCDCAGSkIcehq7cpJ2mZ6UBL4CN1Uj0vOAojNmxEST2IRNLtHpyHBtvKk=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by BN3PR03MB2257.namprd03.prod.outlook.com (2a01:111:e400:c5f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Wed, 8 May
 2019 07:50:10 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11 via Frontend
 Transport; Wed, 8 May 2019 07:50:10 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 07:50:09 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x487o8fq011479
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 8 May 2019 00:50:08 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Wed, 8 May 2019 03:50:08 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "melissa.srw@gmail.com" <melissa.srw@gmail.com>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Subject: Re: [PATCH 2/4] staging: iio: ad7150: use FIELD_GET and GENMASK
Thread-Topic: [PATCH 2/4] staging: iio: ad7150: use FIELD_GET and GENMASK
Thread-Index: AQHVAmZEuvjZKalljUODTfy22uS+XaZd7oYAgAJ7MACAALnZAA==
Date:   Wed, 8 May 2019 07:50:07 +0000
Message-ID: <1220395cfe158e2116a1f2826ef6ce96074463b4.camel@analog.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
         <7f7d36348bca1de25bd70350b7c665be6441250f.1556919363.git.melissa.srw@gmail.com>
         <CA+U=Dso6zSLzhhdiZcc+P4-2zcabxnoMd2539HmofTXrtYoKDQ@mail.gmail.com>
         <179d019c34cc69e50f19499a6089ac94740b59f5.camel@analog.com>
         <20190507204456.wwjjkeuzq44jy7w7@smtp.gmail.com>
In-Reply-To: <20190507204456.wwjjkeuzq44jy7w7@smtp.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA9E8C580B32C428CCE2C9F93B26605@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(356004)(4326008)(107886003)(102836004)(446003)(53546011)(436003)(426003)(2351001)(70206006)(478600001)(11346002)(7636002)(7736002)(8936002)(36756003)(23676004)(76176011)(7696005)(2486003)(8676002)(6246003)(246002)(54906003)(118296001)(2501003)(316002)(5640700003)(5660300002)(1361003)(106002)(186003)(26005)(229853002)(7416002)(6116002)(3846002)(336012)(70586007)(47776003)(14444005)(6916009)(14454004)(50466002)(486006)(476003)(126002)(305945005)(2616005)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2257;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f487d0-abb9-47c0-cbaa-08d6d389cbc9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BN3PR03MB2257;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2257:
X-Microsoft-Antispam-PRVS: <BN3PR03MB22579CF8F287B7D6E1C1DFEBF9320@BN3PR03MB2257.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9S1Sp473BbNxU36JLnFOdZijNZ/dlQkbaJIFPnCx+1V46yoLCZEr9Jb+DmHSOXfkPiEF9+OZSz08tbFw90E8o8MALbl4M2c++/mrbODEDFNob2e4VyVg55rmkzknSKd+8823rOoHCNz/5yE0FS9SA/3W6WnQOpTyW4y41jSLuvb/PcXISgFqxLNPYrQITz2bszV1DBi1X/QmyaOeR4brwWdrC94iF0zptwAc6tncwZquTVdbZI72UJafNPkIxmkFy1tbTYsYTHohLwz0RDcxoPtrqJOxZFyTeUhloSrTTIl04JZdDlxL+mRTsxc89bAWleYMOfPPh17X70jYqZv9FY7v3Up/UUDmfU6OCtI6hkJVJ0sT5YLPILNzdwnHEX6O+DA8l6jwc8w/56yJCGZKoI9fouiYdB0EsLHA0jz45Rk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 07:50:09.5283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f487d0-abb9-47c0-cbaa-08d6d389cbc9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2257
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTA3IGF0IDE3OjQ0IC0wMzAwLCBNZWxpc3NhIFdlbiB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCj4gDQo+IE9uIDA1LzA2LCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3Rl
Og0KPiA+IE9uIFNhdCwgMjAxOS0wNS0wNCBhdCAxMzo0MyArMDMwMCwgQWxleGFuZHJ1IEFyZGVs
ZWFuIHdyb3RlOg0KPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIFNh
dCwgTWF5IDQsIDIwMTkgYXQgMToyNSBBTSBNZWxpc3NhIFdlbiA8bWVsaXNzYS5zcndAZ21haWwu
Y29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBVc2UgdGhlIGJpdGZpZWxkIG1h
Y3JvIEZJRUxEX0dFVCwgYW5kIEdFTk1BU0sgdG8gZG8gdGhlIHNoaWZ0IGFuZA0KPiA+ID4gPiBt
YXNrDQo+ID4gPiA+IGluDQo+ID4gPiA+IG9uZSBnby4gVGhpcyBtYWtlcyB0aGUgY29kZSBtb3Jl
IHJlYWRhYmxlIHRoYW4gZXhwbGljaXQgbWFza2luZw0KPiA+ID4gPiBmb2xsb3dlZA0KPiA+ID4g
PiBieSBhIHNoaWZ0Lg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhpcyBsb29rcyBuZWF0Lg0K
PiA+ID4gSSdkIGhhdmUgdG8gcmVtZW1iZXIgdG8gYWNrIGl0IGZyb20gbXkgd29yayBlbWFpbC4N
Cj4gPiANCj4gPiBBY2tlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4NCj4gPiANCj4gPiA+IA0KPiA+ID4gT25lIG1pbm9yIGNvbW1lbnQgaW5s
aW5lLCB3aGljaCB3b3VsZCBiZSB0aGUgb2JqZWN0IG9mIGEgbmV3IHBhdGNoLg0KPiA+ID4gDQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1lbGlzc2EgV2VuIDxtZWxpc3NhLnNyd0BnbWFpbC5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9zdGFnaW5nL2lpby9jZGMvYWQ3MTUwLmMg
fCA2ICsrKysrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2lu
Zy9paW8vY2RjL2FkNzE1MC5jDQo+ID4gPiA+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9jZGMvYWQ3
MTUwLmMNCj4gPiA+ID4gaW5kZXggMjQ2MDFiYTdkYjg4Li40YmE0NmZiNmFjMDIgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vY2RjL2FkNzE1MC5jDQo+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vY2RjL2FkNzE1MC5jDQo+ID4gPiA+IEBAIC01LDYgKzUs
NyBAQA0KPiA+ID4gPiAgICogQ29weXJpZ2h0IDIwMTAtMjAxMSBBbmFsb2cgRGV2aWNlcyBJbmMu
DQo+ID4gPiA+ICAgKi8NCj4gPiA+ID4gDQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvYml0Zmll
bGQuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiA+ID4gICNp
bmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCj4gPiA+ID4gQEAgLTQ0LDYgKzQ1LDkgQEANCj4gPiA+ID4gICNkZWZpbmUgQUQ3MTUwX1NO
MF9SRUcgICAgICAgICAgICAgICAgICAgICAgICAgMHgxNg0KPiA+ID4gPiAgI2RlZmluZSBBRDcx
NTBfSURfUkVHICAgICAgICAgICAgICAgICAgICAgICAgICAweDE3DQo+ID4gPiA+IA0KPiA+ID4g
PiArLyogQUQ3MTUwIG1hc2tzICovDQo+ID4gPiA+ICsjZGVmaW5lIEFENzE1MF9USFJFU0hUWVBF
X01TSyAgICAgICAgICAgICAgICAgIEdFTk1BU0soNiwgNSkNCj4gPiA+ID4gKw0KPiA+ID4gPiAg
LyoqDQo+ID4gPiA+ICAgKiBzdHJ1Y3QgYWQ3MTUwX2NoaXBfaW5mbyAtIGluc3RhbmNlIHNwZWNp
ZmljIGNoaXAgZGF0YQ0KPiA+ID4gPiAgICogQGNsaWVudDogaTJjIGNsaWVudCBmb3IgdGhpcyBk
ZXZpY2UNCj4gPiA+ID4gQEAgLTEzNiw3ICsxNDAsNyBAQCBzdGF0aWMgaW50IGFkNzE1MF9yZWFk
X2V2ZW50X2NvbmZpZyhzdHJ1Y3QNCj4gPiA+ID4gaWlvX2Rldg0KPiA+ID4gPiAqaW5kaW9fZGV2
LA0KPiA+ID4gPiAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPiA+ID4gDQo+ID4gPiA+IC0gICAgICAgdGhyZXNodHlwZSA9IChyZXQg
Pj4gNSkgJiAweDAzOw0KPiA+ID4gPiArICAgICAgIHRocmVzaHR5cGUgPSBGSUVMRF9HRVQoQUQ3
MTUwX1RIUkVTSFRZUEVfTVNLLCByZXQpOw0KPiA+ID4gPiAgICAgICAgIGFkYXB0aXZlID0gISEo
cmV0ICYgMHg4MCk7DQo+ID4gPiANCj4gPiA+IFdoeSBub3QgYWxzbyBkbyBzb21ldGhpbmcgc2lt
aWxhciBmb3IgdGhlIGBhZGFwdGl2ZWAgdmFsdWUgPw0KPiANCj4gSGkgQWxleGFuZHJ1LA0KPiAN
Cj4gWWVzLCBJJ20gd29ya2luZyBvbiBpdCEgIEhvd2V2ZXIsIHRha2luZyBhIGxvb2sgYXQgdGhl
IGRyaXZlciBkYXRhc2hlZXQNCj4gKFRhYmxlDQo+IDEzLCBwYWdlIDE5KSwgdGhlcmUgc2VlbXMg
dG8gYmUgYSBsaXR0bGUgbWlzdGFrZSBpbiBjaG9vc2luZyB0aGUgdmFyaWFibGUNCj4gbmFtZQ0K
PiBhbmQgaXRzIG1lYW5pbmcsICBzaW5jZSB3aGVuIGJpdCg3KSBpcyAxICh0cnVlKSB0aGUgdGhy
ZXNob2xkIGlzIGZpeGVkLA0KPiBhbmQgbm90DQo+IGFkYXB0aXZlLiBGb3IgdGhpcyByZWFzb24s
IEkgcmVtb3ZlZCBpdCBmcm9tIHRoaXMgcGF0Y2hzZXQgdG8gbWF0dXJlIHRoZQ0KPiBzb2x1dGlv
bi4gSSB3aWxsIHNlbmQgaXQgYXMgYSBidWcgZml4IGlmIEkgcHJvdmUgaXQncyBuZWNlc3Nhcnku
DQo+IERvIHlvdSBoYXZlIGFueSBhZHZpY2Ugb3IgZmVlbGluZyBhYm91dCBpdCB0byBzaGFyZT8N
Cj4gDQoNCkdvb2QgZmluZC4NClNpbmNlIHRoaXMgaXMgYSBidWctZml4LCB0eXBpY2FsbHkgaXQn
cyBnb29kIHRvIGZpeCB0aGUgY29kZSBhcy1pcyBub3cNCltldmVuIGlmIGl0IGlzbid0IG5lYXQg
Y29kZV0sIGFuZCB0aGVuIGRvIHRoZSBjb252ZXJzaW9ucyB0byBuZWF0IGNvZGUuDQoNCkJ1Zy1m
aXhlcyBhbHdheXMgdGFrZSBwcmlvcml0eSBvdmVyIGNvc21ldGljIGNoYW5nZXMuDQpTbywgSSB3
b3VsZCBzZW5kIHRoZSBidWctZml4IGFzLXNvb24tYXMtcG9zc2libGUsIGFuZCB0aGVuIHVwZGF0
ZSB0aGluZ3MuDQoNCg0KPiBQLnMuOiBTb3JyeSBmb3IgaGF2aW5nIHByZXZpb3VzbHkgc2VudCBh
biBlbWFpbCB3aXRoIEhUTUwuDQo+IA0KPiBNZWxpc3NhDQo+IA0KPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiAgICAgICAgIHN3aXRjaCAodHlwZSkgew0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjIw
LjENCj4gPiA+ID4gDQo=
