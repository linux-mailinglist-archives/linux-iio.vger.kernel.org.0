Return-Path: <linux-iio+bounces-12229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ECC9C7D37
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBACDB22FFF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 20:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE4206E6D;
	Wed, 13 Nov 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u/iQyRSi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36D188736
	for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531540; cv=none; b=MWbxDurIK5uOy2O+A0+QGHMQSHuKiYO+RuE49WQTP1Z6+MHXesTj1dgFdCyM3c9lkiGXd+4nGlNECtQJ/3q3S/MbscHpgNMwL4I7FHglDB4CyOrCCf4bMjhKkhGsQzHVOneIBZRohBBFaon/4ZgUPZrxUetsCtKa58KriY4f274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531540; c=relaxed/simple;
	bh=H3iT72KAJqpp+BDqqpjohjw+E1OXEnw4DduGcnR8JhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pglm9DQMZNkYmXJixGcmi1Rx7UgHkt8DownJ1Kvms9aY4d0dGHIoDSytJVJUIjwtFaGYtNiBfZ1E4CbQZ6pPKZfQ2NjqHmIjoIk2f3YrFkSUrhujIuoDXsYc5ZsiMe78KgRKaNHTx5aPfD8GEeL4UaKetSqli+wi/2PyXAB7yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u/iQyRSi; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288c7567f5dso3329190fac.1
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 12:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731531537; x=1732136337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83v/a7/p9Dx4wQKNzWHghWcROrTy7x/lk4BkJYfzHno=;
        b=u/iQyRSiHpk9QMnd1IKpTAyFFv6GkHSVyirmoS/AgdfGHXBKlLm1CTWAVOS8e5Eslz
         jMAzRMlEVk66duU0ThGwb2AjJY7/ogL9mowcSN+7gJgiUF0iwXvWpd+S7wWWEcPFm4Yu
         o+J0viJRZHDeSorAASZBNUxTFaOEYvGX7vXmedwjjwIh/H6VgMRDyDmugiui/AOL7PC4
         Yje+ifuBHIR7bhx7iTNQXo09rW6S3KkctMjJ/8ZQ6bnhS0umO2rJiu/nPQ46m5RaiDvH
         q5rhQtAbnhG9k6uD9dMnvMAD59c7ZlSUMoL/I887CHuL/ItN+VhZS9GouMGcTnuX1f0Q
         RWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531537; x=1732136337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83v/a7/p9Dx4wQKNzWHghWcROrTy7x/lk4BkJYfzHno=;
        b=IWiW2T256pFk+tKwL9XcOYXw7tcpCrkdZIsqRR84gj+3kNTyL+6nQF3tqrtomK2uHA
         JTLyHk96zZ/D7KGQ4MDpbS8+HP6NZ372CNrk5hT880pW+/TahCTsgIgw252m3avYKkFx
         TRXwNQnkHQPGZ/Wpdx4lDIkS5Bd9lbJG4uDzNGPQepg72NX4IQZbSMVHwrijvzv4H6iX
         vBOFy1LnZSo4CkggADKRabhTAGRbqAQx2Pjy8nxQVJP2q1XL4Yukgdwbcn2x0JStkGAg
         7CcwGCHy1QIWY2aQYjhWq3sQb7E4S15JzDhhq2AicIDzrU53o2UoRdnMk1B9axwDvXCe
         OHKA==
X-Forwarded-Encrypted: i=1; AJvYcCVcC20UVF+kI0aYqHRGWrXq/qqtcoPL6Yf38ITZq61FO0IHxVU5DbxMp5uS2a3BwlBz/oBMapnB57w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eCJhcIwWDrxiCquYLOXYvvz8IHDjblx7aAyPbUEaVoely8bx
	aLSy7Y/upSXoBQLZDssEdLTaA9fYYT1rOqnLRtbGPYW5E1jPIFatQAY9x3s7PQs=
X-Google-Smtp-Source: AGHT+IH8Iu1gM3sGqu0PCCaBVFuc0424eQizn9/MUPjj53FJxCRIz3UZvZM/I4j/Wh380SZXsy1dTQ==
X-Received: by 2002:a05:6870:808c:b0:260:e713:ae8b with SMTP id 586e51a60fabf-29560129840mr15819915fac.20.1731531537135;
        Wed, 13 Nov 2024 12:58:57 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a600a2af3sm935949a34.67.2024.11.13.12.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 12:58:56 -0800 (PST)
Message-ID: <1390b66e-a9dc-42ee-a692-34a98146213f@baylibre.com>
Date: Wed, 13 Nov 2024 14:58:55 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: adc: ad4695: add new regmap callbacks, timing
 improvements
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 2:52 PM, Trevor Gamblin wrote:
> The AD4695 driver currently operates all SPI reads/writes at the speed
> appropriate for register access, rather than the max rate for the bus.
> Data reads should ideally operate at the latter speed, but making this
> change universally makes it possible for data to be corrupted during use
> and for unexpected behavior to occur on driver subsequent driver
> binds/unbinds. To solve this, introduce custom regmap bus callbacks for
> the driver that explicitly set a lower speed only for these operations.
> 
> The first patch in this series is a fix introduced after discovering the
> corresponding issue during testing of the callbacks. This is a timing
> fix that ensures the AD4695 datasheet's timing specs are met, as before
> the busy signal would sometimes fail to toggle again following the end
> of the conversion sequence. Adding an extra delay in the form of a blank
> transfer before every CS deassert in ad4695_buffer_preenable() allows
> this requirement to be met. The patch also makes similar changes in
> ad4695_read_one_sample() (while also tidying that function somewhat) to
> make sure that single reads are still functional with the regmap change.
> 
> The second patch is an improvement that increases the robustness of the
> exit message in ad4695_exit_conversion_mode(), this time by adding a
> delay before the actual exit command. This helps avoid the possibility
> that the exit message will be read as data, causing corruption on some
> buffered reads.
> 
> For additional context, see:
> https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>
Tested-by: David Lechner <dlechner@baylibre.com>


