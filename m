Return-Path: <linux-iio+bounces-15067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42979A2A358
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 09:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E6A1889329
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EAF225A3D;
	Thu,  6 Feb 2025 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1IeleN6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331A22488E;
	Thu,  6 Feb 2025 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831166; cv=none; b=ZQAhgheTbIUq5SfajI9OeBoXsDds4xjnkflrP9LELFPg2CodW8srI703Gt8BEmqW5d+zK+CIG2FbORzW/wNqDr86rePMMDTodHHaNsLssxuzi0cAskOfz9P2w1zTq9dBFJ8bqJWDBLlz5EDAKoC/EA43bOaIkNAqdl7hUU2t3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831166; c=relaxed/simple;
	bh=oKu+cB+CM3wATBLp/5s34qObsyhrmghUZM1r+46ZaOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iS4vGH7j2w+liHprW1oaDUFrzTZL05K2JJyLlPkZPfFiKHZJVyEJ9G1K6OlMz3hqy2Od1pTx8c8m48fb3ZvPYF4yDSkKqbk33Kt0l0zv5VKpxRRAxUkLuLOZ+hsrfXJsfFNNMfDGadQCWtIYsJBIid9iupJm7WjIa+wOUz1e+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1IeleN6; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-304e4562516so5897681fa.1;
        Thu, 06 Feb 2025 00:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738831163; x=1739435963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Oq/sm/m7Gr6yeLfF6pPWW8J+P9gaFDWDMTmeX0qou8=;
        b=U1IeleN6TaIgRthTiA8L/ttB5vEhqDFgMVNa0LuJkm1EtvbY6SwGh4dmIKmtprrbci
         Wfyg5Rgq+YLQiMbwhONres8TA7lajCC6nyJ/v3+Ea9Si4zkdnm7fZzxyXRpNG1+cV3Om
         SbN8S07V17irY/51UAwJzM2ZTQkrsmN/NVoJwDgErrwnxdqIoQG4Xt7FWX1zZE1t9cEL
         nM2TUAL2KCLOap2fuIgOYb3lDA8jAtrsVHnk2eBtIHk0aEYSK+eyWcjHOLUXMODozTfl
         BmEwCBo+aamQLh90MrtKzFrI58c6n/RPd5bpykzEXfWtTe5eDc4jSN2SdGucai3Y8Wg3
         6tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738831163; x=1739435963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Oq/sm/m7Gr6yeLfF6pPWW8J+P9gaFDWDMTmeX0qou8=;
        b=mYH4kKzsxK4gwvDuLZeUN9IEUc3iQDk6j2paHxQzAB+4v8sm84ti9dyp/LO7YOycAH
         1mAHJcJNPDVyvx6T6y22mhbPS1xSP69Sx3WvQaHN1WoNutpqtIeGrhixJLXi1gPrHIfv
         JucG4FoXqqM3j9KXI9vV6TJtn199vO1pEMGUoq7wUtHoi5SxoswSVWZp4tPmAJxr/0bA
         dEYkHJteURUGgy+1c1u0fYCVY4xMIL/lBzZGBBL8DoBBvvQSS8KiL2wy/mkOPQ4PaCpw
         /fb401/hwLjB4swbLRNv1h4SgKzjPVrjenuazP0YutHocTuLbqe1MeXq2JfSWlv+wdVv
         TWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2unCghnhMNMc8rl2RNJ3uTbhAlLknajlCpz0jn/A5sjSDP226deVtX58jGyoZaB9bBduMXHZMfXSf@vger.kernel.org, AJvYcCUrJQfRZsn41t8IG0NscQLT2r9Cg6U2jXqL2lwcfYJb3VegaVkyu5tQMlSr/6SVol6NccWmaaiA9XqsGED9@vger.kernel.org, AJvYcCV/ZTiNMuSTHXASulqfIGHAMN+HcIXW4pU+89kF7dDQFaWKQOVHxCXdpWrLEp+NYIxhF6iWm/bdO8Z0@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZXam5o72G29RLbCTJBpLfhwC+DXR2If5wTThX25jwz8Mq8hw
	ecL3ts2F5kIBYv8eSHTEgTdx+QyH5bKlwTyILPLvKMIT4PvAJm55
X-Gm-Gg: ASbGncsyk8NU96IZGLVp/77h6ASSaOBe9dwEKDNHTwCvCHBuBQOexarew8cAVHYRiCQ
	OeYMH8MY8YbC0fGVvDPgQqqqCxn9DI+pABPfHvTw+V38c9m9ly3gytMjMGAb+/g5C5wnBhSAYXQ
	S+9m8x41fAE8wDI6x/hR0WUyqoOXajm34TlFULObGtt7DLUuyw3imI+/RcQEEFRkEtDHrrNgrrS
	mbC8ORNBQZoTXMmXdqluWV+JXqbvA9nn6SAoKoCZLWUczxft9W7iR1rBnMR8A4MJvAacG/YiBNX
	lm1G9lF6irUoaHxry6GdAYIfZ+BO
X-Google-Smtp-Source: AGHT+IEYT2mKibkqI11HshmhDNKvwHktb+wJ7DD6s9zM7WziIbbzxX7sOKY1KNQNHSenFypF6uFd0A==
X-Received: by 2002:a2e:b610:0:b0:302:49b6:dfaf with SMTP id 38308e7fff4ca-307da58cb07mr7598521fa.20.1738831162629;
        Thu, 06 Feb 2025 00:39:22 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de2f6995sm692861fa.107.2025.02.06.00.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 00:39:21 -0800 (PST)
Message-ID: <76858097-10a8-403d-83a1-f70064f97a6c@gmail.com>
Date: Thu, 6 Feb 2025 10:39:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: ROHM BD79124 ADC/GPO
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <4e6cd143d3e896587528a415c8623ecd610fac55.1738761899.git.mazziesaccount@gmail.com>
 <20250205-stalemate-shorthand-5a29fbc4081f@spud>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250205-stalemate-shorthand-5a29fbc4081f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2025 22:03, Conor Dooley wrote:
> On Wed, Feb 05, 2025 at 03:34:29PM +0200, Matti Vaittinen wrote:
>> Add binding document for the ROHM BD79124 ADC / GPO.
>>
>> ROHM BD79124 is a 8-channel, 12-bit ADC. The input pins can also be used
>> as general purpose outputs.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>> RFC v1 => v2:
>>   - drop MFD and represent directly as ADC
>>   - drop pinmux and treat all non ADC channel pins as GPOs
>> ---

...

>> +patternProperties:
>> +  "^channel@[0-9a-f]+$":
> 
> You can only have 8 channels, there's no need for this to be so
> permissive, right?
> Otherwise, this looks good enough to me.

Thanks Conor!

Indeed, I think we only need to accept channel@0 .. channel@7. Thanks!
(And reason for this being permissive is ... drum roll ... copy-paste :) 
That's my main method of creating the yaml bindings. Swearing, sweating, 
copying and running the 'make dt_binding_check'
:rolleyes:

I'll wait for a while for comments to the other patches and fix this for 
v3 :)

Yours,
	-- Matti

