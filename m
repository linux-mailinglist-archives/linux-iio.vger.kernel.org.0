Return-Path: <linux-iio+bounces-21999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02554B1113C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 20:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F379561F9F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A2224228;
	Thu, 24 Jul 2025 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrWamkk6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A327057D;
	Thu, 24 Jul 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383282; cv=none; b=u4KmNeXHiba/39/98Nx/OSTKaA7JnDexGQLTWzVmIoSasVtq3yxCMDe7CcBfylXOE+QXhYs0Nb+FO/MqjcqZy/03OvqeGR5asSYm+41jK6CCo3rFITvPCKYg6v1jBvaQ+Wl9yH+A+0dMZYQsIMSbgdfL+vhlFkkF59YQOVwOM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383282; c=relaxed/simple;
	bh=UZLedV5uA6EjpO7MgEOW3w2GJr+5eSJTDyDVyLPNRsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDsTJ/6ZD5erS3Dd47c2QfZhCe3pgM1PYsNFIeXWUX6Z/7raVMcy67SzkATEWs4X9LB5M/4nfIirjI/Db21q60/DxDqGd9ExhAAo5qhh0UkCeeZVQH+Z4b2ZgNKf74d8wfkW2vFK0wa3tBxoW9peucMgpIhG7tsaUI3CZm6Wmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrWamkk6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33097e1133fso12724791fa.1;
        Thu, 24 Jul 2025 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753383275; x=1753988075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ijSk7QskYjpTyK8bVw3INdFGsVMtzdXh/QKVQVcOkU=;
        b=mrWamkk6DvH/MJ9bAdSQkTSkfN2zkN5iIlPODMxLcIun33Ys+wZWorpBXZ1cbuxk35
         JBKJmCjGT3ovhrNGnTPvThQ+91ZO3VF2Ot95uk6XWbK5VinoraxGAjq8ELAn8hlqNZeH
         YNFm68juvycxgh5eXNAaKQIIuu9xbOpe9soovBtkTlhgJJBNZwoZzFv+Gv/1oZthKiSs
         Vf/iCIuySWiVGzWvzdAqfAGbuTwSL5BSxOBo3ac3X/hArSI3wbG/1rxibypfujvMMnw8
         ruxE7O884VbDCZ94hzmw0BFfSIWT4XoxkJ5W+PtzkTiSJw9Fbg5ZM1yA8Ir0FkGA0Nb4
         L6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383275; x=1753988075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ijSk7QskYjpTyK8bVw3INdFGsVMtzdXh/QKVQVcOkU=;
        b=S9zQGinCtPun28mg7T1ftJw7jzFxf1yeVNL9aGNt5MjyCWsEGwg/kKCCXDa3iGf4Gh
         X9mWqMcyuTUPbzSQO2s/GZvHvrS8lPUmf1rFqSvIunKjRfqogGSz1ysdd2lLe5f4YYoQ
         DLzKuqL3+ZLYAxUgei90bLehyUAJs/alqUlbBGMj1LHx2XtG0nAeb+EAUEimIlVAxyow
         ETFxE46Hu7wFEhis4YyZUz+DakNf3X2fpo8qZoGLhnC8asGUh+ulA362JKmML/peZFz1
         A9wUUJETxUIkZgtuctumtAyysopfemLGYb0j15FhmMQQKSXhCHm8BiBBN/O1yYtj3Jr/
         W7dA==
X-Forwarded-Encrypted: i=1; AJvYcCWITD/EuoKcvad2I1pwpmB/cZvcJjZaK4gboPeavupACkh/lk959kKdZRYcEzwzayg2AeuT0Urgh0I=@vger.kernel.org, AJvYcCWR6W6dZ7jmiGQAhjhcBXCa5zZRfqSaMwNA6JawRW1u1tl++odILfSMev79s7trAanKFBgDArGvV/0+7EbS@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFWwOszO+ajpveNrXLPRfh8qC/1gW07By7V5M0nQd6N6eiEJf
	ouEVmcjvgKf2Sd97wXWzv/ZNWLH/JfDgKnW8ddRNaZyXhpG5XuuMYljg2qZ9xjCyG1SzjBDNUaF
	++BcpN2Gs4wYWWgUQ+ZZUj6pWFanQUpk=
