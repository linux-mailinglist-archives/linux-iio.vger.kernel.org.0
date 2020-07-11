Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD721C4CE
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jul 2020 17:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgGKP10 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jul 2020 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgGKP1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2020 11:27:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABBC08C5DD
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2020 08:27:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i14so3854860pfu.13
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2020 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5C/90y2ZQVCuj64QcU4N7wK9ia51VdJrAMkVGHHOBE=;
        b=QTbmz+Tb2Mil3pYZvoPEPxD+23sgSgvkCJeGl6q3NL16xImVNMLZEm722S9gwe6hMT
         rVMqBjo/SlndhCdEQxJ8N5uip/UgiFm376F/A79Ugw2b/ZC5h+sNO5cS57MPIh1BP9kQ
         i7ua/SItjHtOyRV7ap37kj5ho0cESIwUUgske3yY7SyxjezjcvMqOn8YPpKNrEZdQost
         /Hr2xQ/mNfGRu5vq4Ii+R8DcaZyPA9zVve7yQwe5wSniYXVW0cxXhdOCug/2rN66YBF/
         0oQDESFF9pFuq5UpilzE9PpidmH47TKLn6oUoZaksDxghvPZdAmQhoJMHJumD9Omxj7T
         D+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5C/90y2ZQVCuj64QcU4N7wK9ia51VdJrAMkVGHHOBE=;
        b=GfdWay6Bl+0vQk1U+YVRqq4uZWmFbiOv+X0t6a6U+TZfzJ6UuBnLqBsXtFP72gmAru
         u7TsexIwCyio8ItEfGTOdINY9CTYQEGmrZP8EIQeRHfdJUy54gTdGaCwqPLXvsZmD8QC
         kuBLCJjGy56S43qbTBI0dPIPTR46nopcEEwuSjJTD8ccN6TgdFM2OwVPjNCfggPOrLai
         ZLSpi6u56unoMqQ3rCmbEif5DkcT8I/E9Php7aotovRFvL7Ckw724BCMLUzb9uK/h2lu
         htTDHNYepHRQ0+uQJYAGzU4d0/PsA712hX4ifkhif1gBh18gp/UQ0FFlZI6JHlp0XcHl
         EteQ==
X-Gm-Message-State: AOAM530TMIVTnKD3wMh2kCM4rXstpJmhZpZgsiTw+UV9Jus7O/W7TYgd
        I6+qtdtyG5GMlJwSVHmcbKg4H0fnypJ/TaeZ4xM=
X-Google-Smtp-Source: ABdhPJzYgQnilWfStmgkraQCmevob6TsfC9meoObcyE/8l8hXJPvVQ9tarT+aoo6CVLkvChAtLp8J3aeC3zm8EUm/nI=
X-Received: by 2002:a63:924b:: with SMTP id s11mr60756588pgn.74.1594481245114;
 Sat, 11 Jul 2020 08:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <86d053d1re.fsf@norphonic.com>
In-Reply-To: <86d053d1re.fsf@norphonic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Jul 2020 18:27:09 +0300
Message-ID: <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
To:     Eugene Zaikonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 10, 2020 at 2:54 PM Eugene Zaikonnikov <ez@norphonic.com> wrote:
>
> Add support for HDC2010/2080 driver and sysfs documentation for its
> heater element.
>
> HDC2010 is an integrated high-accuracy humidity and temperature sensor
> with very low power consumption. The device includes a resistive heating
> element. The temperature range is -40C to 125C with 0.2C
> accuracy. Humidity measurement is 0 to 100% with 2% RH accuracy.

Now, some almost context-less comments to the contribution.

Please, use Datasheet tag(s) here with URL(s) to the datasheet(s).
Also, be sure you are using https (note S) everywhere.

Datasheet: https://...
Datasheet: ...

> Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>

1. No need to put file name into the file
2. Missed at least bits.h inclusion
3. Keep comma in HDC2010_GROUP_HUMIDITY
4. IIO_CONST_ATTR can be one line, but hey don't we have IIO core to
take care of it?
5. Use traditional pattern

if (ret)
  return ret;

data->drdy_config = tmp;

return 0;

6. Indent better

if (!i2c_check_functionality(client->adapter,
    I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))

(or split last line above by operand per line or alike)

7. Drop unneeded casting
tmp = (data->measurement_config & ~HDC2010_MEAS_CONF) | HDC2010_MEAS_TRIG;

8. It's one line
ret = i2c_smbus_write_byte_data(client,
    HDC2010_REG_MEASUREMENT_CONF, tmp);

Ditto:
dev_warn(&client->dev, "Unable to restore default AMM\n");

In general it doesn't look bad!

-- 
With Best Regards,
Andy Shevchenko
