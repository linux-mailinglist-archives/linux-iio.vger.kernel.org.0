Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C64A362C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 13:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354754AbiA3MYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 07:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiA3MYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 07:24:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30612C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 04:24:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6CC2B80DEF
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01646C340E4;
        Sun, 30 Jan 2022 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643545442;
        bh=dh4V2i/t3gof15OVJRsffMu55Wy+2GQACjZjP9WXEuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YYXmFOWHszPcUWyJgwGzGoFga7aNDBQaYFy0wqIJdE60CtgqErDWHTTQInnXcMBJN
         6wf8DlYHhT52nuRXTddbrLqDe+vdIMAlzIt/oHTJ/5lRMPQ6OQuHa1QtOSe7vvny0p
         WPYgEHzWJggTQL0dYHYF+bhTxWb9eVwZ9s9RL4T6ewjAD3vQQFq9gl2DI10QthdtMY
         jdNp7+yFjj6v4FkihFceB0Zp3h0t2ucLGmBBuVgsqyD4slOz/Ysski+xlmas8m4tCd
         HHcUXgW31gZ0M4y3DfgC4aQww1LQ4lUTG3r1i1Dvu2qhf1yg4JxdI3LqMYmF1YlHSy
         81S+63gMSbHfQ==
Date:   Sun, 30 Jan 2022 12:30:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, anand.ashok.dumbre@xilinx.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] iio: adc: xilinx-ams: Fix num_channels for PS channels
Message-ID: <20220130123025.5ff021d9@jic23-huawei>
In-Reply-To: <20220119114513.2035609-1-m.tretter@pengutronix.de>
References: <20220119114513.2035609-1-m.tretter@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jan 2022 12:45:13 +0100
Michael Tretter <m.tretter@pengutronix.de> wrote:

> The IIO channels of the PS are not provided in the sysfs even if the
> ams_ps is enabled in the device tree. The reason is that the channels of
> the PS are not added to the overall number of IIO channels.
> 
> The line somehow got lost between v11 and v12 of the patch series.
> 
> Add the number of ams_ps_channels to the number of channels to correctly
> register all channels.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Applied to the fixes togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-ams.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 8343c5f74121..ede968efb77f 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1224,6 +1224,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
>  
>  		/* add PS channels to iio device channels */
>  		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
> +		num_channels += ARRAY_SIZE(ams_ps_channels);
>  	} else if (fwnode_property_match_string(fwnode, "compatible",
>  						"xlnx,zynqmp-ams-pl") == 0) {
>  		ams->pl_base = fwnode_iomap(fwnode, 0);

