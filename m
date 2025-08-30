Return-Path: <linux-iio+bounces-23507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92C4B3CF47
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 22:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2097B38BF
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715892DFA2B;
	Sat, 30 Aug 2025 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImGmFVja"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590613D51E;
	Sat, 30 Aug 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586586; cv=none; b=nVbZfD66oymphlnhX4MpI7gxANiRzkCG7duis/aeq2bJqIGhAO4pFfXppKU6fBzvwtLWFbKQqwCRVOo7tjZqfVdZ88OlB6cjCFpLxx9p1Jf9E53hca0mh1lr3eF6U72Iu56xdrO513SnV7FPIwRAk4sdrx2HspXN7XNWjjzsuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586586; c=relaxed/simple;
	bh=Oc1SfZPRwpPbIA67baTaaoY0Mim5mSLqWxxH+3osxrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXDcwkkYK70YGQx0GEUmWIlF3zoXIZQJOOu0XHugELuKysmkgAJnPhrKF6MmldYRmlUoyIYvz5jRZrvJzLhbOIShfNMAH70cqXhMnw+J96v7KyWlg6Lc/A2RcYoPkh0HFrR4y9l8eQadvMU+7eHiqL+a3GeEqoKoK8wLohdnhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImGmFVja; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so3862245a12.0;
        Sat, 30 Aug 2025 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586583; x=1757191383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+MrdMl6FNd1ZxMPqxCMJ/a2n5M5hiW2ISh619iEIHA=;
        b=ImGmFVjaxkXlCATXBqvICb6jGI5eR1X5t2st2vtObGIgEWaxJcwXr7fwlirK8gdkOF
         gPpEp7t6Lie7+0eaydpgvobR+g2Q/dvgWfgfgNiumhGB7vd/K2H1TwqWS6OK1xi5PQ85
         2H/jYk+7WVysiw3EJohdEhRSdHqTzr3bgcMywDLzA3HiZgr6rolk6K8vW2OA/6e9J95S
         Qynglq9TSqnavtK63fhrtvO3n2lWip6hxQtKTKov5o1uqzaCJE8+ZzseT8kyDYSLL2vw
         KMAh99A2cdDqpVS8GlnszlHnROoZQUsAbyo/LdcudONzjwjG3ljh1W3+1RVR1LctRJbe
         RicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586583; x=1757191383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+MrdMl6FNd1ZxMPqxCMJ/a2n5M5hiW2ISh619iEIHA=;
        b=pMiOg/PzuedtQ7nkQb1lz0SvIb/bLDssbe3ilMhEhiGimlutKikCyshArseLjBHl8/
         NkMviaa8+HLwFpTABeEz04SRU8+UzXzW6FsLG5p4jy3in0gn+mAHABmyYQ3+GaYvHJT+
         1IBopeFfdGMF92dN33JoTaHXfKWxbb9OTrytbtbdUx19RvazxExVDBneL8Vao1u3FCs2
         B5HFF7gXWqSOvm2XOX+MiVD7/iEhoM9jcy5EfwEurxDzcMHqUvBhS/+1ARMoNBXSJRL8
         x4yccQHMxsa4xu+PBYbWqU0iPp7tFTi8ya11VzSGT9gg8Pln/kHYQaFz0BHscydIpGyD
         AQtg==
X-Forwarded-Encrypted: i=1; AJvYcCU7evv1QhlYZ+gpnf43RlJlWBedPSxBWqus73qGtqOB8H6+Weq7G5H9ifkiVsset6UGmwOxIkNOX+YxP8l0@vger.kernel.org, AJvYcCUlWt+8eNFFehhfhrinyIAIy6t8dSORmxAMgpjDB8c7yMrELZ+nKjhSm2BO26PHtt4k2rCVIu3fDhNY@vger.kernel.org, AJvYcCWdRGHbU/ZOwVjxs0zkNtptnXUjNT0OlkINYt5urR5CeLLsBuc9iV39FKl0rpqDP1/jT5+nYNiN5Wdj@vger.kernel.org
X-Gm-Message-State: AOJu0YwSsT94vRSo5LSJJ6/Ff6geUCXDj1x9QI/H4NE0+/YxymvVUXiD
	r7+JQY8doraLHUVYGlaW0LIYKdLZ/BnsBAAzvwawo55zbYmBgZ5t5KsN9EeMJlZlNdBirT00Hs5
	7OTvrj+kuZ8HmQhfFgqjsHB8K3hiVyeU=
X-Gm-Gg: ASbGnctZJ9AjzAqT3yaiwDirry/guOK8Y5hDkdnYFxclGvMlOY1B3RtsmIpkcFFqS0E
	VwlZezkOnLP2Z5b3QRsG+KDMMUUzHyQaHAG/g4lkTQHP11TMG6dMSPDp5jISGeLVLsa9gqoG6F7
	Rhcq10DLehjhQhGVEvTf+08V123iUvvUCR7YB1BHOgzKILZ08rcS5bdj0keBACrFqF9Ypm7i3Ku
	pHYsD0=