X-Gm-Gg: ASbGncshFMQaJmNN+J/TM7wfHnDEo36UjiG765Jg2wy8zI3yuG62HS0BufGloWPw5Bz
	skyOWvCARlb2511BAZqcemvVkgz9S1RFZZQAC/A5a7twvpA+efLZrcC5s+8u0ZKaQcXgrNA6QfD
	wDHxu6fCqUCBqekzu+NCcGb8Urf3p/WL4Pkdkh1V5gNwQir3Q9bxt7qcE9Ps4K5Sg4uLFoTwmjM
	EX7IrGUdFeSCBYfOhNmAW4AiVYSIENzeE872RD0lg==
X-Google-Smtp-Source: AGHT+IG9EuHm1P3KrGqSFeyfqN4yloIzeuOPQ8o8aTK9HGHxo5BWMxso5dDhyeQoGOcUiunlzsc9rLb4u2ZasQF8jAc=
X-Received: by 2002:a05:651c:1986:b0:32b:80e1:300d with SMTP id
 38308e7fff4ca-330dfaa6f52mr29091311fa.0.1753383274213; Thu, 24 Jul 2025
 11:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com> <20250721195419.526920-2-akshayaj.lkd@gmail.com>
In-Reply-To: <20250721195419.526920-2-akshayaj.lkd@gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Fri, 25 Jul 2025 00:24:22 +0530
X-Gm-Features: Ac12FXx1yG3AE99wuna7d6P9cuBv9SHxx6lTYY2ihETbWOs36a7qMy3z0Vg4JvQ
Message-ID: <CAE3SzaTFgLsLCw-bqSTygaanCpHKHGRj7ssGim84WjB-DxZPVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: ltr390: Add conditional data freshness
 check with sysfs control
To: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:25=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
>
> Add logic to check the sensor=E2=80=99s data freshness status bit before =
reading
> data, and skip reads if the data is stale.
>
> Introduce a new boolean sysfs attribute, `data_fresh_check_enable`, to al=
low
> users to enable or disable this behavior at runtime:
>
>   - 1: Enable data freshness check (default)
>   - 0: Disable data freshness check
>
> This provides flexibility to choose between ensuring fresh data and allow=
ing
> faster reads when occasional staleness is acceptable.
>
> Document the new attribute under Documentation/ABI/testing/sysfs-bus-iio.
>
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
> -> Tested on Raspberrypi 4B. Follow for more details.
>
> akshayajpi@raspberrypi:~ $ uname -r
> 6.12.35-v8+
> akshayajpi@raspberrypi:~ $ uname -a
> Linux raspberrypi 6.12.35-v8+ #5 SMP PREEMPT Tue Jul 15 17:38:06 IST 2025=
 aarch64 GNU/Linux
