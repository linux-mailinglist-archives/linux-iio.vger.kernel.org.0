Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AA46E0FD9
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDMOVj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDMOVi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 10:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2D4359D
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 07:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9BA63F08
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 14:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD485C433EF;
        Thu, 13 Apr 2023 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681395696;
        bh=10Uxa4k36DnSix4curU8Nx8Xy1yj5PT2NfzgOwKksuU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nkJup+/pZ5GLXYAfeYa58M3SySmt9H62M1dsrahyZtH4cF0npBMZJJ5PefIGh9BSd
         mUkoD606x+JLAGGRa4UW68g44ROW6ZuU31pXMAQPFH0mcmu1/cgr+Nr6ExU7K68MGO
         34Srv3p5IHQPS0Ae1diQRGpQWsA/K6Mr1KcqxRmtVaq7eAeMiHQdSuT/5lIfVHvvpa
         xGSjHxlp5/O4Kdvhb7Etr74qXHFCTD/oq/HGnvQfWzYcbduah7PZbTmvUxAMOcVAPu
         GhJqxMzKQwOT/NEt+HM/sSYfafK+a0fUZTuq/FtvP5llMPw89Zc6W0vce+NyilZK51
         BFPqX5P3bmFRw==
Message-ID: <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org>
Date:   Thu, 13 Apr 2023 16:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
 <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
 <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13/04/2023 10:36, Fabrizio Lamarque wrote:
> Added undocumented properties:

Use imperative.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> - adi,clock-xtal
> - adi,int-clock-output-enable
> 
> Removed clocks from required properties.

Why?

> Renamed avdd-supply to vreg-supply, while keeping backward compatibility
> (deprecated avdd-supply).

Why?

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You decided to ignore quite a lot of entries, but most important - also
lists, so it won't even be tested.


> 
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 28 +++++++++++++++----

Bindings are always separate patches.

>  drivers/iio/adc/ad7192.c                      | 18 ++++++------
>  2 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index d521d516088b..5dc7a7eea5f9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -32,7 +32,9 @@ properties:
> 
>    clocks:
>      maxItems: 1
> -    description: phandle to the master clock (mclk)
> +    description: |
> +      phandle to the external master clock (mclk). If not defined, internal
> +      clock is selected.
> 
>    clock-names:
>      items:
> @@ -45,7 +47,23 @@ properties:
>      description: DVdd voltage supply
> 
>    avdd-supply:
> -    description: AVdd voltage supply
> +    description: Phandle to reference voltage regulator. Use
> vref-supply instead.

Corrupted patch.

Run checkpatch, test your patches with dt_binding_check. This really
needs a lot of work.

Best regards,
Krzysztof

