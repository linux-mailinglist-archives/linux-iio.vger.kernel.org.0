Return-Path: <linux-iio+bounces-156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4E7F03BD
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 01:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3D4280E95
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 00:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56728365;
	Sun, 19 Nov 2023 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D2fmaMV+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25631AA
	for <linux-iio@vger.kernel.org>; Sat, 18 Nov 2023 16:09:31 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso42827641fa.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Nov 2023 16:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700352569; x=1700957369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/5ruKM3Hz3yRyo+jUN5TQx5/j0UzN7IPSfZFbubOxg=;
        b=D2fmaMV+KwEZlpDwMwjMi/XmSTqobmkk2UFJSN6z947lZU/cn7vexHWB89vH63rit3
         B27yjf1JJJCHLsPdhBXAOKY/NuAIcwAA06OpM0JCz17d7+8SHQ9p0xqkF+rs64rx3HSH
         /SHSnVhoBj+SMFTB2dFiQIufx60b4lG4HkTA/JVls+cw8fmjem+XgRtJhsiJ+Ab86TLb
         YRWmoPtrgUtyMZVMNsRdaBCV46ORCYgBGAaFCKAniMDc0daKhJ6UjdOGa4kdV37+IoUs
         pLHu37XtOkPw39kwfaXoo2A8ZpJR8yLl7Yn9MMC7U3ei2HL8EP7ejQCaHziNKUJN48U3
         0OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700352569; x=1700957369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/5ruKM3Hz3yRyo+jUN5TQx5/j0UzN7IPSfZFbubOxg=;
        b=C2xXZLVGtrNV40jO4Hih8hhjLfj/a0STrW98zQLpjuOgOCJnS/bYBw5Bf46f7uhyKO
         Ebnr53srXa/jQDjFHHt5YyPfMap5iMgR8AHuBdfZNVU0PJfNcxlI8cVbOg7Jb4vkfxwB
         updhz9tOQliazeyC+TeWN9tWq4/2+02O4r8cbVb1eb8T7GSnpW2ucEv/83hODK75Nq+H
         OMqB4bAHqU+vHItMQN7SN7wXHBjjhLfGphDypcIVBiEvH36WXp7/ZP3EUR51qAnnPi2g
         mBUguYLiONjU7ZL7HfvSOnS4JJb14EzgH4cBphbt1IaBmMq1fXPSoVnLoE4H79X/2lA6
         Ki/w==
X-Gm-Message-State: AOJu0YxrbNv8IMmyY9W304jCKrD/waeW0odni534M92Kvw3K5TN64h3t
	6PGu0ecXZVJk4TVF62g+hFoNiropEsPrOJfC9R7a3NFGqu9gUOE1/bnUVA==
X-Google-Smtp-Source: AGHT+IGA8fLAdRMFAAZYf/r/fBwkkxkXbQB33eoeqktRg2ACGl4ZssiuzZCithPD7+FDW+Rrm28dDNrv6OZd+iB4W94=
X-Received: by 2002:a2e:3613:0:b0:2c6:ec01:cf6 with SMTP id
 d19-20020a2e3613000000b002c6ec010cf6mr2712771lja.31.1700352569256; Sat, 18
 Nov 2023 16:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
In-Reply-To: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 18 Nov 2023 18:09:18 -0600
Message-ID: <CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
Subject: Re: supporting binary (near-far) proximity sensors over gpio
To: Sicelo <absicsz@gmail.com>
Cc: linux-iio@vger.kernel.org, maemo-leste@lists.dyne.org, 
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 12:22=E2=80=AFPM Sicelo <absicsz@gmail.com> wrote:
>
> Hi
>
> Some phones have 1-bit proximity sensors, which simply toggle a GPIO
> line to indicate that an object is near or far. Thresholds are set at
> hardware level. One such sensor is OSRAM SFH 7741 [1], which is used on
> the Nokia N900.
>
> It is currently exported over evdev, emitting the SW_FRONT_PROXIMITY key
> code [2].
>
> So the question is: should a new, general purpose iio-gpio driver be
> written, that would switch such a proximity sensor to the iio framework?
> Or evdev is really the best place to support it?
>
> There are a couple of people who are willing to write such an iio
> driver, if iio is the way to go.
>
> Regards,
> Sicelo
>
> [1] https://media.digikey.com/pdf/Data%20Sheets/Osram%20PDFs/SFH_7741.pdf
> [2] https://elixir.bootlin.com/linux/v6.6.1/source/arch/arm/boot/dts/ti/o=
map/omap3-n900.dts#L111
>
Since this is really a proximity switch (it is either on or off)
rather than measuring a proximity value over a continuous range, it
doesn't seem like a good fit for the iio subsystem. If the sensor is
on a phone, then it is likely to detect human presence so the input
subsystem does seem like the right one for that application.

More at https://www.kernel.org/doc/html/latest/driver-api/iio/intro.html

