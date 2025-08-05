Return-Path: <linux-iio+bounces-22314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA2B1B823
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 18:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E20B62425B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385EC292B22;
	Tue,  5 Aug 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDvz7LLb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8C292906;
	Tue,  5 Aug 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410383; cv=none; b=WObFQJ1LAZSfASI4GF7iSwiwQFs4oifou+YDlOJrOi7wikkcWiOodmN4nJCPJVCYEdDAj/fYr6oMScyr6LTKuJweDcIw6454ikQ7s5xnYEaTd9ua2KPeGl90TXgz3bKiPAQy7W99Qich+jUOgRRYKbr66Z6tapwYiy5fQglL780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410383; c=relaxed/simple;
	bh=rRhOMnJaXbH2DsNOiXiySwYYqVDOpYKbEOHZc7gvk2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cfaxngk9b5p5mFLJ6vh0CovthhwD1UjWTlZqai7gaKJOoEmIG5pfPvj6S3FBBmbe2l08hxM5AHtB7UOe5qTT8/HpHDiF9AyRAMRLNJ7QdgqALyz558u3hfUcluLk3FLSdztypOG/2OdXzEQQ2nBYfJ9F/ckmtPfWPM0xNpw59m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDvz7LLb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b7892609a5so3842742f8f.1;
        Tue, 05 Aug 2025 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410380; x=1755015180; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzsNue1EiCY6bi1jTjxVYfQO05vHAxYAdI5gi2RiJlM=;
        b=nDvz7LLbU6OKlbVxMnNBPh8r6hJcTm8ymI90n4rzH3t2kMJyhDeu5tJhjDDyNaEaSD
         VZzIVwvCkcMutqJlvyxAbXDOk35kb2Uacv7YhstRzyN8OoUmax6E/twuJ7sCbPSFDdLh
         6R0wnVrRsSJta3W1Cd+Snkk2XkLPNTWildmFZEWna7D2gUD4wKgdaI7YxYuIcIMywfjr
         a0dnR08fWLOBIJax8KdaUfayYxopRrTooaDqdG8sFbaxbFsydqBrgEcsyxChTCCG0NGz
         +iFtc9KJ5cLAi1E8rNfUedNq5fuYK10mzAXConJJsLz+DX9KQ8S0C4xi2qNs/tCoNMsM
         J85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410380; x=1755015180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzsNue1EiCY6bi1jTjxVYfQO05vHAxYAdI5gi2RiJlM=;
        b=hpwY9waZgNW8uroIUWTYcbot4AB2M+DYQcY/W4U9nrCmgegzsaidZ+dbA7VX205mXM
         NyOZvWJJSdl1rU3X1giGHOgy8Ce0gISdO5veNtTAUW2XON0gwVBmYhO0A4xuGgJBfOJk
         N4kBAhQKnIqP0kgzASwoyEeDUc0MTqKWdwUZepVI7cT3aJj7qsuqzzG3pHzsdymDYjcc
         VLiuTao0u4OYaJtBahDzb6A999yXn7XwAOVY3SuolLphNYbMq4TwhId3AvtaMVivJddZ
         YlLovFL97W64SIef5HrEIE1q5mI189oT7QkV5Ur+aSWsOmIJj6cAy+to83FW8HfEphWd
         ZJug==
X-Forwarded-Encrypted: i=1; AJvYcCV7t7KzNujtRObDB5gYnaX4ALoiFjzJZLGSuSALwNjRfuiGH7qvJpkLUNTEmH1JKX5wox4HAqDWnNMFHFa6@vger.kernel.org, AJvYcCXDmHZxSYBBX7jeAGV9c+bwkNi7841RSWzEW4RVrg4YC2ohHbPSSWxVzbXx0/oj+q/UUcrmcfx4cZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oGstuwl2bmf9YDBLstwMMEO1bzbvwFcBAY1YQ7tG3IAAXVjO
	Lo84CzZFP+50E6oYT1Ept9s005S4x18wEP8NdYkSlg0FjhaI/skL+jnkXp0NNw1d5Mg=
X-Gm-Gg: ASbGncv21SSDSPTyEPI1Tqm5AtTYgTZFsNEwB0ZtuGyoGxfJsCUAUCw2gF+EH6IenHk
	3ney6Ao64r1qYiUUjCOg5XXKm7FUiKFisZ6hkAfGdFKbndackyRpLejgk1kM0pSdc74uA8x2orc
	BtqbmS5+u7OTEI4EumHafZz5h1LyeYr19HR695VQoH47JvBZ6gZf/BO4U9f/tqIbgbTIj04b4z9
	dCv0nGQDmpqxZjOsZIEeny7FjlOq6h1p3xJpJ1U9eYpRm1hHg0CsN8V7oaVVOPaLqtBpWsp+rJf
	785aD2WDw1yHQsD7IV0Jkh3eOQBstJpdvb+SsnJ3cdQcusgC6SVhTyXG8U5ji0WR5tGDm7zqfm3
	USBxRWTgaq3Ex3xdCO9cu9Aqk
X-Google-Smtp-Source: AGHT+IHolTUHMxnP7yndz8Y5Ygqi/TZevGAglqlabKFpduqy8MXl7UxdhPlxqd5xzNJvKgb7jD5XCg==
X-Received: by 2002:a05:6000:2584:b0:3b8:893f:a17d with SMTP id ffacd0b85a97d-3b8d94d35d6mr9257536f8f.49.1754410379436;
        Tue, 05 Aug 2025 09:12:59 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm19832869f8f.64.2025.08.05.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:12:59 -0700 (PDT)
Date: Tue, 5 Aug 2025 17:13:15 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stefano Manni <stefano.manni@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad799x: add reference supply for ad7994
Message-ID: <o4snk6isxzpkgmcgr7ff2zfuqwqvd5mbvbff5d3cd7jspiljwb@pv57a63fyfin>
References: <20250805142423.17710-1-stefano.manni@gmail.com>
 <CAHp75VfCL88GMSRYnJ+wh85Yj_RrBztSLWOvQJTapVdgFerMyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfCL88GMSRYnJ+wh85Yj_RrBztSLWOvQJTapVdgFerMyg@mail.gmail.com>

On Tue, Aug 05, 2025 at 03:13:06PM +0200, Andy Shevchenko wrote:
> On Tue, Aug 5, 2025 at 2:28 PM Stefano Manni <stefano.manni@gmail.com> wrote:
> >
> > AD7994 supports the external reference voltage on pin REFIN.
> 
> ...
> 
> > -               if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
> > +               if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)
> > +                       (st->id == ad7994)) {
> 
> Instead of making this conditional longer and uglier, it is better to
> add a boolean field to chip_info and just check it instead. This will
> remove the churn when any new chip will require the same change in the
> future.
> 
> So, please make it two patches:
> - introducing a field in chip_info and use it for the existing cases
> - add this field to be true for the ad7994 case.

Agreed!

Plus either is already too late for my eyes but I don't think this patch
is compilable.

- Nuno Sá
> 
> Is it doable?
> 
> -- 
> With Best Regards,
> Andy Shevchenko

