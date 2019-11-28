Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF810C538
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 09:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1IgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 03:36:19 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:4956 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfK1IgT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 03:36:19 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: dJT9flTQuajuGPGe9ikQ7RX6lakOYUnFzYzl7MfYerXbegq1GoAPteeE2PSsWE37CkVJQKIQiM
 vxuFuRCEHrf8ozJz8hlBrNPKebHkUkwoNQGBcS6UNMPbXFF6lIOmR1Kr4FsZ6yZY+KKcJefEZ+
 PJlQiuY77hWc/q32MJtpEXj4Xo9wqrF3YMqAkEMb5mX2AJuakRPlBKdMBg4HtiZHAPZdquO70k
 0zjHvsGndYS9DFJPfmt6jmUyItq7/NBUgXSsDwzoov3QJi0Fe45r5BnskSPHrk9rAItNKCGfFw
 SgE=
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="60025842"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2019 01:36:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Nov 2019 01:36:17 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 28 Nov 2019 01:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuZ1DdwGQQ/hrWPS2/eIkps/d9D9L8GXmr0h6WqbeCwEA2Xe6e1D3RYQg5uM6beLTzQ6d55UaIfXJ9FzUIZjxEl5M8hbffyqGr6QxFTA01n3aeaKcD60HCH3zqY27mXPMMxJ3JrGueFE9y0WmMZNYqPHDd8s0y/RUG7eNN16S5EGDzPn0n0JqN+9ngojOsbNKV0smC0/rsBWpUOvsYbnCLtprXXP1vw2Bs36iZugpytXeN583zI31a9k1KZfny9RhwwOXamP6jYK71/B8jhuhxh+kkl3/X3IIAFzMduBjfIKHTnJs2VNu9S9EnCIhp7xS1xa6M74dcZduzaZFuStWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rmW3pOsLIa/N0sXbp6pIG1p/LSBpD1ES5YlAlAuRQM=;
 b=la3j/3NGPP+WAs3QUWu711yMH9B0TmCGhuQdS6gahZpqaulNJn98xsDAYscyK5vBMeclipAZzRm0Zzy+38dD5i74LNh8RPFvtPwdXZDltxgtdl7mo3OtccCehduwcE9DSljv41beMIYqkIKbxSiSoZVZQ5ZFu9Z+swuqBo4Q28J5VpVt9PtF/Utbj6B7T8Yhv0I4H7WHYknyhNDHLo8yTr60TPNhkVMNIfIzRgGr9nTCrsjZqa6vOmR0hYo1FVhQHE+UBozhjZqTkx9cQWaIhoMhmNieU884xsg2AH6XmCyBYUBvrbjdQCnUbCiEe6+oAjH802l6+CJ0FE8gt3zLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rmW3pOsLIa/N0sXbp6pIG1p/LSBpD1ES5YlAlAuRQM=;
 b=jAYtcaVOBgKO46HRfQSNyE9duMR0QM2Yvjhy6BBCjsQ2b0OKoj1YWaMcKqnjvAY4SzYy23tWzUqUJc7XNNTXpBoEy0rYoWcnUKuOk6K4mFK0aLdeImV974yu/eoY79UXaUFpapXS7zh+LAKUj+GRa21CehiT0MNVEsofmn4lAp8=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 08:36:16 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2495.014; Thu, 28 Nov
 2019 08:36:16 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandru.Ardelean@analog.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <lars@metafoo.de>,
        <Ludovic.Desroches@microchip.com>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>, <jic23@kernel.org>
Subject: Re: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Topic: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Thread-Index: AQHVo6GcybDu2MmyfkWfKAIGUFGv9aegRneA
Date:   Thu, 28 Nov 2019 08:36:16 +0000
Message-ID: <9df3d999-0ec6-a282-d24b-8f7df5f14f6d@microchip.com>
References: <20191023082508.17583-1-alexandru.ardelean@analog.com>
 <17cf55869cc418795d0013c0594ed8fc04381d46.camel@analog.com>
