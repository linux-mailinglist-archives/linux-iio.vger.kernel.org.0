Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339AE3714B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfFFKKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 06:10:06 -0400
Received: from mail-eopbgr690072.outbound.protection.outlook.com ([40.107.69.72]:49522
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727846AbfFFKKG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jun 2019 06:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELVQlyaoUnz3a1yXuH4VUBdVXLf1z9tpRILdvDLY6r0=;
 b=fLaxAZnkhjFytJ84L6fl5/TFRNdPg3F138UH5FaUpGAl8kB8Q/q8mP+XZbAGhSnWDHga+Cqow1rzHsRFOvQCMO3kQ7E3vgVjxfWlgKbTDeGNS8bPJ0gWvLic4F0iJyCZXGPDRgihaucyKCo6RBIZf0vkidOF1xo5Rk0l2dZ+Ols=
Received: from CY1PR03CA0002.namprd03.prod.outlook.com (2603:10b6:600::12) by
 BN3PR03MB2257.namprd03.prod.outlook.com (2a01:111:e400:c5f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Thu, 6 Jun
 2019 10:10:02 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by CY1PR03CA0002.outlook.office365.com
 (2603:10b6:600::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Thu, 6 Jun 2019 10:10:02 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 10:10:01 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x56AA0b1005974
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Jun 2019 03:10:00 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 6 Jun 2019 06:10:00 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hancock@sedsystems.ca" <hancock@sedsystems.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: xilinx: support all ARM platforms
Thread-Topic: [PATCH] iio: adc: xilinx: support all ARM platforms
Thread-Index: AQHVG+Xlca5zDvFM6EOV+QckaK3pXaaOq0GA
Date:   Thu, 6 Jun 2019 10:09:59 +0000
Message-ID: <379a99c8405b4cfbaa61ac49f9b40d4c577eb2a8.camel@analog.com>
References: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
In-Reply-To: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F3F1D37EB149244B8BE9E9E6E0EAB04@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(376002)(136003)(2980300002)(189003)(199004)(86362001)(316002)(6246003)(246002)(305945005)(11346002)(110136005)(14444005)(54906003)(356004)(4326008)(36756003)(2616005)(7736002)(2906002)(7636002)(446003)(70586007)(26005)(118296001)(126002)(47776003)(436003)(486006)(476003)(50466002)(14454004)(8676002)(336012)(8936002)(106002)(3846002)(76176011)(229853002)(478600001)(2486003)(23676004)(6116002)(102836004)(7696005)(186003)(2501003)(70206006)(426003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2257;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2258e99-d337-4f38-4dbe-08d6ea6723c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN3PR03MB2257;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2257:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2257E1970A56B5B7B53E84E7F9170@BN3PR03MB2257.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3jPF0CxECXoh6At5lIIDcQ0Dxg4xxh7ya3J3DiGnyggNqBkYwZzoSrjeUbCNXIVcD05wnbnDmx2wZb6awM33kulGFT6HgVR2oxB94uD9CWV7mG/NJSCBg6fOpE6refFp0UZ9NvPQPJzyiD3tU/gCCH0Tk3VosxavSfWcSg/P9LTAE25xXhhzYvXvdcfRLOF4w9Hllt7PHnNbpbD5ZxH5l2MWedO498T/7kcts1p/USJeGFlWGRNlK6izDZLNaXhGfCW9cR2M1CbFlWVxmCTTSm6vKrRH/fujqNXdmzl/BGnl82nj76E6knLmd1JYh00PCDetv2pasGR4iHmXgaCPOmCxfWR3KUFmO18LkooPaS/4mKlkzTWcQ9asZ2qy1GJHfcDs+gJks5oMZH3V+yaXpFpwRISGosllryva3g5Yzro=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 10:10:01.6736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2258e99-d337-4f38-4dbe-08d6ea6723c0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2257
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTA1IGF0IDE1OjA3IC0wNjAwLCBSb2JlcnQgSGFuY29jayB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gDQo+IFNpbmNlIHRoZSBYQURDIGxvZ2ljIGNhbiBiZSB1c2Vk
IHdpdGggc3RhbmRhbG9uZSBYaWxpbnggRlBHQXMsIHRoaXMgZHJpdmVyDQo+IGNhbiBwb3RlbnRp
YWxseSBiZSB1c2VkIHdpdGggdmFyaW91cyBBUk0gcGxhdGZvcm1zLCBub3QganVzdCBaeW5xLg0K
PiBDaGFuZ2UgdGhlIFp5bnEgZGVwZW5kZW5jeSB0byBBUk0gaW4gdGhlIGxpc3Qgb2Ygc3VwcG9y
dGVkIHBsYXRmb3Jtcw0KPiBpbiB0aGUgS2NvbmZpZyBkZXBlbmRlbmNpZXMgZm9yIHRoaXMgZHJp
dmVyLg0KDQpUbyBteSBrbm93bGVkZ2UsIHRoZXJlIGFyZSAzIEZQR0EgcGxhdGZvcm1zIHdpdGgg
QVJNIHN1cHBvcnRlZCBpbiBMaW51eC4NCkFuZCBzeW1ib2xzIGFyZSBBUkNIX1pZTlEsIEFSQ0hf
WllOUU1QICYgQVJDSF9TT0NGUEdBLg0KRm9yIHRoZXNlIEFSTSArIEZQR0EgU29DcywgaXQgaXMg
dXN1YWxseSBwcmVmZXJyZWQgdG8gbGlzdCB0aGUgc3VwcG9ydGVkL3Rlc3RlZCBBUk0gKyBGUEdB
IHBsYXRmb3JtcyBpbiBLY29uZmlnLg0KDQpJIGFtIGN1cmlvdXM6IGFyZSB5b3UgdXNpbmcgc29t
ZXRoaW5nIHRoYXQgaXNuJ3QgaW4gdGhlIGFib3ZlIGxpc3Q/DQoNClRoYW5rcw0KQWxleA0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgSGFuY29jayA8aGFuY29ja0BzZWRzeXN0ZW1zLmNh
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9LY29uZmlnIHwgMiArLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vYWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiBpbmRl
eCBmOTZhNzcwLi45Mzg2M2JiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvS2NvbmZp
Zw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiBAQCAtMTA4NSw3ICsxMDg1LDcg
QEAgY29uZmlnIFZJUEVSQk9BUkRfQURDDQo+IA0KPiAgY29uZmlnIFhJTElOWF9YQURDDQo+ICAg
ICAgICAgdHJpc3RhdGUgIlhpbGlueCBYQURDIGRyaXZlciINCj4gLSAgICAgICBkZXBlbmRzIG9u
IEFSQ0hfWllOUSB8fCBNSUNST0JMQVpFIHx8IENPTVBJTEVfVEVTVA0KPiArICAgICAgIGRlcGVu
ZHMgb24gQVJNIHx8IE1JQ1JPQkxBWkUgfHwgQ09NUElMRV9URVNUDQo+ICAgICAgICAgZGVwZW5k
cyBvbiBIQVNfSU9NRU0NCj4gICAgICAgICBzZWxlY3QgSUlPX0JVRkZFUg0KPiAgICAgICAgIHNl
bGVjdCBJSU9fVFJJR0dFUkVEX0JVRkZFUg0KPiAtLQ0KPiAxLjguMy4xDQo+IA0K
