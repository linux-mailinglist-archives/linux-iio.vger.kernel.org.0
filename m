Return-Path: <linux-iio+bounces-24639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D356ABB0E95
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C54C19C0DAF
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E73043C8;
	Wed,  1 Oct 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqtFc5/R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DD3043B3
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330586; cv=none; b=Q41RgkBZjI+J5QpBc7fF5UMtbMEnroIxs/lujtaJt3JK/zCoe6RvlF+/cPTvuGgBgnPDsOfyktWx5Agc0UJQdzFMvUeBWqd+DDnHTdAyH5OiIB+Q9a/eEK+iygTuKgrYKYvu6GtS+x3ermV0IHqubrFz1TTHC5H57JjsLG4gy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330586; c=relaxed/simple;
	bh=TRyHs9IEHWxtIGR/sLNg5b2MfBrNlCsFmJrDYwg376Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3ftYs8VylOf6nG3J9NxuSU/68LRcJuhDruVo/cqXDzDhjUix8DhwxBWDtEC5b+PP6TuMO3w3DMEo/f/nwQFJZON32XJb0qJTxh3OVwX6acVJ5PB7ADkTORK6QHk7duHGgxO5fB7Su+SCN9CxzuHbDZT43ihBh6ud7GKhbE1gPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqtFc5/R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f343231fcso4306296b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Oct 2025 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759330584; x=1759935384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vMaRMjae5qhJ6T8LZr9SwTJXOKHeU5QOS0jWZvlSGc0=;
        b=kqtFc5/RzIf1TYfNGW+xOrXTjfq2CpqDVvTunN6cg5r0OD6y7Yog72C2D1PcEeTTYi
         Cxzx4xTUSmf6L0u6KWNew8SJpbdaxA3celSkacP1B616zNY0TNpuWJMoS991qw28Wp+p
         VahG4ARxRiezCOttWKjPRat2YRuJx2ji0CxZDsc5vIMWnou5yyd9rRxLy92y0xIyDojn
         yDygSIkDVAso1LUxojWk6f3pKoNwRk8cjbCO0Gv2tp8+DMth+GSBjocI/dw00V+66EkE
         V1WzPoug3PoKRwVL0Cgpd704r8M/e0Qh8P8Zsw18iXpXfdgT8S5lI0H7bfWDn3w7CbKR
         o1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759330584; x=1759935384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMaRMjae5qhJ6T8LZr9SwTJXOKHeU5QOS0jWZvlSGc0=;
        b=PO2hjie6yQEztKyCZnSkH19wF+VWk0+DXXhM3z8dHfOy+XU3aIGrtRwvfvPx0j/FX1
         JJAL0BJH5ydZ4mHFAMS34XVfdP3xPmWBAtLrGNOk1on0EPQxdeKIMoMQ1OvdX6faUlv+
         Agu0tqHXgpglSYmziAvKX1KeZv6MM3fh/DIAwjeBPykDVe//hdIFlGpL9xF9uh1mjNPk
         yXaPhOvD8nGzhpYo9S1ophvjX8nGgV1xPBT0R8m5o2NhkBKb8BnildzbdlmeznU1u0YI
         uqaTNmSwIfQBsnikM/xYSIJn31eJZRa9mrdVDR2MuEmIwSSejRljyTZ9wi91K60nMn8J
         77ww==
X-Forwarded-Encrypted: i=1; AJvYcCWP+YzFT7tGKkP9TbVJdWgjRZbidMKTVcmGuNs5nIqX0LDjGCK/tXiQXkdlNj2XAOpPl7WuvJX65lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVLc0Ax+zjhHNaveQj4FIuVGa305LWoub+W4hOQaa0WYYv3mV
	7NlybvBJUGBWM4n8i/W5NqA0UStPxJnXr7rM737b6wGDDex8A1gaBr2S
X-Gm-Gg: ASbGncvOfDtqvY835HLveJnvZGrXIuVFMxa6xN06WsPFqsA3QxQ1rIM1TwTKyQQcvXV
	LgEOKEeGHuiKwHK9P4LJlkpGrF9ToQUNgsmA+EQG6SR/rj55beQv918fneaVqo+wRi+L9JEdkf1
	dCwbfY0zf+k2WpVRQ70J/vHIMYl+Mr6wnnWVieuTgCVdg+TFiAQqDH9Dk+A4olQ34pOQTJC5VdP
	bI10Xao3osAFC8TtcnQ4rsXY+EQNy0lmS4oJlGIaYAmkzKqlZxKYBB7Y4iTWFJWCBa39DxJ2FwU
	b4F147dcTngWAmav6FuKj4Rp5ktZPhqBjaYMClwSvOoQmEV2us//fN902G9EM2nupKi2gthnvbh
	kkG5J8BhlSrrFdLjPv3yEY7oO64Ixwez/1qQB77IC4QT8YNfCHqsB6KC5iVKKBHSzxFwP5nO/Rg
	ga7+JRicHgcWqUKXqv3us=
X-Google-Smtp-Source: AGHT+IHNGQLvotx2qaUZNh8cndj8yxi/+YPCSljuENQkge2S0/2QPiWneDeKuPJFHif4je6sXsDnzA==
X-Received: by 2002:a17:90b:3511:b0:32e:51dd:46dd with SMTP id 98e67ed59e1d1-339a6e97a92mr5001609a91.16.1759330584328;
        Wed, 01 Oct 2025 07:56:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399cd8013dsm2418350a91.4.2025.10.01.07.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:56:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b0632c19-1b98-46fe-add8-d2926fd296ea@roeck-us.net>
Date: Wed, 1 Oct 2025 07:56:20 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 4/7] dt-bindings: hwmon: Move max31785
 compatibles to max31790 document
To: Eddie James <eajames@linux.ibm.com>, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 chanh@os.amperecomputing.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-5-eajames@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251001144441.310950-5-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 07:44, Eddie James wrote:
> The binding for the max31785 is the same as the max31790, so just add
> some compatible strings for the max31785 chip.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

I'll pick this and the next patch of the series after the commit window closes.

Guenter


