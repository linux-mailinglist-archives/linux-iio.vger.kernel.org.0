Return-Path: <linux-iio+bounces-23452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A95B3CAD8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E4565308
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB46B27602F;
	Sat, 30 Aug 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4D+tyo7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFF23ABBB;
	Sat, 30 Aug 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558063; cv=none; b=aE/bS/+L8t+MJ5cM0xLntQ3jbwc/OWC0InqtP3tVNKnbngCALCLi0rQHPMjt7E8ue0vcTCNRf7vTUTsio53c1BARgUe0mVJIp+T+QUweEYfq7TAVH/rD0ojSA4xyIya1HOMtJ6IeflsHxW6BBRb5NSYB9B1oNw6i0Tj0pTrE8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558063; c=relaxed/simple;
	bh=j3Tc5/7aDYD4iRmkGzx+LsfOXJS2+eCdrdy+RBCz1Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txJPhrxfaERy7jYffoI49+ijtd4E8+soGto4iM5/sYNMIBBxyEws89kTzHdBxGXNQb51eB9VW6dPON+U5oqe/U+GsIyIxPSYAyu5rcHatnRs7UiviZjrkkRApjDdnyG98Dk54zcmwR5piUyRaW6pbT+XPVzRxZaLrfiSXUsAElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4D+tyo7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b040df389easo28716366b.3;
        Sat, 30 Aug 2025 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756558060; x=1757162860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg2EqLM1YUYUSkubTD1zvM7cqAjmItqmyMFantlg4+4=;
        b=Q4D+tyo74AOD1nm3/bdSyAcYtq52Z47YmZreIDfa5nulijfMxE37xRS/v655FcKrLj
         zO7VKWVbdACtD5F5+QWX1cMJnyHLMbMsa8b4n+JyEzK0SBlrQVl0G/pybW0fB3Wu8eki
         7DDVvePI5yjDMItI9ZSf98C0K1MkXdI+ahuIxhmIoUXANKB2J+z1tRcf+uyVVxEBGID1
         OGzSZAQ7vXZWTJ2VQHosQ2Io98jYYfeYxtNaS1QWuVlHCkzloRguz1PTMahgbMmOd0Hv
         +bQzdq+ky9kzLgVCOWd23RECgjBwz4Z2CnAjB/OaOU9Qzz1VB6X5CGa+pxohX9xesvEe
         ugzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756558060; x=1757162860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg2EqLM1YUYUSkubTD1zvM7cqAjmItqmyMFantlg4+4=;
        b=ARJ2oYHoGqp1DVSm9R5DrlqBH2MK8rbW4Qo2CawAvToEVk/pPjGj2YpDb2KWqVpvkU
         scLny3m3IuN0k7SdkzKw5PKPW/xoUMWpFgBuUkjX2aDUeLiaucVH/aHgu9viGf2Fow8/
         F12auBobNWFyIHfgqgWbHTXgqFtZIymMSkBuCcsXXbYweQBDcgPfzD81YzrvRuMx/PQ2
         hGyoeExBrKBpg24hCwlbwTjuFkNm0pLx/BD5rHfotbGHVfCcby3IsEyBfTyKU9U6tu6i
         zFpxNGDgOnQyFU5GkJ6go0qnisg3v2dQB5YE9oUK84gbQ2INYaOVJNHQpg9A4y/7IhFi
         NGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWayi04qBQ/SylsyFl19D9FA67pts4odFol3qBZIPfobg9oIZFewYdrdcXcQ+6teqDNCY8g6SsxL/g=@vger.kernel.org, AJvYcCWwu3ffu1FpN2ubKDRY4hkhkneXfFQpTXfnvBxYGWM5Ukq8wn443ph77jToKzQgbULci3sw6DDl0JEQI9sa@vger.kernel.org
X-Gm-Message-State: AOJu0YytJjsbQxB/cTeZkFYHxZaJ5JiVZW3iAAqRUZ/AFt9DsP4Ykptn
	5XcWuOxVWzw3pzJLCU3Muj4nu1Tn2QQP1YUzKxIYO1nbguN9R8EWHxRWKFs75iqQiK5/wSlIdm6
	vDSmrJkrXgfbignNhyRIk/I5Szk2B9pI=
X-Gm-Gg: ASbGncvFW+FD2y9ekSWZKAoFIPSt4hTWSsVRwwMJR35QrbQcOHYChqbKmdt6fNvZwGf
	DZtmHa6kJQVr+hz0ZmInvHX/gylWL46Y32UpDfKXksgQyFpv1roTx1dPpzf8CPksq1FoxMuyN4f
	wglKw37v3tCYpOK4feUNHZ+zEtlx7eonhRS6NgkwZq3TtFS77LFktXa7gVsFdMCjxPFqw052HlD
	K11ttrwuUEhgsFqSw==
X-Google-Smtp-Source: AGHT+IGsED2EvEtWCTscvA7FEtnFKiMDZv+rvm/YhCdIwur4sYk15s4qDF98jR/0TgRUIFIZlpxm6gQ30wT7j//KCZg=
X-Received: by 2002:a17:907:97d6:b0:af9:c1f7:802 with SMTP id
 a640c23a62f3a-b01d97549c9mr209032866b.31.1756558060336; Sat, 30 Aug 2025
 05:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830115858.21477-1-gustavograzs@gmail.com>
 <20250830115858.21477-2-gustavograzs@gmail.com> <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 15:47:04 +0300
X-Gm-Features: Ac12FXyqpoKmk7YZ0GSrzHBso8O5RoU77oggwWqPczVuI5H4eVQHQgrggTo9SGY
Message-ID: <CAHp75VfT2Nq4fMxdcbhvxcaoXas0waLnn1cj7XybTGoYJnmLnA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:44=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs@gmail=
.com> wrote:

...

> > +       return sysfs_emit(buf, "[0 %u %u]\n", step, max);
>
> Do we need []? Is it common in IIO? The usual way in SW to have "$min
> $max $step" (see `seq` in shell, range() in Python and so on).

I stand corrected `seq` actually gives what you used. So, the first
question is still relevant. Use what is the common case in the other
IIO drivers / core.


--=20
With Best Regards,
Andy Shevchenko

