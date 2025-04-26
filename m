Return-Path: <linux-iio+bounces-18718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796AA9DDB8
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 01:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0E67B30A9
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518FE1FCFEC;
	Sat, 26 Apr 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLCJL0P6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41407494;
	Sat, 26 Apr 2025 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745708486; cv=none; b=RbaVolO46GcG/JxUtRJ2EoDF5gK6nnOc8z6IrY4jJTNq5aX6M8nK7A4HAW4+5lyBEarDL1mvmpPLUG4/kScAWymF5VJohCUps/DE4ipBOnIn0HmPejpiBPmEgyZNuP1NZSO0vdmo0/LpeM0Nw2Irf/ybqkXqNeq74f4f/Y+5VvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745708486; c=relaxed/simple;
	bh=3KjCpYh+eHD0Q2Q4JHtcq4uyZZmov/9v378xW+9l0OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avCHTLMOAm0CMxp5vorTfErFfv4hX2lHM461JN2ZpOfvcb7stJJ2nQz54XrWTT0kVzUN75Q9aadMoOhMYHmu/yc5/4xbTRPeGkuhpbcL+ZzO2BuTIpsQxt/vQmzxWFE62y64y9SAeTHsiPksc7INdlQI51IP1gQZncPFOzlLogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLCJL0P6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so3037643b3a.3;
        Sat, 26 Apr 2025 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745708484; x=1746313284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DqD618T9wecbdh5UjMD8+tf3VJeXQ46pSVKEiwd4GOM=;
        b=XLCJL0P6CBNSbOcQYiP6TU4V/mb9X5qJyadYi7UyYCUy45/kKCqCI8WSx+ZrlYCxWq
         Y9xIpTsLFS6IUoA1mirYV90pYmVaEHV/gFFM2uAkdlCBu4c0Qcb/tBUy77U6Uun3yulL
         yILUm8J+thkKTXHBR8QtC66yUHB6lizPHmvvIAwFNXqqGaf4cPcNYCpFK1XGiY2Y03HA
         AThh2Q1CiQDU3geqsAR/LvQLKLoeUfO1BPaa4cRafTRRZw9DeEUakL9bHa5Ff4CWMRG+
         hIbeEYSZwfWVUHOmYhPu0TmqGxqB/HVohdvA9ynJyrBb/V8JhzptWdWPvbwB4+qLg+Sv
         fj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745708484; x=1746313284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqD618T9wecbdh5UjMD8+tf3VJeXQ46pSVKEiwd4GOM=;
        b=IRtQFgugR30gfj+hWiQMXsUDB6XDtFK60XdqR6OiFfTUJsjgkMKEIyY2TFscep1/KY
         MDxleE1iseH84MPagkUYf89pm49/AWCxHft+lG6aWbRupWUfi4sWO17luzEw6Y3/4ocO
         eVWerZkbWXmdisoQP4GEb0VkQb7ot/geKX7FDkMLUH9nA58UVcFp8bdza4znc/mrr4Ut
         9gOUo5+92D10QD+4Ab25KrPBQ/alaWxjBkkoPVqoSCr8Z8lTp56GtD7/BT/WOFVcqwoO
         pCg5VcoQhju8MdzwhceG6cLBNDKdgjn54RR6/8T48B110SV7ohu88HBTJnnHPS5K/p7V
         SQTA==
X-Forwarded-Encrypted: i=1; AJvYcCW8jmbiMjbXhmVyzXoSE5pJo092F57GsRmP140E5qiJHdhSIkLrmHJFH4+F44cWj0xtxiyVws+r0R4=@vger.kernel.org, AJvYcCWtj7Qr5UOHljnI900dDESjDi6iNtuKrivQFebCYz84GE5zf/mNNT1b0AW8etahAHG3QFe7pVTlnh5bItVw@vger.kernel.org
X-Gm-Message-State: AOJu0YxDO1doIM5xYkFPX2qFqhETGLlXmnDH8e0F3eXuanpSU3z/2HGc
	bGyFRZXrXKzdezUp9D6ge6T69Clfs3ijFwFtJPqgZ1NDQTvqo5hi2d34eadQ
