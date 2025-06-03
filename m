Return-Path: <linux-iio+bounces-20177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3CACC614
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 14:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387787A155D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 12:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54122D7BF;
	Tue,  3 Jun 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi9pdO/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230446B8;
	Tue,  3 Jun 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952094; cv=none; b=o8dVoTsNOdChcmxe3jlFBX8d5zBBH9Gvp5leT/WXkgIZDfES7nwbO/8FJLQ233gWErVxaG8XfMMzM1/mGqYmyrAg4reK1OJdf7FAr56rLpVnB+Ojzq0/Ukf4BIIciv3k1VXYqtPHFZEodGteXwAlaxP8UFAzRTufIMVEhPJ9H4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952094; c=relaxed/simple;
	bh=h92UUlXMO/KLL58P3PSjFD/SbuRQD19YhC6UgkrFuhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNAK3qMdUcN/NgGTjbbAZlAlBKd4CaP1jiEg6K8SZs2FxQ7GjL/dJ55E4bnutiuzQUmU+WX6SNOE/DnB3806+QDvXikNrhwPZEeFGfeLyLrIE9CbMA9GWJ47Hfl5vGGCdP1EsBnLgOTRy1SmIQrxXOUM4hbeJNk1XOEkUWQhBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi9pdO/v; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a56cc0def0so44893551cf.3;
        Tue, 03 Jun 2025 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748952091; x=1749556891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5gk2lwOOOLeohREzJWg+/TaGpOi69oLrNHUYeAZNaU=;
        b=Wi9pdO/vzywpOzQrpkzHt0NbVVukb8zemqSMNuT2YhAPRYBvLxVA07wa9BzxOzory3
         yXFRmJEtb+KlHwx0Brvelt3bO5mIu/aJphk+lc1J98wKmyJYYqFPoCsCc76ELX/eTq6T
         UpBds4Q9BPvSsIazN8T5ss1+yphLzRoYf0GLNavvGl+VBfkknK0jAlY0f4owi7thQML/
         gyK/sfBkl5qsiJNwMxZyywTMcjWclX5PNH7D/eAd5oAgAMRdIijGHQJqTIJldhQWyXjn
         x/03LBWDzPWuNRvtn7/JLJUdTziHE/R1z+uqj8w4sxTF5f52QbvG3kIRD/MD9ZfSchYh
         Vypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748952091; x=1749556891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5gk2lwOOOLeohREzJWg+/TaGpOi69oLrNHUYeAZNaU=;
        b=Z5756HJjI32ZL7qU1cy52JuJn6m30LKMSbhdO9Kumze9VjlF89DDm3YUv4iwAJZ/Gl
         omFFNu7Qy/LKvXEgqXSY3O7eZISPQS+ynbvjcVRqtv/+a79GjDJO46315YT6ZCeBQk9y
         BpbOyevjqfdF9YmEFC39I7PcxP0CL05T+GyXWUeu/o/YIESRvzvBvkjo8oXB1TrHuv5v
         W4dhRihvesqtp4QL+Oz1TgzSVrXA1hCN3TVj69VdKAXjC3Dk+Pb9zMvTZd5w/tXwlw43
         ONYv1UVEYjm19al6yLZct9oA0AubarU1ylGEJlE3AnzIe52f1MlZ/T+NIwfSjH1clrao
         BUmw==
X-Forwarded-Encrypted: i=1; AJvYcCU89QKfa15J57Wk6VdmS5DoiGqn0EfYvpVdYB7EM+asO4CPsETc8UMr8vjUw26s92lmUdP/V2x2/Fap@vger.kernel.org, AJvYcCVkCl9xsh0nE7HoNvHit4sIewvJ2fKLoWCDYlWE/7fJnNcF11PhDCh9021KfNDrlI9IjSk61b8rocQu@vger.kernel.org, AJvYcCW1D+h5d25nx+iDCUCym2SgvqOVDZH/XLwhXB/OX+qhPRxpzq7AaR9THJnjYVW8sYHBUiGiPgz8hhX7QfQX@vger.kernel.org, AJvYcCWY9LZTbK6pirrxJuh9Cv0Fvnirvhd6ZV/+vZQIV/7/u9rGfbqqkw8aJ9sXvAj9a4DNIYfKQQN6hSvuQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2A7xJ8kpMH1JFKK/d82eZYPbm4AvLsp4sjGQMqPmzYCCeKtkj
	iGJM8r3X+RH9wDS+LvMNg6im4njjfSQB7W7oZW884/BQQk8v+p0+PqrbKbOKLoceUOk=
