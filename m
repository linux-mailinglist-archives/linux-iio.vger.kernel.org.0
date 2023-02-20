Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0069CB2B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Feb 2023 13:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjBTMlP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Feb 2023 07:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBTMlO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2023 07:41:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1E166D5
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 04:41:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PL23K1M7Nz6J6Cf;
        Mon, 20 Feb 2023 20:36:29 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 20 Feb
 2023 12:41:09 +0000
Date:   Mon, 20 Feb 2023 12:41:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <phdm@macq.eu>,
        <linux-iio@vger.kernel.org>, <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
 settling time
Message-ID: <20230220124108.00001b36@huawei.com>
In-Reply-To: <Y/M5feqZB+4JP99M@lore-desk>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
        <20230218135622.6c5d4569@jic23-huawei>
        <Y/M5feqZB+4JP99M@lore-desk>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Feb 2023 10:12:29 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Wed,  8 Feb 2023 15:42:31 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> > > During digital filters settling time the driver is expected to drop
> > > samples since they can be corrupted. Introduce the capability to drop
> > > a given number of samples according to the configured ODR.
> > > Add the sample_to_discard data for LSM6DSM sensor.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> > 
> > Is this only necessary for the particular sensor you have provided
> > values for?  Or is it more general?
> > 
> > I think the code will currently just set the number of samples to discard
> > to 0 for other cases (as no value set for those sensor types).
> > That's fine if 0 is definitely the right value for those other sensors.  
> 
>  I think all the sensors have this information in the datasheet/application
>  note. However, even if we add sample_to_discard just for LSM6DSM for the moment,
>  we do not introduce any regression for the other sensors with respect to the
>  previous codebase since sample_to_discard will be just set to 0 (so we do not
>  discard any sample). I can add sample_to_discard for LSM6DSO but at the
>  moment I do not have other devices for testing.
>  For LSM6DSO, do you prefer to add it in v2 or is it fine a follow-up patch?

It's fine to do this as and when we can test particular devices
(or frankly just assume datasheet correct). 

We should call it out in the patch description though so hopefully people
notice they need to add it for sensors they care about.

> 
>  Regards,
>  Lorenzo
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 11 ++++
> > >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 58 +++++++++++++++----
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 18 ++++++
> > >  3 files changed, 77 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > index 499fcf8875b4..8e119d78730b 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > @@ -137,6 +137,13 @@ struct st_lsm6dsx_odr_table_entry {
> > >  	int odr_len;
> > >  };
> > >  
> > > +struct st_lsm6dsx_samples_to_discard {
> > > +	struct {
> > > +		u32 milli_hz;
> > > +		u16 samples;
> > > +	} val[ST_LSM6DSX_ODR_LIST_SIZE];
> > > +};
> > > +
> > >  struct st_lsm6dsx_fs {
> > >  	u32 gain;
> > >  	u8 val;
> > > @@ -291,6 +298,7 @@ struct st_lsm6dsx_ext_dev_settings {
> > >   * @irq_config: interrupts related registers.
> > >   * @drdy_mask: register info for data-ready mask (addr + mask).
> > >   * @odr_table: Hw sensors odr table (Hz + val).
> > > + * @samples_to_discard: Number of samples to discard for filters settling time.
> > >   * @fs_table: Hw sensors gain table (gain + val).
> > >   * @decimator: List of decimator register info (addr + mask).
> > >   * @batch: List of FIFO batching register info (addr + mask).
> > > @@ -323,6 +331,7 @@ struct st_lsm6dsx_settings {
> > >  	} irq_config;
> > >  	struct st_lsm6dsx_reg drdy_mask;
> > >  	struct st_lsm6dsx_odr_table_entry odr_table[2];
> > > +	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
> > >  	struct st_lsm6dsx_fs_table_entry fs_table[2];
> > >  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> > >  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> > > @@ -353,6 +362,7 @@ enum st_lsm6dsx_fifo_mode {
> > >   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
> > >   * @gain: Configured sensor sensitivity.
> > >   * @odr: Output data rate of the sensor [Hz].
> > > + * @samples_to_discard: Number of samples to discard for filters settling time.
> > >   * @watermark: Sensor watermark level.
> > >   * @decimator: Sensor decimation factor.
> > >   * @sip: Number of samples in a given pattern.
> > > @@ -367,6 +377,7 @@ struct st_lsm6dsx_sensor {
> > >  	u32 gain;
> > >  	u32 odr;
> > >  
> > > +	u16 samples_to_discard;
> > >  	u16 watermark;
> > >  	u8 decimator;
> > >  	u8 sip;
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index 7dd5205aea5b..c1059a79f5ff 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -457,17 +457,29 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> > >  			}
> > >  
> > >  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> > > -				iio_push_to_buffers_with_timestamp(
> > > -					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> > > -					&hw->scan[ST_LSM6DSX_ID_GYRO],
> > > -					gyro_sensor->ts_ref + ts);
> > > +				/* We need to discards gyro samples during  
> > 
> > Trivial but wrong comment syntax. If that's all that comes up I'll fix it here
> > and in other instances below when applying.
> >   
> > > +				 * filters settling time
> > > +				 */
> > > +				if (gyro_sensor->samples_to_discard > 0)
> > > +					gyro_sensor->samples_to_discard--;
> > > +				else
> > > +					iio_push_to_buffers_with_timestamp(
> > > +						hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> > > +						&hw->scan[ST_LSM6DSX_ID_GYRO],
> > > +						gyro_sensor->ts_ref + ts);
> > >  				gyro_sip--;
> > >  			}
> > >  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> > > -				iio_push_to_buffers_with_timestamp(
> > > -					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > > -					&hw->scan[ST_LSM6DSX_ID_ACC],
> > > -					acc_sensor->ts_ref + ts);
> > > +				/* We need to discards accel samples during
> > > +				 * filters settling time
> > > +				 */
> > > +				if (acc_sensor->samples_to_discard > 0)
> > > +					acc_sensor->samples_to_discard--;
> > > +				else
> > > +					iio_push_to_buffers_with_timestamp(
> > > +						hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > > +						&hw->scan[ST_LSM6DSX_ID_ACC],
> > > +						acc_sensor->ts_ref + ts);
> > >  				acc_sip--;
> > >  			}
> > >  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> > > @@ -541,8 +553,12 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > >  	}
> > >  
> > >  	sensor = iio_priv(iio_dev);
> > > -	iio_push_to_buffers_with_timestamp(iio_dev, data,
> > > -					   ts + sensor->ts_ref);
> > > +	/* We need to discards gyro samples during filters settling time */
> > > +	if (sensor->samples_to_discard > 0)
> > > +		sensor->samples_to_discard--;
> > > +	else
> > > +		iio_push_to_buffers_with_timestamp(iio_dev, data,
> > > +						   ts + sensor->ts_ref);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -654,6 +670,25 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
> > >  	return err;
> > >  }
> > >  
> > > +static void
> > > +st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sensor)
> > > +{
> > > +	const struct st_lsm6dsx_samples_to_discard *data;
> > > +	int i;
> > > +
> > > +	if (sensor->id != ST_LSM6DSX_ID_GYRO &&
> > > +	    sensor->id != ST_LSM6DSX_ID_ACC)
> > > +		return;
> > > +
> > > +	data = &sensor->hw->settings->samples_to_discard[sensor->id];
> > > +	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> > > +		if (data->val[i].milli_hz == sensor->odr) {
> > > +			sensor->samples_to_discard = data->val[i].samples;
> > > +			return;
> > > +		}
> > > +	}
> > > +}
> > > +
> > >  int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
> > >  {
> > >  	struct st_lsm6dsx_hw *hw = sensor->hw;
> > > @@ -673,6 +708,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
> > >  			goto out;
> > >  	}
> > >  
> > > +	if (enable)
> > > +		st_lsm6dsx_update_samples_to_discard(sensor);
> > > +
> > >  	err = st_lsm6dsx_device_set_enable(sensor, enable);
> > >  	if (err < 0)
> > >  		goto out;
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 3f6060c64f32..966df6ffe874 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -634,6 +634,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> > >  				.fs_len = 4,
> > >  			},
> > >  		},
> > > +		.samples_to_discard = {
> > > +			[ST_LSM6DSX_ID_ACC] = {
> > > +				.val[0] = {  12500, 1 },
> > > +				.val[1] = {  26000, 1 },
> > > +				.val[2] = {  52000, 1 },
> > > +				.val[3] = { 104000, 2 },
> > > +				.val[4] = { 208000, 2 },
> > > +				.val[5] = { 416000, 2 },
> > > +			},
> > > +			[ST_LSM6DSX_ID_GYRO] = {
> > > +				.val[0] = {  12500,  2 },
> > > +				.val[1] = {  26000,  5 },
> > > +				.val[2] = {  52000,  7 },
> > > +				.val[3] = { 104000, 12 },
> > > +				.val[4] = { 208000, 20 },
> > > +				.val[5] = { 416000, 36 },
> > > +			},
> > > +		},
> > >  		.irq_config = {
> > >  			.irq1 = {
> > >  				.addr = 0x0d,  
> >   
> 

