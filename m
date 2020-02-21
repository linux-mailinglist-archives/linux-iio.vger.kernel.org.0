Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A57167C19
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBUL33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgBUL33 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 06:29:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF25208C4;
        Fri, 21 Feb 2020 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582284568;
        bh=grW6OXb2vxHmgBHZt2eKZCfDKpDOAenLAQU4t1P4nz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QZ7Deo6vVg4qN/GtbQ6Yf4JbRoV8HxU1dDL/rTViw/scch88+RcgIS0Gu5bxKa4c3
         ysItOkNpXFNofa8DTdnFEfQEUiblzWxOQqCkTO4T3ksOB69SRsHTTE1vihX+X2KWig
         3KYr1+bjL0O7ZKAcAGd0JBuN3bvn2E0DO3GPMkow=
Date:   Fri, 21 Feb 2020 11:29:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 07/13] iio: imu: inv_mpu6050: fix sleep time when
 turning regulators on
Message-ID: <20200221112922.7f8e98b4@archlinux>
In-Reply-To: <20200219143958.3548-8-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-8-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 15:39:52 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Turning vdd regulator on requires a consequent sleep for the
> chip to power on correctly.
> Turning vddio regulator is much faster.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

I'm going to retitle this as reduced sleep time rather than fix. 
The reason is to avoid it getting picked up as something we need
to backport.

Applied this and the ones before it I didn't reply to, to the togreg
branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 3502b996671c..63cdde20df7e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1201,7 +1201,7 @@ static int inv_mpu_core_enable_regulator_vddio(struct inv_mpu6050_state *st)
>  			"Failed to enable vddio regulator: %d\n", result);
>  	} else {
>  		/* Give the device a little bit of time to start up. */
> -		usleep_range(35000, 70000);
> +		usleep_range(3000, 5000);
>  	}
>  
>  	return result;
> @@ -1321,6 +1321,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		dev_err(dev, "Failed to enable vdd regulator: %d\n", result);
>  		return result;
>  	}
> +	msleep(INV_MPU6050_POWER_UP_TIME);
>  
>  	result = inv_mpu_core_enable_regulator_vddio(st);
>  	if (result) {

