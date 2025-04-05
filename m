Return-Path: <linux-iio+bounces-17634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A225A7C9BA
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBB01784F8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB1A3597A;
	Sat,  5 Apr 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMP1XYjK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9149366;
	Sat,  5 Apr 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743864369; cv=none; b=bIgWcQkJbPZNJUERAXy0Er52+qGlAzL1U39+S3lwAfyAOVPxFryvMDRhiZKX06DhCCc6iW5HmR7vnIHm1Qa1hqlt7DfALHc1ST+PlNgEeoSWgv7e20V+l0FDG5NBSJAH/sT2pO97M8YwiMAPaYAhWQAy4zSesntNREb1Ucd+Tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743864369; c=relaxed/simple;
	bh=6s3eQ7BkOXOdPBXuj2K3fWJdJVreSOIhE3/1mifP4AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhUlCzj3FvLTea2VDSePMlLp4u8pXH7taSnBqnZ3N+L8RAK6gwgIezzCSe5ByjOQxkHbzRgyzZd6I/nl6NeZly9H84VKaY746Akn5SengHands0a0/n1IJi7G7u5M9k76yTzmtCJJ6OH+pxCp+Z7N24SBGimCvWlq2ldKAD0DG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMP1XYjK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so3260414a91.0;
        Sat, 05 Apr 2025 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743864367; x=1744469167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM9pm8O4WYEyy6C9rJfQCxZshNzd0Wxlrb1h9vcUCcg=;
        b=GMP1XYjKYTTK7kZpbcIw7pM8g4EaSwj3Iv2UHq1JvpIux46VSDD3jExtkLJcK5BnvH
         oVW9kmDzF7uL1OsYm86t8xP/+yw4+yFvWco/lAmEwgLAZIEb/Zu7hennvJr4g4gRYXEs
         nc0lIzOL5sgnRE3FVTXZdi1RtgQEa15FVqSr48QUAIquyV3xmuNzUB11v3uZg19iO96z
         yLRWZA7J4e+dKzr9Rz/d5XOwe4pNIbgEXW5gSTZahKswfgqciLq3hF0YWesi1xDC8KkQ
         E04MoIsgqItOVfEZJFnr+lyDIxc/IYDPtK0/Z1wakJS4nEMVh+A07RP7AgZ/fNslmhWi
         YEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743864367; x=1744469167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM9pm8O4WYEyy6C9rJfQCxZshNzd0Wxlrb1h9vcUCcg=;
        b=mOX05w9gOBGbaO6gODF9JmOm+OXMzs+ldzXMQVuTS0v6QgNfAw1RLuRb8+PYZEAkpI
         1u19BQPoAauB7xpyaXS8EmgS22RFLKLuF0sW7A2TNWwzkCi9S6NFHbl/as/3Li1ZWB5B
         MjUztS0kBFah3T9pxJF3YYrJPT2+CuIHXq/y+XuGCJi10qTLAO/N7VBz/GADfrgG7wXT
         mQ+As9YDKuCP44aJXXP6Z2U6KYMBoWy05Crh3nbM3B5EgjPfNl2xDAB85dXBNpEsZaUv
         HM7aJXebkOczq+VeLPiegy2qzhf7BzTTBD7qZNpGxWEFfII+BgJ7G2tQ/p5AJVzeBNzb
         9iyg==
X-Forwarded-Encrypted: i=1; AJvYcCV+oEuwahIYzZx7TdtIGid4qOHF6P10glGrYW8f/rbltGB8EWcX2B/RuOR1iH8bu8S69LBIDYTQ8rTB@vger.kernel.org, AJvYcCVQtq5ZeXfL9WM8JpYh79AQB4hU/fehUZm4AeKP+QoBvBYdDo+8qXch78p6B8DAXw6S2rH4op4SfAWW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0cPyTnpVCPxZsHQKdGT85fspUYSWM+asP0dJhLWxFcQ30kej
	/vNngvy1c2MkLiRffdNMyGKSZDhTcLcveZEr4mwMP/bV4703Dq/g6lwW+vy+/oCvB9XoeEDSSY9
	Vulq0dqGMCc2akMUDUs3UQMN/YB0=
