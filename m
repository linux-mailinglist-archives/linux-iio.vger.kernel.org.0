Return-Path: <linux-iio+bounces-7242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC7925C94
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981F81F22889
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8931849F4;
	Wed,  3 Jul 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POT+OZvP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB101741D8;
	Wed,  3 Jul 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004907; cv=none; b=d6ubwfGEhtmqWOueRtN1FpBx5ipI3vEzAugwi1BfU5EOPcdlAauZZumxB5YRqBKQZPRui1s5CTrjgDyApHogVj7RRN1ANAj4kUyPF3S7G+gfzYsMMn7lnFTqpGJES5JGBIAaLCHJJi0XT0Bp28nluvlYAY6YjgMjLsri/6nRn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004907; c=relaxed/simple;
	bh=RGfWciQkHzZq7C05OxQDAd8nHDJ/nb20nhb3H7x/P88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jn0hNQ9btSj54hIf5LJshuKHYBvE23r4v8+p0Omg2X9tIhR1X/jvEfYNh8fAfQwABft/MglcquaPHvhipGeeKBTq8IWNZuBoaaqI6OEg9OUojIxhfWE1m+uRw2+GQxsKzX2NNLZPROkcT2kIC+eStnv8eZGEUMJU9PbAvqP+G0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POT+OZvP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso2346463a12.3;
        Wed, 03 Jul 2024 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720004904; x=1720609704; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RGfWciQkHzZq7C05OxQDAd8nHDJ/nb20nhb3H7x/P88=;
        b=POT+OZvP+iuEvMCz9gpDRvkymCisD5PP1sntp840d2AtyVFsHOQt+jsY8Wy7D+nEFw
         oMnKhotPLmRjub7FF1owveZrOkcGhW2QIlqwlBPiUQkG/fZH7yzD7kKXTjZS/nmyY1tn
         OfyVYwbc5XTBIxGDF4ye5zjFd/F79yzZbCoTXxirZE9CffPQsRGMUzN2NyzwmxYokiRz
         b3pMMzuMWV/KS7hqnba3NTzd+P+uKPOSHlICYn+oDy5TxOhJhlL7G4lkManStW9zfLH8
         UJwsWz0aoDZiRx/3NhDk0p0H7pxY9NaYzqhN+N4ODKobnh9cp77QB+oTiH67Edi1u4jK
         H6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004904; x=1720609704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGfWciQkHzZq7C05OxQDAd8nHDJ/nb20nhb3H7x/P88=;
        b=iIBtx6Az7gY8xRcJVQB1V7wNqx2g/0RjGPFJu0n8ZR4IvL5gYWUnEiUEnumKbLjOy5
         aQqLee4mscOZvifMtO0uQ69dtiTym2woyvAbSEPi6VvbRKp6ER+MH5QZpM0YhNAaAnRo
         5bPcbxbRSzw1hH0k6w5xM7Xxd6OQBFQjyWCpwd3cD+qtc7YiwR6PaqkwL66etElBwqGH
         qJakl5pOSJldtFzKFGMoYr6JHK7A+09L3LZptgXdTRNpwHAQ9gMAO7LtZ4qgwvPTq3uY
         2QzTG+LbVB752by2PyVNbCwL4FMBVVHOwlmljtfTf58HyOlgAE2FMQg11svM6rB3XN+U
         6eRg==
X-Forwarded-Encrypted: i=1; AJvYcCVx9Tgso7O14FUvxVKMkH+cGXyTjJnogzL5JymFyb7uhBVbdjBabxMzkzJXV8QoPoS/mDfUMzMOF+O1LYGUixqmlirhYI+Zs1odoEd6B/32OqovarVzvcHVHBx04v0w1P8tJ6HOI8KORWr7LpuHjdy+tk0ow4VxSQYPP/BUpvAq2Zg45Z+6
X-Gm-Message-State: AOJu0YzUGWlf5YF+XE8jLbfY8x8NopcUrcBSvYt3sx+bqBHxCbL229oq
	INrax0b/udaVl2t36JY1dypBn7G5zKLZ8P9sV1JGbrRhIGyYnuRh
X-Google-Smtp-Source: AGHT+IEKrnywZf4/o21me6pqT1Qouo23xRlPrFEmiNPXTCykCCNHVCiQ1YMGa43eM3RTFIW2cBAovA==
X-Received: by 2002:a17:906:a0d9:b0:a72:8066:c76f with SMTP id a640c23a62f3a-a751445f161mr643058166b.63.1720004903583;
        Wed, 03 Jul 2024 04:08:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789fd7a0esm3795483f8f.104.2024.07.03.04.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:08:23 -0700 (PDT)
Message-ID: <8010eaf5300d2dcf928812693379b649b77f0e0f.camel@gmail.com>
Subject: Re: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to scoped_guard
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, jstephan@baylibre.com, dlechner@baylibre.com
Date: Wed, 03 Jul 2024 13:12:16 +0200
In-Reply-To: <20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
	 <20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 17:34 +0000, Guillaume Stols wrote:
> Switching to scoped_guard simplifies the code and avoids to take care to
> unlock the mutex in case of premature return.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



