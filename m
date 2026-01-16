Return-Path: <linux-iio+bounces-27891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B499D388F2
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 22:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 615D1304BB79
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47BF2FDC3D;
	Fri, 16 Jan 2026 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cp5qmBEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6627A30AACF
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600280; cv=none; b=nO6nlqzy0ZBP3+zVKTgMvXxnbLdv3GxymdjgbRNt8eae8XnphxO0DxJ8+dnCEqW9eKiWSp8dOAwVnT69h0J3zlnj2RgXWF4iBqDNyCb/SYZ6ajBR1cPEkmImNA+DES6BOkqQlwxgd+E916i1JUtZQurMnoNUct5a9Qp/YuZZuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600280; c=relaxed/simple;
	bh=1ap1WGmCdUAfeAfA1Uj3FhkOVQp+SG6/lAV/o2C7jtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5+qUqm5jWP06q2YscGluG+2O33+EIfTi7DoVyAPRYtDxvftzddh2jc5sLu1BwjXXTUk8RXYedTEiyk/x1l3dac283LGeXZjbgr9y9yo71vH5AGKW3a7fgkJOY3eZznmp5NRs7CvUjJuvqInjg91kgF5sNfJGkGsUF8aFUwfX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cp5qmBEK; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c819ca0f1so1494505b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768600278; x=1769205078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3940XG5D9uHiDmu72L1oryEY4P2+ezhQJ90ZGR7dK0=;
        b=Cp5qmBEKleds0QK8IRj/Zx/fUA/2JJC13LYJMBRQmyFqg3Gx5kZLcQcD0tLirL9iSa
         1VSf3d/JapdL6Oa0rakbHYXdLexdSrE/Q8/cGoZ/rA7xMo30ezQDtG7a/MVYaqKmaZGG
         Td/+FJZMJ9N8X83+G+mVBTWbSN8H4WUlx6buapXXMQ+OdqhHEmg6Cw9PjU8N6vsKgzoz
         fiLDRGdcbsk78tjtkVMurIzVvRT5we0xzpXOSTIOpo1CeLSyrHFRpXVCidjDKMbUGLnr
         20dLJKavFYgo1lZTr2PUBnXQr9Uqhhu756Y7ah5iJQ6bj/hPtmVGDJXuq6nRPt4fz6it
         AK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768600278; x=1769205078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3940XG5D9uHiDmu72L1oryEY4P2+ezhQJ90ZGR7dK0=;
        b=Dx2AMTACvd5lNoBZ5o0oksI8M7IfAtCoKEDtT8mPzoBHjk+FX98c12xwLeaBNxha05
         vCvs/O9wS98bnupBSVraClnmi2O2+39Cy520ZBuchfyazgw8yaOBCdfN67Lm74T7M3SA
         IMrsV10POqg8EyBmkOKbhvLLT2MjrD0/yblodeBjiAgCsl7qNaPlhI9B/nLRqFi71tVJ
         UK+l+vBb8dw5+D34PpAYnda74y2d+ijoHMXvqbHyB+QYd3A/Rk9Rb9NoffZ8jE/9GiKJ
         beS9bVwC2EEOLfIP68rSkvJ88rdRUlkKBD+f1ie/8lD+fAKb0JDN08BLSkdPybCrb7rm
         LIxA==
X-Forwarded-Encrypted: i=1; AJvYcCVQRoqZVFWYvwnck+Qw2gfU+8kKz4ef1IDxVwOz7iqdvG0Pr7SUYFWnwJDhM6X5n6XIFHI4FnfcOXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxewxuni7B6MvixbxtpZNuLjKPD9CvBSy14xffx9xoC+PqLYzZb
	ZqkwKSuCNMCuuGQ4sfNQz/vMcTKnZirdrseo11DlnOrYPX6Xv32OU+I5vJ6pUS79dC0=
X-Gm-Gg: AY/fxX7FR3iiLV1V44prXQSZZIGaVOyWBqaRQ45uNmvYiC5kefMbQbQPaVuEety9DxO
	TmqNHdcS9XbzXpECE+7i7JbntOsTsPqU0jnaU72N+DnPQ1R508vIafqngvA+XjRpVJKdxXnQc19
	v1ITB6OXw8ur29nWBxEU9cPSivFiBiLFas2YaoVER7/xM6xCEAyhF+l+DinGbBExLMirpcCHBcD
	78oooVl54q6k8dt6TGZa25foDopWpKsEXAaoRybWtk0+dcD89SI19EBpDvXw616lW96Lre3Ni6C
	36lvlnmagbA05YNeoK7caLCPXgmKNDzY3epttDblJ9bnGLHJKkxUzuPv/sfclIPwHDYJ0KL6M0v
	RVmcPwNAPlu1XeW8U1IMIRr/BZS8ED1gb8upZ21N57TlyCC1qTBTyY8z7a9QZYRt1V+VdWfg3Zv
	wYHCMufhtL/TeUJLMRnzRii3tny4AgRYCltPe0CjY4uItIejoci5Oyr8aZoJg4
X-Received: by 2002:a05:6808:1903:b0:45a:58af:fed6 with SMTP id 5614622812f47-45c880fed55mr4136737b6e.17.1768600273578;
        Fri, 16 Jan 2026 13:51:13 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:bd39:740e:f70f:5f7d? ([2600:8803:e7e4:500:bd39:740e:f70f:5f7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dbcdcd3sm2008795b6e.0.2026.01.16.13.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 13:51:13 -0800 (PST)
Message-ID: <5a953bf8-857e-4c67-be43-d60cc9b5a34c@baylibre.com>
Date: Fri, 16 Jan 2026 15:51:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <20260106-lock-impr-v3-2-1db909b192c0@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260106-lock-impr-v3-2-1db909b192c0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 2:06 AM, Kurt Borja wrote:
> In order to eventually unify the locking API, implement
> iio_device_claim_direct() fully inline, with the use of
> __iio_dev_mode_lock(), which takes care of sparse annotations.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---

...

> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index aecda887d833..3cf340208694 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -664,31 +664,47 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  
>  void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
>  void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
> -bool __iio_device_claim_direct(struct iio_dev *indio_dev);
> -void __iio_device_release_direct(struct iio_dev *indio_dev);
>  
>  /*
>   * Helper functions that allow claim and release of direct mode
>   * in a fashion that doesn't generate many false positives from sparse.
>   * Note this must remain static inline in the header so that sparse
> - * can see the __acquire() marking. Revisit when sparse supports
> - * __cond_acquires()
> + * can see the __acquires() and __releases() markings.
> + */
> +
nit: I think "attributes" would be more technically correct than
"markings" (since we are touching this).

