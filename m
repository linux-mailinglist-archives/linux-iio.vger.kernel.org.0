Return-Path: <linux-iio+bounces-13985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4398AA046E8
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D516E1888999
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC91F709F;
	Tue,  7 Jan 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tv0zbpD9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC81F63F8
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268177; cv=none; b=h+MVcKxWJghBLjTXxvwOGCDr1LqTmAtLePIPmNRn3ORXSC/HqWDrhInFFe+9oeYMrBkwPGVbeSsI3TLOEqYwlPa2DfAf21W9m09G0XL/VRXZk226ZdcGEcIDdAvYyifuaeDOcHnZzIxbZ9wmWSzRLcn9D0YMlX5bDe1Iyq9pAEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268177; c=relaxed/simple;
	bh=Y4CJRAGDnC7iGZQEiu3CAI5YM1AmUdMlOjU3LW7pIKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L26Tl8C4xiGDhncacTjDZ0lGqTOyKCM0F3O7im/5cMu1Ei+zjN/rTusaHh9b0IwEmTzQjqeJttEfCq37YnB4Lz+68qimNlXShBE5vCMnp8UquhyKEiBbRrvKsRAjhoV/10Z55Ihwgrt9EuzGeQc13sYADACaRRwjlbN2bKLDV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tv0zbpD9; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f31e8c2bfaso3400667eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736268172; x=1736872972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NS+4uyy4WSlme22Nh2XfmwM5QULvJZzhlOyoVgJVctE=;
        b=tv0zbpD9CiXJO8FzapNqnsZZdOCVNEQ5Ju7iNCjvLlnrSDAebUBL2igMd/483EFM7n
         NzsY+B+oYooPYkE3u0dtxtmm3t/gnFMUndJnM5KPSqwNy1xuhxldxHrykozegX9w+wYY
         Y7aGWxQKSXwL51bPQ8ZdnRTiZdWopltX+46Ccj3mrSFrPV1NT3Yntk/9yEIlwxAnHp3o
         bWF/X0RLmOQnPmB8tCd342cxcWeH1NhCvaDV0QYFKmOCUib8Bw+hDCR+RfLxovK9QREG
         KddyW5R8TmHsJ/riNRCZCzPDOPOgK4pLRYdZcfHINFfr07b4MsZEWIKZaWfxiqtcW1AC
         b+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268172; x=1736872972;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS+4uyy4WSlme22Nh2XfmwM5QULvJZzhlOyoVgJVctE=;
        b=JbLeTwJo2pM/MYktvN4jLopIN359N2VmgVHNiit5wVsxQFWwrCkAF3XLRMuqNwYvX1
         2xpRnyFjNiQ950L3FffTO9JCvVNa16jiLeJILqIOa4Nv/f4NmSHYqQDDYALUEWechJTJ
         KdIH8ScjQ0F6FcirIB0AmreHpnyORwSueT1rE3Mvi4ik0eRcEjNdMkweB71Nt9NauSl+
         /tvslFDDIFckB3soDzGXnTnpwzX3BWqI7dZjul/ySnE2Xm2EmkvwzXFqpGBDqxjTJ8MM
         9rbXHVunZ2ZZ+ASBz9ozVy6O0HRH8dIWcKB7+sCIvpuQxuWBxISr4sy/Aywr9VttDBJO
         UCDA==
X-Forwarded-Encrypted: i=1; AJvYcCWsrrlTQYA7IJjIefKw0C1FrEFlaeFbSQk9DHXlI6yrYPFNmSRRZrA3VD4Q/ACOqR/EnjCopc1qbbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrcpn+eDiWNoykHK4kYVAlMk3H0OiexabhFdIzNYEx+UsV909y
	pbe5aJQD6sB2LISZS5fdjsX25y66vl9NwrUILE5DSXXisZvBzM80js5PWsaRDZc=
X-Gm-Gg: ASbGnctmmBoRmgVwXwjVS8603rZCIeCcQG9O2ywX5ggeNHqLS+AneWqAPfTNnOXcocg
	4X43/NsKZpvpeUNqaSrJwTk33kaqqMQtp4dMiI1CP7CWVf/bklB9lh7RK8LTDQeTjaDcPUDT24X
	dWWr0yfIFu4nExpjHaysae6fyeLeKFe5ZYR5Ai6FBnzEKVXjEqApzx7BrzmrUPk/5vCXTgdqO6c
	lcjIGm9df/nU4ZkGnF+2z8GxEOJ9P80v+E+WDuFX4DJw0zYz/t1LCDGRmkZ+dS6scllVuemlvuC
	S1gYT+IwxYE3dUGWEA==
X-Google-Smtp-Source: AGHT+IH1ms8XV/786w6e3xRpBgzBKmkYoG3him7eUgN7qc4ku/C3O+p7mR3rZq7QoSJ1bl4nVcxtrA==
X-Received: by 2002:a05:6870:47a2:b0:29e:14ff:2f9c with SMTP id 586e51a60fabf-2a7fb0cc025mr36125756fac.18.1736268172098;
        Tue, 07 Jan 2025 08:42:52 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d745627dsm12619643fac.2.2025.01.07.08.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 08:42:50 -0800 (PST)
Message-ID: <4b6c8505-5615-4d43-9632-3fc3dca27e70@baylibre.com>
Date: Tue, 7 Jan 2025 10:42:49 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iio-next] iio: proximity: Fix use-after-free in
 hx9023s_send_cfg()
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
 jic23@kernel.org, lars@metafoo.de
Cc: jstephan@baylibre.com, yasin.lee.x@gmail.com, dan.carpenter@linaro.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250107123510.44978-1-dheeraj.linuxdev@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250107123510.44978-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 6:35 AM, Dheeraj Reddy Jonnalagadda wrote:
> Reorder the assignment of fw_size to happen before release_firmware()
> to avoid accessing the firmware structure after it's been freed.
> 
> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602791
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

