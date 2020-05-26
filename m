Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCAF1E1F51
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgEZKGU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 06:06:20 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:54598 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728048AbgEZKGT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 06:06:19 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Tue, 26 May 2020 18:05:49
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.78.173]
Date:   Tue, 26 May 2020 18:05:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Kangjie Lu" <kjlu@umn.edu>, "Jonathan Cameron" <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH] iio: magnetometer: ak8974: Fix runtime PM
 imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CACRpkdYr7mprhK9rdWEfuuwb7hxxc5aS5LZqKf4x5OgMrvh4CQ@mail.gmail.com>
References: <20200524025117.15679-1-dinghao.liu@zju.edu.cn>
 <CACRpkda9ENYMLZVnTzN2rn9UvsMOWpeDnOhh7zs4ttAJqgipKw@mail.gmail.com>
 <58a22985.cfec2.1724f66f322.Coremail.dinghao.liu@zju.edu.cn>
 <CACRpkdYr7mprhK9rdWEfuuwb7hxxc5aS5LZqKf4x5OgMrvh4CQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5ad23cba.d1763.172507207bb.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3YXj96cxece8JAA--.2665W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgYMBlZdtOUELAABs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbX0S07vEb7Iv0x
        C_Ar1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r4DMIAIbVCY0x0Ix7I2Y4AK64vIr41lV2
        xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCa
        FVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67
        AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBXaGF0IGFib3V0IGp1c3QgbW92aW5nIHRoZSBwbV9ydW50aW1lX3B1dCgpIHVudGlsIHRoZSBl
bmQKPiBvZiB0aGUgaW5pdGlhbGl6YXRpb24/IFJpZ2h0IGJlZm9yZSByZXR1cm4gMDsKPiBUaGVu
IHdlIGNhbiBrZWVwIHRoaXMgbmljZSBnb3RvIGV4aXRzIGFzIHRoZXkgYXJlLgo+IAo+IE1heWJl
IG1vdmUgYWxsIHRoZXNlIHRocmVlOgo+IAo+ICAgICAgIHBtX3J1bnRpbWVfc2V0X2F1dG9zdXNw
ZW5kX2RlbGF5KCZpMmMtPmRldiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEFLODk3NF9BVVRPU1VTUEVORF9ERUxBWSk7Cj4gICAgICAgICBwbV9ydW50aW1lX3Vz
ZV9hdXRvc3VzcGVuZCgmaTJjLT5kZXYpOwo+ICAgICAgICAgcG1fcnVudGltZV9wdXQoJmkyYy0+
ZGV2KTsKPiAKCkdvb2QgaWRlYSEgVGhhbmsgeW91IGZvciB5b3VyIGFkdmljZSBhbmQgSSB3aWxs
IGZpeCB0aGlzIAppbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHBhdGNoLiAKClJlZ2FyZHMsCkRpbmdo
YW8=
