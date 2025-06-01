Return-Path: <linux-iio+bounces-20113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD58ACA035
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AF616AA94
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBEC15CD55;
	Sun,  1 Jun 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2u8b6Qc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133971BC58;
	Sun,  1 Jun 2025 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748805165; cv=none; b=M00SfP+lkn/fXoJwNqlp0Wn5O2cNT3cgoS9ND8/JpahabINCoijWUsoDDW8/vNkQ0PKcozXnqtcR2ot5gutV8NnfIKrvGgrB+ZYxyR/a6GHeXXV3m0lgkYnRi/TzrpF8mKSg7Z/XMa+Aapsr/yGV1DJiCG77Zn82wPYXiycCzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748805165; c=relaxed/simple;
	bh=jDbnCEsU6h3oVBdfQrVhfj5f2ECvv2dd2BKz/ONcxrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id/rL1+9sjHREx3B5RviaFAkixHaBD1kc6uw1LoW7lTmL/j14VJhPGrN85fsevVVO5Ht6qnAcKhxF/5flCBxfOSPX8PIy9j0/8OJ8c0Xsj8Hj37P+JmOptoVtx2NISpiY2Lk07sX0P8NP0Ygt9BX5S1lpHWscyTvcLaNFTnmluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2u8b6Qc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad8a8da2376so591559166b.3;
        Sun, 01 Jun 2025 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748805161; x=1749409961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDbnCEsU6h3oVBdfQrVhfj5f2ECvv2dd2BKz/ONcxrM=;
        b=d2u8b6QcOGd3Q+FJ9Mh/zfsk20SC5oQxCGnalYgSJjPqgLmYzuZ6O07OOAWUikIAKl
         ukN9cuGu0Bo3GX9GZKpwv52eyttPBMixHhtaYuUUM2oD1/M6mG/aUE1l+PnfUoRAaB4k
         2GIPaBXU+U+BT4zDZQ892zZYxUlnf9agzYtNRoO8q6Aat1Fj24haOi2JR2Trk/ptpy+3
         +V/YJxV9ywyoFbhGyKzjU9gim76n89VRUpeWWTNqc2lgL8nLxJZr73hA33ogkBlaPebY
         OXPUO39AwKbWUUdy4VU6sJ3aASTcthPeUfg59Of+DNFhduXDyGoLDXgei+8pYjIhY2K7
         1OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748805161; x=1749409961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDbnCEsU6h3oVBdfQrVhfj5f2ECvv2dd2BKz/ONcxrM=;
        b=RpD2raSiC8bAt6RrpPRR4uEA+XE2YqHJgzvN7wbSFkMBdaks1vNNkR4mmLEzNs+ukM
         zyLyN4QiUX9MgxRrThdwfez4U0JJw4XXA1H8At3Vgk829PlsR6/btr94gm6/5pNUKrDU
         sP2+qzE87LISmy+SQxKtZalKfBFbtGQJaNczVEjvmNsohjeLbAC6RcxUXYRaq4keqVSi
         Dzrh3266TsHgLNSzPo1X3Yu3rDfC/ZArvtGoPCQR/90vkikrZ62bdnO7jHBl9JrWS1ox
         BcObVSwSA2N23fyYYichzZBnOiXsqvmeRu/rd3Xy2kR93oUbAYnFFk+THUQBFGWUYdv7
         /Q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1eSbWFVbqFlpevTew/Dg9TfptvX9wEOY1VjNO28tIjCWleatL1wpSZT1XIQCAdx3w1c/ki1R0In40@vger.kernel.org, AJvYcCUPJsrUxCKsydudhNX4aRm284ARCzJlhNa97LucYL86f4ri9ssOHHtnIO425V+8YzsV7SvXAWmrz7s=@vger.kernel.org, AJvYcCVwNiYC2R3hoyC4IqYUsD2YbTVqbO3qoD+8yay0QasJ4l9SgDXlcAQZevZlFv5d6JSt7/7jIvcXYq1b17vS@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7y1CBEHxIjVNRpbk4IbAohtqtm++zob4upWYR6oiU77llOmF
	TeMxnD7HbsSkvlOTNI4KRUaznKoM8M6B7Q6sqpNXYl2B/YApj61efLDyIlQbg9CSw8Vulbz16N6
	Or8BVzpAzOS2RuSTP4oLkX2uFbNYDn0I=
X-Gm-Gg: ASbGnctKKrSQMmmMK9dZu3AG4cbVTbJA3nAWVxFW+ZjLG5p73TIe95MWBaV1I23jg/8
	Cdsv/UxgoNbLHdWWIgfSQNhTJc9dxv7BBjMGU7PN3zlpm+1tWHTT02+qjx2Y5cUw3miDd3brY9d
	z50S8USoiszjolC7He3IUkvnLBtJ5GayAv
X-Google-Smtp-Source: AGHT+IHYHVYJgj6t/Z1VPbT/2qKyPrOOmvPybYbfbvGHM6R0ag590qzEp7pLEOpytt+WUjSciCBybjtJCYYqpTFDUl0=
X-Received: by 2002:a17:907:72c2:b0:ad5:b221:540c with SMTP id
 a640c23a62f3a-adb495dabc0mr665766166b.58.1748805161187; Sun, 01 Jun 2025
 12:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-5-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-5-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:12:05 +0300
X-Gm-Features: AX0GCFsHEwoQugXdv0k4xDAS6GzIw40xu4KfllcXLBfdRLLZgBx0Wjgoe5wJBkc
Message-ID: <CAHp75VeMqyhxsaR32up7d-+SeveZiV=XR4dE4Huqje2FLa+0ng@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] iio: accel: adxl313: add function to enable measurement
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:21=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> Rework controlling measurement and standby of the sensor. Therefore,
> replace writing the register directly by encapsulating this and dealing
> with the return value in a separte function to enable and disable

separate

(Please, go with a spell check before sending a new version)

> measurement. This will help to avoid redundant code in all locations
> where the sensor configuration needs to be adjusted, thus measurement wil=
l
> be set to standby, in follow up patches.
>
> Further, reduce the control mask to only the measurement bit. The sleep b=
it
> actually controls a different behavior (not just putting the sensor to
> standby for configuration, but turning it into sleep mode) and it is not
> used so far. In consequence, there is no need to cover sleep bit and

cover the sleep

> measurement with the same mask.

--=20
With Best Regards,
Andy Shevchenko

