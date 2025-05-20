Return-Path: <linux-iio+bounces-19746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4243BABE4AE
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565A01BA15D8
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831C289E13;
	Tue, 20 May 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR20Gck2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BF21C9FE;
	Tue, 20 May 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772743; cv=none; b=e3K2ARikR1IM/jspDoGnCWBVTgaM69C9FDjmZG57Ndb5PgHg9G3yyk1rXJyy+h51fFGsZgZFpL0qrgiiYfnK2/LIoX3rLhSPzqeunwkUP2Uss7HCZSJpsENBqSPL56T/eK4DGKrFq70ze5EKKd5D1opVMEr3lNz2+LqX5lCzVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772743; c=relaxed/simple;
	bh=odfqx0apwbgiqnayUHIIYSQn2+iIc7TxKxOT0NeLYPQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XViVeDloonIx0NMxzr0Aab8ztYNotJWhTc3MDvQyhRUKTL6WFN8IsiQZIDH07VPgQuFtiyXhNua+p3KuPpluQYTj1m8WvgRR6FqAAOxBrP7PMgqRQ5t0FSEOr5AW9nNb7uEabfynft21H0wrZ0N7fsetHkFviMmgRsf9q1GH6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR20Gck2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7911963392so666851276.1;
        Tue, 20 May 2025 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747772739; x=1748377539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSqq+sB9BjMwB3r2uahAlzETHFM0L2RnWbh8LKDgqGI=;
        b=IR20Gck2c8/vXWZj7Kvx20PAQ36Af7kY7Q+xNh1wbjJzwD00bf+DJkupNFn5CYcb22
         1RulM19Fa326N+J+LgVak9oH+nZ+Pnu32lNWvNtkIGvprTbRofO5kRcLSAZ1MZg+JMO2
         MVBccJ1j/+G3B15oWUE8LP4hGZmWn8j253UXbBRWBrp7BzCInsXsFzbjJLg79JFfB5W7
         PaPuEjHhgIMrFnquonm1Z0wupqjwqVxTP7akJwecG8Dn5etf1Ek4Ep/CepFfS0QWVJyo
         Md7bi8DJSTeHJkQWV5qRE8sV6PAA6wWR2YXoHRKE572+i2SU2uX3AvjY+GkL9YuDFkjP
         Wwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747772739; x=1748377539;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSqq+sB9BjMwB3r2uahAlzETHFM0L2RnWbh8LKDgqGI=;
        b=need5PwrFvE5wm8p1XS8/oNaBMiH+JkuqXXnQqrtYzJVDuNuail0qznAhS5YKeO7oZ
         s6iiz+1lN7eIYEAb/5+PGctgzLSbgMd2gkPWyIvs9tw1CjIQFwf098dKwVx+gZkWc5DZ
         VySxuz8aqtJCB2JsLYRuBWmal/5ahugrnImx1VMD7Vzm5+G2m2RcjHs32bLMOkjMOxAN
         RUvkdxBE9aLvoBGBHeyo+hsUsluF8e7DIn2DkA3CgkcwDMwWs4GOA+1WoYqqqVnwd2al
         1v6e6nMBrVIIjakXGfrAVTrk28EMpLF4Hu9JsKxrlIXRvPda6JIZRDMDSrpumBp8TRG0
         oJmA==
X-Forwarded-Encrypted: i=1; AJvYcCUwlgayZzTob0BjK+UV3oJXK6AMGU3clHf0EPJu1jmvX54O4U+jlBctx4eYqpFaxAxuxi6Ozdnv2sE=@vger.kernel.org, AJvYcCW2R0wDBeFX8eR/xyPpyvshpMnRfHe3FswAlJSK30DFrj6ltpuNUFQLyVanbHJN/mROxDzFNprQNWeO9Vdb@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3x71diMKF8H29bZ6cYEreYaRh25zBr+7m4Ws+1BTbz2KIwyg
	976Y/vCJXSYHYLjLRpSUAiJUEESOLklDq9LQjyCBGSMw+zE/UM/u8EgArzdiIHClUdXCO8RCY64
	Zl2uJt8AlGTSbsKdpGGWTt6zyPgDMnIg=
X-Gm-Gg: ASbGnctOhSXBHCWxyzX29WhCH7aOGGvcw2ej+pIaOu4k05Jj7VHKj2p6IlJxV5Vp+zR
	SpqGq/ImpjxalZBSYdozypokuYnLkbszqtQDJrIuJb0ypJAORt2SNctxVIKP/vmGdLMhMF5V6zz
	v+u/eVS3ZhFxBlWA8bQA8PRoV7HYhfDIx1
X-Google-Smtp-Source: AGHT+IHvOgeEY+JUkC+eU1nJioYHSB5tXx0piSJfp/MBEd/c2bOa7+brErDTJlctiHq1TvWOEEJnm9G4I+Q4KeIfP2I=
X-Received: by 2002:a05:690c:6f85:b0:70b:76f1:a402 with SMTP id
 00721157ae682-70ca7bbb472mr129328947b3.6.1747772739386; Tue, 20 May 2025
 13:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 20 May 2025 22:25:03 +0200
X-Gm-Features: AX0GCFtNZEF5ddL1fPWSAGaUeUBUwvNx3zv-vNdKoZSSTXlhXX3rqlhoK73rjKY
Message-ID: <CAFXKEHavquk_oyhMpkawkKUwnfNA_eFWH5XYFsZQkM1_-Rh6Vg@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] iio: accel: adxl313: add activity sensing
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, Lothar Rubusch <l.rubusch@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy, also here I copied from the MARC mailing list.. some questions below.

