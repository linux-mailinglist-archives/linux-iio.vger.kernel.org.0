Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC411ADB95
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgDQKum (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729238AbgDQKul (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:50:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2AC061A0C;
        Fri, 17 Apr 2020 03:50:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so828850plk.10;
        Fri, 17 Apr 2020 03:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Je/eLmrKhS3hdneu92S4cmYbnB84FusrgAZoZiZ1TmY=;
        b=BBjGapnQsGPSilyRxQstsGW/Tdd3ArqijwGKdeFMjiK+edNoW1X135JfO/AxTH3g+V
         lWvkkrbv5jqrlhXzNZs+DVHpQw4ZdOEDqEHVtlud2p2K7NoxC1xB7NwGj3yLaoDZeHJV
         59J/ovTk1OQsRqvHaSaiVgAu4HpQmWHGdL1K7RS0DP8qmeHYtpMYTXm0QGnL8SvL+iHH
         K3wUvqyl8/nLq2ueQzzFbdpvT5IC9L+4DNaLqRtGb9ucRj0C+hHTVic4+1vqgX/ISK9v
         PvZjVoNZafw+UlP8rZz4ION2Y1iVVxoDtk8fu2lMuc66duOMdbALlmPjWHIi+evdZEq2
         3Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Je/eLmrKhS3hdneu92S4cmYbnB84FusrgAZoZiZ1TmY=;
        b=dOcCZ7ME01YITBRl2jjxM73AQMIyw75+h1gZgDh7zZ5cfE6blW/JgvAdjDstHlDvdy
         P1rrjIsbZUrInJFv+n1OARf+ImFc/WfNfz0ybxvmNviaPDRljnaLpGOGOk12vGlLiDqV
         lVzpbK/iBKuIO9NqgLu0fFzX9Fecf7mrTTJr2SgiLxpa4T974tI5kRGXOAGaxYY99w1e
         dtfCpNYcBNmzs6aLxVt5DuHMfagGqbcCEgbK7J6EsOFlb0M02U+5h0MtGsU2S8fIpPya
         ZFxHTEnZhcXnc7KncOxCrqt1utGUhVq7rloQYx4qjC7k9qbzfMx0FqKhLVj8UkH0f+GW
         XdtQ==
X-Gm-Message-State: AGi0PuZIWZUY+DE6kABwVTsof9bfj4yFpOru6Co/iC3cdsjbTS8m2LEt
        o0P2Jh68LbsEr1tFVyX/6Nu3Rq93lepN+SMbTfY=
X-Google-Smtp-Source: APiQypLBwl6Gl7xdzmrIHTDp0wku+POYI6v/91l0vZXpBhC76ZlTjBtazQvlJtnJti5DsGxyTnbzzsF2RUN7oK9sNMQ=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr3597676pjb.143.1587120640825;
 Fri, 17 Apr 2020 03:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200417080549.23751-1-brgl@bgdev.pl> <20200417080549.23751-2-brgl@bgdev.pl>
In-Reply-To: <20200417080549.23751-2-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:50:29 +0300
Message-ID: <CAHp75Vf_kBfb_oLB2Dp48iYiDgs2k_RgzpudTvQMoxNYGMz3TA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] irq: make irq_domain_reset_irq_data() available
 even for non-V2 users
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 11:13 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
> made available even if irq domain hierarchy is not being built. We'll
> subsequently use it in irq_sim code.


> @@ -475,7 +476,6 @@ extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>  extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
>  extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
>  extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
> -
>  static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
>                         unsigned int nr_irqs, int node, void *arg)
>  {

Seems extra hunk slipped to the patch.

-- 
With Best Regards,
Andy Shevchenko
