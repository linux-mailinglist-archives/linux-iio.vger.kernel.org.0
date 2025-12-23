Return-Path: <linux-iio+bounces-27338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAAFCDA141
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA753015163
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECA2EB5A9;
	Tue, 23 Dec 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZOvWWfDU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE074288C20
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510384; cv=none; b=ZkWrLb4jQ0Fnz7ndaOhccncB4NFmSKbLTuB//GxiPSQiXTytZnSWllGJFLyLZuM4wSCNkFPX+yCHhN+S/jLThE5V4Z/kXEo/yT+fP5dbsUZ/RD+xw8OXbjlBj0N0BeHK010PfonN/WkyOvB/4fsXk8KWXO0cLleINDr4nh3Eseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510384; c=relaxed/simple;
	bh=NdjE4V+EEouklcSCm6BZ7mfDidB3bn7JY5Wh2M//4AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE4TVudzKvtP7J6IK3TblVcJluedm1GTs9G1cttQ1axC/uV6IjA5uQ3M3v9AluhpzthTKbZkEhu7i1kRGsk/QlVBWewZBAOFlct3KqrNdUo3cfnCWO6EP7SQiHqb7X25vSzrbMLKQR8aU5/Ctxmdvl2IgeEgzoTvRaIFhcb3/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZOvWWfDU; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65e94e128beso1323891eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 09:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766510380; x=1767115180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHzs3BD6a+q8LRnlmiLzH3xOmNz9JKocpErVtV3u+xk=;
        b=ZOvWWfDUKdgb2JtdGUO6hQVGmBTyYO4Koa+aFckFoUUTxujWgzeY2QcoKe9j7RbwV3
         TyzHvWvKUU9yfVJSmvY7tJABwJ+ARp9bViEXkFuJlg+vax6dPnByac+7/y3wnsbORAwQ
         +heZMs1VBk964Chv8uMNQ/Rui9H3gAQ5TVBWWj6rLRFOTY/M795gwZ2MSLXhYHMxBmKD
         GWqqVtsegHBC5Tzo4D/XT2jTNIAEVdNrOiXb1uQYa5ciOL3aK1CMfZd6+jAKJxIFNPE0
         6lrqE6FrsajmMQVsILbNOC+XsANsS8g8iLMJizAyjtLKki1zsc26weJv7XZhXtoo8tbu
         2sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766510380; x=1767115180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHzs3BD6a+q8LRnlmiLzH3xOmNz9JKocpErVtV3u+xk=;
        b=VzSvVWQmdQMoHEg0IFOg+QF+qc7VN+14sbr3vMKDcNbe7BXouBKsub4Y0fR7Zgpvar
         WMDg0Zi6BQeCjrP14FWSFTdDfZ9o+rOOlZsDuHEzzrcu4oChlZAY2w8EbN+5NCCQyHzp
         /MODt0R2kwIIcDjFynKQyFw+Et6quGsCLo67GrlCvz/L30p8J/FkYmxRt4IfV3dS40WL
         25iJuAE5xWAm9ZoFOfYTQJVN+G5uxT+vZVRomggm4qlhIm1oXn83b4s4yqvYA2t7IZaf
         hf1sj98+LwScYkPbqgpF7WyNlQu7MKhKJInUaGhcrY/B71z+UBod+LE4EsTfUJGH3JoC
         LGCA==
X-Forwarded-Encrypted: i=1; AJvYcCWjBeTtqRm09yrhtQc++AWm30SeycmD9MkTrXYIsLSM3/SkQzRGjYi+1o2ZsOrg1OxQ35RLkjI1yH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyermVPNyGAqx/+IKb4N/t57Dd+spSlabEa23BH+3tmgEfrGM
	RpYBNCPM43jqbJTqdfgKWsb6yFxxmRjiAE835Wltl4eyKsepz+k/HlNm+nmTfPWhNng=