X-Gm-Gg: ASbGncvc6H0eKhfRjlWoy4PIKiwlSCZyxmdw0/64L5BB1QN//2irf/xu9MRpwB8GYji
	h4WqQ5XTXrC5mkpCDnqZ4Uw1PwaJMcpnHq5bh8zAcfitp2vYH0/C5JD/PhNI0xOXwP2TRiaNYhV
	8PypHMTB1lPoEEcIcwM07Nos7JTW0=
X-Google-Smtp-Source: AGHT+IHH7+o2N/dwkgL9yGiz2MpiopkNUI2wQHdOpcoCCLc6Kr0hKHRZtGxrg+QWQYUPCfnHY4CbwDGj/Q8gDVezvC4=
X-Received: by 2002:a17:90b:53c7:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-306a47e0664mr12367389a91.12.1743864366813; Sat, 05 Apr 2025
 07:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403053225.298308-1-gye976@gmail.com> <20250403053225.298308-5-gye976@gmail.com>
 <20250404125155.0000738d@huawei.com>
In-Reply-To: <20250404125155.0000738d@huawei.com>
From: gyeyoung <gye976@gmail.com>
Date: Sat, 5 Apr 2025 23:45:55 +0900
X-Gm-Features: ATxdqUHZbaPq4T9wRdUPhAhN3cojiOO1hYwXpVSyOR0cjh_655zFfIyrpErnfTM
Message-ID: <CAKbEznvnTzvv7GtdF0JNbsya0iW4fN3VFH9bEGNDrXWOfm3ELA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	lars@metafoo.de, gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan, thank you for the review.

> > +      * When data is received from the MH-Z19B,
> > +      * the 'mhz19b_receive_buf' callback function is called and fills=
 this buffer.
> > +      */
> > +     char buf[9];
> > +     int buf_idx;
> > +
> > +     /* must wait the 'buf' is filled with 9 bytes.*/
> > +     struct completion buf_ready;
> > +
> > +     /* protect access to mhz19b_state */
>
> Be more specific. What and why?  It's not protecting the regulator.

I added it at first since the buffer is shared, but there shouldn=E2=80=99t=
 be
any locking issues in this case. I=E2=80=99ll drop it.
>
> > +     struct mutex lock;
> > +};


>
> > +static IIO_CONST_ATTR(calibration_forced_value_available,
> > +     "0 1000-5000");
>
> Check the syntax for available attributes. We don't have a good
> way to describe this particular set of ranges. So best option
> may unfortunately be to not describe it at all.
> Anyone calibrating this device is going to be reading the datasheet
> anyway so should know what is possible.

Yes, it seems better to keep this as a comment only.


> > +}
> > +static IIO_CONST_ATTR(co2_range_available,
> > +     "2000 5000");
> > +static IIO_DEVICE_ATTR_WO(co2_range, 0);
> > +
> > +static struct attribute *mhz19b_attrs[] =3D {
> > +     &iio_const_attr_calibration_forced_value_available.dev_attr.attr,
> > +     &iio_const_attr_co2_range_available.dev_attr.attr,
> > +     &iio_dev_attr_calibration_auto_enable.dev_attr.attr,
> > +     &iio_dev_attr_calibration_forced_value.dev_attr.attr,
> > +     &iio_dev_attr_co2_range.dev_attr.attr,
> > +     NULL
> > +};
>
> > +
> > +static const struct iio_chan_spec mhz19b_channels[] =3D {
> > +     {
> > +             .type =3D IIO_CONCENTRATION,
> > +             .channel2 =3D IIO_MOD_CO2,
> > +             .modified =3D 1,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>
> I'm curious. We have a range control in your custom ABI, but no scale.
> So what units is this in?
>
The unit is ppm. and as far as I understand, co2 input(processed) unit
 is percentage concentration.
so In this device, the scale is a constant value (0.0001), regardless
of the range.
Is my understanding correct?

> > + */
> > +static void mhz19b_write_wakeup(struct serdev_device *serdev)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_get_drvdata(&serdev->dev);
>
> There was still an open question on that where I asked
> if a standard existing callback was the correct minimal thing to do.
>
ah, serdev_device_write_wakeup() fits perfectly in this case.
I miss that, sorry.

> > +
> > +     init_completion(&st->buf_ready);
> > +     ret =3D devm_mutex_init(dev, &st->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* TO DO:
> > +      *  - vin supply
>
> The code is very simple to just turn on the power supply
> at driver load and off at unload. Simpler to do that from the start than
> end up with it being added later.

Yes, I agree with you. I will add some code for it.

Thanks,
Gyeyoung

