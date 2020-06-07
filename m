Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CBE1F0A28
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 07:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFGFbH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 01:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFGFbG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 01:31:06 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40EC08C5C3;
        Sat,  6 Jun 2020 22:31:05 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e11so8556970ilr.4;
        Sat, 06 Jun 2020 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6PCjm8DRiPgGJStEEbTtdFI8goCYQBJLWF2XteTTws=;
        b=cBGod17rtVjTBwG3mOAF3XiqwqVPeMvYHWKc3VX6CaaXIOzPwcwllm0EGdw4Kzu8S2
         rA8pxmxuaZq0lGwnC/sS8iWpPSoyJFfOqZkXomRZyye8vIl6rnRFyVK28xQfcjiQhgwk
         f93ez8i3cf0OXURImtrXdjNpERFHwH8yoJ6YC6NzZSkdkB8VTTKrFW5xpHGQR2ZkjPeW
         ezFDJOQpVUBoVT6/Su/qCKKrdUOmxQs88LZYhLzDBnn62qy2BNBUZz/xFheODShk7StA
         l1faLCIalSzVwszCijqZ8rBlBUk9MfgsyNQW5K6/y5H8gptQveCifJas7SgdKgVWUmqt
         FJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6PCjm8DRiPgGJStEEbTtdFI8goCYQBJLWF2XteTTws=;
        b=bhwuWsf1x2pJwlbkAaplwpg1u3KL+wtdtXG+WQhhaKbyVy/FmRHARTm3dOZuQqg8wS
         nfwImPj79IM29zU1xqF+LsWA2Eq17A/EmFFMCiu/67JblK8VMS0zWx4OpKQJgVwiSKZA
         e9kf2Tw40jq7nAnxJ0yFfpi6KVxxbBbPyLdh1E26OrkmcIjQgUc6HBZuakxDJHo+BQ65
         CdNvsxUrJOHo7bK4r1NRCC7svVbpOzRXfgVhqkzifgpIV9CRoZiXqkE8vMLAmNaMVv6Z
         d9RdmR8cUR7zjGtJMXjWSbXtOYby7UxxRBlpNNwF7+nTsqVVMI4Lfw0zYDiYSspeNaZ+
         cS2A==
X-Gm-Message-State: AOAM532pH66mDptxr94+oghz1EHLlE0DRO7nQwVwbZu0qBgUMxJlCrI8
        HNEVAKFKFbtF9LSCGkRipffBPNHMKluIed6tyi0=
X-Google-Smtp-Source: ABdhPJyK6hO+lxMlcpX35oeaYP6iW0oA+D4n3ZFXdZytrYASYYIGduNWcgTYTKOFIMA698FuXou41MvbP9TCWcMufVY=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr16529735ili.40.1591507864347;
 Sat, 06 Jun 2020 22:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200316124929.GA389@syed.domain.name> <20200318020506.GA45571@icarus>
 <20200322175831.74e10aa7@archlinux> <CACG_h5qctM0S2buQHHNnJ_qVY6YY2wYruj9aTKH9RiJ=9_LfoQ@mail.gmail.com>
 <20200404150633.2421decd@archlinux> <CACG_h5o=V_y33krqojmANnqG+Uf7FJmOVmkY-MGZ+zLJR+Q2YQ@mail.gmail.com>
 <20200607040850.GA80713@shinobu>
In-Reply-To: <20200607040850.GA80713@shinobu>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 7 Jun 2020 11:00:53 +0530
Message-ID: <CACG_h5qG7xU0kL1-Hn8q4S338ESAzz4qjN56Z8Bfi9ekYRTTzg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 7, 2020 at 9:39 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Sun, Jun 07, 2020 at 09:28:40AM +0530, Syed Nayyar Waris wrote:
> > On Sat, Apr 4, 2020 at 7:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Mon, 30 Mar 2020 23:54:32 +0530
> > > Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > >
> > > > Hi Jonathan
> > > >
> > > > >Looks good.  I'm not sure right now which tree I'll take this through
> > > > >(depends on whether it looks like we'll get an rc8 and hence I can sneak
> > > > >it in for the coming merge window or not).
> > > > >
> > > > >So poke me if I seem to have forgotten to apply this in a week or so.
> > > >
> > > > Gentle Reminder.
> > > > Thanks !
> > > > Syed Nayyar Waris
> > >
> > > Thanks.  I've applied it to the fixes-togreg branch of iio.git which will go
> > > upstream after the merge window closes.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> >
> > HI Jonathan,
> >
> > I think only the patch [1/3] has been applied. Patches [2/3] and [3/3] have not.
> >
> > The three patches were:
> > https://lore.kernel.org/patchwork/patch/1210135/
> > https://lore.kernel.org/patchwork/patch/1210136/
> > https://lore.kernel.org/patchwork/patch/1210137/
> >
> > The last 2 patches need to be applied, I think.
> >
> > Regards
> > Syed Nayyar Waris
>
> Just a heads-up: the relevant bugs are present in the 5.7 release so it
> would be prudent to tag those two patches with respective Fixes lines.
>
> William Breathitt Gray

Mentioning below, the 'Fixes' tags just for reference:
For patch [2/3]: counter: 104-quad-8: Add lock guards - differential encoder.
Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential
Encoder Cable Status")

For patch [3/3]: counter: 104-quad-8: Add lock guards - filter clock prescaler.
Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock Prescaler")

I have replied on the v5 patches [2/3] and [3/3] with the (above)
'Fixes' tags. I have added the tags in the message.

I think that was what you meant.

Regards
Syed Nayyar Waris
