Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5725C249
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgICONn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgICOMi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 10:12:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC627C0619CC;
        Thu,  3 Sep 2020 06:25:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so2132105pgm.7;
        Thu, 03 Sep 2020 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rBLHCW+xCPafeIkvVVQSL44AW9YIX51FOu10BKIiLw=;
        b=OgiACbcbQ1ItN0Rs6SHierX23wZ3W0QcSSP6eHDn26H6ndV6FVvyAPfzddT63ATKJ0
         j20K6Qun/pU/eTF15WCngzAcNZekk0cCrl5XV9cAScvAwA3M4JQrrdmh/0/XXJ1yYzc5
         auls8Zngp7jLOtlmd6vlb/AQMblOo/0eoaP8Aft9XRyijNkiG/93XP9jlW8+HoTG5zTz
         PgcXNTaXhjb+IOHaAL8TNTXE3sWpQ7gRKc3BTt9YcoactbZeouPK/MwojZhbkY3Ql8M6
         5zc1xe4CjGj7XXJNE8lt/Rl2LsQnSUcXJdm6g69l1qbRYwnpzYqmwhMD3ifUehAFGv0J
         spMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rBLHCW+xCPafeIkvVVQSL44AW9YIX51FOu10BKIiLw=;
        b=qdsjSrmKdsiukpSqogdso7HbbarUYCZd/pRFi8BO+0GCeBGilxM1XhR76oybwQ2pp4
         SCgGtW+Nig6ueAUw+9Ecv3uVtw1ew0u9j2nZyn+qrpIJlX2C6SBOJ842XBYimxZ1wNbT
         JJ3lw5kVXrMkPK5TZoTjUdMvMkV5pHRKxZQxE3SXtG1TB0q/g2KDGfRcsyhAybxdJo9y
         QCcvRNdSmbmGpU6czpzOaOgoNHvfIrg51hsyEQK8ftbW+gAg+bvhPBXBwXEXCSJECScl
         koZ3I6DkmRv05ATf2i3wH5QF4mUGqwjjrYeFhNyyQ3T7s6B0xHwfmwsgdv4r6mgBiTQS
         I8yQ==
X-Gm-Message-State: AOAM532jcwYqEBeNY+0IxlTXNK0F3DNkx6IpiCxB8SIPMehDtVr5q/He
        UNjRqjmNIdpMnbBNU2LifFxKgTi1yX3cLk4fcR3ds1OcsbkFwEb/
X-Google-Smtp-Source: ABdhPJzimILiNCSgnKp/qJ9/9071OtoXwPPCV8ZOTnov1Okg3uUJ9PSdnnWUgfLq+tSjngGf5i/NlRBPuXDUiWzdlSE=
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr3949007plr.226.1599139525682;
 Thu, 03 Sep 2020 06:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200903130950.6274-1-nish.malpani25@gmail.com> <20200903130950.6274-4-nish.malpani25@gmail.com>
In-Reply-To: <20200903130950.6274-4-nish.malpani25@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Sep 2020 16:25:08 +0300
Message-ID: <CAHp75VfReT-EjCV=cW8mV1MmoMPPdY9q1scoPwbD_DEHpQHd3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: gyro: adxrs290: Add debugfs register access support
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 3, 2020 at 4:10 PM Nishant Malpani <nish.malpani25@gmail.com> wrote:
>
> Extend support to read/write byte data from/to the device using
> debugfs iio interface.

...

> +static int adxrs290_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +                              unsigned int writeval, unsigned int *readval)
> +{
> +       struct adxrs290_state *st = iio_priv(indio_dev);
> +       int ret;
> +
> +       if (!readval)
> +               return adxrs290_spi_write_reg(st->spi, reg, writeval);
> +
> +       ret = spi_w8r8(st->spi, ADXRS290_READ_REG(reg));
> +       if (ret < 0)
> +               return ret;
> +
> +       *readval = ret;
> +
> +       return 0;
> +}

Hmm... I would suggest to have it like

adxrs290_reg_access_rw()
{
 ...
 return 0;
}

adxrs290_reg_access()
{
 if (readval)
  return adxrs290_reg_access_rw();
 else // it's redundant, but someone can use for better formatting
  return adxrs290_spi_write_reg();
}

-- 
With Best Regards,
Andy Shevchenko
