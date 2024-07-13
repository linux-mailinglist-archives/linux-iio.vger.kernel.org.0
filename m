Return-Path: <linux-iio+bounces-7601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B19306D2
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B11D1C2332C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777513C9A6;
	Sat, 13 Jul 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="xDL+KsUy"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BB38DD6;
	Sat, 13 Jul 2024 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720893381; cv=none; b=t39lNWU8epfAfRaSaM5o4+Yw0eTl3PqHahUUyiGfo1KFiwenepCsA3ZwYCf9pUcl+qDMYdY2pZRUo8eNaTyaaqrKQviWSbdHPif5z+HcvdftXpSsI7d31f65XhJjubwA80yYR0PxwSMxbVvpMAkdpEpjk4yQKFXO9qkTX6iFs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720893381; c=relaxed/simple;
	bh=arYgdwpdCCFTzYCJ4hmnsiSNeVIXUmEu6EPo/qr05pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0DguW8YESgJPASeil6M/WFLUImpsFq5UBKF4ni264cqbziwEgEhh2lkBJyN3eHfnCtEzEt38/c6r6nBID0e3isQaJl+JXsw9TjIYCoWuGke1w/5PVnkkeoKl/1c4cnokuDPRWJW/ni3g89njRmD79gUhazC6hzhZ5IllOsiNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=xDL+KsUy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0E1D7882B6;
	Sat, 13 Jul 2024 19:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720893377;
	bh=H2q5W+tJs6HE3ol/dpWu+HroG5h013Qm/VoPvUv9ANQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xDL+KsUyqabyaDrEIpCqqM+jbOYBz/QCovCdSB0kqJoL0Pdi/8tqhFXieIWG1FEXX
	 oFglV7hXr+7JuAPBmuAtt3OrxfWv5ViYB+dzIlgQtONZK2cJj1lY/gO37xZ9wdLrdY
	 iKHnt1yL5PkJWXsoJvS2QbEwX0TBbnmvlIoH+wupu+eXJ4a3RcS+EFlk6iOKaRUJhC
	 o6N48zUWDesOEaJHhUaxa6DPR8b9EcWk4uwuflaCPIZDuvwu1ry8J8F/QUtJtmk6od
	 bWz3v6FfgQ5n1z1wYOrxaOX03LZMltURTBaZ4RFFGp68XWBT/dgoKf3nfJNYFYgAgo
	 GlGZ5jsLWpfdg==
Message-ID: <9f473d9d-0cc9-4a8f-9e16-6b482de5d0ad@denx.de>
Date: Sat, 13 Jul 2024 17:53:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: ltrf216a: Document
 LTR-308 support
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Shreeya Patel <shreeya.patel@collabora.com>, devicetree@vger.kernel.org
References: <20240708114227.18283-1-marex@denx.de>
 <9c6d56a4-6797-4748-b08f-710b4a0b5280@kernel.org>
 <20240713120635.69fcdda1@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240713120635.69fcdda1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/13/24 1:06 PM, Jonathan Cameron wrote:
> On Tue, 9 Jul 2024 10:26:17 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 08/07/2024 13:41, Marek Vasut wrote:
>>> Document LiteOn LTR-308 support in LTR-F216A bindings.
>>>
>>> The two devices seem to have almost identical register map, except that
>>> the LTR-308 does not have three CLEAR_DATA registers, which are unused
>>> by this driver. Furthermore, LTR-308 and LTR-F216A use different lux
>>> calculation constants, 0.6 and 0.45 respectively.
>>>
>>> https://optoelectronics.liteon.com/upload/download/DS86-2016-0027/LTR-308ALS_Final_%20DS_V1%201.pdf
>>> https://optoelectronics.liteon.com/upload/download/DS86-2019-0016/LTR-F216A_Final_DS_V1.4.PDF
>>>    
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Applied to the testing branch of iio.git which will get rebase on rc1 once available.
> 
> One minor request for future series. For any multipatch series it's helpful
> to have a cover letter even if there isn't a lot to say.  It always provides
> 2 things that are useful:
> 1) A title for the series in patchwork.
> 2) A place for people to give tags for the whole series in a fashion that
> automation like b4 can pick up.

ACK, I really should work on the cover letters, not just here, thanks 
for the reminder.

