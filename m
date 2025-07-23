Return-Path: <linux-iio+bounces-21925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94FBB0F836
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE00417150B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FE1F7910;
	Wed, 23 Jul 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxrdoiXh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348435D8F0;
	Wed, 23 Jul 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288471; cv=none; b=HJUU6vgL9ir7DMNTc57Sg2EfVlJUbVvZGJECGuTM/RVBhz0CuUZqBAoNHs8/BQ/lXg2pbx2tECNeTtv9FbyKYfG1ZC2CiVUMUfEhC5cpxXCmeMcO4PzEqBdRVFv5NB4GGCJbbdd5PU5NOb984uZHQ6qc8wkdsldj1yazKOzym50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288471; c=relaxed/simple;
	bh=5vajZ1YZzIMMVwkAV2mijOkRVNoBPMzy9UzxrmeAAv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWwYdayOVTK1ygFSm9FFgpIomFbhIfCsBN/9i1aAyWOVNFYOKtgD6Egf0Zsl2LQ5025og9b8/UBeUjSF1SG47qDDgAf1cUwZNTJB/PDf+uczeAUDL0r+FA5Md5GGpPSDzU86omxQN9Gb2zNJfIOD762/LoCrOnH+xAjfIryIc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxrdoiXh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso34582a91.3;
        Wed, 23 Jul 2025 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753288469; x=1753893269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9Xd/U2z4tmfw6ztPMpuZGjzJCTGLEXhl3vszeoyDjk=;
        b=BxrdoiXhgMfwiAyToflegASdVzivqd3KcMZMEOJ9Pq8SbrEQqImQb0GZ0RYhgWTlfF
         yuZXdYPNT66RxAkN/7I5IT5NAfue+5K0nwQ5RztgZkSVL8yBEwSo386xEfgPJuaH+D3b
         da3SIbabm3je14YNL2uSDrMJ6CEghZ8OQ/pgadf4Ef9Zi5gIU3wv8zJjHgtkhsE38/+Y
         Fi6xogLBrN8K3tKdU0xoXNxiMeQBpYhe1vDXmcnqNyZpmOOcsqTunVzcoL5fY2OvQpAU
         oCWTtzPF4c94v+TAmN9dk7Ko8fw1How5LS7FS6Mv8RW7oFVq4PfxkJHtbIJ312DG+zKL
         Kl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288469; x=1753893269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Xd/U2z4tmfw6ztPMpuZGjzJCTGLEXhl3vszeoyDjk=;
        b=Ho0JxSt4BWc8ETGcsyzazGaKmLfOQyldGZNanA6XtEL/GK9tCde0UY7wxoj9qrTXwm
         RWyyB/XYKTF3Z8kvcgKL1zWTchjnkzH9x4hF47nLSJZbTD5jVTvrK5zqy/3ZcVNeUf54
         v5fykB09V5ihpfNvZtZv+tUi+VnR4Go6RyBFPtOkf47RNdQHQWpc+LPSJoM43pOI65c+
         ji1leRXtKK8EZW0djPR9ka3MeNK3PtcEAJJL2sJ85Fg2Icc0HBbotqcCftlUYUBmDotH
         5DcxeHe7pU/EC+e8CnAuzxsCFnE/IxziYpDDVvcOXMrXWO26d6LgEiuexHIGqORLcmjd
         lXBg==
X-Forwarded-Encrypted: i=1; AJvYcCUP5azYJLLmEx+UkSbo74oqLDLUmQ/mjuEEhkh42q8liW2XT7QQnBi17OCoOMF9KD6jxBH6Hyj+oJR8@vger.kernel.org, AJvYcCUhOT6o2mdg2B46lB4RrsRFu9KafdkYrHbIUhiLwSkTlnZiTRqSDKCChdeQVNFB+WzZnBpU8scq@vger.kernel.org, AJvYcCV9OUEdNSGnzAL6mZZ9VKXpouVSTcE83DNDfZ8r1RnNzmRyCHqhPOyiTfMEixKKkFINwB5aHVf4QvUu@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBeH6DPH9TcNasb8uA9M1g0VXuPDElrgnRVlsPT5nVvfl7ILk
	h/RwUF19ATehW+vjOXjNslSsHDrdKwFx1s0gywBpL8uPz8fHDULdNjfr
X-Gm-Gg: ASbGncuruvMYjsX0hQI7CPNcxgDBZqrFA8FxNbtxkuY3h4VsJFmEfLTZUMK3Hr5PmCz
	D3AWeqSuG3zv4BsJHvLPCfSK9GfPnk7IUAvSfdIBvar5s424S9QyXCDnME8RJS2Dk5H0p/hXul4
	++Wpgrqi/Yejota+hQLofqCimHpXThtR9CcggZuoktkDep72YtqyD3qIQkJUFvmIR/8ajvUIM8b
	sNRK2j4YPLCsmNfUNkKQfU8LdfU+4YPihStyaiEgNU4WjPplK+9VmIGOTP2BzOmCo0/0kGQ77od
	FMiwiHEGITDcEvTmXRvuFpqsNo7Ggw0547bxnVH5Ut6J0IzUrxINBCv6OY3TwtHxcGulYWXAezm
	n6XON89NmvGMFVSc36DwzhYY3oDCIimXZ3xvvjCThX13sU4TCmA==
X-Google-Smtp-Source: AGHT+IHk3A6YXkSfq5EiTOgSQfJLMSFz6qiFQuW3inOO+ZCDhCMcwUobbP9gZ2q3IPF2326ki+C4wQ==
X-Received: by 2002:a17:90b:2b86:b0:311:e605:f60e with SMTP id 98e67ed59e1d1-31e507c19f9mr5756344a91.20.1753288469351;
        Wed, 23 Jul 2025 09:34:29 -0700 (PDT)
Received: from [192.168.1.143] ([49.207.192.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce288sm2047652a91.6.2025.07.23.09.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 09:34:29 -0700 (PDT)
Message-ID: <169f4fd7-7ea6-4764-aaca-c08cafb36762@gmail.com>
Date: Wed, 23 Jul 2025 22:04:19 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML
 docs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
 <20250723-foamy-glaring-tench-561fe2@kuoka>
Content-Language: en-US
From: Sanjay Suthar <sanjaysuthar661996@gmail.com>
In-Reply-To: <20250723-foamy-glaring-tench-561fe2@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/25 13:12, Krzysztof Kozlowski wrote:

>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Best regards,
>> Krzysztof

Thanks for the review and suggestion throughout the patch review 
process. Let me know if any action item needed from my end related to 
this patch. Best Regards, Sanjay Suthar


