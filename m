Return-Path: <linux-iio+bounces-2449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D21850DF2
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 08:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237F41C210A2
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C676FCB;
	Mon, 12 Feb 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/dDG5av"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC77462;
	Mon, 12 Feb 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722507; cv=none; b=fN8I+WHvm2JmyWDYJphimljinJkkLdxWngHglpjopIoG+A+mVvW67aEuuKNcc/BEtYZUGluv6D6RJD7vb3ll3rdjKmAPHpZsPSl+Vc5wdz4LXN9EaI0H5e1bQWPlhYQ8algAuIZwDSikw+9Fd9zPT5X1BxuWTDAFG4ejnYaGZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722507; c=relaxed/simple;
	bh=cn9DAENmMFWrHx/ZVLiD7XfNJl44DYG+Sh/8ZzxHtaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK2qrxNTM8iCV4I1wcGwzvSF98AYLMkb1xUD89d6mWx4w5Ox7b6iA7gdq7hGfpGxFq4Ho9BEHofMvlwRtoYtQ/52U5GXFi5OFA2Z9rM7INIpp/ou+g9i1uYgTySAqQ0VVrDtKgH66c6UiM/bCu8i2XWckiuo3pLEVFm++4OUiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/dDG5av; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso2165123b3a.2;
        Sun, 11 Feb 2024 23:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707722505; x=1708327305; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cn9DAENmMFWrHx/ZVLiD7XfNJl44DYG+Sh/8ZzxHtaQ=;
        b=S/dDG5avSPI4NdQXpA36wALMooJ5uGWjkd4JPSghF71CTkMS8xWUg21tD92745zjJJ
         aiva5RJHLikw+6n1YzX2rZT+yxnZGM0fJMq8BeJKKs8FiqVYWNdEj3k2Hb0Kiyvn3fZV
         ro5wMrT/owfK9scQ8mGP7xtrF97L4DhBskbfX9xgMCmeIR9dmgesVOC8IW99i88ZvRVV
         BFdiv+qKVhUK1bRAFa3/x5s4L4JfCbzdTvn3cPeuBIDideiSe8H53hiv59/edzxHJlZp
         ddIVUjL5/X79dzXBDf+mhQ/I3BQFONLwn3oiRSQxRNrJCCIkkdZPQaWRl+gRwawxW8QB
         M5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707722505; x=1708327305;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cn9DAENmMFWrHx/ZVLiD7XfNJl44DYG+Sh/8ZzxHtaQ=;
        b=P0pky9vTCk2MQlMBOeznGeJgvdY+1FD65tAPj/fcsRT42/xKYaI5tbzOuZ5W+9aIps
         o/ImtUVDyQ2xZYRaL85furiPB+SFlEHZBMtEapvptB7/rsZyoxyexypPgIpprBrUoHXy
         T70ubH2P+L5adeA4VmWoXooO5Im5DO8OC6FFUqgVEtQYX4pNlL94n9k4DY8un/0ZKBWV
         I3V7Tjqx+C3VNAO9cdc+vDZahe9V+hHsIr7/2+HMWJDpGn+77ImvJe6DfoThHhDzZYvX
         1eoQ+/SsIA03+WDxsF1dxj9E8Ewr9h3v1vR2y96KrBltDtynIik1tFrsfNNtwV0P0eim
         rD7Q==
X-Gm-Message-State: AOJu0YyZr5nf2KFMXG/GhxY/UPMcf6meRH+Rhb1GEZNXDgur1LWDSK/s
	G/rcyFToBoWLlIu4dbCSxWrfUvj1AcGT34TLeuYnso+NRz4Tk/ioJ6AFFmkHFY3UZA==
