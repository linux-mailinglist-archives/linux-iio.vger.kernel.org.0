Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6862F4E1BAE
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 13:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiCTMjt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 08:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiCTMjs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 08:39:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0592DD9;
        Sun, 20 Mar 2022 05:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33737B80E59;
        Sun, 20 Mar 2022 12:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182D2C340E9;
        Sun, 20 Mar 2022 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647779903;
        bh=IZfsvkaxMkpn+GE5n6DYnX2fTynW+lK7SLEdNd7EtOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6e+XPDV2ffgeXEWSoOl1riO7vMcXo5cC2rmFRyOZhhxEAGIoF45KdTzmmJgmEj8w
         5wcXPgULCuEeQmhRcZ5S0y4ZtbDYPx6+XdpduPKTiw1FumXzQ3xt4dFDC1zhEJd2w3
         C4aYi11v2uoY8knjeFf7T3a6ZiumrkPk3QhhmqLrzsx/eItSJD0Y/MtlHmJi4VCytN
         wrBy9WpQs+IdQ1VWPOJzUWnKHgenxRzuAqvrNTT6Tj93nbm9yhld8SQDFHlNbbJHnn
         9d52PH80glSbE56hwl7wX1FOBoyxUUm3k78/FCRdqnBTIv4D5xHqo25nRJBjH25AG2
         qpNY1X05HXV1A==
Date:   Sun, 20 Mar 2022 12:45:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: iio: sx9360: Add precharge resistor
 setting
Message-ID: <20220320124546.2ca12ab7@jic23-huawei>
In-Reply-To: <20220315173042.1325858-7-gwendal@chromium.org>
References: <20220315173042.1325858-1-gwendal@chromium.org>
        <20220315173042.1325858-7-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Mar 2022 10:30:41 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Allow configure the resistance used during precharge.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  .../bindings/iio/proximity/semtech,sx9360.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> index 63e1a1fd00d4c..a0f8a454481db 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> @@ -61,6 +61,14 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>  
> +  semtech,input-precharge-resistor:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    description:
> +      Pre-charge input resistance in kOhm.
Another one to make in ohms and give it appropriate prefix so we don't need
the ref line.

Thanks,

Jonathan

> +    minimum: 0
> +    maximum: 30
> +
>  required:
>    - compatible
>    - reg
> @@ -85,5 +93,6 @@ examples:
>          semtech,resolution = <256>;
>          semtech,proxraw-strength = <2>;
>          semtech,avg-pos-strength = <64>;
> +        semtech,input-precharge-resistor = <4>;
>        };
>      };

