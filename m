Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9F1BA376
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgD0MU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 08:20:26 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:51632 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0MUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 08:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587990024; x=1619526024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R43wtvhC24K6pJ14wJlcjzNJdiqCGFsmevQF9ZSkudg=;
  b=uiCyiVvANpw/5UX7DW+3s8B4K6FUkOwdvSTYZElT3rs3zAOZX+UWnMUx
   e+EvlOxySEernax7TXKG46YEB0/5UqjsbgMCVMmkz5nohF14DgebI5jgD
   eGFXBM6C2y/oUFKoafpdugYlKLfyL1+Og4Gq3YqZ1T1QEszsUNRFpPTph
   ooWz5nfNoXw5NRG2+ts28basBbAIyWEQGWyXy4cg6bMVwPBuvwRGNkvnt
   JxfmJAvWnUBkKXy6bKOKCN/MA+9ojxMykmQfy+PBilrY/2oqJYRJyNU+T
   W3/9K7gA1G8GHZnp9HqNeOqCfE1CUCY0QjKx6VqQq20IIZNBT+eDt6Db4
   Q==;
IronPort-SDR: Ff+1U8+21c8tFd55A5kT2CuszM4BTgmjSmQtTdUFXSw/0L/V0nzj/UkN36xzzKkAAeo0dwXwcJ
 FUfBaastvBVv74ouW3HiU6grdo+CcJt1+gsDiqgcx5QwcXZfR+EJc2SgtEVXN3gAtA470RRq1s
 2cvGw5FvfmbLnTZ1q/t4ppGp1h37aqjOJyXz4gOYNlvc2tdMMDj8QJmuqWZzLAlu4rwSXBoKki
 COT83JqlKoGg4m51C3jgpD/VRnUOz0ESy6Zer5IAoyY9Knrm1MQsZBx5yZOPu5aqvnvlP4aWak
 Q2w=
X-IronPort-AV: E=Sophos;i="5.73,324,1583218800"; 
   d="scan'208";a="74670077"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2020 05:20:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Apr 2020 05:20:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 27 Apr 2020 05:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiPsiqbaMlubxS35CJTjAescls1XQr5S/HKIPJsj3GJbffmcLa2B6PxKzIoOxlMMLUtwMRt553ABpFeJ+E2Rvs6KsAJj0nD/BHUihLxVb8bRklbkgMYEIZXJfZls/rhuXINEqNhwZl3+nryjNBqXzNAxDbA8W0YXn+mAWF4D7nUYionGLPv+zrrivNPERTWBT7uaSqTBwrQtMOTH1ELn0SrdzsppzGABykH/xuOsnKM5L/+BHUz5cMvAmhY/6JPvQ/AOINKVUkWeMDx8PgIRyQtYstKHdWe98PlCrsUTdx85DbhBZCr/za0E5HXyJcslLJKnMjfKDtiL/fkqa7iJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R43wtvhC24K6pJ14wJlcjzNJdiqCGFsmevQF9ZSkudg=;
 b=Z5fph3YInBdtQqZNCvYVZoUwyB5h3HEjcQz7u8vS+ggNFettyPx5E62H0LeGTwkJI1DcndaagWrBBpd0fJInT4bPaHamlb4wcbwR1LOkefso6xgvGZC4o99/iU6LhUn3NEtLjfTKa4Qip+PJieoAnARBwjobz7WEafJhwCJyhkdOMA9C2S9XQxk8/TLB/kAEIX1EGJ0k974Yl8FPuipgTHTx0++u5OcsXIEQWzx5tzmwAd9/GwiXwcxR/Vi1hwrIpVP7wqvMLw4mfwaRUSo/T8zLFvzNFtrcgSHWb1QPpffCBkTkIMvsKUHU/O6eKD5vRwdbALagtuySi/TG9YO/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R43wtvhC24K6pJ14wJlcjzNJdiqCGFsmevQF9ZSkudg=;
 b=Rk9oVjZ2HJ3KRliAH2XLpP3vyq1Hs/cz0kFIcoSZ9Qdll/k7DvFWV2FUNFiCrye1I+laOBX8kBmE6BRnbkuh0zCSQPHyQ3jzHNyyhCMbzAZUxpaSvKhejtMjk2PUANNGtKUyEQrFnAwek0/Y/MnOsbqDOsZ+uelgN01RsDLa+IE=
