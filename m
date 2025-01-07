Return-Path: <linux-iio+bounces-13991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806EA04888
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 18:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D742B3A6909
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E11F37B1;
	Tue,  7 Jan 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc5N//jm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1771F190A;
	Tue,  7 Jan 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271828; cv=none; b=l0s5tQB2QNuAiYOfA6BNS7fClco9aXF3c2llNwSXmPTRaDUIfnRcLa26Vz/dqHqVL7iieGDlFrQvjPIeVJKQeFP2OPKVIwsR02Ps4ySMoWD+yCEqysFI4VeukdJz3jtuPnBnAAMNeXpzwtLRXkPFsAVXGdP3YHMp1QJtWqJVIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271828; c=relaxed/simple;
	bh=KRHyw9q1s/cHYGSRtD+9s//Kr0BvAbVRC+5cKog7fsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhSeErZ3/j05jP5nADKLAV7l5sRZByayOHA6szjGnkwfzcRotI8mzKmMHfkoGqAhnYoKNhGY/OdltPL7QkyVOC4pPkpm2zV064ZeNDv0rgo25Y/NbLepjUtGGyWepsQkLgW45v70xYPVOVRauc4YYkJPLyAg6Nxnmz+Ltiq1ns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc5N//jm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216728b1836so213448065ad.0;
        Tue, 07 Jan 2025 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736271826; x=1736876626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuYt+M8lYYDPZKXJxw7vUTqWWPNo4Ab4w2LDMtwz7gw=;
        b=Tc5N//jmyXPrNRHbLIxymo50Jybx4ZS4EknqMWKA40dbDEF8S/juZF61o0XEAd0VQJ
         0Rxt1cUp9tMW9l/2V+yB+OK1wH+Uk6Dz/OiP4WzDlDFXMh1aaEMKScwP2N/mBwQD2jyN
         vzkuNEsRXfZuTUSiJ5ULsrQQgrs7QA5/UAUhF1C/+XPuM5SXxTmudgOBspKUH8dtjDg7
         fYoPxsFGy8n0Uw0nBL/ZBawuO6lQE8SF4FTR3YdZ0SLgDnkhIr/ibTw2t6DPZLq4Wjni
         s5HPkcobmiiEciglsHhETMKtQoOqLOUKszVXVbJe6JbzEb2VMazJz4XtmOV3wGwmZKAi
         Lv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271826; x=1736876626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuYt+M8lYYDPZKXJxw7vUTqWWPNo4Ab4w2LDMtwz7gw=;
        b=NL1rK0GJ9BAHe4809IUdF0bFzadlA7kh9LZPQM7dvE/onZ51f6VfDmHn5LCW9773Yh
         HC6SJAJiUQBJfaIs5LcIK/nGXMNoLDyk09c2mWYMw+ssW7ia1tmb5hH3CISVlasTUN5A
         6vEqzoJ7i12Eku+SI7KPXi7yferPlkEGQ5AkPua6iqF+g9UXu0hZM1ReweXgJYpmt6Ny
         xQs+gVblP9EUXM4pg2D22Yuajqd/N84clI+P7YWVOexg3Qe1TBGX+qSTWciZt0RrzzmY
         tVRlMY7W2m8mRQiHz2P9FXkDGByNeyZGqqzZ4vkyl/t7X4m9JPc7q/BzburHPhjXHpv9
         0hUA==
X-Forwarded-Encrypted: i=1; AJvYcCWIcOYcI5JDcZwm/rlBB+HiG1KjkQhReoqsNQYjGUfpGl9rlSQpEJVVNxhzzr4El0gX6DaCVjKTJaRZIeXJ@vger.kernel.org, AJvYcCXj9cnM1ve0ZqJk3I0HpT4Du8CXRjjyZxEm8X8b6sDs5VRXpgA3uUIDbDYXyPsFKhDJp9zr6opvZLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjM3CZa6f8GSNTmzFjv+/GsQuIYj65bJgRTYmYax7Wf8ykDmyK
	74mnoHZgYWIjx1uMPufT/MWdoqQpmQ9d/4VHnA7tKVkAAoeWBHI+
X-Gm-Gg: ASbGncuZJ5tyPnGeFkFA2YqRowp6eDLPmyQpCW/4ZRvt7PTdEE+k1ewZ2BHWII4Vu83
	eWx4t1kahMTJD5tuao+ULaHflve2tMcNOeOVkGX0DjWM6t+4P3rrpiJu/+DKRS3Uq0Pt0ZJQxLf
	x+E1gmBim/y8W5EgCdk7ucPL1XMltsII/ZG5kfOGO2lGPcFdZxOgWGIXzi3fhznDynAQtULVjA9
	TVbhAz2uzB3KgWe056JQaoCAN3P9uKORl+EIbUgpRQuGE9senPKl/CMCw3MJgskhmQ=
X-Google-Smtp-Source: AGHT+IH7kPTyfBQm7QBOkI2TPP+L3n9YkLlmOAOc4wM1GXJzqTs3qi4t5NeB8CQKk/U94sywb3JYHg==
X-Received: by 2002:a17:903:27c7:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-219e6e8c92cmr672264715ad.5.1736271826489;
        Tue, 07 Jan 2025 09:43:46 -0800 (PST)
Received: from localhost ([2804:30c:4057:c200:dfe2:5075:a83a:1a44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478ac95csm36147558a91.49.2025.01.07.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:43:45 -0800 (PST)
Date: Tue, 7 Jan 2025 14:44:20 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, cosmin.tanislav@analog.com,
	jic23@kernel.org, lars@metafoo.de, granquet@baylibre.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2 0/3] Re-add filter_type/filter_mode
Message-ID: <Z31n9C8FwgzV0hs0@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
 <8db7c0f5-449c-44ab-b92e-590dc697baf0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db7c0f5-449c-44ab-b92e-590dc697baf0@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:11 AM, Marcelo Schmitt wrote:
> > Better document sysfs ABI for ADC digital filter configuration.
> > 
> > Change log v1 -> v2
> > - Split into 3 patches.
> > - Re-added sysfs-bus-iio-adc-ad4130 to keep filter_mode separate from filter_type.
> 
> If ad7779 is the only driver with filter_type{,available} attributes while
> ad4130 and admv8818 both have filter_mode{,available} attributes, shouldn't we
> be deprecating filter_type and promoting filter_mode?

Oh, I had only grepped the adc dir and I didn't noticed admv8818 also had
filter_mode.
Hmm, don't know, though still biased towards filter_type.

- The admv8818 filter_mode_available ABI exports different values (auto,
  manual, bypass).
- AD7768-1, ADAQ7768-1, AD7768/AD7768-4, AD7124-4, and AD4170 datasheets
  refer to sinc filters as filter types (though not all of those designs are
  supported in IIO or have filter attributes).
- The AD4130 datasheets also refers to the digital filter as filter type in
  some occasions.

But some datasheets seem to use filter mode and filter type interchangeably
so I don't know. The admv8818 use case is valid and is both low and high-pass
filtering while the ADCs sinc digital filters act like low-pass filter.
Maybe even provide a different name for ADC digital filtering?
digital_filter_type (or digital_filter_mode)?.

Thanks for pointing that out.

