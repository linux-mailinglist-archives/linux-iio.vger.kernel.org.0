Return-Path: <linux-iio+bounces-7770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4F9384BD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 15:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414891C20929
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312416630A;
	Sun, 21 Jul 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1fNyB/N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE26166302;
	Sun, 21 Jul 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721568920; cv=none; b=EOhd0uOyuSNyXHn5ducuO5WUawXCbHSlOg/Gi7BI2uj1XnljABeKDEUUt2VLT3JN8T6lGw+DU2ONfHK5mfFqT5hYaTDvvDR5vhecqWdPRDbgCeAI+dEMkAvs1pb+RFafFTrGMsgR6SVAzwytO17URsfF0P86pMoV6npgsp/6o9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721568920; c=relaxed/simple;
	bh=tGX2yKYZTIt3Q0s/YAylIxLVx4C+iRJs8AHqvQGziNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvmDzQtfCZ1XD1mkirAwecCL7cZq/miTeYRTVcSBKwfyswPCb6bVm3QVm7fgILBYdRx6nS0fk2RH+qUzbFGlefXsBG0AXP0XjqTOuV4x+a1+lCyGq0wrhGcZVG2Y+SeNNjDQonnyRTHKLL4FIHFbL0dHtKPcWDoa5tSZYKzUz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1fNyB/N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so22225465e9.3;
        Sun, 21 Jul 2024 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721568917; x=1722173717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGX2yKYZTIt3Q0s/YAylIxLVx4C+iRJs8AHqvQGziNY=;
        b=C1fNyB/NK9ZmQsA95C5bC+yvcx4j018IntY7vS7prETMNoNk3kXyAt3W49h6W/xswW
         vs3GjaLe5ZPMRJ01YZ4slfrQTMslcqv2aHAWus1/fSJtenDerMtkFNZsdIMMkfSGAuCJ
         Tuj6TywvOQ60qaRy5hxRx7a5LCcBYLzBGVioZLESwg3aQ1KoGqzJJVZy29VnMHcdDxWW
         E1VetEGbbW4Xldg139XtyX+sLWiDx40oZgbJahj7KCOQpK+CWq4NsrW+sEBOS2adNuE3
         fcIL5+UNQk9lElg+UABXVZU3inccEhYyZ49v/yJr3fVi1Z7y8QPO5rig56u8vRHJNSql
         b3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721568917; x=1722173717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGX2yKYZTIt3Q0s/YAylIxLVx4C+iRJs8AHqvQGziNY=;
        b=EefBArOXWZPT4A0bUlRdmYGQynQanT3F7RrlOjV23Y0OYeMg/Mmg/zO5NussstpZ/H
         T4gSFlJrYCgRSKajIoL7++2lRc9J7yE4URk6qFsB/ZZE+wGr7EHDSnfmDZHut48YNGhe
         +xRRvk6jak0LR6qS/HUzncBG3ZaatBS1i5SQbxDNmHHe4qJI5xs9+DTbLebPTEgM2aRo
         tsDH8QGCwpPhmk+OhwjPwJGOVm2B+rT/Rem1pQp/7Q8aSEQ0mu+GIUdumaUoRQqu26Qs
         B1+l502ojX0DfIT4Shdtzlx/5Kkvuy8gihS3gZaaBBPi/4Ez+Wxbua3GKEs2W1UCBabq
         xkYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmlSSit8FO7zgyUrsyp5XNHkLXjEwPypBDRGp04H7ePkoSz9eabOdoXXotOtW1XnfQhflegHliOs/k42MkjfvZBrTy/dYZHxYeG/O51hFEUxJxJ/1iH71PQbpqVW9hggt1PzP9i2zXrSca4rG2+ajAHLEQGe8Y500BfKxd0ef6i4woow==
X-Gm-Message-State: AOJu0YxGbMvSMm2MIA/pMAj/QOXFxiot3UZfqJ4/Tjfu/Ftce/ew2GHv
	fkX92QfMl1DU49q1QdRtR+2WTnO/OR01c+g1e0h2MZT6GlftgWEW
X-Google-Smtp-Source: AGHT+IEcn84Cq+Gii4W3vduMEPECvPWBWA0iK6LpwbsePcodSCViWjBHOrRvWfwO2/rBchjlyKEZyg==
X-Received: by 2002:a05:600c:cc6:b0:426:6f48:2dad with SMTP id 5b1f17b1804b1-427daa67d53mr29230125e9.35.1721568916747;
        Sun, 21 Jul 2024 06:35:16 -0700 (PDT)
Received: from [172.27.139.187] (c7.campus.utcluj.ro. [193.226.6.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868ac48sm5992440f8f.29.2024.07.21.06.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 06:35:16 -0700 (PDT)
Message-ID: <8b616aec-06ce-462c-9161-1c05adcd1069@gmail.com>
Date: Sun, 21 Jul 2024 16:35:14 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] dt-bindings: iio: adc: ad7192: Add clock provider
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20240717212535.8348-1-alisa.roman@analog.com>
 <20240717212535.8348-4-alisa.roman@analog.com>
 <20240718-revisable-penpal-bc06ff6366ab@spud>
 <20240720144257.200b4511@jic23-huawei>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <20240720144257.200b4511@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for suggesting and taking care of the tweaks!

I just wanted to point out that some little stray changes found their way into this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=42991c882f7f264ff8533c289edd015bbc0bc5a7

Kind regards,
Alisa-Dariana Roman.


