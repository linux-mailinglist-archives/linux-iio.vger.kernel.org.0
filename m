Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C289AD77BF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfJONx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 09:53:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38175 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfJONx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 09:53:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so5289301pgt.5;
        Tue, 15 Oct 2019 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhHgBu9DtlVuSa/jKN81LxnRQ5IePxEDrqTOOn2qwlc=;
        b=oKjy0lXqfaBGQOGxCfyXjK5IpuMO/YOWCF5nkjtbivKJ5HRGK6luMngGsN9xTcQq23
         2krqRfsoPw28MJcSKfyxYGQjH2hqwBkP+qygdHQapWzARXN0xn5zyr2s/zOcMIWYajDL
         0ufPvELGFhkOlnpI+Ydymyi7FwXQ+9ap+zpW6wY/O0gn1ZNIixNKIRHDF7SmBxLWZu3Z
         qzIFUJMub6bE+NZgTwew5E31oxZjyzk7CIqg7lqKbSzO/3j1bjzxabtnkg2BMZlMX79C
         Jv4P/XpW9ksJ8iQu0iMgboaSQr9NzD0MntkcvM0WhdgoGjuFoPzzPbPBwv34r3ZGZoAh
         FR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhHgBu9DtlVuSa/jKN81LxnRQ5IePxEDrqTOOn2qwlc=;
        b=Y2ejVFrZ4hz1EBNCTxtFvEyCTAFKxzgpCjLHZ+O3anAFk7rPeJK1kfTiv4TKWUJ/Sg
         2lGZ7w8yRQkm39ySTXG3RNWi1FlfvJALeYCyHJvZo81KWwzJuDSdQtI3jCCX4rIAgG15
         qnvY+4uTxvpMpndOKy61jgexNQPHCuYtW1MwYgGkjGVAwIyEKjiq4WjhFkpbDPn3PnXo
         f0eCyHN46QLcw6ZsX8uv1EjlyEGB7unMPbXTP+HZQKKxQuTMkvU9LwAVKY8QBL3XjaN8
         vib8glQKDSxTw+hfI2GtbdRzIqcghEX/3zTAcBIkEz0BsJ71VYAmlVKZUFZ2M3Xnoh6O
         rkxQ==
X-Gm-Message-State: APjAAAVX0r5N9BjgU2zjW8ayzFYpBerqVH9HfXXhpw5UL1kWYspQqEl1
        l1VY+MpGZjSJoIOjMn/IWTCdnxNB5/dnjvKyqcY=
X-Google-Smtp-Source: APXvYqyuQKWewX3MTgBBY9LImkYYICsBBlZXn7ZhrfDVATCJxjHgqylTK7hQwpt/Bk5EGGJetAsik/a2Fy6Yjpul6E0=
X-Received: by 2002:a62:e206:: with SMTP id a6mr38798141pfi.64.1571147606854;
 Tue, 15 Oct 2019 06:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191012035420.13904-3-dan@dlrobertson.com> <201910150017.MkSBCEcB%lkp@intel.com>
In-Reply-To: <201910150017.MkSBCEcB%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Oct 2019 16:53:16 +0300
Message-ID: <CAHp75VeyB2rZXXF34cUKp2iBfJMeN3fw8SfBMW=13sZY3z2DNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: (bma400) add driver for the BMA400
To:     kbuild test robot <lkp@intel.com>
Cc:     Dan Robertson <dan@dlrobertson.com>, kbuild-all@lists.01.org,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 15, 2019 at 12:25 AM kbuild test robot <lkp@intel.com> wrote:

> smatch warnings:
> drivers/iio/accel/bma400_core.c:422 bma400_set_accel_oversampling_ratio() warn: unsigned 'acc_config' is never less than zero.

>    420                  ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG,
>    421                                    &acc_config);
>  > 422                  if (acc_config < 0)
>    423                          return acc_config;

Obvious typo, has to be if (ret < 0)

>    424
>    425                  ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
>    426                                     (acc_config & ~BMA400_LP_OSR_MASK) |
>    427                                     (val << BMA400_LP_OSR_SHIFT));
>    428                  if (ret < 0) {
>    429                          dev_err(data->dev, "Failed to write out OSR");
>    430                          return ret;
>    431                  }



-- 
With Best Regards,
Andy Shevchenko
