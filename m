Return-Path: <linux-iio+bounces-22668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F2EB24B70
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D89116C311
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97022EAD0D;
	Wed, 13 Aug 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4dT1gMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3E2EAB93;
	Wed, 13 Aug 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093445; cv=none; b=q6h0uVFjKlvEkVNfAzVwf3hxRMaiSETtfWBWC0gfJD0sj3hVJTV9ApddqcI3Ftno1sbfqarNurXrgLko23z3uSqoEQUtR5C91sA4KNjJzwxJl/blIHmLvWV5bzp9U1b3phLTbhUaP4eWIvay9b4zmx5WfIfLKlRiFKhRhpkZLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093445; c=relaxed/simple;
	bh=m6ExRnpHShyIYOeJg8BNk6Zgj4kKhO7CklioMmPqjc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=purIAzo6gMUxCl8TiHeUmQVDaLO/nP0GeOi03c82s25N6i9Tpm42WiNYf4dgEiykbp02w0E8OmB6M/cy2vQ/OCXc85VAPJ0WW5/DPMv+lEZPMC/Ta625NGtZLsEozs7xT9Z6601fN2tIxnL8st440mBRfV0NAKaEvDshD1uKAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4dT1gMW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b975b459aso5791287e87.3;
        Wed, 13 Aug 2025 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093442; x=1755698242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx/mbNPuKPuEGK23CHmWyt4whnvAbRyq8panIaj6BBY=;
        b=C4dT1gMWJPwC8rE3ABnftyoo/XepwYXNNJbRG36vNgw7uD3IGPCtMifZTmfqbuiUFS
         7VhsNYPSnFsOM5PIs3jFyNEtomjmyuKi+bcQNkzRtu/okiwsqwrhT5OX5qg8Vy87Zgmp
         GhloUAXhbNpJF0+wW5vfnXYzwAmYUGXv6ajiDAelJFMVC6xgKyMHvgmorh2nr+TWh8t9
         gZNo5vkWHgAGb75BcBXDr/CHHXLPm6A5grz3PvT6emvtzloI83h2K3G8ZVrG2DQGw6Ts
         rVaUY2xmXV8vU1aCFV/TViarZbhnRrH3XGebTyBJAH9zGqF7sTvVqcrN3zfir2HssZXA
         yITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093442; x=1755698242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx/mbNPuKPuEGK23CHmWyt4whnvAbRyq8panIaj6BBY=;
        b=k/IzY+77UPnNOMOxuiErTGpo3YLd9zLD0ss2kvoJtN/ToENjme4xHSNzL9y6VZRLkm
         fQeVF/b1FeIAIB8LEiYrtevqtZTNwG/RduPT36+POyzT9a9bDm7uh6jp5TPtYvBTChRH
         +CXC128O1GTlR0lxO+hd4nuaEiwAsI6+p0r78NlVLpuuVPD1lYWXSNz3K1luNFI5UHJy
         UdfaUWA5PE40CyT1GexzPlPEempCv36hawpNah8aYZUb53t8m2LbhKvCAfT6huQplvV8
         qJ+GQw0Gr1lw/cYhxfLgr59i07inXIWbDCZIS4k/7FnZBL5ePMcUV36jZzTxI8+x0DkM
         pnUg==
X-Forwarded-Encrypted: i=1; AJvYcCVqDVAvQpts6lb4NSkoLpj0Ql8QFe69kwsvMmrxWqDC1/ZnHBQRh00SHex348NumT98lqV+YfpWHtU=@vger.kernel.org, AJvYcCXrBJ0B0jQAVq6iZRiOcsSyUph0astd5YNb++AXjISwxAQRuiP5gaUeQRwlEDmjIKcZjnkNbhg/dSwljwf7@vger.kernel.org
X-Gm-Message-State: AOJu0YysyXgXEMEGi2YBLmE74UeWCKLWwtZL2q7ugemkehjIfJMK5+MA
	LPeSIitP3JZeXdre5e9mWC3MiNJctJhUHHXcRo4fBwXv515iU5oFNqaRN8PBXdXI6rmH8QntZjq
	Pidf93kmQ8+XoXS06M5SWA473w7+ws9Y=
X-Gm-Gg: ASbGncuw10BOHaKPOPbKTd/O8bwGf0Xseem1oWxUQrNrIgohH/Wwo0vCI675iaxf7cr
	7m7BYJxRNbjgsHoxvUbDctL7AJPc1mazQgPVuJMMR9wNprJINZ5TP2FrHlgaqSsLvmh+eqfIh3r
	qWeeafzjuRjmxb6bN7eCCTyXbsIMrNoQsPElE46hUQDSLW2z/TExdFpg+3pEeH+sIjVuDhv5HLX
	KEfOJlN
X-Google-Smtp-Source: AGHT+IHw9EZIgDXwmtIotLZ+/JggBWw2i7AMZDQNX0Yog0kIZcsVUe7kSZrlMwy6KSdhfID1dE5tdW/xUXNvysrPHBo=
X-Received: by 2002:a05:6512:1326:b0:55b:7cb7:f57c with SMTP id
 2adb3069b0e04-55ce0414bb6mr938955e87.57.1755093441686; Wed, 13 Aug 2025
 06:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813133017.72476-1-akshayaj.lkd@gmail.com> <aJyYJLMUYAm_uqUx@smile.fi.intel.com>
In-Reply-To: <aJyYJLMUYAm_uqUx@smile.fi.intel.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 13 Aug 2025 19:27:09 +0530
X-Gm-Features: Ac12FXyeUZ_yE6whQbBHAPCt9k9OozSgklnU7idmXRC4x8c0DcaGwLh-BiCfhJ8
Message-ID: <CAE3SzaSNV4DMUQB5rQQSV+QsCS6Z2BjFkFD3eaXO9J=TjUbNYw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Add device powerdown functionality
 via devm api
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Aug 13, 2025 at 07:00:14PM +0530, Akshay Jindal wrote:
> > Use devm_add_action_or_reset() to do cleanup when the device is removed=
.
>
> > Set client data with i2c_set_clientdata().
>
> This is not used anymore, correct?
>
> ...
>
> > -     data =3D iio_priv(indio_dev);
> > +     i2c_set_clientdata(client, indio_dev);
> >
> > +     data =3D iio_priv(indio_dev);
> >       data->regmap =3D devm_regmap_init_i2c(client, &ltr390_regmap_conf=
ig);
> >       if (IS_ERR(data->regmap))
> >               return dev_err_probe(dev, PTR_ERR(data->regmap),
>
> So this hunk needs to be removed from the patch.
I thought so, but removing i2c_set_clientdata would mean that
dev->driver_data will NOT contain a pointer to indio_dev.
Irrespective of usage, ideally dev->driver_data should contain legit value.
Hence I kept it.
If you feel otherwise, I can remove it, but I feel this should be kept.

Thanks,
Akshay

