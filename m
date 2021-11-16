Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AFB452EB8
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 11:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhKPKMy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 05:12:54 -0500
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:45123
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233844AbhKPKMu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 05:12:50 -0500
Received: from icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwCnb6wjg5NhQSLaBw--.5741S2;
        Tue, 16 Nov 2021 18:08:35 +0800 (CST)
Received: by ajax-webmail-mail (Coremail) ; Tue, 16 Nov 2021 18:09:37 +0800
 (GMT+08:00)
X-Originating-IP: [160.85.151.149]
Date:   Tue, 16 Nov 2021 18:09:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Dmitry Maslov" <maslovdmitry@seeed.cc>
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, north_sea@qq.com, baozhu.zuo@seeed.cc,
        jian.xiong@seeed.cc
Subject: Re: Re: [PATCH v4] iio: light: ltr501: Added ltr303 driver support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210303(5f774024)
 Copyright (c) 2002-2021 www.mailtech.cn mtdemo-icoremail
In-Reply-To: <20211113181954.7b714942@jic23-huawei>
References: <20211106174137.6783-1-maslovdmitry@seeed.cc>
 <20211113181954.7b714942@jic23-huawei>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: iIpjg2Zvb3Rlcl90eHQ9Mjc3MToxMA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <69591cd0.cc.17d28393652.Coremail.maslovdmitry@seeed.cc>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAfwCnn2Rjg5NhixoAAA--.69W
X-CM-SenderInfo: xpdvz0pygpx31u162vxhhghubf/1tbiAQAKClQ9KfAB6ABhs5
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=maslovdmit
        ry@seeed.cc;
X-Coremail-Antispam: 1Uk129KBjvJXoWxuryxXw4UZFy5Zry3Cr1Dtrb_yoW5Xr1kpF
        y5WF15CFn5XF1fWa98XF1kZFy5Krs7K3yjyrs7K3srA39xGwsrua47t34YkFn3Zr42vr4S
        qFsFvFW09a1rCFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBBcHBsaWVkIHRvIHRoZSB0b2dyZWcgYnJhbmNoIG9mIGlpby5naXQgYW5kIHB1c2hlZCBvdXQg
