Return-Path: <linux-iio+bounces-6878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081191616A
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CD0B2597D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046B21494A4;
	Tue, 25 Jun 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF1waEZE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8B149012;
	Tue, 25 Jun 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304444; cv=none; b=FlgZWv3y1fTTsGc96U6xPAcidECh3OvOBx/ptsI75XQU2L5a1nDN+5X38ijk/3NMbreYRHawFkAAbaUaxJhTSUi9mf75evzY9QHIl4e13mWBDv6f7gjWwiVU53J4zTIDeMBnN7JOgcLIJa2sK74cYd7CtUsqiqbCPRM/bZ4FhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304444; c=relaxed/simple;
	bh=nSIZIu+EB7YN2ilaluaL3ghhEn0LhDQk54LpZnQA20M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2gTsZHbFiM3ygOkyc5i1RbOdZaKhtvQ9usORE+l5Skz0pSB9uqdRQvP5xnB/BwIYFUmaARs9ChJWTZ5DKMgY6XCLJOhFhUQgnJgeqB0EnyZkDmWqnRZcIHWk+xyfRSYXaYCpTbSCr4o4MTtshkmXwHIcdR52z7/h91pMhptfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF1waEZE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f480624d0dso44150715ad.1;
        Tue, 25 Jun 2024 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719304441; x=1719909241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akbFbUx4zXtt9Sx/BycXbdc7GV532lhD2ZNeuACeKGU=;
        b=cF1waEZE//quJbVcyFJorB9F9mZCmqGuNKUhdXYtqAFSA7liYLw7uC6euTLK16LlJ7
         Z4Mg9Gdg1cQiv7uEQgTjFhVya830+1G8poWv2WoxRqqy/hZBXUekZlItcxe8kcQAvx9A
         LfHI2b+3wOEoH77liJx4E2N2MdEBOilFIloDOS5HPvzIdIdkU/qemo7/DxUpDplXwlQj
         Sip6zhguv0spjChUhHSY7kMdzyUZtT7rFH18o/37JjOqa2n2vh9t5CXZM2tJQNKFWUgs
         OQQUqPwYXAUfr7N0V9RDgSuRDhhO4gVnc0wAZASvBeCXyWSjtQXq+0fjvv4p8xLYS3dr
         X4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304441; x=1719909241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akbFbUx4zXtt9Sx/BycXbdc7GV532lhD2ZNeuACeKGU=;
        b=FMh7zOS5V+n4WzWeNxt6zmML7iqjdOhXghxS0MSIGG1ztCjybDY109pXc3NlvtvnVG
         FER/kcbSSOOmtahZQ3TOx8OKN1AupCkjmTIxf+XSt6qwAleWRFedtitkLhUXvCfo7/uq
         8fCjNvztRy3Klp8JJpeQBF1Qd89H+67GZPBpV0jku8z0/S4oLLobAvgGgQK0MQ0iQo32
         g8GaynyxKP1hp9jBLE8907bmW81Wdz725y5mdopow0qbrruBrlIuPQT7oP16xehR3ua5
         usaVUY8mpbMi/t0OTDDjzB3TyLLjtEhbvnTc+vsmQEfXWB4Xc9BcVTepSBVtCHysIKgX
         m8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV7589vAvwQ/371uxdJ+qP5yFkytK0dHAE8SzUKIsFcnZ89w35VSNsmICC0m7E/jGYPUdOVggC3U2FhdkxCBj16KLpcfXtKJ8BR/vm1CvBvO3MgyQgBXHHqQqyo7JV6AMXFa+lwlU2lc49YP7f1xH8XYz5wM4Oq9GhOHhm9d98nWjMH5w==
X-Gm-Message-State: AOJu0Ywdfb1rkh58T322VNyZdrk0sc9JD4qxK/z7gNBV90F0aQC/pNf/
	79TZDnUMHyyt4tS2KjD1yqPUlbPpSYLcG+4VbG2xZehLKOI4sl4W
X-Google-Smtp-Source: AGHT+IFqgjuD5g2gzmir9mbrdsiyzKEG/pT4oh0oVRvz1fXUoL0cjVjpoN4ZY//QhcqstHJQIMBwmw==
X-Received: by 2002:a17:902:d4cc:b0:1fa:449:1de3 with SMTP id d9443c01a7336-1fa23f155bdmr88341065ad.53.1719304441464;
        Tue, 25 Jun 2024 01:34:01 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb879csm75276045ad.275.2024.06.25.01.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:34:00 -0700 (PDT)
Message-ID: <22deda4f-74e1-47ac-a181-83539e112fc0@gmail.com>
Date: Tue, 25 Jun 2024 16:33:51 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com>
 <d77a4777-d282-4004-895a-7809abf68130@kernel.org>
 <20240625-basis-greedily-483c1518026a@wendy>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20240625-basis-greedily-483c1518026a@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/6/25 14:53, Conor Dooley wrote:
> On Tue, Jun 25, 2024 at 07:48:52AM +0200, Krzysztof Kozlowski wrote:
>> On 25/06/2024 04:15, Yasin Lee wrote:
>>> A capacitive proximity sensor
>>>
>>> Acked-by: Conor Dooley <conor@kernel.org>
> And I _never_ provide tags with my kernel.org address in them, so this
> didn't happen either :)
>

Sorry,  I misunderstood the meaning of these tags. I will remove all of 
them.


>>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> What? How did this happen? Where - provide lore links to prove it?
>>
>> NAK
>>
>>> Reported-by： "Rob Herring (Arm)" <robh@kernel.org>
>> No, drop.
>>
>>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

