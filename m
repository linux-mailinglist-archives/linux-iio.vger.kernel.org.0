Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6309F3CE
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 22:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfH0UKo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 16:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0UKo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 16:10:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9492186A;
        Tue, 27 Aug 2019 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566936643;
        bh=KmRThUyd33509gpgyQIb+xwcQlNPC156eqJXJJJj7Ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R7XkO79wNXBmisY9zJl1xvrlaTs8or7Xyv7Orp8PIIlnFImz3aVT57sJGBuL0UChT
         xTBAscd6vnlnxiJDbVIZe2sALwtjdpFeYWuGOC4q9NpmX1w0T+5Sl+AKUiedjEklz8
         WqhonDPyw+tqoXV3KmQLqN5fo0v2bTAen2MZSvp8=
Date:   Tue, 27 Aug 2019 21:10:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: rely on IIO_G_TO_M_S_2 for gain
 definition for LSM9DS1
Message-ID: <20190827211038.3f821353@archlinux>
In-Reply-To: <776652415fadc8fc027ca13e74d942d7f45d7e7e.1566894470.git.lorenzo@kernel.org>
References: <776652415fadc8fc027ca13e74d942d7f45d7e7e.1566894470.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Aug 2019 10:29:06 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Rely on IIO_G_TO_M_S_2 macro for LSM9DS1 accelerometer gain definitions
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
One last tidy up for the cycle ;)

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c85c8be3a024..2d3495560136 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -141,10 +141,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  					.addr = 0x20,
>  					.mask = GENMASK(4, 3),
>  				},
> -				.fs_avl[0] = {  599, 0x0 },
> -				.fs_avl[1] = { 1197, 0x2 },
> -				.fs_avl[2] = { 2394, 0x3 },
> -				.fs_avl[3] = { 4788, 0x1 },
> +				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
> +				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
> +				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
> +				.fs_avl[3] = { IIO_G_TO_M_S_2(732), 0x1 },
>  			},
>  			[ST_LSM6DSX_ID_GYRO] = {
>  				.reg = {