X-Google-Smtp-Source: AGHT+IFaKr7FnzUn+u/3zAbu74/m+MUS+zy1Z33pn1upAiuuCG6iCNpqUuYU61DihfQubaHis63R6Gf7ZlPQ0g4fhp4=
X-Received: by 2002:a17:907:3f94:b0:afe:7cb6:60f0 with SMTP id
 a640c23a62f3a-b01d8c86d85mr267547466b.29.1756586582493; Sat, 30 Aug 2025
 13:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com> <20250831-icm20948-v1-2-1fe560a38de4@gmail.com>
In-Reply-To: <20250831-icm20948-v1-2-1fe560a38de4@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 23:42:26 +0300
X-Gm-Features: Ac12FXyByc6WY8IgtCHwKu6rFKt3EKG4bJeBI51LQx3fl2seio61SrYeE0Vk-10
Message-ID: <CAHp75VeKfHQH3LMCjVdjd=kJA4s6-Ux1-WHNzOsYA-f4QkkUyw@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: imu: add inv_icm20948
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 9:43=E2=80=AFPM Bharadwaj Raju
<bharadwaj.raju777@gmail.com> wrote:
>
> Core parts of the new ICM20948 driver.
>
> Add register definitions, probing, setup, and an IIO device for
> reading the onboard temperature sensor.

...

>  drivers/iio/imu/Kconfig                          |   1 +
>  drivers/iio/imu/Makefile                         |   1 +
>  drivers/iio/imu/inv_icm20948/Kconfig             |  17 ++++
>  drivers/iio/imu/inv_icm20948/Makefile            |   8 ++
>  drivers/iio/imu/inv_icm20948/inv_icm20948.h      |  47 +++++++++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_core.c | 122 +++++++++++++++++=
++++++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c  |  48 +++++++++
>  drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c | 108 +++++++++++++++++=
+++
>  8 files changed, 352 insertions(+)

This looks strange. The few files are created here, and there is no
comment like "new file ..."
That said, the MAINTAINER is not updated here and hence the file will
be orphaned till the MAINTAINER changes. So, update incrementally
MAINTAINERS starting from the first patch.

...

> +#ifndef INV_ICM20948_H_
> +#define INV_ICM20948_H_
> +
> +#include <linux/bits.h>

> +#include <linux/bitfield.h>

Unused.

> +#include <linux/mutex.h>

> +#include <linux/regmap.h>

Can be replaced with proper forward declarations.

> +#include <linux/i2c.h>

Unused

> +#include <linux/iio/iio.h>

Forward declaration.

> +#include <linux/err.h>

Unused.

Keep it ordered and follow the IWYU principle (include what you use).
Currently this is a semi-random list of the inclusions. And missed
forward declarations.

...

> +#define INV_ICM20948_REG_BANK_SEL 0x7F

Make all register offsets to be fixed-width, like 0x007F

> +#define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
> +
> +#define INV_ICM20948_REG_WHOAMI 0x0000
> +#define INV_ICM20948_WHOAMI 0xEA
> +
> +#define INV_ICM20948_REG_FIFO_RW 0x0072
> +
> +#define INV_ICM20948_REG_PWR_MGMT_1 0x0006
> +#define INV_ICM20948_PWR_MGMT_1_DEV_RESET BIT(7)
> +#define INV_ICM20948_PWR_MGMT_1_SLEEP BIT(6)
> +
> +#define INV_ICM20948_REG_TEMP_DATA 0x0039
> +
> +extern const struct regmap_config inv_icm20948_regmap_config;
> +
> +struct inv_icm20948_state {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct iio_dev *temp_dev;
> +       struct mutex lock;
> +};
> +
> +extern int inv_icm20948_core_probe(struct regmap *regmap);
> +
> +struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state)=
;
> +
> +#endif

...

> +#include "inv_icm20948.h"

This file uses much more than the private header. Please, fix this properly=
.

...

> +static const struct regmap_range_cfg inv_icm20948_regmap_ranges[] =3D {
> +       {
> +               .name =3D "user banks",
> +               .range_min =3D 0x0000,
> +               .range_max =3D 0x3FFF,

Are you sure about range_min? This will cause circular caching and
unpleasant side-effects.

> +               .selector_reg =3D INV_ICM20948_REG_BANK_SEL,
> +               .selector_mask =3D INV_ICM20948_BANK_SEL_MASK,
> +               .window_start =3D 0,
> +               .window_len =3D 0x1000,
> +       },
> +};
> +
> +static const struct regmap_range inv_icm20948_regmap_volatile_yes_ranges=
[] =3D {
> +       /* WHOAMI */
> +       regmap_reg_range(0x0000, 0x0000),
> +       /* PWR_MGMT_1 */
> +       regmap_reg_range(0x0006, 0x0006),
> +       /* I2C and INT status */
> +       regmap_reg_range(0x0017, 0x001C),
> +       /* Sensor readouts */
> +       regmap_reg_range(0x0028, 0x0052),
> +       /* FIFO count and data */
> +       regmap_reg_range(0x0070, 0x0072),
> +       /* Data ready status */
> +       regmap_reg_range(0x0074, 0x0074),

So, the above are real, the below are virtual? How does it work?

> +       /* GYRO_CONFIG_1 */
> +       regmap_reg_range(0x2001, 0x2001),
> +       /* I2C SLV4 data in */
> +       regmap_reg_range(0x307F, 0x307F),
> +};

