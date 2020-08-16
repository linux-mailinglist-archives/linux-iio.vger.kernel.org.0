Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A12459D7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 00:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHPWTj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHPWTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 18:19:37 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FCC061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 15:19:37 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p18so9101015ilm.7
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkcZzuMa0KWX54HQ/i8rwQk69v0uhXTqDlHr6CvRGf0=;
        b=oLoM24c9W9QDfQEka2Py1zyaf4vtAeCE3QWy7IyEXp3VfZte+2RzrAIcXnc/Nft6gO
         s96HwoD3W5h64atKhTUzx7hpVlDArLHuiI4svL79mBWpM+3b5Gue/1x4hmhvMu/2a7Hg
         y3FqV2Hu3t1YQmdQRlpHIXiVWPBK8prlJ4XYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkcZzuMa0KWX54HQ/i8rwQk69v0uhXTqDlHr6CvRGf0=;
        b=qcyMlAf1m51sWswg/KylE/6z3d6e2MUybOM1+sGZJ0JqoGz1wS9mMZd7NQY/wzrmSN
         cfAxkMeXxlUwq6oY4vMJxG01zQ3WiJFNN16YKI8EYOaoTaoU/P6rOj6Cl1JciLgTmvFT
         mBVtHcru2wF9yGJtRFP9Wnr1UA3oJstPGBrwD11lSWOU6f4EUSFFAjIJZzIu7NkBHdw1
         7xQgCnjpgzBJ/qsWIfPI9YqEsgT7RZ4AHSY7jbuj1t+NBX368UDn1kxnnMWpkMaTppQl
         OAyYy2EcjQIK7KRr0+UGb4OseQPcF3uBaz3dszl8VnTd1VdhIidgzQzLdqpInLZD8Jas
         SKbA==
X-Gm-Message-State: AOAM531DDXOlYq9EZI7L1zFLv2UEiu+m924oTLnMJ+rXlZZXYYaZrQVx
        bbSrRJDhSCluszX33DpXmteXkc3m+5Fqoxny7di2eA==
X-Google-Smtp-Source: ABdhPJySERcXu7AlxAUAMVgLDOch9W2eq584oKVC2lPlxK3oODrvqWnqNer+pnocJ0TnvtP9X2c1lomIajxcwzFU8/o=
X-Received: by 2002:a92:4989:: with SMTP id k9mr11882013ilg.177.1597616376543;
 Sun, 16 Aug 2020 15:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200814134941.10576-1-matt.ranostay@konsulko.com> <CAHp75VeP24wrWk49Gic-fR72kU+1sBQD-OCW88ji1ZYShSsNXQ@mail.gmail.com>
In-Reply-To: <CAHp75VeP24wrWk49Gic-fR72kU+1sBQD-OCW88ji1ZYShSsNXQ@mail.gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 16 Aug 2020 15:19:25 -0700
Message-ID: <CAJCx=gkDBUZ+ozJAsi43ff_frRGTZXdE1PEbtpyYjcFUubvi8g@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30102: update author's email
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 16, 2020 at 2:52 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Aug 16, 2020 at 1:06 AM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> >
> > Update email to author's current employer
>
> > - * Copyright (C) 2017 Matt Ranostay <matt@ranostay.consulting>
> > + * Copyright (C) 2017 Matt Ranostay <matt.ranostay@konsulko.com>
>
> > -MODULE_AUTHOR("Matt Ranostay <matt@ranostay.consulting>");
> > +MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
>
> This is actually an interesting question, had you been working already
> for your current employer?

Yes I was, but this was for my independent contracting company (that
has been dissolved, and the email clearly won't work anymore)
for a presentation on iio.

Pretty sure Konsulko doesn't have any issue with copyright assignment
to them :).
Also retroactive assignments are quite legal (under US law at least,
also IANAL) as long you of course own the copyright.

Good questions though!

- Matt

> If no, I don't think this is a proper change in the code (of course it
> might require your new contract, then it's probably fine, I dunno). It
> would be a good change for MAINTAINERS, though.
> If yes, the commit message doesn't clarify this.
>
> In any case, just my 2 cents for the future changes like this, since
> the patch already applied.
>
> --
> With Best Regards,
> Andy Shevchenko
