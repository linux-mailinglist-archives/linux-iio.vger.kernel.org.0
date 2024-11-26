Return-Path: <linux-iio+bounces-12714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12699D9F0A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 22:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79862851C4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149E1DF759;
	Tue, 26 Nov 2024 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfZgouHG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65169160884;
	Tue, 26 Nov 2024 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732658031; cv=none; b=TA08qqoT9wNxco8cVXcIx1mV8joM9CqY9YCMnvRlhOcPnPf69RAstmHOO0jkUtouy5rhs9oRlMy5vEIFXTsrbasEAf36t2t6UPsKla4GxnvoYhBJ1egRgzEErPBeJIIvdw41JB6CkAD287MrEcdXYm115dFtggBdx3pMlhiTSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732658031; c=relaxed/simple;
	bh=XxW2iLPt+XhAQeApRQrQFEcEYbCZ/dJ9uwj2LSxxDLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzwFFDnJdV0VICrKAiBHPwfIBF4BnYpLnAtSAcvx8Uu5EXc576AZLkD4Ve6k9gZ86ZWJGUjFY6OdEAr4Hhku+wf+hCruU0S4ki2OC+eD5SFMh2gHuSTiClBSv4o41n1j+V0KqRne9dGQj37bcVSrN6wSSGvJ8uLNDAN+vkIKPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfZgouHG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e387ad888baso985676276.2;
        Tue, 26 Nov 2024 13:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732658028; x=1733262828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt1v0cwAYnSlT9foVL6cUW5pg9vb/kHtLuwjuwqBLxw=;
        b=gfZgouHG+oMeOBWs16MADv/mvZkOfJoC69yAsfqu1XTsblExeCR8V44ZdKR+l8AlEJ
         nl1i0mLdVPWcW5FP9aAS7zG0FURqKDE8UnFi8bhlXsmRyIDKIYwQ/+2JxPrtNxLzd7wR
         7CFN0NCkQCHJH06ID1kq6QQscZWq5eZMgLhTQ7enGZ8euzQVzTwJ+zMUUz91S1Qd6Ssz
         MEUdvFgTsI2T5iUwlZ5Z5OIfe9dChKAjkXXKVFm66zISjR4dEQJy/Qi2EymOqQpn1My/
         RMvuw2uCUgVdzaCKsG/CMlCyTvNJgdW8uysHRrmU5bptIYPh2Xyv9g3DLNd+0+/N3NqO
         LTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732658028; x=1733262828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt1v0cwAYnSlT9foVL6cUW5pg9vb/kHtLuwjuwqBLxw=;
        b=Qy6e3W6Mzij6KybZGHK507JnPULTTkjpuOWj95y+sPVz18dABVI9FsOxxVfY4vNhdV
         4f5ssuf81zXpXhJwFNADY9Cf2oSGsfsqk+dB+7qaa2QR1YEiG4UnoiOyK24pis4OS4iF
         0n/t/ATDP1/iI5gtigTjK5u9Hkx5oPFa/K5QfhtloW7fqjrxnJqx9Iqwt+cIVrfpB1He
         Tq/yhJpHe5IEj+cCxerpuRtLgGlNLrRp4xV9Dc7YlNQFzxTVMgFOkCqoP23SxfXPEqnc
         vHM+lqhHxlSLG+qNpDHd4E9kcbxD1QkAOp5h9Hel9dEzVfPBfx3hWABmU3fgyR10l+K5
         hBqg==
X-Forwarded-Encrypted: i=1; AJvYcCVphZc/dHvPZ7DdZ2cCi983tWPx/MSeQX22aHt+LvK/i7YzmPWEAYKDYx7OrIrCgMTa2l9fEGFSZR/ZWRZM@vger.kernel.org, AJvYcCXBWj56kB+uhjzbkTeJL8yR7OUBbYtAAjDd/fbXZxn2H9jpMfmnqLLvg7iJHVubeTJhJdtiyPq1Rfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsIA8EzFxqTBr17ydKPjjihEzM5DaJz8j1MybyL/r8efOpTjR
	8vIe9GGsP/xRUb2t4WwVMJncfy3S75WOuI66bbooBPm9duj0pAyDcE7IexIh5ndCUtkAX43ksuc
	Zkv6rrfDc0Ce3yIf7EwjnS8/V2qc=
X-Gm-Gg: ASbGnctxHWECuUUAl9fr08lCVwhQFRgMIwCHFm/Np4hkboGJLtKevzGqU7DFbhA7dzS
	fvEz6jg/35giqUIWWaX1KF9t6gGhpAV0=
X-Google-Smtp-Source: AGHT+IH7Oj7o8LbEu9AaD2P92tfHV+6MKCPIYSj99qZ6FcSbX3JDztvHRpUsR7nR76PLszA8002PwdFqwzWg2odqIgU=
X-Received: by 2002:a05:690c:dc3:b0:6e2:ada7:ab3a with SMTP id
 00721157ae682-6ef372752bdmr4240007b3.5.1732658028344; Tue, 26 Nov 2024
 13:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117182651.115056-1-l.rubusch@gmail.com> <20241117182651.115056-16-l.rubusch@gmail.com>
 <20241124185449.6f81ade1@jic23-huawei>
