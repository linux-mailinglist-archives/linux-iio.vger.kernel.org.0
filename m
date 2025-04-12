Return-Path: <linux-iio+bounces-18032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD49A86F0D
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A6E17E94E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD520D509;
	Sat, 12 Apr 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHmbr4mE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB72045AD
	for <linux-iio@vger.kernel.org>; Sat, 12 Apr 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744484032; cv=none; b=Jg+sgeYYHH7USYoR0ehYtJ9BGi7V+jqblB3b31J2z/Ph9nwFd4ni0BNj81XAPIvSK41VJ9qkcaORfOLEAjm/nQ+o9yWZAqv9rsiB3i30I0Alif5nSYXpA2fLJDBrxXgA5TfnjkHW48cLCPjjDr0ruK0a0EdilSHUbsOniaeSHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744484032; c=relaxed/simple;
	bh=5r5/vvbgyopJ6kfdjoC8mkXlBqF8ZIzF+t8YYK0Dtl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM8/h1iEsLsEhnpbUI5aWuegWFpohLvTdW/WuNBh3jijUx6xXf6dpoOjUjUxf5zOh4S+s0OOMwT4Vys7SxctSTJBnHbil7UhVbGeDOtwwM65LetSS4N9gbXIseRX5Vd67T82XC1LkmrwHG0yRVJcGohZH/Qte8THf7IkdyLWkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHmbr4mE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso33319005ad.0
        for <linux-iio@vger.kernel.org>; Sat, 12 Apr 2025 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744484030; x=1745088830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2amxAQujXkkKwLd+ABv273ZgDUskjFf8T85YTacE7YA=;
        b=JHmbr4mEVROr6xi54163IeQTEc5p7gHMkx6N3pJfwDH/BA7JpHbHZ5tVQ/WxLPQ84c
         2E+FjtY6bI85+IOHsnR4TlW9y3JDUU7n7xImKkeZYbMslwrF38uINTFvtqjH5+o+TyFx
         9WZRM2Vf2mDdWZibVvEj4wHBt6+M5C9d1u/dZnBD7DSei3yzHkGjmN6E+jLIUzBfevLP
         4kV9h/yBvSkMJqFPy/KnpJts5S6gLXPZ6TQ9bHpl8Vs0gQgN6ww0g5O+pkmfdc929TE3
         tdSqA0iHzInf7ceP5/G10i3gHtpvLdioplVUN269EkD9BwrHVJ3cgZqCPjUFNt12A9vo
         0P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744484030; x=1745088830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2amxAQujXkkKwLd+ABv273ZgDUskjFf8T85YTacE7YA=;
        b=R1s3z90MIUQmfjIxNCQwcDrUQAcj990AT+hAJ4ayGCvuq+LQEnG+XovxzOctd2h79a
         60Z7TtOtwKHbX+nFNcBhXCidutF2jFPqRXKcN4S/VclTw4S7JaKLJDj34fkv6IEd6ihl
         1GjLQoM5GuCaI/bWT4LsvZP0W39yg8i2/dgRHwPfHe25liMtLjD63Mu2okaOzv0J5qMz
         gzExFjp6pza5iiJ6i/awp1PLkLUOrw3ar4LYxBWNvGSFNMNb3vUXGPHc8lC4+kowtrKP
         Rhclo79PpRhkbV2rv6RJrvLeYgTEkZibDRT8mOXLDTsGiqeHlaWXBLbSzdTJ7Np0tjBW
         fMxg==
X-Gm-Message-State: AOJu0YyvruCOVGzTLVq0UB1py51vgwNQPzn2oEa8GL0hCVVim6usdelN
	a9csjm/zb6+X0E8JzBvt9aIh5iBWSAHErrp7y+/KXF00GixxZJaz2E3Znzjs
X-Gm-Gg: ASbGncukC/krgJ211UCRdiFobpxelXjNEZ3v5coZqmUIviK06ziZYqiQY/CuJdr1SFn
	OJ2k/OB+SNjoepXGkcsHOqwRj14ZjW6NqysjSHflw9mr73iuYMMugxRmkmxeaZE5F4wAk7AyVTy
	yqHdxE1Jg3toI4+4mTuaRXWL0uGpftwYrlYLvrjtbdvbfCjPPfghtR3lWFb/EiakLO8kFEmfVe2
	G9EvSGC8QkCVIyQq2JfutR/VZltNzshvDVR61BTvoO0UvF6xwEhNulK4fYYUcsyQQW+apgxuFoO
	XECKqXd37VRqOGsljxeHzR0F9VgNdx2a4+putHFmLyf/hVc=
X-Google-Smtp-Source: AGHT+IH3Eq9ul9IOig6qb87If0xgtjhnOTr42tmg0TrwWCSCSMVStu7RkpVpL+aG10jkFw/XaaoqnQ==
X-Received: by 2002:a17:902:e745:b0:224:249f:9723 with SMTP id d9443c01a7336-22bea4ff19cmr94589215ad.51.1744484029503;
        Sat, 12 Apr 2025 11:53:49 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd21c62c3sm3858124b3a.52.2025.04.12.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:53:48 -0700 (PDT)
Date: Sat, 12 Apr 2025 15:54:55 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/37] IIO: Sparse friendly claim of direct mode (the
 rest)
Message-ID: <Z_q2_8x9DO3LI7K8@debian-BULLSEYE-live-builder-AMD64>
References: <20250331121317.1694135-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>

Hi Jonathan,

For the whole series
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Really nice series IMHO.

Thanks,
Marcelo

On 03/31, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Firstly, sorry for the huge patch set!
> 
> I've run out of signficiant groups to break the remaining patches up into.
> Rather than have lots of small series of 5-10 patches, lets just have one
> mega one. Feel free to review a subset! I'll nibble away at this as reviews
> come in and post a v2 later in the cycle with whatever remains unreviewed
> if that is necessary.
> 
> Note that a number of the drivers touched in this series have no
> obvious active maintainer, so it would be much appreciated if anyone
> has time to take a look!
> 
> This is effectively part 5 of what will probably be around 5 series
> focused on moving from iio_device_claim/release_direct_mode() to
> iio_device_claim/release_direct(). The new form is more consistent
> with conditional locking semantics and sparse markings have been
> added that let us detect miss-balance between claim and release.
> 
> More details can be found in the cover letter of the first series:
> https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/
> 
> This series focuses on all the remaining drivers.
> The final patch removes the old infrastructure.

