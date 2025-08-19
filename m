Return-Path: <linux-iio+bounces-23014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A0B2CC4C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9703D7A3083
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6130DEA1;
	Tue, 19 Aug 2025 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCDqr0pJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBE22FDEC;
	Tue, 19 Aug 2025 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629061; cv=none; b=OrbAuwQq+mQQRMi65ltfuQZ72SAWAzbt5nmtu9lOp3+miTR1bvLnG35UudNSahu4dQ0sAD3leLoPWKSN4vm5ITuV/7YGklKuK0CbgXZSXmpjWN7QHMuR3A+mPor2Vb41q23v1EbR1QNNbwbtCg819VOHnYcQNvo5o/cV+2fCMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629061; c=relaxed/simple;
	bh=UcYskV4CIN05uSXAiSsCeHVBj5oOi0G1fynlgggpPdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiqQ5R4vaAS/OYF+Zgjx8ZoSdhXleLMvtQnGf2etUT6m5sM0OgxX0jDMaf9TV5rqg/1B+T/3pn6XzGesHKBt8EuIrfLhlVMYaZF9s4V7VYMwepimoTlbJZZpFJdvn3Q3UVz61kXnju8u2kkF4Y5cyJEB2/eDMY0onZ7jxaaan4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCDqr0pJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333f901b229so44638511fa.2;
        Tue, 19 Aug 2025 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755629057; x=1756233857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcYskV4CIN05uSXAiSsCeHVBj5oOi0G1fynlgggpPdE=;
        b=eCDqr0pJaW/SaECBGDKL/gpO94tiAgpwSm8acafGKeNxlf+V1i/F8Fd8LzmwUjCtmn
         sLra1jL+mKCUnkRzhkEl4joF5ZDlc4NqxrrWbtjw6lLeISdLQRE889fmh8jGHdi1+hWb
         u3d92AVzHJlZshUmtfk+q0+B/yhGXuPWNf6Nreeb3DlSl4NAai7Eewqj8ml49fLUodhK
         6yR1iEZsPo/RtMRMCGpI3f4rER9PF3cR31wxQIxxZDwTstTpNVbjf5dPR4IhHXG8gU9N
         JpIB5XTX2hhwKcLC/Tmjw3Tr6nlG9XD24SF0qQ/svLOlsYmBuB/fG1Pc68TkR7qsFbKD
         6Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629057; x=1756233857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcYskV4CIN05uSXAiSsCeHVBj5oOi0G1fynlgggpPdE=;
        b=kSRAb0GEGtW+R+559zpDD1StnWmxfLtqRlKGA4sqlQQbNWZhQ0NUPdwC1JGfZANab7
         GyPvyTE5jomXUjxi9FNJHvOts8q8ErZwYzxGaPq6+ip7J6Pdv+tnaSTZx/wGf1zp+m+K
         cmrQL9+I39Yxy5A26EtVSrARZndy/WGVkRr7w7YsFw/jO42delJxkY5ogUCEedfGTWw5
         u7fQU+h8nD2JVEAG9x3e9Xtm95woB4StH8b/8IVL0Vvz9YkTRHudncQlGR6swGj8sWh1
         m3iNFSKhYnf7S2LlEsiNauNUGoqFkav0lVDgzUoxjwGCm3YHauflNVBcmBNylIqBgILg
         Xotg==
X-Forwarded-Encrypted: i=1; AJvYcCUqVM9B1EfmkG+fqJW1K+HPar6qC+JeaMJd5z18ASBRtxrPF9ZmHblrFVwbnAnJine2oJQGYpXpawSP0L/3@vger.kernel.org, AJvYcCWYbSnRgXwPnT4NwOq25/CZve16i9yMadXfBozDxb03aeTqxXcWCr8XG8PRmVLenNfQfEaUk8I/ItM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCC27kvq4m3SgopKuy1CeE2ByaZUUOFrM4Qv35AZpFAmDT8HCX
	8YVzbX3TAuYdlyTB32nfxyMFFACmX8iycFvvjtP+PA0BwJ3wgzPDSgVyOcacWgdJpGAl2vKPyUt
	s/y/VtZyhDXQxrP6X/pgs5vqs9l4fM5c=
X-Gm-Gg: ASbGnct3FcTu6OW10HfjpR8ynBOa6GrM63EB2QxVilCAnor/rpZvwi8wPfOvOHYShVZ
	I0PyzXH1J/pLvmzaBPsXcA2INZJwbMjA6HcHCUbqH/mEsuEJNdYYk2INxHa2AHWsJnbXHquxbMM
	QGOIYuCfJMGVF/i6kcUCY8bUduPDd8QqKA6TCMLr/8IEoUUz7u6Qg8QSj3tncQMTZrpqr/Ui2Sq
	77YRGs=
X-Google-Smtp-Source: AGHT+IEDyTBew0x5Dj202Ju0JCbquyS6+m6nz/cjh0EdcLcCt+vbtACwf4SpmJ7Dp/C111yPOutkcLqjVFegEwAdwK8=
X-Received: by 2002:a05:651c:1108:20b0:32a:6eea:5c35 with SMTP id
 38308e7fff4ca-3353bca2bdamr245611fa.15.1755629056788; Tue, 19 Aug 2025
 11:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819125017.635182-1-rongqianfeng@vivo.com>
In-Reply-To: <20250819125017.635182-1-rongqianfeng@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 21:43:39 +0300
X-Gm-Features: Ac12FXw_fKoM4mDZbusmFzSMy3vbbaRFHMHzdUrGQjEPDsYKdXQ3VL1qxfSwFeg
Message-ID: <CAHp75VftM2E6Kjcxh=fm9mawqqgYE9=TLuW=0eRZ6VDD7nZBew@mail.gmail.com>
Subject: Re: [PATCH v2] iio: common: scmi_iio: use kcalloc() instead of kzalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:50=E2=80=AFPM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
>
> Replace calls of devm_kzalloc() with devm_kcalloc() in scmi_alloc_iiodev(=
)
> and scmi_iio_set_sampling_freq_avail() for safer memory allocation with
> built-in overflow protection.
>
> Similarly, Use array_size() instead of explicit multiplication for

Use --> use
(no need to resend just for this)

> 'sensor->sensor_info->intervals.count * 2'.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

