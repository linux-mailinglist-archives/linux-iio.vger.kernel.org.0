Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E123482255
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhLaFtS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFtR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:49:17 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED5C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:17 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p65so31918714iof.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nq39ADJitqN2qQkSjjGOWalNzpI5UcRydAd9ZEherYE=;
        b=g+4ezeM7Gp1C2gdx11vsxvCypbtSjUY3NIJAs9DzAkpPGZ8XI/0wkUYqZsYzffg4FX
         /U+ehYLTlzq/KTr2s4eKgkvdAGxb7rpZqRwK75fqR3qPNSRB6rCDLU1jSXJbjj2n/F6i
         wse02nCT0lJPSQXU+GNA5fY6WtSY0M+tAsclQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq39ADJitqN2qQkSjjGOWalNzpI5UcRydAd9ZEherYE=;
        b=AHk86Qw1zn1SXdSstqHx5WiNbwO6ZhyE921jA2zFM3tnJLgpPU7nDRRjXCn7b6pNl8
         lLY9TW9gGNDVrTFMuOQNKl7NatRJpQQorqkkUz5pA+0rDuJ00ISy/omETd5aaPC9pVoo
         +PZUXGyGjQG7yzYKdOblK1W6ezVl0Y3eXiWLkMOK4wI6wOSRX6zSyBPRJ4f66zs71Cly
         lEtcW58Jwvi1wXmhOm8KSXd7nKPZy6joL1Iywc4M0YjUa+OYeXZnolevsDiJKNLxo5t0
         bDNGqytTtO3mM+VPET7vjZlPZ5fE6DGFvC/x/ndsyPJtBTQnrMqJJDCiXvBM4mk+3EEF
         KTew==
X-Gm-Message-State: AOAM531oMbVA4h2L2tqdCoLUnC9fk1lnjk0sMoc/2Yds/mAFRKqHCS5P
        Bui/4Avd4rjZPj+g4s+MMm3XYdpXB0tqHLnVp6JVHG7iEPzHig==
X-Google-Smtp-Source: ABdhPJyrlWfCSZlHGELbtwwQLmgMK/e3Ulta+ux+SGjSxltafUOPR+hjWw/yaRWjYxi7rsf4lyb0XQHxm9uxaWU6vTE=
X-Received: by 2002:a02:ba8b:: with SMTP id g11mr14813329jao.20.1640929757035;
 Thu, 30 Dec 2021 21:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-10-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-10-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:49:05 -0800
Message-ID: <CAPUE2uuy47iTn_XN-eAFV_pQQsQajr4H0JDANtMLAMyeOjJpFw@mail.gmail.com>
Subject: Re: [PATCH 09/16] iio:proximity:srf08: White space cleanup of spacing
 around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The spacing in this driver was inconsistent with a space after the {
> but not before the }.  Tidy this up to avoid providing a bad example
> to copy into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/proximity/srf08.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index 9b0886760f76..ac1ab7e89d4e 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -528,9 +528,9 @@ static int srf08_probe(struct i2c_client *client,
>  }
>
>  static const struct of_device_id of_srf08_match[] = {
> -       { .compatible = "devantech,srf02", (void *)SRF02},
> -       { .compatible = "devantech,srf08", (void *)SRF08},
> -       { .compatible = "devantech,srf10", (void *)SRF10},
> +       { .compatible = "devantech,srf02", (void *)SRF02 },
> +       { .compatible = "devantech,srf08", (void *)SRF08 },
> +       { .compatible = "devantech,srf10", (void *)SRF10 },
>         {},
>  };
>
> --
> 2.34.1
>
