Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118E463F49C
	for <lists+linux-iio@lfdr.de>; Thu,  1 Dec 2022 16:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiLAP6Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Dec 2022 10:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiLAP6U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2022 10:58:20 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFBFA5558;
        Thu,  1 Dec 2022 07:58:17 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id x18so1494290qki.4;
        Thu, 01 Dec 2022 07:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqYuf4cCv+SwvDMJzDiImKFhnbPR9Lllup2w7YcJ49U=;
        b=1XuC++JWd4/itL/nx6iPb7CJpk+1cnbfS4ptTWYD+LnXpc1TIlUguXvZ6ydpyCQiCc
         4UftgzUG61poZVCNIP9HRILWYnvEC1b6v/eLstq6R0LqG42mfMjD9O7EYoS/LsBJTxbl
         T0cjfZ8li+/AquCVZSGEQya/zem1vOdcZiFJgjgEfBnmoDaWvGoMm9Rn8p7FKChwWg4Q
         +TjNIef/W/+6cMeWzXyBNtYf3fCGueImD+TAvOUH7gLCMD/zTLLU5SA5UUJWPHzyLDEW
         RVHpGWMFxiYOER+6j6QwD6DvGdCkz86lxxUFGVeZja1f8sEiUcjYMBuR4BoMBo54mSRB
         tkFg==
X-Gm-Message-State: ANoB5pmwo3DZQqqhXtIUKV2iL9pbp192OednwjfBsyAqu2y82dm+H2m2
        TyPXe4yUf0K8+sECWN8wVgvM4geHWdh6UA==
X-Google-Smtp-Source: AA0mqf52wWU8fCWxA+FMRc90cwTFYLYCLszPR8DOX1meMMpnDVXfvtrUp0GqI4AsAf1eKm71B0SAiw==
X-Received: by 2002:a05:620a:1599:b0:6fa:3b1b:9c82 with SMTP id d25-20020a05620a159900b006fa3b1b9c82mr61060801qkk.704.1669910296543;
        Thu, 01 Dec 2022 07:58:16 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id d14-20020a05622a15ce00b0035cd6a4ba3csm2794511qty.39.2022.12.01.07.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:58:15 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3c21d6e2f3aso21427167b3.10;
        Thu, 01 Dec 2022 07:58:15 -0800 (PST)
X-Received: by 2002:a05:690c:b81:b0:37e:6806:a5f9 with SMTP id
 ck1-20020a05690c0b8100b0037e6806a5f9mr47129496ywb.47.1669910295479; Thu, 01
 Dec 2022 07:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20221124170018.3150687-1-biju.das.jz@bp.renesas.com> <20221124170018.3150687-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221124170018.3150687-5-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Dec 2022 16:58:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUyBBcSs5Y9tjnpYf83UGUSaUYhxU2ACHkq_2jDNeiQSA@mail.gmail.com>
Message-ID: <CAMuHMdUyBBcSs5Y9tjnpYf83UGUSaUYhxU2ACHkq_2jDNeiQSA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Thu, Nov 24, 2022 at 6:00 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
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
> external input phase clock pin and "cascade_enable" to enable/disable
> cascading of channels.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->v7:
>  * Updated commit description
>  * Added Register descriptions
>  * Opimized size of cache variable by using union
>  * Used test_bit() in rz_mtu3_is_counter_invalid()
>  * Replaced val->timer_mode in rz_mtu3_count_function_{read,write}
>  * Added TODO comment phase3 and phase5 modes.
>  * replaced if-else with ternary expression in rz_mtu3_count_direction_read()
>  * Used switch statement in rz_mtu3_count_ceiling_read to consistent with write
>  * Provided default case for all switch statement.
>  * Add mutex lock for avoiding races with other devices
>  * Updated comments in rz_mtu3_action_read
>  * Replaced COUNTER_COMP_DEVICE_BOOL->COUNTER_COMP_DEVICE_BOOL for
>    cascade_enable
>  * Replaced RZ_MTU3_GET_HW_CH->rz_mtu3_get_hw_ch
>  * Added rz_mtu3_get_ch() to get channels
>  * used rz_mtu3_shared_reg_update_bit for cascade_enable and
>    selecting phase input clock.
>  * Added rz_mtu3_is_counter_invalid() check in rz_mtu3_count_ceiling_read()

Thanks for the update!

> --- /dev/null
> +++ b/drivers/counter/rz-mtu3-cnt.c

> +static int rz_mtu3_initialize_counter(struct counter_device *counter, int id)
> +{
> +       struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
> +       struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
> +       struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
> +
> +       switch (id) {
> +       case RZ_MTU3_16_BIT_MTU1_CH:
> +       case RZ_MTU3_16_BIT_MTU2_CH:
> +               mutex_lock(&ch->lock);
> +               if (ch->function == RZ_MTU3_NORMAL)
> +                       ch->function = RZ_MTU3_16BIT_PHASE_COUNTING;
> +               mutex_unlock(&ch->lock);
> +
> +               if (ch->function != RZ_MTU3_16BIT_PHASE_COUNTING)
> +                       return -EBUSY;

I think having a request_channel() API would make this more readable,
and avoid duplication (here and in the PWM driver).

> +
> +               rz_mtu3_16bit_cnt_setting(counter, id);
> +
> +               break;
> +       case RZ_MTU3_32_BIT_CH:
> +               /*
> +                * 32-bit phase counting need MTU1 and MTU2 to create 32-bit
> +                * cascade counter.
> +                */
> +               mutex_lock(&ch1->lock);
> +               if (ch1->function == RZ_MTU3_NORMAL)
> +                       ch1->function = RZ_MTU3_32BIT_PHASE_COUNTING;
> +               mutex_unlock(&ch1->lock);
> +
> +               mutex_lock(&ch2->lock);
> +               if (ch2->function == RZ_MTU3_NORMAL)
> +                       ch2->function = RZ_MTU3_32BIT_PHASE_COUNTING;
> +               mutex_unlock(&ch2->lock);
> +
> +               if (ch1->function != RZ_MTU3_32BIT_PHASE_COUNTING ||
> +                   ch2->function != RZ_MTU3_32BIT_PHASE_COUNTING)
> +                       return -EBUSY;

Surely you need to release the channel you did obtain (if any)?

> +
> +               rz_mtu3_32bit_cnt_setting(counter, id);
> +               break;
> +       default:
> +               /* should never reach this path */
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
> +{
> +       struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
> +       struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
> +       struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
> +
> +       if (id == RZ_MTU3_32_BIT_CH) {
> +               mutex_lock(&ch1->lock);
> +               ch1->function = RZ_MTU3_NORMAL;
> +               mutex_unlock(&ch1->lock);

Locking around a simple integer assignment doesn't do much.
You might as well just use WRITE_ONCE(), to avoid reordering by the
compiler.

> +
> +               mutex_lock(&ch2->lock);
> +               ch2->function = RZ_MTU3_NORMAL;
> +               mutex_unlock(&ch2->lock);
> +
> +               rz_mtu3_disable(ch2);
> +               rz_mtu3_disable(ch1);
> +       } else {
> +               mutex_lock(&ch->lock);
> +               ch->function = RZ_MTU3_NORMAL;
> +               mutex_unlock(&ch->lock);
> +
> +               rz_mtu3_disable(ch);
> +       }
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