X-Gm-Gg: AY/fxX4epUEcHb1qk495l1+F5dpet2e6YMG1h9AwTu3tkJsI0QXuk9xFuy3JKJ2VfAI
	Zwi9y3FOHc6yyIMSWqpt2Dfl9GlglqX2fApwSIVEKMY85XmZjD0ZFBwycQC80UJelA3juae7DmC
	zi6gSMYRVyaepAJNE/5RkXhq3woEZEohaxiEM+Nx9Gq1OhsEA5VTiicA7V859rg/QTP/U/fR0ue
	6VmJB9xuWHVxqlZ+HESB/qRp1qdS1ehCJWzcpe4RHneqZlKjW+E0rb/QwIkCpidA8ae1pcXjRJ/
	+3K5aAQR0VIQWbz9tAm/Mx2PIoTaYIGkcPdHDRo06JeXxOe41un9h0X12x/qBXqb/wKkpsmDEtP
	qSXWvxhv22y0TvkFLHwqVVOjlcBtc2zeG0Wu0i+OiTsyxR68tLNhKwb25jrfSvnqhhvfODBoGK4
	JbT0v9AD/sqW/qMN5S8ogm/4tjBYALj92dzUcBUX0Js19ENk5BVqd6i+LPaaNp
X-Google-Smtp-Source: AGHT+IFol+32ZNHnAJwQnVwVNbtJWIUgSq1V1a2nMl5MLixp2jR1RBcMRLq6HzFozpq4GGBCAoox8A==
X-Received: by 2002:a05:6820:f004:b0:659:9a49:8eea with SMTP id 006d021491bc7-65d0e3a9cb9mr7432898eaf.30.1766510379759;
        Tue, 23 Dec 2025 09:19:39 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:fe29:88f1:f763:378b? ([2600:8803:e7e4:500:fe29:88f1:f763:378b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69ba9bsm8889471eaf.10.2025.12.23.09.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 09:19:39 -0800 (PST)
Message-ID: <92d07935-b2b5-4cf3-bd45-654d77cdc23b@baylibre.com>
Date: Tue, 23 Dec 2025 11:19:38 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] iio: core: Add and export __iio_dev_mode_lock()
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
 <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 8:45 PM, Kurt Borja wrote:
> Add infallible wrappers around the internal IIO mode lock.

Not sure what "infallible" is supposed to mean in this context. Maybe
referring to autocleanup?

> 
> As mentioned in the documentation, this is not meant to be used by
> drivers, instead this will aid in the eventual addition of cleanup
> classes around conditional locks.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  3 +++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f69deefcfb6f..1cce2d1ecef1 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2171,6 +2171,36 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>  
> +/**
> + * __iio_dev_mode_lock - Locks the current IIO device mode
> + * @indio_dev: the iio_dev associated with the device
> + *
> + * If the device is either in direct or buffer mode, it's guaranteed to stay
> + * that way until __iio_dev_mode_unlock() is called.
> + *
> + * This function is not meant to be used directly by drivers to protect internal
> + * state, a driver should have it's own mechanisms for that matter.
> + *
> + * There are very few cases where a driver actually needs to lock any mode. It's
> + * *strongly* recommended to use iio_device_claim_direct() or

I wouldn't even say "strongly recommend". Just say "use these instead".

In the exceptions, likely the autocleanup version should be used as is
the case currently.

> + * iio_device_claim_buffer_mode() pairs or related helpers.
> + */
> +void __iio_dev_mode_lock(struct iio_dev *indio_dev)
> +{
> +	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
> +
> +/**
> + * __iio_dev_mode_unlock - Unlocks the current IIO device mode
> + * @indio_dev: the iio_dev associated with the device
> + */
> +void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
> +{
> +	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
> +
>  /**
>   * __iio_device_claim_direct - Keep device in direct mode
>   * @indio_dev:	the iio_dev associated with the device
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 872ebdf0dd77..aecda887d833 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -661,6 +661,9 @@ void iio_device_unregister(struct iio_dev *indio_dev);
>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  			       struct module *this_mod);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> +
> +void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
> +void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
>  bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>  void __iio_device_release_direct(struct iio_dev *indio_dev);
>  
> 


