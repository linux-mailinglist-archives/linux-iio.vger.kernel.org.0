Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC67D1A770A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 11:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437436AbgDNJLJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437407AbgDNJLD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 05:11:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FBCC0A3BD0;
        Tue, 14 Apr 2020 02:11:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so5773123pfl.12;
        Tue, 14 Apr 2020 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32ds5tL0YEBK/fjJ+CT4RkbpJZ2m0HbKxbVRo9m7pVg=;
        b=hrh7iBsMf81wW8o2XOz392GPw9NQQ+0GNz5p1FysFnPSRSMyPwH4RoxYvPfP0ajscY
         xUdofOONEWCkmE4tGN16loAG2e3/82SExQU4WGMsVazrNyhzifvxLgeO3kiOu7HT/QLR
         pThArRqDhqmfY4NqkQzz6krhQs5TY5lnSVFpydOnDdFo3SmOwv75Lp0+m3v1ZYxpnz8z
         kiKHtoB0kLpmVKFgnjp85MqboIeflrwvwGtrQqsgHhfejLRfyKYXDFsT7DAMMFELQDo9
         1YJLo7QlGpi/bRONcHni6cP4lSp5ezYGFRxXEvJ6upEBdNiYeLsVIxQUmYGXaU5bEY5I
         4nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32ds5tL0YEBK/fjJ+CT4RkbpJZ2m0HbKxbVRo9m7pVg=;
        b=Qpj7Mxi5LR6ktNaX/ccRFa0i67e1zEWoFijW2EU+O905jtEng8ex++lpU9nuOQryiI
         lfReq7dJdFlZpRS0oOlVincM6ojYGLID9E9KfwhKuRMwjwqWSdlQ3DYcbx6G5NoO0pWm
         38AJ2PZffufPsvPTvPQ8KtG15EhATATCArb/T4dNo+WrZgu+Ar9lLDk4GT4G2NT+siio
         aDjwQrDZuc7LwTaUFfMwtjwXNMzruTMEAE6EP4vDhHR1h29T/g9WzcIs+/0SjfzBkcSQ
         PRfBr59MBeGfuEbA/26JQix7tpZHRnn3y/Ol5bQAyrffHjuHZ0hBvRguYa+/0Yb3Lg32
         XV2A==
X-Gm-Message-State: AGi0PuYVyk+QaLSITw9jYwEIFFlxx29Oukl4LJxN+AguW9dy54sKuJ4k
        d2V3UFyAUBiY8ZupWM0HAhF7gWB1sl1Y+vpomwM=
X-Google-Smtp-Source: APiQypLZHb9q22KG1TM33678SbhBoclm0DhV+XJRNjOggDfRSvaXtIguQHLzedNRUEV1rBir3XaigO6BiPQArS8wfNI=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr20275328pgb.74.1586855463228;
 Tue, 14 Apr 2020 02:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200408175058.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
 <CAHp75VcuPoVK_+KV+88Di1dUFZ9S8-1nNqo2s8a_n3vgSMoecg@mail.gmail.com> <CAHcu+VZMiFVt9L9kNCTtsmxUP-7tO+pBpCOtMHQPotuye_2w1A@mail.gmail.com>
In-Reply-To: <CAHcu+VZMiFVt9L9kNCTtsmxUP-7tO+pBpCOtMHQPotuye_2w1A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Apr 2020 12:10:56 +0300
Message-ID: <CAHp75VemvD0mvDHWorSFhqOKaQ1Y_vLYVAQmnb8iz30AH431+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2 v8] iio: Add SEMTECH SX9310/9311 sensor driver
To:     Daniel Campello <campello@google.com>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 1:56 AM Daniel Campello <campello@google.com> wrote:
> On Fri, Apr 10, 2020 at 4:52 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Apr 9, 2020 at 2:54 AM Daniel Campello <campello@chromium.org> wrote:

As far I understand you agreed on the rest.
Correct?

...

> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > Signed-off-by: Enrico Granata <egranata@chromium.org>
> >
> > This is not understandable. Are they who helped you develop the code
> > (we have a special tag, i.e. Co-developed-by in addition to SoB), or
> > just people in the middle? Then the question is, how come author is
> > you and not Gwendal?
> >
> This patch was initially developed by Gwendal and Enrico (here:
> crrev.com/c/1089826).

So, tags should include
 SoB: Gwendal ...
 Co-developed-by: Enrico ...
 SoB: Enrico ...
 Co-developed-by: yours (if you developed it)
 SoB: yours

and on top git commit --amend --author="Gwendal  ..."

...

> > > +#define SX9310_REG_IRQ_MSK                             0x03
> >
> > Is MSK abbreviation in datasheet? Please spell it how it's in datasheet.
> Yes, they indead use MSK.

Okay!


-- 
With Best Regards,
Andy Shevchenko
