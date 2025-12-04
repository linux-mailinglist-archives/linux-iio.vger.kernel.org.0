Return-Path: <linux-iio+bounces-26756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD2CA4D21
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD18C3091909
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA033446A8;
	Thu,  4 Dec 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T09prPBn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0A3446B1
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869642; cv=none; b=MwestWNQimJRDLU+sP56+urUOYCRQVdsZpbkRnRt5can52GZK3c7wuqyiHEGURDodP/3TRpv7F3GTmQKi+7ApN8uXSeE3S6klQq+YPa43G4tqYWfNutCpvc7dF7pLET36TZ3qeAdlMi+15gkIZdtCp22WCkl+Q/JSYGNXbvMvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869642; c=relaxed/simple;
	bh=e7sfty3yRlUODBxJz+PpxClJYLIPv1iuD6tUC8QfWQk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JEIYv+5q17zuKnX2I/jABmeQVHQcdhzl0Vu0fL6EG5QLf9O3EPsUFbp0rIaR1EoxSRjGhMWD4SgZJDJWx1DAq7BSCn+AviJpat7eWxT5nO7ODnFQ9ccaRbXiwyOTslW9omJ+f8mpey0ZoND3QwtCaJLOjjntH3A+ORbdIAMHTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T09prPBn; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b09d690dcso453703e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764869638; x=1765474438; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOkTIDR+TWpIaxfl02NyThkY1v6gZKg13N/SLcRcC4c=;
        b=T09prPBnpn0epGRd7UL9ZYA6OpzC0Oo+XYZMQHhwDOEAuqgf5/whpU1MkG8BdhLf2R
         rXlExom24AITIMsbhJIDyKkLQw1Y+fYT4zPM9/dBYWIrrisvtoUe3qKFJJ9ScnR8oZ6C
         61XxFHbmqGKQ9WxGYfi9pL71M85qADB5rQ7HflRgf7v/u3Dy2lHuipzlEf/DsbjOPgVt
         7jAb158RN4zTQ2tl0rqyCVBgSCwrz0kYGjYsDkEG4QWnSPKto12CXQpAzR4HkzrYYVJI
         3IL7vbgFFxMQb4uXtl4dhJ1tITzMqrbaA6PbTcVn9tSjIwg2Q281yQp+e1Fc7QNnKhTO
         q4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869638; x=1765474438;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOkTIDR+TWpIaxfl02NyThkY1v6gZKg13N/SLcRcC4c=;
        b=lqKXRPL4b+LcbAX60aeh8V1jPqfuWX6E+oquUUWr+u3Tp4cGsgwHC4Uydm+oalMrHM
         IHFGVGvnzH1qlzWa+YRxo4wWZglhGA6J6WG2TV+6GVBqnP2DoV8m+GLJdkKOLruUbg+L
         lh2nj+HYEY7H1vpyj4Xg5+CsrwzMQrscDVKCxsjhdAzWYA/aMKaPEPxsj7hEQEM20UKn
         xHi7Wo9wuoUcthq3HCR7ztA4JZaCnbedH7GC8xH+90GYWWSfLM9OqSASycjQAVciEsEm
         JbX9jPBDHv9cYDjrsrecupscCb9Ec182+4J9xD7O4W2g5/+tObwaqq+1zLBSYh2LefFe
         pq1w==
X-Forwarded-Encrypted: i=1; AJvYcCU4VVwKe4r9MXl3m+k8RgaIgKmS5vo0BE3AyXFVxL6leI/Y49Ek2RpU8Tj3VPCbkev2pwdOGxq5uD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWr16qDjjjcqu1mQQ7e7WXtUpBhJgWpbA6MPc+T9cCuGF+/ot/
	EpQn4gwufnEaz4OfujpO85YLUBneClP3UdpnSo97iH7bbypUtSsX5DX0
X-Gm-Gg: ASbGncu5Idho4przhBXzOw82fsIF8v2wjCSsCjvbgxSqSaSFLKFn/6NlVIQZpB61t/2
	c20UUBx8amfg5DMkFHIiapoIevNrQ/PtOP1JnS+BFtlF4Vyau+9nu02uCUHoJDXEPhnIU75b4gx
	rTKvFG1WV1TY2bAaTcq04sQfM0lbD+bYVjXvbVZyX9wTKMTRSFxDDus+x2/cL96pzCEOjo1s8fD
	8IFIAlBI+PPsz0VyvkEQPa6pm0B25mqCH5wJ1x+DzemXU40ME5kz0mquvkfAeNTwxsc0wD+aJeX
	mRJb3xknrWcm7MIoByvYvsYjUY5bBtvj2Eom7UzQ3YJKhqeV+0kH/UkLC0NkMzkwDY0kMD+/Anx
	IxJi0KNcaIx5HuyMDlRbBrd8TQFutRIkPvDSWHG6NDmikMRB7kCsqbBeIPJT2TfshLMA1kyKLK8
	ZIG04c8A==
X-Google-Smtp-Source: AGHT+IGlqYuc0MrdtBQVsuewSDNftJnQO6IYdcPyj5E2cCkLcpeZ4pRP4rTMgDOr8UY0XIwiv6cDqg==
X-Received: by 2002:a05:6102:5706:b0:5df:bd66:7b76 with SMTP id ada2fe7eead31-5e506882463mr1639471137.17.1764869638606;
        Thu, 04 Dec 2025 09:33:58 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e5107e7677sm955060137.6.2025.12.04.09.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:33:56 -0500
Message-Id: <DEPM2M0JZVLR.D8R992OGRBMD@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck"
 <groeck@chromium.org>, "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
In-Reply-To: <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>

On Thu Dec 4, 2025 at 9:36 AM -05, Nuno S=C3=A1 wrote:
> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
>> Hi,
>>=20
>> In a recent driver review discussion [1], Andy Shevchenko suggested we
>> add cleanup.h support for the lock API:
>>=20
>> 	iio_device_claim_{direct,buffer_mode}().
>
> We already went this patch and then reverted it. I guess before we did no=
t had
> ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much better. L=
ooking at the
> last two patches on how we are handling the buffer mode stuff, I'm really=
 not convinced...
>
> Also, I have doubts sparse can keep up with the __cleanup stuff so I'm no=
t sure the
> annotations much make sense if we go down this path. Unless we want to us=
e both=C2=A0
> approaches which is also questionable.

I think if we add iio_device_claim() or whatever the final name may be,
we can annotate that instead with acquires(&mlock) and maybe it could
work?

I will test that.

>
> - Nuno S=C3=A1


--=20
 ~ Kurt


