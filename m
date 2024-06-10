Return-Path: <linux-iio+bounces-6137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74927901BC8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657521C2156F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FD225CE;
	Mon, 10 Jun 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzeBLrr4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13118633;
	Mon, 10 Jun 2024 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004063; cv=none; b=CkAnMkItE4vlaws3oi5xguTlNkAbYDb5b4CbZ8/Q3RCJ1ffLq3b69lrQ826SUYZFUhXd8KeuVHG6khPyhH4gxSggqvEjhY6RW9NRktKNHXQvaXg/B/AYGm8qFtv6KgAuWSStu3qM7jVOtoP0l5Pbia8J98eCpz5rJheXTLRrAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004063; c=relaxed/simple;
	bh=dry/TEgITjT+XQB9PI/5CoGE6hTEEnJRiV6uO6qB8t8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwPq7gb3LMMXDlnxpvjMhCUW3FoJ4PLj2rHPVVCRIcQW8+q2p2xtXp9qbdBg5CEDhkHU4uIFWq321TeccamuNRwW5tOsur+/jxr6MShd4Dtp+JYD9RwsjdLFcJFT1SnxoZZf182PZqH/S2rgKDriH0FYkHxYa4BNnDnE3LrvYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzeBLrr4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so2584218a12.2;
        Mon, 10 Jun 2024 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718004060; x=1718608860; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dry/TEgITjT+XQB9PI/5CoGE6hTEEnJRiV6uO6qB8t8=;
        b=MzeBLrr4RKj556cKRMSJPQUwEke4L9mh+My5R6Pkd0iIPV+SO4bAVF1ZkljdeLhfdF
         1SJ85cN304KcnPblF7G9TTln1xTCRsezy8Aj+8EmM7UMgmVAKq9+StUdboNISewRFFF2
         V4HSFgaRUZhFDf+pUHdx/tr0ifhfZCiBw4cAUHy7UHRuFk537sAqn6ZPBUYFwJFbjAJJ
         pHbsNmpqypH63tQk74EV2cnQ1OKStB406xokVtCuqCVRRcYakA7k80gnvuDnzLHMcSjN
         +TMOq2MHn9tfgsRnyFywuEsO6e3Qpb3EBwBZiZ0ndYarv3dnCJtNMQKYftm6RsGgLfBb
         n0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718004060; x=1718608860;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dry/TEgITjT+XQB9PI/5CoGE6hTEEnJRiV6uO6qB8t8=;
        b=LrBspEasVDKoOmaYxn6te70zVa6hd6Ta75gb+jB+B7eQ2Jbdaq9exdBwZWoVdDJWyV
         NelRNFesxrWlS5KWvos2NwVLcPZGm7aBbDbHAcGVZaTR3RpCGgtmUjtOnHE5pQ3z3kD2
         NPMKgaQ4hiJNA1sjXANqdD8V8B59geRClr5lzHo8+9fIWz0//IailqFRToiNm2SNAZvr
         HsjRdrawmc44m0raFilh6zrUQR92zSLOl+NWYn+JVPiKlSqNv5cL4DDGvV+NVFdXHBwr
         wXzx48ul94tKPAO1gSbZ28fZ+xxb2iVX3uKzV5S19HB4V2fEIX5QLOQdKQPr8qjVZuiH
         q4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5+pqyzeRH8Q8L3H2/rTvedq+Jat4P84x0VIfmRxqJkdll7+VtV09ef6CkrUPFAkceQxodsMbnL1A5Tivysd9GGmJ9bY2bYuuaxSpzjwOtoNmDt1fNBY2SIEHk01+CQLyg1MVxLNhNYcVFcQRBHzQCqN3XyZD2m66xabqRk5N874drug==
X-Gm-Message-State: AOJu0YyN9DrdEWkUqn7xh3K3lXTv3ihuOD1wCJbPJ1q6uakzUfT8MOUY
	KeFgUYLWumq3matp97QcgEsqkkYvG+wac3w2sUIlBQx9hf7Nm1UI
X-Google-Smtp-Source: AGHT+IFEAI00pZs+Aw5+f9m+oOsv2IstH1WbSmW3uJEkrg07OwpS/rMBBfJYomDr3q0euA3tbqv9ew==
X-Received: by 2002:a50:cc96:0:b0:578:36a2:7073 with SMTP id 4fb4d7f45d1cf-57c509a811amr4666217a12.29.1718004060628;
        Mon, 10 Jun 2024 00:21:00 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae229729sm7062061a12.79.2024.06.10.00.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 00:21:00 -0700 (PDT)
Message-ID: <c1dd957d438a099727ff17614222cdf93eac5842.camel@gmail.com>
Subject: Re: [PATCH v7 6/9] iio: adc: ad7173: add support for special inputs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Mon, 10 Jun 2024 09:24:48 +0200
In-Reply-To: <20240607-ad4111-v7-6-97e3855900a0@analog.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
	 <20240607-ad4111-v7-6-97e3855900a0@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 17:53 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> =C2=A0Add support for selecting REF+ and REF- inputs on all models.
> =C2=A0Add support for selecting ((AVDD1 =E2=88=92 AVSS)/5) inputs
> =C2=A0 on supported models.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



