Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05F74F53C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFVK1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVK1U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:27:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5422075E;
        Sat, 22 Jun 2019 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561199239;
        bh=Vmym3nLdX+eC1jmoUtRAV6vskavgxGlOYGZL08/6bYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jyODZMFQB0lphrPw5wS94NnSxP0tGeyLWZhwVRjZ6/t74Pe3weBLP6rRlVAvDL4Kf
         CvW5ysop5Em0Dw1zwzV/L6YLzZMOpFN7/OQV3TV4UGH6o2BKJkg3g8p1VGedI95z8i
         DcxrXdgjq+O0blqOpMg4oFZKb0wONQhWOr++vlHI=
Date:   Sat, 22 Jun 2019 11:27:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>, <lorenzo@kernel.org>
Subject: Re: [PATCH 0/7] iio:st_sensors: make use of regmap API
Message-ID: <20190622112715.5595f1c9@archlinux>
In-Reply-To: <20190617234943.10669-1-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 16:49:36 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This series is meant to replace I2C/SPI APIs and make use of regmap
> to reduce redundancy.
Huh. Not a great deal of redundancy reduction given the
stats, but potentially makes sense for a whole load of other reasons and for
future development!

> 
> Denis Ciocca (7):
>   iio:common:st_sensors: add st_sensors_get_settings_index() helper
>     function
>   iio:accel: introduce st_accel_multiread_bit() function
>   iio:magn: introduce st_magn_multiread_bit() function
>   iio:gyro: introduce st_gyro_multiread_bit() function
>   iio:pressure: introduce st_pressure_multiread_bit() function
>   iio: make st_sensors driver use regmap
>   iio:common: make st_sensors_write_data_with_mask() inline
> 
>  drivers/iio/accel/st_accel.h                  |   1 +
>  drivers/iio/accel/st_accel_core.c             |  19 +++-
>  drivers/iio/accel/st_accel_i2c.c              |   7 +-
>  drivers/iio/accel/st_accel_spi.c              |   6 +-
>  .../iio/common/st_sensors/st_sensors_buffer.c |  10 +-
>  .../iio/common/st_sensors/st_sensors_core.c   |  90 ++++++++-------
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  65 +++++------
>  .../iio/common/st_sensors/st_sensors_spi.c    | 103 +++++-------------
>  .../common/st_sensors/st_sensors_trigger.c    |  10 +-
>  drivers/iio/gyro/st_gyro.h                    |   1 +
>  drivers/iio/gyro/st_gyro_core.c               |  19 +++-
>  drivers/iio/gyro/st_gyro_i2c.c                |   5 +-
>  drivers/iio/gyro/st_gyro_spi.c                |   6 +-
>  drivers/iio/magnetometer/st_magn.h            |   1 +
>  drivers/iio/magnetometer/st_magn_core.c       |  19 +++-
>  drivers/iio/magnetometer/st_magn_i2c.c        |   5 +-
>  drivers/iio/magnetometer/st_magn_spi.c        |   6 +-
>  drivers/iio/pressure/st_pressure.h            |   1 +
>  drivers/iio/pressure/st_pressure_core.c       |  19 +++-
>  drivers/iio/pressure/st_pressure_i2c.c        |   5 +-
>  drivers/iio/pressure/st_pressure_spi.c        |   6 +-
>  include/linux/iio/common/st_sensors.h         |  41 +------
>  include/linux/iio/common/st_sensors_i2c.h     |   5 +-
>  include/linux/iio/common/st_sensors_spi.h     |   5 +-
>  24 files changed, 230 insertions(+), 225 deletions(-)
> 

