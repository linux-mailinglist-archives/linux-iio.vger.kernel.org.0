Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E876F3C492
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 08:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404056AbfFKG51 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 02:57:27 -0400
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:54752
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403964AbfFKG5Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 02:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1q8q9xjI+ixFi4HbOmNQGOYLLUK++YV/ktGOv/vzQU=;
 b=0xqG28Nj+wl0Xtb6JgdigbUyYUE/sCR0iORdKZrEfJoU7WQn1uZsVkSQy61H+QjAYtfGQ/Wc8AceZKHpEDXcSpoWJG8GgnTJu8lHZbbjTlazirX6i6di94qSTXVSye0YXIAsJ3ZokJf26kooUsGTW74Em+xmLmZe3TNXvIk8NsI=
Received: from BN6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:404:23::20)
 by BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15; Tue, 11 Jun
 2019 06:57:22 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BN6PR03CA0010.outlook.office365.com
 (2603:10b6:404:23::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.17 via Frontend
 Transport; Tue, 11 Jun 2019 06:57:22 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Tue, 11 Jun 2019 06:57:21 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5B6vLsS030073
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Jun 2019 23:57:21 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 11 Jun 2019 02:57:21 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hancock@sedsystems.ca" <hancock@sedsystems.ca>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: xilinx: support all platforms
Thread-Topic: [PATCH] iio: adc: xilinx: support all platforms
Thread-Index: AQHVH6j1tuMWpYcb8UG29tfpB27xz6aWQV6AgAAG1QCAAAFbgA==
Date:   Tue, 11 Jun 2019 06:57:20 +0000
Message-ID: <00e670434c42ba76a631362cbc5ef2f8135358fb.camel@analog.com>
References: <1560183824-19061-1-git-send-email-hancock@sedsystems.ca>
         <2c4116f4923ac710de15c2980e620f9d59f902b6.camel@analog.com>
         <23b0143d-7089-cba0-813d-2634345a66c4@metafoo.de>
In-Reply-To: <23b0143d-7089-cba0-813d-2634345a66c4@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8B444CC588A384F89B34889CEC52365@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(189003)(51914003)(199004)(316002)(14454004)(6246003)(2201001)(478600001)(118296001)(2501003)(486006)(86362001)(110136005)(2906002)(229853002)(106002)(54906003)(8676002)(5660300002)(8936002)(7636002)(7736002)(476003)(186003)(305945005)(246002)(70586007)(70206006)(26005)(6116002)(36756003)(2616005)(3846002)(7696005)(23676004)(336012)(2486003)(53546011)(4326008)(436003)(76176011)(126002)(446003)(11346002)(426003)(50466002)(14444005)(102836004)(356004)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d5d18f-ca44-4f0f-4259-08d6ee3a0d5b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BLUPR03MB552;
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Antispam-PRVS: <BLUPR03MB5522A3E21E3FCC19582D558F9ED0@BLUPR03MB552.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PBFGpVM+RpjNAeRozqCxJpKYvJ/BP2qIoG0119zM72twJEGwp5jymOUMfMvgJ+Pade3mKFbiLYyoDRtcz0wtYLjoHKlY/Td9mGuYEAAwNRr+k6cZHf9JCGndgpbOPWdWTTVCd6DHl6Vn4Musy3fQ8DuOrrksFSxeAZRrVJoYazmPv3sxN+/FmgUkAUTkdYKVD1G2aZHbUz94/da/j7SzO3NjgyyNAyPktY15vXkKfW9knY35UBZQBfnc/GQ/o8kqNnNuE/hrCMFuQyj+zBjhINv3j7CL5YRZlIUkTWgsxnN8DoOgpIU/1BGhbQqfCgMWpBXmKIhvkeZ1HxpgKcFpVQ9W/boX9ruOlmo0wrdH8Z/TpCX3lcdYnd8h10CkXKUP8FOW2lbVC0XPxZ/+vECsIhv0QsN5ePE3D54TamMLTpc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 06:57:21.8071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d5d18f-ca44-4f0f-4259-08d6ee3a0d5b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTExIGF0IDA4OjUyICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiA2LzExLzE5IDg6MjggQU0sIEFyZGVsZWFu
LCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDE5LTA2LTEwIGF0IDEwOjIzIC0wNjAw
LCBSb2JlcnQgSGFuY29jayB3cm90ZToNCj4gPiA+IFtFeHRlcm5hbF0NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBTaW5jZSB0aGUgWEFEQyBsb2dpYyBjYW4gYmUgdXNlZCB3aXRoIHN0YW5kYWxvbmUg
WGlsaW54IEZQR0FzLCB0aGlzDQo+ID4gPiBkcml2ZXIgY2FuIHBvdGVudGlhbGx5IGJlIHVzZWQg
d2l0aCBtYW55IGRpZmZlcmVudCBwbGF0Zm9ybXMsIG5vdCBqdXN0DQo+ID4gPiB0aGUgWnlucSBh
bmQgTWljcm9CbGF6ZSBwbGF0Zm9ybXMgdGhpcyBkcml2ZXIgd2FzIGFsbG93ZWQgdG8gYmUgYnVp
bHQNCj4gPiA+IGZvci4gVGhlcmUgc2hvdWxkIGJlIG5vIHBsYXRmb3JtLXNwZWNpZmljIGNvZGUg
aW4gdGhpcyBkcml2ZXIsIHNvIGp1c3QNCj4gPiA+IGRlbGV0ZSB0aGUgcGxhdGZvcm0gZGVwZW5k
ZW5jeS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0IEhhbmNvY2sgPGhhbmNv
Y2tAc2Vkc3lzdGVtcy5jYT4NCj4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIGFuIHVw
ZGF0ZWQgdmVyc2lvbiBvZiBhbiBlYXJsaWVyIHBhdGNoICJpaW86IGFkYzogeGlsaW54OiBzdXBw
b3J0IGFsbA0KPiA+ID4gQVJNIHBsYXRmb3JtcyIsIGJ1dCB0aGlzIG9uZSBqdXN0IGRlbGV0ZXMg
dGhlIHBsYXRmb3JtIHJlc3RyaWN0aW9uIGVudGlyZWx5DQo+ID4gPiBhcyBpdCBzZWVtcyB1bm5l
Y2Vzc2FyeS4NCj4gPiA+IA0KPiA+ID4gIGRyaXZlcnMvaWlvL2FkYy9LY29uZmlnIHwgMSAtDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9LY29uZmlnIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcN
Cj4gPiA+IGluZGV4IGY5NmE3NzAuLjdlMzI4NjIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJz
L2lpby9hZGMvS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcNCj4g
PiA+IEBAIC0xMDg1LDcgKzEwODUsNiBAQCBjb25maWcgVklQRVJCT0FSRF9BREMNCj4gPiA+IA0K
PiA+ID4gIGNvbmZpZyBYSUxJTlhfWEFEQw0KPiA+ID4gICAgICAgICB0cmlzdGF0ZSAiWGlsaW54
IFhBREMgZHJpdmVyIg0KPiA+ID4gLSAgICAgICBkZXBlbmRzIG9uIEFSQ0hfWllOUSB8fCBNSUNS
T0JMQVpFIHx8IENPTVBJTEVfVEVTVA0KPiA+IA0KPiA+IEp1c3QgY3VyaW9zIGhlcmU6IGlzIGBk
ZXBlbmRzIENPTVBJTEVfVEVTVGAgbmVlZGVkIHNvIHRoYXQgdGhpcyBnZXRzIGluY2x1ZGVkIGlu
IGEgY29tcGlsZS10ZXN0IGJ1aWxkID8NCj4gPiBJJ20gc29tZXdoYXQgdmFndWUgb24gTGludXgn
cyBtYWtlZmlsZSBsb2dpYy9zdHJ1Y3R1cmUuDQo+IA0KPiBDT01QSUxFX1RFU1QgZW5hYmxlcyB0
aGUgZHJpdmVyIGZvciBjb21waWxlIHRlc3RpbmcgaWYgaXQgaXMgbm90IGFscmVhZHkNCj4gZW5h
YmxlZCBvdGhlcndpc2UuIE5vdyB0aGF0IHRoZSBkcml2ZXIgaGFzIG5vIGRlcGVuZGVuY2llcyBh
dCBhbGwgaXQNCj4gd2lsbCBhbHdheXMgYmUgZW5hYmxlZCwgd2hpY2ggaW5jbHVkZXMgY29tcGls
ZSB0ZXN0aW5nLg0KDQpJIHNlZS4NClRoYW5rcyBmb3IgdGhlIGluZm8NCg==
