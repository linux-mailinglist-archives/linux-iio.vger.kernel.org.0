Return-Path: <linux-iio+bounces-19719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED26ABCC02
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 02:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A9A3AB458
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 00:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F691DF728;
	Tue, 20 May 2025 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9iWDfN4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402EFC08;
	Tue, 20 May 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747701098; cv=none; b=gmwGVNAtE3403obXuzpWnXpL224t6uMr4OYG/TFO01YtSodV655ZOMdqWcGvrtMNgEzNCA7J2XoUZyFBZFfrEfP9gA5PJy/nn2Bezubf6UcvrOsbFt1+0ErxHuCIyM17sXjCUi36ejd7SjMX87O7J4XNxOIiaspRlqdczX9FT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747701098; c=relaxed/simple;
	bh=ns9XDYIXLCeBYLBqsS+BgnN5u6+CGHLNqq0gVv2wN+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxfBMm0qLbtR5P+xoPbhioeOJnvKsXEiVTe2TRYz9vSG72D5r9Q02eCipKQS9Fxc0rcDtlDcqVAUbbzaCPuylmpZ0F86xLunLtvhjrzYWOEuqs/KiOlNj3piruTz19nxjNBlgl+ji97/HHIr51qi9p79apQVUcxaSAsjyDvKG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9iWDfN4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54d6f933152so7610270e87.1;
        Mon, 19 May 2025 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747701094; x=1748305894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns9XDYIXLCeBYLBqsS+BgnN5u6+CGHLNqq0gVv2wN+A=;
        b=h9iWDfN4A8T3LUvGjmjtxKbtYskwcBMGzJss7eVMaamTYpVRa/ncu+Qi1A3oMiw4zX
         PCn6My2yCgknq7Bdob6rEp4CSj9sje6NFhCPGMRyXgCwrFaWkTzFxN/BH/jcxPD4NRNQ
         NbCYWHsRQc79Gxz3I+QDWy8XCpzz94QrFkRjIYTBPbfJpnYdeY+/Sd0U78FFWXZGF/p3
         gVEDwUrwmi1YCa18OBwW5exD/ejPO75MsWOJjPcPBQdIu/uMdyoew5M06nQ1bALNLHtu
         ndQ08h19FZn8PGPjnwQVqRaucm9T2gshUo4WV8vXIKuquUvZDmLG5pgl4wgerZHLFnem
         LMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747701094; x=1748305894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns9XDYIXLCeBYLBqsS+BgnN5u6+CGHLNqq0gVv2wN+A=;
        b=SkW9BaPfEjMfryg9WAxOl0Bp4KBPr3GQMqOUmjuhniOtMpylpKApBdnk3rvsyp4mLE
         q2QsUPM8AP0teepZnIeRUmY/5rmGbM7EncB49LtjhUz+jM9MOXao572+WTTlVbapG642
         OYy4IzjOi73Lxxt/ldOEMcl9EEuAI4I0wwy5IOlxVpZ7eSXrR0K9IhB2F7S2KqQ0vyh4
         to/1OxKYw72AAmXU5gS46DwBmfEyA/fU3Ymmn5+oirxuVqKR5nNQaA9/sl6tHU/1/G2K
         FoyDxHuNGIVTufdzmCu/QFd2B4KcfQYjT+lp0Pva/MbrWNRpghpT+U0AswPFMTIOek5X
         VFaw==
X-Forwarded-Encrypted: i=1; AJvYcCVWgKshcP/GyyZub6HXRCq6MP0yugiZTjtTnN85v87/WLqLIqx43qwS6rZiOAfMfUEXzHafz0a28Cs=@vger.kernel.org, AJvYcCX+DCillYWL5P6owmUcYv0tGe2DDw7ezw7QwnY0TpTB2QzBGfe5BGyuZ1e55pqIGTvOH0jvytRs@vger.kernel.org
X-Gm-Message-State: AOJu0YwqFh2yQbDTTZ7J9SfFMkFM4QfRe/88pHftv+fop9wUYy1Xn6ho
	fD7IyRYT9KH3qnZBFA3FeE8MWC/grn0hTshj11vqTQkeU7vq5PhSCsAWyUhxqNtxCitiufDhtKV
	jOKzrwzFPTpzv7kPEW2DZj0sP95bRClg=
X-Gm-Gg: ASbGncspPLPp+trNjEQy3nKP08X4uPe2rjhGwMw2JeorWMzKsStbNDRybJcpsm0ykUi
	Y8YCNdQMv6Edpskj1zXCKTDyF40c/2CXguWGPEPORcyOlmzaoY3h6IjJOwL7evBrdNxN7A9/s6A
	V3EzGHYE4f9sRKr9gXQWvIWcT0H6cNBw3yCf27kEwfBshbP/JgjggdS5XO7q2nZtV2
X-Google-Smtp-Source: AGHT+IHc3qnC8mMmIb4o3P/26DdOOQXX3nerx+sg0ERdVNJOtlNY+uefNM75tmbBlQiRwdBJb++4jdz/dw+kltKT9Sw=
X-Received: by 2002:a05:6512:6288:b0:54f:c5cd:ce4f with SMTP id
 2adb3069b0e04-550e971b4f6mr3860617e87.6.1747701094191; Mon, 19 May 2025
 17:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516173900.677821-1-festevam@gmail.com> <a41491e0-595a-4614-a03e-34848446a815@gmail.com>
In-Reply-To: <a41491e0-595a-4614-a03e-34848446a815@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 May 2025 21:31:22 -0300
X-Gm-Features: AX0GCFuAOw3iH2QReFfX-AnOKr69vd_4uUAPLtQWzlUBbgyAvbsAPmzDVMS1jzU
Message-ID: <CAOMZO5CtcmpH6sMpHboEyP50iPG3qGAyzg+TEoR7w2-ykU44_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Mon, May 19, 2025 at 2:01=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> I could argue the problem which is fixed is not related to the
> 2718f15403fb. I'd say the problem has been the commit which introduced
> the 'offending' masks instead. The 2718f15403fb is not fixed by this
> change. It could help identifying the faulty releases if correct commit
> was pointed here.

Fair enough, thanks.

I am going through this driver's history, and it looks like the masks
have been always wrong, since the beginning.

I was not able to point to an exact commit, though.

Maybe I can remove the Fixes line. Jonathan?

