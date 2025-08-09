Return-Path: <linux-iio+bounces-22493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66908B1F4FB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 295FA4E103F
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFAB2BDC34;
	Sat,  9 Aug 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl0e39jD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67429E10D;
	Sat,  9 Aug 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750046; cv=none; b=uQrIXG9ir0jpJbve51qNdzDMJQn9SNTyU8pmQqrj659lJyxZMO8ywmrayUD6YrzxwI4ru4V8pI2DsyioDC1JEEzvuf2DHqRMDu6Q8miRgs8R+1h6/EDO2GVUpAaNndmxORwL5n36S4uA9ysfZhDP2oCvRRAi8A5x87V6Sw/7MKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750046; c=relaxed/simple;
	bh=1VmpB5Ibj4Yszy6afKomstQ8c+4Jfgpb5dWPq5qaHsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXJTzMwQu8TKJh+D1M80WHamfScUncOWvUSUr/iuW9wtrbzZX+0W3qgm0RouYX7UWIJgOnWXU/yu027WlWsngtKgQApNZpUkX6Joofk6hhUVyCpTENf8q3pQOUZImy0K0UMTQPWaLrztLHJL6eWZVVS/7ze19xah1KSHzHwMiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xl0e39jD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso2222850a12.3;
        Sat, 09 Aug 2025 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754750044; x=1755354844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qWFAQa6ghWNAVFp90dmhpeqTC8dkDj2Z0djww0iqfM=;
        b=Xl0e39jDp2ysUGJxRoMx0c+yrLc2KmBoSltcb1OYB25kq5PzpAFliwxbBSHgdJhkty
         hMiyGXsBv6t2k66U94PzPRXDN3jxWkNR4hl01qwLEZrsixI0MTc7L9NZgqSKUPM2OoSU
         DiBCdj0765tVkRusdkH/YRgkaunKSH+AeWWPAkZ32Ehx/jW8nzv2aPzG/0BrbvHy9xAP
         nNPeXf+retq4liLGsZC1gndztatb4S55rF4DCtluJcUawp3MJjThLJvLXUJDK+adCwRq
         8kmQmq3D/e0PRV+7GQtSkEcOeTWYbchKtXD7suTW+p97gS0zlhQGeCggOGn2D7bigSwz
         1yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754750044; x=1755354844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qWFAQa6ghWNAVFp90dmhpeqTC8dkDj2Z0djww0iqfM=;
        b=mL8c03FOgH7D7rX7KcNPULK+3N+PUGQaBCr+nGLKVW/pXuAQ5qMNRIgMRzWjLJOx+/
         afsFvLzSY1B/oEX+e7CDJ+hYkAxrzq9uPOzQZSrLjvwHORC2N4kwF+0QZeFxyzELSamy
         2edipNpwxzBfk2Lcj/WWXErry/64y8ydQszrpAwmDqla/2o/kTT8HPb7ZSVxlP1xt6Rn
         nxYSVrU94wZz8roo+naWiSMezp30X9S/3nXXkHG65QRsPS8sbIywAZ3iE+L3nWTjI0M2
         +rh6DrsWP6XK0B9ue0QTVvqKto6wKjyThp3A3dN/yVhs1Tw8tiM9/zcrX57J3ipRMQKq
         XIpg==
X-Forwarded-Encrypted: i=1; AJvYcCVA55PI7UjtKhGkDhTLz7AHrPAUZKIi/4jCmoPV3QHqSa1eyHjopBmEu0VS2tgCcgESFdKpGL3QahqPy5eo@vger.kernel.org, AJvYcCWk/WV6KjBCpMgFjDR9xKlFoVCMfPt2nP7vliXzDXPi+MvwXifwBNaErQRe4T/AccmQED5D5D7qDwMK@vger.kernel.org, AJvYcCXNIqNCMrzedgvLkMzS/5QQY0ZtjtSZmG8jc+PWEUBEaN+YtRSuQRgUMMZWGp7NmdwT4G52RBy3X9jQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzJdLehAbbVv0fmCrGVfSj85dmjQhxkpm6AmQ80m+yzhQpU1/
	e9jgUbfLbSd9tQ9CAJUJWxEaHZizOzFvk7zM8Y19yHIf3LKj2gPr1mga
