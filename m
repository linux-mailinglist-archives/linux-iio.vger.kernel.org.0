Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C5E3D70D5
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhG0IHK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbhG0IHK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 04:07:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7543FC061757;
        Tue, 27 Jul 2021 01:07:10 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q15so19352392ybu.2;
        Tue, 27 Jul 2021 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+KcL7dXJ7D+nJ0tqj3mxzvtr9CifwH+o213FLhP+90=;
        b=OCpS/XTLoi9+PoX/DP+w8tt/iyNKr+IVeLA/BdoCYS0/zLJn1oHX4fmJAzfxkA2uAw
         SF0v0nNK+qEhyilM9zpd2OBm6dA78fvzS4otFIHYIzSmB8+mlXExzoUgW2H+LtcpOIG7
         BiDJHMA7+oaRYkH3N+cCSbhBhTCaa4U/C/QFYl0m8qNEhlYkCWp36GTJRqNQYwE7iSKf
         mz+j+rcXVUJ29oHAjVUzNPBHwHCqkBAj97GLKwrgAzPe+/0P2q00CidT8N00Uv+EXo37
         cJU2qhdMeH2F4SFPQGmD/GW3K0ZFtzpFSdqaLWBQlrtpXs1A0EDG97cKduuLAzB9wL1c
         8DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+KcL7dXJ7D+nJ0tqj3mxzvtr9CifwH+o213FLhP+90=;
        b=dIdMYHC+EtKAIIuHuopXGE/CzFvBu92XH21YfDFLLsv5G/TEA5Aa0MqNFxpvl7o3UN
         OtVDJ2mlSBb222exCmElzOKsZUefPBt5a3JtiVVChjaApR8IHRI53sTf0axe/5GtXitq
         kmqwoy5rSFo1OGhlpM12xGw4t/YWG1+7glN7hjZUvfEJOQvAN+p4gj9DJdsilmwGI9GQ
         zNYl71CclNkaNDsxef+3tYqPmahHlXjEKfaV/7hSKMK9ygeF5qBOJPZ58AY92hdQJNXn
         1WFuTJ0EdE2EytALX6ZOkG/DShFnV0lLWA7nf+oOG146cNRD1Tztuf72pWOjnvdv1WHE
         Jatg==
X-Gm-Message-State: AOAM531KWToUYnPlvwVr+TvhM5uVNZ0lWiqzyNqG82KKIQHeQykHf7Qk
        MkXl5VagrHjPoDIfSIGnjTys5zoS2uBb7AEDwRY=
X-Google-Smtp-Source: ABdhPJxDdIl3vPRyEk27KSNLAP01FPQ1VB7lbBTDmDcYYYZ/WeGI2XtHsbDdLuJSqkD38EyLa/Wzgoj9a6tzgkuZ2ao=
X-Received: by 2002:a25:e404:: with SMTP id b4mr29884451ybh.426.1627373229775;
 Tue, 27 Jul 2021 01:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210726182850.14328-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <1627335750.959093.914062.nullmailer@robh.at.kernel.org>
In-Reply-To: <1627335750.959093.914062.nullmailer@robh.at.kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 27 Jul 2021 09:06:43 +0100
Message-ID: <CA+V-a8vOG+-r7_ddp-3eWu1tSjfvWrheMMXY75TDrmD+mdRR3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add binding documentation
 for Renesas RZ/G2L A/D converter
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

On Mon, Jul 26, 2021 at 10:42 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 26 Jul 2021 19:28:48 +0100, Lad Prabhakar wrote:
> > Add binding documentation for Renesas RZ/G2L A/D converter block.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++++++++++++++++
> >  1 file changed, 134 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dts:26.28-29 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1418: dt_binding_check] Error 2
> \ndoc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1510163
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
The base patch series required for this path is v5.14-rc2. (I had
mentioned it in the cover letter, maybe I should have added a note
here too)

Sorry for the inconvenience.

Cheers,
Prabhakar

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
