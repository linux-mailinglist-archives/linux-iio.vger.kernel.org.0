Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690BE58C55D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiHHJQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbiHHJQa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:16:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48FC13F37
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:16:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y11so5946239qvn.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lIIjCoHUVfNFwlhD0VD7gJY3u1tYv5jq03KtVWhR/yY=;
        b=LtWM7W+zhULoJ2tXHREvmFlsJKObq8Xx5i5DmbHhDjD/XzW16XVL6dkNZ4UFt10kZt
         bpQPCQu0yrLlqYXdCMaEnoQKsdH6aY0hKqLqgjTugVXTpkQRyeW4vXGll7KyN3g6nl6o
         UIGm07CqTSfC/ZtmLrdX/nWj/NVfXJSfQqxSITsyUlpxka+k4fzcJmca8U9BL3YqHLmm
         TGPoui1ehsa5g0U6/Nv4LKazuBQpLjMpMjfMQeNa7xP4dRgX/z1OS0tFa7XDCGCdhEpB
         Ks36i4IhLQhPElQszNPs67sk216EWkGBxOEnLUk61IbE9WxFFDikJt1Ie/EIxj2ZQU6f
         59nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lIIjCoHUVfNFwlhD0VD7gJY3u1tYv5jq03KtVWhR/yY=;
        b=Gx+q0bCnz+krNgVBFX8HPhFl+9bsB2ds+yBJ2b79QlSmXCIup3snVpm6YseYsghj01
         fMwjGPukk7huPXKS1OGxQ0HMBu9W9neoBjfDlilVOZhWtPdINXrK0iyhc3jrZCv9Ucm4
         AamZ6/S9ZEwqwHjMY1INjIKMyan6dsR09Jjot7XdN4BjQWqvHt8VJ99Reoy/SD+DnFiE
         bqA8v8DYQ0vX8oZ+oreXxYbVRiSS4OVFTLFriA2NzX7AJscVaTLfLmck3Bk+FjLSZdJr
         73eJmN12t0VIimqy6ex3tB6qmsfct1XdfGIgJ1L15sZ0l5t1b91a/JDwN4sFQF/DsS6P
         nNfw==
X-Gm-Message-State: ACgBeo2gl/gwUC5fZcTyt8gsUwtd/yIMJ2ljpa6UYJcRr/MgLuhj3Q4g
        HlawrlS4o5+O8KvV51/zWJaQT3WDgmIKzemiTGQ=
X-Google-Smtp-Source: AA6agR7KLkQXAdQCMlzN6QzohhFrFUUujiespis88PNBw7UZ8TlKjAn7d6T5MmHnwUeZEl82vMgd51Zj6jhdEr3fXs0=
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id
 iu3-20020ad45cc3000000b004748ddadfb6mr15096370qvb.82.1659950188950; Mon, 08
 Aug 2022 02:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220807145457.646062-1-jic23@kernel.org>
In-Reply-To: <20220807145457.646062-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:15:52 +0200
Message-ID: <CAHp75VehuNsXbNO0qW0aYZqZcmAR3VbOR_zQQurhNxyLUtiWeA@mail.gmail.com>
Subject: Re: [PATCH 0/2] IIO: Clean up a couple of warnings that snuck in.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
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

On Sun, Aug 7, 2022 at 4:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I'm not sure how these slipped through my local tests and 0-day.
> These are definitely shown with W=1, perhaps not without that
> but IIO is generally W=1 clean.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Jonathan Cameron (2):
>   iio: test: Mark file local structure arrays static.
>   iio: light: cm32181: Mark the dev_pm_ops static.
>
>  drivers/iio/light/cm32181.c         | 2 +-
>  drivers/iio/test/iio-test-rescale.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
