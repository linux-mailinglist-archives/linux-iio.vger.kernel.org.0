Return-Path: <linux-iio+bounces-26564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F2C94B1C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 04:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D154E4E1750
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D01F419F;
	Sun, 30 Nov 2025 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax0zY2bw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871463CB
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764473509; cv=none; b=W9HkvwpbeQrmQYkKHfE/c0316H0XPuVRwaPJPpMBo6WVNIsWkc35mlxR/U2AhbopbSQCDGeitQWhFvJoYvYRSbVLyR9hu2tekyiSiKkyZ0wTzm9NzYr6MzcUq+33qVQsFN2MjfJqeDn8Ra1WfnFIwWg45/tuGdE6VSGA2vKtxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764473509; c=relaxed/simple;
	bh=0Jmug8C9Wt13WRpSx0oCy5aLyOWe463+u5m1tiDTA6A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=CA/S2wixMiyCruHJTe7Nkr+ht0NL5+gy1lkl6nymRhL7vQUCZL+tz+3z9cYaOuGlljMQRbQuRcFI08T2ho/sv9ly5QTW0GxPBC37sFEOMbWhlzPvSQkg52PwC7BNxyAc8bIoy82RllA+phgxlAkySMxwdb0XowXizVn5+WZoIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax0zY2bw; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dd6fbe50c0so1216933137.2
        for <linux-iio@vger.kernel.org>; Sat, 29 Nov 2025 19:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764473507; x=1765078307; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNXcJkrLq97RKGghE/tDEV9K/VHLf6K0n2K5yQgJjy8=;
        b=Ax0zY2bwa43jnuapddZFeGsSNmuFp4QWxJ2rKCIRGf/G9x1F62uuz3Y23/az9m/PFh
         YemYypHaDvQDNNERa26IvMa87xwdxyivD8REjUseQ9nQX+uK8Ww3ijEuG0lXdDzh0t1r
         nw15o/umJHVw7cxBeZfwpnv+ULGuj4Eg0RA7jqS99XZg1DwGNxnhunnuIdzTn6nedKh8
         Qg8xlW9qUu6/MzJAoklyCPPfTjgMaR3ZJhxlxSy2bjHITJCSj+oWfi8v1+D3vrVfKtZT
         ihbv0aZHUN5UoatNWRIcdzOjx/Ww735qdyDBdihl/1u/dm0twn9bWh1rQSzPsZs1i+UK
         0EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764473507; x=1765078307;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNXcJkrLq97RKGghE/tDEV9K/VHLf6K0n2K5yQgJjy8=;
        b=sSJFMyOPuCmh0saCzKEhmosNs6zxiP1902yl5dcVTtWnd3xuD0TNO2BDT/7Y4WwtgZ
         IhF9wVn8SaKEWFnbkC/u1KjcKcJnuD1x/VoKThN2hSPwoT03/IcQqkWK2q0PXxQd9cBY
         meVMn/UlSC4jUHNmKkSCoodxh/JfT85RzW/Mn2j2N0xz3Sq2cMzJWnzWLqe0vheVWaug
         7ZLwXS4CiyXlQXJMp3PU+AXEcGKEBi9m3VpjC2ZnKyOexeAuZXoRCqvyt5tW+3NRbyzN
         6/yZ7vJQjtGHaEJmRDyDB4/v6JsxGVOaQIRQRxwCtVezl1ojVV7NE9mVOW+QDKErw/AB
         pQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUe/ORCuq2tBexxVQ6xWKLkuIMEGNk0cWUr67j6eXQlEg98BQrsw7JcKmBDYx9rKz2ox8yBElhFXxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynIUjhIGl8qsiiJvuKNKfqHpeqG91l71K10HVo2WF4Y13AjHSU
	p9Dehl4mVjZIOmk1oEV5gQXFRsTGMqbBdcRnr1BnrBVI278IXMYXjNki
X-Gm-Gg: ASbGnctA5TozOArSV8eWw3ezWrfflK1j0GI3rXhelJ3yt8IMkICXEKo461DQ6QMqVM5
	SoTObhXXD1AqJRjFRRx0lig7bjfzuTvw3+LVLQQ7qD3jZ0nA/1VCeyzhKPXmSNgv8WwBwl9uzmB
	jGmJyqBwjs0Odfz9rcyqNuiJwiFujEVBRBcTFLlgXHdGN21kPmZMgSAeeIEp1CZ1iElXTftBJKM
	2Baq9pTvKm5Ibgu+H0XhfeIUVuzyovoND6HNDd3xS0Ra+X1iqZeaf380TgSgIFiZQUV1khxBEbq
	48B0Ap74OOieiJzMf/Z/+Ra8LKuX6eVPEKrpq0H7e5smt9VLuxO7D8VCNmk39hcRZ+Iy+duLNUZ
	lUzcRLy5dn0dUkhS/pKMopK7r+NV9nWo+Wvd/yY151hcPlRxZWIOsM+azZcPd9byhvUF8HDov//
	w6X+o=