> List:       linux-iio
> Subject:    Re: [PATCH v1 09/12] iio: accel: adxl313: add activity sensing
> From:       Andy Shevchenko <andy () kernel ! org>
> Date:       2025-05-19 12:15:17
> Message-ID: aCsg1XddkT6sGjev () smile ! fi ! intel ! com
> [Download RAW message or body]
>
> On Sun, May 18, 2025 at 11:13:18AM +0000, Lothar Rubusch wrote:
> > Add possibilities to set a threshold for activity sensing. Extend the
> > interrupt handler to process activity interrupts. Provide functions to set
> > the activity threshold and to enable/disable activity sensing. Further add
> > a fake channel for having x, y and z axis anded on the iio channel.
> >
> > This is a preparatory patch. Some of the definitions and functions are
> > supposed to be extended for inactivity later on.
>
> ...
>
> > +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> > +                              enum adxl313_activity_type type,
> > +                              bool *en)
> > +{
> > +   unsigned int axis_ctrl;
> > +   unsigned int regval;
> > +   int ret;
>
> > +   *en = false;
>
> Even in case of an error? The rule of thumb is to avoid assigning output when
> we know that the error will be returned to the caller.
>
> > +   ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
> > +   if (ret)
> > +           return ret;
>
> > +   if (type == ADXL313_ACTIVITY)
> > +           *en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> > +
> > +   if (*en) {
>
> This doesn't need to re-write the value of *en. Just declare local boolean
> temporary variable and use it and only assign it on success.
>
> > +           ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
> > +           if (ret)
> > +                   return ret;
> > +
> > +           *en = adxl313_act_int_reg[type] & regval;
> > +   }
> > +
> > +   return 0;
> > +}
>
> ...
>
> > +static int adxl313_set_act_inact_en(struct adxl313_data *data,
> > +                               enum adxl313_activity_type type,
> > +                               bool cmd_en)
> > +{
> > +   unsigned int axis_ctrl = 0;
> > +   unsigned int threshold;
> > +   bool en;
> > +   int ret;
> > +
> > +   if (type == ADXL313_ACTIVITY)
> > +           axis_ctrl = ADXL313_ACT_XYZ_EN;
> > +
> > +   ret = regmap_update_bits(data->regmap,
> > +                            ADXL313_REG_ACT_INACT_CTL,
> > +                            axis_ctrl,
> > +                            cmd_en ? 0xff : 0x00);
> > +   if (ret)
> > +           return ret;
> > +
> > +   ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
> > +   if (ret)
> > +           return ret;
>
> > +   en = false;
>
> Instead...
>
> > +   if (type == ADXL313_ACTIVITY)
> > +           en = cmd_en && threshold;
>
>       else
>               en = false;
>
> > +   return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> > +                             adxl313_act_int_reg[type],
> > +                             en ? adxl313_act_int_reg[type] : 0);
> > +}
>
> ...

The above is a good example for the following. From time to time, I
face the situation in a
function where I'd like to end up with something like

    if (foo = A) {
        var = thenDoA();
    } else {
        var = thenDoB();
    }
    doSomething(var);

In a first patch I'll introduce only the following and remark in the
commit message, that this will be extended. Since smatch/sparse tool
will complain, I'll need to fiddle around with initializations
(becoming obsolete in the end), e.g. I'll end up with something like
this in a first patch A:

    var = nonsense;
    if (foo = A) {
        var = thenDoA();
    }
    doSomething(var);

This is the case for switch(type) case IIO_...MAG: as only type (for
now). This is the case for this is_act_inact_enabled(),
set_act_inact(), etc.

I assume it's better to simplify each commit individually and don't
leave the "churn" around which might make sense in combination with a
follow patch? Is this a general approach I should follow?

Or, can it be legitimate to just split an if/else and add if-clause in
a patch A and the else clause in the other patch B, since both are
probably actually not complex. Such that patch A for itself looks a
bit odd, but will make sense together with patch B?


> > +static int adxl313_read_event_config(struct iio_dev *indio_dev,
> > +                                const struct iio_chan_spec *chan,
> > +                                enum iio_event_type type,
> > +                                enum iio_event_direction dir)
> > +{
> > +   struct adxl313_data *data = iio_priv(indio_dev);
>
> > +   bool int_en;
>
> Why? You return the int here... I would expect rather to see unsigned int...
>
> > +   int ret;
> > +
> > +   switch (type) {
> > +   case IIO_EV_TYPE_MAG:
> > +           switch (dir) {
> > +           case IIO_EV_DIR_RISING:
> > +                   ret = adxl313_is_act_inact_en(data,
> > +                                                 ADXL313_ACTIVITY,
> > +                                                 &int_en);
> > +                   if (ret)
> > +                           return ret;
> > +                   return int_en;
>
> ...or even simply
>
>                       return adx1313...(...);
>
> > +           default:
> > +                   return -EINVAL;
> > +           }
> > +   default:
> > +           return -EINVAL;
> > +   }
> > +}
>
> ...

This one here is interesting, to my understanding I followed here e.g.
the approach of the ADXL380 which is supposed to be a quite recent
driver [the _read/write_event_config() there.]

Now, your remark made me think: I'm unsure, can I actually I implement
the following approach here?
- return >0 : true
- return =0 : false
- return <0 : error

It seems to work (unsure about the  error cases, though), but much
cleaner and simpler! I'll send
that in v2, pls let me know if I missunderstood you.

[...]
>
> --
> With Best Regards,
> Andy Shevchenko

Best,
L

