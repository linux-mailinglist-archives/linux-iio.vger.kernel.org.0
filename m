Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297221BF329
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD3Iml (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 04:42:41 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:33340 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgD3Iml (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 04:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588236161; x=1619772161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vKi806RWge+d+/XxlV+C/6/J77zXeXTTY+wxg1WRG8M=;
  b=F+uOZzUu4ITeuZdD85qoOivbdCQSHcauMsXBN0NRyJMc4UsjYyN1U7G4
   IxVxSPf0wEZMtHE3Uy1jqXnX0b4OHGngbwgskyVgMk+HkU0TPoqoFO3pc
   xyJ+Cp05WbOavbD92NrD6Y8k0F66kOeCa008okkXuUb7U0XKkFSIF4miW
   etm4abbqGH0tFX8vMoL4oW8UvIWmy1PEvlN6449XoZsJVmhoBlk2crw0p
   962oJEVK1+beGaMSzrQTaH/zF36PdjNmeEUDYi32Dxohnmip6l3Bgy12v
   JXQn/et+OdiD9Vmb9I3dnwQmLUFywqBT7ef9VjQrE91+KA6p+GE5BZuW2
   Q==;
IronPort-SDR: Qb0oj2jHT57A2pdbWyupVeCTUL2sjBVEatf3pWQu+7I9h3WitjZ7ByUA93AItOooZqkDiSyOjz
 xgoy59jcgYjJ3eQCvdjkhut7BxzVsahOMFkvG3hUGJGYdivtbNRnYtDQXNJq9sU1irnKH1Yfb8
 ngiVh4azlMhCcq/NrGkKrRyK4SMb4Q630eY9BrvVexPoeh2erYGO1NcbBGmxPMSrDxP3taW9j3
 cR5OUYm2N0JS6yeihKXKvkgaNUWPP/vMVI6k7DyORnXgShLxw1EnnmYkILqWrcU/RpwAmn+Jlc
 caM=
X-IronPort-AV: E=Sophos;i="5.73,334,1583218800"; 
   d="scan'208";a="74349227"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Apr 2020 01:42:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Apr 2020 01:42:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 Apr 2020 01:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqkq+StodtQTtM9TrSxvdZ3xC28q8PrtHWLLaAQ7kvDwYJINMdthNsNGAnsFoSF7ywg6NZpBS3DiSgtBia50Syqe4sp6RZkyxBI+LXIoC86QHXTocqiByoK1WL10FdRpXWKd1toSymHI2i+M7A0XStL23FqXGJ+WL+tW/NMzRMNkcRcv7cO0syv/riVv+muIwktQ5HQRAWaNmYHSDXK4HqXl9K2TWi41Ctf31ktPfzr5vOl7+dVZeAQCPlASH6QygApzT99sNALKplub7yfTAdYUaiPDHxQf61xFl4OaBkBpfWFS4XIjDQN4Blj7S9QeA94wBybuW6nhr9F4NOzkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKi806RWge+d+/XxlV+C/6/J77zXeXTTY+wxg1WRG8M=;
 b=QSDNKLI84zuEYmhf8tWY80QkZqUhnmP02Ql3AxXwzrxr30usS6FWwX4+UZV7Upq92Pv6cEKCiSum1xM1JoOrbBh3kdPatOHFl68yRA9B4/oBEsOXwHb+kdv+UjWlQaP5KrXHeo/LJuf0Yx0ZUrgzvkMGuLbiv2ttwzolNs9kZxqr2bWHfZKZTdRxe1Sq53d+PO0ytl56EQYKUa3UbfNt97a0aH/0v7rLRHyvVky0WQmq4Iu06D75naSTmS4So/IAZlVAMdYsrRht1NvBcyj2q0yA507mj5jzmE/IIicktd8aNVZiY2H39KEQGfuK96B+JYOEZlM+SEOjtwqkiv1bXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKi806RWge+d+/XxlV+C/6/J77zXeXTTY+wxg1WRG8M=;
 b=SMSAjoV2oSsGAlDYjb/VDmPj163BnlYe3CmoJv9HVd5zdTOCZD0OZlrQl6B1C+Trc/KTb8Jga3jd7cSlF2tZDimequuCFjVmK94go7Gsjldne4dD8Ao+OFBZet0lXtsmTXff48encwQ8gpsDbFqyz+G/EpXUwMVgmkg+Y9sIFoA=
Received: from CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22)
 by CY4PR11MB1317.namprd11.prod.outlook.com (2603:10b6:903:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 08:42:37 +0000
Received: from CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b]) by CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b%12]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 08:42:37 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [RFC PATCH] iio: __iio_update_buffers: Update mode before
 preenable/after postdisable
