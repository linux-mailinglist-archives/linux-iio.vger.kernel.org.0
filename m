Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14422C60BA
	for <lists+linux-iio@lfdr.de>; Fri, 27 Nov 2020 09:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgK0IOV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Nov 2020 03:14:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43022 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgK0IOV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 03:14:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id f12so3970952oto.10;
        Fri, 27 Nov 2020 00:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5J7WTD9K640qotY+2fWDkBGRwYagEywHoZY9oKNIuHQ=;
        b=R0e34tGoqKBziIFGOF+8qJe9ZcZ4neK47a3ry9lF5arTY3D8O4dOX2E7g2gy85XVLt
         vuf8cFORMEq6F4jD+toE7ih17RDG7ZNxjUNuXDSw6zto8ane390t7Z147CZ6Am+0tOXG
         QEEJ1zquPl2Ks6jHY/maCbYuGmak/6y8Ipdq3+n7kl2E3eTE71asmABgEJ6ei4C+HCf6
         6agSoNQDitHOEps2Ppz+jlYMLQ5vs3S5IkgYvrC3LTkoRFXx8TU/OscPPsBevhfxmXqa
         FoS4DzHYKAlc56xrBV414u4g23ni61V6FA9OMMBEOaNK52iwkyZNUYyH6nvmUUp9nOtV
         yLiw==
X-Gm-Message-State: AOAM532tDyqeopon1x4hugE/JLMDm2rwEPTiviVCl+42MF0x92ePi9X/
        fqHEGquVwiJTjzylWjOAwndaeAE1y5AObzHVRDw=
X-Google-Smtp-Source: ABdhPJy/nrrgv9y4ZkK4RYkWQyJ8pEKKfmkbqrIbJnJsWZiJ2PohN16BTBgNu+xl3J6jp694Mobc6d6QuWtgjAOeKEo=
X-Received: by 2002:a9d:686:: with SMTP id 6mr4654059otx.107.1606464860268;
 Fri, 27 Nov 2020 00:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20201031184854.745828-1-jic23@kernel.org> <20201031184854.745828-31-jic23@kernel.org>
In-Reply-To: <20201031184854.745828-31-jic23@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Nov 2020 09:14:09 +0100
Message-ID: <CAMuHMdXGjG5hCpOzN9q8J+K3WvODK29kco8TsNmoJ8w-=4PrJw@mail.gmail.com>
Subject: Re: [PATCH 30/46] dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to
 yaml conversion.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Oct 31, 2020 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This is a somewhat unusual device, in that it effectively does
> spi offload.   That means that it doesn't act as a full SPI
> master, but supports some functionality.  As such it supports
> a subset of specific SPI ADCs.  There is potential for a future
> clash in bindings, but as these are simple devices hopefully that
> will not occur.
>
> One addition to this from testing it against existing dts files
> was to add a resets property.
> This is specified in arch/arm/boot/dts/r8a7791.dtsi
> If it's the dtsi that is wrong and not the binding doc, then
> we can fix that instead.

Documenting the resets property was the right thing to do.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