In-Reply-To: <20241124185449.6f81ade1@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 26 Nov 2024 22:53:12 +0100
Message-ID: <CAFXKEHZtG-y0xq=ejHg66N-gztukzVQRaGDjzaN5sdAJOL_G5g@mail.gmail.com>
Subject: Re: [PATCH v2 15/22] iio: accel: adxl345: reset the FIFO on error
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 7:54=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 17 Nov 2024 18:26:44 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add a function to empty the FIFO and reset the INT_SOURCE register.
> > Reading out is used to reset the fifo again. For cleanup also a read
> > on the INT_SOURCE register is needed to allow the adxl345 to issue
> > interrupts again. Without clearing the fields no further interrupts
> > will happen.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 75 ++++++++++++++++++++++++++++----
> >  1 file changed, 67 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 40e78dbdb0..82bd5c2b78 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -356,6 +356,61 @@ static int adxl345_get_fifo_entries(struct adxl34x=
_state *st, int *fifo_entries)
> >       return 0;
> >  }
> >
> > +/**
> > + * adxl345_read_fifo_elements() - Read fifo_entries number of elements=
.
> > + * @st: The instance of the state object of this sensor.
> > + * @fifo_entries: The number of lines in the FIFO referred to as fifo_=
entry,
> > + * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes eac=
h.
> > + *
> > + * The FIFO of the sensor is read linewise. The read measurement value=
s are
> > + * queued in the corresponding data structure in *st.
> > + *
> > + * It is recommended that a multiple-byte read of all registers be per=
formed to
> > + * prevent a change in data between reads of sequential registers. Tha=
t is to
> > + * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.
>
> To ensure this, set avail_scan_modes.
> Then if the user requests a subset, the IIO core code will extract what i=
s necessary
> from the read of everythign.

Very intersting. Unfortunately, I could not find "avail_scan_modes".
Did you mean "avail_scan_masks"? I saw some drivers operating with
such. Could you give me some more keywords, that I could have a look
how this is done, pls?

This must be (one of) the reason(s) why with noinc read I only managed
to read 3 directions from the FIFO at a time. Actually, I guess, it
should be possible to dump the entire FIFO.

Lothar

> > + *
> > + * Return: 0 or error value.
> > + */
> > +static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fi=
fo_entries)
> > +{
> > +     size_t count, ndirs =3D 3;
> > +     int i, ret;
> > +
> > +     count =3D 2 * ndirs; /* 2 byte per direction */
> sizeof(st->fifo_buf[0] * ndirs);
>
> > +     for (i =3D 0; i < fifo_entries; i++) {
> > +             ret =3D regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BAS=
E,
> > +                             st->fifo_buf + (i * count / 2), count);
> > +             if (ret) {
> > +                     pr_warn("%s(): regmap_noinc_read() failed\n", __f=
unc__);
> > +                     return -EFAULT;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * adxl345_empty_fifo() - Empty the FIFO.
> > + * @st: The instance to the state object of the sensor.
> > + *
> > + * Reading all elements of the FIFO linewise empties the FIFO. Reading=
 th
> > + * interrupt source register resets the sensor. This is needed also in=
 case of
> > + * overflow or error handling to reenable the sensor to issue interrup=
ts.
> > + */
> > +static void adxl345_empty_fifo(struct adxl34x_state *st)
> > +{
> > +     int regval;
> > +     int fifo_entries;
> > +
> > +     /* In case the HW is not "clean" just read out remaining elements=
 */
> > +     adxl345_get_fifo_entries(st, &fifo_entries);
> > +     if (fifo_entries > 0)
> > +             adxl345_read_fifo_elements(st, fifo_entries);
> > +
> > +     /* Reset the INT_SOURCE register by reading the register */
> > +     regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
> > +}
> > +
> >  static const struct iio_buffer_setup_ops adxl345_buffer_ops =3D {
> >  };
> >
> > @@ -401,30 +456,34 @@ static irqreturn_t adxl345_trigger_handler(int ir=
q, void *p)
> >
> >       ret =3D adxl345_get_status(st, &int_stat);
> >       if (ret < 0)
> > -             goto done;
> > +             goto err;
> All this churn just makes things less readable.  Better to have the bulk
> of the addition of fifo handling in one patch. It won't be too large
> for review.
> >
> >       /* Ignore already read event by reissued too fast */
> >       if (int_stat =3D=3D 0x0)
> > -             goto done;
> > +             goto err;
> >
> >       /* evaluation */
> >
> >       if (int_stat & ADXL345_INT_OVERRUN) {
> >               pr_debug("%s(): OVERRUN event detected\n", __func__);
> > -             goto done;
> > +             goto err;
> >       }
> >
> >       if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) =
{
> >               pr_debug("%s(): WATERMARK or DATA_READY event detected\n"=
, __func__);
> >               if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
> > -                     goto done;
> > -     }
> > -     goto done;
> > -done:
> > +                     goto err;
> >
> > -     if (indio_dev)
> >               iio_trigger_notify_done(indio_dev->trig);
> > +     }
> >
> > +     goto done;
> > +err:
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +     adxl345_empty_fifo(st);
> > +     return IRQ_NONE;
> NONE is probably a bad idea. Something went wrong but that doesn't
> mean it wasn't our interrupt.  In most cases it is better to just
> return that we handled it.  IRQ_NONE might be valid if the status
> said it wasn't ours.
>
> > +
> > +done:
> >       return IRQ_HANDLED;
> return where you have goto done and get rid of this.
>
> >  }
> >
>

