Return-Path: <linux-iio+bounces-21370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E69EAF9E35
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 05:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222701C47E07
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 03:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475826C382;
	Sat,  5 Jul 2025 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhviOMw7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A140856;
	Sat,  5 Jul 2025 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751687120; cv=none; b=M2HB/4/E6s0PS4hVLtaoK6rnMmOc3F4Sw4hUDKO3AmTHaIJHZI427Ysfi1q2zGWbAxUEiscgTQL7hiATVsX1/1xFBIdicWeqNORAT2ust6I2jpBBrmPaAndxE2iORKyOX6W2LEqO3JK1Udv54p/tCXgeluDGtmG/NlGQOqDj3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751687120; c=relaxed/simple;
	bh=1/qboNFZMRZ/EP/VTle86vBmjRoZx2apjTbAn3IEnXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1cI6e6AvhGDp6sGB5N/k9hD9m2Y7U8bljTRez47wqkjbgFvRkv50q7I0lFmKp7Vyegy4HpzeO8WPEu1vfYsDL6y2tEndNsy321ddXnsmuPkYwQyhlwHZWngggSilGMs0IIlqOL2mEWJonK8fbtRCruWHfcEO/XXGnrqeDK/k9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhviOMw7; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-531466622beso422300e0c.1;
        Fri, 04 Jul 2025 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751687117; x=1752291917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxn5O9R8zM5uNNIFJkKjTcOoiYIJRVckvhs4gosK+Zg=;
        b=OhviOMw78hHuHqwIVELlqV07MNijs8suI8RBcHXndEnvFUNEsI1Q2hBVVmf8GRiPAY
         6S61KIA50n7YHwBRdIC7lEiNzjbXn+anUEnYg7WnWfdjct7HFn9r3Veco29dADdAZVI9
         1djNOZIn7q7umOZD3uSD0WLd8wlEGyskRU8oFhoDOz8cpIB1V+zJG+N8IORcESI+RU9Q
         CI7iATiFy5L23ZZLNCaK9oZiH44NXzTnMXvit1QX9/285FDYjE9o9PhzmldCg6kAf4jM
         H+T+bGYOXQAgIrdcCF+SAoFr8smWuaxSVQCoGGMQeNYHWaXCWSauO4S2Xyhj8X9pSj00
         ZmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751687117; x=1752291917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxn5O9R8zM5uNNIFJkKjTcOoiYIJRVckvhs4gosK+Zg=;
        b=rGz425APTkdqep+ZfQKbdzmSVLIqBQsA1B3OS/egQXYJU0TjsSI6HGmewVlmJx+e+I
         MQJankTJif3M+ZwY57pq9UcUdR3mi6sJXCmQZWoiJqkZwDAID4nNqAlyVJKt1SzHdDfE
         Hlj7EvXVJNATsCqTMhf5vbgTP909nqfAlIbbn9boJalxkaxte9uaxC1n5DdQXStJK3uv
         g+RuyQng5NHL5cz1gLiJqOlOhEO21a2mJA5PfBHGCi9BVPxMKAna0TBWHhlwzRaM8Qza
         8sBQsMsCGA0vC9qsLdMTvofxn9BwuXO1MLuJuvNbOJ+NtpFpB+ql/phrAUNAq2+91+gB
         1ivQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFZeqZDc8+fGFWfyxK1auiHl/qVGfoXBTljZWN20PJKsBfvQlmNzMzttmmGJI9iNbb0zpKikdyBxMTKV3g@vger.kernel.org, AJvYcCVsAKeEGcjs7KQ0aZ7BdTGgKvf9yun3ViykXFUNvH1ahRZehcTbtxMheXK+wnaVUf9FLQWY4CvEOHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4jMFMtw4rUJ+uCb3BZkH4XTot0L3Gt2AYLac8ganNrpoSbcN
	JyiSWvoashpqbfRw0XyrbTglyH7AiiL8w9rMWGQ3dpL1N8+MX3L1h2lJT8WKWQaRzNkZLlZ5g6Q
	vE8B4jpqbSxt15pMyDGXwjN7WzsYJP5Q=
X-Gm-Gg: ASbGncsSIb1NCrBhRl62AMlpI3IyRXB8W5WmONIRhLO55u7Rl2mQZdyeJwjwxr51MWc
	RABXh9wRG3cWyPjkZPaVrBNgnW86JDjlTvVvwpzutq5ojPQVtFvu/WB1EBKsKxDbL2Q2IvzjUWn
	9ac59rNIgjC5CE45yLNPtsdiu4i2sBF5cwK5ZmankAWj0=
X-Google-Smtp-Source: AGHT+IEsd/2gkkGLE/EI1r1VxK55gqF+R/IGayYk2sj+60uzmX9UpMRv4oN74fB6peBV3OlZpS4Aak5g8kpH3Es502E=
X-Received: by 2002:a05:6102:440e:b0:4de:81a:7d42 with SMTP id
 ada2fe7eead31-4f3059d1026mr586361137.1.1751687117297; Fri, 04 Jul 2025
 20:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <20250618031638.26477-5-andrew.lopes@alumni.usp.br> <20250621185824.69a11319@jic23-huawei>
In-Reply-To: <20250621185824.69a11319@jic23-huawei>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 5 Jul 2025 00:45:05 -0300
X-Gm-Features: Ac12FXzLQp1RDoG5qPnWWadTRP__sjuPHvBZ1dJbhMZEQVeKR8lz7IW__q6hiBc
Message-ID: <CANZih_SWg03U1jOn63++A=+_9GkzFhtK7S563hdb2m=tk5SK0A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] iio: accel: sca3000: use sysfs_emit_at() instead
 of sprintf()
To: Jonathan Cameron <jic23@kernel.org>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 2:58=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> > @@ -423,16 +423,16 @@ sca3000_show_available_3db_freqs(struct device *d=
ev,
> >  {
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> >       struct sca3000_state *st =3D iio_priv(indio_dev);
> > -     int len;
> > +     unsigned int len =3D 0;
>
> No need to initialize as set on the next line

That makes sense! I=C2=B4ll change that.

>
> >
> > -     len =3D sprintf(buf, "%d", st->info->measurement_mode_3db_freq);
> > +     len =3D sysfs_emit_at(buf, len, "%d", st->info->measurement_mode_=
3db_freq);
>
> sysfs_emit() when you know you are at the start.
>
Ok! Thanks.

>
> >       if (st->info->option_mode_1)
> > -             len +=3D sprintf(buf + len, " %d",
> > +             len +=3D sysfs_emit_at(buf, len, " %d",
> >                              st->info->option_mode_1_3db_freq);
> Fix alignment.
>
> >       if (st->info->option_mode_2)
> > -             len +=3D sprintf(buf + len, " %d",
> > +             len +=3D sysfs_emit_at(buf, len, " %d",
> >                              st->info->option_mode_2_3db_freq);
>
> same here.

Actually, both cases are aligned. I checked the code and they have the
same number of tabs, and in this email they have the same number of
spaces.
However, since I'm not reading this diff with a monospaced font, for
me it appears to be different but this is caused by the difference in
size of "-" and "+".
Maybe this is why it appears to be different for you too?

Thanks,
Andrew

