Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120BF57BAC0
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGTPrR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jul 2022 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGTPrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2022 11:47:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A96941D30
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 08:47:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b10so7177698pjq.5
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdIHSwueZwEBeNauClrTeD9IGAfwuhJyeScJS1stpc4=;
        b=JNe3mHnu+Cg/HjmOPprglTWJni5EFqLAy27v2T8xgjR/yIjXu5EfDcuh/kMmKlqtbr
         rNZ/H9eBdaDtq9D6Uf+lk9qJlz/QkRkPboB5YbO/8dUTdP64uJxUUXM6gjZA590KJ3EH
         C/hzKMUtqYX5qDP6DrTp7HFOHl5y87HXgcz5Z/htuSwCsd0JUInNDJty97ygF9nh53I4
         YK6oZYfk4B3wj30UGJ/9bICRb0J4QiCFuZZTwSkBZbtsWdE5s1z5EZVqiPETUP/mnw2p
         /B1KJBsDSRjSiEwFJrTODsKbnenMT+F6mFVEa0lNqPhzicWwXb5GeXwt3m6Vr9YaJhKJ
         dg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdIHSwueZwEBeNauClrTeD9IGAfwuhJyeScJS1stpc4=;
        b=fsJlBQZx2N9Zj9sXPl8devWiRiQsy3blPzNeB985Ypx87pY/RBVgajTXjo7yvAV2Bu
         1CuYkWVMn7p4jD42IIRjIw/v+P/PVo15jU95/cIP73uD7wL3a/JZHE3FaPsTCmlhwsGU
         Wsn8ZDNNCVwyLFHC7ponY/C+5cLnBTDXOrxChFEJbMIxWfsyd3PhpXygGWWzSbe3MHlE
         lhT7/JXMh7HYAGug92Y/mGuxyCkTwUT6J+h9f3MB1C1JC5y27bphSjqJFYK0vKzu83Uv
         /MgRbwSAjmeahcqYFubW0qxl55hMZTRkA7cIVaiDE9WT0RcG57dRj9UlVZc4l0mDwXm9
         8xEQ==
X-Gm-Message-State: AJIora/NEudxx4EEmQPpprTASQh3p5B0rofTEOXPYkDIa13zn9E2aw9p
        0YcvPYT0cxSqmAg4j3Y/x6YJsg7mtx5FN2pk+Ss=
X-Google-Smtp-Source: AGRyM1sT3OJG1l3JOU+kDd+LdAEUj9e4H3n+Vm519+79nY4DmJiEK1BoM0oXIsLmudVUfK5516IRYpZ7Y7Om1D4ZQ7w=
X-Received: by 2002:a17:902:ce86:b0:16c:8a4e:746a with SMTP id
 f6-20020a170902ce8600b0016c8a4e746amr36758808plg.168.1658332035980; Wed, 20
 Jul 2022 08:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220720153136.3502440-1-martin.larsson@actia.se>
In-Reply-To: <20220720153136.3502440-1-martin.larsson@actia.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Jul 2022 12:47:01 -0300
Message-ID: <CAOMZO5CpbrqafGJYyj8csivAieysSdOjbWaBMf3hz+iBsDqapw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: imx8qxp-adc: propagate regulator_get_voltage error
To:     Martin Larsson <martin.larsson@actia.se>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Martin,

On Wed, Jul 20, 2022 at 12:31 PM Martin Larsson <martin.larsson@actia.se> wrote:
>
> If the ADC vref regulator returns an error, for example, if CONFIG_REGULATOR
> is not set, the error will be used as a reference voltage.
>
> Introduce a guard for negative return values instead of unconditionally
> casting it to u32.
>
> Acked-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Martin Larsson <martin.larsson@actia.se>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
