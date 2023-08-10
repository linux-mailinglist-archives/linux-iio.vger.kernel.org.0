Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D72777379
	for <lists+linux-iio@lfdr.de>; Thu, 10 Aug 2023 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjHJI4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Aug 2023 04:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjHJI43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Aug 2023 04:56:29 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6172103
        for <linux-iio@vger.kernel.org>; Thu, 10 Aug 2023 01:56:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583d702129cso8652427b3.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Aug 2023 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691657788; x=1692262588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4xzhtgK2ZzvOYUDyqNSbtvklnaYEVyirCJgKwWKjKc=;
        b=r96+eZWbRyq6nfaVV7VksEHYdO4rbmkXKvs1TzZmcvoJqoo9rzhy4biR7Cah7jgdOo
         od5JiHxyra3MzW6c03d8sWhGe5I5u9R+IkSr1ce55lrsx+q8bMVHQWt5wLtep/NMzr6q
         Cf3sGJVKXJ63hdOBtPNTk3tgDtZV+R9rtq70IVXjIDDtDwWLfdU2cp/zdWJf6c+RVETx
         xvH2vUGFpmVLpLSmXb6LU2IE10mD16h5o06cfRo+a6VkiJfxI+f9GXy5mU1LbN1aIC4j
         DUgWbFv1QgGDsQdHXi7fsnjDH3JTojWshdIURjrDWHaKkyLuDH+WS1iLfXTR6qdSpIbk
         4lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657788; x=1692262588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4xzhtgK2ZzvOYUDyqNSbtvklnaYEVyirCJgKwWKjKc=;
        b=G3RmNwZIKIXB8sWI5znObj4UCwHv1Jp9G2VOKqNxtYm/6cz6uMbZgmwmJmN7UvM5X5
         qbzeulZpR0n/ytkX1L7N7K6f8D8KglK/nWrsPkC03PiiqQsTVBMg8UvMrdVlbiqQwmQI
         zVOvK9B7H4u3dQ4Wh5eDP1XJT/IbxTpHHE70XToLzwhKOmg7pxfqgJnRfAqEVQnPXqZ+
         k1WrXg+RYaUuWv3bNvW0vx0FB7lDWxR0GgCjdptRrkOuKjKocmvOJ8bKZaC4BcK/a6x9
         JEDUBsC/NpqGXJt9LixbTGabxDoBNRbn1rah42bMSkyUnBo2LkQ+k2mTxIM/Pu9O3buN
         amTA==
X-Gm-Message-State: AOJu0YyWUpXC/gm3mARgdEpid9J8oYhMvqHoWmihtCvHDNWmbX/7BfXe
        zsSEPjhXRxT0MIp4ZEoNxtZdfLM2cnwrulKCH9irWg==
X-Google-Smtp-Source: AGHT+IHLVKgLS+yA12n4e4oVR00qirPsOIQHxKivvEYUO3GDX4h6o1R1JjXDTABXln2G48Ua37dLjT4kf/I4MTOSdhU=
X-Received: by 2002:a25:76d0:0:b0:cef:e2c4:d366 with SMTP id
 r199-20020a2576d0000000b00cefe2c4d366mr2018376ybc.48.1691657788682; Thu, 10
 Aug 2023 01:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220524075448.140238-1-linus.walleij@linaro.org> <20230809134337.28224-1-bavishimithil@gmail.com>
In-Reply-To: <20230809134337.28224-1-bavishimithil@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:56:17 +0200
Message-ID: <CACRpkdah22hgM6VruErJedWM7apAuO7BGdFeSz4Hz0c2Nx3kjg@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Mighty <bavishimithil@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 9, 2023 at 3:48=E2=80=AFPM Mighty <bavishimithil@gmail.com> wro=
te:

> > The current code "mostly works" because we have not run into
> > systems supporting only raw but not scale or only scale but not
> > raw, and I doubt there are few using the rescaler on anything
> > such, but let's fix the logic.
>
> This does break the logic for twl6030/6032 boards as the seem to
> only have only raw and processed masks[1]. What would a probable
> solution for it be, to modify the twl gpadc to include scale+raw or just
> revert back to the OR?
>
> [1] https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030=
-gpadc.c#L808-L840

How does it break it?

It's a change to the AFE rescaler driver so it can't really "break"
twl6030-gpadc.

Isn't the complete picture involving some device tree using the prescaler
etc?

Can you try to dig out that so we can see the whole situation?

Yours,
Linus Walleij
