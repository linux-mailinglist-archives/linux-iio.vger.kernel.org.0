Return-Path: <linux-iio+bounces-27384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB7CE009B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4346530024B1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234371BEF8A;
	Sat, 27 Dec 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv8FACGA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738532692E
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858330; cv=none; b=f3iKkGX/NvoOfcVSIZIiTFRPdcJdEHxOgEpegwtkAIQ7HhWTZRuAGcFqFpLZgiFoqt47VyFS57x/c2VoWK4AplZzsAd2K7euJfGZBuqHF/oxF6hSHXEbE4xPutuvTRpOd0mYPCXCxdgd/XNCIAba8zbaMmRCl8A09gnsLTWaShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858330; c=relaxed/simple;
	bh=unYrbs1T+wnAEQdMdfCauI1Sktq4y8Uw/FBTmPNJYzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LqBcjBmkota1MZPHdOOoSZ5980kmjsTX1/d6dNPqnpDdA4mtjF2cNhKKH7glLfiwSHcQ1pLwOrwhKtuD7aKZ2zKJXRN1zLD3pGAKTyas2EVG25BQJMJhdZLfD+LHGGe4BdWh2oA8ppM77NTziqiFjnGJYHDKrHLT1V1hTj7m2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv8FACGA; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55b1dde0961so5989724e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766858325; x=1767463125; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PQuMr6wBVUJuyrHrhYcC4MChvAIPzu2L1/FVbd0FA4=;
        b=Nv8FACGAuaT//jeZtKXgg/fwzb5Kh2MBGh5MB53oPYqDlhhgqNMtmJFPj98rbcNgvB
         ML5DTMC7SEkgjfbPs0w4UGAcJKtbpa3QK5gdycte969G/2DnIkPtRHl6O86VSy+YpOWX
         /vGXknKW5hQDXL28P8sFc1iB4fqOcdVB6dXafjvdQZbhxAghsEzSARCENOvg70YMzhUQ
         6sJ8fLIyxLqBTSDFLtf+VKqoQXbwZW5aJyhMp46xqOx2nhH7XMezk/ODjAsTv7IuIS2k
         iU5NeSCqCkcnCx1fO9vGq+LQHd03AqVJFH92mKZm0EMYv7v0uJUV8y99yUr4E+s49OVp
         IVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858325; x=1767463125;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PQuMr6wBVUJuyrHrhYcC4MChvAIPzu2L1/FVbd0FA4=;
        b=P48FuxF2wUAcC+Osm/oo4zXvgYxzTi+fyZ2dkjKYRGBT9lmIWppSAmTssVsjHrO4NF
         1HFNsA70q4Mqz0MfpI8nzeBqlICp4JcCQ0zz3yOAmAMkrEppiYj0KdCq8QGGkv/PqK/x
         5VY5A/9R2F1zXHAu06s0IZeMxZ11OEwq4zGQl7BlVaLylnvvam+EaSJ5yb8jM9Cc9Gry
         N+s31xUKK4Rcf3tGV7iczHy3rZbMlEYAZ/ftKW4JYhqGWWUF276BTls80MTeYfLyAlnE
         DEOyWIBlDyqqT69/Mmxg2mDA5tobtAD7nvoydZaxL37125GV5eb2hbt0SQdv7KXm187M
         7VnA==
X-Forwarded-Encrypted: i=1; AJvYcCWrIv2mPlDy2LSKzshVf9J9q9f+hmFHHq26uU7aBNKmpxAEMLxODoluALDgglxBGkcGnkItOAyp1mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywubrl2l9ztfq0KD3AYnTebKSIoZ4cZJbSP+JSfq3Pg60hy3oNq
	J+ytb6zzESXujwCoPp6maYSI0Xr+LzVueeq1TEXvSmQqgyDYo9uTfDQ9
