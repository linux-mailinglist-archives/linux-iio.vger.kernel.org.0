Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7443A55C800
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345377AbiF1MTm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiF1MTl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 08:19:41 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0452A411
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:19:40 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p136so15693947ybg.4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKt22ivsvisAp0Ppii7NDDpofgjpmk/aYUMdFg5g1+M=;
        b=XEznpu6Kdxr4ngikMBVCPcx0YefTzMSLd54kiYQyLG2mKQnOjz6U300NZ8/Rm7d0yD
         oaehMMKN8KpK18oL9SsUwANKiisfJMPegqEkBVO9F8bVdGrD9tFfDBrDteKEH1XdCSk+
         8OYL5N18TBjX44/2+J5LPfsBAAfoHqCnnMi2WB1GPOLbd+KMR2Jrefsu3tGAMGRFLGfh
         jVd70Cn+fLzScrJteD9hxHxVrLQN7DMqWp1baxV3o8SO4Y4baCJWEVkqK2PozhGOmY+d
         ERFeVnGDV2i2cD5QME50Hr6yj6IhreIkfpl88tDY/Aqk5wSPUmkmlJmVBe//mzTLUfPK
         eS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKt22ivsvisAp0Ppii7NDDpofgjpmk/aYUMdFg5g1+M=;
        b=jgzPRhs+beqyFduaOpb8acj75cKoAB0g13kNLps1OmZmb5y7RvVdrKXVx+DS573lgi
         DK7MENWFEIZ7NZfBath5ysKUZe9/K45xDGKqQbRkllBXh4BQcF8JkUVpPr/Djm4IWMO+
         ay0yTZr6PtcBZIL5oXpEQ1wyFQt7qul3WJtFu9nzFqVLe4DvSlddIYbhSWCAhHgavWW1
         s9v3gigIc24UyxklctcmUNeSJNqPNIdt+a6OlIfTPz8BatciwWYCKLRK2BpOFR0VnFg4
         S5b9pEJmwA2FTDX2tIS/UM1CF2kqepn8owZvw2KCMxm/OkhcAQJsQOZxYJPlfHtg15ND
         EXvQ==
X-Gm-Message-State: AJIora+SH+slHAAehCXHl1fxqlf1PlM1bgsz25uMlZavlW9XOXQJuWbF
        MN7lWnkKc5QzUEKTTIicSJh5DggXeEIOizjOd4c=
X-Google-Smtp-Source: AGRyM1uj+E0SK0m9Ce78CfernihfGaVBDCX8Js92sVOYXPneQRQ1e/Kbp/i22ztktFeTtl/Yn3jIYUsx27Y++mLXJ5Y=
X-Received: by 2002:a05:6902:1142:b0:669:651:1bd4 with SMTP id
 p2-20020a056902114200b0066906511bd4mr19218116ybu.385.1656418779686; Tue, 28
 Jun 2022 05:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220626122938.582107-1-jic23@kernel.org> <20220626122938.582107-16-jic23@kernel.org>
In-Reply-To: <20220626122938.582107-16-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 14:19:01 +0200
Message-ID: <CAHp75Vf7FwBVKdeW8vubJf_0d-Ypp+Sx5B8=2c=LQaKpnwK65w@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] iio: cdc: ad7746: Add device specific ABI documentation.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 26, 2022 at 2:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The datasheet description of offset calibration is complex, so for that
> on just refer the reader to the device datasheet.

...

> +What:          /sys/.../iio:deviceX/in_capacitableY_calibbias_calibration
> +What:          /sys/.../iio:deviceX/in_capacitableY_calibscale_calibration
> +KernelVersion: 5.19

5.20 ?

> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Write 1 to trigger a calibration of the calibbias or
> +               calibscale. For calibscale, a fullscale capacitance should

full scale

> +               be connected to the capacitance input and a
> +               calibscale_calibration then started.  For calibbias see
> +               the device datasheet section on "capacitive system offset
> +               calibration".


-- 
With Best Regards,
Andy Shevchenko
