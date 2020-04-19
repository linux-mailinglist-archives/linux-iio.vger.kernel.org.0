Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326A01AF769
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSGBv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgDSGBv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 02:01:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3062CC061A0C
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:01:51 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q10so5083280ile.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fsK17HepZ9t6IIBF7i5cqm2XDf2qSTiC6cmbVUc5ts0=;
        b=HkMMCdAnIvmdBZHYpcs16V35bpjPzJjknDldX77R3y2f1xrilDw+qbmT3psfjGU0Ag
         fHhy5N/xbCsBc/LLg2GnaTJWdu33J/FXOGHSVAU/McM96+QLqgUIr2S0Raml+CoOR17u
         tgUeckYPZh2uzlS+o06GD0lzGU0dNxaX7edP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsK17HepZ9t6IIBF7i5cqm2XDf2qSTiC6cmbVUc5ts0=;
        b=LS9cPu74AHWKxOfaBwhcXCvRk+aVggTQIfrC8mgDtaUhok+rjWiBDBTGrdS/Tgj+hE
         nv23W7I4qS2yeYl4ZQTPmqV4EQYyMUL5CPo/4WH5tBqTIlcA61ax2JeLZDckyqirw5Fo
         EOJiyA/W0KI4QdNAi8X6bD78HpmapyTUd2Q0zKoIXsWinsT1HQPWLD8Yxa754DpptyKS
         0a4ikNqLZ35oXHPxI9ISYojsLt6GLXEMBy0jVWpOP4FJaTvnY+KQhOej9HySfSgcQ8cn
         5D/VI8Tux5XdLbwQLMxP3p/9WID/jZF90ZAqoVcSvc/AMtraXhP5us/WxzdXRNya/Y0S
         0hRQ==
X-Gm-Message-State: AGi0PuYTAm7Ov5lUPAM4G0fxeWE10zfPj89Em4s4zzzMhVvkHYjZUjZ8
        u1rTKyMKTx4D9DwroIJFJAPO1cvtl8HekHhnseQlsGdVWTY/gQ==
X-Google-Smtp-Source: APiQypKeWYI0zWahe9sSyd+nOUbotL3M4Ca/T1SSFZxj56355Qlrkq+nnN/kG2uevsQHgsnZRhok2w3EkG7pcoXkX6A=
X-Received: by 2002:a92:ad09:: with SMTP id w9mr3533243ilh.177.1587276110484;
 Sat, 18 Apr 2020 23:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200419055907.23411-1-matt.ranostay@konsulko.com> <20200419055907.23411-3-matt.ranostay@konsulko.com>
In-Reply-To: <20200419055907.23411-3-matt.ranostay@konsulko.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 18 Apr 2020 23:01:39 -0700
Message-ID: <CAJCx=g=ADPQETdMF2OeUQ4V0Ox4jCQabc5YWFOGGq-B4rOA1Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: chemical: atlas-sensor: add RTD-SM module support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

*sigh* wrong patch submitted.. ignore this for now.. v2 coming up..

- Matt

On Sat, Apr 18, 2020 at 10:59 PM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> Atlas Scientific RTD-SM OEM sensor reads temperate using
> resistance temperature detector technology.
>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 32 +++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 82d470561ad3..b58ef9759c08 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -68,16 +68,20 @@
>  #define ATLAS_REG_DO_TEMP_DATA         0x12
>  #define ATLAS_REG_DO_DATA              0x22
>
> +#define ATLAS_REG_RTD_DATA             0x0e
> +
>  #define ATLAS_PH_INT_TIME_IN_MS                450
>  #define ATLAS_EC_INT_TIME_IN_MS                650
>  #define ATLAS_ORP_INT_TIME_IN_MS       450
>  #define ATLAS_DO_INT_TIME_IN_MS                450
> +#define ATLAS_RTD_INT_TIME_IN_MS       450
>
>  enum {
>         ATLAS_PH_SM,
>         ATLAS_EC_SM,
>         ATLAS_ORP_SM,
>         ATLAS_DO_SM,
> +       ATLAS_RTD_SM,
>  };
>
>  struct atlas_data {
> @@ -199,13 +203,29 @@ static const struct iio_chan_spec atlas_do_channels[] = {
>         {
>                 .type = IIO_TEMP,
>                 .address = ATLAS_REG_DO_TEMP_DATA,
> -               .info_mask_separate =
> -                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>                 .output = 1,
>                 .scan_index = -1
>         },
>  };
>
> +static const struct iio_chan_spec atlas_rtd_channels[] = {
> +       {
> +               .type = IIO_TEMP,
> +               .address = ATLAS_REG_RTD_DATA,
> +               .info_mask_separate =
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .scan_index = 0,
> +               .scan_type = {
> +                       .sign = 'u',
> +                       .realbits = 32,
> +                       .storagebits = 32,
> +                       .endianness = IIO_BE,
> +               },
> +       },
> +       IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
>  static int atlas_check_ph_calibration(struct atlas_data *data)
>  {
>         struct device *dev = &data->client->dev;
> @@ -350,6 +370,12 @@ static struct atlas_device atlas_devices[] = {
>                                 .calibration = &atlas_check_do_calibration,
>                                 .delay = ATLAS_DO_INT_TIME_IN_MS,
>         },
> +       [ATLAS_RTD_SM] = {
> +                               .channels = atlas_rtd_channels,
> +                               .num_channels = 2,
> +                               .data_reg = ATLAS_REG_RTD_DATA,
> +                               .delay = ATLAS_RTD_INT_TIME_IN_MS,
> +       },
>  };
>
>  static int atlas_set_powermode(struct atlas_data *data, int on)
> @@ -566,6 +592,7 @@ static const struct i2c_device_id atlas_id[] = {
>         { "atlas-ec-sm", ATLAS_EC_SM},
>         { "atlas-orp-sm", ATLAS_ORP_SM},
>         { "atlas-do-sm", ATLAS_DO_SM},
> +       { "atlas-rtd-sm", ATLAS_RTD_SM},
>         {}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_id);
> @@ -575,6 +602,7 @@ static const struct of_device_id atlas_dt_ids[] = {
>         { .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
>         { .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
>         { .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
> +       { .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, atlas_dt_ids);
> --
> 2.20.1
>
