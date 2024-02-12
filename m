Return-Path: <linux-iio+bounces-2450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0675850E08
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 08:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552881F27F6B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896757469;
	Mon, 12 Feb 2024 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRTMreNe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DC79C0;
	Mon, 12 Feb 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723007; cv=none; b=iWKxM4YVRn3s2SoC3pj5k9fzOoUA0246fa175+kEt8gSdPTlbW7DRQqcym8CDo0hKygIAWShJs9anXAlX9QGmjs8Q0HIm7XZpm+vMR0hQ0Bwwvo4DUqgGLS5xmKpiowOuz7QPVYleUxdjsOiFSogy0rHCIhIinCqMD5Owi8Ksq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723007; c=relaxed/simple;
	bh=hFdocZULyuXPn9JHwt64F91GjTLXIhXwqQ1nO1rFIZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH6fSB/ZNpKtaQ7jCHQoEhIBFNYRzXvE0uQ6IpEC5i3+41+vKpTabxbyBfNbgG0EYx32RW3vmzeg/f/WGY39kQFY12eD9esQrH0i1lCNbkh5A7EPAs1KEWdk1U2C1YNvFbOfxhZEpp8VWicx3omL31pTqzUHXQPdFWCfDdYpiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRTMreNe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d93ddd76adso20022075ad.2;
        Sun, 11 Feb 2024 23:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707723005; x=1708327805; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKiNG/b3vtHfBP7BGh3BFcPqXowiaUYQGloNivxEUn8=;
        b=nRTMreNe9k6zJn6Fk533WN0gucIjhjcv4DYzBk13a/eqz2MYj+03lS2IixAPHPI3n3
         PckPYcAmF1U9Q1k1EySAw0fJbyb58wbmwGsfouFRMlThiL4WKWG4EIjkfUVC5ygiZdsG
         GR1oq/YdyB76siA+iAq+1abLfPO43PDI4mjTguYAdsfLMCFfhoIhcstnOWkARdviBHJR
         TgfcIb8QQGH7ZTtVqsOkTjz6ZnsJT0aeBvLVX5MaVxkgaqI6NjDdMMscEwzRnLtTOzon
         FqZsc42Qyhd2OeX740lbVU18Q62GtSZfO1KM7H6cIdsnjEugsC6SeAXkKq5cob42S9ic
         Nx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707723005; x=1708327805;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKiNG/b3vtHfBP7BGh3BFcPqXowiaUYQGloNivxEUn8=;
        b=jEVq69dEghY2PLSvAroN4yUbopmRe2u2TTIl2c8e9UP0lC5lcFI9AxLAmp5oWAtcMB
         lA7wIl4P107kLoGy9Y0rAKERIcNCdU7B9RGhDW3XyRULLf6ozhFOV2i2bmFse7CzctOS
         8kA2HCqhjs/s40KiM4Ijy+j0HP2I+SyoIn3smBJClxb+ERj7fs1F0vV+r12+uDsKnIUh
         w2c3lYIDas5XqyDIncM2Exv1tH57wyjXi0V4k/gbZS36WoNOrvu+jbBKsVrLMceMAhu8
         Mhy2oc8m60mZErFcKlJsajUT9/2nb67xd4hvrhEj7vJG+rn/uuhVKC45O2QxfZ+sPBID
         xrhA==
X-Gm-Message-State: AOJu0YzpXVtnR6AeTJDbAVMP12ewRJT5aWmpc2eHim6EA44sNgZYvX92
	rtN15eqmQzr5ZG8XcIdNBfRSR04jgUOwW7MLslRL4Z2t9E0rA3r9
