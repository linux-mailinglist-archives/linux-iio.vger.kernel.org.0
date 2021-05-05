Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0A373BD3
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhEEM75 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhEEM75 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 08:59:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E801C061574
        for <linux-iio@vger.kernel.org>; Wed,  5 May 2021 05:59:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o16so2337258ljp.3
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aq5XNOfUQdjc5MQW5ThVD1Tl4zjG0Q3QxIAgOhGNuPE=;
        b=VoVtb69GLr/uP8AzeqYYHJ1+txH+ndgSdDMviYaU5d9PI0zKfz3gH+SQ43ULm/slGK
         MonoWnQ/ZgzUnDlgwwktsaG0MPmezGOV0nUsaZ14xZUr0I9TmNohzbYRKKJIQXvtVXcA
         m3B2oJTfNswrfbk3Uyn+Bm2/TzuINQBU41Aamd95hBv7qv+hO6Xfk5SRUfaIn7IqRuCS
         BQsGQAxiu31fZ19JKeEjjO6IkjCFqIQfxIaOUN07p6u09zLkOBVT0Hx1fhqVutiU6FzJ
         uO2UqQG35EYR84hRobuEbbcZTW+oLrsZ6DlvScHlakH5uwY7pun3fD6yYsXUe0lQoZf6
         eiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aq5XNOfUQdjc5MQW5ThVD1Tl4zjG0Q3QxIAgOhGNuPE=;
        b=YsxgfTAvXEY9lPHSqsMW3OpSpf0LRwxCH63F4LXGpdEmEEeSQl5wuRaxcfaag58945
         CfL/MAgh0m3NXkqc4JYp+jubDygwi0O2Lck73GZO5w/d48uefAeHjyBFzkSutWaL3xHT
         49gqKbljX4lOkpnOHPoSSoegP7FHcT+KSMJV7/62Yjc2x/f8ggAfiNSEGrrRuhBO6Gb2
         lhPL5IsritsfurCGaiGINVbH56XUsPcKOBSfcwZU44v/8PzvssO5fAH/9Dbvmo9KLW+N
         +jOz2q+gj0qwcRf9rd6+eDBFZ/hHXG+XgXjc1sExjVpxgm91kDzRuJtm9LP2B3BWHqVP
         iQig==
X-Gm-Message-State: AOAM532VqlIZkv3kY4v4BpnbQzkkUkf7aRJjmkltdfDlvdYSllcwnPkb
        qhpqcGAGHN8UJ/djeKD1k679qE6IEk9PMV0AIG+/NA==
X-Google-Smtp-Source: ABdhPJxpUhmUqcuQfT6D4cK9JLJLqw92q7SDF8w6GljL3Hlgy64ll/PLaapVldeNYKkjXnHBL5I8zPz7vnn7b1zPyD4=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr14607110ljg.74.1620219539556;
 Wed, 05 May 2021 05:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210501172515.513486-1-jic23@kernel.org> <20210501172515.513486-4-jic23@kernel.org>
In-Reply-To: <20210501172515.513486-4-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 May 2021 14:58:48 +0200
Message-ID: <CACRpkdZJfcgHM7m=TA-qKJOOh3fmF9d+2cP3G=NSuyuhj_svww@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] iio: gyro: mpu3050: Fix alignment and size issues
 with buffers.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 7:26 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Fix a set of closely related issues.
> 1. When using fifo_values() there was not enough space for the timestamp to
>    be inserted by iio_push_to_buffers_with_timestamp()
> 2. fifo_values() did not meet the alignment requirement of
>    iio_push_to_buffers_with_timestamp()
> 3. hw_values did not meet the alignment requirement either.
>
> 1 and 2 fixed by using new iio_push_to_buffers_with_ts_na() which has
> no alignment or space padding requirements.
> 3 fixed by introducing a structure that makes the space and alignment
> requirements explicit.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Again a very nice fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Again I wonder how we can help driver authors to always get this right.

Yours,
Linus Walleij
