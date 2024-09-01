Return-Path: <linux-iio+bounces-8924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B996765E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C192C1F21871
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D117E8E5;
	Sun,  1 Sep 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l1JBb4QA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0917E01C;
	Sun,  1 Sep 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725192553; cv=none; b=b3YUhIyDDK8jJZVVQ9dKvaYFHQzAnvuHTkrosrSCYjMvO/4mwgrKzM//5dBbD4L0NYie3GbmYOqkK+JMkSqvOYpKfndaEma/5x1LdVAwTTEF7CHxiDzzRLsWAzTzKApzhzBpJWbvJNrGOXc0XkZN3GO3FYTxBkMpL7HGgaigfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725192553; c=relaxed/simple;
	bh=cu9LJjm1nHCO9NMmkUm4yErSsdVtDA7IFZxoJ7nTO3I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gjHwh7pz7B4kL34yxEUJUY3Psc4VrqUbJ0FLmMpLsuXimwaVlu0kHFHMlcq5COrQ8sjVtEhiK3QSq6Xh9diZoQZf7TD4q3EZmxN8DO7IYRPlfIbDObl/FYgSnBkVGuontPm3U7f9f86ICLm5VnIzcnJ4iQDPZX00C7c1+dBZvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l1JBb4QA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725192523; x=1725797323; i=markus.elfring@web.de;
	bh=mydL1oQ8sljL59ISc3eqaLx0XF1zkrGbHSVKS4Rrctw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l1JBb4QA8l4e6ojuCtxvfOS/ianBHxqytBZ/t0xskUiT4KCLMLVWSRP6zguvkaXX
	 kU1Vn+jn/IcWJ6N9sBTLytApgAUD0Nz64wmLuHuCLCUo+au9nTICOphoAF2AL74mE
	 Rk+PPlMmZ111IzYeMWHOKE8ZjAL63UKy2BxXl7B1fmPDqb624V9/iD8z5cayp8chP
	 ivrNIlZUlJKBCbwZKckF78I3joQ3WK6FLN2McQ367BrfjswY5MpuuhARw/JMqCP7o
	 cbF6JwgcxkZ26RwnzIu9HVFTu16VpJrIoIPYJgRM6eY3eP98VODxtyLZdWseln27c
	 uHZAJwkw0j+qZ22lrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1s69uR1tqe-00Zkc8; Sun, 01
 Sep 2024 14:08:43 +0200
Message-ID: <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
Date: Sun, 1 Sep 2024 14:08:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gyeyoung Baek <gye976@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240901091214.15199-1-gye976@gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240901091214.15199-1-gye976@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QUKGJHOtld2ZXAvWSqLvppID7RVJ4c11NBPAf6WHwKoXtlm6Ia6
 PyW6QB4kmCCZxTBVdtjP7cWXeKSGVPxGW192ezZHU4IugbTxjzV5j9U7vakJ7PXnESuDkKJ
 xMiL4k04DPOFJLy8xtajwfXAS/gDtcdBNEg13xlNBof3L20UmeMVsRyIWR0ClD1/QkIQhxv
 VDXYXI4G2fCqtuF3Osf9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:orIapVHE6vA=;/ryElGWFVX4yl++yUK74o/+7653
 0HEhieHVyIsVEw+Vj0Z1a8RX/k1wiXvlBaFvCjNYttgvRjtpzYRKmKN8jG7RE83mFEqg6TIe8
 3u7GA+eHIHddFP3k2hR6Zr7ilKvjLMpnOKtVeCVIM3LwL03WUK0jFLHx9omjHi3AHNzUwZX74
 B/3wVjcd0HTO6j3hwmdt5jrvfTSsp36tTinJKXmkfqzpcJ11x5hOVjTgATAhuVfVYxR13OwWE
 xX5bS02rtrcMEROuafMpt+oanAZyS1/1K8xv0tqo8jNJN1aqsgaCkL8xbiVu0RaRYqjn8xv/y
 37kTAw19ElGECyxKfQhI7ISd6clRnoAgiI1dwXNLEeRppLHO8dJZ8bEsOPNwRX3ahj2JaqAQb
 dXy3aSBl0ohWPlNgqQsOFqEVEZp5qXeXDd4ZPyUIg4VW7SscoWWBLLvPma8stv0WLlyGK4uI5
 iA46cTV1kk0cDfhbALm2438/h4CjY06zRGmwPTFMH+NUPYemgO2EPg1VHQlj8EjLwni9dekDm
 PSx4GDea+flWXpZjvdFa/57cyggEKCGSv2e9TaeZMsXM/9RsXEShQKkuMGGUUjwekkgKV2XOP
 KpkTP/cc9aSifFH+mU6fiK9DNcjlvaMsy/KDw7aO9Z9x12DvcN2J7P1qh1bbCvODVjgp5jN9u
 Ftae+ZJ4DLoOHdmDqIwVYmpd4gCKDcs2viyIaoFWLfnT2v3isxaFE4I1Eg/5Dy/xsVPNYErbx
 M5EHE0JQkB8PiDr0Mp8BqF77MpB1geiLSZW1b9kyaNi3SWpAPyeNYVgUzfh+JjLTTukKO5C/h
 e+IRa7+nhYfq+NY33dzDQ67Q==

> 'flush_fifo' label performs same task as 'endsession' label

                                            end_session?

The number of actions differ between involved jump targets.


> immediately after calling 'env_reset_fifo' function.
> so i remove that duplication.

* You would like to specify a corresponding goto chain at the moment,
  don't you?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.11-rc5#n526

* How do you think about to increase the application of scope-based resource management?


Regards,
Markus

