Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D120E5278D4
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiEOQxX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEOQxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 12:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF942CC91;
        Sun, 15 May 2022 09:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E678DB80D0F;
        Sun, 15 May 2022 16:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5196C385B8;
        Sun, 15 May 2022 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652633599;
        bh=hJF+NLEfw4w89l30YcNd/EuLrWGLZxHgPY6Jc4ksRHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D1PuFRBz65lKDm3TkPyWJTGBBUp/mZ0w5fTJa+tqjlXiZ6QSoqbTSfPIh6pg9AgBY
         bXFbpvzWI8wKngSjXfnEKxV5lFkgVwsGjYNwbGwnbB+5MhyBWLtclEtmxPgLpw8peE
         7qjWcC8sR0vqfStUa+qpX9XE8uXZgmu5W2lKDLaeIrFaFr6bl281uYDHLcVRq7F4z4
         pty1+AZbf1EPNAOsTe/TIKlYiMFxkJJWex7oyNQYcEQL5K5rqGzhrSN/EgxOX4FtVe
         YXmHIMLMZZihPjOxRZ6ll0X7egeffiTgBTWLHwieoySJKs+i1pNsGPIzNETm6nbc6q
         +u5fNiGZo9zhA==
Date:   Sun, 15 May 2022 18:01:54 +0100
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
Subject: Re: [PATCH v5 0/2] Add RZ/G2UL ADC support
Message-ID: <20220515180154.6e7b1162@jic23-huawei>
In-Reply-To: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
References: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 May 2022 07:03:34 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> This patch series document ADC found on RZ/G2UL SoC and also removes
> unnecessary channel check from rzg2l_adc_read_label().
> 
> v4->v5:
>  * Removed redundant "type:object"
>  * Added Rb tag from Krzysztof Kozlowski
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
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 ++++++++++++++++---
>  drivers/iio/adc/rzg2l_adc.c                   |  3 --
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 

Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if we missed anything.

Thanks,

Jonathan
