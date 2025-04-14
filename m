Return-Path: <linux-iio+bounces-18070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282CAA877C7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 08:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9D33AFF5D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73919F13B;
	Mon, 14 Apr 2025 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enDnc/g7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2F64D;
	Mon, 14 Apr 2025 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611349; cv=none; b=MkJQTLkUREolsEfdkcq16Z1hZ7K97SKn3nicbEbtrzxhQV3Z/GuZ80CcRu4ZePg6I5tkXPrU3eyrAhYaM84C6+5+N9gR+skjuce7So/ANqGDZh9haUwgRAJVfFKbyj3vHYXRQlaRJeshClz+ckeSwR6fzBHee22HmK3pq1dm+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611349; c=relaxed/simple;
	bh=UJ/RWRlDV7zKKAfftCWu26aDq4GEVcBmM5GR1+w6ZEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lc+ObKF7ppEq8wbjRQCD9j0XwHxRy0L6El9LbK3jZPXuP1slkSE6KzDXrzxl3TZtdSCefqVuNv34mtgQf0DOL/ZnogiZpB8xliIBd36fc6AMtnOVIYQe+9jnP5nSg3AOcwxq3OdRjb/wk14yX+RjF7alxTzo8wv1bb2yLp+7dC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enDnc/g7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30ddad694c1so39048231fa.2;
        Sun, 13 Apr 2025 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744611346; x=1745216146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjcF2WJUuCtRN/KG1IsSFo708u3n1AwBwA8993WsM/M=;
        b=enDnc/g7L27PUVzNAok4LAopqnLvmfRGh13tYmXXG7yeQ3vCla5JOZk7/f6I6RsM1c
         VtAuHQkvHmG2nJH2waRBwrQScEmi1n21Qy0TyXDkAAPbQH5woY9DhatYhrT8kqhwEfZK
         bTvitlc8liqUrIVNBXWRqkULBoo3druoUaYLTR/ubVhOCCp9+00GVCVwW4jpOd9afViJ
         He4yq/afJuzzizTQO6igQLpT1ESHYaCvwTqKwpS29x6CkIrNSrvnCuR+5Zv1n0QlwopJ
         uRzwXltA7mtrrgt9LeolhMBRVgU68G7LbUYUmYtAkzv8Lv0oeY2+yrTOZCdev84iv9hU
         SC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744611346; x=1745216146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjcF2WJUuCtRN/KG1IsSFo708u3n1AwBwA8993WsM/M=;
        b=F0cByAGK+lBBvuhj2ndnL8fiYh6y4oy8/VMe+poJ2hVs4cX6+IzanA/VgFI+OHj+rj
         UbQhn38k2+SR91DES/lMHJZZX3T1ieT0tmLK6uDUG5ToGG2IDpdtp5zwasEVnW71Ju7C
         7CCdeZ+RjyIy6TnhNEIs+DL6gf+3L61ru8dgK2O6NYZIfobnOJb3sAxyyqb3vd/8dl/t
         3u+8PFeXt2IPOATt0QxZfSE8594PsX4kCNpebwlTvhd2MJ1Lu20NqVV59IFhwLB10/m0
         lApUhH3834PWDuIG48IIO6+2yDQB715KLJ3ZTvoicQyR0JuF+ToUS7bxREmy2CvwlkWc
         KphQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOzfBndqeP2ZVZIDpHAI9hZHwZosNiQnGClTMY/IKC0pOGEIhSmOFS0/ISSdCiMEvkUvMXRu+pMs+AS96q@vger.kernel.org, AJvYcCWE188yrerZ7lxlYPrf9tDcgH+Jr3t0yz2M9ZTKPzHKP8VkpZb1zo62wnA/9aUCHP0cxdtzbdGaGL2Q@vger.kernel.org, AJvYcCWfO7WTNWfaqPXge6xC3K+iu6PncPupCSEgRRYZC6RDwcLQKhNlt94OcfNuhSHQvbgrPz1HbYsTw3Gi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxas6RX4iFoBZPxfQMTsCztAk7268JBih08oZ7gBCeInEtWEg3M
	JnRb41k2N6PqlBb+3KmwlPnxlFXfDVlyRfdrQo0d6CsTZCj4TFkd
X-Gm-Gg: ASbGncuGl6gCKld12wVf29H0lhPQgHv+/UyHTnPhHSvYV4HoVUlc/BRkooWWYqG/a7Z
	0jxVr0qz+mTHUPhf27e5byYP+wOZ5YCRvXI1LmLoWSgduOnyMUDiKfdE8ZPhDxJoGGXxuJc9YSk
	lk6a/ulw7JVFzba6RPTs9n7lTghxEHBi69iRvAFuGRR5ILsee9Az6UrF3gLQFNqIIcjVM4N+/9j
	q1Kc5srVXG5ZGWAIJLczIAMvgBHphNSRDCR6KuP6upwSnbJWx4HE5J3dJkS5B8FuyZKTcGevO7m
	t50gNkzJ31b35xg4UfnPGOgki7a1QNBxHZNlFvdbAAhMe4QUOG0P4C3UUjYyQ51bOeAIPo/Jbre
	Nca2vyf3Pf6XkWT/QE8IyxA==
X-Google-Smtp-Source: AGHT+IESXdygoKOi7ura1Pv1kh/pO5a5AqCwYTwFhNnVbWVyYagbC+892+upURVMW7rDkcW0EO4DzA==
X-Received: by 2002:a2e:b8cd:0:b0:30c:111d:d7b8 with SMTP id 38308e7fff4ca-310499d56fdmr29792181fa.10.1744611345747;
        Sun, 13 Apr 2025 23:15:45 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464eb11esm15543821fa.58.2025.04.13.23.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 23:15:45 -0700 (PDT)
Message-ID: <022605b1-dd61-467d-85f3-ec60a8d1da8f@gmail.com>
Date: Mon, 14 Apr 2025 09:15:44 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: adc: ti-adc128s052: Add support for adc102s021
To: Jonathan Cameron <jic23@kernel.org>,
 Sukrut Bellary <sbellary@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408132120.836461-1-sbellary@baylibre.com>
 <20250412141047.4273a8b1@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250412141047.4273a8b1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/2025 16:10, Jonathan Cameron wrote:
> On Tue,  8 Apr 2025 06:21:18 -0700
> Sukrut Bellary <sbellary@baylibre.com> wrote:
> 
>> The patch series adds the support for adc102s021 and family.
>>
>> The family of devices are easier to
>> support since they all (no matter the resolution) seem to respond in
>> 12-bits with the LSBs set to 0 for the reduced resolution devices.
> 
> This has raced against Matti's series
> https://lore.kernel.org/linux-iio/cover.1744022065.git.mazziesaccount@gmail.com/
> Support ROHM BD79104 ADC
> 
> With hindsight that wasn't obvious from the patch series name though
> which should ideally have been
> iio: adc: ti-adc128s052: Support ROHM BD79104 ADC

Oh, right. Sorry about that!

> Please rebase on the iio testing branch on kernel.org or on top of that series.
> Technically I've only applied the first 7 patches so far, but the 8th
> should be a simple change from that v3.

I can also rebase the 8th on top of these changes if these get in before 
I rework the 8th.

> Matti, you volunteered as maintainer :)  Hence please take a look at
> this one.

Sure. Thanks for CC'ing me. I didn't have this driver included in my 
mail filters yet.

Yours,
	-- Matti


