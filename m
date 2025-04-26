Return-Path: <linux-iio+bounces-18719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527DA9DDB9
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 01:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DDC4641F3
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 23:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA017A2F0;
	Sat, 26 Apr 2025 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7p2cZjY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4CB1FE455;
	Sat, 26 Apr 2025 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745708770; cv=none; b=FFmtELgL9eMKFKi3LIRR2R7CPU7e/JSxT/3ZgLyu373ss1snTUAt4Lc+2mM6EU9IkpuftD47PX/ilw5XPndIcDxMSO12ky40QsNp4Zr8FxxAY9fCJ+NPseGqXZ1VdW5dLa1AgXROZihbFU2dLo2lJ5gvpU6RDJ0iP76AHaXluFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745708770; c=relaxed/simple;
	bh=m+RA8gzsvOfscFAGRmCDVeYxN0tmD5osbA5ye6MRq48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS9IuRe3grLe++AyRBz2NWis85rhkc++gZh5IytjW9JICHYC6g4+MQcw3J2cSqfhFggq5PQZpUcn+2TXnjJ9dLB51cNkI+yOgVAsj2OXSuBBfROvnpRF8nYNtOM5qGXe39L3oh0NvFTO9S8ipDRpiuP6rkHxzg7DqZYQxCm033Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7p2cZjY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33e5013aso43295245ad.0;
        Sat, 26 Apr 2025 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745708768; x=1746313568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+laHSLvAxUEnN7XoD7+RpZEC9zqXbmDcxTDzKjoExLM=;
        b=K7p2cZjYYf2Fq1tgLUMV0oa0j8xRn+1z+qHrPVABO7514o3TTIOppwqMoshf2fKnp2
         COwFgm5VJKgdD39miVEKXjvnyZc/DV7fhFmIVRbMAebi6p0eE0A1OHmKFv19cIKpkKE+
         BNsJoTLOyEt10WTZxoyWsQ9lFxd0lpVzoXlZsNjMkxEnO9tkKt65BJCCnOLmKr+nilgt
         3BQyf4ZqyMerqkTZVWBN4+Dunme/sfAy1lW33uMuOaTMxINuqKaNsAqqBN3bgVmAS3aR
         M18AdlHx/f/fG/Ouh/+3Fv4pIxW2f/CUsmIsrOEZ9D3aqAWfbOXafDn4CxMNQdf7RhK5
         f8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745708768; x=1746313568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+laHSLvAxUEnN7XoD7+RpZEC9zqXbmDcxTDzKjoExLM=;
        b=ZQN4weR4S0oVqoBS/V+kocc2FEWlWC+oyUAYqRMjKvpWSwGJHJylfWXjLjXdBkPMLK
         arpqT2eI58H0fEoMeFo1nNiGzCJmFdGbe1HycQc2f7HQesgcF/j3hOVWpFrv584/libJ
         gHzSMEg1fz7ZpGuOF3tc2P07lUKQX/aYAowN4PnZsmu0yi6v/sx1Wlx5RgEYmVh9HWvN
         4n5XbivhzH7A92xC42QLKx5qTiOi25VOBDMRIPaKS7/9EZycca9dI8QLkshuV8BXtoeo
         P7UIxI1GIf1MiWXDtvKNpDM4GTJl1Cn1g+lbuXsnZZUuXIpQqAcXySTPXCi1sG2pgeFw
         WLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLiKkXaAcpaLD9b4LmNQXRqGK9oRgcUqB1pUrT6iqDlc9i8y5L6aEzw3mCJnoVCILDMks+HeoV/QY=@vger.kernel.org, AJvYcCXQ+Qu5rwYG2JldeQxf24uYH3f7ovFtiqrJL/aBOHZNkifYOCObGI+CSXT47rViclg4lLfE5tdHvE0KtVc5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YTEOV+RxW6G46wqDd+laqd8vA7SvbNrVWB3y2lEzM18XL8x1
	EKTpHXrBqu7rQ+DYZ670qnNBlKBICc4h5yttjY2GbLRw/LAyrzlE
