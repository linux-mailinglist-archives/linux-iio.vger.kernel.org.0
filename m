Return-Path: <linux-iio+bounces-19204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D484BAACBC4
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 19:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B5D1C2016C
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB9284688;
	Tue,  6 May 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j/IIUOf9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE61280003
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550824; cv=none; b=ssm3umm+1QiUnMgexxNCaRkwaBq5QIhF1DdEts4Ifqfm7aOBhECUKYyYy7N2fBDUwRONo7qMtcW5HtT8J6308RZy0nf2zXiK13HE7taxscdcBIeR84YIM/e2i4IJG6CE+FnsHnLWf8QM08imPPy3z4BjLgoMpjr2iHH0H3ObG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550824; c=relaxed/simple;
	bh=rMT0xdQQt+3r2qtKrekqHV+J40aw9Vry4Sfm4EzwYgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuYPEYviQ5gtXTsSwMS4O4+njzV8fqWm5QY1dhalQRzHjeqDZq3YqwVOgRKnnTCvUmeqHjJmeT3QYFCBRsHLVYi3f0j2r08q840Q8a3izevu5M2gnzQr04yyGplN8SumjhMp4dxgr+omiMcPr+ufoAj0i34ugls+buvijcCyqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j/IIUOf9; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72b0626c785so4786896a34.2
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746550820; x=1747155620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xowZWkm/X/sMYc/KKOP8flO/U1/kVq3qKvxE/W0L3a8=;
        b=j/IIUOf9BexEyHGjaJmxI6TDjN99j297fHbw/1LjK/L4DGCdJCwuqlWbr7puXKz+eF
         /LpjxztpXlEvlyfxzbBqaB5tYmEdqUFEsSZgYSsFPEnNxMOrLi6+q3MW71thgwplhCY3
         +GOtCNXDopmfazRsFnNTMXgmsdlL1VJNnOzwnI8EzIP8JC6AZSgMXNaBHOSLgfB2ji9i
         R4I3VGqvwdYEoRlwAqDxXwy4RVU9ro5zOPNuVQXkXWycEolrimS/7af/UMkuRwWtF1q9
         SykVmgqQ6gUoGMMXOwVuhYweuZPyTfPUJ/A/c9PDB32bWDAMlnW+LazPL1Q/JIKNjkYa
         L1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550820; x=1747155620;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xowZWkm/X/sMYc/KKOP8flO/U1/kVq3qKvxE/W0L3a8=;
        b=vDwyfvL5B8UOwZgxbX8huTd+tM9N/FhZueu2ziZJQRZWegvDdKbv3RC/Owtr9hT8KD
         KhgPpFxIHdoZ1kv7R7ASJJZcBXSEBc7Bmx81ZwaPONY13z9yjCa0loqW1Y55VqFoe3fF
         79LPgOBD1ak6uduGmC5iDluej/igbmDZ4aIoLOzcw3b3PonFMflQgUtFsSRwl4ao6dqG
         E0daHXuLFDsjusD2AMTabRN+WfrPGTt4MH8HA4Qz24viARGyo1VsGVb6p4PhhfXRM8cd
         ixm8d19bufSYZScras3opGNwjeoVZ4Mz3P3KUiBm0X+I1csiv/2eHugomQiw7ZtlNPAR
         8XDA==
X-Forwarded-Encrypted: i=1; AJvYcCWRc18qbi2wOrzXiOm1rGaNTlXyM9KXAtF8MWDN+xXv0GwjUXWtrjCPWN0iMrm6b1/AW7QuScyO6ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWunlP31uYDDON77cPY6AFKTuGEO2SOxF6Z7ga4pOGvvWcHTDO
	BqU4VNPeHGPVR8etba1qCt7kiH+0feVSGMYx33kDgpeX6u+d2OVRcXdgD/MMA4U=
X-Gm-Gg: ASbGncuJ+gOYz9MEsIDTXsvDKAUs5qZgTgCBRvqL0gBLNMae5gQUi98hQmZkuByQXVD
	UNoq/IlxQvOKTaHPviV90sxzyPuCkFt71Ka9f06mNH+oCnzcSzH3PPJuXXlsEF1ZO2GnswFwAQF
	E/g+2f4gaOJeBSZoZOz/5IT8BXKLp1loic2/EDTV/iH6+YcJBGjZdqzBngb+ooWRS1v64ipFa9w
	cN+mWmaPek82CKG47tzlFOlzkTa1axlUjBeiQH9F+0EJqurrAR3aMvvvDxSNKPjgvLKMaKWs6AN
	ZH3r7TZVH+sqtM5LTjYgbZja7NGL547MMFe9K5Z5K8O01FX6LNdcLMQtOBRc1QuxRlVHM2e/mXC
	xhYDS8h8b/OvsyKzZNg==
X-Google-Smtp-Source: AGHT+IFNPKlrUp5qRyXmpfL7F/ah602Gc3+IjI75vJg0+e7TbpPzmIhUUjvuHpOtYUHtumXvXy+COg==
X-Received: by 2002:a05:6830:2a9e:b0:72b:872f:efc8 with SMTP id 46e09a7af769-731eae95b90mr8191432a34.24.1746550820406;
        Tue, 06 May 2025 10:00:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5172:9f6c:997a:41ea? ([2600:8803:e7e4:1d00:5172:9f6c:997a:41ea])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d31c71aasm2135889a34.20.2025.05.06.10.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 10:00:20 -0700 (PDT)
Message-ID: <aa7f18ce-9330-4a30-93e5-85489f507a42@baylibre.com>
Date: Tue, 6 May 2025 12:00:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: backend: fix out-of-bound write
To: Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 Markus Burri <markus.burri@bbv.ch>
References: <20250505203830.5117-1-markus.burri@mt.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505203830.5117-1-markus.burri@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 3:38 PM, Markus Burri wrote:
> The buffer is set to 80 character. If a caller write more characters,
> count is truncated to the max available space in "simple_write_to_buffer".
> But afterwards a string terminator is written to the buffer at offset count
> without boundary check. The zero termination is written OUT-OF-BOUND.
> 
> Add a check that the given buffer is smaller then the buffer to prevent.
> 
> Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---
>  drivers/iio/industrialio-backend.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index a43c8d1bb3d0..4a364e038449 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
>  	ssize_t rc;
>  	int ret;
>  
> +	if (count >= sizeof(buf) - 1)

Isn't it OK if count == sizeof(buf) - 1? In other words, should be:

	if (count >= sizeof(buf))

> +		return -ENOSPC;
> +
>  	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
>  	if (rc < 0)
>  		return rc;
>  
> -	buf[count] = '\0';
> +	buf[rc] = '\0';
>  
>  	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
>  
> 
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e

It looks like we have the same or similar bugs in:

drivers/accel/ivpu/ivpu_debugfs.c
drivers/gpio/gpio-virtuser.c
drivers/iio/industrialio-core.c
drivers/iio/dac/ad3552r-hs.c

Do you plan to fix these as well? 

