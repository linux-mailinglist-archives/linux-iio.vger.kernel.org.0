Return-Path: <linux-iio+bounces-11755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590C69B8D6F
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 10:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B511F24065
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FE1157E78;
	Fri,  1 Nov 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cldo86Uk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7513154C0B
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452040; cv=none; b=BHjTj1yOYtxRGn1c0pbWfyjXk3n2679wQVZ3iN0eY1/mGxYFCQ//TCYA4iNCFe0KgpwyVNT7h6WYzdbYMK187W/0+u7DUisuLDq9Zmu55hx7fxGRja/WByaoH4ljt6JAs5l3mSGr+asWmum+45T+2Ke/2yXj28g36azfIVlMgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452040; c=relaxed/simple;
	bh=ACJJRQ1tSBj/PagPfjyn5Mt3OZak1fC/XApix33RgaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYUE2unqWttQrDQqiks31UqRmLRBP2ytRDEHQ/io7dbNhnMetV7BCiH2BMdnKHrHRBh66AE7odCve7RyT/bk3wsrbH4qa2YU9/4puwAyYhvqU5LpeEMxM94qS5DndjBAccfBttgBtiZZfDJbFSI++jbMJarUAXvl+09Ir1IIGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cldo86Uk; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d2e71de18so592507e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730452036; x=1731056836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT8ZiELAo/qpmpYFHSS+6cqtNCiLfewPD+HuZPIlUX0=;
        b=Cldo86UkTTuooYDPXta1bCIHopGTTmID6Sx9A9h4OuItPbQJRF9a57Uk9+dTs9dZm0
         dNbhI5kOJRErDq9+9V68UTwyRN7lJ7iXm35/zkvEJjRaMrXr2bTctbLi+aITtdAxpb4Z
         XQ1b0MVgoSzPVDqkI7Z3RBO/Wok6mQxLaM2i2/niwEzSrKlZmmuV4ILP5oTz/hIhlbil
         pKRFzE1Ixwrd6IwRLjVJdn1W/LH7cs0cBhNqcoQrR+kmHQG8KmrrrnKDmpVk+L9jrt2a
         vjf0YfDKtYqaccFBKfjR7NOIk8tb9tf2r9zvTowGuA92xm0eZjcJA5pJxZpIiNCYxxse
         GMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730452036; x=1731056836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT8ZiELAo/qpmpYFHSS+6cqtNCiLfewPD+HuZPIlUX0=;
        b=Eq7EfOGRimR2I4gGpPk6shxu8NYBMHrUIi0mmBv6iMz2hW8/shfT9zOV5WNLATeqRL
         mDvTjoeaTmxOw5j9ehsVdqldNFcIgg3dnB0Rx1E69rj5FAouYuM9B2pXcMLnnl25BxjD
         l9RPoyqCXEu7Rbs29o0ZgtMIbjPw1Mj6Nsh7jAFh4y3zh9PHzGewFBZLmQR3XRwXk6XJ
         EF5svzIqdNp5ibGdzgwi3fPqG8QfMQPt8Q0n4KDvFODEiHuMweca7seB7XuwSk2o9E7i
         3rQ6bGtou14o4msoPsCCovKn0M3yC5xtEhNuM9aNZcG6y+X1q5boiz2KSnyiSkf4sZzF
         j6fw==
X-Gm-Message-State: AOJu0Yw80kUo4LvnEGE/JizjDmGbxj+nSnrWdqOAHfh0ptv2aoFCIN7o
	yukeBg9eFQ0RJ3vqf2gk3Df3X3WKZrRiRswdlK0NBOddDgLsJSZJGnCMcdMeXfMVp+7WCVifR29
	r5Aar6SK8Jhz68jdeNNAun4T1mPo8AnsJbJvNRG4xONEabe+1iYYhkg==
X-Google-Smtp-Source: AGHT+IGbUTRRz86eEDv3TIajVVkB0mtwcL9oiYycvg5A/+hrXFVSa6n6WIyuzJR7bvvTXgt/PVGnRh7rp3aBoxGndZI=
X-Received: by 2002:a05:6122:20a2:b0:50d:5095:f02b with SMTP id
 71dfb90a1353d-51014e9a3d7mr20928028e0c.0.1730452035618; Fri, 01 Nov 2024
 02:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031063707.795842-1-aardelean@baylibre.com> <20241031185906.064d733825c176addd48a733@linux-foundation.org>
