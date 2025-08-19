Return-Path: <linux-iio+bounces-22991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C96B2C7CA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA503BD263
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5F27FD78;
	Tue, 19 Aug 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EexxtQRT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098027F18F
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615330; cv=none; b=qnw6sgJ+tGm9s8MfoHahZ2vf+eX2LCp2W9NDbjrgP6YokH+kM90+MU55PTy80KQzG/sPyFlyyW3zNyFiQyQCOtDkKhpYEc2bv5tOchTUe1YudXwGOkfKANgJcuqlVL/HWBcUXmysq/u4NP2sMPTEIYvpBNEV+7joPgknJPSKyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615330; c=relaxed/simple;
	bh=rZi4e4mNoKCg92RzZ+sQYlS+mPo/zTE1yqe24FKrvK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMmliK873e7hAHUe22fp7MhtRra/JKvmlXY/2kCWfHAYjalp6CG8zQ/KlLbkfsuXVdaHi+W9H95LsjpDoCWXBkehhdVK/5W9WFaTcxU70Wd7ipxR1Px/Y99s08pNQjs7ZcHDOFS13KiUENornqhJvLJx2lNBtwpxnsk27HgrQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EexxtQRT; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cceb72187so3519747fac.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615327; x=1756220127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNYz6zBor3BO7K/f9oFMseiDraaZC+D39dcIGBw1HiY=;
        b=EexxtQRTdRgOg7tJQj+7VVhGr09xhsXxjtDGqL+4Znk28dFR4nCCXAb+tWPbwK2hGf
         2qs1WfJsCyQrwCel4MYdJO3m9db5VNijRUv8+pkUf11uxoE+HAdLjPlyC6JRXwN9JtG6
         elzdDCC2q0NUyI+ogi/YuZTN6m8qnNC+GtfiDmOdN7JRlnfXFRWClkmt+9b5noNM03k6
         6zq3yDbu8hnKoPRbW60ewEWNL0b3rLkF5OV1rRQpl6mcTwQsSZT4abPf7Rd0ZLIGzw36
         MlD8610IuAK/BtoGFCFsvAmMZzMGI4aA7eygaqeIhZicEDxvQpbi+hUwC6uRN+YB/rbf
         30CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615327; x=1756220127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNYz6zBor3BO7K/f9oFMseiDraaZC+D39dcIGBw1HiY=;
        b=PR1eqDe7OjAq+od29peOArvhbSLm83txrpkuuynPDD4kHozOIScsQgbV6G7q7ZDRMc
         SWKz8mDW3V10A38JKaB1wWHELaDhLhvSt4/BxT3yawESrELvN2HnOkMrXPNs+pkWKoAK
         DPjGgBn7hygNwecqetwbYLWSWDYqFsNqOff71GIK5bE794guxTQMtfkNlHTEJYARJzje
         KIFgKohkKberx9k9ztjYH/oq2Yp7G4Nj4lHkosdUT6ouvb+mp25vaSqV5f7V10qqwNG7
         6BiMD4uVDYgP/VOQfNsqRPlqtLll48d6izSUQPw7+fSkv3sBKUuN3d8j13Q8wp+N2UCq
         nsZg==
X-Forwarded-Encrypted: i=1; AJvYcCWnLR+/o++iUsy58/N15qQXjk+tCXSa6AhMbG8ievjEyzc1ZRJrWQmPtnlKRIa1/8RH/HLfW0oWvwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtsiyMYp5PPv0GJqzUpXGoH5j8yZTBU2pF4Clpz6zCN6w5jhr
	slLJ127qB9TH35Fc1rlDJr7YOA9dR1bWwhdoFlLCRwybsqArFjk72PgOKwH/HQ+O5Jg=
X-Gm-Gg: ASbGncv62W+OA4lD+k+G+WQN3dOdXSemldkBtZu0+s2N5IbpQW4wrnurej2n6Rz7EmE
	h7Ou09Z731wdlZMuCwe4iLOZbvrX/9548G3Y1VdFpXH15nTtO9q25KEFhN5jrRbI4aL9dPATQD4
	uehAvk/m/F753kFADexv8B1nrCaUuVfF2UZ+3zN7tUXAKP4EfBeJQGeJKhITzSeXlXpeRVjWDdr
	fWF5vMkvByr2xb/ch4npyKogPOT2q8351Cr18QliCFONH3QAq+Qy3WdanynDUguMS5kAnihtVwJ
	Bp5HJllosQ/t1LyK9sAyrgm9XCrAtUAxGUEyIXIHZ4Ye0ukpYNbimfMmXOy6n+nJENLLA22+R4Z
	x1diS42ZYdkemTB0AMaAl3kM3gPmWR9qRjP57WEhTQHg7LBUnjouYt5unF+100bUZkrALGULflC
	A=
X-Google-Smtp-Source: AGHT+IGJKUtR0KedPrLrV9OrX3clCWOEdUIRgfULW86bsxgtpHLFlVjx2/761XN0QdxXUzPLpNJfSA==
X-Received: by 2002:a05:6870:709d:b0:307:b28:48e3 with SMTP id 586e51a60fabf-3110c3be255mr1744806fac.18.1755615326961;
        Tue, 19 Aug 2025 07:55:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbf8442sm3444800fac.31.2025.08.19.07.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:55:26 -0700 (PDT)
Message-ID: <01eebb48-17ba-467b-b227-96784917c50b@baylibre.com>
Date: Tue, 19 Aug 2025 09:55:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iio: mcp9600: White space and fixed width cleanup
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-4-bcollins@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818183214.380847-4-bcollins@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:32 PM, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> Make tabs consistent for register definitions and also fix width
> to byte size.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibrc.com>

