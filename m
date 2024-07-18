Return-Path: <linux-iio+bounces-7702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069AE934EE1
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F3E1F245AF
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923D1420B8;
	Thu, 18 Jul 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx4I6LZd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33513E028;
	Thu, 18 Jul 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311718; cv=none; b=l/Dt+POMIU3le+y+rsZwmWfSoVph5+kMTdRGwimmrG9P9Lon26OoiYdJkLsHe+uqEBbIrp5NtlFu3EctFPob6zL9yC+TRc8kR2WDVQU6wogK7E131A38kp42AftpK3cMjywzqo4tn7HgpiV2I8DSFH6uwvjRTUrEZv01CNEy2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311718; c=relaxed/simple;
	bh=Zu41XDxS0G+XZTGya57Mh9o/OsV+lTxsEHtcdNGShBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6ThaRw6WsdkItnOoBmYWxetBqI1uIaqXvefSlkbYuJijTPng4LuC3QRf6thbiYtNmKITOEzyUP4hVefKXRKtZ5yMqM/GsJSSXmtYSHGv08ju0yS8o/dtZaWcFC1vsEK5Aao18itRkcDkFsHFQAUWTJsneUe1LdXWmH4CSFbfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx4I6LZd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea0f18500so376454e87.3;
        Thu, 18 Jul 2024 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721311715; x=1721916515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zu41XDxS0G+XZTGya57Mh9o/OsV+lTxsEHtcdNGShBk=;
        b=Cx4I6LZdUdVuCfI/vGZJ2Go3i//TJ63C2adAn3BOz8EKsIPmet4QrPIl//Pj3tZ7W/
         bPPtv0QToH6XtHQsDBBpu04hhIYvZkl93lXjTG4OcxQLUG0UXUGFv2V8oPZS0GPei/g9
         T4runz2LJHkxbDR5+/nayAKUV5NviyVjlld5XDt6HxY5e7/J9Jt37HaPfJ1hzmYV/AOI
         pzkMn55b1Ryfof9rLB3lQkvCmTRkAXiJZsQuV7CbCLH1vFA62PRFcHmEqTfG9BRqDVcI
         Q9qegflWyGehXwbeC1uUcVxsnzDTSMFID9DXA1QgHiRHiMc5K8fRy/LtnBrEUoErC1+y
         g9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311715; x=1721916515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu41XDxS0G+XZTGya57Mh9o/OsV+lTxsEHtcdNGShBk=;
        b=Rsh7O6RnSezZ2TQgwqO/uXxzZlPFCWH7ERU356OfIhUX4aftNtFRH2utba/mqPUZHL
         wQwlMt2oyLiNb6b65TmxHLYqf7X0O3PUYn7A8krRHN3m+P0t++4O4tE9e4np6hEKa5sm
         eES0o+j2i/GzuJXXjs4N7etEkond2awLblLoskXh/EcqH6bRLVC/0sPLBvO2XpWdzplq
         yuXo3vPqOMlGcAynYnZwNfPZ7dYh1ksnPJUPLmyZJifxoDoVtDRDGt8NkKE7k482HJ8L
         R/kH22g4GHLn/NmM9lV7HT5sa7OxdeLGCum/GoMBygzFLw3voZkKvyD0E7tGVbc6WacL
         F1rg==
X-Forwarded-Encrypted: i=1; AJvYcCXMjkDJuSboPgQhlS6gUX4WxpDJIP5xlWeTk9GY9DL0bKroDf7OV9w1oaLEiE3oMR5zf2Zx/arCdb2QI5srCZgHb1q3+WW5VLEod7LMvp9kNAa+E/C4lKLxo0LC7yJ+XBCD8Z79B9o+3JdUTop8DOfFeANMFEhHkEOoziUpf2nO24ijIA==
X-Gm-Message-State: AOJu0Yx+xZ743Zt0Lwyfoseb6UD8L+JZiGqMphZQjvtWfZpJ68tEIWP1
	/i+5FqYHk3Sf0xg+CWXvLfEYuitCDha7AS+fP0dVdCjUiz11ZKG6
X-Google-Smtp-Source: AGHT+IEJ516zfOSBvP+CO6M25dL18hqjOXPoF08EMhPOhsI7c1waSlPDuumU94Lt5tfdUG2hN0squg==
X-Received: by 2002:a05:6512:b8b:b0:52c:dbc2:ea1 with SMTP id 2adb3069b0e04-52ee53ac96dmr3690480e87.6.1721311714107;
        Thu, 18 Jul 2024 07:08:34 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a7257esm15994785e9.28.2024.07.18.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:08:33 -0700 (PDT)
Message-ID: <cc1d58f9ca652dff81ffda0af2329cc673e888fb.camel@gmail.com>
Subject: Re: [PATCH v7 2/4] iio: adc: ad7192: Update clock config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Date: Thu, 18 Jul 2024 16:08:33 +0200
In-Reply-To: <20240717212535.8348-3-alisa.roman@analog.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
	 <20240717212535.8348-3-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-18 at 00:25 +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>=20
> Undocumented properties adi,int-clock-output-enable and adi,clock-xtal
> still supported for backward compatibility, but their use is highly
> discouraged. Use cleaner alternative of configuring external clock by
> using clock names mclk and xtal.
>=20
> Functionality of AD7192_CLK_INT_CO will be implemented in complementary
> patch by adding clock provider.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



