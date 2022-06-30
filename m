Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ADE561EDD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiF3PMN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jun 2022 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiF3PML (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2022 11:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC52BB3F;
        Thu, 30 Jun 2022 08:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B17A660E84;
        Thu, 30 Jun 2022 15:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142ECC34115;
        Thu, 30 Jun 2022 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656601930;
        bh=ZaCyi231xN55NbL6hah2FVZ40YJUDbimFdDQCUOmGEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K7IKXfd9/pUACjiI15Da8zt3ouesm1jbRlDrrQQYEA48PUssOguUm2V2ANCrrmZIO
         TFpuXyFtZWp1mbIsube9cq9hma3+6WnoHOYolML+fqKebhh+lavwfJPt9F2mW8Qepm
         0iztq5YZ+mu2QOxAQ9YsFIS0DfEYI1B5uluNXzA9L3AG94KQqT+vs6E2PqWLF3YLPb
         uwQDfnzQBAIoprN47o+Ft1EnYcZM0cKDp7dp+MTsBMdFDHehPq8BHRlgF8oJAv5LKg
         IWXwD0/fjVUL8jTblCUfcFUe5TXrZJ+lCNsstlEEZeaDJoeWsfj6i6DbTyT+a2ntsV
         lb2ca6Z15QTcQ==
Received: by mail-vs1-f54.google.com with SMTP id j6so18603800vsi.0;
        Thu, 30 Jun 2022 08:12:10 -0700 (PDT)
X-Gm-Message-State: AJIora8tUziQggjiIIu5Wf3N5Md3hDnXUVlRueR9ZztUrjeIdgwDHF2c
        6SfL9plAQohLNiRDKGH16YmGdskJwba4z8Uh1A==
X-Google-Smtp-Source: AGRyM1sE0e68v7McZcrdxOt2FnnPQJyoMMCz3luQW735kIxxQS448cN4nvcfDkxVmzob49oMuoeWsZ1lbV7RsMyGwOQ=
X-Received: by 2002:a67:1787:0:b0:354:6490:437f with SMTP id
 129-20020a671787000000b003546490437fmr8839140vsx.26.1656601929001; Thu, 30
 Jun 2022 08:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221444.3638-1-macroalpha82@gmail.com> <20220627221444.3638-2-macroalpha82@gmail.com>
In-Reply-To: <20220627221444.3638-2-macroalpha82@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 30 Jun 2022 09:11:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9U0ku+2hiaLeUMakpOhp7DYhQLi2MJpUthTjX5T655Q@mail.gmail.com>
Message-ID: <CAL_JsqL9U0ku+2hiaLeUMakpOhp7DYhQLi2MJpUthTjX5T655Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: adc-joystick: add poll-interval
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>,
        Maciej Matuszczyk <maccraft123mc@gmail.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>
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

On Mon, Jun 27, 2022 at 4:14 PM Chris Morgan <macroalpha82@gmail.com> wrote:
>
> Add poll-interval support for the adc-joystick documentation. This is
> an optional value and if not provided the adc-joystick works as it
> does today (with triggered buffers). If this value is provided, the
> adc-joystick driver is polled at the specified interval.
>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  Documentation/devicetree/bindings/input/adc-joystick.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> index 2ee04e03bc22..2d755091e46d 100644
> --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -18,6 +18,12 @@ properties:
>    compatible:
>      const: adc-joystick
>
> +  poll-interval:
> +    description:
> +      Poll interval time in milliseconds. If not specified, device will use
> +      triggered buffer.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Already defined in input.yaml, so add a $ref to it and here you just
need 'poll-interval: true'.

Rob
