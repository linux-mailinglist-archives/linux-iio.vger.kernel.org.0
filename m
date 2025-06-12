Return-Path: <linux-iio+bounces-20567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5AAD79CF
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB849189408A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DADF29DB86;
	Thu, 12 Jun 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZtoOCa8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914B198851;
	Thu, 12 Jun 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749753287; cv=none; b=lbkWnAVhFaNDYRDQxzcYKl30lIRS1cJS4ZJEJCbQbd2qDpXnWHt7kFEsKKnzMRMaoTVtUrPZ9y6YyomUHOx6k2tyt1NWI6U/bFJ6R7SoRdLizR+XlCA6tLPhsWsu31eW+DUQCdyaMxkSCuV+NaEaFD3A2Ygzb0fh5v/oSabqKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749753287; c=relaxed/simple;
	bh=AMi8JfSWB3lcCuCl+VXqzaRKa594kGSWnHo4Wlygz1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILObsnJte7OdGKGH4JyGs15dYi01Rpi68rmNct7RVUFO/Jn2eaRQW10dSHh9xGkr2u3J1AN6lMw4+gqgw3CQsG3taK9fQJUoFd7ZxqAShvmnmNWcVP6qk/SW0e99rXKPM5uft116zx0beTOKimNadBpmXzDNKynAkaaZFc6T3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZtoOCa8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so2205355a12.1;
        Thu, 12 Jun 2025 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749753284; x=1750358084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMi8JfSWB3lcCuCl+VXqzaRKa594kGSWnHo4Wlygz1I=;
        b=PZtoOCa8JNqTLUMSZU13hqNPQ5Zj5a7JGSuarFdshWKzSS6mqr7ZU7/SxkOzRO4gWJ
         RI+66r6nzwDE1JfVrwPrGy6LD969FDgK9pFBGag0ZSzhTtZOoXnKOZ71UtuJnAWyif85
         CdwNJI3GQjdCGlLza6zRF/Nf4aWiHklW63PhNxHbwXIeJqKWicTv0E+OL49P/VX8f4l1
         jNRHaD9+N6NOVltQAvkwcyvic6y8h8L+NBbAr5bkhZGcnPruyDVCQOCVUORj+LJLP6Cl
         Zvr64S4fw1gfAuLaCQVuBjvU4ooWqg1N4kUrCXDk4gQzffPa42AbqFOpHiU5Sut+omRG
         1MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749753284; x=1750358084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMi8JfSWB3lcCuCl+VXqzaRKa594kGSWnHo4Wlygz1I=;
        b=lR7XfeHgL9/AauM6YytW5aIoWxditwCcLd9m6NTFUvPj5KdSTebrKUH319tXcMa2uV
         BXO6k2ogv6ps0CSHm+cR5rZftb1Souif0Eb4cJEwvEt03sU/BQFc0j0Y7/hAwrFruNi/
         UA8GM9oDoI6wY7Zh1xR7N8vqPyu/9QsWte9bIob9ynrT9ZXrlrkrOcQ+qLLb1JsphmQX
         lvMBEyUvG64vcvCeYEvEQt0NcZgqV9TM3a9f0Y9xtDiqETLGM1oW9dQVqim7/lB07onB
         Bvy7tP6Mj7Sl0uAA/Ftd0VvywEmmNn4lznzLTYFJIxwNcKm3Btce7sDS40O7EWHqqFTR
         2qXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYXXQW4pUFMYUaer60g1gh+jxZHHS61Q1lZHHWCX/u18CT2pevq8yi5LJnwK+q0AQYNUQfpmQQU6Q=@vger.kernel.org, AJvYcCX6QlZGEUHGKPpa/je27JPTM3Xc3Z1BuqU55j9PDyvfplwNiX4ecVKgEPk2aRK5PldwTjMXZlgbogvNQrzS@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIu4TFGR7JMrmsW6gjA7wR+hGvfLdaM58BkvI0elKh2Y1t2B+
	M4nGVVXfTXMPY2+jrjneuaaoZYa3tzKEtbglQFQbme3TPknKwbutiCCrEvjOZXEo9s56Ohxf0M6
	xgfVGgIZIbbakZWwVX4GuviV0rnB2Sck=
X-Gm-Gg: ASbGncuC3pfM8KxN5/pw1NoXiRmh+cFjeXEITW8Iapb0nBJdCpNzMUm/TbSR6sFRlfX
	mRyNuuO5bu7QmVr8ihodcPXRFKopUn3vqgBru0wiMEbC3f0u0qek5w+gwWIMTFnHReSNB93znyv
	y0M8Qo7Dg6TC0F31yK8YjAn3P/XXWXyRP7B5RpaZi1+PcMPqoBeO+zXw==
X-Google-Smtp-Source: AGHT+IHNkpU/CkQlbaaAiNI0DoxRq19J4TX8YRoBNmjH9WS+PpnFYRnByZ3pplCe6vyDs4AF9NF8KtBDaSH2wVdIpY8=
X-Received: by 2002:a17:906:9fd1:b0:adb:469d:221f with SMTP id
 a640c23a62f3a-adec5bb5e01mr34541066b.31.1749753283702; Thu, 12 Jun 2025
 11:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-4-bf85ddea79f2@baylibre.com>
 <aErQVKul7Gnxvu3F@smile.fi.intel.com> <275cf035-f0ca-4aa6-a41f-b0c21d7c9374@baylibre.com>
In-Reply-To: <275cf035-f0ca-4aa6-a41f-b0c21d7c9374@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Jun 2025 21:34:07 +0300
X-Gm-Features: AX0GCFu_G9WbG-CMS-t1JlbRQAQtYVirLmzxuAHYyVufUNRXely7dYTaGAXrNuY
Message-ID: <CAHp75VeewKdOQk9qoO-2Ann90hwAGE0goOtiOG9BRjJ4cn6h=g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] iio: amplifiers: ada4250: move offset_uv in struct
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:31=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 6/12/25 8:04 AM, Andy Shevchenko wrote:
> > On Wed, Jun 11, 2025 at 04:33:04PM -0500, David Lechner wrote:
> >> Move offset_uv in struct ada4250_state. This keeps things logically
> >> grouped and reduces holes in the struct.
> >
> > Can the (smallest part of) the diff for `pahole` runs be added here?
>
> Well, I didn't use pahole. I could just tell by looking at it. There
> was int followed by two u8 followed by int, so we know there was a 2
> byte hole before the last int.

Yes, but since we have a tool for such cases, why not use it?

--=20
With Best Regards,
Andy Shevchenko

