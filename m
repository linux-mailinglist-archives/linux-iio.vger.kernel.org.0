Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB06614A2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 11:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjAHK54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 05:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjAHK5z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 05:57:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB99140FE
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 02:57:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6873360C59
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 10:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D8C433D2;
        Sun,  8 Jan 2023 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673175473;
        bh=4hwwv1V4LuHFJiL0/NTZ1kqZFRvIVVJxmM5MHNbL6Q4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dM0ojoP85AgBr0T4lrMWbXM6rYI1rvz1lHRGcN0302U655mJQqwkh0G0A1wkI1NTX
         VducQ9mDoA9MUXNb8Kig4XBZxPCTblDPJOUx+DZr6YobyYwWnbd6TjX4p71JCQYEa7
         qVDWUzDOSMKaI7FOpCwWZyMbIi8yGcGUdOUvTgbC//pAHk7J1kEZ8Xev+n3Qe3pdHh
         EL7kozw8ascHW25Vsa2ieyYuZOSz1AZKSIjx869nyIiNgxM00+3PhB4kKZQKuIOG/r
         c95pGF3wuSemc+2cgNrrKUqT6zNmvxNIao9Gm0Gomde+cMRl1D6sIoui9Bod4dsMnA
         4XthvirvBX8Yg==
Date:   Sun, 8 Jan 2023 11:11:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] counter: intel: Depend on X86
Message-ID: <20230108111122.4abdadf5@jic23-huawei>
In-Reply-To: <20230108074750.443705-2-pbrobinson@gmail.com>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
        <20230108074750.443705-2-pbrobinson@gmail.com>
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

On Sun,  8 Jan 2023 07:47:48 +0000
Peter Robinson <pbrobinson@gmail.com> wrote:

> Limite the Intel counter driver to X86, it doesn't
> make sense to build it for all arches if the couner
> subsystem is enabled.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Probably better to go with
depends on X86 || COMPILE_TEST

Sometimes other compilers throw up issues that are missed by those
targeting a specific architecture.  Obviously this is less important
for x86 drivers than more obscure platforms, but meh the principle still
stands.

Jonathan


> ---
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 508d857808e9..011e6af840fc 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -41,6 +41,7 @@ config FTM_QUADDEC
>  
>  config INTEL_QEP
>  	tristate "Intel Quadrature Encoder Peripheral driver"
> +	depends on X86
>  	depends on PCI
>  	help
>  	  Select this option to enable the Intel Quadrature Encoder Peripheral

