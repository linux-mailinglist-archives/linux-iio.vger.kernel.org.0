Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E703C1D2DB1
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENK4V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 06:56:21 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:3057 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgENK4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 06:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589453779; x=1620989779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NHTcgBB3mlfcrLEtMExUc4wiT6XNkQvTonsVwUt6aqw=;
  b=pGoftd3/mDU4yR7rKGltoJhd44V7woiE6pIaLmukgKiuWipHi3oWi6KL
   VWcWzQqkyO7lhQ5w8EeiBz0u9bf6ViLlaW2a+m67UbQ9RkaQeOPMyR/yn
   DkeR2AJHYhkKfJQMsYxny3rirERNabhZA/huqgYo8AvQprP/AO4BORmIJ
   D+NtwUF0EkvYv6LlP8lERquE9tuyz0Xdvpl34XpUuwQzGV1uRAwvMkC0I
   1ViHj4wx3yEvWp+CDEhylk+loFiF/uAkTSoGBByPCjtXIxvjVhYpC9faQ
   CLJUUiP97bbDQy5fg/zCejwOC8yx9zv/DyAO7jjpP5K0hfD+Bo4b++t+j
   Q==;
IronPort-SDR: NFT9vdJm7rji+YJigJ8XhSk4s5R21hY2cOkM0sTeiDinArzeDYS1UFAJG1spxzmtwhi7ycL+Z9
 qkeaii/YHkcb9jVPF8kml9oZLnvaYu0vIFuis4fiuMXrhkPvFUzZxmG0WJJtKBJCwRok7Bliqy
 5fhhNAXLDBWDtyyhs1qvFQW/UmHwC1H0eN5KH3LubXwLiY0sK3e40LE7i/YehivRKtjBVlXsGk
 L7msf3WTnYwiHpG7nNWMATcJ0ktLKdL5fbldcl+kvT2QNIosaogB4m843ySgSfo9VCVLbqmxZ+
 YdE=
X-IronPort-AV: E=Sophos;i="5.73,391,1583218800"; 
   d="scan'208";a="73436098"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 May 2020 03:56:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 May 2020 03:56:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 May 2020 03:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGL9rQZBilSo/6EQfEIzD3e0HYxi3bOcf3khYqmpTiZ24fQYG6XMUXQrmm5PIgFEaP+fMizQ9LYaTnnJzsw1EroryrWiR+SB9UGg9gND85XTbRFbIqKHeSYU7ZfQnPVI/zwFfqlS083ugmdToa32yNYje9gd0yq0N3eZ4d5u6x2eFncJwhAqujPfiIfkp57Qp7JCVULKwasf4FMeYAEK1BEtsUq9frfrMCLtzQqsUiSZNVcmAE7hRJuEs5Wl6q9FMP46UkR/h5UmyNch0dY3kTkMS6/6ST2BGa6VF/SWkEQNjfqb3qPYaaBa+zwrWLib4BRMLJ3o6YgduLL52BWczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHTcgBB3mlfcrLEtMExUc4wiT6XNkQvTonsVwUt6aqw=;
 b=ffjWUVwsCCTU1cT4jKla4IcYP1Nj7uYt5yd1uxgrmhXqJtT1EuDDj2jV8RW86Tt1tFAQXtYlv62rrPMTGffIjpyRz+TYKmle7yZgmY9RBBBhYLDU2JuUQ6GZcxssrq5JWEQ/F0EI9fVyy2Xc4nJGw4J5Wmy+d4fmmI3GH+9Tzx2H/gdN8tfZ9NKJM5eEe3LEVVtSqJeF76hNwRj5o/IJl8YCAOMp1144fNSQLM7M33mYR2Y5fyvckbljvh8JdFzhnlXZdc1GqH732QQFzYlZXijW/Lx+gW81RU1E9JEiuZ49xj2lv04kyo2qrBp3j0WBC9qBaOB+lg7NqmVWSex/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHTcgBB3mlfcrLEtMExUc4wiT6XNkQvTonsVwUt6aqw=;
 b=PZCTzuCQgSMx98Ly+KOyAp3HpJaUQdKiUHq3PFOPffr0DEKopP2bGddto7wm1t4TpWl0YIEuCm3qeSYvsPN74BdabwmSUxbvXolAqYWUS4pWf6bAP7xkWxiRmF6POiF5ADu7S8zbu/Pzs7VUjFa2QBsYfAxnhaYYxK7yBN04a4s=
