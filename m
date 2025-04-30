Return-Path: <linux-iio+bounces-18913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF8AA53F7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335B11C0125F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA54264FB3;
	Wed, 30 Apr 2025 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZtV8bycx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490ED2741A0
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038610; cv=none; b=tK/BNdG6nKLXcRqdflV/6zKuVuk2AmgFtLkEzqWVqxfSlxao7XTdwDhXy8iYksBg9U9X7Em7GG3XLnt0uU1CpPVXdlmh+p67GKsAD69719DCuL8TPqeQkgeHDFrxz9HX/bZGfUm0uf8gPbg1RDQFSVySvZUiGqt8+T0qvfcnw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038610; c=relaxed/simple;
	bh=Pb/efMrKg4+HQ6/2NfMbs7Yh7bxImHsK9yrL75Whraw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrkFDvioJMkl0qb0aDFYxiHjR/SOB51QYhfa6vrjdSdQ1dv6ueP1CQb0URo/ZcPVAd/tYUZg9pLhdeU3r4skNSiH8qjWyOhjCCCzHdSdi/t1wUt4g4rmtIhOLVuH3UPwGjcnrd1PyOwfrn5TOFtwn3CKs4Q/OCAplo9k3Rqq/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZtV8bycx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-606477d77easo125242eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746038607; x=1746643407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRXIk2lKOYAihoanpH8QfdOUyxAwjsmIpzrb0u3+vUw=;
        b=ZtV8bycxyMd8Oo2aCtRDHSBqDpXEvKtPS13YV11fWJNa3apDicwVUT33iToiV32Jsk
         L6lPAP8s2Wox4fHf5VRJdPRnjBKE5zZJIQWEpaH/K9OqAM+27TuIbcjfGDRE9GfwfXRy
         FFcDh9TjW6VINlRGFLjV3IZnk9q1NuiZ2UtYtLywb4BxvdtQluuy/XudfUZBbksaHufi
         CEdfGBMLgCQrEgP+/+DTTAQfmm5dlEhQjNi21Tk6jTMCb/tLsBGd8fwi+AVs1VIVSBvk
         anhdXrudaY3V2uzuLn4fDzVwgD/DvVHYpuYm2fsafeNymG2ADng+oIUX7Hta/viBOWPY
         +coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746038607; x=1746643407;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRXIk2lKOYAihoanpH8QfdOUyxAwjsmIpzrb0u3+vUw=;
        b=xCvcJh7R9gvG9QAKx8/ntZ36JVkccIHxUuwCDlew1dM/CfJ+XJyE9JmiydRnnVXqYo
         aVM+2kSq/m5W11aiKyIu9XIhXU8Lx4a9MViIQaDo+pG2L6SINzY6syCFOXIhy46sNIHa
         TuD0MUH+vJCHX9KsQ1VB70JSe16jeR2ITqxJ1gEMePD5TCNFul5nj6Pt5aKMUm5x3zxJ
         lqkERyAldXsOVKjtHKMEMOWhrUHXPAkKz6H3+haAk6tmxUJy56/OOSOZh2j2K/H3f9bH
         hReJCHEpZepiYOGvBZFkY9Y9g9V6KRbXdINFHClXYWZhFBjejFcHhzHZT1KApqdYgYHW
         9STw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ayK98y+4VEzqNQwHqTc6LXviDq80P8ILMLUl12oBG75s1XWnwuqRdDDGoo9uG/r5msSf0jspILQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mJEwjRS/Dio6dOJyvyxqrJ5+6USr2DJkcFcv7qBF2e8Z5mtw
	M/RrpA2chXokeMDojZr9fiqr6+/o7ap+X4Hj4A84l5lKr9vtrPc256oxW2gEO3w=
X-Gm-Gg: ASbGncs7vLN6umm+At693NGEfDAISMHkI1g93N+bHEmWZlF99iobJcXqnmYwVnlWH5q
	k+LaJnUNivC1fZIj2yqWxSBQdYm2sNqsQ7Ft1Myv3PNHKwMCmZ2WalTNDh4U0Leb3pVhHcTmQw6
	IZkMvMxPbECg36YSD2Ry5OSYuds8PY9rnMkN00BrlyDXDPtuMKGo92+Aay0Si/bx2sw2gmlFE4c
	ds8NMVcaWCI6s++zZMLXr4mu9hAttuay+0VUzO0OzB86lRx0iGIlBBQEeiL05LxVzwb0LUUYlGZ
	y39JjuZlYOML/JYTu9g8tY0OmsZfVIevw2vIKFOnGXgj8VN/4V5aB5/zTwsS5/thNjtspbSSjG0
	WKWS4H6J52wqtZVc=
X-Google-Smtp-Source: AGHT+IFJ7NsTI0Qgevug+avxKfif9V5H032u+ML/0KNagUrHEeVV4ThgLTtzw4bhB4wmXUjY6rLWXA==
X-Received: by 2002:a4a:e843:0:b0:604:99a6:4e90 with SMTP id 006d021491bc7-607df5e5f9amr353602eaf.0.1746038607385;
        Wed, 30 Apr 2025 11:43:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60686e96dddsm884171eaf.2.2025.04.30.11.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 11:43:26 -0700 (PDT)
Message-ID: <996aedcb-f4f6-47f1-a818-ac89de0fa459@baylibre.com>
Date: Wed, 30 Apr 2025 13:43:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] iio: adc: ad7768-1: add regulator to control VCM
 output
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <8a04f8f1e9c14d57b1db2f38a8433a0367c0c9dd.1745605382.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <8a04f8f1e9c14d57b1db2f38a8433a0367c0c9dd.1745605382.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/25 7:13 PM, Jonathan Santos wrote:
> The VCM output voltage can be used as a common-mode voltage within the
> amplifier preconditioning circuits external to the AD7768-1.
> 
> This change allows the user to configure VCM output using the regulator
> framework.
> 
> Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
With the issues that Andy pointed out addressed:

Reviewed-by: David Lechner <dlechner@baylibre.com>


