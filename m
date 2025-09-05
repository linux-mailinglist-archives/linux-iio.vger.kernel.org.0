Return-Path: <linux-iio+bounces-23775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE4B4582F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A841C282E4
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC034F486;
	Fri,  5 Sep 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz4CkTFD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4433171C9;
	Fri,  5 Sep 2025 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076726; cv=none; b=F6k59beexcNLUKvvSQ6yKGQgFvm7WP8Qhhs+XsJCDgm5NHcNroe9VmbymOrCp2G+l13y6lVu1gsG+Ug+SEkOCvWjaTVqicdQk1JWH/oFa7HpNHCmaFI/fWyglUI9khjmdcFM9Apuvq4qSu1Ahm8NYO2EiBXxQq6C4uJyWRttIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076726; c=relaxed/simple;
	bh=1lJqfn1/uB8y9018YPf/Wjob8LCFnwteI0Ft0nKjXIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PP43DMRi446HWIcJ38tUPJnBIALD3srJ+IFYozrsTbsJB1HNzg7WB0ENj5qU8LUhtCo8J7aiksFrXseI4yFAKi4qDtjMEPwOJ+NytLUL2+H9SM2EI8k2/Gu3PIbV4fHYdLZlCvqfkcFDmZHqor/ajJobUFHnbzZrPxqGvyQ4Da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz4CkTFD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so5831761a12.1;
        Fri, 05 Sep 2025 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076721; x=1757681521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziV+XqeYRkHAwdBjvAjF0x4ukMyU7pFERZM6NiV19iQ=;
        b=Oz4CkTFDy+Y6IuOqNwe4DB33LCJsPOzPHBh7QCaghBIz1fTfGfV5rmVDNt0z0pTogD
         O0HBTMDFu/PQPakQE6XtbSms22vsxIk7/l/wpY2gt9XgDACNNcKlIYezWxLB35+pgOmN
         BeW89xP+0GB4R8R3IazvB4yguom2Zm7szlgOn/LQVHnSTzS7noZ8OYGwSAOpAqHSJWd3
         bdwHkJEGHRO7p1lNHTMYpay6waz0lUSdQKKa/5v9rBfDAvwwbuO655BctElEku1EU3tB
         0Q22YmiKmciXfNfvZHncnuZkxGlVU4SPtw0qPqBtR+fdQq3I1tMo9Qd97OsRckjPGOpM
         RpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076721; x=1757681521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziV+XqeYRkHAwdBjvAjF0x4ukMyU7pFERZM6NiV19iQ=;
        b=VC4FBNTCcwxyzAHzhBbBDG/XWbyJpFneIUhJFGNLcfxkKGry1Xr9ASdMujeW2xt5RV
         BVRWMUfJ42tqEukDXz1AOHiklZhSAAvlncld/f3Fxp95Y2Rud1jNxMyMD2aEopNAxnAt
         AlxZjO8Z3kPMzeo7g7GGGRxyUwQ3HkI33AjUbdbJrpPLNLPy0PwFzgcvJTXSvD3uy1Gb
         DCE9HNEbO/IrcABO55Gy3CEYxEVzk4KDiv9TNGUfyfOD3KJDBVRpgV61rjSTqpG2Jmi/
         11IVP1c6LPE7LZVKBFBUGhVCT8Urf0+1gf9foQe8wMTqQOmm4zPLQKzynFjSpXHE8Qs1
         VZDw==
X-Forwarded-Encrypted: i=1; AJvYcCUc6XmQVj/+tmRwxKwlmXvwhp5UFXR1TqHzpRM/2TBrWxdbjFvHq9zc7WfuXWRyobpNUJwHpixjvRc=@vger.kernel.org, AJvYcCXUR3xzRs5HTu0D5hFGpqA9Zbo1YBs1r72YgouFAGdBBrdMfGmHSzO0kFyUuwLpW2lavW8sCfq+/erolRHO@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBMXhHM9HXzHVywFfsDQmwYhf37qRbRPo9ZAtAzrn+Nc4V2CH
	vCC6xl3b0NWFZ87jQND496eAik0T5J0q6u/qGOMu7qr1tWck871GTSfK86wWLnfpdId5EwW+Y4R
	DfUiSJEkq/A9Yuz9zXj90LHDmu8z0iYU=
X-Gm-Gg: ASbGnctShvm3vlYHs245Zz1L0jcFbzMUuWD5LykJQ2v3EfW8d5GMoyVe7tYapEbO3fs
	4p+opsLdrUdPdkGAiKxzbczjHaKCaUVcSIiyHlUC846dFaviwTWXhj1tYjZgRg4bo1XPMiOogXC
	I1WtFR79HgS7i0VQRCoxfxFhJn7k2Yrw0fQfBkVTYCXRuGo/+uNXM7w2yXbWR7IThOe7uqBAwZs
	epsUxYINPrGmdBcWNBm
X-Google-Smtp-Source: AGHT+IHg75bPktAmt+k0dCSmlEaci9vfvll2JR6mlr3n/MiYVkPhsRkvpnD5MG2IvT0ZkxbdhOTPRnwe8BBHyCgmGWw=
X-Received: by 2002:a17:907:9809:b0:af9:3f99:1422 with SMTP id
 a640c23a62f3a-b049307e6c1mr380537266b.5.1757076720724; Fri, 05 Sep 2025
 05:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091115.2687-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20250905091115.2687-1-zhangjiao2@cmss.chinamobile.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 15:51:24 +0300
X-Gm-Features: Ac12FXw61G5NTW2HMdo_6oAGOHWCSb7HMlZUPgskU-QvIJQbiuu1tkdtWpKO-fM
Message-ID: <CAHp75Vd0G3FU4WnjfRLfo_p-vaN+zp8AEjycfRCnfnchGrQHUA@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: rm include dir when make clean
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:16=E2=80=AFPM zhangjiao2
<zhangjiao2@cmss.chinamobile.com> wrote:

> rm include dir when make clean

This needs work to make it English proper text with all grammar and
punctuation being respected.

...

>  clean:
>         rm -f $(ALL_PROGRAMS)
> -       rm -rf $(OUTPUT)include/linux/iio
> +       rm -rf $(OUTPUT)include

What?! Please, explain "why?" in the commit message.

>         find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -dele=
te -o -name '\.*.cmd' -delete

--=20
With Best Regards,
Andy Shevchenko

