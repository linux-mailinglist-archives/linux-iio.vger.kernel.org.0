Return-Path: <linux-iio+bounces-25304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36515BF50BF
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 09:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D8C18A6419
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 07:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC22848BA;
	Tue, 21 Oct 2025 07:46:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FF284690
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032793; cv=none; b=Fnn2j70wqSqDOZSpQOOjM2sspFaJcZulYci/9IRxNyTO4Px0K8iDPeSm4gA9Oekzl8uefmGVrvwOREGMZK/m1t8xbZfadhxTk2cAVbi44N9CTq/l7ht0b3DpRLqCTknOJ7cDHk2mQnqULgm4zTmoiSJMLpRGJJiwJodMD+dj/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032793; c=relaxed/simple;
	bh=5G4JqyuB+1jfwF+3s2F0oLxHOIeUzEWkM1tGorit4ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBdqpQuqRaR3suAjDM/DXne7XCkK2Tz+XcKoLSKij1LRjpPAjb28qaomuLuWo1/jeA+D6GXziU1dKJqPXtVX+1k8MZc7d8l22AV+LaJ7mBsmTsQpjg+BkiP4gFrYzDv4FL7aJa/wdXh3VZj2DhlE4uYgmbtunfOQEwHdrih1aUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-59d576379b9so1762271137.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032790; x=1761637590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOVef87yu8OWyluOAjGxPlGJdL3ZMdICelAlkVBkCao=;
        b=EKg/ZQd12C6QPakJI3ASU3xhJ5ZQNdVSRUqlj2VZPDct6G23GVgltLyp+LUor4fmJR
         Tks2UcJvWjVon9K1LQaSgN3WKJaNYdz0KnZFh3hU3IGj7ySaxYTdu+K1SxIFPiGKsKlh
         SnJIZ5yaObUI0mg7+XgykF/11phMX4KmH0lLy4vhby32HrwzMo2BBaZWiJRUMUg7gVvC
         Onj5EjwEPHvi9ZWkHZ1Xxsd832oUFzLbkyAbsQkM+LNBklQNuXTVroOe3dV5sqLp2Peo
         hOPQwTbGmB5SnsbWVIGUNVpS6jQ6NAeHiB0cOFuRyorQBUjuIjMcSBpy3wjYVe77KAC4
         8MHw==
X-Forwarded-Encrypted: i=1; AJvYcCW/6eXIl3NiYXszje6aCGnf1Ptp3DwcRKjfIsMG054hAAWFldHJ3n0hgJ4JjgKjRNRLnt6Sk7rtRrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdnHfcnNWa/QxBeF7cbeIBoGRhzyfXNrrgh7Ki5aKL/tQYnNmW
	nZMxAz7f2rSQleO1ppZMGnDKlK4AQ1AIhHtR/IkivJmdZDKltWIiKzllt8/toyBI
X-Gm-Gg: ASbGncvbUlxkgZyu8EqFoh8ZBmLpQ4vjAuwHezMO2ObUFwp2lEGUjYlksHR5XPiixWW
	zQkO7Pf1pWrkB1cRqg611Snw1JbKKdiBZRSjuBPnft1IrmBGXmiWlRMlxt9TJeAXWY8MUjzkcCS
	vBKkzn+uwkMJJs6ZYD5kRQ88fpNcV1TBy+gOkoVsJmnO2SzKWIUnKGiISjLHW5qd+2Naio6FmZD
	XylRvm6qWogTEa1QW/4l6WOhZVjmevCjYw5SJ5oYw1zWzUAN4yQeJh3xlxXACcBwhqcfwR/OfY7
	s9DPc5+PuRzpkQlpGvpya7SvzpXdWZFRNbhGju7TIhSeWTtNLKD8ZIPMf9niGclEvuQ05P1Wu0i
	zMRYbXvwG/0My16AbObEH2jxAO+MFXnYDj4U4EFMPltWQrxO9LHUmrq+uKkgp8GwefKJGIl4jjs
	MfIxX8X4x8HgGep7FFA7fnnPv/pPrI4NbpDePu7IS/Y/XRyfO0
X-Google-Smtp-Source: AGHT+IFGKZ/rKiGeiXX+l2F8xbZEuE0VQXJPxE3zMOgv1Q6J9DS5yXYqGjR/cOoXIQNrezZLug3X9g==
X-Received: by 2002:a05:6102:3909:b0:523:712d:44a1 with SMTP id ada2fe7eead31-5d7dd4b254emr4660353137.19.1761032790192;
        Tue, 21 Oct 2025 00:46:30 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932c3db2539sm3190145241.8.2025.10.21.00.46.29
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:46:29 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-59d576379b9so1762266137.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:46:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcDxT/ghXjViQpEYqOKvZZRSSsdMn6hrh5jW1Nw3ouilHLxV4DDtQJ60y/6o9XemEWQxoEPzHMN9o=@vger.kernel.org
X-Received: by 2002:a67:e101:0:20b0:5d6:18ea:a52f with SMTP id
 ada2fe7eead31-5d9773551a6mr1568570137.41.1761032789407; Tue, 21 Oct 2025
 00:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-5-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-5-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:46:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXcfw5LNHJzb6wPhhr_+PhqTXW7vVsPh0Jh4C37sH_1RA@mail.gmail.com>
X-Gm-Features: AS18NWCrnqUjqenK4TJrNwGcosBJE6DKtmO9ndJuUuCBGZAhQh3Anhkt0sj-6Uo
Message-ID: <CAMuHMdXcfw5LNHJzb6wPhhr_+PhqTXW7vVsPh0Jh4C37sH_1RA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: r9a09g087: Add ADCs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 13:15, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G087) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 15-channel
> ADC.
>
> Add support for all of them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

