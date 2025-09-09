Return-Path: <linux-iio+bounces-23900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D666B4AACB
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 12:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6AE1C602C6
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DEA31B825;
	Tue,  9 Sep 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzPTdm7m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52F31B10E;
	Tue,  9 Sep 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414068; cv=none; b=DmYsOYtlvR0CKfos7hGOCnkBorbGTpg50Km1jnp55mVW+Adf4huDeTWDUn08Z+m/inPJbmhk+jNCcQIvAlaLIBVtYmy1/wjqKuv8+IJCsb/8NO+Ga6sH51+ihGict92/0GFrvfjFlonS58sgM4Sp6dHIs9sijwW2RtDi3sZGhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414068; c=relaxed/simple;
	bh=JP0XNgNpP8hs5zSj922+ugM5c82GbYQvoCg74VDxh/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsJdaxFF8soDfuZkwjYb9SZfGT7Kzn9Cpz7AsAlMhua1B92/uTRTMCmUYMA6GzAktgikpxWxxLz/0UrgB/nnoKfmPyI8nL2Byp76bEU+bTji43vvz/1sEg0wF7leabiOJAaROW8XoW6TLHr56vvs5mXgsbpjYdZt88b/CpPjXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzPTdm7m; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04ba58a84fso417718266b.2;
        Tue, 09 Sep 2025 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757414064; x=1758018864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIdms+T9avOm/SSFFUzhJdDUjY0a4M6JmVeG2AGja5o=;
        b=DzPTdm7mNwydy2U2iu0G/aWhCZ2dKq2arOcZ68r1iBB55eU3v6vju/+hpc7NTyyFa5
         Gq6dPC6hy+qkKEuG2tNiw3ob2/lSCft918SHUPG9YvTqBe1g/ZQJUMiGolOvySYC+TuM
         PTj6Bnr4PUFsv3h0WL+zG1IS+C6SfyB1XgbqD+MvrVNCTvTZ9LhIoiRIHaQwVd4Teb4r
         gAV/e4Ico1x4ZgDUYK8mEDqFvq1yRWUUsezlpBv89FL6djN9FTqRkKSlUDUSACfWO4tZ
         /jhklfVx4UYNO6Yl5/a+VYdtsTe8g0j52RvLVYPCUCYeMuW9rdfofppLZ7Z8xVpIerzP
         vhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757414064; x=1758018864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIdms+T9avOm/SSFFUzhJdDUjY0a4M6JmVeG2AGja5o=;
        b=ZmhJ0Gv/MmtVyMIxAS1wLoGdkghxJCbYBlMCfnPADQx0Ce1VGYLosr77O+FJh6B+74
         GsoylrFwkstt9g513cAHXAGDRhVpahXHgKOiGYTmPPvklofdABK/OcK3SA3l4rXDCsV3
         X9NfbBpgeCzM9EgcvAN3/X74RyfeQduH9vEBG3TSD0SYTvk7a0unftZ73HOXZ6geyl+d
         qNR51jyhKltdQdolvPf46m0XW1fLI91SICEmHpmnm7j35OJ8q1vuI/iDwv00NS60oiKq
         CO0d2aHxpBK1FCkYZuTEW0HpMKFHz5D77XR5IqgqjgUmTnaAnj5FlL57T2EAJFYBmxht
         LTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFvAcTcngg9sa8ykb6x1tmzOE/bAURQRiskoihdPGo7YDrzYu3K5DOwIOlaXb7oeYmN4t46vl9GJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxjsPimLiDXejpYNbYBEK4hX/JjbVwD2T/0gw9YeUocm7D8q/
	YZX1+WhBj1E4qAOPePj1WCzIqCk676m8VnevvxjJi+fqCGzdTC61xVm+e1m/JwSVrh7Ktq2Eq/M
	iL3HZijMhbGGnyt+0dK89ImiyYihnnlc=
X-Gm-Gg: ASbGncvMKFsRJP2rmF82RLJkCRtY3w+w/wpkI4PkGcII3yUxyY5FjAnyG70NOwBInpL
	WMz8o8brYjHZOQW9JKQFw2e98YJewKRzsiepqFY4c0/X/MOW/lqUPh6ypy5MHBbzSzzWarWqt5A
	/qQdIqzHxPcC2yYbajkmXHD7Ro5P+FT/rrlRmIMSO9vtRQBAosEMQ7os7XgQ7VVyAccb3h+i0i5
	urcef1EGngt3R9jfi6vukqiI4vMrccvHstYGierKBOt
