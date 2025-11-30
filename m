Return-Path: <linux-iio+bounces-26574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA51C9527A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDFA3A32C1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D6298CBC;
	Sun, 30 Nov 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoPKtuEi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F6126C17
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764521145; cv=none; b=RpJ+RSIlCxIGBLjfdtqBFadHoueZ8K6sdjMjG1naGYzYlM/R5Uf8hZoEmACWM7V7itrHADhW3ZfXQlEMgdCKD1dGadgDzEQ/+Fjut88qV6VOIo7W84vhI46jd9d/0WuCp6Hr82DcqS4uw7LVoRGit0bzfvsNNRrTeit8j2eaQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764521145; c=relaxed/simple;
	bh=QRyBqvtmx2ubpzl9DI+h2Fahv64heZ9ghFbpZt9ATCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLBXTqpp/TpYIavav2GZNsjvZTJut5dDvj+9TzHc7beNLVifmi0R9oKbBy9dH+aOTvymcu7GzVF0wlaoBBsy/U4pKizZrhVJ+hVCshC/tY4AzD1fv+PrnUv4Fn/ib7H6PwhaytNPfz2xxk2lBWw+ztSHf1WG98fvUxjPRLIbOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoPKtuEi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so5026197a12.0
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764521142; x=1765125942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xyBotyvFYthL5/710vpr4HUBIeYUUX2BVNXyDUWzv0=;
        b=hoPKtuEiQ9p1stAEJrM/gszrSlxrMpHP83DC1oqrfBj2e+3DWle6lk7uCceTZr/u0Z
         MdTIj+zKxCBpaPxZD6YUGzLvbu0tJs+WVrDraG9LXovD4/3/7I/NSdWJfze0sGQGHeII
         wjVbcplvesyraDTlA+rx4EfjT/ThQXCWaY41Jf+zOb4o4pMmZfmAGlQVa4N65CUcRZQM
         hg00MxoEb1/lNB+B2kvIgs6NPPmkcuDVUm81178AwVz9YzroGBPCxXHBsP0QHuydA6Xw
         qnK6D4j87b1+VEH346zaJwzciVStX2Zs2XnWUjim1KANvTEidCo4DXC/P9nwbtyVNOPp
         c3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764521142; x=1765125942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xyBotyvFYthL5/710vpr4HUBIeYUUX2BVNXyDUWzv0=;
        b=apXWnfEH78O1Rf42Aj4kwAXfd6+/PtjbLNUR516v3lN/753eHu4AEEzIid9GgSgOvg
         jx1i+myLuhdgWilBBCElLEfWqCJsXvAvwMqTQQWZlhk5ci0vep2kYJq8iPwczHovdJ6P
         Z5h2udn3hoqnqu/JNJ7w0A0caOH7vNRKhVMWDagNQPB4NMbhCPC0myUYoOvE+Kh9kMGI
         jh2JadEeL5JVkvs+H/5u+GTXisDzNkFXt8ZXBxlKHk8iBUa6ylYSQhwUg0Hu2AJ2wbC+
         pvZUv3cQU7ZzuGHRK2pV3aG2cbavFxMF4HQHW0uWBvwPtwDobIdlMbxzeR2JERUK4VR+
         LC7g==
X-Forwarded-Encrypted: i=1; AJvYcCXHnTffIsySPO/Gmpu+F7+1gGeVPYTEC74atKYiLerA6tSijC21iPwEU+JCDijiWhFdTbASsKXBzVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/fy/K9MoxeYH5ZPt5UYkuA+Lr/PfNTAPtDV4Q8xZmmtRjcjN
	n2XTEGoqygFN/eYiwazBMpUUH8xo20EPc53LehVzzcCLwxXb9WLraYBETKwyn8G0KuU7mGte1jU
	bnNbht2je76/iAv+QcnHfLvLHJyZl8lM=
X-Gm-Gg: ASbGncsHAtl39oICjH64jZWdbL7fjagMHIw7tEoQrcyC26R/6ydvrcjpcUchCrVWfXc
	2crhBydcWTBw0bE2SswJQre0OI+CBGmU+V3t7M6sjPbSj/7H0j19BUrgrHR+jU12DGHxkfXzzw9
	tLCuUeriGqteZmPE6RrMSEZS8YuVMeC0Eh2ekLJ53wn+/r0HtJuqbup0KT1B8/+k4eihYm8gabZ
	k1eB0WP4zNwOVC58MDWRbvlrR6DVWNX7QOzX+LTbPoivnCaERbzHE+ongIRhUD4Wx3bPZpRz3SO
	E2f1GPQ7EgrRwTVzM5Yq9J9wAJ0MbxNEJEYRHYQ+11xCsujd+7V0h0ZffnZb9W0mxETyk3vSEQE
	AFqw5gxs=
X-Google-Smtp-Source: AGHT+IHbZtnNlDAnCT+6deJEg4KOrJR5Cd+mQ2OA1sju00H4PKIStvn30XJxtn4VJ89XiqS8GvovsKiIbRg7rVZE2Yc=
X-Received: by 2002:a17:907:da4:b0:b73:3ced:2f66 with SMTP id
 a640c23a62f3a-b767159eea3mr3678850666b.14.1764521141522; Sun, 30 Nov 2025
 08:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com> <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com> <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
In-Reply-To: <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 18:45:05 +0200
X-Gm-Features: AWmQ_bn83Y6jJoqRo9Uw92wPt1-SaVGR2ryYOyWklBRViqubbIxWrE_QK92uBsc
Message-ID: <CAHp75Vc3Reh2OzbEzKk7P+wG40Ys+jfsejZdwQZD90sJcv6skQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tobias Sperling <tobias.sperling@softing.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 5:31=E2=80=AFAM Kurt Borja <kuurtb@gmail.com> wrote=
:
> On Sat Nov 29, 2025 at 9:21 AM -05, Andy Shevchenko wrote:

...

> >> + * @ad1018: Device data
> >> + *
> >> + * Calculates an appropriate delay for a single shot reading, assumin=
g the
> >> + * device's maximum data-rate is used.
> >> + *
> >> + * Context: Expects iio_device_claim_direct() is held.
> >> + *
> >> + * Return: Delay in microseconds.
> >
> > Does 0 have any special meaning?
>
> This function is never 0.

Would be nice to mention this in the Return section.

...

> >> +    /* We subtract 10% data-rate error */
> >> +    hz -=3D DIV_ROUND_UP(hz, 10);
> >
> > Hmm... For delays I expect to see adding 10% to have a good margin.
>
> hz goes in the denomitor bellow, so less hz is more delay. Makes sense
> because worst case sample rate is less sample rate.

Please, rephrase or amend the comment to point this out. Because at
the first glance it's not obvious that subtract means delay increase.

...

> If no one prefers to do it, I can submit a patch implementing this. Same
> for the lockdep issue above.

If you are motivated to do so, please do!

> > * The macro is crafted to avoid potential overflows on 32-bit machines.
> > * This imposes restrictions to the possible values for @_fsr (less

s/to the/on the/

(in case you stick with my text)

> > * than 274878), and @_res (great or equal to 6 bits).

--=20
With Best Regards,
Andy Shevchenko

