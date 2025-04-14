Return-Path: <linux-iio+bounces-18084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDA6A885F6
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4861940089
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B28A274650;
	Mon, 14 Apr 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHLcmgjN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D772DFA53;
	Mon, 14 Apr 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641073; cv=none; b=W8jDUMs5QXgMgmHma0a+5Uvhse3a3DNDYjnR7a9VRau0LJGRfmM900vZd9LtHw7awuAtsC9fNdtFFmoVkSDuvjN0f82ipjwNZyZPGdOaIf/cfa6PU7euTXtSy9TC98X6/x8w4Bk/th7V3aEWPq0RLQxpO991S+RUpRKWMzxjwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641073; c=relaxed/simple;
	bh=yIcJvnTptscJjpkr9x3k7c3iyRNfLlqyxEVAgXj4nQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOhqiqXw6aLqFhH6H5FV41NI8vK6Y4hgyUbikRfavzJ8YBnPaowuykdYX+lKXvMvBHHtupb6W8QwlEtI70ZUHKXyys2PQPMEFZP2R8DLu3htM1yDF4qcJNyg4atqLlL1aKBQURIWZVZxNfvLNZ6F6wA9oUiAxoWlaRbGQoyvgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHLcmgjN; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e638269b1deso519380276.3;
        Mon, 14 Apr 2025 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744641071; x=1745245871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk43/7PYX5zGyHo+8Azq9MrRSbWSna8DaWT5qYwPs9w=;
        b=nHLcmgjN5JUPmMt+h/hjaqa7ksfZsvz2zt+TELQvgdOpXO6VP+wGTvzuFSOS+DhBMp
         zooVYldsI9gzYjHifuA72d+2P3mbAvUwu8FPIF3t3M62ph6x7zRSAWMwaT2i2qPqGLoK
         O/dm07LtFnIb7H9yb72izo9ibL/xi6hC9T7+bf7IDS84yxH3mAhXGq2Nf08AJkX0C7Dy
         /gXW+GzIPjDBRYuKY+YVZWp/tHRZBfTCuB1wOUUL/0tLtdU19PLlmRrbbo1X6lihecSQ
         Vj6fC1pxaK09v9vpicDXD/SJmg7lm1bq48E7NC/YUU9HkzBuXiP1858Z4tskSH7gzrMU
         CO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744641071; x=1745245871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jk43/7PYX5zGyHo+8Azq9MrRSbWSna8DaWT5qYwPs9w=;
        b=pV3icrCI/+sp+HCbhQUu+jeOdFEAL4NX+/HhcnSbcznTNc7nXYDJ3LOJ5mwWsE9Dii
         OWSeZ8VooZsoYtuDccwvncNfJqnYcihiQjBYl0GhnzbxDTYZEOX8xgZnTfnppCA0RN97
         30BbgYKRLOls1ELTSp8AvFsGsA/iqUG0X3mv1wAX4rHKZIR/2tNImrrvyhtWAFAyazaK
         mqFv+8FYSadHsxhNMlI/A2l7KLP9PON+GPfcUXgaNeGilcz8pkyektHwYruthsX4S12K
         yOnkKqEvj4ZrST9Z5GI9qriVPcZWOatIsC0y5VAHIBT0q00KXYzTFJEtTMLfvrf+zyc8
         I08g==
X-Forwarded-Encrypted: i=1; AJvYcCUFnyz6pUdL4lU5mrPt1PGzxuNY4szQxt/fDGdAWwW0K+sMbbrFIA8wGnS+QHMx/eW9eRTkV0kzhgCQfWbK@vger.kernel.org, AJvYcCW0JYSS5q2crLbDjse1KNiYsjyf6noJ4HeyBuEyq/C4khyRRhDZu7gt7QYMEWSi3oBv4OYyu2tqGjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YMMiArEdLJJZ68WtF/V1sjLxSGPpJPXUPTg7Kivwbrodan2i
	sDXY8PkiBaVZAN1EpmPTGI9vFSCICNL/kCwjawQzFu/WDGZgG7YsMfjkgmaB+bOKFDQksyjHdIl
	VB+UIJq7DEM/SVoMow+5H1lbb91XDNW9J
X-Gm-Gg: ASbGncuaatp0M9/WNIIYvPxZRjcQNLhGhY2hkrBnga15WRLH4sn63Zy4NRsmyRjmiK7
	8/7EEI1h7Yzs3h0FwXq/jJHAti5mS5EStUknzZcW6PVh7iYoP1SdGB5BBy2K1OtCVQkA7Jp1olI
	iKre+XRklYiDSCvpR/tfRbEUa6L+SaKyqk
X-Google-Smtp-Source: AGHT+IGcL57gO/PCoW3qRcfjFE8xCZaDj7USONuvi1WJebEYrLw1kRMp0+d+u4evmaDEZLo7bz6ChyTDhP268VSfT0k=
X-Received: by 2002:a05:6902:248c:b0:e6b:7f6a:2169 with SMTP id
 3f1490d57ef6-e704de9c1ffmr8629617276.3.1744641070940; Mon, 14 Apr 2025
 07:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318230843.76068-1-l.rubusch@gmail.com> <20250318230843.76068-6-l.rubusch@gmail.com>
 <20250331112839.78c2bc71@jic23-huawei>
In-Reply-To: <20250331112839.78c2bc71@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 14 Apr 2025 16:30:35 +0200
X-Gm-Features: ATxdqUFag1tZrsm9IdAEgyHF7e_WW1c3GX7R9C38HDNQwLyqFNQKy9n-w0JdGns
Message-ID: <CAFXKEHZ6pozMTw_8hT9i7rp_OtPZMaFXEisW925oYgFFJeXv=Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] iio: accel: adxl345: add freefall feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 18 Mar 2025 23:08:37 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the freefall detection of the sensor together with a threshold and
> > time parameter. A freefall event is detected if the measuring signal
> > falls below the threshold.
> >
> > Introduce a freefall threshold stored in regmap cache, and a freefall
> > time, having the scaled time value stored as a member variable in the
> > state instance.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>
> Apologies for the slow review!  Just catching up after travel
> and I did it reverse order.
>
> > +
> > +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> > +{
> > +     unsigned int regval, ff_threshold;
> > +     const unsigned int freefall_mask =3D 0x02;
>
> Where did this mask come from?   Feels like it should be a define
> (just use ADXL345_INT_FREE_FALL probably)
> or if not that at lest use BIT(1) to make it clear it's a bit rather
> than the number 2.
>
> > +     bool en;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_thresh=
old);
> > +     if (ret)
> > +             return ret;
> > +
> > +     en =3D cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> > +
> > +     regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
> > +
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > +                               freefall_mask, regval);
> > +}
>

This raises for me a bit of a general question. I face this situation
quite often when using FIELD_GET() or, like here,
regmap_update_bits(). In general, when I need to apply a mask on a
value to be set or unset.

A fixed version of the above could be this:
 421         regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
 422
 423         return regmap_update_bits(st->regmap,
ADXL345_REG_INT_ENABLE,
 424                                   ADXL345_INT_FREE_FALL, regval);

Actually, (suppose we have uint8_t, and mask only masks a single bit),
I tend more and more to prefer 0xff over the particular bit, so...
421         regval =3D en ? 0xff : 0x00;

...and then apply the mask on it. Is there any opinion on using 0xff
or rather using the exact bit? Or, do you, Jonathan, care more about
one or the other?

Best,
L

