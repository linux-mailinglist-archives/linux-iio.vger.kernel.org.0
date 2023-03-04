Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD56AAB26
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 17:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCDQjA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 11:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCDQi7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 11:38:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD4DB46D
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 08:38:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E79C160686
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 16:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFEBC433D2;
        Sat,  4 Mar 2023 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677947937;
        bh=LBWvlGsUA+NSo3cIrcy54rL7d7PxL2JUMHiOaV+k35A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VeKUtWCYGLOWkb9IgPR9AgroEWLi2hGUh14gl3umXWNi+4aqcKTyIOsER6aUjZCQc
         7prFmQmDhrnfTTcqhtz6TIlA5iqJDP2GYdnLA3+m3mpx30Xwe5p5WCzDC7/msGuJLj
         jgqFPe7RqbgsA3g/uJC1GhvCIduIQqrjpjl1Od2Fo6aAB2D12OU7D08/QbyXv60on7
         EV9u1107wA8vwEbmphz8u+B0X9kp96wa26d2OctozLBD+K6Cn2iafQ97892PXAF8Q8
         VLYiYDYRHJBDLKlpAqUB7imKajZUXoTW3nKAAMMP0MKDeY7wgVp8QfNBjGS4e4RZ7r
         Ns2mXmFR1udTw==
Date:   Sat, 4 Mar 2023 16:38:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     phdm@macq.eu, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com, mario.tesi@st.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: discard samples during filters
 settling time
Message-ID: <20230304163853.1f109fd6@jic23-huawei>
In-Reply-To: <21dcd94935c147ef9b1da4984b3da6264ee9609e.1677496295.git.lorenzo@kernel.org>
References: <21dcd94935c147ef9b1da4984b3da6264ee9609e.1677496295.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Feb 2023 12:14:56 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> During digital filters settling time the driver is expected to drop
> samples since they can be corrupted. Introduce the capability to drop
> a given number of samples according to the configured ODR.
> Add sample_to_discard for LSM6DSM-like sensors since new generation
> devices (e.g. LSM6DSO) support DRDY mask where corrupted samples are
> masked in hw with values greather than 0x7ffd so the driver can easily
> discard them.
> I have not added sample_to_discard support for LSM6DS3 or LSM6DS3H since
> I do not have any sample for testing at the moment.
> 
> Reported-by: Philippe De Muyter <phdm@macqel.be>
> Tested-by: Philippe De Muyter <phdm@macqel.be>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git.

I'm not rushing this in because any existing userspace code must coping
with the bad data by doing it's own start up filtering - or in some other
way coping.

Anyhow, if anyone feels strongly that we should rush this in as a fix
then let me know.

Thanks,

Jonathan


> ---
> Changes since v1:
> - improve commit log
> - fix comment style
> - remove check for LSM6DSO-like sensors since they already support drdy-mask
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 11 ++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 57 ++++++++++++++++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 18 ++++++
>  3 files changed, 78 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 499fcf8875b4..8e119d78730b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -137,6 +137,13 @@ struct st_lsm6dsx_odr_table_entry {
>  	int odr_len;
>  };
>  
> +struct st_lsm6dsx_samples_to_discard {
> +	struct {
> +		u32 milli_hz;
> +		u16 samples;
> +	} val[ST_LSM6DSX_ODR_LIST_SIZE];
> +};
> +
>  struct st_lsm6dsx_fs {
>  	u32 gain;
>  	u8 val;
> @@ -291,6 +298,7 @@ struct st_lsm6dsx_ext_dev_settings {
>   * @irq_config: interrupts related registers.
>   * @drdy_mask: register info for data-ready mask (addr + mask).
>   * @odr_table: Hw sensors odr table (Hz + val).
> + * @samples_to_discard: Number of samples to discard for filters settling time.
>   * @fs_table: Hw sensors gain table (gain + val).
>   * @decimator: List of decimator register info (addr + mask).
>   * @batch: List of FIFO batching register info (addr + mask).
> @@ -323,6 +331,7 @@ struct st_lsm6dsx_settings {
>  	} irq_config;
>  	struct st_lsm6dsx_reg drdy_mask;
>  	struct st_lsm6dsx_odr_table_entry odr_table[2];
> +	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
>  	struct st_lsm6dsx_fs_table_entry fs_table[2];
>  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> @@ -353,6 +362,7 @@ enum st_lsm6dsx_fifo_mode {
>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>   * @gain: Configured sensor sensitivity.
>   * @odr: Output data rate of the sensor [Hz].
> + * @samples_to_discard: Number of samples to discard for filters settling time.
>   * @watermark: Sensor watermark level.
>   * @decimator: Sensor decimation factor.
>   * @sip: Number of samples in a given pattern.
> @@ -367,6 +377,7 @@ struct st_lsm6dsx_sensor {
>  	u32 gain;
>  	u32 odr;
>  
> +	u16 samples_to_discard;
>  	u16 watermark;
>  	u8 decimator;
>  	u8 sip;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 7dd5205aea5b..f6c11d6fb0b0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -457,17 +457,31 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  			}
>  
>  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> -				iio_push_to_buffers_with_timestamp(
> -					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> -					&hw->scan[ST_LSM6DSX_ID_GYRO],
> -					gyro_sensor->ts_ref + ts);
> +				/*
> +				 * We need to discards gyro samples during
> +				 * filters settling time
> +				 */
> +				if (gyro_sensor->samples_to_discard > 0)
> +					gyro_sensor->samples_to_discard--;
> +				else
> +					iio_push_to_buffers_with_timestamp(
> +						hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> +						&hw->scan[ST_LSM6DSX_ID_GYRO],
> +						gyro_sensor->ts_ref + ts);
>  				gyro_sip--;
>  			}
>  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> -				iio_push_to_buffers_with_timestamp(
> -					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> -					&hw->scan[ST_LSM6DSX_ID_ACC],
> -					acc_sensor->ts_ref + ts);
> +				/*
> +				 * We need to discards accel samples during
> +				 * filters settling time
> +				 */
> +				if (acc_sensor->samples_to_discard > 0)
> +					acc_sensor->samples_to_discard--;
> +				else
> +					iio_push_to_buffers_with_timestamp(
> +						hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +						&hw->scan[ST_LSM6DSX_ID_ACC],
> +						acc_sensor->ts_ref + ts);
>  				acc_sip--;
>  			}
>  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> @@ -654,6 +668,30 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  	return err;
>  }
>  
> +static void
> +st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sensor)
> +{
> +	const struct st_lsm6dsx_samples_to_discard *data;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	int i;
> +
> +	if (sensor->id != ST_LSM6DSX_ID_GYRO &&
> +	    sensor->id != ST_LSM6DSX_ID_ACC)
> +		return;
> +
> +	/* check if drdy mask is supported in hw */
> +	if (hw->settings->drdy_mask.addr)
> +		return;
> +
> +	data = &hw->settings->samples_to_discard[sensor->id];
> +	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> +		if (data->val[i].milli_hz == sensor->odr) {
> +			sensor->samples_to_discard = data->val[i].samples;
> +			return;
> +		}
> +	}
> +}
> +
>  int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  {
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> @@ -673,6 +711,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  			goto out;
>  	}
>  
> +	if (enable)
> +		st_lsm6dsx_update_samples_to_discard(sensor);
> +
>  	err = st_lsm6dsx_device_set_enable(sensor, enable);
>  	if (err < 0)
>  		goto out;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 3f6060c64f32..966df6ffe874 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -634,6 +634,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.fs_len = 4,
>  			},
>  		},
> +		.samples_to_discard = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.val[0] = {  12500, 1 },
> +				.val[1] = {  26000, 1 },
> +				.val[2] = {  52000, 1 },
> +				.val[3] = { 104000, 2 },
> +				.val[4] = { 208000, 2 },
> +				.val[5] = { 416000, 2 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.val[0] = {  12500,  2 },
> +				.val[1] = {  26000,  5 },
> +				.val[2] = {  52000,  7 },
> +				.val[3] = { 104000, 12 },
> +				.val[4] = { 208000, 20 },
> +				.val[5] = { 416000, 36 },
> +			},
> +		},
>  		.irq_config = {
>  			.irq1 = {
>  				.addr = 0x0d,

