Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26B571471
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jul 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiGLIYn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jul 2022 04:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGLIYl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jul 2022 04:24:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EF796AC
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 01:24:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so8991713ljb.13
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2N4KorNOXZE8VZqs+aIclRFr40PSboI56TVg9Mv304=;
        b=fW35/ftpBr+c4RzhbRFMn3K7XLGcmJU9mAlvOSsRP3ZUaEr66hiFtfb0BYrcMeH8B5
         DwNKjuyWi9uBXgVVn7DjZdvgFzYL2g83TxzWI94q1xsV35ULeCLW6lSmxaLooLzmU9iG
         0zMU1BxCufNarJRk+C+ampev2O3fzXS3b5lt6kb3mElizvj7QpDYeTe85KZ55rSfVqFf
         IlhpA0NaA/KatRILpjIiS838WoE02iNvqnIXnK36yoWPGl27G3U1CcuYqlrG73IoztmV
         JTHoAnU1iw/PS1t8IPguvg0pHX79PYLfhp2PIflrYyp4f5M6m8PfSEjEfQuxGJEIix1d
         C5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2N4KorNOXZE8VZqs+aIclRFr40PSboI56TVg9Mv304=;
        b=jDwa4YBMMrEt7CLXq4z8jghn1ivgs9RU4Hnl+rEVz7jLeafbdeHPahNG9ChbeemoCQ
         Z7cDkOilds1qeNHyYZnWX5oBj5B1mC7EuRYWUOQIhK8xKql2bzZT8bjYLd3JciYliT73
         Kt2gUI+rdy4XpcHm7gqkNtxARu2RqVIXjx2jViy3/Lcpdk1kJXpwejj52Dzk6w/4paML
         c/5i4q91Sfqr+l+zU+ku/84ggV5AUYm9zWVaob1Lug3IGYRtLp39nfd/3D8FStje5UuI
         vBG8WZpTCmdoPaNpJ1CZkrqw2J028AkTgzrMCpCi7iy00kIh7dFM2w5RxgayWnuUrLMF
         GfsQ==
X-Gm-Message-State: AJIora9+4d0rd6wX8m8Sxfbv3hUN9K6nub0QD7Jsu52nmHVvJFZRObcd
        cGpcOBs1ifPA5VU2lujlnbgt5zgG7ylaJh2UXzTkWNpOPLGn+w==
X-Google-Smtp-Source: AGRyM1u2gJN+EV2CSChsVctq8Vyz8B+p+mzI0oN1UVueY/Xyb4nc9EezgG6OgoeAoL1Tz8380hN4fsShEV59qlX+nZI=
X-Received: by 2002:a2e:594:0:b0:25d:47ee:85ff with SMTP id
 142-20020a2e0594000000b0025d47ee85ffmr12691951ljf.435.1657614278801; Tue, 12
 Jul 2022 01:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220711193714.50314-1-paul@crapouillou.net>
In-Reply-To: <20220711193714.50314-1-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 10:24:02 +0200
Message-ID: <CAHp75VeLktz27cTDwpoBMUNkuyz-C_jXtgxQxjo=m1FFBWqQYw@mail.gmail.com>
Subject: Re: [RFC] iio: afe: rescale: Add support for converting scale avail table
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Mon, Jul 11, 2022 at 9:46 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> When the IIO channel has a scale_available attribute, we want the values
> contained to be properly converted the same way the scale value is.

Beside that not very readable `foo <<= x == y;` line, I think this
will look much better if we first convert the rescale driver to use
struct s32_fract (or whatever is suitable).

-- 
With Best Regards,
Andy Shevchenko
