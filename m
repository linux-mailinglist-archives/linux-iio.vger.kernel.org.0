Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3F2D4499
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 15:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgLIOmW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 09:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733042AbgLIOmQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 09:42:16 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C85C0613D6
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 06:41:36 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f17so1313146pge.6
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 06:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dv36TdENnVUgmyOMLy5Js/A2ShsqmYWWUPMt8lD+meg=;
        b=qw6uz+BYksdvOM1TVrHYj0+d/bVN4UtpZ0eWX+JyLMu6czat0srVsnFPVfcuiCNKr/
         gIS5hQ1Z9AiYaIA+nvDJ3KQwAEkBFS/JKGj4qHuDP2hkfAv4Q/Ze06voQZKKIwPFW2FV
         /dgIxC7M9wAGCjsbZVZSqmJRO2vMLNDjThJKJV2wvuRCM8bedqZvnv0UK8ZJiBdJ9ZIP
         ypUdIghm3zkefWSce+4eQgYhX1RgxaJEVofuyLvBgxhU3SNuqIdUV0seQzguR9AOQI8Q
         xc8vXvLGduJfg2IvdqF1XMYb6yu8Jo1LEK/BPGUexjQSCTA8La4tTq48Vskt+RLvly8W
         zg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dv36TdENnVUgmyOMLy5Js/A2ShsqmYWWUPMt8lD+meg=;
        b=H5zFOialcG/DIaWl7QNVEvKYTQUwy4IYewxQ7KP3FZjO1wT01HAUq1ynCgcAu7jYv/
         IrfC8sYPQnkvoSLbv8afjax1pHaggTJbhDRmPCmPgN1sADuKHWecOy9aN7gtYpr+nkFs
         OInlIkZE3xillQWqCKow/noSUZhut9PwcOZTLJu4nkcPFc4YTcPCbJqiS4C8b8lQIP1/
         mc6KknhQHHfzEJJU4j+ETXBV0bn4lFmZrmieTFC1m9nTKkEFNzS0QNQt4PC2/G+Br3GH
         GGzL+tgXzkyhd8ORdWeRpW3Jixos/WldJFLSuv58ETETSLWJE9TJYnay+YHPvWzd3YVz
         pUEQ==
X-Gm-Message-State: AOAM533vfYOIFp9NiBx6cNNvO5ERcVcM3OhCCFYWjOKmgeI+NSObj3Bl
        VGi7U9KheFsqtk8/5zpsRDQB4qwtPsqvBaa8LZs=
X-Google-Smtp-Source: ABdhPJyvVLR6Wfnm4G0HFKDJFqrTBXxQtGlVUiwmrMTMHyYJO43ZlPvh7PJQGpJneCkTDwilnwYZa6osn1uuORMl63I=
X-Received: by 2002:a63:c04b:: with SMTP id z11mr1538530pgi.74.1607524895693;
 Wed, 09 Dec 2020 06:41:35 -0800 (PST)
MIME-Version: 1.0
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
 <CAHp75VdqYxfdS5+zPsj071HSJ_CG3M8n=zfoTwg=jf-f6_naUw@mail.gmail.com>
In-Reply-To: <CAHp75VdqYxfdS5+zPsj071HSJ_CG3M8n=zfoTwg=jf-f6_naUw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 16:42:24 +0200
Message-ID: <CAHp75Ve8ya2rKrKoRp9F2o+xvAJvVWCdtqo6gfjXgourLHXwBA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: common: st_sensors: fix possible infinite loop in st_sensors_irq_thread
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 9, 2020 at 4:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Dec 8, 2020 at 4:38 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:

...

> > +                       err = -EOPNOTSUPP;
>
> Wrong error code. You must not return it to user space (or you should
> fix all call sites to be sure this won't be returned).

Oops, seems the other way around. Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko
