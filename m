Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35B32BAAE1
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 14:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKTNPD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 08:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKTNPC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 08:15:02 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC31DC0613CF;
        Fri, 20 Nov 2020 05:15:02 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b16so6998357qtb.6;
        Fri, 20 Nov 2020 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJenwxuMJ3fHhAqhSb9DRcOy5ZgHFW9ardFwfPRGSio=;
        b=TQ8tCR+3msq61mUjTsOCu2tEfQijzpFcbBd9E1FpvhBaLp/XmfKkMZiaDViqlX5D0P
         nNWtgIrvltPSMTW56191BUeI1yzdMXB2i96sLgrT44WNuGk/Eol/ELUkCjt+bwcTAD9i
         1YMmCOl4Xc9ZDyAz01WrV0T/CkwBN/1DlJrDws+kRVgf7oYLUoIE+DxGO0SlRXnxwD3p
         IQCX+zRdH67nFAGkXefRbNX4IRnAzgA4tNrX5u/WDKnoKQn7xgoH9xzxCnpllCOeUIun
         7DTaCeXhZUARG1NZjywcMYXOEww/zHBL2nm/1tFrOQY8/6zToAEQtXG20W/vUZ3lFGOW
         Aifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJenwxuMJ3fHhAqhSb9DRcOy5ZgHFW9ardFwfPRGSio=;
        b=SkSDalZ0L5dX1HeynnWS9H4rwhVQj+MGtf15wms3Hr8+GuX85uaj9o5vcd/E7LLt5z
         xx6iQiSuYYaj5lTngp0DTpHbmm5TAT+6ZWY2an1+Y8wBAnOLSFcu/dyfnv5OgGZq8iao
         H6/8zNqNVB2qAoNnOtYLKCKRTs9pqNGMznNJYOLnEys33Nsugajtu0pKYw/JBlR45vP6
         FR8MTbxJJvFIJCXz/glN1kpjL7F5Uw3CcXhV/A4BYgfDFYI6mEZU345Q+UgzeSJV5tRL
         Mua0pKnVcAbcqPmZ+PaVGXAb33NnqlNruZmCaZ6eUoFebQlc8GurFY78kPl17jIGW5/v
         PyDw==
X-Gm-Message-State: AOAM5333FfHqTFGyWGzI4bREf/AlZMLWcfedcrceBW3aJb35glXi19Fr
        aug+zUBU4I6c6QAdDk+v2M+7X+pmMLG32bbzLZTCWFqQgqs=
X-Google-Smtp-Source: ABdhPJw9f+0WPTBvR82J0tnwOZmunJ1poP5d26B+Q+WNv5jbC4SH8rIDenJemutiALLu1IXmymLF148sGh1AUI+/9IM=
X-Received: by 2002:ac8:7a70:: with SMTP id w16mr15678577qtt.61.1605878101749;
 Fri, 20 Nov 2020 05:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120030103.36138-1-matt.ranostay@konsulko.com>
In-Reply-To: <20201120030103.36138-1-matt.ranostay@konsulko.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Fri, 20 Nov 2020 18:44:49 +0530
Message-ID: <CALUj-guTNWK9m-bwmkRC3st9VExhFkXPiUevXw_EA9xamR6BYA@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC support
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 20, 2020 at 8:31 AM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> Add support for the three 10-bit ADC channels registered via
> the IIO subsystem.
>
> Cc: linux-input@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> CC: Rishi Gupta <gupt21@gmail.com>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/hid/Kconfig       |  1 +
>  drivers/hid/hid-mcp2221.c | 65 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 05315b434276..4795744d9979 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1157,6 +1157,7 @@ config HID_MCP2221
>         tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
>         depends on USB_HID && I2C
>         depends on GPIOLIB
> +       depends on IIO
I am wondering what will happen on systems which do not enable IIO.
This driver can not be used there.
Is my understanding correct?
>         help
>         Provides I2C and SMBUS host adapter functionality over USB-HID
>         through MCP2221 device.
> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index 0d27ccb55dd9..7e62f1dc54d3 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -18,6 +18,9 @@
>  #include <linux/gpio/driver.h>
>  #include "hid-ids.h"
>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
>  /* Commands codes in a raw output report */
>  enum {
>         MCP2221_I2C_WR_DATA = 0x90,
> @@ -56,6 +59,7 @@ enum {
>   */
>  struct mcp2221 {
>         struct hid_device *hdev;
> +       struct iio_dev *indio_dev;
>         struct i2c_adapter adapter;
>         struct mutex lock;
>         struct completion wait_in_report;
> @@ -67,6 +71,11 @@ struct mcp2221 {
>         struct gpio_chip *gc;
>         u8 gp_idx;
>         u8 gpio_dir;
> +       u16 adc_values[3];
> +};
> +
> +struct mcp2221_iio {
> +       struct mcp2221 *mcp;
>  };
>
>  /*
> @@ -712,6 +721,7 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>                                 break;
>                         }
>                         mcp->status = mcp_get_i2c_eng_state(mcp, data, 8);
> +                       memcpy(&mcp->adc_values, &data[50], 6);
>                         break;
>                 default:
>                         mcp->status = -EIO;
> @@ -791,11 +801,54 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>         return 1;
>  }
>
> +static int mcp2221_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *channel, int *val,
> +                           int *val2, long mask)
> +{
> +
> +       struct mcp2221_iio *priv = iio_priv(indio_dev);
> +       struct mcp2221 *mcp = priv->mcp;
> +       int ret;
> +
> +       mutex_lock(&mcp->lock);
> +
> +       /* Read ADC values */
> +       ret = mcp_chk_last_cmd_status(mcp);
> +       if (ret < 0)
> +               return ret;
> +
> +       *val = le16_to_cpu(mcp->adc_values[channel->channel]);
> +
> +       mutex_unlock(&mcp->lock);
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info mcp2221_info = {
> +       .read_raw = &mcp2221_read_raw,
> +};
> +
> +#define MCP2221_ADC_CHANNEL(idx) \
> +       { \
> +               .type = IIO_VOLTAGE, \
> +               .indexed = 1, \
> +               .channel = idx, \
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +               .scan_index = -1, \
> +       }
> +
> +static const struct iio_chan_spec mcp2221_channels[] = {
> +       MCP2221_ADC_CHANNEL(0),
> +       MCP2221_ADC_CHANNEL(1),
> +       MCP2221_ADC_CHANNEL(2),
> +};
> +
>  static int mcp2221_probe(struct hid_device *hdev,
>                                         const struct hid_device_id *id)
>  {
>         int ret;
>         struct mcp2221 *mcp;
> +       struct mcp2221_iio *iio;
>
>         mcp = devm_kzalloc(&hdev->dev, sizeof(*mcp), GFP_KERNEL);
>         if (!mcp)
> @@ -869,8 +922,17 @@ static int mcp2221_probe(struct hid_device *hdev,
>         if (ret)
>                 goto err_gc;
>
> -       return 0;
> +       mcp->indio_dev = devm_iio_device_alloc(&hdev->dev, sizeof(*iio));
> +       iio = iio_priv(mcp->indio_dev);
> +       iio->mcp = mcp;
> +
> +       mcp->indio_dev->name = "mcp2221_adc";
> +       mcp->indio_dev->modes = INDIO_DIRECT_MODE;
> +       mcp->indio_dev->info = &mcp2221_info;
> +       mcp->indio_dev->channels = mcp2221_channels;
> +       mcp->indio_dev->num_channels = ARRAY_SIZE(mcp2221_channels);
>
> +       return iio_device_register(mcp->indio_dev);
>  err_gc:
>         i2c_del_adapter(&mcp->adapter);
>  err_i2c:
> @@ -884,6 +946,7 @@ static void mcp2221_remove(struct hid_device *hdev)
>  {
>         struct mcp2221 *mcp = hid_get_drvdata(hdev);
>
> +       iio_device_unregister(mcp->indio_dev);
>         i2c_del_adapter(&mcp->adapter);
>         hid_hw_close(mcp->hdev);
>         hid_hw_stop(mcp->hdev);
> --
> 2.20.1
>
