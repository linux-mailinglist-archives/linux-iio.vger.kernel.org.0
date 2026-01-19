Return-Path: <linux-iio+bounces-27973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C95ACD3ADF4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 895D2300F566
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052103816F0;
	Mon, 19 Jan 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0xB2+8Oz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E63815C8
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834811; cv=none; b=OLu1z+V4cgxClKrQJuqHYGeHP8uXxGHb54r482VbJXj0IQ/RJAN4QVt797+H7yKSne1D9GtWGB+vJwivReVzc4Owk0o4LInJCO/amDmrBfxFIp1sbMH/2dKzcTmNgre37v9g5lsBg/tXopigCmVoJOThIuX98G8B1mxXmBzfjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834811; c=relaxed/simple;
	bh=cm0kBCrCagAmIwIfdqQivns34awEDM3DgQZ629eJSvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdUu4K34CQFVBYst7Kg3D2MRaXNhAjqASGm5IVNXKgEnVNik3khhdJ4P45GP5s6BUW+aC1Vx5eQqZXjJdVieXl7T5UWxITaPw7jLOZA5rASwz0HcIQq3ERgJC0/dir9qc8cRGZ8UraRMoz8Z0lgAHcZqpGXdNyJKWK20xiaAy7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0xB2+8Oz; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4041c73ab4dso1540369fac.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768834808; x=1769439608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4+U9ZGKYVnrOMk8WBltvHJAB0HdENMPvpMm9u9ZXYU=;
        b=0xB2+8OzBFiJoPPCweIGUvNIB9ZIbkaJ6OebkHuDTSGJJNH/Trg7jS96Oz+vqutLqh
         xUCQScZVIt3+R5GpihO6DxjNDPONRtv6KbXM+aPzM5sBI5h5yusnFKGeey5YdDsMs4Aq
         vYeJR00cdK/P3ZRr0O1nEEZ0rwGZFYhIgWjJv2DrRPg58twM+/mPTAYzTFeqWKM0IjJO
         y5wkl24cdr2QmhFOuFZ3Z1D0BjPu2tNesWoQv3Q9qDOG+PyI4ZvIKXVrtzbTOPnKSm7J
         CXzBvHI5qK3bjnoum4kjWsPRPHDumM+m5L6SZaeFnvsdz3vfIKyr3E21l+kn0KhoAsd/
         kTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768834808; x=1769439608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4+U9ZGKYVnrOMk8WBltvHJAB0HdENMPvpMm9u9ZXYU=;
        b=ofd/udVnR9s3FOsgD2St6KvaYLRMoSpAQyP7DV3W6zQi5zNtqBscZ6yTGljY9psqYL
         YHqcPYWFGvACIku+WcydUarp63NQ+KRiU3keCUQkXQ7kfIcJmCCNMcd5OCYtbdERXMLs
         Z3bNVQH7gA2is3A5iJUBMxVdT7sUwcOAUbuSezvhKG4g2urYEhMfeFkdy7Kn/EuVb1lx
         pfVnjhKQwcJzSZ+V4lyd91OTPJOBJ9FJXhboX4U1ZNBbYgiQYhPVOYPEtiqjHj4+3Lve
         z/0FCdr9h/hcAoDkxrPqLB5UKbQYtZ+kc+15QqAl/1vQ42+FReU5hTWE/+MVjtpGnDX0
         hRjw==
X-Gm-Message-State: AOJu0YzvSqg/Ih9YN4h7RAZHmLvlL3nNLkkD8hN0UmaVuXFltW8tUphH
	7AMgFKjsUViVRISSIN2REOx1Qhst77izSWI1zZIpcGG3+A9mDzJuITfdyxtoPr/qoD0=
X-Gm-Gg: AY/fxX6wdtTZdDUtHxwMto0KO74FYQ9XiMNPRf+IFnlsxaGxORcoRadOKUSD2Vfploa
	ATgWEW8DT2ISEbipdDk/BwE3jAFZwk3YlVMNHbpMSIfM79q7ZFFxeH19/22wzSP6X4v6JZuQhyj
	x2fXbsXuHTxMc7fbDMcJq0eVbX1ku0Q76ajukfElhrWmN2Cxe8ZDNJToia6kHsM93TO8e6bmzgi
	B+70CmuzcWpzuyex1Bnfg27nZ1LdA8Zc4cYTvQgLnehp6BU8yqzaUOqUhKMFqnQYeQX+S+ZPQ1g
	L9bqyN0sUQs1yH6415Kpc9cdvvZO8RIlOU8x/0opT7/xdwqlFBc6ZQJCMHEq+/qcxndjLEKPPWG
	fOYe+yxDjlULXlTfgXbdz7P8aEduLbr0EzkYZJWdX1DwKr0CwTLS4mB6Qe1MzSMjLvjRdbRuZYj
	Y5Uh0DKC0NurmPmSfliQlKcUSBRWRHfyWjcIv7cXbIJcEQJB+1rOhkK/Wqduw0
X-Received: by 2002:a05:6820:984:b0:65f:72ce:5e38 with SMTP id 006d021491bc7-6611896c48bmr4616133eaf.57.1768834807830;
        Mon, 19 Jan 2026 07:00:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d51b:6660:8b0f:6002? ([2600:8803:e7e4:500:d51b:6660:8b0f:6002])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661186da6f4sm4457101eaf.7.2026.01.19.07.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:00:07 -0800 (PST)
Message-ID: <69c4bf5a-e081-4660-a4ef-a92e9b081b41@baylibre.com>
Date: Mon, 19 Jan 2026 09:00:06 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
To: Tomas Melin <tomas.melin@vaisala.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
 <fda7d715e2cab2545c9ecdeead22d8a58ae5032d.camel@gmail.com>
 <1f431375-f2cb-49a7-a0bd-6c00273a3c92@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1f431375-f2cb-49a7-a0bd-6c00273a3c92@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/19/26 7:49 AM, Tomas Melin wrote:

...

>>>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
>>> @@ -235,6 +251,7 @@ int iio_backend_read_raw(struct iio_backend *back,
>>>  			 long mask);
>>>  int iio_backend_extend_chan_spec(struct iio_backend *back,
>>>  				 struct iio_chan_spec *chan);
>>> +int iio_backend_has_caps(struct iio_backend *back, u32 caps);
>>
>> Not what David suggested and I do agree with him FWIW.
> AFAIU this was exactly what was suggested. Citing:

Slight difference. Should return bool instead of int.

> 
>>> bool iio_backend_has_capabilities(struct iio_backend *back, u32 flags)
>>> (caps is fine too if we want to keep it short)
> 
> Using the longer format is not very practical. Can we keep it as
> iio_backend_has_caps ?

Yes, I said as much already. But I guess you are asking Nuno. ;-)

