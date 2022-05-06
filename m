Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4B51D21F
	for <lists+linux-iio@lfdr.de>; Fri,  6 May 2022 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389486AbiEFHVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 May 2022 03:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389487AbiEFHVs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 May 2022 03:21:48 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236EC66FBC;
        Fri,  6 May 2022 00:18:07 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id y6so5248447qke.10;
        Fri, 06 May 2022 00:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsIpX/vfVN3xlhccbkLgbaTI0smOBxkyBI6YB6HwjoI=;
        b=sGFyPJEaVEjaPaLc4j0JW8ZkaeEwSBj/c8UWSDqQeeDq+VCfeFS2JMwo1F9yxkRR1J
         6Tv/71Ilq6vxgoYD1wYsGq2nM0wrEO7pkVW9e89azxvWOKak7CZvs0dlkLC/oBOZ0ryl
         aB6boIJpKz2UgXFmhyvL6Dz9PkfkVvHnaWPcZ0WQhdsO704EYTsYF0AuvgfngS2Z0nrW
         mf6IPSydlSQpH3uvu8L0kgvqOqr6PIXRkVS97eEuLADVBWtb5I8GdVXlbhhLrFJsZAh2
         hgBVAsRk4LeViaoIx8TwinJ4qAKRWr4ZiDIMUOMKmuNEpCiJefZVJezpbfyvNebV1tLX
         isYQ==
X-Gm-Message-State: AOAM531opnqFIw+H2ucMYYpSv9yjfyH4TS/0p1JeBo+3NfMzY3ECmcUb
        I7r9kTtVVNk80+CrjSMOLkb09CN+i+3ECw==
X-Google-Smtp-Source: ABdhPJxmQ9qrl/ExB1onOedPDp8oA2KKNSn3nOEoaAGyg11w0H9v6Tj2IEOxPHXvoAPocR8GJ7rakQ==
X-Received: by 2002:a37:6696:0:b0:69f:c376:3762 with SMTP id a144-20020a376696000000b0069fc3763762mr1433153qkc.588.1651821486042;
        Fri, 06 May 2022 00:18:06 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id y12-20020ac8524c000000b002f39b99f695sm2108826qtn.47.2022.05.06.00.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:18:05 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f16645872fso71985257b3.4;
        Fri, 06 May 2022 00:18:05 -0700 (PDT)
X-Received: by 2002:a81:913:0:b0:2f7:c833:f304 with SMTP id
 19-20020a810913000000b002f7c833f304mr1513924ywj.283.1651821485226; Fri, 06
 May 2022 00:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com> <20220505184037.511295-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220505184037.511295-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 May 2022 09:17:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVuE80kLNDT00nq5zttQQ6XZcWyS9B+2jSBZfK9jg_Sw@mail.gmail.com>
Message-ID: <CAMuHMdXVuE80kLNDT00nq5zttQQ6XZcWyS9B+2jSBZfK9jg_Sw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: rzg2l_adc: Remove unnecessary channel
 check from rzg2l_adc_read_label()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 5, 2022 at 8:40 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Remove unnecessary channel check from rzg2l_adc_read_label(), as the channel error
> handling is already done in probe(). Therefore no need to validate at runtime.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2:
>  * New patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
