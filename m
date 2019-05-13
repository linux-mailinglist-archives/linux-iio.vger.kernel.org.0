Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA411B3A4
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfEMKGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 06:06:34 -0400
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:23616
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727339AbfEMKGe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 May 2019 06:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTC6C2xX78uOjJqmP8yCOQSAQn5EGoHZNCGN2gvy4Pc=;
 b=WPi8uIIuaoLDSVjkle6Keb5bmnsPQTipjqMtKCVUPZjdnhDS2oyByQQafb2WhbP+Ox6N4AbfMEzAVkPrBzwVCZkTnQ/Gp+HL8mnjylFsp+R8cSYksU+RNLP0wUCVY2l6+3MUj+gvIbwuOPRLkFXuQU9n5uJQxI7SEdT0h2jYA4s=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 10:04:51 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Mon, 13 May 2019 10:04:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; rockwellcollins.com; dkim=none (message not signed)
 header.d=none;rockwellcollins.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Mon, 13 May 2019 10:04:49 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4DA4m6h009749
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 May 2019 03:04:48 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 13 May 2019 06:04:48 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "adam.michaelis@collins.com" <adam.michaelis@collins.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "clayton.shotwell@rockwellcollins.com" 
        <clayton.shotwell@rockwellcollins.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "brandon.maier@rockwellcollins.com" 
        <brandon.maier@rockwellcollins.com>
Subject: Re: [PATCH v2 3/6] iio: ad7949: Support configuration read-back
Thread-Topic: [PATCH v2 3/6] iio: ad7949: Support configuration read-back
Thread-Index: AQHVAQIqbzl9BQf0pkK+UqLa18a5zaZlx1/ngANgQAA=
Date:   Mon, 13 May 2019 10:04:47 +0000
Message-ID: <1557741886.29142.3.camel@analog.com>
References: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
         <1556813672-49861-3-git-send-email-adam.michaelis@rockwellcollins.com>
         <20190505154227.1735b1b2@archlinux>
         <CALMrGWV6rtYQShtm7uBQygtdOpPW30mLnKMxb2Jk8pY68B6yyw@mail.gmail.com>
         <20190511113112.2da6385d@archlinux>
