Return-Path: <linux-iio+bounces-25269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB9BEE34A
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F919189E38E
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1D21FF5B;
	Sun, 19 Oct 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="eYszdRm8";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="eYszdRm8"
X-Original-To: linux-iio@vger.kernel.org
Received: from h3.cmg2.smtp.forpsi.com (h3.cmg2.smtp.forpsi.com [185.129.138.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7410A1E
	for <linux-iio@vger.kernel.org>; Sun, 19 Oct 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870743; cv=none; b=n9tiNOnsl1yqi+q0dXtoUsBIullf/78dbrsB4CrMxvjHEeohirJO1nDgVSsISFmjm24dgQH/u2KR30AYpuF511LsDaQWAyu6bj1C4bTDhqmFLrZeI1pxII4Cu7iOm3AesFh5SDmpm+/1iuFJNT67lPKGrl/Jibx5dSq7AJHAxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870743; c=relaxed/simple;
	bh=2q3WAdXE/1dqhz/yegYxIgHyQ7YftAXi1mXaptgGwgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwA0MSBUMrwTEpnNxEG0REfPPO3KvaBG4YgihplUe+VEXcnZuEueJ4N146Av/cq+910wndnIJGqYlsb+d5Lnr2A34DEDqS7Bwn2ThgO6WD3U5ZR3/ngvys4InmoUPJ5Mfiw+xA58kpCtk3z4kAMTiDef5wpbEUIsUlRhLhlRvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=eYszdRm8; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=eYszdRm8; arc=none smtp.client-ip=185.129.138.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from [192.168.10.89] ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id AQulvuR9t19lQAQulv4NfB; Sun, 19 Oct 2025 12:45:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1760870728; bh=PclRwxNPAx+8lkzl6Cw9ArXFuek1LV052U36M8oerug=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=eYszdRm8ELiO49vPC+uYQVXwPT9Q+l3xIVXqJWLjIomi6AlNcAjJTWRLLfjJ5wGRf
	 Fsd0BUWguMg65cYP31qTh29fOJLwIvE5pVg7o3MLEX9Y1hxyOmpltDcvmjMW9ZqQ5O
	 GYdP6O75lVvMYNDxfkJGf/uXj8G08akrDfuPF93zIvcMGWdsy1QwdDBy+XpkCEHSQT
	 RFANcvFZQlMyCWZskpnmFbf7temTS56URsEuQWQKokOnl3LatVSznUN6pXAtbvuauU
	 0gwoQ7vff5T/uFfksmBFkQ2HSEC1kzZnKbJXA4XFo84tZHYpObiNYVZh2SVuvxiApF
	 e2C0ExF5Xdpyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1760870728; bh=PclRwxNPAx+8lkzl6Cw9ArXFuek1LV052U36M8oerug=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=eYszdRm8ELiO49vPC+uYQVXwPT9Q+l3xIVXqJWLjIomi6AlNcAjJTWRLLfjJ5wGRf
	 Fsd0BUWguMg65cYP31qTh29fOJLwIvE5pVg7o3MLEX9Y1hxyOmpltDcvmjMW9ZqQ5O
	 GYdP6O75lVvMYNDxfkJGf/uXj8G08akrDfuPF93zIvcMGWdsy1QwdDBy+XpkCEHSQT
	 RFANcvFZQlMyCWZskpnmFbf7temTS56URsEuQWQKokOnl3LatVSznUN6pXAtbvuauU
	 0gwoQ7vff5T/uFfksmBFkQ2HSEC1kzZnKbJXA4XFo84tZHYpObiNYVZh2SVuvxiApF
	 e2C0ExF5Xdpyg==
Message-ID: <6ced29c5-bca2-4c29-beb4-b566f4d9bf17@skyrain.eu>
Date: Sun, 19 Oct 2025 12:45:27 +0200
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
 <20251014071344.151914-1-andrej.v@skyrain.eu>
 <20251018140825.006fcb7b@jic23-huawei>
Content-Language: en-US
From: Andrej Valek <andrej.v@skyrain.eu>
In-Reply-To: <20251018140825.006fcb7b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJfQCHNjVWpcwLcsrn2q13AI1RN57AiUJEep6Tg9/7o1k+wBw1N/BntIfhcUOxYTqp4ajcuRQdFUKhFQMV5p427iMS2NhuKXhpwD72fJ2jIzMNAtZP4X
 zD/ZELpUUlkple73SfkoldpIdk2k2R71EMFKpFRMm8qL4QZNJpD8Td94TZBeCoSq66Tb9kXo8waQ9dZXJF6j3azSWRbKFN9bi2gJf2Gn8yW1eJQVTyGhNY0h
 uqy//irWYULM8CmhoYb/Hh4Auoa7ngQtSecN6rFHsySlUpRkgJSviPrxGL/embaGKuuRcZ9GAj21MqPYjAFZoXab6lWB8KZwF4UQUeud2yawS/uKInzskn8G
 8uIznf9FDBuAP0Zpg8k5Jt2vaqZiW8BrzwF2aXaH8HeROwL+x+iFoldW8AuAuymn2p902Gh9FQwsN6WuuKuNrqxvVJzE1A==

Hello Jonathan,

On 18.10.2025 15:08, Jonathan Cameron wrote:
> On Tue, 14 Oct 2025 09:13:44 +0200
> Andrej Valek <andrej.v@skyrain.eu> wrote:
>
>> From: Valek Andrej <andrej.v@skyrain.eu>
>>
>> There is an race-condition where device is not full working after SW reset.
>> Therefore it's necessary to wait some time after reset and verify shadow
>> registers values by reading and comparing the values before/after reset.
>> This mechanism is described in datasheet at least from revision D.
>>
>> Fixes: 12ed27863ea3 ("iio: accel: Add driver support for ADXL355")
>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
> It doesn't hugely matter but I was only asking for a reply with the single
> line David sent. Not a new posting of the driver.
Ah ok, I misunderstood it then.
>
> Definitely don't ever send two v4 with any changes at all as that makes
> it uncertain what automation will pick up.  Standard b4 string to grab this
> patch grabs me two patches with two patches as it can't figure out they are
> the same.
Sorry about that.
>
> Anyhow, applied carefully by hand to get just this one and marked for
> stable inclusion.
>
> Thanks,
>
> Jonathan
>
Ok, good to know and thanks for the guiding. Will try to do it better in 
the future.

Btw, you swapped my name and surname again, at least in the commit 
(author) :).

BR,
Andy

