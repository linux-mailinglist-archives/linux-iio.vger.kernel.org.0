Return-Path: <linux-iio+bounces-10176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B04991815
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A031F2231B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A515854A;
	Sat,  5 Oct 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="13/2Zl3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF3157A7C
	for <linux-iio@vger.kernel.org>; Sat,  5 Oct 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144286; cv=none; b=f7Fl82vSri0m/4LpW9OWKWKMynmFeNJ+O9QLCABBRhlAzShcq/cBzeeyT36mYBagJerf1hTDuQJnYC0PAqH3ghi/Fllz3eCqOdx2jWx9J3uQK26BuhP7Pt6LiD/SGju04wUPDDUSsQ+aKNCA25ss+5ly7zjsGU4HqHW2FOI1pRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144286; c=relaxed/simple;
	bh=7G8Idj89zb2EI/kVrjhy0YfPRleOfpA5LbmpcuA/zRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HcSvwIOIoVubvxI4YcQRTjG7QYJe5oGlNRMWqpLzq/gAlg37aqufePE1keC4bEMTnV54F3tOO8kxboIGreNwyjC4r/jtYe1MpZv0JTxY0IvcxWpYKp+k9C8a+/GbVSevdL3zyi0ws6PInZ00GzAgloe+wpN1Zv5rUQC2cPArmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=13/2Zl3B; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e1cdfe241eso1059510eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 05 Oct 2024 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728144284; x=1728749084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Kwl0dXoGvk4I1L3ha2mUXPb6YQ/5kfQsKUBo54j7RM=;
        b=13/2Zl3B98PpVXeySxA/QP5kR3TpBrmfMXAhzO/PYiWBI7rMvq/WLgmlceLliSGSfj
         QjdHBXvGnpaUxjdLtWWjxagcxlyaZGUHiRJZAtihP++M8ep6n0gK3FiuItFUa+NY2She
         eIgBZZb91ECOFtSpRy8dK78dxc+MvpUQtLvnGASc1jGzrhEu90QUQy5Q0LV3kugXnwp5
         LonVx8jKtYHDxSIWMAATXN227hvtNiYnl+bQLYXP+cXoqi23ox+mZl0iSLtD+NVOc4AP
         oaYOdCMtAYifDW7QkLLut7UYmJ3UVv0JqMZrCGCS5uKHTErx5gTYnA1ADdsLoOqNh/yS
         OLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728144284; x=1728749084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kwl0dXoGvk4I1L3ha2mUXPb6YQ/5kfQsKUBo54j7RM=;
        b=nApPGmFhMb3b8w7hFEYflzJBf5x9nDqMwRIqC0U92ppW/a4E6SllWLL8K7rY+c3vrK
         MpeSuh8zZxfvcY2TS113/bEwjLyC9osp4ybGZ702aKOqss9E03xMdCz9RFh+/xTHJ5R4
         WWG+9HjEGyUG8Ao96CVxGUewB9GgPk4uq7EYOnsu69V1V709hUqCrzn6+zRrv+2EJDXN
         fNcmClZ6m/SoI4M8aPMQK0hlfKtTP1+iLV6HyKleUE9wB3opj6OBz4G1pHTjkB4ySVBD
         giDZraRweAcISdfidK/Vwuon7FwIEXPQhSMzKalgDPZ5X2qAjuce8eq79CeSgHtQ1ANH
         EeFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeheEaktxFIVGI/8Mq/WUleyWrLMNAcb8+mjOJ9dmdvk71l3maCXmNocLZzxKzattwiIxODRgc9Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+vY0Dd2DpAJxJkwcbZjC6O9k9ofX+soziRrueePXM1xH9ylX
	mvda28SW0CLLdcqC01rY66UVenI3SzIPb27v7yHTnPolccVJfLQ1QPymfx/EXKU=
X-Google-Smtp-Source: AGHT+IGlbSF2O7STOLHo7SpIZU5tLsjFrVnpfRxE0DIBRR39U8WUKT+qVDkdrC2mG0giRQE9tWO4ng==
X-Received: by 2002:a05:6820:1c84:b0:5e1:cabe:a3 with SMTP id 006d021491bc7-5e7cbe5f4e4mr2972082eaf.0.1728144283944;
        Sat, 05 Oct 2024 09:04:43 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71556847358sm550142a34.61.2024.10.05.09.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 09:04:42 -0700 (PDT)
Message-ID: <7696952c-acee-4906-a37d-03aab2b23352@baylibre.com>
Date: Sat, 5 Oct 2024 11:04:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: adc: add ad485x
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-5-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241004140922.233939-5-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 9:07 AM, Antoniu Miclaus wrote:
> Add devicetree bindings for ad485x family.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +
> +  vcc-supply: true
> +
> +  vee-supply: true
> +
> +  vdd-supply: true
> +
> +  vddh-supply: true
> +
> +  vddl-supply: true
> +
> +  vio-supply: true

What about REFIO and REFBUF supplies? These are optional, but
no reason we can't add them now.


