Return-Path: <linux-iio+bounces-20920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E606EAE4D2C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 20:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D57AB25B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB022D322D;
	Mon, 23 Jun 2025 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pt4dtf7b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B828AB16
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704714; cv=none; b=Ge9vRWYc/RG4/Kiz25/vmlqzDhhcWsx1vgB/Y3TfDAkP6BXRl2bcehm2zQRbvFkE7n1YuoGPbHMSLqAI3KenVINUwhFuPz2rnxc1wQGvCI6kBpRnbiDhkMbiWJR17dgWO7wAnLQuKdR8eRY2u6KFiZSJtUfiBfhcbmWG4MywNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704714; c=relaxed/simple;
	bh=dAGcpPn9BKdjZg6u5r0ynv05efA6L8kLk1089lC0m7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsqUvmDvUdCPGcAvCdM2zeeIEdEDQdxJF4IcM45mECnztRSoRel7eZzYepNkVZ37PFwC0cK1EyLbbn4m0gKHXqrAWaQHQB1WrPpC3qVZFm0jisxvRv+fZQbrrTnKhsljbwpRvjFLRwWxKfibXn3/iBYf6JfzG9Y15ksImdPQOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pt4dtf7b; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5314b486207so1255110e0c.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750704712; x=1751309512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUA0XE0sgECf7mZrc3TcVnQkYoYJalGvBUM1bDhYGOE=;
        b=Pt4dtf7bi0AS+v1T9L3xBntxpzv+0SFWdO50umgcDpJCcrBLQgTkAgIwogBMXs0NdO
         7/8W0QHxPuBqbUeyN8IhkibVoD5jf74F28NfPWAQwH9vwVxMAobHBtLT/3Cnvr2KjS43
         w+DMQIiYCPc8A+POEDO/P9gfftwpDXYtSGIBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704712; x=1751309512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUA0XE0sgECf7mZrc3TcVnQkYoYJalGvBUM1bDhYGOE=;
        b=J/2PoCS/KODMGmZnJjSsBcZInpNbI0asvtbrEICR3sWrKbhC1FlNo9O8RdjPk4gWYy
         p2q2D8bYBTxB7MCIGLIu3yWymVb4pAJMTiWYkPBaVL4ape2XjqZdvZsNZEBE03tfYxFL
         t7IfaBPWioN++yvshPhUqY16P5NUu10hbu8AHN03gWopVH9vlD5igeNC8qLyrcx7YwjX
         zkNW0SDWZvQt/VkgD8qfBnJnUjF5TTMuYMXbs1Fl38kKRpbc7gpTs0WYv3jsUgjFWqxl
         ODKHGpMElElNiT+Rmof34utQ5L+ak848oEBHJBtYofOCcE8BozKcOC2bWG+5erhoFAKw
         Tmpw==
X-Forwarded-Encrypted: i=1; AJvYcCXWkwFlgNa7UL/jsOru16/SzOYZ/hiE45sr2q9/LZqDzhgbw/wNYuY6WuUFJmYE1vWz69pZbN0zeF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUkSCQxQxRDhwiNl7hTHaY1LUOpKad/unVaxFCdQQBsnsRfxc
	RChzUasvTZOo+lwOHT/6zWQg/bi9vllqlRBhwoOIZpgw1xmbMsvxLCbyyFLLNdmwl5U3qBgBRnA
	7fmDL+hyZSA5flDOd+9C//OuB6rDTxhnkhXCdXTV3d2wOdJr1f9M=
X-Gm-Gg: ASbGncvTSgFWXVyG4pVUsLmWUadz4dvaCVEPKYWlEbtJAJiV0ZztLyykr9D+SmPriJB
	4D5KjDYJzSCsIiS8cDUIuhcHUPsDjvBui9aNQ5gDUPtqgHaPS3zdBQ+aE/8Q1rFIX+2ophr8Q7j
	PBYLhny/NYPh8cesYw3qRRxDPMNpmpaEgs0UA5k2YLaMH55NKYz8qIKZDIoDRji36k8Hjljw==
X-Google-Smtp-Source: AGHT+IGi/fuIUaK0ZImUSVjqylNlJmhkZ9ZsBCULM+hKWJwO0aXvyHRZTh7gsKJxRpUEOckagu4tpk8+P+gUDmI92cM=
X-Received: by 2002:a05:6122:1314:b0:531:4708:3d45 with SMTP id
 71dfb90a1353d-531ad8c17ccmr7898482e0c.10.1750704711675; Mon, 23 Jun 2025
 11:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623184817.220409-1-gwendal@google.com>
