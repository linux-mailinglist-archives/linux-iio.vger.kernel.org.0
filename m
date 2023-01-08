Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59A6614B2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 12:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjAHLRW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 06:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAHLRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 06:17:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0BAB4A4
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 03:17:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3651B8085C
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 11:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE591C433D2;
        Sun,  8 Jan 2023 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673176637;
        bh=iZIz6ZTIhutSgpOkrhiliF8K1ISbGo3f+AxDxgrPfi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mgisAHRxSO1XdTy64hEWL8Ctx3QYDZjeT92UIefqsKXJCKbeMjpLQnTFGzFe/Y9zM
         Ys2VYZN0pwWAochyxnR8hcxH50JjHo03ok3tNFTVOjOQKFGHBw+FD+h5lWjbAXKTtc
         oqR6KAxiAd+cz/uO1yF3RldoFxR9JhNV1KO1WZt1qXPXd+dMiU/XHGBUOxmO69w6m6
         edKD+rz7Zoy+26//pGUyVr7JbfL0jiz3ThxZynj0WhlSVyp1IOnZRiCn0DC10jM0cB
         RsuOFumDY2HX73OiNiiSOlF7rWasqaWzCNVHz3Awf4ZR4qjEC5zAoaTNvBEZXrZLPL
         kikdLcsuF7XHA==
Date:   Sun, 8 Jan 2023 11:30:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] counter: FTM quad: Depend on the Layerscape SoC
Message-ID: <20230108113046.461ec222@jic23-huawei>
In-Reply-To: <20230108074750.443705-3-pbrobinson@gmail.com>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
        <20230108074750.443705-3-pbrobinson@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  8 Jan 2023 07:47:49 +0000
Peter Robinson <pbrobinson@gmail.com> wrote:

> At the moment only the Freescale LS1021A is the only HW that
> supports this IP block so add an appropriate dependency and
> compile test.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Ah I see you had deliberately not put COMPILE_TEST for the x86
one - fair enough I guess.

For this one, the IP is fairly generic and I think appears on other
chips - not sure they are supported by Linux however.  Maybe it's
fine to limit it like this for now and see if anyone shouts...

Jonathan


> ---
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 011e6af840fc..ef78386ccd2e 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -31,6 +31,7 @@ config 104_QUAD_8
>  
>  config FTM_QUADDEC
>  	tristate "Flex Timer Module Quadrature decoder driver"
> +	depends on SOC_LS1021A || COMPILE_TEST
>  	depends on HAS_IOMEM && OF
>  	help
>  	  Select this option to enable the Flex Timer Quadrature decoder

