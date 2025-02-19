Return-Path: <linux-iio+bounces-15808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61996A3CA08
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 21:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318C23B8ED5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F423C8CC;
	Wed, 19 Feb 2025 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrC24Sfz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B21F2C5F
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997300; cv=none; b=YYEkyyuqCGaxgGfh5NGbvZhC0fBonVuOscRG221zdc0rKBST9KR8vkKXlJ6S5cocvqCGsJPjYWrjxTs50XCz6MYFHIRH3ezaGwd0rg0go8zOxhvB56duria4/N32BKfytu5KGVJahWblYL+kf1Br2U48zXZ6/hc2QxjXLmqvhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997300; c=relaxed/simple;
	bh=tmmB1CJeqQfmQIsT1k2GUWvfj10sMcsKlDITNHP0y0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZbf5h4ItgtT9RuACB1+RuQq+5JG2XLYuncSGSHV2/uXxDcB6WT+rI0TbJQH9558uhhlDW0Q45NVD8oQmkKo7y23R2zo6oq8cUvLwYCG+C06Tc3qWdWOoXcayF4wtVag5n4JdBOaCzCq0m2wgQ0irUFeZdz7HYGSisQ21xiFJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrC24Sfz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54622829175so233472e87.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 12:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739997297; x=1740602097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmmB1CJeqQfmQIsT1k2GUWvfj10sMcsKlDITNHP0y0E=;
        b=qrC24SfzifPCd/chsOHEE5eg/ij7+Rqoiy1lfyuVqdpLNT2XMPm4sv1zg+JENjtcal
         9vBYifdKFqZp/DIGw7YhyarKqRZ1g0zwwaO4VAHAnfycUv+bBhsYv+xxFQSUDlQpsvC6
         TLyTBlOGKaBFx26TOsNB+5vTou9SkZTeg7Oibk4/Z0rG2uAMcJbvBG2aYZVh6jnbYnzb
         osVBhY939AitIpz7AaMOFo/QUW/DTtz3yUUsBtOASblJRuwZyEuYVsces0O4uQnJ0nzm
         PC/Jd3yLobueKoVUkyl/20JDTsW4jZpFzRmI2P2MXdS752ZuvXYcoiAs3mfS+QCoyxii
         yIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997297; x=1740602097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmmB1CJeqQfmQIsT1k2GUWvfj10sMcsKlDITNHP0y0E=;
        b=j/TPA+mHx60s4ifU9pv6IGruosvyQsBmvuw+DPQ3fmCJnXq4b1kKX+UpXEdWlNS6tY
         eGDllW5zZ7qkT8SdpJlM3JxoI5+Fkf4nfQgvOVNMIsGslnD9VCxsBq5AWR2WI/NYyGQr
         P+7MMUisIduvAXHLArzQIOJwFcZ9w3evkB4i6E8oficholEo8bqYBrEn4YPX5DOX8Wy5
         aer7YlDNL2MM5tvbJzqOtwMFaPyN0/Nx67RHCTsTmRpDbYstUsJoemICjM+lVzbMiHsz
         +534/CRM95Ip4v6aEaMZzPTaaUWEcqyO+kmyAKWNe6DhVJZ1D1oR+p1L10OXpmnhNyUc
         tPpQ==
X-Gm-Message-State: AOJu0YxYoz7jqy4UJb19claPannufK2/HczRBD7AqSjn5vyY5C1DknCV
	T60xwVQBi+58g8MrY1fpMBi3a7V1m5jaUfTik6/y84sGfhhMw7A/Y5ex6sHBg/yu1IU7LOIoPG3
	bAJAidFXRDeZbXJoJJs1djnQV9umAAKviCL+f3A==
X-Gm-Gg: ASbGncsr7tFh0xmGD4HIw8xFBSmDsA3yTp3q86FXwSav1OrNS81+kaK/Ez8Ex/bZ7tq
	hkaaaPRtdBvXhoLNqVPg9qb9LlcmIlL/DyrYs2IpSqLcvaOuiFAUslI911bLDJhUPmiQCqckf
X-Google-Smtp-Source: AGHT+IHbToAtZe/z+uRFGIRnNv1BDrEH+lc1qU1hrhcx1euMXlKTWhbbehSpK2l1rH3kiLuqYPFivyA0U+9MmTz7gF8=
X-Received: by 2002:a05:6512:3dab:b0:545:2fcf:642d with SMTP id
 2adb3069b0e04-5452fe2727cmr6277433e87.6.1739997296872; Wed, 19 Feb 2025
 12:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739368121.git.Jonathan.Santos@analog.com> <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
In-Reply-To: <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Feb 2025 21:34:45 +0100
X-Gm-Features: AWEUYZmqmEnkA-aLVYEYk2CgVjDlg2QM-jTEjVJlaUmymL8juT9oZ9shwBapvIM
Message-ID: <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan/Sergiu,

thanks for your patch!

On Wed, Feb 12, 2025 at 7:20=E2=80=AFPM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>
> The AD7768-1 has the ability to control other local hardware (such as gai=
n
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
>
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Is it not possible to use the gpio regmap library in this driver
like we do in drivers/iio/addac/stx104.c?

It cuts down the code size of simple GPIO chips on random
chips quite a lot.

Yours,
Linus Walleij

