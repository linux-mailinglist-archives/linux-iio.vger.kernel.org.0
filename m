Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2D138158
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 13:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgAKMSK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 07:18:10 -0500
Received: from comms.puri.sm ([159.203.221.185]:48670 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbgAKMSK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 07:18:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D5976DF384;
        Sat, 11 Jan 2020 04:18:08 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TejDi3c3HHlT; Sat, 11 Jan 2020 04:18:08 -0800 (PST)
Date:   Sat, 11 Jan 2020 13:18:04 +0100
In-Reply-To: <20200111121518.34162e02@archlinux>
References: <20200104132052.28337-1-martin.kepplinger@puri.sm> <20200111121518.34162e02@archlinux>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: add mount matrix support
To:     Jonathan Cameron <jic23@kernel.org>
CC:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Message-ID: <07782E31-C423-472C-A8E8-19F7C0124510@puri.sm>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Am 11=2E J=C3=A4nner 2020 13:15:18 MEZ schrieb Jonathan Cameron <jic23@ker=
nel=2Eorg>:
>On Sat,  4 Jan 2020 14:20:52 +0100
>Martin Kepplinger <martin=2Ekepplinger@puri=2Esm> wrote:
>
>> Allow to read the mount-matrix device tree property and provide the
>> mount_matrix file for userspace to read=2E
>>=20
>> Signed-off-by: Martin Kepplinger <martin=2Ekepplinger@puri=2Esm>
>> ---
>>=20
>> tested using the lsm9ds1 on the librem5-devkit (and userspace tools
>like
>> iio-sensor-proxy) where this will be needed=2E
>>=20
>> thanks,
>>=20
>>                                        martin
>>=20
>> revision history
>> ----------------
>> v2: additions and simplifications according to Lorenzo's review=2E
>thanks=2E
>>=20
>>=20
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx=2Eh      | 19
>+++++++++++++++++++
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core=2Ec |  2 +-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx=2Eh
>b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx=2Eh
>> index a763ff46f596=2E=2E7076fc8c4c3b 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx=2Eh
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx=2Eh
>> @@ -76,6 +76,7 @@ enum st_lsm6dsx_hw_id {
>>  		=2Eendianness =3D IIO_LE,					\
>>  	},								\
>>  	=2Eevent_spec =3D &st_lsm6dsx_event,				\
>> +	=2Eext_info =3D st_lsm6dsx_accel_ext_info,				\
>>  	=2Enum_event_specs =3D 1,						\
>>  }
>> =20
>> @@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
>>   * @enable_event: enabled event bitmask=2E
>>   * @iio_devs: Pointers to acc/gyro iio_dev instances=2E
>>   * @settings: Pointer to the specific sensor settings in use=2E
>> + * @orientation: sensor chip orientation relative to main hardware=2E
>>   */
>>  struct st_lsm6dsx_hw {
>>  	struct device *dev;
>> @@ -406,6 +408,8 @@ struct st_lsm6dsx_hw {
>>  	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
>> =20
>>  	const struct st_lsm6dsx_settings *settings;
>> +
>> +	struct iio_mount_matrix orientation;
>>  };
>> =20
>>  static __maybe_unused const struct iio_event_spec st_lsm6dsx_event =3D
>{
>> @@ -479,4 +483,19 @@ st_lsm6dsx_write_locked(struct st_lsm6dsx_hw
>*hw, unsigned int addr,
>>  	return err;
>>  }
>> =20
>> +static const inline struct iio_mount_matrix *
>> +st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
>> +			    const struct iio_chan_spec *chan)
>> +{
>> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
>> +
>> +	return &hw->orientation;
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info
>st_lsm6dsx_accel_ext_info[] =3D {
>> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
>> +	{ }
>> +};
>> +
>>  #endif /* ST_LSM6DSX_H */
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core=2Ec
>b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core=2Ec
>> index 0c64e35c7599=2E=2E27e157f8a031 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core=2Ec
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core=2Ec
>> @@ -2325,7 +2325,7 @@ int st_lsm6dsx_probe(struct device *dev, int
>irq, int hw_id,
>>  	    (pdata && pdata->wakeup_source))
>>  		device_init_wakeup(dev, true);
>> =20
>> -	return 0;
>> +	return iio_read_mount_matrix(hw->dev, "mount-matrix",
>&hw->orientation);
>
>Race condition=2E  iio_device_register has already been called by this
>point=2E
>Hence userspace interfaces are exposed=2E  Userspace can read the mount
>matrix
>before it is initialized=2E  This needs to be earlier in probe=2E
>
>Jonathan

ah thanks! I somehow knew this looks wrong but I was lazy=2E resending soo=
n=2E


>
>>  }
>>  EXPORT_SYMBOL(st_lsm6dsx_probe);
>> =20

--=20
Sent from mobile=2E
