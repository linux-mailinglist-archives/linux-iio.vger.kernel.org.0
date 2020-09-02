Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7925B354
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBSGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 14:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIBSGO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 14:06:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D421C061244;
        Wed,  2 Sep 2020 11:06:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so67699pfw.9;
        Wed, 02 Sep 2020 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LX2OMZai9flsOsfe5+rGnzhjkRdBhsRLDuzWXJdfp/E=;
        b=TeBdJHLHyOZ71K4CnkGNgZQW/2hBuEGl2rAqWycRk4Ffh3Wa8zlyiKHx5yZvVoU66X
         PVR6XebZS/lZu7GN9h3w9Dhj8UiCs3YklPhM+8R18rh1FDPGroYDT2R82xoMrWLOPkYR
         wLPrS2Vh808yt0nZ6PC2x+QV9qdwPB+sDWhDWChPudbq63FkVsyuOJ2qycFpdaT0B7fM
         ilA6UnAeavcBGEd91S9n3d8M7w8hWBtavAXK1Y+G18fDZx/Y+dJWWD3vk68DXcZHAb5z
         SERYqzfWT7BBk50uIsxNFeqZt7Pt3R2uJIpHhR3vd/eEC/qPSyUCyD1yKavz+DfZk/dx
         WZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LX2OMZai9flsOsfe5+rGnzhjkRdBhsRLDuzWXJdfp/E=;
        b=DenEvLSYy1O+EWjTMe6NEZDO8JStAEodTxFBVSrUvEjd0PUnBZLmYkGJ7z+x4QCNkE
         uiJVbR8un35aTUJKUqEmFO+VookAKq0DyfyW8HjkqZT9nZmgSQ47F+unwEMnRSzSmQqZ
         k2+rVqadIPf2XRlggyYta73YTzJvOSqFTcs2NVoLhTCqa+qUcTlnfnMHN4Tb9hVLoNA7
         kFj/TDD67dgS3vaHvzKdEbdkWUQowBVL44krZTv2YA0jhWusQMNrGV66/Y3X6fOKSH9a
         8lE4P301M13UfhJ9o8FP/mXqpgCnwSaFFLrtyQ6vDWP+vAGRAXxblu7+aQaKHgqTRQgT
         EVWA==
X-Gm-Message-State: AOAM533RJcu1P8PN+NG6AI/3z/dWJkAZmGFu27h0BVc3tNX9X/DEeuFQ
        d/6vKbKzGw3ihqaNw/V6sL3O87GOyUFhdPpnmn8=
X-Google-Smtp-Source: ABdhPJxls+o/6SWSy3/4c1vyQrVA5ehqrtaxB362IX2RwBfNuNMRPAypmn3oUkxqpisRFjrY69wh0sILHpwkUtJR0mo=
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr4122167pfj.307.1599069973447;
 Wed, 02 Sep 2020 11:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200902134222.28357-1-mircea.caprioru@analog.com>
In-Reply-To: <20200902134222.28357-1-mircea.caprioru@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 21:05:56 +0300
Message-ID: <CAHp75VcYVsFtiHYfy4pzsZdDWOEToU1mf2KmQ2BaEtrVbPy8kA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: Fix typo in device name
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 2, 2020 at 4:45 PM Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
>
> This patch fixes the device name typo.
>

Luckily it's part of v5.9-rcX, so if Jonathan sends this within v5.9
time frame, we are good.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Fixes: 951ad4700313 ("iio: adc: ad7124: move chip ID & name on the chip_info table")
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>  drivers/iio/adc/ad7124.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 8dce06e9e69c..766c73333604 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -177,12 +177,12 @@ static const struct iio_chan_spec ad7124_channel_template = {
>
>  static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
>         [ID_AD7124_4] = {
> -               .name = "ad7127-4",
> +               .name = "ad7124-4",
>                 .chip_id = CHIPID_AD7124_4,
>                 .num_inputs = 8,
>         },
>         [ID_AD7124_8] = {
> -               .name = "ad7127-8",
> +               .name = "ad7124-8",
>                 .chip_id = CHIPID_AD7124_8,
>                 .num_inputs = 16,
>         },
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
