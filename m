Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472643EF319
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhHQUMY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQUMX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 16:12:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814EDC0613CF
        for <linux-iio@vger.kernel.org>; Tue, 17 Aug 2021 13:11:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p38so43852167lfa.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Aug 2021 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ECUnJRdGhvZQ5vTa9e0gW3gLFpsPXzyagk4LktRcpA=;
        b=DTYC3ua7EePGe9OrsXz3+MkXNeZUErzxrswujVRS1A4/P0Ri3b58vvLqpMBCkEL40Y
         yAcgAAeTGUl3HdER8NO7xg0ji5zrv9uIYE5cvhXecmAMOaUFMxC/XvxiNRyaRUulqKfc
         MwrTek+xPSuQUq5u3qQ8BQ1X/XlHeXk5vqa2acgT+w3FlIFi9XInUc1+LTKnMlCs2KrW
         41u1c55x2SjUzBf5emHA41ryOhhiZLpfqIgxNKwEo778gtRZm7Ks+qaUe4Ofzl4SzIzv
         eNpxJu4jj0muaxLoUuv4WWbbN82Fv8SERSVj+LSSnUA9c3JKafuLABoPe1WKHVIjY13l
         iIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ECUnJRdGhvZQ5vTa9e0gW3gLFpsPXzyagk4LktRcpA=;
        b=NR61gskjVDOw4oCUwAILZ4wZOlsj++nhu8y3B6/s7na7/w1Vn9fTa0MMc05p9MhSJx
         9tfg6+4wIrYw0nBYWZ11jmfYILrRL0oH2p3TYaXMVNRHKa7C7dxbOA2zNJMqxS9qbdfQ
         c/yiVCJSCWBIIWZqC7rw4d9EY3aHYdPoTn7vR1X7Cj946+4NkVm6BslDm6OpDcFyiPPl
         03bV5iT34zmggv/ncahephhiLGDjLLzbi1gyQVPODwMrAebhGvByWNomEgszHiPMhT+F
         bfu3Q0ykgkBOQ9Whae23B4Hkt6r+HAO7D4hQFZhS77UOlm5bf5SmKyPHba6hQdiHXBXj
         XkHQ==
X-Gm-Message-State: AOAM532MUp+nzrgZ4JWV0xDfK/l07+SVnK8HGYk5EMOMo/C3prXtPiEj
        af3gW1rToAji7/SU25qwmSgEQU/ZEZym8eWI5g7TfQ==
X-Google-Smtp-Source: ABdhPJxFwsBPGC+jBiacultIR42jboGDCaeK4IJ7HxVey6ekxIJCHv7HR8bP2YzM0B+ofhdgnZC6Be8jJqpMM39s550=
X-Received: by 2002:a05:6512:3250:: with SMTP id c16mr3551573lfr.465.1629231107903;
 Tue, 17 Aug 2021 13:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081330.9645-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210817081330.9645-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 22:11:36 +0200
Message-ID: <CACRpkdaemTruXS3PTz3z_hpkvBYvi802dF6VBDq+fLEyxZStrQ@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: remove dead config dependencies on INPUT_MPU3050
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 17, 2021 at 10:13 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit b1fe0cf06f92 ("Input: delete MPU3050 driver") deletes the superseded
> MPU3050 driver and its corresponding config INPUT_MPU3050.
>
> The dependencies on the superseding driver in ./drivers/iio/gyro/Kconfig
> to ensure that the two drivers are not built into the same kernel is a dead
> dependency and not required anymore.
>
> So, remove those config dependencies on INPUT_MPU3050 for MPU3050_I2C.
>
> This issue was detected with ./scripts/checkkconfigsymbols.py.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Oops my leftover.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
