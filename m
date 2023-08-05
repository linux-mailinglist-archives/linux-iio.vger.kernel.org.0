Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8A7710A4
	for <lists+linux-iio@lfdr.de>; Sat,  5 Aug 2023 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjHEQwG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Aug 2023 12:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHEQwF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Aug 2023 12:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B96E6A
        for <linux-iio@vger.kernel.org>; Sat,  5 Aug 2023 09:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB8B660C15
        for <linux-iio@vger.kernel.org>; Sat,  5 Aug 2023 16:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B619C433C7;
        Sat,  5 Aug 2023 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691254323;
        bh=4sh43qTwr2m5s3LNFnayv2BKdBVvlM/fDGzOZTi0ldU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RmglqxNV2yzawBds6wj/s1zBSRYuQzFALQtKT6Qh3CyLqzyJylLnPGjgdlgHxXMBr
         sVKZkGNeiLljUZEqAQg+/jPuIx31FdDJj88g0cB5wh1S2tM1nbTseeDGKEseAutPi0
         Qot32AV4LaCFR6vwVOxr6PLTu4WEuO6jh9aulQFiFqyJKZ/8+dTDLKHt1mI6oaf5Fj
         c1tLETrhHMCIdVLo/V9LayiHKUhP7u/sug8DxQc07xrFpOAqBDOS6yW0AU4Ow+lD8F
         sD+PvoZSh521gr4TNWnzYB2MrlgigZ3J1DzZg+3BIxZg2WPUrf6hKXqeL/2v/Nhmuj
         jB/o+lKkUrmdw==
Date:   Sat, 5 Aug 2023 17:51:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio: adc: men_z188_adc: Remove redundant
 initialization owner in men_z188_driver
Message-ID: <20230805175156.5b696e8e@jic23-huawei>
In-Reply-To: <20230804100938.100435-1-lizetao1@huawei.com>
References: <20230804100938.100435-1-lizetao1@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Fri, 4 Aug 2023 18:09:38 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> The module_mcb_driver() will set "THIS_MODULE" to driver.owner when
> register a mcb_driver, so it is redundant initialization to set
> driver.owner in men_z188_driver statement. Remove it for clean code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/men_z188_adc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
> index adc5ceaef8c9..198c7e68e0cf 100644
> --- a/drivers/iio/adc/men_z188_adc.c
> +++ b/drivers/iio/adc/men_z188_adc.c
> @@ -161,7 +161,6 @@ MODULE_DEVICE_TABLE(mcb, men_z188_ids);
>  static struct mcb_driver men_z188_driver = {
>  	.driver = {
>  		.name = "z188-adc",
> -		.owner = THIS_MODULE,
>  	},
>  	.probe = men_z188_probe,
>  	.remove = men_z188_remove,

