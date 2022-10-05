Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4555F50B1
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 10:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJEIPq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJEIPp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 04:15:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E55F4B99F
        for <linux-iio@vger.kernel.org>; Wed,  5 Oct 2022 01:15:44 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id fb18so115811qtb.12
        for <linux-iio@vger.kernel.org>; Wed, 05 Oct 2022 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=tAPw4yEf6SHNItylvGA1OKl9dXOTYh49zTb3gddLagI=;
        b=hN3AR8nr0ypcbUd+d3GaDTtK0QyAJVmFiLOU72ULL3RAar+RsSMOTgplk4ILNXz1Zm
         zknUvcQ9jfm+Bsc6+yrBd7/mGeQp2VfW7NODyefMac6S925K67W7OZjoCVPb6IswdCqe
         w1ecnUoblAGDQ6j16fuAOp8r07av3QVqiOvTmi84vu1k8B7DPluszTydvkDQ9d3uYKFs
         Q+60s+MA5nj4arq/nLPmU6mCnHqCDjLnQSWEHyzTKbUGjvdfhb+1L6pBAucpQLMELmre
         uOoiIxsncH9PHrpKX04F1t400n2hWhCePDf082e26+xO44DluDU8ouS5ATm0h0iCWP0m
         FL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=tAPw4yEf6SHNItylvGA1OKl9dXOTYh49zTb3gddLagI=;
        b=Q1tcDQf1SExeSnGA6zU/11g3pMLZWdXtFOyZfLooeuI+sIpW9y2O3vSARXDUMMCuFy
         KtQqysE/+oTzYLx+jqMZiuueuicgUSCKVcaPLXDN6VBlKqNl5lARxW1eQKYnUhk8+1X0
         m5vla8Qz1uGwZd7YfU1dbSAGw4/ZZ7R9isH+274sWavJOmCyOPnpfjL82wkFGdUkIN4K
         fkfg9kK5WobcFk4OW19ERtNK9t2FJyX6F41+15UsWoAisLXDg3vpLOBGdq/TTU4pvMje
         A512pADw8ChlBeMWQtNSbl1jwBL7E5NjNEAxhQ07IicXNuxhb8uqVO/aZrGjOXgbkRAr
         2FZg==
X-Gm-Message-State: ACrzQf3eAxkW7WDjoYnnoZJwxIVJ6btQqXijU0d1QjdFFLaDyOhqGkHN
        n4OmnvFu5hYvrnIJ54mcyHM=
X-Google-Smtp-Source: AMsMyM7+mm1zQ34QC8GikFji+VHDdjcJmdbQ82iZxoJPrhQEawjnE996rvoGiMpoelrDKzjd/RtpdA==
X-Received: by 2002:a05:622a:252:b0:35d:482f:e105 with SMTP id c18-20020a05622a025200b0035d482fe105mr22690420qtx.92.1664957743172;
        Wed, 05 Oct 2022 01:15:43 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id z2-20020ac875c2000000b0035cf2995ad8sm13559089qtq.51.2022.10.05.01.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:15:42 -0700 (PDT)
Message-ID: <428661431e54744064946ced681cc0351d51d698.camel@gmail.com>
Subject: Re: [PATCH v2 15/16] iio: health: max30102: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Wed, 05 Oct 2022 10:17:00 +0200
In-Reply-To: <CAHp75VdiAzOUNMB3wD5og-uZi1W_7UWkqV6+s7jCxpaBs1VWRQ@mail.gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
         <20221004134909.1692021-16-nuno.sa@analog.com>
         <CAHp75VdiAzOUNMB3wD5og-uZi1W_7UWkqV6+s7jCxpaBs1VWRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDE3OjE1ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gVHVlLCBPY3QgNCwgMjAyMiBhdCA0OjQ5IFBNIE51bm8gU8OhIDxudW5vLnNhQGFuYWxv
