Return-Path: <linux-iio+bounces-23664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE097B41317
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 05:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591191B274E3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 03:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B571E9919;
	Wed,  3 Sep 2025 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbVmQPzu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7BBA4A;
	Wed,  3 Sep 2025 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871169; cv=none; b=ZAat9AGfKfN8ESrsL/8oV2HMD/SXmGeW1j/Fzqkk5GljRWavM5NBHcr9TX0luhuWWJ7rqOlXU6uM8ouLb+vO4Q/Be3AzS9Fzxzq1RAaQrD4wvPbHyiQq7xapzY1n1z3T3vjIrs7sZZZe2+Jr6cpQyU0GfJown2AbSYTPCpjQMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871169; c=relaxed/simple;
	bh=6JeODGhUmfMgsEw5AyH9a8tSkHZ61ujB953Yz6MMK58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz7FXryJivKgVTjJYE9kTih4BSJKKluQ9QJJVZABtHQsQ82iGuH7LcEj/pPrdez/kxE6dRdDEJ5pUfIWm5KbbI4l/ZvqMjSCwHRe48CVjsiqO0Dh/3TmQrwXGJl2MdTTW87ziuuRA7mOBcu/Py+uZmWhYP8Nrr/SDNHiMTAxu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbVmQPzu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336cee72f40so31656081fa.2;
        Tue, 02 Sep 2025 20:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756871165; x=1757475965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0Z7nLA7aVtrFGgmeGm/eI0r1k5QWi+ahYOUOcO2AD0=;
        b=GbVmQPzu+7GLPcGoX3OLMoP/MW7GgPMzFZEBcuBEf3Gbeok1cu7VfOHDbgBeloLWg2
         UcUWpyFkVAsLTWi8Ss7bKNbJfzt9feCyV1aVZ6ZZujfU+pCL460oK1K0eb619GRLY6Mc
         mUe+alYV3WauxfFtSB5v5Qzxfhh22rSYn9ynKvDp+8UZjYComLctE8xjl5K9rRx/8gtj
         KNGcmDL7fTOWVgoF+XpC4m4OEfEJYsFCZUSoo3+bfhS3TxgS6fNzU+or29MR5j0SGNH3
         emXflpqFQ60/qXrpaTyfmeVnVpIarevctc6LGa/dcCKNKrDtsUk+JGB8Sv9KJUFhdim4
         sQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871165; x=1757475965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0Z7nLA7aVtrFGgmeGm/eI0r1k5QWi+ahYOUOcO2AD0=;
        b=ikNN59GjlseQ/Yv4NVWN7wXWPH9r6NYw31zEH+TGQkC3EECgFXFMJdRFOePt+Sez5G
         CH0Jwsu6bx1k0t0nbAf/Hn9VK++YwVVl/70Oj7KgRPy/Iw7co+4PSmTQ8FhA25ER1DKI
         fZO61EXnmRUMX0OZFJHGXU8sxJrdbPY3cxovL6oL+JRa/brgmN5mbdUTA22pKWJTxs/3
         97Bo8dI5ePlcon7A+xgm2vSQ0HkrHFO0hQO+S3e9H1AQThAFuXPgUfe/PeMh7OqjCloo
         Q3Tg8SEREVI859O2Sz81CCKY0hMiSutMBZB65EZt9zD6vGeRufHpPxqy8WUbY0RB+DNp
         8Zzw==
X-Forwarded-Encrypted: i=1; AJvYcCU0pH3zu0fQrskeC7NEV/QZfimDDC7j1F7zgVFYZ3U9yW7FGEH5o4f3s+zbZOXqFMLk9e2wuokGA9I=@vger.kernel.org, AJvYcCUb0BVD3Tpk0fWzaaW4Ekf1AVC0VhiWQv37my/X/CUMUqilSwi5C2y13J9aGp3Mz+SDAKb5YNidbdLklzWs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3BANevUCXmiE+8mQXXNHs1LZ2gdGjjgaD1sWFPuzSOZl3Ret
	yqPINIk18VTvl4GIzAKWlhGRy+d5Ab3QxNIUgehVic5DGHib9hW4aaNsepVbbj1YG900J/Mebnw
	2vlHBJ5rr0HLl7ozrY6VyhfgKkTBxDjc=
X-Gm-Gg: ASbGncujT7vcUhk0R3O6IUeyv/XDFIH/0SrJ4e+nNxhWSy8+t6S4DFjt7b+IfX0g/lL
	YTrxPvnciK/vb2A+Lg+cq0uMZEJjja/FnXqlRMLAZ4v+F+of9WwaZKnK6CPj/rOxGTfPjJf3IfN
	ouMJGKykO5gjU0SE8wpMILXSyzJtFianPFHe3VeDMnVTdZDYmCZwGw1gNVLkIcWei8dkgH2lUcJ
	hHN0GgYxP0Ek2/rVzwk4LVdvTbszi1b9OXMBnbdZjiX2JZpG6Wj
X-Google-Smtp-Source: AGHT+IHBvgqTlzo2mrZAhB7FN0BcOeT+9TYJbXmMqfp//04ZfjspH+O9ZZ/2oaqqDqrZX0ztFAnYJ5zo6YWJVX8KqnM=
X-Received: by 2002:a05:651c:4ca:b0:32b:7472:c334 with SMTP id
 38308e7fff4ca-336ca988152mr49278681fa.16.1756871165026; Tue, 02 Sep 2025
 20:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901184238.34335-1-akshayaj.lkd@gmail.com> <aLbptFRh9ZvAVfLn@smile.fi.intel.com>
