Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B364BB93D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 13:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiBRMhA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 07:37:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiBRMg7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 07:36:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A815FF2F;
        Fri, 18 Feb 2022 04:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09869B8261A;
        Fri, 18 Feb 2022 12:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1FCC340E9;
        Fri, 18 Feb 2022 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645187798;
        bh=fVqLYtl67A738/uSuBX10+joEJXj8cfcTX4sEe1vJ+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rR/+7REpgXU5omzPUnkVaW9ElHOwVkcUOkQnLMGUSnroAPGmScL4g7kvOt0KZCXKY
         JkpdIu7McnK/DzmotDQuiVuH5ENuxcD+odFpHxsPh2clD95lfvPGtUhGPckiFqQrUd
         KGWF+BZ4N7w+yrhL28Dfi9xmZEXf3y0U7sg4mbN3UG13WjPqOVW993gWTbDvhd8J6Q
         JPIBReFmZyR/i2brdSurVww97bN4Whapau3uofnP9S85Uddh5Cir0H/sVCBDfnsESM
         UVn0SBWKds96MhhI+1xhUKnd5f+4eCyN4NlCBz8AtG2EKcnVRAzkNWGZz3qbZj7nsC
         vq8yNS/M9BuSw==
Date:   Fri, 18 Feb 2022 12:43:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: adc: microchip,mcp3201: fix interface
 type (I2C -> SPI)
Message-ID: <20220218124327.70efc17d@jic23-huawei>
In-Reply-To: <20220216162312.4064-1-jlu@pengutronix.de>
References: <20220216162312.4064-1-jlu@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Feb 2022 17:23:12 +0100
Jan Luebbe <jlu@pengutronix.de> wrote:

> This family of ADCs uses SPI, not I2C.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Applied.

thanks,
> ---
>  .../devicetree/bindings/iio/adc/microchip,mcp3201.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
> index cbbac4ce56d6..fcc1ba53b20d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Oskar Andero <oskar.andero@gmail.com>
>  
>  description: |
> -   Family of simple ADCs with an I2C inteface.
> +   Family of simple ADCs with a SPI interface.
>  
>  properties:
>    compatible:

