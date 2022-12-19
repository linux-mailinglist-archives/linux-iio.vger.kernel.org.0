Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5E6508A7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Dec 2022 09:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiLSIk1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Dec 2022 03:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiLSIkY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2022 03:40:24 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF8BA1AB;
        Mon, 19 Dec 2022 00:40:23 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id g7so7699009qts.1;
        Mon, 19 Dec 2022 00:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Whf9ddK2ntCTSLjvmk1zPOl1fs77bjB0k2GN9PCv9e4=;
        b=e75xWEyQOfOrx68GnAsjKfCG8bQqbVrciyv8TBzza47uHVgF3ZsaHUSHeZUn3LuPh0
         wAuwBvMiyqX3lehxRNPoAuV4HaAbKNeUbal8KgxmBQqWNJbTD53HeUY3FKQnDWO6noZQ
         IvLIf8MoOsdoSK+uAOhsXFTnoZGwri9gszefdZoVd7hF5QnRjU3wI5nKdBnwoJ4cw5pS
         lqBayJS2SUc/l/6Mz/51K4ysP7FU1hXDPHTqY0qmh2FVyfWW+HNn8xlYJVyoCUqdPB3r
         4OVONintn/EXZQY5ryJoYHsFKCrQ4SwksRxHgHZfTrX8AqpyELG78+ra5JYLj5G33I4H
         jHkA==
X-Gm-Message-State: ANoB5pkVCiDv+gd8qno4R9dHI87OB8yb7I9uegJFI0Fx6a0q6RVhZPL4
        JECRfGsE0Zh4Yiyn4kdvyjP5Rs7aNLKajQ==
X-Google-Smtp-Source: AA0mqf58hsR4iZ+P8qGvBv/BgwgEO2HX7li4H532GnhXZ8uwXWZcHrAa2v05knply6Vr+M6A2RvNJw==
X-Received: by 2002:ac8:6887:0:b0:3a5:10c3:13ff with SMTP id m7-20020ac86887000000b003a510c313ffmr50856643qtq.48.1671439222060;
        Mon, 19 Dec 2022 00:40:22 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id q21-20020ac84515000000b003a7f3c4dcdfsm5641135qtn.47.2022.12.19.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 00:40:21 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 192so8667262ybt.6;
        Mon, 19 Dec 2022 00:40:21 -0800 (PST)
X-Received: by 2002:a25:7104:0:b0:702:90b4:2e24 with SMTP id
 m4-20020a257104000000b0070290b42e24mr14806510ybc.365.1671439221181; Mon, 19
 Dec 2022 00:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20221216205028.340795-1-biju.das.jz@bp.renesas.com> <20221216205028.340795-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221216205028.340795-5-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Dec 2022 09:40:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXLqgWLb5B7=Orf6aMtcaXgejftHbOZAmg_yDX6QkCjnA@mail.gmail.com>
Message-ID: <CAMuHMdXLqgWLb5B7=Orf6aMtcaXgejftHbOZAmg_yDX6QkCjnA@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
To:     biju.das.jz@bp.renesas.com
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Fri, Dec 16, 2022 at 9:50 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add RZ/G2L MTU3a counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
>
> This patch adds 3 counter value channels.
>         count0: 16-bit phase counter value channel on MTU1
>         count1: 16-bit phase counter value channel on MTU2
>         count2: 32-bit phase counter value channel by cascading
>                 MTU1 and MTU2 channels.
>
> The external input phase clock pin for the counter value channels
> are as follows:
>         count0: "MTCLKA-MTCLKB"
>         count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
>         count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
>
> Use the sysfs variable "external_input_phase_clock_select" to select the
> external input phase clock pin and "cascade_counts_enable" to enable/
> disable cascading of channels.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v9->v10:

Thanks for the update!

> --- /dev/null
> +++ b/drivers/counter/rz-mtu3-cnt.c

> +static int rz_mtu3_count_read(struct counter_device *counter,
> +                             struct counter_count *count, u64 *val)
> +{
> +       struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
> +       struct rz_mtu3_cnt *const priv = counter_priv(counter);
> +
> +       mutex_lock(&priv->lock);
> +       if (ch->is_busy && !priv->count_is_enabled[count->id]) {
> +               mutex_unlock(&priv->lock);
> +               return -EINVAL;
> +       }
> +
> +       if (rz_mtu3_is_counter_invalid(counter, count->id)) {
> +               mutex_unlock(&priv->lock);
> +               return -EBUSY;
> +       }

As the locking and the above two checks are duplicated multiple times,
perhaps they can be replaced by an rz_mtu3_lock_if_counter_is_valid()
helper function?

> +static int rz_mtu3_count_function_read(struct counter_device *counter,
> +                                      struct counter_count *count,
> +                                      enum counter_function *function)
> +{
> +       struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
> +       struct rz_mtu3_cnt *const priv = counter_priv(counter);
> +       int ret;
> +
> +       mutex_lock(&priv->lock);
> +       if (ch->is_busy && !priv->count_is_enabled[count->id]) {
> +               mutex_unlock(&priv->lock);
> +               return -EINVAL;
> +       }

rz_mtu3_lock_if_count_is_disabled() helper?
(can also be called by rz_mtu3_lock_if_counter_is_valid())

> +static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
> +                                            u8 cascade_enable)
> +{
> +       struct rz_mtu3_cnt *const priv = counter_priv(counter);
> +
> +       mutex_lock(&priv->lock);
> +       if (priv->ch->is_busy && !rz_mtu3_is_ch0_enabled(priv)) {
> +               mutex_unlock(&priv->lock);
> +               return -EINVAL;
> +       }

rz_mtu3_lock_if_count_is_disabled() helper?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
