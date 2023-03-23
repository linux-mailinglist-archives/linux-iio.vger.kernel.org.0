Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE606C615C
	for <lists+linux-iio@lfdr.de>; Thu, 23 Mar 2023 09:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCWILw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Mar 2023 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCWILv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2023 04:11:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C259F4
        for <linux-iio@vger.kernel.org>; Thu, 23 Mar 2023 01:11:50 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p204so12717683ybc.12
        for <linux-iio@vger.kernel.org>; Thu, 23 Mar 2023 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679559110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1fhnGMLi8Wn3XPsLDvfzhNl6+rCk5aMOMyjCfNvXAs=;
        b=X1vOPlKQ+BpBk4ICl7aYfFuFNiNo57iTs6FTX6A0rlLZb68UV5UxUWjHDyiAiX96AF
         QU19ciZ9/obzizY0bnvn9lfCs+mzNKvy8FtS+6WMoTvESWrB36ZO4VYregwMc5RQBnmJ
         TKabCW9wgNNWrdCYUV8C1g6TziW+Y9LmUbrR2GD8wsUCqubIr1ztt/epPAtJxwsqpfkT
         cuhsE39U+pKwriAgcUThGhLLUIBC61NB8iijxx1JpLzNZWdtwe1TItESjy2hmJlM7d82
         r9u5zso57rOSBQsdsmCxz+TsOHexcvgRB5XkvvBJGng1CRkereRZJXNEo9eB7ljTW+NR
         vhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1fhnGMLi8Wn3XPsLDvfzhNl6+rCk5aMOMyjCfNvXAs=;
        b=U+jy/ZrU6Yyfft0BLzclOtZ/HXttUNJV74/zMyiVu0z+dZztc64MMzeix1Ja6Lqs9B
         aGbgCulRRqSnoNH96hYTR2A3QllKG3fUWk/pGKa6q4WZ1BpXoddVCci9IvgKPd1jBi73
         XlcOybH1TSerwrCX6lol4lvFV5jJOfS/7gIQgDmqDiWuncxTy9KUENnxmwEvoXmuL7Ls
         so+pzqtzrA7zgg7VYJ1h1+tQxfcoJOgu0WuaxAN7MthnjoPLGyDpIJkPclhRgcDJpYJQ
         HUVqRewd4lXRYgztr7xCgSsvenLkj8auHSGEQ1x8A3zJ96iXESFqQLXgl2K4pC549VSm
         cVOg==
X-Gm-Message-State: AAQBX9e024XnfyRUka4BRMl6sOk7kPAL7CYACHxzAD/e8orApaAZ90IK
        hfPMhXwS9IOhEZdEvglNJRiWagW4FD3vzIsg+LIajA==
X-Google-Smtp-Source: AKy350Zp02dCuLcHDwS9uTZzFqTJEjUYzEoj4gXR6Bv2ntsac5aI2DmyaelR9XzBhgoIUyzLuMrlrZjOjDnVod/pVGE=
X-Received: by 2002:a25:6b0e:0:b0:a27:3ecc:ffe7 with SMTP id
 g14-20020a256b0e000000b00a273eccffe7mr1395899ybc.3.1679559109815; Thu, 23 Mar
 2023 01:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <02034937-12e2-44f5-8311-10d960dc7dc4@kili.mountain>
In-Reply-To: <02034937-12e2-44f5-8311-10d960dc7dc4@kili.mountain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2023 09:11:37 +0100
Message-ID: <CACRpkdaiFkgEmbfUHmmr8J6afcr-W4ngtcVUwbAZn+KsumG+pg@mail.gmail.com>
Subject: Re: [bug report] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 22, 2023 at 10:09=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:

> [ No idea why this warning is showing up after 6 years. -dan ]

:D

> This is a semi-automatic email about new static checker warnings.
>
> The patch 63c3ecd946d4: "iio: adc: add a driver for Qualcomm PM8xxx
> HK/XOADC" from Apr 4, 2017, leads to the following Smatch complaint:
>
>     drivers/iio/adc/qcom-pm8xxx-xoadc.c:769 pm8xxx_xoadc_parse_channel()
>     error: we previously assumed 'hwchan' could be null (see line 761)
>
> drivers/iio/adc/qcom-pm8xxx-xoadc.c
>    760          hwchan =3D &hw_channels[0];
>
> Here the hw_channels is variant->channels so it potentially is NULL
> (maybe?  I don't know the context very well).
>
>    761          while (hwchan && hwchan->datasheet_name) {
>                        ^^^^^^
> Check for NULL.

Actually there was a patch for this last week:
https://lore.kernel.org/linux-iio/20230314193709.15208-1-xhxgldhlpfy@gmail.=
com/

It seems the other static checker also found it now...

Yours,
Linus Walleij
