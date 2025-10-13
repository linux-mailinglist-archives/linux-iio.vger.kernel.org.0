Return-Path: <linux-iio+bounces-25018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756CBD1BCD
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48FAF4E1D2D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F542E6CD3;
	Mon, 13 Oct 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="H2B1VjUD";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="H2B1VjUD"
X-Original-To: linux-iio@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56D2E0923
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339266; cv=none; b=QBgOV7Yak7g4ZKVD+DrWQzYCeJPxhwFaWb+5Q7c2MeSBRK8S3NLiYyLqk1RGhvl1CYBXWCb+FB852WS4x4qi4zSMg30Zwv51dM+u84v95i7h8/JTHcfBAE5ad2rurlRT1aFq13wpvPhsm26RXYhab+rzU2mCiuWHF5Mp5XNLLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339266; c=relaxed/simple;
	bh=cO0079NTmTYANqfStInu1zTwi0gwNH9xRiFEsZT+jC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X23RjS6LR3VaNbHaMlkyMVvCx8LmimlKMfxqihG+6k2MohVULb2wG/Yw2S8GZjA7xI2fqWXPMi8KXaqoU+LU+cU+Gq/wnD2BMLPuFucaLDEmv0m0cq0I6CgMtfhRo6p1/23QHxYtbRR7xDE/tmlztT7B0WzFiE35jpj64xiugmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=H2B1VjUD; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=H2B1VjUD; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from [192.168.10.89] ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id 8CeZvHBvTx9qo8CeavX15C; Mon, 13 Oct 2025 09:07:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1760339252; bh=pGASkZaTjUNaRn0OZijCoPUxD0MIJXyRCwN9WTYhJY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=H2B1VjUD0EUPWcJA1E+UTcS9scht8Q1xa9PbN6wnKGnqMMewXANjANCkW7RqS4DFq
	 O6yn+d+NovaHzmYrAoGzOl/8IwMcIXPYGmp0y7z2yg7p1lekHI4Bbjd93WIYnZNneb
	 qD3r0PpV2renVjPujFLoHSDvoDugZC1649ZwmN1Uj2cChZIZ5eH5yHCdqQ2wMXcIZz
	 OK83Ra5WpjeWevWp0SV9CYt19ZwdckhiouvEBR6uSLJ13avH9CtofALiScbgSKPwsC
	 lbfGjp8fPSMw/Io0YrQ9YphQ1+RDVK42ekgrXA0fzfywvXzqdBg1ZtCeRXX0LokbIq
	 lDl7x/Rn4I0+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1760339252; bh=pGASkZaTjUNaRn0OZijCoPUxD0MIJXyRCwN9WTYhJY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=H2B1VjUD0EUPWcJA1E+UTcS9scht8Q1xa9PbN6wnKGnqMMewXANjANCkW7RqS4DFq
	 O6yn+d+NovaHzmYrAoGzOl/8IwMcIXPYGmp0y7z2yg7p1lekHI4Bbjd93WIYnZNneb
	 qD3r0PpV2renVjPujFLoHSDvoDugZC1649ZwmN1Uj2cChZIZ5eH5yHCdqQ2wMXcIZz
	 OK83Ra5WpjeWevWp0SV9CYt19ZwdckhiouvEBR6uSLJ13avH9CtofALiScbgSKPwsC
	 lbfGjp8fPSMw/Io0YrQ9YphQ1+RDVK42ekgrXA0fzfywvXzqdBg1ZtCeRXX0LokbIq
	 lDl7x/Rn4I0+Q==
Message-ID: <6b4889b6-a806-4ecb-b6d3-ed164b821645@skyrain.eu>
Date: Mon, 13 Oct 2025 09:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: accel: fix ADXL355 startup race condition
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 David Lechner <dlechner@baylibre.com>,
 Kessler Markus <markus.kessler@hilti.com>
References: <20251006095812.102230-1-andrej.v@skyrain.eu>
 <20251012162652.65619962@jic23-huawei>
Content-Language: en-US
From: Andrej Valek <andrej.v@skyrain.eu>
In-Reply-To: <20251012162652.65619962@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO3whyo884JhBKWCwA60geTD0S8xGJIk4rPgt42WSmJib/v9+niw4QmuL9w3uFRUsCrexyYqmjq/NfbmpieeRnsUbMjyHvt23SVxOnjKG/4mjuhTOOsm
 RZvurEiqJSXm5Iad8gYk1crrG8sjXv3eRQuUncBGMxpPmmda9wtrCGMKhTwYFr+7CRBd2zPaiQ8ldlwPrYsWZdU9RMXKzNYXdVdwWzYGd6gBL9Zbm8WBjp02
 Sp/gb3ZAwcv0lMm291hBLlQRP27RURX8aU+AxZXO9bRUDXptUEC41WgHJassFMFRylPDaOoNFNi5MGDg4q1XpXrp+eifXZKuazXJXnObftErhhm1ZatX/lcj
 2q7Rw54krJq+VPUAFdNerZmc9UQ31NqavJ9wOuuk8SHFYKC5bwyX2Vd30hdUHjh2gtn/5cSTXOUsBypTkuEUFcsXNmm2ww==

Hello Jonathan,



On 12.10.2025 17:26, Jonathan Cameron wrote:
> On Mon,  6 Oct 2025 11:58:12 +0200
> Andrej Valek <andrej.v@skyrain.eu> wrote:
>
>> From: Valek Andrej <andrej.v@skyrain.eu>
>>
>> There is an race-condition where device is not full working after SW reset.
>> Therefore it's necessary to wait some time after reset and verify shadow
>> registers values by reading and comparing the values before/after reset.
>> This mechanism is described in datasheet at least from revision D.
>>
>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
> See submitting-patches.rst in documentation for how to format it, but as
> requested on previous version please reply to this thread with
> fixes tag.  No need to send a new version.
I looked into this document, and to be honest didn't find any "issues" 
in my patch. I used checkpatch and get_maintainer scripts and passed 
without errors. So what's missing then?
>
>
>> ---
> Change log missing
What do you mean by this? I didn't find any special document for this. 
Or do you mean the commit message, if yes, what's missing?
>
> Otherwise looks good to me.
>
> Jonathan
>
>
BR,
Andy

