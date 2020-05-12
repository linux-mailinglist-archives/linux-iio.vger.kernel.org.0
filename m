Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE491CFBB3
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgELRMt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELRMt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 13:12:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D8C061A0F
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 10:12:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z80so8873922qka.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mhXIarFJGq4Y7o1OACEMY+CWjpNuyCrBkx0AvhbST58=;
        b=Yf7kJP8TPOhuvK1QsyJFscagmDUQZK+pL/Y6v6hbW+/t58l6484/Vvudp5TmsD66Vt
         ZONixv6Z6GQNvj9xxmrbpKfZiHkllK9oOmUj03VSq3CnB7zHzAVUu0g4gk29zJgYIFnZ
         f5hjoYCB9IISk16xC5+FX5Ym/KaPYaNpy0AbL8QM25gdCBcZje70QIw0LwxqIbXeRMvH
         axOI0kqzxQOK6xsNSCwvEpQITI75sAyJ/ZvIz+WtxJdlU0TE/X+D1Vu5mySY0N6NauSH
         OyaW5sRpqz6N97CnWlBFBDTjsjG8qXyEDp73cGlwoZejHPhUyHE5YsJ4olE9CWho31jJ
         mLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mhXIarFJGq4Y7o1OACEMY+CWjpNuyCrBkx0AvhbST58=;
        b=LT9cTv1Lv2wREmOI4hn3Cytxlpbgc21P+mytjAHdF+L7aZNsEZAxyTmL5u8md744U1
         mPDIpdPI60ZJt2i/2WBnXJmuZsJ3GkP6LB/t1Tn8QcD5r4XaduoZC5EW0XbYht9cc1Gw
         HS7lTd4TO+csvLk8V3lq3EfGgwcujHuhH+3K/+yGnu2keLlyqwgpJ+Os0oTVxV8n3agO
         NE4dTdKG/cvU2H9NssvfOerq0JUjihZa2CAYDHv6+v2WMhH6VHOhRt/OBKKsxljmmdP0
         ONJ9ncWTncI/UExHlZX5KMnUpdjdMcqn/ZQ1Zg0UTlhuFwMAtdB1/kYxSQrAZEI2Qfqd
         ZaNg==
X-Gm-Message-State: AGi0PubmhyKr+5egv8xF24bTTm4E/Ka7CmZTlpkuZlzqS3DOpFWJSgN1
        5x/n/+29THwrOaVEYjPH2YQCG9vH/wQx1oakiaDalA==
X-Google-Smtp-Source: APiQypJIMsGtzThZyW1lqSg5Tc9VmY8HlcF1qXM8u4OPF55cPNjhQjFyV5VLPhxjjL+KT0ArViJcIzRkt1OOy/WCwhY=
X-Received: by 2002:a37:5b47:: with SMTP id p68mr15632193qkb.120.1589303568424;
 Tue, 12 May 2020 10:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200430143019.1704-1-brgl@bgdev.pl> <20200430143019.1704-3-brgl@bgdev.pl>
 <6568919d6cc3ee8f602a58354e3aff44@kernel.org>
In-Reply-To: <6568919d6cc3ee8f602a58354e3aff44@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 May 2020 19:12:37 +0200
Message-ID: <CAMpxmJV+uO0bUa5cEqXnJT97zD8dqwuL9E5ij4Cu0o_fqWiPfg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] irq/irq_sim: simplify the API
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

wt., 12 maj 2020 o 17:37 Marc Zyngier <maz@kernel.org> napisa=C5=82(a):
>
> > - */
> > -int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
> > -{
> > -     return sim->irqs[offset].irqnum;
> > +     irq_ctx =3D irq_data_get_irq_chip_data(irqd);
> > +
> > +     if (irq_ctx->enabled) {
> > +             set_bit(irqd_to_hwirq(irqd), irq_ctx->work_ctx->pending);
> > +             irq_work_queue(&irq_ctx->work_ctx->work);
> > +     }
> >  }
> > -EXPORT_SYMBOL_GPL(irq_sim_irqnum);
> > +EXPORT_SYMBOL_GPL(irq_sim_fire);
>
> Rather than using an ad-hoc API to queue an interrupt, why don't you
> actually implement the interface that already exists for this at
> the irqchip level (irq_set_irqchip_state, which allows the pending
> state to be set)?
>

Yes, this is great, thanks for bringing this to my attention. I can
drop another function from the API.

Bart
