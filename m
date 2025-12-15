Return-Path: <linux-iio+bounces-27096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD769CBF343
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93201303AE98
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C233557D;
	Mon, 15 Dec 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB7kETwe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B41335098
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817842; cv=none; b=OI+gAwwdId6F8Nj3XeR0FkKiswWEuKuOlaLjBIYz5iVvoALqRJc6+kkAFbi7jLUkjx8QpK4USRP7kq5i/zvfGeJHUXuli+1c83ECgYQ8TLDaz69TtM8Bx8xEfJEi8CVo9jhuhV3pN+U1Ehi4UJMbh96QxsSRC2w89cv3hHWj7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817842; c=relaxed/simple;
	bh=iRP8tmXMtbl9jHWOwI2GLvhWvQ/O/bSRM3cgmpbaHUs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a6ULA4Qyfye/KjntnqHdiiwTDbQD4KaeM4nQV/cgJDKE8H+5HUH6ZfOIBXpkRCYkyWq6lq7Ft3cOxNnslRWpH7FeUL5EpI6Z4Fl3CMfNssMO+tdhjsfF46iFS9PqmoxNhXzZTuyOLcJcCi2gMaaor51MEbFu7tuIqkr1shy96gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB7kETwe; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-55cda719128so839072e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765817839; x=1766422639; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRP8tmXMtbl9jHWOwI2GLvhWvQ/O/bSRM3cgmpbaHUs=;
        b=FB7kETweaUAfFoEQhSPoAX9dg58gxEoHkaalNMFVVKugQ4PYBECkoaf99sOQJGNsfO
         ncHus001qiBs8zwQK6EpiuZoI1wqVoVYhlcouUMr5TcmfPOJpa4+jMJKm4f1GWYjn5/4
         Gx1jqBt/LbQe/ma2KccrY6x58Ljr6093MzJX/RGOo46qfueB/f2IuwoGPNL3i3GG77TJ
         klQYp+SAny5QAZqpedSlntCHjtiBjdDymqd0kCA8GW2P4lx5gUqqK+lNcFwD84S1hzUV
         k2KR3WKtHlVU9ox7Y5gtBW7i5g/vZwobNEB4hEJ33dwtP+6QlKrnD1FKujFuQ8DWk2KT
         wESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765817839; x=1766422639;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRP8tmXMtbl9jHWOwI2GLvhWvQ/O/bSRM3cgmpbaHUs=;
        b=OlCEV6UBHySNjDnUQ8n2+JLSjUOTp2Cbjm2clI4gf1xCJ/KMnuA3HkLMEWNsePmE7F
         8rASILFnmrsa/rPfCqGkQ2B63vyFMCCIy3Kit0T90H2Xpcp6YPV+DjJ2qJbLdE0LDr5w
         X+3957xBr1+ykpBUI3Rs6i6guryDdSeh4LHGWFgIJkWyjHGTRFkcltAaI0iM+tOhMPN6
         UuDxLfjKXUHx1gg+X5qWXZsw4T77tVWvPFcwGh7qjaujcueABpy86sFlNlID987G7enI
         k7WTkG9kSXr8jPlgCe+2KFQAa1gMet6QoTvQ0yq4qvoyAczyz845zI1CnuL0UFqveu65
         W3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/3RhyYWJty0/rz5EmtSdJ9vrsZzxWUKcbZ27FN1k+br5dQVwPgQVmBRo+U+W3KkMN9X3yLQ3sYIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wU3M7xGZOvkfzLns5itmg/j/yvB2jNW+RslwIPB5sMAl/dxR
	cDzVgrBeeDZzvrurd9uklDgdprr3x+ghhb7J8ZaJpGLYUn9+xiER8neH
X-Gm-Gg: AY/fxX42VMCp446jaavOmzLveKrF9AsbpJk/LPuVO0WkbYjjfbX7FwZ/GSIKnpo81N1
	2+/PD3k5CxqAnze4njj+CF977lh9fz3PZEPOQ27GU/y0Kw4cf5Tq+yIeUkCNX5+gzgVzI9+3nnf
	4ManzfDe48yj/FOONFclqAxw3OUsFrhXV3lzF+tB9axXQ8Dgd+XP9noGYkORDo3ByBQPd/dq6+w
	lh2BlypdP4/knm/PulKH5D4DNXMEEdYDxNqhHcaYbm3aC9Jntz3xWeOf+mWRSCKMH8GuzrqqIOa
	VoNRpLnonrE6HVJzI434diQ+5WmXgAj1nZGHzqxmsd7lh51HzpLP8xGm3fsMB/kDljxD69g2AwA
	7IdmQ1Wv5ZNbtuGiLyMCt4sblwRmPr/p0MK9hks6yaJa9mRYTam7cEviX5MSTTZskZY+O8fl/zB
	/uZK2mow==
X-Google-Smtp-Source: AGHT+IF0duYtbh6rimYipQ0gT9A2nPffn1c0ynYhlc+imPFc3cMR0Hl8XDCUZSrigOtwFreaQRoBYA==
X-Received: by 2002:a05:6122:2228:b0:559:6723:628c with SMTP id 71dfb90a1353d-55fed643c05mr3394845e0c.16.1765817839601;
        Mon, 15 Dec 2025 08:57:19 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55fdc739e8bsm6595964e0c.15.2025.12.15.08.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 08:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 11:57:16 -0500
Message-Id: <DEYY6JGHSTQ9.1NAQUNJVP55A0@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 0/2] iio: Add support for TI ADS1X18 ADCs
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
 <9b73421e-d08b-4480-ab28-5ff5a845e264@baylibre.com>
In-Reply-To: <9b73421e-d08b-4480-ab28-5ff5a845e264@baylibre.com>

On Mon Dec 15, 2025 at 10:56 AM -05, David Lechner wrote:
> On 12/11/25 10:25 PM, Kurt Borja wrote:
>> Hi,
>>=20
>> This series adds a new driver for TI ADS1X18 SPI devices.
>>=20
>> This is my first time contributing to the IIO subsystem and making
>> dt-bindings documentation, so (don't) go easy on me :p.
>>=20
>> As explained in Patch 2 changelog, the DRDY interrupt line is shared
>> with the MOSI pin. This awkward quirk is also found on some Analog
>> Devices sigma-delta SPI ADCs, so the interrupt and trigger design is
>> inspired by those.
>>=20
>> Thank you in advance for your reviews.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>
> I had a few minor comments on the driver, but nothing serious.
>
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Thank you, David!

--=20
Thanks,
 ~ Kurt

