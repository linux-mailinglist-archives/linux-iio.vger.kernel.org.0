Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE16291D43
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 21:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgJRToN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733194AbgJRTnz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 15:43:55 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4AC0613CE
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:43:55 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j8so8390347ilk.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWenhFesr1w3jNOrHoKxpIn7aIFwj8qNewUZEqgfPdM=;
        b=VMvrkPOjHLlUI4sI2rGOGrISxzwGTODFlquH0zCr68cYhcIzYg/MHdPtegAja3vzVw
         Lu+TAn7km0+xlnYQyM1xJS8hq3q73WvmTpICDR4AwTamcnLbCwvquMZ3KbGvgusTKw2Q
         2qpBvGIjMWb6GtF5HJUNqK1yUBBNMA+GcEjKn7WNoFbNz0405900KcycpwxBG10xc/gH
         lMd/6ncCX7lUP61gfFhdD+FeqB7kKrIbRx2WjIOjl0K13gCaOn9cXTW+xhlzRLXS/4Uo
         BYns0JcvGifKCUYamerAe//rCV6IKDoi8F0IgF1UALU+6FIQpd5d2TarzYtWPAi/CIf5
         ve6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWenhFesr1w3jNOrHoKxpIn7aIFwj8qNewUZEqgfPdM=;
        b=PNrz0iO7KqvD6sNLDXsS9ERHASMXx9BURXnsAUMJqZDSZKyNF4hdTobZMX0CjPOs4G
         1StmKRvbcZuBv3kv2oBSlhmnvxzC4mjXrrk7GNOpllCtD1DgxNmGYkysH5HftUTn4HcF
         u/XnGRbBA+DDfcUQlVGMb7u57GqO671N1ZNFyTb8+yxMR8T6QSdTgeRikzTEB2CrvYco
         PxaGctIyBJWxXB1eAZN7oRUqqAhj4GTw3C1m5n5EUlNwcI6yS6tQFwr6m5i5IFtEV+O7
         v7VM6WqrbxW07h+yBCIXBVCM2jgalqRWHYaGSosaybzPYNrrONik4LOkkOSboZPn7zFw
         CrFQ==
X-Gm-Message-State: AOAM530cHsreirq2t6uGqMQY4buxDCt4SkH5nzyi9Iouof8vr8/4Afeb
        URQPaW55m+FBW+/NZaG8ONJEUC/KO4muQ1yIfkYHdg==
X-Google-Smtp-Source: ABdhPJzVCY4CXlJo5Yk7DLu6Jm6h8fkfHziS90cktjXSQwP51sBX0o/6i7dgEM8BHuTRh478qb6FII0oYpE820vpB5c=
X-Received: by 2002:a92:c5af:: with SMTP id r15mr8834836ilt.88.1603050234668;
 Sun, 18 Oct 2020 12:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201018171545.3190476-1-fparent@baylibre.com>
 <CAHp75VfJUhA3WmmirctmrieQfZKSNerFa=nwPmBYvffXUTRp9A@mail.gmail.com> <CAHp75VdFw5jy10QSOFbJVyObqEmiaavFM=BFd92kw1AH4rMxqw@mail.gmail.com>
In-Reply-To: <CAHp75VdFw5jy10QSOFbJVyObqEmiaavFM=BFd92kw1AH4rMxqw@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Sun, 18 Oct 2020 21:43:43 +0200
Message-ID: <CAOwMV_z9B4suGd33H_D6ep-UpXn2W2QyTd8az2C_NERMFALWVA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: mediatek: fix unset field
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, chun-hung.wu@mediatek.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy

On Sun, Oct 18, 2020 at 8:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Oct 18, 2020 at 9:31 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sun, Oct 18, 2020 at 8:16 PM Fabien Parent <fparent@baylibre.com> wrote:
> > >
> > > dev_comp field is used in a couple of places but it is never set. This
> > > results in kernel oops when dereferencing a NULL pointer. Set the
> > > `dev_comp` field correctly in the probe function.
> > >
> > > Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
> > >
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> >
> > Shouldn't be a blank line in the tag block.
> >
> > I think Jonathan can fix it, but be more careful in the future.
>
> One more serious issue, you forgot to add tags you have gotten in the
> previous round.

Thanks for the review. I will make it easy for the maintainer and send
right away a v3 that fixes both issues you pointed out.

> --
> With Best Regards,
> Andy Shevchenko
