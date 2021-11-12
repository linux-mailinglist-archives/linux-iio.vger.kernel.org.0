Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4C44EB48
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhKLQ0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 11:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234496AbhKLQ0E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 11:26:04 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6850F6044F;
        Fri, 12 Nov 2021 16:23:12 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:27:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add dts property to disable
 sensor-hub
Message-ID: <20211112162758.2c2293ae@jic23-huawei>
In-Reply-To: <78e0ba2979aca8cc1894fe4c99e784591ba681f1.1636552075.git.lorenzo@kernel.org>
References: <cover.1636552075.git.lorenzo@kernel.org>
        <78e0ba2979aca8cc1894fe4c99e784591ba681f1.1636552075.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Nov 2021 15:42:32 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce the capability to disable sensorhub through a device-tree
> property since there are some configurations where users want to
> explicitly disable sensor-hub auto-probing at bootstrap.
> A typical configuration is when the sensorhub clock/data lines are connected
> to a pull-up resistor since no slave sensors are connected to the i2c master.
> If SDO/SA0 line is connected to the same pull-up resistor, when the driver
> tries to probe slave devices connected on sensor-hub, it will force SDO/SA0
> line to low, modifying the device i2c address.

That's some 'interesting' wiring...

My only suggestion here is perhaps expand on shub as disable-sensor-hub
would be easier for people not familiar with the abbreviation?

Jonathan

> 
> Tested-by: Mario Tesi <mario.tesi@st.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index f2cbbc756459..82ac6c59ca03 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2244,7 +2244,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		return err;
>  
>  	hub_settings = &hw->settings->shub_settings;
> -	if (hub_settings->master_en.addr) {
> +	if (hub_settings->master_en.addr &&
> +	    (!dev_fwnode(dev) ||
> +	     !device_property_read_bool(dev, "st,disable-shub"))) {
>  		err = st_lsm6dsx_shub_probe(hw, name);
>  		if (err < 0)
>  			return err;

