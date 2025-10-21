Return-Path: <linux-iio+bounces-25333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B7BBF7096
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F4403D86
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5832B9BD;
	Tue, 21 Oct 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOkxskzi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9FA2749E3
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056518; cv=none; b=Hk2rHDnbqWXxyKW3V4t/wRpN4eKYdbXOY7i1wVstp75exYhD5y1ONj8iu07NeR+mazIPKs7Vv8iTKay97HW9lkib7klSGMAmMSyUDbUJbZLTv3H1vaplVcT38BWs9TLA4fozDYqIPbyRGj6t30Uu41F9BIyf/72AeEorrqdbmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056518; c=relaxed/simple;
	bh=6K+Ya9AoUD4PI0lKdjjQSEvFS7cWapIsir5GAcL14js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLUmFiHMTVSNh5rqFGyvrztpIyQ9i+zA2Z/fmDOJP1ME/+1v+7R/6lMSe047N8cOhUm3mjb/JZwKsPoHtZA0BZ46n858uud5dUieHdnR/ZOCsFT+/naKqkQ4A1uzEtYkipk0lz1v/y5aRfaFkauwIQmt9x05LinSIpJNtmoJpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOkxskzi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so2669175e9.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761056515; x=1761661315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2UPlKlBMRgDPmUCzuIFXxKg63hxPHeMGbfNf2loeFc=;
        b=xOkxskzioce3lQEoalZkrzKD3R5XHVi9qE97WB+cR5KCdBzQix/MGRly7XXG+BFZ+h
         vtBWPZUH04AZayOkK9XJkIcnpC85DjGiPCdpPJsL/zFQMaYREAOtM9mBYOhicr+eHK6u
         BPEdJ1OfQkXFF/D2FaVAqe703dc98Jg+ejmaLRO82GOecoPIu8V0XSlDZu5DNEiypA6D
         Ey/BmKV8ZeD8Veg63etcwX1rzoQh83F0JwLwIXhq5ZpzbzMDVhi1UCPR/UxdOq5Ka/VK
         fLuCSO3A7cHvN5wdE4h2ZqLOWxle9w/tor4BSoPSbpiiL6f6nfgwkT4wZOTt0cGjTAQT
         DSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056515; x=1761661315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2UPlKlBMRgDPmUCzuIFXxKg63hxPHeMGbfNf2loeFc=;
        b=eLtYXLgTKbNSKH5G9s9UTtncaU7ML5ra1r4/Nv2NKEhHB6jKyOSgYholk4SrqSiWfW
         lIrZmq3gfKPfZeJq5N+tGT70wF8LO9TzQLSqIE98EKTEi6dXyaInO2zzmqHhwGw9KsKC
         EoCAJE6iW/0cYpm1Dpe1RSRnFEU/kWXIfP1Loj0rEGg0/RlctwnBm7ZELKBuDLXMU8z4
         Y5gjMEhF0WQvK5ffHH/7UuEPe/50ojxKg03tjbjN7QiM0AzLCHVfqJmgeCEW2MNZi32m
         lBXrXgCBw5Iq3tIFKiHP5H/P/mMimVgvj/eMSp4smWz+qdkhjr7sWB9DPHb12ol5r2J2
         dr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWork4RmAokCKugtDUecjyy1GzTw4EGdV/mC8uW2qCeSEH5tI7mcqFWcLP4iqxzP6N4FEMSCP+aSCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJ03VXIMxTK7KaJPxYT/YWGZZIr5z68bVinHIiAM+AfWroqao
	yaqfdfeN6049PuCLPH23Nigkj23l2yEtDV2eUSW5wmH1SQac7zXwTrILNrttNcIF3iw=
X-Gm-Gg: ASbGncs7uUmBvHc/rQP9Ug37DpvsEjYMcmug1JsXJiIw7RqEjzxOQwo8fmreLVlbEgu
	/GADWBOGMZxxum4h1ZUWXjBzwSWK0s5vLcO7Jr7NWEFFup27ZzV/TgL1QFuWOiDYRvDNc3JwAiX
	K+D0MOaCx7jbgl3kurshHM4RNBtJAcVhVb/A1FzH7Xarg0kL5ZFRlnW3I0ytnAdbvfz/OF4lFSv
	tszOzGhtTLhcGq5E+UEMtMa/gWOx2clydruzw6PUUjnjXFcg/Hnz+bfgZHbZxZvVSYK/8owoiZO
	Ds/q3wnarAwD+4KG+ZV4pe16UeoeSmkO7e5CQB0vdSEo3ZhYEmWCrofdlXOxJCmmzYnVJvZUB41
	Viwe2SWW92bQ7f6R/jWpH3ybs+m38ciGA0qwnJexcWsBvlZ+dJrtzgGxf2MuYuAifQxrRP7Ix
X-Google-Smtp-Source: AGHT+IFgUwtFyMQzVFuUZ9DJK1ExlofFZ2ywTH/htMIthIxsBbbqiw9fs64De3rLyJVpj6OFqtdPYw==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr133669265e9.33.1761056514836;
        Tue, 21 Oct 2025 07:21:54 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm229301885e9.0.2025.10.21.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:21:54 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:21:51 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org, 
	casey.connolly@linaro.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 07/10] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <yyllvqn2i5mqyetf4c5c3k5xyrz2yfxwbkun22zhx6poumt7dn@k2pt6rcemfdf>
References: <20251021083219.17382-1-angelogioacchino.delregno@collabora.com>
 <20251021083219.17382-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021083219.17382-8-angelogioacchino.delregno@collabora.com>

On 25-10-21 10:32:16, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate an USB Repeater device, used to
> convert between eUSB2 and USB 2.0 signaling levels, reachable
> in a specific address range over SPMI.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for EUSB2
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

