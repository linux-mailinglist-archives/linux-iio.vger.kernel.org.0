Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA36767C8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jan 2023 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAURqz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Jan 2023 12:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAURqy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2023 12:46:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00C2312D;
        Sat, 21 Jan 2023 09:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A0D60B2B;
        Sat, 21 Jan 2023 17:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA61BC433EF;
        Sat, 21 Jan 2023 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674323212;
        bh=aLSAqvLkrC8f7XfxzcgC+5wYZ7Vv1cTXJYugYyKAzD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KusvBcU4rf9q40MaZTG2tId9d0FmXdQb+BULc4sAkL5v9q5gi0qhp7ujUJuBsJ/d2
         d04afeEvs4pmjQcF/oenJquTeeLPvei5C0vDNXlxZpU/4CtBobXpn5t6/FfLPiCmsh
         tFJ1Wz7JqFmhlauyItERmii8Xn5DtpYtEUcFfR3GeinZKMN8NVRji/DXEp4ZdqT0cP
         c2R/Uju5fWs7v+aJ7+8COOxzXSRy+WaCngM8TUTcnxU8BVk82ZCJZPjXaFKrWJv+mJ
         XgeBeZS5KRSWGaDgtqj7Y/LjQ7HjYHeKR4LV/5Z7Z1JXvby2EfQzsaMUvi8nLrO/Og
         K5fK2jS5x3agA==
Date:   Sat, 21 Jan 2023 18:00:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] dt-bindings: iio: dac: Maxim max5522 DAC
Message-ID: <20230121180038.0609ca0d@jic23-huawei>
In-Reply-To: <CALJHbkDKTFN6BT=MCA5Obg6K6jY+yhwCd5Dsa5Ayrj=Z1mLwEA@mail.gmail.com>
References: <20230115173958.134201-1-jic23@kernel.org>
        <CALJHbkDKTFN6BT=MCA5Obg6K6jY+yhwCd5Dsa5Ayrj=Z1mLwEA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Jan 2023 23:46:35 +0100
Angelo Dureghello <angelo.dureghello@timesys.com> wrote:

> Hi Jonathan,
> 
> thanks a lot, and sorry, looks like i forgot this out.
No problem!
> 
> Reviewed-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Applied the driver an this binding doc to the togreg branch of iio.git
which will initially get pushed out as testing for 0-day to see if
it can find anything we missed.

Thanks,

Jonathan

> 
> 
> On Sun, Jan 15, 2023 at 6:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Add binding Doc for this SPI DAC.
> >
> > The driver was perviously posted but was missing the DT binding document.
> > https://lore.kernel.org/all/20221106165928.223318-1-angelo.dureghello@timesys.com/
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Angelo Dureghello <angelo.dureghello@timesys.com>
> >
> > ---
> >
> > As it has been a few months and I don't want to end up not taking the driver
> > simply because it lacked this simple binding doc, I've written one.
> >
> >  .../bindings/iio/dac/maxim,max5522.yaml       | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml
> > new file mode 100644
> > index 000000000000..24830f56c501
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/maxim,max5522.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim Integrated MAX5522 Dual 10-bit Voltage-Output SPI DACs
> > +
> > +maintainers:
> > +  - Angelo Dureghello <angelo.dureghello@timesys.com>
> > +  - Jonathan Cameron <jic23@kernel.org>
> > +
> > +description: |
> > +  Datasheet available at:
> > +  https://www.analog.com/en/products/max5522.html
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max5522
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +  vrefin-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vrefin-supply
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dac@0 {
> > +            compatible = "maxim,max5522";
> > +            reg = <0>;
> > +            vrefin-supply = <&vref>;
> > +        };
> > +    };
> > +...
> > --
> > 2.39.0
> >  
> 
> 
> --
> Angelo Dureghello
> Timesys
> e. angelo.dureghello@timesys.com

