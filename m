Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959215501D1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 04:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383685AbiFRCBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 22:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbiFRCBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 22:01:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BE6B7DC
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 19:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655517689; x=1687053689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l5uBCltGOAECjQetHMCiX4oaVx3wtljWGCj7SxyqP8Y=;
  b=T2hlEMffXmb6wbBFUe0pHsXyCWx4J20TR5JTCH5GkxNGdesr7K/U7CWO
   QB13R8asUhegbq1nxT+qmvlgO6X1Yc3x1WqMDajRN6Y9F2bLYA9JtN8pd
   Js2fVrBjvAAdAUIPK8RZnRl+vFODTlnl9H6AjUyf/ce7ajl9iu0nxSCwn
   xdv7/yMb+Nj4u7VndxG89O/bOEi9wrrLGMAIoyJ/1SXDcu3rhlzFdW6pP
   07Z0NByhKDGVh9VoKovIV5YymoC+gDQssFJX0c5QsZXWYRpqfoUO6J4fe
   ZJJVdTO9sFX62MCzsk//kpDqbYPtSqRmb6M/JSp2d+E5e4jXworMZ3JTW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305050147"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305050147"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 19:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="537017862"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2022 19:01:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 19:01:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 19:01:28 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2308.027;
 Fri, 17 Jun 2022 19:01:28 -0700
From:   "Hall, Christopher S" <christopher.s.hall@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Topic: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Index: AdiCFGKgSJf28KGeQ2qEKrwEQy9pwAAQT46AAAU1qIAAA8pdgAANdf+g
Date:   Sat, 18 Jun 2022 02:01:28 +0000
Message-ID: <ad7e53d1bd2448b4971af65483fe3542@intel.com>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de>
 <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
 <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com>
In-Reply-To: <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgTGludXMsDQoNCkZyaWRheSwgSnVuZSAxNywgMjAyMiA0OjQwIEFNIExpbnVzIFdhbGxlaWog
PGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4gd3JvdGU6DQoNCj4gRm9yIDIuIEkgYW0gdW5jZXJ0
YWluLiBQZXJpb2RpYyBldmVudHMgc291bmQgbGlrZSBQV00gdG8gbWUuDQoNCkkgZG8gbm90IHRo
aW5rIFRHUElPIHBlcmlvZGljIG91dHB1dCBpcyB1c2VmdWwgZm9yIFBXTS4gVGhlcmUgYXJlIHR3
byBvdXRwdXQNCm1vZGVzOiBlZGdlIG91dHB1dCBhbmQgcHVsc2Ugb3V0cHV0LiBJbiBlZGdlIG1v
ZGUgb3V0cHV0LCB3aGVyZSB0aGUgYW4gZWRnZQ0KaXMgcHJvZHVjZWQgcGVyaW9kaWNhbGx5IGJh
c2VkIG9uIHRoZSBwcm9ncmFtbWVkIHBlcmlvZCB0aGUgZHV0eSBjeWNsZSBpcw0KYWx3YXlzIDUw
JS4gSW4gcHVsc2UgbW9kZSBvdXRwdXQgd2hlcmUgYSBwdWxzZSBpcyBwcm9kdWNlZCBlYWNoIG91
dHB1dA0KcGVyaW9kLCB0aGUgd2lkdGggb2YgdGhlIHB1bHNlIGlzIHR3byBBUlQgdGlja3Mgd2hp
Y2ggb24gY3VycmVudCBJbnRlbA0KY2xpZW50IHBsYXRmb3JtcyBpcyBhYm91dCA1MCBucy4gVGhl
IHB1bHNlIHdpZHRoIGlzIG5vdCBhZGp1c3RhYmxlLg0KDQpXZSB3YW50IHRvIGJlIGFibGUgdG8g
b3V0cHV0IGEgY2xvY2sgZnJvbSAxIEh6ICgxIFBQUykgdXAgdG8gMSBLSHogdGhhdCBpcw0Kc3lu
Y2hyb25pemVkIHdpdGggdGhlIHN5c3RlbSBjbG9jay4NCg0KSXQgaXMgcG9zc2libGUgdG8gcmVw
cmVzZW50IHRoZSBwZXJpb2RpYyBvdXRwdXQgZnVuY3Rpb24gYXMgYSBQV00gZGV2aWNlLA0KYnV0
IHRoZSBQV00gc3Vic3lzdGVtIG91dHB1dCAtIHdpdGhvdXQgbW9kaWZpY2F0aW9uIC0gaXMgbm90
IGFsaWduZWQgdG8NCmFueSBjbG9jayB3aGljaCBicmVha3MgdGhlIHRpbWluZyBhcHBsaWNhdGlv
bi4NCg0KPiBJZiBhICJzaW5nbGUgZXZlbnQiIGlzIHNvbWV0aGluZw0KPiBsaWtlIHB1bGxpbmcg
YSBHUElPIGxpbmUgaGlnaC9sb3cgYXQgYSBzcGVjaWZpYyAod2FsbCBjbG9jaykgdGltZSBpbiB0
aGUNCj4gZnV0dXJlLCBpdCBzaG91bGQgcHJvYmFibHkgYmUgaW4gdGhlIEdQSU8gc3Vic3lzdGVt
LCBsaWtlIGEgdHJpZ2dlcmVkDQo+IEdQSU8gZXZlbnQgb3Igc28sIHRoYXQgc291bmRzIGEgYml0
IGhhcmQgYnV0IGNlcnRhaW5seSBkb2FibGUgd2l0aCBzb21lDQo+IHRoaW5raW5nIGFuZCB0aW5r
ZXJpbmcuDQoNCkVhcmxpZXIsIHdlIHByb3Bvc2VkIGEgbGluZXJlcV93cml0ZSgpIG1ldGhvZCBp
biBhZGRpdGlvbiB0byB0aGUgYWxyZWFkeQ0KZXhpc3RpbmcgbGluZXJlcV9yZWFkKCkuDQoNCmh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDIxLzgvMjQvODA3DQoNClRoaXMgaXMgZm9yICJzaW5nbGUg
c2hvdCIgc2NoZWR1bGVkIG91dHB1dCBvbmx5LiBUaGlzIGlzIGZhaXJseSBlYXN5IHRvDQppbXBs
ZW1lbnQgdXNpbmcgdGhlIFRpbWVkIEkvTyBoYXJkd2FyZSBiZWNhdXNlIHRoZSBjbG9jayB1c2Vk
IHRvIHNjaGVkdWxlDQpvdXRwdXQgZXZlbnRzIGlzIGRpcmVjdGx5IHJlbGF0ZWQgdG8gVFNDIGFu
ZCBzeXN0ZW0gdGltZS4NCg0KVGhlIGRpZmZpY3VsdCBwYXJ0IGlzIGltcGxlbWVudGluZyB0aGlz
IGZvciBkZXZpY2VzIHRoYXQgYXJlIG5vdCB0aW1lDQphd2FyZS4NCg0KPiBZb3VycywNCj4gTGlu
dXMgV2FsbGVpag0KDQpUaGFua3MsDQpDaHJpc3RvcGhlcg0K
