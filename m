Return-Path: <linux-iio+bounces-3194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3DE86B9EE
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 22:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF32E1C22DB0
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A170038;
	Wed, 28 Feb 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBN6sDQb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCC70020
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155999; cv=none; b=cp/tv5GYwU+QzUJLR06M1kToKodKI6aUtrxjIaQLEFFhCMW+fTRTXEn+GQRkfyHMEqhBZC59zeh8hLxHbXLbssRArlouxudRjWbGcBR/dW1sZtrHEqH4LHZS+aitbzFDrd+bVBggn3BqZSWRxjryC+RoEglM5r2oPKFATxNQXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155999; c=relaxed/simple;
	bh=2QplW/PSL+l5wBlz2Fhb2MD7icGVtnf5yghrdyR7zlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmljJp7iYI3Jy6bVq/CUZ02tC1HbM3XydOEWXz4ey6+whAOLn0WTW5+vjv6l5mVE8VxinVsrei3sAAHGkdeXuTU2mkUXdCZ1GYMP5mELolEvH/M+jv0O0FjBCb7zSdYJ5eHSwF4rFYUEFnceipEPLiIY6RZm33xLIqUJU91bxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBN6sDQb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso2466495ad.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709155997; x=1709760797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLd8h0kEPBZWXG99LoXPX1j7y1LhX/a2aDKq9S3uX68=;
        b=aBN6sDQbxrowODDrLK+SjX+fBVboj16jTtc0JmnAsYlX+IxsJR//Q78Ef229q7BVeH
         k1loVZK1lowplOUnadJZy6JVfXerQXD8WmyZTW9TvRQjvfhk9aXLvNV/TdU3BT+CZ6AJ
         AA8I7rfTB85C3iJawTE0geey0WYKINkco6uXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155997; x=1709760797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLd8h0kEPBZWXG99LoXPX1j7y1LhX/a2aDKq9S3uX68=;
        b=oTwhBt2NPn65zHdojXU47nbxJthfxjzMnwqAQXPiLq7r1Nap3DOgaZxjuCEjAh1IIe
         5bgdauy3k+GEI+US12/0As9jxo/BFzDjEOmOS3uMVhWN0fNRzVC0HlfVzhNpfQfKZj28
         ZdrypC1XJZw9as3Il+AIhExV0yBQXIdec5ijyc5CdbkrLZY5yDt+vDNVTrrrKUSW2kji
         4Tbg8cArpEv0+kXXGujW+Y+ntv8FOaOmHlHIMSuhu+EBzlNhRLS7ZOdNkEZKsR788az0
         gsn/L4Pbf54ap93UxwsliiVMuWY9y3gtcpJzwpjrWhbq953rViV0quUjxYkwqJ7eCqx1
         6M0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLEVKwYv5eNZFKsPcxGYUIwX4vOiWcEum/ytPH/+zom5izX/XinWAhFrdvUDj4Frea+l7dIu37YVTaFaoiDWGhx5MDGrT3LJnk
X-Gm-Message-State: AOJu0YyNfaZFmXsEVSdD7/J4pIjOTVk+oA52x4cLsHScNU7TIvYdXPbT
	l4UTpVgQ9O0zRXstlOvwWZHm1H5ZjGmxabKBJxYhRviHCyycWFsgQh7znepurw==
X-Google-Smtp-Source: AGHT+IGO5QT2ql8Rf0ElQjy3mY7mI7ajEF2Z3zSl9mRYp9jbKdiPIbR1SfabYEntk3bTWsEUAJJ/WQ==
X-Received: by 2002:a17:902:ce02:b0:1d9:f83e:3a54 with SMTP id k2-20020a170902ce0200b001d9f83e3a54mr192671plg.64.1709155996838;
        Wed, 28 Feb 2024 13:33:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902848200b001dca997b3e3sm3729404plo.65.2024.02.28.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:33:15 -0800 (PST)
Date: Wed, 28 Feb 2024 13:33:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 1/8] overflow: Use POD in check_shl_overflow()
Message-ID: <202402281332.9B2F13570@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>

On Wed, Feb 28, 2024 at 10:41:31PM +0200, Andy Shevchenko wrote:
> The check_shl_overflow() uses u64 type that is defined in types.h.
> Instead of including that header, just switch to use POD type
> directly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