In-Reply-To: <20241031185906.064d733825c176addd48a733@linux-foundation.org>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Fri, 1 Nov 2024 11:07:04 +0200
Message-ID: <CA+GgBR_tCVVo75+eOxtxEtFdCMkAWFiHjm8eAfPYt+sLBGjBFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] util_macros.h: fix/rework find_closest() macros
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	bartosz.golaszewski@linaro.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:59=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 31 Oct 2024 08:37:06 +0200 Alexandru Ardelean <aardelean@baylibre=
.com> wrote:
>
> > A bug was found in the find_closest() (find_closest_descending() is als=
o
> > affected after some testing), where for certain values with small
> > progressions, the rounding (done by averaging 2 values) causes an incor=
rect
> > index to be returned.
>
> Please help us understand the userspace-visible effects of this bug.
>
> Do you believe the bug is sufficiently serious to justify backporting
> these fixes into earlier kernel versions?  If so, are you able to help
> us identify a suitable Fixes: target?

Oh right. Apologies.
I keep forgetting the Fixes tag.
Added below.
I can also do a V2.
Please advise on what's preferred.
I'll also admit that my attempt at explaining the bug (in a general
way) looks a bit wonky.
I'll try to re-formulate the bug description for a V2.

---------------------------------------------------------------------------=
----------------
For this reply, maybe I'll try a more "timeline" approach (for
explaining the bug).
I'll apologize for the amount of text I posted here, but this bug is
one-of-those-LOTR-anthologies-trying-to-explain

The bug was found while testing the 'drivers/iio/adc/ad7606.c' driver;
particularly the oversampling setting (of the driver).
Taking as reference the oversampling table (from the driver):

static const unsigned int ad7606_oversampling_avail[7] =3D {
        1, 2, 4, 8, 16, 32, 64,
};

When doing:
$ echo 1 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
$ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
1  # this is fine

[1]
$ echo 2 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
$ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
1  # this is wrong; 2 should be returned here

$ echo 3 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
$ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
2  # this is fine

$ echo 4 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
$ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
4  # this is fine

$ echo 5 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
$ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
4  # this is fine

And from here-on, the bug goes away. i.e. one gets the values as one
would expect.
The bug no longer happens as in the case of [1], as the difference
between 2 values (in the array) increases enough, such that the
averaging (of 2 values) no longer causes issues.

Initially, the assumption was that this bug happens only for searching
exact values when an array is monotonic with a progression of 1.
(One could argue that find_closest() is not intended for arrays of
1,2,3,4,...N).
While trying to create a fix for this issue, I started writing a kunit test=
.
That produced some other quirks, but not as bad as [1].

For example, this array from 'drivers/hwmon/ina2xx.c' &
'drivers/iio/adc/ina2xx-adc.c' drivers.

const int ina226_avg_tab[] =3D { 1, 4, 16, 64, 128, 256, 512, 1024 };

While running the kunit test (for 'ina226_avg_tab'):
*  idx =3D find_closest([-1 to 2], ina226_avg_tab, ARRAY_SIZE(ina226_avg_ta=
b));
   This returns idx =3D=3D 0, so value 1
* idx =3D find_closest(3, ina226_avg_tab, ARRAY_SIZE(ina226_avg_tab));
   This returns idx =3D=3D 0, value 1; and now one could argue whether 3
is closer to 4 or to 1.
   This quirk only appears for value '3' in this array.
   And from here-on the current find_closest() works fine (one gets
what one would expect).

---------------------------------------------------------------------------=
----------------

The above is one way of trying to explain the bug.
The other way I am trying to explain this bug is through the kunit in
the 2nd patch of this series.

But to answer one question above: this bug exists since the first
introduction of "find_closest()".
Circa kernel version 4.1
And it only affects several corner cases (of arrays).

Fixes: 95d119528b0b ("util_macros.h: add find_closest() macro")

>
> Thanks.

