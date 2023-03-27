Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E416C9ED4
	for <lists+linux-iio@lfdr.de>; Mon, 27 Mar 2023 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjC0JER (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Mar 2023 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjC0JDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2023 05:03:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7CA3A8E
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 02:01:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so11124841pjb.4
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20210112.gappssmtp.com; s=20210112; t=1679907711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqsTkBs6N6moVAGndgySpKN2a5Zh6cCjYlIjBQjIbQk=;
        b=OAspQ+mNtEjnF5DPf+PUklx9ud9YCxl5EO9S3cilH85NbyMHB2szIRjaHvleaGgTiL
         BxFr0jHL0xvnFXZSr9nMK7wjvlTyCa1TEs01Bt+fHyk+YXzYWTCD+QRnaPLwV9hRuy2j
         XoURpLFbhnVuC9/u5QOHyJdz/IjunP/+wBFN55W6ds76BKzf87FK1WJFMeJ7W4wsvvKh
         NGRVDHwf7IJvTArPUppleuFN+nJMZDPwcoyTkXiita73AkMlHzEEGY+P1b+Jx2YeGDKt
         zmWhuwjBAPp2JJBEjloySXmnSKPIaBmIY4SzFRiViwp1dTGEu4255OGZyfZkAKnO54jl
         zwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqsTkBs6N6moVAGndgySpKN2a5Zh6cCjYlIjBQjIbQk=;
        b=sbkGu+6qNd2b68AShc00whYRBiPASszGswGPcd4CpzSgc85nhRaaa05EArpv4Z7Wm4
         wvhnLurW6/U8M3Zc9KRq80iS7a853LtBE31tS5ORQXwmEFZNDwbzWbE93ivIJZoUqHPf
         7LSECeV30+iSEfqJYpvtW+8MkQxE8Bdsmd8hzzwk72iHleO2R2A7DayTgSdGP97XIVEO
         NA1wIbRsEaRhVhhTX8Srlp86F7y85or+/auM+Xn1kH+BNmodCKvTkz/NKmI67DjGErez
         QT6HBdDLIzC/nEYu0d53YJuUHFYV8k6isD7PL5odR0ljEt3in6cBq02Dp3Rf9aYAmBVC
         zZmA==
X-Gm-Message-State: AAQBX9cqPeaPROyuAfwegM2fxIXmtc/m9MhiXhXvm/uCEG580v+HipXE
        +pxQ+9emepCF7QZzqHCM9/JurcXdEBOeGDGnUMo2HQ==
X-Google-Smtp-Source: AKy350b3PrgzVh7g0IGsxImabv1+jPWAgKuzUjuvlvhyjri3TLAf0eGYOM19z3ngLKMVIHgy/1vmUEksSPGp2ltCKmE=
X-Received: by 2002:a17:902:8f8c:b0:1a2:1ec5:e11f with SMTP id
 z12-20020a1709028f8c00b001a21ec5e11fmr3305343plo.6.1679907711300; Mon, 27 Mar
 2023 02:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230306044737.862-1-honda@mechatrax.com> <6e1fe1015235ae7d7eb9ef2526fd64b6d6d628d7.camel@gmail.com>
 <CA+Tz-SHQxNzx=eS8ex=3Hps0th5bTY+K1qSWrZqWC8ryv+d0RA@mail.gmail.com>
In-Reply-To: <CA+Tz-SHQxNzx=eS8ex=3Hps0th5bTY+K1qSWrZqWC8ryv+d0RA@mail.gmail.com>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Mon, 27 Mar 2023 18:01:14 +0900
Message-ID: <CA+Tz-SFbt2RAz3POMRoTHqz+tNyQOn3UsssZV9EvHUhhR+XJbQ@mail.gmail.com>
Subject: Re: [PATCH] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, Nuno

> On Mon, Mar 6, 2023 at 10:30=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> > Another thing that came to my mind is if the data is totally
> > garbage/wrong or is it just some outstanding sample?

I'm sorry for not answering your question. The data is the same as
the previous conversion even if the input voltage is changed. At this
time, a logic analyzer shows that the read operation is performed
immediately after the conversion is performed. The read operation
returns the previous conversion result because it is performed before
the completion of the conversion.

> > Some research on this also seems to point that we should (need?) call
> > irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.

I have understood that I need to call irq_clear_status_flags. However,
I cannot find a code to free the IRQ in ad_sigma_delta.c and other
Sigma-Delta ADC driver source files. So, I would like to implement
only irq_set_status_flags.
