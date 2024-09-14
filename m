Return-Path: <linux-iio+bounces-9586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D59792A8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB531282A2D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2961D1305;
	Sat, 14 Sep 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT0mQG9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627341CF29F;
	Sat, 14 Sep 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726334860; cv=none; b=D5sjx7gd7qKS5Pthz5LK/2amvBOM/T+UUvqEIJudbbXitR1ejbUM9dMjEkh2lWcnV/9c/px5FpnlTueoJs8kae/UP7oizd56cZeF4y1Tt7OaQPdLfIOUU8j2V3YLMbGRFXuS61Ub8Wek/1zhd65hXAC8dXtv8uTCeKMnl9IwrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726334860; c=relaxed/simple;
	bh=G7MGD6YFlVzcoRY2U5cpBxTQS4KQQJAjDF4qA7NCnDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMO+9Ak+atyrVM89iZfEyEti2cNOy3fLGNiOBtenBYkZdznri32EXvb2KSNM6diD2OFTztqDtYwHYjtNuWHNNPyhS29UR8pFjZFs0Ztn4ATGcgDjcdcEQ7C6Fd4TniUqIl/S6OBF4wOAqWeSeZeIlho1VcCL40orLAfGUQjSgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT0mQG9h; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so3056433e87.2;
        Sat, 14 Sep 2024 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726334856; x=1726939656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ua0RwIdNbsjghsvTrAc/40v+bEWhVeTz6+XAYW2j+4A=;
        b=kT0mQG9hcMSyNMtGcvfbDW+oflOI6na8TEVsLm2xEannihdl9/McH67K8dz+q18YUV
         uZvWDOpOaD70qdV9Hb7kn+q9MUvclwrO4MDiHvEw/noDa3N9Q1Qri6dVe+d/SGsfxmYQ
         gfJiWVMyNMuO9wHB4Qli1Ry1caIyVssel5gFE/nEAVYxCziMWYseXOYUd8DUS0W2Etqu
         CcleEusAWfkQku0rZXss+LVg1wHGlgHCKLqQAxiywW1l7aog6Ghc5etjxHQTd7kmuxsx
         /qFdfMeWGsOYXLZcSlA4Vp+ty2K/Mz74CYrVURV8200R6vpTTpuU4lNH0iK/b5kof4zk
         uUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726334856; x=1726939656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ua0RwIdNbsjghsvTrAc/40v+bEWhVeTz6+XAYW2j+4A=;
        b=a/hnu9A0SolXE8efhp5HfvaC6W1ZiS7dDO9lntko7JMbbNlWaT9NkGsKqc9qAxGe05
         mrehGjjOXJGFgRqtSEFNNX5Stom/fKHLgasGHpofx4tFtkmqOX1yx2fsZGiJ5lTt0fCN
         cJWeCnWBUH4TrU4HyXrX0uPEjc22Vjkk2mAtoNIfKooj/iGURTT8JT+ODGIG+bGPADCN
         +gdnAvqS7U/ft+xrP3voVM0H/lxmJ8G+y2W6i/nYWOjke+Lydsv+abcd44lCcn21UhK9
         l/BdOalMFIza+Oj8/dUCbw2yqhoXQFfGgfNGELgeIxISYV9NQZaatKn/3vQWY3G/ax1E
         bGZA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/OPc16mmp2iFAZIVp7ECTxhsRug4NkO8CXMkFC8lYMsXe7+zgVgxXt5ic1Zig6xoMvckF/3Dhs4t/+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4mJzlHKuMcRXuZBoLP0TJn0v+5J7gvWYbw6p+5aMxAlbWJpA
	btamUgh87aV/JrueANXE8DWqCshak6MnyhzquqyoJboPNthE/JeqCFwMBwdYE/y7Xf9kZWrQqhi
	hHvgTBmri2NS1jchfiY77vh62so8=
X-Google-Smtp-Source: AGHT+IFx1ixGYkC8ziz1GzRu0FxwU9Yc1Wopig6eol/64aGuDHuzaI2KsiYl0tNin+B10ZefRsd+N6ESwQMAyPZ3Ndc=
X-Received: by 2002:a05:6512:b9b:b0:536:52c4:e45c with SMTP id
 2adb3069b0e04-53678fcd1c1mr6260267e87.31.1726334855953; Sat, 14 Sep 2024
 10:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
 <20240910045030.266946-2-abhashkumarjha123@gmail.com> <20240914144402.16486b79@jic23-huawei>
In-Reply-To: <20240914144402.16486b79@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 14 Sep 2024 22:57:24 +0530
Message-ID: <CAG=0RqL7y-Dmi6nAibkGOr32ufmMHS=pGjgp_7Er_oBTMqEszQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: light: ltr390: Added configurable sampling
 frequency support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi Abhash,
>
> A few minor comments inline and an (optional) request to cleanup
> the mask definitions in the existing code.
> >
> >  #define LTR390_PART_NUMBER_ID                0xb
> >  #define LTR390_ALS_UVS_GAIN_MASK     0x07
> > +#define LTR390_ALS_UVS_MEAS_RATE_MASK        0x07
> These masks should be converted to GENMASK().
> If you don't mind doing it a precursor patch to do so
> would be nice to have.
>
Can I do the mask to GENMASK conversion in an additional cleanup patch
at the end? The patch would clean up stuff related to newlines and such.

Meanwhile I would use GENMASK for the new ones

Thanks,
Abhash