In-Reply-To: <20190511113112.2da6385d@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.224.122]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6541262E312764CBD6D8CC0A43AEDEC@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(189003)(199004)(5660300002)(8676002)(426003)(436003)(2501003)(2906002)(446003)(14454004)(126002)(8936002)(3846002)(6116002)(11346002)(103116003)(2616005)(478600001)(72206003)(476003)(6246003)(486006)(336012)(4326008)(36756003)(50466002)(76176011)(23676004)(102836004)(7696005)(2486003)(316002)(53546011)(305945005)(7636002)(7736002)(229853002)(356004)(26005)(246002)(106002)(47776003)(7416002)(86362001)(14444005)(186003)(70586007)(110136005)(54906003)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e4ed3d-b5cc-40cb-7d9b-08d6d78a6fe4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BLUPR03MB550;
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Antispam-PRVS: <BLUPR03MB55062DF2FA44ECA8849C7249D0F0@BLUPR03MB550.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0036736630
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: deKDWhoTFmv4wF7C0i8fTeWzU7Nrmv9Kiy3HylyjiOJsln1sbRacUpBcH05lpxVMt20VCk518w0MH1GWTJOA8EwRqAaFRoLkNvC+v/WSvPK7c6vzaoJAiRckfyRPK40bK1UncZ2hZw6Mgs7Lg3fsjhHj24Htxl06yWirIatqU5HBzG9nN0Vfn0dBm+/z3WUSqeIwY0SJ5sE6UlR1tY5lEgY9ZwFxGaAei0OyzkXIq37MhgJRlT3Ib2OACRj+HF3kZogutsIjDypVgPOajiKTEW02xCKINEZRC5ejuE6xHRFTpRRrJHfBjTymXHwXfM1fRQjpICxFijF695bXPprnMSrknK/+U0OxiTpxxDHhPyVWff1mbUkU5zVdTN/hMtx/uI6b/bvWHC7Mn98Ucebi3h+X3nkGIE3qPWKFfhsO+Gs=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2019 10:04:49.4439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e4ed3d-b5cc-40cb-7d9b-08d6d78a6fe4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2IsIDIwMTktMDUtMTEgYXQgMTE6MzEgKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBUdWUsIDcgTWF5IDIwMTkgMTQ6NTM6MzIgLTA1
MDANCj4gQWRhbSBNaWNoYWVsaXMgPGFkYW0ubWljaGFlbGlzQGNvbGxpbnMuY29tPiB3cm90ZToN
Cj4gDQo+ID4gDQo+ID4gT24gU3VuLCBNYXkgNSwgMjAxOSBhdCA5OjQyIEFNIEpvbmF0aGFuIENh
bWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IA0KPiA+
ID4gT24gVGh1LMKgwqAyIE1heSAyMDE5IDExOjE0OjI5IC0wNTAwDQo+ID4gPiBBZGFtIE1pY2hh
ZWxpcyA8YWRhbS5taWNoYWVsaXNAcm9ja3dlbGxjb2xsaW5zLmNvbT4gd3JvdGU6DQo+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IEFkZHMgZGV2aWNlIHRyZWUgcGFyYW1ldGVyIHRvIHNldCB0aGUg
Y29uZmlndXJhdGlvbiByZWFkLWJhY2sgYml0DQo+ID4gPiA+IGluIHRoZSBjb25maWd1cmF0aW9u
IHJlZ2lzdGVyIHRvIHRlbGwgdGhlIEFENzk0OSB0byBpbmNsdWRlIHRoZQ0KPiA+ID4gPiB2YWx1
ZSBvZg0KPiA+ID4gPiB0aGUgY29uZmlndXJhdGlvbiByZWdpc3RlciBhdCB0aGUgdGltZSB0aGUg
Y3VycmVudCBzYW1wbGUgd2FzDQo+ID4gPiA+IGFjcXVpcmVkDQo+ID4gPiA+IHdoZW4gcmVhZGlu
ZyBmcm9tIHRoZSBwYXJ0Lg0KPiA+ID4gPiANCj4gPiA+ID4gRnVydGhlciB3b3JrIG11c3QgYmUg
ZG9uZSB0byBtYWtlIHJlYWQtYmFjayBpbmZvcm1hdGlvbiBhdmFpbGFibGUNCj4gPiA+ID4gdG8N
Cj4gPiA+ID4gY29uc3VtZXIuDQo+ID4gPiBUaGlzIG5lZWRzIHNvbWUgZXhwbGFuYXRpb24gb2Yg
d2h5IGl0IGlzIHVzZWZ1bCBhdCBhbGwuIEknbSBjZXJ0YWlubHkNCj4gPiA+IHVuY2xlYXINCj4g
PiA+IG9uIHdoeSBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gY29uZmlndXJlIHRoaXMgYXQgYm9vdCB0
aW1lLg0KPiA+ID4gDQo+ID4gPiBDb2RlIGxvb2tzIGZpbmUuDQo+ID4gPiANCj4gPiA+IEpvbmF0
aGFuDQo+ID4gPiANCj4gPiBUaGUgY29uZmlndXJhdGlvbiByZWFkLWJhY2sgZmVhdHVyZSBpcyBi
ZWluZyBtYWludGFpbmVkIGZyb20gdGhlDQo+ID4gb3JpZ2luYWwgdmVyc2lvbiBvZiB0aGlzIGRy
aXZlci4gQmVmb3JlIGFkZGluZyB0aGUgZGV2aWNlIHRyZWUgZW50cnksDQo+ID4gdGhlcmUgd2Fz
IG5vIHdheSB0byBjaGFuZ2UgdGhpcyBzZXR0aW5nIG90aGVyIHRoYW4gZGVidWdmcyByYXcgYWNj
ZXNzDQo+ID4gdG8gdGhlIFNQSSBpbnRlcmZhY2UsIGFuZCB0aGVyZSBpcyBzdGlsbCBubyBhY2Nl
c3MgdG8gdGhlIHJldHVybmVkDQo+ID4gY29uZmlndXJhdGlvbiBkYXRhIHNob3VsZCB0aGUgZmVh
dHVyZSBiZSBlbmFibGVkLiBJIHdvdWxkIGJlIHdpbGxpbmcNCj4gPiB0byByZW1vdmUgdGhlIGZl
YXR1cmUgYWx0b2dldGhlciwgYnV0IHdhbnRlZCB0byB0cmVhZCBzb2Z0bHkgb24NCj4gPiBleGlz
dGluZyBmZWF0dXJlcy4NCj4gQWguIE1ha2VzIHNlbnNlLsKgwqBNeSBndXQgZmVlbGluZyBpcyB0
byBkcm9wIGl0Lg0KPiANCj4gQW55b25lIGF0IEFuYWxvZyBoYXZlIGEgdmlldyBvbiB0aGlzPw0K
PiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQoNCkhpLMKgDQoNCkl0IGlzIG5vdCBv
YnZpb3VzIHRvIG1lIHdoeSB0aGlzIGZlYXR1cmUgd291bGQgYmUgdXNlZnVsLiBJIHdvdWxkIG5v
dCBhZGQNCml0Lg0KDQpSZWdhcmRzLA0KLVN0ZWZhbg0KDQo+ID4gDQo+ID4gDQo+ID4gQWRhbQ0K
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWRhbSBN
aWNoYWVsaXMgPGFkYW0ubWljaGFlbGlzQHJvY2t3ZWxsY29sbGlucy5jb20+DQo+ID4gPiA+IC0t
LQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqBWMjogQWRkIHNvbWUgZGVmaW5lcyB0byByZWR1Y2UgdXNl
IG9mIG1hZ2ljIG51bWJlcnMuDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGRyaXZlcnMvaWlvL2Fk
Yy9hZDc5NDkuYyB8IDEyICsrKysrKysrKysrLQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jIGIvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5j
DQo+ID4gPiA+IGluZGV4IGFmYzEzNjFhZjVmYi4uNzgyMGUxMDk3Nzg3IDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ3OTQ5LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9p
aW8vYWRjL2FkNzk0OS5jDQo+ID4gPiA+IEBAIC02OSw2ICs2OSw3IEBAIHN0cnVjdCBhZDc5NDlf
YWRjX3NwZWMgew0KPiA+ID4gPiDCoCAqIEBpaW9fZGV2OiByZWZlcmVuY2UgdG8gaWlvIHN0cnVj
dHVyZQ0KPiA+ID4gPiDCoCAqIEBzcGk6IHJlZmVyZW5jZSB0byBzcGkgc3RydWN0dXJlDQo+ID4g
PiA+IMKgICogQHJlZl9zZWw6IHNlbGVjdGVkIHJlZmVyZW5jZSB2b2x0YWdlIHNvdXJjZQ0KPiA+
ID4gPiArICogQGNmZ19yZWFkYmFjazogd2hldGhlciByZWFkcyB3aWxsIGluY2x1ZGUgY29uZmln
dXJhdGlvbiBkYXRhDQo+ID4gPiA+IMKgICogQHJlc29sdXRpb246IHJlc29sdXRpb24gb2YgdGhl
IGNoaXANCj4gPiA+ID4gwqAgKiBAY2ZnOiBjb3B5IG9mIHRoZSBjb25maWd1cmF0aW9uIHJlZ2lz
dGVyDQo+ID4gPiA+IMKgICogQGN1cnJlbnRfY2hhbm5lbDogY3VycmVudCBjaGFubmVsIGluIHVz
ZQ0KPiA+ID4gPiBAQCAtODAsNiArODEsNyBAQCBzdHJ1Y3QgYWQ3OTQ5X2FkY19jaGlwIHsNCj4g
PiA+ID4gwqDCoMKgwqDCoMKgc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gPiA+ID4gwqDC
oMKgwqDCoMKgc3RydWN0IHNwaV9kZXZpY2UgKnNwaTsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgZW51
bSBhZDc5NDlfcmVmX3NlbCByZWZfc2VsOw0KPiA+ID4gPiArwqDCoMKgwqDCoGJvb2wgY2ZnX3Jl
YWRiYWNrOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqB1OCByZXNvbHV0aW9uOw0KPiA+ID4gPiDCoMKg
wqDCoMKgwqB1MTYgY2ZnOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgY3VycmVu
dF9jaGFubmVsOw0KPiA+ID4gPiBAQCAtMjgzLDcgKzI4NSwxMSBAQCBzdGF0aWMgaW50IGFkNzk0
OV9zcGlfaW5pdChzdHJ1Y3QNCj4gPiA+ID4gYWQ3OTQ5X2FkY19jaGlwICphZDc5NDlfYWRjKQ0K
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFENzk0
OV9DRkdfUkVGX1NFTF9NQVNLOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqBhZGNfY29uZmlnIHw9IChB
RDc5NDlfQ0ZHX1NFUV9ESVNBQkxFRCA8PA0KPiA+ID4gPiBBRDc5NDlfQ0ZHX1NFUV9TSElGVCkg
Jg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFE
Nzk0OV9DRkdfU0VRX01BU0s7DQo+ID4gPiA+IC3CoMKgwqDCoMKgYWRjX2NvbmZpZyB8PSBBRDc5
NDlfQ0ZHX1JFQURCQUNLX0RJUzsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoGlmIChh
ZDc5NDlfYWRjLT5jZmdfcmVhZGJhY2spDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGFkY19jb25maWcgfD0gQUQ3OTQ5X0NGR19SRUFEQkFDS19FTjsNCj4gPiA+ID4gK8KgwqDC
oMKgwqBlbHNlDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFkY19jb25maWcg
fD0gQUQ3OTQ5X0NGR19SRUFEQkFDS19ESVM7DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKg
wqByZXQgPSBhZDc5NDlfc3BpX3dyaXRlX2NmZyhhZDc5NDlfYWRjLA0KPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFkY19jb25maWcsDQo+ID4gPiA+
IEBAIC0zMzEsNiArMzM3LDEwIEBAIHN0YXRpYyBpbnQgYWQ3OTQ5X3NwaV9wcm9iZShzdHJ1Y3Qg
c3BpX2RldmljZQ0KPiA+ID4gPiAqc3BpKQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqBpbmRpb19kZXYt
Pm51bV9jaGFubmVscyA9IHNwZWMtPm51bV9jaGFubmVsczsNCj4gPiA+ID4gwqDCoMKgwqDCoMKg
YWQ3OTQ5X2FkYy0+cmVzb2x1dGlvbiA9IHNwZWMtPnJlc29sdXRpb247DQo+ID4gPiA+IA0KPiA+
ID4gPiArwqDCoMKgwqDCoGFkNzk0OV9hZGMtPmNmZ19yZWFkYmFjayA9IG9mX3Byb3BlcnR5X3Jl
YWRfYm9vbCgNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGFkNzk0OV9hZGMtPmluZGlvX2Rldi0+ZGV2Lm9mX25vZGUsDQo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiYWRpLGNmZy1yZWFkYmFjayIpOw0K
PiA+ID4gPiArDQo+ID4gPiA+IMKgwqDCoMKgwqDCoHJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMy
KGFkNzk0OV9hZGMtPmluZGlvX2Rldi0NCj4gPiA+ID4gPmRldi5vZl9ub2RlLA0KPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJhZGkscmVmZXJlbmNl
LXNlbGVjdCIsDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgJnRlbXApOw0KPiA+IC0t
