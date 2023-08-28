Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECCF78B2ED
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjH1OWn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 10:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjH1OWL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 10:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A7110;
        Mon, 28 Aug 2023 07:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1DD64210;
        Mon, 28 Aug 2023 14:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E2AC433C8;
        Mon, 28 Aug 2023 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693232528;
        bh=Uh9Inux16p3BirUM51qFE6ZZJGMGzxsoHOYPszqTF5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jLWU5EXHjiZvdSevIopzAYmOctoRxD1kFLyaPw76TgSeuJbukwtbXI6UAa0iikQ2e
         DCn181B/yk3pyvndRnTn1DCt/9NrF6e7o8gFTSau0CmlebZ7aYtNi5vwWHqaCfw3UI
         fEnHw0gCvBkvjSeEXqD4oWJMV8RwSlovg5nCbFqSezoS0SE46iOcKG3brC2VK34jOE
         54SxlUYdIDkcG6Y1gFKVK2S58glpDWhvqd6dDw6e5PmjACWWFHVmwlhSpITusFQ576
         TejyMRV3Hg95JoWFqxRf0i6BJONIAnb5lOSEGElI/bdMYyOfxtIiNsFnb9zXyQp2kQ
         rFRIH95G+d8Vw==
Date:   Mon, 28 Aug 2023 15:22:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: magnetometer:
 asahi-kasei,ak8975: Drop deprecated enums
Message-ID: <20230828152226.3c085067@jic23-huawei>
In-Reply-To: <20230818075600.24277-4-biju.das.jz@bp.renesas.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
        <20230818075600.24277-4-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Aug 2023 08:55:58 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Drop deprecated enums from bindings as it is been here for a long time.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Applied patches 1-3

Thanks,

Jonathan

> ---
> v2:
>  * New patch
> ---
>  .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> index 9790f75fc669..ee77558e9800 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> @@ -18,13 +18,6 @@ properties:
>            - asahi-kasei,ak09911
>            - asahi-kasei,ak09912
>            - asahi-kasei,ak09916
> -      - enum:
> -          - ak8975
> -          - ak8963
> -          - ak09911
> -          - ak09912
> -          - ak09916
> -        deprecated: true
>  
>    reg:
>      maxItems: 1

