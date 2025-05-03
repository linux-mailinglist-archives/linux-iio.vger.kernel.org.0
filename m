Return-Path: <linux-iio+bounces-19020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F260EAA81EA
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1C73AD089
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994827E1C6;
	Sat,  3 May 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INTlC1a5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730727081C;
	Sat,  3 May 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746296479; cv=none; b=KCvd1lCuWX4JK7zQ/yMxlFSmDZ2RA1YWEDeY1bMoKwGYQ7wSEumrvWvK+iuhMpbfKUx+VxIoYcC8klZ1LaMrLdpUqOSXKZHobuYjjSlO5fAEBzRfBVl3MUs8pjfd3zTIzXjYEWBPSOLaSp/MPNsV0EqLKtc5ODOujHo9YnQiB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746296479; c=relaxed/simple;
	bh=CYwIFeC0sURXEvXP777r3Z0BskxeSWFp8rznqWY4Dzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q34nCm6Fyld2HvKFKma1+uV1k0YvMTh4lbkPwvAoPEZFXqsdg1kllJN4w6EjTdRv/k9/GhqJrS3qyzc5t9ug9fa2KJbr+cfVaa4zz+V5Pv0C9sU9uAb3lHzMBduiuxLgsj5/GNvIHOaMrIvQNpLh1qlqgBXmsc3a7LQd+AnRXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INTlC1a5; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f94b7bd964so2478834b6e.1;
        Sat, 03 May 2025 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746296477; x=1746901277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CYwIFeC0sURXEvXP777r3Z0BskxeSWFp8rznqWY4Dzs=;
        b=INTlC1a5uf+IxMRDPv253XWT1OkI4TuDFp+VHI0QAXkXKn8QaUdZZD//tC9BNgD/gX
         F0aSs5yvsVTxKuM2lsdw9Lq9J2aRnf1ixNkkT+p80z1Bf1J6H6BwYQfTnO3cT9b9TvPH
         9iOD8767YyDbqbUAOEVlGyhdXSPaKK068PqW1eZnQMY+FeyK+qnI+xDbh3iln9Je4J1i
         8vN6pTrG9S0XCaOh3rM4l6j4MvfemoDcMP3ClwcC2p1bN1YGRTrqLz+hquRdsOXrdlNF
         UCPulDwyuHjEaETOvrYCwMjIBZZEqPbcZSOZtLqlof9yKvTC3xT3j12qR9e3oTIloKOO
         EJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746296477; x=1746901277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYwIFeC0sURXEvXP777r3Z0BskxeSWFp8rznqWY4Dzs=;
        b=diJp+QdBZuQNVYEVC3jnZKJo95eVi6+pJ/OecK8IKV5wkHl7glbzz2d6ylTQqGsUPi
         F/WvxknRHqqPNrg9j7CCQqWVnRLfzOuy8yjn+WOgnLiazRulzm6bLMM6XJWKskZAu18S
         knGP3VlDTtXNlyga77t3wDKLhv6jukabAj09g4un7NTkXvMmy6rWTCDI5qx2PaEOZhJn
         EQiXmMnT28HDA0+N7eKxDjw3KXK020WgLPBUF+lw4jpARjFJ1NA4dJ4snzbmtirRI1A9
         JrpIqzcStej46JbYIm+Wzl2hK8cVKOMLHWi80+uRsnGfNMq0mljp0Nlbs2wLNmfCckAR
         4p3w==
X-Forwarded-Encrypted: i=1; AJvYcCUfNhW7BJJWj62HbSW1jFshZjdW1KtQc7R/6W+xurWPEsyJNHWtf6Gr5EKqbmoxPTY1FDn0JfcsA5Gu@vger.kernel.org, AJvYcCWXG/MHVknJXe8OUEzDWZpIv94bVD1eUHFleh/YEzVQUZLWBHbJlCTzVDzNQT7vg/FguIso2ZNn0KvVBA4F@vger.kernel.org, AJvYcCXWhkS84RDpGeba/Lh8wUBZTQAvejbQ9DCOsnSVlPlOgGJLhF2b+BtbdlSj7ARUJGtNRwUr5eIik9Rt@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwaTEKhgsRQC6jrlC4A+qEayuuR+UjdWo5oO0+/yJny9CK2mp
	X9xpNX/QnAifkOq2zqn/fG3d4uE5ME7vnC+AQr65rE5v/MppgIOUzGCmHt/IUX1nx2K7M+SW14d
	A3x7JlGA6313KvzjppeQO2PEeF0M=
X-Gm-Gg: ASbGncukF+ltki758kIKkx8fyZ6GiLcEWG71Sp8UqG5F37bmZKTC9vFsOlKjDdOSfXA
	aG9ibZTZ3taz/lxmQcdLYLvkXjEdgZoUnte7c20VFNhPWopbCOPgcoqI6TU/vwh1DnWdwmH8iIV
	iGAmQkMWh7YdtgvkAubfxMsg==
X-Google-Smtp-Source: AGHT+IE3tEb9+y0QpyQV5D1Q707PzF6MCKD6WZN6PTD4zOMRfmafShUdh7xzFvarhazzyRUKyF3kv/W+chlBUuyPP/k=
X-Received: by 2002:a05:6808:13cd:b0:403:51ac:23ea with SMTP id
 5614622812f47-4035a55f64fmr944995b6e.9.1746296477382; Sat, 03 May 2025
 11:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503095532.132041-1-akshaybansod997@gmail.com> <aBY0wHEzjbBex-Hn@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aBY0wHEzjbBex-Hn@debian-BULLSEYE-live-builder-AMD64>
From: Akshay Bansod <akshaybansod997@gmail.com>
Date: Sat, 3 May 2025 23:51:06 +0530
X-Gm-Features: ATxdqUEYo5SC1cZKvrEP_lX5gKSFaQoSdgKGIoAOyuhlfm3y7fKdoLzeq30RpbM
Message-ID: <CANm0iNgg-yxFMeRGdr6DC3T-x2HEznCiCc9pqpErLu-NPriqjw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad559*: fixed coding style issue (shorthand unsigned)
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Marcelo,

Thanks for the review.
I'll split this into two separate patches and make the necessary changes.

Regards
akshay

