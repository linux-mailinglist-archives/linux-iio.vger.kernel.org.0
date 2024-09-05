Return-Path: <linux-iio+bounces-9196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B496DBE1
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D6B26C0B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8716426;
	Thu,  5 Sep 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WayLhooo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E1125D6;
	Thu,  5 Sep 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546781; cv=none; b=llZyMnoFr8WGuKHuhg3igXQp+qiyb8laVgQc1R0En5NO1sITT0ksA/ClRwpY2KSvlli8ULbGTPOJbGTy8Wqd5/uiZBIoVUKeg4uxyvuzOxZuHPlizjjbfe8OWwFFVzP+Fmf/VDN2ZdHCXmyew3aiq2BNjgNyUPcFymtoEo7+mvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546781; c=relaxed/simple;
	bh=0A+s3H37++IvYKk6gW340TzQZEWiS7VSk7wtNsZLzTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVYqYR5SfoQCFhkbYVD6FOfIYImKzuCGc0hUvb8PCbPJWkFFHASnnZa6heAtGKvK5fPi6mpzSWXEvjVr54S2KNtnXTUud03lqg3yY3oDGlqNMgjhXWPJEevGSnkPe9LkYsrlvy77gaMBUzMARQ1z1uTGYIyVwqNxiSZ5wdapqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WayLhooo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2053525bd90so8582115ad.0;
        Thu, 05 Sep 2024 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725546779; x=1726151579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqUIS3IYAntrsQ78J8BadQpaqj7oa2eN12jU71ttnpg=;
        b=WayLhooo7tJMOJdDZZ6OdGEodDRD67c2QMNOpFnV4wf3YZXAZlnCewSvsMGE9PoQNH
         v7lykp/KiqxEx3eL6Jvi47YVxCxNuTmn9ZNxWAjSgWPT2P7JaQ0dchF5W9qvVGeH1a/e
         /63FrjMjkfIyBQEBsmY1NCCz1ZI5tuezDmZdtKVM+mrmWIexg+NgNwMRv95uBA/qHGNt
         q6Db2qLFfIFdFmF9AGNT4as/USN4dUPSuL+f8BF5NustQc8N7GUTNbjcnQ5LzHpjxRFo
         5QQLuLz81SBwleK/gSX2YlYLYWCuyDsXv5WwokIcrI7fQIr3niy8gPJU9lYp4ekYMjHV
         rmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725546779; x=1726151579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqUIS3IYAntrsQ78J8BadQpaqj7oa2eN12jU71ttnpg=;
        b=OkvyShyhdVGcO7OXyIpDvVzogwM58ZAr4R9aDBhD344yiZv+Yl8aH7VrYPE1sw3z0p
         rOAzsudme4ulv6PnnZEmoaFI6ae5SYaLqTl+rGcUzdJYC/IXoCqmiYm64uhi1HjUkWdg
         5A0EiRIBvo3S5SfCKcHByCbGl4VAHTYYnn5VLXYo0j1pzl8HolFX+6XlNvxJjiMG4+gu
         JkkTrm3DYENhDWXiqRxdXtZ8S9lznRHoFZhPNFpbpUBosrxdIfedhWlZFFhxiesaF/Ju
         2dYb/aPR87Ir5+x2hx2VkcldJ10nvONs7B8JQE/f5eAICuqzyCPoPxWdmsbqMFVnlTa0
         UoFg==
X-Forwarded-Encrypted: i=1; AJvYcCUFD56AsMqZxcAUKQLU42KlpOBFsaeB8LAeXPoA96p4VdTK6a0ru0LZdvyXWbe2kX4CqvD6lAaK7dQ=@vger.kernel.org, AJvYcCUjJo404fxO9Hu1K5CVm4TDw1FoJNUjnTWqSmCQw6vAj9kizdjqG7u/qOTRPL42CzK9Gm+rbpC8DmQvFE37@vger.kernel.org
X-Gm-Message-State: AOJu0Yysbql/aADRzaShQlhmFDf6Lr+kWlYI7blNvHwOvwPW0+pff1DZ
	Ot5Lu8sNE5W8k/PKQLQT2cj68TzGsg6aSu8kjxqPSYHWmsYUzxdgvXaeov5BIIBEDSmWk/7nvWv
	F1a0Sr/3ZXp8/w0LhbAy2q5x6NlyZp6/zZVU=