In-Reply-To: <20250623184817.220409-1-gwendal@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 23 Jun 2025 11:51:40 -0700
X-Gm-Features: AX0GCFsHHGcCYlrXcTLSutu8zYA1Th_N_SV58RXlPzvwbDsi_T3ZtfdAg-9oCzQ
Message-ID: <CAPUE2uux+FATvm44RAzQe50h3orztARe3XSZkjqfNMp68d2B=g@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: cros_ec_sensors: Flush changing the FIFO timeout
To: jic23@kernel.org
Cc: tzungbi@kernel.org, chrome-platform@lists.linux.dev, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ignore this patch, I sent the wrong file.

Gwendal.

On Mon, Jun 23, 2025 at 11:48=E2=80=AFAM Gwendal Grignou <gwendal@chromium.=
org> wrote:
>
> From: Gwendal Grignou <gwendal@chromium.org>
>
> fifo_timeout is used by the EC firmware only when a new sample is
> available.
> When the timeout changes, espcially when the new timeout is shorter than
> the current one, we need to send the samples waiting in the FIFO.
>
> Change-Id: Iec40367472bd301123c22e38d0ad8aca4ed41379
> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 51 ++++++++++++-------
>  1 file changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index bd8483866d046..339faee6ab44b 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -105,22 +105,6 @@ static void get_default_min_max_freq(enum motionsens=
or_type type,
>         }
>  }
>
> -static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state =
*st,
> -                                     int rate)
> -{
> -       int ret;
> -
> -       if (rate > U16_MAX)
> -               rate =3D U16_MAX;
> -
> -       mutex_lock(&st->cmd_lock);
> -       st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> -       st->param.ec_rate.data =3D rate;
> -       ret =3D cros_ec_motion_send_host_cmd(st, 0);
> -       mutex_unlock(&st->cmd_lock);
> -       return ret;
> -}
> -
>  static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
>                                                  struct device_attribute =
*attr,
>                                                  const char *buf, size_t =
len)
> @@ -136,7 +120,25 @@ static ssize_t cros_ec_sensor_set_report_latency(str=
uct device *dev,
>
>         /* EC rate is in ms. */
>         latency =3D integer * 1000 + fract / 1000;
> -       ret =3D cros_ec_sensor_set_ec_rate(st, latency);
> +
> +       mutex_lock(&st->cmd_lock);
> +       st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> +       st->param.ec_rate.data =3D min(U16_MAX, latency);
> +       ret =3D cros_ec_motion_send_host_cmd(st, 0);
> +       mutex_unlock(&st->cmd_lock);
> +       if (ret < 0)
> +               return ret;
> +
> +       /*
> +        * Flush samples currently in the FIFO, expecially when the new l=
atency
> +        * is shorter than the old one: new timeout value is only conside=
red when
> +        * there is a new sample available. It can take a while for a slo=
w
> +        * sensor.
> +        */
> +       mutex_lock(&st->cmd_lock);
> +       st->param.cmd =3D MOTIONSENSE_CMD_FIFO_FLUSH;
> +       ret =3D cros_ec_motion_send_host_cmd(st, 0);
> +       mutex_unlock(&st->cmd_lock);
>         if (ret < 0)
>                 return ret;
>
> @@ -154,7 +156,6 @@ static ssize_t cros_ec_sensor_get_report_latency(stru=
ct device *dev,
>         mutex_lock(&st->cmd_lock);
>         st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
>         st->param.ec_rate.data =3D EC_MOTION_SENSE_NO_VALUE;
> -
>         ret =3D cros_ec_motion_send_host_cmd(st, 0);
>         latency =3D st->resp->ec_rate.ret;
>         mutex_unlock(&st->cmd_lock);
> @@ -769,6 +770,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
>   * @mask:      specifies which values to be requested
>   *
>   * Return:     the type of value returned by the device
> + *
> + * cmd_lock mutex held.
>   */
>  int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>                           struct iio_chan_spec const *chan,
> @@ -841,6 +844,8 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
>   * @mask:      specifies which values to write
>   *
>   * Return:     the type of value returned by the device
> + *
> + * cmd_lock mutex held.
>   */
>  int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>                                struct iio_chan_spec const *chan,
> @@ -858,6 +863,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sensor=
s_core_state *st,
>                 st->param.sensor_odr.roundup =3D 1;
>
>                 ret =3D cros_ec_motion_send_host_cmd(st, 0);
> +
> +               /* Flush the FIFO in case we are stopping a sensor.
> +                * If the FIFO has just been emptied, pending samples wil=
l be
> +                * stuck until new samples are available. It will not hap=
pen
> +                * when all the sensors are stopped.
> +                */
> +               if (frequency =3D=3D 0) {
> +                       st->param.cmd =3D MOTIONSENSE_CMD_FIFO_FLUSH;
> +                       cros_ec_motion_send_host_cmd(st, 0);
> +               }
>                 break;
>         default:
>                 ret =3D -EINVAL;
> --
> 2.49.0.472.ge94155a9ec-goog
>

