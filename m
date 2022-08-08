Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9558C587
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiHHJ2v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiHHJ2u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:28:50 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95413F56
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:28:49 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id y11so5960886qvn.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W+B+D8sRbjIlVNYmUHbWQaqUTUJ1MMhwcTCA2xLUNLs=;
        b=FwT1ozFKdXwSivRMFRA+RS5qQntzD08Qn17BI4rVzK1NA9TnkZ+oT68wFc6aYzGvxk
         vFgQBPelihunt+tpEzRCoYjF8z6jn0ims6igM6gApC3shniyQnNNHHbkqzaGA5Q4/nAy
         DdARRiORFZU/ewZf17g/xaOiVrpyruiR4zNXPgFR27WvNNMqF2bUMfvbyTJ/xqI1ycOB
         RP/glWXuqJQaz+l+e2tDqkpITlAx9SWjUD8tBIIp/A4kwteLT34JjOcrNGqNRT0Y9yiC
         6C3S4cgxUV0pU5Hjss5IpSPMWLTHM3PNZBWxXPxji+jPqXYn0ysBu+t81jhCoeh61Ohn
         gNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W+B+D8sRbjIlVNYmUHbWQaqUTUJ1MMhwcTCA2xLUNLs=;
        b=4hA6xskYlqfrjMnFiT3wuv+NQsgci4p/qoLpfeN36B0Yn+aN4JUnP3ygW7yvcN2023
         6HP5P2OhYZdh5hh4MYLBfhW7mgMXNInNcwI33s9OexPKEN9BACULwC9JOpGUvWLXvtxI
         hheaMYpGlLa8aFdWJ7Y3LCgBltGc0Rer53MI45GvQgUM8DVL7mrAm0rRIMHoR55T5neT
         Mf3n9ht45cf+CkDJP7dvGhGDgJ7wKejJSa3+47nNY9uSA3Hbal4Jmef1N9nNFNYiNIee
         OL4jMheo+grlJRnDhqT+BkR+mtXC16Yv0r5XdGZlCLz7kgpkQsjJpsvcB0PP/2n/meyj
         mJDQ==
X-Gm-Message-State: ACgBeo2wtHKarZrAw3GZEa/2sfEqCuyx6Fm3hvKkEOMoE0SK49R1X5F5
        DbBg5VPhdaiv+BjVbPzew1WPCMOC2aSn8G9FUqI3zv8n22c=
X-Google-Smtp-Source: AA6agR5oO3NBEI01hp+2mcr1+ujrmIQLxs7T9FT9gMluVv2sYG06kXTWYowSjJFXYLECSz8Jr2U3+gAwamer0VK2y6k=
X-Received: by 2002:a05:6214:e69:b0:476:b991:586f with SMTP id
 jz9-20020a0562140e6900b00476b991586fmr15029730qvb.48.1659950928873; Mon, 08
 Aug 2022 02:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220807185618.1038812-1-jic23@kernel.org> <20220807185618.1038812-5-jic23@kernel.org>
In-Reply-To: <20220807185618.1038812-5-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:28:12 +0200
Message-ID: <CAHp75Vf5PX3UsyofUWbaw7ndntp0fSrLhRP2fcQGnjA_wOTZ+w@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: proximity: srf04: Use pm_ptr() to remove unused
 struct dev_pm_ops
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, Aug 7, 2022 at 8:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> If CONFIG_PM is not set, the pm_ptr() will ensure that the struct
> dev_pm_ops and callbacks are removed without the need for __maybe_unused
> markings.
>
> In this case we can't simply use DEFINE_RUNTIME_DEV_PM_OPS() because
> that would provide suspend and resume functions without the
> checks the driver is doing before calling runtime_pm functions
> (whether the necessary GPIO is provided).  It may be possible to
> clean that up in future by moving the checks into the callbacks.

...

>  static const struct dev_pm_ops srf04_pm_ops = {
> -       SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> -                               srf04_pm_runtime_resume, NULL)
> +       RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> +                      srf04_pm_runtime_resume, NULL)
>  };

static DEFINE_RUNTIME_DEV_PM_OPS(...);

?

-- 
With Best Regards,
Andy Shevchenko
