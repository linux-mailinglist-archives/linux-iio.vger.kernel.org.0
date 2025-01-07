Return-Path: <linux-iio+bounces-13987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD1A04735
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E911888C04
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237818A6C5;
	Tue,  7 Jan 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nabmKMQ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7218EAD
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268880; cv=none; b=S0g/o1ifdvlbKJ+x+hDv4CMIGG8mMVUi0Qkev6tt6Y8tcmhvIXWO1xcCz2Fn/uCqyCHYPk0HOsYqB30Zgv8W/XYXcmLhBaVhfJ2PCdBCq/QYyUHc8MmG3rMGAUZh+zBD+NalYwoK4+EhXUy5wqZg0iBiqqNWmHBajvEFM0SUNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268880; c=relaxed/simple;
	bh=dLgWc4KqJ81pgGk9fLIlOqeJ2PEP1t39aPLBxw2Cun8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjlmjMd4ksyjdncXgwz/kEQeuTs1st4Q0PC05uLvzmsKzRIe+8jaHp++7Q9csgL9vNSo6CK0et/PotuWQE9zuu8MYepzULT8gPZdtGfKQWLA2D5KuLPwOyNVjW3uSxWabzIFwSep+XiuhIYdIHSbAMO2ZaRfTrCaBY9f2FWsntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nabmKMQ/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e1b1767b3so8412494a34.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736268876; x=1736873676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2scHcxGrBFtgqkDoS9/WXdRczqZsWf9JpruT9p8IRw=;
        b=nabmKMQ/TlZHeZBNWWXlWFIRfPlnD+IPH04Bctih7vL7oDe6hprm1SC48Uoma5hAxd
         wqCJ57/taPVpzj5UVj+f6IAG36tIWrGRtun+AEORCAiKopgzQDn07ShBGBhF/HCr+i7F
         rh6hIGWOCkA8vJBnL0pKVyh9HKZpHCZ9INjrqr147gowkAHy7Pwtd4AmfPPVdyoPKExh
         T2pUOqQoniDjla85/Sd2bkef7/EOA/3A5HcruLgwccHb3hAkog2GY8GYcGuxQIqcCfxl
         HHn6CzV3MSRJ8cnvofOnTJeRGY/0qMNbV/rUabBlMN5HNCjF52ZrFf7/nS7KB5IJ85wu
         h1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268876; x=1736873676;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2scHcxGrBFtgqkDoS9/WXdRczqZsWf9JpruT9p8IRw=;
        b=cjXBd7UhCX2ZEGn1HAidrjAMsgjMKmJ1UP2Zioq+jlPz0yjKU/53eKeps4XSqj+rZ2
         8R7ZZmUUAKr+l71kRHzzJfZihUBu1pB6DComdqYBYi9kedWIYRoexbA0mca+Q79p5/79
         RheP2P0hpseZ8kZGc4JqZJsiG4subopN2EkNuBtAqHljycD0oulii3r6vFvAdLT7pHy5
         C+jMD8Bm5GqGKP1QeSwk8D7o7eMtHfh06w6GieHsspdkdJc42UhWXpTtjq46f8CG2tMw
         ougPogx6iWJLsMWYsnqI21UW2GCvpm5JDbt5imyzN7gJSm9C3BzukMHjtUFaxo/QgCpK
         Fokg==
X-Gm-Message-State: AOJu0Yw3kIqxoS6WSFp/ZXrhQOpHsAlK2UZGAlrdK4yAEMGMx7LNz0lQ
	g/WDUhc/Ua9744TXBcUYdP78KbcTlZcxcLPKJMuy8JRREWR7zihKC/vvDPct4EA=
X-Gm-Gg: ASbGncuAL9hCANwDBJbtiTqu8OBl8Tg5MhcXuEXzV1/cCakJKwa0bKbspeOczxO+16C
	AFoODinuh3aT/aHt7fXQ6tRnSuo5NH3a4RYC4cytrcNAvh1kvjyvIeO8DMFQT6b4Bvh1MMgzOjp
	vM07RKBdFkRiBKLPtMr9/qjybk5afNd/6B/mlgaLCk8kVWG3T6Ukwo/jRanHOU/49IA+FzMp0+n
	eUGfmVkhbhL2dFOOfQai889SetNkOHWe0ToKZCK6eXd3DKLhwMbiGT2gFr21LlKRAI1GKIDHGJS
	7mS4LuC9CojmLd7jKA==
X-Google-Smtp-Source: AGHT+IHl1wTuLkfYY9EW86dpDl4Naal0j7GzY2CsGRbhNytd/NgCUspbG28RXx8KWPjpGcxreyTdgw==
X-Received: by 2002:a05:6871:62c2:b0:29e:70c7:a3f7 with SMTP id 586e51a60fabf-2a7fb00ba8cmr26923887fac.4.1736268876500;
        Tue, 07 Jan 2025 08:54:36 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74c71edsm12483548fac.16.2025.01.07.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 08:54:35 -0800 (PST)
Message-ID: <ff6c464f-8cac-42bd-9c18-e883eaf0cf95@baylibre.com>
Date: Tue, 7 Jan 2025 10:54:33 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iio: adc: ad7380: enable regmap cache
To: Julien Stephan <jstephan@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
 <20250107-ad7380-add-alert-support-v3-2-bce10afd656b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250107-ad7380-add-alert-support-v3-2-bce10afd656b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 2:48 AM, Julien Stephan wrote:
> Enable regmap cache, to avoid useless access on spi bus.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


