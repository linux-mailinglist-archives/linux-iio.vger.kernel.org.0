Return-Path: <linux-iio+bounces-15900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386FCA3E6A1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA93AFDB9
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F40265624;
	Thu, 20 Feb 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WL38YEcX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD700264627
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087044; cv=none; b=HzFSUk1ANsaB81ICB1//PBI5nb6OusED8lrw460zI3ceCZt/6+GY8LHLkGGXYP3Xog+jSOOizsWHYR0zb3MicIyNyYBsnlU8VEAG0drDuwRW9HFzW4FRgpuQDucGRlhF+YI3eUXIe84o2JH4wSvIloGg88iEPKYz6jOgNVE7Y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087044; c=relaxed/simple;
	bh=4IlTTn57fzjGT5neuC60L+1dIx72n+UtfQr5bV/D27w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkqW+tu1grfVaeo7xqqeiBQ2+gB22BDSjuKERtgTp6iHqUQUDnlWRR2/084X6bSaCLN3W8JehCx7CB0d6rx7go2XxxuWRZjVouKfpNkohnykEVw6Fe70FeCh98HGganSIyONIVJzKBKxX5jXcaYyX588/Wy5KFmMdB3u/9nO114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WL38YEcX; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fc0c06e1deso650198eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 13:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740087041; x=1740691841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFd/eiSziPMZWtzl8X1O2OHBJVjEs/2F5XFS5d1bJIM=;
        b=WL38YEcXKPC5A0lyLdMO7ESMN3vYT7V6skgjG2buZyS3+afeDPTUZht0CCtUF1YJOk
         Oicd1U730PU7/dz7EA/HsDsY8nJGhqC0Tisr08+LNMhN3ijhaHe8A0vRudxfLW18SA2A
         +Zr5LvEhyrVhT+AHZHYphBUq+VtTqNIymabTUHMmEjQuWT83mmF7P2J1UHXez1nFb74k
         ZQnWV3bRZDXRKbBBjv5jQkkN3hcTyp/xH/sjVh+SAytNMSONraBoP1r7uwSlQafQTpZ4
         caTqmQa/GdrZRZewMS0M2xcjm60HgBhcpKJ+1fwsU88+02wN1Yi4fW1poviJqUDYPPs3
         8CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087041; x=1740691841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFd/eiSziPMZWtzl8X1O2OHBJVjEs/2F5XFS5d1bJIM=;
        b=FWrLKj8djH7Q8JCN93t3x5YXtWBG8R5KdpU+TLqxMiKbbUbtKY4KIBX5UZkQwmqFuv
         hHyCiW/MqmLKo3XjoQszR0oulUVgWWtuWveDiGUbC5CG7Qa/+5MUgM5HsY481BXCKuJr
         nbJFFuv5VfoLVwsxZWWFqn5LSqFZIrxriTLEgHuU+AaoZ8djPxyu8MswahTJSck9VjhJ
         pMuESNQoMacAWXr+5uB4mZ7Nr6BGm5ERfYFTYyhNreIFftCLoDdZPQZOWQYfZTzzglTo
         6VEfXaiDW0Cns1bCsthYUEzkMLUhO2oB8G2ZpknP/dgQOigK+mKl9lGKrYCx4lxD5YuC
         nH1g==
X-Forwarded-Encrypted: i=1; AJvYcCVV4/lmEpFNs6CZAWmhRX5ugcFjZnIVZ+nx3JWZlvDrQWbtr5Y4+bSGc36bcIRV7/IktWp2Hj4R/Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpdSYB9EPAsqn0j3SwMH72wtBz5PouTLIGR81AYl6RRHI8m0Q
	GqLnLVqKM1Cg1nPq6e+hoOpLDKO4UkRZ7lQf3UqECkFg5ZBUwWCA2mtC4QqB3N4=
X-Gm-Gg: ASbGncuXRikLs29hY1nfNKfJuDTR30yOkoyeChA0OHxQvYn7rdMvAtgvIZS47rqz+JY
	r0y+g79BOKLnBBpxs6sZWxs0Vdw39/APP0fNCsVyt8xIs/r6XLnaL861Ed4o/oIFgukiyhFBKhN
	PNFug/yGRJDtKQUhaddtTPs2gNAgN8f1P/adtgNxPbE+02UIkdBdgW+KbFl0XecjTDiUq8sqdR7
	R4fENEcCzOlNo5OfJ+i6R2RZnGXWZhrMd15TpicL5Q1omzDVo7oyhCmVD3AuMkS7eJuFsgsbO8M
	wczfl6b6OROl+n/L7PNW+ukv2uFkWdc2fpNVAqpFL0s7lALwdJlC
X-Google-Smtp-Source: AGHT+IFqWxbZFRA1rz6PvPU2XODqbR9hz70tJhTG/+Dqectftq8EDR8raj5yvtCTiONyxW3BNF1Olg==
X-Received: by 2002:a05:6820:1612:b0:5fd:50d:49e4 with SMTP id 006d021491bc7-5fd19648f16mr652519eaf.7.1740087040824;
        Thu, 20 Feb 2025 13:30:40 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fced377d94sm1875193eaf.32.2025.02.20.13.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:30:39 -0800 (PST)
Message-ID: <63e98010-860c-4d66-9cac-4f37d5e08f5c@baylibre.com>
Date: Thu, 20 Feb 2025 15:30:37 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 07/17] iio: adc: ad7768-1: remove unnecessary
 locking
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <f866c5e181e9e77f4179c44a857cebd60dce32d2.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f866c5e181e9e77f4179c44a857cebd60dce32d2.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:17 PM, Jonathan Santos wrote:
> The current locking is only preventing a triggered buffer Transfer and a
> debugfs register access from happening at the same time. If a register
> access happens during a buffered read, the action is doomed to fail anyway,
> since we need to write a magic value to exit continuous read mode.
> 
> Remove locking from the trigger handler and use
> iio_device_claim_direct_mode() instead in the register access function.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


