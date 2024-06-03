Return-Path: <linux-iio+bounces-5712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B68D8AA5
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5262328131C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8BB13B29D;
	Mon,  3 Jun 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F2Ds8tku"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438DB13A884
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444776; cv=none; b=JVJPv6Pka26exxxhx8c6VYhLazzhYyZQjhZLW7TyNQ8tcQf9LfAl0hawDP/DWm258Ke5mtnWwGF7hob/KRWB/LJIa4ziw0UaiTYtq5e/7OlH3DR7SpbHYvmOmoIzOCiUpuf0j/qz2dHQ4x8Ncqu72ZMzFL3Aq53Nj6wqr1qkOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444776; c=relaxed/simple;
	bh=8ObTtzJzwdgrV6cQN4g+ncxZ7TC6Y/uH8CVk4H+ab+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zti1/uu/wqO7cahlteKk+YNRPVnI6CEfTKSoibLysBcahtFgMaW6BJOblz1jmiSMBqEUKfogJs8DSZt11gSbLQqiggCZ2Xa7FLY3WXXpCvSW6Vdv6rou814QtdHXSocuXNjJ+oZjUYjfRACMiogrAg+cjduM8DSr1C+Z14cvTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F2Ds8tku; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2509f93959bso1281962fac.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717444772; x=1718049572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRFpfKOMP0yGFtHmUjNHpNMCBPomaUfAjcDTvSN7F+w=;
        b=F2Ds8tkuAOa+4QWwtaaWf67McvRmml9TlwFgfNrwkB4KFRj7z7aEP+kTqLJlqUzta9
         3/IPhMQ2IhqPTVc17gyjE8TxTr60E7xz1iUP7vI0wiq135de2O420G8ZZZqICHaRWPWr
         eakUlyjJzGhdb16ZeasX8sJ0oZTWooFBPVhmq+GNY5RvIvNEWiUNDA37BH2Zg3wVJOZe
         HVvaAqgSSlP4KxGcPKT4hGRQ/Fx1c9vSXa4bqR3A4q26uKQOwItbjzSQFP0YuEFy8JlK
         bX3qoPzomKsMPK/27UZfBvs7tyxVKSAlWsbDvuZvOQgmtvdoE1HVvVtHiLKciIgk79Ed
         8EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717444772; x=1718049572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRFpfKOMP0yGFtHmUjNHpNMCBPomaUfAjcDTvSN7F+w=;
        b=S1OkvJ1z2FGq2WtcYK1SN2v1mkd3RILEVSynBWQoWTsuubSfQATThFHBO3m9ZjCC7H
         CXOMJJXVvPh5lXI4rxbEkU4yoJ6o5s9afqhWwGIcVEjjYbk+2pVp9G80dFwC8GqVafSd
         qcaVnKNBGCRjxzUYkJ5Uqmw3mj6F2+AqE4u3kbr8BI1DK37ObMWxFG36XxGLGwHLUlhd
         Lh14dk3AO5LHadNyshynYzby7LcCEJNWqEybAVmyN/oN5iR8vCQPo2RVF6uxTLnISxOT
         WgGvsUm1L2ngl7ESsd+WC71xLAY/vUlOg+a+bJo9Y4KQsxJXlSZz9bwiJDXdzQYP5NHF
         YxrA==
X-Forwarded-Encrypted: i=1; AJvYcCXtEKkycyMHTVGiKkPnyWa53HWcX/LAgVoblrPjqDPG/w0zpCwnLvLj+P8MX6sSZkWf1J346KtsK803EbhGR0q/pNYE9Utp8NDJ
X-Gm-Message-State: AOJu0YzGCet+DLQDujLmvluTtqBdBPPJWe9EfVONzqy0Az/Y3lD85pIh
	V3NHLi0hE98O7juPRiUh+HBWLucq53gvTcloz5R+6//H4szwspIkyMHDY3Hir54=
X-Google-Smtp-Source: AGHT+IFeHA+985ubS7larOgU0Ytw2VgLpfpcgg0FNQ0XvzTTpJVj13VKEHuPTBVru3so0HW9l3Au8Q==
X-Received: by 2002:a05:6870:1654:b0:24f:c0da:3d4e with SMTP id 586e51a60fabf-250ffa8574emr308963fac.2.1717444772157;
        Mon, 03 Jun 2024 12:59:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-250853e5f19sm2663534fac.58.2024.06.03.12.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 12:59:31 -0700 (PDT)
Message-ID: <2942a938-19b9-4642-8ed0-8e17e4825bc5@baylibre.com>
Date: Mon, 3 Jun 2024 14:59:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
To: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
 <20240603012200.16589-5-kimseer.paller@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240603012200.16589-5-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/24 8:21 PM, Kim Seer Paller wrote:
> Add documentation for ltc2672.
> 
> Reported-by: Rob Herring (Arm) <robh@kernel.org>
> Closes: https://lore.kernel.org/all/171643825573.1037396.2749703571529285460.robh@kernel.org/
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2672.yaml         | 158 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> new file mode 100644
> index 000000000000..d143a9db7010
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2672.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2672 DAC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2672

The linked datasheet describes 12-bit and 16-bit versions, so should we have
two compatibles here? adi,ltc2672-12, adi,ltc2672-16

I don't see any ID registers where this could be read from the chip at
runtime, so seems like something that needs to be in the devicetree.

