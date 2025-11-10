Return-Path: <linux-iio+bounces-26126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BF5C45B4A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 428174E9F5C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857C302154;
	Mon, 10 Nov 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AZ299r+v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A3301716
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767932; cv=none; b=GSMFT3/ckqPS2CJteiz3AJ23GB4GT44Q550cxPMgOWPAjm2Dx1Rp90kjU/khRHqIXWcthn3kV86J7WvrB1TCquu0aHtFgMXU5YL5tZxA/0YI/YOuazuHQLLRPwpeizSzQkmrAz1DJcXwPQQG07qQ8vH0tWMgphPb36E5yKssXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767932; c=relaxed/simple;
	bh=qnjBiMJkIXLvcN2tQ3kKtwe3MPoSDbfxMzyDw/IYIRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW36J39FhI52jZZL+j6cCN4SZBCvLT/Ta7oooKohBhBYAP//f12ZlmjMBelo0Xk8IpbNL5OZaed7Xl5UwwLSmbFwe5Q7IlOl63X1rdjGv+9gRHR83dGz6xD9ccQdnw9eoy3T4lRnYPt/rt/5x2Tn3Y4gwNMc7YhbBYQT5DCvMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AZ299r+v; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso23521081fa.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767929; x=1763372729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnjBiMJkIXLvcN2tQ3kKtwe3MPoSDbfxMzyDw/IYIRE=;
        b=AZ299r+vF5tZeeD9hkfovPHbhl1Vy4Jl4+QSx5dYTrd+Qjo6w7lVRfRJ0lPnql5eMG
         ulEV6tG6zT/8QvmT3kXOcM2FzeewH5fhEn5eC9fd/8fKG9sgoMTaK0SSORozp/0bzEbC
         fVyJwL9A66+ge+Ip69Z/sbfqd7irkd4Ez4lVhybXKrPxdBlfdCdQSydlzv41/8ILRfa9
         yvEmxWjCNaCTdnv6WsUGbfPhRTMeDeFFKz5htmhL2H9tfGxsrrGuXJ7KqqUUW0tLvIz0
         ChLhhpUFPuGV8ZB2KU9cGIygf6lhdRntOc+BMKH4YXGGhExCgMBfeVRqsKC8oRfgAJZ3
         1zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767929; x=1763372729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnjBiMJkIXLvcN2tQ3kKtwe3MPoSDbfxMzyDw/IYIRE=;
        b=U90HIQ508mjKKXeSJ1w7WGmHzBUThb5fLD39WUifnhuGe/8jt7HZT7SFl4HHdqZl/o
         9BBWeldx21xTcHmM/QrXyAfOSFWZKDQMajWHg+4h/nuaxPr8YFp2r7awZWvAU0aup4Ku
         RgseitZ6IJDruuAKW8bCVzPvfchmHjpyIjV7m4RtD4Swd8djld9bAw+mqAHRXOWQmcZO
         zoMN/2UuAfUnqJ5RQ1x2UxqKWLvDZg3M0D/O0Ooecd/WCRciy4BAkkMulPCLvowtbHFa
         sXIn6BGXSQi/xlAD3p52fyg7WYun9Au1s0McZ+d0/qTh0e/qDV57LFZxpzCpolRdGgOR
         msDw==
X-Forwarded-Encrypted: i=1; AJvYcCUyR+Yd9R1EEnIrluHPeCn0uhsWM85NKuUmVemyJ+ktqHeoP4ZtWGs5/LNPcJanKojB/S1VeoFlLK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kHcCI9Go1lzaU/eo+Sd50d4HcmPGXXyZNLfIBNv6nIvM623M
	cqAsPnOO/ejyJsFygFLzNjFy3fwyTtVgGRwg+El/n9hIzCaLy/AzKcsFyAEOiHY4q10M3e+StK3
	2+GCAl/jzf6zgxawXr6vmcZpJf0kMhcN60E/AAWQuCw==
X-Gm-Gg: ASbGncsywmzBAfjzv4i8E2wrTjfo95iSWnM2UDwfg+QjJUVwWURKsRE1qc5H3Ze6VqH
	01YNkal8DlNnSpcwndT3qZoL7Mz+omTbGp3+I0oJwLSsR+4TiznUwMc4kXyZY6+9sqUd2JZZk1L
	TL4igD5+vsStrL318ZxzpwcB0ZGR9Oo1ip49vxGvmFrzelcr4u93y2avmC/NxMhOnSo4J4w5cpB
	vzRHxLRCzEi/io4K0p9IUI/J4OFI28dksGjpK/PPAxFiFEkiB4q8hVJwOhk1dsCtW5+AIVCn5ip
	E7g8ZYlpo4swAgLqib1BqvB4QE3C
X-Google-Smtp-Source: AGHT+IEwxaIWXFScRs1Hq0fBmK7fZkWPD+yK0SQzV2/fW2LGNYN/mL1YgGP/C9AUxAvecy0lVYjr0F0QSSJtuF4wUZo=
X-Received: by 2002:a05:6512:108a:b0:592:f315:852 with SMTP id
 2adb3069b0e04-5945f184ad2mr1435238e87.22.1762767928600; Mon, 10 Nov 2025
 01:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105104330.111057-1-marco.crivellari@suse.com> <20251109164536.2ed7867d@jic23-huawei>
In-Reply-To: <20251109164536.2ed7867d@jic23-huawei>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 10:45:17 +0100
X-Gm-Features: AWmQ_bmdK7CiQUcCbuYW8BTPklves8Rjv8AJG39X1Iz2zDNrUfEWE6A-sfVQUbk
Message-ID: <CAAofZF57ahp4FP_W=fTNwYqEL5y6bYkV+b6G0ScYQm5yQbKTaQ@mail.gmail.com>
Subject: Re: [PATCH] iio/adc/pac1934: replace use of system_wq with system_percpu_wq
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Marius Cristea <marius.cristea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 5:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> I'd start these descriptions off by saying the system_wq is deprecated.
> Then people are already on the page for there being a necessity to make
> a change.
>
> Anyhow, I've seen enough of the discussion of other related patches to
> be fine with this.
>
> Applied.

Many thanks, also for the advice!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