In-Reply-To: <aLbptFRh9ZvAVfLn@smile.fi.intel.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 3 Sep 2025 09:15:53 +0530
X-Gm-Features: Ac12FXwVvsbM41bQHZ82XJLOIt2xRM2n18hDbxMUQC2jLBsuDabZ9aKHLtKLWbw
Message-ID: <CAE3SzaTnNckFDRMDqGPDAg471bRskJ=_n5C_qSLKQeq3F-Lu_g@mail.gmail.com>
Subject: Re: [PATCH v4] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Andy for the review. Follow-ups inline.

On Tue, Sep 2, 2025 at 6:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 02, 2025 at 12:12:36AM +0530, Akshay Jindal wrote:
> > Implement runtime power management for the LTR390 sensor. The device
> > autosuspends after 1s of idle time, reducing current consumption from
> > 100 =E6=B8=99 in active mode to 1 =E6=B8=99 in standby mode as per the =
datasheet.
> >
> > Ensure that interrupts continue to be delivered with runtime PM.
> > Since the LTR390 cannot be used as a wakeup source during runtime
> > suspend, therefore increment the runtime PM refcount when enabling
> > events and decrement it when disabling events or powering down.
> > This prevents event loss while still allowing power savings when IRQs
> > are unused.
>
> ...
>
> > -static int ltr390_read_raw(struct iio_dev *iio_device,
> > -                        struct iio_chan_spec const *chan, int *val,
> > -                        int *val2, long mask)
> > +
> > +static int __ltr390_read_raw(struct iio_dev *iio_device,
> > +                     struct iio_chan_spec const *chan, int *val,
> > +                     int *val2, long mask)
>
> Can we avoid using leading __ (double underscore)? Better name is
> ltr390_read_raw_no_pm(). But you may find even better one.

renamed as follows:
__ltr390_read_raw()-->ltr390_do_read_raw()

>
> ...
>
> > -static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > +static int __ltr390_write_event_config(struct iio_dev *indio_dev,
>
> Ditto.
__ltr390_write_event_config--->ltr390_do_event_config()

>
> ...
>
> > +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > +                             const struct iio_chan_spec *chan,
> > +                             enum iio_event_type type,
> > +                             enum iio_event_direction dir,
> > +                             bool state)
> > +{
> > +     int ret;
> > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > +     struct device *dev =3D &data->client->dev;
>
> ^^^ (1) for the reference below.
>
> >       /* Ensure that power off and interrupts are disabled */
> > -     if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > -                             LTR390_LS_INT_EN) < 0)
> > -             dev_err(&data->client->dev, "failed to disable interrupts=
\n");
> > +     if (data->irq_enabled) {
> > +             if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > +                                     LTR390_LS_INT_EN) < 0)
>
> Wrong indentation, hard to read line, either one line, or do better. Actu=
ally
> why not assign it to ret? The above not only simple style issue, but also=
 makes
> readability much harder as the semantics of '0' is completely hidden. Thi=
s style
> is discouraged.
Earlier did not use ret here, because powerdown function is of type void.
But if readability is the issue, I have used ret.

Regarding clubbing into 1 line, I have my reservations there. I think
we should not
violate the 80 char line limit. Also since the line is already 1-level
indented (begins
at 9th column, due to if(data->irq_enabled) check), the spillover will
be too much.
The readability does not seem to be taking a substantial hit here.
Let me know if this is non-negotiable for you. Will happily make the change=
s.
>
> > +                     dev_err(&data->client->dev,
> > +                                     "failed to disable interrupts\n")=
;
>
> Why not doing (1) here as well and with that
done
>
>                         dev_err(dev, "failed to disable interrupts\n");
>
> besides the fact of wrong indentation.
fixed
>
> > +             data->irq_enabled =3D false;
> > +
> > +             pm_runtime_put_autosuspend(&data->client->dev);
> > +     }
>
> ...
>
> > +static int ltr390_pm_init(struct ltr390_data *data)
> > +{
> > +     int ret;
> > +     struct device *dev =3D &data->client->dev;
> > +
> > +     ret =3D devm_pm_runtime_set_active_enabled(dev);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                     "failed to enable runtime PM\n");
>
> Something wrong with your editor or so, please check and make proper
> indentation _everywhere_ (in your changes).
Fixed.
Editor is fine, just did not pay attention here. Matched with existing dev_=
err
statements and understood what you meant.
>
> > +     pm_runtime_set_autosuspend_delay(dev, 1000);
> > +     pm_runtime_use_autosuspend(dev);
> > +     return 0;
> > +}
>
> ...
>
> > +static int ltr390_runtime_suspend(struct device *dev)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > +
> > +     return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
> > +                             LTR390_SENSOR_ENABLE);
>
> I would make it one line despite being 87 character long.
Same as above
>
> > +}
> > +
> > +static int ltr390_runtime_resume(struct device *dev)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > +
> > +     return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> > +                             LTR390_SENSOR_ENABLE);
>
> Ditto. (Here it's even shorter)
Same as above

Thanks,
Akshay

