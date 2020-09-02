Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891F425B383
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIBSNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 14:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSNw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 14:13:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57118C061244;
        Wed,  2 Sep 2020 11:13:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j11so125023plk.9;
        Wed, 02 Sep 2020 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iz9IwyNAPHOdvHV+qKdwdXbfIBOQcrl01GVTHqaFy8Y=;
        b=slBjyMf9lA2UMcRZNGjoNklbTtn6nWoC3yN7gMube3mAbWTAtnlQNuvDstGSZoNlpP
         DxOS/g6r0/vte0sg9tyZBPMG008lDq+w+uZR0Ke1GQNYhBsTlyq2Go6VvGjsXC7pVhN1
         F2iSgEiUHxweBGEsfRLW2FsJDGEYLlKebIIFtZJylasF2hANcBNmmIEJFOxBeMMIJUBA
         3Vczr1PzayXbGHMnHzfawdWQ36oCBimV61R3xGkMGWDOv2xsgqU794UDNEQpolDQWX3Y
         9nsXPZAJyogmwFZFMUqVYsGKgzKv29taejmb8QjSII6YC3KUIthKtF+uWTETYhW1KDce
         99mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iz9IwyNAPHOdvHV+qKdwdXbfIBOQcrl01GVTHqaFy8Y=;
        b=VcJIibaKO/r5u9Hmq6rGrXVLTiw7CP/JSD3xDvvB++H7QlLTnlYQbxxMmYoDzgjIs1
         dP4f+IAlCP88nmvH72PfMBfS1KzImg9wmvcWKvDLvrBXvCRL1lbayVXGNr9XruEjwB1X
         MEshg4yN79e3m37KiGB/4GB4yc5gwcdRcQhKag7xRErAUYfFgxwWNr7omrFO3wAAjkjJ
         0XQWzoViFfa80s9aayNdLPHzQqng4quO2BmBiMFtf0Cm6kQZ5QvhB05YyN81TUtUTjvz
         chDNAFzjuh0/OJsLmRwN684b8G1gAiU80hU0cpO99X6IfGVCqgKB5a6jg90uCw1gJ0M9
         OOfg==
X-Gm-Message-State: AOAM532RgCgImC5usMw8bgKdfNCDdA7mBe2BNGikMVIXXb3kxGLUcyxP
        b67sIEfzAcqqKO8K97z5LMmR8BlAd9HV0Ncjbc4=
X-Google-Smtp-Source: ABdhPJziHGmyiFn4xCNoJgII4iCOfoLaLXiyMWQnYUeyVlB7eIb4cXtUUg7Ymi6n4SAu7Gutm22N4htGSAQE+oGCQzE=
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr3055894plo.129.1599070431881;
 Wed, 02 Sep 2020 11:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200902145957.13861-1-krzk@kernel.org> <20200902145957.13861-2-krzk@kernel.org>
In-Reply-To: <20200902145957.13861-2-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 21:13:33 +0300
Message-ID: <CAHp75VeDqd1fiXVgcZXei2vLJrR4067o0E8wgqUbDio4sKvS7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Move Hartmut Knaack to Credits
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 2, 2020 at 6:01 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hartmut Knaack was an active reviewer and contributor to the IIO
> subsystem and drivers.  However his last message on LKML is from
> October 2015.
>
> In thanks for Hartmut's effort, move him name to the Credits.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Fix order in CREDITS
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/CREDITS b/CREDITS
> index 32ee70a7562e..c741455498a4 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1942,6 +1942,10 @@ S: Post Office Box 611311
>  S: San Jose, California 95161-1311
>  S: USA
>
> +N: Hartmut Knaack
> +E: knaack.h@gmx.de
> +D: IIO subsystem and drivers
> +
>  N: Thorsten Knabe
>  E: Thorsten Knabe <tek@rbg.informatik.tu-darmstadt.de>
>  E: Thorsten Knabe <tek01@hrzpub.tu-darmstadt.de>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index facffcf7b1d1..94dda8ae202c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8489,7 +8489,6 @@ F:        drivers/iio/multiplexer/iio-mux.c
>
>  IIO SUBSYSTEM AND DRIVERS
>  M:     Jonathan Cameron <jic23@kernel.org>
> -R:     Hartmut Knaack <knaack.h@gmx.de>
>  R:     Lars-Peter Clausen <lars@metafoo.de>
>  R:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>  L:     linux-iio@vger.kernel.org
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
