Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A161EC0C8
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgFBRO0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 13:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRO0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 13:14:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E540C05BD1E;
        Tue,  2 Jun 2020 10:14:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f3so5322103pfd.11;
        Tue, 02 Jun 2020 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDKEOQW3zzKg27PHbCCQiuGUgsLSAgNyAkY4CZ592P8=;
        b=QX2NqYaKI02lh99tfRoYpKssbJuXJc/viEZOCaPdRM99I9ujjBp6i7QH/PeX/tZycn
         WHBIWtyV1hP5huS546uhTOS+LThr94j5tz6Ytm7yuUDzP2Ntot5OEccGlPDIQcSd3Vza
         T6nqJAtB+XUcaulomzKKodYKIKUqrmvs/z6fwSZt3tlF4ppjuV1+UdpNxDp7fedu6Trm
         nyH6xrjmVUrdc5dfTAoe3+DXAoH2LaOxhP4E1+pcwa5lEKXB75YVOskFvj2+TKK2Kj+z
         sV28XsrrAossb/smm1uc9+CHSs2wJUHOM2G4mtFcNetg+Mum+uyipAAlRzjYDaGn8UsF
         DtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDKEOQW3zzKg27PHbCCQiuGUgsLSAgNyAkY4CZ592P8=;
        b=KG/9NOJb0egoZDv9CI1zHoKprhCqSsr8vX6oLpbgsay8Oivvot2MA2+GepVtQdYs67
         UHEhA9piFGTGTXx29TK0BKSsTyfhUlCEIw7ZczbIgUedGPzlkJaICseSax7gOlWn7zXA
         rFdO5w3k6doUpmnClQ6pcLQ/f2M2xJecyD1aMlMsTCTotkcY5BP+tPA9hB+hdKNn2rKF
         QzGCdti+qtD7rDZ7n/NHnjTim+JBzYyd2G/AR4aGx0kx4Hds30WzY/TE16UUyTgRplVJ
         wiVXFtLXDBkIWpU3j7l//bpTWwNo7TvTRP34VW5OxIDRWJO1tCvXq64sCDWCE1SL1y4/
         ZOPQ==
X-Gm-Message-State: AOAM533sByq5Phfliyv/omYYQ0bbvTdVgrUkAitBzpKVtMm7ygbnnexf
        H8wW14Ti7pSzeeBQ6iP05LNoU7qEDu3BF2HiGPU=
X-Google-Smtp-Source: ABdhPJy3SFp0xIUMraAbk46rfGFxgJiu2JNz+q3JZrwYxxiOHdwNt/JtImJZKe7Hak4dhv1iLWMNHf7biOdORb/ORPc=
X-Received: by 2002:a63:305:: with SMTP id 5mr24196734pgd.74.1591118065723;
 Tue, 02 Jun 2020 10:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602164723.28858-1-tomasz.duszynski@octakon.com> <20200602164723.28858-3-tomasz.duszynski@octakon.com>
In-Reply-To: <20200602164723.28858-3-tomasz.duszynski@octakon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 20:14:13 +0300
Message-ID: <CAHp75Vc60q1PC9j6KR1-OJHxw=nBAHt9zJK=h9f27yJxMHpb8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: chemical: scd30: add I2C interface driver
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
> Add I2C interface driver for the SCD30 sensor.

...

> +static u16 scd30_i2c_cmd_lookup_tbl[] = {
> +       [CMD_START_MEAS] = 0x0010,
> +       [CMD_STOP_MEAS] = 0x0104,
> +       [CMD_MEAS_INTERVAL] = 0x4600,
> +       [CMD_MEAS_READY] = 0x0202,
> +       [CMD_READ_MEAS] = 0x0300,
> +       [CMD_ASC] = 0x5306,
> +       [CMD_FRC] = 0x5204,
> +       [CMD_TEMP_OFFSET] = 0x5403,
> +       [CMD_FW_VERSION] = 0xd100,
> +       [CMD_RESET] = 0xd304,

Keep sorted by value?

> +};

...

> +       ret = i2c_master_send(client, txbuf, txsize);

> +       if (ret != txsize)
> +               return ret < 0 ? ret : -EIO;

Wouldn't be better

  if (ret < 0)
    return ret;
  if (ret != txsize)
    return -EIO;

?

> +       if (!rxbuf)
> +               return 0;
> +
> +       ret = i2c_master_recv(client, rxbuf, rxsize);

> +       if (ret != rxsize)
> +               return ret < 0 ? ret : -EIO;

Ditto.

...

> +static int scd30_i2c_command(struct scd30_state *state, enum scd30_cmd cmd,
> +                            u16 arg, void *response, int size)
> +{
> +       char crc, buf[SCD30_I2C_MAX_BUF_SIZE], *rsp = response;
> +       int i, ret;

i -> offset ?

> +       put_unaligned_be16(scd30_i2c_cmd_lookup_tbl[cmd], buf);
> +       i = 2;
> +
> +       if (rsp) {
> +               /* each two bytes are followed by a crc8 */
> +               size += size / 2;
> +       } else {
> +               put_unaligned_be16(arg, buf + i);
> +               crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
> +               i += 2;

> +               buf[i] = crc;
> +               i += 1;

buf[offset++] = crc; ?

> +               /* commands below don't take an argument */
> +               if ((cmd == CMD_STOP_MEAS) || (cmd == CMD_RESET))
> +                       i -= 3;
> +       }
> +
> +       ret = scd30_i2c_xfer(state, buf, i, buf, size);
> +       if (ret)
> +               return ret;
> +
> +       /* validate received data and strip off crc bytes */
> +       for (i = 0; i < size; i += 3) {
> +               crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
> +               if (crc != buf[i + 2]) {
> +                       dev_err(state->dev, "data integrity check failed\n");
> +                       return -EIO;
> +               }
> +

> +               *rsp++ = buf[i];

+ 0 (for the sake of consistency?

> +               *rsp++ = buf[i + 1];
> +       }
> +
> +       return 0;
> +}

...

> +static struct i2c_driver scd30_i2c_driver = {
> +       .driver = {

> +               .name = KBUILD_MODNAME,

Better to hard code.

> +               .of_match_table = scd30_i2c_of_match,
> +               .pm = &scd30_pm_ops,
> +       },
> +       .probe_new = scd30_i2c_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko
