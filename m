Return-Path: <linux-iio+bounces-18885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4749AA3B4D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492DB1A84FF6
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DB2741C4;
	Tue, 29 Apr 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGSjX2M2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973F267AE4;
	Tue, 29 Apr 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965178; cv=none; b=KILam6dpM+BfkkhEtLTj23kD4mgNoo8QFVWcTsnyQW5dF86tXTWljgsLbb6II7My2JTBwpniUmg/DRrun1wuycPSVK/BwbcUzufzDAfdaNwdHbbT3GmRTBmUYbUeeMZlxxswnm8pyRQpG/Kro5G26lwBZ9jWarmtjiYWlPSzw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965178; c=relaxed/simple;
	bh=8Eq2V/y9n8X7Wdttukkjp0P5QfxYqZ0fcjewV0ijtlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyKmNXzURStAHbxqYJ5HMt7wsqCcpxC5pwJy3cYwL3qKM95jnqG3X+qks2nOP7s4Ygf4vE9V4NH9q3/F7xY4BdbLm072DLCxrhLNdfgBowCi1q+bGhV+G9uhMHq7wlgXTju/fnHEXel2nhyr+6z3TVkBVZ2DDMt+AWvn4djvxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGSjX2M2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so1287868866b.2;
        Tue, 29 Apr 2025 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745965174; x=1746569974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Eq2V/y9n8X7Wdttukkjp0P5QfxYqZ0fcjewV0ijtlY=;
        b=PGSjX2M2eNTxjIfW5JE3biCLcteSnbYdwl0/4hv1KGhs8FEGLB1nNAv+xekXqBCYat
         ptZlBEoESdvXHS/LhZa/GrDNgnPpK3v02Qw3KJ5CQZ5Ape7EfG69z8VXYFtPjt1ptsqn
         peiSbrGBx0bCg320lFMjbIyc+U1FhS4D5N8NoB8GSlWh2n6VPFSZpOpL1IPlMHCHTcEx
         d3FEXGsH79GSxY9INpUBXUP8zp8m7mrLQPY6lNWHpg19f3qrX/1sLFcHxR2Uw9GZK4j2
         djYG0ZehwrVaMGPoyhOYUqaELj9mmUUgvQ4b3/EavqfbkE28KP8ivo9Na3dZkZ7Qc5WA
         yRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965174; x=1746569974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Eq2V/y9n8X7Wdttukkjp0P5QfxYqZ0fcjewV0ijtlY=;
        b=B4d98rc4QrY3Vpo3liGVveVVJBwu2TwPEqGIx+ZgnrWyGzR/JAPvkEdTF6NZLxxpF2
         UHpVKq4qgG8Z04Dyr/Y6ksGO+bU9Wh6KKil9ivwPSBEhwsbbo+N84ngWHDBk6FA0gLWM
         rDw2xZDckQc7sq5YZNtRtjeFxBLnNNMeEMzHe2kN53qL6BaMCafVjXCzTnlhEMEnzk18
         7FyQuKk9zpk70JXtg55TReyKuVB+W7diERddFxAaa4OAbfqGNBIKAWTVzVInxz19bPcg
         iGr1rGtyi12qaNd00MJOscJZeFWZ5GCNiO2b7Mh5NC1M7G7IQ9aJhiEJM9pcnaIdYUOg
         LdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCGyybPycbDWKKyT0cmILWPatAsBeml9WY53sDHToXbdwHz8B5fQnc870x29DhXXWUB5XvoXfT2Kn2D7SA@vger.kernel.org, AJvYcCVTMlZpV7W/c0s120StZ6jxe2hGMQppGLIdtUj0DFDrqqRYeB5Y6YzTEtstHJCzi5iuqTOnRkhQmaxv@vger.kernel.org, AJvYcCXT4atwinnkPfCJFvYmyeSNsgKj887lKz6gWmI0492jFVlg3Ab1P8nxAaQ1P86Pr4upN2KdgtpG2DA9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/znSRMVNXEysD0B6l9gDufyPNEQB/ZO/3qhRDe4CEdyQXcdUq
	XhHYyMVkzg/3raB7Hj+fp6LNpGOJL3BkGykg7BAFozt+lxEKv1tnUPssXHTOZqvp12ck1B+IU8f
	PMYd9qvSKsQEFWJ80IV55fFbdm5jyydMi
X-Gm-Gg: ASbGnctsIvWkfEh9yeqhmuxAKjPpqpcNVy/xmlLfwg4cmCa0LoERdMp33LzpsWyEYTN
	P4Eqn9qWbOqotRq7j/sHQVNUTX5Ls5KBGH/9GkvWDVjz7J+PW9+5dRTT6U6li+fZd0LHbUPd/c+
	bKUNBAf3FVsqZLwh7U7pryMw==
X-Google-Smtp-Source: AGHT+IF87R5uBfJhVBOmxoFOc8IDi9XInq99Sps/vXzEijBd1LQS4tKFX9nEpLNiKeMmOcKgl17Tb1fiJa1RFfqyps0=
X-Received: by 2002:a17:907:86a2:b0:aca:d831:8fb1 with SMTP id
 a640c23a62f3a-acedc765e48mr108112966b.51.1745965174255; Tue, 29 Apr 2025
 15:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-togreg-v7-0-0af9c543b545@analog.com> <20250429-togreg-v7-3-0af9c543b545@analog.com>
In-Reply-To: <20250429-togreg-v7-3-0af9c543b545@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:18:58 +0300
X-Gm-Features: ATxdqUHDmZ6_6-5HFx3SVBo9-BjG8swQGKMOhQKOgun95oSGNPbuPZ7x_37xhwg
Message-ID: <CAHp75VeY_vjS=Ca4L34UMjVyDvG6iLdrW_c-owKWBLK-3Lg0BA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: dac: ad3530r: Add driver for AD3530R and AD3531R
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 5:20=E2=80=AFAM Kim Seer Paller
<kimseer.paller@analog.com> wrote:
>
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disabl=
ed
> by default.
>
> Support for monitoring internal die temperature, output voltages, and
> current of a selected channel via the MUXOUT pin using an external ADC
> is currently not implemented.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

