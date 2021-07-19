Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7AB3CCFE1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhGSIWk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:22:40 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:44892 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbhGSIWj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:22:39 -0400
Received: by mail-pj1-f46.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so11985395pjo.3;
        Mon, 19 Jul 2021 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7CPkM/PC09FWcMi9Eu2o6KPkbaMxUaV2+b6rFKLJXGg=;
        b=RlMHSiKGPgNvAqmJ3fONaKQbOFJTLMSj5hkuBRmAkXFUvk9VgkhtQauD/lHDJ0V293
         a9rEDjQE1wcLG3+CtoQQqHHs2hiKUqT4iueRg+GvJcD5/Eiw9fnOCyCOIfuudY3PSNaO
         hm23uhpE09sOaQF3Cp2eedFlNaXk8711LXNrpoDtQ7F9sApMlBK7Km0CdbuKUfUYt8Rb
         IzoifFITJZP5QvBrzVaVNXKoFBUHfFBdc3CzKhO6BqAPNLEUoqxxQhFwOoZdhoTmhw0p
         0xppCdho7nLRVVwfDjS/NrLkZCTNupJR1zTrjD6Yiq15fPo4XVUsJE76t31QDWCSnpsi
         hcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7CPkM/PC09FWcMi9Eu2o6KPkbaMxUaV2+b6rFKLJXGg=;
        b=YRxYcjq5L15IOYj1TPve6TQ5u6raAGhjwQxGDNzai8DqQn7YRsmib28EEOoZdCS+89
         J5eOhfOSphmOTz6BirFhLHI5Hadl3lAgwTxBZED2gUzsSdxNmwvx0DzGFjBmQ21caCVk
         HVGWpXeWXmSpAS9+FahyCdhD4Xpf/a32UDBNqtv0Pdajd5anZmqjdVW7LxtxnJvlWxnP
         pyVvznQxuxGf/GLX/CyPJKnpda9x7HWE1ttff8CVgajehXS+LrfRVsgA9OHUg6rXt4Qd
         qjjM3ByvmjHrFCF2wvm1e2PEjPapTWqUzXtcrUKnkuF5Q4VEnQpPesYS+zDzNJDwlI42
         sBsg==
X-Gm-Message-State: AOAM533He/3g1s3CTZBOlX1lVlWs1jWCepCv0h4Vu9WDy1v/Q1pML6pa
        IGW2DWbEbQK8n+PYO8jP2tyVr1nZYZwKENMZY8g=
X-Google-Smtp-Source: ABdhPJyn3qqVixEIfkAnSijssrjGnopSVbkwIY4FHUI8uQay2fOdBTPh7WjOakScsOJsqzN1tfKrMrzj8vjPgBeQvLA=
X-Received: by 2002:a17:902:eb52:b029:129:bc24:ce5e with SMTP id
 i18-20020a170902eb52b0290129bc24ce5emr18514435pli.67.1626685338969; Mon, 19
 Jul 2021 02:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
In-Reply-To: <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 11:02:07 +0200
Message-ID: <CAN8YU5MFMqh3wZo-yOOE8och3x089kYWjtrr83Jt8wCQTKFE8Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vlad.dogaru@intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 15 lug 2021 alle ore 18:50 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:

>
> > +/* must be called in configuration mode */
> > +int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
> > +{
> > +       int i;
> > +       unsigned int tmp;
> > +       u8 cal[BNO055_CALDATA_LEN];
> > +       int read, tot_read = 0;
> > +       int ret = 0;
> > +       char *buf = kmalloc(fw->size + 1, GFP_KERNEL);
> > +
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       memcpy(buf, fw->data, fw->size);
>
> kmemdup() ?
>

As a second thought: no, the whole point of reallocating and copying
here, is that we want to allocate an extra byte; kmemdup() will
allocate and copy only the very same amount of memory
