Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9948F78A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 16:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiAOPlc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 10:41:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32768 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiAOPlb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 10:41:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87508B8092A
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 15:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC81BC36AE7;
        Sat, 15 Jan 2022 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642261289;
        bh=1KRao/VxmwSEUptCXxREnj4rjT6mEcHAyhmDT/IJG2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K7Osu6Owu84gsoL+QXFLwgkNbbEN3VNjM9mdjpP3mAG6cuIVjIA6tEV1tYzhccI1T
         gj9ltpuYevMgqV3PrNZT/LTPHrX1CXeDlqZ1GFRRiLVzDinIZEumN7iUG1pVNs3zur
         fdJ6IszyiZtICgXH3cK+TbgTUP622JptZAKCnx2bDCmEeZhCoaaYEvchpyUaFewsOQ
         rxJL5yIszXdegvhkeeXzkHQO/sgk4vB7KSNsvmWrQTd0P8J5cPBcR636IQ38FZCyit
         WBMrKSly5Awe5/E5KLOhH3+5PiOPmjAWkXsPluWbZtUWScY9kK7Q22D4f8cjFpLfUH
         FnlJv83PXM2sw==
Date:   Sat, 15 Jan 2022 15:47:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 01/10] iio: core: Fix the kernel doc regarding the
 currentmode iio_dev entry
Message-ID: <20220115154713.2f9f25fb@jic23-huawei>
In-Reply-To: <20211215151344.163036-2-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-2-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Dec 2021 16:13:35 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

Sorry for taking so long to get to these. I knew some of them were
likely to take some thinking so they kept falling at the end of
my review list and I kept running out of time / energy!

Anyhow, time to make some progress.

> This is an internal variable, which should be accessed in a very
> sporadic way and in no case changed by any device driver.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Hohum.  Plenty of history around this one but I think you are right
that it now makes sense to mark it as INTERN (and when we can move it
over to the opaque structure).

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 324561b7a5e8..06433c2c2968 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -488,7 +488,7 @@ struct iio_buffer_setup_ops {
>  /**
>   * struct iio_dev - industrial I/O device
>   * @modes:		[DRIVER] operating modes supported by device
> - * @currentmode:	[DRIVER] current operating mode
> + * @currentmode:	[INTERN] current operating mode
>   * @dev:		[DRIVER] device structure, should be assigned a parent
>   *			and owner
>   * @buffer:		[DRIVER] any buffer present