X-Gm-Gg: AY/fxX7ho5m2WNiJVaHWI1+GMN52SURqJDrIHSgLDy5OOq6xSvuP7TGS6dRik7Gpwyw
	xLeuVrvuufw+QOzlijScAHS3lyokiO90gyYtG7lwGTol5MGQ0WmfNtkw8cKvyhBoR6+OGwO7ZCA
	SFteUdWO47Z6Sbi4lyfQZ56/tLXP+4o6K7uMcYMJV4qguj5kTDIx6s/MrapGwH6Z0r1m/F+P73R
	if8W0JcKxcqYDAn9kZWAcMU0A4IODENl1RKXOhfJm/H024J4v8AFvnXXNn3KzwczgiVqN43xn2b
	Mm9nYUtfArNmhDhdHI8njPcm1Pz7WoZoHOXE2ecV1EBdlZA1pLCHeS/QxbBowSLRVW22LswDt9F
	kQTRq8/dj35j/O0GZVvztnjWJ6xiV4JYPm5yRODsi9JWhL/q9bBNK6hy6VL00qA0ocWLRLdEuCn
	yw/A==
X-Google-Smtp-Source: AGHT+IF5qieJEyZmb6QmnGjcQXf/tzE1xyqtk3YZirur3Xb0fzxTbnHNfA2HC5NRTch0STJMLcwhFw==
X-Received: by 2002:a05:6122:238c:b0:559:79d8:27a5 with SMTP id 71dfb90a1353d-5615bb9b5a0mr8288055e0c.0.1766858325180;
        Sat, 27 Dec 2025 09:58:45 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d165f2csm7886851e0c.20.2025.12.27.09.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 09:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 12:58:42 -0500
Message-Id: <DF97040MFVN2.18VE8M36CAX80@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-2-6fb47bdaaf24@gmail.com>
 <6ad0f764-91f2-4946-81cd-9363ec87722a@baylibre.com>
In-Reply-To: <6ad0f764-91f2-4946-81cd-9363ec87722a@baylibre.com>

On Tue Dec 23, 2025 at 12:20 PM -05, David Lechner wrote:
> On 12/11/25 8:45 PM, Kurt Borja wrote:
>> In order to eventually unify the locking API, implement
>> iio_device_claim_direct() fully inline, with the use of
>> __iio_dev_mode_lock(), which takes care of sparse annotations.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---

...

>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index aecda887d833..76398dbfa5ca 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -664,30 +664,42 @@ int iio_push_event(struct iio_dev *indio_dev, u64 =
ev_code, s64 timestamp);
>> =20
>>  void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_de=
v);
>>  void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_=
dev);
>> -bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>> -void __iio_device_release_direct(struct iio_dev *indio_dev);
>> =20
>> -/*
>> - * Helper functions that allow claim and release of direct mode
>> - * in a fashion that doesn't generate many false positives from sparse.
>> - * Note this must remain static inline in the header so that sparse
>> - * can see the __acquire() marking. Revisit when sparse supports
>> - * __cond_acquires()
>
> I think we should leave a comment that says these functions need to stay
> as static inline so that sparse works. Although I'm wondering how sparse

I'll keep that part!

> could still work since __acquire() and __release() are removed here. IIRC
> it was a bit finicky about that.

Now __iio_dev_mode_{lock,unlock}() are declared with __acquires() and
__releases() tags. These are then used conditionally in
iio_device_claim_direct().

I did test every driver with `make C=3D2` and it seems to work in the same
way.

...

>> +/**
>> + * iio_device_release_direct - Releases claim on direct mode
>> + * @indio_dev:	the iio_dev associated with the device
>> + *
>> + * Release the claim. Device is no longer guaranteed to stay
>> + * in direct mode.
>> + *
>> + * Use with iio_device_claim_direct()
>> + */
>>  static inline void iio_device_release_direct(struct iio_dev *indio_dev)
>
> It could make more sense to make this:
>
> #define iio_device_release_direct __iio_dev_mode_unlock
>
> To make it clear that the auto cleanup functions that come later
> don't call iio_device_release_direct() but rather call
> __iio_dev_mode_unlock() directly.
>
> Otherwise, someone could be tempted to modify the iio_device_release_dire=
ct()
> function and the changes would not have an effect when auto cleanup is us=
ed.
>
> (Same applies to the release buffer mode function.)
>

Agree. I'll implement it like this.

--=20
 ~ Kurt

