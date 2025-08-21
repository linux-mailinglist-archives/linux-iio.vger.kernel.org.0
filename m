Return-Path: <linux-iio+bounces-23090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A768FB2F0BA
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C1E17EA87
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54C32EA16D;
	Thu, 21 Aug 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcEYsYZe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004C2EA15B;
	Thu, 21 Aug 2025 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763855; cv=none; b=HHHieRqVb023Z6XZaK2HKlzvPO+U7qcp1N75vVBVx3h0RtSYENDi/XgPVWLqFS2keHjfWZjxQYYzpl/ZwLdL9Qj1na8Fd2wk1WPbjFKxqD8RTeuCvh0c1CtDSttEJe0F5p4W3/HLGLyAvyEQZ1xWuDC6Uf26dK7QNsyqccjyQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763855; c=relaxed/simple;
	bh=lboy/sK4F5dhHOxlexmXLlvin2JW8bi6mai/3Ua0FKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY9z8iPjdHqaJD8gLS1FEvedRifsiw6i7oIWzqJMHNoIOxGJYx0Wyz8XMPDrukNuLFNqqVh1riD+QJBEpTZNWcBL2pv5b4/dLNCnFnz7cg2ZMksyABtOpG0oRytQ6+vTugCZwfo97+sy2zlOeAMi1t2TpjwZQFOT+xmIZMPdYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcEYsYZe; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7aea37cso92358066b.3;
        Thu, 21 Aug 2025 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755763852; x=1756368652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ortLY4+3DuwemOSw2qTsPndlSqAZQ2LKeWM/vfevNlY=;
        b=VcEYsYZea3UPTCUEKCxe+8v7v0y+UY08rbJs1HnZSns1NQ1SmzFB5oBDDuGvZPRUeg
         iH4iAbEISMIgkm2Ovg3xNx9okzbwr7/ORDDse8yKosDopIa1FU84LErkEkffmrlPglvb
         4dkT69ej4A61001+nbSzckC+ZW5iLQ4WxBwlNXAS+hN51NGxdquaPKULJP9cDhmNcLAd
         6pxqGRKGO0GUMB1uRY/v5kwbOJ9aMYvwi8eUBKbQ3Yhbhb+YecEiNvdbCbywb3zOS7hb
         SUREE8IIUK0lO3nZO5Je0zjiGy5PG7hzPSx724Xt231Dm967qCHOi0YONU/b5SmjZD0X
         Ck9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763852; x=1756368652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ortLY4+3DuwemOSw2qTsPndlSqAZQ2LKeWM/vfevNlY=;
        b=JVI6j54sNkx1klrvEy6fhrYAOAYOOqVJjW3TQv0uJMuL5eM0ud9ft9xU7ENXtjee8f
         lPY2ehZ/6Zjy41OdllaXQCzXolysBW5NuX8G75d4MpB8n9SiucGvYVA4eopumwhPck1j
         z9AhS73HUcvv6wxyMEuqK9JvBkEYWr0Ads9g8QMMc60LA+7T4Wbfittq0T/EEilxvyDv
         iz/w1BVI1JWcAZV4l0P/tEJgYsR5Vc7Tx3R5bpS94bSvsrgIG+7VUrHMms/gHM/VFbW3
         R3V+a98yqBaimpfImZ/b4Unrn/jognzsreRwHMiciY9sdbX7juXc2toQHqIU4l377bQm
         rdHw==
X-Forwarded-Encrypted: i=1; AJvYcCWtdOA3fv6KnHStNGWvkhiB4Fomw4MzPV+EoPyH2Zm2T9v2FaeD+Qz7agTa6g+oKDMW+ty25otjQbcuG/OF@vger.kernel.org, AJvYcCXU7k4tDaDqokvna6JZfuhrniO4Aal5e6NvhHA6IcxSwZnpmDn/ko1QyLrvCcJ43Db9AwZE3tkKsPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmhocB25RE3qfuN/SmVrvnFmThUZvSCZ56EmRxRqBceiefK+/
	1t41BYuTMjZCTH/vZjBdjx//qCoTo+fHO8+8T5lqOM8HfqLtm8BRmr1EohArA5KTINsYkDGW+LD
	hCoA9Y6B+ZZZW4jDsWH7otRX8RAhzcOE=
X-Gm-Gg: ASbGnct0/cxfti9B2JAK1XBVXEs820Jdav7uFOI1V8sDPqAQHY8csijeeQxBf1/4Imt
	E7Q6kTF7m0Ok9rE8VFWxaPaYhdPFkrhSR17sg50YFyP3qnxodJj60/CIhUPwkLuiXgYRM30yv9I
	I1bfig0q2jF0/HPErr41FnAG0+lFd1hlsNfi1d3Um42t6QfABuVPlpUAV0m9w0HV6ppGN1V0X94
	mziVvvWBA==
X-Google-Smtp-Source: AGHT+IGHq2swEHFOK6SnLCgVW8tcxdey//4oMzAmbvbQfij9NupFn6eqpQDQxjbAIjYyJFpJ1tsrJMJkdHp6/0uiT7k=
X-Received: by 2002:a17:907:d13:b0:af9:9d7b:6f44 with SMTP id
 a640c23a62f3a-afe079f3384mr176399366b.19.1755763851921; Thu, 21 Aug 2025
 01:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-bmi270-gpd-acpi-v4-1-5279b471d749@uniontech.com>
In-Reply-To: <20250821-bmi270-gpd-acpi-v4-1-5279b471d749@uniontech.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Aug 2025 11:10:15 +0300
X-Gm-Features: Ac12FXzaSIJS21Xe83njY0FSPtPNI3sEDrWsPGu8xaBy3EFqE2kEU6xiKLYcBTE
Message-ID: <CAHp75Ve7OC80r1ZcAHPeOxeUemEUbV9GfOtr44ZJ9Vswteb78Q@mail.gmail.com>
Subject: Re: [PATCH v4] iio: imu: bmi270: Match PNP ID found on newer GPD firmware
To: cryolitia@uniontech.com
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@deepin.org>, 
	Jun Zhan <zhanjun@uniontech.com>, niecheng1@uniontech.com2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:52=E2=80=AFAM Cryolitia PukNgae via B4 Relay
<devnull+cryolitia.uniontech.com@kernel.org> wrote:
>
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>
> GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
> When they switched to BMI260 sensors in newer hardware, they reused
> the existing Windows driver which accepts both "BMI0160" and "BMI0260"
> IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
> devices, causing driver mismatches in Linux.
>
> 1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
> BMI260 sensors to avoid loading the bmi160 driver on Linux. While this
> isn't Bosch's VID;
> 2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
> 3. We're seeing real devices shipping with "BMI0260" in DSDT
>
> The DSDT excerpt of GPD G1619-04 with BIOS v0.40:
>
> Scope (_SB.I2CC)
> {
>     Device (BMA2)
>     {
>         Name (_ADR, Zero)  // _ADR: Address
>         Name (_HID, "BMI0260")  // _HID: Hardware ID
>         Name (_CID, "BMI0260")  // _CID: Compatible ID
>         Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>         Name (_UID, One)  // _UID: Unique ID
>         Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settin=
gs
>         {
>             Name (RBUF, ResourceTemplate ()
>             {
>                 I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
>                     AddressingMode7Bit, "\\_SB.I2CC",
>                     0x00, ResourceConsumer, , Exclusive,
>                     )
>             })
>             Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
>         }
>         # omit some noise
>     }
> }

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

