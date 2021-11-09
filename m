Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01D44B3CD
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 21:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbhKIUQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 15:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbhKIUQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 15:16:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BDEC061764;
        Tue,  9 Nov 2021 12:13:35 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u11so393309lfs.1;
        Tue, 09 Nov 2021 12:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCo3ZYUvPoVt8JEt2PZSTfPPj0pbEwYv3HN7zMRymXc=;
        b=BqBGLTasdswHd62KYITnkW/OPOhaZhLVuHB8URFEnwRcmXpc4SPcsyXK/7Xl1slOxd
         wylCk0xqWGz6F62FMQdZrvmEIj4qUev4wIl3s8nHgb8k/BMOJu+v7x17NKvrNrlfMvVG
         MMg99tdOOpaA5gCO2Sfc44dNMHPICLoIJOmtYk+sb1jnLo7oY0KrbMBD3m3BRIfoyShS
         VRhZHVUAFChtLYGDSCTu3T9+l6trFb+2EWNWjB8MSdyt9u7YakCvxaLyHdrVcqAwjeKi
         rWfh6Ir3/mijSHUlwlbd1GSEY+qMs1AOUe7CSm8tRtpYiTa398VWkxQXMvCG+iOsgrDF
         jLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCo3ZYUvPoVt8JEt2PZSTfPPj0pbEwYv3HN7zMRymXc=;
        b=RNGh2KFEzvxLu+zOUtcJsN8ueE+vDLuJCdrwT8uFcpQIVQrNoWXXOvj5htUF8NzVbM
         7TbkvjE2k/bGPKuJFeCISM3n5bQS7yDKENHKSoWSu8xveLgNmwxAiQN87OPgHrindGQK
         y2n8P+G3sg9m3MkqFym2DIJDpa8G2qvbKK8C2iEr5DZ+CXi0xzZ8QOOQ5HaS3rniyhRW
         RwBCcdUFMWI4932llZDQ2wCfrBAw4HhmDTcgj2I4GEq2mpyILOiRaGz9vSgTf8TVDe5v
         nie7vLc0D8gM6IzD0xJu4w/wFsXQE/D53p5KyzW/XQtP1MWpEK6EmenxS/f+FYhz1l3S
         21eQ==
X-Gm-Message-State: AOAM531uedVpt12UfmieACjXYrX2VJ1In87kW4xCKxm7j480KtfbTmhX
        qwckBaDBRvGI41QMt2iHb/QeN6iZdnX7ecQi1CE=
X-Google-Smtp-Source: ABdhPJxDaWDpWZ4XopS52A9UNiYz4wGGfgQugqHQm93wbhcpSbDYqHLF3yEUBRj9V8FWYySt8+ndKf9X9M2cdKTXHhg=
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr9712546lfg.498.1636488814040;
 Tue, 09 Nov 2021 12:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20211106173909.34255-1-puranjay12@gmail.com> <YYeOVJjiz6huHv4y@kroah.com>
 <CANk7y0jsy9m3YLdSgjsoP-w_NcS-QZx3UTd+jnMHdRrhQ8zgeQ@mail.gmail.com> <YYrP1RS5Uyf0MzD7@kroah.com>
In-Reply-To: <YYrP1RS5Uyf0MzD7@kroah.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 10 Nov 2021 01:43:22 +0530
Message-ID: <CANk7y0gNiqiR+4cLHq39y5qNNX6Lb2e=urpq-4a3FfrZ2nnewg@mail.gmail.com>
Subject: Re: [PATCH 0/1] device property: Adding fwnode_irq_get_by_name()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 10, 2021 at 1:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 10, 2021 at 01:00:26AM +0530, Puranjay Mohan wrote:
> > On Sun, Nov 7, 2021 at 1:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Nov 06, 2021 at 11:09:08PM +0530, Puranjay Mohan wrote:
> > > > While working on an IIO driver I was told to use of_irq_get_byname() as
> > > > the generic version is not available in property.c.
> > > > I wish to work on this and have written a function that may work.
> > > > I am not sure about its correctness so I am posting this patch early for
> > > > review.
> > >
> >
> > Hi Greg,
> >
> > > Please test your code, and also provide a user for it.  We can not take
> > > new functions that no one uses as that usually means they do not work.
> >
> > Actually, I just wanted to get a review of this code before I test it.
>
> No, please test your code first, before asking others to review it.
>

Sorry for this inconvenience.
Actually, I have never worked on this part of the kernel before so I
was not sure if I was doing the right thing.
Now, I have tested it and sent a new version.

P.S - I won't send untested code again.

> Do you want to spend your time reviewing code that the creator has not
> even tested themselves?
>
> thanks,
>
> greg k-h

Thanks,
Puranjay Mohan
