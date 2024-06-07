Return-Path: <linux-iio+bounces-5979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3F8FFEA3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E128BBE9
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B5815B152;
	Fri,  7 Jun 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFPdnf8d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61722156C5B;
	Fri,  7 Jun 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751062; cv=none; b=bNO3q3dnZ2nUDmjBYVHEx3NCOqEnXtwBqcoj5e+TNDk0lXAG71jTW7k7QTIw4Qy8NGTJWcoi90tK+v6/HaEbEG3K86yuTk0Dnro+cCl2xjTFbGhONNTHgYSSwLRKvQgSEqfYvSttwqPaE5Bmgzez5TcnsK3BlFgCuGXt0RpkrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751062; c=relaxed/simple;
	bh=zY8w3RswIfZFX2pjGT2B4WWLkoE0CKtoyQZMU5wnpRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fF75wjVsVOfwl2btW666HIyDaG+afk8RAw6XnRXWVVqmBVKVL1usS7VzwB+57OrsabA5Jn8UxPVlii/a7P9aSHzSjIDYjuQsPtM/bE8sMCj98GfMkk6eCzSlMoIF4I5/+np9VaeTUxHTeVCoAU/pDTPzz2kTAKdKxWoFCJDaKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFPdnf8d; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6e0a499687so29485066b.2;
        Fri, 07 Jun 2024 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717751060; x=1718355860; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zY8w3RswIfZFX2pjGT2B4WWLkoE0CKtoyQZMU5wnpRc=;
        b=MFPdnf8dys0jBagmpNaZJAWpqSaN+xoaYdQeR44KCe5fsTfhAhYFjpzedageNnAa1S
         jhTgWlqEf2PZFcbozTm7QVhdidVGUoTprsYK/MD7WCtIKHg/AOpYQXhZg/bqjDTkG2vz
         ke2BW77ZUsWk6B6mhGv0mE3WojdlSBR1pPcI8mRUWKgrbFrQU0DC30m3SWPK2/fR6IJZ
         zZwk2tqsPoeSLFuDcBFDad7H4QcPJmPrtTlR/WqCU2z4iGhlPAUHaPmfeeSPhgKTDn5C
         lbay7jmzh4ilqIqJc8IMZqhiKkWnC0L7V5j4j6HWE+S0Gc/TSrIVtddhHNjbx9btHOt9
         5ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751060; x=1718355860;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zY8w3RswIfZFX2pjGT2B4WWLkoE0CKtoyQZMU5wnpRc=;
        b=k3T6UEhqFvUCygY7t9KKDosOrFkQcgggs0FbZ59jXDolG+Ka4Y+Me7+NDSAWZAlLbw
         aZL2DzAXI03eflKW3Dg2tJkIVB0XaEkiIIZFysHJEMqmx1w2HcEoIah4BaO9XOUfmInL
         QSv2pZ+jk+G6nMuxSgx32QauaGIcsl/RBKfyZglzRREvzHY9ZM58NR5iauu/4hpp28/s
         JefPNkcd5ZyaPhdumuwxb+O4EkrBE9b648pKVjwmWga59F/WULYEBQcnxkw8nT0POfPP
         TSz0m6Z/TNq/JE2RRbavMKbyZ93vNFSxuUlAE3WlXkE038a5G3JOUOYho87OZu62JLGP
         c0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3yeLC7XnWshFV5uKiOZ4TPK2OI4evoRxaRWjcO4tcWO6E05q8eUn4WaaUmiRiCVWJ6aXJl+6W3QvkgjHlWbeN54mmfOPUWKYi1lk8Kl8JTrhH/c5vG/pzGbeVEU4QbGnOuTcVr4Mi6HSgidtXrTC67BmoLtlqbICSf8rUwCahF5oX/w==
X-Gm-Message-State: AOJu0YwU6oHNGeW6v/PuqaqddH6ns556K8GtO3y+bcygIeDJ/DNegElp
	+OxS5cnmK1dxmRRP2zvvX8N1vz8jkgeuX/eMOUoIil/CJ70DIERLxJ0fgw7i6Vfebw==
X-Google-Smtp-Source: AGHT+IFO+WfF1ib+IKCLuKU+jB3CDvMMZYZptXoIzYymrazdnRRuoSOdKlRqzAMYKqHxQyxivMjSnw==
X-Received: by 2002:a17:906:2687:b0:a63:582b:8ac1 with SMTP id a640c23a62f3a-a6cd6f00605mr113389266b.20.1717751059595;
        Fri, 07 Jun 2024 02:04:19 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80595e7bsm214853366b.23.2024.06.07.02.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:04:19 -0700 (PDT)
Message-ID: <5905268db15644ece76b597b7bc8220f4f473204.camel@gmail.com>
Subject: Re: [PATCH v6 7/9] iio: adc: ad7173: refactor device info structs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Fri, 07 Jun 2024 11:08:06 +0200
In-Reply-To: <20240606-ad4111-v6-7-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-7-573981fb3e2e@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Drop array of device info structs and use individual structs for all;
> drop models enum as no longer needed. This improves readability as the
> structs are pointed directly.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



