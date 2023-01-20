Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF27675DDC
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jan 2023 20:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjATTUw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Jan 2023 14:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjATTUs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2023 14:20:48 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 11:20:44 PST
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A3C917C6;
        Fri, 20 Jan 2023 11:20:44 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1674241447;
        bh=0Pe5QS9y7LSeYm3L6F0SMYWlM7rzxmhMnheYubXCKdQ=;
        h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:
         Content-Transfer-Encoding:Message-Id:References:To:From:Subject:To:
         Date:Sender:Content-Type:Content-Transfer-Encoding:
         Content-Disposition:Mime-Version:Reply-To:In-Reply-To:References:
         Message-Id:Autocrypt;
        b=Z3GK/uvZawWIj8QhMSWpgvMkqf0GzcsL6QMy6VvRpMyXnKLRCEbMLkqtgzyDnYxLn
         kDIrAgnsE+icT0tACQmLqaXgcg6mGns+jJ4C7DK4OTmCmzX2Rspc7RQ3mo159DfwkX
         nEd+sNm0aJBO01PuD3aQ+Aef9uzb/whVIWmerhhXHIbG+iSbNi0BXztYodrS6AGxuc
         30l7xk4MkvaFJVWZs6LeFQURC/TxHS3JCDp2ZH49dPAnwMtnCcumfqLkDdswG+cnLZ
         jBDbDwiI4RM5iKqMUTjKrg+QXT3Eo+TKElHXVSrBmCZYKgLR6MkW36BjE+t/KFUe9A
         n9hhSAWoOsrXw==
Mime-Version: 1.0
Subject: Re: [PATCH 5/5] dt-bindings: iio: cleanup examples - indentation
From:   Alexandru Lazar <alazar@startmail.com>
In-Reply-To: <20230118184413.395820-5-krzysztof.kozlowski@linaro.org>
Date:   Fri, 20 Jan 2023 21:03:55 +0200
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A97DC86-040D-439E-9131-1E4ABAF0788D@startmail.com>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
 <20230118184413.395820-5-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is likely redundant but just so you know I=E2=80=99m watching, this =
diff:

> .../bindings/iio/adc/maxim,max1241.yaml       |   4 +-

i.e.

> diff --git =
a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml =
b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> index 58b12fe8070c..ef8d51e74c08 100644
> --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> @@ -54,8 +54,8 @@ examples:
>   - |
>     #include <dt-bindings/gpio/gpio.h>
>     spi {
> -      #address-cells =3D <1>;
> -      #size-cells =3D <0>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
>=20
>         adc@0 {
>             compatible =3D "maxim,max1241";

looks okay. If you need it:

Reviewed-by: Alexandru Lazar <alazar@startmail.com>

All the best,
Alex=
