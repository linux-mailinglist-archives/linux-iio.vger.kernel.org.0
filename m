Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9550E0D3
	for <lists+linux-iio@lfdr.de>; Mon, 25 Apr 2022 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiDYM4G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Apr 2022 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiDYM4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2022 08:56:05 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECD22B1AC;
        Mon, 25 Apr 2022 05:53:01 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id s4so10686683qkh.0;
        Mon, 25 Apr 2022 05:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKBLvzpEGSIBr54zoQtzf0+gxoJzKeZeIIlQHCf6yKo=;
        b=La3ufGSzfOO6drUj42uT4E8bM8Ik6K7zYq3Vpf/za9DK4mz78SoQmfpeTSCXJT2PUX
         mnJgUne3994smRr1beaE15iU2Hg+ruBkJIxzxZHTBo7lVM83tMpNpd9TXcL2O7JJsXA6
         wySm2tI/4XBY8wrik4ebA+8mnC/P0gem+nQSLI05CPkECgUELJ+kbR73WhwkhqPygkks
         PNilfD0WtdzsgWTG/Kcr+ImMwLsS4BVIhCxfvWHKZx9Eec0P5tUVNCF/oVTEieq8TdAf
         Qy4dBF3zMDXus4LbLelocb2eUpovNV63oheIJzr/C0Eok0gWI6WeypIUpxFxsHu9dTbi
         vy8A==
X-Gm-Message-State: AOAM531GqExwH21sDhke3bcYWXNhPcasDlwoT/zpH379KZiUFEU0V3PM
        wgmqZbpxe0FGEm6VD10vXwJvshr5tul/3w==
X-Google-Smtp-Source: ABdhPJx3YxKjRtX65g8uolxdlpRkrEqFMhgebNdysIWIoDOhXLJfra8whjxJ/kA3tkbTPv0joLUmXA==
X-Received: by 2002:a05:620a:40d6:b0:69f:2d4b:4236 with SMTP id g22-20020a05620a40d600b0069f2d4b4236mr6472595qko.197.1650891180657;
        Mon, 25 Apr 2022 05:53:00 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm5016132qkg.64.2022.04.25.05.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 05:53:00 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7d19cac0bso40025577b3.13;
        Mon, 25 Apr 2022 05:53:00 -0700 (PDT)
X-Received: by 2002:a81:1cd5:0:b0:2f4:c3fc:2174 with SMTP id
 c204-20020a811cd5000000b002f4c3fc2174mr16882015ywc.512.1650891180048; Mon, 25
 Apr 2022 05:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220423131654.131390-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220423131654.131390-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 14:52:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSTjXqQ2GQh6HPyUSJ-ZMiUPS8PDXsk1ZhGV=y2zzJ+w@mail.gmail.com>
Message-ID: <CAMuHMdXSTjXqQ2GQh6HPyUSJ-ZMiUPS8PDXsk1ZhGV=y2zzJ+w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: Document Renesas RZ/V2L ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Sat, Apr 23, 2022 at 3:17 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document renesas RZ/V2L ADC bindings. RZ/V2L ADC is identical to RZ/G2L
> with same number of channels.
>
> While at it remove RZ/G2LC SoC from binding documentation as it does not
> support ADC.
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