Zy5jb20+IHdyb3RlOgo+ID4gCj4gPiBUaGUgcGF0dGVybiB1c2VkIGluIHRoaXMgZGV2aWNlIGRv
ZXMgbm90IHF1aXRlIGZpdCBpbiB0aGUKPiA+IGlpb19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUo
KSB0eXBpY2FsIHVzYWdlLiBJbiB0aGlzIGNhc2UsIHdlIHdhbnQKPiA+IHRvCj4gPiBrbm93IGlm
IHdlIGFyZSBpbiBidWZmZXJlZCBtb2RlIG9yIG5vdCB0byBrbm93IGlmIHRoZSBkZXZpY2UgaXMK
PiA+IHBvd2VyZWQKPiA+IChidWZmZXIgbW9kZSkgb3Igbm90LiBBbmQgZGVwZW5kaW5nIG9uIHRo
YXQgbWF4MzAxMDJfZ2V0X3RlbXAoKQo+ID4gd2lsbAo+ID4gcG93ZXIgb24gdGhlIGRldmljZSBp
ZiBuZWVkZWQuIEhlbmNlLCBpbiBvcmRlciB0byBrZWVwIHRoZSBzYW1lCj4gPiBmdW5jdGlvbmFs
aXR5LCB3ZSB0cnkgdG86Cj4gPiAKPiA+IDEuIENsYWltIEJ1ZmZlcmVkIG1vZGU7Cj4gPiAyOiBJ
ZiAxKSBzdWNjZWVkcyBjYWxsIG1heDMwMTAyX2dldF90ZW1wKCkgd2l0aG91dCBwb3dlcmluZyBv
biB0aGUKPiA+IMKgwqAgZGV2aWNlOwo+ID4gMzogUmVsZWFzZSBCdWZmZXJlZCBtb2RlOwo+ID4g
NDogSWYgMSkgZmFpbHMsIENsYWltIERpcmVjdCBtb2RlOwo+ID4gNTogSWYgNCkgc3VjY2VlZHMg
Y2FsbCBtYXgzMDEwMl9nZXRfdGVtcCgpIHdpdGggcG93ZXJpbmcgb24gdGhlCj4gPiBkZXZpY2U7
Cj4gPiA2OiBSZWxlYXNlIERpcmVjdCBtb2RlOwo+ID4gNzogSWYgNCkgZmFpbHMsIGdvdG8gdG8g
MSkgYW5kIHRyeSBhZ2Fpbi4KPiA+IAo+ID4gVGhpcyBkYW5jZSBiZXR3ZWVuIGJ1ZmZlcmVkIGFu
ZCBkaXJlY3QgbW9kZSBpcyBub3QgcGFydGljdWxhcmx5Cj4gPiBwcmV0dHkKPiA+IChhcyB3ZWxs
IGFzIHRoZSBsb29wIGludHJvZHVjZWQgYnkgdGhlIGdvdG8gc3RhdGVtZW50KSBidXQgaXQgZG9l
cwo+ID4gYWxsb3cKPiA+IHVzIHRvIGdldCByaWQgb2YgdGhlIG1sb2NrIHVzYWdlIHdoaWxlIGtl
ZXBpbmcgdGhlIHNhbWUgYmVoYXZpb3IuCj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoaWlvX2RldmljZV9jbGFpbV9idWZmZXJfbW9kZShpbmRpb19kZXYp
KSB7Cj4gCj4gV2h5IGlzIHJldCBub3QgdXNlZCBoZXJlPwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoaXMgb25lIGlzIGEgKmJpdCogaGFja3ku
IElmIHdlIGNhbm5vdAo+ID4gY2xhaW0gYnVmZmVyCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG1vZGUsIHRoZW4gdHJ5IGRpcmVjdCBtb2RlIHNv
IHRoYXQgd2UKPiA+IG1ha2Ugc3VyZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiB0aGluZ3MgY2Fubm90IGNvbmN1cnJlbnRseSBjaGFuZ2UuIEFu
ZAo+ID4gd2UganVzdCBrZWVwCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIHRyeWluZyB1bnRpbCB3ZSBnZXQgb25lIG9mIHRoZSBtb2Rlcy4uLgo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZgo+ID4gKGlp
b19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUoaW5kaW9fZGV2KSkKPiAKPiAuLi5hbmQgaGVyZT8K
PiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBhbnlfbW9kZV9yZXRyeTsKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gCj4gSS5vLncuIHdoYXQgZXJyb3IgY29kZSB3aWxsIGJlIHZpc2libGUgdG8gdGhlIGNh
bGxlciBhbmQgd2h5Lgo+IAoKTm90ZSB0aGF0IHdlIGRvIG5vdCByZWFsbHkgY2FyZSBhYm91dCB0
aGUgZXJyb3IgY29kZSByZXR1cm5lZCBieSBib3RoCmlpb19kZXZpY2VfY2xhaW1fYnVmZmVyX21v
ZGUoKSBhbmQgaWlvX2RldmljZV9jbGFpbV9kaXJlY3RfbW9kZSgpLiBXZQpqdXN0IGxvb3AgdW50
aWwgd2UgZ2V0IG9uZSBvZiB0aGUgbW9kZXMgKHRodXMgcmV0ID0gMCkgc28gdGhhdCB3ZSBjYW4K
c2FmZWx5IGNhbGwgb25lIG9mIHRoZSBtYXgzMDEwMl9nZXRfdGVtcCgpIHZhcmlhbnRzLiBBbmQg
dGhhdCB3aWxsIGJlCnRoZSB2aXNpYmxlIGVycm9yIGNvZGUgKGlmIGFueSkuIFRoYXQgc2FpZCwg
eW91IGNhbiBsb29rIGF0IHRoZSBmaXJzdAp2ZXJzaW9uIG9mIHRoZSBzZXJpZXMgYWJvdXQgdGhp
cyAoYW5kIHRoZSBwcmV2aW91cyBwYXRjaCkgYW5kIHdoeSB0aGlzCmlzIGJlaW5nIGRvbmUgbGlr
ZSB0aGlzIChub3RlIHRoYXQgSSdtIGFsc28gbm90IDEwMCUgY29udmluY2VkIGFib3V0CnRoaXMg
cGluZyBwb25nIGJldHdlZW4gZ2V0dGluZyBvbmUgb2YgdGhlIElJTyBtb2RlcyBidXQgaXQncyBh
bHNvIG5vdAp0aGF0IGJhZCBhbmQgaWYgdGhlcmUncyBubyBtYWpvciBjb21wbGFpbnMsIEknbSBm
aW5lIHdpdGggaXQpLgoKLSBOdW5vIFPDoQo=

