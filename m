Return-Path: <linux-iio+bounces-17323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA10BA7567C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 14:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742BD1893517
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828351D63CA;
	Sat, 29 Mar 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYTUtJzx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D031CB337;
	Sat, 29 Mar 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743255631; cv=none; b=pLWOSYK1ANsedJCv6nrTnolJL+1AkhMG29CpjNMkvFKnYXFDcDlExtXmGxUmZb/Bm+VazkAm5SyIbjyubndQw2bDHXGqMTU1/5waNexHKh1myuoN/ysYFNk4MB9xXhVrVkJcqMFkMcARHqMufijosyyAvGrareONNmOh3pGUCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743255631; c=relaxed/simple;
	bh=MoWzeZWOTaAKgwFTjQ36mqg0XzzUVcbJKEAWJVJs+KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyfOrDnuer8MJfi01W+lQmQ3xQ7sZAw2CW/ZXG6gYb5+AoW91Kvb5Pd72LCEt9DykieApAKWI+tKHlGB3JzULc6t3SGl45dxvTBdzX5PW7ceb/9BaxxngnclQRST5JghVolGRmdt89Lr7h4+NWDdczhpp4QHG5dUtD/X2Gb4Q18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYTUtJzx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so66313515ad.1;
        Sat, 29 Mar 2025 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743255629; x=1743860429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dAst4F27VW8K5mYgO/xzjAOXmOxFERt6ayMD9R7JYo=;
        b=CYTUtJzxzLB1qIMT+3a1FXyPowww7S6dCya/mSlRJ3mghzsaKjTZcb2F6LTqjD/ysN
         M1tlfjpEt0q+vC/cLG4Edz0B6C+RIM6JEkEXc/doy1Bc1/xG7ZlEfF51O2ocYVMvkSAs
         RHwTMFhjtHWsMhwHmUCLQ4QHHZ+D5o0nJVQTL+wgWZvowmZAHFU+VTpueXgLzoLW88YV
         ygbQvzPgN9mRmfeVvNojgkq/AycpUsfSAXuAwmh4gjP9SQVgv22kj/kxFttsmlWkQtTp
         4MzprROhYiCwwv9CXoJBQ4B7ZUJb13K0v7mKxcMINNclPoDqOYXjpUdZptsn9Nc8HJMc
         bOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743255629; x=1743860429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dAst4F27VW8K5mYgO/xzjAOXmOxFERt6ayMD9R7JYo=;
        b=CJ67iyTtkH8lwFyCdIjKAKn0++YxE3NsjVCuQao3OLQWlY5beN1CLtTKu5/23FZu6v
         nBT4gqu6rtC71tRSMQA+nZszmVxKje72XNg8PFubkGdWQiRlBiwXfL7kO0UhA+WoTFTl
         BG41DycY55MJkK4sGTIC6iHkBAFTtbNJnTdgqg46/XQaQnuakHz/7tpybz8E/HzP4Q/o
         2QEqnWPaHlT77S8EH19TppUfryAxkIrdd+A7LLSJSB+YRH3dr88Msj3qPfSYyTuhfbYw
         QnYy+sXr8bbN/PzJZD5JkwNuk631DhG30OriAwKIh07xEkeFe1gYBeIVhallxpIlNSr6
         UxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWsEfPL3uDD9F7gn5O9Dn9BpWExdO7kPuj1YXGVPNinHWq4sVnnZi/K65EeM0proqmhjVSKyIgG9d2hK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+MZrCovlXW4a+PblM69xfsEV7NhoM2OtKKNwgELxwRPrvmt4
	5mIneGoJ/UrTo2foDL6lDWTjzuCGSLSYTP9Yg0wQH36j6atdO/fy
X-Gm-Gg: ASbGnctkRdKJNb1KarFsUdKyUmNI9jc0kfFQtWh6o88P4PvPRMOjSjsacNLxnzGvVYh
	RmT2wm1181CIIgtaNtKmDDZxAXrSVrUnO4wd5U+jp7ni1qlU5N1gnzY5K/wX7azCi9X5hpY636d
	W3i0iyoBXtpfX/2NoEiSMpIWYw28bSpiv0P2U8Pd7RKFW3krpxHziF52S9B2sbL/ovl/sEMKN0d
	nh+HAf855KegV2duXFAEX+TdnO3/ZCkAseMV0eLqAIxNi1dj7S3pLWz7fwt5GEn1kj8lv9WIPuB
	G7MfMRth9dzGKvzA5vE4mkxehlKOzH+f2DTBbIA9EniRI/4aF2PFAA==
X-Google-Smtp-Source: AGHT+IGJjEMZtKoHgbsGX+ALAGZjFxOcU2Vy33m106UeqkLR7cq0fKX2dLrtPTHUTlpHex4xYcNFtw==
X-Received: by 2002:a17:902:cf0e:b0:220:d257:cdbd with SMTP id d9443c01a7336-2292fa01b74mr53629935ad.48.1743255629078;
        Sat, 29 Mar 2025 06:40:29 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3051cd9f674sm2350193a91.2.2025.03.29.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 06:40:27 -0700 (PDT)
Date: Sat, 29 Mar 2025 10:41:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <Z-f4irfx5Jtz-rfk@debian-BULLSEYE-live-builder-AMD64>
References: <20250319045212.72650-1-simeddon@gmail.com>
 <Z965Rz8NuXhbHrgy@debian-BULLSEYE-live-builder-AMD64>
 <CAGd6pzNW2JKxTfQ8rLD8V7bdUgq8fc0R+ayChf3J0VdRm9Ptrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGd6pzNW2JKxTfQ8rLD8V7bdUgq8fc0R+ayChf3J0VdRm9Ptrg@mail.gmail.com>

Hi Siddharth,

On 03/25, Siddharth Menon wrote:
> On Sat, 22 Mar 2025 at 18:50, Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > On 03/19, Siddharth Menon wrote:
> > > Refactor code to use the FIELD_PREP macro for setting bit fields
> > > instead of manual bit manipulation.
> >
... 
> I shall send in another patch addressing this.

My understanding of Jonathan's reply to this patch is that it would actually be
ok to do all MASK/FIELD_PREP/FIELD_GET cleanup in a single patch.

> 
> > > -             st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
> > > +             st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> > >                                       st->ctrl_ss);
> > Not sure about this assignment with mix of FIELD_PREP and non-FIELD_PREP value.
> > Maybe have
> >                                        FIELD_PREP(AD9832_DAT_MSK, st->ctrl_ss)); ?
> 
> From what I understood, I don't think that would work out. AD9832_SELSRC
> = BIT(12) but AD9832_DAT_MSK only covers bits 7 through 0 GENMASK(7, 0).
>  It could exceed the maximum value allowed by the mask.

Ah yes, that's correct. I didn't look very carefully at the assignment
surroundings when replying. Sure, it would use the BIT(12) mask. So, something like
FIELD_PREP(AD9832_SELSRC, st->ctrl_ss)

> 
> Thanks,
> Siddharth Menon

Regards,
Marcelo