X-Gm-Gg: ASbGnctdYeQ5f3tz4wQynUnsKLlrAwxDkau0Ruj/KcqVIAnbSRE8R5GSihyyRh6qhTw
	pqE2/k5TDzmcZGH9FOAugy/XCVytJfvYWnkwh3Qte1Fzw9diC5Jj9yPBZCXmFL+dNWe1me6SNXf
	qSa5Zf607kgtWV3VYI+xqTH/viu4AZyZkN4QACDCugJF+eG5HmTPMQcpVSGOokqGv6U8FkN8wu4
	ZhWnZFniNP8lxOQgn9BRLncKm5HauGsSP0LZLoQFuk1/XJJR3LWYSBTnMEt71OXR5XqTqYJFS+P
	LpSS8nx8U8w9AODayFPRVGSBm4KAbWV1F8l1tFX6DHVLdT55x2YlGQ==
X-Google-Smtp-Source: AGHT+IGbeJRcVif92g/Ta6VxscgASXIih4Sizr4bZSGbCaReYMuG4jR90AjMjeCNxKbvry9EDkGePw==
X-Received: by 2002:a17:903:41c9:b0:223:f9a4:3fa8 with SMTP id d9443c01a7336-22dc6a040dcmr59753305ad.19.1745708768435;
        Sat, 26 Apr 2025 16:06:08 -0700 (PDT)
Received: from archlinux ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51028basm55143605ad.196.2025.04.26.16.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 16:06:08 -0700 (PDT)
Date: Sat, 26 Apr 2025 20:06:01 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <tksgr4m2bl2pppeyhoqobwtqes5kgjueo6yflps6ib3au2itpv@nh3i5yvvn53u>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
 <20250424-bmi270-events-v1-3-a6c722673e5f@gmail.com>
 <CAHp75VcxoyoHYkSJw_OudEs7kAsaan9urhPofZQXyOyOVdBWuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcxoyoHYkSJw_OudEs7kAsaan9urhPofZQXyOyOVdBWuQ@mail.gmail.com>

On Fri, Apr 25, 2025 at 08:25:00AM +0300, Andy Shevchenko wrote:
> On Fri, Apr 25, 2025 at 3:15 AM Gustavo Silva <gustavograzs@gmail.com> wrote:
> >
> > Add support for any-motion/no-motion events based on acceleration slope
> > on each axis. Threshold and duration can be configured from userspace.
> 
> I'm wondering if you are using --histogram diff algo when preparing
> the patches. If not, please do so for the next version.
> 
Yeah, I am indeed using the histogram algorithm.

> ...
> 
> > +       irq_reg = bmi270_int_map_reg(data->irq_pin);
> > +       if (irq_reg < 0)
> > +               return -EINVAL;
> 
> Why is the error code shadowed?
> 
I might have forgotten to update this line. Will fix it in v2.

> ...
> 
> > +               case IIO_EV_INFO_PERIOD:
> > +                       if (!in_range(val, 0, 163))
> 
> 162 + 1
> 
Ack.

> > +                               return -EINVAL;
> > +
> > +                       raw = BMI270_INT_MICRO_TO_RAW(val, val2,
> > +                                                     BMI270_MOTION_DURAT_SCALE);
> > +
> > +                       return bmi270_update_feature_reg(data, reg,
> > +                               BMI270_FEAT_MOTION_DURATION_MSK,
> > +                               FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MSK,
> > +                                          raw));
> 
> ...
> 
> > +       case IIO_EV_TYPE_MAG:
> > +               reg = bmi270_motion_config_reg(dir);
> > +               if (reg < 0)
> > +                       return -EINVAL;
> 
> Shadowed error code, why?
> 

Same as above. Will fix in v2.

> -- 
> With Best Regards,
> Andy Shevchenko

