Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FBDD928B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 15:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405388AbfJPNd6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 09:33:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53757 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405404AbfJPNd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 09:33:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so2953230wmd.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2019 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AYq2N2yEzQH1HjpxxmEeXqbt30IDy6qCih3rZuvrbBo=;
        b=kuJmsIwxhcDk12Qhi+jjnG3VISYs2cmQLedBqa44+pU9Q3QcxbB/q8/gGnQ3YT3+N4
         JBcafTIvBkZtrvqVawGm0imvEn34920vkcFdC9bwedaJZe12oWjDOaxeDhMcRwqHU4B4
         H1WWBqu0lVv+OQmSfXw7e1NrKGkK2n+wj1Tt+9pZjx8x6gRYGubtAmNsAZyGr6k/KFQI
         xrR15SLl6gJQTblye2208ucXr5jK0KW+gavggAAca5q8srF0zXJMTRkUBA7DvekxBDrM
         BxTTCfBk1oxab2unXDfQp9abC9BTgKNSQDMOUamBFovmmBhlqLf1WRImHptfBpjYUfuO
         gs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AYq2N2yEzQH1HjpxxmEeXqbt30IDy6qCih3rZuvrbBo=;
        b=hgJtr3mkn65PZmo96nujCFjPoEiPn/eMs8u6U+0f87uovWlRSYQN42Gv57z6CAr8lw
         bli8DsREuJa3+5kbLfZFiUB+WLlqqPd0jFbPj7oQZWjxjCnd/3yJ5tth0CYtstv+MJDq
         t/iPDfaJH9Bs+aVtq+C/16HS7IWJEXs5qLUfJoYCzRm3Ha5jbRaLMBgCFymozXxnkhJI
         LMUHSWCbiTvo362k60zs8wGyrkF6s3/MbAknLDES6BDDW8FojjFJIX1iIJYhOMrPAz1F
         RUb4rXxAIMgO1GgRyrT0R4cnl0TM45xQJgNPcFqPfzRMeNuf664W7cCO2MNAtMOWo07q
         lNBg==
X-Gm-Message-State: APjAAAWUbt00GId01StTeM5j6sMdzwlkPKAd9ZUOF1u68BvvMghIlw/0
        nDUh5hzXCoEoK4wQqXgXvhUzZvuYcZXhQiDf3bO0Rkmf
X-Google-Smtp-Source: APXvYqy2AtTWdLiz35MFiNyM4ycc/XC9eWmml2Djpws8xt66XX+q0ikR7AIFMzbLfaZpRdlC3ltEFR1jEtBXJq7yFX0=
X-Received: by 2002:a1c:2407:: with SMTP id k7mr3275299wmk.99.1571232834249;
 Wed, 16 Oct 2019 06:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20190923121714.13672-3-andrea.merello@gmail.com> <20191006085545.2df79667@archlinux>
In-Reply-To: <20191006085545.2df79667@archlinux>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 16 Oct 2019 15:33:42 +0200
Message-ID: <CAN8YU5NPpcwcj1ik+yzWuvRheBzLtj3A75b_5FZtqw2osfoahQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: max31856: add support for configuring the HW averaging
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Colin King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno dom 6 ott 2019 alle ore 09:55 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Mon, 23 Sep 2019 14:17:13 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > This sensor can perform samples averaging in hardware, but currently the
> > driver leaves this setting alone (default is no averaging).
> >
> > This patch introduces a new IIO attribute that allows the user to set the
> > averaging as desired (the HW supports averaging of 2, 5, 8 or 16 samples)
> >
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>
> Sounds like oversampling combined with a lower sampling frequency, so
> there is standard ABI for that.

OK. Do you refer to "oversampling_ratio"?

The datasheet says this applies to thermocouple measure, but by doing
some testing with real HW, it seems that this setting affects both
thermocouple and cold-junction measures, so I guess it shouldn't be in
the form "in_temp_raw_oversampling_ratio"; does this sound right to
you?

> Jonathan
>
> > ---
> >  drivers/iio/temperature/max31856.c | 43 ++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> > index d12613f7ba3c..8b2e0102fa5c 100644
> > --- a/drivers/iio/temperature/max31856.c
> > +++ b/drivers/iio/temperature/max31856.c
> > @@ -24,6 +24,8 @@
> >  #define MAX31856_CR0_OCFAULT       BIT(4)
> >  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
> >  #define MAX31856_CR0_FILTER_50HZ   BIT(0)
> > +#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
> > +#define MAX31856_AVERAGING_SHIFT   4
> >  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
> >  #define MAX31856_FAULT_OVUV        BIT(1)
> >  #define MAX31856_FAULT_OPEN        BIT(0)
> > @@ -65,6 +67,7 @@ struct max31856_data {
> >       struct spi_device *spi;
> >       u32 thermocouple_type;
> >       bool filter_50hz;
> > +     int averaging;
> >  };
> >
> >  static int max31856_read(struct max31856_data *data, u8 reg,
> > @@ -109,6 +112,10 @@ static int max31856_init(struct max31856_data *data)
> >
> >       reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
> >       reg_cr1_val |= data->thermocouple_type;
> > +
> > +     reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
> > +     reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
> > +
> >       ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
> >       if (ret)
> >               return ret;
> > @@ -295,14 +302,50 @@ static ssize_t set_filter(struct device *dev,
> >       return len;
> >  }
> >
> > +static ssize_t show_averaging(struct device *dev,
> > +                           struct device_attribute *attr,
> > +                           char *buf)
> > +{
> > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +     struct max31856_data *data = iio_priv(indio_dev);
> > +
> > +     return sprintf(buf, "%d\n", 1 << data->averaging);
> > +}
> > +
> > +static ssize_t set_averaging(struct device *dev,
> > +                          struct device_attribute *attr,
> > +                          const char *buf,
> > +                          size_t len)
> > +{
> > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +     struct max31856_data *data = iio_priv(indio_dev);
> > +     unsigned int nsamples;
> > +     int shift;
> > +     int ret;
> > +
> > +     ret = kstrtouint(buf, 10, &nsamples);
> > +     if (ret)
> > +             return ret;
> > +
> > +     shift = fls(nsamples) - 1;
> > +     if (nsamples > 16 || BIT(shift) != nsamples)
> > +             return -EINVAL;
> > +
> > +     data->averaging = shift;
> > +     max31856_init(data);
> > +     return len;
> > +}
> > +
> >  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> >  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> >  static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
> > +static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
> >
> >  static struct attribute *max31856_attributes[] = {
> >       &iio_dev_attr_fault_ovuv.dev_attr.attr,
> >       &iio_dev_attr_fault_oc.dev_attr.attr,
> >       &iio_dev_attr_filter.dev_attr.attr,
> > +     &iio_dev_attr_averaging.dev_attr.attr,
> >       NULL,
> >  };
> >
>
