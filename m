Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD972550D87
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiFSXMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 19:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiFSXMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 19:12:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E785FE3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:12:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ej4so8856478edb.7
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oNYbdTMC2COMsNWatWMyYc72XIREuv2bQDskB+/znM=;
        b=exIXEoiJtvKd4UubkR/nkCvqc5ZFYp1DwCYa2eopsu/2JNm++Gg8Q155O5hI8fz4Zq
         cJXWLWWaxCE+gAZaaz2YRCp70gYhEHxeTfslyD6F8HlxW6Tm4A2uTIPsoAr+evx56GiQ
         ngYuTA79eVKNKT/+TRfJs5BHMKwIrXZEGJLcsG3SyvLJ6UnPGMICYSHjBBcdlePa3RUr
         v7Tm7VvTkzbNhKKshbISnMlpY5ySs+nkOlxFF5G2MaetPG6aB+mSUTPFDpEk0GlgZdC9
         ei5VkH9vziRSiqXvxOxpG8mVYkzw+9trc4LbazAn0RFAyaRuHR+D717ZoNX0jZ6QzW/j
         zLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oNYbdTMC2COMsNWatWMyYc72XIREuv2bQDskB+/znM=;
        b=cB/a8cJqg8VFPM287/6+BdaZiRswiuYGOzcxJMzT3f7k01zcoRgdOrtzmJc7BjoWFo
         +mNQL4XqwP+Y7ocn6vIJmtq+7f3dmLKPG7HvU/08V+C5BzLQ52cKwRe2I7v5dbSnlM9s
         son5uIGx+KgnMrYxDpuSfFuAGEwpPlZJx6yHCfEl0BJc/jDGF2B25W41ZXjjAuHeOCmb
         HA1mDdhtKJT7C8UGNlHHELoxbtGSL8GIwqbBt06TjUEq/xceS11bdaDkxWGKdrCaEHdG
         LmPiCp2wpoJaMtWQ0KTvgE5Vbo8xxqitDjI3JBu02q8qL2qtl7iagp0lzJ0+ICgfcl6o
         coIw==
X-Gm-Message-State: AJIora9fmeSftAbNR1bixVOehGULTLk+mLyWhUAnJYCqNibzowWr+19U
        Iuu3AYyfy64TyjJddkCCAwKZFpVwnHnz6JRhAP0=
X-Google-Smtp-Source: AGRyM1sFt9rJFFEMLhdLzDYjdVn8I1QzhjPMzZdz4Q+FK+MerPDMBAR4ZFlCKIk9kEq4EeM98G+BFx8l1fWqbvdsHVk=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr26412998edc.97.1655680332673; Sun, 19
 Jun 2022 16:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org> <20220619185839.1363503-17-jic23@kernel.org>
In-Reply-To: <20220619185839.1363503-17-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 01:11:36 +0200
Message-ID: <CAHp75VdTwj6sAQp2r2egFXvr5RQvnDHrOUo45==UT-_6A9GKrg@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] iio: cdc: ad7746: Move driver out of staging.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> All known major issues with this driver resolved so time to move
> it out of staging.
>
> Note this cleanup work was done using the roadtest framework.
> https://lore.kernel.org/all/20220311162445.346685-1-vincent.whitchurch@axis.com/
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/cdc/Kconfig          |  10 +
>  drivers/iio/cdc/Makefile         |   1 +
>  drivers/iio/cdc/ad7746.c         | 818 +++++++++++++++++++++++++++++++
>  drivers/staging/iio/cdc/ad7746.c | 818 -------------------------------

It's a bit hard to review, perhaps you forgot to add -M -C when
generating this patch?

(Also note that `git am` able to parse renamings, the only thing which
should be in full in patches is when one deletes the file, although it
may be already supported by newest versions of Git, dunno)

-- 
With Best Regards,
Andy Shevchenko
