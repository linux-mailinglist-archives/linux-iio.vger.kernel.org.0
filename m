Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C349B1A934A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634900AbgDOGdZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 02:33:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29182 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgDOGdX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 02:33:23 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03F6XKXL018687;
        Wed, 15 Apr 2020 02:33:20 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn9a9538-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 02:33:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrX7Vboiu02t7fXTeKMVRFelzcYAS2H4qhLRWF/CoxOnYnoAcT5D4g9Z+98H8cdIMhQfHLpIv6G0waV6QiKtkrtbIbVvPuk7+dzDXUnBRFE1MyMndhHLQSkXNFQrsIcnclzQBMsimLhy3kZQvRZKBWCmh3kV7eipEKfXA52tX/QcHGr//1W7sTkL2evjxZY2syiBT3Ps6d8XlYzmvC32IiPcArqWhjSmlabU2VpMsXoSl9YeR8MU1RaiiB73uw8SL81X8HtH96RcaoYrEqNRAs4Qgs5WvnRY7++CvchPlz558najUeOhYgVyoh/aop4oo4bR7WVW2ywu/MAvjTDeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vmqv5OG7ok0/+98er2RY7/KxSrSgnuMxQLDYlkPdEo=;
 b=NwoX6A025+4Sv7XWqj1oVPkCwVTneg0nxbkQD241ud+kB1utdaYqSKai0oY4yrbusWFjVkqdlSihWhp6OLTAATMaPdNOylEbRO4I6smM9cWgY+iIUCa74NknySeSMBgob8MaCGikIX5DwLfKDtpSr60RIwkkFSfr+mzLJc8sv8PV7ApjfWS6q5Qx1mZ65J2DHWzGjUwiBCsK76jl1ZBe5QD2VfO3KttPlqmoSewWeWgC3oPPYCY2VIORueXASKNTTTJEXdeDdWhjfu83NIW53KxMtYnGwQ+NGwfLMqU1+z0+o4ni6vjvcgx4oKCMXIVnpY1miHMBstdkvXxSe6+znQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vmqv5OG7ok0/+98er2RY7/KxSrSgnuMxQLDYlkPdEo=;
 b=QOKAzNnotkI7HyeRJ1bdA513P8ci51mGGO5ZdsDNY6k87azhEIg3T2sMr+bFzcscaVQ2ll2fgV2PmgEXvh7IVx2T3dYf1nFpGTHYd1ZpMZ9nNtgSBzZk4sHnm7KuxpBE0r/qZNbayizGWIH/cNsoH1wurgiJ8VBuO3/duChpHJk=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4890.namprd03.prod.outlook.com (2603:10b6:5:15c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Wed, 15 Apr
 2020 06:33:19 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.024; Wed, 15 Apr 2020
 06:33:18 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Thread-Topic: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Thread-Index: AQHV8gBr/PFF68cjP0mJ7GikcNLAp6h3h5YAgAFDNoCAAFoPgIAA1qCA
Date:   Wed, 15 Apr 2020 06:33:17 +0000
Message-ID: <f13b4286c5f133e7461d59965d7f84af059c8e89.camel@analog.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
         <20200413180556.20638f3b@archlinux>
         <9315e9a7-0703-b119-ca32-69f0c2fcc7de@microchip.com>
         <20200414184505.0cd39249@archlinux>
In-Reply-To: <20200414184505.0cd39249@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a06fcb3-05f3-47c7-b455-08d7e106e2f3
x-ms-traffictypediagnostic: DM6PR03MB4890:
x-microsoft-antispam-prvs: <DM6PR03MB48909ACF5CCED1E022A06B5AF9DB0@DM6PR03MB4890.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39860400002)(366004)(346002)(136003)(396003)(376002)(8676002)(478600001)(8936002)(53546011)(2906002)(316002)(6486002)(186003)(26005)(81156014)(5660300002)(36756003)(86362001)(110136005)(966005)(4326008)(2616005)(66946007)(71200400001)(6512007)(91956017)(66446008)(54906003)(76116006)(66556008)(64756008)(66476007)(6506007)(309714004);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KrkdpWKQMtUmG8BiRGxbN81hcu3ZmYqugfJNBW3wZqeDzjOvYiYSXm3o8vlXOq52yUp6kcfKaOORGn/bfM/3vd/w7bWIo0+TQq6KZJeNvyV8TxWMeQxgeK87x2/01qO2k+RkligAOrhLJpBs37jHyQ6Ft1BGSHGv1sjwF9hZSB+mpWdGL6cZpxV9IuW/2jX7uL8dQiGQ05GvhsiBhW0WgO86S8ccHTsb8XqJldDHeRwrO48FtLc0BMjoCtg40MQkCG+ZgtlAkdfV/plxuTICq5xJe2YlZp9NyIgSwa4dzPY6y7A47/XzYSsP8XNqN1hQ1zd0RNOPonRTguEVAp47kBR8CLUyGAR42EW7WiWa50sPbAatMJfjzLxin7RO973xY2jyPG9TfCbFiDCHpYvxGTDcRcDOjriflJC4jxzDr70RTiKFwJx4c0AWL2LXPJKPRpVc69dMIJZzODm88pu1KZS4s2iijN7TYmm47oFlZy0NsqU2BU3aMobIw2QA0XPAYBoaAqYdAibCfwi4awQtAe9vB9s78W+vtSRRzLAZStlgQdAzj6VclT3sAQdEZGKH
x-ms-exchange-antispam-messagedata: a9fK3sfYRTPCOZhMDhzg4rko4wfYzZboGsEu5y8MNGrzAOQNjGA3m71wEMHg8PA2BCNWPFqoM0IQxnd/sWr9zCowLP65fON4FO9f+MT6BaynjeRWF0iZaBWmJ3s+i8i66T09O3vtj4gVWdq2JohDwg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <13D6628C5C9866428910A1FFFE93E727@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a06fcb3-05f3-47c7-b455-08d7e106e2f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 06:33:18.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96vb7WQAof5Vr5iTLBAIzGX6v9D6BQaB3EonBIPH/fR2GWxa78gUcum9IhZ9oMcrCVcdPPh8gQBFuHEeADHVOVekInhFCPDYAc8l1ELug5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4890
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_01:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150048
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDE4OjQ1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDE0IEFwciAyMDIwIDEyOjIyOjQ1ICswMDAwDQo+IDxFdWdlbi5IcmlzdGV2
QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiAxMy4wNC4yMDIwIDIwOjA1LCBKb25h
dGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+ID4gT24gV2VkLCA0IE1hciAyMDIwIDEwOjQyOjE4ICsw
MjAwDQo+ID4gPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cu
Y29tPiB3cm90ZToNCj4gPiA+ICAgDQo+ID4gPiA+IFRoaXMgY2hhbmdlIG1vdmVzIHRoZSBsb2dp
YyB0byBjaGVjayBpZiB0aGUgY3VycmVudCBjaGFubmVsIGlzIHRoZQ0KPiA+ID4gPiB0b3VjaHNj
cmVlbiBjaGFubmVsIHRvIGEgc2VwYXJhdGUgaGVscGVyLg0KPiA+ID4gPiBUaGlzIHJlZHVjZXMg
c29tZSBjb2RlIGR1cGxpY2F0aW9uLCBidXQgdGhlIG1haW4gaW50ZW50IGlzIHRvIHJlLXVzZQ0K
PiA+ID4gPiB0aGlzDQo+ID4gPiA+IGluIHRoZSBuZXh0IHBhdGNoZXMuDQo+ID4gPiA+IA0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVh
bkBhbmFsb2cuY29tPiAgDQo+ID4gPiBFdWdlbiAvIEx1ZG92aWMsDQo+ID4gPiANCj4gPiA+IEhh
dmUgeW91IGhhZCBhIGNoYW5jZSB0byBsb29rIGF0IHRoaXMgc2VyaWVzPyAgDQo+ID4gDQo+ID4g
SGkgSm9uYXRoYW4sDQo+ID4gDQo+ID4gRG9lcyB0aGUgcGF0Y2ggYXBwbHkgY29ycmVjdGx5IGZv
ciB5b3UgPw0KPiANCj4gSSBoYXZlbid0IHRyaWVkIHlldCA6KQ0KPiANCg0KSSd2ZSByZWJhc2Vk
IHRoaXMgcGF0Y2hzZXQgb24gdG9wIG9mIGN1cnJlbnQgaWlvL3Rlc3RpbmcgYW5kIGl0IHN0aWxs
IGFwcGxpZXMuDQoNCg0KPiA+IEkgd2lsbCB0cnkgdG8gdGVzdCBpdCAsIGlmIEkgbWFuYWdlIHRv
IGFwcGx5IGl0Lg0KPiA+IEkgY2FuIG9ubHkgdGVzdCB0aGUgQURDIHRob3VnaCBiZWNhdXNlIGF0
IHRoaXMgbW9tZW50IEkgZG8gbm90IGhhdmUgYSANCj4gPiB0b3VjaHNjcmVlbiBhdCBkaXNwb3Nh
bC4NCj4gPiANCj4gPiBNZWFud2hpbGUsIHRoZSBjb2RlIGxvb2tzIGdvb2QgZm9yIG1lLA0KPiA+
IA0KPiA+IFJldmlld2VkLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hp
cC5jb20+DQo+ID4gDQo+ID4gQnkgdGhlIHdheSwgSSBkbyBub3Qga25vdyBpZiBteSB0d28gcGVu
ZGluZyBwYXRjaGVzIG9uIHRoaXMgZHJpdmVyIHdpbGwgDQo+ID4gY29uZmxpY3Qgb3Igbm90Lg0K
PiANCj4gQXMgdGhpcyBpcyBhIGxvbmcgdGVybSByZXdvcmsgcGF0Y2ggYXQgaGVhcnQsIHRoZXJl
IGlzbid0IGFueSBwYXJ0aWN1bGFyDQo+IHJ1c2ggYXMgbG9uZyBhcyB3ZSBkb24ndCBsb29zZSBp
dCBmb3JldmVyIQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gRXVnZW4N
Cj4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IA0KPiA+ID4gSm9uYXRoYW4NCj4gPiA+ICAgDQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBwYXRjaHNldCBjb250aW51ZXMgZGlz
Y3Vzc2lvbjoNCj4gPiA+ID4gICAgIA0KPiA+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlvLzIwMTkxMDIzMDgyNTA4LjE3NTgz
LTEtYWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20vX187ISFBM05pOENTMHkyWSFxbDFiWWlO
TVBGbHoxdHduQ0NBUXBpRUJ2cHp4Ul9WSEFQTDcxMnJXRmZ3eTJUU0tqWjJVaEdCb1Y3LTI5U3lu
eTZ6MHlnJA0KPiA+ID4gPiAgDQo+ID4gPiA+IEFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5Lg0KPiA+
ID4gPiANCj4gPiA+ID4gQ2hhbmdlbG9nIHYxIC0+IHYyOg0KPiA+ID4gPiAqIGFkZGVkIHBhdGNo
ICdpaW86IGF0OTEtc2FtYTVkMl9hZGM6IHNwbGl0DQo+ID4gPiA+IGF0OTFfYWRjX2N1cnJlbnRf
Y2hhbl9pc190b3VjaCgpDQo+ID4gPiA+ICAgIGhlbHBlcicNCj4gPiA+ID4gKiByZW5hbWVkIGF0
OTFfYWRjX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgLT4gYXQ5MV9hZGNfYnVmZmVyX3ByZWVuYWJsZSgp
DQo+ID4gPiA+ICAgIC0gYXQ5MV9hZGNfYnVmZmVyX3Bvc3RlbmFibGUoKSAtIG5vdyBqdXN0IGNh
bGxzDQo+ID4gPiA+ICAgICAgaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSgpIGlmIHRo
ZSBjaGFubmVsIGlzbid0IHRoZQ0KPiA+ID4gPiB0b3VjaHNjcmVlbg0KPiA+ID4gPiAgICAgIGNo
YW5uZWwNCj4gPiA+ID4gKiByZW5hbWVkIGF0OTFfYWRjX2J1ZmZlcl9wcmVkaXNhYmxlKCkgLT4g
YXQ5MV9hZGNfYnVmZmVyX3Bvc3RkaXNhYmxlKCkNCj4gPiA+ID4gICAgLSBhdDkxX2FkY19idWZm
ZXJfcHJlZGlzYWJsZSgpIC0gbm93IGp1c3QgY2FsbHMNCj4gPiA+ID4gICAgICBpaW9fdHJpZ2dl
cmVkX2J1ZmZlcl9wcmVkaXNhYmxlKCkgaWYgdGhlIGNoYW5uZWwgaXNuJ3QgdGhlDQo+ID4gPiA+
IHRvdWNoc2NyZWVuDQo+ID4gPiA+ICAgICAgY2hhbm5lbA0KPiA+ID4gPiANCj4gPiA+ID4gICBk
cml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIHwgMzEgKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tDQo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyks
IDE2IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS0NCj4gPiA+
ID4gc2FtYTVkMl9hZGMuYw0KPiA+ID4gPiBpbmRleCBhNWM3NzcxMjI3ZDUuLmYyYTc0YzQ3Yzc2
OCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMu
Yw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+ID4g
PiA+IEBAIC04NzMsMTggKzg3MywyNCBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX2RtYV9zdGFydChz
dHJ1Y3QgaWlvX2Rldg0KPiA+ID4gPiAqaW5kaW9fZGV2KQ0KPiA+ID4gPiAgICAgICAgcmV0dXJu
IDA7DQo+ID4gPiA+ICAgfQ0KPiA+ID4gPiANCj4gPiA+ID4gK3N0YXRpYyBib29sIGF0OTFfYWRj
X2N1cnJlbnRfY2hhbl9pc190b3VjaChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4g
PiArew0KPiA+ID4gPiArICAgICBzdHJ1Y3QgYXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3ByaXYo
aW5kaW9fZGV2KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICByZXR1cm4gISFiaXRtYXBfc3Vi
c2V0KGluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFzaywNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmc3QtPnRvdWNoX3N0LmNoYW5uZWxzX2JpdG1hc2ssDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQVQ5MV9TQU1BNUQyX01BWF9DSEFOX0lEWCArIDEp
Ow0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICAgc3RhdGljIGludCBhdDkxX2FkY19i
dWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4gPiAgIHsN
Cj4gPiA+ID4gICAgICAgIGludCByZXQ7DQo+ID4gPiA+ICAgICAgICBzdHJ1Y3QgYXQ5MV9hZGNf
c3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAg
ICAvKiBjaGVjayBpZiB3ZSBhcmUgZW5hYmxpbmcgdHJpZ2dlcmVkIGJ1ZmZlciBvciB0aGUgdG91
Y2hzY3JlZW4NCj4gPiA+ID4gKi8NCj4gPiA+ID4gLSAgICAgaWYgKGJpdG1hcF9zdWJzZXQoaW5k
aW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAmc3QtPnRvdWNoX3N0LmNoYW5uZWxzX2JpdG1hc2ssDQo+ID4gPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgIEFUOTFfU0FNQTVEMl9NQVhfQ0hBTl9JRFggKyAxKSkgew0KPiA+ID4gPiAtICAg
ICAgICAgICAgIC8qIHRvdWNoc2NyZWVuIGVuYWJsaW5nICovDQo+ID4gPiA+ICsgICAgIGlmIChh
dDkxX2FkY19jdXJyZW50X2NoYW5faXNfdG91Y2goaW5kaW9fZGV2KSkNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgcmV0dXJuIGF0OTFfYWRjX2NvbmZpZ3VyZV90b3VjaChzdCwgdHJ1ZSk7DQo+ID4g
PiA+IC0gICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgICAgLyogaWYgd2UgYXJlIG5vdCBp
biB0cmlnZ2VyZWQgbW9kZSwgd2UgY2Fubm90IGVuYWJsZSB0aGUgYnVmZmVyLg0KPiA+ID4gPiAq
Lw0KPiA+ID4gPiAgICAgICAgaWYgKCEoaW5kaW9fZGV2LT5jdXJyZW50bW9kZSAmIElORElPX0FM
TF9UUklHR0VSRURfTU9ERVMpKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCj4gPiA+ID4gQEAgLTkwNiwxMiArOTEyLDkgQEAgc3RhdGljIGludCBhdDkxX2FkY19idWZm
ZXJfcHJlZGlzYWJsZShzdHJ1Y3QNCj4gPiA+ID4gaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4g
PiAgICAgICAgdTggYml0Ow0KPiA+ID4gPiANCj4gPiA+ID4gICAgICAgIC8qIGNoZWNrIGlmIHdl
IGFyZSBkaXNhYmxpbmcgdHJpZ2dlcmVkIGJ1ZmZlciBvciB0aGUgdG91Y2hzY3JlZW4NCj4gPiA+
ID4gKi8NCj4gPiA+ID4gLSAgICAgaWYgKGJpdG1hcF9zdWJzZXQoaW5kaW9fZGV2LT5hY3RpdmVf
c2Nhbl9tYXNrLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAmc3QtPnRvdWNoX3N0
LmNoYW5uZWxzX2JpdG1hc2ssDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIEFUOTFf
U0FNQTVEMl9NQVhfQ0hBTl9JRFggKyAxKSkgew0KPiA+ID4gPiAtICAgICAgICAgICAgIC8qIHRv
dWNoc2NyZWVuIGRpc2FibGUgKi8NCj4gPiA+ID4gKyAgICAgaWYgKGF0OTFfYWRjX2N1cnJlbnRf
Y2hhbl9pc190b3VjaChpbmRpb19kZXYpKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICByZXR1cm4g
YXQ5MV9hZGNfY29uZmlndXJlX3RvdWNoKHN0LCBmYWxzZSk7DQo+ID4gPiA+IC0gICAgIH0NCj4g
PiA+ID4gKw0KPiA+ID4gPiAgICAgICAgLyogaWYgd2UgYXJlIG5vdCBpbiB0cmlnZ2VyZWQgbW9k
ZSwgbm90aGluZyB0byBkbyBoZXJlICovDQo+ID4gPiA+ICAgICAgICBpZiAoIShpbmRpb19kZXYt
PmN1cnJlbnRtb2RlICYgSU5ESU9fQUxMX1RSSUdHRVJFRF9NT0RFUykpDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiBAQCAtMTg4NiwxNCArMTg4OSwxMCBA
QCBzdGF0aWMgX19tYXliZV91bnVzZWQgaW50IGF0OTFfYWRjX3Jlc3VtZShzdHJ1Y3QNCj4gPiA+
ID4gZGV2aWNlICpkZXYpDQo+ID4gPiA+ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4g
PiANCj4gPiA+ID4gICAgICAgIC8qIGNoZWNrIGlmIHdlIGFyZSBlbmFibGluZyB0cmlnZ2VyZWQg
YnVmZmVyIG9yIHRoZSB0b3VjaHNjcmVlbg0KPiA+ID4gPiAqLw0KPiA+ID4gPiAtICAgICBpZiAo
Yml0bWFwX3N1YnNldChpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2ssDQo+ID4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICZzdC0+dG91Y2hfc3QuY2hhbm5lbHNfYml0bWFzaywNCj4gPiA+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgQVQ5MV9TQU1BNUQyX01BWF9DSEFOX0lEWCArIDEp
KSB7DQo+ID4gPiA+IC0gICAgICAgICAgICAgLyogdG91Y2hzY3JlZW4gZW5hYmxpbmcgKi8NCj4g
PiA+ID4gKyAgICAgaWYgKGF0OTFfYWRjX2N1cnJlbnRfY2hhbl9pc190b3VjaChpbmRpb19kZXYp
KQ0KPiA+ID4gPiAgICAgICAgICAgICAgICByZXR1cm4gYXQ5MV9hZGNfY29uZmlndXJlX3RvdWNo
KHN0LCB0cnVlKTsNCj4gPiA+ID4gLSAgICAgfSBlbHNlIHsNCj4gPiA+ID4gKyAgICAgZWxzZQ0K
PiA+ID4gPiAgICAgICAgICAgICAgICByZXR1cm4gYXQ5MV9hZGNfY29uZmlndXJlX3RyaWdnZXIo
c3QtPnRyaWcsIHRydWUpOw0KPiA+ID4gPiAtICAgICB9DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAg
ICAgLyogbm90IG5lZWRlZCBidXQgbW9yZSBleHBsaWNpdCAqLw0KPiA+ID4gPiAgICAgICAgcmV0
dXJuIDA7ICANCj4gPiA+ICAgDQo=
