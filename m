Return-Path: <linux-iio+bounces-20666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33957AD9F5E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738D23A1290
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42B2E62D3;
	Sat, 14 Jun 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBBHGU6a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C831DE8A0;
	Sat, 14 Jun 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749928600; cv=none; b=L7WJArx3oDl6FDkXu5Wb3D+s+qjzD75pJpRsqdAHpCd7BRw2/c7gaae++hO/lhM4c6gaKeKi2CzJhP3NZRb5fpHqyY7WQoE2/8ZreV1I+jQ0B4oYSm5dwESD43VbG1Qt80RKm87AC4A0uCjN97RGXHFXUjSUtH9mhaVaZYZSV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749928600; c=relaxed/simple;
	bh=zI+1aeFc0WrfDTwvebaq1I9+fVkZyGxtwWsm6ZiW0Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvLshVI727Ai11cSZFo9caN9podVGpZS1bo56Rx8nLVbFFxIvlJKEQZiu8xz7juwU9iLirZDp+pLaLBEz0Z1Z9yFuNdsDyP53rxHFzUEanBxWxkzgwGpHn/+2BDCUUYFkpHBgMul++MnBzXdPzXpdFYvFWHt7orOqaSxocPAuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBBHGU6a; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5311937292fso1031057e0c.3;
        Sat, 14 Jun 2025 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749928598; x=1750533398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI+1aeFc0WrfDTwvebaq1I9+fVkZyGxtwWsm6ZiW0Qw=;
        b=kBBHGU6aYVBDJPuWWsPOQkpWXbhLlqc0tbaULzpXJT8xtKySPBKLr88eC5vZ1C4uGt
         AlwKquikn7o+6iHQUMxZwzg5Qnx3CPmy59FtQSTBEdSfDh1K7O5MsgIPLQ3oV/O05b6o
         7Ck8cYdYMBedtpZXV69ce++mjLPF5pC4UGn/gBzYJstA8rKBN/cJv5ctTGaspuS8Tlh3
         3SnrM6pOD5/tHOpjlaYTc+O68VqPWiRlBCJmQO2/Qy9LX//aa03EY1uFRrBAw+flMf/z
         sC/g7DngdRHJal78syL8bxknBJ/Tle9xPvw7zBS0AHji17NECxfC6t0vh2+XcKH+dcLE
         Q3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749928598; x=1750533398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI+1aeFc0WrfDTwvebaq1I9+fVkZyGxtwWsm6ZiW0Qw=;
        b=UKj0Ya3hqaZMz77VxmiCOeCqCOcf2whT2OHJIdxeYzpmoDPoeQQqVxvS+3dULm2kih
         q55K4RcUa082cHmf4ITTfMnbAdZS0mGgcjfXCLzw1cFe6olMusY6a7LQwsxBPK28718c
         GdGfDri3qp5UEFB8Uh3vQsdi3ACnEAVPkAfsc8AtQ5K6l75JrqexeCfa5IqGWrcbEV7Q
         V17YMBAozHuaL9VALOMehHcQRzZnueFr2I/7pmu8fKPtYwDIffhZugb4EA+NkAsDDAVA
         QNXgY04NfHTCE8sjVR8+8tkNYA02LmR1PDGLUtESv0/YtAuYi7mtjm9y175EQArpRS84
         iCSw==
X-Forwarded-Encrypted: i=1; AJvYcCUaSxBYiOjpul1KPulbkd/dlVWpOLSBUSXxYSLqw1r8OvueU72jjB1LmI+pP4tFGBNTtRgLGufXNcSCKTYK@vger.kernel.org, AJvYcCXcGGbDl3Qge3sYjlXuJhKvHdNRf0vCmFqvCW2YdNmlD9Yn136jhPhNpZs1GQKuHrgAV+2mSLLHaTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQAs1gmwcZLOTsb9LsfaxEoog4xxMr60khNWILS/uPmOZ/FKI
	R5jZZlrjWynmUglAYKYjpNub9q1TpMClFUd+e9quso4ZTiv9Q+kWzKKn0LShdy6RVSQVqyYPz82
	y58cexGKZKb9RtkI+XkYMC23/wDorWpg=
X-Gm-Gg: ASbGncsghzAPkmDaaMZwmh+BJBt9Djf+BPZEqDtPbL4QIKCKHhNO5tEb9OW6dOZsgVm
	1rKYTjUf8Ws/Qebqc20qTZajMU2TmGFUHJu2V7V0rRSgKos+MNyfkd7JEn0DFctPNYPMtW/MLLH
	EPjT2ZW4RBgATvdDf09V2iVxpIOz8O47sS/H3TI5gVijBAjcO9veRNCAu5fA==
X-Google-Smtp-Source: AGHT+IFPz+MGdR9xaxyWw5ZcFXkAIj7zZTibwK8+1PJ5JbiQSc8w420wRrtSop3ucYZ0WGoLt8TZvqce1UY2Bfi69h8=
X-Received: by 2002:a05:6102:4a86:b0:4e7:b338:5352 with SMTP id
 ada2fe7eead31-4e7f616472dmr3504188137.10.1749928597811; Sat, 14 Jun 2025
 12:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-2-andrew.lopes@alumni.usp.br> <aErOevItBLmKm4Jv@smile.fi.intel.com>
 <20250614124838.02b79111@jic23-huawei>
In-Reply-To: <20250614124838.02b79111@jic23-huawei>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 14 Jun 2025 16:16:26 -0300
X-Gm-Features: AX0GCFs_0VtfZ7D3Sr5WHSYQZNvCVZtJvJaC7pRoL7sZJRVTiBx7Q_gjuowjTRo
Message-ID: <CANZih_QXx8fnXgcngxJ710mNt2tMeGUmezEtTpuQMdDGbqVypQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: accel: sca3000: replace error_ret labels by
 simple returns
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, andrew.lopes@alumni.usp.br, 
	gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 8:48=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 12 Jun 2025 15:56:26 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
...
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Applied this patch to the togreg branch of iio.git which is
> initially pushed out as testing.
>

Thank you, Nino, Andy and Jonathan for the review! I'll address the
comments and send a new version of the patchset for paches #2 and #3
then.

Thanks,
Andrew

