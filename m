Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56D144AC32
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhKILEC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 06:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhKILEB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 06:04:01 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206DC061764
        for <linux-iio@vger.kernel.org>; Tue,  9 Nov 2021 03:01:15 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so14252576otm.10
        for <linux-iio@vger.kernel.org>; Tue, 09 Nov 2021 03:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/4WrYjMlWS6GMpdX0XkH/Y8D/jstg0/u8wiXMqkgFs=;
        b=so6xBZKAjC5rTTAwlxdNauvxWQKSJsSmaiVKZoCn7gEkCVVhLMG+avIOvIqTEeRuRb
         lBnYxvprv7uBLPCq5HJcnY+Vld3UjvQhkv5noeUGWeCBB9kDpchVL+3RKpP9bEFPAAUF
         aFEcz6oeWnSjDq/8SSglGntTEw9zfR9kBgWI1+yV9ZZ4GdhPucJamGDvjUZmRVF0Hw23
         0NGJzAzV6rPRdzg0OIJ2KaF2C42sYSsh7QR2b8ayHSZzROuL9B1B9vQFuZcoK7iLIoIw
         O1Vil0H5LYFSCRiZs8ZcDsw4RgG/i8LZK2u7pDz2fzhJigHxEGiPiymEyXbrN1xPvQ3y
         /WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/4WrYjMlWS6GMpdX0XkH/Y8D/jstg0/u8wiXMqkgFs=;
        b=GyIe0YhjHAbTkeOUygWjIqmxSdEJjcwcLRtTFnSADRmHmJK4dWD7cBhTMae1PbLqxH
         CCkwADIJrkdXIApKv79iP3yrmJrAwMLgTV1TUeBhzkiRHqYCgZMbNkxKjEDN9rCfoRW4
         k5CQmOI4Ohyy9HyJCIlEkyYI9yqmFDFbLa1VMLrnXWRK/jZI7wr/GRv6iI9RzjsWCjAa
         KAgdm3NCUJWAh5j7u8MtqXMxxOVyqrA9wWIcA2TgUA2ztRxXEQNoS8Mhusjab/7GneHt
         LDnY13MVzLubenT4X/q+dAjq/2saDslkG4wqMm3mxpemXk5z+xdQoarSIG52tmrs3Kp3
         HJQw==
X-Gm-Message-State: AOAM530zVsrml1xVRH3RkTLI9ACgThVWejJeZwG/mvsBDOAXBKjpbvUx
        MgW+p8qVHFKFR17sT2M/S66hJL3sIgP8vmckdOrFzw==
X-Google-Smtp-Source: ABdhPJwnTlISQB6ie1HJI316BheQEVEVG+Ush+PsnMarcrRRROjmUG4S1wXnFN8UPupF2z4IZzkCb6F4M78TH7rYQgQ=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5214405otk.179.1636455675112;
 Tue, 09 Nov 2021 03:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20211031142130.20791-1-lars@metafoo.de> <20211031142130.20791-8-lars@metafoo.de>
In-Reply-To: <20211031142130.20791-8-lars@metafoo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:01:03 +0100
Message-ID: <CACRpkdZxDNK6H82b6J-0muCGRGK4w9A5FH9_OgRTTzWy6AaOJQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] iio: gp2ap020a00f: Remove no-op trigger ops
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 31, 2021 at 3:21 PM Lars-Peter Clausen <lars@metafoo.de> wrote:

> The IIO core handles a trigger ops with all NULL callbacks the
> same as if the trigger ops itself was NULL.
>
> Remove the empty trigger ops from the interrupt trigger driver to slightly
> reduce the boilerplate code. Object size of the driver module is also
> slightly reduced.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
