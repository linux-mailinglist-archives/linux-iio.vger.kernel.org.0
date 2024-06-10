Return-Path: <linux-iio+bounces-6148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007D9022A6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 15:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A451C215AE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 13:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD482498;
	Mon, 10 Jun 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFhCXJB6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252774048;
	Mon, 10 Jun 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025999; cv=none; b=fQNED1skjbJgaLweMHZFM6pRMGFHw2JqNjWHPf0iL900yqcG5mItZFcqP0mt3AYX6zAi/PrH+YwRd2YT+OgKqsiZPEq1qoL6xVh4Hbs6rPiYdftznjIpArG84Hd+OK2MDq8gP+3kJBJnQhbU+5m83GHUAOIOA3H0jzLvkLOIIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025999; c=relaxed/simple;
	bh=H3dWE4h7KzfXVCEa/Qled2dPPQ8hF5yac7cYUe5gnqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX0mvBcclIZKg084m2EqZfc8HTsyumSGxUke5J6zISUEciRH4aElVSPobs0o+38Q9swryeLHprzeYUTF4LByAHgvX0/ld0rNjzp1hMmgQlY6a3Aj5/CK+u6Cxp708jBUiKwewRh7ba0JtpEYCgv34to3HUbEYdc7miz9GG1mGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFhCXJB6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7041f4553ccso2256060b3a.1;
        Mon, 10 Jun 2024 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025997; x=1718630797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4w4mgyCvqp0tpBFX3kdwj+Vb/Ib5BUa62dRD/0jFXbQ=;
        b=NFhCXJB6uAClvhgXfAFP1O2ZnG4aJEbYR+mCqYMzbE29GYs7LsHCmt0uzN2JVDsf4K
         anVFsB0XE0Jz1XE5tsjDlM5K0dH3NMhrJrL0AQPVDqi6auvIXQ3Urgu5pQC0yaDJBRkn
         YL/BJUafSXcMv/UTxiELcOsWzWqyusknJyFs8eftQtDdIHXD5rpNSsoaayWzHAs3KA50
         mygKMWI1MGRjFkhOGzoC3hLwhlP3hXf/hG9VOnimZKPDdhzrRajpjryXbIAB9vk+IHwP
         +cpK0bviKW/1FKKTZEQMSKjkb0dpf5MGh1FryzeYhhzER1CmSp/QUUuT8dwxpW7q7c/e
         qaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025997; x=1718630797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w4mgyCvqp0tpBFX3kdwj+Vb/Ib5BUa62dRD/0jFXbQ=;
        b=aeSi+JNy2ajRJVCBp920rGcUfnt6si3d9i/0R2BseoZLfkOJ4MWbhZBAVJ2mmo1J00
         DvIQv+BaAm4+CUQHbns8QgbnuEE5nl1zduw1sxKZ3jAIqT6CJrJ7MwGvn3olxHCBig0D
         zHhh/goXaa3x2tELJ3sc7ZAM119MCwZH2WLZmghGwSNZ/eWo6K//LtLkULk22HPMP78I
         KaRQoKa7AGr9pRU3M0TVykGoSqirOhbewMERLX4HcVdiYpHWKPWgpEaQZkIkqulKvywl
         5aEESxCHnzY8YLmC4V1UdTdP9H/pQ1/Iete7OuPw/EqRQG+3dYwXsxC3fj5T5j5j8b5l
         KI2w==
X-Forwarded-Encrypted: i=1; AJvYcCVNEKE0Q+nuOU3bApbMML4eOFX9HDgVHnIvemsoW/8Jae2G3DxHrroGRGh+V4FVn7Arf8qExJepA1z+PizfnWnnqZ9/ewlSQJAw+xkRxoq5YYT1LjyGYsiLoDUrzw+eV+tS+NzLPUEJ
X-Gm-Message-State: AOJu0YzRYjmvWZ5QTtsCpE5BIopIaB3Ty+a41LvdlJDxn7Kz3hFmEsQl
	pGeXSSahMu1XzfnrMECABOiFHLft9c5prVP1zni/RP97+ZnagMwV
X-Google-Smtp-Source: AGHT+IEYn0/Tj6kneNfxJv00f11r932nKku8RxAmGBKO9j89FxY6C2EL5jQg7ZmnPY/tdYL/uZAuiA==
X-Received: by 2002:a05:6a21:789c:b0:1b5:fde3:a603 with SMTP id adf61e73a8af0-1b5fde3a727mr6025573637.20.1718025996777;
        Mon, 10 Jun 2024 06:26:36 -0700 (PDT)
Received: from joaog-nb (201-13-139-53.dial-up.telesp.net.br. [201.13.139.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70432004423sm2842682b3a.150.2024.06.10.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:26:36 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:26:29 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <20240610132629.xjj32vzrekpl356w@joaog-nb>
References: <20240606163529.87528-1-francesco@dolcini.it>
 <20240606163529.87528-3-francesco@dolcini.it>
 <20240609115234.20e08840@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609115234.20e08840@jic23-huawei>

Hi Jonathan,

Thanks for the review!

> > +
> > +static int ads1119_validate_gain(struct ads1119_state *st, int scale, int uscale)
> > +{
> > +	int gain = 1000000 / ((scale * 1000000) + uscale);
> > +
> > +	switch (gain) {
> > +	case 1:
> > +	case 4:
> > +		return gain;
> Odd to calculate it if we don't need it
> 		return MICRO / (scale * MICRO + uscale);
> use constants as it's easy to drop a 0 in these without anyone noticing.
>
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +

Just a minor. I do use the calculated value on write_raw() by storing it as the
new channel gain and would still need to validate it as scale/uscale comes from
userspace. Maybe I can just remove the validate_gain function and do the check
directly on write_raw(). What do you think?

Regards,
João Paulo Gonçalves

