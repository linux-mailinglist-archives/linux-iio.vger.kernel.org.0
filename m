Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE557354EC5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbhDFIhi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 6 Apr 2021 04:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhDFIhh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 04:37:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0196C613C2;
        Tue,  6 Apr 2021 08:37:28 +0000 (UTC)
Date:   Tue, 6 Apr 2021 09:37:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: inv_mpu6050: Fully validate gyro and accel scale
 writes
Message-ID: <20210406093743.7e23e0da@jic23-huawei>
In-Reply-To: <BL0PR12MB5011889BC549865552ECE88AC4769@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210405114441.24167-1-lars@metafoo.de>
        <20210405155526.78ef4363@jic23-huawei>
        <BL0PR12MB5011889BC549865552ECE88AC4769@BL0PR12MB5011.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Apr 2021 07:51:05 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan, Lars-Peter,
> 
> thanks for letting me having a look. This is effectively as obvious as it looks.
> Never think of testing that, thanks for the patch.
> 
> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied to the togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Thanks,
> JB
> 
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, April 5, 2021 16:55
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Subject: Re: [PATCH] iio: inv_mpu6050: Fully validate gyro and accel scale writes 
>  
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Mon,  5 Apr 2021 13:44:41 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > When setting the gyro or accelerometer scale the inv_mpu6050 driver ignores
> > the integer part of the value. As a result e.g. all of 0.13309, 1.13309,
> > 12345.13309, ... are accepted as a valid gyro scale and 0.13309 is the
> > scale that gets set in all those cases.
> > 
> > Make sure to check that the integer part of the scale value is 0 and reject
> > it otherwise.
> > 
> > Fixes: 09a642b78523 ("Invensense MPU6050 Device Driver.")
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> Looks like this is in the 'obviously' correct category to me but
> will leave it on list to give Jean-Baptiste a chance to look at it.
> 
> As ever, give me a poke if I seem to have lost it down the back of the
> sofa in a few weeks time.
> 
> Thanks
> 
> Jonathan
> 
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 453c51c79655..69ab94ab7297 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -731,12 +731,16 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> >        }
> >  }
> >  
> > -static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
> > +static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val,
> > +                                     int val2)
> >  {
> >        int result, i;
> >  
> > +     if (val != 0)
> > +             return -EINVAL;
> > +
> >        for (i = 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) {
> > -             if (gyro_scale_6050[i] == val) {
> > +             if (gyro_scale_6050[i] == val2) {
> >                        result = inv_mpu6050_set_gyro_fsr(st, i);
> >                        if (result)
> >                                return result;
> > @@ -767,13 +771,17 @@ static int inv_write_raw_get_fmt(struct iio_dev *indio_dev,
> >        return -EINVAL;
> >  }
> >  
> > -static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
> > +static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val,
> > +                                      int val2)
> >  {
> >        int result, i;
> >        u8 d;
> >  
> > +     if (val != 0)
> > +             return -EINVAL;
> > +
> >        for (i = 0; i < ARRAY_SIZE(accel_scale); ++i) {
> > -             if (accel_scale[i] == val) {
> > +             if (accel_scale[i] == val2) {
> >                        d = (i << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
> >                        result = regmap_write(st->map, st->reg->accl_config, d);
> >                        if (result)
> > @@ -814,10 +822,10 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
> >        case IIO_CHAN_INFO_SCALE:
> >                switch (chan->type) {
> >                case IIO_ANGL_VEL:
> > -                     result = inv_mpu6050_write_gyro_scale(st, val2);
> > +                     result = inv_mpu6050_write_gyro_scale(st, val, val2);
> >                        break;
> >                case IIO_ACCEL:
> > -                     result = inv_mpu6050_write_accel_scale(st, val2);
> > +                     result = inv_mpu6050_write_accel_scale(st, val, val2);
> >                        break;
> >                default:
> >                        result = -EINVAL;  

