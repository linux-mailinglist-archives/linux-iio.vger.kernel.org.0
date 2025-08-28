Return-Path: <linux-iio+bounces-23336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FDB3A286
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE491C82386
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FFC3148D5;
	Thu, 28 Aug 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShS8yTm5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958B313520;
	Thu, 28 Aug 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392240; cv=none; b=glUuabgXbMktdbZySenbLxdcA2k5EfGjW0VW9bZy/jB8lgerswKzVz4GbQ4PIV2GiLsCdA8lOiw250Kk/k+LxdMPrTcQm2HoT9V3wxDnZUU5sVgw63o6T8tVdG73lE/bt4pugR2lihlFuCgV5acKDdfp710x6sS7x9ACY34HSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392240; c=relaxed/simple;
	bh=y+wN+lwhqYoTKxVX6uQN/sHMwauGJ+RriAyxhBVnStc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkJTFnMtyd/SKNMTj1AWnKfRIH0+Oz2JTOM1R3qkG3BqybuUBgo8jca018HrNCMWVhZw+k6NOg95q34SrJAUYdAWyJ5soHLc7zVxVN/D+WRfiP7B8ThaDrgZLYAG+devrs+5Gstr5gqjni29SwFxdvpiOg3KsKYAqdewXEMcqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShS8yTm5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afebe21a1a3so182186666b.0;
        Thu, 28 Aug 2025 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756392237; x=1756997037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+wN+lwhqYoTKxVX6uQN/sHMwauGJ+RriAyxhBVnStc=;
        b=ShS8yTm5c9XgJt+uN6yZzT8KX/LR/L+Ks/WF3f3jEWr4EMsN3JkY6qz6Zzk6eLnVdX
         3oJXc79XX62wfcvk1OOzXr3EjRxYW1tYMlFCYPRYs4y3R7zM+1yf3UBK0QYC2EFh9biC
         Hl1SEZ8d4Hi2jbNH/qZqG7b1c/POSMn9nuhOLrxLv/HLjH4eeWZJkDG0IBO/ruu8tez8
         wfj20gUdVm5O+BxF3Wf/lmdbep4Yi07+nZvo0D6eO00ToTuDscaaycKQ8xIXXOnDspoX
         ukgNzvAS6G91j+LhKkjX9FGKotpyiJ4SXbQF/7zc4IKIn6mRiH+nyLigUCCbNWACeTvU
         GBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756392237; x=1756997037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+wN+lwhqYoTKxVX6uQN/sHMwauGJ+RriAyxhBVnStc=;
        b=hbQxvGSMBQzeFo7ib3nEiQZjFAE5OQQVlysFpfPHgHjIVD81ka6NT1E8IM/TsUzfcO
         mNlTogNsZILQ1juOqqYJFZ3zuosUdXmFda8Bi88nT7V1vD5LgdkR0447F2Jw9EjOJJdV
         t84M3C1u1ejqmOxasiCJi5vM61cUDkaYA3sXKUqILpdKkGRIPd4tX7wZWbYlxQohfUhf
         BCgqK1XiB7SU4flq2QBEeGZFtloAZG+6NuIfyc0tGFxyiZoQtKLJsIN+vbfVVdSZ/3cF
         BG60f0ByfsKSDcvCOfcb5RUrvs7X9HQaSImNmLftG4twBQSQ+sCFAW/0JBB0NTkxlj+j
         pYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWcM7O7tSwDmvJR2HK3/m0ZD/x9XRuUknuMFd7lYnEhf0IvIuMBRo+jTvtwTiwSG5IFKxk3oKgYM44=@vger.kernel.org, AJvYcCXutzTK/8GGqWQInvVJsjzmhGrFYEXDi/jJ0xQ1JyOHdciKVuyU/Nicg0upzGaCeHkdi6aVDoHNw+o8CiP/@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVe8iujFM3R3iu+U8TMQWp+z1oRcmpkNOxlxXjh4cZIlRm5P5
	QLbTdZHlw+8n4oXupbrRrp2HhrP+0DSC/aRX8/Z6xnornACa3Ad4E4MhN69q9ZPz1lKFu/Hr4Ll
	0bxMXxJ60S8NcTwrxG9jRRMzI1uLaTF4=
X-Gm-Gg: ASbGnct6tNr8LwJIGN3yr1cV37IApAQldslwVQ3mCySZFYwlVceo9yy5+cOoaMgxgWg
	/9ejpSeaokDd/XpBre5G+50PpxKbzKez6xZd9Wr2Pi/CojGNX2P5vPWcjakWGl9zLZQfRRakGck
	3fI2QYgvHXsMlUkx2O+dh9YX4iSD39OFSasYkKimf5h5qpFmHhl5sKyMvyv2b0SJAlUHPq6vXU1
	zUy3KXUNaJv6KHLSw==
X-Google-Smtp-Source: AGHT+IHSpV38jN3vXlwaE5Hc/33kYxgkSGU7qt3cnFjrbvgWPlGfvWhPC35RdoWMMw0cLo0RpnrmYHf9TYgJV3EIk80=
X-Received: by 2002:a17:907:7ba7:b0:af9:479b:8c80 with SMTP id
 a640c23a62f3a-afeafeccd92mr974083966b.4.1756392237310; Thu, 28 Aug 2025
 07:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828140617.3193288-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250828140617.3193288-1-sakari.ailus@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Aug 2025 17:43:19 +0300
X-Gm-Features: Ac12FXyTLkbkyCMLdfg5IxUIPPUzIcPP1Ugg5myE3SihT1YJg_dhgWhZBLYFxok
Message-ID: <CAHp75Vdr5atuW8wivgR3KRjhCK_i+JE2rJFTU3CkWwzpuNv_pg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] iio: dac: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:06=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to

redundant

> pm_runtime_mark_last_busy().
>
> Also clean up error handling in stm32_dac_set_enable_state().


Code looks good to me in this version
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

