Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954C313AB7
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfEDOmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 May 2019 10:42:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38028 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDOmV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 May 2019 10:42:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id t70so6583766oif.5;
        Sat, 04 May 2019 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9bJ5mQH0bFiSdzMFFB9aG/I/ocJ8zclWjNdxs2Hvmc=;
        b=F9pvV3Iw0ijwtXW8NVwe7iDvNNXcDLXlSYMftcFbSh3TXFVxECvo0hYJOPGNx7/eIV
         Mnz6OTzHh/I+2tS1nQd9nLT2+ah8qGnw15m3JeCCuLX09gU20NwjZS1zw/Ac+h4lX7Gt
         v5kvfKBC66bIxucRd953nF+f415VzOefkU6MM9CMItaC5QWHUvPtavkoeyMsdybKOd4N
         PqFCzs8yAeXgWd0ldp+H/wlaqEhe4Rp1SE2FGce7oAUVvLu34C6WtYs/+9PL+uJY53za
         g6hWBFiF/QHuvB90NqPEz3C51cOxd9KsL//TrCgQIxQ9h5u7ifEcEQNTGGpp4IaRRQrv
         hWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9bJ5mQH0bFiSdzMFFB9aG/I/ocJ8zclWjNdxs2Hvmc=;
        b=Uj16ZYWzlqL1QXGVx/Z9y0MBLzdfTPTQ4lZXagV47jMShlRCU5fc8la17VjeNzBr78
         B36UXToOxW/F/CtxrbsCF05kWO/OQviCKLOqE/ZMimyE3osAiBXQQtm4Xd7xMHv5EnBN
         K2jm7Qw7oGRHopGGJOaQS12/5DfQCREzdiF+WpgU6OP7Z5sf/l2KxjlMXXhJa80wKPG2
         wetWr8s+g+WFbl7BkpUlFWG4vfyu5I/GpVmHyS9Pn3LSzPA+4UKlQgpVoCffkWuhAXAE
         Qnhwq6lep6zQe+3DkyT3cncWOVDoOY9EZipC4dTRCQ8+LoOGIzKbtlbszJicguLj6m9M
         CltQ==
X-Gm-Message-State: APjAAAU8vfEK2wzPQND2Qx/cCxuQyLhUBWV+p6baR4BZmijWTGfav3pM
        m/J3qKFTMY5WHdOnPuXIV7yI6UYFUwY/4lHEwuw=
X-Google-Smtp-Source: APXvYqzEVEdH+1TEvoSvfgHfEz8LzW/K9QdEdDzS4k7lw+vdiS+OmGvkxrRdA1vw3qZWSKfHjIOhFLNkCCwoNRDDcww=
X-Received: by 2002:aca:5bd7:: with SMTP id p206mr2766026oib.128.1556980940695;
 Sat, 04 May 2019 07:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556919363.git.melissa.srw@gmail.com> <CA+U=DsqiRBAdGK0aqp5Chv-AtuL8W47tu+Bq6O_Pc97HYbewkQ@mail.gmail.com>
In-Reply-To: <CA+U=DsqiRBAdGK0aqp5Chv-AtuL8W47tu+Bq6O_Pc97HYbewkQ@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 4 May 2019 17:42:06 +0300
Message-ID: <CA+U=DspNV8JAbSesYZVV0czUL5=1fY1BWwbGFVum4a0aDp33Ng@mail.gmail.com>
Subject: Re: [PATCH 0/4] staging: iio: ad7150: improve driver readability
To:     Melissa Wen <melissa.srw@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 4, 2019 at 2:12 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Sat, May 4, 2019 at 1:24 AM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > This patchset solves readability issues in AD7150 code, such as clarify
> > register and mask definition, fashion improvement of mask uses, reduce
> > tedious operation and useless comments.
> >
>
> Hey,
>
> Two patches seem a bit noisy/un-needed.
> The other 2 are fine from me.
>
> This driver does need some work to move it out of staging.
> I am not sure what would be a big blocker for it, other than maybe it
> needs a device-tree binding doc (in YAML format).
> Maybe Jonathan remembers.
>
> Some other low-hanging-fruit ideas would be:
> 1) remove the code for platform_data ; that one seems forgotten from
> some other time; the interrupts should be coming from device-tree,
> from the i2c bindings
> 2) you could do a AD7150_EVENT_SPEC() macro (similar to
> AD7150_TIMEOUT() macro) and use it in the ad7150_events[] list; that
> would reduce a few lines
> 3) similar to 2), you could do a AD7150_CHANNEL(x) macro ;
> 4) in ad7150_event_handler() the checks could be wrapped into a macro,
> or maybe some function ; i am referring to "(int_status &
> AD7150_STATUS_OUT1) && (chip->old_state & AD7150_STATUS_OUT1)" checks
> ; those seem to be repeated
> 5) add of_match_table to the driver
>
> I (now) suspect that the reason this driver is still in staging is this comment:
> /* Timeouts not currently handled by core */
>
> I wonder if things changed since then ?
> If not, it would be interesting to implement it in core.
>

I forgot to mention the wiki page for the driver:
https://wiki.analog.com/resources/tools-software/linux-drivers/iio-cdc/ad7150

it may help with a few things

> Thanks
> Alex
>
>
> > Melissa Wen (4):
> >   staging: iio: ad7150: organize registers definition
> >   staging: iio: ad7150: use FIELD_GET and GENMASK
> >   staging: iio: ad7150: simplify i2c SMBus return treatment
> >   staging: iio: ad7150: clean up of comments
> >
> >  drivers/staging/iio/cdc/ad7150.c | 102 ++++++++++++++-----------------
> >  1 file changed, 47 insertions(+), 55 deletions(-)
> >
> > --
> > 2.20.1
> >
