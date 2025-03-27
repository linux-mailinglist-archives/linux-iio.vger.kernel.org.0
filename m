Return-Path: <linux-iio+bounces-17280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DE9A7320E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B821890C52
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4491B960;
	Thu, 27 Mar 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLqsCpIt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709322135D0;
	Thu, 27 Mar 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743077331; cv=none; b=nWYLvZG6OPdNuKpzdQu171BltiXNp8Lo8qy8CIlpui3gKRWPNMqe0zahClafaz5abIZ/kKPnEhAXaCMduVuCsHlwj8isNoV0TLrtKSYBPpDag7nzW8Ea7AEv1/3ZetjHHiQMgErqjzCQSV6+eC0i2lxVyfmwcglqVieXo0tt2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743077331; c=relaxed/simple;
	bh=bXlRpZjRoRouKqkyY114qDUi62T33js+8zLGw0WTHCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1iVVRcYQFy9wmeSsLHKzfaSa74ALlVPknuR4cK1r+qIrZI/VTUeEN2qVN4a0hcIqH1sRvKL7nsMCEN9bIPYVLMMC0iGhZ62i8oAYAu0Qpj1Vxf10IcwJOPmzW2spQaUNCzcJjOGy8KMkLn/iLX+zrUiRjMZDZrJD1bRLpHt5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLqsCpIt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227d6b530d8so16950285ad.3;
        Thu, 27 Mar 2025 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743077330; x=1743682130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S092O3DXnMkKDtgF7xLiATCJGN6nGXLA4vmLl5PCoVI=;
        b=cLqsCpIt6gZ4eaK06V0mMZ4CmpJZ92lAp4XpZqogPerm3VhaR5WJVlXEtzXMHuF+vY
         CbJDUVEOqNu3C8pgTr69/Fp6DfaI2QV1RbIxhqw/kuJgwrZLI83dW7oKV3iYyRsdrDGS
         sXnF98N5O6p6rA9D2Rev5sIDr6cr/DdOqCV3g9Zy0LrSlDR8OWitx4QcU04ppRifcGRz
         bF39OZ02itMMdvkjKwZJM9D9aZKNI8Ij5mcFbg46HXT5zZHjbqsYDf2zpzTvkUiADbED
         DkRW3Ui/LThoa/La2oFXXzW27w5ZGnFOnZV7J2WptRlAXa/eCT/YXCN8UdOmnx4ASGKG
         ueKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743077330; x=1743682130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S092O3DXnMkKDtgF7xLiATCJGN6nGXLA4vmLl5PCoVI=;
        b=MaQI1Kq7ouv7fVjnwUMoVyAMUZjt0fs1FyeYm9Gbrs48FNHcJxc4wDNpnx1E0+YPQQ
         K0uJzcOBkwVzXrUXoaSt/7MiA3WrJ6K75QEsRb5cmgHVCyfBfyPEQXTGeiyN8Vvm+Xep
         OA2bcprc4bn/tLbjjy2wH8zJXg+RjFOQBOA52ax4JB3WfXU5qqFr5ztSuvVGiV4RaxO2
         DW233kPeCaRIMHtgpx9DJA2gjQyn3jFGkAesTX/9OajJ1f04BxGeOPMtk0X0PNFvA4Yg
         85GIiyrz/7c2tyiOzHl77h8njbA5/3e1GZ12Rta6rzAc38kU4YUjSk2qKWfdSARtUNu+
         67KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6DHONgVJLsxek1A8vJFV7NULn8nA1fvX5suBL+CgWco3Q0ngPc80jM0QNeBVkA/l8RmhpOVDvloc=@vger.kernel.org, AJvYcCUgukThcgX4Tqcv1a7e3E3/Qjum7g0ev7M59UNX5LfWvw5FDoT4DRLZ0PG+Ob7j6gXSf4BDAZqIa7TvFiMh@vger.kernel.org, AJvYcCVker5YTi+MEpJYTS4HeN+gz7wNxA8s6eZ8tEpI7vNa7QQ9B2YesI25e85xvGvNf4NX6lYw2a+P78X8@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4yDylQ/L2BeOyRY59LMepuUGlT5FvF7VuVxsiM8O9/Sxwumf
	mTYBC3mW+iVH+ptt5TfxLfdUZNkRDaj8antEH86bbrfqnJjfnc4j
X-Gm-Gg: ASbGnctM08Hy9bnXHQcpBMiJEWDdHvxJso9iSFzINcqkfwZQNQvy+DdJbKqrs3ye445
	bROCnhfmhfn4IrEr0LuCYEdB/IT+cZo6JqwAdUnWGa+xX82CvHITd3hMpu1N9iCIdJOLtQ0MEZi
	9w4+L1+52y0oGPHg2DuKmTQEIuInsNzgg45L3zX6j6KHV59+UlHyFnsumyPQkg52IYl5pHIRKPL
	ppPE0kmMPJ0y0naH0tgki7LZ4HBgb9rSYbN3KyekAiY9Xg3sLcBwkDy2jMmeafyzoX4auCwtm+m
	Egq1l50iDR9smwbUqQfnpaGB/mv8CCH3Z8om5KL/nakJkfZUzmg9og==
X-Google-Smtp-Source: AGHT+IHUG6UgpW+F+Lfh6Jbif+df6VczM9J/+UtolhbE5v+PkNSZTi8Z4jWjIvJDFkXznii5rwnMaw==
X-Received: by 2002:a17:903:2447:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22804877972mr55641315ad.22.1743077329421;
        Thu, 27 Mar 2025 05:08:49 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f4c500sm128027075ad.83.2025.03.27.05.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:08:48 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:09:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
Message-ID: <Z-VADhMDmmPFhlC5@debian-BULLSEYE-live-builder-AMD64>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
 <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
 <Z-R3E23hWiUKDc6q@debian-BULLSEYE-live-builder-AMD64>
 <yxhvtline3ey3ekybqfe3k4y4sm6746wpqwpydxv2brryironl@u2ezr3sryqxs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yxhvtline3ey3ekybqfe3k4y4sm6746wpqwpydxv2brryironl@u2ezr3sryqxs>

On 03/27, Angelo Dureghello wrote:
> On 26.03.2025 18:52, Marcelo Schmitt wrote:
> > Hello Angelo,
> > 
> > Patch looks good to me.
> > One minor comment bellow.
> > 
> > On 03/21, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > 
...
> > > +
> > > +static ssize_t ad3552r_hs_write_data_source(struct file *f,
> > > +					    const char __user *userbuf,
> > > +					    size_t count, loff_t *ppos)
> > > +{
> > > +	struct ad3552r_hs_state *st = file_inode(f)->i_private;
> > > +	char buf[64];
> > > +	int ret;
> > > +
> > > +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> > > +				     count);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	buf[count] = 0;
> > Shouldn't it be
> > 	buf[count] = '\0';
> 
> Why ? I am zero-terminating the string properly.

Oh, okay. I was just more used to see '\0' as buffer/string terminator.
I see now buf[count] = 0; should work too.

> 
> > ?
> 
> Regards,
> angelo

Regards,
Marcelo