X-Gm-Gg: ASbGncuGKI90Oas0PDRCqudrIvfLUqWWi9amyg9CbXErp7K3agsOMkwC/6DuKupijgt
	EorQ120+2zWO5PIHKYM4op7zMB+xdmkK6bYAfWYEgFuz0rZ5uKR3hCaYG4FO0cixrIaVbuqzIvE
	bqN6zQxsX6FWSo/maCFCtrSPxRvB9HCRsHowl3fq34WY0OVQMLDe+usFuIW7BNPs6r6GJznrQuH
	bcsIhCkTK5RDFG70eqZswIs+oWVLZ4IF+7hYP1FX6c1kWw69+lMKhteZNxJI9oBAi45Oow1zuG1
	qtLqvQwuWMdTxaNHSeVaqpCOy9tLurmjIOGMbGKTKfD4FusUc7mvenRfKeRgcenYvxRz3Akx3yk
	ErP/dLGYWchfBHuobtg6PSg==
X-Google-Smtp-Source: AGHT+IFLW6w5oB6ZXbuB7TpKPWatpCUluGeUA5lja2xOuxx1eqqEzTSB1q3l1GYm+kirkb7tz809Lg==
X-Received: by 2002:a17:903:3b8c:b0:234:986c:66bf with SMTP id d9443c01a7336-242c20037f0mr87772355ad.11.1754750043928;
        Sat, 09 Aug 2025 07:34:03 -0700 (PDT)
Received: from dixit ([2401:4900:1c45:5acf:2843:11a:c808:689a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897ef30sm230625275ad.106.2025.08.09.07.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 07:34:03 -0700 (PDT)
Date: Sat, 9 Aug 2025 20:03:54 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aJdcUhz-vqnx8DwA@dixit>
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
 <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
 <CAHp75VeKPr=3H_wOvcesqj4OsrqN7zwRFFk3ys3O012JpQtxrQ@mail.gmail.com>
 <aJcw8icGvsDzFGpJ@dixit>
 <CAHp75Vc7Jftvmgb0EgnYmiKtT2TTYb2uQGNgaqm7hvkFWpJ9cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc7Jftvmgb0EgnYmiKtT2TTYb2uQGNgaqm7hvkFWpJ9cg@mail.gmail.com>

On Sat, Aug 09, 2025 at 02:44:00PM +0200, Andy Shevchenko wrote:
> > > > +       data->wr_regs[TLV493D_WR_REG_MODE1] |= mode1_cfg;
> > > > +       data->wr_regs[TLV493D_WR_REG_MODE2] |= mode2_cfg;
> > >
> > > No mask for the existing values in the respective wr_regs? Wouldn't
> > > you need to use FIELD_MODIFY() instead?
> > >
> > I believe, we are doing OR op with the value created using FIELD_PREP,
> > so it should not interefere with the existing non-masked values.
> 
> I am talking about existing values in the array.
>
Right. So in that I think it will make more sense to directly use
FIELD_MODIFY instead of using FIELD_PREP first and then doing this OR
op. Right?
> > However, as FIELD_MODIFY is there, I should utilize it.
> 
> > > > +       u16 val = 0;
> > >
> > > I would move the default assignment to the 'default' case. This makes
> > > the intention clearer.
> > >
> > As per the suggestion on privious version of the patch, we are having
> > ch datatype as enum and as suggested, with enum as swicth-case, it
> > should not have default case. so I think this initialisation to 0 at the
> > beginning should be fine.
> 
> It will make no sense. Please, remove it. and perhaps the compiler
> won't warn, otherwise the default case will be needed.
>
Understood. Will keep it uninitialized.

> > > Missing include for this macro I believe.
> > >
> > No I guess. DEFINE_RUNTIME_DEV_PM_OPS is part of pm_runtime.h and its
> > already included.
> 
> And how is it related to my comment _here_ in the code?
Pardon my misunderstanding. Please ignore.

> > > > +       },
> > > > +       .probe = tlv493d_probe,
> > > > +       .id_table = tlv493d_id,
> > > > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko

