Return-Path: <linux-iio+bounces-22295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C3B1AA48
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 23:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B30C17D4CF
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219223815C;
	Mon,  4 Aug 2025 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNEZWdlj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51781634;
	Mon,  4 Aug 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754341570; cv=none; b=cgHUr4wvfiuMrG/3/a5ZN0mAX1XTBZPQYyPLbiSkR5/hAGQ+0C7gkuDeNe8tqlqkQQUlkw0/aB9KwLa9hgQ2WvXiT5dIkEwPbGlvmoCFf2hYgSnqrtsU/mCyE/bCG29RwTVba6c1PWcXafBQqNxS1ESni25gxJCyU+SfghEMSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754341570; c=relaxed/simple;
	bh=hAYYWBNkgTboJOTpGHZqE45qh6anueVBqS2SKZgwLyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcxBhaTIvPjg1ewPExL5SPWmKhzaYg7U7Mat0cCv7pHnPV2NmSNn+P3HHPM7nyxO+vwj/cD8OCnqLJ+U/SUFKuwZET/BtK4eeP1gMXz1byxDig9+dwUB2bEM67ZKitgegRUcxRPJX0MMjCvrlMv8ay2sOKQC+0CxmVvkKLaDDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNEZWdlj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so5310630a12.3;
        Mon, 04 Aug 2025 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754341567; x=1754946367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAYYWBNkgTboJOTpGHZqE45qh6anueVBqS2SKZgwLyg=;
        b=dNEZWdlj5/JNvPgWw3SGpQLCAXdWyJElITuapLgd+EqwG9PUS3NCeWNBRuOHKclfFT
         GY/c3r5WVMhzAH7Kg6tsxPtgr5fZ4nPAwP/pDlPXorQjvIMPseCiUdjaI/hirIsh0+xm
         VGl8iqvj8sprfAOs/RtIjnbwAwFHCV+Royrk42ARPjqSInLVApTIzlVZVhwgkYmTmKqI
         amfD8fGygMlXPl3S1u0BWTh9Sbxpw6Mclo3evfKpgy18u4uj3vK/if636+wFh4qIKj47
         8Awm6Z3IXtIjXgVhqhUU1a0JQm7PR+yrTyRNyfuCiBfZS+zVy5obHinrJ57ww9GIzGbp
         UzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754341567; x=1754946367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAYYWBNkgTboJOTpGHZqE45qh6anueVBqS2SKZgwLyg=;
        b=rUF7+XguF0gH7xVbVIvH1VpMPgpCoqTQ52cEDRHcFltpJ9aesryKdD0vPLI0km7i/o
         /Sviy2LmPk6QPsxFyL7RuevemUAmxz8H7NTApPQ2aydJlRdkosuW+3TKwpIgncDb/1N9
         BxQX7o+U+skDCy5jb0sJScArFzQzM4n75cse+owc2a91uGXP9QRTWbVEkwF8RBCWM0qD
         tNKsMxkdmaskVxEaeXZJUSEhOOvDbPhKwLMATM4TZ55rNWFUtyqg70cNOD9ZvFJRxdZY
         9B58iY+DTYpuleso0IDB+BSYl+ULuqs3/IBi2CVksepM12NXqpyxBMCWR/gdyR+Q3gPb
         Cl4w==
X-Forwarded-Encrypted: i=1; AJvYcCUX/jWpUX3BxcQCOW5Yl9zaCgfx/eTtrs+wZCZWr8Z3C43fdxRTTHFZ9/VBHz6Vv7FPyzxjbaOS7Mifz0LG@vger.kernel.org, AJvYcCV5PCafzRr7b2jb/B48Z7Bf2kWixGDp+myQQfk0GuaLxJ/hAXAJnJxgcPpEhS8x9pRhf5ZZMaFpo+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7Gk+KRllAUj+BKDUd4stn/hC1NecdgvnaRxrIclpuO/7yf1+
	aA2VzddXORnLW5i9xtHgJTR6XizRBuKaA9wY+cKebkAJFlxnOI3upHC6A2Y5oHy89oG66ipNRPX
	+RSUiKfhiilXNFRTOo0g0pgMLsuTb0sU=
X-Gm-Gg: ASbGncufPDjNSy+yqoa/HQrfY3qJVh4tduZt2u/YuogJW8myyaHaJWA+A6cAnUEU9PT
	v1+OYSWtti3wCzfpENkqxwGUbFKUOz6Y6irFC2npcnAen7DrQuNHFTPOg+2yi3Y2X2Kei7KEcli
	1Knoe8Q5axQTpnSwh9atiYMRhzm74ZOfgDIJJxEkWFBHAxhhn42Mc+/f3PRnoTZLaFlenJHOKlq
	Mc0l4SCzg==
X-Google-Smtp-Source: AGHT+IFamALuNxbnfgWP44r/2U8A7Q/KGKAulraciALTXJdSiCkkFnPpjn4xRxuqGOPVIq6pXvLdR/i1Z14wASqjMz4=
X-Received: by 2002:a17:906:f59f:b0:af8:fb0a:45b4 with SMTP id
 a640c23a62f3a-af940015697mr1060855966b.18.1754341567200; Mon, 04 Aug 2025
 14:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 23:05:30 +0200
X-Gm-Features: Ac12FXzLG7WX0l96yAxtgYs6sHhFQpugHe20NpCudLjBUfxb4gw53s8rdv2of2Q
Message-ID: <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 9:25=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.co=
m> wrote:
>
> Implement the .remove() callback in the ltr390 driver to ensure proper
> cleanup when the device is removed.
>
> Set client data with i2c_set_clientdata() to ensure indio_dev is accessib=
le
> in .remove(). Replace devm_iio_device_register() with iio_device_register=
()
> and explicitly unregister the device to align with the updated removal pa=
th
> and follow common patterns used in other IIO drivers.

Doesn't sound right to me. HAve you investigated PM runtime paths?
Looking at what the code you added there it sounds to me like a part
of PM runtime ->suspend() callback.

--=20
With Best Regards,
Andy Shevchenko

