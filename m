Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8B6056CC
	for <lists+linux-iio@lfdr.de>; Thu, 20 Oct 2022 07:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJTFb6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Oct 2022 01:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJTFb4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2022 01:31:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB26193EF3
        for <linux-iio@vger.kernel.org>; Wed, 19 Oct 2022 22:31:55 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o22so12168084qkl.8
        for <linux-iio@vger.kernel.org>; Wed, 19 Oct 2022 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke+DoHhz1XKy9xeNSiWO0Eq/IHfSDBUW8TnozKir+yg=;
        b=TySompZSaWj8ilygpbslEMOvJTyRDnsYlgZ7bhvmjaCxBESJPZDRCdfrFYuDYx9oZu
         451dsTbKp4i9rwAtT+BFxZzipZwyc8Wv3aoE3j08Z07k+CF6nvXckaV1k9uOf97oZxiC
         FhrlGnntM2FeFAOCw5dwNL8d8s3NbsokJObDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke+DoHhz1XKy9xeNSiWO0Eq/IHfSDBUW8TnozKir+yg=;
        b=V/Zxeq0J2xtTYiFkBmdnJhe6+IXeOEXFCb74YcSFlpB2nKSqNsji4HACK2ggIzbV4+
         gXauDDgSGywksTZOVZ3U70LS61KI6Zf+s0OgkL/AXwog0mw4/dXCz/hYRKuvSRTlzwew
         93s+F68gzyYO/q6h7B7js6ESGyMETpha5akZ+LEJrG7gTSL9cFBGk+g7sXJzY0p86gbv
         RpvUn1V8S0GzIAbWLAJK31ZZrCDqdojtkvV/9eUYhedKOhOuMgjyWDdw7J/CsGQPf7GU
         vSvZ7lTPZ7i9SeZ+SYCryREBOrRXYP3BJGYs+fOdZqgQFxfTWiUi2EUHwPHayRqN6k2f
         TZbA==
X-Gm-Message-State: ACrzQf1NSPuWjIB/igFL+XZVmVvq3P+tzy6xYRAB6cYI5CKoN2B2l5kE
        EnidmjbK5ZJ9iyDbd5rle7bwBhYxW4c8YNu99qK/88eigViCBA==
X-Google-Smtp-Source: AMsMyM7rbr3SeVf2uq/UjmCaSllheYSnF+G+Nq3nkPhZYx70376dLOjGbkDbvp1MKM63ck4gxD61zyrIdQpk52EU2bQ=
X-Received: by 2002:a05:620a:4510:b0:6ee:e6de:828d with SMTP id
 t16-20020a05620a451000b006eee6de828dmr8382571qkp.70.1666243914644; Wed, 19
 Oct 2022 22:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221019125254.952588-1-mitja@lxnav.com> <20221019125254.952588-3-mitja@lxnav.com>
 <CAHp75VcCORhVefBoQgnbe+aRJfJHfJ7PTk=Xr1eQaEYFsdJvLQ@mail.gmail.com>
In-Reply-To: <CAHp75VcCORhVefBoQgnbe+aRJfJHfJ7PTk=Xr1eQaEYFsdJvLQ@mail.gmail.com>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Thu, 20 Oct 2022 07:31:28 +0200
Message-ID: <CACbQKWeRVXw_78-OoZFHCNX+tgRx_OfCaK7OaYBBwzjMAxcYng@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: iio: pressure: ms5611: added max SPI frequency
 setting to the example
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 19, 2022 at 3:23 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 3:55 PM Mitja Spes <mitja@lxnav.com> wrote:
> >
> > Added max SPI frequency setting to the example. It is now honored by the
> > driver.
>
> Is it possible to add a constraint here? So the schema validator will
> issue the warning / error if the speed is too high.

The constraint is already there:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/pressure/meas%2Cms5611.yaml
```
spi-max-frequency:
    maximum: 20000000
```

But in any case the patch 2/3 limits the max frequency.

Kind regards,
Mitja Spes
