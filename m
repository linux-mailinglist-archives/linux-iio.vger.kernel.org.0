Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF753D7A5
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiFDQLt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiFDQLs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:11:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC526C46;
        Sat,  4 Jun 2022 09:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89FFFB806A0;
        Sat,  4 Jun 2022 16:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8165FC385B8;
        Sat,  4 Jun 2022 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359105;
        bh=Vii1C87+3SgMLoNYfvGhWnI077/TCjLSR7uLxLQUZQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tVh/+l3Ah9qCZ5ml0xSDGsmkvYF6lyj8zqLHI6lPF0ReEtakLf8GvwsO9uG4xyDFX
         YrvgSCa010Cf5zqNaa9zpKHUEbPWKm+HF2QbPuM7hPDqZiyfiPxw+SeNUI1TNTK0TV
         AnwD9l3yxx2TiAT42UuXd7W0O+C/Ymbm74DP05OXtIfeTs345Aqr1uQVel+yiEm5FZ
         9mLsk5X0nEfOxhHkzRaMGmByyHdycvErLypD6Jm84S4qCf1rcKguuHkNjsY7cszeiw
         y6K8BQJkJzusFQb9d8hgIn7bPIt5DPcVn2zXzKizA2X2TueLQe9Z038K9lMAjsq9Ai
         TnQxwAzUe19MQ==
Date:   Sat, 4 Jun 2022 17:20:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 03/10] dt-bindings: iio: sx9324: Add precharge
 resistor setting
Message-ID: <20220604172046.3adbadf2@jic23-huawei>
In-Reply-To: <20220429220144.1476049-4-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-4-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 29 Apr 2022 15:01:37 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Allow configure the resistance used during precharge.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
Applied

> ---
> Changes since v4:
> - Add multipleOf propery
> - Move description at the end, to match convension.
> 
> Changes since v3:
> - Added Review tags.
> 
> Changes since v2:
> - Change kOhms into ohms.
> 
> Changes since v1:
> - Suffix field with kOhms unit.
> 
>  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index b8a6ee16854ff..d689b2bab71b4 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -126,6 +126,14 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>  
> +  semtech,input-precharge-resistor-ohms:
> +    default: 4000
> +    multipleOf: 2000
> +    minimum: 0
> +    maximum: 30000
> +    description:
> +      Pre-charge input resistance in Ohm.
> +
>  required:
>    - compatible
>    - reg
> @@ -157,5 +165,6 @@ examples:
>          semtech,ph01-proxraw-strength = <2>;
>          semtech,ph23-proxraw-strength = <2>;
>          semtech,avg-pos-strength = <64>;
> +        semtech,input-precharge-resistor-ohms = <2000>;
>        };
>      };

