Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970B336F46
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 10:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfFFI7R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 04:59:17 -0400
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:19616
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfFFI7R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jun 2019 04:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKF2kab47WTWMT/USdF4I14NPIoqz4OwVekZ38M+PGk=;
 b=7BOdFlBoOWsO9IlCc7+4TwEOTPhJeT1nqzTxjRkGye51izFz6r68mWjIe3O99FW7RIJgBeipW3/ivAfdZYZqTxMni3/H0yNY2oKMhyH0TsaJmyMxh//G8fsnde9QNqIJig2DPNUaMl0j99+T56B1Lij7QI2j1IMirRRvfgtY3Y4=
Received: from DM3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:0:50::12) by
 SN2PR03MB2271.namprd03.prod.outlook.com (2603:10b6:804:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 08:59:14 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM3PR03CA0002.outlook.office365.com
 (2603:10b6:0:50::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Thu, 6 Jun 2019 08:59:13 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 08:59:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x568xBRk019687
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Jun 2019 01:59:11 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 6 Jun 2019 04:59:11 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "92siuyang@gmail.com" <92siuyang@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio:core: Fix bug in length of event info_mask and
 catch unhandled bits set in masks.
Thread-Topic: [PATCH] iio:core: Fix bug in length of event info_mask and
 catch unhandled bits set in masks.
Thread-Index: AQHVGtJ9P5E5ewmmHkOo6yet6TmxCKaOmZ4A
Date:   Thu, 6 Jun 2019 08:59:10 +0000
Message-ID: <b422a132f5e4db9d4e4079963e52e1031e2f30e6.camel@analog.com>
References: <1559652000-18333-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1559652000-18333-1-git-send-email-92siuyang@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBBF7C7DF81403438267E6B35FABE208@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(189003)(199004)(186003)(356004)(336012)(6246003)(426003)(23676004)(8676002)(47776003)(7736002)(246002)(36756003)(11346002)(2616005)(476003)(436003)(446003)(126002)(229853002)(486006)(2501003)(14454004)(478600001)(7636002)(76176011)(2486003)(50466002)(70586007)(7696005)(2201001)(70206006)(5660300002)(110136005)(118296001)(8936002)(305945005)(2906002)(106002)(3846002)(14444005)(102836004)(26005)(6116002)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2271;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 306490dc-d2ec-44b6-4079-08d6ea5d3f28
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:SN2PR03MB2271;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2271:
X-Microsoft-Antispam-PRVS: <SN2PR03MB227105822B63ADD683AECADAF9170@SN2PR03MB2271.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vsI7BBZT7reC5cJWrbgej1kPXvg6s7bubkBI+vvgzNDC9udQwiz6qQjBBQW5Z3Z0DdvfhJBYVKK1dnuDsexq1k542Ld+mOQW/B3ZuoD4EyTt0bGyyWoolUrEj5yBRd734qriI3u3gy238veoiXr1DcyC32sAjX1TS0KeBiXs8j2rMLktFOBZBUxPIuO8yXGEoja6g8DHA+ggmqYaEN5mA4GqODzEtBWtuuvHdvaUtEtniyQBRnIAFfmY6VcCFJVSG7G3vVzIozxRdlFMhgNaD18d1vqdWV9rgGEVergzYuJieRhJ9tZRvd//5xNsNLUvREyBHPWdqtD0ge1XefoFhNMLyT0i90uFirvirrWG0U+t6YPGMoh/W+q0wYTk/NYH8SmXSoTIPuYUORzsWuBiXOV4jJNT9ueg6lOKJtsMx+Y=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 08:59:12.6330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306490dc-d2ec-44b6-4079-08d6ea5d3f28
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2271
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTA0IGF0IDIwOjQwICswODAwLCBZb3VuZyBYaWFvIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiANCj4gVGhlIGluY29ycmVjdCBsaW1pdCBmb3IgdGhlIGZvcl9lYWNo
X3NldF9iaXQgbG9vcCB3YXMgbm90aWNlZCB3aGlsc3QgZml4aW5nDQo+IHRoaXMgb3RoZXIgY2Fz
ZS4gIE5vdGUgdGhhdCBhcyB3ZSBvbmx5IGhhdmUgMyBwb3NzaWJsZSBlbnRyaWVzIGEgdGhlIG1v
bWVudA0KPiBhbmQgdGhlIHZhbHVlIHdhcyBzZXQgdG8gNCwgdGhlIGJ1ZyB3b3VsZCBub3QgaGF2
ZSBhbnkgZWZmZWN0IGN1cnJlbnRseS4NCj4gSXQgd2lsbCBiaXRlIGZhaXJseSBzb29uIHRob3Vn
aCwgc28gYmVzdCBmaXggaXQgbm93Lg0KPiANCj4gU2VlIGNvbW1pdCBlZjRiNDg1NjU5M2YgKCJp
aW86Y29yZTogRml4IGJ1ZyBpbiBsZW5ndGggb2YgZXZlbnQgaW5mb19tYXNrIGFuZA0KPiBjYXRj
aCB1bmhhbmRsZWQgYml0cyBzZXQgaW4gbWFza3MuIikgZm9yIGRldGFpbHMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZb3VuZyBYaWFvIDw5MnNpdXlhbmdAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0K
VGhhbmtzIGZvciB0aGlzIHBhdGNoLg0KVGhpcyBmaXggaXMgdmFsaWRhdGVkIGFsc28gYnkgdGhl
IGZhY3QgdGhhdCBpaW9fZGV2aWNlX2FkZF9pbmZvX21hc2tfdHlwZSgpIGhhcyB0aGlzIGNoZWNr
IG9uIHRoZSBzYW1lIGl0ZXJhdGlvbi4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWNvcmUuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jIGIvZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYw0KPiBpbmRleCBmNWE0NTgxLi5kZDg4NzNhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gQEAgLTExMDcsNiArMTEwNyw4IEBAIHN0
YXRpYyBpbnQgaWlvX2RldmljZV9hZGRfaW5mb19tYXNrX3R5cGVfYXZhaWwoc3RydWN0IGlpb19k
ZXYgKmluZGlvX2RldiwNCj4gICAgICAgICBjaGFyICphdmFpbF9wb3N0Zml4Ow0KPiANCj4gICAg
ICAgICBmb3JfZWFjaF9zZXRfYml0KGksIGluZm9tYXNrLCBzaXplb2YoKmluZm9tYXNrKSAqIDgp
IHsNCj4gKyAgICAgICAgICAgICAgIGlmIChpID49IEFSUkFZX1NJWkUoaWlvX2NoYW5faW5mb19w
b3N0Zml4KSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAg
ICAgICAgICAgICAgICBhdmFpbF9wb3N0Zml4ID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIlc19hdmFpbGFibGUiLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpaW9fY2hhbl9pbmZv
X3Bvc3RmaXhbaV0pOw0KPiAtLQ0KPiAyLjcuNA0KPiANCg==