X-Google-Smtp-Source: AGHT+IHP1Gk+IT+glfYKtU0OYJDb+d/EEpIw57u9DDRyfDuHa31Js4CEqSYzL6VsQPevKFPxoAG2Kw==
X-Received: by 2002:a05:6102:334c:b0:5dd:b69a:cdce with SMTP id ada2fe7eead31-5e1de0eccc9mr9460400137.1.1764473506918;
        Sat, 29 Nov 2025 19:31:46 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd6ce2180sm4130942241.5.2025.11.29.19.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 19:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Nov 2025 22:31:44 -0500
Message-Id: <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Kurt Borja"
 <kuurtb@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Tobias Sperling" <tobias.sperling@softing.com>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com>
In-Reply-To: <aSsBdJZDWcadxEHC@smile.fi.intel.com>

On Sat Nov 29, 2025 at 9:21 AM -05, Andy Shevchenko wrote:

...

>> + * @ad1018: Device data
>> + *
>> + * Calculates an appropriate delay for a single shot reading, assuming =
the
>> + * device's maximum data-rate is used.
>> + *
>> + * Context: Expects iio_device_claim_direct() is held.
>> + *
>> + * Return: Delay in microseconds.
>
> Does 0 have any special meaning?

This function is never 0.

...

>> +	/* We subtract 10% data-rate error */
>> +	hz -=3D DIV_ROUND_UP(hz, 10);
>
> Hmm... For delays I expect to see adding 10% to have a good margin.

hz goes in the denomitor bellow, so less hz is more delay. Makes sense
because worst case sample rate is less sample rate.

...

>> + * Context: Expects spi_bus_lock() is held.
>
> Do we have a lockdep assert for this?

Lockdep checks lock is held on the same thread right?

Thinking about it, this context is wrong because we don't hold the bus
lock on the same thread. Rather we hold it to avoid other devices from
transfering while we hold our CS line.

I should probably remove this context and mention this peculiarity in
the long description.

...

>> +static int ads1018_read_unlocked(struct ads1018 *ads1018, __be16 *cnv, =
bool hold_cs)
>
> Hmm... Don't we want to return value in CPU order? I don't know the answe=
r
> here, and IIRC IIO triggers might be actually good with endianess convers=
ion
> done, if required, in user space.

I specified IIO_BE endianness in each channel's .scan_type, so this
works. However, I don't have issue especifying IIO_CPU and just
returning CPU order values.

...

>> + * Context: Expects iio_device_claim_direct() is held.
>
> Jonathan et al., do we have lockdep assert available for this?
> I really prefer to see the code for it, while comment is good,
> it is not good enough.

This would be nice.

...

>> +	if (iio_device_claim_buffer_mode(indio_dev))
>> +		goto out_notify_done;
>> +
>> +	if (iio_trigger_using_own(indio_dev)) {
>> +		disable_irq(ads1018->drdy_irq);
>> +		ret =3D ads1018_read_unlocked(ads1018, &scan.conv, true);
>> +		enable_irq(ads1018->drdy_irq);
>> +	} else {
>> +		ret =3D spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_bu=
f));
>> +		scan.conv =3D ads1018->rx_buf[0];
>> +	}
>> +
>> +	iio_device_release_buffer_mode(indio_dev);
>> +
>> +	if (ret)
>> +		goto out_notify_done;
>> +
>> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timest=
amp);
>> +
>> +out_notify_done:
>> +	iio_trigger_notify_done(ads1018->indio_trig);
>
> Jonathan et al., maybe we need an ACQUIRE() class for this? It will solve
> the conditional scoped guard case, no?

...

If no one prefers to do it, I can submit a patch implementing this. Same
for the lockdep issue above.

>> +/**
>> + * ADS1018_FSR_TO_SCALE - Converts FSR into scale
>> + * @_fsr: Full-scale range in millivolts
>> + * @_res: ADC resolution
>
> Add here something like this:
>
> *
> * The macro is crafted to avoid potential overflows on 32-bit machines.
> * This imposes restrictions to the possible values for @_fsr (less
> * than 274878), and @_res (great or equal to 6 bits).
> *

Sure.

I'll address the rest of the comments in v4. Thanks, Andy!


--=20
 ~ Kurt


