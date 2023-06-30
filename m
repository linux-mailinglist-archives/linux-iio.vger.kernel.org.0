Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511927435E1
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjF3Hgj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjF3HgI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 03:36:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655EC268A
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 00:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE225616DA
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 07:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A059C433C8;
        Fri, 30 Jun 2023 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688110566;
        bh=Fo79Mj6tAA5XpINSMp2N6dUv1xlVL4akEk3gPGx0dq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okEUuHSt/tyxTU1r0FrapEnz44JIiWkOvAMenmfHzP76KamJahIygP6yozCxc/fND
         lwhMTvIz5Ykl+OfM5weJ8d0Ap8Z8LxidyvArUDPfNW+71o55UaF0GmrwN0Z0E5Sj7j
         BPnE4RtsP+QVBHhl81pLYx+QBtimhjxLvvh3VJ8oJlUJ3lD/vLUO5/K8RiuAiGPkeE
         toqoeedWhzPqqLYblbOkY0+9ZD2E/BrecuEG6RaNCBTTgjZTobSn3Gzcp/5LwQGHiK
         9lnPHa1y3F/hRweIgot+rDXX9B53ESr6K8WSb07tf8ITs7Ad1RPBRY5RIuBxLCLO5l
         f55YL2HjfkTpA==
Date:   Fri, 30 Jun 2023 15:36:01 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Yiyuan Guo <yguoaz@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@chromium.org, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] iio: cros_ec: Fix the allocation size for
 cros_ec_command
Message-ID: <ZJ6F4THLoYy6S8HP@google.com>
References: <20230629132405.1237292-1-yguoaz@gmail.com>
 <20230630063132.314700-1-yguoaz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630063132.314700-1-yguoaz@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 30, 2023 at 02:31:32PM +0800, Yiyuan Guo wrote:
> The struct cros_ec_command contains several integer fields and a
> trailing array. An allocation size neglecting the integer fields can
> lead to buffer overrun.
> 
> Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>

You could attach my R-b tag as v2 has no major changes from v1.

> ---

Always a good practice to put changelog here.  Search "changelog" in [1].

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> @@ -253,8 +253,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	state->ec = ec->ec_dev;
> -	state->msg = devm_kzalloc(&pdev->dev,
> -				max((u16)sizeof(struct ec_params_motion_sense),
> +	state->msg = devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
> +			max((u16)sizeof(struct ec_params_motion_sense),
>  				state->ec->max_response), GFP_KERNEL);

While looking at the patch again, I found a nit.  Please align the code by
adding an extra tab before "max".
