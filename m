Return-Path: <linux-iio+bounces-5980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22E8FFEBA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B448CB228DA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069A15CD41;
	Fri,  7 Jun 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww4R4mEO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227115B15C;
	Fri,  7 Jun 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751168; cv=none; b=Hsv9DYzNmdkQEQq2WEbBhMiP3/bS4vmf+PC6JCfxRV+Rn4mPwJs7AiC8PPB9joRV/vaeC+IkxCF/J7WQmsx9p+ZHJHhaBd2xVKsR9CvUypEvyEwK7tMQdTpd5RmYRSiwv6CuQe1MFaMEfr7fAOb6wa7qqGRp8lPjBm3Us04D8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751168; c=relaxed/simple;
	bh=02Ezor/EFk6mpRpX7GE8KDOgJoMksH7wmGt1Ymq2OUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdvP4REZrPXs+ZzN6c6tWwB8tMiRT6WWgkVKvqQ2J5n2B3L5RxAt+uICTOt7LDF8M0x1WJt3F/Z7KQAtyEbzKtmKnKAuFUCBwg5/qKCChwnXVvxt/aPrsbBTGRY4KymOUF7X8BCKpYgrWKsw6do0Sy5r2fb5dae2Rdj76I+sOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww4R4mEO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a526c6a2cso2118335a12.2;
        Fri, 07 Jun 2024 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717751165; x=1718355965; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02Ezor/EFk6mpRpX7GE8KDOgJoMksH7wmGt1Ymq2OUE=;
        b=Ww4R4mEOkuQkZ4Vr/RZmCUJAdkKTnZxfHVoXFLBopRgli/Mf72AxRmWne7aes2wBlf
         gl2Fnn2+EigEF8wKIBUwSOdi2+mGeQQHuEVtjD14XdtLP7zkcb71WMFZNPmr24ZwzeBf
         JPvp6/IAvrJ2PBFjwWK/fTOfyDkL8a5kxJ9uzgjlFXBgAKMUZ3BbheTZoeyymlzGWABy
         ap7K7czgGjV817TdPm5kjDMXUTe4Ij7BHtofKrwQOnhFMR7Wb879Qkv0YiZLI+U4O+zC
         EPPRiOjvEM7HwgQhp5yMA3BPnI6ViQFeeQe75seQvkR2kuo6od7/cDEqEczBdxZhRxyx
         3H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751165; x=1718355965;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02Ezor/EFk6mpRpX7GE8KDOgJoMksH7wmGt1Ymq2OUE=;
        b=H6n10+eZwlc3O4RfAUV1+SaKQhxHQRRDVYYrBv1DIlTdHoZD2kt6Uhf4UTNEWfIwYz
         2B971Xl/8LnZ3xVmcg0pLqA2wp1vIEqyVY5nfzRiqgh3tzozQgnEoMhT6SJFBihgL9Qr
         pYRlvQxswYwg4OFpjSzgjY6xo38gcrsCUO21kuhekf4Dc/bLobsvqcj/VrBot3Ykib5s
         X5MU9n6cGM5sSpMJYKu9jImUQqYkJDcXiZLMKxMotC5a+PepfLlm1xwtfyAssrZ0x692
         KsT+Br2zM5DDPQ8LXquF3GOo4fL2Rc2xBbDtit4CYWT/2VGRfX+NgUSMS89nYn87E9Et
         EDYA==
X-Forwarded-Encrypted: i=1; AJvYcCWDSqdJk78HkWXAl8vRADEsvLrqfrH7NRiFWrpNa50i8fIn3ihJ2cRBKI9rG5xkChpC5nqJxFsjixmlgSyMkyZFsbD+8KZBvaZkUxAgWZqlTSRfav8U2x1Jwavt3dnLFLhonfIDMy63EEih4LvokS/knesRXW8jAvaYLbOagiZCYALadQ==
X-Gm-Message-State: AOJu0Ywsh9oVZm+wnfha9jnUEFSC/4+LAeLVSVTDRR6KPZxYlmcMN6Lx
	7e1DrziXCC3j01KAathh0USD18TEbFVlMSRErLCQIymuyl1FxvvE
X-Google-Smtp-Source: AGHT+IEN6md56MkALoiq/calcQIVIkG7jdXgQegNznInubYEMGzzFbk4uZozcFPSfxkdToBhRaUBeg==
X-Received: by 2002:a50:8719:0:b0:57a:2546:2512 with SMTP id 4fb4d7f45d1cf-57c5099b8b0mr965262a12.34.1717751165181;
        Fri, 07 Jun 2024 02:06:05 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2023a1sm2399254a12.61.2024.06.07.02.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:06:04 -0700 (PDT)
Message-ID: <fe4e553875d2d20b4c3994c24bde02184d160ff4.camel@gmail.com>
Subject: Re: [PATCH v6 8/9] iio: adc: ad7173: document sampling frequency
 behaviour
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Fri, 07 Jun 2024 11:09:51 +0200
In-Reply-To: <20240606-ad4111-v6-8-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-8-573981fb3e2e@analog.com>
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
> The ADCs supported by this driver feature a sequencer that read in a
> loop all the enabled chanels. When setting the individual sampling
> frequency for each channel and enabling multiple channels, the effective
> of each channel will be lower than the actual set value. Document this
> behaviour in a comment.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



