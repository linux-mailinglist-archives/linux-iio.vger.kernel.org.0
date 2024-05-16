Return-Path: <linux-iio+bounces-5070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A14F8C7A26
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E751C2173C
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4B14E2E8;
	Thu, 16 May 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzHJV/Sy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60014E2C1;
	Thu, 16 May 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876110; cv=none; b=J1gox7R7gavoSMPPPcCS/EeyHxfX6Pw2T2EdTNvXKRPWhpJBLWUNRV9FGmSPKhWNPxRkQ60HN3kP+OqyhLfTTGwuAz0N5P1HOz9SoGD9acOYEkY0HawJGptxCbdpSL403FsNaPCgBJsAX5l+jSWbOVhX2VhKA+5zZPd/PqOfk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876110; c=relaxed/simple;
	bh=Mh0u9Y06mcntjSNlKFJ57KMfOKSfioL1lnQzZWm3pu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czo2L/8Xv+c/sKfZUHLTBqkA/LgVWIxJHcjlTtTLuRYXyfNQ6Zt/fOX0JqdKIpWCAhfQV0be3MqlAv6y7XvN2NldMRFeDI6dbqjk7hy9ENKofjHmbuTU6HzH8rAHPMojRfphXnuhQtWyfGHlAH4zIhcAE6CC+fY6l0QG7y/w9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzHJV/Sy; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792b8d98a56so745216185a.2;
        Thu, 16 May 2024 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715876108; x=1716480908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xe39QYa7TfsWXzNNingUD+O1lJhMRi830tLy3GV8ajM=;
        b=kzHJV/SyfkKLyjkYNSKJkewDlss+EOzRlrH4RzYrg6Sq+kC21tiRG5517RRBHei6uD
         dfOTKk5O5FPU+XH9jZjXlyiLgtrDf2A/Tsp689y8jKtvuIaE5nzxkfcwAmUyu7ZB/E5X
         JrIwVpW4hfohPhtH7gzndjnMnmuQnQFD5qkGKvOny4kh0GfFU53CWm5HbJkTQrKyjgpX
         znXhnc2Y40YYLpXbFIVfDMcs9sEfP886QjK60B9UA/IncyWuTlIWfRZCvLsdwWyyD62X
         TJYI6gnyMNxMu8KZTJAAmcBiATXEzFroKho8wuTHCtUFIjz18G2IESzDgulYZhLFn7I9
         C5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876108; x=1716480908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xe39QYa7TfsWXzNNingUD+O1lJhMRi830tLy3GV8ajM=;
        b=HgOZe37ZDdF2VhtS9EYdafDeW1V+qaeKjtMM47+ZIXU6uVZOqLIowCTiuWIOkAnPhE
         aeUg+pQG/IkOm2YKzYysqB4knPNQfgdxhxlMVZ68GJkKAfJbvDq38zTYTxZpsnsw9/A+
         NfhmwWZxc1IWnpcjbfu+q+QORoEr4G9LocQ8BfWKiqC2+tZI6sLyKnOkYztVjfUdbZUZ
         1So0btKRqrXPXY15SQ0dqJDeDoYhNNvnfvQJV+2YmfLfVBJ8NzXDvjr6+4+ucgnJimMI
         vq9Lmw9Sg0osiqXWywBnDs71LZwZoPejzeo7S4wV+cqUnLBOlDny5TAmEXTkkqQNBVgg
         oZRw==
X-Forwarded-Encrypted: i=1; AJvYcCX19f5a8QMNGS64Q5haW681a57spmxZy1VuETrdvAaA0g1au4cqeAHHhhG06UF+0lV0JPY3BHmTyaKTS0jJkCRCDDj68vKsyCqykbRWOT+SNB+NFHIWLx/+7CUtZamBPQguBNSgSSvoT8q7wcAhCLztXieSv1wk1g5ZPwE/rLQVbIXy3A==
X-Gm-Message-State: AOJu0YwNTUtni9TR7cyGTai/XiCr625FSNPtyJ2vb9fvAG9nnGyi9Gv4
	541+nsHjiOFfQGmcFB9sE5FntAOtFdPJREvU9hwx6YB+OPbHsF+q
X-Google-Smtp-Source: AGHT+IFUuxxxvJDDRP5xjeDBCKJXwzIYIXtYwwHtRWhzgkosnjs7D4tlbQURdVVrLy5sbsofDmkh9Q==
X-Received: by 2002:a37:e209:0:b0:790:9a32:651 with SMTP id af79cd13be357-792c75f47e3mr2216024685a.55.1715876108240;
        Thu, 16 May 2024 09:15:08 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.105.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf315009sm816795585a.118.2024.05.16.09.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 09:15:07 -0700 (PDT)
Message-ID: <7705589b-d135-48c2-b4d2-866138a82918@gmail.com>
Date: Thu, 16 May 2024 19:15:04 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Add support for AD411x
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
 <CAMknhBGUHB65FALiy4pC2kHs0hXuF-51uwL5CTXOVWaBh_QpDg@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBGUHB65FALiy4pC2kHs0hXuF-51uwL5CTXOVWaBh_QpDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/05/2024 01:35, David Lechner wrote:
> On Tue, May 14, 2024 at 2:23 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> This patch series adds support for the Analog Devices AD4111, AD4112,
>>  AD4114, AD4115, AD4116 within the existing AD7173 driver.
>>
> 
> It looks like most of the patches in this series are cleanups and
> fixes of the existing driver unrelated to adding AD411x. Perhaps it
> would be better to split those out into a separate series so we can
> focus on that first? Especially since several of them need to be sent
> as fixes for the v6.10 kernel to avoid breaking usespace or bindings
> in the next release.

Sure

