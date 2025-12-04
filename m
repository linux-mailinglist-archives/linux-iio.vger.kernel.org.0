Return-Path: <linux-iio+bounces-26757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13914CA4CEE
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA63303C4FC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CC5345750;
	Thu,  4 Dec 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI5bVWH8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FF3446D6
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869643; cv=none; b=oPNemUYShpS/POE/3HJ3RBrO+ZJ/8g2rn4GYqzFCTepZtVjR45QfXRjLggISMkKOSNnOHipPbKpv/FyYeVLNbt3QTXIlBRgwFUce22E46st8gLXmOfLbJp8PM71e5BzidVlLzJKyBOjjLYnFKy1Sq9ex1nvYCpNOGXAWq2FgJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869643; c=relaxed/simple;
	bh=zwNwsL3MEBBaOwWuSJBlSHt6tafLg03rAix17SfXbcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emBPdl5uDMzKOJTU1qqGMACb8O915rqirMWb9nrs8bscwnGtmIeyRgsi6uJixl3kXnNGPCfDPT6fL5u7wXt82MdEOVGfVgW5yZPP953kobakFrgKb9H7GbH5jxyr9FnPMYmTDAXByIyBDNNb8jiprqPuV4C+1V5NoW1xOE3661E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI5bVWH8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b73875aa527so179600466b.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764869640; x=1765474440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwNwsL3MEBBaOwWuSJBlSHt6tafLg03rAix17SfXbcA=;
        b=EI5bVWH8wPT/SgHz4Nj67KiZ4Y1PrfKW+/dd6EuHyKlzNN4JUI4VUnNMAqiZbQWA+P
         DrsxMex3vFGQR8HxVTd+n1+Xs6AkFk1wQqg5AiQSeCDtB2ww0TQZYWqywfxqhZfpEsuy
         JFBwYfiXdxkMQE2AE1XMhfaQk0sSPHX7V0RkhKwnMNMpYd5+Hie6SsFXdtCcYwVDjnpE
         ZhEaLqS0vnfOnsa5BYvVtl+vkyieZLhzqy/9zMd44lAJ9aF51qbph8cIt7aO+1imtsVq
         Z9jKiRBy1YUsy/PCSNrmxSEiszQQ9HMKmgZ2GF4dz7WBVd/NBZ7IDqev3tCZqDm3Jz8X
         VgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869640; x=1765474440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zwNwsL3MEBBaOwWuSJBlSHt6tafLg03rAix17SfXbcA=;
        b=oF5toaKFRYSK0Z9eoPn1Ro86sva++vUAlkDQHPUnPHcF65PhE7+RH82yE5+tgU57Rd
         saAd7bNyrZSkPFolQnHu+cJHrTQgdQd0Su0vA6LyeWHDaAbRTJ5p6ZRW6Xw0cjMx1hDx
         cMdxvKFYHyatRwUz29iDo+8Q5obPeLNct4JfOD1C3/ROF0A8LPpL/DYUWNKQjGpWGDxv
         CR8A8mJqqLALkrXrMZjwaPdfQrDZn/CLcDRzV6Y0KCA5NJ3c3QsUIvmnsiREOl4Vr4mM
         ay/bzpYqXlQzNuCzacpiQ//mLZ7qtFeZukhegjQML0efccyEuL4Ew6rnTvNc84QveJIn
         H/4A==
X-Gm-Message-State: AOJu0Yznu5siegHLAOCQkaPdNdAhfCodcULMleqKOWxPcE2lB2/SdXuJ
	KMxIsKZsSh1lrAz7jpMjsY9Rp9kH8eCrVqPvTzvJ/XIhxsfBpebx/bMCbTlVXQsIC8vRoOpZyzh
	mzO4YvnZfdokWv1v/1UGTvnobTdM+zgQ=
X-Gm-Gg: ASbGncudFJCHGbreSRdJZfmksTZmh+nh2XTFcm6Rw/MNzO86I4H3bwHvB9WQ6HLgCu9
	zUBpnoMOE0hkW/auPwLXzesbdLxpsOBYeRNbpWyuVGL5914baB5iq83SDGUvTxJJEA25gLSQ9h+
	blLj+rCpdHNYSArVt1n/BSELqEWZDWZL1aHAOLLjKeliXBFDT9KkgCIuK/FrXawioOkOGMP0Uw6
	jde0uCG6aC22FME7nIT5cwazHZP25RJROJ6gCwrOeAJ6WF1N/KJFlMM+nBFxg49gEv9nSO4cahU
	8Lm7UkiJvG5zXYN6UQs5VDu+DDTeZ0x/p6bAh3y7frFd7Eg19aRmlkDOJ+npdYOcnqc2ek0=
X-Google-Smtp-Source: AGHT+IETKsM3BI2wp1S5t7jM4wNOp2o65Evlcx5VeQtVE4qy+9UgyQKV+p8LtP/WSAqZyJBkVk0mk/QsbAR00cMxK2A=
X-Received: by 2002:a17:907:1b05:b0:b73:544d:ba2e with SMTP id
 a640c23a62f3a-b79dbea899fmr685627966b.25.1764869640024; Thu, 04 Dec 2025
 09:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com> <20251204-iio-axi-adc-minor-change-v1-3-2d441d6c5b65@analog.com>
In-Reply-To: <20251204-iio-axi-adc-minor-change-v1-3-2d441d6c5b65@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 19:33:23 +0200
X-Gm-Features: AWmQ_bkFov7FYakhVQDUy6NknV-kavx73Afhc-pEPt2QqsY04t5kSnnidBBMkoI
Message-ID: <CAHp75VcFAL5oV7D_SBjai3xfVZ3BhR7BGUpCg-E3_JswJs25nw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: adi-axi-adc: Slightly simplify axi_adc_create_platform_device()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 5:23=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> There's no point in having a ret variable and checking for errors (as we
> do nothing with it). Instead, save some lines of code and directly
> return the devm_add_action_or_reset() call.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

