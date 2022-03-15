Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A8D4D91A2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Mar 2022 01:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiCOAfV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Mar 2022 20:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbiCOAfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Mar 2022 20:35:20 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4913B007
        for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2022 17:34:10 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2e5827a76f4so12989247b3.6
        for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2022 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdjvIv9X03T1lnRHbPGRi0kHGuJQvLGOeu0KF8C3TmE=;
        b=jEFJ758GccUytc/uku8oIqw/xxhQy8DmIrM9FowX0a6oqE6kY/vX7qeWCVFbO8Ugrg
         YfdT6bNtHU7z4/gFPLyubag4GFqTLg4IDZpFMtWBm+bvZOs6jXznRDGakx6udkqs0Qqs
         +VuKL9mUYFFigJlGJ4Js6h+a8x+i+r8X5TrNPLyA30B/mYufZJAq8GYvTCCfzZdXZr94
         ODfVlV0BQAWvfKktc/u4vGmTWwjhkd0jWqO0i3EIvgAH1+DlXVB1eXGkVlhygytnzaUX
         UIiXWKdK/I7aRtZCUm0osrf2uaH8FBItMt61SFi7eoi0uAl/zI072QxxVGytpAtsmkxV
         R8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdjvIv9X03T1lnRHbPGRi0kHGuJQvLGOeu0KF8C3TmE=;
        b=OIRAYkLaykfLYOUUTR5yUnmyJ8mXmwTb34k39/KLmbR5ibTqoHgv6WTvkHU+yAt04j
         SWWJo7/DGfm9jdALbogpbcGnKqM06vqAa3aCNSekbEbSkjMZYGMYJ3nIR43+jI2EmCUi
         YvpnX9ZFaQgjzIqkDiaYU4LQN2XJjp9z73r6kwhXRxbM+q1uvX2/WQHhJ1uJOl8ulDwN
         Yb9e8WOiTS2d53JTgWGhLw3hv4BlD0ZlEFjtVHgxw3rI5CK07ga7rfrDA5C+jqRatxhq
         f54beoqDsrZQmrXzIBCaHOJnXr8wvhJ+MYZTzWvrBfMBZk/2nUX1IQ+tgOmJSpZn6G7z
         gQdQ==
X-Gm-Message-State: AOAM531Hfzrpf2YcgQ+MNyn51WwKIsqzzKAAWcF3We8hYDJQferRoXw7
        Vfovv10hLAyagZwNgYSNOESooasRdXtow9FHV+6Qjw==
X-Google-Smtp-Source: ABdhPJy4MuN9NbOvk7nJFMxNLaCNz29QAezZZW14Kq0imNjbj7lLbA9osK3qLlknwCiaWBXasghEzYOuwgJCAL9BWxQ=
X-Received: by 2002:a05:690c:9b:b0:2e4:da22:2a71 with SMTP id
 be27-20020a05690c009b00b002e4da222a71mr15804026ywb.126.1647304449363; Mon, 14
 Mar 2022 17:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220220175149.503495-1-jic23@kernel.org> <20220220175149.503495-3-jic23@kernel.org>
In-Reply-To: <20220220175149.503495-3-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:33:58 +0100
Message-ID: <CACRpkdZCxjDRHzNABuCj9N8EQYkSCwypxoyWkmrjbhBnq5dv-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: gyro: mpu3050: Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, Feb 20, 2022 at 6:45 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Using this approach as opposed to CONFIG_PM guards allows the compiler to
> remove the unused code instead of doing it manually.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Very nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
