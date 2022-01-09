Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B621488AA9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 17:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiAIQrq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 11:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiAIQrq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 11:47:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C100C06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 08:47:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so44037567edd.8
        for <linux-iio@vger.kernel.org>; Sun, 09 Jan 2022 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+E3+Y5pEVR/3rI5C8diqL19DcEGGdhaEvhd9GIAj3M=;
        b=qCthtYyaJ0aEOEGElpYrwRMpWaiQhelVueqYwoZiPZ64YQ0TpR+G4EbT38s8Uau76W
         EojzY2RLr7BrXU20m9gLaw15tjIAZavMPO6H3aeq7ZD8AR/rUMksZWAbyGFlrAQzzO+e
         DUYvn2TD3zZbrC8Y4VelcEdVpfCFhg1v1f+9Y402ZbTgwHNB3M77jwA7rNP5x9O2TtCz
         HBQtS9D/CmP7J+aF8uQXg8Wc8v4k7Rm3DGawcwThSqw5tYPqOgmXlOHs6NMMCoaH3wFw
         kNfHLSg5PIXukWKimtj3W9VSlNfDypnoMYPuqAf4OlmOWtNUVtrATaz7qwmchq9rgOPX
         NYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+E3+Y5pEVR/3rI5C8diqL19DcEGGdhaEvhd9GIAj3M=;
        b=EdDlad9hOna1QbkMt1phcbcUJy1OKILePvfJs/bKZf28DfwZ1fVt7X/HdovEO0Vn2b
         zb1Wj+X8nA03ZXURVt3eC2tyrCaWBSuMSltIm73CM7j4+ywr4I6LRYmw/nm/EXqjPysE
         qNYFPfiyoEfO4cbVPyr6Ma0tj+Y5Hb71Vcff0kwkLRE1SmTCxqn+U31gPaC6c6NlCIw8
         x1vvq40vMrcYaQMSCBioTYnwS8UYEGm1JbNq3tHDyUKcx1edI6uUkfB4tPLRxfsztWYX
         fUCXJknfV+ILjngs7Vas6kGFik0SccAWiPo7k89kMLOTSfZMg0vSGvaexlxiILN7D6hG
         vgcQ==
X-Gm-Message-State: AOAM532064pgCz25NkI/ScQAdn5bXW6sdz3TqTXiRTjIMXndk+pEoj+U
        gYaCeudcbobNK59TQRHW34mdq4DEvwzeysWgg7U=
X-Google-Smtp-Source: ABdhPJxKiaVwIsyH8qL3BIZ05p+mfdp07Z9TCSq4v5PL/Fz+cWF0jTDvHMqd6E/wEYoxaWh0XqM/gqGrMCaQ9QnZlJI=
X-Received: by 2002:a17:907:a0c7:: with SMTP id hw7mr3594516ejc.579.1641746863997;
 Sun, 09 Jan 2022 08:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20220101203817.290512-1-gwendal@chromium.org> <20220101203817.290512-4-gwendal@chromium.org>
 <CAHp75Ve5OjpdSs3DLvV8PORZMmEz5H+nA=c2Zior-wMTWj0A3w@mail.gmail.com> <20220109163903.7c368fb2@jic23-huawei>
In-Reply-To: <20220109163903.7c368fb2@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 18:47:07 +0200
Message-ID: <CAHp75VfshkFi37gNTVqFWDDU8c5o+R7d+trK=0zi2_eB5XMmLg@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] iio: proximity: Add SX9324 support
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 9, 2022 at 6:33 PM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Sun, 9 Jan 2022 14:25:35 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jan 2, 2022 at 6:28 PM Gwendal Grignou <gwendal@chromium.org> wrote:

...

> > > +       { "STH9324", SX9324_WHOAMI_VALUE },
> >
> > So I believe this one is allocated by SEMTECH. Can you confirm?
>
> This one seemed highly plausible, but indeed good to have it
> actually stated that they'd allocated the ID.

At least technically there is no issue with the ID. Administratively
might be, that's why the query.

>

...

> > > +       {"sx9324", SX9324_WHOAMI_VALUE },
> >
> > Missed space.
> Fixed up.

Noticed that other hardcoded tables have the same issue, up to you how
to proceed on them.

-- 
With Best Regards,
Andy Shevchenko
