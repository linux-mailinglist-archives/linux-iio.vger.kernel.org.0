Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE36139BC9
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 22:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMVnX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 16:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgAMVnX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 16:43:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AF420CC7;
        Mon, 13 Jan 2020 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578951802;
        bh=5pXMYL26hJICNomi0biZj5KDrYRSotbgIK93VKbdwXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uWUjeE+/UI4G2g/wkDCT/oRwL7XQIMEvpN06sNb4xswumR/5UZxL+hLQDXmJGF1cu
         9DQyCyit5GsXL0MGbMEkBWGHDxPo4nV+uM2A4YNfnwk1rercwIwnLdvnIdYxWAbh7R
         PsL8MUmUF2rFMeUr7tTKDFkWq1/AfhA/8L6/lzjk=
Date:   Mon, 13 Jan 2020 21:43:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: check return value from
 st_lsm6dsx_sensor_set_enable
Message-ID: <20200113214318.22e40bdb@archlinux>
In-Reply-To: <3a7c5182cd676230eadb11510aee7317ce1b4e34.1577954098.git.lorenzo@kernel.org>
References: <3a7c5182cd676230eadb11510aee7317ce1b4e34.1577954098.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Jan 2020 09:36:29 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add missing return value check in st_lsm6dsx_read_oneshot disabling the
> sensor. The issue is reported by coverity with the following error:
> 
> Unchecked return value:
> If the function returns an error value, the error value may be mistaken
> for a normal value.
> 
> Addresses-Coverity-ID: 1446733 ("Unchecked return value")
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I'm going to interpret this as a cleanup / warning supression rather
than a fix and so take it through the togreg branch.  With those fixes
tags it may well get picked up for stable.  I'm not against that
but I'm not going to explicitly tag it for stable either.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 0c64e35c7599..a16395598754 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1534,8 +1534,11 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  	if (err < 0)
>  		return err;
>  
> -	if (!hw->enable_event)
> -		st_lsm6dsx_sensor_set_enable(sensor, false);
> +	if (!hw->enable_event) {
> +		err = st_lsm6dsx_sensor_set_enable(sensor, false);
> +		if (err < 0)
> +			return err;
> +	}
>  
>  	*val = (s16)le16_to_cpu(data);
>  