In-Reply-To: <17cf55869cc418795d0013c0594ed8fc04381d46.camel@analog.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0094.eurprd05.prod.outlook.com
 (2603:10a6:207:1::20) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191128103601424
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b2eafbe-ef3a-439e-bab2-08d773de089e
x-ms-traffictypediagnostic: DM5PR11MB1242:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1242B222E70CA55BD75E8494E8470@DM5PR11MB1242.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(51914003)(36756003)(99286004)(5660300002)(2501003)(4001150100001)(8936002)(26005)(53546011)(6506007)(25786009)(102836004)(14444005)(5024004)(186003)(386003)(256004)(54906003)(110136005)(316002)(4326008)(76176011)(66556008)(66446008)(64756008)(66476007)(2906002)(66946007)(6246003)(229853002)(6306002)(6512007)(6436002)(6486002)(31696002)(2201001)(52116002)(6116002)(3846002)(71190400001)(71200400001)(478600001)(81156014)(81166006)(8676002)(966005)(305945005)(11346002)(14454004)(446003)(2616005)(31686004)(7736002)(86362001)(66066001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1242;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cs6ctQ9weDkRgardJfydV7Sn6vSaMyV7kJzrFzn3gSh9zHCw2XnJtltgwM6rCYUGV5xURuwAzK8gR1gJeBEPdsLoGHTEEwckpWOvRk5qW5lPrsW8FRJSvvGCZONSjOka7Odp7/lJO+FnXMCLbRXaJEJJ6V2oXzW4v46ZODfbokW2j7uXvajqcbKPd/C9cHBvNgQFaumDRJgRMbfg1fn1SEj5cxzfVSeQpdSbuq3eA3ilRf0uli8Nc8nIBHOeTSWdoc4gxuPXR2Ayxy9cVvdboA4ZO9yAXwSSYkwDSKABBZ9Nktn8CKPQ4SyTY2RIuTqzHE0FoYrk8U5PpkEdmqvib6dmGQQMifWuxx0w4TFGjip/YXFqBx+/KrUWVQqpTIy8nFyqw5rxo3RsuJx3r9c70e8//mhBeAJznlxE5We47KA+AbciCNkgdk+wMOSlvIjfmDavlGJ6m1XVzieG81pMcAaM/GpAKtAApUrW5cRySEQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8739BBE5179FFC4A98A2E10F7E17C8FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2eafbe-ef3a-439e-bab2-08d773de089e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 08:36:16.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTGlS321QWkZBFrY/YH40zmVe2fiyYeQcgR2/RetLUyBPYd0+LxSHwLjR7mSsQOA9PU4ahpWxCuBAT17KjdzNUX++4qgiZNLqgyIWdcggj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1242
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDI1LjExLjIwMTkgMTc6MDMsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+IE9u
IFdlZCwgMjAxOS0xMC0yMyBhdCAxMToyNSArMDMwMCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3Rl
Og0KPj4gVGhlIGlpb190cmlnZ2VyZWRfYnVmZmVyX3twcmVkaXNhYmxlLHBvc3RlbmFibGV9IGZ1
bmN0aW9ucyBhdHRhY2gvZGV0YWNoDQo+PiBwb2xsIGZ1bmN0aW9ucy4NCj4+DQo+PiBUaGUgaWlv
X3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSgpIHNob3VsZCBiZSBjYWxsZWQgZmlyc3QgdG8g
YXR0YWNoDQo+PiB0aGUNCj4+IHBvbGwgZnVuY3Rpb24sIGFuZCB0aGVuIHRoZSBkcml2ZXIgY2Fu
IGluaXQgdGhlIGRhdGEgdG8gYmUgdHJpZ2dlcmVkLg0KPj4NCj4+IFNpbWlsYXJseSwgaWlvX3Ry
aWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZSgpIHNob3VsZCBiZSBjYWxsZWQgbGFzdCB0bw0KPj4g
Zmlyc3QNCj4+IGRpc2FibGUgdGhlIGRhdGEgKHRvIGJlIHRyaWdnZXJlZCkgYW5kIHRoZW4gdGhl
IHBvbGwgZnVuY3Rpb24gc2hvdWxkIGJlDQo+PiBkZXRhY2hlZC4NCg0KSGkgQWxleGFuZHJ1LA0K
DQpTb3JyeSBmb3IgdGhpcyBsYXRlIHJlcGx5LA0KDQpJIHJlbWVtYmVyIHRoYXQgYnkgYWRkaW5n
IHNwZWNpZmljIGF0OTFfYWRjIGNvZGUgZm9yIA0KcHJlZGlzYWJsZS9wb3N0ZW5hYmxlICwgSSB3
YXMgcmVwbGFjaW5nIHRoZSBleGlzdGluZyBzdGFuZGFyZCBjYWxsYmFjayANCndpdGggbXkgb3du
LCBhbmQgaGF2ZSBteSBzcGVjaWZpYyBhdDkxIGNvZGUgYmVmb3JlIHBvc3RlbmFibGUgYW5kIHRo
ZW4gDQpjYWxsaW5nIHRoZSBzdWJzeXN0ZW0gcG9zdGVuYWJsZSwNCmFuZCBpbiBzaW1pbGFyIHdh
eSwgZm9yIHByZWRpc2FibGUsIGZpcnN0IGNhbGwgdGhlIHN1YnN5c3RlbSBwcmVkaXNhYmxlIA0K
dGhlbiBkb2luZyBteSBwcmVkaXNhYmxlIGNvZGUgKGluIHJldmVyc2Ugb3JkZXIgYXMgaW4gcG9z
dGVuYWJsZSkNCg0KSWYgeW91IHNheSB0aGUgb3JkZXIgc2hvdWxkIGJlIHJldmVyc2VkIChiYXNp
Y2FsbHkgaGF2ZSB0aGUgcG9sbGZ1bmN0aW9uIA0KZmlyc3QpLCBob3cgaXMgY3VycmVudCBjb2Rl
IHdvcmtpbmcgPw0KU2hvdWxkIGN1cnJlbnQgY29kZSBmYWlsIGlmIHRoZSBwb2xsIGZ1bmN0aW9u
IGlzIG5vdCBhdHRhY2hlZCBpbiB0aW1lID8gDQpPciB0aGVyZSBpcyBhIHJhY2UgYmV0d2VlbiB0
cmlnZ2VyZWQgZGF0YSBhbmQgdGhlIGF0dGFjaG1lbnQgb2YgdGhlIA0KcG9sbGZ1bmMgPw0KDQpJ
IGFtIHRoaW5raW5nIHRoYXQgYXR0YWNoaW5nIHRoZSBwb2xsZnVuYyBsYXRlciBtYWtlcyBpdCB3
b3JrIGJlY2F1c2UgDQp0aGUgRE1BIGlzIG5vdCBzdGFydGVkIHlldC4gV2hhdCBoYXBwZW5zIGlm
IHdlIGhhdmUgdGhlIHBvbGxmdW5jIA0KYXR0YWNoZWQgYnV0IERNQSBpcyBub3Qgc3RhcnRlZCAo
YmFzaWNhbGx5IHRoZSB0cmlnZ2VyIGlzIG5vdCBzdGFydGVkKSAsIA0KY2FuIHRoaXMgbGVhZCB0
byB1bmV4cGVjdGVkIGJlaGF2aW9yID8gTGlrZSB0aGUgcG9sbGZ1bmMgcG9sbGluZyBidXQgbm8g
DQp0cmlnZ2VyIHN0YXJ0ZWQvbm8gRE1BIHN0YXJ0ZWQuDQoNCj4+DQo+PiBGb3IgdGhpcyBkcml2
ZXIsIHRoZSBwcmVkaXNhYmxlICYgcG9zdGVuYWJsZSBob29rcyBhcmUgYWxzbyBuZWVkIHRvIHRh
a2UNCj4+IGludG8gY29uc2lkZXJhdGlvbiB0aGUgdG91Y2hzY3JlZW4sIHNvIHRoZSBob29rcyBu
ZWVkIHRvIGJlIHB1dCBpbiBwbGFjZXMNCj4+IHRoYXQgYXZvaWQgdGhlIGNvZGUgZm9yIHRoYXQg
Y2FyZXMgYWJvdXQgaXQuDQo+Pg0KPiANCj4gcGluZyBoZXJlDQo+IA0KPj4gU2lnbmVkLW9mZi1i
eTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4+
IC0tLQ0KPj4gICBkcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIHwgMTkgKysrKysr
KysrKy0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2Ft
YTVkMl9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLQ0KPj4gc2FtYTVkMl9hZGMuYw0KPj4g
aW5kZXggZTE4NTBmM2Q1Y2YzLi5hYzNlNWM0Yzk4NDAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5
MS1zYW1hNWQyX2FkYy5jDQo+PiBAQCAtODg5LDIwICs4ODksMjQgQEAgc3RhdGljIGludCBhdDkx
X2FkY19idWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QNCj4+IGlpb19kZXYgKmluZGlvX2RldikNCj4+
ICAgICAgICBpZiAoIShpbmRpb19kZXYtPmN1cnJlbnRtb2RlICYgSU5ESU9fQUxMX1RSSUdHRVJF
RF9NT0RFUykpDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+DQo+PiArICAg
ICByZXQgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+PiAr
ICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gICAg
ICAgIC8qIHdlIGNvbnRpbnVlIHdpdGggdGhlIHRyaWdnZXJlZCBidWZmZXIgKi8NCj4+ICAgICAg
ICByZXQgPSBhdDkxX2FkY19kbWFfc3RhcnQoaW5kaW9fZGV2KTsNCj4+ICAgICAgICBpZiAocmV0
KSB7DQo+PiAgICAgICAgICAgICAgICBkZXZfZXJyKCZpbmRpb19kZXYtPmRldiwgImJ1ZmZlciBw
b3N0ZW5hYmxlIGZhaWxlZFxuIik7DQo+PiArICAgICAgICAgICAgIGlpb190cmlnZ2VyZWRfYnVm
ZmVyX3ByZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4+ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+PiAgICAgICAgfQ0KPj4NCj4+IC0gICAgIHJldHVybiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9w
b3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+PiArICAgICByZXR1cm4gMDsNCj4+ICAgfQ0KPj4NCj4+
ICAgc3RhdGljIGludCBhdDkxX2FkY19idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2KQ0KPj4gICB7DQo+PiAgICAgICAgc3RydWN0IGF0OTFfYWRjX3N0YXRlICpzdCA9
IGlpb19wcml2KGluZGlvX2Rldik7DQo+PiAtICAgICBpbnQgcmV0Ow0KPj4gICAgICAgIHU4IGJp
dDsNCj4+DQo+PiAgICAgICAgLyogY2hlY2sgaWYgd2UgYXJlIGRpc2FibGluZyB0cmlnZ2VyZWQg
YnVmZmVyIG9yIHRoZSB0b3VjaHNjcmVlbiAqLw0KPj4gQEAgLTkxNiwxMyArOTIwLDggQEAgc3Rh
dGljIGludCBhdDkxX2FkY19idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlvX2Rldg0KPj4gKmlu
ZGlvX2RldikNCj4+ICAgICAgICBpZiAoIShpbmRpb19kZXYtPmN1cnJlbnRtb2RlICYgSU5ESU9f
QUxMX1RSSUdHRVJFRF9NT0RFUykpDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4+DQo+PiAtICAgICAvKiBjb250aW51ZSB3aXRoIHRoZSB0cmlnZ2VyZWQgYnVmZmVyICovDQo+
PiAtICAgICByZXQgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7
DQo+PiAtICAgICBpZiAocmV0IDwgMCkNCj4+IC0gICAgICAgICAgICAgZGV2X2VycigmaW5kaW9f
ZGV2LT5kZXYsICJidWZmZXIgcHJlZGlzYWJsZSBmYWlsZWRcbiIpOw0KPj4gLQ0KPj4gICAgICAg
IGlmICghc3QtPmRtYV9zdC5kbWFfY2hhbikNCj4+IC0gICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4+ICsgICAgICAgICAgICAgZ290byBvdXQ7DQo+Pg0KPj4gICAgICAgIC8qIGlmIHdlIGFyZSB1
c2luZyBETUEgd2UgbXVzdCBjbGVhciByZWdpc3RlcnMgYW5kIGVuZCBETUEgKi8NCj4+ICAgICAg
ICBkbWFlbmdpbmVfdGVybWluYXRlX3N5bmMoc3QtPmRtYV9zdC5kbWFfY2hhbik7DQo+PiBAQCAt
OTQ5LDcgKzk0OCw5IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX3ByZWRpc2FibGUoc3Ry
dWN0IGlpb19kZXYNCj4+ICppbmRpb19kZXYpDQo+Pg0KPj4gICAgICAgIC8qIHJlYWQgb3ZlcmZs
b3cgcmVnaXN0ZXIgdG8gY2xlYXIgcG9zc2libGUgb3ZlcmZsb3cgc3RhdHVzICovDQo+PiAgICAg
ICAgYXQ5MV9hZGNfcmVhZGwoc3QsIEFUOTFfU0FNQTVEMl9PVkVSKTsNCj4+IC0gICAgIHJldHVy
biByZXQ7DQo+PiArDQo+PiArb3V0Og0KDQoNCkkgd291bGQgcHJlZmVyIGlmIHRoaXMgbGFiZWwg
aXMgbmFtZWQgd2l0aCBhIGZ1bmN0aW9uIG5hbWUgcHJlZml4LCANCm90aGVyd2lzZSAnb3V0JyBp
cyBwcmV0dHkgZ2VuZXJpYyBhbmQgY2FuIGNvbGxpZGUgd2l0aCBvdGhlciB0aGluZ3MgaW4gDQp0
aGUgZmlsZS4uLiBJIHdhbnQgdG8gYXZvaWQgaGF2aW5nIGFuIG91dDIgLCBvdXQzIGxhdGVyIGlm
IGNvZGUgY2hhbmdlcy4NCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2gsDQpFdWdlbg0KDQo+PiArICAg
ICByZXR1cm4gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPj4g
ICB9DQo+Pg0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzIGF0
OTFfYnVmZmVyX3NldHVwX29wcyA9IHsNCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KPiANCg==
