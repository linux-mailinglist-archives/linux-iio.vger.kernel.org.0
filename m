Return-Path: <linux-iio+bounces-27339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC2CDA153
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 18:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7832B3027A5A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF53002A0;
	Tue, 23 Dec 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZJCIwaCt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819242F2604
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510422; cv=none; b=BdsDI0ck0AXcQHa6jVHSxuR5cCV0KJ3wjfoO5ADjIXQZgkseKVLUt6bQwKPvzOoDpfcZNM2TRs1ooQ6KBFon+ylt/vBfSAuqhD2UEpkzxZAuzNiRPlVbkSFcJOkB7x8OUZY08Kk3iWGouPv+Msi36MGqDOIUxpmfFJX7saSxTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510422; c=relaxed/simple;
	bh=BOangCFpjJ52aOedJ3g06NZWOG6nu/2RmNPphZdciHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+N+g6UoDIO/NdGOuTnUQyZWxu9mVY+0ZJGFJ8r6Y5BskPiXcCu6NXntKi1f2HQdlHce+RGUqGJ90rYG5S6/T8WbTfbmowGtM4UGS6HQlnfgyQNOnoBNglW/prEtuXFW3JgUhz29gGynENMzqLJ7dV1kwQECoZI5LJWsZ4Vrr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZJCIwaCt; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c75178c05fso1817024a34.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766510419; x=1767115219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqjoHDMp6UnfGET/5eFXYzvi2pMQ1f0rv1DZdq1dHzY=;
        b=ZJCIwaCtCX2dSWRKlMVB1kphCIgBnt7fxIXvdPXKgS35JHn8pp8VuWCG7VZkN6fG7a
         ux72e1Akd/T9etfDlpRfhWcBzF2EzL7BidNAadg/CUIDc/E/2S7iwmp+bzW9TD8QhUTF
         mjvwzKjbs7gZxaH2AXbFYfMLx0K4GxOu6dDBLJCHqy7dlHcyO0lcp++M1j3f4h0bODVa
         81A05f9dtTCBdUuS8N32oYrsutxmBhyfqgenypKNREU5JNfFp8wisQCEOBb5UM1ZPD5N
         xUvpPIHYC06KEKjAV9jkuaVnvws4vlfOkN2MaEyW2NW4SYCH1OaNe4WoUdxClSDpGdaq
         k62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766510419; x=1767115219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqjoHDMp6UnfGET/5eFXYzvi2pMQ1f0rv1DZdq1dHzY=;
        b=qALjXOMoK3RhZ+ucNjQLSag15X/nZmZvEOaK175uJITimcOoaNJoMf4gbzNrOET4VV
         jE/vMeETiZwCTl9eSTytdRIKs50uqdP4Q9XCl05C118gZwBPOOjmOJtmuF1FYE1guLlq
         mLFvrzusKkc3MVBRmaZ15osk2jCccst6YrVoGLPhnpYE8Iy5DXeoE4OP0xWauluXQJF0
         Nc3PhASQVzvbEFUMfazbb4p8ogUVOBjhmhCJRVq8Gy28MxdytV7YERyWLygR4uTcY2lu
         WRdZ7R9GMv64a5y4U+xxI3VczO8145vyvuoPXzOpNhZQVhKrX+acgXyugIHmKCKMxvIA
         vqGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsoS25DCuEm8YYOwkvGLb/RSaAZiUPKK9IA8jJm1sCRwizzhWp+BOAaq5QiSZKnIQn9cwZGq3delo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Pm9uyZEowsjzyU9V0KMsGd5R9lYTVERrTJd5l/wCQ91b8A7i
	grifhoa5Cgx26P3Ngit37JZuCm8V1wdcdYj+lNghqZEwU4csCxEFd8sgfVLukM+UdW8=
X-Gm-Gg: AY/fxX5Ey5toFKX2jRqEykrNzk+WV381SknHvNdHcWccmANsC9CsFTaNHq7cgKv/yTV
	O/PdTeDVnH3T7ogkPKbw5oMR+kNdsGbF+DH6lwjKIbjA2yfr2BPc0618fNZjSHssIJKPbrXgnNj
	U9v+rFmrzK3JFScxVqWb1Rj23s7QMItXyy0AjYWvBXDQYLpPpMsghSEUabOSnjt60fmwuwfAU6I
	OYjviOxxbGRjXFOOvewsgO9o4QdxJzhpn/sKskcqiMFwSJeFUuP5Ap8UBVdSBDgpiSwql2n7/Jf
	bqOH+paLDRG6/nheI0PvWwGVduSxmvZkLk0tt2JoTqtiB9Ts7juRt6lE1bh9oPeCQy1oKZA+esk
	yIx9DolszALfpZQDgz/s2l+dDuPQperBj27bMBzYPG/wYMRpEo0tKbQ/If8YyTJQ1Oy0ySz6XBb
	R9JPYx6LH5OYBeWEVgW/WZIwGn306zhzVLDtsI4Pgje09RD3YTddCgk25ixeiO