Thread-Topic: [RFC PATCH] iio: __iio_update_buffers: Update mode before
 preenable/after postdisable
Thread-Index: AQHWHsjeKE5QM+3ps0uLCt3MtXdmgaiRWQYA
Date:   Thu, 30 Apr 2020 08:42:37 +0000
Message-ID: <0096231b-eda4-7685-3411-3de467618c25@microchip.com>
References: <20200430082455.1628-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200430082455.1628-1-alexandru.ardelean@analog.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.24.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7015aa57-3409-4a6d-cd5c-08d7ece26f69
x-ms-traffictypediagnostic: CY4PR11MB1317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1317225102A55479138B1615E8AA0@CY4PR11MB1317.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(366004)(346002)(39860400002)(376002)(76116006)(6486002)(91956017)(6512007)(64756008)(66556008)(186003)(66446008)(66946007)(107886003)(110136005)(316002)(66476007)(5660300002)(4326008)(54906003)(71200400001)(2616005)(15650500001)(2906002)(31686004)(36756003)(26005)(8676002)(6506007)(53546011)(966005)(31696002)(478600001)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmmPcMBbE7cxDsG9UsQONutQ3Dhaimoi92eCM65Rs5qdgXL3bzo0DO5vuGotBzVrnkQ3tYoFAPpQfhGW7t6lJL5x62PhwK0/gsf4liTlasXY7Ke/jzSIvn57ORAh+l8lDf226d47QppY9HNnTCrIdoOWGec1SF6fd8k0Rp30BeuGCEydb2/MVYj48r8/Hf4khl94ZxM6V/5K7h53zT/nyjMxBgP8CjNlFrMq9405I14szSAJnuFT6F0tWKsOYwN3hs927e1PQorpnop3B8ErFTA4XbVk97bWzmJuyFAGx59RUftHAX9A5kD/DdM76COhlz/4wppU9NGjKp/KcwnLsnJAg22RfgPWud9eag/beQaPQMyIrebvQtiTDQTlHd1UAz2HlmYRvZiP/KqZDYf11BV7y/t6WKlTJOveOU/EiKF33jv6sNPkaa7CZ3xkJ01r45gbVLrSp5oMMh3HadLyIGcv4+QWZ74Pzfo/K8KO7EWEg+YsBExqjv5f4K27ZtjSgsybCIBiMyxwdhSmnepJOg==
x-ms-exchange-antispam-messagedata: 5Evrs6mJSjl06hYmQHj80DcZbs4QtNYSh9XoPHqRDAH3Fpke/NhmbTJ68qlaAtX4CQHVbRWAvACxVKBRzxsVbOSfYJrWX2gnkSiPE3GZdzu8T96cfGh2KrcGRzjTs25OJz+ORsZSvqqQekxEPIWxm5eaR+7FYW8d2UP/3z4Z8EQFJ5Qbnkw9rhMMzNc6hq1k3zR28mzYynowr6n7NUKvkthEe+BApKcQt8pM3qJbDsD+QcOXuHkczZ1XBjHpT1mDhhXuWDBFxN3TCAPJC25GItaHace94x4q00vH+j6VJVdnks9hwHz8CFNHMLXuRLMFt7U61HwFJCbx8/NBtKX7rIQtkZ+rr7GRAAvpQiYrHIj4Mqe5HwSSMD3XH9FkkAiQ1AnYPBBsGpLZh40J+5DkQ/oUXE0lXuij3sHfOsUtnPgVkSpvAIyPowGIcb/fJsqSBWi8d+EqZBr1QEPEKXGWRsS3ftweFjcrhPmbihaRclJ7GtTYb+T5VXDfFKKupJ85HAnWt8r/KUUZyQcbFW5scaZ1wlsHicDOeFNob2PIZPu5inQlniHudcdKwe5aY4Y1eUUXch+hfKZ4cHOZJGcUxdJ1QCf3V4b5Epuaf70vDS/Mn1g6of0cm+PYJbOMObgcVNRae/T7T4JN9mPzbeLEu7RRUtu8Rk8aZomIzUoUkl1oWSLnU5XybMK30SZJdPezew0BI263K9W4XemP7AgsjlKvgDdYrtPBuTLyLFdrZF2bwiJQPHI7tNgutH2CFfrUBme9LbVRNT/nCoKbYFiVg6g5n6KKuqNq6ZjTRIpp3cs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED6286F8E5294B439461A3E82A75BED7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7015aa57-3409-4a6d-cd5c-08d7ece26f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 08:42:37.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZk3N7IuPs6yPWUQkzDe7N00fqP8cKMtmYRIYiy6INikvKWRSpPbhpbUZirz/uP+uJs5kRUrv/s6BBHLHq6LVByg0vheFe8nO8pUUN8OGZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1317
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMzAuMDQuMjAyMCAxMToyNCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiBGcm9tOiBM
YXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gDQo+IEl0IGlzIGNsZWFyIHRo
YXQgd2UgdHJhbnNpdGlvbiB0byBJTkRJT19ESVJFQ1RfTU9ERSB3aGVuIGRpc2FibGluZyB0aGUN
Cj4gYnVmZmVyKHMpIGFuZCBpdCBpcyBhbHNvIGNsZWFyIHRoYXQgd2UgdHJhbnNpdGlvbiBmcm9t
IElORElPX0RJUkVDVF9NT0RFDQo+IHdoZW4gZW5hYmxpbmcgdGhlIGJ1ZmZlcihzKS4gU28gbGVh
dmluZyB0aGUgY3VycmVudG1vZGUgZmllbGQNCj4gSU5ESU9fRElSRUNUX01PREUgdW50aWwgYWZ0
ZXIgdGhlIHByZWVuYWJsZSgpIGNhbGxiYWNrIGFuZCB1cGRhdGluZyBpdCB0bw0KPiBJTkRJT19E
SVJFQ1RfTU9ERSBiZWZvcmUgdGhlIHBvc3RkaXNhYmxlKCkgY2FsbGJhY2sgZG9lc24ndCBhZGQg
YWRkaXRpb25hbA0KPiB2YWx1ZS4gT24gdGhlIG90aGVyIGhhbmQgc29tZSBkcml2ZXJzIHdpbGwg
bmVlZCB0byBwZXJmb3JtIGRpZmZlcmVudA0KPiBhY3Rpb25zIGRlcGVuZGluZyBvbiB3aGljaCBt
b2RlIHRoZSBkZXZpY2UgaXMgZ29pbmcgdG8gb3BlcmF0ZSBpbi93YXMNCj4gb3BlcmF0aW5nIGlu
Lg0KPiANCj4gTW92aW5nIHRoZSB1cGRhdGUgb2YgY3VycmVudG1vZGUgYmVmb3JlIHByZWVuYWJs
ZSgpIGFuZCBhZnRlciBwb3N0ZGlzYWJsZSgpDQo+IGVuYWJsZXMgdXMgdG8gaGF2ZSBkcml2ZXJz
IHdoaWNoIHBlcmZvcm0gbW9kZSBkZXBlbmRlbnQgYWN0aW9ucyBpbiB0aG9zZQ0KPiBjYWxsYmFj
a3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZv
by5kZT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJk
ZWxlYW5AYW5hbG9nLmNvbT4NCj4gLS0tDQo+IA0KPiBUaGlzIHBhdGNoIGlzIGFsc28gYSBWMiBv
ZiB0aGlzIG9sZGVyIHBhdGNoIGZyb20gYSB3aGlsZSBhZ286DQo+ICAgaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtaWlvLzE0MzE1MjU4OTEtMTkyODUtNS1naXQtc2VuZC1lbWFpbC1sYXJz
QG1ldGFmb28uZGUvDQo+IA0KPiBIb3dldmVyLCBpbiB0aGlzIHJlY2VudCBjb250ZXh0LCBpdCBj
b21lcyB0byBmaXggdGhpczoNCj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1paW8v
YjlhYjY3NjQ4OWRlMzU3NTk4NGRhYzU2MTBmY2YwNWZkODc0MmEzOC5jYW1lbEBhbmFsb2cuY29t
L1QvI21jMDkyODRjOGY3OTI1MGI5MmE1MmZkNWI4ZDFmNTQxZDFjMDJjMGMwDQo+IA0KPiBBdCB0
aGlzIHBvaW50LCBJIGRvbid0IGhhdmUgYSBjbGVhciBpZGVhIGlmIHRoaXMgYXBwcm9hY2ggaXMg
Z29vZCBvcg0KPiBub3Q7IHNpbmNlIHRoZSBtb3RpdmF0aW9uIGlzIHRvIGZpeCB0aGUgYXQ5MSBh
ZGMuDQo+IEhlbmNlIHRoZSBSRkMuDQo+IA0KPiBTb21lIGV4Y2VycHQgZnJvbSB0aGUgQVQ5MSBk
aXNjdXNzaW9uOg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IEkgZGVjaWRlZCB0byBkbyBhIGJpdCBvZiBzaGVs
bCBtYWdpYyBmb3IgdGhpczoNCj4gDQo+IGdldF9maWxlcygpIHsNCj4gZ2l0IGdyZXAgLXcgaWlv
X2J1ZmZlcl9zZXR1cF9vcHMgIHwgZ3JlcCBkcml2ZXJzIHwgY3V0IC1kOiAtZjEgfCBzb3J0IHwg
dW5pcQ0KPiB9DQo+IA0KPiBmb3IgZmlsZSBpbiAkKGdldF9maWxlcykgOyBkbw0KPiAgICAgIGlm
IGdyZXAgLXEgY3VycmVudG1vZGUgJGZpbGUgOyB0aGVuDQo+ICAgICAgICAgIGVjaG8gJGZpbGUN
Cj4gICAgICBmaQ0KPiBkb25lDQo+IA0KPiBJdCBmaW5kcyA0IGRyaXZlcnMuDQo+IFRob3VnaCwg
YGdldF9maWxlcygpYCB3aWxsIHJldHVybiA1NiBmaWxlcy4NCj4gDQo+IGRyaXZlcnMvaWlvL2Fj
Y2VsL2JtYzE1MC1hY2NlbC1jb3JlLmMNCj4gZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9h
ZGMuYw0KPiBkcml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tYWRjLmMNCj4gZHJpdmVycy9paW8v
bWFnbmV0b21ldGVyL3JtMzEwMC1jb3JlLmMNCj4gDQo+IFRoZSBybTMxMDAgZHJpdmVyIGRvZXNu
J3QgZG8gYW55IGNoZWNrcyBpbiB0aGUgc2V0dXBfb3BzIGZvciAnY3VycmVudG1vZGUnIGFzDQo+
IGZhciBhcyBJIGNvdWxkIHNlZS4NCj4gDQo+IFNvLCBMYXJzJyBwYXRjaCBjb3VsZCB3b3JrIG5p
Y2VseSB0byBmaXggdGhpcyBjdXJyZW50IGNhc2UgYW5kIG5vdCBicmVhayBvdGhlcnMuDQo+IA0K
PiBTZW1hbnRpY2FsbHkgdGhvdWdoLCBpdCB3b3VsZCBzb3VuZCBuaWNlciB0byBoYXZlIGEgJ25l
eHRtb2RlJyBwYXJhbWV0ZXINCj4gc29tZXdoZXJlOyBtYXliZSBvbiB0aGUgc2V0dXBfb3BzKGlu
ZGlvX2RldiwgbmV4dG1vZGUpPw0KPiBUaG91Z2gsIG9ubHkgdGhvc2UgMyBkcml2ZXJzIHdvdWxk
IHJlYWxseSBldmVyIHVzZSBpdDsgc28gZG9pbmcgaXQgbGlrZSB0aGF0DQo+IHNvdW5kcyBsaWtl
IG92ZXJraWxsLg0KPiANCj4gU28sIHdlJ3JlIGxlZnQgd2l0aCBMYXJzJyBwYXRjaCBvciB3ZSBj
b3VsZCBhZGQgYW4gJ2luZGlvX2Rldi0+bmV4dG1vZGUnIGZpZWxkLA0KPiB0aGF0IG1heSBiZSB1
c2VkIGluIGp1c3QgdGhlc2UgMyBkcml2ZXJzIFt3aGljaCBhZ2Fpbjogc291bmRzIG92ZXJraWxs
IGF0IHRoaXMNCj4gcG9pbnQgaW4gdGltZV0uDQo+IA0KPiBBbHRlcm5hdGl2ZWx5LCB0aGlzICdp
bmRpb19kZXYtPmN1cnJlbnRtb2RlJyBjb3VsZCBiZSByZW1vdmVkIGZyb20gYWxsIHRoZXNlIDMN
Cj4gZHJpdmVycyBzb21laG93LiBCdXQgdGhhdCBuZWVkcyB0ZXN0aW5nIGFuZCBhIHRob3JvdWdo
IHVuZGVyc3RhbmRpbmcgb2YgYWxsIDMNCj4gZHJpdmVycyBhbmQgd2hhdCB0aGV5J3JlIGRvaW5n
LCB0byBkbyBwcm9wZXJseS4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpIaSBBbGV4LA0KDQpUaGFua3MgZm9y
IGZpbmRpbmcgdGhpcy4gSSB3aWxsIHRlc3QgdGhpcyB3aXRoIHRoZSBhdDkxLXNhbWE1ZDJfYWRj
IA0KZHJpdmVyIG9uIEpvbmF0aGFuJ3MgdGVzdGluZyBicmFuY2guIEkgd2lsbCBsZXQgeW91IGtu
b3cgb2YgdGhlIHJlc3VsdHMuDQoNCkV1Z2VuDQoNCj4gDQo+ICAgZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWJ1ZmZlci5jIHwgOCArKystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
aW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5j
DQo+IGluZGV4IDMwYWY4YWY4ZjMxMi4uZWZjYzQ0YjYyOTQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWJ1ZmZlci5jDQo+IEBAIC05ODksNiArOTg5LDcgQEAgc3RhdGljIGludCBpaW9fZW5h
YmxlX2J1ZmZlcnMoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4gICAgICAgICAgaW5kaW9f
ZGV2LT5hY3RpdmVfc2Nhbl9tYXNrID0gY29uZmlnLT5zY2FuX21hc2s7DQo+ICAgICAgICAgIGlu
ZGlvX2Rldi0+c2Nhbl90aW1lc3RhbXAgPSBjb25maWctPnNjYW5fdGltZXN0YW1wOw0KPiAgICAg
ICAgICBpbmRpb19kZXYtPnNjYW5fYnl0ZXMgPSBjb25maWctPnNjYW5fYnl0ZXM7DQo+ICsgICAg
ICAgaW5kaW9fZGV2LT5jdXJyZW50bW9kZSA9IGNvbmZpZy0+bW9kZTsNCj4gDQo+ICAgICAgICAg
IGlpb191cGRhdGVfZGVtdXgoaW5kaW9fZGV2KTsNCj4gDQo+IEBAIC0xMDI0LDggKzEwMjUsNiBA
QCBzdGF0aWMgaW50IGlpb19lbmFibGVfYnVmZmVycyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfZGlzYWJsZV9idWZmZXJzOw0K
PiAgICAgICAgICB9DQo+IA0KPiAtICAgICAgIGluZGlvX2Rldi0+Y3VycmVudG1vZGUgPSBjb25m
aWctPm1vZGU7DQo+IC0NCj4gICAgICAgICAgaWYgKGluZGlvX2Rldi0+c2V0dXBfb3BzLT5wb3N0
ZW5hYmxlKSB7DQo+ICAgICAgICAgICAgICAgICAgcmV0ID0gaW5kaW9fZGV2LT5zZXR1cF9vcHMt
PnBvc3RlbmFibGUoaW5kaW9fZGV2KTsNCj4gICAgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+
IEBAIC0xMDQyLDEwICsxMDQxLDEwIEBAIHN0YXRpYyBpbnQgaWlvX2VuYWJsZV9idWZmZXJzKHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBidWZmZXJfbGlzdCkNCj4gICAgICAgICAgICAgICAgICBpaW9fYnVm
ZmVyX2Rpc2FibGUoYnVmZmVyLCBpbmRpb19kZXYpOw0KPiAgIGVycl9ydW5fcG9zdGRpc2FibGU6
DQo+IC0gICAgICAgaW5kaW9fZGV2LT5jdXJyZW50bW9kZSA9IElORElPX0RJUkVDVF9NT0RFOw0K
PiAgICAgICAgICBpZiAoaW5kaW9fZGV2LT5zZXR1cF9vcHMtPnBvc3RkaXNhYmxlKQ0KPiAgICAg
ICAgICAgICAgICAgIGluZGlvX2Rldi0+c2V0dXBfb3BzLT5wb3N0ZGlzYWJsZShpbmRpb19kZXYp
Ow0KPiAgIGVycl91bmRvX2NvbmZpZzoNCj4gKyAgICAgICBpbmRpb19kZXYtPmN1cnJlbnRtb2Rl
ID0gSU5ESU9fRElSRUNUX01PREU7DQo+ICAgICAgICAgIGluZGlvX2Rldi0+YWN0aXZlX3NjYW5f
bWFzayA9IE5VTEw7DQo+IA0KPiAgICAgICAgICByZXR1cm4gcmV0Ow0KPiBAQCAtMTA4MCw4ICsx
MDc5LDYgQEAgc3RhdGljIGludCBpaW9fZGlzYWJsZV9idWZmZXJzKHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSByZXQyOw0KPiAgICAg
ICAgICB9DQo+IA0KPiAtICAgICAgIGluZGlvX2Rldi0+Y3VycmVudG1vZGUgPSBJTkRJT19ESVJF
Q1RfTU9ERTsNCj4gLQ0KPiAgICAgICAgICBpZiAoaW5kaW9fZGV2LT5zZXR1cF9vcHMtPnBvc3Rk
aXNhYmxlKSB7DQo+ICAgICAgICAgICAgICAgICAgcmV0MiA9IGluZGlvX2Rldi0+c2V0dXBfb3Bz
LT5wb3N0ZGlzYWJsZShpbmRpb19kZXYpOw0KPiAgICAgICAgICAgICAgICAgIGlmIChyZXQyICYm
ICFyZXQpDQo+IEBAIC0xMDkwLDYgKzEwODcsNyBAQCBzdGF0aWMgaW50IGlpb19kaXNhYmxlX2J1
ZmZlcnMoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gDQo+ICAgICAgICAgIGlpb19mcmVl
X3NjYW5fbWFzayhpbmRpb19kZXYsIGluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFzayk7DQo+ICAg
ICAgICAgIGluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFzayA9IE5VTEw7DQo+ICsgICAgICAgaW5k
aW9fZGV2LT5jdXJyZW50bW9kZSA9IElORElPX0RJUkVDVF9NT0RFOw0KPiANCj4gICAgICAgICAg
cmV0dXJuIHJldDsNCj4gICB9DQo+IC0tDQo+IDIuMTcuMQ0KPiANCg0K
