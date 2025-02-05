Return-Path: <linux-iio+bounces-15041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92734A28C08
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F947A4145
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862B14F9E7;
	Wed,  5 Feb 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTYVRyVm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7312EBEA;
	Wed,  5 Feb 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762810; cv=none; b=dG7dDsNkv294dAWhuk3uDieSE4I0+qUe7g2KU0Zs8CdEovDwRaMsy0aOS45hYm3ZxIhB5kKSO9hcNmua+d7ilWA3oOW6oB5WXzH5jacqgCWpcEPRu2oLwrv7/Sk0OL3WY6JZu4i8b0V+J/Z9muzUAsz4SsZBQA4LuOH1cwp8x6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762810; c=relaxed/simple;
	bh=VEPlH+RhDHgn4sMtlpsv672QA3CFVCdp7B6pZTK/y+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCz0u01FF6a7hOXojFXWqcylC6WXNfjSPvBAiAWh0JEUrkHm6vzDmSIOPYjAKo03EhoXImbkjUcgeEKr5skjuV4DlJhBX8FUvzq05ke7ASfmDpxwrRMSw3R7gXtYf9ezhBF9Wm8x3y6WGePMwd85zXG4+2YIxezS6xwwRyclTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTYVRyVm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54024ecc33dso6951504e87.0;
        Wed, 05 Feb 2025 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762807; x=1739367607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLyqjf9CbaYco7gdVIzuNw0UDGuLx8SC0tEUwWNJflc=;
        b=KTYVRyVmdXX7IH8POhkYL6rJkgqZhl/mK31QOczQ8mk5GnXdcGixNZ936BrgAaDWUh
         Y+2RYKTX4izxtkDhxSF0HCC/e/i5tHkQIIHqsho574HdGKk8Z2iOe+mZVllvrKH8mG9O
         vWlNUBgkxTcGB5LmQlKr4PeA/A1pe5DDe1JiQ6zL8Ms43WKvLerDFW3c53D6I44fF5AJ
         q43toYf+D14puiSmPYdpw7KG5DBCKeVSAtlAqr3P4QC9CqaHcdZCMp5+cq+xT7l2EoRm
         OU1muxQHE45ll23YG6lu0/XVleJX0ZkJ8talb0uGwA8rS0endJk828G9DlAYvyn6WTEE
         bpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762807; x=1739367607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLyqjf9CbaYco7gdVIzuNw0UDGuLx8SC0tEUwWNJflc=;
        b=G217gWlFDLQY0v8HM9J8JJi0cLwNmCIsiQxrIrOQyE/MOsQDfK8ijZQs3s8sJYbbQt
         TCpp9lodmZuqOyCgZyyMYoJUdUE4IrrosicTM/J+PaHkXh+u200UtqED3NZzAQ+TYJz5
         uwmoUhU/L2fWcaY0SGZp2TWw1QfyPNBt+dvd2LgKhGss0dzUjbUq2ZwYzxGuo1pYNM2A
         F/jJlMTWXJ3upZUtT9PMXiOiaFxPC/P7IdxkW1AFlZJfKoJ4Z2LJXkP/nhg0OKHEksI5
         aFHhaDP5Z8C2OGly4BAzduihTbwlbos6mkPUsJEebSwVNpBzIzFJHmsfoRUiIpBD2r3T
         oc7A==
X-Forwarded-Encrypted: i=1; AJvYcCUi6xfRKWNx+UYT3L+JtmDhiATKO5qOj2U21VaVfeoshyiFCleOCDRUja2EbuL3HJvzkG98dmeurDxe@vger.kernel.org, AJvYcCWksJ/Nxe38xlTUWi4JpwMfwi9CQft3YGdr67BjFvcCfIVSirB3UNuVYNWc7NtFvqdSbmly9zlpas3v3w==@vger.kernel.org, AJvYcCXTLdY8A+Z+0+Yb2txT5RsRKHqfuPC29k8Vr4O9xIcO54ja35bBSDMFraCkzhjjA6U6zM3noE6zGrkx@vger.kernel.org, AJvYcCXZO/8F9qdS8VLNxXz6brg/ro2BEX3/ZyN6RbSQApuHJz3nJ/LuX1rJHAxx+q1jUu1/owZ6eKUdkF+kr9mm@vger.kernel.org
X-Gm-Message-State: AOJu0YwaR9KWXyLY4GoRzywfN0tpWQA77aho807sf5rIqjJMk6b8qP+T
	x5xZ6LEEWaieaGkFV/Aq0afcnMzAMGHXEg3s5nbw7HjMl9NRWhgH
X-Gm-Gg: ASbGnctS+9ZHIg7rhMZ/dQPMnUQn7FlBLFc7aZW8Ip7cedJSBj5Pe+rJTENf29t4llr
	RVCcQ1R4cKfbUx35cp94OOVI4vbPpwUFuSHAncdZ0DPTEawRXPBPHR0QPd1VFTQDV/Zet3VeBZs
	A4ON2pmnoXfe66hkON5//Vl3T/5piEW5AN49+grpJUoxS5d/bv4B2JaMzPG7uXwM3Vm0/8qNi3D
	ScgzG8MMF/MIK22eiZG+N0fJ43ZnIB5FqN/61Xa2oFQqJppkJLD4+FM4o6soY8vGJsFXFQA4HDi
	X2fIobIvX8Y4JQJTU0GpspdaYiMX
X-Google-Smtp-Source: AGHT+IEu+0lYusoGOWBtFbezGvy1nQBT7d23YvXF588JSxC4EkiXQiSDJlPFs+jQpZ/qiL+o6Q1Acg==
X-Received: by 2002:a05:6512:368b:b0:53e:39ed:85e6 with SMTP id 2adb3069b0e04-54405a6ff4amr846174e87.32.1738762806700;
        Wed, 05 Feb 2025 05:40:06 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb0b7asm1891082e87.119.2025.02.05.05.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 05:40:04 -0800 (PST)
Message-ID: <4a9790c4-8428-4939-b112-e5fe41d7b746@gmail.com>
Date: Wed, 5 Feb 2025 15:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] mfd: Add ROHM BD79124 ADC/GPO
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Linus Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <cc30cf6859b5e5a7320282709f428cd42717ac6b.1738328714.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cc30cf6859b5e5a7320282709f428cd42717ac6b.1738328714.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2025 15:37, Matti Vaittinen wrote:
> Add core driver for the ROHM BD79124 ADC / GPO.
> 
> The core driver launches the sub-drivers for the pinmux/GPO and for the
> IIO ADC. It also provides the regmap, and forwards the IRQ resource to
> the ADC.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Just a note to reviewers - I dropped the MFD from v2. No need to review 
this any further.

Thanks!

Yours,
	-- Matti

