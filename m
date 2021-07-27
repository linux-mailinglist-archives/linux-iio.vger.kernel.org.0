Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B181A3D7F47
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhG0UbL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 16:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhG0UbK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Jul 2021 16:31:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41C7660F9D;
        Tue, 27 Jul 2021 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627417870;
        bh=ZkhS55XggLNssuCIBqtuPZ0Y/L4fu7HoNPrNXlSi3H0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kKbLYUkTlJrXfrhwcbofYMAT0Aop2PvcbQtZ3pTZQaKI/9fg5uvByY+V8OB2YlbXx
         avrb24K+NrF9IHGKq/o/X1sMrUrrklEKceLo8l6bU/JEHpI2KKjmjZIaoS2XVo/oiM
         XDM7rHWLlnYEoitiYzA4eUr4o+eg5Yz4WpFSfHgXUKqiQZF7Gezex3PzxwyqbZTopi
         983GFo307ij96rxx1kGXi3dtJYQ82IKTPrsVT4vB0MVbJZiwOfPBv5SZB9nd/CVNR9
         HPW/mRcDVq2/13wN9Jc3Vix0UXlMOXWjV+Oi9HnYcfznmCoC/RKCh3u0pleSI8s1mK
         3y5NnRcetNDBw==
Received: by mail-ed1-f43.google.com with SMTP id z26so201850edr.0;
        Tue, 27 Jul 2021 13:31:10 -0700 (PDT)
X-Gm-Message-State: AOAM531EIoykfp3aiB5j3mM90YqUhMBFhEwFRwgjzY4do3dtR2Ktu2dr
        tZWdlX1HubQ1Zrnpqr5y7vcrfDVwSTENiEmsYg==
X-Google-Smtp-Source: ABdhPJyj1o0RiCXcDt0UK5f2hKJR4DHqtubY4gmn20A+p9mszuTSkyEL1stsRYSj+yi431oxWeSE4QZmZUQ3HMqG0mg=
X-Received: by 2002:a05:6402:1a4c:: with SMTP id bf12mr14265859edb.137.1627417868821;
 Tue, 27 Jul 2021 13:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210726182850.14328-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210726182850.14328-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Jul 2021 14:30:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXYJjPXUGEGqmiXB0o=40SjdizG6JhRbVCkjpqCZG2bQ@mail.gmail.com>
Message-ID: <CAL_JsqJXYJjPXUGEGqmiXB0o=40SjdizG6JhRbVCkjpqCZG2bQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add binding documentation
 for Renesas RZ/G2L A/D converter
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 26, 2021 at 12:31 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Add binding documentation for Renesas RZ/G2L A/D converter block.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
