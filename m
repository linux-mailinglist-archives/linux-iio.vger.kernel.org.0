Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E956C18E588
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 01:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgCVAVQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 20:21:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44274 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVAVP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 20:21:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id 37so5130160pgm.11;
        Sat, 21 Mar 2020 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oo1KhDpsYm4r+ZCFpfpS62+p3Q8htiktdPZfhYhrkqM=;
        b=PUlsm6g9R40oqeZpDaQXuGcpnmirz9Da9vYRs56HYevTggKswALehHL5ie5FIi5P5s
         XBBMIUzBtqTcG8u4A0p5/p/7eXiZtP+ikmxAC1gLeqWibgabGzKsfueK+TORmT8EKkGG
         JEsKy6cMrvPs6oAp8tvxX+RUiuAfwkXFCpLHedzf6SanwuBcg6jcg5OhrJbc4HxIIgDL
         QoLS2aulPY9IKthojust6jmNvf2oAVctlnOZI/TCXixUSQeH5Tz8mryJvU9LTPXGVqD5
         CaT21P6vM5dvdhk7S3Fdqx1oGK69Kh8GNjcGb4UtksXS40+j2RyzgN2eBJ8+h0Z3N1qU
         YBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oo1KhDpsYm4r+ZCFpfpS62+p3Q8htiktdPZfhYhrkqM=;
        b=osHXChdmbB+YrH7kHq5OPxZ/C4RfvrLnvzz7yWcSeB8D8WNG9DJP63vc3y7Qwhy0Fg
         TDRnGLhvzU1um79OFi2lD8asdWhQY0T9qDnz0sOX5e3bTzw1tZRCJ3o1Gapx1KXhgYRi
         T/EFwYmJFZ9NcGm4F/imszC3oNUn1IV4BS8mjQCvkl2aaG/Rr53A5zKO0+g5sQs47KY7
         am52SjanRB4hGRvPxvf++gM1vQBOkwHEoD9Kt2Yw8JjwqwcrQaXWDB+3rGNxwTMD8tmb
         GnPO2p7hyFgMhsKIDxD3G2G0DPvxiZcXM+pmMDj9rNboYY+agKB3bco4tQXQsGj8cXj0
         bCog==
X-Gm-Message-State: ANhLgQ1rBebVZRtMdV3320/cZOEF6rudp19cOvo8eCS7vkb3XAlOdnU8
        QHSSc/bmfS7bafpAJk4QwsQIddUbT341S2PLCgJpZyfqDHO7lg==
X-Google-Smtp-Source: ADFU+vsa0ivPADE4hSeky25Q7EI3YbLdtV5qmX0dYZSfF4r4NYyeZaiojOWGaifckbRlK6AEm76cUtG00EWEIaTXBJo=
X-Received: by 2002:a63:1c4d:: with SMTP id c13mr15056673pgm.4.1584836474171;
 Sat, 21 Mar 2020 17:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584380360.git.agx@sigxcpu.org> <5566fe01df933d3281f058666e2147cb97b38126.1584380360.git.agx@sigxcpu.org>
In-Reply-To: <5566fe01df933d3281f058666e2147cb97b38126.1584380360.git.agx@sigxcpu.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 02:21:02 +0200
Message-ID: <CAHp75VcHuAUDB59ZDJQAQgugQOwASM6K+sQ9uPAR7jMyOcdZCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: vcnl4000: Export near level property for
 proximity sensor
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 16, 2020 at 7:47 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> When an object can be considered close to the sensor is hardware
> dependent. Allowing to configure the property via device tree
> allows to configure this device specific value.
>
> This is useful for e.g. iio-sensor-proxy to indicate to userspace
> if an object is close to the sensor.

...

> @@ -342,6 +343,26 @@ static const struct vcnl4000_chip_spec vcnl4000_chip=
_spec_cfg[] =3D {
>         },
>  };
>

> +

No need for this blank line.

> +static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
> +                                       uintptr_t priv,
> +                                       const struct iio_chan_spec *chan,
> +                                       char *buf)

...

> +       if (device_property_read_u32(&client->dev, "near-level",
> +                                    &data->near_level) < 0)

It doesn't return > 0. So, you may drop that and put everything to one
line I think.

> +               data->near_level =3D 0;

--=20
With Best Regards,
Andy Shevchenko
