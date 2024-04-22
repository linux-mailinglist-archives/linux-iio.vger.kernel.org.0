Return-Path: <linux-iio+bounces-4434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ED48AD036
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991D31C20995
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F5152521;
	Mon, 22 Apr 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ07eb1N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BE5025E;
	Mon, 22 Apr 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798390; cv=none; b=pQEgkqFsmQ3wGXxy7TpcM8Yjg5fNf7oxcpfRT/qDvEyuTCTnPwAshx7EqSsqKPLQYd0u8vXtcruO94BqThL4GW4Nm0PRG0xgw6BtsDiJ9wkJ9NOnlvRCpAZtkVhu/Yzu5aMZYb6F2sRjJkXZRmLKrTFJ9z6OEgHzMm3aYueitSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798390; c=relaxed/simple;
	bh=1ZM36XBQ+Ug/+Msdxo9lrVnAiv5Wct4bZHL2H8s5r7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Td0nsR7r+MMUDlQDW0xUpXSEEwY1UJJ4bqlpMgB0KwA/Oc3k2Wc+b+kQWjxvvomO2Q5J/taZpjoHf+qyrCkWg2I/bBbOMA0c3g9kwHLhtBxC8p21K74kyzOwlAIzMVx5jzWAVV2AjLmyZxMHz12SfYKySNuockXN36KJuBzd6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ07eb1N; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57215beb09bso418967a12.3;
        Mon, 22 Apr 2024 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713798384; x=1714403184; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ZM36XBQ+Ug/+Msdxo9lrVnAiv5Wct4bZHL2H8s5r7I=;
        b=hQ07eb1Nh28KgRizECkQ87fBwg4IAxqqpAQhCb5OF2hItYGfQ/l4p8PeEP3o3mc5jg
         RtWE0lSEKTzqDQTDgBKDB/V8K00utof+wOcg9upOiRYg3e33WPANImhjV9omQB2Xq8+s
         EKKj7rrWHH0B1HJasnaEAKDJGlwBv7c2g5acMCrCWI+wGX9OaWzK1ynvjXRBmLVaRVVq
         MI77x0DVxmXIf2Y1u96Y677ykw5tWQpqyimnFqWq5zzruGPE+0rMgYq2gGO3ry4xCHuw
         zRqdyODqU0ef6ahDaSsXo7r/wkMY5dp5xn4KeqGwtl8lwq+QhpghSYWvggPSHEFC4IQx
         ZcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798384; x=1714403184;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZM36XBQ+Ug/+Msdxo9lrVnAiv5Wct4bZHL2H8s5r7I=;
        b=RyTy0/rpJSKGSSsb1E2oPYG6KJr8oTlodB1ItrBj0wZF5Ri3aoUC73zkC0RAI3Fsjr
         6oVxiQW+NZLvNCfVYfJxIeouZkJcEnPxjdjKV1TS0vhUTrgesszhnpJJc3U+hREoHG+1
         4242CYsPolBnEVVq8vmSSQOgmJwktFTF5EkRrZs5F75yuPkD7aMSZuousbln4j7t6Iac
         fMn3gzKFEzA7eaHUcGR1BaWXLAXpcxiq1C56uvisHIqehyyDdbgLY0umCCdmt5o+ARke
         o22dmKuSwu1OhCU8IkRL1/AMLam11IgC6MJduJBXoJFdlRrBRd9hkr7q0DmeBAMura0N
         J24g==
X-Forwarded-Encrypted: i=1; AJvYcCXgWGYN89/gtvrNcJTel2XjegNRAnbsqzdBIa/W0FdNZ9q+w1ikXrcID6u7yRq2+DwTrcvvtzJ5BtoYBBXce6aJ1PS8TJYPBt9I5xdxXxpYS21Wor4mBSZi8mlwrm745gdoTVtuNA==
X-Gm-Message-State: AOJu0Yzr4WSYAXKe54a63+TWZSQnunjZRML334025TSQCpeqoJIr6dRT
	iP7213XYm/K+dJ9s5gQR3R2ZSpPbq9peNzW/zpjK8oiryiPQeQL0
X-Google-Smtp-Source: AGHT+IEyyP9ZOlkbRcFQw0325uLAtTa0tGcrbkt2eUgskPxOVixG+wxPpNr63tSMwqyMHV4usMy0yQ==
X-Received: by 2002:a17:906:5955:b0:a52:36e1:c139 with SMTP id g21-20020a170906595500b00a5236e1c139mr6791672ejr.4.1713798383209;
        Mon, 22 Apr 2024 08:06:23 -0700 (PDT)
Received: from ?IPv6:2001:a61:3481:2201:6106:96db:d27b:d2c2? ([2001:a61:3481:2201:6106:96db:d27b:d2c2])
        by smtp.gmail.com with ESMTPSA id bw19-20020a170906c1d300b00a5238156017sm5896882ejb.88.2024.04.22.08.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:06:22 -0700 (PDT)
Message-ID: <be927df578a936e7699a26edfddd42470689e7cd.camel@gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: adc: axi-adc: add clocks property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 22 Apr 2024 17:06:22 +0200
In-Reply-To: <20240420160404.57bd835d@jic23-huawei>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	 <20240419-ad9467-new-features-v1-3-3e7628ff6d5e@analog.com>
	 <20240420160404.57bd835d@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-20 at 16:04 +0100, Jonathan Cameron wrote:
> On Fri, 19 Apr 2024 17:36:46 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Add a required clock property as we can't access the device registers i=
f
> > the AXI bus clock is not properly enabled.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Fix, or doesn't matter until this series?
>=20

It does matter. But reality is that it's rare for you to catch this issue b=
ecause
such a fundamental clock is typically enabled pretty early during boot. But=
 we did
had some issues (on other cores) regarding this. Anyways, for correctness, =
I'll add a
tag on v2.

- Nuno S=C3=A1



