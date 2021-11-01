Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D105441C01
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 14:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhKAOAX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 10:00:23 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:59705
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229826AbhKAOAX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 10:00:23 -0400
Received: from icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwB3n89W8n9hUtzWBA--.18994S2;
        Mon, 01 Nov 2021 21:57:42 +0800 (CST)
Received: by ajax-webmail-mail (Coremail) ; Mon, 1 Nov 2021 21:57:12 +0800
 (GMT+08:00)
X-Originating-IP: [46.253.189.78]
Date:   Mon, 1 Nov 2021 21:57:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Dmitry Maslov" <maslovdmitry@seeed.cc>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Jonathan Cameron" <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>, north_sea@qq.com,
        baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
Subject: Re: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210303(5f774024)
 Copyright (c) 2002-2021 www.mailtech.cn mtdemo-icoremail
In-Reply-To: <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
References: <20211031164603.4343-1-maslovdmitry@seeed.cc>
 <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: duHl22Zvb3Rlcl90eHQ9MTU5NzoxMA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1d537660.dd.17cdbca2bb6.Coremail.maslovdmitry@seeed.cc>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAfwA31CM48n9h3TIAAA--.93W
X-CM-SenderInfo: xpdvz0pygpx31u162vxhhghubf/1tbiAQERClQ9KeMBowAYsC
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=maslovdmit
        ry@seeed.cc;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WrWDKF13KFW8AryrGr13CFg_yoW8Wr13pa
        y3tF4Y9FykWr1rWr1qqrWFk3W3tr4DWr429w1jg34xZrWj9Fyrua4aqwsYga4DZrySqa4U
        XrW2grnrGas3WaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQW5keSBTaGV2Y2hlbmtvIiA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4KPiBTZW50IFRpbWU6IDIwMjEtMTAtMzEgMjI6MDc6
MDkgKFN1bmRheSkKPiBUbzogIk1hc2xvdiBEbWl0cnkiIDxtYXNsb3ZkbWl0cnlAc2VlZWQuY2M+
Cj4gQ2M6ICJKb25hdGhhbiBDYW1lcm9uIiA8amljMjNAa2VybmVsLm9yZz4sIGxpbnV4LWlpbyA8
bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz4sICJMYXJzLVBldGVyIENsYXVzZW4iIDxsYXJzQG1l
dGFmb28uZGU+LCBub3J0aF9zZWFAcXEuY29tLCBiYW96aHUuenVvQHNlZWVkLmNjLCBqaWFuLnhp
b25nQHNlZWVkLmNjCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gaWlvOiBsaWdodDogbHRyNTAx
OiBBZGRlZCBsdHIzMDMgZHJpdmVyIHN1cHBvcnQKPiAKPiBPbiBTdW4sIE9jdCAzMSwgMjAyMSBh
dCA2OjQ2IFBNIE1hc2xvdiBEbWl0cnkgPG1hc2xvdmRtaXRyeUBzZWVlZC5jYz4gd3JvdGU6Cj4g
Pgo+ID4gUHJldmlvdXNseSBsdHI1MDEgZHJpdmVyIHN1cHBvcnRlZCBhIG51bWJlciBvZiBsaWdo
dCBhbmQsCj4gPiBwcm94aW1pdHkgc2Vuc29ycyBpbmNsdWRpbmcgbHRyNTAxLCBsdHI1NTkgYW5k
IGx0cjMwMS4KPiA+IFRoaXMgYWRkcyBzdXBwb3J0IGZvciBhbm90aGVyIGxpZ2h0IHNlbnNvciBs
dHIzMDMKPiA+IHVzZWQgaW4gU2VlZWQgU3R1ZGlvIHJlVGVybWluYWwsIGEgY2FycmllciBib2Fy
ZAo+ID4gZm9yIFJhc3BiZXJyeSBQaSA0IENNLgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWFzbG92
IERtaXRyeSA8bWFzbG92ZG1pdHJ5QHNlZWVkLmNjPgo+IAo+IEkgYmVsaWV2ZSBpdCBzaG91bGQg
YmUgRG1pdHJ5IE1hc2xvdiwgaS5lLiBGaXJzdCBuYW1lIExhc3QgbmFtZS4KCkkgY291bGQgY2hh
bmdlIHRoYXQsIGJ1dCBJIGRvIG5vdCB0aGluayB0aGVyZSBpcyBhbiBpbnRlcm5hdGlvbmFsIHN0
YW5kYXJkIGZvciB0aGF0LiBUaGUgcmVhc29uIEkgcHV0IE1hc2xvdiBEbWl0cnkKaXMgdG8gYmUg
aW4gbGluZSB3aXRoIGNvcnBvcmF0ZSBlbWFpbCBhZGRyZXNzLCB3aGljaCBiZWxvbmdzIHRvIGEg
Q2hpbmVzZSBjb21wYW55IC0gaW4gQ2hpbmEgc3VybmFtZSBpcyBwdXQgZmlyc3QgCm9uIHRoZSBs
ZWdhbCBkb2N1bWVudHMuCgo+IC4uLgo+IAo+ID4gQEAgLTE1OTcsNiArMTYxMCw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgbHRyX2FjcGlfbWF0Y2hbXSA9IHsKPiA+ICAg
ICAgICAgeyJMVEVSMDUwMSIsIGx0cjUwMX0sCj4gPiAgICAgICAgIHsiTFRFUjA1NTkiLCBsdHI1
NTl9LAo+ID4gICAgICAgICB7IkxURVIwMzAxIiwgbHRyMzAxfSwKPiA+ICsgICAgICAgeyJMVEVS
MDMwMyIsIGx0cjMwM30sCj4gCj4gQW55IGV2aWRlbmNlIG9mIHRoaXMgQUNQSSBJRCBiZWluZyBp
biB0aGUgd2lsZCwgcGxlYXNlPwoKSSdtIHNvcnJ5LCBJIGRvIG5vdCBleGFjdGx5IHVuZGVyc3Rh
bmQgdGhlIHF1ZXN0aW9uLiBEbyB5b3UgbWVhbiB3aGVyZSB0aGF0IHBhcnRpY3VsYXIgc2Vuc29y
IGlzIHVzZWQ/Cj4gCj4gLS0gCj4gV2l0aCBCZXN0IFJlZ2FyZHMsCj4gQW5keSBTaGV2Y2hlbmtv
Cg0KDQoNCg0KDQo=

