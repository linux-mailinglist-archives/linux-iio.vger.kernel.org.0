Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6458619E61D
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgDDPgE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgDDPgE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:36:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234E720644;
        Sat,  4 Apr 2020 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586014563;
        bh=YvpOIbxfgrOj69WNcoVGwAEOdWS6W1rIA8WTBpAGWa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cIxA7hYW+6eNHUC6ypv+l1z5OO/D1kSJsJ9NttIKEdhPBxLERoyJwpIW5v3xjDH4N
         a71cjwLsnjNoAbrDvYaqa06Nq0JuPZ0L2s/Z3UghmtAgk3Cg2Hj48w0A2h3SOLms/N
         vsaClnowrAIAh5M1trV2kdGpUQzJf43VCnO0uyh0=
Date:   Sat, 4 Apr 2020 16:36:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: Increase ODR_LIST_SIZE
Message-ID: <20200404163600.6e0bf090@archlinux>
In-Reply-To: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
References: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 22:52:25 +0100
Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:

> Support for sensor with up to 8 different ODR settings.
> Required for supporting LIS3MDL as sensor hub slave device.
> 
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index f2113a63721a..38b613072da2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -111,7 +111,7 @@ struct st_lsm6dsx_odr {
>  	u8 val;
>  };
>  
> -#define ST_LSM6DSX_ODR_LIST_SIZE	6
> +#define ST_LSM6DSX_ODR_LIST_SIZE	8
>  struct st_lsm6dsx_odr_table_entry {
>  	struct st_lsm6dsx_reg reg;
>  