X-Google-Smtp-Source: AGHT+IG0Inkh5tNcx6+4D5TIh70ivyhYMwMBin16AO8oli1i6S44fQI6KaMT/3f9JE/qxr/7rXj1/9Ybfa4BZcHTTQg=
X-Received: by 2002:a17:907:2d1f:b0:b04:3fe2:23c4 with SMTP id
 a640c23a62f3a-b04b1437f92mr1166081866b.19.1757414064106; Tue, 09 Sep 2025
 03:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757061697.git.michal.simek@amd.com> <2780986977702f126416ec442c5336bd541f475b.1757061697.git.michal.simek@amd.com>
In-Reply-To: <2780986977702f126416ec442c5336bd541f475b.1757061697.git.michal.simek@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 9 Sep 2025 13:33:47 +0300
X-Gm-Features: Ac12FXwKPRN_B8-TT82eURXpq587luV-gkx05Hh9QxN6ejEbtq4XJNNqktpNGrU
Message-ID: <CAHp75Vc1hkf8jgP76+oHgKU_hFn2STPbgO550ZP2Z39KaCFb7A@mail.gmail.com>
Subject: Re: [PATCH 2/6] iio: versal-sysmon: add driver for Versal Sysmon
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, 
	git@xilinx.com, Salih Erim <salih.erim@amd.com>, 
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Andy Shevchenko <andy@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:42=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> Sysmon Driver uses Linux IIO framework, which was used to abstract the
> supply voltages and temperatures across the chip as Voltage and Temperatu=
re
> Channels in the framework. Since there are only 160 supply voltage
> registers and 184 measurement points, there is no constant mapping of
> supply voltage registers and the measurement points. User has to select
> the voltages to monitor in design tool. Depending on the selection, a

in the design

> voltage supply gets mapped to one of the supply registers. So, this mappi=
ng
> information is provided to the driver via a device tree. Depending on the
> number of supplies enabled in the design, the device tree will contain th=
e
> information of name of the supply enabled and the supply register it maps
> to.

...

> +config VERSAL_SYSMON
> +       tristate "Xilinx Sysmon driver for Versal"
> +       depends on HAS_IOMEM
> +       select VERSAL_SYSMON_CORE
> +       help
> +         Say yes here to have support for the Xilinx Sysmon.
> +         The driver will enable users to monitor temperature and voltage=
 on the
> +         Xilinx Versal platform.
> +
> +         The driver can also be build as a module. If so, the module wil=
l be called

built

> +         versal-sysmon.

...

> +#include <linux/bits.h>

Quite a few headers are absent...

+ export.h
+ types.h

> +#include "versal-sysmon.h"

...

> +static u32 sysmon_temp_offset(int address)
> +{
> +       switch (address) {
> +       case TEMP_MAX:
> +               return SYSMON_TEMP_MAX;
> +       case TEMP_MIN:
> +               return SYSMON_TEMP_MIN;
> +       case TEMP_MAX_MAX:
> +               return SYSMON_TEMP_MAX_MAX;
> +       case TEMP_MIN_MIN:
> +               return SYSMON_TEMP_MIN_MIN;
> +       case TEMP_HBM:
> +               return SYSMON_TEMP_HBM;
> +       default:
> +               return -EINVAL;
> +       }

> +       return -EINVAL;

Here and in many more, eliminate dead code.

> +}

...

> +static u32 sysmon_supply_thresh_offset(int address,
> +                                      enum iio_event_direction dir)
> +{
> +       if (dir =3D=3D IIO_EV_DIR_RISING)
> +               return (address * 4) + SYSMON_SUPPLY_TH_UP;

> +       else if (dir =3D=3D IIO_EV_DIR_FALLING)
> +               return (address * 4) + SYSMON_SUPPLY_TH_LOW;

Redundant 'else'.

> +       return -EINVAL;
> +}

...

> +static void sysmon_hbm_to_millicelsius(int raw_data, int *val, int *val2=
)
> +{
> +       *val =3D ((raw_data >> SYSMON_HBM_TEMP_SHIFT) & SYSMON_HBM_TEMP_M=
ASK) *
> +               SYSMON_MILLI_SCALE;

Can the whole driver be switched to FIELD_PREP()/FIELD_GET()/FIELD_MODIFY()=
?

> +       *val2 =3D 0;
> +}

...

> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val, int val2=
)
> +{

> +       (void)val2;

Unneeded.

> +       *raw_data =3D (val << SYSMON_FRACTIONAL_SHIFT) / SYSMON_MILLI_SCA=
LE;
> +}

...

> +static void sysmon_supply_processedtoraw(int val, int val2, u32 reg_val,
> +                                        u32 *raw_data)
> +{
> +       int exponent =3D (reg_val & SYSMON_MODE_MASK) >> SYSMON_MODE_SHIF=
T;
> +       int format =3D (reg_val & SYSMON_FMT_MASK) >> SYSMON_FMT_SHIFT;
> +       int scale =3D 1 << (16 - exponent);
> +       int tmp;
> +
> +       tmp =3D (val * scale) / SYSMON_MILLI_SCALE;
> +
> +       /* Set out of bound values to saturation levels */
> +       if (format) {
> +               if (tmp > SYSMON_UPPER_SATURATION_SIGNED)
> +                       tmp =3D 0x7fff;
> +               else if (tmp < SYSMON_LOWER_SATURATION_SIGNED)
> +                       tmp =3D 0x8000;

This looks like s16 limits, can you use them?

> +       } else {
> +               if (tmp > SYSMON_UPPER_SATURATION)
> +                       tmp =3D 0xffff;
> +               else if (tmp < SYSMON_LOWER_SATURATION)
> +                       tmp =3D 0x0000;

u16 respectively.

> +       }
> +
> +       *raw_data =3D tmp & 0xffff;
> +}


> +       u32 ret =3D -EINVAL;

> +       mutex_lock(&sysmon->mutex);
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       offset =3D sysmon_temp_offset(chan->address);
> +                       *val =3D sysmon->temp_read(sysmon, offset);
> +                       *val2 =3D 0;
> +                       ret =3D IIO_VAL_INT;
> +                       break;
> +
> +               case IIO_VOLTAGE:
> +                       offset =3D sysmon_supply_offset(chan->address);
> +                       sysmon_read_reg(sysmon, offset, &regval);
> +                       *val =3D (int)regval;
> +                       *val2 =3D 0;
> +                       ret =3D IIO_VAL_INT;
> +                       break;
> +
> +               default:
> +                       break;
> +               }> +
> +       spin_unlock_irqrestore(&sysmon->lock, flags);
> +       mutex_unlock(&sysmon->mutex);
> +
> +       return 0;
> +}

...

> +#include <linux/bits.h>

+ io.h

> +#include <linux/moduleparam.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include "versal-sysmon.h"
> +
> +static LIST_HEAD(sysmon_list_head);

list.h?

> +static struct iio_map sysmon_therm_static_maps[] =3D {
> +       IIO_MAP("temp", "versal-thermal", "sysmon-temp-channel"),

Where are the IIO_MAP() and struct iio_map defined?

> +       {}
> +};
> +
> +static inline int sysmon_direct_read_reg(struct sysmon *sysmon, u32 offs=
et, u32 *data)

+ types.h for uXX.

> +{
> +       *data =3D readl(sysmon->base + offset);
> +
> +       return 0;
> +}

...

> +       mutex_init(&sysmon->mutex);

devm?

...

> +       indio_dev->dev.parent =3D &pdev->dev;
> +       indio_dev->dev.of_node =3D pdev->dev.of_node;

Drop these, IIO core does the same and even better.

...

> +       mutex_lock(&sysmon->mutex);

scoped_guard() from cleanup.h

> +       if (list_empty(&sysmon_list_head)) {
> +               sysmon->master_slr =3D true;

No need, just make a sane default and !exist will work in the other
branch the same way. I believe it's

  bool exist =3D false;

> +       } else {
> +               list_for_each_entry(temp_sysmon, &sysmon_list_head, list)=
 {
> +                       if (temp_sysmon->master_slr)
> +                               exist =3D true;

Why to continue?

> +               }
> +               sysmon->master_slr =3D !exist;
> +       }
> +
> +       mutex_unlock(&sysmon->mutex);

...

> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/adc/versal-sysmon-events.h>
> +#include <linux/iopoll.h>

> +#include <linux/kernel.h>

Mustn't be used in new drivers.

> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/of_address.h>

Huh?! Please, make sure you are following IWYU principle, please
*drop* all of the headers that are *not* being used (by this header),
there are a LOT of them to be dropped.

...

> +/* Channel IDs for Temp Channels */
> +/* TEMP_MAX gives the current temperature for Production
> + * silicon.
> + * TEMP_MAX gives the current maximum temperature for ES1
> + * silicon.
> + */
> +#define TEMP_MAX       160

Here and everywhere else, bad namings.

...

This is an unfinished review due to the following reasons (from more
important to less):
- AMD is not the first day contributor, the code is awful, it missed a
lot of reviews and updates regarding the last several years of the
kernel development (IIO subsystem in particular). Please, avoid
letting reviewers do *your* job.
- The patches are too long to review, it would be nicer to make them
feature-by-feature, where each one is < 1000 LoCs.
- I started this a few days ago, but I'm busy at the moment, that's
another reason.

--
With Best Regards,
Andy Shevchenko

