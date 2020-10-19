Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCC29299A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Oct 2020 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgJSOjf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Oct 2020 10:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgJSOjf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Oct 2020 10:39:35 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED916222E7;
        Mon, 19 Oct 2020 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603118374;
        bh=2FifQM9EWB2bUVMRQarRsruG8flQ/5VispgBkGY1pm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p0lIsmZXVN81E40FXnaQXstnzZI1C+MZkrF3g2cC0M9Z2ndDIwXmPVG5VlOWtnSQg
         UD0Khiepw8v0jNfF+MU/RMEZGHhwaC74iPpc0VKtxaBf9wsLcCPxjADGvWJM/Igz+9
         dp55g9mG7XoWd7t+BslP9rsX3VAVfc2xkA0SFqLs=
Received: by mail-ot1-f43.google.com with SMTP id n15so10638974otl.8;
        Mon, 19 Oct 2020 07:39:33 -0700 (PDT)
X-Gm-Message-State: AOAM5320bJDmmjI3jCuDnYQCn4wFMjYQ9cQdetkLLLYmbdzYghKjya2g
        8ndzZz0BB+VGADgPw0qTfpDcBdZ2m6g4iJqrrQ==
X-Google-Smtp-Source: ABdhPJxGFutvK5gjDMYu+0q/w3JyYiWz6Be1hH1R4bYoocmHah1VOQCTsmRkM7a9IHkFKSr9Ie4lgkofOWROlw20UWw=
X-Received: by 2002:a9d:1c90:: with SMTP id l16mr242288ota.192.1603118373108;
 Mon, 19 Oct 2020 07:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201014104926.688666-1-rmfrfs@gmail.com> <20201016185707.GA1743713@bogus>
 <20201018120046.42689d19@archlinux>
In-Reply-To: <20201018120046.42689d19@archlinux>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Oct 2020 09:39:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFTguw+VWrnBfz1yRgpiV1UKHjGUpUhUa31VWBOaPmnQ@mail.gmail.com>
Message-ID: <CAL_JsqLFTguw+VWrnBfz1yRgpiV1UKHjGUpUhUa31VWBOaPmnQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: fxas21002c: convert bindings to yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rui Miguel Silva <rui.silva@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 6:00 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 16 Oct 2020 13:57:07 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, 14 Oct 2020 11:49:26 +0100, Rui Miguel Silva wrote:
> > > Convert fxas21002c gyroscope sensor bindings documentation to
> > > yaml schema, remove the textual bindings document and update MAINTAINERS entry.
> > >
> > > Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
> > > ---
> > > v1 -> v2:
> > >    Jonathan Cameron:
> > >        https://lore.kernel.org/linux-iio/20201013153431.000052c9@huawei.com/
> > >        - remove Unit from tittle
> > >        - reword interrupts description
> > >        - drop interrupt-name description
> > >        - add spi example and bindings
> > >        - remove vddxx from required list
> > >
> > >  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 ------
> > >  .../iio/gyroscope/nxp,fxas21002c.yaml         | 95 +++++++++++++++++++
> > >  MAINTAINERS                                   |  2 +-
> > >  3 files changed, 96 insertions(+), 32 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> > >  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Nice patch.
>
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to maybe poke at.
>
> I'm still not 100% sure if unevaluatedProperties or additionalProperties makes
> sense here, but as Rob's happy, I'm happy :)

It could be additionalProperties instead if you want to fixup.

Rob
