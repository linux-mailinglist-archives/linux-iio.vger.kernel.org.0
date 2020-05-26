Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624D1E1A9E
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 07:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgEZFOl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 01:14:41 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:17074 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbgEZFOl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 01:14:41 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Tue, 26 May 2020 13:14:06
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.78.173]
Date:   Tue, 26 May 2020 13:14:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Kangjie Lu" <kjlu@umn.edu>, "Jonathan Cameron" <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] iio: magnetometer: ak8974: Fix runtime PM imbalance
 on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CACRpkda9ENYMLZVnTzN2rn9UvsMOWpeDnOhh7zs4ttAJqgipKw@mail.gmail.com>
References: <20200524025117.15679-1-dinghao.liu@zju.edu.cn>
 <CACRpkda9ENYMLZVnTzN2rn9UvsMOWpeDnOhh7zs4ttAJqgipKw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <58a22985.cfec2.1724f66f322.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3YXiepcxeDTEIAA--.1889W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcMBlZdtOTotgAAsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbX0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwVW8WwCS07vEc2IjII80xcxEwVAKI48JMI
        AIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lV2xY6IIF0xvEx4A2jsIE14v26r1j6r4UMIAIbVCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGksIExpbnVzCgo+IE9uIFN1biwgTWF5IDI0LCAyMDIwIGF0IDQ6NTEgQU0gRGluZ2hhbyBMaXUg
PGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+IHdyb3RlOgo+IAo+ID4gV2hlbiBkZXZtX3JlZ21hcF9p
bml0X2kyYygpIHJldHVybnMgYW4gZXJyb3IgY29kZSwgYSBwYWlyaW5nCj4gPiBydW50aW1lIFBN
IHVzYWdlIGNvdW50ZXIgZGVjcmVtZW50IGlzIG5lZWRlZCB0byBrZWVwIHRoZQo+ID4gY291bnRl
ciBiYWxhbmNlZC4gRm9yIGVycm9yIHBhdGhzIGFmdGVyIGFrODk3NF9zZXRfcG93ZXIoKSwKPiA+
IGFrODk3NF9kZXRlY3QoKSBhbmQgYWs4OTc0X3Jlc2V0KCksIHRoaW5ncyBhcmUgdGhlIHNhbWUu
Cj4gPgo+ID4gSG93ZXZlciwgV2hlbiBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9zZXR1cCgpIHJldHVy
bnMgYW4gZXJyb3IKPiA+IGNvZGUsIHdlIGRvbid0IG5lZWQgc3VjaCBhIGRlY3JlbWVudCBiZWNh
dXNlIHRoZXJlIGlzIGFscmVhZHkKPiA+IG9uZSBiZWZvcmUgdGhpcyBjYWxsLiBUaGluZ3MgYXJl
IHRoZSBzYW1lIGZvciBvdGhlciBlcnJvciBwYXRocwo+ID4gYWZ0ZXIgaXQuCj4gPgo+ID4gU2ln
bmVkLW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+Cj4gCj4gPiAg
ICAgICAgIGFrODk3NC0+bWFwID0gZGV2bV9yZWdtYXBfaW5pdF9pMmMoaTJjLCAmYWs4OTc0X3Jl
Z21hcF9jb25maWcpOwo+ID4gICAgICAgICBpZiAoSVNfRVJSKGFrODk3NC0+bWFwKSkgewo+ID4g
ICAgICAgICAgICAgICAgIGRldl9lcnIoJmkyYy0+ZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIHJl
Z2lzdGVyIG1hcFxuIik7Cj4gPiArICAgICAgICAgICAgICAgcG1fcnVudGltZV9wdXRfbm9pZGxl
KCZpMmMtPmRldik7Cj4gPiArICAgICAgICAgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKCZpMmMt
PmRldik7Cj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYWs4OTc0LT5tYXApOwo+
IAo+IFRoaXMgaXMgY29ycmVjdC4KPiAKPiA+ICAgICAgICAgcmV0ID0gYWs4OTc0X3NldF9wb3dl
cihhazg5NzQsIEFLODk3NF9QV1JfT04pOwo+ID4gICAgICAgICBpZiAocmV0KSB7Cj4gPiAgICAg
ICAgICAgICAgICAgZGV2X2VycigmaTJjLT5kZXYsICJjb3VsZCBub3QgcG93ZXIgb25cbiIpOwo+
ID4gKyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X25vaWRsZSgmaTJjLT5kZXYpOwo+ID4g
KyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmaTJjLT5kZXYpOwo+ID4gICAgICAg
ICAgICAgICAgIGdvdG8gcG93ZXJfb2ZmOwo+IAo+IFdoYXQgYWJvdXQganVzdCBjaGFuZ2luZyB0
aGlzIHRvIGdvdG8gZGlzYWJsZV9wbTsKPgo+ID4gICAgICAgICByZXQgPSBhazg5NzRfZGV0ZWN0
KGFrODk3NCk7Cj4gPiAgICAgICAgIGlmIChyZXQpIHsKPiA+ICAgICAgICAgICAgICAgICBkZXZf
ZXJyKCZpMmMtPmRldiwgIm5laXRoZXIgQUs4OTc0IG5vciBBTUkzMHggZm91bmRcbiIpOwo+ID4g
KyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X25vaWRsZSgmaTJjLT5kZXYpOwo+ID4gKyAg
ICAgICAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmaTJjLT5kZXYpOwo+ID4gICAgICAgICAg
ICAgICAgIGdvdG8gcG93ZXJfb2ZmOwo+IAo+IGdvdG8gZGlzYWJsZV9wbTsKPiAKPiA+IEBAIC03
ODYsNiArNzkyLDggQEAgc3RhdGljIGludCBhazg5NzRfcHJvYmUoc3RydWN0IGkyY19jbGllbnQg
KmkyYywKPiA+ICAgICAgICAgcmV0ID0gYWs4OTc0X3Jlc2V0KGFrODk3NCk7Cj4gPiAgICAgICAg
IGlmIChyZXQpIHsKPiA+ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZpMmMtPmRldiwgIkFLODk3
NCByZXNldCBmYWlsZWRcbiIpOwo+ID4gKyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X25v
aWRsZSgmaTJjLT5kZXYpOwo+ID4gKyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgm
aTJjLT5kZXYpOwo+IAo+IGdvdG8gZGlzYWJsZV9wbTsKPiAKPiA+ICBkaXNhYmxlX3BtOgo+ID4g
LSAgICAgICBwbV9ydW50aW1lX3B1dF9ub2lkbGUoJmkyYy0+ZGV2KTsKPiA+ICAgICAgICAgcG1f
cnVudGltZV9kaXNhYmxlKCZpMmMtPmRldik7Cj4gPiAgICAgICAgIGFrODk3NF9zZXRfcG93ZXIo
YWs4OTc0LCBBSzg5NzRfUFdSX09GRik7Cj4gCj4gS2VlcCB0aGUgdG9wIHBtX3J1bnRpbWVfcHV0
X25vaWRsZSgpLgoKSSBmb3VuZCB0aGF0IHRoZXJlIHdhcyBhbHJlYWR5IGEgcG1fcnVudGltZV9w
dXQoKSBiZWZvcmUgCmlpb190cmlnZ2VyZWRfYnVmZmVyX3NldHVwKCkgKGp1c3QgYWZ0ZXIgcG1f
cnVudGltZV91c2VfYXV0b3N1c3BlbmQpLgpTbyBpZiB3ZSBrZWVwIHRoZSBwbV9ydW50aW1lX3B1
dF9ub2lkbGUoKSBoZXJlLCB3ZSB3aWxsIGhhdmUKdHdvIHBtdXNhZ2UgY291bnRlciBkZWNyZW1l
bnQuIERvIHlvdSB0aGluayB0aGlzIGlzIGEgYnVnPwoKUmVnYXJkcywKRGluZ2hhbwoKPiAKPiBU
aGUgYWs4OTc0X3NldF9wb3dlcigpIGNhbGwgaXMgZmluZSwgdGhlIHBvd2VyIG9uIGNhbGwgZG9l
cyBub3QKPiBuZWVkIHRvIGhhcHBlbiBpbiBiYWxhbmNlLiBTdXJlIGl0IHdpbGwgYXR0ZW1wdCB0
byB3cml0ZSBhIHJlZ2lzdGVyCj4gYnV0IHNvIHdpbGwgdGhlIHBvd2VyIG9uIGNhbGwuCj4gCj4g
WW91cnMsCj4gTGludXMgV2FsbGVpago=
