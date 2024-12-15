Return-Path: <linux-iio+bounces-13526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5519F2564
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7291881E07
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C71B6CFF;
	Sun, 15 Dec 2024 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SR/eRAxY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E34154BEA
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287802; cv=none; b=ua11bvvo6O0jtLWql7UwY6/scbgp9VkyJhH6GIta264Ljp3LKaKPwgPrf+QuC54ULkjdh9/YpXJf2/eem6uEb0Dc+xwiw75zJYC4ekmWMBVbJQrgNqr0LFNNTJM+EZEA+QthS7Odhan/GYp6dwTeHOj1kt3+tlvWroJAuKPLoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287802; c=relaxed/simple;
	bh=ON/4KCkDuQqzO/Lx9kqc2FGP7cWtvxR6wJnrHvH17OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brz6oabyi1a2TK1SP8my/JMzfuuDs3z5rXahwDGG8i+L1e2zYwsZ3YkqLFiNS21tW6YNQ1vVTHt98p5jsvs0ga+rkA6wTb21mFb9FdoCC8Fc6Am4gR/Nu2AWhfCjWDLusnRtHdhGUJ6BsyxlheSWDQ48j8kO1psjAsWD9VL7hp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SR/eRAxY; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e35be77b5so611191a34.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734287797; x=1734892597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbxLQltL8Y9DUr+jXfDQjsiT43IdqwonAxv91BEtCeA=;
        b=SR/eRAxYGwh0fT4RdGNjge3qpd6764S+vbXqoDSzt5djEDz+mWnXD/NBs5gE0mkX9d
         7pfIvn5Y0/OGLYsBLmIk3oY97HPVRj64OC8ukOcit6yefo3WyADHTc7765fsQqNKKzme
         4iDdiCjdsB+WbIQLvhyKKvP0N5lLELbjw9/JmT7gLlB2imWe7+l5KHobQd4eDia2fhri
         P4YVtPxst2+xh9NfHlRug1AaeFP4dcGlYVPyJGZra8ZDNUsKTH6TtjIyWWcQdjKlp0kh
         EOplK/4lBozudHZVH3ZShOJu61VfQpBoK2Ik8SuuxMcatlGTBN+zhPkMCWhnZM/N52qI
         YsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734287797; x=1734892597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbxLQltL8Y9DUr+jXfDQjsiT43IdqwonAxv91BEtCeA=;
        b=uORWV1MGx1OgtOXKEUFoV5T8HHqmIVkSsraGjsa4o8NKpaGk89nVuVWJEpoME5gaxJ
         SCyRBC4ELvuerg3sEM4YTqAgvOfnCjnE1CNjAssxhXELSvhYf5octuW5GAI6eaXKeKo3
         yB9+eOo7eO1/Igygt2tg46QReob0pKv7JYYbdRO3lGchWPJYEpMBDJG7yKxgZ2PdFtZJ
         1Lbpa0uN51wqzQLBsC6fJdro2x74S1niI0N31zZfQLRRWoBASwLZ3Jk454xxiFqXwP/Q
         2spY9C7Nk/N+JiOUw5SllprNTDngf6q5rOInU8Qf1er6GjLz1iPg6EUSjlCtChPrsCZq
         aJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUowySFyDA1WEAxFUJuHBt28b8ljJ0tWErvLAzWABKtzjgfIjYa28n3dM74Atbz45rALNStjxUJYpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6x2ayVkNQQUUSze2KpKowWeV3uszcAN1R5wDPXT8MagxpLJRw
	bEmUR2pTxoXhGlSuAn39tiso7TPhYpXBEwm9niYPvYBcWbPj+bmCwTIPkNpN84RRKDhUkBd7c4v
	W
X-Gm-Gg: ASbGncs6xsdJTRYmJvtsfnRjFK0U//A/tsOH70BwrRnw49h7DY1CQ0Nw4WGwICdpGAD
	iK8BG55/5nqHY/AOG69csJKTh0ky5A3b1/fdzDydzFmToRtTcYkDTgJHFB7iXFKe5vqRiIAG1yZ
	CARzisifcLR3/g+Nicttz3r22pIxytpsnWT/laTpcGKsLExT+bqoh3TVa81/uwxrzdLwvNcWlws
	LyXH0btGIK1KhgZUd3/LP3XPHwM4hpi5qxNiaXOlBiwmhjPy9zMiobz5GSEtiZLQYp/HqmML976
	RDHk2LeY2wKZtvyCiQ==
X-Google-Smtp-Source: AGHT+IH0CVk3ETgfQNsDyEtOrpb/V/IgRycgelMEHafo1kPEGFRRNk7emaDCiCG3Z+jZZqWW0PiaJg==
X-Received: by 2002:a05:6830:44ab:b0:71d:5117:c07f with SMTP id 46e09a7af769-71e3b5c2c3amr6834647a34.0.1734287797195;
        Sun, 15 Dec 2024 10:36:37 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f33f80605dsm846764eaf.15.2024.12.15.10.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 10:36:35 -0800 (PST)
Message-ID: <60b1ef7f-778b-4c45-8b70-e28ad092e70b@baylibre.com>
Date: Sun, 15 Dec 2024 12:36:34 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] iio: adc: ad7944: Fix sign and use aligned_s64 for
 timestamp.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241215182912.481706-1-jic23@kernel.org>
 <20241215182912.481706-2-jic23@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241215182912.481706-2-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/24 12:28 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Whilst it doesn't actually make any difference because the code
> that fills this field doesn't care, timestamps are all signed.
> Use the new aligned_s64 instead of open coding alignment to avoid
> confusing static analyzers and give slightly cleaner code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


