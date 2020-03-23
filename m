Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD118F1C7
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 10:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgCWJ3B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 05:29:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35703 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgCWJ3B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 05:29:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id g6so5697907plt.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2020 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvQdrkALIpb+y1ay+V651nvSKxtPfqLFiYqaf6nk46c=;
        b=srXbLNZ8AvrMjothxo1oIZLjqKAUX/fmrnQTOkMlHcBp73rQ62ru1Aje8EMZNqjJdx
         0ARSvzrtSvRbkTFa0mWLVO1Zn3uitN+mW5ClKifafBXhQLg2c4sER6dYRCBBYpeujXEy
         0Z1DpzGxpFNENkEearZvsV44AtG2qNsLVDiqpWOZjjUwZnn7XxINzz8R+ccYvhDhggRg
         1b9pLhGOmc9Rpld8BjnDR8MSGFSjRm9VFYaQsN2ZBfGOuJAGVSsCx+GlnQi+bw7XM5zE
         p0m57ndQIOh2pzNrCLDtw+3BL4dePVFi3Fh5+1JLZ8fEYjbP/xhrckr8y0dr3u8oubl1
         xy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvQdrkALIpb+y1ay+V651nvSKxtPfqLFiYqaf6nk46c=;
        b=kTXDu3kk6FQzk1gPKxJXRXz+2C+p8wqC+YzymW/AhJ6m170eRzgbYuEFGEpEg9mgDT
         8PVLpiOyYkoC8jg/ncEvSB3R2lwa99LQIyhLJg8q8nkAZXbyE2u6CTxdYXcg2W4lZqR8
         md6iw5gtS+2zu+mA3LaMh9VW20njauyU4/c+p2PoGDWwSEP4y6V1agI7v2CrlTLA9g+J
         vkycDJ8qXb9vMvEWP6ns1YfI+M1EMDu7iW3GCfIImtZOCASzVoKAscLNfZ5Vo4tqb5/C
         s46xZWYpyHlkrHkvBVBD4IC0syUYw4+vamq/Y5vnQSP73W0DL480PfYDOzs+UWSsdNx4
         yICQ==
X-Gm-Message-State: ANhLgQ3RNU9DkyX2g3fJcd/zLJi6bQMfqVTQPNyE2o9DVukLIv6p/LMM
        q7Qk+0n9IBijuHqmEnO6jB59tDQQ/vk3VA0zVRU=
X-Google-Smtp-Source: ADFU+vthWOv+nz0MlcdPxRYNI7Xb893Hrysk0W5KFXyWImj/sDiBFVUlgqOxK697IUVAIsDbr642p/HJTnRQlDSQJVo=
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr21455712plo.18.1584955739687;
 Mon, 23 Mar 2020 02:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584904896.git.mh12gx2825@gmail.com> <dad3cdb5de76234cc460300c31aea6af671f81ad.1584904896.git.mh12gx2825@gmail.com>
 <CAHp75VfC=y1mHW5=ghwdMMZYg=00_a5RB0Phz4j_vM77pehvMA@mail.gmail.com> <20200323014935.48048405@elisabeth>
In-Reply-To: <20200323014935.48048405@elisabeth>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 11:28:52 +0200
Message-ID: <CAHp75VfF+oDWsOF+_=U6YBeP60XLF=SLYzExa=5WjLSgoMUw9A@mail.gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v3 3/4] staging: iio: adc: ad7192:
 get_filter_freq code optimization
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 2:49 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> On Mon, 23 Mar 2020 01:44:20 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Mar 22, 2020 at 9:57 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> > >
> > > Current implementation of the function ad7192_get_available_filter_freq
> > > repeats calculation of output data rate a few times. We can simplify
> > > these steps by refactoring out the calculation of fADC. This would also
> > > addresses the checkpatch warning of line exceeding 80 character.
> >
> > I'm not sure you did an equivalent changes. I believe in the original
> > code precision is better. Consider low clock frequencies when 10 bit
> > right shift may hide some bits of the division.
>
> Note that those bits are eventually "hidden" in the same way later,

Even if mathematically (arithmetically) evaluation is correct, we have
to remember that computers are bad with floating point and especially
kernel, which uses integer arithmetic. That said, it's easy to get
off-by-one error (due to precision lost) if we do big division before
(not so big) multiplication.

> despite the different sequence, due to DIV_ROUND_CLOSEST() being used
> at every step (both before and after the change) without other
> operations occurring.

By the way, where AD7192_SINC3_FILTER and AD7192_SINC4_FILTER
multiplications disappear and why?

-- 
With Best Regards,
Andy Shevchenko
