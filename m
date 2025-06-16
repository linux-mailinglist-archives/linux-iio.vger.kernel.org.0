Return-Path: <linux-iio+bounces-20705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EEBADAE04
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF039188D9BA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BC5298CDE;
	Mon, 16 Jun 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXOtpIw8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108812641C3;
	Mon, 16 Jun 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072130; cv=none; b=YFnPbrM5vdw2QhVyY71wq4M35j7dZrQbcsJCBybCSW8DNu4WswR3LkaxIDWr2PA51tLKR132ApXGkjYFW/TJai9/FsXV8fB9d03Y5YV+SVCWFtpVWk4sgfBvwjIJx2ZZA5dQjqPt27Dwb2zxO6db6Vnm3QdZP9r1mhb3lMINCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072130; c=relaxed/simple;
	bh=SG65e5h8Je3miCFgAzV4ivtAbTcr1kPNEH9Nbgn7wMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcQEodYbIcozk0QLGwxQ9O6qamvh1STiFNZNoD/ni5BTAA2xWp4JNl6FvIn38SQ+GB6Pa3C3Wii1aWGtXMTkPw4diz6nPKfbINHjNyUvWM6uRiTPHCt8EdBuJO4QUaZZ3ICR5X1MutPb3kyPo6OVrgf0NRAg72lIkBUwcUjAUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXOtpIw8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adfb562266cso251272966b.0;
        Mon, 16 Jun 2025 04:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750072127; x=1750676927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF2GuuBU+VkqFmp436qPJ1JhgGKnZ8HVcy4XhiKGL0I=;
        b=XXOtpIw8vvSAakRTO0KmroleYcXz9ecFE4r15P2NnvrbM69HdNtySF1p+Yns10Dhc/
         liQbWgRNm05VOQdUCZ3fLR/yC1J8B4Dfadc/fF5PhEWB7UWDEHD4E+1I/OoI4yr1UkxV
         YDYxmS7cLmooKuXwO5agSjcE3T6sKct4AJwjw78+cbKW2vj+ULpK3ig8rKYWsdyvtsOe
         EwuvDpyPLdSAWDU7YE1twfAWuSBhkhKJ9UsHr8kUJ0hVU4rwMitdf4/miI+oEWhevPIv
         DwiFebe1nJQ1lHapLokSyeRC8to0H74hi8K4S2BXsKTU47+/Bm6o2hG+MRS1MnonXq48
         AQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750072127; x=1750676927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF2GuuBU+VkqFmp436qPJ1JhgGKnZ8HVcy4XhiKGL0I=;
        b=Qs08cQzJIqGTW/nU/Ti8L5zeGP3xrVJlOCX6julkMl3YyILBNaABcYX4HpKiXyVR9k
         +eSwzeoX290PWj3o5hxQ2qk0DR/PwpmWQlgteXh6aNfY9NJ3rG16AK1mxF1SkWBCrEj2
         2XHN7/TOzRBYOmNmA9HXoM1SZsalhfAX0cgbeJpnMMDogwq0k977uYMtIEX8Opi2ZS1I
         AgA+1ZdRkXgt/cS7CwgrjKTjsv7h9/0AsW7mWF+MEBZeAgSAICV5dZvSCVKCp25yDWZr
         oDAEq9tBG32RNLkAFjqOnKfl4cWuzlS12yXlKaR8nMPNjJeijEFdQfU92pGLp/XvWJzD
         rxow==
X-Forwarded-Encrypted: i=1; AJvYcCVi0HUdGgakrXFpjp7RlUizDgiSNfz7vqjiCCBml3OJ1YS2esFX+fJctP5Zm1vXCOs5+w3ssRX0y0Wc@vger.kernel.org, AJvYcCWh1ygQZ33w4+o4AP63TUmhuepiJ3HXRufaW6O49jtZkt89knrtZt++cCdsgTBn+dttPD2XuWagaXkcBnix@vger.kernel.org, AJvYcCXFoMWkXpiCOXx7Eztn+aUPJ7pAkiPMRkpu/rJA67ONI/YkFBbyUrmVHKEDb+7OhqbkqOtNxTyJoBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsimb6/1yAacnttEI9O5YOJASyUCEifUMxTy37MIODR2mwl1P
	de7Uv34padg0LY2qQRKKqpWNjJQSIe3TEKFK5Zx8viN4wPkVtRlrchfF7t8EcHgjrO2TQKZPYUQ
	DM2WwB/tEaASo1Kid5lnx0yLWvLb13M8=
X-Gm-Gg: ASbGnctdhMkZOIFdmnAnH0Ok/XSNvKFcF6hg8eK0VV4S2Yeopazru20U0tPHif79SUP
	gFMIgpE2u6FyWjG9IiPfw1mEv4CsvfbDlfyJzpbPhBEfNUeVyB6cS4LIO2WgcwuM2vfrtArj+RC
	+XU41Ee0CHc+Zrw8G9186EY3aryolDROm9ov0t5oeZyi8z8g==
