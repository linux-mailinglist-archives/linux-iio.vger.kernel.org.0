Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB3754EC0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jul 2023 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGPNKi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jul 2023 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNKh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 09:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9D1AA
        for <linux-iio@vger.kernel.org>; Sun, 16 Jul 2023 06:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4C7960C96
        for <linux-iio@vger.kernel.org>; Sun, 16 Jul 2023 13:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D7EC433C8;
        Sun, 16 Jul 2023 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689513036;
        bh=fcGv7rvewm5CT9q7nLoHmQhGvABlapDTnrh/om4jAIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pnkM/ryH82SM83fH4dA+iUgucBGF+FxFZJYK5l1L/4fgFXxSWzJKVJJd81/kWni3V
         fK5upXBVqkp8LOqtVZcNCNAolSye/2HGm8k80MQPf4YNNnww7460b/LK2nc7hZyOyC
         ugITv5SMF3sUETWcRm+qg2PsDlpuYQz2SKOyUs+kFYhEtjznzsgZYDuRbjBGFElAAw
         mr7co5O0Hehtc42lWX/tVHIYlvR/bV6fKjLzuezj/kRGsZWdr/PrZigH488dOCRP9z
         gIOoPxXRVkvuKV+nOhChB4N7DFVpBoHOrDe++xv9wJUlWDjhY8o4r8BRy6N/+LmJ9Z
         8tI5rAtSRNuPA==
Date:   Sun, 16 Jul 2023 14:10:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yiyuan Guo <yguoaz@gmail.com>
Cc:     tzungbi@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@google.com, dianders@chromium.org, mazziesaccount@gmail.com,
        gwendal@chromium.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for
 cros_ec_command
Message-ID: <20230716141028.4c57c5c7@jic23-huawei>
In-Reply-To: <20230630143719.1513906-1-yguoaz@gmail.com>
References: <20230630143719.1513906-1-yguoaz@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Jun 2023 22:37:19 +0800
Yiyuan Guo <yguoaz@gmail.com> wrote:

> The struct cros_ec_command contains several integer fields and a
> trailing array. An allocation size neglecting the integer fields can
> lead to buffer overrun.
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>

Hi. I'm sitting on this one for a couple of reasons.
1) No fixes tag (replying to this thread with one is fine)
2) Various people commented on earlier versions, and I'm waiting for them to confirm
they are fine with this version.

If I hear nothing in a few more weeks I'll try and figure out the
fixes tag + whether all the reviewer comments have been addressed.

Jonathan

> ---
> v2->v3: 
>  * Added R-b tag from Tzung-Bi Shih
>  * Aligned the code by adding an extra tab before "max"
>  * Added a patch changelog
> v1->v2: Prefixed the commit title with "iio: cros_ec:"
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 943e9e14d1e9..b72d39fc2434 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -253,7 +253,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	state->ec = ec->ec_dev;
> -	state->msg = devm_kzalloc(&pdev->dev,
> +	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
>  				max((u16)sizeof(struct ec_params_motion_sense),
>  				state->ec->max_response), GFP_KERNEL);
>  	if (!state->msg)

