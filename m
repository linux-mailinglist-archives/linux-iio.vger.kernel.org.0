Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4401F6F3047
	for <lists+linux-iio@lfdr.de>; Mon,  1 May 2023 12:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjEAKq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 May 2023 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAKq2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2023 06:46:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AADE58
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 03:46:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a9253d4551so17314355ad.0
        for <linux-iio@vger.kernel.org>; Mon, 01 May 2023 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1682937985; x=1685529985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VPB4vBgaw0yyj4YmwpyS2q4carTBS6uXeBNTXWkwGA=;
        b=vrkpIp9hObJY89qo8FxxIUh2YC1tpwirFVIqHDqZ+Mz6dm70Bg37eyE8v5XzfYnXtq
         4GfTCZFZHyX9yeWK1x+LlLXgFmCUksor8+oOJjfVHr5UCth2TUfkkYHMjmR3UhS+kPRB
         srIhB/0mra8LiitCaJY3yXXbB3xdUduRH4P2q93ndlJIZh2Y49zR1qP3AiKcWsMXfJEt
         JxCM1ey8Mg8gILejgjOhuEpTFkjV8GkmdFSHjmP2e4uOqagaSds93FUNfnUFDR3hUlRr
         L3udWVzEkirY/q7TfCO3npTpVmwZQn/6Zy2jPmtK5QNkRc4sSiubwDGVBf8TLh/JNw4L
         LYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682937985; x=1685529985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VPB4vBgaw0yyj4YmwpyS2q4carTBS6uXeBNTXWkwGA=;
        b=eKT4C3ssHTxCxM3jn87ISNeDZIPVQ5RHrjQsTQMwJqZWLUUGq1dFSqMgcTVzI9uTSt
         myK+fUJKuQWsyyheM2jA6qBmBVL0UL+OOkx6d24SlpTokxOQNxIRM93yUJN4/Zbmsi75
         Qj+ZuKkZIu3ruqBzEvSP+3hxDDdE/Rpk/mXCZWi4+3rxUDpe/e+kZXsXMbYkOsr57MbX
         f63funsAQAKM97QnO0xvkmWk3lh8u+x9Dh0ECE6dJ5t0jqEFJTHa87FyAmPYJhduT/0C
         o5vML7FrJ3hzwwI9Wo7eQIb6vzCrrFzLFpXfkXvFC34IBCw6uG+75CE6f+Em33G8JP8y
         wv0Q==
X-Gm-Message-State: AC+VfDzIc6oErHxAsYIDh/yAcEbkvo/9cS7DxPbhfq1Rd3NOktdZef2s
        b0FFhaP6GlqJvIjUyRfCB7pjHFIORdkwdYpdwpRzjg==
X-Google-Smtp-Source: ACHHUZ5RuLIFf34p/UdZSQI+fH6hL6awdAsiHF/DW7p3jYcNdnxX/tcH6TKtZFxnFch003+zywuhdd+uTXWFP5NwNLM=
X-Received: by 2002:a17:902:f551:b0:1a5:22a:165c with SMTP id
 h17-20020a170902f55100b001a5022a165cmr14822492plf.0.1682937984619; Mon, 01
 May 2023 03:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230420102316.757-1-honda@mechatrax.com> <20230423121528.259d3cd4@jic23-huawei>
 <b6a96cca17832219042c90baec2442b1a5bad7b7.camel@gmail.com> <20230430184311.7443e1d7@jic23-huawei>
In-Reply-To: <20230430184311.7443e1d7@jic23-huawei>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Mon, 1 May 2023 19:45:46 +0900
Message-ID: <CA+Tz-SHPt_Kcwvmt6Xq0-DgkQC835UWeajjq28-qku+urxRQvA@mail.gmail.com>
Subject: Re: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

On Mon, May 1, 2023 at 2:27=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Mon, 24 Apr 2023 11:09:34 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > On Sun, 2023-04-23 at 12:15 +0100, Jonathan Cameron wrote:
> > > On Thu, 20 Apr 2023 19:23:16 +0900
> > > Masahiro Honda <honda@mechatrax.com> wrote:
> > >
> > > > The Sigma-Delta ADCs supported by this driver can use SDO as an int=
errupt
> > > > line to indicate the completion of a conversion. However, some devi=
ces
> > > > cannot properly detect the completion of a conversion by an interru=
pt.
> > > > This is for the reason mentioned in the following commit.
> > > >
> > > > commit e9849777d0e2 ("genirq: Add flag to force mask in
> > > >                       disable_irq[_nosync]()")
> > > >
> > > > A read operation is performed by an extra interrupt before the comp=
letion
> > > > of a conversion. This patch fixes the issue by setting IRQ_DISABLE_=
UNLAZY
> > > > flag.
> > > >
> > > > Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> > > > ---
> > > > v3:
> > > >  - Remove the Kconfig option.
> > > > v2:
> > > > https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechat=
rax.com/
> > > >  - Rework commit message.
> > > >  - Add a new entry in the Kconfig.
> > > >  - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freein=
g the
> > > > IRQ.
> > > > v1:
> > > > https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechat=
rax.com/
> > > >
> > > >  drivers/iio/adc/ad_sigma_delta.c | 25 ++++++++++++++++++++-----
> > > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > > > b/drivers/iio/adc/ad_sigma_delta.c
> > > > index d8570f620..215ecbedb 100644
> > > > --- a/drivers/iio/adc/ad_sigma_delta.c
> > > > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > > > @@ -565,6 +565,14 @@ int ad_sd_validate_trigger(struct iio_dev *ind=
io_dev,
> > > > struct iio_trigger *trig)
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
> > > >
> > > > +static void ad_sd_free_irq(void *sd)
> > > > +{
> > > > +       struct ad_sigma_delta *sigma_delta =3D sd;
> > > > +
> > > > +       irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_U=
NLAZY);
> > > > +       free_irq(sigma_delta->spi->irq, sigma_delta);
> > > > +}
> > >
> > > Don't fuse the two operations unwinding like this.  Just register a c=
allback
> > > that only
> > > does the irq_clear_status_flags immediately after setting them.  Then=
 leave
> >
> > I was the one to propose fusing them together because I thought that we=
 could
> > have issues by clearing the flag after calling free_irq(). After lookin=
g again
> > at the IRQ code, I can see that it is not up to free_irq() to free the =
allocated
> > irq_descs (that might only happen when unmapping the virq) which means =
we should
> > be fine doing the normal way.
>
> Ah. I'd missed the ordering.  If that had been valid (and I think you are=
 correct
> that it is not required) then a comment to make that clear would be neces=
sary.
>
> Usual case of: When doing something non obvious with ordering, say why.
>
> >
> > That said, looking at the only users that care to clear this flag, it l=
ooks like
> > they do it before calling free_irq(). Hence, I'm not sure if there's an=
ything
> > subtle going on. In fact, looking at this line:
> >
> > https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L190=
9
> >
> > I'm not so sure we actually need to clear the flag as for these devices=
, we
> > should only have one consumer/action per IRQ. Anyways, probably for cor=
rectness
> > we should still explicitly clear it?
>
> Good question...  Looks to me like a driver shouldn't be clearing this fl=
ag
> itself, but it's probably harmless in most cases.
>
> I'd drop the clear of the status flag, perhaps adding a comment that
> the irq core does it for us.
>
> Jonathan
>
>
> >
> > - Nuno S=C3=A1
> >
>

I'll remove the callback and just call irq_set_status_flags() with a commen=
t.

Thanks,

Masahiro
