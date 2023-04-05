Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC56D7EF0
	for <lists+linux-iio@lfdr.de>; Wed,  5 Apr 2023 16:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjDEOOv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Apr 2023 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbjDEOOn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2023 10:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2193130FF;
        Wed,  5 Apr 2023 07:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E075624D0;
        Wed,  5 Apr 2023 14:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ED5C433EF;
        Wed,  5 Apr 2023 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680704047;
        bh=rlsnlTjUd1xSpPxfqawqeam3IRXFhwsuItYDlF3U898=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQREMqqHHX+JGuqgGaXqC6GZ+iNAHNnHWk3a0XQDVO45QOFtbiJPrO/ULgtJ6npoa
         YXeuz8zFrxVPgJlgpwpvN0gBslIancgiQ3PhvF1iJpM2iaTtm0UvHf31z3Tw0P+U0X
         /Z8+/4m0xpNHwee3qV08nxPeceeo3yW8x7LQ2Knwu4F9R/mFYoqPZ2QeTRELDBobRw
         LIYf5WaLOnt4+evfxsxN13NbQcYZKr6L2VHJhp34SppJSobz0scOdUTbzadDDeI95a
         sIRtPMppQqM7LgCXDhdavxVNYtB9Jso/YRMREHAzUCqRfjw2iDO+8uW0nL5bHra37B
         C9d8p5iWM278A==
Date:   Wed, 5 Apr 2023 15:14:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v15 3/6] Documentation: ABI: sysfs-bus-counter: add
 cascade_counts_enable and external_input_phase_clock_select
Message-ID: <20230405141402.GI8371@google.com>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330111632.169434-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Mar 2023, Biju Das wrote:

> This commit adds cascade_counts_enable and external_input_phase_
> clock_select items to counter ABI file.
> (e.g. for Renesas MTU3 hardware used for phase counting).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
> ---
> v14->v15:
>  * No change.
> v13->v14:
>  * No change.
> v12->v13:
>  * Updated kernel version from 6.3->6.4 as it is too late.
> v11->v12:
>  * No change
> v10->v11:
>  * No change.
> v9->v10:
>  * Added Rb tag from William Breathitt Gray
> v8->v9:
>  * Added available blocks for external_input_phase_clock_select_available
>  * Removed the "This attribute" from the external_input_phase_clock_select
>    description, and capitalize the word "counter" from description.
>  * Removed the "This attribute" from the cascade_counts_enable description,
>    and capitalize "counts" and "counter"
>  * Moved these device-level configuration blocks to top of the file.
> v7->v8:
>  * Replaced cascade_enable->cascade_counts_enable
>  * Updated commit header and description
>  * Added external_input_phase_clock_select_available entry for driver-
>    specific enum attribute and created a new entry block for it.
>  * Add a line stating cascade_counts_enable is a boolean attribute.
>  * Added missing 'component_id' suffix.
> v6->v7:
>  * Replaced long_word_access_ctrl_mode->cascade_enable
>  * Updated Kernel version
> v5->v6:
>  * No change
> v5:
>  * New patch
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 32 +++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Applied, thanks

--
Lee Jones [李琼斯]
