Return-Path: <linux-iio+bounces-20671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C43AD9FF3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF9517496B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837E1F417F;
	Sat, 14 Jun 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfRckyEf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099757462;
	Sat, 14 Jun 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749937228; cv=none; b=FncfmUM1SFXZw9Kiq+/IRh7GDCgofnl/qK0CXN2IIzp7RZgig3hoQEQ8mjCVCZScEZZ/a5Jr9s4jXGDg6H+AsXB9mWxhYbwEMeBg1VsutRFU2U8ixHcbTWYZ8UacJETxxn6RifsEB7DN1LgBkSkQr0j23egoY5e+/Sn14fU2yXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749937228; c=relaxed/simple;
	bh=kd3743nSEbDXUiz922RGfFIOoObfj1ILzw9dt0uTHak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2ozNwlvCfjD9w0cL5LuGmt9x3XvMFJMHSl4NIefNWUvWUFZ5+YJcP/bQZBTBCYTUet1CjEFEskCLbwjqq7MKHB6Uw4VWr4n2P+psHxphAgAli5yZtk0d6sdpoHIUCmkifQMDAmwtDDm3iE1JBsSc4+zyk7RCnFNTFOO/M4mc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfRckyEf; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso285323137.3;
        Sat, 14 Jun 2025 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749937226; x=1750542026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs3ud56tPhQ21R7sW4xLVk6AP0PKjqKuPxbE8YEes4E=;
        b=ZfRckyEfh6Bh3wwcgtIb1AIz45XjwMB5MGLXiHODA2FTMG8CmxW/tOkUXPJEfKtbis
         rrcOSzMUC/ldn0Bn3IYe2iCk72tNtWWvN+UmE/cARgECxaR4wdntneECgW94ZZ7pmZiH
         MPMuJ8vapfDS2u8TKNnajh/p0BGeOL/LyMGzMzwcRlgxi58wrlmNNy8zfWJisBbWWK5s
         N5h2pZ/AjrfYOnW/9Vh6ZtTrstjKfBEROfgxVCmxU2xRYb2y2KDVkN74SjcLFLwl3Jye
         8gAf8DqHgmNfeNx0ooc0S5bwN8z4NsgYo6CdszK9apygYGinoNAKmJ7c0X6pNjso/mog
         IA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749937226; x=1750542026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs3ud56tPhQ21R7sW4xLVk6AP0PKjqKuPxbE8YEes4E=;
        b=NEzKk+IBBR49GI8eiDWw66XOluS7NvZZfPDbk5uDt5Q8JyMWXOhjMUURXaMBku04JI
         /6UW4CkqorBca4cmFsIYfdMtA3L5aRwclP8msT3XDwQPdwsuyKiKBzSvvDI/KTNaP5ae
         IuYpRDyR2RW1ofwhkUUnVJlMcB13J6b3a3v3+VIT/IU8ofoOxgmfM2F6SKNHjIIlhvFL
         Im2N64KN4+N5yKKmt8fhjjQbcHQIVuepge1MRIZ1g7G4Z0a2THKHQ6PjCw7BYhOMONKr
         XM4NKKZQc+AWTR4lSpByk/pzmZ+GFdL50XH3UGGPHZcRFFZzfjNVaUw4jq7zQUVe1XK5
         P03w==
X-Forwarded-Encrypted: i=1; AJvYcCVvHVqV8iasG6HgS7lwq8NBftIVtDqN0LlFNC6aslZWHYFii7JbGA9Ojcf137msjpdroNopTXSIzI4GvYFw@vger.kernel.org, AJvYcCXUENgzEic1JKNQAfVrAtTs7Gl13WZqAqn3kJEcwt4t1P2EXL/6KcLXfkxxrYHqPlk1HkLhA34fh2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Fo3Y3XMZFOHXB2qMIR1QGJgOQWXX/vexfCPuKfFdlKmHMzoK
	+Qh/LapG1uZZdE20+Yx4A9XwGJx/UfDoUL2IRu6RJfxvGria8Ksj6mfm+nPRMyeLz9Y3KJATr4z
	XegShZlHCDZtkNSI2nqBHrnYdR1p4vQc=
X-Gm-Gg: ASbGncuY853y6uJkYZRGdZeMzN4Rj9/NGpIc/8VD4LuZoVyl3dgaBVC6EDKglZ2hW0/
	c7PoAN08XBJGgY9bJ2w27hwFz/TgLrcIsmCdBjArUvwyptUOES7tTDNzG8v5nuhiBicZQBDTQFM
	+nQY9qSdDiNDF8hBQ4lPaO87GEo3ntYc1YTRx/S4VOmQqBw7z+0GOQ2PVmdA==
X-Google-Smtp-Source: AGHT+IGIoZF5Ii5VWn9QWYYh/i5PeesWca3iK1OQzLB51j0/8zYJriLJXADUm8mHtJ33L0IXABVdu5gLyquUP5f+DC8=
X-Received: by 2002:a05:6102:2c09:b0:4dd:b259:ef34 with SMTP id
 ada2fe7eead31-4e7f611b1c9mr3811485137.10.1749937225911; Sat, 14 Jun 2025
 14:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-4-andrew.lopes@alumni.usp.br> <20250614130132.220f5f16@jic23-huawei>
In-Reply-To: <20250614130132.220f5f16@jic23-huawei>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 14 Jun 2025 18:40:14 -0300
X-Gm-Features: AX0GCFuex5943y7wWsKY2jBWOErHaftMtOPudcJYALbHWj_W09DVG4zVa2y4rZA
Message-ID: <CANZih_RErpueDYAC--XUnq=wUY72WWDsC9mj0n1bfqC0aiRHYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
To: Jonathan Cameron <jic23@kernel.org>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 9:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 11 Jun 2025 16:39:21 -0300
> Andrew Ijano <andrew.ijano@gmail.com> wrote:
>
> > Use guard(mutex)(&st->lock) for handling mutex lock instead of
> > manually locking and unlocking the mutex. This prevents forgotten
> > locks due to early exits and remove the need of gotos.
> >
> > Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> > Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> > Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> > For this one, there are two cases where the previous implementation
> > was a smalllocking portion of the code and now it's locking the whole
> > function. I don't know if this is a desired behavior.
>
> I'd call out more specifically that you are going from
>
> lock
> stuff
> unlock
> call which contains lock over whole useful scope
>
> to
> lock
> stuff
> call with lock no longer done inside
> unlock
>
> In at least one case.  Looks cleaner to me. I'd guess this is a silly
> bit of code evolution that you are tidying up as that lock dance looks
> pointless to me.

Yes! That's something I noticed when making this change and it looked
like a clean up for me too.
What bothered me were cases where we originally had a lock /
spi_w8r8() / unlock and then several operations like iio_push_event()
or sprintf(). I found these cases in sca3000_event_handler() and
sca3000_read_av_freq().

Maybe this isn't as problematic as I'm making them up to be, but it
seems that applying the suggestion of Nino to use scoped_guard()
instead in these cases would already solve this problem.

>
> Otherwise just the {} for cases thing needs fixing up.

Great! I'll fix that too.

Thanks,
Andrew

