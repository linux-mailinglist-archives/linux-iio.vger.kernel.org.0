Return-Path: <linux-iio+bounces-18121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BEEA88C32
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 21:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F2B174DBB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBA0288C9B;
	Mon, 14 Apr 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1UMjU8o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1213CA9C;
	Mon, 14 Apr 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658463; cv=none; b=hUznJxtZSMI9YDzEHUIMAEh1ZO22rlHzn1qJ0aL6xx8LPXXjsgTXuq92+wo86mod8NHLDPD2HtZOg790SpYkeTfCkKj1NMOc726/miIc7O7qUF/b3akP1hM3gsGZSQYVmls8SUUeIyHYFlKFn7F3a++IPno3KDHS4C1crUaJ9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658463; c=relaxed/simple;
	bh=ZWvlEKrL3keG/czpO6zUsgNhEXBnOerwPZIVy4wx/cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8Eq7425KyDNhj67SCBedVS2BhcNPMLMJcAYVHd1iWY18O9060l7TmRBvDoMnW+l+y1HTpqZ1OidI8q7YRSVieOoNsp4x4RPfz7Hu/LPWyf7MDT3OhJn9UvkpgWZMVEJSuH2/lqLCNBo5NdiYzVkWuchC77xTG6tuZRJ0Kuhh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1UMjU8o; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso3286198276.2;
        Mon, 14 Apr 2025 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744658461; x=1745263261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=obROj9OHt/C3Qb4hnrNCME/v4kiPzy4k+fmQTcyUCNU=;
        b=f1UMjU8o108AR5Mq2SSN9bzYOkTZzwblOngA8K3+VmXEmbjEluJcJ/6shYQKxaO//E
         rwCEDrr+4p2BbduW2SX15o5kk9vawO44CMaWIlybZn+UOOPWPMbT2uOc6+cQdrhmzUxR
         pbQTG9+9lIs79Az9s5nHlzc+055lJ4JJPcfU8XWdj9B+YevW3YqGdb58/UuyEjZoghrs
         TLlt74atBJuBfaKW8cqXHLkXFM/DLjQsoMAVVVvAPbeu0XtM6gBqRBumFGKo1E8OtW/Z
         /Uq4gn/XlPyItrgVC9mMI0Iq2R/MyLEZi9Ef9f+683nIb4+sTglykQUomFLxGHPY/7uL
         iVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744658461; x=1745263261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obROj9OHt/C3Qb4hnrNCME/v4kiPzy4k+fmQTcyUCNU=;
        b=sGqRjZcT7LIpoRHGJQzXgJ8BZR4j/QnneoHINDY7zZIhD9xJ0LhbmtYcLYcH+4pd2w
         VKzYy8o5DHMyA/8cLTEqllat3YuIYsv/XbmU1RZN+P8w72la0v6PTbUtOjIo0x1pn1V2
         GyId45+STKCpBSILCUoo8KnFixW3wpwQsZGCa8rjE9eyN+aYBxCZpttVwuDGv+ZVgw0K
         1N45Pz/+RNzRxa2zCXTPn/vsqNOx39A78irgE6UdAXJ8k8uTI29P7n9yX/fINvYIO3Fo
         1Sz5niDMxaEj9yE98cggVZVWZCIUrG8sx2KynjDHskDur18EG06/hEX732DNBzftkeOH
         YmEA==
X-Forwarded-Encrypted: i=1; AJvYcCVSjY0QaPW3AMsD5T1QdosBdhT9EuM7o7DssFaERN75gtTAzQXA5i7hHlG8GQhcuN1aop6N4JIudSytt+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwL0zawU0VTydhVW3R//yD5b6+D6zoccbwi/f2mEG4BNFw+7O8
	+UCVSWWioHvAgjgu3RJNmd5baZJNXdwegPAXUMe1zdER8JVbeuijAMORD0UBXOzV2Ecb8VH7IWE
	+a4TB91kixS38uFl48RGnpI8wOWg=
X-Gm-Gg: ASbGnctviHHlHaCM0/V0oYP8pgQx2+gZ3VOFUNo3jDR2blqvPqseA4mleREwdBzzQDW
	fBRWabfuz7/HaBX9K/MeBO+yr/WwidRWZpQhw8WR0QG3yWNVo+2Vs0Fy8ABERu4R9FAtjvt/mDr
	kUaHiVd6CEANWH8prEg0qzwMrUbKQxDmEMx5QeTIGygtiPrDM+tzGJ6Xc=
X-Google-Smtp-Source: AGHT+IEnbonKkHcOHThRgC95LZa7xC/Euul+fsvazRpNbLbkH50sySzeaHKVSyOmpmCfjkNpaGXp0GdDATuH5Y7sCpU=
X-Received: by 2002:a05:6902:228d:b0:e60:87a0:61fd with SMTP id
 3f1490d57ef6-e704df189e3mr22532632276.6.1744658461378; Mon, 14 Apr 2025
 12:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414164811.36879-1-simeddon@gmail.com> <20250414200312.0b9eeb10@jic23-huawei>
In-Reply-To: <20250414200312.0b9eeb10@jic23-huawei>
From: Siddharth Menon <simeddon@gmail.com>
Date: Tue, 15 Apr 2025 00:50:25 +0530
X-Gm-Features: ATxdqUGTyxPuItWpG94bKrM6IKeqvpWTAaXqlM58GxhgXVO_PIp7E8GKaG5kvrQ
Message-ID: <CAGd6pzOF1LqN0w2WEhaGx41mxPNkkD7E9DQNQWSZEzjyuyuYpQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: iio: Document ad9832 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, 
	Michael.Hennerich@analog.com, lars@metafoo.de, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 00:33, Jonathan Cameron <jic23@kernel.org> wrote:
> Hi Siddharth,
>
> Whilst I'm fine with better documentation, I'm not keen to merge if for
> a staging driver until we have that cleaned up and moved out of staging.
>
> Anyhow, that doesn't stop us reviewing what you have here!
>
> My main comment is that we should be focusing on what is useful to someone
> reading the kernel docs rather than providing detailed description of the
> device.  If anyone has one of these and wants to know more they can
> get the data sheet.  As such most of what you have here is a case
> of too much information.
>
> Jonathan

Thank you for the feedback. I'll keep in mind for future reference.

Regards,
Siddharth Menon

