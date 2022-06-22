Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881755477F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jun 2022 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353907AbiFVItR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349937AbiFVItP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 04:49:15 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29580377DF
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 01:49:14 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l11so28967714ybu.13
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3DXofTTLpzI/TjWwuQqQFpuNkc2XNdmD7En35ZxJTI=;
        b=DSxnLgcLtwEK+8xC/wAI4hy0XWVJyozvRHgM/P1PRri9OR0vAE41oLzJWNs6tSh+d6
         R1VlnSLbwHfh5J8W1RRNqIs/7slA/2yXXM7j9oyVPxPeB9YkRSjjdvZSe9O7H9MHz7tU
         LFsAPiUMBOCqLhz9bITJneV+ol9NUab5mk7MZyr5IqPD7OnAcidcQVMdmk6kNbZqw92l
         7YD8/GxiZzmXIm1urIK9V76rlwBLAdYL23WHbvF7tQm9UIk0WC2jrIsfupvY0YvKHzPh
         x5UYXcMGKpsoo23BlEWzYM7Fh/Ly4MWWJXklMWM8AZcI7Z7wPgrj4zri+B++Z1eH7+68
         RSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3DXofTTLpzI/TjWwuQqQFpuNkc2XNdmD7En35ZxJTI=;
        b=yozMN4uVnKQO2c8wlhh/lpYmbGYd45bfelk6PVrVMt8zBgQRft4lLynTZQ9onIcw9d
         GwuCtFxZTIoiHsVr++YCoErPs0ncsHLlFMFdlNjwyBGU35PaZjNi0cfUClIzTpkPMsFH
         lkb6iXf0POxCW7xm4adiB9Tj9Vp711ZLJ5TbI1eGFf49p5Ec6zeCJxk4bE5Q8ln6GUFp
         505N7W0PHQLK8foLKjLoNBaUU4QqzgWVbkm4xJRdlg113jJHmnNqFrvHm8F1Yn82vmg+
         DU+GPyGuyQtv4HXqs4TX7D6WfgZfnbGWMOM4eWOGni6Mh6+rME+GnCj3/TKTWsrdIoPV
         1dAA==
X-Gm-Message-State: AJIora88J7+NHrf84izT8XMb/e3TNjl6voRWN4+UsZayoSnjUWUlRRWT
        ffi2ggydix322jO/5h0+I2lvBR07Q9F9QP5IWJaajg==
X-Google-Smtp-Source: AGRyM1viKiISxQ8Egb+XkUDnqCFWJBQSB+E1CgmBQX6W95Tae4PDllQKTdZPoQBkh2q+f9xPXlJG8LG/mgZw6ik0cv0=
X-Received: by 2002:a25:7255:0:b0:668:a372:b433 with SMTP id
 n82-20020a257255000000b00668a372b433mr2451551ybc.626.1655887753451; Wed, 22
 Jun 2022 01:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655509425.git.jahau@rocketmail.com> <18f223776f6942d52af2e41dd10160e220a23311.1655509425.git.jahau@rocketmail.com>
 <20220618155618.18996d0c@jic23-huawei> <10c06f21-23d3-d3a8-5a6d-8290cf2971cb@rocketmail.com>
In-Reply-To: <10c06f21-23d3-d3a8-5a6d-8290cf2971cb@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Jun 2022 10:49:02 +0200
Message-ID: <CACRpkdbpz0LPXgW5as3g-pVyHe42R_EtdY4=zaroGxkE6kq5SQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] iio: magnetometer: yas530: Change data type of
 calibration coefficients
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 21, 2022 at 2:51 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 18.06.22 16:56, Jonathan Cameron wrote:
> > On Sat, 18 Jun 2022 02:13:13 +0200
> > Jakob Hauser <jahau@rocketmail.com> wrote:

> > Ok. If this is harmless to existing drivers fair enough, though my personal
> > inclination would have been to take the easier approach of making the
> > new variant sign extend on variable load (sign_extend_32() and similar)
> > just so we didn't need to check the older parts weren't affected.
>
> I didn't know that operation :) Let's take this.
>
> Not sure how to handle the "Reviewed-by:" tags. Even though it's a small
> patch, it gets modified a lot. Therefore I'd remove the tags of Linus
> and Andy.

Keep mine.
I very seldom disagree with Jonathan (or Andy) so the default to any comment
from them is to keep my ACKs/Reviews.

Yours,
Linus Walleij
