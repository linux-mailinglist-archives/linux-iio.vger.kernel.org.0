Return-Path: <linux-iio+bounces-22998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4793B2C811
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0603E5C319D
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7586253B43;
	Tue, 19 Aug 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bRNa3UM9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24C263C7F
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615913; cv=none; b=ge55puyw7Bgsh6NGMw4wQT0pxBlOyMEtDZIbX9puhcU9/4cGv4VP0Mh6VRywNrED5K8/cqfWHEb2xcF4wFhU4yRNiFq/8JbxAdF19emRmyH14wCrVvYltKDLHYuFTRm8gtTMANK4ss9anUQy9YVcFRotLEnYgVihRxXOh0CXedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615913; c=relaxed/simple;
	bh=dekGUVKlmgJ1LUcSokupcNE9gClnOhE48jKoE7QWVuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WpiC6b1RowmJlHuOiUu0RSE36dBzdaT9xTH8eceYq2PaKeDQcAiV6Qd/NAFt1PV3L3jhi8+J3q8POEj2vR78fyC9L86vhSnwL2jnC2A+TdePwLbqxwtiex0QXgVkUP0x1UjZ7LrAoK7+5CyFQYCJxyVvUNEBAVBr0H5pPO96TDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bRNa3UM9; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74381fc8abaso1450083a34.2
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615911; x=1756220711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMXTmk35S229MAbkPFpiW+nflBx28g6QPg9NXy1ZgtA=;
        b=bRNa3UM98+CRr7ozyuGvPCldgOJpUdgX++S6BdcrcKH5v4xlU7UfCPcIW9MJ6Zuzit
         INVeGC+Ysr7BXhsJxOKFxnVYFtMcOmRlWd2nw6j5HxP9fPIE8HZDGS7L5m++8aVbpz/X
         cAJWhs65lEKaSzluCqFGNiskTUbCb3PQ06Cj2/Zi4aHMniBJrkdRVt9pP1SJhX7Z6HHT
         4HrJorNOGFFZQKLA1kEPP5MTTESvc+lrSvVd8IOmPlFNFLJq5RRRug+pLJLspeOeS3rD
         x/IYgUdI3vNmiJm0cZhqnrQJy4QXoU0xSqsNpXnklzsvDI2ZaCkw6omL9ptfUV4bGlFj
         C20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615911; x=1756220711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMXTmk35S229MAbkPFpiW+nflBx28g6QPg9NXy1ZgtA=;
        b=dv5HGsl3VYUdCWtrVW5mBjcSAf92egudIyGdXQnrGDH1HUxHtZvL+LtLog2T33iOOc
         a90/bRw5JejRS1wkNpDSUGkOXwclmPVxN+O6UlNliGSvMHhFzMnKnCQrC1Iuldw2HWiB
         4lfbcd7eGjHaqcGgRZBGPtHPEZNBFX6bqaEOuw0tXSDGbruRZb+xNurvZ38c6PtKvpxb
         6UroMWe8d5FPvjuoezOjN/Do53f9onguHmPS297jveFrMa+UJxTKLNvR9KjkphUF/0Ok
         yce8Nal64lmelTXXm9BcVEEQNOiIQRwhNnJ8qk693QWqfGgx9g5Kxnd2F/6ndmWv0oK5
         UlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnoi1NQuJxB3lHakJ0ChNlkqqyRn1wSP2okd7DbYMPayPQGOm78tim7HC/n7QXbg7xk6nMOSQ0UpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zMjaL21VdPmHudzw+GaaESCfK6yTB/ulu9Im6zePaZue6Gka
	zQMQh18GCiaTE27Yno+6fNGEz3YiXKotwGux4y0cm54MQ4nj2WywtYBOqZt2ZoQeZD8=
X-Gm-Gg: ASbGncuV3fF2uyeCpImVbay6koFL3YgFvHViOmrHM9+zqtSTamQND4DeYeOooJB7F2r
	7FwNuXIFRKC2qho2uAGRwv4oJeOVhKlmohygQOXy9D/3Gpn110C/2etCLdj93EXEuCf1YacKtjR
	GnuI+lOj3z03beWAjjb0Th+EnVgZ0r4GzLiRWoW6ijwfHEJvmohcpTD1TcsSoy8f0xvEiWsvXXF
	CTYDfBeh3AJtbxgPozM9gg+R0dX1lPa7L1fa3RO/Qe1ZYpA5IrC1d8YH6mnZliwFgjii7HXGZlp
	cHlRJG2bNw996i5w8vLnnanNdj8k8uPDuj5GoOgwQbegdejUNDnDrNDxns/CVtJii2QbLtUUh6D
	SWzJTofGdTq9ARr4Hfb1G6RHJ2fdMY6PpRfb3vsBhjhLzDlhiNHeaRY+2LwZ7gGxHN74A5KFXGp
	E=
X-Google-Smtp-Source: AGHT+IG9hSIHsbvBSMuM+1DjW+6RnRyqFcbS8/ej/hb5PzR9IP8FISpX8gnH3Mud8EC9CDMd1mUScg==
X-Received: by 2002:a05:6830:4186:b0:73e:96e6:2540 with SMTP id 46e09a7af769-744e09dfa60mr1883876a34.2.1755615910866;
        Tue, 19 Aug 2025 08:05:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204e556sm2418288a34.43.2025.08.19.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 08:05:10 -0700 (PDT)
Message-ID: <f7815955-7e8a-4f67-b699-8b19cb38683a@baylibre.com>
Date: Tue, 19 Aug 2025 10:05:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Drop unnecessary
 dev_set_drvdata() call
To: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <aKSRpTuwA0P-ZaUS@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aKSRpTuwA0P-ZaUS@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 10:00 AM, Salah Triki wrote:
> Remove the call to `dev_set_drvdata()` and the associated comment
> since private data is never read.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2 :

Reviewed-by: David Lechner <dlechner@baylibre.com>

