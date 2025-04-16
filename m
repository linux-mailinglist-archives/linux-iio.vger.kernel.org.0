Return-Path: <linux-iio+bounces-18180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF359A90FCA
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 01:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269A33BCBFF
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 23:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E04124BCF9;
	Wed, 16 Apr 2025 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IeQNr62N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DA24BC06
	for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744847294; cv=none; b=oJPuL2K17EeTfV9m4ON0lveX6+jValWitGzimYzEKIhSTbQPwSdOxc0Ps0ZkUO2jY1dkxW0gSozCwJcyo/DmfXhep4Gkl+PgkgZnKDrtkfHTWLwe/ajkX4KwopX9Sd+LkbB2u8N2ZUjmuFHEapmjK05utby6cvbbySdCJRtoWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744847294; c=relaxed/simple;
	bh=nl7ORVsqtDlafGG8zW3jSU0tQ7GM23fxe7sOITNWJMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrXz5VcpF+2hWcwJIMXUNdZZDKOEvRTy297x+ZNAJKsG42CXBrDP5Mz7n19pSm0uN5tM3l6mI81+EuRYRSuOhR3LoUqP8H/dq6w8Xm0xzFZImVrLGajcsagGsmiUl5Btjux1egsgiGMOVkhWH/3UsW6ATePORcQY3If7M0d53ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IeQNr62N; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3fefbbc7dd4so81604b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744847289; x=1745452089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veBMCXisQaViMak/b3QVt1P1w1Q1NYzMaAZe/nvm4BA=;
        b=IeQNr62Neo07rmfuMcOUYr9miFdAH0RJySiKEOETTuMkRPAHVqY3vAu0Cu0EkoOMxe
         6woCoQwGJWbXR2ivDNOiSlP7nedscmWUBSeo3OdSDPjlmjgY7x8VgA1nLxBo3kc9t9Nd
         yLVpgmKyYqhnOSXg2/o8whAugQTqxx4TeAhLiIUMLxqkQWxh8zgrEm1fHjtVHT93xgns
         L7LucHtIbkgpvdt5bigkEbkI0DN2kEZNprUl7LhEUYYkM3CEXehO/jjCO5C+cTMgUEkg
         d4g+0LjI8ThJE93KAx7uQyoCENdryv/lx1qzND14L6HywqN9V1UX5Di1JHWyc6kd90R8
         0F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744847289; x=1745452089;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veBMCXisQaViMak/b3QVt1P1w1Q1NYzMaAZe/nvm4BA=;
        b=V8ZCKCi5uCg3/4pA5u5VEtETaM9EXQH7RtbJWStmOMKiP/Mjs4ZMoaeSJcttKAvGnp
         XfG7I06JHZ28df91p7wWgCm+XfPYajzhNG8ZFsO++FLWiHXgkOBis5evqpmuqtp0fYlj
         wmflyTd2B3z0gD0cbjxqg2CaFQ6qO0GNqMN9dDe8J8NjacqO6jHtyXnp/7PdGE9mivoe
         nKn8q67DKloNH/W7ni7Mr7kkyG0PiZIvnSBKqHAupcicWBNrZfr4ii7i9EZhy2cBCLYE
         a9oEmxD1CRAmIVDTcrnx5ayxMPHgJixuxYaoN+iMdK9C7QOJ8XEzjZsLtMQqYVFx2afN
         5zgg==
X-Forwarded-Encrypted: i=1; AJvYcCUeWwX9XaourXSUORe1Ev4pe6Uuk53qxd3Ii4m6cf1kslGmET9a8NKlc78gWeMCvn/U4WKjlUeAQEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mWyhvcAFin9gf9ySc5jckFnIt39sivJGyneWWBZYBW937LSn
	7Vk8uAdu12AP6gALFLFiBHr5UXVnQpQwli2TgQmM2raPj2LBcp5G35FfOSM6nOQ=
X-Gm-Gg: ASbGnctJPCvmhd0v8gg+nNB6SpNw63+W/SF9tQQwkgiczArP1Yg/zXmJLEovWOx5HnK
	KbEvP16MHpHaRT/T3dNK2wkOW2nDj/49NFRMdbLyxHfI11/IkrtjSQ6t6PvJbB/8ub8nnROQLWR
	POk2qZmt45wX6TyQ0eFZMxzzEuCOFxkzUH1FaeMR7J1Xmi069rDnoPqO7JDGjqJ96b1EqO5tA5D
	bqLdKosusMTfjDt0XdI8m3+wJlsCcgRq6ScM4xM+T0BhDUXhNWvX+S4MW0h/DjG3u650c0VYqJd
	Ne4NuqCTVUSiKcnLXWKF8WCn0WyBLCJiDwQ6prckzquyI9hgwq28UF2nu7cjYGg+w6U3qv5gg2Z
	3Bhxnd3QVgRi9y/o+wA==
X-Google-Smtp-Source: AGHT+IG+KHJaPx4AqvIZBYcI/jAmSr5yHSm8ITm7TjlZC0wimXnVASLS1IQZD5Y+oFWIkt4wj6UjFQ==
X-Received: by 2002:a05:6808:210c:b0:3f7:e8de:bb10 with SMTP id 5614622812f47-400b01ed9a5mr2712710b6e.23.1744847289559;
        Wed, 16 Apr 2025 16:48:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3? ([2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40076282682sm2955107b6e.3.2025.04.16.16.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 16:48:08 -0700 (PDT)
Message-ID: <c3058c51-a956-4f49-837b-4cc0ac7ffeb0@baylibre.com>
Date: Wed, 16 Apr 2025 18:48:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] IIO: Introduce iio_push_to_buffers_with_ts()
 taking an input buffer length argument.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250413103443.2420727-1-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/25 5:34 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> v3:
> - Take the dummy driver back to doing a kzalloc()
> - Various white space changes.
> - Tag collection
> v2:
> - Add some fixes via aligned_s64 (thanks David)
> - Improve naming of new parameter and mark the error check unlikely (thanks Nuno)
> 
> When using the IIO buffers, the length of each scan element is always known to
> the IIO core (used for sizing kfifo elements etc) and depends on which channels
> are enabled. Devices often use fixed size structures or arrays.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>