X-Google-Smtp-Source: AGHT+IHpvoW8kTopgNHvJB47zIPLhA4DF79IcPKJuUd7SqI15T07VS73hQIck7tvsgycRE1e/bdVvA==
X-Received: by 2002:a17:903:2447:b0:1d7:3067:aab5 with SMTP id l7-20020a170903244700b001d73067aab5mr7141547pls.57.1707723005213;
        Sun, 11 Feb 2024 23:30:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVX0geMNZpkhS3d4T1wRugzx3B/AapMIHM+ekqIQLtjlgwV1LYSq8jKBZi7Rqk61Ga+VDjg8bhJG3OshE2XbYoH1LrVeVZ0T9wwAinKl8YjUJFJL6BNADA/rLdpAT0r+N29kpY79ut4ZoPD7LULGwobY8W26lskJRAe1YOTjIAq0L6m0XaI6igo4jiGcSIFwWdOMpJaE26TGMzMW3EQWqcOuXPCbYN1Lill3Z8qtOniI8Hr+ev2nN+8aFFhOTICCB91bPp2LJ1bzAnyAnL18TYdUg3RcmZmBI8/gWpEPSeYDjwtsnmeqo5mxI2jqyhg5pB4tN4oc4NgzdfahgRb5O1lMuEfRqzoTu6PvVTEPcdHdmL1BRjD6rYAXw==
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id v2-20020a170903238200b001d54b763995sm5307390plh.129.2024.02.11.23.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:30:03 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Hans De Goede <hdegoede@redhat.com>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, jagathjog1996@gmail.com,
 luke@ljones.dev, benato.denis96@gmail.com, linux-iio@vger.kernel.org,
 lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Sun, 11 Feb 2024 23:30:02 -0800
Message-ID: <13845892.uLZWGnKmhe@nobara-ally-pc>
In-Reply-To:
 <CAHp75VcFXSfV4rPDaJcUVC92QGK3U55AqQqPo0WYKmpcKnw+eQ@mail.gmail.com>
References:
 <5769241.DvuYhMxLoT@nobara-ally-pc> <4956451.31r3eYUQgx@nobara-ally-pc>
 <CAHp75VcFXSfV4rPDaJcUVC92QGK3U55AqQqPo0WYKmpcKnw+eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3318439.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3318439.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Sun, 11 Feb 2024 23:30:02 -0800
Message-ID: <13845892.uLZWGnKmhe@nobara-ally-pc>
MIME-Version: 1.0

On Sunday, February 11, 2024 9:08:59 AM PST Andy Shevchenko wrote:
> 
> No ACPI_PTR() in new code. It's more problematic than helpful.
> 
> Above for your information for the future contributions, as I said in
> the other patch comment, I think the better approach is to enumerate
> from an external driver under the PDx86 realm.

Thanks for the constructive feedback. I'm working to fix and re-send via
git send-email. I think the ACPI match table method should be okay and
seems pretty standard for a lot of devices. The problem in this case is
that the identifiers are not currently unique to each chip. This is something
that should be rectified with BOSCH and system builders and then in the
future, the ACPI match table(s) can be updated, and the aborting portion
of loading the bmc150 driver for ASUS ROG ALLY can be removed.

Best Regards,
Jon LoBue



--nextPart3318439.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXJyPoACgkQ4obKiQwb
1x2/pQf+KSL1xyLkVZhBSb2d9lt/t6KkLN9ASY22gBuafTsBNUbtgA+ewXB1dJ5D
tgl5nUBIyLscDEd/c1BFMXzrFC+ActIQqhci/vDzVdvJ6KqZrtX+F6nF+pHEugQA
0sLCPI4857k5bupG4ofRVWYOg74Nu3oRFfjJEeellJeLhv8sz4+Ql7/YcPtXV9fj
T6yoCsbMl7YeNIZyM78AmXTxaE9Z1nLhRgoxN5VWa//IQRKao6DIsZuQms9SfOpP
wbMsrhz+gqNlVVeFMHDh/jQng/eT7oWtnmRWB9ndp3QgpifmIOOubd7wfUlatzko
AvqALT86BEysYl4fYBr7w2ZCAoB80w==
=H/Wr
-----END PGP SIGNATURE-----

--nextPart3318439.e9J7NaK4W3--




