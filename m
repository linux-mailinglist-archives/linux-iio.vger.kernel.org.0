Return-Path: <linux-iio+bounces-4486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A08B0087
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 06:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA4CB240EB
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 04:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27CA13DB99;
	Wed, 24 Apr 2024 04:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPEU6vip"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A513DBA0
	for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932901; cv=none; b=VN20PlkBE2QIwfvxEYft76Z7HNXnib5KLZXYeHHKcn8qkIuAtsVsGJ7RkFZB/tDfT7qu6XDd67EJrtdlfVlsZfUIJ6RQDQYjbtBhI2SsOWiKGQtTDVXIkux7+p1AVmxN87MR4Gw5yzfuuHZJNzK50B/hJ3YV4J21+CrvHuGIkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932901; c=relaxed/simple;
	bh=K2uPx8Z39cowyd3CKs/kv0/GPxaVvKugF3Okmkjpnuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxKcZiCv5yzFd9Y2NPy0VHY8DY1LrFmX57mwE6IjUlJTnVL0FISl7d3W/GVwojjyNjIbehhinJnHBeAsSAfLkHKQMwPxz7WzLmxAgwGC/5rZ6M9B2JYWpYdvSlYxg/DVnKX0NQo0+GGtnN2EiKu5tUHrE+K6ETTBcBCZwIs9oWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPEU6vip; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5883518135so144212466b.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2024 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713932898; x=1714537698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R8Fs3EjOdj6derBzQe4RlSevlHJghueWR0mNYiVQCo8=;
        b=IPEU6vipT+Xa7En49p+JNgPICicS70PpWZhTcU9qkqOUcGn6dXEImtS3aQ/R+/URtY
         soActiicKwfRym0BFPKxltMPobDnunEP0RTFrC8ljNkvXULxUS0PErXtRMTfybdF9rqF
         pnGxPpk2yUm7IDcxI0s0lIBRc5zQG3hgDvZJRuunDNByqpJ1oOKdq+VrPmgfRLC1qGw5
         OhdsQTlaqIbwRyhT0jQi8V+WbGYPBIoy9sShYpCpRmLsX5qk32rylRjCqJWdpJiXep3C
         yjf1LBEUrGFs9Yb6RKryi02mtkg8vPv0CA8wZ2wTpYTGMOLivV6X0aXvd8etoBvb3JR1
         kvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713932898; x=1714537698;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8Fs3EjOdj6derBzQe4RlSevlHJghueWR0mNYiVQCo8=;
        b=qOxQwF6aboVwqlNmkTIM1IW1lSRMLNRuSX4Y0Po3ZwtzLStcgbl8J5yD6yOBmR5+Ms
         zwK0DiE9HKZkV4zDTxJ+MiUZq5OCdVAytw4J9LWCcorMrZZY0uHrbW3TzKqC6vKOZPHi
         ht7/caJYe46bdkXkmId7pmd55ODXDg1JLov1sF0TIgNE6i47O84r0nFSFbC5lNEi6eJl
         vCToqj3sI25lbvdh8zHWif2WnLhiAMs6Pm/j8smCZJUReyfUx+fBtB3vy1GKYcC8/gC4
         7yD372acx2ERWJ6zMhssNx/CqDVOlyjV2S6tP1Ja33dDJwNFhC0q9x70kQDL7Rm0PSEJ
         xgpw==
X-Forwarded-Encrypted: i=1; AJvYcCUmHZita1RB/soLCiDYzBARbihSnC0soMvRiuxmdiXaiE9kQaeWMg5V+ATVHHCXLZH3VbunMXjAoW9aIR6w7w1TglZ6Zda3Q8f+
X-Gm-Message-State: AOJu0Yxa6Ex0OOwH/HyumHlJBzCwgoCQ8Xx0N5w2buvWroGXAbiXZReO
	WVkufRr7H5E39byEZTXtWYom+jLf0XohryRODwMIcGMfgSuQEmT2Liq9r75GswY=
X-Google-Smtp-Source: AGHT+IHhibC5y0u82AOKA3V0ahASy6QI1S46tkSYPwpI/AUogp7DUC0A/o5LtZczFgCVrCna43jbXg==
X-Received: by 2002:a17:906:d206:b0:a4d:fcc9:905c with SMTP id w6-20020a170906d20600b00a4dfcc9905cmr657577ejz.20.1713932898280;
        Tue, 23 Apr 2024 21:28:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bb6-20020a1709070a0600b00a55b020a821sm3841045ejc.13.2024.04.23.21.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 21:28:17 -0700 (PDT)
Message-ID: <7d08f521-bdc9-4122-a636-a0a2c5bc328b@linaro.org>
Date: Wed, 24 Apr 2024 06:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: light: stk33xx: add vdd and leda
 regulators
To: Aren Moynihan <aren@peacevolution.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Ondrej Jirman <megi@xff.cz>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Willow Barraco <contact@willowbarraco.fr>
References: <20240423223309.1468198-2-aren@peacevolution.org>
 <20240423223309.1468198-3-aren@peacevolution.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240423223309.1468198-3-aren@peacevolution.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 00:33, Aren Moynihan wrote:
> stk3310 and stk3311 are typically connected to power supplies for the
> chip (vdd) and the infrared LED (leda). Add properties so we can power
> these up / down appropriately.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


