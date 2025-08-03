Return-Path: <linux-iio+bounces-22230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECECB1951A
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 22:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5BC188EA31
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE01EEA54;
	Sun,  3 Aug 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHgGtzZV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10A173
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754251969; cv=none; b=IhmyAwHDMwptTmi1UqKSZjqDpYB4HDPi58OEVAIvg02ltDC6Vw2pXHS+IZwJtkLPT+j9DgyDa7qwljjmLGZjrmQwsOdQHU97G4rz1c0J3Dn6dR3lgWYgJQyq72Yj89KGgOtsia6ox1mheXFOuPRFJSX00XF5Wm5eu9kkx0TIVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754251969; c=relaxed/simple;
	bh=lFWHMN7GEk99jNUK3d6+dk0DiRxeeHhg+O1swkA47OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVrUfz4+BhU3L2a4zDqcFUcm9/fKuzV0bOTkoCV3QNJzOf/wV2U/TTugIn56jhQLxxJMjTQgg5305qYXqLkF1RDu6rJ4BNo5KTSoWiK7OYsfx3GfkHFYhUdwgbPCcvw/UUCYlVrXTQDT7ZAukBVyu/zTMq+VWMwQ3H3UR2EfmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHgGtzZV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so3688603a12.3
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754251966; x=1754856766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxrz4Jn52x2JnJBjO15ndcSV6MknewLLeh6Y/hpY45g=;
        b=eHgGtzZVSYTkeKJAs+36PkpqfAPq4ZyWDwC4ZSXFRGGKF4NV6nuKVORCklPcRf4HVf
         7ozw8RjGyHTyESy6c6Rhs7osdRN74OJJAJbBDz1JZ8oG0UWfuHCxm4DNBWDfIJ5i+0xC
         foKxz7s6JcR1nvseRDu1s8+VyqNAWAivLJ0OEY9gTTHmf8f4ihAoNvcb//+JJqhA5+k9
         ivkq6o5NZb5oTiRgJYeFteofSV8eqdF4SqF6TXcHTC7uUwvFvXcEPjB/hjCNM3ZqJho6
         J6RSHSMyKS29oUh1618ERAnBq2J7T/jlN59SRROIDAIhPJKXtRPUHHnw6b61weyjy69h
         dM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754251966; x=1754856766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxrz4Jn52x2JnJBjO15ndcSV6MknewLLeh6Y/hpY45g=;
        b=QliHkPlwFnE2NrZ83faRUfPMg1FEbxnEu2B2VCNQ26SQ+rl4zcEOgcT5grNZXKeF7+
         QlhzTqq13hfQdzKBIBxtFvU/cir68Htzy2whUdCOHUNZ6VBxW0mgsaof40wWSWNfCCea
         KLLLYka4w0IsaAE859x8Z8ErMPurfNLruikNHI0MbVS4ywZruOixpclWgY4wKFS/N2Tq
         aL7An0Lc9Ff0l3uc41qfVoTel1hTuwkyAi1DfXsNtjoxPr+MvQq6gBjm6M2TggQwWWKc
         oZ7rSDZ6M2y8vgAWc/9Q5KsC5SrJM0d+UeqDVTopDFH2KDlxIhRzYEX5r/DWXgEyRV46
         0bbA==
X-Gm-Message-State: AOJu0Yw6bSDTtPc3BSe0UZhrm1kpgVpPSp3UPVM4gvVUGmdfcr7EIRnt
	fZckkMdNQAuXQHVHU8QKkDQSvAtZ3niCxl5iRwswlDZyZrYDUyc43j3Uz9DvZnmOgjaie8sDdEV
	VFVuWkCu7tWn4n0pJRkfGX5ljlB6n9BAJSdfOHMk=
X-Gm-Gg: ASbGnctvatkYvnrnMnG2fqrHzi8MHpWOMxyxl18iqzSme5eh8VxbDefghr1bzRJtSvw
	yE0GLqTD1XXdZJ+DmFzXYz+hW1ZDuQdI6Vcu9TGgCASUW6PvTLscUDzgK8YLps9rlSYEffLapKs
	DHnrJ/XmjICCyiVl3QXa4AHF3W8zOGfjCCF5i1mWnBEZnct0UbF9U5OEYxKz5UcWt7KxUUOmXPc
	pA5N30LICODwGhdbIXZ
X-Google-Smtp-Source: AGHT+IFTlXh+/zYJagpQ/jbIgYQmFtqy4ZODtXBum9d7wNSgDslFSyDknl2XVXAGwYS2XhXs7xwF0VElf4uXdfPqRvo=
X-Received: by 2002:a17:907:2d28:b0:aec:6600:dbe3 with SMTP id
 a640c23a62f3a-af940223539mr791468966b.56.1754251965992; Sun, 03 Aug 2025
 13:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE> <20250803140802.36888-3-Achim.Gratz@Stromeko.DE>
