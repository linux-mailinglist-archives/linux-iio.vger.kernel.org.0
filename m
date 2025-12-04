Return-Path: <linux-iio+bounces-26754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA0CA4C66
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74EBE306222E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4932C2EC579;
	Thu,  4 Dec 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW9eTQgy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9C1A9FBA
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869270; cv=none; b=m/epZmEqY5nIvNtnDpWNVLW7C2VR3aUQZUdtYJYhKb2LkuMomYdQc4UBAmS3r1uBbBsTBmj8HroFLMG/IKZup+QESy7iultMZq/09kzjuifu/0Wjbb6c4hhkO+BEb/b/ZL0ygQ8JeWtV9xCl1o7frBU0ur3Shj2WtLPFmbkj8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869270; c=relaxed/simple;
	bh=eqGqlfJDwmZx0z2EPrh+1X/MhsQ0Fjhr6WonNR2+vaI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nxtjNuB/StbZbhTbpjYJkzGsUe1A45csEZyNpH4ar8rIG3EfhDa3jLrzXmdETWz4tMEKPY+GhFbKgqBeOGzmFMCfT9Ib+DZMwvpiiajO9COkw5XfJRl3m6vWvtB82Eqf8Ql9gdKF4Gs5vc14bMd1EhORDijq3560NqJ6Ir2L2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW9eTQgy; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640f88b8613so1055246d50.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764869267; x=1765474067; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqGqlfJDwmZx0z2EPrh+1X/MhsQ0Fjhr6WonNR2+vaI=;
        b=gW9eTQgyMse7LN9/8o6odJOX1XGDfawPAKPrM8bhsJyI5zFvDSnsdOoKZuETIDqr6R
         T/QPs+7RI2cN/xmC9rPYTKlKp+DF6IORcdHzcRgPEsOaL2dW+lXLlzkHI9I828NixQit
         pVhcfci4JwLjNBlCOjkm92wbIhCfEfeFX2Cm/53JAUCfHtdQlop9qQh4qfkaN6kj+xm+
         s5CjpQTDMoit+OlhGiEAt0KnXa763PkeMfSs+8Se92q3mEFaulmty292JEyqfwmWJ2S6
         tLJ+l75UR3EigUXaAUVF95SHVYGHLO0dkkCmDHrpX8IKZx4gbZKhI4EC/33VzEynausR
         ZM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869267; x=1765474067;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqGqlfJDwmZx0z2EPrh+1X/MhsQ0Fjhr6WonNR2+vaI=;
        b=SAvmBjoHVCowpkix5LZKkywUZkCL1Ccn6VUhjDWSx2WwE3RKCTDkwptCsKT6TYwuIV
         fcKfK6F5wTpmREdu52z7/py+XRaunRbHL3Z9i9IxuY8VbdBk1ERAFWnTzrC5Bf1iPdI2
         6I2SDuqQ+pEhobEJJ053ntrFRXA6x3rnlafveulcWLYc/pL3bF4GK90YkHu9faAPprzA
         CUNAoTpsWghbwhR1vgJ219dsgqxx+HW34IDuI/jSeEpLszDSKEIGT2il6Bk2KECHxwmV
         FTeA+WN7CUfK6bkHUUApEC45yrLJ+rAaE9rWQJkXFG6hdh/GW8v3ozFmIYW4daHsYdUx
         PVeg==
X-Forwarded-Encrypted: i=1; AJvYcCU6m/sD7Hjmtjl2xFZ0jnyF3kXlIn1MUPFjZRvisR+2Mb96gr2h+2JCw/rJOAMoXTVOlUOyudPh85o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSiwXXfe/9fH6aJKhhS/GFh6Orj0zp+7XLpB1RNSaZl/CQt1X
	uTq7EyKhmbvILqKhXwhxl19iokWjmGSrUrW7DuQNmphqqQgSy7z4/PQz
X-Gm-Gg: ASbGncvYsmnyd6bo7K+hBC+6LWw8hQV8aUQfoc7BzoVAkQg9hNKFk1Om4mdn7qq6LhW
	M1LAYArMMZ81Ja0iRTHC5wAASxJjmc018SuCSoB9X1SO81pNKBR7gPEYQcSc2TImA7PGl7MRG82
	BnBwgGH1VQmogzjFKKK6pT1ZnpuyEiwGrSo2fPrOeWRVNLNNAdjPvsybJiXbz8JfjZHypFXdsYG
	25f6P4HIIKcfL894y0OFQs5X+EL3MeoroFQ5mwdkmuAduUaJl8YnImAOQFG9f2wVshT0mkVLtfQ
	brUx+Y6bDWKbFWmfz/ePaKp7buL2uYAQqtHfbbFkD0ne5eFcP0b3aMrE9V8kEV3gqWefRcwLWIC
	ehb/l5FH06SU8pF0UbghQ9BKbMy5dazS0EFa8tgOCVsLPGPUdRr3XHJrFtwQCw/37RdbJhwdtRj
	PpzPfpLA==
X-Google-Smtp-Source: AGHT+IFVmPrN9yCBS2cH9aAWPQBXj1xtArMxTEkDbv/AkGSDM9xx4AHqY9pQra4kUQ8H5Q/7FKOGIw==
X-Received: by 2002:a05:690e:1385:b0:644:43f7:11b8 with SMTP id 956f58d0204a3-64443f71711mr752690d50.13.1764869266395;
        Thu, 04 Dec 2025 09:27:46 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ca7d4sm7528147b3.15.2025.12.04.09.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:27:43 -0500
Message-Id: <DEPLXUZ8UPY9.38K72YVMTF84W@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck"
 <groeck@chromium.org>, "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 1/6] iio: core: Match iio_device_claim_*() return
 semantics
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
 <20251203-lock-impr-v1-1-b4a1fd639423@gmail.com>
 <9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
In-Reply-To: <9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>

On Thu Dec 4, 2025 at 9:23 AM -05, Nuno S=C3=A1 wrote:
> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
>> In order to improve API consistency with conditional locks, use
>> true/false return semantics in iio_device_claim_buffer_mode().
>>=20
>> This also matches iio_device_claim_direct() return semantics.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>
> Even if the rest gets a NACK, I think at least this patch makes sense. In=
 fact I
> would even extend it so that we have the same inline API with proper anno=
tations:
>
> https://elixir.bootlin.com/linux/v6.18/source/include/linux/iio/iio.h#L67=
9
>
> So it really has the same semantics as iio_device_claim_direct()

I agree. I will include that here and just call it match semantics.

>
> - Nuno S=C3=A1


--=20
 ~ Kurt


