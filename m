Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE16B51667F
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352259AbiEARMx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 13:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiEARMw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 13:12:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C524D9FC;
        Sun,  1 May 2022 10:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F6A60F55;
        Sun,  1 May 2022 17:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF08C385A9;
        Sun,  1 May 2022 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651424965;
        bh=iCvEOmfIs6vrabHhbYrsup5vE6YtFT+aY/0VYIqnBgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hfFGFWdyLb6jTroH0TJ199ZV4cBYWQU0Acuj0v7iGk4W2FdGY9N4qdPQ0NtqNKoKc
         GNmxHMrvS2m50NP73WuB9Nanr1tVwP+rLwCKLQQIBJQEViOtqnHIWi8PXXMPfwB1Po
         9nRt2ekBkojqnkh7EBqtaVfSUtBXcQ7kolWrCHIlyck4jLvZNRi1GCjt2G9CpQyp9U
         hBbiR+ReIfbe+QPbluZw3FVZVONMzmYyoZF5u/DmMdyC0uDrg0g25ukXQ6kgX/O781
         toKupkvIA5+RpXoR43vIyhQoH+Q2rEebJBhUXpV7XZTAv1GJZvWp/zM+55swDcwRl2
         EQANjwDNZCYKQ==
Date:   Sun, 1 May 2022 18:17:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/10] dt-bindings: iio: sx9324: Add input analog
 gain
Message-ID: <20220501181741.5dd3bf26@jic23-huawei>
In-Reply-To: <20220429220144.1476049-8-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-8-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 29 Apr 2022 15:01:41 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Allow setting the configure the input analog gain.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Hi Gwendal.

So, my immediate thought on this is whether it make sense as a
dt controlled thing or not. It's the sort of thing hardwaregain
is for in the userspace ABI. However, I see that's already
in use for the digital gain. This one also unhelpfully applies
to all changes whereas the digital gain is pair wise. Hence
there is basically no way we can map the two controls to a
single ABI element.

So, how would we expect a board designer to set this value?

If the answer is we basically have no idea but some boards do
want it set then I'm fine with this basically being a somewhat magic
value that is in some vague way associated with the antenna setup...

Jonathan

> ---
> New in v5.
> 
>  .../bindings/iio/proximity/semtech,sx9324.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index 0be87ac05b97a..d265eb5258c84 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -143,6 +143,17 @@ properties:
>      description:
>        Pre-charge input resistance in Ohm.
>  
> +  semtech,input-analog-gain:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description: |
> +      Defines the input antenna analog gain
> +      0: x1.247
> +      1: x1 (default)
> +      2: x0.768
> +      3: x0.552
> +
>  required:
>    - compatible
>    - reg

