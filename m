Return-Path: <linux-iio+bounces-18532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E368A97814
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4943C3A7395
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC72DDCF0;
	Tue, 22 Apr 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DihY70s/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685C244676;
	Tue, 22 Apr 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355466; cv=none; b=CMAHF7ak2GOZFcfBYzEDQdYd+UBKXwx6Nl0yUrJE/AVdyIG0sArR2ElFJOToxavG19r3CoDb5eY9AXP6+zafjlR9ZvJ6INVlEfQafT5ccH99/peOH0iAjMoSjyHPMrD1KLPIBE1RtM0hKLOktD3CttU6/ke6PUNMC/8yXPsR+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355466; c=relaxed/simple;
	bh=UwwaIRx7DzNpf+e2zP137gEqPfoImRPx00geFNMzItQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GstzdLuMEWJ1i/KeFxh7okeI8/qcdJ3BlCw3EWrs4W12HWWnI9wPlYgEvigU9biEGZzop+LnAJ41aD5Yqgnsw66PuXqRbwprK1qA1MSdVUaiNZH5vTTYEY5Zhf98h9pHxupSH9mQo7Aygu1Q3retl8XtTi+7YXuyn6kIiJNDVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DihY70s/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso595262466b.1;
        Tue, 22 Apr 2025 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745355461; x=1745960261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACryD6HUvzVZZNuuQQMpAgIXQmMe5NYVrLKyNsZ0hzA=;
        b=DihY70s/m37KYLkwJtqLWf/TM1fmmj7j1CrqpBvy9G6HGb1KQVyeCZPbZTMoXg/Q3S
         k11fiwUPNTSkTvAsKGn8WLpATGxP/p3ILQkpooRGwL+HFodGLKIFF2F6eSZije2pKvdK
         8ADcBmjN2pJFhdVCNiNXPL9VICuUG+q2d+vBZfmkK/+l2JCeQ4CpZ5MJU5/JbHH3Rxm3
         TtfZ3LIs21X1cDTl5idm1vN3NkA3Tps2kVMvwMr/uAp0phQwOfjeG+Jq1Jvg13q54K+a
         CNQaBxQEkUMT7LdSGmK5bb72Y7D0I2SbsibLROUTUyQ+iWIXCCmUTiqiLuRneTW1SI8h
         REaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745355461; x=1745960261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACryD6HUvzVZZNuuQQMpAgIXQmMe5NYVrLKyNsZ0hzA=;
        b=f6h7D6wBmVW3J8XTyBJ6kxDEeCCYZdsC2mH8zsWPczh81SHBEVeEzFRCDExUfmV2E7
         Ptv6S0fbt/AXOXsLC7rQ7ALfXF+pS7paU9uwh+IX7vVGNlzEz3DHKfTgHiKzerisC9Mr
         cbJXrZpN2K4Rav0DuER7GKXlf/1mWXDyvNTodaaGYjvsS3qtYGiUeQeGBZRkEXkknEj8
         3oIjKlLktyuoYM3e/Ga2vNG7yyktfzS+ODA9DUSS/LSQqo9RVC9eMu/A6aqDSoAoywdW
         6L4koVty91f7fz5dH621SD15I4/LvmOXb5ylfDixl9zPlSvc0XIjDK8646hcyWbuSGzv
         eZYg==
X-Forwarded-Encrypted: i=1; AJvYcCVdPEeKh6ETP8HA7weK640JCwpApNdf/UJ1LDcqf8+htyzOGrCU9Yxg5gP2oj9seY2P8XL7g638+I7oMeST@vger.kernel.org, AJvYcCW606Kw3G1ONRSExLMrXn4pgra7flDYYfloEEy85mMmJY6SbQmKo/fMlLODuV6Lft6+ZHlBwL34iy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNPTzmDvV0o9OlqdWDBFRQQyT0O/Wy1bNuI2muCNM1IxKlfHP5
	gaRD2oZQq85fKwxewPFcc7o1aENBQImBsu3FgjFtjuyZL2aR2wQYkwV+v8UQtCBn08Dd4zmRuo+
	mSBSFX7BY8K++f4yQm8pQ943MbCJi8Mwj
X-Gm-Gg: ASbGncthR8aqx0xECXNBrcBLZXyFUCQsgQJ8IYaoUMj1bQ5TEAhZ74kCTFyiNDqKj1J
	t110vZE/psOVRZezr99396q+wqYCErrmd6pCxnfwj+SZG9pg0+zP2kW3uzyrOxjG4tmmrqNsPcJ
	cOLCFETyZ5sdIzaz+/mO+DhyUe5z5Q1cbG
X-Google-Smtp-Source: AGHT+IEhk2EMQWAKRwX9NCabHzQ3Vzzvv2iZ7d9RrcsUVWLAP2GIZq8ft6qTnSahDEtLvHMgape2xQnRJpRlfiykHBY=
X-Received: by 2002:a17:907:2d29:b0:ac2:7a6d:c927 with SMTP id
 a640c23a62f3a-acb74dd4166mr1251413466b.50.1745355460777; Tue, 22 Apr 2025
 13:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
In-Reply-To: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Apr 2025 23:57:04 +0300
X-Gm-Features: ATxdqUF-oSMchupKET0XykLjWGb_SUEW5Va9B8qPNOL3TfAUmzMI_Zy3DGgTC0g
Message-ID: <CAHp75Ve_C6BXo75xy4+xZ5b1O9-TT5TGGQDgTR_F1s3TFK3p6Q@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: drop sensor_data array
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 10:28=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Drop the sensor_data array from struct bmp280_data and replace it using
> local structs in each interrupt handler.
>
> The sensor_data array in struct bmp280_data is not used to share data
> between functions and isn't used for DMA, so there isn't really a need
> to have it in the struct. Instead, we can use the struct pattern for
> scan data in each interrupt handler. This has the advantage of allowing
> us to see the actual layout of each scan buffer for each different type
> of supported sensor. It also avoid juggling values between local

of the supported

> variables and the array which makes the code a bit simpler by avoiding
> some extra assignments.
>
> We can also drop the BME280_NUM_MAX_CHANNELS macro as it is no longer
> used.

I like this change so much, thanks!
But one comment below.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

>         /* Pressure calculations */
> -       memcpy(&data->sensor_data[offset], &data->buf[3], 3);
> -
> -       offset +=3D sizeof(s32);
> +       memcpy(&buffer.comp_press, &data->buf[3], 3);
>
>         /* Temperature calculations */
> -       memcpy(&data->sensor_data[offset], &data->buf[0], 3);
> +       memcpy(&buffer.comp_temp, &data->buf[0], 3);

Shouldn't these memcpy():s be get_unaligned_be24()/get_unaligned_le24()?

--=20
With Best Regards,
Andy Shevchenko

