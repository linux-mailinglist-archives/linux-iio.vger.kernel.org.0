Return-Path: <linux-iio+bounces-23453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF3B3CADA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F537C57C3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B45274B2E;
	Sat, 30 Aug 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6oKyTSm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CDEEA6;
	Sat, 30 Aug 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558230; cv=none; b=Dm3HLX7UBoGpOopG+V+Q1VPSBBEF20PJiOGAgK2hX1038fXX1ISQM8ufE0XQFTEM8QzlrgldW749uW+5PuHyV9eDjNTcSLwz+slbAsLi6ygM3xiHdDJlio6OCk3Zu+uZVNr9JvE07QicQX3Gn6pP8vOz1A4znBB69Xp24qd9JNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558230; c=relaxed/simple;
	bh=TxDh7mKnBHWLobRIwMlkJYpD2DqQ9yiJ6Um1xpNZhPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlPiuVyq3INPKqDGfDh8KQZqCyQvZSAo0j+jKjUDPAwxq8o/8CJVvfwKZWik5uL1os6CpUKbzCUVJGVcwp00e0J5TISCr92UyS4QUuOev/9oCYh0+zb/a6/oXPtiXGD2AD6xOITZwjnjKCG4TuK5LCb14ggdKMWRY+Ww++g2IZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6oKyTSm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afec56519c8so499587466b.2;
        Sat, 30 Aug 2025 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756558227; x=1757163027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9JY8OMG2YxKp4hClY3cj/pSFyahn3pDbXzmSQBWiak=;
        b=Y6oKyTSmzLB6l7PSpIDPJx+Pg46s6F+qtYe9o89WfZRr1wJvpvmJhN2JXa8GNeyD4r
         nbDnVKQQqbof9RH7H1AzcYBVGIqiGBDDBoQsC6Wt8Sp5P5LA8deGHZJiFfOYSETs03Kh
         znlTCfZG+mf3vtCYG3jzACOYKilH7lQgrUwFfU8b7BORaub6g8FCWfJg3hBb0DxVLIzg
         bu3clKLmHE23cr1S+mt5vBRRJmfs8kCGeYHRPcprzTtxO5LVQt65SoiUJYotz4T0B/pe
         t9iksy9wdtMVs1evoRSfhnjnCLc1AwFKSkmauxbkvp+4Yyv3r9lTDlFnjfjaga7SIcU1
         q4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756558227; x=1757163027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9JY8OMG2YxKp4hClY3cj/pSFyahn3pDbXzmSQBWiak=;
        b=qqJstZxFBTvUKCn9NIO060KYK9Wp8j5TynBgylay0PUW/flsqRuhQvhOdMU5nzpjxR
         pn5hB0wWyOi7jSELR+E6nDpko0Ln9ArXVIpUVe0+8f7stIWc2p3XNIhPRm2lpFBOOgsZ
         KTrU+dWbuj/MSe/3f/ovAhwxYYQfElQ9RgnW8L8EquCWCf0Jvn5dILP8rgdmkfdtJlhD
         KHqVDEK5WnrHzXcItcDhEnrYqfXHiOCJdz20Tu5XKhZgGPG2OVEP4PGrmYR+o/7prG3Q
         NO8k844Ri6dVyEnxA+e1k+mloKzFCiZJfxg9O4xdxAHDoKgl8Dnt6NY86+c+VNWwgHnY
         /GIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUS+ERgcK7sCey/bqCdNDIZGPhvWEW6Qy2ccWa4K6F4UEN1N/rwgDH8TRU2lCnlVx7YXwAeRf/5U1j+MD0@vger.kernel.org, AJvYcCXcUmjzPkiDEteR2sYXtvVPwchiAdIBFhHaMDHuw6a9UcKUiOpQvWTgSh3eAC509WVJX5IIjUYrRKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzELw6AASyQJIpsmmZ+I4eK0DfhFyvB9OTAcPpEcfIDhfZsMLb7
	fufUDP7RQR/yNY4Wcy2hXNPTTGAep1NqfJ94n3kjYX7f/+GnutsV4ug+FcVuhLsYHD20xruFlLO
	8MAEmB+05M1xygBBLjCxyPM9IhKg0ilM=
X-Gm-Gg: ASbGncsQ+PsXLT3vcnXLcSnD/SKIh8lvKUqfO5fSyjZBezGTcss6Pj4Y5blyhuJyowC
	4RjFHnSwKG+Y+Y+5brKBWVTByxXWx1xMC2useKkcZyiPxVBT4X7vEyCVQS75zHPy2MnpuNhWNYc
	Fn//4GuKx6Jt6hV2FWJqvaJt3JxOpwTUp6iIKrLOzKQgU4mPBa8oVHRx+PAQlkTsajelykONmoa
	rhOyCvbEHLn0xP1dg==
X-Google-Smtp-Source: AGHT+IGRlKIN3L7O3+mo60QI531e4ffqig1xKaMo3GVhtrwIXMR4FeubI7+Ch93Q4sJ8XRrLBVGkGQO5Ul3uf+Oe5OQ=
X-Received: by 2002:a17:907:ec16:b0:afe:c2e7:3705 with SMTP id
 a640c23a62f3a-b01d8c74961mr161436366b.22.1756558226763; Sat, 30 Aug 2025
 05:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830115858.21477-1-gustavograzs@gmail.com> <20250830115858.21477-3-gustavograzs@gmail.com>
In-Reply-To: <20250830115858.21477-3-gustavograzs@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 15:49:50 +0300
X-Gm-Features: Ac12FXzvRqo4azPR_71KPYZV3fc7qFKKDwZYxViV1ROWsrKqbvbOXF65uQuoXFs
Message-ID: <CAHp75Vf13aqDJj2j7MtfLTAT2MW-S3+M7wtEXsG1Wh7EKfxJSQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: ABI: document accel and roc event attributes
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
>
> Add accelerometer and rate of change event-related sysfs attributes
> exposed by the bmi270 driver.

Seems to me like the absent attributes that are already in the kernel,
should be added in the separate patch.

...

> +What:          /sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_en

Out of curiosity, is it for real? I mean & (ampersand) in the sysfs
attribute name? This is quite inconvenient for use in shells.

--=20
With Best Regards,
Andy Shevchenko

