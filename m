Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC4462910
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 01:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhK3A1h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Nov 2021 19:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhK3A1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Nov 2021 19:27:36 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E330C061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Nov 2021 16:24:18 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t19so37925121oij.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Nov 2021 16:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgXAtJ5iirqkOnQV6iMk7FlkZwmbQg2a/CfOXDmURbc=;
        b=awRwpKfKfQhvGQbS+Qthr00oL2sVUMHj/Yb5LdgwtligGzn1drJi+b22qE0nBo600j
         oZZQgppgbc+DOxQ+GrgPLxyjUrwYrWQwmAgOqV8jUOlJokqUk7c0B5FmXQUNXBk4G3Uu
         cyrIflugjduMmi6SJV4XaxBMpvgt+LyEC/tFY/l3D0Y0K5z8D7SHITcxUA5odJ0gOrua
         tl924uSyfGKcs0HcfxxxvW6hsHk6zZ4sW0qQ5qrzRo1oCYljUOJnFDkn5Xbph4unlzn+
         d+2XsEUAyWnRSJaEJuZa7Nvaq4hvFFxwrCeatxBZqBNXMNSNeFHaZo7zwxEH3F7pH4Mf
         PXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgXAtJ5iirqkOnQV6iMk7FlkZwmbQg2a/CfOXDmURbc=;
        b=sPuHrCEUtz2MZ8iXheZ76SEF3B0d3sLNkOkZOpXk8eUEt41o7cRnOwu5K0No4xgeQB
         SDq/udU/4JOME20o12VyXjfNMuNPXaAcBAnLvEIJHcrA8FypfASvK3XglBkQ+2dXZwJu
         HDn+oCEdvunE6Nr96IOxuMyeODEMNhthwRHZscyjw/C96gWWwHJ9PrAO7RGzrkxGPVms
         iFsqFj9IszfVw1fkpEp84GCRts2uvB6j0206azwxfd3Qr4rGjnksIiyRSrCIy6XmofY+
         9jv1yp5Cba6s5MCNxpW7V3doZ9EhRuSye+6T0tfQRrHqPInY9eKKDOsAZ9iWa4264e3W
         m4vw==
X-Gm-Message-State: AOAM532+CruO/Cuql/wxTyY0shTN2SKk8YlTTEEo2Am1nd9LqrNWmvDH
        1SaSocGLyLsa8CpZRQywHI+XxGqpIxrd+oIZQ5o3S3ftFxk=
X-Google-Smtp-Source: ABdhPJwz/c5JFx/ObeZ3MEl3fu5jE1yHt2k5gMyL+nzYejjq4GyrFqizAK8T7/zfbs7v0EIykVuhASG+SNpBupxB62k=
X-Received: by 2002:a54:4791:: with SMTP id o17mr1311885oic.114.1638231857759;
 Mon, 29 Nov 2021 16:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20211128192635.2724359-1-jic23@kernel.org> <20211128192635.2724359-7-jic23@kernel.org>
In-Reply-To: <20211128192635.2724359-7-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Nov 2021 01:24:06 +0100
Message-ID: <CACRpkda4qWHjgwinuq4j4ymHu-E+b0N9vCh4rAAKH==8iobEeA@mail.gmail.com>
Subject: Re: [PATCH 06/12] iio:light:cm3605: Switch to generic firmware properties.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 28, 2021 at 8:21 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This enables use of other firmware types with minimal driver changes.
> Part of an ongoing effort to move all IIO drivers over to generic
> accessors in order to reduce the chance of of_* versions being
> copied into new drivers.  Also updated the headers to reflect this change
> including using mod_devicetable.h for struct of_device_id definition
> rather than going via of.h
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
