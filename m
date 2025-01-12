Return-Path: <linux-iio+bounces-14198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF33A0A93A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20CD3A39D0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA21B4244;
	Sun, 12 Jan 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9NSwTY/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577461B393D;
	Sun, 12 Jan 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685667; cv=none; b=OgcWZT7ASa6zHWIwm08PRRe5tCU6H4cLzVAt920JukenaMgcOf5NZZJfqZsOZL12KpER6Vr9hcSSBIN9uTfLL8Q1o2oaTUUfqdDjN22hBj6pIV/vQgwKW3wU+iqArKnehbaJqvf1ZN48EkVuOHeb0b2G4dRfW50YTgrZalSIEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685667; c=relaxed/simple;
	bh=jyP9TN0d22RkZb1Xs7298WH6lKv/VUK8C3aChaAi5js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAXj0no1YFopGBUMKLGatViwjTCuW0o3AxUpho73KZrjbURA7PFO9NmcBWv6dXt2qijTkxvyzoJMOXQbOLcZfktrG8PJE97ngReKB5mauBMubgGxBoAZEI5ckTuI+z5I9Gy13gA15rKLx6qwMdWcO0G1OuWYkqrGklKtU7U8uuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9NSwTY/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-303548a933aso27254521fa.3;
        Sun, 12 Jan 2025 04:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736685664; x=1737290464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snkeaPpog0Pezto4AadoeGkx1XozJXf44lR2r+sn0l4=;
        b=a9NSwTY/liGIPxBkt99NZO4qguamRMy+vZx1NsOqwhZzViMoAfOba6l5oaogaBR7KQ
         FgYUbjjuIxnzmGn6XVy/8vCpXXLhCGWuBlgwMusqfc2IKuoApOgZ/CEdtPCcpoNfszY6
         skicVeTRkYcUvh05F6ghdrJclYCRNgysuI19auEK5hsV3CcYFno4Vv3/0p8hAMfP1yuA
         MeBInpWlTUUuzWr30bAjPTKmHLbMinv3RVX2k1FSGWcivHFcWUZO4X+YKZMMa1H9yvI0
         /GFERxSIZ66bM7vfbfKWXA1FyacS7wGuiopUPHcKniRha74oqCGKD319DwXA0GBlu6f8
         moog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685664; x=1737290464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snkeaPpog0Pezto4AadoeGkx1XozJXf44lR2r+sn0l4=;
        b=RHwDvybBPFUv4xYIUlS1/pjSz3iZog4e0qNrHyLovF1Rj9p0r30Mo8KIe670FxfSZu
         dtoau+hQIPo48i7/8JZAoeSNDR8PNIvOjrjtipdoOyUIw8Eh6s2TBw9aimWMzCm2SntJ
         DtL11ZnY69UI+SC1tdggi7aVnH9DRvwl06jtPyRdhbFoSjWEEkq5z3w87GdxcIHaWOuV
         kojHqajOZWT/rnzlrEio03azPdUvD2hvaOT4qwctJhE7Z0mbePaNlQoFCJxWjwXmJNfa
         xRx4MlWVDmmsz+dFFFJc7TcPG2Qev2dWnerHpe536NTIn019RYbu4efDnYt43/+56g9F
         uSfA==
X-Forwarded-Encrypted: i=1; AJvYcCVTA6LzsVhCUBzjqtcwaIMfoMjjulwmNQ9xSEi7JvXMsMQ/PvRCOtO1aolzhEg/OiFwjKDd4wCrh8G6t3P0@vger.kernel.org, AJvYcCWRGYROGHnbyXOZTB60zPHHPf+koyI4ERQP7JzrnuPoQD6J9Kh1VubJALcEDh27iCFYKSLpz/rC6Qo0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhu1/XrOyjqwPNYinG1+ekCgaFCZc7FqtEwHj3qKZMLF8Z7e/6
	svnPqpL7sPZ2hgSkRBrXEJhVUDmkH24wSjZceBs9aeSMMxhc9TabQacL4/VXxW8DWQ==
X-Gm-Gg: ASbGncsBfPDoKAzch158068feOwyW/EPvuafAsUK2g1avjTN59pxOpfHaODWXEPrFzB
	3Zfqmyf5W76Upw38yZrdxuWLOs0bx5HLQuAi5hcqeOOJ4qvQrWtLKzt9uNXlsefsaQ6+s5U9KVw
	xPDv0L6ieJZgYXQClrvzVQU3TLNCWp00UcASR9Tz27hi2awAZ8xK3lvlBCUaZlMwBNqii3HIJYi
	1bzdUyJlTPbdBoWipn+liVLllDu5TateNoDETHgjYqw7we4mdP1WlJNWaNgEQFQbw==
X-Google-Smtp-Source: AGHT+IHRS382vN0x4c7H9wWYacUz9Xn4ooJWhrw67LkYlr4rH0+BelwrswfAcOgJcFtTDcs2cysJRg==
X-Received: by 2002:ac2:4c46:0:b0:540:269d:3017 with SMTP id 2adb3069b0e04-542845bab7emr5410980e87.18.1736685664186;
        Sun, 12 Jan 2025 04:41:04 -0800 (PST)
Received: from [192.168.1.78] ([45.136.247.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be49e2esm1071680e87.29.2025.01.12.04.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 04:41:02 -0800 (PST)
Message-ID: <db8f5929-6bff-45f7-8d04-88c0aaae3816@gmail.com>
Date: Sun, 12 Jan 2025 15:41:01 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] iio: accel: mc3230: improve driver, add mc3510c
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
Content-Language: en-US
From: Vasiliy Doylov <nekodevelopper@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've fucked up with it. Sorry

On 1/12/25 3:06 PM, Vasiliy Doylov via B4 Relay wrote:
> Changes includes:
> - Add mount matrix handling
> - Add match table to work with DT
> - Add MC3510C support
>
> MC3510C use same registors as MC3230, but different value scale.
>
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
> Changes in v2:
> - Ordered commits
> - Fixed comment style
> - Ordered struct members
> - Fixed device table
> - MC5310C commit splitted
> - Link to v1: https://lore.kernel.org/r/20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com
>
> ---
> Vasiliy Doylov (5):
>        dt-bindings: iio: accel: mc3230: document mc3510c
>        iio: accel: mc3230: add mount matrix support
>        iio: accel: mc3230: add OF match table
>        iio: accel: mc3230: add multiple devices support
>        iio: accel: mc3230: add mc3510c support
>
>   .../devicetree/bindings/trivial-devices.yaml       |  2 +
>   drivers/iio/accel/mc3230.c                         | 93 ++++++++++++++++++----
>   2 files changed, 79 insertions(+), 16 deletions(-)
> ---
> base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
> change-id: 20250111-mainlining-mc3510c-564702fba487
>
> Best regards,

