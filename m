Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB805527252
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiENO6J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiENO6G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 10:58:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7911F606;
        Sat, 14 May 2022 07:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10D65B8090A;
        Sat, 14 May 2022 14:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB82C34115;
        Sat, 14 May 2022 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652540282;
        bh=id9kGhQSkeF5O+3klfSkwzYJE2yXleUyS83qSJgyotg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e86oykHJkH0X2No2GLCU65VI4b5gnZ7SrlM+c6BczSIUNTzzXc6WQEo0UcddZSaQ0
         UH3praGYhn5wLGzkjYtSB3WalATmQ+DSb4+Z7qNnRnnaZAfHV69AvtIspyM9iRcvUC
         6tdeIpYwkNwB2FIpw8jgo8MfyaH2nhOUE+XjbN3bNCq14cbQlv+VuJD4d5SzmzvrgL
         YiAuPznzVSC0yvvA0y4EjJ+YJakvg3qOtkkcfVfTGzkwu0UgLC5Eu2w4xE7I+qSnub
         GJBkGcW1DF098h9KMQyqRWLTyN7UVprn2g388L/EMfz7Cyy/lgNP/EeanDMj7rfNLD
         g23ASn3pLloVg==
Date:   Sat, 14 May 2022 16:06:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v4 0/2] Add RZ/G2UL ADC support
Message-ID: <20220514160636.0db097d9@jic23-huawei>
In-Reply-To: <20220511082325.36185-1-biju.das.jz@bp.renesas.com>
References: <20220511082325.36185-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 May 2022 09:23:23 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> This patch series document ADC found on RZ/G2UL SoC and also removes
> unnecessary channel check from rzg2l_adc_read_label().
> 
> v3->v4:
>  * Removed unnecessary SoC specific reg description as it is
>    equivalent to the logic used in reg.
>  * Removed Items from reg.
> v2->v3:
>  * Added generic description for reg.
>  * Improved schema validation by restricting both channel and reg to [0-1].
>  * Added Rb tag from Geert.
> v1->v2:
>  * Started using generic compatible for RZ/G2UL and added SoC specific validation
>    for number of supported channels.
> 
> Biju Das (2):
>   dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
>   iio: adc: rzg2l_adc: Remove unnecessary channel check from
>     rzg2l_adc_read_label()
> 
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 30 ++++++++++++++++---
>  drivers/iio/adc/rzg2l_adc.c                   |  3 --
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 

Looks good to me. I'll give some more time for dt-binding review before
applying though.

Thanks,

Jonathan
