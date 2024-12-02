Return-Path: <linux-iio+bounces-12972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A189E0C05
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1383A282D7D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D91DE3D6;
	Mon,  2 Dec 2024 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeYhRmDU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A61DE3C8;
	Mon,  2 Dec 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167494; cv=none; b=CpGQgHWOEqlk+2fjOPBmYbgk7WZ7vNNZLNVGZ5ZtOaFMJNib4wlBm+smokF5wHW4YoEWI6G3ArsLv3EIiDkYJZzbwwKT/Yb4tkiKhWQRbAnH+GqDScPIzpqVw3ZFx6opbQqb4iCuFW+MbKQsdT7gTkExfPftZqg2yU/RoQ4Rfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167494; c=relaxed/simple;
	bh=wayb2byA9PXjEbaCd3kqDOfxdaTNaFw/0tj3MFZqjgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKsb2TjSc2Gvlj/lJGtrf3MdAX0sSGHjO3j11lyVfe/CAOs34ad8CxzouM44mAJ0wJWOipY+vgUi7cWdpyMTgcc32b4M2mSdshok4iVzyrnn46dVKYQcPibw5zz6StOBJOGGJPSDG98IRGt2XfRMppLZ3qgdsNAe/e9svqO7GJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeYhRmDU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385f4a4093eso897101f8f.1;
        Mon, 02 Dec 2024 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167491; x=1733772291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7O2hkmzneJO23kQhspKnzrj/ryO+yA8CoJyww/4RjX8=;
        b=CeYhRmDUPEZ8wChHjazLeOJihBJ2CTb4gOzsuzKd5Ted9q+4EwHJ+F8P/2hGRSyXNV
         ViUbHugod9F5jjIlYYyONJzhZ+93uPSuYt+lSQFb8iYzBhBW5D+VtSUhves4+C4kbVED
         0chnXNiBTDwIGoaZfKloJOhwMcghNSbvHX3kwE+43gNdSpYRwIlAeF/EjY3Ji5Uxk52+
         muABSk3ZO9qDsHfyCEAwwc0mgAyMoKi5Zr8jAgYzvrniUdN7ytBAVnWJBzQHhvHO5pQv
         0PHf+lxN92JphvmN/uqZ1y0Ne/2wAkRROQDmxh6LX2ZgcvWjmba8VACTTFsE2NNg1UjN
         miPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167491; x=1733772291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7O2hkmzneJO23kQhspKnzrj/ryO+yA8CoJyww/4RjX8=;
        b=hE2oNndGgIEH/DpdZmO7TCswk6KfCG3oE0KOaKl2lQ/xOU4jd5DL0yDabxzSJi4QD/
         jrsTfKup18z5yXkJDYnFAa6xDKzrZvDje8LCXc6hMyhoWQOFYbBCbGcKFLA9s/zuyviz
         /yCdOIsH/BXo9JdpKMVUdHL7SExW2UYWxhv1NL0PO+WpxaGyF+f+FI39d/tNyp0PeR0B
         dnfU0KKrHk3NvFAY673IbZRZHUUWNLvs36JJSeTQEFXlRqNF7jP2ikqW4NrQ9U05ejBY
         80YbIsG8zfr0CSyZGWcUJZ8QmE7Z9BlwUn2FkRru0LRTsWSXA9U++KfnCtEaBwOUI6iZ
         3EKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+5aUkncV3FOOthVIEWB6RsSiDqPpskL8NHJlTofkqSk/Yi9xFq+h9uzGpuHfhGmvofwFuajcW/LbmWoh8@vger.kernel.org, AJvYcCUuAwiUcxFEEaS/1hJAEIMR4sNfydmBdPruzXrLbYAFCb2ZpQW9jEPB2w7gFjR7wtYLdCiMNApfZ9rO@vger.kernel.org, AJvYcCWPmOi1PgDxgkYKh5IPcN0B4vwpwrdUVIxLQ0gLYTXuCZBFGGkiU1OKShjsbv02hKY/+KY1BlOQeCKr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cS6Ei252YdsGScqQJpgdtvlW0zlU1ZDpTnjdxSxYm6/5Vurn
	KvAdyoJJ8mWAFQAFEhNk2ohVA1qHtTcNtmzbpfnQTDB4+/9bL5KO
X-Gm-Gg: ASbGncudFCAyRlUWd/6qUvTYhj5b78E/Qx8rdklcA8de1zq1J2u+msaZzlN1P5vN6s1
	4CAKIzfKebPW9FQCC1coafsq0gqGWzjqQX5EDzw5MUDRC7+npPsTHb6uhYSuyuZSnqXtDIoLpEL
	N6uI5LcQmmUpkB0F3TduYWA4GFttPibmq+p0yovfGMRIsHxDQoBBZ6L9XREtI0aHM4GK6YRN4H9
	WXp+PWs3pcz4077pc5RertyWpxXZYRoOm99AW5oHd6raEoo1aXuXm6qGav3
X-Google-Smtp-Source: AGHT+IFwxIOIwaZWMhaN7+zUbd/VzyxqPZTFWKRTbTZVar0ITlWmPFKfB3gwF9By+Pk+SThJ38n7eQ==
X-Received: by 2002:a5d:598f:0:b0:385:f5c4:b318 with SMTP id ffacd0b85a97d-385f5c4b718mr4410404f8f.31.1733167490701;
        Mon, 02 Dec 2024 11:24:50 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36b80sm13210273f8f.29.2024.12.02.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:24:50 -0800 (PST)
Date: Mon, 2 Dec 2024 20:24:48 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ajarizzo@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: pressure: bmp280: Minor cleanup
Message-ID: <Z04JgFlg57-slCsU@vamoirid-laptop>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
 <Z03_fBy9PmqDGLg3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z03_fBy9PmqDGLg3@smile.fi.intel.com>

On Mon, Dec 02, 2024 at 08:42:04PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 02, 2024 at 07:19:04PM +0100, Vasileios Amoiridis wrote:
> > Changes in v2:
> > 
> > Patch 1/3:
> > 	- Switch if case for better readability
> > 
> > Patch 2/3:
> > 	- Reword commit message
> > 
> > ---
> > v1: https://lore.kernel.org/linux-iio/20241128232450.313862-1-vassilisamir@gmail.com/
> > 
> > This series adds the SPI interface description on the device-tree file
> > of the sensor, adds proper self-described sized variables and performs
> > a minor optimization in time variable names.
> 
> For some reason your patches still have v1 in them. I dunno how you prepare
> your series but I recommend one of the two options:
> 1) b4 relay
> 2) my script: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

Hi Andy,

Ah, my mistake! I didn't pay close attention. I use the --reroll-count
from git format-patch. I was not aware of those automated ways, I will
definitely use them. Thanks for pointing it out.

The patches are correct, the versioning is wrong, I can resend them if it
is necessary. 

Cheers,
Vasilis

