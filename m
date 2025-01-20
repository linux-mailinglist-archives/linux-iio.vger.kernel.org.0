Return-Path: <linux-iio+bounces-14489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5CFA16581
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 03:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5801C3A3A66
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F43398E;
	Mon, 20 Jan 2025 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HA4QQHRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B092110E
	for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737341193; cv=none; b=m/DeNeL0z3woSkzONf/FKEQQa4xIN+3f5CdGb7pliRH3IXMQ9ezbqsRBynKFDWrKY/IWBW7YKAO3pcSFg/QbQ2a43yFCinmnb83zd9BGaPPI5j/0LENcX6YVIEvFPhUH0TSxr3N090FIRPFJnBlPccuZ9hSIbXAjQr9INZME8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737341193; c=relaxed/simple;
	bh=6fhS6jrdP+M3izc4tiFS+22WyRmuQafYbnTLyIItfGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPVFYUTBMyZQLaxuw7XVQuHqPQ1KILLflNK90vs8urtfckrcoSCnXvTVFe1MmZCHv3OWMFyKxvuCq0loeftJ1XNGA2+nJPZ/dDaAGQVR95qiF8XTQ9rfECaUpR7wM+qSsD7PK5TQFAfp6EuawUORNQVIN5/Rvd3GzBIr7wUVXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HA4QQHRH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b9ad0e84e6so475745285a.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jan 2025 18:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737341189; x=1737945989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fhS6jrdP+M3izc4tiFS+22WyRmuQafYbnTLyIItfGU=;
        b=HA4QQHRHFC9KgsXyegZZ5il0CLAYTB91wk0gmDzWVxuEhOPhYjcjGnHQ3nZ9NOP/Re
         EeZ6fpzvXVTvc/MgcSCs9mA73qSWy8e/Uttyydj9sPuchJGlRsnvKbQMXE5BTGMtgflZ
         6L9WzINkl9Bb2FKQRsmOfyFXsgHvF3Aki83Jq2MCPf+G06YaWyzjei8CyE7/xpJxQ5yH
         naj+CPeb54kHsNUxHLuaePw3NmKLx9wQVCX7K7pgs9g+ggMlxPafHE63voGOPAmpSr97
         r19vGtg8Z0qyVKpTeRcv3RirKKyPWZYSo0iRtgd17km0C5jI3I90O5TSzhq4cZ4qX3bj
         peqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737341189; x=1737945989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fhS6jrdP+M3izc4tiFS+22WyRmuQafYbnTLyIItfGU=;
        b=A6h5n8MSZ+UwupLAgrbeWq4ogH2IsaRxpJ+HjHNay6qhmlvZQ4gcdRnM8gnY/gXU8r
         WoNoHacyoDfOLdxAmzy9xgWU9HFPD0j5RZmvUS06fk8rPr/9YGtIvy4HTAx+aLlKENM8
         P7Cl2x6hLlpo7rRv7pen0EQQs5CsJdHoToNdqHIrw136auh2m3t44DlbYWrV1sqia649
         lH9NgAKk8W5z//mzFUDG4aQ2T2mLlzYE3NdQ9E0flvv4qut0c4op8NgGdxID40hWL9yg
         upFawxGZpv7xPn6C4pnR8xWxVbDDMoQbXcLICrLyjnEk/7UNxkWqs2K5bLdXXcg2bLGR
         h0UA==
X-Forwarded-Encrypted: i=1; AJvYcCU9jtiCUATfHxYZuLPWfTmwzQP/L1Y8iynOWt4GcLxpmFF5kw9jpq+xStVoFg4vEerHMYZOyJYeDdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEya3okiBB+rdJsNU55T2S7FQhIhpj9LAUsevQBvliiBmD2kA
	Qxucjm3fzzMi5rHsoOKvjlRaEVLFMtMnght6qpG1F2Ux3l1YVqxXEbRKSDiYg+V6pndb/yLg1jO
	cTDg=
X-Gm-Gg: ASbGnctsp83cpgx9A4yb+x7NmWAVcHs1lVqM6B9SF6Ra56qDqxXOPPBnG/3lWSms5ZW
	Lj2lrAezylZL223Zi0ZFrHB9EbsE4SYedKwg0NiGVQUNV2pLEtVxamwDczLO3f75LDPBQFqUNC3
	ymfrN4ugR53yY8TZvcGr5EQbVxNWXJKLA8gkgMxkGZXo2SpSmS6eHysftlBwKtC4JL/TzXHAjge
	YEZFpFTqqAh8ryKGDNhnG4Fle+AuPXFLVeShLHfTUAeI3I22IKVe4jHaBRR84pQDqzDKpApcRP4
	nAGTUZF2E8V2Ha1WDmolykW+nSaDs6U6hM/nfw==
X-Google-Smtp-Source: AGHT+IE2ZGER+m/DBiuD42NI+mSvyZfSA4KqOfJnyolbuLDFTgazWkkrS8GH8HYzNIJKP5VZaB/L4Q==
X-Received: by 2002:a05:620a:394d:b0:7b6:d643:59a9 with SMTP id af79cd13be357-7be631e56a9mr1776362585a.11.1737341188805;
        Sun, 19 Jan 2025 18:46:28 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614f0096sm395114685a.112.2025.01.19.18.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 18:46:27 -0800 (PST)
Message-ID: <d87f1f77-4c8b-4c49-a211-99f06ba94425@baylibre.com>
Date: Sun, 19 Jan 2025 21:46:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: ad4695: make
 ad4695_exit_conversion_mode() more robust
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
 <20241113-tgamblin-ad4695_improvements-v2-2-b6bb7c758fc4@baylibre.com>
 <20250118171236.782bcb0b@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250118171236.782bcb0b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-18 12:12, Jonathan Cameron wrote:
> On Wed, 13 Nov 2024 15:52:59 -0500
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> Ensure that conversion mode is successfully exited when the command is
>> issued by adding an extra transfer beforehand, matching the minimum CNV
>> high and low times from the AD4695 datasheet. The AD4695 has a quirk
>> where the exit command only works during a conversion, so guarantee this
>> happens by triggering a conversion in ad4695_exit_conversion_mode().
>> Then make this even more robust by ensuring that the exit command is run
>> at AD4695_REG_ACCESS_SCLK_HZ rather than the bus maximum.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Applied 2 and 3 to the testing branch of iio.git.
> I'll be rebasing that on rc1 once available.
>
> Thanks,
>
> Jonathan
Thank you!

