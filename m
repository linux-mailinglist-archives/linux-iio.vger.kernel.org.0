Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5F496CDC
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 17:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiAVQTp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 11:19:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56944 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiAVQTp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 11:19:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB58E60DEE
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 16:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134DDC004E1;
        Sat, 22 Jan 2022 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642868384;
        bh=EswijO1wVL9f4+FV6jWi9kD9qr56NeuCqCyjAFXT5dY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EVNPGrSAcHRTtk7ho41e0ELYNQ6EmOh1UHPCZL93edxsiQb9k8FjR/AXIzX7UY/GL
         po5O2pOdmd/uXnvgLPXPiN1UW5shBHvahNCk186jWvSHPMsdHk1+ZXl1a3k8iKbYug
         yRrR2tzoS5UE6VWNACwmtvoHBfJYFR5C4dbYafxvvKL55yKJ0kMr8m1kJVcnHw6ndn
         tqLULmSA6c25CvR2SB0dhotJ6Q809qZJrs+csLXObquavLpsLn9S2N74pFW66THlB5
         oXB4L3nic0JrAxiI7vkwwzTvyE/HyG0HJH7zwAzkuo3rQ0iX2y0B6OIVbkbQsjLNEA
         uiUNWFJu9mw9A==
Date:   Sat, 22 Jan 2022 16:25:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: add maintainer for ADMV8818 driver
Message-ID: <20220122162554.0dfcdef7@jic23-huawei>
In-Reply-To: <20220117070039.6139-3-antoniu.miclaus@analog.com>
References: <20220117070039.6139-1-antoniu.miclaus@analog.com>
        <20220117070039.6139-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jan 2022 09:00:39 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add myself as maintainer for the ADMV8818 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Series applied to the togreg branch of iio.git and pushed out
as testing as other stuff in there will benefit from being hit
by 0-day.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7cbe2f80e58f..2daa9ec12dc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1154,6 +1154,14 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
>  F:	drivers/iio/frequency/admv1013.c
>  
> +ANALOG DEVICES INC ADMV8818 DRIVER
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> +F:	drivers/iio/filter/admv8818.c
> +
>  ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-pm@vger.kernel.org

