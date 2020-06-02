Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04D1EC0A7
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBRE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRE3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 13:04:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504BC05BD1E;
        Tue,  2 Jun 2020 10:04:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u5so5350791pgn.5;
        Tue, 02 Jun 2020 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qP1SFtSKI85Od2m/ro+JDsXQO3tioUkpdU+dKmyTlRI=;
        b=oKdJMl8TzZa9ODZicGnJcIHOSTF432mRcPBazZ/oTtgrH1YkrG0tPbvTQTywX7E82v
         LznKAjaKPExPwMtJX05Ej3AH1saH0AN4BtFgPqV8V1Y6X4p21PRg1GpxrLArdhxiQ8H0
         YmIuXFrMUMYLRyztBUc0V3yiM2htahRds38SIt+on1RRdOheHwCCh1WJnSJqlXbhDIMQ
         zGW4dt7W/JC4DAGz4ZSkjDA/rLd3jRQc5MdtRmeBz0L00VBeD+RNZkSBduKADuyamVN0
         pNFL0CZsl6CINpv0svITsMuZGqldfK3kC/bntvftYNTN6H4lo2NRC0rzNQWi2MNyTNIa
         EyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qP1SFtSKI85Od2m/ro+JDsXQO3tioUkpdU+dKmyTlRI=;
        b=o7nYeQXgz5mssPo/Aqq5fEhi3T1ROqzAkL+6j1L85RP7sENnqQ4TP5AI3aTQESy1oH
         i6fAtxckolNso8tGwAZ7tcLNPJo2JJHyp/qHa6Qr3Nmjy5luQ5iyE992DHgp/zM2kqft
         Yhd2IqCe57yS5MhIB6/zXEmlQmff+0Aj7t1cd2rl5mNYUTbj4Qmxc0F9la45A6867178
         iVuJ+2+EsGrI4nynaQBungi2JNXmEtp0V7LI047vUxTZomPSteN4ZY/9XoNHSmWtAIKL
         3FFU0PnbjQOhlKeY/90UkbBWsmK9ZUVM/xXdv06LJ0P8B5u+gbinWoUjR3T7ROusGWEx
         mphQ==
X-Gm-Message-State: AOAM533jMn13naivjVlVJjjp1bbYq7eprmHVBaG8FpvXIEPqBcJZYIOL
        2AXpFLM7TUr6kaL9XYfk2V0UbDmfNy3yDnRpllw=
X-Google-Smtp-Source: ABdhPJxlrtHHSjUce6iWy8kx5cGdV/gbgQevdhKK2v4Wg33jtRnDrxZu3cO9IRlBrmWXR9y0L8UBAUJdRuX9Kv1FLGk=
X-Received: by 2002:a63:305:: with SMTP id 5mr24160733pgd.74.1591117468175;
 Tue, 02 Jun 2020 10:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200602164723.28858-1-tomasz.duszynski@octakon.com> <20200602164723.28858-4-tomasz.duszynski@octakon.com>
In-Reply-To: <20200602164723.28858-4-tomasz.duszynski@octakon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 20:04:16 +0300
Message-ID: <CAHp75VfjWG_3XC5FJoaU7XXJc+04JTbEKdjZK=g6ffBPvJNhxA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: chemical: scd30: add serial interface driver
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 2, 2020 at 7:49 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> Add serial interface driver for the SCD30 sensor.

...

> +static u16 scd30_serdev_cmd_lookup_tbl[] = {
> +       [CMD_START_MEAS] = 0x0036,
> +       [CMD_STOP_MEAS] = 0x0037,
> +       [CMD_MEAS_INTERVAL] = 0x0025,
> +       [CMD_MEAS_READY] = 0x0027,
> +       [CMD_READ_MEAS] = 0x0028,
> +       [CMD_ASC] = 0x003a,
> +       [CMD_FRC] = 0x0039,
> +       [CMD_TEMP_OFFSET] = 0x003b,
> +       [CMD_FW_VERSION] = 0x0020,
> +       [CMD_RESET] = 0x0034,

Hmm... Can't we keep them ordered by value?

> +};

...

> +       ret = wait_for_completion_interruptible_timeout(&priv->meas_ready,
> +                                                       SCD30_SERDEV_TIMEOUT);
> +       if (ret > 0)
> +               ret = 0;
> +       else if (!ret)
> +               ret = -ETIMEDOUT;
> +
> +       return ret;

Perhaps

  if (ret < 0)
    return ret;
  if (ret == 0)
    return -ETIMEDOUT;
  return 0;

?

...

> +       char txbuf[SCD30_SERDEV_MAX_BUF_SIZE] = { SCD30_SERDEV_ADDR },
> +            rxbuf[SCD30_SERDEV_MAX_BUF_SIZE], *rsp = response;

Please, apply type to each variable separately.

...

> +       switch (txbuf[1]) {
> +       case SCD30_SERDEV_WRITE:

> +               if (memcmp(txbuf, txbuf, txsize)) {

I'm not sure I understand this.

> +                       dev_err(state->dev, "wrong message received\n");
> +                       return -EIO;
> +               }
> +               break;
> +       case SCD30_SERDEV_READ:

> +               if (rxbuf[2] != (rxsize -
> +                                SCD30_SERDEV_RX_HEADER_SIZE -
> +                                SCD30_SERDEV_CRC_SIZE)) {

Perhaps you can come up with better indentation/ line split?

> +                       dev_err(state->dev,
> +                               "received data size does not match header\n");
> +                       return -EIO;
> +               }
> +
> +               rxsize -= SCD30_SERDEV_CRC_SIZE;
> +               crc = get_unaligned_le16(rxbuf + rxsize);
> +               if (crc != scd30_serdev_calc_crc(rxbuf, rxsize)) {
> +                       dev_err(state->dev, "data integrity check failed\n");
> +                       return -EIO;
> +               }
> +
> +               rxsize -= SCD30_SERDEV_RX_HEADER_SIZE;
> +               memcpy(rsp, rxbuf + SCD30_SERDEV_RX_HEADER_SIZE, rxsize);
> +               break;
> +       default:
> +               dev_err(state->dev, "received unknown op code\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}

...

> +static struct serdev_device_driver scd30_serdev_driver = {
> +       .driver = {

> +               .name = KBUILD_MODNAME,

This is not the best what we can do. The name is an ABI and better if
it will be constant (independent on file name).

> +               .of_match_table = scd30_serdev_of_match,
> +               .pm = &scd30_pm_ops,
> +       },
> +       .probe = scd30_serdev_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko
