Return-Path: <linux-iio+bounces-5285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C98CEF32
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F992819BD
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897E42AB1;
	Sat, 25 May 2024 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8nbfQTH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D01DFD6;
	Sat, 25 May 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716645699; cv=none; b=bvivYMJQCsAKsWGfsemyct11drvg7goKprkF/YQAx94WwsFHgJR34WU6fvaw11OWrVyh8yZOhk6ARy9Jt3347R/LCF2yAbp5HkmHsGHfgLGbDV6YoNdyd9XUwqFyWbYhTIgiuH07OGM4y/9vLpBUFeOLJTddRpSdGOXBelqUXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716645699; c=relaxed/simple;
	bh=jz9wkc1FMP4qp1PK1KagkY0E2zB1V5eh7JiuozjXfyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxfkGyOBpMVHNVIXQrumw8Q9tadJ96wwhaKJJqDo4LkzXL4SBCKoye4I32Br5QpCR73kB1MPFI7+xKI1MEfVoEh9suk+r6yel4PohJ6mNe7MlwOP58QMG3ZzHt+3pdYbgckzi6xFK+AmjYmNhrQqbcrl3V/4h8KeX5m9RKtgs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8nbfQTH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e724bc466fso83689801fa.3;
        Sat, 25 May 2024 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716645696; x=1717250496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjIf/Nlt5hfmMgIm9+EKfmLkc5Lr9onDLEUZ7ihTSio=;
        b=C8nbfQTHijM8OKftU2wzt+GSwbAbdNUaAXmg80F6gfOQYG5/odVM16o9+9uNF1xXg6
         6bQMk02PrZPdS1M2eCNdO8lBSieM+4ehSNV1Rl/3NUhWIv6MMxOwV6cTht6ryqoJCTL1
         8fuYEW7LlntNDNYovM4a3dYaRJfujLrXz3cAiR/MO2M5qnDbBwnSz58yt3gdo1HvF7KZ
         yasdpEusroWdZhiWLXfePGwtJ6UiekL53eiA5puXN77E6cxX8lb14MjHjL8Rq7b41+vG
         jO7comiCvYa4oWvqSwRqApRHYLXu4aCOnGwavvlf1EgpEZT9TNH0rni+cdElRVDdwPyB
         uhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716645696; x=1717250496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjIf/Nlt5hfmMgIm9+EKfmLkc5Lr9onDLEUZ7ihTSio=;
        b=WUKIpQY6Z3QntlJK6wjFW2r7+yPMVIYQJ+bCYkBbqjNcwBuxYQ1pMuEELcj4OimVvf
         FVLQxQMmicJRboSFFuxE39swTve94qoobULknLhcZ3Th5cvRT5gFX9do2D79/kFFcfIs
         ZqDpfuG5dROBqFA74py00QzjCHyxeuhe1LtAXIRaPl4ojLsdKqb7B/XXqReziTx3Vb/S
         UsgDDc923vz/smS9c62YoEz+XboG0hyC8563VSTYiNxWkT5Ol/jy3WkSb2QaVxAwZDak
         91dWOcu80pTnMGLA4np98r8Fk4HLA7NxcoKENXLArNpt3gvaGXL5imgJcy0wPhO9JzYL
         Xwmg==
X-Forwarded-Encrypted: i=1; AJvYcCUgiRSgLA8fS4UCKwcQsjxwSFayNw6cUUqz8TFu45o8Phs5JDq7WB3slMO9WBtWRTOFLG2uvQl5BdsJO7nNqYvgiTVwDukF7R/jYRFFiIrK+oW6++s4digsXgowFjzjV8TelqZNqGxQ
X-Gm-Message-State: AOJu0YxWmktJD/wL5Md6/TeFo3fMbFQjLVnmMDZ3ys/hwG0uUvEDVzoj
	/Stkn34Bwg79bZ3NX548BunlmGBAGGHykMaOn9t3MZUnDtVfnTkWs8RkpswbcwpjU4P1EDgXRIh
	NwiMqIi/S6Pi/yPvYgM5W2MxYT/Y=
X-Google-Smtp-Source: AGHT+IHy4xNxaHBYuO/6Df4lWzmUbbVJPFJKbyrk49Ry6yefo2WEXYFOcDI9deIszyWdSb6CWPt6cebYXP2Gu8iRLSA=
X-Received: by 2002:a05:6512:1051:b0:529:a66e:5b52 with SMTP id
 2adb3069b0e04-529a66e5bd3mr1852678e87.46.1716645695725; Sat, 25 May 2024
 07:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
 <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
In-Reply-To: <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 25 May 2024 17:00:59 +0300
Message-ID: <CAHp75VcTxXsnKVR5EQYTNhokHeXrOxQPe9gAkWFRr0yZT1KTPA@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org, 
	lkp@intel.com, oe-kbuild-all@lists.linux.dev, lars@metafoo.de, 
	swboyd@chromium.org, nuno.a@analog.com, u.kleine-koenig@pengutronix.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yasin.lee.x@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 3:42=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:


> 5e5a419c9407f6 Yasin Lee 2024-05-10  1110  static ssize_t hx9031as_raw_da=
ta_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppo=
s)
> 5e5a419c9407f6 Yasin Lee 2024-05-10  1111  {
> 5e5a419c9407f6 Yasin Lee 2024-05-10  1112       char buf[BUF_SIZE] =3D {0=
};
> 5e5a419c9407f6 Yasin Lee 2024-05-10  1113       char *p =3D buf;
> 5e5a419c9407f6 Yasin Lee 2024-05-10  1114       int ii =3D 0;
> 5e5a419c9407f6 Yasin Lee 2024-05-10  1115
> 5e5a419c9407f6 Yasin Lee 2024-05-10  1116       hx9031as_sample();
> 5e5a419c9407f6 Yasin Lee 2024-05-10  1117       for (ii =3D 0; ii < HX903=
1AS_CH_NUM; ii++) {
> 5e5a419c9407f6 Yasin Lee 2024-05-10 @1118               p +=3D snprintf(p=
, PAGE_SIZE, "ch[%d]: DIFF=3D%-8d, RAW=3D%-8d, OFFSET=3D%-8d, BL=3D%-8d, LP=
=3D%-8d\n",
>                                                                          =
^^^^^^^^^


> Also use scnprintf() instead of snprintf() unless you need to check the
> results.

This is incorrect advice. You should recommend sysfs_emit() /
sysfs_emit_at() in this kind of case.

--=20
With Best Regards,
Andy Shevchenko

