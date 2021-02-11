Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8631930E
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 20:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBKTZH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 14:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhBKTZB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 14:25:01 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB47C061574
        for <linux-iio@vger.kernel.org>; Thu, 11 Feb 2021 11:24:21 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t11so4593704pgu.8
        for <linux-iio@vger.kernel.org>; Thu, 11 Feb 2021 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n1xfvgXUG9Tu0pQ42zngbG5JP/dIN/VE8WElqLZMLs=;
        b=B7w9ErNyYV1vNP6Z0GlRg2Y99qDFpofJpISdbcJJWdf1GA0Fn3ZK9q1E1rlY+awwri
         WZVSwp0gEu7uBCTxM4MZqs7HYZhZ98deYwb9K3d3++UcAYgHd52K/4sJ2o+xSR/ASfFN
         BRa3mUezxvaOBFY1+8iBGhZ3Chvlm8/QhQ0gg9OUcCrXixsAuGSQEyTW2pLqf5TqiuXz
         xkVyNHMlvWI9JWMhfj7pax1HbCcRSF2+3EfZrvZh5AWfn96bLy/hsgm6YsoIfrig5vOf
         0kSq4Mz5RWecI1GzjS17FW7IWt8gMOjdyJZfNYtG5oY4iRK6VCT23/xRZXRcUt33TMpQ
         YAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n1xfvgXUG9Tu0pQ42zngbG5JP/dIN/VE8WElqLZMLs=;
        b=A9n0YC3A0PQ29/kndUmjb2tlcgiMLpWjo+vJWZIrsMaVna6EpQ3GeH1xd4mJaG32f1
         BDX83efoPFJZxH0NDaNx0NQj1ljqdhAMWyqPDsFCkfGBRVfw+pmFUFeKA+WRqBH/34fa
         tJHwfluHESrGmg5rowrXNQ3IEA+WTCQPHiIAq6DR0Wz/1Y1XeiG7zQGHWGaRGeRwlo1K
         O6W7z6iRmCo3lWpat2PaLOh60z/Kw169d5X2F4Sbdapn4vdNEIab8ZGDXE/zIyKCyJEZ
         qu6dapZ0WIUuExJnawf7O0Y5amQbQ6+mcusg64UjKAL0CwAyRumcOJ5CE1fhGoHbEDqK
         NRAA==
X-Gm-Message-State: AOAM531t4jSaWtQpamo0F9M+DMSrXD0fuO0FKsZyDf2JHvzKwcF5bzr1
        DUVZxRfV1Hb8Fh49cX3ZIQj1lrFY8W92BWYsh5o=
X-Google-Smtp-Source: ABdhPJy7QqfNStCUofm/+nx+rfLVZmpQa9uODyt0rskezNSBF0kxN8797GTL9kysqkQlv3FZ+eSz6fgXPt1ZHKSfcoQ=
X-Received: by 2002:a62:384c:0:b029:1e3:8bca:5701 with SMTP id
 f73-20020a62384c0000b02901e38bca5701mr9026006pfa.7.1613071460809; Thu, 11 Feb
 2021 11:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20210208142705.GA51260@ubuntu> <CAHp75Vc1VWYLO1rF-NNnW3qkgiGycgpTHvr5Q2Yn91aZcFuyJg@mail.gmail.com>
 <CAMwq6HiAufEjLPn2hSnQ7iBvrrCZUzwE_hdFE8s51ewbuJOMYA@mail.gmail.com>
In-Reply-To: <CAMwq6HiAufEjLPn2hSnQ7iBvrrCZUzwE_hdFE8s51ewbuJOMYA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Feb 2021 21:24:04 +0200
Message-ID: <CAHp75VcT_7=MKErF0oVn5PFT1_7OeD4cZaw5WAANvhHouB7V6g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: ad7949: fix wrong ADC result due to incorrect bit mask
To:     Wilfried Wessner <wilfried.wessner@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 11, 2021 at 8:42 PM Wilfried Wessner
<wilfried.wessner@gmail.com> wrote:
> On Mon, Feb 8, 2021 at 5:06 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Feb 8, 2021 at 4:27 PM Wilfried Wessner
> > <wilfried.wessner@gmail.com> wrote:

...

> > Shouldn't be blank like here, but I think Jonathan can fix when applying.
> > Jonathan, can you also amend the subject (I totally forgot about
> > subsubsystem prefix)?
> > Should be like:
> > "iio: adc: ad7949: fix wrong results due to incorrect bit mask"
>
> Should I send a v4 with the changes proposed by Andy?
> It would change the subject.

Depends on you. Jonothan usually processes the queue during weekends,
so no hurry.

> And if so, should I add the tags:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>

If resend, yes, you need to add them.

-- 
With Best Regards,
Andy Shevchenko
