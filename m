Return-Path: <linux-iio+bounces-14102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54434A095F7
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0547C16B3F0
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9583211A02;
	Fri, 10 Jan 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ljwejIbI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AF211A03
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523560; cv=none; b=Gboj9xSmT0RiZR8owm3Oy0ZmN192VhZDKwMw3msNcRrH5C4NbEVJekSI8fzWJ17JFWGgcC0qdhzL8d5qEbV5LCVbtoz1G1Ga1o3Yf0v6ffiRUHbFTs8IlqC2HO/Chi8lUzWKvRj/7Or+euHQzIz1XPnudcHh/yqW6DrJQ8w3udk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523560; c=relaxed/simple;
	bh=LKXQLsvrgg+pxLYnYYvYVMNTayDlzyBEg/TzHXbtM0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzWFyec+wwHN4DgWVBPw1ushJA42C6RHVSL4kIBe73D+LrxK46LuYOxGsWxxv9lvbo38hvVZ4NSA3VgYPuKD0X9q1lW5aohHXpBOCSYsZjE4+8QZTObTtrdEmFHkp3C+aFS+I+lan/879bNPO+am37FKCBAw4vaSQHTp/MXSMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ljwejIbI; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a3939a758dso739758fac.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 07:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736523557; x=1737128357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TigNdxMYT9K/5BTKW5H3aos6hpeUsO7PTILu3j0uSCM=;
        b=ljwejIbIbrYaXSMK0y3LMrsjIWaoTgSuISumo0R51HVbRU5zmu8b9l3mNjO5wGDzlH
         2w3FYxgshOvSJqvIs/H6vRqVIoff41CoDn7EPaS2LpysQ38uGYnXMdbtruYgzAf3COtt
         vSvDCfn1Zuk6vPOei3fdOIb48g+ChUjZEfvp3IpdHNbdWY549rwL0qrpU2s52lH2WKNa
         v1+vwm7qWX6IfIPHPx/Z5QUdD1q/cPIbIjTcClhj0RYyDbKom2+RPxxJb6HAo/75tpJP
         8MbGGUWTRsE5XLOyH9kHQhkwiypFnlr5aUC6mzlM432PFyvlOgJdzmxVOHeh4+4wH4RL
         KHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523557; x=1737128357;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TigNdxMYT9K/5BTKW5H3aos6hpeUsO7PTILu3j0uSCM=;
        b=PrmS7mln+075/O5QAde91hJXsF2J/aQiHZmBTzEnKZjU71wYZMKU0iKyUTBXtV3YCb
         tfeW903kIxn6iKGMSgyZQYDTce7HjSyfJb4FQveY1hBZuz58fnfDmTIcsDHI0UPQ2D2y
         Db/nHhKnzwG/yuWt7PVuBoMPZumWJ7LVAyaPKvNi4QuZ+YPJ72rkx7WAUxc6BnMQfYqW
         MCnS1KnKK+50GEu3G0OIpCNWKXk7IrdoL7ZrYDoEwxdnrf+lCqX+m7JW2eKH6wSmvv7/
         bcDqVwamYPVgEiUymxY6ekefrcS/8bou7StEpwG+0mYQ1wV1h7FYYyHQY0Kho2pjN1NX
         bXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZHXZNkOsrD2mdjKF7EMDFKutizzJaNmO08sAbBNPic1/AWw3fw1wOOAPhHJzAinlNshEW9OJwGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1buuqJdF5YElVfvxO9SxIVY09HDNQDuFzX3vcTiEHx2HAb0Bw
	JHhGzWKpC68ClknYs+huNcXlFidsWGL7zKovEDY4RdqYreUQsCqCZhBflQtR/RM=
X-Gm-Gg: ASbGncvjZ5qUKWhck3JKI2+K4aQlQ7N3gBOsrE5pHx6R4HdyrJTxULPBryk/spwAXEM
	qq3Y3hKdZGsKJzOSvNyjcOFiaB5B4RmPQdobbYbi21cT8Mf3eT0UeWxrLo+vUwn0wlfM8waSWaY
	mVb6qNN4SU3pv8atqvAtwBfD7OW2oKH4CQzcmnzxuGfsmGSmHZg9mdM1PDeqKLIwHaXjBfJIjOp
	0QcS4wV0yaL0TCwwWdtLrC16vYS41N7dBMuQcVvrgwiurox2Eh/SP1PCEayiY0FZwE29mTRWtE8
	TGBeo8hr3OOZC2D14w==
X-Google-Smtp-Source: AGHT+IFgn9QvyOl8+KV04aRtcbiWSnoI1izLUxiddpaTpYkfaG4CS7wfK47kB8U3jH77vBtpvMi2VQ==
X-Received: by 2002:a05:6870:e6ca:b0:29f:a0b8:6f7f with SMTP id 586e51a60fabf-2aa066c6dc7mr5989291fac.12.1736523557127;
        Fri, 10 Jan 2025 07:39:17 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad805938a4sm966653fac.26.2025.01.10.07.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:39:16 -0800 (PST)
Message-ID: <43754ea5-1bd3-4398-ac7a-884afcbb42ee@baylibre.com>
Date: Fri, 10 Jan 2025 09:39:15 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] iio: dac: ad3552r: share model data structures
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-7-ab42aef0d840@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-7-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 4:24 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Preparing for new parts to be added also in the hs driver,
> set model data structures in ad3552r-common.c, to be accessible
> from both -hs and non hs driver.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

