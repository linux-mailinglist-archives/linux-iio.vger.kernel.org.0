Return-Path: <linux-iio+bounces-2478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0824E851B9D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 18:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644FD1F23051
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB13F9F1;
	Mon, 12 Feb 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DguiPWSz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A703F9D5;
	Mon, 12 Feb 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759234; cv=none; b=Met4r5Zj2tPnQZ15pt9BXNqBgAEFHxQgWf5SyJ4OL+JTlHswC0qca9oytYPKvIk+PF9BMpKFXzPYijq/xDTfUzZ6ZduzN1yDxW111dvNcyt23lJAYNnkRmyoceBlp/7QQ0DXzacGR5+aTI+1/4thRBDN3S1fZ5agr3BTjwBmIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759234; c=relaxed/simple;
	bh=hEhdVQpRKnswqbNspAVD0fMVZ7h9rWmoFPnD7QNOB8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXxtiHBOkbhS4tfqag+cwcU6Z7c0BsGSJbBbaRcYwuEtQIxrO48geCydZ8gmuu8EwIwz27YkjeAWufAVFUB10UfeK/ayO6SA/vFiRImNGVg26/LQ7HBYbmQPly3osIr2V9w7+mSVtUMITsRzZ7cP89emv03/83YfzrMbHkWITxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DguiPWSz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d73066880eso32036085ad.3;
        Mon, 12 Feb 2024 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759233; x=1708364033; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1VQyb7QOuBElKWvlJ78MD8OwjRNNlm7Ekb3Ty82ccyk=;
        b=DguiPWSzyWBkMiNy41DYFrErvrQFtqV7OGvKw5I59SY8MOR+RNl9QEhaTl1jRGQP7p
         +20npy6aIaIQts6UHVm5qPOoRqBeW3FIWs7uZhtTAu16HUh7ZfnoFgDqcqJOyiS2FsD4
         8gnu3hiPoHu957Z+bias8gLPO+FLnHhAcAzLrL5nN0t+ieefJPCGT4Mu4p1WBpBSII3r
         if85x8Ko60A5S596DqdknMgFUefZfHZMKNehm8wRwtOaiToFURTMltjCavvZcDqWYJbz
         GYk0oK5fDaFLMb0269nHcReCVF0sn1QFlwhWX62fh6tZc4u7SIMiSebl3aae5dxebqNk
         wmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759233; x=1708364033;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VQyb7QOuBElKWvlJ78MD8OwjRNNlm7Ekb3Ty82ccyk=;
        b=l/nbfW0AAUrBjwE58R8t5FxKT6Ex8ZkTuqz2P9H73nE4TuHuAqNjVlqtIjg8ZiBjaw
         dUTVVwVCNE7pfaBjul2R5YqFX9L1Bc1l2jyQES+Y+wZKnsnpS7ELYw3u3ftPI1Oaa/NO
         Z8CCM40vpLGpLlEzOPqsHIfTXMNK3aYZA04mC+mfiOiEp7CbGj0pWw71/4idjOhe3BB6
         xdAH2GVpFZvZM3lqSx4PqrVxw0SX/vDQXqiwSg1orFV1pGqGUkMFC3WPCZCQ0l1kqd7i
         DVbthXmPA2FwIKqTMnM0bNwW5BWnd7F6YzPLHL564Sg/w6Ed0ErXr+Dnd8ssvOjQ1Nfw
         CqKQ==
X-Gm-Message-State: AOJu0Yyc+D6qh8pFajmiWTA1ouEnBeXmTdnALUxiofTdDj/vjpxPN8Jj
	HTKB5vqjUs0h3yUeEAUNlJ7Ovhp6uGVBV3fgpaNQx166xNJ6VDhsbGWy3npuWtrBQw==
