Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320D4442122
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhKAT6T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 15:58:19 -0400
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:44713 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229725AbhKAT6T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 15:58:19 -0400
X-Greylist: delayed 21494 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 15:58:18 EDT
Received: from icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwA3X89WRoBhWMjZBA--.21105S2;
        Tue, 02 Nov 2021 03:56:06 +0800 (CST)
Received: by ajax-webmail-mail (Coremail) ; Tue, 2 Nov 2021 03:55:35 +0800
 (GMT+08:00)
X-Originating-IP: [46.253.189.78]
Date:   Tue, 2 Nov 2021 03:55:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Dmitry Maslov" <maslovdmitry@seeed.cc>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Jonathan Cameron" <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>, north_sea@qq.com,
        baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
Subject: Re: Re: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver
 support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210303(5f774024)
 Copyright (c) 2002-2021 www.mailtech.cn mtdemo-icoremail
In-Reply-To: <CAHp75Vc+Yqcq=gtpMgzb5pDc9nuNbzzwVjfsTg20hZ7VfAQ88w@mail.gmail.com>
References: <20211031164603.4343-1-maslovdmitry@seeed.cc>
 <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
 <1d537660.dd.17cdbca2bb6.Coremail.maslovdmitry@seeed.cc>
 <CAHp75Vc+Yqcq=gtpMgzb5pDc9nuNbzzwVjfsTg20hZ7VfAQ88w@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: zOqXjWZvb3Rlcl90eHQ9MjI2OToxMA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6f764cb4.e6.17cdd1249ee.Coremail.maslovdmitry@seeed.cc>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAfwD3kyM4RoBhjzoAAA--.108W
X-CM-SenderInfo: xpdvz0pygpx31u162vxhhghubf/1tbiAQESClQ9KeQNjQAFs5
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=maslovdmit
        ry@seeed.cc;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WrWDAr1ftry5JrWrCFy7GFg_yoW8tFW8pa
        y2qFyFkF1kGr1UZrnFq3yjkw1ayrZrJF42gw15X3yxZrWY9ryru3WaqwsYga4DZry0qayj
        vr4jgr9xXas8uaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQW5keSBTaGV2Y2hlbmtvIiA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4KPiBTZW50IFRpbWU6IDIwMjEtMTEtMDEgMTY6MjA6
