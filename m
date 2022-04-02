Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE304F04CB
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357904AbiDBQTc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357901AbiDBQT0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 12:19:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4291814866A
        for <linux-iio@vger.kernel.org>; Sat,  2 Apr 2022 09:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE152B80A3B
        for <linux-iio@vger.kernel.org>; Sat,  2 Apr 2022 16:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C3FC340EE;
        Sat,  2 Apr 2022 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648916252;
        bh=JjiCaLCOtGqxTPWyRFDgeLaIyJeWN08cA4T4oFW6ni0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XzXv0Y+uT/yfeEQsjSfLgXRZ6EfgvI6fonVmeYHW8Xc46NCbcaYUxE5m25ALAKd5o
         6pxgCP4MQXv+ioFVTEY9XM1SRRFGoD4fPmGV5ZVjVGXFzwj94phJWlEzs0uxPTbC7Z
         thJNm9/XdPHMuFTZNcGQrwUBRw2Rt8y7J4GClzvwu9hF1QR8PtZMkfazghgA0VQUbO
         vVeqCNWvErKgI8Na5kXuk6D3qW3yKELBOEf7wq+4EiXz8pclO7TTzrwD3hfnvYKchC
         SetobM75ANLsxpOEYavtERR2imyP62vARKTm68EeycTFRUdviXEGCAlI2K2KLHSBef
         PMBRzWooo8PmQ==
Date:   Sat, 2 Apr 2022 17:25:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Fawzi Khaber <fawzi.khaber@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: Fix I2C init possible nack
Message-ID: <20220402172515.1d1dcee5@jic23-huawei>
In-Reply-To: <20220331091121.2680-1-jmaneyrol@invensense.com>
References: <20220331091121.2680-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Mar 2022 11:11:21 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> From: Fawzi Khaber <fawzi.khaber@tdk.com>
> 
> This register write to REG_INTF_CONFIG6 enables a spike filter that
> is impacting the line and can prevent the I2C ACK to be seen by the
> controller. So we don't test the return value.
> 
> Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>

Jean-Baptiste, this needs your sign-off as well as you were part of the
path the patch is taking to mainline (see the DCO stuff in submitting
patches).

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> index 33d9afb1ba91..9c1e373a5daf 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -18,12 +18,16 @@ static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
>  	unsigned int mask, val;
>  	int ret;
> 
> -	/* setup interface registers */
> -	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
> +	/*
> +	 * setup interface registers
> +	 * This register write to REG_INTF_CONFIG6 enables a spike filter that
> +	 * is impacting the line and can prevent the I2C ACK to be seen by the
> +	 * controller. So we don't test the return value.
> +	 */
> +	regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
>  				 INV_ICM42600_INTF_CONFIG6_MASK,
>  				 INV_ICM42600_INTF_CONFIG6_I3C_EN);
> -	if (ret)
> -		return ret;
> +
Drop this additional blank line.  One is enough!
> 
>  	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
>  				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);
> --
> 2.25.1

