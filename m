Return-Path: <linux-iio+bounces-4825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04488BC4B0
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551F21F2165E
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B6140367;
	Sun,  5 May 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt4PHsNP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD4374CB;
	Sun,  5 May 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714950497; cv=none; b=kbQsuzlPFhuuQmgL/+0+H6A+w4VjfxzYewIELF80G2ngqmMoIKf552ns4FFw29d9MxUZwV0jir9xinqRjkzub9jCTyECQ8G1DWdB6Jf3THWY3mgv6LKSSnYxZiHPwn8igmwN9ItYDBd9JeSSTHQ37newtrrbQV+SVhUnrCCQ2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714950497; c=relaxed/simple;
	bh=sO1bCtWtZNtX/y3txjwfHuSjDHCzKW6qrmiRBggkaHc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ao/IMDdchMc2J8T/zFORjEyDTScxmcZ/ge1kgIscUKHebFTja06erE8RnmGl2zvcOcw0L7tKssAyEZqdgufgH3M6rlNwXJGHBvbAvRX5lneYh3iGWhG3LGnL+Oow0hY9Snf1KCDQsjWCof1bjeTAV9GxvHmeVnv9w14mj8q0Ssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt4PHsNP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572babec735so4654450a12.0;
        Sun, 05 May 2024 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714950494; x=1715555294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tskK3STwMBeYl+RbxU4+ZeO0SLew6XfkR91Iyt3O2DQ=;
        b=jt4PHsNPBjvyXGxcI36zkmFAluURyjQT+cf8/o8atcLfJ9YUowORTPxu4IBJXQiKAJ
         rCSgtdyIJuvDEWt2SO8NB6jfAw+tgXHX/7LZ4S0RKLOHZq8kqRfq4eRyt/0WjP+B6Uhp
         dSawqV4dCX7wMZQVn8+OeF8NTCJLp+4xPBpWf5QibF+BBFhpvTfDFqje7htkrmUF2UTA
         RjrzL73tgBf7aKuD09e9i438kmxMQHJOkZZQaU5yjut88PPoEnUES87+O2i+M53IGgis
         CDUbRVbvLa9omLqT3VQ2LMozN/4eGkNSPFtk7p6I/noz65GrEc0MlP4VMYzTUnZWm5PL
         lJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714950494; x=1715555294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tskK3STwMBeYl+RbxU4+ZeO0SLew6XfkR91Iyt3O2DQ=;
        b=WOhCcZFlj/a6HAZNAzWkQnJfaZT/csWNPqLcByaTM0ZUJLkBVPQwwGF+bQlVx5o9Lg
         g+cLrfo7PFj7+f4z4SZNAzoJmuWywhEbirxLQvEEU1l4I7rc9kcggv5C65urBbBRgeso
         2nlNUqgEvzmep+Uvn1A4Yi7Whm2x56vNT+c0Mk2ZSGcSmJjIrbDxq9NgpvfgH2MmkPOF
         eVKkArC6yJdPwOUY91p7PTMAlBkvgz4sDXPbHE8gsKmFN7k3sJ7FMRkvchZVIzO5MCz3
         luVfb4TdgPY9rJrAJffvlzI81SCtcv7h5Iq0VqNancxP7WKyj6XKnArlH27xGum21aUp
         QQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvkEwkkx5QKhtWPuWY2GiOTOGbAIynquq6LY3KzaP6o+wNM2I71j8P8F2f757yP3ke+j5skKWmK/4r+f8SKPFLzX5tT2vHtYKVJWV2G0GdATho+XH8akKeJ/nQ8KSiu6EX0LV3J+Uf
X-Gm-Message-State: AOJu0Yw0m8Fzeq019ZWsta3MaGI8ZZs3AxpuXio1Dd3STOXANEOXbpKO
	cRi6fLNENMLfSJ2FJ5SSOuTwuwVgp1wYgRMkj4iBMFEP3RYLJMwz46JhODk66YI=
X-Google-Smtp-Source: AGHT+IHgRrQC8tDiAesdZ8UmjbR0R+Uqald3KXZGWxu3bOCU4iH8QjeLsUwa3tDDzCtXQ8r1AN+1aQ==
X-Received: by 2002:a17:907:7d91:b0:a59:ccc3:544 with SMTP id oz17-20020a1709077d9100b00a59ccc30544mr1246280ejc.2.1714950493898;
        Sun, 05 May 2024 16:08:13 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:7a5f:ec16:256e:4660])
        by smtp.gmail.com with ESMTPSA id er21-20020a056402449500b005726e5e8765sm4423133edb.3.2024.05.05.16.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 16:08:13 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 6 May 2024 01:08:11 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] iio: pressure: bmp280: Make return values
 consistent
Message-ID: <20240505230811.GA17986@vamoiridPC>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
 <20240429190046.24252-6-vassilisamir@gmail.com>
 <20240505200818.1e70c664@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505200818.1e70c664@jic23-huawei>

On Sun, May 05, 2024 at 08:08:18PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Apr 2024 21:00:41 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Throughout the driver there are quite a few places were return
> > values are treated as errors if they are negative or not-zero.
> > This commit tries to make the return values of those functions
> > consistent and treat them as errors in case there is a negative
> > value since the vast majority of the functions are returning
> > erorrs coming from regmap_*() functions.
> 
> The changes are fine, but that argument isn't correct.
> regmap_*() functions never (that I can recall) return positive
> values, so if (ret) would be valid for those and I'd have expected
> the exact opposite outcome if you are looking at regmap*() return
> values to make the decision.
> 
> The if (ret) pattern is sometimes used throughout because it
> makes
> 	return function()
> 
> consistent without needing to do
> 
> 	ret = function();
> 	if (ret < 0)
> 		return ret;
> 
> 	return 0;
> 
> That pattern isn't particularly common in this driver (there are few cases).
> We also tend not to worry too much about that slight inconsistency though
> in a few cases it has lead to compilers failing to detect that some paths
> are not possible and reporting false warnings.
> 
> However, all arguments about which is 'better' aside, key is that consistency
> (either choice) is better than a mix.  So I'm fine with ret < 0 on basis
> it's the most common in this driver being your justification. Just don't
> blame regmap*() return values!
> 

Hi Jonathan!

Thank you once again for the valueable feedback!

Of course, if (ret) would be valid for the return values of the regmap_*()
functions. I was just trying to understand which of the 2 options is more
widely used in other drivers and I tried to implement that. In general,
the if (ret) is used 65 times while the if (ret < 0) only 20. So, in
terms of noise, changing the if (ret < 0) to if (ret) will create less
noise. I chose the if (ret < 0) because I saw other people using it
and it felt better in my eyes. I could check if if (ret) applies
everywhere and update it in the v6.
 
> > 
> > While at it, add error messages that were not implemented before.
> > 
> > Finally, remove any extra error checks that are dead code.
> 
> Ideally this would be broken up a little more as, whilst all error
> code related, these aren't all the same thing.
> 
> I'd have preferred:
> 1) Dead code removal.
> 2) Message updates.
> 3) Switch to consistent ret handling.
> 
> However it isn't that bad as a single patch, so just address the question
> above and I think this will be fine as one patch.
> 

Since from your comments in the next patches a v6 is for sure, I could split
this as well!

Cheers,
Vasilis

> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Jonathan

