Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76420755DF3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGQIKT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 17 Jul 2023 04:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGQIKS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 04:10:18 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E7C0;
        Mon, 17 Jul 2023 01:10:16 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-57764a6bf8cso42855657b3.3;
        Mon, 17 Jul 2023 01:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689581415; x=1692173415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gySSZ2dMhov+wrSpSe2G+NfFchdPIpp9V5G0McbZJ2c=;
        b=aPsxVC2zZ4cWq4khj6Fn0/bomvcCZsXo9DTAxjQ/YAGlzefcjDcP7o+3v7b/sP3Oja
         HZhqPmyksvNcChVYppu6ZCGJR5zgRRRJMS9G3z+DLVmfIodYTGIHpyNYh9b7eHt8vtDN
         nOrbsjyl5NirtaHEaLiMRpE+yMCm4yuhsYgV7VuZaJJG0GZkGpTErq3UIl+hOzXgAUDE
         Rv75eo3BfuvvMns76/+8hUKbAjrWkS2vfFkePyyqj4u2GpZAkT2/rA91wJ5uP/szb9sA
         F582fj0hwlV84Guexda202tt3oZWu4lYcax19UiwUcwRMOkEytr0fW3b6dbz7cQxtugP
         y8iw==
X-Gm-Message-State: ABy/qLbmGXWEIoif1G/DqbRnGc8/Vib2zLJLwmWkWK/FhVFY8/NaP4/p
        AmVEMbgyLGoY7gbCzNsA+tHXmM73n5sFlQ==
X-Google-Smtp-Source: APBJJlEfOppA7HGQc8YYywZz2IANV8173xzCAcoqtTiJ+eVbb5ued64OtNgjNHsZv80l0OuGbm6TSg==
X-Received: by 2002:a0d:d246:0:b0:576:b52d:4946 with SMTP id u67-20020a0dd246000000b00576b52d4946mr10693506ywd.30.1689581415082;
        Mon, 17 Jul 2023 01:10:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id e6-20020a0dc206000000b0057a44e20fb8sm3718051ywd.73.2023.07.17.01.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:10:14 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so4324886276.0;
        Mon, 17 Jul 2023 01:10:14 -0700 (PDT)
X-Received: by 2002:a25:1f0a:0:b0:c47:56c9:a9bd with SMTP id
 f10-20020a251f0a000000b00c4756c9a9bdmr10820743ybf.6.1689581414420; Mon, 17
 Jul 2023 01:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com> <20230716175218.130557-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230716175218.130557-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 10:10:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-+7HynuF+8ZfupP3pJ0omfif4KzvmK5FGeqfyx8xPUg@mail.gmail.com>
Message-ID: <CAMuHMdX-+7HynuF+8ZfupP3pJ0omfif4KzvmK5FGeqfyx8xPUg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: accel: adxl355: Simplify probe()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 16, 2023 at 7:52 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Simplify the probe() by replacing of_device_get_match_data() and
> i2c_match_id() by i2c_get_match_data() as we have similar I2C
> and DT-based matching table.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
