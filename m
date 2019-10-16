Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D32CD90A8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405217AbfJPMUo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 08:20:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39020 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405187AbfJPMUo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 08:20:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id 195so4343484lfj.6
        for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2019 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6GV8doMb+gqzCvtrSmZqY1Hj8oeje5u/TcPUTpe6WI=;
        b=qdgkmqij9P79ZYU6S8CVk0DzQmZw/5eXOU6Zu1o+bhhud2u28ebVvCGnEuesqLv2zQ
         rcrdshmCrR2YtDxnXElJq/kpUIkdvPMZm0ybZcHbVFrYslsCw4l5hYcgxWjVVZrG1XPy
         9W4KG+nemB+KTVJw3iSkJe59nkT08Lo7METbArW13bc9I4nPkbqo3LT8kyf3YLfrni9g
         K6bqPJ6HNIwBd47pt1sMrNAM4Hg9XxbVTq8th4lsuey6MxuYFNhJTOGh9Gfo4dwWzU8b
         FzHp7yfg3yYqHEI4QLKRBTX8L+usg3oUWZO9Ct7U7fFP+dZNF06XaKPO6XHFubT9XKBv
         PhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6GV8doMb+gqzCvtrSmZqY1Hj8oeje5u/TcPUTpe6WI=;
        b=eV+0UcNVPQ6lOdpY3mPdDyNt50RMjst+ofKiLKd7Y4r2DNYGFQl9gNbKoEzNqH/1XS
         ybma5G+U1RluphZH+Ygd7xIUrAQpG5MFlrq16QJAzuF09BwWh3J0fe/R5s+7sjcWjD7c
         vdS+KaGb5Dj2/Zh08r5IHw/aJxFFRlbU5y32D93WMfMfqRrQYg1SbYGzQUEzYdHAk27S
         GSeMbiGcA6LgS/7NeosLDX4BF7xL8qFP3Fxo58Linw4SBcGMBfP9CuuJ/E+VeI+0lSCm
         Wb2bYXm98Urrshe8DJgVuAAhq1rZxiPMaS18EzaUJEJFigzgdj97G+6cVd+ATPGmyxsd
         btjg==
X-Gm-Message-State: APjAAAX4vKMg+qEbw55JRpp/Yl9ostobcYWTDtSJ3f97eOkb+nvfL50s
        2HY7lnjTrspjA69O/PprvNgv0+gAO7GhkA9clStuGw==
X-Google-Smtp-Source: APXvYqxqCUJQ2O4mfHiED/0u+6XOo4LO/oE5DNO22lpkRYsECqAV/MzwdixmV8dPGearq2WpT0a5A8T7nQ8mRVD4pvI=
X-Received: by 2002:a19:22c4:: with SMTP id i187mr5204884lfi.152.1571228442275;
 Wed, 16 Oct 2019 05:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191013101742.1454364-1-jic23@kernel.org>
In-Reply-To: <20191013101742.1454364-1-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:20:29 +0200
Message-ID: <CACRpkdaW-UXaKcgWA0DpxF1QWhajDXwOYcZhUKztq9UY3mh5fA@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280 endian tidy ups
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 12:19 PM <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> There is a somewhat interesting mixture of be16 and le16 going on in
> this one function.  Changes here formalize that a little more.
>
> CHECK   drivers/iio/pressure/bmp280-core.c
> drivers/iio/pressure/bmp280-core.c:215:35: warning: cast to restricted __le16
> drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> drivers/iio/pressure/bmp280-core.c:237:37: warning: cast to restricted __le16
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
