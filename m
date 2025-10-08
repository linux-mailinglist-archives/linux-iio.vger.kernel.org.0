Return-Path: <linux-iio+bounces-24858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB471BC5650
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF023B42AB
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048F28FA91;
	Wed,  8 Oct 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnfLECuv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824528DB46
	for <linux-iio@vger.kernel.org>; Wed,  8 Oct 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932643; cv=none; b=Bh3vy7DEr46uYRPPLysHGbXrRmUfCEiieVTDGoF6zuxGnXvbOkK/c2k3QqQskaQN7LjGKih9hz2H63zx32jdLzpaeb/msKQB4jtTRzgFZ3HnpTC7MZ0dgfz9TpnD9eBFn35vNJjmHDAFlBuDb/hrC2dh1KqTkhl+rPThN24+XTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932643; c=relaxed/simple;
	bh=IrnD2O8X5hB5MwrlfqWITqkYfIyt6OZiSNUedEcDcF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+kZbR0WNOe8BDpTujmZhouUd4h0nt3N8Mt7W6hbUqcy27oWBB7+hPo9zO0Jg/ChiU9ZFL1/Rwex7u0dnvhLVLklYM8sAT3wGgacBXzE0sfNvhK5aWW/te/GOWXxeHIyqzQuyqa5VUD8h1N75KRLKdi+y7YyzNx1HBU0jHdt56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnfLECuv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78118e163e5so781187b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Oct 2025 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759932641; x=1760537441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2S2XrHAuOcCepyqws2PwWFNO5GZ8yv1xZPuvvSFngn8=;
        b=AnfLECuvT+yWVI6AbqSe4Dss9iGBdYqsZRJuKfhK1b/788ZgsOLUro46ACuWveq8EA
         8hkuOre1PN6jhAEQZT6Y9fWVgFJwmtvLq+TlnpJtXhMB3CqpGMDzQ8AA1mT1RmyHUV0a
         uaH/jCfSJkdRSUsEj6UZKIhgtctwLGm8DhSD4EdltEpdCsw/qVCaBaKLRkXnO8RY96G+
         xOw6avcrFn4hooau8guHNjQ1CKxsEAMcyCTvm0tCGRiNg7jMvGibUNbKwtGyhKnVKHuT
         bmVpBxz7rLXVBSlhzihmpDawiSc/MNBbBtnAtyNPohXSfgDhXBixQnj+Tb3AYrA1kgFa
         saTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759932641; x=1760537441;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S2XrHAuOcCepyqws2PwWFNO5GZ8yv1xZPuvvSFngn8=;
        b=rT6Amt0IB+jgAyi1eSE4cz161TXvgoNT7j/j7jj91tgyTZXvGDC3ZkPYej4oBz7BCn
         jKmlt6ud8oFrayBKFGDuyC2+J2qYv1pYRBukD1Shrmc98QSSaf4h2xlTKpNbPLXx9GYb
         jtHmR2rj2IxLmfzROLTbLccjXwr2YDCX/x8Gt3kfBZINMlhpa8RF5rNxYQV2bSRD/jkV
         WC9DdkVrFZUED8rSEGLvamalHoIrLggYGGfinrVDq4TF3GI/T0W7ZvOVcv2gcTAfOEnz
         nT7Lf+UOyvcR6L6CptW7zo/ozsodhWXvI4PHQShpYCB2kyZlX8e97PxavpFK9IJoVgTF
         550w==
X-Forwarded-Encrypted: i=1; AJvYcCVo6ADnh83+E7odbxNRPc3nSj7jmGUf/gbNEkCWLwDt0AHOobmOimUiogh5zwHHhOTt/O5vI7h0u6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzebbgFmAkFe53vuo9fAqBw9blVsO8gU5HIhjvwxo0P3n2+ByRA
	RU1M/2kcQmgAjrKlyIbNEzWOdChOZch8/5gha6ET8tFzLtBB3X/opmNa
X-Gm-Gg: ASbGncv+2CvrjCMGbJzfS7xblQD4N56/JGXSBe1GmubO2GS9L/dc9ZGcQ+2A2psHh76
	KEF8xekb4BM0h37YMfjxEKOnrZIavb37SkD9rY74HGcSHRRhzslwA5cKv2YPVQn5B+4M/zPCiv3
	HGN+PaOF1DHcWTWd66efZ2waFA2k6L2oI+wtQu4aJNrfAlc8FrB3QKjMoIK8PQHRfZbqoDu85R6
	hKt7+zK5jeFSNDJwbrBDSsiZ4NguULbcwcwgS+D1ni3RXuevLBUOKuupHEc8tPh8fIYtO0fbEyg
	E95lfcNA2tYqcQUGCITjEoe4ZM3cFSKq10nz1sxmQA1NwOULM4ojekC8pah4TTc6nKC/b2Ibvze
	iuiRnnO9milUU5awA353wKPF9aKwQryC5daUuRKghX9npB6f0pGU+zHVU+p6pVuOKYPeB4JTHjT
	AHAnWXb3W8C+BtYRXP4iM=
X-Google-Smtp-Source: AGHT+IHyX5D/x1kAgnyjYEICDRw+TCkp9jPNdAwsxvT++V1jJP2L7aAzg7L5pRnzV72nWvHalFzB7w==
X-Received: by 2002:a05:6a21:6d90:b0:243:fe1e:2f95 with SMTP id adf61e73a8af0-32d96d8d186mr12375975637.6.1759932640578;
        Wed, 08 Oct 2025 07:10:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6311462b24sm7698861a12.37.2025.10.08.07.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 07:10:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <96f5443f-5b40-4d05-b350-78d55a1d841d@roeck-us.net>
Date: Wed, 8 Oct 2025 07:10:34 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] iio: temperature: Add support for NXP P3T175x
 temperature sensors
To: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, peterz@infradead.org,
 jstephan@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: jdelvare@suse.com, vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/25 03:07, Lakshay Piplani wrote:
> This patch adds support for the P3T1750/P3T1755 temperature sensors under the IIO subsystem.
> 
> P3T1750/P3T1755 support two operational modes:
> 1. Comparator Mode
> 2. Interrupt (Latched) Mode
> 
> The HWMON subsystem is more suitable for implementing drivers for comparator mode operations.
> Reason:
>    - Temperature thresholds can be polled and exposed via sysfs.
>    - Register reads do not clear status, allowing safe alarm state derivation.
>    - Matches existing drivers under hwmon.
> 
> The IIO subsystem is more suitable for implementing drivers for interrupt (latched) mode operations.
> Reason:
>    - Interrupt mode uses edge-triggered ALERT/IBI signal interrupts, which can be pushed to user space using iio_push_event.
>    - IIO’s event API (IIO_EV_TYPE_THRESH) supports timestamped rising/falling edge events.
>    - I3C IBI integration maps naturally to IIO’s event push model.
>    - No persistent alarm bits are available; so polling in HWMON may result in  missing events.
> 

This is just wrong. Interrupt support can just as well be implemented
in a hwmon driver.

Guenter


