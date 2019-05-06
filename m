Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB241449A
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfEFGvi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 02:51:38 -0400
Received: from mail-eopbgr710056.outbound.protection.outlook.com ([40.107.71.56]:39136
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfEFGvi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 May 2019 02:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZlUxmHAnTfV4fvuRR07OAFwnrB0KNHVpt968yquJ20=;
 b=rv+1FVnApWblORq9qEh+/0QewDuvpmPpEXu2DbGD3JkryITdtvlfILh2Ecwgg4lIVjuVXmcbpE1yPyGhg02bI09ZaDUZilUoWkgUGSLX8kJ3A8+WFh5ILyLl7oUkqdmfIVO7MMQ0BzYAvwgIVWGMcCh4u4vsr0xP070VD//L3OI=
Received: from CY4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:903:33::27)
 by DM2PR03MB560.namprd03.prod.outlook.com (2a01:111:e400:241c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.10; Mon, 6 May
 2019 06:51:34 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR03CA0017.outlook.office365.com
 (2603:10b6:903:33::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Mon, 6 May 2019 06:51:33 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Mon, 6 May 2019 06:51:33 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x466pWBL021375
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 5 May 2019 23:51:32 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 6 May 2019 02:51:31 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "melissa.srw@gmail.com" <melissa.srw@gmail.com>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] staging: iio: ad7150: use FIELD_GET and GENMASK
Thread-Topic: [PATCH 2/4] staging: iio: ad7150: use FIELD_GET and GENMASK
Thread-Index: AQHVAmZEuvjZKalljUODTfy22uS+XaZd7oYA
Date:   Mon, 6 May 2019 06:51:31 +0000
Message-ID: <179d019c34cc69e50f19499a6089ac94740b59f5.camel@analog.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
         <7f7d36348bca1de25bd70350b7c665be6441250f.1556919363.git.melissa.srw@gmail.com>
         <CA+U=Dso6zSLzhhdiZcc+P4-2zcabxnoMd2539HmofTXrtYoKDQ@mail.gmail.com>
In-Reply-To: <CA+U=Dso6zSLzhhdiZcc+P4-2zcabxnoMd2539HmofTXrtYoKDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C855B05558C3C478658EC39E2C73FC4@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(199004)(189003)(36756003)(356004)(76176011)(23676004)(2486003)(14444005)(118296001)(106002)(70586007)(70206006)(8676002)(5660300002)(246002)(8936002)(7736002)(7636002)(305945005)(47776003)(14454004)(102836004)(6246003)(50466002)(186003)(2501003)(4326008)(6116002)(3846002)(53546011)(26005)(229853002)(7416002)(2616005)(316002)(478600001)(126002)(476003)(486006)(7696005)(54906003)(110136005)(11346002)(2906002)(436003)(426003)(446003)(86362001)(336012)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB560;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b786019d-19f4-465b-2d24-08d6d1ef46e1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:DM2PR03MB560;
X-MS-TrafficTypeDiagnostic: DM2PR03MB560:
X-Microsoft-Antispam-PRVS: <DM2PR03MB5602EA77DCBE1E8CF87360AF9300@DM2PR03MB560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0029F17A3F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: A/Vl/Kdfww9B6FU2TsYUhDJU6FUUNIgWED+x9YrpBZja/88Xava3MSy5fGgSD625//ETTNjSeiB1UGl8CDmtdsVELppmxA63+zSkUZHMtR7eiAXwt0OcS4Yl0aFcHy9n4UkQxguYTwsHxYpiYsKH9gOiUF3OgbAXXpcYrNOn3AW/rZLbjmvYF5vfttORqSKUUPe3D2JW9oplSjHwNSGhrfG/BGd61EXaDVRv2Jmd3Bx2yK7ijEoF0/+6OsMwugHKb6zu1gWRbONinrNXMjZsoXGmdgzJlkHBfbwbeIm08iJQQqol3B54l4pgPV8/IlwIl+vsNMSReyu5qt1zDegukvyMQhTjqJ5uW0Yx4dMh3Rzdjch7KSh41tiRqx5tqG3Oe3M7HaK3c/l6hZfDhlLUgZ71rupmj4ko1G9iME1TFeI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2019 06:51:33.1271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b786019d-19f4-465b-2d24-08d6d1ef46e1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB560
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA1LTA0IGF0IDEzOjQzICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBTYXQsIE1heSA0LCAyMDE5IGF0IDE6MjUg
QU0gTWVsaXNzYSBXZW4gPG1lbGlzc2Euc3J3QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4g
VXNlIHRoZSBiaXRmaWVsZCBtYWNybyBGSUVMRF9HRVQsIGFuZCBHRU5NQVNLIHRvIGRvIHRoZSBz
aGlmdCBhbmQgbWFzaw0KPiA+IGluDQo+ID4gb25lIGdvLiBUaGlzIG1ha2VzIHRoZSBjb2RlIG1v
cmUgcmVhZGFibGUgdGhhbiBleHBsaWNpdCBtYXNraW5nDQo+ID4gZm9sbG93ZWQNCj4gPiBieSBh
IHNoaWZ0Lg0KPiA+IA0KPiANCj4gVGhpcyBsb29rcyBuZWF0Lg0KPiBJJ2QgaGF2ZSB0byByZW1l
bWJlciB0byBhY2sgaXQgZnJvbSBteSB3b3JrIGVtYWlsLg0KDQpBY2tlZC1ieTogQWxleGFuZHJ1
IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiANCj4gT25lIG1p
bm9yIGNvbW1lbnQgaW5saW5lLCB3aGljaCB3b3VsZCBiZSB0aGUgb2JqZWN0IG9mIGEgbmV3IHBh
dGNoLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNZWxpc3NhIFdlbiA8bWVsaXNzYS5zcndAZ21h
aWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2NkYy9hZDcxNTAuYyB8
IDYgKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9jZGMvYWQ3
MTUwLmMNCj4gPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vY2RjL2FkNzE1MC5jDQo+ID4gaW5kZXgg
MjQ2MDFiYTdkYjg4Li40YmE0NmZiNmFjMDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zdGFn
aW5nL2lpby9jZGMvYWQ3MTUwLmMNCj4gPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2NkYy9h
ZDcxNTAuYw0KPiA+IEBAIC01LDYgKzUsNyBAQA0KPiA+ICAgKiBDb3B5cmlnaHQgMjAxMC0yMDEx
IEFuYWxvZyBEZXZpY2VzIEluYy4NCj4gPiAgICovDQo+ID4gDQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9iaXRmaWVsZC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ID4gICNp
bmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0K
PiA+IEBAIC00NCw2ICs0NSw5IEBADQo+ID4gICNkZWZpbmUgQUQ3MTUwX1NOMF9SRUcgICAgICAg
ICAgICAgICAgICAgICAgICAgMHgxNg0KPiA+ICAjZGVmaW5lIEFENzE1MF9JRF9SRUcgICAgICAg
ICAgICAgICAgICAgICAgICAgIDB4MTcNCj4gPiANCj4gPiArLyogQUQ3MTUwIG1hc2tzICovDQo+
ID4gKyNkZWZpbmUgQUQ3MTUwX1RIUkVTSFRZUEVfTVNLICAgICAgICAgICAgICAgICAgR0VOTUFT
Syg2LCA1KQ0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIHN0cnVjdCBhZDcxNTBfY2hpcF9pbmZv
IC0gaW5zdGFuY2Ugc3BlY2lmaWMgY2hpcCBkYXRhDQo+ID4gICAqIEBjbGllbnQ6IGkyYyBjbGll
bnQgZm9yIHRoaXMgZGV2aWNlDQo+ID4gQEAgLTEzNiw3ICsxNDAsNyBAQCBzdGF0aWMgaW50IGFk
NzE1MF9yZWFkX2V2ZW50X2NvbmZpZyhzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYsDQo+
ID4gICAgICAgICBpZiAocmV0IDwgMCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gPiANCj4gPiAtICAgICAgIHRocmVzaHR5cGUgPSAocmV0ID4+IDUpICYgMHgwMzsNCj4gPiAr
ICAgICAgIHRocmVzaHR5cGUgPSBGSUVMRF9HRVQoQUQ3MTUwX1RIUkVTSFRZUEVfTVNLLCByZXQp
Ow0KPiA+ICAgICAgICAgYWRhcHRpdmUgPSAhIShyZXQgJiAweDgwKTsNCj4gDQo+IFdoeSBub3Qg
YWxzbyBkbyBzb21ldGhpbmcgc2ltaWxhciBmb3IgdGhlIGBhZGFwdGl2ZWAgdmFsdWUgPw0KPiAN
Cj4gPiANCj4gPiAgICAgICAgIHN3aXRjaCAodHlwZSkgew0KPiA+IC0tDQo+ID4gMi4yMC4xDQo+
ID4gDQo=