MzUgKE1vbmRheSkKPiBUbzogIkRtaXRyeSBNYXNsb3YiIDxtYXNsb3ZkbWl0cnlAc2VlZWQuY2M+
Cj4gQ2M6ICJKb25hdGhhbiBDYW1lcm9uIiA8amljMjNAa2VybmVsLm9yZz4sIGxpbnV4LWlpbyA8
bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz4sICJMYXJzLVBldGVyIENsYXVzZW4iIDxsYXJzQG1l
dGFmb28uZGU+LCBub3J0aF9zZWFAcXEuY29tLCBiYW96aHUuenVvQHNlZWVkLmNjLCBqaWFuLnhp
b25nQHNlZWVkLmNjCj4gU3ViamVjdDogUmU6IFJlOiBbUEFUQ0ggdjNdIGlpbzogbGlnaHQ6IGx0
cjUwMTogQWRkZWQgbHRyMzAzIGRyaXZlciBzdXBwb3J0Cj4gCj4gT24gTW9uLCBOb3YgMSwgMjAy
MSBhdCAzOjU3IFBNIERtaXRyeSBNYXNsb3YgPG1hc2xvdmRtaXRyeUBzZWVlZC5jYz4gd3JvdGU6
Cj4gPiA+IEZyb206ICJBbmR5IFNoZXZjaGVua28iIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
Pgo+ID4gPiBTZW50IFRpbWU6IDIwMjEtMTAtMzEgMjI6MDc6MDkgKFN1bmRheSkKPiA+ID4gT24g
U3VuLCBPY3QgMzEsIDIwMjEgYXQgNjo0NiBQTSBNYXNsb3YgRG1pdHJ5IDxtYXNsb3ZkbWl0cnlA
c2VlZWQuY2M+IHdyb3RlOgo+IAo+IC4uLgo+IAo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hc2xv
diBEbWl0cnkgPG1hc2xvdmRtaXRyeUBzZWVlZC5jYz4KPiA+ID4KPiA+ID4gSSBiZWxpZXZlIGl0
IHNob3VsZCBiZSBEbWl0cnkgTWFzbG92LCBpLmUuIEZpcnN0IG5hbWUgTGFzdCBuYW1lLgo+ID4K
PiA+IEkgY291bGQgY2hhbmdlIHRoYXQsIGJ1dCBJIGRvIG5vdCB0aGluayB0aGVyZSBpcyBhbiBp
bnRlcm5hdGlvbmFsIHN0YW5kYXJkIGZvciB0aGF0LiBUaGUgcmVhc29uIEkgcHV0IE1hc2xvdiBE
bWl0cnkKPiA+IGlzIHRvIGJlIGluIGxpbmUgd2l0aCBjb3Jwb3JhdGUgZW1haWwgYWRkcmVzcywg
d2hpY2ggYmVsb25ncyB0byBhIENoaW5lc2UgY29tcGFueSAtIGluIENoaW5hIHN1cm5hbWUgaXMg
cHV0IGZpcnN0Cj4gPiBvbiB0aGUgbGVnYWwgZG9jdW1lbnRzLgo+IAo+IEhtbS4uLiBZb3UgYXJl
IHJpZ2h0LCB0aGVyZSBpcyBubyBzdWNoIHJlcXVpcmVtZW50IGluIHRoZSBTdWJtaXR0aW5nCj4g
UGF0Y2hlcyBkb2N1bWVudC4KPiAuLi4KPiAKPiA+ID4gPiBAQCAtMTU5Nyw2ICsxNjEwLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBsdHJfYWNwaV9tYXRjaFtdID0gewo+
ID4gPiA+ICAgICAgICAgeyJMVEVSMDUwMSIsIGx0cjUwMX0sCj4gPiA+ID4gICAgICAgICB7IkxU
RVIwNTU5IiwgbHRyNTU5fSwKPiA+ID4gPiAgICAgICAgIHsiTFRFUjAzMDEiLCBsdHIzMDF9LAo+
ID4gPiA+ICsgICAgICAgeyJMVEVSMDMwMyIsIGx0cjMwM30sCj4gPiA+Cj4gPiA+IEFueSBldmlk
ZW5jZSBvZiB0aGlzIEFDUEkgSUQgYmVpbmcgaW4gdGhlIHdpbGQsIHBsZWFzZT8KPiA+Cj4gPiBJ
J20gc29ycnksIEkgZG8gbm90IGV4YWN0bHkgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24uIERvIHlv
dSBtZWFuIHdoZXJlIHRoYXQgcGFydGljdWxhciBzZW5zb3IgaXMgdXNlZD8KPiAKPiBDYW4geW91
IHByb3ZpZGUgYSBuYW1lIG9mIHRoZSBtYWNoaW5lIHdoaWNoIGhhcyB0aGlzIElEIGluIGl0cyBE
U0RUCj4gdGFibGUsIHBsZWFzZT8KCldlJ3JlIHN1Ym1pdHRpbmcgdGhpcyBwYXRjaCBzcGVjaWZp
Y2FsbHkgZm9yIHJlVGVybWluYWwuCkhlcmUgaXMgRFRTIGZpbGUgZm9yIHRoZSByZVRlcm1pbmFs
LCBjdXJyZW50bHkgYXdhaXRpbmcgbWVyZ2UgaW4gUmFzcGJlcnJ5IFBpIExpbnV4IGtlcm5lbApy
ZXBvc2l0b3J5LgpodHRwczovL2dpdGh1Yi5jb20vcmFzcGJlcnJ5cGkvbGludXgvYmxvYi82ZWY3
MzI4NzVkNzA1ZmYxNWNjNGMyNWQ0ZDBhMGVlZTg3ZGMyYTU4L2FyY2gvYXJtL2Jvb3QvZHRzL292
ZXJsYXlzL3NlZWVkLXJldGVybWluYWwtY29yZS1vdmVybGF5LmR0cyNMOTkKClNvLCB3aGlsZSBh
dCB0aGUgbW9tZW50IEFDUEkgcGFydCBpcyBub3QgYmVpbmcgdXNlZCwgbGF0ZXIgd2UgbWlnaHQg
dXNlIHRoaXMgc2Vuc29yIGZvciBvdGhlciwgeDg2IGJhc2VkCmJvYXJkcywgZm9yIGV4YW1wbGUg
T0RZU1NFWSAtIFg4Nko0MTI1ODAwLgoKSXMgdGhlcmUgYSBwYXJ0aWN1bGFyIHJlYXNvbiB5b3Ug
dGhpbmsgdGhpcyBwYXJ0IHNob3VsZCBiZSBvbWl0dGVkIGZvciBMVFIzMDM/Cg0KDQoNCg0KDQo=

