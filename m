Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF059261B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiHNTNi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHNTNi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 15:13:38 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB32126A
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:13:35 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id l18so4143822qvt.13
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zv1kEl9r4RJcjt8sZ2Uk5u9N5M4I8yhjo8C3pO7/fBQ=;
        b=CcXW7i9QI+7hBgOkbfbAItoC0WHnxKP84JpBiIKbFS09b56sSh36CJtyKRq0/aGTAB
         6wE5iEcrlgDR7R0omprTwRx/fVaK6j9KyD+XXx4mbFGRWBhQUXNOb/HTfDkkAuAAUlDO
         x97GM0RUxgv85ovfXhH6B5gw3VjWJeoia52dJadSZ9sOsRox3TRHij/Z9qCSNvIUj+2S
         toIZHqYk4CPZNrBE20tYIEtCAWHhll2K9p9kgFI4AQkSO+LnYtbBd2V/JXgurBcNwSEs
         ZKgqW09SO8EmeLnzUFbu2eqv6EiiPpYa+iufJlQYQ7mG8U6dWXSKw2p7A0DKGpkXTuIE
         Vozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zv1kEl9r4RJcjt8sZ2Uk5u9N5M4I8yhjo8C3pO7/fBQ=;
        b=kIU495rXxQxobG+JLifUHSnw7906Yp+/n3HIXtD9zaOw1n9lQrBzZmhTPqJGFmge4Y
         Jj7840HUs20jhHbJrAKnVcfT2bLll5M9eMkQ5xqOexaxxJ86G8jI6iJz0Jn5QkfNaEC2
         1sCnVspd4IxlPQxqgXz3bPNBN5E9SsEAThsvAx92LTrENXUzos+U3P/AmawuMHDKjaFl
         XhmxM/Zy+cCjev9XTz8BhaykB9mngMsNiU8Do/SRJeKcqa8X7FW2Lf+1Cli9UbyatCii
         IXjTt3Q16ehqkkJCjHLmPg/k7AfAFPsdnP/D785rusxl9SQGDT3dRczXERto1bToqa95
         xFhg==
X-Gm-Message-State: ACgBeo3XCEmb9aeJScV5Ud8WZCiKrrZPg4ewnzewUnaKL1k1rsCzBYHT
        tkAYJn95fQLnM8Ucx2VWkNRHtt/lqu/kTrMt/198OAsL
X-Google-Smtp-Source: AA6agR6JvlD5LH1ktf4z06APBb3tQSh78gFTs2L/uRxuorTD/+vMF81xg5Qsg6QK7ZQuwNWcTQho3sLkkQ1lxHo4l0c=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr10818287qvq.64.1660504414945; Sun, 14
 Aug 2022 12:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220807190712.1039403-1-jic23@kernel.org> <CAHp75VfFGUQevM3skOF_wSxSvTTUy98KCDqyOXUhBLpZ6-g4UQ@mail.gmail.com>
 <20220813171303.7b682989@jic23-huawei>
In-Reply-To: <20220813171303.7b682989@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 22:12:59 +0300
Message-ID: <CAHp75VdgcJ96tg-XMHAricQc9Dti3+PKhFiOtSnCn45ehpoxJA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l: Use RUNTIME_PM_OPS() instead of SET_*
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 13, 2022 at 7:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 8 Aug 2022 11:34:23 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Aug 7, 2022 at 9:11 PM Jonathan Cameron <jic23@kernel.org> wrote:

> > > Here we could use DEFINE_RUNTIME_DEV_PM_OPS() but that would have the
> > > side effect of providing suspend and resume support.  That would be
> > > harmless but also of little purpose as this driver does very simplistic
> > > power management with synchronous power up and down around individual
> > > channel reads.
> > >
> > > In general these new PM macros avoid the need to mark functions
> > > __maybe_unused, whilst still allowing the compiler to remove them
> > > if they are unused.
> >
> > ...
> >
> > >  static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> > > -       SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> > > -                          rzg2l_adc_pm_runtime_resume,
> > > -                          NULL)
> > > +       RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> > > +                      rzg2l_adc_pm_runtime_resume,
> > > +                      NULL)
> > >  };
> >
> > DEFINE_RUNTIME_DEV_PM_OPS() ?
> >
> Disagreeing with the patch description argument on why I didn't do that?
> The extra ops set will never have anything to do...  Mostly harmless,
> but kind of gives the wrong impression of what is going on in this
> driver.

As per thread with Paul, this patch has no function change intentions,
but also, if tested on hardware, enabling system sleep states
shouldn't be harmful.

-- 
With Best Regards,
Andy Shevchenko
