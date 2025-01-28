Return-Path: <linux-iio+bounces-14659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA1A2075B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A461884653
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E58197A87;
	Tue, 28 Jan 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyZitI80"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E2156C74;
	Tue, 28 Jan 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056665; cv=none; b=NyZNxXmgfmvzukHmriAbzTH5GcYaQ+x01fYO8aAywZ1wjU2cAv+aq6VOJBcvjmumC/AkbWV3w47qQRZRFhFS4fNzWgZxGLejnxVe8si9+oXLDV0Yr1o1AfXQV7TOWXCkcsdxnMIw+H5elxWDLE7u7+hDTHjyvAraz5Nj8W+pLeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056665; c=relaxed/simple;
	bh=WwMbeJFeiqNA+J4p6yPB22ASNVhPZ6fT8Qgmji4LBfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcaJYZglGTUsbgwu04DhHN3LsYMTHMsvLD0i46zQlbSYk5FMwR9y4GO2GM7bTcw9p6TOX6jOYDgurmkZx6xA3z6ovcoOhTi5TvK4H1ROBJsSI/v0rNu6xT7oHGZmx/GlL/XD16IVWKLynhBuvYd3FA7AIZYbepqioPZNtvbrkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyZitI80; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3061f1e534bso54860371fa.1;
        Tue, 28 Jan 2025 01:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738056662; x=1738661462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KY6BpTkvdDzMGk1K8gr0Po21cTMRZ7WSrpc3Rxbsc5k=;
        b=TyZitI80fA7hQFaQIO3ftvwe3rb31EKWnDK+PWsBQ5Gt3XbNKdVzuHeqODmqGCf+Jj
         MO57xZi//vBfP4YIOM1jxeZFAH1w5AGQlq+9PXrs6B8GZMqbrb4Ms0Q8QhltlLViX/mg
         g4zcT6IGZVGF9ay1IqrSL8g97qIxgmUVbzvH67cLeLQqGlGoiUgCKHRvYqYHjk4M/Fg7
         mzD75jRMFWh6WHl/H0YGYXi1Uy8QBPcd9gxgIaGrAy9Cd0qyNTMRLg7/o6miydlTzMB5
         pnjyflGbwZSUIj/npum8tNmkg385woebUQ6mAfB6yaszAJajhfW5326qdkzwnVCY5qdc
         FCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738056662; x=1738661462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY6BpTkvdDzMGk1K8gr0Po21cTMRZ7WSrpc3Rxbsc5k=;
        b=oCIljQcxUHiE6EYB3rALrmabPAHtU0cP+mH5y1hKe0k3i846MdImp8rASHszr80hGC
         4ZuBlmX3TRcN2KhjFyNK3raAw4RB93g91zlY6wVRRsxD8JOZqpI7hePrjMoUAqpi8rMJ
         1uvbqj3Z6LDLAZgtk7nqeia0XSs9YxxwC024p71BVB6Fs9rJti90iWDbAduQvFSHZV62
         OwwKEBmhJMsX8HQ2iSP2QLsI2PJsVs8yiQtMTtkmuk9RzJuk9HZsQsjSbEsLypT7wus3
         Q0Kh4rmxtBx9BkrXWNvL58SpVNlR0N/gtZKp3s6cmd+fvy/wFRDv3zqlA6Re0dsTeBAe
         WR1A==
X-Forwarded-Encrypted: i=1; AJvYcCXmtLwBk00PvrY2uBEivpOEKNN9jRXrnX1Z2aWQ9HT8d0Cpg7HuAkjoRIQ8QkLXAGNlIdupZjPcel+gq7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6w7YZVClniqKyaZK6vkFM4Lm+di+tYau1GWOKV6/cSQWlSigf
	t42mgzlV44JKsY69bo7a3JlJt3IR+E38z2mB1r0bUZWQLmqmPBpvGO5Mmg==
X-Gm-Gg: ASbGncvyuZznB4c7W8repFSV6MZn3I/SgwUnoXNFh7urL6bZGwhdoUSI0DS60yVp+77
	NMa6BMPNFCduvF5GHaOI9Q/lRpkRgoHSBKJ1N6vDmw5inrB87AV5WZEpkhCFjkdXGxCI7FmaGho
	W4E/kAI8/8ZZESv47eLM8Qe2ZzCAwy1fDyWBO0PYrVHxA6rT7oIL6GaFUpFuFeTIs7vBXxqaKkr
	4fi7mkzyc0Ugd7zYFwMQEWKTpxegVYa9yoF0EOHC9ohZi7FC/YeKcxeiffubr5niv/iSMuy4y/9
	oTHsk8YDmw9+FPChjcGrJqtidhu3Lcam4DMEffoBGiTcedVcboWurgIZ
X-Google-Smtp-Source: AGHT+IHh5jCQQWs5OUY6wBnChPJOr8N6eZkB8jW62iXwuXuw9EVA1cwbU7o4vDrTmHaTh/t6DxoRQQ==
X-Received: by 2002:a05:651c:1990:b0:302:336a:89f7 with SMTP id 38308e7fff4ca-3072ca99b4cmr196478921fa.18.1738056661656;
        Tue, 28 Jan 2025 01:31:01 -0800 (PST)
Received: from [192.168.1.110] (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076ba6b02bsm17871611fa.12.2025.01.28.01.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 01:30:59 -0800 (PST)
Message-ID: <0f77fd18-bea7-4660-88d9-f84d776e1821@gmail.com>
Date: Tue, 28 Jan 2025 11:30:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: gts-helper: export iio_gts_get_total_gain()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
 <20250127-veml6030-scale-v3-1-4f32ba03df94@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250127-veml6030-scale-v3-1-4f32ba03df94@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Javier!

On 27/01/2025 21:30, Javier Carrasco wrote:
> Export this function in preparation for the fix in veml6030.c, where the
> total gain can be used to ease the calculation of the processed value of
> the IIO_LIGHT channel compared to acquiring the scale in NANO.
> 
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

