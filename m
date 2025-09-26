Return-Path: <linux-iio+bounces-24464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D387BA50C6
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9CB1BC782C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFF284883;
	Fri, 26 Sep 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NIR2hyag"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053028469D
	for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917463; cv=none; b=HdrW9Mchaj5exFkJHq/6aUVVwccRqAGmKHBleRFGEwTiG/EPg5KlAAElmwO9KFuhBpfRn9Y8YmTnQY09nY5+i6YNDvawYOwlkC6d/8Q5uXulwpnNuULgjkMUbPDgLeZU9wLiK1o0KAI2vhyT7XtLPRrGZ4AFUK5JqosLycJE6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917463; c=relaxed/simple;
	bh=1yQrANvKpY0ljywMGibLEmI7xpn2zjzMdiYcXzsnAYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIOX0e4mcG4yiZTc9GqopmEojzrtvCCf7V8s75M7eGNvk706SSjC880hPhlXIOmcOWB9+Wmc6lXjajU0E9m5aLSsEWa1Mw7mVFVHEJnLFMplYeC1KV8mfColSSJPlw18SSZ/gxeKQ3iC3lC5Tel+P3MfwvX6PVQHimOcwWsYR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NIR2hyag; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30ccec59b4bso2501631fac.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758917459; x=1759522259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+S0IT5rLN8S3zlzSf3mYl4iNyco/hSRX1g8S5jZJwo=;
        b=NIR2hyag1RqA8AF1uJamKoGp6Qxa1F7sW0kbnJez0PCJEj/dZiKozZ/eFP9Pvw0RLB
         /MQNX0kstKLVKRGLl7SDv0r6PrRpHouo1i+Fsoegz16Wh3S+KbawDZPSGzHrGYNqJA8N
         SdwMFlF+9Z8id2DXI/fjTK/M3gNJbTWKFhRbAUupFOKkjzCFPsjYUglUespA5MwW90Q9
         u/Z8bY/hDh4oW2fuNqwH5pZt1gf0HYP4amzfBs2ZOJMAxlJUArFDw9ihqt1N2PmezpP6
         vQk71EqtYYzmCVcGsmPw+cBWZTnUNbYYBKJ/+ABsfu/UGCwyRxFdtjLvYz5TAae1SfmB
         vV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917459; x=1759522259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+S0IT5rLN8S3zlzSf3mYl4iNyco/hSRX1g8S5jZJwo=;
        b=YbOYUdJqpaIlfnp+QvP5zwTTadMxbZdkRGcjQ9FuNO0MDTV7PU46zAvdiSFlmOQ//L
         AEAsivvMCMIP8wmlkeImX6A4KrIknLmh+FxPkiy2vwUx+m6An5yRvrs+xFm1ikmNNzvh
         5ScqsDGGOS/CfgeapL0K3DfTtdsPPL8EwxJ0QX91CVAWAwy/xeuLlkGoghwnfuk6R4ME
         x0p0HzSgLU29rdv3m8SY3S8bh7+HzkJ/4LEkKQodyamIIB+8Qpr27ArVPpDxRlW2zncw
         HPVskhTEkhjM5vIAOv8goKWq/IUMAlTCc/wv1Moj4cxCgyVU1EQChlDq9cH03OuK/Y1l
         PQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVge+184ZtTjteYL4gndmj5NzxzPPs2UKdZH9ihh/IAGZFLuBYuuFp5ug5Q8xMDbaIIk7Bxw82MGrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVDUd6S+YngOAjpV2hxCGVPL2rfG/ZmUeH8DPz+Sp4oMzVFu7
	x1rgZxyxEzc5kUQBPREHjYqOlI+LuuYzJMBKqlJND4YzyKhfq9CqyJQsCKg55kDj+xY=
X-Gm-Gg: ASbGncuSkntqq+C4Q84rWyrqp5/vhyWXwao4q31chlgo7X67eyBry331bm18dg/ztDk
	/vqRPdiDrc31TS295Lz73Vu5k8Bh9qwpN7iW1uChW9Wfg+C/g72egE+GaCLaKPdZvRkxDfh6gtY
	LyAds4OdDzmq1Jvsov59wm2hX0zYH/9fSHgb2o6fzOAd1xe424HGQuiFADO1XnCD6Oqif41R8nF
	2MLwFVn2oD90Yf4OFObhueDb1vXuyBmY0s8E2Edh/z6qQhsEsGHPkVu4w07kFY71/NkFKdM0sq+
	vvF4W4rWXsYZmjHcGpvb9A8uvRrwIOBl3gs23n3MXO59xF08Zh2EQ+WDEYcljquyr62/On4g6Ok
	mjfG5WO2Ck4Zmj0KwdUzlZDh/LDBtIIz3KR0vhgn4Loci1dkyxwrDoZaz22rVNrG9L2CbeT1Cvq
	pEDy5UY8U=
X-Google-Smtp-Source: AGHT+IFcyHFcbzgQMQ366fdi1lF7AzQiOaOUKjLiAJa9T6IxReaoQRfsmCjDR6l7iAESo+0k6Yda1A==
X-Received: by 2002:a05:6870:6586:b0:30b:7d90:1061 with SMTP id 586e51a60fabf-35ebed296c1mr5766812fac.4.1758917459275;
        Fri, 26 Sep 2025 13:10:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:7871:889:3150:8454? ([2600:8803:e7e4:1d00:7871:889:3150:8454])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-363a3f3610bsm1640539fac.14.2025.09.26.13.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 13:10:58 -0700 (PDT)
Message-ID: <c8c6390d-825f-48bb-9aba-7d91ecf1e3ee@baylibre.com>
Date: Fri, 26 Sep 2025 15:10:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] spi: offload: Add offset parameter
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
 <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 2:01 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay. While at it, add some documentation to offload periodic trigger
> parameters.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