X-Google-Smtp-Source: AGHT+IEz8p+tFNJnTJAhQQScZoJY+sH3uvVK72oBqnzM8X6KhvfUF5nP+pr2GIaJYiy7B/7uXyXX7pBBZ2ENwyrmANs=
X-Received: by 2002:a17:906:eeca:b0:ad8:81c2:64e9 with SMTP id
 a640c23a62f3a-adfad2a07b5mr651709966b.8.1750072127114; Mon, 16 Jun 2025
 04:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <20250615222258.117771-8-l.rubusch@gmail.com>
In-Reply-To: <20250615222258.117771-8-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jun 2025 14:08:09 +0300
X-Gm-Features: AX0GCFtlQPJwcTKd1ML23MY1QxOMtHi0_mPvh8ufiv3vMb0aJy3rsFJx0j2yEc0
Message-ID: <CAHp75VfETJwOAxmBQ+o7G7wwP3dWyrG_4nteAqAwv9f=SX41=g@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iio: accel: adxl313: add AC coupled
 activity/inactivity events
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:23=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.com=
> wrote:
>
> Introduce AC-coupled activity and inactivity as MAG_ADAPTIVE events.
> This adds a new set of threshold and duration configuration options,
> ensures proper handling of event disabling, and extends the use of the
> link bit to support complementary event configurations.
>
> For example, either ACTIVITY or ACTIVITY_AC can be enabled, but only the
> most recently set configuration will remain active. Disabling ACTIVITY
> will have no effect if ACTIVITY_AC is currently enabled, as the event
> types must match (i.e., ACTIVITY_AC must be explicitly disabled). When
> either INACTIVITY or INACTIVITY_AC is enabled alongside an activity
> event, the link bit is set.
>
> With the link bit and auto-sleep enabled, activity and inactivity events
> represent changes in the sensor's power-saving state and are only
> triggered upon actual state transitions. Since AC coupling uses separate
> bits for activity and inactivity, each can be configured independently.
> For instance, ACTIVITY can be linked with INACTIVITY_AC.
>
> If one of the linked events is disabled, the link bit is cleared. In
> that case, the remaining event will no longer reflect a state transition
> but will instead trigger based on periodic inactivity or whenever the
> activity threshold is exceeded.

...

> +/**
> + * adxl313_is_act_inact_ac() - Check if AC coupling is enabled.
> + * @data: The device data.
> + * @type: The activity or inactivity type.
> + *
> + * Provide a type of activity or inactivity, combined with either AC cou=
pling
> + * set, or default to DC coupling. This function verifies, if the combin=
ation is

Comma is not needed before "if".

> + * currently enabled or not.
> + *
> + * Return: if the provided activity type has AC coupling enabled or a ne=
gative
> + * error value.
> + */

...

>  static int adxl313_is_act_inact_en(struct adxl313_data *data,
>                                    enum adxl313_activity_type type)
>  {
>         unsigned int axis_ctrl;
>         unsigned int regval;
> -       int axis_en, ret;
> +       bool axis_en, int_en;

Why is axis_en not bool to begin with?

> +       int ret;

> +       int_en =3D adxl313_act_int_reg[type] & regval;
> +       if (!int_en)
> +               return false;
> +
> +       /* Check if configured coupling matches provided type */
> +       return adxl313_is_act_inact_ac(data, type);
>  }

...

> +       act_en =3D act_en || act_ac_en;

Why is this done here and not after inact_*en checks?

>         inact_en =3D adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
>         if (inact_en < 0)
>                 return inact_en;
>
> +       inact_ac_en =3D adxl313_is_act_inact_en(data, ADXL313_INACTIVITY_=
AC);
> +       if (inact_ac_en < 0)
> +               return inact_ac_en;

...somewhere here?

> +       inact_en =3D inact_en || inact_ac_en;
> +
>         en =3D en && act_en && inact_en;

...

> +               /* When turning off, check if the correct coupling event =
was
> +                * specified, this can be misused, e.g.: Having AC-couple=
d
> +                * activity turned on, and in current call trying to turn=
ing off
> +                * a DC-coupled activity shall be caught here.
> +                */

/*
 * Wrong multi-line
 * style. Use this example.
 */

Also, please rephrase a bit or split to more sentences as it's harder
to understand now what you meant. Also this doesn't clearly explain
the ' < 0 --> return 0' cases.

> +               if (adxl313_is_act_inact_ac(data, type) <=3D 0)
> +                       return 0;

--=20
With Best Regards,
Andy Shevchenko

