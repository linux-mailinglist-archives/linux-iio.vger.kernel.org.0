Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA335122D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhDAJZL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhDAJZH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 05:25:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A59C0613E6;
        Thu,  1 Apr 2021 02:25:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v10so997061pfn.5;
        Thu, 01 Apr 2021 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcJF/BBGMNv5fOUXpTBUPmSo3mFX9t5CM+ENzKRrZCI=;
        b=W6s8vBaz6L8oONMsN+4LJuxghjCU55VIWZAU/VgTQM1jxjMNCusoKOZgwvX5vZW+91
         kqZb246ygjbOdOjyHdz2WJyVSD+TNP/oUWPNbIgepYM5aacKHrTDYMFudJ7P9bW6nWWT
         bUoqqJj9g4uV95tuk7r9wJlm/HSurwPt8Hpw7xm7RKUgZ2Ydn+NdUCNruB2fdCyg/3sa
         kIgxWwqJFWFieU31KUfMzXMiaLIe4hYT8mlcIqaKCSd1DWXWNvJBH+D65L/Iyuty1Dhj
         t5ZTnhIx9m26/Qag1cmQxS4TuUJVFMCKK36l8erSEn8tgjuL+s4YHXUPori1bkNfEaZu
         Xb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcJF/BBGMNv5fOUXpTBUPmSo3mFX9t5CM+ENzKRrZCI=;
        b=XrNuhnzERIecS8GnwcfpuzpF39boVkvUQt5vpf2h+tsdv1eG7X0qp1FKoSkALVvtzC
         NNjhYLPR0RqdtGi0Y7GtKvKd6HlLzA7V7s+URbsKy6duDcmlZj0qHY947tXYnpHycrB3
         1OK/O0ENEK7RIFum++CNJXw4tZ0+O+L0IZN0hiWO+LRQc2AS9ZvY7joipE4klcmhnjgV
         DfAQVgdK98qK0rxoJ+rFgJW3xeFz9bCQ5VB+bMbT3Hzb7kfIiaGl8kkcinNsCkorOUCQ
         InboUHFl6D19Z32nL56yp3qGjMylu0RWCzcteJVKnTV2D1cgPgCdg8xvFb5SzJVkc27d
         J5OQ==
X-Gm-Message-State: AOAM533ImEodQRkmIkFxc+CV/PH//FmadtJ1QILAB5iimDQplc1oIUSK
        zWGJ/5wAkfmBXWPAWVNSB9umn6tDJ2DBIEF6MCU=
X-Google-Smtp-Source: ABdhPJwCbEWia0Zw4AzmecyTFOw/29AALz4hmZPiBtzVzH5mQeMn7ExNpTKFDLFx4qSKoDGN2lK9U/0Ygl5/F69UwxE=
X-Received: by 2002:a63:c48:: with SMTP id 8mr6613001pgm.74.1617269106503;
 Thu, 01 Apr 2021 02:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210401062517.28832-1-dmugil2000@gmail.com>
In-Reply-To: <20210401062517.28832-1-dmugil2000@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 12:24:50 +0300
Message-ID: <CAHp75VfgL0KW0fetgE3NuBb4itMK1oY+yLmr1xDYkn390hCscg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: Use %s and __func__
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 1, 2021 at 9:27 AM Mugilraj Dhavachelvan
<dmugil2000@gmail.com> wrote:
>
> Change function's name to %s and __func__ to fix checkpatch.pl errors.

No, just drop the __func__ completely. First of all, we have a device
name, and uniqueness of the messages in the driver should guarantee
easy findings. Second, specific to _dbg() variants, with enabled
Dynamic Debug it can be chosen at run time!

I recommend going through all drivers and drop __func__ near to
dev_dbg() and pr_debug().

-- 
With Best Regards,
Andy Shevchenko
