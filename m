Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE24419FD4
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 22:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhI0ULi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbhI0ULh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 16:11:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59819C061575;
        Mon, 27 Sep 2021 13:09:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v18so38730528edc.11;
        Mon, 27 Sep 2021 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWCgs3XZtqQ75S4Sam0oUHvtow8EHQKNfWFQPQcnRsY=;
        b=CjCqPN4lsrmL/kgXYQ/RxflbFh56hSOKqIeyX1W/oIBfrq4g8nLspVD4sQMrn+40Rh
         Rx4viRYm7QpwSajB8/nS9I5EnOQAzL0pUBz4lQns538q/Qteac9sWhcfIIrmfsOSKzsU
         M/PAXh8x8DmXoA/RtTV/ChQhPTk8C8Id1hnlJcijflS84t+U/LfK3VqO+GuY2jbR/wSS
         Jeouq+xThsOnrcpcRddG2ODCpZRewj156How3JR4A1KMdpDZs7HuWvu3b5Y3uekBZh/f
         anAzLHdRSEeqsXP37MCrOfOLFAdqYOJXZV5OWmUogHnZBCe+LfWz2FGRBS/GFuXNmIlm
         9OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWCgs3XZtqQ75S4Sam0oUHvtow8EHQKNfWFQPQcnRsY=;
        b=UQpxaWpQs5jfXDlGKB1btQVWc28wYVXarxzaxtg32GTd8vsC/Kbx//jTXHymsZD7wZ
         zfIMFbP4T7bKaWfg6Eqccqg3GZ7h9DrVwEbI39UxoLdC+QlEMKlyXaZ4xu7tzznnXmlp
         BGwq7XT8R8OsxJsykn+0K5eD/U55eCpbqbRf/qZXqOE33rtGiOgLRYyAsF+80yauO+QD
         e27baglC0soiDMeEJxJcKXKvTUIEhstFd+twVDytkXP54EMrm0uxqenO0EMGVfzERXMh
         KnQfziuC6O/HU/rgSyHFX6jIKtgU/J1YckTUV1jO6iHsJfhtCX/T6cFz76beqOfdKVLM
         JRXA==
X-Gm-Message-State: AOAM531yRwsV0BG+bA4FdIvEGzl9RrNnmzpSxWN3slJxL2xxZSbeCGKw
        0illVw72TlpELzMjwlyKt0CIGSDls8VrTKbpvqQ=
X-Google-Smtp-Source: ABdhPJzCjvA/IcL6veR1cMq/hHfeR/9BjzJWC1sc8TXInJGO6uEWxkVIvtfeGVw/Xg4fYEEF9aI0SBlYG9XiAfkPmrs=
X-Received: by 2002:a17:906:f92:: with SMTP id q18mr2161486ejj.353.1632773397700;
 Mon, 27 Sep 2021 13:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210927081426.762-1-caihuoqing@baidu.com> <20210927081426.762-6-caihuoqing@baidu.com>
In-Reply-To: <20210927081426.762-6-caihuoqing@baidu.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Sep 2021 22:09:47 +0200
Message-ID: <CAFBinCAatVy_9abUJ7A6frbsOqDqAzVe9oDJODOS5MC7aCcDVg@mail.gmail.com>
Subject: Re: [PATCH 6/9] iio: adc: meson_saradc: Make use of the helper
 function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

first of all: thanks for this patch!

On Mon, Sep 27, 2021 at 10:15 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
[...]
> +       if (IS_ERR(priv->clkin))
> +               return dev_err_probe(&pdev->dev,
> +                                    PTR_ERR(priv->clkin),
Is there any specific reason why you put PTR_ERR() on a separate line?
it would still fit into the line above and be below the old 80 chars
per line limit.
For priv->vref you already have it the way I am suggesting there.

[...]
> +       if (IS_ERR(priv->core_clk))
> +               return dev_err_probe(&pdev->dev,
> +                                    PTR_ERR(priv->core_clk),
the same question as above applies here as well


Best regards,
Martin
