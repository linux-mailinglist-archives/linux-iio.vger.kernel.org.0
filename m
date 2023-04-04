Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3EF6D5954
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 09:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjDDHUj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 03:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDDHUi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 03:20:38 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A4E72
        for <linux-iio@vger.kernel.org>; Tue,  4 Apr 2023 00:20:37 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso33482475fac.12
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2023 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680592836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0VUHBlqdfVu2APoDOaPHripqBY7Z/blJKHMOnZGIuI=;
        b=cX80WDGj5kLvu1komErhN8XENq/ivIFhmKSqKkxKzkW9Bv6tYhGB0z/58FbN7RFdoF
         xYjMddylDkTdOJ/hEi+8QmEjdsQFAaQuW2WafQBa7rvE+r0N++ol3GxVjObpFcoFOVe7
         XISUycdz69UuEFwCerJdSsemgXxPUYRTwg5hW3x0sb8RaifLio6AzIV4AhgyJ8BpFCO4
         t7yLhTZFEyVcpSH/WPO+bb2Goi4UI1GEQN3a1pjHWxwuNYv164PoQhVCUHsC7k/tdxP1
         QbO4xWwUQQDDR9Ef6JDXYwucMMyc1sCOPpyMCk1XGOcpuL32D4ULhU/pxKHyWSkEVq/x
         mbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680592836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0VUHBlqdfVu2APoDOaPHripqBY7Z/blJKHMOnZGIuI=;
        b=2/qDEJrPyY/hB88xcmzu8RSQkMi/so1qgz6noXGKpickbBVeVPtUnn9DfgfkClKIUz
         WAjDZQCu8iVI9T4znMI+cCVnZkrPhlELkZt3v47mczse0c5t6ffE3oq9Oah4bcOEeEBc
         pEoBNwTrBVvV/FYleRZXu7Hsm0xZwKMGDAIeX/mdk4/l16xgMTej43ua0S2UILZF3Ojz
         e3J8xO87UcOOamsCFyhVqwhoiKy6Ja+4fw5QEGkjJ/C0SuuRuLZDSgnIyfxX48MX5+ea
         blVDYYtimoeqwGeC8pv4GfEw0f0AKOfo5ov33cy3wJCwT/FaL4TMD2yU2tQZQ8qrqg25
         rmCQ==
X-Gm-Message-State: AAQBX9dd9wEJ1e6afoAzjPWuYTfmS8YD2Toc1QSADLStTWnJSTLeSqG0
        /OiP+KV1eoVJOgb9cehNeR844wi0tN+Wbvf5t+4=
X-Google-Smtp-Source: AKy350ZUD2wPE1qtv9RQ05JVPX/xUwkw3SU6wOkEsOcbebTHav0GSvCQcbQUzJJGCMzN6PHzxJtRYlLicIM4dKIevJc=
X-Received: by 2002:a05:6870:b38a:b0:17a:dcce:86bf with SMTP id
 w10-20020a056870b38a00b0017adcce86bfmr882997oap.8.1680592835884; Tue, 04 Apr
 2023 00:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
 <4ef51234de8e496791bcb7cd190a7ccf31626c1e.camel@gmail.com>
 <CAPJMGm7qQ-TgnG9ocXDDQX+Fhc9ridHyS1Ztxuq9mX+Q+DL=sA@mail.gmail.com>
 <11450376865596c3c1ef6cf54a71fc63924e7d90.camel@gmail.com> <20230401153702.17cb95dd@jic23-huawei>
In-Reply-To: <20230401153702.17cb95dd@jic23-huawei>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Tue, 4 Apr 2023 09:20:24 +0200
Message-ID: <CAPJMGm6JNBwU46_uxtn0t+WWUcEFiPXrgmfhSO2YiwGYrkAvow@mail.gmail.com>
Subject: Re: [PATCH 2/2] ad7192 driver: fixed unexpected internal clock
 fallback when no mclk clock is defined.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 1, 2023 at 4:21=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 30 Mar 2023 09:53:29 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> > On Wed, 2023-03-29 at 23:23 +0200, Fabrizio Lamarque wrote:
