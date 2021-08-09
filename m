Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669D43E4D07
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 21:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhHITYO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 15:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235487AbhHITYL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Aug 2021 15:24:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65C260FDA;
        Mon,  9 Aug 2021 19:23:45 +0000 (UTC)
Date:   Mon, 9 Aug 2021 20:26:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v15 01/13] counter: 104-quad-8: Describe member 'lock'
 in 'quad8'
Message-ID: <20210809202637.4aac5c81@jic23-huawei>
In-Reply-To: <43b4acab9e238638c7067dd4a363a42f94c94ccb.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
        <43b4acab9e238638c7067dd4a363a42f94c94ccb.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Aug 2021 21:37:26 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This adds a kernel-doc comment line describing the 'lock' member of the
> 'quad8' structure.
> 
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Initially I was confused as to when Syed had acked a new patch, but
then realised you have pulled it out of the later spinlock conversion
patch which Syed had indeed acked, so fair enough.

Applied to the togreg branch of iio.git and (unlike yesterday)
pushed out as testing for 0-day to poke at it.
> ---
>  drivers/counter/104-quad-8.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 5283ff128c17..0caa60537b14 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -28,6 +28,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>  
>  /**
>   * struct quad8 - device private data structure
> + * @lock:		lock to prevent clobbering device states during R/W ops
>   * @counter:		instance of the counter_device
>   * @fck_prescaler:	array of filter clock prescaler configurations
>   * @preset:		array of preset values