Received: from CY4PR11MB1605.namprd11.prod.outlook.com (2603:10b6:910:10::22)
 by CY4PR11MB2056.namprd11.prod.outlook.com (2603:10b6:903:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 10:56:16 +0000
Received: from CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b]) by CY4PR11MB1605.namprd11.prod.outlook.com
 ([fe80::7c42:c3d3:aaa:88b%12]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 10:56:16 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>
CC:     <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [RFC PATCH] iio: __iio_update_buffers: Update mode before
 preenable/after postdisable
Thread-Topic: [RFC PATCH] iio: __iio_update_buffers: Update mode before
 preenable/after postdisable
Thread-Index: AQHWHsjeKE5QM+3ps0uLCt3MtXdmgaiRWQYAgAaIK4CAD53QgA==
Date:   Thu, 14 May 2020 10:56:16 +0000
Message-ID: <8551295e-c166-674e-c449-61ccb5bbef76@microchip.com>
References: <20200430082455.1628-1-alexandru.ardelean@analog.com>
 <0096231b-eda4-7685-3411-3de467618c25@microchip.com>
 <dbd7fba9-ad26-fb8f-7a71-55b75951409f@microchip.com>
In-Reply-To: <dbd7fba9-ad26-fb8f-7a71-55b75951409f@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.125.21.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ffb1e3f-2137-481e-992a-08d7f7f56d1a
x-ms-traffictypediagnostic: CY4PR11MB2056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB205615D6F3BAAE14BA4C33DEE8BC0@CY4PR11MB2056.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QEMUAGyQiDr947x4U7Cb5CgRb7Gb81HFxC/COOrPfEYHXUsUXFkApW0ldMhOUrnBN86VIWIRYzdOij1CQJ6v5wY/gfOs5bk3cE9KFkm1ov+DbYA4ljiEUvgMx6rpxVk/uf3eIs2mxKRdxG59AV9I8BrBtSBxTdZ/rrMQ3KUKajfG6usxompToltZHp0WHmjnNCKqdNH5iKEkM4YPSBiKtEGkTta7xFQGlQze1dK4tpTyVEakNh01w7jogoqHuwQPtzf3R5z6pEDsFfnzDkf9s8WjRKanlGnbBju0pWZtj5FYjr3b+fbxhcxo+Zu/UJKWEpG4P5ul/yVGIw6ZFl3VOphVBfjFw2k4QBHq+B33BzaMge9cyMH2yMtv3lKxkwQKvC3jayFoh33VgfWZ0xEELKSWv4iRyhHVXSwXcUeVkU8Ohu0jM2DugzkfvMgwhymFJaQNNTu8rx5bNnCnAW9zZrri+CAxDu4lI9wJXO0egWzZ0xrNi3d18dj3rY4y2x3OaPpaMh2FHVVuBtrC2d7o266PBorGxHaDWOg/rF9sI+uRMOhf9/lr3UP+sIK6AqvUwTZyWLPXpCAkgz/41St7fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(54906003)(66946007)(66476007)(316002)(91956017)(76116006)(4326008)(66556008)(66446008)(64756008)(2616005)(966005)(478600001)(6916009)(5660300002)(15650500001)(107886003)(31696002)(6506007)(71200400001)(53546011)(6486002)(8936002)(31686004)(2906002)(26005)(6512007)(186003)(36756003)(8676002)(86362001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Qjm8hOG50eviNm7VZkwYF1GW8BenijN0yjLpi5dmh66xmiss8nX89GVWlLNS1Pjdek/eja9wJhlpqaIPxajkcmatY8eZ6v/m3O3eVOjryEQXHIHV4015QAUI7OWnf2mRiSM84AE1YzbxPFRjuk48Msj/FYHc8IguPHCLzr0rPer5ivVoPWgxg2T91R9y+it/xG0BC+Khk1o/tWYMGN5++nu2IQI6636F/a0oMRZteqRjyMsAjuUqmKPU7Scgr3GNcciw0C5gIKZIejQ58HMeVFdNNhXa9ZBhkC7Dc5wXYEbX5rRkU5JWlkm7A2oGXekyJTKB5gvMGzSu1HOM7jbbTXgY0zSAm/ILSGEvoh1QPGeLrgjeezlLUN4hahjEJp4RxoLscJIASX4oI4zP3SAE+tEsSDWK76YygmzmQ/oZdao0nX5mKeeWZxr8WRwcZMS8vyB10RcR+dHy5M8eNSMTlq3af1FfeV0wL5catgUFWhY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C67B1BC4EF6CF746AB8F37E75052C57A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffb1e3f-2137-481e-992a-08d7f7f56d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 10:56:16.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsDA0SGVz9ZmHAvJg4o62oTlrjtg3lOBCLquMRvTDfwURjttHVvJTOpF/eFG0Nm61Xu5QGi1kCcJEXBsTk2REDkTBt3IB/OWDaBZWz+H2fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMDQuMDUuMjAyMCAxNToyNywgRXVnZW4gSHJpc3RldiAtIE0xODI4MiB3cm90ZToNCj4gT24g
MzAuMDQuMjAyMCAxMTo0MiwgRXVnZW4gSHJpc3RldiAtIE0xODI4MiB3cm90ZToNCj4+IE9uIDMw
LjA0LjIwMjAgMTE6MjQsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4+PiBGcm9tOiBMYXJz
LVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4+Pg0KPj4+IEl0IGlzIGNsZWFyIHRo
YXQgd2UgdHJhbnNpdGlvbiB0byBJTkRJT19ESVJFQ1RfTU9ERSB3aGVuIGRpc2FibGluZyB0aGUN
Cj4+PiBidWZmZXIocykgYW5kIGl0IGlzIGFsc28gY2xlYXIgdGhhdCB3ZSB0cmFuc2l0aW9uIGZy
b20gSU5ESU9fRElSRUNUX01PREUNCj4+PiB3aGVuIGVuYWJsaW5nIHRoZSBidWZmZXIocykuIFNv
IGxlYXZpbmcgdGhlIGN1cnJlbnRtb2RlIGZpZWxkDQo+Pj4gSU5ESU9fRElSRUNUX01PREUgdW50
aWwgYWZ0ZXIgdGhlIHByZWVuYWJsZSgpIGNhbGxiYWNrIGFuZCB1cGRhdGluZyBpdCB0bw0KPj4+
IElORElPX0RJUkVDVF9NT0RFIGJlZm9yZSB0aGUgcG9zdGRpc2FibGUoKSBjYWxsYmFjayBkb2Vz
bid0IGFkZCBhZGRpdGlvbmFsDQo+Pj4gdmFsdWUuIE9uIHRoZSBvdGhlciBoYW5kIHNvbWUgZHJp
dmVycyB3aWxsIG5lZWQgdG8gcGVyZm9ybSBkaWZmZXJlbnQNCj4+PiBhY3Rpb25zIGRlcGVuZGlu
ZyBvbiB3aGljaCBtb2RlIHRoZSBkZXZpY2UgaXMgZ29pbmcgdG8gb3BlcmF0ZSBpbi93YXMNCj4+
PiBvcGVyYXRpbmcgaW4uDQo+Pj4NCj4+PiBNb3ZpbmcgdGhlIHVwZGF0ZSBvZiBjdXJyZW50bW9k
ZSBiZWZvcmUgcHJlZW5hYmxlKCkgYW5kIGFmdGVyIHBvc3RkaXNhYmxlKCkNCj4+PiBlbmFibGVz
IHVzIHRvIGhhdmUgZHJpdmVycyB3aGljaCBwZXJmb3JtIG1vZGUgZGVwZW5kZW50IGFjdGlvbnMg
aW4gdGhvc2UNCj4+PiBjYWxsYmFja3MuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBl
dGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPj4+IC0tLQ0KPj4+
DQo+Pj4gVGhpcyBwYXRjaCBpcyBhbHNvIGEgVjIgb2YgdGhpcyBvbGRlciBwYXRjaCBmcm9tIGEg
d2hpbGUgYWdvOg0KPj4+ICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1paW8vMTQz
MTUyNTg5MS0xOTI4NS01LWdpdC1zZW5kLWVtYWlsLWxhcnNAbWV0YWZvby5kZS8NCj4+Pg0KPj4+
IEhvd2V2ZXIsIGluIHRoaXMgcmVjZW50IGNvbnRleHQsIGl0IGNvbWVzIHRvIGZpeCB0aGlzOg0K
Pj4+ICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1paW8vYjlhYjY3NjQ4OWRlMzU3
NTk4NGRhYzU2MTBmY2YwNWZkODc0MmEzOC5jYW1lbEBhbmFsb2cuY29tL1QvI21jMDkyODRjOGY3
OTI1MGI5MmE1MmZkNWI4ZDFmNTQxZDFjMDJjMGMwDQo+Pj4NCj4+PiBBdCB0aGlzIHBvaW50LCBJ
IGRvbid0IGhhdmUgYSBjbGVhciBpZGVhIGlmIHRoaXMgYXBwcm9hY2ggaXMgZ29vZCBvcg0KPj4+
IG5vdDsgc2luY2UgdGhlIG1vdGl2YXRpb24gaXMgdG8gZml4IHRoZSBhdDkxIGFkYy4NCj4+PiBI
ZW5jZSB0aGUgUkZDLg0KPj4+DQo+Pj4gU29tZSBleGNlcnB0IGZyb20gdGhlIEFUOTEgZGlzY3Vz
c2lvbjoNCj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gSSBkZWNpZGVkIHRvIGRvIGEgYml0IG9mIHNoZWxs
IG1hZ2ljIGZvciB0aGlzOg0KPj4+DQo+Pj4gZ2V0X2ZpbGVzKCkgew0KPj4+IGdpdCBncmVwIC13
IGlpb19idWZmZXJfc2V0dXBfb3BzICB8IGdyZXAgZHJpdmVycyB8IGN1dCAtZDogLWYxIHwgc29y
dCB8IHVuaXENCj4+PiB9DQo+Pj4NCj4+PiBmb3IgZmlsZSBpbiAkKGdldF9maWxlcykgOyBkbw0K
Pj4+ICAgICAgICBpZiBncmVwIC1xIGN1cnJlbnRtb2RlICRmaWxlIDsgdGhlbg0KPj4+ICAgICAg
ICAgICAgZWNobyAkZmlsZQ0KPj4+ICAgICAgICBmaQ0KPj4+IGRvbmUNCj4+Pg0KPj4+IEl0IGZp
bmRzIDQgZHJpdmVycy4NCj4+PiBUaG91Z2gsIGBnZXRfZmlsZXMoKWAgd2lsbCByZXR1cm4gNTYg
ZmlsZXMuDQo+Pj4NCj4+PiBkcml2ZXJzL2lpby9hY2NlbC9ibWMxNTAtYWNjZWwtY29yZS5jDQo+
Pj4gZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4+IGRyaXZlcnMvaWlvL2Fk
Yy9zdG0zMi1kZnNkbS1hZGMuYw0KPj4+IGRyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9ybTMxMDAt
Y29yZS5jDQo+Pj4NCj4+PiBUaGUgcm0zMTAwIGRyaXZlciBkb2Vzbid0IGRvIGFueSBjaGVja3Mg
aW4gdGhlIHNldHVwX29wcyBmb3IgJ2N1cnJlbnRtb2RlJyBhcw0KPj4+IGZhciBhcyBJIGNvdWxk
IHNlZS4NCj4+Pg0KPj4+IFNvLCBMYXJzJyBwYXRjaCBjb3VsZCB3b3JrIG5pY2VseSB0byBmaXgg
dGhpcyBjdXJyZW50IGNhc2UgYW5kIG5vdCBicmVhayBvdGhlcnMuDQo+Pj4NCj4+PiBTZW1hbnRp
Y2FsbHkgdGhvdWdoLCBpdCB3b3VsZCBzb3VuZCBuaWNlciB0byBoYXZlIGEgJ25leHRtb2RlJyBw
YXJhbWV0ZXINCj4+PiBzb21ld2hlcmU7IG1heWJlIG9uIHRoZSBzZXR1cF9vcHMoaW5kaW9fZGV2
LCBuZXh0bW9kZSk/DQo+Pj4gVGhvdWdoLCBvbmx5IHRob3NlIDMgZHJpdmVycyB3b3VsZCByZWFs
bHkgZXZlciB1c2UgaXQ7IHNvIGRvaW5nIGl0IGxpa2UgdGhhdA0KPj4+IHNvdW5kcyBsaWtlIG92
ZXJraWxsLg0KPj4+DQo+Pj4gU28sIHdlJ3JlIGxlZnQgd2l0aCBMYXJzJyBwYXRjaCBvciB3ZSBj
b3VsZCBhZGQgYW4gJ2luZGlvX2Rldi0+bmV4dG1vZGUnIGZpZWxkLA0KPj4+IHRoYXQgbWF5IGJl
IHVzZWQgaW4ganVzdCB0aGVzZSAzIGRyaXZlcnMgW3doaWNoIGFnYWluOiBzb3VuZHMgb3Zlcmtp
bGwgYXQgdGhpcw0KPj4+IHBvaW50IGluIHRpbWVdLg0KPj4+DQo+Pj4gQWx0ZXJuYXRpdmVseSwg
dGhpcyAnaW5kaW9fZGV2LT5jdXJyZW50bW9kZScgY291bGQgYmUgcmVtb3ZlZCBmcm9tIGFsbCB0
aGVzZSAzDQo+Pj4gZHJpdmVycyBzb21laG93LiBCdXQgdGhhdCBuZWVkcyB0ZXN0aW5nIGFuZCBh
IHRob3JvdWdoIHVuZGVyc3RhbmRpbmcgb2YgYWxsIDMNCj4+PiBkcml2ZXJzIGFuZCB3aGF0IHRo
ZXkncmUgZG9pbmcsIHRvIGRvIHByb3Blcmx5Lg0KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+PiBIaSBB
bGV4LA0KPj4NCj4+IFRoYW5rcyBmb3IgZmluZGluZyB0aGlzLiBJIHdpbGwgdGVzdCB0aGlzIHdp
dGggdGhlIGF0OTEtc2FtYTVkMl9hZGMNCj4+IGRyaXZlciBvbiBKb25hdGhhbidzIHRlc3Rpbmcg
YnJhbmNoLiBJIHdpbGwgbGV0IHlvdSBrbm93IG9mIHRoZSByZXN1bHRzLg0KPj4NCj4+IEV1Z2Vu
DQo+IA0KPiBIaSwNCj4gDQo+IEZvciBzYW1hNWQyLXhwbGFpbmVkLCBodyB0cmlnZ2VyIHRlc3Rp
bmcsIGF0OTEtc2FtYTVkMl9hZGMgZHJpdmVyLA0KPiBUZXN0ZWQtYnk6IEV1Z2VuIEhyaXN0ZXYg
PGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEkgZGlkIG5vdCBnZXQgbXkgaGFu
ZHMgb24gdGhlIHRvdWNoc2NyZWVuIHlldCwgYnV0IGhvcGVmdWxseSBzb29uLg0KPiANCj4gVGhh
bmtzIGFnYWluLA0KPiBFdWdlbg0KDQpIZWxsbyBKb25hdGhhbiwNCg0KV2l0aG91dCB0aGlzIHBh
dGNoLCB5b3VyIGN1cnJlbnQgdGVzdGluZyBicmFuY2ggaXMgYnJva2VuIGZvciBoYXJkd2FyZSAN
CnRyaWdnZXIgZm9yIGF0OTEtc2FtYTVkMl9hZGMgKGluY2x1ZGluZyBmb3ItNS44YiB0YWcpDQoN
CllvdSB3YW50IG1lIHRvIGNyZWF0ZSBhIHBhdGNoIHRoYXQgZml4ZXMgdGhhdCBpbiB0aGUgZHJp
dmVyLCBvciB5b3Ugd2lsbCANCnRha2UgdGhpcyBwYXRjaCBtYXliZSA/DQoNClRoYW5rcyAhDQpF
dWdlbg0KPj4NCj4+Pg0KPj4+ICAgICBkcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMg
fCA4ICsrKy0tLS0tDQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlh
bGlvLWJ1ZmZlci5jIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+Pj4gaW5k
ZXggMzBhZjhhZjhmMzEyLi5lZmNjNDRiNjI5NDYgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9p
aW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+Pj4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlh
bGlvLWJ1ZmZlci5jDQo+Pj4gQEAgLTk4OSw2ICs5ODksNyBAQCBzdGF0aWMgaW50IGlpb19lbmFi
bGVfYnVmZmVycyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4+ICAgICAgICAgICAgaW5k
aW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrID0gY29uZmlnLT5zY2FuX21hc2s7DQo+Pj4gICAgICAg
ICAgICBpbmRpb19kZXYtPnNjYW5fdGltZXN0YW1wID0gY29uZmlnLT5zY2FuX3RpbWVzdGFtcDsN
Cj4+PiAgICAgICAgICAgIGluZGlvX2Rldi0+c2Nhbl9ieXRlcyA9IGNvbmZpZy0+c2Nhbl9ieXRl
czsNCj4+PiArICAgICAgIGluZGlvX2Rldi0+Y3VycmVudG1vZGUgPSBjb25maWctPm1vZGU7DQo+
Pj4NCj4+PiAgICAgICAgICAgIGlpb191cGRhdGVfZGVtdXgoaW5kaW9fZGV2KTsNCj4+Pg0KPj4+
IEBAIC0xMDI0LDggKzEwMjUsNiBAQCBzdGF0aWMgaW50IGlpb19lbmFibGVfYnVmZmVycyhzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gZXJyX2Rpc2FibGVfYnVmZmVyczsNCj4+PiAgICAgICAgICAgIH0NCj4+Pg0KPj4+IC0gICAg
ICAgaW5kaW9fZGV2LT5jdXJyZW50bW9kZSA9IGNvbmZpZy0+bW9kZTsNCj4+PiAtDQo+Pj4gICAg
ICAgICAgICBpZiAoaW5kaW9fZGV2LT5zZXR1cF9vcHMtPnBvc3RlbmFibGUpIHsNCj4+PiAgICAg
ICAgICAgICAgICAgICAgcmV0ID0gaW5kaW9fZGV2LT5zZXR1cF9vcHMtPnBvc3RlbmFibGUoaW5k
aW9fZGV2KTsNCj4+PiAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPj4+IEBAIC0xMDQy
LDEwICsxMDQxLDEwIEBAIHN0YXRpYyBpbnQgaWlvX2VuYWJsZV9idWZmZXJzKHN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXYsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYnVmZmVyX2xpc3QpDQo+Pj4gICAgICAgICAgICAgICAgICAgIGlpb19idWZm
ZXJfZGlzYWJsZShidWZmZXIsIGluZGlvX2Rldik7DQo+Pj4gICAgIGVycl9ydW5fcG9zdGRpc2Fi
bGU6DQo+Pj4gLSAgICAgICBpbmRpb19kZXYtPmN1cnJlbnRtb2RlID0gSU5ESU9fRElSRUNUX01P
REU7DQo+Pj4gICAgICAgICAgICBpZiAoaW5kaW9fZGV2LT5zZXR1cF9vcHMtPnBvc3RkaXNhYmxl
KQ0KPj4+ICAgICAgICAgICAgICAgICAgICBpbmRpb19kZXYtPnNldHVwX29wcy0+cG9zdGRpc2Fi
bGUoaW5kaW9fZGV2KTsNCj4+PiAgICAgZXJyX3VuZG9fY29uZmlnOg0KPj4+ICsgICAgICAgaW5k
aW9fZGV2LT5jdXJyZW50bW9kZSA9IElORElPX0RJUkVDVF9NT0RFOw0KPj4+ICAgICAgICAgICAg
aW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrID0gTlVMTDsNCj4+Pg0KPj4+ICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4+PiBAQCAtMTA4MCw4ICsxMDc5LDYgQEAgc3RhdGljIGludCBpaW9fZGlz
YWJsZV9idWZmZXJzKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0ID0gcmV0MjsNCj4+PiAgICAgICAgICAgIH0NCj4+Pg0KPj4+IC0g
ICAgICAgaW5kaW9fZGV2LT5jdXJyZW50bW9kZSA9IElORElPX0RJUkVDVF9NT0RFOw0KPj4+IC0N
Cj4+PiAgICAgICAgICAgIGlmIChpbmRpb19kZXYtPnNldHVwX29wcy0+cG9zdGRpc2FibGUpIHsN
Cj4+PiAgICAgICAgICAgICAgICAgICAgcmV0MiA9IGluZGlvX2Rldi0+c2V0dXBfb3BzLT5wb3N0
ZGlzYWJsZShpbmRpb19kZXYpOw0KPj4+ICAgICAgICAgICAgICAgICAgICBpZiAocmV0MiAmJiAh
cmV0KQ0KPj4+IEBAIC0xMDkwLDYgKzEwODcsNyBAQCBzdGF0aWMgaW50IGlpb19kaXNhYmxlX2J1
ZmZlcnMoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+Pg0KPj4+ICAgICAgICAgICAgaWlv
X2ZyZWVfc2Nhbl9tYXNrKGluZGlvX2RldiwgaW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrKTsN
Cj4+PiAgICAgICAgICAgIGluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFzayA9IE5VTEw7DQo+Pj4g
KyAgICAgICBpbmRpb19kZXYtPmN1cnJlbnRtb2RlID0gSU5ESU9fRElSRUNUX01PREU7DQo+Pj4N
Cj4+PiAgICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4gICAgIH0NCj4+PiAtLQ0KPj4+IDIuMTcu
MQ0KPj4+DQo+Pg0KPiANCg0K