> > > On Wed, Mar 29, 2023 at 5:15=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gma=
il.com>
> > > wrote:
> > > >
> > > > On Mon, 2023-03-27 at 22:21 +0200, Fabrizio Lamarque wrote:
> > > > > Allow the use of external clock when mclk clock is defined.
> > > > > When defining a mclk clock source in device tree with adi,clock-
> > > > > xtal
> > > > > property, the external crystal oscillator is not turned on.
> > > > > Without the change, the driver always uses the internal clock
> > > > > even
> > > > > when mclk clock is defined.
> > > > >
> > > > > Current implementation seems to contain a typo, since it expected
> > > > > st->mclk to be NULL within ad7192_of_clock_select() in order to
> > > > > select
> > > > > the external clock, but, if null, external clock cannot loaded
> > > > > correctly (out of bounds due to invalid mclk) in ad7192_probe().
> > > > >
> > > > > I believe this patch follows the author's intended behavior.
> > > > >  After applying this patch, the external oscillator is started as
> > > > > expected.
> > > > >
> > > >
> > > > Yes, looks like a valid fix... Just missing a Fixes tag.
> > >
> > > Thank you for having this patch reviewed.
> > > Here is a backwards compatibility note I believe you should be aware
> > > of.
> > >
> > > Without this patch, the DT node shall contain (any) clock property
> > > for the driver to be loaded properly.
> > > The clock frequency is ignored, as it is ignored adi,clock-xtal
> > > property.
> > > In case clock property is not set, the initialization always fails.
> > > There is no way to use an external clock source.
> > > As you already verified from source code, this was not intentional.
> > >
> > > While the proposed patch should make the DT config load as intended,
> > > there is a possible side effect on existing implementations relying
> > > on
> > > internal clock source only, that would be deactivated when clock
> > > property
> > > is defined in DT.
> >
> > Hmm, I see. I would argue anyone relying on that should have just
> > stepped forward and fix the real issue as you did :). So, maybe there's
> > no one actually relying on this but that's a big __maybe__... Not
> > really sure how to handle this. I'm not sure we want to keep
> > compatibility with something that's clearly wrong but often we need to
> > "live" with past messes.
> >
> > Jonathan I guess your input will be valuable here :)?
>
> Rather odd if they have bindings that say there is a clock but 'rely'
> on the internal clock as opposed to the current bug meaning they aren't
> using the external clock (but everything would work fine if they were).
>
> So I'd expect that we will only see a problem if someone has another
> bug somewhere else that means that clock isn't working correctly.
> At that point they will almost certainly want to fix that bug.

The bug was introduced in June 2021 from c9ec2cb328e3 iio: adc:
ad7192: use devm_clk_get_optional() for mclk, where there is a clearly
mistaken logic inversion.

Link: https://lore.kernel.org/all/20210513120752.90074-10-aardelean@deviqon=
.com/#r

If you agree, I can send a revised patch set (perhaps within a new thread),
with the additional clarifications on clock usage in bindings documentation=
,
and one third patch for undocumented bindings.

There is one last issue we are investigating, we have a work-around but
we have not found the root cause yet. I will post about it later, in
the hope the
patch set would include all the changes needed to have the driver operating
as expected.

Thank you once again for this review.

Fabrizio Lamarque

>
> >
> > > In addition, bindings documentation states clock
> > > property is mandatory.
> > >
> >
> > This looks at least suspicious to me given the fact we have an internal
> > alternative. Clearly looks wrong to me...
>
> Agreed. I don't think it should be mandatory in the binding doc.
>
> Thanks,
>
> Jonathan
>
>
> >
> > - Nuno S=C3=A1
> > >
>
