Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82FD5011
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfJLN1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:27:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43439 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726839AbfJLN1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 09:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570886843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mSmPn95dTxbtFsZXKmT9oca57QOpbVGLKuCe650iKI=;
        b=fWE67QqzljKIbX/QrFPm3LHDN6RpEBjTt8S4zHdTLIJjT7kDX9bOc+YpGehAnYQAFeT37t
        YVfMqRwidvhGSwpYZvwAHwLI9WZ59Lm1T8TN2dlqlhvs0sO+TLOAcpjxmtebFO4BG92QRS
        KRSmokNeXEIun3LLi8EBr0staPJORSU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-BSO12Vu9NVaeFADQK-nLrA-1; Sat, 12 Oct 2019 09:27:20 -0400
Received: by mail-io1-f72.google.com with SMTP id g126so18906151iof.3
        for <linux-iio@vger.kernel.org>; Sat, 12 Oct 2019 06:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvVdxBfFUUUiOCeYZkI7sUgaHb9GpTpgfIXV0H/TVvU=;
        b=C3Hc+zqO5cX4a+VYGBzSaIq4Y9UNVkf3EGPFoRTbrZwb5Ewqe0IgEZXgliVL+hnNC/
         lay4OCK62TaS6N23Kf+Ko97lgyBp4se1/Kfg5g7cagnPkNl5PMwpsd1AKClU7COd1KtP
         dS2najTRNeaZX1vB5Jif3fzyrA2xewh+W5XxYjZXmIuqCE+ViVQlU4jCglfANfQfPYU4
         2pdyNp4tIhuK8OCrlKlZkhcktm4/VEny5zMQekhDF58LTufh93ZoDCdghqXOziy1xS/G
         atRIkm8iUihggb/lcCOED57tmWXgZx/MXy09IMwJv5Ic2sjiiP2sB6S59Kf4YPLUsXYk
         D0ig==
X-Gm-Message-State: APjAAAXCi6H8My7D0wEP2V/v/Shoz8Jwng4Hh4FFFrslRW43ei+bSBmR
        jHMkO/qhnvgiKkwO7WXWPKu2SrYwxHIeY481LRTIWe4jXoyEiQswAj4XiHL5hLCPirIDcplz+up
        5HACJAveKU85Ld9WG5Qp0Sx6oNjYC3KSGGtv1
X-Received: by 2002:a6b:7945:: with SMTP id j5mr22021428iop.12.1570886839576;
        Sat, 12 Oct 2019 06:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzgpgrEeqnvKdFHhkx7Vc1+XTMTSh0dg1Nsb5SMO7ICwsdL5kf9s522ME74bjGBWvo/qJbvoJmzmcivV5UWb18=
X-Received: by 2002:a6b:7945:: with SMTP id j5mr22021392iop.12.1570886839188;
 Sat, 12 Oct 2019 06:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570441034.git.lorenzo@kernel.org> <20191012134023.1b0238ce@archlinux>
In-Reply-To: <20191012134023.1b0238ce@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 12 Oct 2019 15:27:08 +0200
Message-ID: <CAJ0CqmVt5+QMYZoFAOr9pnQDHwvEfu=asPxWP25jTqh7pXM7jg@mail.gmail.com>
Subject: Re: [PATCH 0/2] add support to STM LSM6DS0 6-axis Mems sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        martin@geanix.com, devicetree@vger.kernel.org
X-MC-Unique: BSO12Vu9NVaeFADQK-nLrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Mon,  7 Oct 2019 11:43:36 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Add support to STM LSM6DS0 6-axis sensor. Just compiled, but LSM6DS0 re=
lies on
> > the same register map used by LSM9DS1
> I'm feeling paranoid. Is this definitely different form the
> LSM6DSO which is already supported?
>
> If so ST loose for stupid part naming.

Yes, it is very different..AFAIK LSM6DSO is last IMU sensor from ST
while LSM6DS0 is very old (it has the same register map used in
LSM9DS1 imu).

Regards,
Lorenzo

>
> Jonathan
>
> >
> > Lorenzo Bianconi (2):
> >   iio: imu: st_lsm6dsx: add support to LSM6DS0
> >   dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds0 device bindings
> >
> >  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
> >  drivers/iio/imu/st_lsm6dsx/Kconfig                       | 2 +-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 5 ++++-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
> >  6 files changed, 18 insertions(+), 2 deletions(-)
> >
>

