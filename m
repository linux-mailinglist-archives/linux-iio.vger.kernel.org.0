Return-Path: <linux-iio+bounces-14478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F09A15E74
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F13C1666AB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56A19DF48;
	Sat, 18 Jan 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6bc8a4r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D9A95C;
	Sat, 18 Jan 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737224510; cv=none; b=h2dSMpt0Mvu/FSfR/bvJqB15VjNDJJ1XGNFrXtLGsbWPmdF8A3Bi17XclTvOhdg4CDbaWuZmkLAQdqyYx1QKGe0Rs3nSP4lYZDwKgDVgguXXcejY5k/DNWhWcBLqIMmEuGGu6uHLKtTxH22+W1my5E+smPqVvkK89ghwlXDXL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737224510; c=relaxed/simple;
	bh=a9SqrLJPiCqKhkq3VFMoF49aX14krdlcwesZawTRMJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9hhQLNMg88Ri31twFXbMya4YRK81BPOz8g56vgRPp2UW+MDW7yYn1hCEAQMYU1f+n3BrUF946HOfVhicV6DW9gqMlgu2A/dLm5hdk8SdWvXzsdnhT5iUlsiI7gPA4jS34GZQhZBQCZ3ltYzZPweU33C058nWJZJMzMwpZ5mw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6bc8a4r; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166651f752so75609795ad.3;
        Sat, 18 Jan 2025 10:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737224508; x=1737829308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+rZLrdQTqz1wdIWq/alYOT0NZRMEZRGkf9NlCmKGy4=;
        b=H6bc8a4rRAViMCISSc5voZZXP0pjN+aB8PsLoPsUxzFXIJsHT0Zf+r8S5p1usVqtUC
         hWmoM9ilXarTbkAVmgL1Y15eP3IiIjhEI0GA70v4xEREL4/yZNtaxdfHBpHL59iJxYLd
         gR60Ehve9xad9A2x+PSJfKbEgRPuGp8/yt0dMzTwcyhV92iTrbSQBsEOhuLtJQeKrXRL
         PzuqSIc9L6+Lqe+IOqWCxPjQa6abLLC8laSlw/0c4XqVs+JZu2MudjfDy+RqprW2EO8c
         y18ERrbD8X/OZm84f06ms1DoEJ9qvXkms8kIdVZq67x4BF9CAPH8I9oJC9KNxHB/3EbH
         Fp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737224508; x=1737829308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+rZLrdQTqz1wdIWq/alYOT0NZRMEZRGkf9NlCmKGy4=;
        b=Xlljs6u+iwa+4r3HwMnoVYfQaj6Cucaf6REmkrDQyK3sqlpIUDx2il8HPXO4seFaGp
         OUEdhjd427iIYta8FU/0fP3EvcOYZ4W04hW2L2VVf5+rhYyGxB4ysTzSsPO7BM8lD0AK
         YbC6fTfrVkpsLs32IEBGZGMT/GDn6RHtWRAInD/EDAn3UFBhO0Fli+e4wuUQn38BY3pD
         lhNJC7f++x/Dtr3C7G5MCK8lG0mUW7nfi304H3wNv4jPDA7a8Kt1G8KWAFR2a8ijLgC7
         Mc49vvwMA73vgvKNy0aooOjDlB4xKVW3scl8ONUBOkDnPpD0qPV5bLhTume6t2nWIyMj
         mT8w==
X-Forwarded-Encrypted: i=1; AJvYcCV5EIkFOUkCEUH4JRAXSPFafj6kVyZ8hFEtf2hvvtWsvvL3j2WseDS7PdxaIE7R1l58U6f858zI4pv6FBg5@vger.kernel.org, AJvYcCXTnz7HNsICdAwViDpgAfZH51vMJ+Oyrj76XwbzVLrSpiEgGBW3QwL9rMB6nQRFSZnmh08Xxxb0eTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiI45CDg8FEA6hoAKzGFA9Hc4wKICiTX5Y2Kk+xKWdkJTr42D2
	sCVCGOSi0jEo31Dq4UryqwXqGtO6iKgQywnUNJOw9lTNJgUlAfCS
X-Gm-Gg: ASbGncs5secWJPJXVOAZQhrZ9XAq8GRvZcSSM0yQWmFPUa0zLKLmhE5n6EWI991WBaa
	ec/2gDdLe72aYXpAtYHMxlLcyepitW9SkL4JragfhJJZALoxswDyBa8KTxXKlYPV2cOspBF4IXq
	zkWCHuzaf9pos04BoTjwQ+0xGl4r9BXMMlDdlqkMofkxq4v1qDWKi7ityTzONy1oBNxVrruvFcK
	IpBRYP7ZLrWKb0IkQgqAMAsBDQfYtkUhAhqDc7ADqQkLKjwFZXwGT0=
X-Google-Smtp-Source: AGHT+IHp4vZwUy68IcLB+PGZgQRAVOssO7F6UgiLL/G85mDXjjZPb6KkwXAlFUOGUgF4F+HaTyz1+Q==
X-Received: by 2002:a17:902:e5d1:b0:215:6e01:ad07 with SMTP id d9443c01a7336-21c353ef811mr98463005ad.6.1737224507929;
        Sat, 18 Jan 2025 10:21:47 -0800 (PST)
Received: from archlinux ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ad0b1sm34419985ad.144.2025.01.18.10.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 10:21:47 -0800 (PST)
Date: Sat, 18 Jan 2025 15:21:41 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi270: add temperature channel
Message-ID: <v64q6kkwf6akdyjzvs2xqcjgbiwzys7zkf77p5bicv4ggsukns@fwoe3qqxzef2>
References: <20250118-bmi270-temp-v2-1-50bc85f36ab2@gmail.com>
 <20250118170038.21cfa888@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118170038.21cfa888@jic23-huawei>

On Sat, Jan 18, 2025 at 05:00:38PM +0000, Jonathan Cameron wrote:
> 
> Applied with a small tweak.

> > +static const struct bmi270_scale bmi270_temp_scale[] = {
> > +	{BMI270_TEMP_SCALE / MICRO, BMI270_TEMP_SCALE % MICRO},
> For consistency with local style (and the one I'm trying to keep to across IIO)
> I added space after { and before }
> 
Noted. Thanks!

> Thanks,
> Jonathan
> 
> > +};
> > +
> 
> 

