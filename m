Return-Path: <linux-iio+bounces-19238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7D4AAE0A7
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848AE189A686
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151C28934B;
	Wed,  7 May 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n3ssBU8L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8095288C2D
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624303; cv=none; b=uDJ1eK1J1XmLzIdLXmWbQSdBznjOOnMXiTfuk+G3kwzaPYxlJaWme3rrLNvz6OB+1JG5Jbb6qSRj0J33cpUx2SXa0dddsYVuX2wNkRmkAFNPpmVqt7QpQ5Q1UP+RTwql8Ckd3khhthE3gMcv1vSdBrwMjspiq1Tf20UmdK0p4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624303; c=relaxed/simple;
	bh=JPbsFId9HOcNNCMKmW+AhN0ZtMa4qZCci/vBQwntvgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BV7V53CbdlfQ5QqC26ruxyI2PSGrLbqG6HL6gN9AwVsbK1GTy54ESGXqMwzxQ3QCzrCFKVeTlyYlev8s3pc/HWOENE12AZcf65rQtV2RDIt2EPzgWrxPCh6bhzGpBrZtMyLNZSROOU+3H3iJpZXQ+HpK3xm3z4x0pn3Hhbfq7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n3ssBU8L; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f5496972d3so1274596d6.0
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746624300; x=1747229100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mNpLvD5vQVoCYoH8klEkGMCzhi+IWNYb5PmxSoaGgQ=;
        b=n3ssBU8Lp0W2PZYdMzR65aXwQMuNo/o7Nmr/FofZQnTiNB0QemN9b7ejhPlCpAw6CR
         urmmdwInwtUS1SSOutMdT9rQzv0Wb/W+KnEu3IPgWSgUTOZhSjWYvcQJYrFOIdoAIfVE
         /A6o5TlQSdBlYR01dk2tx7mOlgVv/Y3enhWwIoFido6LCwwMNWUj0fIzYZEUN9fBSe+U
         z6Nf+m3tKuUaywbd75n6tfNoCOtjzrVlaUa0Rsp2kumV+K/XsvkHlvuTcES49QPsdEku
         ag4mHEUHEA7Iv1O/rqXVVh1VwNKkwh71ECAeMqf1ff2nCfoDI8xzmS2JaSTjSE2+0e7L
         zHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624300; x=1747229100;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mNpLvD5vQVoCYoH8klEkGMCzhi+IWNYb5PmxSoaGgQ=;
        b=O/WQzZvQnJrFX73dYp//s77NK9te0sej8PpOpBkE280SyYdR7DgSzHadYXS2ABEoun
         fgBY5KSdQIq4fs0zUeSemCwBg/Ji/+MCtNgpnAu5Ys6q4Gln/vafip/ZNu9ixbhsxegc
         z5iYUoNmVYnt7IX8h2O8k5KbQgY1JPcJzKwOzIV9Ki9fMw/M+LrbjoHkmAzb3j+ffZIq
         OSTMWGjVCskhf946dInqqnosDyqBSVyN+Ymt/B/strTdB2kobMbs7Nx4QbdxN4Cz5TOI
         e0iO06ShpZveyYP/FGcj8EEqgOboCqC9jMY4Ix7P0sSae+pETFDm9N4OMi3sh2NnvzYL
         oKYA==
X-Forwarded-Encrypted: i=1; AJvYcCVQXwNzgcVKolpt5y6LsKIcZUZ7gjkoSt4X81TpVVbyYzPGH0yzG2pOoYS5e2cPtc1TbRCYx3BJb30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6oktRiVEcvCSNGyepL9RSLQSVx9VTmJLBjAFTvqDf5ODjeo/
	ipeLeSME+CKEX6sqBa1bMN4sJrpdLBAAbV1J3s2EJAHPEXkq/O7DZMpH/Ace9jTiueTVX6QhDqI
	i
X-Gm-Gg: ASbGncuRuoiL8+8m9qdkZaHnbuDcrOc0eKNPVRfR8HmS8ULK0QIz/x/dj/BlW+mc8s1
	P0dny4V/p+vL+s7B7fq5/vGHvoGrCRW2QKBChhLjlNFyNn9FuhXhcFgFAi3Rnm1csebcfjpTEQf
	zWVZpPMYJoAmTv9HgTCC33GMwxibUfWnHYDzu5A30c9GiVnKwfgYQYIlCxxi3r2iihDWI3GzkZ3
	XDvarqwAW3QDTdZ6vj4FF4WJAG0QngPeS9f0LAh+p4INSBSdvbj/kPBTOpAWMJwa1vgJ2O0As+G
	YXJ0zbPPRnXzchLHh10xOTfIaKiz4NDYPdl0Gtvj+8Z/v5m6ntgU4E9ACwmM+Bc30OsN8nxcBDG
	1N26dDhWNbVW7XmM=
X-Google-Smtp-Source: AGHT+IETb2JbAqHKM0Nsvz8Uj3dfNmRTjWBQrhF4LcQa8hFco6QFGOGpJTMa1w7dB5MoJJ1ZXmiC3Q==
X-Received: by 2002:a05:6870:47a6:b0:296:5928:7a42 with SMTP id 586e51a60fabf-2db5bed9a3amr1627337fac.22.1746624289401;
        Wed, 07 May 2025 06:24:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3356:f6f6:bf76:a32? ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5d0666fesm585351fac.33.2025.05.07.06.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:24:49 -0700 (PDT)
Message-ID: <9457b419-6aca-412a-b0f7-4b3c7274789a@baylibre.com>
Date: Wed, 7 May 2025 08:24:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: sensor-hub: Fix typo and improve documentation
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, jikos@kernel.org,
 bentiss@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250507055745.4069933-1-chelsyratnawat2001@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250507055745.4069933-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 12:57 AM, Chelsy Ratnawat wrote:
> Includes the following corrections -
>  - Changed Measurment -> Measurement
>  - Changed clode -> close
>  - Gyro -> gyro
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


