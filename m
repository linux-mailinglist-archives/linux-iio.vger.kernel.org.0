Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B325B4EA4
	for <lists+linux-iio@lfdr.de>; Sun, 11 Sep 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiIKMCJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Sep 2022 08:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIKMCH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Sep 2022 08:02:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95E357D1;
        Sun, 11 Sep 2022 05:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77BBBB80B41;
        Sun, 11 Sep 2022 12:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772D5C433C1;
        Sun, 11 Sep 2022 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662897724;
        bh=vLl3tNnMHLaKNDxCydXQOi8x6saIG7BeaVSTovfnYWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lh7R3/b4CTdzauEmEVVTkY1wCnJnxValzoOjublYC+gH1nKEHEXqRPYtpWcHqZsTx
         qbT7Z4rNAUB+Hm03ZxsqCOXNm7pvl+B6KUP/nhwu0RSB4cMKTcn6J+eblWRrV20L+R
         GSUFI+GENG1CXBlbiK0aa/wNfsNX9l1erNy8uTkUqwLYxeFn5cLqTeWgtaWjmrYxht
         yDdGZ2BIJ/sCIQ6/2Q4KjsSGsscBcmqGcdQh2BIGLhF5ijS0eKrwS8PnTUglapbWz3
         w6nnNZmwkDqvABjCwkfZ4WZEg2gAphmJIP43zj7zEmc3mio+HR2dnYryz1Z3ezyNrg
         yBvU5aPH6Qjyw==
Date:   Sun, 11 Sep 2022 12:28:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: iio: adi,ad7923: add range-select
 property
Message-ID: <20220911122800.7af5224c@jic23-huawei>
In-Reply-To: <20220909151413.1164754-4-nuno.sa@analog.com>
References: <20220909151413.1164754-1-nuno.sa@analog.com>
        <20220909151413.1164754-4-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Sep 2022 17:14:13 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Document the new property to select the desired analog input range.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> index 40b0a887db57..9041020bdb81 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> @@ -36,6 +36,14 @@ properties:
>      description: |
>        The regulator supply for ADC reference voltage.
> =20
> +  adi,range-select:
> +    description: Selects the analog input range.
> +      0 - 0 to 2xVREF
> +      1 - 0 to VREF
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    default: 1
> +

Would this be better as a flag / boolean called something like
adi,range-double?

>    '#address-cells':
>      const: 1
> =20

