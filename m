Return-Path: <linux-iio+bounces-20435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87904AD593E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F8E189A8A9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC472882DD;
	Wed, 11 Jun 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQV9tVvu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047E2BB04;
	Wed, 11 Jun 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653414; cv=none; b=bqzWCwMbQBu4xtDSyJscGstvsW9mIXXK0P/1u7c9GcuFyd6rLQH1AAKPQItJxZMr6fkJaWTHv8uO1iqt/9aocanUSoS1VifopwLMXGvlYaM5UlbK1u7/28sWZSoCYlJ3kG8PtaQJgoMxQ//4tNOkeQDMrkmeb2aW0Zcp3QN5GdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653414; c=relaxed/simple;
	bh=AEeuE1jrKq9OUFgXvxYNu6QzNg4rrO74sp/X2G3FTmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPaxOx+i1PiIOKvaIu3kn1Kvih329vCrBL3whHmn6Lt6IHP347npyxPo0kclQQqfjZl7GciJx1V27M4eJsJXB7ilI/ZufKRlOmzlFvQjVtujRoYRsExpk6cbCOB+yObxiyV7ulOoC7pCE3cIeOOpwlCzTr5TqOTj8WdyfB43tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQV9tVvu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e80ba7039so858017b3.3;
        Wed, 11 Jun 2025 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749653411; x=1750258211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/41rwAS4g+9mbZGS4hIlX3+3rogaqhqNUidcEJYkW8=;
        b=EQV9tVvusFZt1kKSVpZC+dwdZrITyE+HfqSI3QmjTQF6x6OJj4c7P0KkiijdUaW29Y
         D1FMoKd8GtYthEF1/EzSv7AMQF63rpnYa/a4Gi1hAqrTZvtXfJigMykSWlOFTe1ggSB+
         aEFTvIOjWbiYi64DcQ3tD7278hlUQQst4gqKq/UOH1ydLQwRDYbuelqlHwqieHWenVe8
         Is/TgG8WndIaWZIGvjxKXYcIOJbdVJxPySn598XFxTUWgo2/QyXdeSf9T9L55V+jBiz7
         Utr3ZFqRIpmthiQ7MqxZmKQ0qCwgKShPJUY2UDwwmzU8SNujpNB6dwne5FvIcAjeyJRN
         6Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653411; x=1750258211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/41rwAS4g+9mbZGS4hIlX3+3rogaqhqNUidcEJYkW8=;
        b=QvstTrytpfGBxakkmOiokhhmibz4rldanLGcDONiki89ZXOq5FdLTvGuxmTPcNic44
         mW7PZjplWW9hTV62z2s6tzF3DFi0Am+B5N3y8KcdUiR6txkHb4MwypC1NoI0fV86UJGb
         ug9xVW4kLzzd5+VMV//sSxHoLGM6dJw13ClJlIM/BfQJiKs1khg+x1m91CUWgGmDRYD1
         feFLAELIzXfLy0gUTnz6BOy8sDeNn1BbV0P+A2FZarab0+znOjsVoeuhQM2JNvW/a5B0
         fAcIa+ulLiEQZyx37Xri6gOCmF16baVn/YDdmmFBfWwhynG1Y3J0DuRg2wPFOluTJs4Z
         Af2g==
X-Forwarded-Encrypted: i=1; AJvYcCU438q/9UZSF0N2395G/OCkUE3m4rUogXOUafBj7aauRZBpZUNEo0CAaWfLUZRIbRvbtcL5GLI305g=@vger.kernel.org, AJvYcCVDvjlW0wQNTZuHqc02DOHwlZ19ZTX7pbzR0+DF02Of80kWLoDWX3Ck6Q0LscPkiAGS/wJOhHETiMSxf0xw@vger.kernel.org, AJvYcCWhMP3HacU4mcpT8Metxo+fp9NJJ0YPYHKsv8qloQcau8PmGIF7qiNPPUEPkwH2QBG0Iv0kuyRFTdy2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3Cz86K7oqDZoWqWPZm/NQc4Fh3J8RR4hN3pUL9o0RiaDc6kD
	oc1x37IDEHZT4+ODSdNoOlLGYpZAvuLVPqzIc0RXpsQd8NT4Ltmd2YQ//Oe9fN/YstlnkGFyPy1
	U1qJc25T5zJpgQScYuGgBkRcd7I+G630=
X-Gm-Gg: ASbGncu8yHSEJHkDXmZzJ/gC/iL+3qgVl5KbAAaO6QR1jRTPYhaInUNAhh6XGIi7Pz7
	/fM+P6AM2jpoEtJyXLk7E3VZSO2bfIFG31Lk931SrzRFLNQiYzTJdSY5xRWvh1/nmDCEY+fD3Qx
	GuRliZ843G12OGdkwRmMUzcAiCOHTlKUso5EDL+L5Ezho=
X-Google-Smtp-Source: AGHT+IFP3eqHwMz69ch7Kc+Cu181mBk/M7iwnEoL6sRNAx1+7NddD87oDbHgNgk+Oewz7JDlXkzTRI20MWR3eLTqRyk=
X-Received: by 2002:a05:690c:f87:b0:710:e707:334e with SMTP id
 00721157ae682-71140b375eamr22973287b3.9.1749653411094; Wed, 11 Jun 2025
 07:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-8-l.rubusch@gmail.com>
 <CAHp75VemOXhpRp2hfDhvzi3y5j5oL-_0xMmWRWkwEtX7Ks5nMQ@mail.gmail.com>
