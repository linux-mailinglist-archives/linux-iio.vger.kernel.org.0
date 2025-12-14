Return-Path: <linux-iio+bounces-27079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2704CBC1E1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 00:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75BA30062DC
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60EE2BFC8F;
	Sun, 14 Dec 2025 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLx/by4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDA27A465
	for <linux-iio@vger.kernel.org>; Sun, 14 Dec 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765756405; cv=none; b=VND6pkUF7LAzBUuuNJP+DxUvE3unb+d2DPy6fnjeiIrVeqxSJzpI2VZPHVd+NuK4gcs2HTCUsuQzXhuF26cMPsmcsZwv1Gs0L4BrFkFbTqbjrtqlo0OpjmF0GzB/irt6+Za/F1FTC43eEJr1vJiI6UOZBOK2Va98QvEAfOhyXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765756405; c=relaxed/simple;
	bh=imomqWpqkx+6bjRUCXg45LFde/m/ON6xIRymtOfup9U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z9ikGEqqJYYqA38UrMxTU8nEWPpfXdnFeKiTmcpzlldrtFX+3XDDifsIUw/5f3zRno+ycB8jNVys3T0KMnsHY2FgcVe8zubp0265cNhoc9/N732pdZtbGEW5Eiz0Qh2wpnSSUIL6R1Nu6VzEINqqsa+jTkXUqntVAsJLVVeqCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLx/by4D; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5597a426807so1902799e0c.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Dec 2025 15:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765756402; x=1766361202; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imomqWpqkx+6bjRUCXg45LFde/m/ON6xIRymtOfup9U=;
        b=aLx/by4DSNPUTIIAxfOjwNm5epKzulUATUZjVFYcZAopTYmCzNqX3EHp1uvwV97ToP
         Fuo2ARJUnfIatMPD3J/eG7VIVZZXfj098g0fWqZQHVqkygaQ3ANNCzfyzjCbtK2zLXXR
         PGrNMTuv4/DTVPZTDsozIKxIo2uvZTct/Sq8zvjwicG5vMcs5LYbLNfNkg0QX+Z17R3J
         TT+0n6Fd/4p7wB1zuGCEIWFzfZFMYQbawYhgQ0UxuWN+a3Dn12bS08z4RDphCMUlQXoU
         btZHSK9R9ciarE3dON/58ONd27nj2/ocYUaUDLUnbtQ/vxDeoEUl7HcwJasvM7VXFnNv
         RN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765756402; x=1766361202;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imomqWpqkx+6bjRUCXg45LFde/m/ON6xIRymtOfup9U=;
        b=P7nOgPiH4bezdn+bVWmhbKG3OQEUcwJb7BAKCVdTzZ4YN9yZb9dwc3qXPfdqHNpwNM
         wQqttVClKtOrgwmVlYnY6UAinhqZnveeLtogfDef00m+IpOanNjlhfBjq9cyKPgTLsEe
         hKJppesfYA9sJ3+UkVqWeuizS4qi+Yvu5tCyEZ+D8SHMHZc+MNoaBfxtoyrzFNpo3Sxz
         fWnTKit2rLlJ2PKjcDwSB6rYk7Q6zreiwNOClqdR/7Pg65lDvXOzynQWtjJBpVL+uWNK
         7n4FHQKgYAgPR0AyP6xw+qqaf1yrj+vcDSfIpK85VSBAt4DakcfadeEaPzB/Qa3nZzHw
         FrTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdQ7FNLpS8LaZ0wP3mOaBA8F54gOEBvH58GHkIZCGKBw5NcrsulnJAFBwN263vDYNAqTeDd0mW7Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcizJ/v0+NToDXuNY78WvHi1VZg+p3aSEk5upCcigOcBhCOQmA
	zP+DSCPdf85Ho5atvwrYk2HoATMEq+3Xo0QoPHdHzEnRMdmJoKl6oWd8
X-Gm-Gg: AY/fxX61wCewOMcNPAblrgS8JBu3UZHWmCP+JPnXTDWt/OIIoU3KP4sMj214cwr2jw8
	vrqvbfqg1sGHnCxoJr5jLQZmlvDo4/t0BiIwal7Gonspk0WIKj2y3qErdZt5V4meDWnY4/RM5bm
	QYGl/4ttd6yz9hxMTfUD0Bze+IdGa1J6QKGhe5TI4eNas9Sp55ocOThnLtEYo9UTZ8xi9k0yM34
	yGCm5IFlA0uNSUNqZBxsIG8IagZdWIWvKrVVlCj4aigxMwJJsukMhHb9ImsCj3xof7z0IwJxydN
	dCGnne01wAs0sus9gP29j1YzI6g6XPRbERUeu8Xa/USR1CIqCpUHPXWCCkTbi0AfeNTEKAmCqE2
	rOxn1A3KKA3fkJRjj106roQJNVxr0tOAgJv4OWoOD50yMEL2x8GEqor+HmoQxfgAs5J3hDVy4zv
	YwFPHW
X-Google-Smtp-Source: AGHT+IEoqQCjZSwLiCqkVJ07lox30kIA6ldc1LVKWm44vuHifiI/AUWhZSeSHNiSZdDgEAi1bOnPUA==
X-Received: by 2002:a05:6122:458b:b0:55b:305b:4e27 with SMTP id 71dfb90a1353d-55fed66a7b0mr3186745e0c.19.1765756402003;
        Sun, 14 Dec 2025 15:53:22 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:c6ad:1d0e:15de:a612])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55fdc638a23sm5590944e0c.8.2025.12.14.15.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 15:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Dec 2025 18:53:19 -0500
Message-Id: <DEYCEJB4SWZ3.13MX1YUFLI1QI@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Tobias
 Sperling" <tobias.sperling@softing.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
 <20251211-ads1x18-v8-2-5cd12ac556da@gmail.com>
 <20251214144839.2eec58f9@jic23-huawei>
In-Reply-To: <20251214144839.2eec58f9@jic23-huawei>

On Sun Dec 14, 2025 at 9:48 AM -05, Jonathan Cameron wrote:
> On Thu, 11 Dec 2025 23:25:44 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
>> analog-to-digital converters.
>>=20
>> This chips' MOSI pin is shared with a data-ready interrupt. Defining
>> this interrupt in devicetree is optional, therefore we only create an
>> IIO trigger if one is found.
>>=20
>> Handling this interrupt requires some considerations. When enabling the
>> trigger the CS line is tied low (active), thus we need to hold
>> spi_bus_lock() too, to avoid state corruption. This is done inside the
>> set_trigger_state() callback, to let users use other triggers without
>> wasting a bus lock.
>>=20
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> Hi Kurt,=20
>
> A couple of minor formatting things. All trivial so I tweaked whilst
> applying. Applied to the testing branch of iio.git. I'll rebase that
> on rc1 once available then push out as togreg for linux-next to pick
> it up.
>
> Thanks,
>
> Jonathan

Hi Jonathan,

Thank you, Andy and David for your guidance (and the little tweaks) :)

--=20
 ~ Kurt