Received: from CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22)
 by CY4PR11MB1797.namprd11.prod.outlook.com (2603:10b6:903:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 12:20:15 +0000
Received: from CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b]) by CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b%12]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 12:20:14 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandru.Ardelean@analog.com>, <jic23@kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Thread-Topic: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Thread-Index: AQHV8gB3ISKFiu2vJ0SQVLw/xGJ2m6h3h5YAgAFDNICAAFoRgIAA1qKAgBM86AA=
Date:   Mon, 27 Apr 2020 12:20:14 +0000
Message-ID: <208699ad-1302-aac1-c2e7-4f469e39a7eb@microchip.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
 <20200413180556.20638f3b@archlinux>
 <9315e9a7-0703-b119-ca32-69f0c2fcc7de@microchip.com>
 <20200414184505.0cd39249@archlinux>
 <f13b4286c5f133e7461d59965d7f84af059c8e89.camel@analog.com>
In-Reply-To: <f13b4286c5f133e7461d59965d7f84af059c8e89.camel@analog.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-originating-ip: [86.120.188.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c08de7b0-4e62-4e0d-0d72-08d7eaa55730
x-ms-traffictypediagnostic: CY4PR11MB1797:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1797435D9A9425A8EDCD4B37E8AF0@CY4PR11MB1797.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(136003)(39860400002)(366004)(478600001)(76116006)(71200400001)(966005)(36756003)(66556008)(6512007)(66476007)(66946007)(2906002)(110136005)(54906003)(64756008)(6486002)(4326008)(66446008)(316002)(5660300002)(8676002)(6506007)(31696002)(86362001)(26005)(2616005)(81156014)(53546011)(8936002)(186003)(31686004)(309714004);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhS11KuPiCmDBRlLUtlYMdc026EBnsazY0WhCDm3MK1tOHUqIY/ThpO1YHm8FUZkgCkfFlWyILOjsrndxgH0dakafn+47DPXI6gKpuV8fsGrmqqE4PcFNc/QJ03EOlzZf5JqxGzX3Z+UUnbJdQSMgJJG/qWQHj+iOeyt6mAzAA1S8aQ0Hkyo/vzwrvTkmA414CSFtUYPGeAXaZ5RlyyXMdl6ecOPczlEVswfXWGpCR2CwkBH4DGIlPU+ao6x3WmU4gPXmSXKRaXOL+JLDccVSdmVP/s662OPvWrc51ZjWiRdbItV0VcYh+iHmfL9ZIvm0Z61M5MH9RgdbTwJwflOfR0F5KkcGeE7iQymXrRvx+pNl9OKTKcCWC+9tGNzfuM8W9Y9418B7/kr3bLN75OobQSm+smwn/PEKC7KqO0OTqCPjp9EAXyiYkZfbYLH8XuEHAZpFxH570eGfJYmsEuHYXBckBw6fWL3aTWeyGKzjuGFaUUBuZ+tK2IusmSQzdKMxJlzeza7niDKemMWs/lZSLg0UtpNeWJS0ra2/jFyDIoeVFxPoCniqw0VJCVY28by
x-ms-exchange-antispam-messagedata: rpWA5M90tsF15ZrbsnmjyNTDLQAjbJsl10QdaaTa2/Ph+cxfHI2nzLQDaqN/x21A7HhSHFEKSM68lQWPNFt/QVEsVmAnuO+ggXkmXGBvZQLtJPZZ275WemnJyxEEOteDW+WlGA8YVeD3tjN/ykcoTtiwjGPJnLEuavdqs3v9Q1EyIM2P8RcmyINISG1MBmeDEI3WmLXqu5LXyldXKXKlRTJ1/lHJBIEDoZ86m0LfDFG63LuLCGv7KE0pqocYCKQ0L5JF7rqPQxjOLZpm356w2Ve63aD+uFwvSQDt3wx6BGmdjyDDZfWW0I+XRZjl9s3+fmlPy57CwZ26uJC+CtCK7s8Fx19nUuNmM33P7f9P1oN6y7W7qnqxvlq3N4c/Jhg5QQMLwriGPcVgrr3zJrozGtklourBAlP0D4F26eTkDWvBVrC0mgIf5ySCcB8T7hHrxiWJTF714HeELl/Dvnw3Pi5Dq1VGj+NsUUHhNO4avKF6NErO/xipSSQYpKZDyrw2yYUDYS/m9xcEvHCvYuuahruA3svmZy9kdEw2613N5QoN4pCLmJpIm5qYC7bYJNyJiYPomROqUFZ1RHvxStKJYJj1kJUOtOLALDNedVhgbkebds548iqJHWYAFmxej8IwhQ31+cduTNWukitHEov2HIXsC6IWK7zrFqesuaFQMf+7HraD8bLM3DYBkV0wVUaBcaVM6DcB8X0W4ToKvA62ftV7BJjhN7Cy5PoyKAkqx9a03lWaJvkNtuAc7vUNyFT7OGchiWX9rEiqxpKpuslQyAERMNRlzL2JYi0siFL4tpU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89DEF75074F1FD48B888E813257C08B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c08de7b0-4e62-4e0d-0d72-08d7eaa55730
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 12:20:14.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvSIrRT9FZxYy8S+P61pKw0WfZA7Lx9DJhYnYLPHQEa+ZZ4sKeNDP4ZXsZ1DJzG4JxUo8inNkK8oQJlsrY7eXBQazYllGxLcHMgcPrmHu/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1797
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMTUuMDQuMjAyMCAwOTozMywgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90ZToNCg0KPiBPbiBU
dWUsIDIwMjAtMDQtMTQgYXQgMTg6NDUgKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+
PiBPbiBUdWUsIDE0IEFwciAyMDIwIDEyOjIyOjQ1ICswMDAwDQo+PiA8RXVnZW4uSHJpc3RldkBt
aWNyb2NoaXAuY29tPiB3cm90ZToNCj4+DQo+Pj4gT24gMTMuMDQuMjAyMCAyMDowNSwgSm9uYXRo
YW4gQ2FtZXJvbiB3cm90ZToNCj4+Pj4gT24gV2VkLCA0IE1hciAyMDIwIDEwOjQyOjE4ICswMjAw
DQo+Pj4+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
IHdyb3RlOg0KPj4+Pg0KPj4+Pj4gVGhpcyBjaGFuZ2UgbW92ZXMgdGhlIGxvZ2ljIHRvIGNoZWNr
IGlmIHRoZSBjdXJyZW50IGNoYW5uZWwgaXMgdGhlDQo+Pj4+PiB0b3VjaHNjcmVlbiBjaGFubmVs
IHRvIGEgc2VwYXJhdGUgaGVscGVyLg0KPj4+Pj4gVGhpcyByZWR1Y2VzIHNvbWUgY29kZSBkdXBs
aWNhdGlvbiwgYnV0IHRoZSBtYWluIGludGVudCBpcyB0byByZS11c2UNCj4+Pj4+IHRoaXMNCj4+
Pj4+IGluIHRoZSBuZXh0IHBhdGNoZXMuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQWxl
eGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4+Pj4gRXVn
ZW4gLyBMdWRvdmljLA0KPj4+Pg0KPj4+PiBIYXZlIHlvdSBoYWQgYSBjaGFuY2UgdG8gbG9vayBh
dCB0aGlzIHNlcmllcz8NCj4+Pg0KPj4+IEhpIEpvbmF0aGFuLA0KPj4+DQo+Pj4gRG9lcyB0aGUg
cGF0Y2ggYXBwbHkgY29ycmVjdGx5IGZvciB5b3UgPw0KPj4NCj4+IEkgaGF2ZW4ndCB0cmllZCB5
ZXQgOikNCj4+DQo+IA0KPiBJJ3ZlIHJlYmFzZWQgdGhpcyBwYXRjaHNldCBvbiB0b3Agb2YgY3Vy
cmVudCBpaW8vdGVzdGluZyBhbmQgaXQgc3RpbGwgYXBwbGllcy4NCj4gDQoNCkhpIEFsZXgsDQoN
CkkgdHJpZWQgdGhpcyBwYXRjaCBvbiB0b3Agb2YgbXkgdHJlZSAoaG93ZXZlciBJIGFtIHRlc3Rp
bmcgd2l0aCBhbiBvbGRlciANCmtlcm5lbCA1LjQpICwgYW5kIEkgaGF2ZSBpc3N1ZXMgc3RhcnRp
bmcgdGhlIGJ1ZmZlciBhZnRlciB5b3UgbW92ZWQgbXkgDQpjb2RlIHRvIHRoZSBwcmVlbmFibGUg
Y2FsbGJhY2suDQoNCk5hbWVseSwgb24gdGhlIGxpbmU6DQoNCmlmICghKGluZGlvX2Rldi0+Y3Vy
cmVudG1vZGUgJiBJTkRJT19BTExfVFJJR0dFUkVEX01PREVTKSkNCiAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCg0KQW5kIHdpdGggdGhpcyAsIHRoZSBwcmVlbmFibGUgZmFpbHMgb24g
bXkgc2lkZSwgYmVjYXVzZSB0aGUgY3VycmVudCBtb2RlIA0KaXMgbm90IHlldCBzd2l0Y2hlZCB0
byB0cmlnZ2VyZWQuDQoNCkkgZG8gcmVtZW1iZXIgYWRkaW5nIHRoaXMgbGluZSB3aXRoIGEgc3Bl
Y2lmaWMgcmVhc29uLiBJdCBtYXkgYmUgcmVsYXRlZCANCnRvIHRvdWNoc2NyZWVuIG9wZXJhdGlv
bnMsIGJ1dCBJIGhhdmUgdG8gcmV0ZXN0IHRoZSB0b3VjaCB3aXRoIGFuZCANCndpdGhvdXQgdGhp
cyBsaW5lIGFuZCB5b3VyIHBhdGNoLg0KDQpNZWFud2hpbGUsIG1heWJlIHlvdSBoYXZlIGFueSBz
dWdnZXN0aW9ucyBvbiBob3cgdG8gZml4IHRoZSBidWZmZXIgPyANClRoaXMgY2hlY2sgaGVyZSBt
YWtlcyBhbnkgc2Vuc2UgdG8geW91ID8NCg0KVGhhbmtzLA0KRXVnZW4NCg0KPiANCj4+PiBJIHdp
bGwgdHJ5IHRvIHRlc3QgaXQgLCBpZiBJIG1hbmFnZSB0byBhcHBseSBpdC4NCj4+PiBJIGNhbiBv
bmx5IHRlc3QgdGhlIEFEQyB0aG91Z2ggYmVjYXVzZSBhdCB0aGlzIG1vbWVudCBJIGRvIG5vdCBo
YXZlIGENCj4+PiB0b3VjaHNjcmVlbiBhdCBkaXNwb3NhbC4NCj4+Pg0KPj4+IE1lYW53aGlsZSwg
dGhlIGNvZGUgbG9va3MgZ29vZCBmb3IgbWUsDQo+Pj4NCj4+PiBSZXZpZXdlZC1ieTogRXVnZW4g
SHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4+DQo+Pj4gQnkgdGhlIHdh
eSwgSSBkbyBub3Qga25vdyBpZiBteSB0d28gcGVuZGluZyBwYXRjaGVzIG9uIHRoaXMgZHJpdmVy
IHdpbGwNCj4+PiBjb25mbGljdCBvciBub3QuDQo+Pg0KPj4gQXMgdGhpcyBpcyBhIGxvbmcgdGVy
bSByZXdvcmsgcGF0Y2ggYXQgaGVhcnQsIHRoZXJlIGlzbid0IGFueSBwYXJ0aWN1bGFyDQo+PiBy
dXNoIGFzIGxvbmcgYXMgd2UgZG9uJ3QgbG9vc2UgaXQgZm9yZXZlciENCj4+DQo+PiBUaGFua3Ms
DQo+Pg0KPj4gSm9uYXRoYW4NCj4+DQo+Pj4gRXVnZW4NCj4+Pg0KPj4+PiBUaGFua3MsDQo+Pj4+
DQo+Pj4+IEpvbmF0aGFuDQo+Pj4+DQo+Pj4+PiAtLS0NCj4+Pj4+DQo+Pj4+PiBUaGlzIHBhdGNo
c2V0IGNvbnRpbnVlcyBkaXNjdXNzaW9uOg0KPj4+Pj4NCj4+Pj4+IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1paW8vMjAxOTEwMjMwODI1
MDguMTc1ODMtMS1hbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbS9fXzshIUEzTmk4Q1MweTJZ
IXFsMWJZaU5NUEZsejF0d25DQ0FRcGlFQnZwenhSX1ZIQVBMNzEycldGZnd5MlRTS2paMlVoR0Jv
VjctMjlTeW55NnoweWckDQo+Pj4+Pg0KPj4+Pj4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXkuDQo+
Pj4+Pg0KPj4+Pj4gQ2hhbmdlbG9nIHYxIC0+IHYyOg0KPj4+Pj4gKiBhZGRlZCBwYXRjaCAnaWlv
OiBhdDkxLXNhbWE1ZDJfYWRjOiBzcGxpdA0KPj4+Pj4gYXQ5MV9hZGNfY3VycmVudF9jaGFuX2lz
X3RvdWNoKCkNCj4+Pj4+ICAgICBoZWxwZXInDQo+Pj4+PiAqIHJlbmFtZWQgYXQ5MV9hZGNfYnVm
ZmVyX3Bvc3RlbmFibGUoKSAtPiBhdDkxX2FkY19idWZmZXJfcHJlZW5hYmxlKCkNCj4+Pj4+ICAg
ICAtIGF0OTFfYWRjX2J1ZmZlcl9wb3N0ZW5hYmxlKCkgLSBub3cganVzdCBjYWxscw0KPj4+Pj4g
ICAgICAgaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZSgpIGlmIHRoZSBjaGFubmVsIGlz
bid0IHRoZQ0KPj4+Pj4gdG91Y2hzY3JlZW4NCj4+Pj4+ICAgICAgIGNoYW5uZWwNCj4+Pj4+ICog
cmVuYW1lZCBhdDkxX2FkY19idWZmZXJfcHJlZGlzYWJsZSgpIC0+IGF0OTFfYWRjX2J1ZmZlcl9w
b3N0ZGlzYWJsZSgpDQo+Pj4+PiAgICAgLSBhdDkxX2FkY19idWZmZXJfcHJlZGlzYWJsZSgpIC0g
bm93IGp1c3QgY2FsbHMNCj4+Pj4+ICAgICAgIGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2Fi
bGUoKSBpZiB0aGUgY2hhbm5lbCBpc24ndCB0aGUNCj4+Pj4+IHRvdWNoc2NyZWVuDQo+Pj4+PiAg
ICAgICBjaGFubmVsDQo+Pj4+Pg0KPj4+Pj4gICAgZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVk
Ml9hZGMuYyB8IDMxICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIvZHJp
dmVycy9paW8vYWRjL2F0OTEtDQo+Pj4+PiBzYW1hNWQyX2FkYy5jDQo+Pj4+PiBpbmRleCBhNWM3
NzcxMjI3ZDUuLmYyYTc0YzQ3Yzc2OCAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvaWlvL2Fk
Yy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNh
bWE1ZDJfYWRjLmMNCj4+Pj4+IEBAIC04NzMsMTggKzg3MywyNCBAQCBzdGF0aWMgaW50IGF0OTFf
YWRjX2RtYV9zdGFydChzdHJ1Y3QgaWlvX2Rldg0KPj4+Pj4gKmluZGlvX2RldikNCj4+Pj4+ICAg
ICAgICAgcmV0dXJuIDA7DQo+Pj4+PiAgICB9DQo+Pj4+Pg0KPj4+Pj4gK3N0YXRpYyBib29sIGF0
OTFfYWRjX2N1cnJlbnRfY2hhbl9pc190b3VjaChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0K
Pj4+Pj4gK3sNCj4+Pj4+ICsgICAgIHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QgPSBpaW9fcHJp
dihpbmRpb19kZXYpOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgcmV0dXJuICEhYml0bWFwX3N1YnNl
dChpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2ssDQo+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZzdC0+dG91Y2hfc3QuY2hhbm5lbHNfYml0bWFzaywNCj4+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQVQ5MV9TQU1BNUQyX01BWF9DSEFOX0lEWCArIDEpOw0KPj4+
Pj4gK30NCj4+Pj4+ICsNCj4+Pj4+ICAgIHN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX3Bvc3Rl
bmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+Pj4+ICAgIHsNCj4+Pj4+ICAgICAg
ICAgaW50IHJldDsNCj4+Pj4+ICAgICAgICAgc3RydWN0IGF0OTFfYWRjX3N0YXRlICpzdCA9IGlp
b19wcml2KGluZGlvX2Rldik7DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICAvKiBjaGVjayBpZiB3ZSBh
cmUgZW5hYmxpbmcgdHJpZ2dlcmVkIGJ1ZmZlciBvciB0aGUgdG91Y2hzY3JlZW4NCj4+Pj4+ICov
DQo+Pj4+PiAtICAgICBpZiAoYml0bWFwX3N1YnNldChpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21h
c2ssDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAmc3QtPnRvdWNoX3N0LmNoYW5uZWxz
X2JpdG1hc2ssDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBBVDkxX1NBTUE1RDJfTUFY
X0NIQU5fSURYICsgMSkpIHsNCj4+Pj4+IC0gICAgICAgICAgICAgLyogdG91Y2hzY3JlZW4gZW5h
YmxpbmcgKi8NCj4+Pj4+ICsgICAgIGlmIChhdDkxX2FkY19jdXJyZW50X2NoYW5faXNfdG91Y2go
aW5kaW9fZGV2KSkNCj4+Pj4+ICAgICAgICAgICAgICAgICByZXR1cm4gYXQ5MV9hZGNfY29uZmln
dXJlX3RvdWNoKHN0LCB0cnVlKTsNCj4+Pj4+IC0gICAgIH0NCj4+Pj4+ICsNCj4+Pj4+ICAgICAg
ICAgLyogaWYgd2UgYXJlIG5vdCBpbiB0cmlnZ2VyZWQgbW9kZSwgd2UgY2Fubm90IGVuYWJsZSB0
aGUgYnVmZmVyLg0KPj4+Pj4gKi8NCj4+Pj4+ICAgICAgICAgaWYgKCEoaW5kaW9fZGV2LT5jdXJy
ZW50bW9kZSAmIElORElPX0FMTF9UUklHR0VSRURfTU9ERVMpKQ0KPj4+Pj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPj4+Pj4gQEAgLTkwNiwxMiArOTEyLDkgQEAgc3RhdGljIGlu
dCBhdDkxX2FkY19idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QNCj4+Pj4+IGlpb19kZXYgKmluZGlv
X2RldikNCj4+Pj4+ICAgICAgICAgdTggYml0Ow0KPj4+Pj4NCj4+Pj4+ICAgICAgICAgLyogY2hl
Y2sgaWYgd2UgYXJlIGRpc2FibGluZyB0cmlnZ2VyZWQgYnVmZmVyIG9yIHRoZSB0b3VjaHNjcmVl
bg0KPj4+Pj4gKi8NCj4+Pj4+IC0gICAgIGlmIChiaXRtYXBfc3Vic2V0KGluZGlvX2Rldi0+YWN0
aXZlX3NjYW5fbWFzaywNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICZzdC0+dG91Y2hf
c3QuY2hhbm5lbHNfYml0bWFzaywNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIEFUOTFf
U0FNQTVEMl9NQVhfQ0hBTl9JRFggKyAxKSkgew0KPj4+Pj4gLSAgICAgICAgICAgICAvKiB0b3Vj
aHNjcmVlbiBkaXNhYmxlICovDQo+Pj4+PiArICAgICBpZiAoYXQ5MV9hZGNfY3VycmVudF9jaGFu
X2lzX3RvdWNoKGluZGlvX2RldikpDQo+Pj4+PiAgICAgICAgICAgICAgICAgcmV0dXJuIGF0OTFf
YWRjX2NvbmZpZ3VyZV90b3VjaChzdCwgZmFsc2UpOw0KPj4+Pj4gLSAgICAgfQ0KPj4+Pj4gKw0K
Pj4+Pj4gICAgICAgICAvKiBpZiB3ZSBhcmUgbm90IGluIHRyaWdnZXJlZCBtb2RlLCBub3RoaW5n
IHRvIGRvIGhlcmUgKi8NCj4+Pj4+ICAgICAgICAgaWYgKCEoaW5kaW9fZGV2LT5jdXJyZW50bW9k
ZSAmIElORElPX0FMTF9UUklHR0VSRURfTU9ERVMpKQ0KPj4+Pj4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPj4+Pj4gQEAgLTE4ODYsMTQgKzE4ODksMTAgQEAgc3RhdGljIF9fbWF5
YmVfdW51c2VkIGludCBhdDkxX2FkY19yZXN1bWUoc3RydWN0DQo+Pj4+PiBkZXZpY2UgKmRldikN
Cj4+Pj4+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+Pj4+DQo+Pj4+PiAgICAgICAgIC8q
IGNoZWNrIGlmIHdlIGFyZSBlbmFibGluZyB0cmlnZ2VyZWQgYnVmZmVyIG9yIHRoZSB0b3VjaHNj
cmVlbg0KPj4+Pj4gKi8NCj4+Pj4+IC0gICAgIGlmIChiaXRtYXBfc3Vic2V0KGluZGlvX2Rldi0+
YWN0aXZlX3NjYW5fbWFzaywNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICZzdC0+dG91
Y2hfc3QuY2hhbm5lbHNfYml0bWFzaywNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIEFU
OTFfU0FNQTVEMl9NQVhfQ0hBTl9JRFggKyAxKSkgew0KPj4+Pj4gLSAgICAgICAgICAgICAvKiB0
b3VjaHNjcmVlbiBlbmFibGluZyAqLw0KPj4+Pj4gKyAgICAgaWYgKGF0OTFfYWRjX2N1cnJlbnRf
Y2hhbl9pc190b3VjaChpbmRpb19kZXYpKQ0KPj4+Pj4gICAgICAgICAgICAgICAgIHJldHVybiBh
dDkxX2FkY19jb25maWd1cmVfdG91Y2goc3QsIHRydWUpOw0KPj4+Pj4gLSAgICAgfSBlbHNlIHsN
Cj4+Pj4+ICsgICAgIGVsc2UNCj4+Pj4+ICAgICAgICAgICAgICAgICByZXR1cm4gYXQ5MV9hZGNf
Y29uZmlndXJlX3RyaWdnZXIoc3QtPnRyaWcsIHRydWUpOw0KPj4+Pj4gLSAgICAgfQ0KPj4+Pj4N
Cj4+Pj4+ICAgICAgICAgLyogbm90IG5lZWRlZCBidXQgbW9yZSBleHBsaWNpdCAqLw0KPj4+Pj4g
ICAgICAgICByZXR1cm4gMDsNCj4+Pj4NCg0K