YXMgdGVzdGluZyB0byBzZWUgaWYgMC1kYXkKPiBjYW4gZmluZCBhbnl0aGluZyB3ZSBtaXNzZWQu
ICAgSSdsbCByZWJhc2UgdGhlIHRyZWUgYWZ0ZXIgcmMxIGFuZCBzb29uIGFmdGVyIHRoYXQKPiBp
dCBzaG91bGQgYmUgdmlzaWJsZSBpbiBsaW51eC1uZXh0Lgo+IAo+IFRoYW5rcywKPiAKPiBKb25h
dGhhbgo+IApUaGFuayB5b3UsIGxvb2tpbmcgZm9yd2FyZCB0byBpdCEKCj4gPiAtLS0KPiA+ICBk
cml2ZXJzL2lpby9saWdodC9sdHI1MDEuYyB8IDE3ICsrKysrKysrKysrKysrKystCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gSXQg
aXMgYSBmaXggb2YgcHJldmlvdXMgY29tbWl0cywgdGhhdCBzaW1wbGlmaWVkIGx0cjMwMyBzdXBw
b3J0Cj4gPiBhbmQgcmVtb3ZlZCBhIGxvdCBvZiB1bm5lY2Vzc2FyeSBjb2RlLiBGaWxlbmFtZSBo
YXMgYWxzbyBiZWVuIHJlbW92ZWQKPiA+IGZyb20gdGhlIGZpbGUuCj4gPiBBZGRpdGlvbmFsbHks
IGluIHYzIG9mIHRoZSBwYXRjaCwgdW51c2VkIGx0cl9tYXggd2FzIHJlbW92ZWQKPiA+IGFuZCBk
ZXNjcmlwdGlvbiBvZiB0aGUgZHJpdmVyIHdhcyBjaGFuZ2VkIHRvIG1vcmUgZ2VuZXJhbCwgaS5l
Lgo+ID4gIkxUUjUwMSBhbmQgc2ltaWxhciBhbWJpZW50IGxpZ2h0IGFuZCBwcm94aW1pdHkgc2Vu
c29ycy4iCj4gPiBJbiB2NCBvZiB0aGUgcGF0Y2gsIGx0cjMwMyBlbnRyeSB3YXMgcmVtb3ZlZCBm
cm9tIEFDUEkgbWF0Y2ggdGFibGUsCj4gPiBzaW5jZSBBQ1BJIElEIGlzIG5vdCBwcmVzZW50IGlu
IGFjcGkgaWQgbGlzdC4KPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L2x0
cjUwMS5jIGIvZHJpdmVycy9paW8vbGlnaHQvbHRyNTAxLmMKPiA+IGluZGV4IDdlNTFhYWFjMGJm
Li5iYWI1Yjc4ZjJlMyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L2x0cjUwMS5j
Cj4gPiArKysgYi9kcml2ZXJzL2lpby9saWdodC9sdHI1MDEuYwo+ID4gQEAgLTEsNiArMSw2IEBA
Cj4gPiAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+ID4gIC8qCj4g
PiAtICogbHRyNTAxLmMgLSBTdXBwb3J0IGZvciBMaXRlLU9uIExUUjUwMSBhbWJpZW50IGxpZ2h0
IGFuZCBwcm94aW1pdHkgc2Vuc29yCj4gPiArICogU3VwcG9ydCBmb3IgTGl0ZS1PbiBMVFI1MDEg
YW5kIHNpbWlsYXIgYW1iaWVudCBsaWdodCBhbmQgcHJveGltaXR5IHNlbnNvcnMuCj4gPiAgICoK
PiA+ICAgKiBDb3B5cmlnaHQgMjAxNCBQZXRlciBNZWVyd2FsZCA8cG1lZXJ3QHBtZWVydy5uZXQ+
Cj4gPiAgICoKPiA+IEBAIC05OCw2ICs5OCw3IEBAIGVudW0gewo+ID4gIAlsdHI1MDEgPSAwLAo+
ID4gIAlsdHI1NTksCj4gPiAgCWx0cjMwMSwKPiA+ICsJbHRyMzAzLAo+ID4gIH07Cj4gPiAgCj4g
PiAgc3RydWN0IGx0cjUwMV9nYWluIHsKPiA+IEBAIC0xMjMxLDYgKzEyMzIsMTggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBsdHI1MDFfY2hpcF9pbmZvIGx0cjUwMV9jaGlwX2luZm9fdGJsW10gPSB7
Cj4gPiAgCQkuY2hhbm5lbHMgPSBsdHIzMDFfY2hhbm5lbHMsCj4gPiAgCQkubm9fY2hhbm5lbHMg
PSBBUlJBWV9TSVpFKGx0cjMwMV9jaGFubmVscyksCj4gPiAgCX0sCj4gPiArCVtsdHIzMDNdID0g
ewo+ID4gKwkJLnBhcnRpZCA9IDB4MEEsCj4gPiArCQkuYWxzX2dhaW4gPSBsdHI1NTlfYWxzX2dh
aW5fdGJsLAo+ID4gKwkJLmFsc19nYWluX3RibF9zaXplID0gQVJSQVlfU0laRShsdHI1NTlfYWxz
X2dhaW5fdGJsKSwKPiA+ICsJCS5hbHNfbW9kZV9hY3RpdmUgPSBCSVQoMCksCj4gPiArCQkuYWxz
X2dhaW5fbWFzayA9IEJJVCgyKSB8IEJJVCgzKSB8IEJJVCg0KSwKPiA+ICsJCS5hbHNfZ2Fpbl9z
aGlmdCA9IDIsCj4gPiArCQkuaW5mbyA9ICZsdHIzMDFfaW5mbywKPiA+ICsJCS5pbmZvX25vX2ly
cSA9ICZsdHIzMDFfaW5mb19ub19pcnEsCj4gPiArCQkuY2hhbm5lbHMgPSBsdHIzMDFfY2hhbm5l
bHMsCj4gPiArCQkubm9fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKGx0cjMwMV9jaGFubmVscyksCj4g
PiArCX0sCj4gPiAgfTsKPiA+ICAKPiA+ICBzdGF0aWMgaW50IGx0cjUwMV93cml0ZV9jb250cihz
dHJ1Y3QgbHRyNTAxX2RhdGEgKmRhdGEsIHU4IGFsc192YWwsIHU4IHBzX3ZhbCkKPiA+IEBAIC0x
NjA1LDYgKzE2MTgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgbHRyNTAx
X2lkW10gPSB7Cj4gPiAgCXsgImx0cjUwMSIsIGx0cjUwMX0sCj4gPiAgCXsgImx0cjU1OSIsIGx0
cjU1OX0sCj4gPiAgCXsgImx0cjMwMSIsIGx0cjMwMX0sCj4gPiArCXsgImx0cjMwMyIsIGx0cjMw
M30sCj4gPiAgCXsgfQo+ID4gIH07Cj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIGx0cjUw
MV9pZCk7Cj4gPiBAQCAtMTYxMyw2ICsxNjI3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgbHRyNTAxX29mX21hdGNoW10gPSB7Cj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibGl0
ZW9uLGx0cjUwMSIsIH0sCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibGl0ZW9uLGx0cjU1OSIsIH0s
Cj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibGl0ZW9uLGx0cjMwMSIsIH0sCj4gPiArCXsgLmNvbXBh
dGlibGUgPSAibGl0ZW9uLGx0cjMwMyIsIH0sCj4gPiAgCXt9Cj4gPiAgfTsKPiA+ICBNT0RVTEVf
REVWSUNFX1RBQkxFKG9mLCBsdHI1MDFfb2ZfbWF0Y2gpOwoNCg0KDQoNCg0K

