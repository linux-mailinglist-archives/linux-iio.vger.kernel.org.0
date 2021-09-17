Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498C140F38E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 09:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhIQHyg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhIQHyf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 03:54:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71393C061574;
        Fri, 17 Sep 2021 00:53:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso3037914pjb.0;
        Fri, 17 Sep 2021 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gO1U8AUjgpmV1EYHhy2AO9VWPgj+9s9+ohJzBuwbZhg=;
        b=Bb9Xm8hW0IiL+8Juw169c8cKnfNr1bI9EOi/6Xc6dMMPnHla4nldpz3WokTLGf5JJe
         Q9Op+Wx5vUGh8VWOGbHpo06cYR5KRRPphkho/r4Uu8f6kwbewPrujRm4c29bw2/dEppO
         8dIjfRl+HOBP6Khoie6Q8a3HtaYBZRQ3SWid6K3xT7Vvs5RCh38GZXvU0YG8wB8NBv0Y
         yrjtOPcMC/x+TvzOXCkH2uHc0Q0OGO+3ntwGJsa8LCu9a7yvBbjJDUlpz7HDQ6yY92aE
         +/PBIJd904mwbQ5FoZ1kL/DbsM9CggDkINFE/O/9lNOUYlVsd8CuqecD9XudaOciXAu6
         8tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gO1U8AUjgpmV1EYHhy2AO9VWPgj+9s9+ohJzBuwbZhg=;
        b=2UUbDJzQcuRcRgpfyvk5D8LCYtV+HyI3XtIp7yZXN8fdwo6wAiInQihanyDngkwQfS
         UDYb2melfUs2ryy9BUvz7tPhK8x4STazPGaLbkRilQNKXm8b0qAHtZvOjr3i2hRDghKn
         6jQYM+z6464gzwuUkYuT/+hEAgKxkc3lB7k1XCZQapZ2/PtVHMQS4pvtOj+qGjNTE0d4
         WULXrmoYqcGH1OmevtjRUj6QzagY2ExkqFObbwzFdROrJ85iuyIQT9V7ookv2YkwvtLk
         Pu1jw3AL3h/KjRJhDw4dgU1U4eToiRR1VQSDt/cNZi+v9hPkMtNrTpO3yvpbEqrJFLPB
         jUjA==
X-Gm-Message-State: AOAM533zmVdc2WZ6dgCT3O6BuB62JDm3tCEOz7dhMm4ehC+jMDQiIudZ
        ISQg9HTphpWSI9/sLsegpg4gnQRl2jPbw0XMYvw=
X-Google-Smtp-Source: ABdhPJxy7WBzPTwkG+2fxhkzEiNokggqo3ZApUQ/9ai1WZi7gHLtf1UZls2NOqnySpsTmlzKBNDzOO25bVGj7dXs3YE=
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr11077171pjl.150.1631865193933;
 Fri, 17 Sep 2021 00:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210916182914.1810-1-mihail.chindris@analog.com> <20210916182914.1810-6-mihail.chindris@analog.com>
In-Reply-To: <20210916182914.1810-6-mihail.chindris@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 17 Sep 2021 10:53:02 +0300
Message-ID: <CA+U=Dsp+p+s9sv1jGh0QPMvoyGtqZn11p+Wtrm-NOKSFWt7AZg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] Documentation:devicetree:bindings:iio:dac: Fix val
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 17, 2021 at 9:08 AM Mihail Chindris
<mihail.chindris@analog.com> wrote:
>
> A correct value for output-range-microvolts is -5 to 5 Volts
> not -5 to 5 milivolts
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> index d5c54813ce87..a8f7720d1e3e 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> @@ -54,7 +54,7 @@ examples:
>
>            ad5766@0 {
>                compatible = "adi,ad5766";
> -              output-range-microvolts = <(-5000) 5000>;
> +              output-range-microvolts = <(-5000000) 5000000>;
>                reg = <0>;
>                spi-cpol;
>                spi-max-frequency = <1000000>;
> --
> 2.27.0
>
