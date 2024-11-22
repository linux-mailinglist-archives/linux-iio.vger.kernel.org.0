Return-Path: <linux-iio+bounces-12506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD349D627D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 17:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55509281A32
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A181DF754;
	Fri, 22 Nov 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iaVEXsLx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871681DED6A
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293877; cv=none; b=tc5XMh8FUyeiLbiAO+xG6Y29J9JSJdJzt+3akTHdbUnGRusR9UiM5R7dIg2wU4irRXK/8GL0JsRDcrWVFaHqv8rMS+2Ec77CAVCvfIyxi8btwlC0VF2m2l9Q9D3c6U0s1C+UPk+fRJNcnbzucUvjP2bMBa1DfOrLcgOIT1qHVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293877; c=relaxed/simple;
	bh=OP7jIjAssaBavEB3Z5dHyvMwl1uaAest0+Ee9D9Eqmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U55frRRWmuE/2mbrolvSBOoik3gBdqhmDA7e4cR+TMxC50fpApUuZROivF1DxhzNLQ/VOWTxWjAFYLk703H10mHy8GLKpy8Jdas8xXZcowaqsse1hTNU0q1NfqzdTMK6hSWHs1mC8xY9xKP64bAK96I/lXgjil8OlBDqs5B66a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iaVEXsLx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609d8874b1so15024151cf.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 08:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732293874; x=1732898674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP7jIjAssaBavEB3Z5dHyvMwl1uaAest0+Ee9D9Eqmg=;
        b=iaVEXsLxl2PmdQJ+gu6BSRVnnD4A6FhybyCyD0MneG5ORFsphYkK83oVSlb36vuEwn
         qSphVgr4SnViY5FpNsu6FmoHn5g8HzGr2uVWeW1sYI4p+gNiaIvkA2RuTPiqf2P1egXT
         pAqUUjHEss+cSqc11r9NqtAofnRdX9tcmxfE0pPdQWTXBKCjY97L6KMnlVEk3PCcIzOh
         5fhW8HrOKKj3qgp916lENPWgFhEbNlbfUEo9I2XwAh4DHb53oxij5obY+pG5xrRydev/
         QMT0U5Pv4UUw6Bzs03Pn12U36i5RGZEpfzmsn2pJDDNMKodQcA6ZeRS+ooCN92+WnHeB
         ANNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293874; x=1732898674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OP7jIjAssaBavEB3Z5dHyvMwl1uaAest0+Ee9D9Eqmg=;
        b=UOU/p16VcLC2qZhaMC/J+FtZQgnQZfeRySd8AFk/MdWImKtnPZY5UK0G4yZBoARlHj
         qKVyiyf6qZiNGAfG3rd9VFrJKEs2KdPBqrJIZsw1CqR6nVaLyV5rxY+CQbXziZL61sQp
         4rjLJr4RcYtjLgvwcvg7r5Rf/8OkGPy6k0kA70pxyRDIV4OjL0yfKFvLVg1KJp8kl7T2
         cpic92XcmwDEiDtV+2RS6fDEKgRAY+jkLJtnPWRHMH5TQfWKFWBzw4LPcD/XnCK9BI6S
         PFN8BrVE5iF3II24xZkuwPu6L1mDIOHEJtbVbvYHSPd7xW8WGSwnHBmZcnEF9+KJJ9Kw
         vheA==
X-Forwarded-Encrypted: i=1; AJvYcCXvzKBMPXRy2WkcvWuOYdG1E43uR/A0BYIWnPoCOIMxARrDiom2XrvBn71O0acuRxKnCNRZGlyEtDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyri7toSetXdjUhrt+PuFOM1lmjmn2XBEvo8YVf7BmsKYqjj8JV
	kXm9hsZPjXBiZ1vY8WG8zxMLe6Qvtrpyev9Y/1+p9nweotMXI6+I23UyoUZkkio=
X-Gm-Gg: ASbGncvlSmmhN8neFd4VFwfjnFL9+De8B9LdQwbHCwbOZhVIb13ri2WTll9CCkoGuwx
	k5d6jQFLBN9laBizbRN6Ge6Xws8QJyCsDI8gaXmte2uMeMXlDR9uk69sfVWqGIJv/w3VeImE7Gh
	qL8g3KGQL1CbTRImN1/zERBKjDFNXg1YZFNT2WtnZC2GPdkDM9Bw0szYftRRZScRJE23NXfnTMt
	RUnzvjFTDNSs9RLAGJLslTbiRiYEPS689ZOwu/zIGGKlFaepC7lvLh8Ygwcnmi2ww4yytxUYJSF
	4DSQ+tOWpDPSq4/fJQ==
X-Google-Smtp-Source: AGHT+IHnTtl4XzgQI6Cj/5Tw1+c6s1eOk2gCKDFSgR+4tzc5/FOY9V3ehAztDo7DybxRc1Stip+1XQ==
X-Received: by 2002:a05:622a:4a86:b0:461:17e6:27ae with SMTP id d75a77b69052e-4653d5a6b9cmr53354531cf.24.1732293874474;
        Fri, 22 Nov 2024 08:44:34 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c49016bsm13278711cf.87.2024.11.22.08.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 08:44:33 -0800 (PST)
Message-ID: <12e62693-adcd-4da4-94ad-e56e98c11cc1@baylibre.com>
Date: Fri, 22 Nov 2024 11:44:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] iio: adc: ad7124: Add error reporting during
 probe
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-21-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241122113322.242875-21-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-11-22 06:33, Uwe Kleine-König wrote:
> A driver that silently fails to probe is annoying and hard to debug. So
> add messages in the error paths of the probe function.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

