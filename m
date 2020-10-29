Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09EE29F2BB
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 18:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgJ2RN0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJ2RN0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 13:13:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5AC0613CF
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2020 10:13:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k9so1185142pgt.9
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2020 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOUbSnlYrOQJwFuXEs1j6t7kdKmqQ1Ms2u6lKTtMx+g=;
        b=qQItJycL0VT26GHzEvZaZaQXq0W4GvUaPWS0xmY8MH6RxW0VOta004yxLVMlSL4n3r
         gPZ+9v5M5Lr1WE6XQ1PwumBZpFOl9k7A0kSzPY/8sxwsexok9Mr8FMMi/NhEt0H5LrsB
         rkGoHllk7EmxiamNA2eOG5SXRqhSt/7rlAeWJcNLSkBaM11eyR47obzC5l8ZDVYWCE7E
         fD8KQUThRZNMMcSa+KkOSv/SUw1BwMbiOGZCXqthv5vuqJeOjhZRXi5Qs5f57mza1CUN
         f5X7/jJoRxdvUOehkUjTEilasHMn/bax4xiy53hZYvLwvgtm3sKHWCi5n8p21Q2yLLxq
         tdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOUbSnlYrOQJwFuXEs1j6t7kdKmqQ1Ms2u6lKTtMx+g=;
        b=pU3d9snku6xsvBm3Z2hTdTUStz8a2kFyrgQvfPtew3Ku5cGQSY3uVvx0ECuPYVVtSE
         aGF7KdKpXOiaVLlloQ278vzY3jhyJmi+hh2jF+YZ+bB2X5WNbHl4jzVfdWpg5ll1yzpK
         vKojE1S6IQRvieNsZudm3NmT4UF8d+RBgxE6pii7cqGAwEdQPDrxdPC4aLCdPyoc8U7s
         eKouxwJjc12BjvwkP69xK5yUrU1v9udcn823Mj1WXtr5Y8T0pf95GWsnxM/Veq4TN+XD
         SXjyrsshn0cI4twGF0hW6RODIooFYFdgj7vap0YQYVMg/q7PcE1ADOeEGEFCYBx2mQ86
         ixlw==
X-Gm-Message-State: AOAM531q5ItXgrh54Hct6LqoQ6Xi/rNDYiCyhk6CDR5csZRCDGR8YCw1
        9e9oVYWf2moFR97x+yZOGtI7KxSTY98QtoGsV/g=
X-Google-Smtp-Source: ABdhPJxa6rtzn0kG0KwDxPubGqvH8nvO9U0cWEjozPafCTrlJWxoEDJ6bwt2qsRrveULEI71TucfU8vjkp1M1Khp/IQ=
X-Received: by 2002:a63:d54e:: with SMTP id v14mr4981667pgi.203.1603991606153;
 Thu, 29 Oct 2020 10:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201026180515.19680-1-andriy.shevchenko@linux.intel.com> <20201029152545.18eecc9a@archlinux>
In-Reply-To: <20201029152545.18eecc9a@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:13:10 +0200
Message-ID: <CAHp75Vc3xDQZdcRLSFY4zn24bf0eak_pCax5wVgR+ATC3VAOwg@mail.gmail.com>
Subject: Re: [PATCH v1] iio: pressure: dps310: Use get_unaligned_beXX()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 5:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 26 Oct 2020 20:05:15 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > This makes the driver code slightly easier to read.
> >
> > Cc: Eddie James <eajames@linux.ibm.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Hi Andy,
>
> I am a bit in 2 minds about this one.
>
> I'm not 100% sure on the register arrangement here, but it 'looks' like
> a be64 followed by some smaller registers.
> It isn't documented like that in the datasheet though, so representing
> it as such might confuse people...
>
> So, we 'could' use a structure with a __be64 and some __be16s then all
> would be aligned, but it would be hard to align with the datasheet.
>
> Unfortunately what you have here is also rather hard to align with
> the datasheet...

Thanks for the review. I just got it right now that the proper one
(and for previous similar patch) should be converting to the bitmap
API.
Because it seems to me that there are fields from a bigger bitmap
area. However, I might be mistaken.

I will drop this from my local branch.

-- 
With Best Regards,
Andy Shevchenko
