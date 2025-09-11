Return-Path: <linux-iio+bounces-23986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D4B53434
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DE27BD142
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86BE335BD5;
	Thu, 11 Sep 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eHCBZkWZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A432ED5A
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598260; cv=none; b=P8e6LLVSRXrYIpAUwrIP91FLwOWE2i4c/tiPgJI44Es7r7/Q3+6RetuSuwQ4d4LmY4W+NBJb0K/+ZmzWDPnDwf5WMf7HYbfyBI+tg639nbLYIuQ7BSObdXAXud8LB3J2wFPGKRRK8uzDQCE+K3Z+6MCpBVMm0XkOdnG901x112A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598260; c=relaxed/simple;
	bh=BgWTKfBKwv1gdZW9TeUwhiLjN7/KNn7CoOORzE/zT2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQDaLBbhSeYl8NX46eYHP0fkoI4joFg/QKJeYXkJp5uOI/IupeBDkggQUUpgSMlr+VP2kmE6C4cuVs4CF4IKrdb+V6mCAuubyly2NXdtB6ccF1uUM2oit3mtUcTws/XsrvY4yk6Ew9d8hUsC8nfoVisQPAZfzKzU1kLls9qBE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eHCBZkWZ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6218f23ab18so97373eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757598258; x=1758203058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCstrsfwRbW6aW0tEip/c6cZxF8+5Njpu6/Zhcqq+6I=;
        b=eHCBZkWZC6S/BDWWfP+SRYOjHnppsMldn6FOlmVYHtG8R9WXAESKXHlerXsSWJgZiC
         zGG/3MC7O5SQ3te7i0ZXjMMV9t/BtDpT2I+Ru/ODm+O4IBmgXUFwurHwH8rlfLcm5maC
         RlRpXWSG6mVt+keIJrKoktz2/ivvdf2l+tcmVxLSPsGZpUtE6cdIbmnAAWS4vonQ0I4c
         31FiYIyYQTxzfGwnLaQE1XALZhTo/UX6J2Ht6/RZzGHH4W/K2jppAWto+ndxJkWnOXoN
         tTj+6P74A7GI8yigDrHBc7zcCjHVErkrG54NCV12aLDFouSQ8F3COxisgYgOQsDpwiw/
         Ckzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598258; x=1758203058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCstrsfwRbW6aW0tEip/c6cZxF8+5Njpu6/Zhcqq+6I=;
        b=mL6seXnAxd1fuGT2L0mmSK4U4ccq2kkmKD+fsaJl2yirv8ejcdVrWj2K/52Sbnej9J
         C8Mb/SaMDiCWiCWQrxdQF+NZ+pcZk7t/xlkpoBYN/oKvGR8fs2/EsB+J66zKWVh9OG7P
         LLEcE4rUl2YOKvbpl35jvL95oZM2jPyb+ltvzmJD9Z9VYVeDTEops+RRjSn/MaxPzva1
         QpolJV/JNEFjn270CmBt7bILMW0+Oe1jB7tcjtwuvEfeEVrwXPl8ZUTITJjgOwl2K/ti
         JsyvXbPfQubVtIO9vOKzjh8FY1TzWfTQl3C5lNiNsrDiyBsnV1SYCVwhxCUkv2YsXOZ+
         zamA==
X-Forwarded-Encrypted: i=1; AJvYcCUFF++BDM90yG3OzVX/63dUowOS6QW1+DhUBDn6a7xd4kotufHGR5vJdauxEaffVriql9OFwMHlJKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLUFrpZaawPd2NujpJlSb+WetLU7xxf+qGSjj9SjHE20eVyjx
	4zku1LK2k2+9AoqQB3lKjnZ7d+3uYS+dEvo0YgT9scgmNv8f1uejcZHRziPx7nyhv44=
X-Gm-Gg: ASbGncv7iEwxQD8m+sUMODoOR47zkKK7LsJWmxQN/LbWE2OhrNE+qF6+w3uu3/U3Rpu
	kjppTaYUaYEJ90s8qzCB6yKs3d/VRdMXLozP18x3qtCwiid1ZcUL8ig+Eju0k+JMBA99G2AqKwp
	/SkbvFtmNYMmAt+IAfktZiQKeLvhMPKJ5UwHaNSBp1VTgSJHzB2Eym+V4vDCRBzdED1sJtn1SKv
	tgu+tnMAQlLQkI8zEB0hJeW/leFRxUgwY8dmTumAx18FOhAbq3VoEjBDDONu8hZt07izyTLV7//
	08348CKJRvokhAIEhH0ynFOKJS6SQVr/K/F8eHD5OggTzbcSwVEJbH9z0qZ+QOfom5BS+8GJxio
	EmRyJYNteKSELLwZa4D9vYZ7ZdTHe3/IqWIe4ZsQHQpd9AO5QXi1Vimh1jhTfsbxle4YQ6XOSau
	g=
X-Google-Smtp-Source: AGHT+IEPP1d7GSlxoHGdnXD8SRk9+hawJ53fqwqLIpfGqR7eWm2LIzdvyvnCGJkNaVEwetQklDMy/g==
X-Received: by 2002:a05:6870:a982:b0:321:8f88:a3c2 with SMTP id 586e51a60fabf-32262d776d6mr10097192fac.14.1757598257793;
        Thu, 11 Sep 2025 06:44:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524bd8359esm351076a34.32.2025.09.11.06.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:44:17 -0700 (PDT)
Message-ID: <719e510e-1032-47cf-9a75-82c36de732f4@baylibre.com>
Date: Thu, 11 Sep 2025 08:44:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno S?? <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
 <a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org> <aMLCWFatVkePTxCa@sunspire>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aMLCWFatVkePTxCa@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 7:36 AM, Petre Rodan wrote:
> 

...

> Just for my curiosity, do reviewers apply the patches one by one to (a branch of)
> the tree itself or do they provide feedback directly based on the diffs?
> 

I think most reviewers are like me and only are looking at the diff in the
email. It would take too much time to apply every single patch I look at. So
I only do that in very rare cases when I have a special interest in a patch.

