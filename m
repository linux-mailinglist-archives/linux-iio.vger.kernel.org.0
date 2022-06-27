Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2C55D66C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbiF0Wdm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbiF0Wdl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:33:41 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583EE186DD;
        Mon, 27 Jun 2022 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656369218; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UnTbRvsxVvXPsq0EF54NsWTHiDn/eVe8XX1xtwUKGk4=;
        b=c7a+2SW6mZIpQup7xMq3mvOiwdn3/sMsjc8HKUcscWn9kScnRF26NFukPNTs3MLFzG4qn3
        zoLnCuK9zCLMkguvbhynbvwVvCn9+Mj6tWj0PrcPjWYtu+r9oNqGnUJv8ESvxtp6jQvzqy
        D0GbK2z+7bIDgQQT2wM/n6r//8U6gJI=
Date:   Mon, 27 Jun 2022 23:33:28 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/3] dt-bindings: adc-joystick: add poll-interval
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        contact@artur-rojek.eu, maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Message-Id: <SNQ5ER.4MEKNEQLW6H11@crapouillou.net>
In-Reply-To: <20220627221444.3638-2-macroalpha82@gmail.com>
References: <20220627221444.3638-1-macroalpha82@gmail.com>
        <20220627221444.3638-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Chris,

Le lun., juin 27 2022 at 17:14:42 -0500, Chris Morgan=20
<macroalpha82@gmail.com> a =E9crit :
> Add poll-interval support for the adc-joystick documentation. This is
> an optional value and if not provided the adc-joystick works as it
> does today (with triggered buffers). If this value is provided, the
> adc-joystick driver is polled at the specified interval.
>=20
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  Documentation/devicetree/bindings/input/adc-joystick.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/input/adc-joystick.yaml=20
> b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> index 2ee04e03bc22..2d755091e46d 100644
> --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -18,6 +18,12 @@ properties:
>    compatible:
>      const: adc-joystick
>=20
> +  poll-interval:
> +    description:
> +      Poll interval time in milliseconds. If not specified, device=20
> will use
> +      triggered buffer.

It doesn't have to use *triggered* buffer - it can use regular buffer=20
as well.

The property should use a unit suffix, as explained here:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/prop=
erty-units.yaml

So it should be named poll-interval-ms.

Cheers,
-Paul

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>    io-channels:
>      minItems: 1
>      maxItems: 1024
> --
> 2.34.1
>=20


