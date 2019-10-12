Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B90D5046
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfJLOD4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 10:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfJLOD4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 10:03:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0352087E;
        Sat, 12 Oct 2019 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570889035;
        bh=kcDvkAYNzsVeMc+o3g7CvzW2e6NgoHIZpi/4XQLiW48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kQW0ERz3Nz5Ds3yvAhMlQum4JJXhAfw8lQU8G2S4UYKxg7L3nmwexwDmVCgkHYB+f
         ZOGgk9RP+W+IB+I6qPelb7mZjY9nXuxFR/cXnTOuf25usfA4gWnPunECU41DSY9wfI
         qbYGJLIVry85vv5wKxvG/Qg3Sk1PKcIFqBLCCxOI=
Date:   Sat, 12 Oct 2019 15:03:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix gyro gain definitions for
 LSM9DS1
Message-ID: <20191012150351.4948d795@archlinux>
In-Reply-To: <69845a7020f584e07cba80c0a1f2ecddc4268d3a.1570439396.git.lorenzo@kernel.org>
References: <69845a7020f584e07cba80c0a1f2ecddc4268d3a.1570439396.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Oct 2019 11:12:13 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix typos in gyro gain definitions for LSM9DS1 sensor
> 
> Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
I tried this one on the fixes-togreg branch and it's not applying so I'll take it in 
togreg and it's another one for you to sort out backports off after the next merge
windows.

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 876f59cedc8b..e8c3922f1b59 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -158,9 +158,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  					.addr = 0x10,
>  					.mask = GENMASK(4, 3),
>  				},
> -				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(245), 0x0 },
> -				.fs_avl[1] = {  IIO_DEGREE_TO_RAD(500), 0x1 },
> -				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
> +				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
> +				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
> +				.fs_avl[2] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
>  			},
>  		},
>  		.irq_config = {