>
> -> Sensor Detection, overlaying of device tree and Driver loading
> akshayajpi@raspberrypi:~ $ i2cdetect -y 1
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                         -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- 53 -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> akshayajpi@raspberrypi:~ $ sudo dtoverlay i2c-sensor ltr390
> akshayajpi@raspberrypi:~ $ lsmod|grep ltr390
> ltr390                 16384  0
> industrialio          110592  1 ltr390
> regmap_i2c             12288  1 ltr390
>
> -> Sysfs Attribute Creation validation
> akshayajpi@raspberrypi:~ $ ls -ltrh /sys/bus/iio/devices/iio\:device0/
> total 0
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 uevent
> -r--r--r-- 1 root root 4.0K Jul 21 23:52 name
> -r--r--r-- 1 root root 4.0K Jul 21 23:52 waiting_for_supplier
> lrwxrwxrwx 1 root root    0 Jul 21 23:52 subsystem -> ../../../../../../.=
./bus/iio
> -r--r--r-- 1 root root 4.0K Jul 21 23:52 scale_available
> -r--r--r-- 1 root root 4.0K Jul 21 23:52 sampling_frequency_available
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 sampling_frequency
> drwxr-xr-x 2 root root    0 Jul 21 23:52 power
> lrwxrwxrwx 1 root root    0 Jul 21 23:52 of_node -> ../../../../../../../=
firmware/devicetree/base/soc/i2c@7e804000/ltr390@53
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_uvindex_scale
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_uvindex_raw
> -r--r--r-- 1 root root 4.0K Jul 21 23:52 integration_time_available
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 integration_time
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_illuminance_scale
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 in_illuminance_raw
> drwxr-xr-x 2 root root    0 Jul 21 23:52 events
> -r--r--r-- 1 root root 4.0K Jul 21 23:52 dev
> -rw-r--r-- 1 root root 4.0K Jul 21 23:52 data_fresh_check_enable<-----
> -r--r--r-- 1 root root 4.0K Jul 21 23:52 data_fresh
>
> -> Default value 1 for data_fresh_check_enable
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh
> 1
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh_check_enable
> 1
>
> -> Disable fresh measurement in the sensor
> akshayajpi@raspberrypi:~ $ i2cset -f -y 1 0x53 0x0 0x0
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh_check_enable
> 1
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh_check_enable
> 1
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> 647
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh
> 0
>
> -> Since data_fresh_enable_check is enabled by default, driver skips
>    stale data read and emits -EAGAIN.
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temp=
orarily unavailable
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temp=
orarily unavailable
> akshayajpi@raspberrypi:~ $
>
> -> Disable data_fresh_check_en
> akshayajpi@raspberrypi:~ $ echo 0 | sudo tee /sys/bus/iio/devices/iio\:de=
vice0/data_fresh_check_enable
> 0
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh_check_enable
> 0
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh
> 0
>
> -> Since freshness check is disabled, driver reads and prints stale
>    data.
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> 647
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> 647
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> 647
>
> -> Re-enabling freshness check, results in driver emitting -EAGAIN.
> akshayajpi@raspberrypi:~ $ echo 1 | sudo tee /sys/bus/iio/devices/iio\:de=
vice0/data_fresh_check_enable
> 1
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/data_fre=
sh_check_enable
> 1
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temp=
orarily unavailable
> akshayajpi@raspberrypi:~ $ cat /sys/bus/iio/devices/iio\:device0/in_illum=
inance_raw
> cat: '/sys/bus/iio/devices/iio:device0/in_illuminance_raw': Resource temp=
orarily unavailable
>
>  Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++
>  drivers/iio/light/ltr390.c              | 55 ++++++++++++++++++++++++-
>  2 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/=
testing/sysfs-bus-iio
> index 5d176d46c15d..da881e16ee3d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2397,3 +2397,15 @@ Description:
>
>                 Provides userspace visibility into data_freshness status =
which
>                 can be used for debugging and informational use.
> +
> +What:          /sys/.../iio:deviceX/data_fresh_check_enable
> +KernelVersion: 6.16
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Read-write boolean attribute controlling whether the driv=
er
> +               checks the data freshness status bit before reading senso=
r data.
> +
> +               0 - Freshness check disabled
> +               1 - Enable check; driver will skip reading stale data (de=
fault)
> +
> +               This flag affects the behavior of data reads.
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 5af0ffd3df1d..b13f01835aeb 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -98,6 +98,7 @@ struct ltr390_data {
>         enum ltr390_mode mode;
>         int gain;
>         int int_time_us;
> +       bool data_fresh_check_en;
>  };
>
>  static const struct regmap_config ltr390_regmap_config =3D {
> @@ -199,10 +200,40 @@ static ssize_t data_fresh_show(struct device *dev,
>         return sysfs_emit(buf, "%d\n", !!(status & LTR390_DATA_STATUS_MAS=
K));
>  }
>
> +static ssize_t data_fresh_check_enable_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct ltr390_data *data =3D iio_priv(dev_to_iio_dev(dev));
> +
> +       guard(mutex)(&data->lock);
> +
> +       return sysfs_emit(buf, "%d\n", data->data_fresh_check_en);
> +}
> +
> +static ssize_t data_fresh_check_enable_store(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf, size_t len)
> +{
> +       int ret;
> +       bool data_fresh_check_en;
> +       struct ltr390_data *data =3D iio_priv(dev_to_iio_dev(dev));
> +
> +       ret =3D kstrtobool(buf, &data_fresh_check_en);
> +       if (ret)
> +               return ret;
> +
> +       guard(mutex)(&data->lock);
> +
> +       data->data_fresh_check_en =3D data_fresh_check_en;
> +       return len;
> +}
> +
>  static IIO_DEVICE_ATTR_RO(data_fresh, 0);
> +static IIO_DEVICE_ATTR_RW(data_fresh_check_enable, 0);
>
>  static struct attribute *ltr390_attributes[] =3D {
>         &iio_dev_attr_data_fresh.dev_attr.attr,
> +       &iio_dev_attr_data_fresh_check_enable.dev_attr.attr,
>         NULL
>  };
>
> @@ -214,7 +245,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device=
,
>                            struct iio_chan_spec const *chan, int *val,
>                            int *val2, long mask)
>  {
> -       int ret;
> +       int ret, status;
>         struct ltr390_data *data =3D iio_priv(iio_device);
>
>         guard(mutex)(&data->lock);
> @@ -226,6 +257,16 @@ static int ltr390_read_raw(struct iio_dev *iio_devic=
e,
>                         if (ret < 0)
>                                 return ret;
>
> +                       if (data->data_fresh_check_en) {
> +                               ret =3D ltr390_register_read(data, LTR390=
_MAIN_STATUS);
> +                               if (ret < 0)
> +                                       return ret;
> +
> +                               status =3D ret;
> +                               if (!(status & LTR390_DATA_STATUS_MASK))
> +                                       return -EAGAIN;
> +                       }
> +
>                         ret =3D ltr390_register_read(data, LTR390_UVS_DAT=
A);
>                         if (ret < 0)
>                                 return ret;
> @@ -236,6 +277,16 @@ static int ltr390_read_raw(struct iio_dev *iio_devic=
e,
>                         if (ret < 0)
>                                 return ret;
>
> +                       if (data->data_fresh_check_en) {
> +                               ret =3D ltr390_register_read(data, LTR390=
_MAIN_STATUS);
> +                               if (ret < 0)
> +                                       return ret;
> +
> +                               status =3D ret;
> +                               if (!(status & LTR390_DATA_STATUS_MASK))
> +                                       return -EAGAIN;
> +                       }
> +
>                         ret =3D ltr390_register_read(data, LTR390_ALS_DAT=
A);
>                         if (ret < 0)
>                                 return ret;
> @@ -687,6 +738,8 @@ static int ltr390_probe(struct i2c_client *client)
>         data->gain =3D 3;
>         /* default mode for ltr390 is ALS mode */
>         data->mode =3D LTR390_SET_ALS_MODE;
> +       /* default value for data_fresh_check_en is 1 */
> +       data->data_fresh_check_en =3D 1;
I agree that this will break the user behaviour.
Before dumping this off, I wanted to explore an idea.
What if this remains disabled by default, i.e. data->data_fresh_check_en =
=3D 0;
So this way the regular sensor read_data calls will not break, and
based on demand,
the application can configure the driver to check for data freshness,
by toggling the sysfs attribute to 1.
i.e. echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/data_fresh_check_e=
nable

Thanks,
Akshay

