Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E56B412651
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387249AbhITS4t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 20 Sep 2021 14:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385819AbhITSw3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A21560F4B;
        Mon, 20 Sep 2021 17:56:47 +0000 (UTC)
Date:   Mon, 20 Sep 2021 19:00:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     Baptiste Mansuy <bmansuy@invensense.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for
 icm20602/20690
Message-ID: <20210920190031.621df561@jic23-huawei>
In-Reply-To: <FR3P281MB053728C83C38C974D2F8CC1ACEA09@FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM>
References: <20210906123219.3084706-1-bmansuy@invensense.com>
        <20210911181024.0ce3e225@jic23-huawei>
        <BYAPR12MB29018030DC537A2937F83BFDDEDA9@BYAPR12MB2901.namprd12.prod.outlook.com>
        <20210919170056.5d30eab8@jic23-huawei>
        <FR3P281MB053728C83C38C974D2F8CC1ACEA09@FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Sep 2021 13:21:31 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hi Jonathan,
> 
> concerning the FIFO maximum threshold, this is more complex than that. In our case we are using both hardware watermark from the chip FIFO and software watermark from IIO kernel FIFO.
> 
> We may want to use a big IIO kernel FIFO with a big corresponding watermark value, without having the risk to loose data by overflowing the hardware FIFO. Thus the threshold in the hardware FIFO watermark used to keep some space to handle system response latency.
> 
> If we configure maximum value for the hardware FIFO, we may loose data even if the watermark used is very far from IIO kernel FIFO size. Image we use a 4096 bytes IIO buffer with a watermark of 2048 (half the size), and our chip only have 1024 bytes of FIFO. We want to use hardware FIFO as much as possible, but without the risk to loose data. Userspace user will not intend to have holes in its data with such a value.
> 
> With all that in mind, what do you think would be a good threshold to ensure we cannot loose data with usual system latency?

Hmm. I'd misremembered how this is wired up... To many discussions on
this over the years :)
 
There isn't a solution in general, but you should expose the value of he
hw watermark to userspace.

We have separate "watermark" (for the kfifo) and "hwfifo_watermark" in the ABI
to partly allow for this case.  That exposes the difference values for the
hardware and software watermarks to be exposed to userspace.

Whilst no drivers currently allow hwfifo_watermark to be written there is
nothing stopping you allowing it to be overridden (subject to being sensible
for the watermark value) - so not larger than it. It may be you don't need
that option.  You could do something a bit nasty with having it default
to the 4/5 value you have below unless someone has explicitly written that
it should be something else. 
If the buffer is started with a watermark < hwfifo_watermark we probably
want to change one of them for any later readers of the values.

Thanks,

Jonathan


