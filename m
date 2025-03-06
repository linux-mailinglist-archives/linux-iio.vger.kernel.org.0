Return-Path: <linux-iio+bounces-16488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFECA5560A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 19:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875AF162975
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 18:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54DD26B955;
	Thu,  6 Mar 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/2LXghN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE026B088
	for <linux-iio@vger.kernel.org>; Thu,  6 Mar 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287386; cv=none; b=GC4C1xidxB0VWOVCaZus0DgXZhOA6iTF0cp3jgnRuHTr8tHsMECCnzpCVM7bDQBR8TeXofBA+zypoH/tHSSP5OWY9OwCQ/bMjDG3MRM9alUIxhrWaKMVt2oyA4lPK8vcxLKo8lQamyGxyTl0f7CKR9qLbvrqTVvIWzf38fY2mUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287386; c=relaxed/simple;
	bh=qn6TH2PXifUHjmG0ByfngdDrdMJ9w0HJg1A2XHC9JX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rG/o1RaIh+Xm3Sd/m/Iwhma732Nq3jtzZaZROPgHe3V8wYcRcUE86+QodE6YXQ1wMBrrJMnkaadjRQcYwbv6hTr51vy5TK+Nao8qlJjkYiJs5wArQXJ9fTog4G2KlgGg+XWPYG8ebkLQ891fgVeaDtaOqD5LXQL7aC2DKBs90oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/2LXghN; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e60cab0f287so708507276.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Mar 2025 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741287384; x=1741892184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lirtugOWcR3f2sQ0CrGMqigxtGw45D1gVWdCKdHV4w0=;
        b=U/2LXghNqGCqoC4g8iMlLKCZ+W7680GAZJDj1mFYFyBUfc3w+lpw7p02iygiTAf55v
         OiOgPH/G0wU86wAHhlmLtW6PcY6jNdfaqK25dDZhwrraW5o9O1H46edodaPszysyNjkQ
         Nw3wvJ4wr08tgwTr+2V1g3UIhJrk2CKeAFYeHLSLUXxkCV5D0KUvwx2sJlLO+D0iXJ3W
         j2HCW3gCMNIuWmKXjmlXcK8mhVJk7JL21reUYekZ7ohlgS787m/RFhSbXGXd2GYLaAjP
         S+7vJ/KQRjo9L5FOLH6AGRlRVAEJPLzk/kUYtVs/Ek1QVIKb8J5cMmJIvgrM2DreC2xo
         9NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741287384; x=1741892184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lirtugOWcR3f2sQ0CrGMqigxtGw45D1gVWdCKdHV4w0=;
        b=e/ICCt3Q2uPoWZexiT9qZ5XKM99BLoYho3w9Sdc1zVOy0LRpIRTeP8+dved6uqW2Wy
         VEBPHSZ4IewgBW17E694tjeCiKsf/uNLkDxk2xxymibKcEqbbBVSWP0IchdWsjizKmTx
         0UzxO6IsS7OiiN5DDhvsIqEbavQJZo0t2t1s+D7QrIOgeo1c22AnS8JjjyuRKAqLuhNi
         rXx8T2AYAbXbd0h7TR5PAv/rL9ohBYcsk9ZvhI9AwAKUBOuuqlwr9j0U6NKLhwISLJ73
         5QtYNxYh/l38bNtUraqkP8XORNeVVe1A5FOszdExeTtz/B9SraWq8DQLcH8Kx88T2gCw
         n9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCV3vNW+tXf3itCmmg+PqsB8fPcYofqwwBlwWfnkyL8L3wgqPJhojb/TyeniyLWZsSU89l3FLCQWmK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8q9hBMkHSSd1dCWVB9crmKUGG8IOY4/Q5Th14RLs+06lPyha
	LNsJWN7PgmV7MF7NG792CLaAWRzaOBBUVQHruHfofjWepkEb8guhSE9Lg28smksRfSbLSmAe5If
	GtYJ9qpr0mXLbVp2ZeX6TCQhZCBI=
X-Gm-Gg: ASbGnctCzkZYMV4Sq6/LVllCIBR3IfM3BpgaJkNe6N6H7LxR1p6yEmDhgfq7w6zm0rM
	8G02QW83BInQxHE29t4eIlNjVuSKq4WTS9kgF/i2bdeiAsbMuDFWha53lywJlrTEX127FWt0ANx
	CueBGJ/XftMkjgTZOJAIBmxQ==
X-Google-Smtp-Source: AGHT+IGI9Fm0bopwYG3hS8L7LA2r8v8VYKqWsEiNhr02w+yqDusXjSc+oeC1AvmUNJbAGtc2Iv1RpaAbrH+zsxlLZZA=
X-Received: by 2002:a05:6902:250f:b0:e60:a16c:d017 with SMTP id
 3f1490d57ef6-e635c203662mr577128276.49.1741287384016; Thu, 06 Mar 2025
 10:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei> <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
 <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64> <20250305145749.413fe30b@jic23-huawei>
In-Reply-To: <20250305145749.413fe30b@jic23-huawei>
From: Siddharth Menon <simeddon@gmail.com>
Date: Fri, 7 Mar 2025 00:25:46 +0530
X-Gm-Features: AQ5f1JoMX2OPL4R8Zxov-SPpxQIVGFxo8OMelTRo9_He05nJQLrTtqxrySjD694
Message-ID: <CAGd6pzMzrJbRBXr2esV1x-TxXjg9zt22y6UdSXgXe7jCO3_raA@mail.gmail.com>
Subject: Re: GSoC IIO project: Siddharth Menon
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 20:28, Jonathan Cameron <jic23@kernel.org> wrote:
>
> This one is an interesting part - I have one somewhere from trying to help
> on the previous go at cleaning it up.  One issue is that I couldn't manage
> to get a stable SPI connection patched onto the dev board.  It kind of
> worked if I used a long cable and did a rain dance, but not enough to really
> test it.

I'll see if I can get my hands on one. Just to clarify, were the issues present
before, or are you referring specifically to the patch?

Please share the specific rain dance with me for future reference.

Regards,
Siddharth Menon

