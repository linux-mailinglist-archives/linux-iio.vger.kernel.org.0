Return-Path: <linux-iio+bounces-23102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C196B2F8E0
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888E55A03FC
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B333311C00;
	Thu, 21 Aug 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATcVbSpD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59E3112DA;
	Thu, 21 Aug 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780442; cv=none; b=PNJMHqTeeOzf81hjOhDFDYS7eIQiLS6fJWTWIirsyiGeGMcUun7lv9ccB6AQLUGDp9kavEhIlTkR5CHcVwpWru4BqXABRzmcswbnaEVTNNF+R6XUmdg2ifwHhUrnWOK8stt3tl8eNZW8m9tZ3IRcbn2/18KyYi0bKERAKdtXxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780442; c=relaxed/simple;
	bh=iAlqtw/ekplPI7hAlw85q9BkNYl69V2XA6PQmsBcWjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ0eaP/24NzoFE7joRIcu1A5tcJd9ng0ZFZ3kOBunrqhPfblm0uHMfgKTShzZUYBqSXTZ3C3+p6/UWkLFQmo6G6a/TIq1oZVDMcJgSAROc9jD4qklzjeSInpx2wcBV02dhKPzOzEGVnl7DFJkk8aD5yMaSgp6nopTnNHv/gFNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATcVbSpD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so3479934a12.1;
        Thu, 21 Aug 2025 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780439; x=1756385239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAlqtw/ekplPI7hAlw85q9BkNYl69V2XA6PQmsBcWjQ=;
        b=ATcVbSpDOO2fkPpxYLOdAVmUPOnslyGA99P3FBm6zwtJFnOUrOk7TWfPYt4WrpNHyO
         vN7YrLiIaBBRhHlukCcQVRtB9GCTVSs6a+cgtZQbar9YMHeqQaIQHtch9NAycIKR6b3x
         1tvfaz0X8wOvtiFo2pkqEphjYsMHegoPkiGOeHOclCpcuATG5CJX+kkBAVXckg4lhK6e
         SJCk8vpqt7ggXq01yT5wWBPEHz9oGus34d6b4HS9O3yGwwcNMm5ZVShnlOf7qqbZPaOf
         e+2bEycpIkg3B4Cfq/K1nfUNyyXnrPUXvMmpiWoxhEovsNqiYMoEP5QQq9A7BW+mMdFI
         OeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780439; x=1756385239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAlqtw/ekplPI7hAlw85q9BkNYl69V2XA6PQmsBcWjQ=;
        b=oSeYL+5GGHGXYSfVwvGwpJDrmM9uaCJR0t5EvzwslPoV3agftITthuph7+Qze3xYC0
         u7CZbNZzYTClPICxEAv8cu8TbD1sZWSDTndy4tzBR6WRzEjQlr2kNfhS9cXarOyKHrkQ
         YmkyvaIBDPo+A6/khl5FTtINeAGtbWZufDdCDu/XvJjZGo/kIiGNvJevCw9aPr9u9tFm
         HY6X8leUzDVhXYlRp3r4L5EJnNPS+rczFzH2u6Cmk/gGRHZ3Yhb3XObqHUZ8N5gqqT8k
         Ea71C6Z/Y5vEKe81nQeQ6lB8Io0UIyT9j7yhg3viI68XywIL4XgnEQfvsGKH1AhfyXle
         JKLg==
X-Forwarded-Encrypted: i=1; AJvYcCWKHDsZsCplbi2skFRkRfYurlG7jbqxvCXK24WosqiUg3vF0RFYVVTAOYz+sPgdSXpmgjJDxGAQ6eLGVD+Z@vger.kernel.org, AJvYcCWL3QvaP7wq2ad5RenUqbMkdnFSvrSkL3ZnVlFrGN5Hl/z7LrdwHwinBA1CPc1d6KhLgSBBqTRCzd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3RaD6xibZ+yem4OhqeSL2mNh5vAxR5fJkJVOL7Vdcp4raNiM
	4KMRJjGG1Zay+I9V9yjpgSRqcWLT2cWLrwIi3KCjjcwbt8CqNbgjin3B2vTGAI5tbv0er9HliHC
	2vexVkxo0kNBuqxwn8ZF3hw0LGiTkgS+7k3HePls=
X-Gm-Gg: ASbGncucnB5cVVwf0D7gwStD0c9EiwXCE6JUGlGZ5SFFEz5f4yVXbAEfoiqSW03wKn3
	YJLIipSQByKxM4cabuQeyv3BLlH5LEmAXkbXY6Or82ALlP6gD57sRkUwth2p0cVAnQHYkrYDDTi
	PAe7DxbgrspTUTSYRQo5Za4bg1tbSYIt2F9HBVeX+x9748L8wwnUsk+WVjc9G6mYyvXEevTzqCy
	QkhMeqKLA==
X-Google-Smtp-Source: AGHT+IHmiqDKBL7inkU4c3NcsKqH46gJn0QZkqcBffSyda0YXauQGNFGKIsY7HXjFWaEH1OqWzaISPFXjLgD6k580zk=
X-Received: by 2002:a17:906:730d:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-afe0bb11421mr194028866b.27.1755780438529; Thu, 21 Aug 2025
 05:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <20250821080723.525379-8-zhao.xichao@vivo.com>
 <CAKv63usy7FsiUCjrqibcr196kVGb5_FDeU__OwLWJxasb3MgZg@mail.gmail.com>
In-Reply-To: <CAKv63usy7FsiUCjrqibcr196kVGb5_FDeU__OwLWJxasb3MgZg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Aug 2025 15:46:42 +0300
X-Gm-Features: Ac12FXzTrV-5gedpLziAcDDxaeMEe5HasNPwVIZs576dMifd7PgzqQZBBbd_MGw
Message-ID: <CAHp75Vd+p1kPPZyrkOsE7EUpCEjd0ii+uHR69EvGNbbDOFuA6w@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: temperature: mlx90635: Remove dev_err_probe() if
 error is -ENOMEM
To: Crt Mori <cmo@melexis.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:MELEXIS MLX90635 DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:47=E2=80=AFPM Crt Mori <cmo@melexis.com> wrote:
>
> I am not sure I agree with this. It provides an error message with
> reason and I understand we want as few as possible, but this would be
> a valid remark inside the logs?

How? dev_err_probe() is no-op for ENOMEM.

Also there is an agreement inside the kernel community that ENOMEM
errors need no log, as if it's the case, we have much bigger issues
than that.

> On Thu, 21 Aug 2025 at 10:08, Xichao Zhao <zhao.xichao@vivo.com> wrote:
> >
> > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > Therefore, remove the useless call to dev_err_probe(), and just
> > return the value instead.

With all that said, the series is correct and good to go. I don't see
obstacles otherwise.

--=20
With Best Regards,
Andy Shevchenko