In-Reply-To: <20250803140802.36888-3-Achim.Gratz@Stromeko.DE>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 22:12:09 +0200
X-Gm-Features: Ac12FXy0_joDFiFsfY_LlTILcfyDwnfrouwDh9F7lbDdyHxarFAPdN8lTViGrnE
Message-ID: <CAHp75VfQxSgQwJQsym9X58G6o4UUgz6EQ4ouhhx82aOHv_if2g@mail.gmail.com>
Subject: Re: [bmp280 v1 2/6] iio: pressure: bmp280: reduce overhead on read
 with MODE_FORCED
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 4:09=E2=80=AFPM Achim Gratz <Achim.Gratz@stromeko.de=
> wrote:
>
> When measuring with MODE_FORCED, each read through sysfs triggers a
> new measurement cycle through aLL channels with the current channel

all

> configuration, even though we can only access a single channel.
> Reduce the incurred overhead (especially for higher oversampling_ratio
> settings) by temporarily switching off the unused channels.  This
> savea about a third of the acquisition time when reading all three

savea??

> channels in succession:
>
> | oversampling | max/full | max/skip | time/full | time/skip |
> |              |     [ms] |     [ms] |      [ms] |      [ms] |
> |--------------+----------+----------+-----------+-----------|
> |           16 |      339 |      120 |       315 |       127 |
> |            8 |      174 |       65 |       166 |        76 |
> |            4 |       90 |       38 |        94 |        53 |
> |            2 |       49 |       24 |        59 |        41 |
> |            1 |       28 |       17 |        36 |        33 |
>
> The results are from an I=C2=B2C connected sensor at 400kHz, so there is
> considerable overhead from the changing the channel configuration,
> most noticeably with low oversampling_ratio values.  Faster
> communication will reduce this overhead further; and since there is
> still a net reduction in acquisition time even for
> oversampling_ratio=3D1 switching off the channels is always done.
>
> Note: The IIR filters will process a slightly noisier input signal.

...

> +       int prev_oversampling_humid, prev_oversampling_press, prev_oversa=
mpling_temp;
> +       int temp_oversampling_humid, temp_oversampling_press, temp_oversa=
mpling_temp;
> +       int switch_off, switch_threshold =3D -1;

Are you sure everything here needs to be a _signed_ integer and
moreover _used_ as a such?
AFAICS switch_off usage is boolean with definitely the wrong type here.

...

> +               case IIO_HUMIDITYRELATIVE:
> +                       temp_oversampling_press =3D 0-1;
> +                       switch_off |=3D (prev_oversampling_press > switch=
_threshold);

What's the point of '|'? Ditto for every case.

> +                       /* can't be switched off as it is needed for comp=
ensation */
> +                       temp_oversampling_temp  =3D 1-1;
> +                       break;

...

>                 ret =3D data->chip_info->set_mode(data, BMP280_FORCED);
>                 if (ret)
> -                       return ret;

> -

Stray change (blank line removal).

> +                       goto restore;
>                 ret =3D data->chip_info->wait_conv(data);
>                 if (ret)
> -                       return ret;
> +                       goto restore;

...

>         case IIO_CHAN_INFO_RAW:

Same comments as per above.

...

>                 ret =3D data->chip_info->set_mode(data, BMP280_FORCED);
>                 if (ret)
> -                       return ret;
> -
> +                       goto restore;
>                 ret =3D data->chip_info->wait_conv(data);
>                 if (ret)
> -                       return ret;
> +                       goto restore;

Same comments as per above.

...

> +restore:

With the above switch that returns on every case, this makes code less
readable. Consider refactoring first the function and then having a
code flow without an additional label.

> +       if (switch_off) {
> +       /* restore channel configuration */
> +               data->oversampling_humid =3D prev_oversampling_humid;
> +               data->oversampling_press =3D prev_oversampling_press;
> +               data->oversampling_temp  =3D prev_oversampling_temp;
> +               data->chip_info->chip_config(data);
> +       }
> +       return ret;

...

> +       do {
> +               /*
> +                * Waiting time according to the BM(P/E)2 Sensor API.
> +                *
> +                * First wait is for slightly longer than the typical mea=
surement time, then
> +                * each successive wait cycle will divide that time by 8.=
  The number of wait
> +                * cycles determines the overhead, this number and the me=
asurement durations
> +                * need to be chosen so that the total wait time meets or=
 exceeds the maximum
> +                * measurement time acccording to the datasheet.

according

> +                */
> +               fsleep(meas_time_us);

Can the meas_time_us be 0? What will happen in that case?

> +               ret =3D regmap_read(data->regmap, BMP280_REG_STATUS, &reg=
);
> +               if (ret) {
> +                       dev_err(data->dev, "failed to read status registe=
r.\n");
> +                       return ret;
> +               }
> +       } while ((reg & BMP280_REG_STATUS_MEAS_BIT) &&
> +                --wait_cycles &&
> +                (meas_time_us >>=3D 3));

Why not regmap_read_poll_timeout()?

...

> +#define BMP280_MEAS_OFFSET             1112 /* ceil(1250 * 8/9) */
> +#define BMP280_MEAS_DUR                        2045 /* ceil(2300 * 8/9) =
*/
> +#define BMP280_PRESS_HUMID_MEAS_OFFSET 512  /* ceil( 575 * 8/9) */

Instead of the not properly used style for the comment and comments
themselves use the preprocessor to do this for you. This not only
makes review easier (no need to recalculate by ourselves each time we
look at the code) but also eliminates potential typos.

--=20
With Best Regards,
Andy Shevchenko