> 
> Thanks for your response,
> JB
> 
> 
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, September 19, 2021 18:00
> To: Baptiste Mansuy <bmansuy@invensense.com>
> Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for icm20602/20690 
>  
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Tue, 14 Sep 2021 13:52:53 +0000
> Baptiste Mansuy <bmansuy@invensense.com> wrote:
> 
> > Hi,
> > 
> > Thank you for your comments, I wrote a reply bellow each of them.
> > 
> > Baptiste
> > 
> > 
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, September 11, 2021 7:10 PM
> > To: Baptiste Mansuy <bmansuy@invensense.com>
> > Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> > Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for icm20602/20690 
> > 
> > On Mon,  6 Sep 2021 12:32:19 +0000
> > Baptiste Mansuy <bmansuy@invensense.com> wrote:
> >   
> > >> Add watermark support using FIFO interrupt for chips having this
> > >> feature. This allows the use of the watermark interrupt with the
> > >> posibility to change it's size. Change the timestamp computation
> > >> to be used with the watermark.
> > >> 
> > >> Add the set_watermark and flush callbacks according to the iio
> > >> description.
> > >> 
> > >>Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>    
> > >
> > >Hi,
> > >
> > >A few comments inline.
> > >
> > >Jonathan
> > >    
> > >> ---
> > >>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 104 +++++++++++++-
> > >>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  21 ++-
> > >>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 130 +++++++++++++-----
> > >>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  24 +++-
> > >>  4 files changed, 237 insertions(+), 42 deletions(-)
> > >> 
> > >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > >> index 597768c..9cdec62 100644
> > >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > >> @@ -47,7 +47,9 @@ static const struct inv_mpu6050_reg_map reg_set_icm20602 = {
> > >>        .raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
> > >>        .temperature            = INV_MPU6050_REG_TEMPERATURE,
> > >>        .int_enable             = INV_MPU6050_REG_INT_ENABLE,
> > >> -     .int_status             = INV_MPU6050_REG_INT_STATUS,
> > >> +     .int_status             = INV_ICM20602_REG_FIFO_WM_INT_STATUS,
> > >> +     .wm_th_hb               = INV_ICM20602_FIFO_WM_TH_HB,
> > >> +     .wm_th_lb               = INV_ICM20602_FIFO_WM_TH_LB,
> > >>        .pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
> > >>        .pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
> > >>        .int_pin_cfg            = INV_MPU6050_REG_INT_PIN_CFG,
> > >> @@ -56,6 +58,31 @@ static const struct inv_mpu6050_reg_map reg_set_icm20602 = {
> > >>        .i2c_if                 = INV_ICM20602_REG_I2C_IF,
> > >>  };
> > >>  
> > >> +static const struct inv_mpu6050_reg_map reg_set_icm20690 = {
> > >> +     .sample_rate_div        = INV_MPU6050_REG_SAMPLE_RATE_DIV,
> > >> +     .lpf                    = INV_MPU6050_REG_CONFIG,
> > >> +     .accel_lpf              = INV_MPU6500_REG_ACCEL_CONFIG_2,
> > >> +     .user_ctrl              = INV_MPU6050_REG_USER_CTRL,
> > >> +     .fifo_en                = INV_MPU6050_REG_FIFO_EN,
> > >> +     .gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
> > >> +     .accl_config            = INV_MPU6050_REG_ACCEL_CONFIG,
> > >> +     .fifo_count_h           = INV_MPU6050_REG_FIFO_COUNT_H,
> > >> +     .fifo_r_w               = INV_MPU6050_REG_FIFO_R_W,
> > >> +     .raw_gyro               = INV_MPU6050_REG_RAW_GYRO,
> > >> +     .raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
> > >> +     .temperature            = INV_MPU6050_REG_TEMPERATURE,
> > >> +     .int_enable             = INV_MPU6050_REG_INT_ENABLE,
> > >> +     .int_status             = INV_ICM20602_REG_FIFO_WM_INT_STATUS,
> > >> +     .wm_th_hb               = INV_ICM20690_FIFO_WM_TH_HB,
> > >> +     .wm_th_lb               = INV_ICM20690_FIFO_WM_TH_LB,
> > >> +     .pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
> > >> +     .pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
> > >> +     .int_pin_cfg            = INV_MPU6050_REG_INT_PIN_CFG,
> > >> +     .accl_offset            = INV_MPU6500_REG_ACCEL_OFFSET,
> > >> +     .gyro_offset            = INV_MPU6050_REG_GYRO_OFFSET,
> > >> +     .i2c_if                 = 0,
> > >> +};
> > >> +
> > >>  static const struct inv_mpu6050_reg_map reg_set_6500 = {
> > >>        .sample_rate_div        = INV_MPU6050_REG_SAMPLE_RATE_DIV,
> > >>        .lpf                    = INV_MPU6050_REG_CONFIG,
> > >> @@ -115,6 +142,8 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
> > >>        .magn_fifo_enable = false,
> > >>        .accl_fs = INV_MPU6050_FS_02G,
> > >>        .user_ctrl = 0,
> > >> +     .wm_val = 1,
> > >> +     .wm_size = 0,    
> > >
> > >I don't think this is ever relevant to parts using this structure.
> > >    
> > 
> > wm_val is used by every chip for the timestamp computation. It needs to be set to 1.  
> I'd missed that.  Thanks.
> 
> >   
> > >>  };
> > >>    
> ..
> > >>  
> > >> +int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int val)
> > >> +{
> > >> +     unsigned int nb_byte, new_size_byte;
> > >> +     int ret;
> > >> +
> > >> +     /* compute number of bytes inside FIFO */
> > >> +     nb_byte = 0;
> > >> +     if (st->chip_config.gyro_en)
> > >> +             nb_byte += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> > >> +     if (st->chip_config.accl_en)
> > >> +             nb_byte += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> > >> +     if (st->chip_config.magn_en)
> > >> +             nb_byte += INV_MPU9X50_BYTES_MAGN;
> > >> +     if (st->chip_config.temp_en)
> > >> +             nb_byte += INV_MPU6050_BYTES_PER_TEMP_SENSOR;
> > >> +
> > >> +     /* compute watermark size, use a threshold to keep some data space for read latency */    
> > >
> > >Not following this comment.  If the intent is you are setting the watermark in hardware lower
> > >because you think more data will have come in before we actually read it, please don't.
> > >The sampling frequency could be very low meaning there isn't enough data available.
> > >
> > >We are dealing with a fifo here, it doesn't matter if a few more samples are available when
> > >we go to read than the level of the watermark.  That's normal.
> > >    
> > 
> > The issue here is when the fifo is full, if the processing of the interrupt takes too much time,
> > we don't know if the first data were overwritten by new data.  
> > If it happens, we can't use the data. So we need to let some space in the fifo.  
> 
> Then the watermark is set too high.  So that's just a software / userspace configuration issue
> and is common to any similar fifo.
> 
> > 
> > It usualy happens with high sample frequencies. If the current space is too much, we can
> > choose a new space of 10 samples. With the highest frequency (500Hz), a free space of 
> > 10 samples gives 20ms for the processing of the interrupt.  
> 
> Understood on the problem, but leave dealing this to userspace control rather than trying to
> paper over in userspace.  If you do what you have here, and a low sample rate is used
> userspace software will expect to have at least the watermark worth of samples.  Whilst
> it 'should' probably be hardened against underflow, it may well not be.
> 
> Any userspace software that sets the watermark near the maximum possible would
> in my mind be either considered broken, or is being used in a case where loosing
> samples isn't a problem.
> 
> >   
> > >> +     new_size_byte = val * nb_byte;
> > >> +     if (new_size_byte > ((st->hw->fifo_size * 4) / 5)) {
> > >> +             val = ((st->hw->fifo_size * 4) / 5) / nb_byte;
> > >> +             new_size_byte = val * nb_byte;
> > >> +     }
> > >> +
> > >> +     ret = inv_mpu6050_set_hw_watermark(st, new_size_byte);
> > >> +     if (ret)
> > >> +             return ret;
> > >> +
> > >> +     st->chip_config.wm_val = val;
> > >> +
> > >> +     return 0;
> > >> +}
> > >> +  
> 
> ...
> 
> > >> +
> > >>  static const struct iio_info mpu_info = {
> > >>        .read_raw = &inv_mpu6050_read_raw,
> > >>        .write_raw = &inv_mpu6050_write_raw,
> > >> @@ -1297,6 +1393,8 @@ static const struct iio_info mpu_info = {
> > >>        .attrs = &inv_attribute_group,
> > >>        .validate_trigger = inv_mpu6050_validate_trigger,
> > >>        .debugfs_reg_access = &inv_mpu6050_reg_access,
> > >> +     .hwfifo_set_watermark = &inv_mpu6050_set_watermark,
> > >> +     .hwfifo_flush_to_buffer = &inv_mpu6050_hw_flush_to_buffer,
> > >>  };
> > >>  
> > >>  /*
> > >> @@ -1618,7 +1716,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> > >>                 */
> > >>                result = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > >>                                                         iio_pollfunc_store_time,
> > >> -                                                      inv_mpu6050_read_fifo,
> > >> +                                                      inv_mpu6050_interrupt_handler,
> > >>                                                         NULL);
> > >>                if (result) {
> > >>                        dev_err(dev, "configure buffer fail %d\n", result);
> > >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > >> index c6aa36e..d925885 100644
> > >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > >> @@ -57,6 +57,8 @@ struct inv_mpu6050_reg_map {
> > >>        u8 temperature;
> > >>        u8 int_enable;
> > >>        u8 int_status;
> > >> +     u8 wm_th_hb;
> > >> +     u8 wm_th_lb;
> > >>        u8 pwr_mgmt_1;
> > >>        u8 pwr_mgmt_2;
> > >>        u8 int_pin_cfg;
> > >> @@ -121,6 +123,8 @@ struct inv_mpu6050_chip_config {
> > >>        unsigned int magn_fifo_enable:1;
> > >>        u8 divider;
> > >>        u8 user_ctrl;
> > >> +     unsigned int wm_val;    
> > >What are these two? Non obvious enough a comment would be good.    
> > 
> > I added the following lines in the Doxygen header :
> > 
> >  *  @wm_val:          watermark size in number of data
> >  *  @wm_size:         watermark size in bytes  
> 
> Ah good.  I hadn't noticed the structure had kernel-doc and this
> would have caused problems when I ran a build tests.
> 
> Please make sure to run build the documentation or run a build
> test with W=1 so that we verify no other documentation is missing.
> 
> >   
> > >> +     unsigned int wm_size;
> > >>  };
> > >>    
> 
> ...
> 
> > >> -/*
> > >> - * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
> > >> - */
> > >> -irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)    
> > >
> > >Given the count parameter has a 'special' value of 0, please add some documentation
> > >for this function.
> > >    
> > 
> > I added a Doxygen header for this function :
> > 
> > /**
> >  * inv_mpu6050_flush_fifo() - Flush fifo
> >  *
> >  * @indio_dev:                Device driver instance.
> >  * @timestamp_val:    the interrupt timestamp
> >  * @count:            Number of data to flush
> >  *
> >  * This function flush the fifo using count as the number of data to flush.  
> 
> This function flushes the fifo using the count...
> 
> >  * As fifo_size may differ according to the chip unsigned
> >  * count = 0 is used to set the max size of the fifo for count.
> >  *  
> No point in the empty trailing line as it doesn't help readabilty so please remove
> that. Otherwise good docs.
> >  */
> >   
> > >> +int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev,
> > >> +                                   s64 timestamp_val, unsigned int count)
> > >>  {  
> ...

