Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56244E1BAB
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 13:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiCTMig (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiCTMif (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 08:38:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B6E182AE3;
        Sun, 20 Mar 2022 05:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3A8CB80E59;
        Sun, 20 Mar 2022 12:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF55C340E9;
        Sun, 20 Mar 2022 12:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647779828;
        bh=WpQoEogN6iba9hlbQIyPhYzXrakGjrefu/tA7f0BAQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMtMcigyqk3x41651REZUSGoALa/S6ea07FVP0t4CcmIe/by074TEpMLofUIOeYor
         dytcmiq9R6A/anyyyj32qzxxx2R2niIMY9Ytg4VW9TViXv9ycHbavAc2K2z0I/vE9K
         Nd2WoxFmTGVTN2nreXVBN4dfFG118t6h7qPbaZpNmKymX2Uw2lM3BNpzcPz6IYYOjF
         olD0onfT5g+sT6vaBu5SmYMN7ERXHf1I5uQ+RjGEUPGvtMiVyXxoWqhejIP0Gm+jQE
         ibf9vqHXIfZb/ySMIHnRvwZhFn05+FstQkRRWB6Ft/8gY/VouCCMFpPZsLnlxfNcfY
         AinlkVhUHsykw==
Date:   Sun, 20 Mar 2022 12:44:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: iio: sx9324: Add internal compensation
 resistor setting
Message-ID: <20220320124432.69c06b72@jic23-huawei>
In-Reply-To: <20220315173042.1325858-5-gwendal@chromium.org>
References: <20220315173042.1325858-1-gwendal@chromium.org>
        <20220315173042.1325858-5-gwendal@chromium.org>
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

On Tue, 15 Mar 2022 10:30:39 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Allow setting the internal resistor used for compensation.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  .../bindings/iio/proximity/semtech,sx9324.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index cd8ed50f2882a..9a046f62579be 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -126,6 +126,16 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>  
> +  semtech,int-comp-resistor:
> +    description:
> +      Internal resistor setting for compensation.

Can we add any info on how a board designer would choose this value?
What is affect of going higher?

> +    enum:
> +      - lowest
> +      - low
> +      - high
> +      - highest
> +    default: lowest
> +
>    semtech,input-precharge-resistor:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 4
> @@ -165,6 +175,7 @@ examples:
>          semtech,ph01-proxraw-strength = <2>;
>          semtech,ph23-proxraw-strength = <2>;
>          semtech,avg-pos-strength = <64>;
> +        semtech,int-comp-resistor = "lowest";
>          semtech,input-precharge-resistor = <2>;
>        };
>      };