In-Reply-To: <CAHp75VemOXhpRp2hfDhvzi3y5j5oL-_0xMmWRWkwEtX7Ks5nMQ@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 16:49:34 +0200
X-Gm-Features: AX0GCFtUretQvWnzRd18WZo3qv7_gg-6ynQ28lJ1vz4r_avJASJoR8-xQOaHeIM
Message-ID: <CAFXKEHZcS2qpb1zp6kkQm_Pb-MxYHErpjD=q6huuLm1Nq=xjqA@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sun, Jun 1, 2025 at 9:38=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > Add possibilities to set a threshold for activity sensing. Extend the
> > interrupt handler to process activity interrupts. Provide functions to =
set
> > the activity threshold and to enable/disable activity sensing. Further =
add
> > a fake channel for having x, y and z axis anded on the iio channel.
>
> IIO
>
> And what does the 'anded' mean?
>
> > This is a preparatory patch. Some of the definitions and functions are
> > supposed to be extended for inactivity later on.
>
> ...
>
> > +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> > +                                  enum adxl313_activity_type type)
> > +{
> > +       unsigned int axis_ctrl;
> > +       unsigned int regval;
> > +       int axis_en, int_en, ret;
> > +
> > +       ret =3D regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &a=
xis_ctrl);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Check if axis for activity are enabled */
> > +       if (type !=3D ADXL313_ACTIVITY)
> > +               return 0;
> > +
> > +       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
>
> If it's false, it will be false anyway. No need to defer the check:
>
>   if (!axis_en)
>     return false;
>
> > +       /* The axis are enabled, now check if specific interrupt is ena=
bled */
> > +       ret =3D regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regv=
al);
> > +       if (ret)
> > +               return ret;
> > +
> > +       int_en =3D adxl313_act_int_reg[type] & regval;
> > +
> > +       return axis_en && int_en;
>
>   return ... & regval;
>
> > +}
>
> I have already commented on this a couple of times.
>
> ...
>
> > +       /* Scale factor 15.625 mg/LSB */
> > +       regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
>
> I would rather do
>
> val * MICRO + val2
>
> which is read more naturally (we will easily get that the expression
> uses MICRO scale).
>
> ...
>
> > +       int ret =3D -ENOENT;
> > +
> > +       if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
> > +               ret =3D iio_push_event(indio_dev,
> > +                                    IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                                       IIO_MOD_X_OR_Y_=
OR_Z,
> > +                                                       IIO_EV_TYPE_MAG=
,
> > +                                                       IIO_EV_DIR_RISI=
NG),
> > +                                    ts);
> > +               if (ret)
> > +                       return ret;
> > +       }
> >
> >         if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
> >                 samples =3D adxl313_get_samples(data);
> >                 if (samples < 0)
> >                         return samples;
> >
> > -               return adxl313_fifo_push(indio_dev, samples);
> > +               ret =3D adxl313_fifo_push(indio_dev, samples);
>
> This is not needed...
>

IMHO this will be needed, or shall be needed in the follow up context.

The [going to be renamed] function push_events() shall evaluate the
interrupt status register for the events the driver can handle and
also eventually drain the FIFO in case of watermark. It shall
distinguish between failure, events / drain the FIFO which can be
handled, and events which cannot be handled so far. It's not a if /
else, there can be some event, and some fifo data. Therefore I'd like
not a simple return here, but init a ret var.

I interpreted your reviews, to change the particular implementation as
if there was just activity. Then in a follow up patch, rewrite it
again, now to distinguish just bewteen just activity and inactivity
e.g. by if/else. Eventually rewrite it by a third approach to
distinghish activity, inactivity, AC-coupled activity and AC-coupled
inactivity, might be now switch/case. Eventually you might complain
that my patches contain way too much modification of every line in
every patch.

I'd rather like to start right away with the final structure with just
the first element - e.g. "activity" - leads to results like the above.
Less churn among patches, but having just one element looks like
having taken an over-complicated approach.

Perhaps it's my patch split? Unsure, I tried to note in the commit message:
> This is a preparatory patch. Some of the definitions and functions are
> supposed to be extended for inactivity later on.
Perhaps it needs more feedback here?

Another example is seting up the read/write_event_config() or
read/write_event_value() functions. I mean, eventually this will
become a switch/case implementation. Of course with just one element
switch/case seems to be obvious overkill. Going by your advice, I
changed it to if(!..) return, it's definitely cleaner. Definitely in
the follow up patches this will be rewritten, though.

Please, let me know what is the best approach or what I can improve to
avoid such "ping pong patching" as you name it?

Might be that you're right here in this particular case, but then it
would be better to discuss the final structure, isn't it?


> >         }
> >
> >         /* Return error if no event data was pushed to the IIO channel.=
 */
> > -       return -ENOENT;
> > +       return ret;
>
> ...and this looks wrong.

Well, as I said. Each separate if-condition (not just if-else), could
be ok or not. If ok, the function still shall continue, might be at
the end, also a watermark flag is in the status reg and the FIFO needs
to be drained. It also might be, that some event comes which the
driver does still not handle, but not necessarily an error
(missconfiguration). So, draining the FIFO helps in most cases to
bring a derailed sensor back on track. If not doing so, it silmply
stops working, you would need to turn off and on again, or even power
cycle the setup.

Probably you have a better idea here, but pls have a look into the
final setup. I really appreciate your feedbacks. I understand this is
a rather problematic part of the code. To me it makes sense like this,
but I'd highly appreciate your advice.

>
> Before the case was clear, if we have no respective bit set in the
> int_stat, we return ENOENT. Now it depends on the other bit. If this
> is correct behaviour, it needs a comment.
>
> --
> With Best Regards,
> Andy Shevchenko