X-Gm-Gg: ASbGncsRE4dEkwOFzJahfM94YLlgrKiBr/6JIp6pWjQL6PRosEsMyvRVBqZ28UQJbHy
	slMU0TJ9WwMyTYXK+lF5Xg3hqHH+5EXLS8scZGQnEX5q6hbsYsuHjNzBvlLxgTGbMscRVM67YMC
	FtZ61nrIhgIw+EWJoA8eTQ7hzklWif2hhQLM1XM3d3zWSvbJV+YWZ9balUkUcFtAmIjZRexrKyt
	KLgMC45celrb/w66jO/LkUKsh9rfU3kLuXKvRjTI8io88gdugdtyYnDrbq+fg1bNu65EIkWiw/N
	8e7EBPaYeoiAHYPbSCJdBOn7ZB/TDbexZQV0fsnT57gSiFRqemrV4w==
X-Google-Smtp-Source: AGHT+IGo5uzGM708NgvnzG93kwpG+t0xhfzsjT+rgcw6F5rEP/F7Bklv9vt67hsmjtL4m4pJWvOiWQ==
X-Received: by 2002:a05:6a00:b4c:b0:736:34ff:be7 with SMTP id d2e1a72fcca58-73fd8b6bd7dmr8457343b3a.15.1745708483803;
        Sat, 26 Apr 2025 16:01:23 -0700 (PDT)
Received: from archlinux ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e2593f557sm5314226b3a.42.2025.04.26.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 16:01:23 -0700 (PDT)
Date: Sat, 26 Apr 2025 20:01:16 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: bmi270: add step counter watermark event
Message-ID: <mqt2iosg3j7ubrncq4figeqfuia4uwxad36gntr27houcvlqbn@srmed7zt4man>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
 <20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
 <CAHp75Vc30u=1jx3qNft-uOVCk49e4gTgyLf3+kgmUADQB56wEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc30u=1jx3qNft-uOVCk49e4gTgyLf3+kgmUADQB56wEA@mail.gmail.com>

On Fri, Apr 25, 2025 at 07:33:20AM +0300, Andy Shevchenko wrote:
> On Fri, Apr 25, 2025 at 3:15 AM Gustavo Silva <gustavograzs@gmail.com> wrote:
> >
> > Add support for generating events when the step counter reaches the
> > configurable watermark.
> 
> With the below being addressed,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>

Hi Andy,

Thanks for the review.

> ...
> 
> > +static int bmi270_write_event_config(struct iio_dev *indio_dev,
> > +                                    const struct iio_chan_spec *chan,
> > +                                    enum iio_event_type type,
> > +                                    enum iio_event_direction dir, bool state)
> > +{
> > +       struct bmi270_data *data = iio_priv(indio_dev);
> > +
> > +       switch (type) {
> > +       case IIO_EV_TYPE_CHANGE:
> > +               return bmi270_step_wtrmrk_en(data, state);
> > +       default:
> > +               return -EINVAL;
> > +       }
> 
> > +
> > +       return 0;
> 
> Dead code.
> 
Ack.

> > +}
> 
> ...
> 
> > +       switch (type) {
> > +       case IIO_EV_TYPE_CHANGE:
> 
> > +               if (!in_range(val, 0, 20461))
> 
> I prefer that + 1 to be separated and the value defined.
> 
> (0, _FOO + 1)
> 
Ack.

> > +                       return -EINVAL;
> 
> > +               raw = val / 20;
> 
> Needs a comment.  Is this in the Datasheet? Then reference to the
> section / table / formula would be nice to have.
> 
According to the datasheet, there's a factor of 20 to the step counter
watermark level.
I'll add a comment referencing that section of the datasheet in v2.

> > +               return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
> > +                                                BMI270_STEP_SC26_WTRMRK_MSK,
> > +                                                FIELD_PREP(BMI270_STEP_SC26_WTRMRK_MSK,
> > +                                                           raw));
> > +       default:
> > +               return -EINVAL;
> > +       }
> 
> ...
> 
> > +               raw = FIELD_GET(BMI270_STEP_SC26_WTRMRK_MSK, reg_val);
> > +               *val = raw * 20;
> 
> Same.
> 
Ack.

> > +               return IIO_VAL_INT;
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

