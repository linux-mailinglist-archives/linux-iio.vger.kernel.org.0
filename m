Return-Path: <linux-iio+bounces-15735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB14A3A1BE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 16:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9D4173656
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABA26B97D;
	Tue, 18 Feb 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CdI9mH1J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D526E14C
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893937; cv=none; b=D+QtHS+WdLCxinWDmuvspDhQnP84qfbdQEdcEqVB86h35skDMz5OPe1uP4/oqKJR0T6ikWfLgyrN4Z2VlNemg+znYJWQC4LI+XcFrqtGwjbRHytJAxvTzHpY0gGGkfmLS/I/u0Nurj5ztRpP9iRLhQAp/9s5CxvWEgdeGtw2zKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893937; c=relaxed/simple;
	bh=scAw7Piub1+a52Kz5lXK3wvFczTaHetzdKfH5yMJxNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaYWXh486avTEqCvV5pB4vDEHk+KSL1tM62VJuDfYiOMdjyEzBolEe0aEy/THW7E1S0yi1UvGWgYC99g5NURunHztkzToMSFJ983e2ejqEpc2HGz2agIkpiuOIs+1xJ8LWEUGRgLw/RwXNzjjS29b+IvHQUBZsIt3kBgZaMVkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CdI9mH1J; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7270003d9c8so3184652a34.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739893934; x=1740498734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfkUl7PQ/UQvmIhswN2heSXMBJahdbnzbu+G3B/4ksA=;
        b=CdI9mH1J30GkMnl/IyMAf5Qn6FxCQdwV56x/Ki812yeq714c+NhEcqQ8yUHumqkgBU
         FsS2Tl3z6V4XcWIoA/iJqt6am2gat7eqAZEOzZjHH3BCnosjF4hdmiZ8X54uQRdA4R0M
         GXmagZi/A6Uajyw3a8N7CBsuug8k+1hJWoJKKM1ixboB0Wyzm1nIvCiOH0tn1qeOCx6k
         gT1OxmQ9Xckq4imxrHoqpe35kLrT3s2dkpH3ggTCiaQ1t3RVsr6rVvgweJcD41tRL0Lm
         KcPHcGGgYrMtj84Uc2Eo68/zP4R7YThlr4ySJyIJW/dmz3i+hEwxNk0g95qn4tKg1Nnc
         MMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893934; x=1740498734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfkUl7PQ/UQvmIhswN2heSXMBJahdbnzbu+G3B/4ksA=;
        b=Jbxz32V0a8G1sykhY4UlWKRY+Xh73UE/g2lFZCYNnRTAEXMiaaDp7uvKzJFoath274
         rFdk+m5DavfTFLrs9kPQ8fOqBek92Az1jtJHiNUjW+tSU+rNE/7uLCcXw47SEUbh4XzT
         Bvw7Odq2I9eAl+jSCv44qwOeTXRgxnHllr5pNpF7yHpabJua4+UEpS5tgX2xRlPio4s4
         IEbr2BDT6LJwI6W4Xg545O6mlFHAi3N9rtmeP+FUvWHJ0dS7QT/dLOHeXVt5iNyqoBpD
         pAFpCwPIVmZXeBLbdjUTSkhAG0j/BdH9L90j4pGA9e9xWCUKmzYdXDBHy4g+6BXKYkb+
         Emkw==
X-Forwarded-Encrypted: i=1; AJvYcCWQhnFilYY+ZmsJBXpYQJ2qEeMMcQGlGw39cJZFYqkghFxxTK2H5jZS6k+ScxwbUXfmd1YAZ7AEWSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtlp1eu8k9h0QxDfahxl/Ag/DDarzgMZZO9cbhdf+r8x9kGTO
	tK3Xv2nQCUm74x33nHtx5KI6amrfnWqK5KwKSG3xNplOtLX1bx3OKeGAw/7wuGQ=
X-Gm-Gg: ASbGncvn4UUuPBExTcTA9z4FmSRHkn9qfCrghyU/jbAOi1NSKWPeEmxASWsLYerFGgC
	xcw5oeE/Q8OxtsfO6QkDxwQqDrb0p46YHQ0PS+pBDU+20aaYpuKECArtdnggo+kTzcFBrf/pnjb
	6bR0QNgADprbLAwI0dY0XxeidP4JiEq+A5343HTfWbxnZIAvK2rxNz5JOxWWNEeVVFVZf+nYicr
	HZpSLKbboAvl+l3LzDxt1SCmSOmvRbcfriDrnrW7TwxDDvS5F8W/dGrasSK9fMkvjdYGJgCcpLP
	5HmxuQZi6qR2AlZS488R+1zpXPIzeWPq90kFNLIr9hvlMA6PXl6+
X-Google-Smtp-Source: AGHT+IHzDE/Gm0VrvhRVpphp5G/jXYl81sADBh+YYjFfpAbGnwtnJR1JSwkn1cCf94FYNmuyBauhZw==
X-Received: by 2002:a05:6830:2a8a:b0:727:2e61:c831 with SMTP id 46e09a7af769-7272e61ca06mr3356258a34.25.1739893933853;
        Tue, 18 Feb 2025 07:52:13 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fceba25fe7sm715688eaf.37.2025.02.18.07.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:52:12 -0800 (PST)
Message-ID: <553ed40f-f0dc-4902-9d2a-9b690fce6ff9@baylibre.com>
Date: Tue, 18 Feb 2025 09:52:10 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: backend: make sure to NULL terminate stack
 buffer
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
 <20250218-dev-iio-misc-v1-1-bf72b20a1eb8@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250218-dev-iio-misc-v1-1-bf72b20a1eb8@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 4:31 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure to NULL terminate the buffer in
> iio_backend_debugfs_write_reg() before passing it to sscanf(). It is a
> stack variable so we should not assume it will 0 initialized.
> 
> Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index d4ad36f54090204bf3bef08457d4aa55aa7c11fc..a43c8d1bb3d0f4dda4277cac94b0ea9232c071e4 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -155,10 +155,12 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
>  	ssize_t rc;
>  	int ret;
>  
> -	rc = simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf, count);
> +	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
>  	if (rc < 0)
>  		return rc;
>  
> +	buf[count] = '\0';

Does this need to be count++? Later we return count.

> +
>  	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
>  
>  	switch (ret) {
> 


