Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE2563BC9
	for <lists+linux-iio@lfdr.de>; Fri,  1 Jul 2022 23:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiGAVdI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Jul 2022 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGAVdI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2022 17:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83972B38;
        Fri,  1 Jul 2022 14:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F80962379;
        Fri,  1 Jul 2022 21:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747A2C3411E;
        Fri,  1 Jul 2022 21:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656711186;
        bh=M98m/sSI144a+JCHTBTnmSEyOXXhwrki5GcnQe3r9Co=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=be/8KARU9UCHa6cahLejCjmPLLvLwr9s/V32L5i/I7i3FI+KC+LGycg5vsInCAjZ4
         VowxiInR/QyM4ioOd2FpB5bL+9D9OqPHM+Nn2LIgYhq6gtcTcHKMOttnYPJNTQKZO4
         2sPd0Eydwpy2XgAyCLtqlCvmlGUJ7IoWRhCJmkxq/gsOcY2bY2hKb+Ia5bf+/rvO7J
         6fE/N2gVgZQK4xXbOR7+Y9RcQrIg8PKMzB7lbnBfcZsjs+wjQuJnIiScgw66fZlQGG
         yX1zMYy/0KUmhBg3iXguD6e4LDoWzTcgB64aZdbQ2FrWF8dv7kwwFl5N8PmRTgFEUC
         ra4OLBlhDGQAA==
Received: by mail-ua1-f50.google.com with SMTP id n16so1264469ual.12;
        Fri, 01 Jul 2022 14:33:06 -0700 (PDT)
X-Gm-Message-State: AJIora/6brUlT0FrOdauVer+nf8uMHlaK8F2w295qygeD1osyddGtgML
        lBCsFFMfbBRhj5Fw6jzi+vaojr6MJdrBOUu2Sw==
X-Google-Smtp-Source: AGRyM1tyGiDJucBa1OhVwhxg83T2tBRzLzQtlarLdxNU6fC96kA4U9r2dcGc022mhj9hW7DJlxAltaM2n/eZST8zFEE=
X-Received: by 2002:a05:6130:3aa:b0:37f:26c0:e196 with SMTP id
 az42-20020a05613003aa00b0037f26c0e196mr10126226uab.43.1656711185460; Fri, 01
 Jul 2022 14:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-3-sravanhome@gmail.com> <YrnChlCiyzgcyyxl@google.com>
In-Reply-To: <YrnChlCiyzgcyyxl@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 1 Jul 2022 15:32:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++_+rPj94notsUp8SMPLFvq+QG4o_Bm6i2f2HSySDT2Q@mail.gmail.com>
Message-ID: <CAL_Jsq++_+rPj94notsUp8SMPLFvq+QG4o_Bm6i2f2HSySDT2Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: mfd: Add mp2733 compatible
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," <andy.shevchenko@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 27, 2022 at 8:45 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 15 Jun 2022, Saravanan Sekar wrote:
>
> > Add new compatible for mp2733 mfd driver.
> >
> > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Applied in place of v1, thanks.

Still failing, pushed out?

Rob
