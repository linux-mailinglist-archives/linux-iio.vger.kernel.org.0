Return-Path: <linux-iio+bounces-22408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39AB1DE66
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55CA56445D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E6C22A4E4;
	Thu,  7 Aug 2025 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze83k146"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6741AAC;
	Thu,  7 Aug 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754599120; cv=none; b=oabJz6w8R5udLx19PrJRgB+L+G2a/kTK4kDW60DuQLGoqH0G7sj4D2t8s7nTVFPFaoOnvaVRHAVbM2HVT8bHjsTdpHIGG31pSpTX2W5uZClpI62PhPbVjZC08PPwJkkMPO0shjYJslIY54kP0ctdS2fdQksUJmluRg2cK1wyL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754599120; c=relaxed/simple;
	bh=vOP30N5g6mBT3bIIZ40ypvUiC/boR0MotsLCe3vK+QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGhci85WjTSIbdGNLGcICDC1rguctde4kIwm3HTKILQ/Kdy/w5007h+5QAQ/VTjcv4SNmPhPx5GAkoP8KkZkZKDi/nKeJdHpksIA5wcZZXhC8bK/ePslL4D1ocfO+0icoBX1ZLBUFNnk/TCH84b0fIDgutEaLAyKhihJuIL22vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze83k146; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af96fba3b37so267394066b.3;
        Thu, 07 Aug 2025 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754599118; x=1755203918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOP30N5g6mBT3bIIZ40ypvUiC/boR0MotsLCe3vK+QA=;
        b=Ze83k146cDNLWs6f5Fifht3+IVYDWpf8LkWiMpwg9qx84GAXRHY01HLV6Yj81GkDGl
         /SpaDtHmHqMUJPCYHGVDHdZygCv3rM/s9c/WYgU/HyRvxcNHW+unHKpjy3XMjcDx0Ubw
         l9q1+0VGtqpukQV/DjsAppx8g31aGOqmqM24j+xLevi4/b+m2mg0gujhzknRD1blqT44
         OdAj5Fot2Utmb8wa/V0/9X5U7v6AES0gifKRSstoVxz6F0KglzkKR4vzAf0cB7+QHGm/
         1aKhoF9ik6ZMvK87Pz+blhzKXHf36vI1n7TmWSOVSWD625seCBXp1/h2FXj0/K5AcBf9
         kJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754599118; x=1755203918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOP30N5g6mBT3bIIZ40ypvUiC/boR0MotsLCe3vK+QA=;
        b=bCGreaNXFo1fABW0rt1PbwA6F08TW72uoWEEST36rNWFo01/hyIBTk4V0lAPFHY2le
         x5gFlImAebjT+voXD1meMxuSoAFs97+Db5CEN2ZFBZjs9djA3mEOayo7enUfZsm0mqlJ
         AxoSlUySwHRMCEcvqZ4Mr4uNfI8T5wH/N/rE7LfZxTYyBgH96EKkddO5PAHBq4GQyyf4
         pUAZHyDamlwNx5d+lpW8axcvpfRE6/s3niZ3D2xU5PAR9q2dcE0e/g9enikCgAcSBa+G
         ivYe/wu2akk3UCQilcd+p+I9nd5J8uxaG0uEXVts3kO8cy0uELkkodA/MpyDZuC9H6Yg
         Dtvg==
X-Forwarded-Encrypted: i=1; AJvYcCUUVmoOGWBr2d3hinQOzABCQ+zT/A3XtwB5ZKrMGxzVJ7u6hO8COYIZl6vROJL0EcWF15jFptv07vI=@vger.kernel.org, AJvYcCVON5CnzXlD+0L8XfOGRGub9VdZz6yxrEx1AcG9SGeGFw/ZGFqF7tKFfKZkNWsfOFyBXjX8sWTa0KVGCu8n@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3M3UWeJqTneIhzEP3zE7b22TQ6RsintfaEaCIiWs5Cr2lVH2
	6yBbJKwa+E/EHbJhaGX072cj9vsvn2pXcinim2hhE0mj3yrhfurEArl+bhswvLIA5vU62npZHrV
	KkzlIwKkzkphsDQ8Xg/gO+2dqpRFAxFI=
X-Gm-Gg: ASbGnct+Qxb3ESM0TZ8UOqXagVmIi4/0vYQU5RtaiQMcM2V9pR+E3bb0XsEo/reKP9w
	wpoTzUtIw0+WbZr0tB3YKPGw2nuLYklxoM+umIai97ig/f9jWhuHFlsjHlZx9SueeBZgWWyElm7
	lgfgVD1nCB+vrherbvPyG+Ckb1ykHgYPQgl2aGw656SdoNx0WuKnxhKNp6sfEH9YmD6DTsc+3q9
	dJG+dqGfG5+Oyt+YCKqcxMqWTLKqdSB0Jdv6n/VkQ==
X-Google-Smtp-Source: AGHT+IEhPu4nyTK5A59AiIOv7kW6bU3DeXNsbP3ZX6bjGovDZXDCFNW1jfvs1KCainAsXDMAMak1DDWXLTWk3NXvU2E=
X-Received: by 2002:a17:907:6d22:b0:ad8:9257:573a with SMTP id
 a640c23a62f3a-af9c62fb725mr34399366b.5.1754599117678; Thu, 07 Aug 2025
 13:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJQDyzoxLsF8nKYW@pc>
In-Reply-To: <aJQDyzoxLsF8nKYW@pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 22:38:01 +0200
X-Gm-Features: Ac12FXyK-aPhsqICYYS4WVsoUbtvn7P77S5Rw9-JkzAvBh9Zh_8QAuDeEVTETUI
Message-ID: <CAHp75Vfe2A6ZSxLO5GLPnEEQzRnaLkxNXLf2bNpoWeO8pL0ejg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad9467: Replace PTR_ERR_OR_ZERO() in ad9467_reset()
To: Salah Triki <salah.triki@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:39=E2=80=AFAM Salah Triki <salah.triki@gmail.com> =
wrote:
>
> PTR_ERR_OR_ZERO() returns 0 if the argument is NULL, which can hide real
> issues when the caller expects an ERR_PTR on failure. Use a ternary

ERR_PTR()

> expression instead to return the appropriate error code.

Tell us more how you got all this, please. (A new) static analyser
tool? Reading the code?

--=20
With Best Regards,
Andy Shevchenko

