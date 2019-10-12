Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9CD4FB8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfJLMad (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLM2d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:28:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208E32089F;
        Sat, 12 Oct 2019 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570883312;
        bh=0ReNxhftJOF60VkFLiQmAsnmky8PfTo6E4U2X+8k41g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D8gEPKvSgKo1KNiB39htE13HMYIjaMS7y5jzFkx87nkognyWPBEeglSyglWvPMiUe
         d6l/RlFCvcgyP2GkYAJ4NyhC0SwMDSlSRU6NzDUt4hOq9vi/p5B1lY2RSnyfV9DdMb
         TJx3uxsCjmswOqS1fo+kZLSMAz5plAHXgxGraUmY=
Date:   Sat, 12 Oct 2019 13:28:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 13/13] iio: imu: st_lsm6dsx: enable wake-up event for
 LSM6DSO
Message-ID: <20191012132827.0a8a7335@archlinux>
In-Reply-To: <a67031c30724002724209dc1e0bba3c53c53a2a5.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <a67031c30724002724209dc1e0bba3c53c53a2a5.1570367532.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:22:07 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add missing wake-up register info for LSM6DSO/LSM6DSOX sensor
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a2a0ac81e3d3..876f59cedc8b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -780,6 +780,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x56,
>  				.mask = BIT(6),
>  			},
> +			.irq1_func = {
> +				.addr = 0x5e,
> +				.mask = BIT(5),
> +			},
> +			.irq2_func = {
> +				.addr = 0x5f,
> +				.mask = BIT(5),
> +			},
>  			.hla = {
>  				.addr = 0x12,
>  				.mask = BIT(5),
> @@ -847,7 +855,22 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.slv0_addr = 0x15,
>  			.dw_slv0_addr = 0x21,
>  			.batch_en = BIT(3),
> -		}
> +		},
> +		.event_settings = {
> +			.enable_reg = {
> +				.addr = 0x58,
> +				.mask = BIT(7),
> +			},
> +			.wakeup_reg = {
> +				.addr = 0x5b,
> +				.mask = GENMASK(5, 0),
> +			},
> +			.wakeup_src_reg = 0x1b,
> +			.wakeup_src_status_mask = BIT(3),
> +			.wakeup_src_z_mask = BIT(0),
> +			.wakeup_src_y_mask = BIT(1),
> +			.wakeup_src_x_mask = BIT(2),
> +		},
>  	},
>  	{
>  		.wai = 0x6b,