...

> +static const struct regmap_range inv_icm20948_rd_noinc_no_ranges[] =3D {
> +       regmap_reg_range(0x0000, INV_ICM20948_REG_FIFO_RW - 1),
> +       regmap_reg_range(INV_ICM20948_REG_FIFO_RW + 1, 0x3FFF),

Make 0x3fff a constant and use it everywhere.

> +};

...

> +const struct regmap_config inv_icm20948_regmap_config =3D {
> +       .name =3D "inv_icm20948",
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .max_register =3D 0x3FFF,

See above.

> +       .ranges =3D inv_icm20948_regmap_ranges,
> +       .num_ranges =3D ARRAY_SIZE(inv_icm20948_regmap_ranges),
> +       .volatile_table =3D &inv_icm20948_regmap_volatile_accesses,
> +       .rd_noinc_table =3D &inv_icm20948_regmap_rd_noinc_table,
> +       .cache_type =3D REGCACHE_MAPLE,
> +};

...

> +static int inv_icm20948_setup(struct inv_icm20948_state *state)
> +{
> +       guard(mutex)(&state->lock);
> +
> +       int reported_whoami;
> +       int ret =3D regmap_read(state->regmap, INV_ICM20948_REG_WHOAMI,
> +                             &reported_whoami);

Just no. We almost do not allow a mixture of the definitions and code.

> +       if (ret)
> +               return ret;
> +       if (reported_whoami !=3D INV_ICM20948_WHOAMI) {
> +               dev_err(state->dev, "invalid whoami %d, expected %d\n",
> +                       reported_whoami, INV_ICM20948_WHOAMI);
> +               return -ENODEV;
> +       }
> +
> +       ret =3D regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGM=
T_1,
> +                               INV_ICM20948_PWR_MGMT_1_DEV_RESET,
> +                               INV_ICM20948_PWR_MGMT_1_DEV_RESET);
> +       if (ret)
> +               return ret;

Any long sleeps (and even 1ms is already long on modern fast CPUs)
must be explained.

> +       msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
> +
> +       ret =3D regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGM=
T_1,
> +                               INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
> +       if (ret)
> +               return ret;

> +       msleep(INV_ICM20948_SLEEP_WAKEUP_MS);

Ditto.

> +       state->temp_dev =3D inv_icm20948_temp_init(state);

> +       if (IS_ERR(state->temp_dev))
> +               return PTR_ERR(state->temp_dev);
> +
> +       return 0;


return PTR_ERR_OR_ZERO(...);

> +}
> +
> +int inv_icm20948_core_probe(struct regmap *regmap)
> +{
> +       struct device *dev =3D regmap_get_device(regmap);

> +

Have you ever run checkpatch.pl? We do not allow blank lines in the
definition blocks.

> +       struct inv_icm20948_state *state;
> +
> +       state =3D devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> +       if (!state)
> +               return -ENOMEM;
> +
> +       state->regmap =3D regmap;
> +       state->dev =3D dev;

> +       mutex_init(&state->lock);

devm_mutex_init()

> +       return inv_icm20948_setup(state);
> +}

...

> +#include <linux/kernel.h>

This header must not be used in the regular drivers. Follow the IWYU princi=
ple.

> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>

Keep them ordered.

...

> +static int inv_icm20948_probe(struct i2c_client *client)
> +{
> +       struct regmap *regmap =3D
> +               devm_regmap_init_i2c(client, &inv_icm20948_regmap_config)=
;
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);

This is wrong stylistically.
First of all, there must be a blank line between definition block and
the code, BUT in this case the code will be harder to maintain and it
will be prone to subtle errors, that's why it's recommended to split
definition and the assignment and move assignment closest to the
check.

> +       return inv_icm20948_core_probe(regmap);
> +}
> +
> +static const struct i2c_device_id inv_icm20948_id[] =3D { { "icm20948" }=
, {} };

No, please make it readable.

> +MODULE_DEVICE_TABLE(i2c, inv_icm20948_id);
> +
> +static const struct of_device_id inv_icm20948_of_matches[] =3D {
> +       { .compatible =3D "invensense,icm20948" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm20948_of_matches);
> +
> +static struct i2c_driver inv_icm20948_driver =3D {
> +       .driver =3D {
> +               .name =3D "icm20948",
> +               .of_match_table =3D inv_icm20948_of_matches,
> +       },
> +       .probe =3D inv_icm20948_probe,
> +       .id_table =3D inv_icm20948_id,
> +};
> +module_i2c_driver(inv_icm20948_driver);
> +
> +MODULE_AUTHOR("Bharadwaj Raju <bharadwaj.raju777@gmail.com>");
> +MODULE_DESCRIPTION("InvenSense ICM-20948 device driver (I2C)");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_ICM20948");

I stop here as I believe the whole series needs much more work to
follow IWYU, the style, coding standards, etc...
When you are done with that, come up with a new version.

Thanks!

--
With Best Regards,
Andy Shevchenko

