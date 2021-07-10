Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762D93C35B9
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGJRTR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhGJRTR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jul 2021 13:19:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F6BC0613DD;
        Sat, 10 Jul 2021 10:16:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a6so14132154ljq.3;
        Sat, 10 Jul 2021 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hy8XAx5SW4pN/d1sv4D22sAv4w67Kioti8n7i7I249E=;
        b=luir/OONiz7OkA/vaFoOF1Odmn/TdO/z6/+KqBylNkwDcqUp67qqc8JTMnCryu6w4T
         Qa97grtM4qeuE7gBGcAzX7E1DGtqTQbHY72bCc4e0REelL6Si8kzSHJYhW342hKIhu9X
         6m1m399bkQpgjBYD0dwJ783m5eRJ98aaX+QqpnJjMWO4rH85gQ2UNhWprj+/g6WAuxXn
         r//ugg4F1hXusgifjVyvtxTNcZpeT1Uzx68kmm7PjrF8/W4//XJLfL6PFlzBAkKfSnvx
         CwiU2Pla98+2G9p02+dLrhb8tF2fphm+eIBf5XS/SgOG50UW7dXA910MpkF3F8IJZnML
         Dftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hy8XAx5SW4pN/d1sv4D22sAv4w67Kioti8n7i7I249E=;
        b=BX/FCCubYrH+7ydh+geDS82XXqkta811bJUjWTDj+oGChGO72Yw/WJOQMPtEXC50m1
         H38/MkG3hwiF7AAEeAOxQIqc0RvBLIoH+dGtD97UWlY3GwIb82WmRbeVIrQnhmKFH03O
         2lK4tobV+Pnm5dY6RtJvYDUbUG107M5FC+bBm8yIHP/6Wb5WcOrpmFM+6LGvilhhLwgV
         3YR5hu/pR9N3ZnOo0wJOZZBS3lGyyd8nw3nrZ1AWS0Hq1IYLaItVlwba4MwWT4nEU79J
         zU+vzCF7QTR4sHbHvDJdnrHgyizfqHdo38ZYrHY3dDbSapip17w+y/kijRo/I/NmdGQr
         8PMg==
X-Gm-Message-State: AOAM530KRjvsNFBnJNN5ozPOzxmC19cKTIvywSFbpzcxvDqfgLt/5dcZ
        jHIryLB1mAjhTHdzcN7PrQc4BzRMtuB0CfLAOGo=
X-Google-Smtp-Source: ABdhPJwwDe6c1AoHRmBi0VMaLZNB373LGZjAcoLRD9/SkLAVxvIhTTANZepWPY/GUqY57ZkwXsCXmI9BhkAwkwpZWqw=
X-Received: by 2002:a2e:a785:: with SMTP id c5mr35009741ljf.490.1625937388938;
 Sat, 10 Jul 2021 10:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210709031526.30746-1-jrdr.linux@gmail.com> <CAOMZO5BHDBR5y5q559UexTmYbhPwSp1MV3TJ3k+z4W8ehE-5_Q@mail.gmail.com>
 <20210709064838.wtuqgm3qwguhpfjn@skn-laptop>
In-Reply-To: <20210709064838.wtuqgm3qwguhpfjn@skn-laptop>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 10 Jul 2021 14:16:17 -0300
Message-ID: <CAOMZO5By=qBZ-Xm-QoXGQ9TfCXJsFQaYHvG0_SoxtKERBRizYw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: Initialize return value
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Sean,

On Fri, Jul 9, 2021 at 3:48 AM Sean Nyekjaer <sean@geanix.com> wrote:

> I have already submitted a patch for this :)
> https://patchwork.kernel.org/project/linux-iio/patch/20210623113115.581609-1-sean@geanix.com/

Please resubmit your patch with a commit log.

Thanks
