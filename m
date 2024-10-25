Return-Path: <linux-iio+bounces-11289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219889B07D0
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5254B1C23A48
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D800189F3F;
	Fri, 25 Oct 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="odaCxQsD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C2064EF
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869211; cv=none; b=sm4mu3b/boIGswkvwze9393Q9M/qBdDR/Geid+Wj5jDttIZoQubog8PWV6JxUhn58em1iuSzQfz12W7Jy28Mr4VYMyGUmnFctlk5PHKNhXbxO0z6iDEH4e97YLv+HHj/p+Wr1R1RSbGqnB/xKdT6jCy1W41b930U3T555mQwOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869211; c=relaxed/simple;
	bh=1glypQCh6oU6vE3DESBggtLlZR/ohpj1NVGaFmiQlHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thzKr/uhvp5y/GaSF3gba+NEPrJ6RzuOSEjKvw5ZIVplgR2Vhzctj2OgRhxX7RtUx+HruIAIpBJgqMNf8Wu+RYM++QhzB4OvtvIUNqeuqUMGm7EZ1Cw4XtYefhURl50K3uibfzpCkWhD5virCBF8jFOdEZn3jTuL0nLu2nqGCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=odaCxQsD; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-28c7f207806so987720fac.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729869206; x=1730474006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEZuHAA8jrvQYw1X6ZzndrKs/WqmOwXkzHNkdE13zG0=;
        b=odaCxQsDwxbdMnVuZIjxGUmM80BQe9Ux1St3ELFUsGz/Mb+QyH33sRoh6tCnw8FGWE
         BurqfLY1TCpftaj9qTgnHp8Try1vf/5s1rl3P/FQ69q1m69tyk5Dvs5bb5ekddrsRu8k
         y+defOTU2fdLHU5gDEHxIx+4UX/9NjVt4szsAASG9qhFC5vxUtnt/nzjqcrxPHifqxak
         l3W9efnIJNACTj2O+hvPE73mAHAIiidxsh4o3pQj5+Tj2CLn7z4a94y9xYnfAUA9spo6
         YsbxdBHntSHvSfISB7Yv5iev2p/VBo28PRS4x4ikevqHrc3bQpRR9cDxSUuZUcxmN9fP
         idnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869206; x=1730474006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEZuHAA8jrvQYw1X6ZzndrKs/WqmOwXkzHNkdE13zG0=;
        b=oSRaDG9k1371U53rp3iLOMken/27vr9NlDBgDazsWMC2n82qDpArK25R/7AOt7cByF
         EQFXDTI4CHpuiqBo9KTLk61F4qc9zXhe6fIootvmie0HbYOWYLx3/YI6tOhp8kMQGVQ7
         Bfb4Uv1LnBzaF7nlSmr9eTHe4XSO/A6YnfVrwVoNyzDqEMVs9Kdqae0NCWQqxa9iirip
         d4jLi4I2xoyVxhTFcY1j4gz1UKirL1WpEi5A0uSCmqUFkGA76LOCcaDnMWR/LDEuofIu
         e15UrMiHj5tgAjudsABpPVgbTDhGm9A76woUEEh3anHiNWVKkIMz24up2Rbzr4ekmOHY
         +6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXET+t/DJ/Fw6q6bPW2d51Ufc4urgFbK+cUKNPwGuxFp+7ZWz+VrrBTWH6O4iKlMYLfbDu9AzlTmIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzQ71QsTTu6vQMXi+AuLvv0OrJhenFtX/bIXXbGiH+C2QwvAl
	ZujzmuCakwxLD8OTAiEXugm4F2mIFBa9929BEefCeMnogip55DKS+RfiXLeXaCE=
X-Google-Smtp-Source: AGHT+IHDeF7XMCZ1zuEMXoudHjPnmgG8Mw/iYsPRBtIJJeM8OILnp8VsSaxLdCT6Ho5BEB4MGt2j+A==
X-Received: by 2002:a05:6870:e0d1:b0:288:44cd:33a2 with SMTP id 586e51a60fabf-28ccb73264fmr8369570fac.46.1729869206291;
        Fri, 25 Oct 2024 08:13:26 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29035d20dc7sm304413fac.10.2024.10.25.08.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 08:13:24 -0700 (PDT)
Message-ID: <127a3066-1ee0-43ca-8214-05c9409e0138@baylibre.com>
Date: Fri, 25 Oct 2024 10:13:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] iio: adc: ad7606: add support for AD760{7,8,9}
 parts
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com, conor.dooley@microchip.com
References: <20241025095939.271811-1-aardelean@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241025095939.271811-1-aardelean@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 4:59 AM, Alexandru Ardelean wrote:
> This change-set adds support for AD7607, AD7608 and AD7609.
> These parts are simpler parts for the AD7606x family. They support only
> HW-only mode like AD7605, but they support oversampling like the other
> AD7606x parts.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>


