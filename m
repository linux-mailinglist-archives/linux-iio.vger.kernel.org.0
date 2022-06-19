Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A5550D83
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiFSXBD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 19:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiFSXBC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 19:01:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0368BDEB
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:01:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c13so8318186eds.10
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9i/+Rlge8FpKZhDpo3dAHxm9VwiEdyHtkurTkhCJlY=;
        b=Omg95uU9eW8my9kaESWyodB9Wejkk2CObU20Zxe+k3pJ259Eeep4g4WfqsCrcVH+Er
         1T5ZmsbicNBilHGIMxMX4Jp1hje5OThfQmcSFPdKPxaTIgoukwD+M8sE9htpGykMfd2r
         RzTG/soML7XZpr9uh5rZ1jqAQI/3aAwU+5GAxCg3FZlyWeFYBRYMwIE+cCXjZCW0pOeP
         EcFUJGfHdnAnmWSQhw/6IqIdRDZXhdaC1mq0DX8qB/EJiZiIT8+BPnUAlIrf8KzUnaHc
         chWsCWD9XINYerYU76iXD9OV+HXqI/+3zh95Ub246bCz/J642tDI0qun/xLEQBDd4QFy
         djWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9i/+Rlge8FpKZhDpo3dAHxm9VwiEdyHtkurTkhCJlY=;
        b=qfex0N9fmiI5jNKjwsOChiWfFYQK9kFkleYIDr261loMqzDD8EzFoPOH6doiY+VhUr
         pKmNpNE3Hxphlz+C0mZW90Wf7N4AoWTLlm2+1+auab6KejD6Xv+hpTyaWvTsbrpB2M/9
         miQvPe3xCfJSpJXwS2lde8p0/oFiAZzHiOH8MmbKtd3AdzEjEDWOIk23oU+HQUAmnpXj
         TLzjd9/XqcdoXWX8yMREhTL0c7KYFkqYZDjWWUTnYeE4x28oYzQHz72bCsfAt4a8JDCg
         RbgukjtKBcmB8gpPw6ayqOt1uXZHMAT4DlZrfVOki9HoW4lS7rkC0Em2FNW6MPU/mZw4
         7rjA==
X-Gm-Message-State: AJIora97p83TQ4Ebx/3LFsdNB6nPvzHiS6arfsPmGjKlzsLeq8br54lh
        l9DyA+1IKHQUfb5tczdiKf9vsqqdZ8keY0n24ZE=
X-Google-Smtp-Source: AGRyM1tdwMX2nzIP8+Ecpgc1xzgUaHIOCxnF2AAzktq0welLrABrjDO3T1nOajVBw90zWtvT7+OTK8GUppXSHQJrHdQ=
X-Received: by 2002:aa7:d29a:0:b0:435:705f:1319 with SMTP id
 w26-20020aa7d29a000000b00435705f1319mr10446558edq.54.1655679659606; Sun, 19
 Jun 2022 16:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org> <20220619185839.1363503-6-jic23@kernel.org>
In-Reply-To: <20220619185839.1363503-6-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 01:00:23 +0200
Message-ID: <CAHp75Vfp3rzi_NPHZ76CDC43X3Mpm=vthBw6Og9Ya=OjCEeAHQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] staging: iio: cdc: ad7746: Use local buffer for
 multi byte reads.
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

On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I2C does not require DMA safe buffers so there is no need to ensure
> the buffers are in their own cacheline. Hence simplify things by
> using a local variable instead of embedding the buffer in the chip
> info structure.

...

>                                                     sizeof(chip->data),
>                                                     chip->data);

How will these compile? Or am I missing something?

> -
>                 if (ret < 0)
>                         goto out;
>
> -               *val = get_unaligned_be24(chip->data) - 0x800000;
> +               *val = get_unaligned_be24(data) - 0x800000;

-- 
With Best Regards,
Andy Shevchenko
