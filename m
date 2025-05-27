Return-Path: <linux-iio+bounces-19971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2B1AC5B53
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 22:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9F41BA3793
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A10207DF3;
	Tue, 27 May 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUrATRbm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA7207A32;
	Tue, 27 May 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748377528; cv=none; b=bk7mWOmy/3YLAQHuI/atHUdvvCfE12DkffmFDJwKeI4dk7YDyX3VnU0b+tjh1Z5jjN/PApUOGPQvmJsJVP1RKGxqrb+z9iiqt7clIi3bWlZTVt7eLtUfTFGRn+gmTVcz4yakZOxF8aTAqq0bCcaoA0Mf7gU3V3uZlx34UNUfdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748377528; c=relaxed/simple;
	bh=7WLBv/ofKKpVQ4+N7iBDcStjFtc23UH+TamlWsR0YRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wgv2a4cYRjm4fjiksCr+/MMrioLkFirx9hTabkPfdcTKmbtTCQ1UEq7gzeBWRwMPSFXA8XGRq5KGB95XsKVo8F65NMvudxSBk2lAYoZ601KhXNo7InhvsbuSXA3I+LQl7/CVoH8sVNbZFMmOuBKGv04UzQscHFb3G0zT6W6+bWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUrATRbm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so600651466b.0;
        Tue, 27 May 2025 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748377525; x=1748982325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHriREhYXsVN3PTfpUXKWCC6Fzlb+eD24NDVbENg//8=;
        b=EUrATRbmLkDSAci5C8nWvt9ygmR4Tjaxj6BQ37uFbbGKhkYR3BowSd8AJhzDZFb3eP
         fgwTmGVNgtZrRQJhn5MhgDrWHJ4xpbIuONeUoNoiqAL5gvshp/Myij/jzhDupaUG1ojC
         StVgwFWJ7+Q205G6PdJpBmRD41XBkGyGgQGbnMBOmysjk11vDHbnLZc4Y9OqZUD4ph5v
         UH3G4zdJ8kFXRVPv939C7oSrIrBqSf5pBfoiCDy8+i+wKNq8xD6r44sfqff1Dr4XM29z
         kWnavCLr1+MXXY6rrJ0fFMYHYgXOkCGq7/dnfcuds/+ssL2eWadZM3cj0ODk+c30m4Hw
         iOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748377525; x=1748982325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHriREhYXsVN3PTfpUXKWCC6Fzlb+eD24NDVbENg//8=;
        b=l/a64CtE72Nqv3xWVsG7+YKk1nBLzbxMB1/tHeGY0gYZpjGWozwdaPyN1eFpysNjHy
         6L4Mq4hvVA1mLVRdk6tzWLIePRKmARpAudqCKKC1d8XJs4hPYwQIf7XfaVqF9cyGRkvc
         UtoCBz8r+mO4UOmuweU/nRLl818PfTtogaqeliBuwDT+GoEGoI5Sp0ZAlWQlB+hf3Kuh
         yY06Yk2Viuty3fvc3thCrP5LKvkUJTsyUoTDsb2PnpxQyrgwH6H62vm/0fubyMT8ohe+
         f1WUJ9X3EqsImy3jy5IxqnNRCj9MmBGDHQDzQhzIFZh5b6dY+EHmIWUO1RTjsuj5UabX
         wYCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQKbuaSxNNYAq/LiBPURcCzkA2uOms+hjmB2qhBEFspCqoQXUpR+N/cRLjz1VzEUy9oj3d9x1jRbFG6wSH@vger.kernel.org, AJvYcCX+/aG3ODow1oa2Rjvu3JuA1Ex7LV2Ka0AAZPxcr9S9YlLQE+BkLh/De6moWGFGHdW1D8/060BNgTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNuqOmXzZamsZZq2q+zDKkGNK6r3zbf1Vx7zROqRCrzgfQ9M2
	SgXF+O+LYg8tXYCgb86RvETjb/zxBz7+3nRH0dkR+nVJITZlruh/rGPHfWIZ8T2rSNz6XpnAsDg
	sf+cNRHTahlBmF2gZ/RcZ00it+BJgUTY=
X-Gm-Gg: ASbGnctD52HdmDnECWoZfGgg/Nj3UJh5JC6fOnAsPBuZd4A/WhEXbo81nQ+GKum9HRW
	wqaveD2Axir39dW6Nf0K6N49R2/yNpkeUZPVic1f6znpmIQMAURF+o5LIX/Lp1FDFmaq9qifvL4
	M2HiNDT2VWrMu2YwxD+Vvxk8e8fg4wNfzuikQ=
X-Google-Smtp-Source: AGHT+IHAGL3xvoj8++xzNaJa5MIllYOt5VZU3Fz3T2O8fX0qFTK9cEIra15ddslMj35d5MOx6ZObihk8vOpa+ZaD2C8=
X-Received: by 2002:a17:906:dc92:b0:ad5:719d:3e88 with SMTP id
 a640c23a62f3a-ad85b1e0c2dmr1351901966b.44.1748377525110; Tue, 27 May 2025
 13:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527200534.98689-1-gye976@gmail.com>
In-Reply-To: <20250527200534.98689-1-gye976@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 May 2025 22:24:48 +0200
X-Gm-Features: AX0GCFujAZCm1Za1N_gkC8n3W3cwjzAK8NaKYwdLfXL1IAFAHm6cDfMAe_Llecg
Message-ID: <CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Avoid data race
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> w=
rote:
>
> A data race could occur between `atomic_read()` and `atomic_set()`
> Use `atomic_cmpxchg_relaxed()` to group them atomically.
>
> Previously the main logic was executed when `use_count` is 0.
> Now it returns early when `use_count` is not 0.

> -       int i;

I don't see the point in changing this line.

...

> -       int i;

Ditto.

...

At bare minimum they are not relevant to the patch change and haven't
been described in the commit messages.


--=20
With Best Regards,
Andy Shevchenko

