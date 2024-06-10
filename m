Return-Path: <linux-iio+bounces-6138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678A901BDD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9552EB20EEC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71874225CE;
	Mon, 10 Jun 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtQVAgUl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F991879;
	Mon, 10 Jun 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004256; cv=none; b=MnLZcHVPN4t6QPTj6cQYBgli70b8L62Ps9b/j6eUZAN42An1/Wo3VQEaWVUVx81P202pNK6GiLe+aDFQIkJMIKQ+ovgCPT4wVdRLNQl+IBnLf4xtoizLG8ggc5Xb7Z7bN5PmJ1dR00RYqvn3wkQ40Ib7IL84cVPZ7K8lXNa/lbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004256; c=relaxed/simple;
	bh=XtV6J/C3mIYUKJcRToCoRtSjZ3qY6JritvP2gPzIkEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmpideH5XDKGPcgujv9lEB+L66EBrjHhdeJOGq2qBcg+JbXXIF4rI0T7Fv5MBQgX6K38PwkqvTaA/4Ddbz1Bqet7u9jHV7xzYwv+pA6ZxQV5ssTwiC31fPJbX1YTyZ1ksSHORaRPdgDkoGgrjps1yaXv1FfMmsiNqR0sKXx89aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtQVAgUl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so1015200a12.2;
        Mon, 10 Jun 2024 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718004253; x=1718609053; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XtV6J/C3mIYUKJcRToCoRtSjZ3qY6JritvP2gPzIkEA=;
        b=BtQVAgUl1/JjVcmB1/BtxuriFcNXA3qSocEFZfhizybDJuxddxjbdxOeomdPQm6JrB
         7B+L+0ynqMcA9863ol8a5DW3JzbSNI1jxHlxmas16mrISLrXCZcWoGLYfzBSSNlahm7w
         mtZq5oIyKMhXBP86YsdsdZg9AFBPJdyr6gQGu+Kpn1agSeNbdZVK8vsGI6SScD7Pbaba
         mz0OEZ3nty3A9vbKlcOLTNs6AdsUhCcC5a3jZ3SY7N1JVWr1wFsXPzaETLX4LklH7tBb
         rbQrTXyiFmJiO5oIFChmr31OlBdhag0evlgKIM8o8rXfq1BnvqMiQcbkJM5oSrFl3BOH
         BH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718004253; x=1718609053;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtV6J/C3mIYUKJcRToCoRtSjZ3qY6JritvP2gPzIkEA=;
        b=rhocM5FWP3qao6mDzI5UNDKOUs2ynu9ALAfrgI5dhp8Csm5u50xPaoCEobBBrtkQsh
         lTqMxVUYVO9IJbQIIZoa+Qm7vFimg0O65E6Oqet3SFRKGDRLALdGkQXjtqVeAE6kU42V
         X+1fdicnNH3RhMuiItRC40zBCH0fREZm3D5CdYlmiZ8J3KggTeZbI9VLb7h1ioTylcUx
         Uj7ckNMq0fjpMb4F+9DfJNgOZ2HjA3JZmSH3xVH2tLNhnBOCviLlMkNMdi+HZiyu4oae
         FP7CgXXXAPBxveSOUCuyzjN9vEIZQoHqcDQb7Fq1W5vyQgVDTpp5FccdgSS2GUTbiVT5
         D5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV9JUTwdc+3O9be1yYgX9o8j/aRz22j/503hCf9b42dJ5G/wkwIritpclqf24BcVC5NrZ0AXd37/irnjM+zwjgZ/dinGm17GXci6BDEmcsmB22jVNxBJUfqEb/Iw4g5Ps98eD9v4KWh5rzRiKde940vJQQxuMKX1ZBf+Rjd+3pOcjiujQ==
X-Gm-Message-State: AOJu0Yzt9vT8FU0n0K15N4pkqhFp2/7yoFUlIdxHWENSFoRULbDGOSeN
	Ts5bEWCi5Fyddpi+fo+yLZA51l/m0MZpY+T890LjZdVLAh7k4d1f
X-Google-Smtp-Source: AGHT+IFNULR5iskJcWTenAl84kcjQZ9t99Alkh3XL1fQkK0jffBxjeNagzKGw89BtWcwSVw3S1StFQ==
X-Received: by 2002:a50:96d2:0:b0:57c:8027:534d with SMTP id 4fb4d7f45d1cf-57c802753e7mr1297420a12.27.1718004251571;
        Mon, 10 Jun 2024 00:24:11 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae103483sm7024525a12.43.2024.06.10.00.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 00:24:11 -0700 (PDT)
Message-ID: <59d603b930d5943a89618dff23156fa318252fc4.camel@gmail.com>
Subject: Re: [PATCH v7 9/9] iio: adc: ad7173: Add support for AD411x devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Mon, 10 Jun 2024 09:27:59 +0200
In-Reply-To: <20240607-ad4111-v7-9-97e3855900a0@analog.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
	 <20240607-ad4111-v7-9-97e3855900a0@analog.com>
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
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>=20
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
>=20
> This family of ADCs integrates an analog front end suitable for processin=
g
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
>=20
> - All ADCs have inputs with a precision voltage divider with a division
> =C2=A0 ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
> =C2=A0 shunt resistor.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



