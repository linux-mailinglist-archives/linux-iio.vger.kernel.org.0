Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32B3E89E0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 07:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhHKFqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 01:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhHKFqf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 01:46:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF2DC061765;
        Tue, 10 Aug 2021 22:46:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so7882664pjb.3;
        Tue, 10 Aug 2021 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XSzOtpQNRBsOFfbDleSm4bWfas6AMzGa0fymxLtrJeQ=;
        b=DA/ug0ugEDxPxMtqW6q39Mac57gxTgL9Av9d9G3ABDBl1BU+HtVkKDoCEvNsFo2aIn
         lyLH2wZghoIaqsALjpM+u+PTE4D1ahbmRzM/uK5BLO3hJszrYq4ZxPdPyHcmg6kcMqlo
         J+jQDysSSd6RfjF5B6SmVRomp0HZdTtGiu28CnnsqZd2BU+BE0K3KVE4s1XKmSz67aCy
         SFqRkN872F1wuk7mgtybPXFeHUtr1xSHPser/4IIrmKMYmJpV0xElNDLeZGM4EG+E8PU
         ZzAte3PE8fdxsf8zhc3zv4tMq3s0O6KdBjKjHsSJpHzrwEg04SCLJIpWxPFgM0UVdaN9
         IVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XSzOtpQNRBsOFfbDleSm4bWfas6AMzGa0fymxLtrJeQ=;
        b=Gk6bsMvWiVgL0NqQM3Ue8jIaimHALbO3vxe9QiAI2mWGjcS4zmqt04uR5lOaNiVEHn
         5Ac6eZeZ36REtOGgjJODSOxzH//4clrlCVP65vgwCcples1m/uegJAJPOLBQvVQPn1xM
         siR7UFEihIbNspmd2O95bSKu+5PU84R6OMjPxJ60vcb/T08BaGHZeSp/dqE2QaTHP5HE
         MERWQZh8zG9ewwOjVw+BK8L/M/z7k2IM7v1dzzUkK4nYOxT6E5kvdW+vWrkckf47mWsx
         JymwF0EODLfKjTzT2FAi6TnyrzfBNINTButIvrL6T7H0DxzSq3b+0QvuxUukLxLWUjZa
         ww1A==
X-Gm-Message-State: AOAM530OWIulRabrUEqJAC0/BsSvuYlH3x7b/2kMcqCf7ZvhvNxscE9+
        xW+Y+vhFhqsc/xXp497/kdY=
X-Google-Smtp-Source: ABdhPJwZ3qkf1W9udTJ43KLhFTG1uHui9q6hmN6oJt3ThvcxYlJs8cd/vPGoZTQUC5BpEgfb9syOUg==
X-Received: by 2002:a05:6a00:1646:b029:3c3:2636:8d5d with SMTP id m6-20020a056a001646b02903c326368d5dmr27013704pfc.3.1628660771881;
        Tue, 10 Aug 2021 22:46:11 -0700 (PDT)
Received: from mugil-Nitro-AN515-52 ([2409:4072:6d8a:236c:2876:1a1c:7729:ee7c])
        by smtp.gmail.com with ESMTPSA id w9sm1050200pja.16.2021.08.10.22.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:46:11 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:15:58 +0530
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
Message-ID: <20210811054558.GA3826@mugil-Nitro-AN515-52>
References: <20210809075745.160042-1-dmugil2000@gmail.com>
 <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 10, 2021 at 03:49:52PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 9, 2021 at 10:59 AM Mugilraj Dhavachelvan
> <dmugil2000@gmail.com> wrote:
> >
> > The AD5110/AD5112/AD5114 provide a nonvolatile solution
> > for 128-/64-/32-position adjustment applications, offering
> > guaranteed low resistor tolerance errors of ±8% and up to
> > ±6 mA current density.
> 
> ...
> 
> > +/*
> > + * Analog Devices AD5110 digital potentiometer driver
> > + *
> > + * Copyright (C) 2021 Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> > + *
> > + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
> 
> > + *
> 
> Redundant blank line.
> 
fixed in v3
> > + */
> 
> ...
> 
> > +#define WIPER_RESISTANCE       70
> 
> Missed prefix?
> 
fixed in v3
> ...
> 
> > +static const struct iio_chan_spec ad5110_channels[] = {
> > +       {
> > +               .type = IIO_RESISTANCE,
> > +               .output = 1,
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET) |
> > +                                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_ENABLE),
> > +       }
> 
> + comma.
> 
fixed in v3
> > +};
> 
> ...
> 
> > +       ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
> > +       if (ret != sizeof(data->buf)) {
> 
> > +               ret = -EIO;
> 
> Shadowed error code when ret < 0.
> 
fixed in v3
> > +               goto error;
> > +       }
> 
> ...
> 
> > +       ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
> > +       if (ret != sizeof(data->buf))
> > +               ret = -EIO;
> 
> Ditto.
> 
fixed in v3
> > +       mutex_unlock(&data->lock);
> > +
> > +       return ret < 0 ? ret : 0;
> > +}
> 
> ...
> 
> > +       data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> > +       if (!(val & BIT(7)))
> > +               data->tol *= -1;
> 
> Shouldn't you simple use corresponding sign_extend*()?
> 
I'm not able see any sign_extend for 16 bit. Is there any other way?
> ...
> 
> > +       ret = ad5110_write(data, AD5110_EEPROM_WR, 0);
> > +       if (ret) {
> > +               dev_err(&data->client->dev, "RDAC to EEPROM write failed\n");
> > +               return ret;
> > +       }
> 
> 
> > +       msleep(20);
> 
> Each long sleeps like this must be explained.
> 
fixed in v3
> ...
> 
> > +static IIO_DEVICE_ATTR(store_eeprom, 0644,
> > +                      ad5110_eeprom_read,
> > +                      ad5110_eeprom_write, 0);
> 
> IIO_DEVICE_ATTR_RW() ?
> 
fixed in v3
> ...
> 
> > +static struct attribute *ad5110_attributes[] = {
> > +       &iio_dev_attr_store_eeprom.dev_attr.attr,
> > +       NULL,
> 
> No comma for a terminator line.
> 
fixed in v3
> > +};
> 
> ...
> 
> > +       data->cfg = device_get_match_data(dev);
> 
> > +       if (!data->cfg)
> > +               data->cfg = &ad5110_cfg[i2c_match_id(ad5110_id, client)->driver_data];
> 
> Not sure this is not a dead code since you are using ->probe_new().
> 
Even I'm suspecting that and also removing id_table. But I'm not sure of
it so just left as it is.
> ...
> 
> > +static struct i2c_driver ad5110_driver = {
> > +       .driver = {
> > +               .name   = "ad5110",
> > +               .of_match_table = ad5110_of_match,
> > +       },
> > +       .probe_new      = ad5110_probe,
> > +       .id_table       = ad5110_id,
> > +};
> 
> > +
> 
> Redundant blank line
fixed in v3.
> 
> > +module_i2c_driver(ad5110_driver);
> 
Thanks for the feedback :)
> -- 
> With Best Regards,
> Andy Shevchenko