X-Google-Smtp-Source: AGHT+IFgJIUJF1UnvHA6Rd1TsE0hTkxSP5upI5IAA12tyZ1jbH1JI48pXvOQiFqCcm+31nh2W/r63s6RnNUEIA9brbc=
X-Received: by 2002:a17:903:32cd:b0:205:6f40:221c with SMTP id
 d9443c01a7336-2056f402712mr145010625ad.35.1725546778827; Thu, 05 Sep 2024
 07:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903163302.105268-1-gye976@gmail.com> <FR3P281MB1757A2ECAB94077B8E250314CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB1757A2ECAB94077B8E250314CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: gyeyoung <gye976@gmail.com>
Date: Thu, 5 Sep 2024 23:32:47 +0900
Message-ID: <CAKbEznuKUDf4vUa3r52WWxWg9qmB5cYayGehqHe==RuF-1F+3Q@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe function
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response. I understand what you mean.

But I think it's better to have 'wom_bits' in 'inv_mpu6050_state',
because the 'wom_bits' variable is only a variable for bit operation
with the 'INT_STATUS' register, not an actual register in register
manual.
Isn't it?

Thanks.

On Thu, Sep 5, 2024 at 6:30=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
>
> Hello,
>
> nice improvement, thanks.
>
> But beware there is a fix pending in fixes-togreg branch and missing in t=
esting branch that is changing this part of code.
> To avoid a painful merge, it should be better to wait for the fix to be i=
ntegrated inside testing.
>
> Is that correct Jonathan?
>
> And I would prefer the wom_bits being inside the inv_mpu6050_reg_map stru=
cture.
>
> Thanks,
> JB
>
> ________________________________________
> From: Gyeyoung Baek <gye976@gmail.com>
> Sent: Tuesday, September 3, 2024 18:33
> To: jic23@kernel.org <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@v=
ger.kernel.org <linux-kernel@vger.kernel.org>; Gyeyoung Baek <gye976@gmail.=
com>
> Subject: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe =
function
>
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
>
> 'wom_bits' variable is defined by chip type,
> and chip type is statically defined by device tree.
> so 'wom_bits' need to be set once during probe function.
>
> but before code set it every time using 'switch statement' during
> threaded irq handler, so i move that to probe function.
>
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 16 +++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  1 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 20 ++-----------------
>  3 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 14d95f34e981..322ae664adc0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -2076,6 +2076,22 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,
>                 return result;
>         }
>
> +       switch (chip_type) {
> +       case INV_MPU6050:
> +       case INV_MPU6500:
> +       case INV_MPU6515:
> +       case INV_MPU6880:
> +       case INV_MPU6000:
> +       case INV_MPU9150:
> +       case INV_MPU9250:
> +       case INV_MPU9255:
> +               st->wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> +               break;
> +       default:
> +               st->wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> +               break;
> +       }
> +
>         return 0;
>
>  error_power_off:
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h
> index e1c0c5146876..a91b9c2b26e4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -212,6 +212,7 @@ struct inv_mpu6050_state {
>         bool level_shifter;
>         u8 *data;
>         s64 it_timestamp;
> +       unsigned int wom_bits;
>  };
>
>  /*register and associated bit definition*/
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_trigger.c
> index 84273660ca2e..b19556df1801 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -243,26 +243,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int=
 irq, void *p)
>  {
>         struct iio_dev *indio_dev =3D p;
>         struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> -       unsigned int int_status, wom_bits;
> +       unsigned int int_status;
>         u64 ev_code;
>         int result;
>
> -       switch (st->chip_type) {
> -       case INV_MPU6050:
> -       case INV_MPU6500:
> -       case INV_MPU6515:
> -       case INV_MPU6880:
> -       case INV_MPU6000:
> -       case INV_MPU9150:
> -       case INV_MPU9250:
> -       case INV_MPU9255:
> -               wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> -               break;
> -       default:
> -               wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> -               break;
> -       }
> -
>         scoped_guard(mutex, &st->lock) {
>                 /* ack interrupt and check status */
>                 result =3D regmap_read(st->map, st->reg->int_status, &int=
_status);
> @@ -272,7 +256,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int i=
rq, void *p)
>                 }
>
>                 /* handle WoM event */
> -               if (st->chip_config.wom_en && (int_status & wom_bits)) {
> +               if (st->chip_config.wom_en && (int_status & st->wom_bits)=
) {
>                         ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_=
MOD_X_OR_Y_OR_Z,
>                                                      IIO_EV_TYPE_ROC, IIO=
_EV_DIR_RISING);
>                         iio_push_event(indio_dev, ev_code, st->it_timesta=
mp);
> --
> 2.34.1
>
>