X-Google-Smtp-Source: AGHT+IG0Q+Oyc22ZhT+CaPXMkXz+FvGtCZ4AAgpomudEKOuQxsl4kQz/QeilPZnk+478LWZr0CAKiQ==
X-Received: by 2002:a05:6a00:2387:b0:6e0:6bc7:15ec with SMTP id f7-20020a056a00238700b006e06bc715ecmr5648266pfc.30.1707722505097;
        Sun, 11 Feb 2024 23:21:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwmkVSa+wOJd64GplydI6kEQ9X5mdrEz4P4c6z13ms2WyaDOHHTR/RRyftVBMeNnxk3YgnmRlYqYSDn59VBmxENu4JThCIrr+HfHZYYVpvvm0tXLItNdvDr8LREpp/ODpN4zQl5I0RLuaaUXfo0prMfce/atUQdvevp2tN4FwJm3Ixjrqcrwr9Hcxf4xWmiCo4beyRAkIkyWKKn3Xtd2bH1otTqJAA6n304aNHCbdjJOyNueOrp5yYa/Vf4X4FE1O8+33yIuV5ttIcE/TFKcZNbrt2a3M6PPvN45gm25oAv/8BOSarfdBgAWa0drJoGszo9sNEdFHgMsbDObFFK+H+8jdUkiDcr5/OB2vhLK8OXeZEZnXvLqFWmQ==
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id c14-20020a056a00008e00b006e0d21dba81sm2139431pfj.191.2024.02.11.23.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:21:44 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Hans De Goede <hdegoede@redhat.com>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, jagathjog1996@gmail.com,
 luke@ljones.dev, benato.denis96@gmail.com, linux-iio@vger.kernel.org,
 lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading
Date: Sun, 11 Feb 2024 23:21:43 -0800
Message-ID: <5292442.31r3eYUQgx@nobara-ally-pc>
In-Reply-To:
 <CAHp75Ve71Lb4PsGLGY5b_LNVn+Dk8z0Ags9rrWptSp8ot-UpRg@mail.gmail.com>
References:
 <5769241.DvuYhMxLoT@nobara-ally-pc> <12437546.O9o76ZdvQC@nobara-ally-pc>
 <CAHp75Ve71Lb4PsGLGY5b_LNVn+Dk8z0Ags9rrWptSp8ot-UpRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4941070.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4941070.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Sun, 11 Feb 2024 23:21:43 -0800
Message-ID: <5292442.31r3eYUQgx@nobara-ally-pc>
MIME-Version: 1.0

On Sunday, February 11, 2024 9:04:56 AM PST Andy Shevchenko wrote:
> Something went wrong, please use `git send-email ...` to send patches.

Will do once I can test the suggested updated table method.

> Please, make this as the proper table (see many examples in
> drivers/platform/x86/ folder on how to do that).

This DMI board match and aborting of loading the driver is hopefully
a temporary portion of this patch. The ideal fix is that BOSCH informs
ASUS and other system builders of the proper and unique BOSCXXXX
identifier so that BIOSes can be updated with those and this portion
of the patch can be removed. As it stands now, this is the "band-aid"
workaround of having conflicting (same) IDs for different chips.

Best Regards,
Jon LoBue



--nextPart4941070.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXJxwcACgkQ4obKiQwb
1x3S1gf9ExwSVYKZgIK2MhleZSthMgdvX51EMS3Cv6273xmRRRlTl4mINSZlwJCL
iheScZXIyLSMoKAJDVvjLemSv/uRfx3ipetbXci4JQUFZByDnV5jQtSExAggmEgv
so2VRZR+gFulO0ZzN4IRQTPSCfirtxSQwq7mzPF2FOX424QmPj7y3gw10g6fIkXy
grqKoUDfocm/1jLTwYDunJWuqeYqYC6hyNFwu9BuhSGYYl91fZP414nB6F3d40MG
GDjtysoCY6wkpxbY+HfoHJoyntIQr+KPk7nQlUpDxQ/diaBYoG68yn/9M71hOpRq
zr3LAmHo2ydMQmDYSXhbmxu3fVB51w==
=hkxT
-----END PGP SIGNATURE-----

--nextPart4941070.LvFx2qVVIh--