X-Google-Smtp-Source: AGHT+IFfzBPorjhY/GpWOQsdfj15+4yxn2bBd3zh5q8L4r/4wQqa5UNzy7jSp0spx+C3Lx4aGr5IhQ==
X-Received: by 2002:a17:902:748c:b0:1d9:d300:a69d with SMTP id h12-20020a170902748c00b001d9d300a69dmr7540997pll.11.1707759232689;
        Mon, 12 Feb 2024 09:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsyxPgq9dZ3YStFxukkoo+Uvzk8Zz0PIlLMz4zZDixgDn3SJHonw/aC/sZg2jKnf8ys2BCRH9S9yt9hEVE7c+G41QpF2y5X+N5Ldj2fj08UxjjRtVv5jPqmSq7HNxhnmh2E2euPikn4r78yJxlMJILOPzx7hSTF8S3mY7LOwmVMTKqlKEeGPxe4UIphUyPxGheBZg9GgkFEcfIND0uhe/LMOV/fdkijUZTU6MGSjzhIWuWFpIPMK6UHRPZZB/yyjx2vc4kExT/ni0MVlNfM3kz/MJBWRp00AWQXKPb1M9f1WvqdQ7LfHmXG+oqtLJGmku5VQ7v6fUx+wOjYXoOxlWjpYHUDc9smdDACNxsWfBPfQ==
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902b28b00b001d94e6a7685sm594713plr.234.2024.02.12.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:33:52 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans De Goede <hdegoede@redhat.com>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, jagathjog1996@gmail.com,
 luke@ljones.dev, benato.denis96@gmail.com, linux-iio@vger.kernel.org,
 lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Mon, 12 Feb 2024 09:33:50 -0800
Message-ID: <7011170.lOV4Wx5bFT@nobara-ally-pc>
In-Reply-To:
 <CAHp75VfcK35RnPEzBkt4D56WLRFtWHita4e9ZqcLzpqUbw+PcQ@mail.gmail.com>
References:
 <5769241.DvuYhMxLoT@nobara-ally-pc> <13845892.uLZWGnKmhe@nobara-ally-pc>
 <CAHp75VfcK35RnPEzBkt4D56WLRFtWHita4e9ZqcLzpqUbw+PcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5891226.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5891226.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2024 09:33:50 -0800
Message-ID: <7011170.lOV4Wx5bFT@nobara-ally-pc>
MIME-Version: 1.0

On Monday, February 12, 2024 1:50:14 AM PST Andy Shevchenko wrote:
> 
> Yes, that's why this portion is called "DMI quirk". And it does not
> belong to the driver as such. In some cases we may have it inside the
> driver, but here, I believe, and Hans can correct me, we may avoid
> polluting the driver with a quirk.

After discussing with some devs who have worked on gyro software,
I have decided to abandon this "DMI quirk" approach in favor of fixing the
bmc150 chip id check to properly abandon the driver loading when
appropriate. This should be a far better approach and work for all
affected devices. I will need to re-write (and test) the first portion
of this 2 part patch in this manner before I re-submit. Thanks.

Best Regards,
Jon LoBue




--nextPart5891226.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXKVn4ACgkQ4obKiQwb
1x0o3wf+PFDcMORCpFOu18n0faop7dEOogTGGZpbzVzJzg3DOs5VSGySxXYeaVBY
LIZzOnpG/Js/75guFA6O33lYSfkkHFLv0m6cr0kM87dEM+qabQuhYzgFOFLz5C96
xlcX3Z8i8G41pclWmsDk3za3/Wr3JGo15UQPfpbDn/pvLYbFjvui8c027AA3fM1S
rcvgo1IUHwqwunjalhZf7KHxJvG8T7NP/0eHsiMgI8lQjQLdw0fyYegQPUl2lzS2
XgdDwtamvLWoNdP5eF5WhnP6PyQS/KU8OJ0cjJELGON1dEM86wfH5egcYb2DTGH5
/YXuIt7uv51lEoGl0AzLiRKoLhKRTg==
=z1Km
-----END PGP SIGNATURE-----

--nextPart5891226.31r3eYUQgx--




