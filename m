Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B92BC30F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 02:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgKVBym (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 20:54:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:64188 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbgKVBym (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 20:54:42 -0500
IronPort-SDR: SPxkknZm00GcJLpQz3xuhKiZe9ar3ksDaQeI4adj8XvbNzsIbfikV6nXg8Iw3c/oP2jerw4GAG
 OuiD3iiHvsig==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="158665337"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="158665337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 17:54:41 -0800
IronPort-SDR: nHTlTg5R0SVGd+aL/lMzoqiQs0+nGi4R9lPSJNIx7P6v53kz+qpZmiCzAMG0A0S+Thcde6DHl+
 K6fWr1zlp7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="360963901"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2020 17:54:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 21 Nov 2020 17:54:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 21 Nov 2020 17:54:40 -0800
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.1713.004;
 Sat, 21 Nov 2020 17:54:40 -0800
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "Ye, Xiang" <xiang.ye@intel.com>
CC:     "jikos@kernel.org" <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio: hid-sensor-trigger: Decrement runtime pm
 enable count on driver removal
Thread-Topic: [PATCH v2 2/4] iio: hid-sensor-trigger: Decrement runtime pm
 enable count on driver removal
Thread-Index: AQHWwHJwAVvKIqY7DkWZEPObxtGfJA==
Date:   Sun, 22 Nov 2020 01:54:39 +0000
Message-ID: <70f76abd28a26e1259aa8c34851476c31e898d91.camel@intel.com>
References: <20201119100331.2594-1-xiang.ye@intel.com>
         <20201119100331.2594-3-xiang.ye@intel.com>
         <20201121172257.59fa05d5@archlinux>
In-Reply-To: <20201121172257.59fa05d5@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB741AE05E377340945E43B9D5DF45EB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTExLTIxIGF0IDE3OjIyICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUsIDE5IE5vdiAyMDIwIDE4OjAzOjI5ICswODAwDQo+IFllIFhpYW5nIDx4aWFu
Zy55ZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBUbyBhdm9pZCBwbV9ydW50aW1lX2Rpc2Fi
bGUgY2FsbGVkIHJlcGVhdGVkbHkgYnkgaGlkIHNlbnNvcg0KPiA+IGRyaXZlcnMsDQo+ID4gZGVj
cmVhc2UgcnVudGltZSBwbSBlbmFibGUgY291bnQgYWZ0ZXIgY2FsbCBpdC4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZZSBYaWFuZyA8eGlhbmcueWVAaW50ZWwuY29tPg0KPiBUaGlzIHNvdW5k
cyBsaWtlIGEgZml4LiAgSWYgc28gcGxlYXNlIG1ha2UgdGhhdCBjbGVhciBhbmQgYWRkIGEgZml4
ZXMNCj4gdGFnLg0KPiANCj4gSWYgaXQgY291bGRuJ3QgaGF2ZSBiZWVuIHRyaWdnZXJlZCBiZWZv
cmUsIHRoZW4gcGxlYXNlIGV4cGxhaW4gd2h5IGluDQo+IHRoaXMNCj4gcGF0Y2ggZGVzY3JpcHRp
b24uDQpOb3JtYWxseSBpdCBpcyBub3QgYSBwcm9ibGVtIGFzIHRoaXMgaXMgY2FsbGVkIGR1cmlu
ZyBkcml2ZXIgcmVtb3ZlIGFuZA0KbmV4dCB0aW1lIGluc21vZCB0aGlzIGRhdGEgc3RydWN0dXJl
IGlzIHJlY3JlYXRlZCBhbmQgY291bnQgd2lsbCBpbml0DQphZ2Fpbi4gVGhpcyBpcyB0aGUgYXJ0
aWZlY3Qgb2YgdGhlIHNoYXJlZCBpaW8gZGV2aWNlcyBhbmQgb25lIG9mIHRoZW0NCmlzIHN0aWxs
IG9wZW4sIHNvIHRoZSBpbnN0YW5jZSB3aWxsIG5vdCBiZSBmcmVlZC4NCkJ1dCBwYXRjaCBpcyBm
aW5lIGFzIHRvIGRvIG9wcG9zaXRlIG9mIHdoYXQgaXMgZG9uZSBkdXJpbmcgYWxsb2MuDQoNClRo
YW5rcywNClNyaW5pdmFzDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9jb21tb24vaGlkLXNlbnNvcnMvaGlkLXNlbnNvci10cmln
Z2VyLmMgfCA0ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9jb21tb24vaGlk
LXNlbnNvcnMvaGlkLXNlbnNvci10cmlnZ2VyLmMNCj4gPiBiL2RyaXZlcnMvaWlvL2NvbW1vbi9o
aWQtc2Vuc29ycy9oaWQtc2Vuc29yLXRyaWdnZXIuYw0KPiA+IGluZGV4IGZmMzc1NzkwYjdlOC4u
MzAzNDBhYmNiYzhkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2NvbW1vbi9oaWQtc2Vu
c29ycy9oaWQtc2Vuc29yLXRyaWdnZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2NvbW1vbi9o
aWQtc2Vuc29ycy9oaWQtc2Vuc29yLXRyaWdnZXIuYw0KPiA+IEBAIC0yMjcsOCArMjI3LDEwIEBA
IHN0YXRpYyBpbnQNCj4gPiBoaWRfc2Vuc29yX2RhdGFfcmR5X3RyaWdnZXJfc2V0X3N0YXRlKHN0
cnVjdCBpaW9fdHJpZ2dlciAqdHJpZywNCj4gPiAgdm9pZCBoaWRfc2Vuc29yX3JlbW92ZV90cmln
Z2VyKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gIAkJCSAgICAgICBzdHJ1Y3QgaGlk
X3NlbnNvcl9jb21tb24gKmF0dHJiKQ0KPiA+ICB7DQo+ID4gLQlpZiAoYXRvbWljX3JlYWQoJmF0
dHJiLT5ydW50aW1lX3BtX2VuYWJsZSkpDQo+ID4gKwlpZiAoYXRvbWljX3JlYWQoJmF0dHJiLT5y
dW50aW1lX3BtX2VuYWJsZSkpIHsNCj4gPiAgCQlwbV9ydW50aW1lX2Rpc2FibGUoJmF0dHJiLT5w
ZGV2LT5kZXYpOw0KPiA+ICsJCWF0b21pY19kZWMoJmF0dHJiLT5ydW50aW1lX3BtX2VuYWJsZSk7
DQo+ID4gKwl9DQo+ID4gIA0KPiA+ICAJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKCZhdHRyYi0+
cGRldi0+ZGV2KTsNCj4gPiAgCXBtX3J1bnRpbWVfcHV0X25vaWRsZSgmYXR0cmItPnBkZXYtPmRl
dik7DQo=
