Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B2682A0E
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 11:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAaKNU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 05:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaKNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 05:13:19 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B92386D;
        Tue, 31 Jan 2023 02:13:18 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id w3so4162272qts.7;
        Tue, 31 Jan 2023 02:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOusrxrqG7TnsLI2NCfTQDgToKUngDEM8aFSM9oqO2E=;
        b=uRkeA27S1kLE3p42ORWJCgk2P1fQffOHrxWENuqhMb2nPyIcwmgtHoIVHAzNFNRLN1
         vLo1r2256d/b/KLun150Pv2VZ0ResNm3+YocXGZ1UvnOkHP1ITg/vgBGnILHO2XXKkt1
         +u4YjfJCM8rFfh3IOiCLSiWdxOqyvfuJYFvMtqdAGBF0ZdwhU8o8hP9yiek3A5glSFQ/
         LmFyMyHnhlRThOZBLKJmaHJRWuKMr+2kFicpuhi1oEpC7aNP/McfcFadBx2DV1rKGIpD
         ZCBj2ih3LeWwd+K0jO1CHaHAoTST7Jv60tFynS9SH/m45UNfTzF6YN98UrUYR9hRC9hd
         Z6dg==
X-Gm-Message-State: AO0yUKW5UlMW4AhdwNz/KdY02IoOFS9FXl6oJZyp8V6FWA1kWRXLa1tq
        sPuztHjp0hoNLD3qYvAoIu6h7IBgf1Oe9Q==
X-Google-Smtp-Source: AK7set/izsiPqfh3yUF5hQTTQXLkNj3SNOxVHLlEh7qHdk1qDTs+9OjOFUeMBxtk4LK6FG6eIvyfyg==
X-Received: by 2002:a05:622a:130e:b0:3b9:abfb:61cd with SMTP id v14-20020a05622a130e00b003b9abfb61cdmr3310558qtk.26.1675159997156;
        Tue, 31 Jan 2023 02:13:17 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8428b000000b003b63b8df24asm2068554qtl.36.2023.01.31.02.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 02:13:16 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id x4so17454813ybp.1;
        Tue, 31 Jan 2023 02:13:16 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr4711958ybo.380.1675159996282; Tue, 31
 Jan 2023 02:13:16 -0800 (PST)
MIME-Version: 1.0
References: <7b7a13680fa24282c3407e12b5943a66a2ed9068.1666611184.git.geert+renesas@glider.be>
 <3c0895a3-2da6-3bd1-c786-01cf5eaa2452@linaro.org> <20221029135102.5bb9d786@jic23-huawei>
In-Reply-To: <20221029135102.5bb9d786@jic23-huawei>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Jan 2023 11:13:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTkPZm+66PumNa_LgV6DYR2HgH9k6Nbi9RcRPHGRDOVw@mail.gmail.com>
Message-ID: <CAMuHMdVTkPZm+66PumNa_LgV6DYR2HgH9k6Nbi9RcRPHGRDOVw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc:
 Miscellaneous improvements
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Oct 29, 2022 at 2:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 24 Oct 2022 08:23:43 -0400
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > On 24/10/2022 07:34, Geert Uytterhoeven wrote:
> > > Set limits on the number of power-domains and resets, and make them
> > > required.
> > >
> > > Simplify the example, and update it to match reality:
> > >   - Convert from obsolete MSTP to CPG/MSSR bindings,
> > >   - Examples should use #{address,size}-cells = <1>,
> > >   - Add missing resets property,
> > >   - Drop soc container and pinctrl properties, which are not needed in
> > >     examples.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Applied,

Looks like this fell through the cracks, as I cannot see it applied?
Do you want me to resend?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
