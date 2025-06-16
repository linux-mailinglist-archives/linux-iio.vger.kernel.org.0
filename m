Return-Path: <linux-iio+bounces-20703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5AADADE6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EE8170166
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6BE275863;
	Mon, 16 Jun 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr8+lOHM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73B2641C3;
	Mon, 16 Jun 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071626; cv=none; b=c0dag+M1TyaL1euEgCgKexJxJl2c6LXslvCBEkzutv8eRlb/C0p5FJtSjkar+0yyJfULyNGCa7n0DQBeUxMcTpHYa8HAY1kf/Yv1Okzney5WLAVAFDS+gFYWhUta9tgmQAKxWcWQo3X8I0RGjldl/qYiAsBC6itwTSD1SPhl0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071626; c=relaxed/simple;
	bh=AbD6CFZ8f8GSOHilTcveBi0HsQjmGCPfyQtNZhA9M+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSp1ipthMEeytjt+YXBX5OGgmKmoc6/SgFzn6OGqJFbI0lialRPa4urKDRGn1QO0LKOFzWfJbUkASrShW3RGfbvf2EnqeI/CPs4empmhoNXAdWGbRNoBWOR1p9y+Bc0tfNq+CkKM/qNXA70NSg0TYnDj6+wXuFbaev25iJRyKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr8+lOHM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so795395766b.3;
        Mon, 16 Jun 2025 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750071623; x=1750676423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbD6CFZ8f8GSOHilTcveBi0HsQjmGCPfyQtNZhA9M+w=;
        b=nr8+lOHMjxyuHICm+ArWlVxZzmskpusPTFDytfzBPl77G6s6wo1AQGIzCusrugiBRr
         vbSzNnXl4DcOJDB2Ph1I06AH24TGCFdgj/3GIdv/vciECr0pM0Rkf3Y6y949+Q1paVIf
         WRWEzTx/7Oni5OxPjShCz9ivqkYr6iMQ9ixON0V7NEdq+O7jt0s5X8MKqcTR7dveScPk
         aqrwJhUUXr4c7aTW+T2lCz8QRLU/cIbV2kvE68swUwzr/38fPEy/lbN3o4uyxCayWZAw
         GqWeX/Zg1f0sUBbBzP2a0Csa18OvAaGP8ocLOR1JGXrKRt2HMtGvjW2DwP5r/yOsXW+V
         jWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750071623; x=1750676423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbD6CFZ8f8GSOHilTcveBi0HsQjmGCPfyQtNZhA9M+w=;
        b=OsyRdXKcreawNlo9vIq1kFdj/fdZRJedLKrNT6WEG8Ff41Dsx6XrtZBIOsXahvBWxo
         BMgxvMBTP07hkKAPOUPlb0BdAj4Drq2F5aSPZVEQL9+UfwmluxD3lGBQaOKpjul2MT83
         ucYXvUKfdIpHBFOfATRg4ic8vKdhYgnyxUK7HUuzYHA2HNtyyS+B2BD/U9bOXNqo2pHR
         wMrK7g0vtghAx9rkhmgo9YEIJi/rMbpw8L9AyxBRKSMMbkQi8Yg37M1NpGpEc1Tw/wQF
         Z9Qt2/LJa8Tf9cIzhik+rPCTik+uLC+tNNLkmG2kVMYR6pHjpsD9tZWGb7ZnjFNuK6jS
         IzjA==
X-Forwarded-Encrypted: i=1; AJvYcCUFf8fhK4iGjO8vYNVJ7/V6ytbrdPnzJp+qQMa87NddBfjOt0bQoi6zDu+gZtCGOsahrGSnrQgnY2rU@vger.kernel.org, AJvYcCVLFtsLT0Z/O5oOJonzKhrmO6Qh7Vo5qR+NyKFi8fW7wDoNl9zKIs4txLtRUIqUkYBnY+W1fcxrlMkDbtD9@vger.kernel.org, AJvYcCW70/SreqCrLFHp3SylW5Q+F32ortFs+8Vd/SieXNJ5ZtqTrBZU1hOWyxP1wWPn60nycAdRFvC4Cng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+XVQn/mCtAgSp/MkmycrdIuOfMymBLYHV8njzzQLEJtdpAi6
	49YXPCmi5E3SDlofKn+gwCocAq5Fh/9uksr7hpdMtOfGRzdnq3OwCmk+DxT55KN61W63YL5CqO1
	GbTDfHeHrS+O8980TnhuhvSS2kyHOd0E=
X-Gm-Gg: ASbGncvyez+YjTpgudPBr0TQjdH+lQVWlRazBtv+UtbO9PedsPGtldQ7xM8CjPHJ3oM
	QZeLtAEFjNmFrLJEIMs5bKfKkIH6OxUSxMPZqt1hvfNxJ3CHYdHcjKQhf3tJN5tE5KlBWT3bFFV
	myfVf13To2uPp2ibcIyKJ9vNo2Jvfc2i+7+IrHmE7mKhr6x5Z6UwteiQR4
X-Google-Smtp-Source: AGHT+IFTvZ1bxIVHymw7Z9570UwTxcMu+BTxqbdPWSquHTZVTj7pV51Qp/E+mICU5fILfs5NslaFzbViLRLCarztW1g=
X-Received: by 2002:a17:907:3f87:b0:ad8:9f50:d8c1 with SMTP id
 a640c23a62f3a-adfad416340mr891784966b.31.1750071622484; Mon, 16 Jun 2025
 04:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com>
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jun 2025 13:59:46 +0300
X-Gm-Features: AX0GCFtmkoV0DBvSDaNhj8w-fa-lVbU7JTeoqQ34pPmD9BIM28vNTjqJHzx28kg
Message-ID: <CAHp75VcQd_u4LCGbD3khx3EvMzXVNRHBvewYwK2UpAGCiqNS2w@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] iio: accel: adxl313: add power-save on activity/inactivity
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:23=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.com=
> wrote:
>
> The patch set covers the following topics:
> - add debug register and regmap cache
> - prepare iio channel scan_type and scan_index
> - prepare interrupt handling
> - implement fifo with watermark
> - add activity/inactivity together with auto-sleep with link bit
> - add ac coupled activity/inactivity, integrate with auto-sleep and link =
bit
> - documentation
>
> Since activity and inactivity here are implemented covering all axis, I
> assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
> channel for activity/inactiviy. AC-coupling is similar to other Analog De=
vice
> accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
> documented and functionality tested and verified working.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
for non-commented patches, or where nit-picks can be easily solved and
you agree with the suggestions.

--=20
With Best Regards,
Andy Shevchenko

