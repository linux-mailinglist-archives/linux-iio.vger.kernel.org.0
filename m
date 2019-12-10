Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEEB118FE6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLJSle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 13:41:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46122 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfLJSle (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 13:41:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so9281301pgb.13
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2019 10:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wTwfKnj9eczpa2pB2PlbhOCyosSLl37njomT+ws8Zog=;
        b=RVgrOMkTunRC9OxL5bW0If9c94cX0AI3qE8o5LSXokwULZQBNlz3J+ZHFxD2aSZ+AN
         e+Q1LzgnEoidJXYohDJtMYRb9MC6Mu+DHArZuxrjH+kTm2xwOLz/hChE405Wmyl6+A6t
         yrH4qIIuMfE5MzIGCGMzHnt8Bj4ksmHwe845S9Id2ehdc0N8e8pdXa0Sn/DMVcHsNyOU
         XlWo/LNUUvy9nOJvz4FJI0UiB2c79gMHNrT1uLuhHtgLfjCb6w2YKw3D1v+hTXZmo4CW
         PjiQAjUCEz7AUqYD00+BjsAE+5HDpNCNye/JECrpwP0lL4PcBSJp4Koc6toEBKzrNg99
         4Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wTwfKnj9eczpa2pB2PlbhOCyosSLl37njomT+ws8Zog=;
        b=g6aTPvTB6RpFJwoJiqGsQxZgPWsdRsA2KIlzBCh5pvApeLwATl0W350IVZ77n3KLok
         fTiRWMd7NMa8sNU4JmU0TkNdkiN3gvaa0GuVpUBIBM963b6M3YgP4zzv18na/on7jcXW
         gbMA/CKhAFKVvXKpwkK842LcGr/jW+njMEDz89GrFVf3asRje1jBUtsTjhI0Uc/ftmT2
         K0NzzQGzL7uvlsOOQMOZSwplEjIEjtEhzWCGXYAykKheU7QepheNqj+vHllC+M0uiSNi
         BUlrpj7g+tqZamrUmOEeFBulvPgyM3QjGdiuTk1iVB5C3VM6zuWiezJcgyoq7ud/AibH
         uFhQ==
X-Gm-Message-State: APjAAAVQ35eaJZgbhM8LfuEsGcORCGZjwjTBw4ek1Oxr7L/0kO+aDz1H
        /TSKsrD55zCgbxacvdckWb7Jpw==
X-Google-Smtp-Source: APXvYqyU5AsS15FX5JR/4v9ywiSr7NjSeduEieNn9GzLr/P45Zt9Avb7WkbCrH/jY/mSnrUTizA8mA==
X-Received: by 2002:a63:5525:: with SMTP id j37mr25733818pgb.180.1576003293591;
        Tue, 10 Dec 2019 10:41:33 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d14sm3711274pjz.12.2019.12.10.10.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 10:41:29 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: a1: add saradc controller
In-Reply-To: <9a2ddfa3-28f3-7d15-bb25-5b84078b77c7@amlogic.com>
References: <1575358332-44866-1-git-send-email-xingyu.chen@amlogic.com> <7hpngxqfa7.fsf@baylibre.com> <9a2ddfa3-28f3-7d15-bb25-5b84078b77c7@amlogic.com>
Date:   Tue, 10 Dec 2019 10:41:28 -0800
Message-ID: <7h1rtcqazr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

WGluZ3l1IENoZW4gPHhpbmd5dS5jaGVuQGFtbG9naWMuY29tPiB3cml0ZXM6DQoNCj4gSGksIEtl
dmluDQo+DQo+IE9uIDIwMTkvMTIvMTAgNjo1NiwgS2V2aW4gSGlsbWFuIHdyb3RlOg0KPj4gWGlu
Z3l1IENoZW4gPHhpbmd5dS5jaGVuQGFtbG9naWMuY29tPiB3cml0ZXM6DQo+Pg0KPj4+IFRoZSBz
YXJhZGMgY29udHJvbGxlciBpbiBNZXNvbi1BMSBpcyB0aGUgc2FtZSBhcyB0aGUgTWVzb24tRzEy
IHNlcmllcyBTb0NzLA0KPj4+IHNvIHdlIHVzZSB0aGUgc2FtZSBjb21wYXRpYmxlIHN0cmluZy4N
Cj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFhpbmd5dSBDaGVuIDx4aW5neXUuY2hlbkBhbWxvZ2lj
LmNvbT4NCj4+Pg0KPj4+IC0tLQ0KPj4+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gQTEgY2xvY2sg
cGF0Y2hzZXQgYXQgWzBdLg0KPj4+DQo+Pj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWFtbG9naWMvMjAxOTExMjkxNDQ2MDUuMTgyNzc0LTEtamlhbi5odUBhbWxvZ2ljLmNvbQ0K
Pj4+IC0tLQ0KPj4+ICAgYXJjaC9hcm02NC9ib290L2R0cy9hbWxvZ2ljL21lc29uLWExLmR0c2kg
fCAxNSArKysrKysrKysrKysrKysNCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9hbWxvZ2ljL21l
c29uLWExLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FtbG9naWMvbWVzb24tYTEuZHRzaQ0K
Pj4+IGluZGV4IDcyMTBhZDAuLmNhZDE3NTYgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm02NC9i
b290L2R0cy9hbWxvZ2ljL21lc29uLWExLmR0c2kNCj4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2FtbG9naWMvbWVzb24tYTEuZHRzaQ0KPj4+IEBAIC05Myw2ICs5MywyMSBAQA0KPj4+ICAg
CQkJCWNsb2NrLW5hbWVzID0gInh0YWwiLCAicGNsayIsICJiYXVkIjsNCj4+PiAgIAkJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KPj4+ICAgCQkJfTsNCj4+PiArDQo+Pj4gKwkJCXNhcmFkYzogYWRj
QDJjMDAgew0KPj4+ICsJCQkJY29tcGF0aWJsZSA9ICJhbWxvZ2ljLG1lc29uLWcxMmEtc2FyYWRj
IiwNCj4+PiArCQkJCQkgICAgICJhbWxvZ2ljLG1lc29uLXNhcmFkYyI7DQo+Pj4gKwkJCQlyZWcg
PSA8MHgwIDB4MmMwMCAweDAgMHg0OD47DQo+PiBXaHkgMHg0OCBoZXJlPyAgQVhHIHVzZXMgMHgz
OCBhbmQgeW91J3JlIG5vdCBhZGRpbmcgYW55IG1vcmUgcmVnaXN0ZXJzDQo+PiB0byB0aGlzIGRy
aXZlci4NCj4NCj4gVGhhbmtzIGZvciB5b3UgcmV2aWV3Lg0KPg0KPiBUaGUgc2FyYWRjIGludHJv
ZHVjZXMgNCBuZXcgcmVnaXN0ZXJzIChhcyBzaG93biBiZWxvdykgYmVnaW4gd2l0aCBnMTJhIA0K
PiBwbGF0Zm9ybSwgYW5kIHRoZXNlIHJlZ2lzdGVycyBhcmUgdXNlZA0KPiB0byBzYXZlIHRoZSBz
YW1wbGluZyB2YWx1ZSBvZiBjb3JyZXNwb25kaW5nIGNoYW5uZWwuIEluIG90aGVyIHdvcmRzLCB3
ZSANCj4gY2FuIGNob29zZSBmaWZvIG9yIG5ldyByZWdpc3RlcnMgdG8gc2F2ZQ0KPiBzYW1wbGlu
ZyB2YWx1ZSwgYnV0IGl0IGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGN1cnJlbnQgZHJpdmVyLg0K
Pg0KPiBkb3V0IHJlZ2lzdGVywqAgfC0tLT4gZmlmbw0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwtLS0+IGNoYW5uZWwgcmVncyAtfA0KPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fC0tLSBjaGFubmVsLTANCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwtLS0gY2hhbm5lbC0xDQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IC4uLg0KPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAtLS0gY2hhbm5lbC03DQo+DQo+IEFPX1NBUl9BRENfQ0hOTDAx77yac2F2aW5nIHNhbXBsaW5n
IGRhdGEgb2YgY2hhbm5lbCAwLzENCj4gQU9fU0FSX0FEQ19DSE5MMjM6wqDCoCBzYXZpbmcgc2Ft
cGxpbmcgZGF0YSBvZiBjaGFubmVsIDIvMw0KPiBBT19TQVJfQURDX0NITkw0NTrCoMKgIHNhdmlu
ZyBzYW1wbGluZyBkYXRhIG9mIGNoYW5uZWwgNC81DQo+IEFPX1NBUl9BRENfQ0hOTDY3OsKgwqAg
c2F2aW5nIHNhbXBsaW5nIGRhdGEgb2YgY2hhbm5lbCA2LzcNCg0KSSB1bmRlcnN0YW5kIHRoZXJl
IGFyZSBuZXcgcmVnaXN0ZXJzIGluIHRoZSBoYXJkd2FyZSwgYnV0IEkgZG9uJ3QgdGhpbmsNCnRo
ZSBjdXJyZW50IGRyaXZlciBpcyB1c2luZyB0aG9zZS4gIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkn
bSB3cm9uZy4NCg0KPiBUaGlzIHBhdGNoIHVzZSB0aGUgMHg0OCB0byBkZXNjcmliZSB0aGUgcmVn
aXN0ZXJzIGxlbmd0aCBqdXN0IGZvbGxvdyB0aGUgDQo+IGZpbGUgbWVzb24tZzEyLWNvbW1vbi5k
dHNpLg0KDQpPSywgbXkgZmF1bHQuIEkgd2FzIGNvbXBhcmluZyB3aXRoIEFYRyBpbnN0ZWFkIG9m
IEcxMkEuICBCdXQgc3RpbGwsIGlmDQp0aGUgZHJpdmVyIGlzIG5vdCB1c2luZyB0aG9zZSByZWdp
c3RlcnMsIHRoZW4gZzEyIERUIGZpbGVzIGFyZSB3cm9uZyB0b28uDQoNClRoYXQgYmVpbmcgc2Fp
ZCwgSSdtIG5vdCBnb2luZyB0byBiZSB0b28gcGlja3kgYWJvdXQgdGhhdC4gIA0KDQo+IGFuZCBp
dCBkb2Vzbid0IGFmZmVjdCB0aGUgZHJpdmVyIGJlY2F1c2Ugb2YgdGhlIG1hcHBlZCByZWdpdGVy
IGxlbmd0aA0KPiBpcyBsaW1pdGVkIGJ5IG1heF9yZWdpc3RlciBtZW1iZXIgaW4gc3RydWN0IHJl
Z21hcF9jb25maWcuDQo+DQo+IEkgY2FuIHJlcGxhY2UgMHg0OCB3aXRoIDB4MzggaW4gbmV4dCBw
YXRjaCBpZiBuZWNlc3NhcnkuDQoNClNpbmNlIEcxMiBpcyBhbHJlYWR5IHVzaW5nIDB4NDggYW5k
IHRoaXMgZGV2aWNlIGlzIGNvbXBhdGlibGUgd2l0aCBHMTIsDQpJJ20gZmluZSBsZWF2aW5nIGl0
IGF0IDB4NDguDQoNClRoYW5rcywNCg0KS2V2aW4NCg0K