X-Google-Smtp-Source: AGHT+IFKHrsIz88QlZ38cn6wj+NStTXlLJClZOJ8CAkdAaG6odFkTXTwTPo7/oejo9fhLpdux+pQCA==
X-Received: by 2002:a05:6830:7199:b0:7c2:8937:5d2e with SMTP id 46e09a7af769-7cc66901f28mr7039103a34.15.1766510419383;
        Tue, 23 Dec 2025 09:20:19 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:fe29:88f1:f763:378b? ([2600:8803:e7e4:500:fe29:88f1:f763:378b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ebe98sm9756043a34.21.2025.12.23.09.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 09:20:18 -0800 (PST)
Message-ID: <6ad0f764-91f2-4946-81cd-9363ec87722a@baylibre.com>
Date: Tue, 23 Dec 2025 11:20:17 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iio: core: Refactor iio_device_claim_direct()
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
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-2-6fb47bdaaf24@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251211-lock-impr-v2-2-6fb47bdaaf24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 8:45 PM, Kurt Borja wrote:
> In order to eventually unify the locking API, implement
> iio_device_claim_direct() fully inline, with the use of
> __iio_dev_mode_lock(), which takes care of sparse annotations.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/industrialio-core.c | 44 -----------------------------------------
>  include/linux/iio/iio.h         | 38 +++++++++++++++++++++++------------
>  2 files changed, 25 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 1cce2d1ecef1..cffc6efb6617 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2201,50 +2201,6 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
>  
> -/**
> - * __iio_device_claim_direct - Keep device in direct mode
> - * @indio_dev:	the iio_dev associated with the device
> - *
> - * If the device is in direct mode it is guaranteed to stay
> - * that way until __iio_device_release_direct() is called.
> - *
> - * Use with __iio_device_release_direct().
> - *
> - * Drivers should only call iio_device_claim_direct().
> - *
> - * Returns: true on success, false on failure.
> - */
> -bool __iio_device_claim_direct(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -
> -	mutex_lock(&iio_dev_opaque->mlock);
> -
> -	if (iio_buffer_enabled(indio_dev)) {
> -		mutex_unlock(&iio_dev_opaque->mlock);
> -		return false;
> -	}
> -	return true;
> -}
> -EXPORT_SYMBOL_GPL(__iio_device_claim_direct);
> -
> -/**
> - * __iio_device_release_direct - releases claim on direct mode
> - * @indio_dev:	the iio_dev associated with the device
> - *
> - * Release the claim. Device is no longer guaranteed to stay
> - * in direct mode.
> - *
> - * Drivers should only call iio_device_release_direct().
> - *
> - * Use with __iio_device_claim_direct()
> - */
> -void __iio_device_release_direct(struct iio_dev *indio_dev)
> -{
> -	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> -}
> -EXPORT_SYMBOL_GPL(__iio_device_release_direct);
> -
>  /**
>   * iio_device_claim_buffer_mode - Keep device in buffer mode
>   * @indio_dev:	the iio_dev associated with the device
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index aecda887d833..76398dbfa5ca 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -664,30 +664,42 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  
>  void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
>  void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
> -bool __iio_device_claim_direct(struct iio_dev *indio_dev);
> -void __iio_device_release_direct(struct iio_dev *indio_dev);
>  
> -/*
> - * Helper functions that allow claim and release of direct mode
> - * in a fashion that doesn't generate many false positives from sparse.
> - * Note this must remain static inline in the header so that sparse
> - * can see the __acquire() marking. Revisit when sparse supports
> - * __cond_acquires()

I think we should leave a comment that says these functions need to stay
as static inline so that sparse works. Although I'm wondering how sparse
could still work since __acquire() and __release() are removed here. IIRC
it was a bit finicky about that.

> +/**
> + * iio_device_claim_direct - Keep device in direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * If the device is in direct mode it is guaranteed to stay
> + * that way until iio_device_release_direct() is called.
> + *
> + * Use with iio_device_release_direct().
> + *
> + * Returns: true on success, false on failure.
>   */
>  static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
>  {
> -	if (!__iio_device_claim_direct(indio_dev))
> -		return false;
> +	__iio_dev_mode_lock(indio_dev);
>  
> -	__acquire(iio_dev);
> +	if (iio_buffer_enabled(indio_dev)) {
> +		__iio_dev_mode_unlock(indio_dev);
> +		return false;
> +	}
>  
>  	return true;
>  }
>  
> +/**
> + * iio_device_release_direct - Releases claim on direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * Release the claim. Device is no longer guaranteed to stay
> + * in direct mode.
> + *
> + * Use with iio_device_claim_direct()
> + */
>  static inline void iio_device_release_direct(struct iio_dev *indio_dev)

It could make more sense to make this:

#define iio_device_release_direct __iio_dev_mode_unlock

To make it clear that the auto cleanup functions that come later
don't call iio_device_release_direct() but rather call
__iio_dev_mode_unlock() directly.

Otherwise, someone could be tempted to modify the iio_device_release_direct()
function and the changes would not have an effect when auto cleanup is used.

(Same applies to the release buffer mode function.)

>  {
> -	__iio_device_release_direct(indio_dev);
> -	__release(indio_dev);
> +	__iio_dev_mode_unlock(indio_dev);
>  }
>  
>  int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> 