X-Gm-Gg: ASbGnct8lx0KKUGtdCYaND6I4/M0OooaWsW+C6BrhpGJZ8wlTPSJVW0rGj7qXXa6u0X
	Ke6X0e3VZz9MV5RARh9BxcNXUPk+nE3smnoYX8FFGIrQnJ7UVWQ84GqV5Z5TzjlCodouC9A+5xl
	BCbJhJinpdJfB4H4ktozozbiysfVkN1fv+7cbLcA/WTt5j36cqlx9tJYgMtmLZH90ff0jRTGlg0
	StwxoQhLTWZrLvdMJFqk5CV2+TZMZjTAwn2R+pDL7JtSd0TBs9oS8EB5Am82bksQhrB1CWCOTag
	eO/Tf4ByY49o12Am2pyhriuvDC+JOK9yDdITqurGY3bMqBlzOl7hsFHf+9vUU12riyAejQ==
X-Google-Smtp-Source: AGHT+IHkd3xP0AuVWx7aZOobspQQuluiMGh3RGmXtKIFGOpQiJHf47IF+VP77KmJCWKRTBLn9KS7lA==
X-Received: by 2002:a05:6102:949:b0:4e6:f7e9:c4a5 with SMTP id ada2fe7eead31-4e701ccd25emr8903178137.22.1748952080349;
        Tue, 03 Jun 2025 05:01:20 -0700 (PDT)
Received: from localhost ([2804:30c:406b:9100:2a26:16f5:c81:e61f])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-4e64e9f7ff2sm8433407137.27.2025.06.03.05.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 05:01:19 -0700 (PDT)
Date: Tue, 3 Jun 2025 09:02:56 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v4 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aD7kcFupREh4lW0s@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <e79f9a126672b33b8a7c01f650fee43a68c74029.1748829860.git.marcelo.schmitt@analog.com>
 <aD27cobHWeBX8o30@smile.fi.intel.com>
 <aD3XQfUfxIiz62ZU@debian-BULLSEYE-live-builder-AMD64>
 <aD6x2caTMd1eBInM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD6x2caTMd1eBInM@smile.fi.intel.com>

On 06/03, Andy Shevchenko wrote:
> On Mon, Jun 02, 2025 at 01:54:25PM -0300, Marcelo Schmitt wrote:
> 
> ...
> 
> > > > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > > > +{
> > > > +	/*
> > > > +	 * The use of static_assert() here is to make sure that the comparison
> > > > +	 * is adapted whenever struct ad4170_setup is changed.
> > > > +	 */
Does the reason given in the comment justify the use of static_assert?

> > > > +	static_assert(sizeof(*a) ==
> > > > +		      sizeof(struct {
> > > > +				     u16 misc;
> > > > +				     u16 afe;
> > > > +				     u16 filter;
> > > > +				     u16 filter_fs;
> > > > +				     u32 offset;
> > > > +				     u32 gain;
> > > > +			     }));
> > > 
> > > I think it doesn't make much sense unless one uses memcpy().
> > 
> > memcpy() is used to update the setups after reg write succeeds.
> > Also, previously, memcmp() was used to compare setups.
> > Since struct ad4170_setup has only unsigned integers (no floating point fields
> > like ad7124 had [1]), ad4170 works properly when comparing setups with memcmp().
> > Though, it was asked to do explicit field matching on previous reviews [2] so
> > that's how it had been since then. Well, both ways work for ad4170. We can
> > compare setup with memcmp(), or do the comparison field by field. I don't mind
> > changing it again if requested. I guess we only need to reach an agreement about
> > what to go with.
> 
> The question was "why do you need the static_assert() now?"

To ensure that the comparison function gets updated if struct ad4170_setup is
ever modified? This intends to be similar to what was implemented in ad7124
driver as the chips have similar channel configuration mechanisms. We also
have ad7173 and ad4130 using static_assert for analogous purpose. There was
also a comment about static_assert above.

Best regards,
Marcelo

> 
> > [1]: https://lore.kernel.org/all/20250303114659.1672695-13-u.kleine-koenig@baylibre.com/
> > [2]: https://lore.kernel.org/linux-iio/20250504192117.5e19f44b@jic23-huawei/
> > 
> > > > +	if (a->misc != b->misc ||
> > > > +	    a->afe != b->afe ||
> > > > +	    a->filter != b->filter ||
> > > > +	    a->filter_fs != b->filter_fs ||
> > > > +	    a->offset != b->offset ||
> > > > +	    a->gain != b->gain)
> > > > +		return false;
> > > > +
> > > > +	return true;
> > > > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko

