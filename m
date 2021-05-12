Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2BF37D366
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbhELSVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346783AbhELRVk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:21:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A482C061347;
        Wed, 12 May 2021 10:20:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v191so18995763pfc.8;
        Wed, 12 May 2021 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mRM7q1w9KEfWo7XLMCrlXg4WbYJ598DsMPCReIKFcI=;
        b=NNxJOC23SFvUX3yQW92nyLFzLFHNPZr8wDnfRRzMSlqB2XWlW6gkv9Pgwv1joc/odL
         kZUSxA62ue/klNVU1liSmFbMBwJyzDwt86W1jUoMTLxjwfQxWO8hCSlzWrYERHAfmD0S
         HgUnaOJWhGXY+4JXADcXpKI9iJCWYvKgwLcFQsBjh8yIKYDK2scSHFKXs2xGOvsCzcQd
         uiOGUIgi+lyiMA8uK7nuZXyxhRDdUOBTBQEBCTfnAEz7pAlfr7ANsPBg43I4VCHqGh6Z
         bbulzkuoffV1gybJb8q00vrxEt7M46JwL5cD9pxAWd6bAtom880pBUVmOcX28MNfRe2A
         MfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mRM7q1w9KEfWo7XLMCrlXg4WbYJ598DsMPCReIKFcI=;
        b=mFATqLwBsL7RH7yhhIVJT30DMNtNARQzmibIcx6iluCGVxgnMJSxHrO98Pm2ethLKr
         y2K5sVVvtjm1tfiim3T6rhMVx8cAa1oPgASLsuPAAa756Yprv2KZ3xXhO7H4/OGs1m8X
         ENw3Sbo2Jp68WlOiCgZbzCxfXuDI1YfDusImSxzkllb1HJ1TwyW1sruYdJc/XCtHULM8
         sASupd3dfrAxhmLXkBPbBxJIp0nz2qmm6i0rJAvcMg/7DMzJViZdqSvAQBBHBHjudoWB
         bmugCZvOotIAXQRp1t0lG+e0UqHOQRVRSsWpyT/V5m++6r3WmKHWsoDOYUvgKb7xXnqa
         BSWw==
X-Gm-Message-State: AOAM533EnNJQE//Hr9IrjYvDrUQXxz1FKJ/HMlSIZl0ttmJiwbEVAwzy
        pygjUiC+MevIiQLU3VJjWCArQM4MsDnpWjQcq2o=
X-Google-Smtp-Source: ABdhPJxDVWM6VC96SX/FrY4PNncdkd0pABiXC4DaOTQwHYXX7VS6NITQsa75eGgDVq4vOcFjWpkRADT1tlGm2bYJnSI=
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id
 s4-20020a056a0008c4b02902b48334ed4dmr22170660pfu.36.1620840013879; Wed, 12
 May 2021 10:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620766020.git.lucas.p.stankus@gmail.com> <09e65d3a235febfc4c3ee172b573ba8c9cde94b8.1620766020.git.lucas.p.stankus@gmail.com>
In-Reply-To: <09e65d3a235febfc4c3ee172b573ba8c9cde94b8.1620766020.git.lucas.p.stankus@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 12 May 2021 20:20:02 +0300
Message-ID: <CA+U=DsptfNDut3984MJkKckgWBhNd_0p17RfpidEXwYhMRfxtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: iio: cdc: ad7746: avoid overwrite of num_channels
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 11, 2021 at 11:55 PM Lucas Stankus
<lucas.p.stankus@gmail.com> wrote:
>
> AD7745 devices don't have the CIN2 pins and therefore can't handle related
> channels. Forcing the number of AD7746 channels may lead to enabling more
> channels than what the hardware actually supports.
> Avoid num_channels being overwritten after first assignment.
>
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index e03d010b2f4c..9e0da43b2871 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -693,7 +693,6 @@ static int ad7746_probe(struct i2c_client *client,
>                 indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
>         else
>                 indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
> -       indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);

ohh; good catch

this falls into the category of a fix, so a Fixes tag is required;
this looks so old, that i did not bother tracking it before
83e416f458d53  [which is 2011]

so, maybe something like:

Fixes: 83e416f458d53 ("staging: iio: adc: Replace, rewrite ad7745 from
scratch.")

>         indio_dev->modes = INDIO_DIRECT_MODE;
>
>         if (pdata) {
> --
> 2.31.1
>
