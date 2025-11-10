Return-Path: <linux-iio+bounces-26139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1215C477E9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83C13BABC7
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1831A54B;
	Mon, 10 Nov 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3/YeC+B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C0315789
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787428; cv=none; b=diztY99qL/3BpJYjV3DoKikMg7OD1XyEhJY6gjintah4k4hjKSE0u3HE7yQ0CoS8BAweG2VciYFAhtaAgtRvq7MT/FN3swLD7KvVr/PfOA7J+z3vxoNazPBK35vhfrB3wW75RVmNnuXVIIkezZGkfTmGTisUvWyKW0Qw0fMdp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787428; c=relaxed/simple;
	bh=hHhiNACwtPLvWt3UU8MHG4kcjsqq5PZ9cNakiqX/+fk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2jL7GtTJv5H50eq3jRWd6s279JhitrCdu4GB4+2HOeaZW1wvNKNGzaAI4+H/87c9ayH4IjxRVkJOzygobPwviGjYOZFL/QNZOUdgK3F3ZnHBDlDUTxus5AzzkvnJxvtwazc4B7NRXaQhagZwA/hWj8x5JIj5q+0rGqrnbtg/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3/YeC+B; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so21473065e9.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 07:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762787425; x=1763392225; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHhiNACwtPLvWt3UU8MHG4kcjsqq5PZ9cNakiqX/+fk=;
        b=N3/YeC+BmW7RWIqQlYNpiwVKY3kMdjX9NgzVHXceDHsoHhxVV60k2hV1pK2fbmbR94
         I6h9ih3V2z1G5xFf5Jmb0HaVddFYkAVV+GrSlcr7Qbl7/GQDXcdKnxXCL2Jod5NYTiVM
         nUpsz8CndyRoe3OkgFIVR4Th1dIJOvLaWe6hoZULByZ4T/UilGJ+Av4ObDgDi+8vdIIe
         SWVEz1PEU6EwtDSa1gBq2MCW4NNIkkvLinZDpQOqOyCEjhz8SHoVBi6B1vKtq+JKbtoG
         nO/bgddvCRSvbIKqz4SUz+Vn8j8KkyFXj+rd7m4amt0sNbyng1iZhSnOYv559pKpVipV
         0DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787425; x=1763392225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHhiNACwtPLvWt3UU8MHG4kcjsqq5PZ9cNakiqX/+fk=;
        b=pyPWvnC5JDI5HY7DLsRJlTlnLV5iO9NPx4ZnWLEYdyLMSIZS5skkiVEQpHS5LiWImu
         +UmrgwELSw9/ROWlGBQ1ZnJp0d1hAJxKO9/wHl2S53nf57ol/mw1SYkVyoZ2KKEbDt+j
         bTuzHsd0vgIb2QsjZtgIclwYTz9LQk2o6HaBcaAnTWV2Pu8ksOOXO/O5zcU16GZ9o9IX
         oWkxdIJ+EBoLLRK6MmLQOYzH8Td4U5h9H+r3HScLB4OhzrqJ34WcuNDgNcCJwqYNMDVm
         B1jNlkgyjwIwzNHP//RNWmfMolMnsrhDkE3yLDV9T9RsC/USW93xZYw27mDP5XYv8xTP
         MDEg==
X-Forwarded-Encrypted: i=1; AJvYcCXVhSybVDxaGdT9AjMvAVZbArrKL7DuqyCjyw4GryKKn1W078uVCX8kKMFNhRIIc+yWyWSU64AK9z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEvhFZ3N1/nqB21mT00X9nPfNEshCzjcAyJZXLSBNEn6CbaRI
	3j0cdt85a7DJ9HELbcjyv1Y+MDk7z2OVhpNOOd1a3WsbhVX4cPUnhg1M
X-Gm-Gg: ASbGnctMwQsbUys3UOJ42ZyS3ERtbvqVfHq7FX1RBbLrI8WvcLwZ9cPuwFuu+068o0F
	awlk3DI2OD7ZEwHujSfNjdKLz5VBxlbyqtR3P3a1f8KoZR8H2iIGEB9R7UjD5Uf25Dw8dkV7YqF
	v1Q24Zeoaarrmho+tXe3Mfz2pjwHJ6PrF2GLJAj8oVIqME7q1In5VpOQpaJshaxddmuCYTJU7lS
	8n4uGDjB37HMIGaZKWUkWux5sTDkUb2knkMt0+iDxkfrBPh3pai6yhBDby1Sk42O+MAtf1xJQiQ
	nK5JF5xvrK8zbVDWB2WKXDbznEsrWEJuY5j5uKw4RUnRqego+PlNzN1Zavp+IhvgxSaFh+XMSHG
	wS05uYaPP8RZnve3mx5kMj7RcRXcRvWCe+2OXtAaMW0S0MgxNzsr5Np08RjBJGcK0ch4V09NoIS
	8sqNF1h8u0kCjOxfztrDo=
X-Google-Smtp-Source: AGHT+IG1FdeoLFHPrIVWt45DxGvO2t555I8WDLNwgA8Cs0QQUwl5h3pf4ldR+8LWwVHCFvNCrdc4Lg==
X-Received: by 2002:a05:600c:5307:b0:477:f2c:291c with SMTP id 5b1f17b1804b1-477731e0345mr71759665e9.14.1762787424649;
        Mon, 10 Nov 2025 07:10:24 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63ba87sm23585387f8f.14.2025.11.10.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:10:24 -0800 (PST)
Message-ID: <e9620db2aab086914fd23dcbaf888be8d72fd8cc.camel@gmail.com>
Subject: Re: [PATCH v4 07/12] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4
 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko	 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>
Date: Mon, 10 Nov 2025 15:11:01 +0000
In-Reply-To: <20251109161614.671ab74b@jic23-huawei>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
		<20251104-dev-add-ad5542-v4-7-6fe35458bf8c@analog.com>
	 <20251109161614.671ab74b@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-09 at 16:16 +0000, Jonathan Cameron wrote:
> On Tue, 04 Nov 2025 15:35:12 +0000
> Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Properly separate the I2C and SPI drivers into two different drivers
> > living in their own source file (as usual). So that no need for the
> > hacky ifdefery.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Applied in a fairly manual process due to earlier tweaks. Please sanity c=
heck
> I didn't mess it up!

Yeps, checked testing and patch looks good.

- Nuno S=C3=A1

