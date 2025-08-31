Return-Path: <linux-iio+bounces-23533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD4B3D3D0
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 16:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E613BEF7B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB5263F43;
	Sun, 31 Aug 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFF9oPfi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14A1DF99C;
	Sun, 31 Aug 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756649243; cv=none; b=loZtEhL0nOnc+1qtXaoMwPlgePdglf+kmvzk5/2AOmt3svDQP3wMpSc/kXPI0oPbuTKEc/9XdpLCLMMPkX8ZFZ4GjZdZ2tMXhyitqB+fgBkpm1Pw/hkL6ioyb/R/298qdIFULDm9cmwHSFN424BdSrGN4T91xjnNfZG41xor72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756649243; c=relaxed/simple;
	bh=42UJ9qEiQVPuEtVkeYAq3kUVHCwCtU/EXKkv9z0KyK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWvie53/USb3TyXE2ZAFTdtmEjfjcPXF6kDmetOMBWUFMxPypmFai/07OWllNonKFxL6zh6Py9/8YbiPY/0h7RwL9MTxEIg+v2yPYD24bU7J8Dw8FLWaDIj9RNInv5L5Y/KlZ931Cxx7fClsVbN97Y/vKQM4EB+Vsi7vHBDJaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFF9oPfi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b042cc3953cso6859166b.2;
        Sun, 31 Aug 2025 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756649240; x=1757254040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42UJ9qEiQVPuEtVkeYAq3kUVHCwCtU/EXKkv9z0KyK8=;
        b=lFF9oPfiCWxpFI51GFQBurKv3k5pWGN4I396QWpglh8+gjdE/LkuuIaPVVW1s+HI5e
         vCR1KUQZ73n/Ahm7b1OzrpYFQle/z+wSWoVHtQlBKpZr5ZIrwMEu1IIdmIBfAlvbptIl
         L8duvQQZS+l651lt6LftDcv/giSjNF98W7hNTLqVdet0KPCciNyAoQnA9mPq8UwgCeCb
         kmVce5tqlQYgArA57eXGYl3skgJzIf/suG20iGhPQqP8XrWO/g1aenlyPqvf0QPC9dck
         DlnxVBUshPZu7v/Tsy/z8vT3Lw4Smpumpg9haq8r/eOcfbsDADxSfaiAc12IA10rBoHQ
         O5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756649240; x=1757254040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42UJ9qEiQVPuEtVkeYAq3kUVHCwCtU/EXKkv9z0KyK8=;
        b=ro011+u2C1ClmmSUO7iOp/ZD/6DRUAeUcyfaXBlSdOYKUkaaQWpP6UbjAg4Z7qzLcw
         bNKCGyJNhiI8+P+kE4WePmO/0l1f1FlgTOzKs3ljWdcKWctFjmMqehwC9oeZAFZj9vnf
         ys/4JxyOPw8TTh2z012VUcM/907j5qDOBxJW7Y5PPNTArWj0404vC+nnGqpbOIfYuDkc
         VIADASLhPJzG12touyr8HpVV/FhclFiC6UkSBjhBpRRqaHnt5jpAhMNb3PojDIVs6UoO
         wpAuw4FuEi0yQPFSh8oODta6DxoNHm+cHTncf2UR6acZI+fp0Q+5qE/hyK6rl+8Qai3A
         EHuA==
X-Forwarded-Encrypted: i=1; AJvYcCVcoQiDIeUryh8KcBrCV/ut/kTg6iaxbCcec5G3/6W8ejAGVSgBL2MB3Biy3EKB33JTl+lYCsoNeAKr@vger.kernel.org, AJvYcCX6+YveiBWhqf1VvH/xUgaoUCrUkBqkH0ah0aRUyPSgysryFYtQC2arrR6bEYOxB2H33HALZMT3tLG+@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoBkttQoetaW6gfJXgtmIFyYqUF45WO7SOo13NBQm5jQBsBFa
	X7gwVHEThdIj3anwNm6knq1ZQLMhmO+6SJ339bbxSpimWK+ZEwBRRTwH/xQLEK+SAzXF22WTIEI
	46AEodMmQYzdyBQ1OLgZmWiSmX7hDchA=
X-Gm-Gg: ASbGncs7KDICJmyiqeZn1oYFGxCWxVdHZCVsybVcey8IS4ficc5g3wLnbTY1gWPz1VE
	JiIp36lWRt5N1mrggxKKALgEOPHR2MziH5j4Xh4TliaiMOQhSUVtOkB3jLj4JjYVNJI9KQG5mKm
	1Ea/UpOm67ZzIqpvF+Vd5l7CSXriGXRhos4TNBc1RRXjT6hU5sovIGhYhOxNO8hwW2upalFTZzM
	aSshOBRDvcep0GM16E=
X-Google-Smtp-Source: AGHT+IH0Xl0/W0c9vgy60ZM13U26KVIbdLaIyx5uS75uXxEy57W9+t84jA9KedoaH8q6cicSLHscTKjLqe1P+adXj24=
X-Received: by 2002:a05:6402:84c:b0:61c:e99d:fdef with SMTP id
 4fb4d7f45d1cf-61d26988c6amr4894248a12.2.1756649239836; Sun, 31 Aug 2025
 07:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+DSw5PWdxqdTMO1oXcAQs9cH04jAVeajFuBcZf==jP=Og@mail.gmail.com>
 <661af11d-1d09-42e5-89e5-a0945e21ad67@kernel.org>
In-Reply-To: <661af11d-1d09-42e5-89e5-a0945e21ad67@kernel.org>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Sun, 31 Aug 2025 19:52:08 +0545
X-Gm-Features: Ac12FXxdD74L9FwLyRpnPDsSA4vrjV4zXrGPvf49Gc96RLz3-8y-DxfZUgnlySw
Message-ID: <CAJE-K+DOReK7+4+98qz-O+gjxZk-BfH4GBU8jTdLfRExudHuFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Added mh-z19c to compatible enum list
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 6:38=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>
> Please use but imperative mood. See longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submi=
tting-patches.rst#L94
>
>
>
> No need for items, that's just enum but...
>

>
> your commit msg said these are compatible so express that. See my OSSE25
> talk or hundreds of other examples.
>
> Anyway, never tested :( (I should not even bother with review...)
>
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.
>
>
> Best regards,
> Krzysztof

Thanks Krzysztof, will retry later after checking and testing.
I understand that it must have been a bit frustrating,but thank-you for bea=
ring
with me as I am new :) .
--=20
Best,
Sidharth Seela

