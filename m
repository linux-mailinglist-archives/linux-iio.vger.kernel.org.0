Return-Path: <linux-iio+bounces-20954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97410AE79C3
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 10:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D123B1E29
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 08:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8612147FB;
	Wed, 25 Jun 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjAjNowm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99520E023;
	Wed, 25 Jun 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839360; cv=none; b=Z5CjNxzXaSuNlrH/AzjA5WToAEDlHxNNTx6EztdF1POTL3JnSk+jw324/wag4Ws0Huzh7uzR58midDcLAQeS3D51XEtrUqa+Jo8CyK4QuwtIO1Wqltd/OeoAWz5oCqZbE6mOx6VoQtnkwT2XV4mjYb9Lr2Po8c73CjPrX0BjRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839360; c=relaxed/simple;
	bh=B9FQ/xDTdaPFjALjUp4dGIQ/na1i4R5MHemjyoJtJVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taXzEPL5XcnhlY2U059LjRQACH0k66byaOP6r29AnDRfJy9dCgeaPVRW0qdcmBXV2LxqWiChMCBILxtIV/tnfrnSo5sxsRTKA9Ws3TRtuLNCAvk7nVmArZaVLWKUByiq9tVvBFsswiwc5paRc+LEDopPTLbJVr77GS78a5ocZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjAjNowm; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70834f92aaeso4462537b3.3;
        Wed, 25 Jun 2025 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750839358; x=1751444158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9FQ/xDTdaPFjALjUp4dGIQ/na1i4R5MHemjyoJtJVw=;
        b=OjAjNowm7EI8tLuGe/AvOhuTVpO4QPXaz/Xat3mG7KIEF7MCyhRnfEyJhuHC58O1ih
         PzkuaVTu2SsMMZRcIQwHdRL+wFrAsS4kZ7g+J9UZl+xmc25cbuqzr0Uw3/hh2JFurxyY
         wgTa2zj9x33OJaAoBVrDGiiqzZRCwbWDfBblVDA+e6FjS6H360IvY6EV+/Nj5pyTxucZ
         afuwiaowF+9+CdmEiWiAAL4s30vQ8oE912rRb1zlo9PcDAqwUr/63fF1iddidnJPbOP1
         RIbWxPdyMaD985+KQOtoBxj58XUKk9uO275utoehg9IvkofABtPxuUtDHXgxlDHjbuHU
         w8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750839358; x=1751444158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9FQ/xDTdaPFjALjUp4dGIQ/na1i4R5MHemjyoJtJVw=;
        b=ccaPnN3sFCpOoqPJ5QXQPiZARzwJCYUUcpBb8dtNoZ7mi5i16iLUNtbb9zhF4DldWc
         k3m0x8YlkxQyXiypA1ZYO8cLeE1ZbQvvLzB76z5W4P20L1+ffA+b+rvP8RPGyPIpGHdh
         4jjj0vZuBkFJmHfK4G1GOTjrfbtrFGj3UtA0ugHybmeJa/OWxbk5wshTIE/Nd5lnodMp
         kKzRkRdA+1EPlt47Nmu7JfOPGdkowwe51SP40Pqfv6zCZIytGFu6JVcXbTcSmMTu57td
         ULBrsWyM4OkcnC5v6GzfttqhkutCAKi7LFU7MgGy79QDVtAo54nEoszop5BdovN8celm
         PCug==
X-Forwarded-Encrypted: i=1; AJvYcCUrohKJl3Hod0lTojJkuovjSxoAGZIp0gydAx+TM0f6teFTx8kST1VXbd7QAxsvLe0MhHeSOoIjuMEg@vger.kernel.org, AJvYcCXWLnrgCdw40h9HiWwJaviVPi5oZBTOTKoooi/fxV0lDjev0ytqHhRSSIPPQmcvMZnXjmheQR7A9wo=@vger.kernel.org, AJvYcCXZZ2H5gjgy0egYi2cDF7XWf9KIwC1SOOTmuJx/4N/Ds3jcGn10iq4BVjpb28IdWiyPWJ+XXp34YKDCrxdC@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTy1xMkSBMc/jjgbEAi0fxFDiJ27uft9N9IF1SZt9B6TxeGsq
	dSA9/uLi260xXRJUWsQOBQ+M6gkAmS/S5TX8MODEbz5Ffvaos0H3Wj81jsgwziWIjyHxPYvXkPt
	RUL2qYyiloeBGGIJgQ24JXcT30vFdBqM=
X-Gm-Gg: ASbGncuuDWqSqq4jTxn5NuGW7pkoVsaEFV5qGC0BQr7KFSsNlU3DZgjrTGh5ril9LDD
	xo75jEe2iwOHF0RnlmC2u6E814k8wcpC28LznviYjMbRYg5T3HPgp8xHCN0bAOQRA3SSFDvCuDa
	vIXARxFGBnu/xLK+xSE5J+Z8qLEH+zrvk4SoY2uI/XpyE=
X-Google-Smtp-Source: AGHT+IErRBRd4ZEkZGGTpdiXkJHmurXTIOpZXK+xDiiziUhNlaNMwGpOR9VoKLkPFm/JlC7M4GtcD6m2pcR3WADrueM=
X-Received: by 2002:a05:690c:7483:b0:712:c5f7:1f02 with SMTP id
 00721157ae682-71406c84c64mr12648157b3.1.1750839357660; Wed, 25 Jun 2025
 01:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <aFDBWztZT67hUF6I@archie.me>
In-Reply-To: <aFDBWztZT67hUF6I@archie.me>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 25 Jun 2025 10:15:21 +0200
X-Gm-Features: AX0GCFsCKhxXsO9vDHgBQ6201WxKb_UPKCWTu4wT49puBY3PnYFj9m7uKV-mBTY
Message-ID: <CAFXKEHaZ8aGw=WZiSDZhsrviATTNK5omRBOhNLd1xAsjxDAPmQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] iio: accel: adxl313: add power-save on activity/inactivity
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bagas Sanjaya

Sry, for the late reply.

On Tue, Jun 17, 2025 at 3:14=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Sun, Jun 15, 2025 at 10:22:50PM +0000, Lothar Rubusch wrote:
> > base-commit: 7461179e080df770240850a126cc7dbffad195c8
> > prerequisite-patch-id: 263cdbf28524f1edc96717db1461d7a4be2319c2
>
> What prerequisite patch?
>
> Confused...
>

Interesting, tbh I'm not sure about the "prerequisite-patch-id",
either. AFAIK there is some git command to verify and use it as rather
an ID of the patch (series), as far as I can see in the documentation
for format-patch:
https://git-scm.com/docs/git-format-patch#_base_tree_information

As mentioned the series is based on this fork and branch:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=3Dtest=
ing

Actually, the base commit should be possible to identify (at least I
could identify it in tig). AFAIK - or, as I needed to learn myself in
the past - usually they check the series automatically first to rule
out such things. E.g. they execute checkpatch, smatch, in case DT
check,... on it. If anything fails here, I guess I would have received
feedback within about 24h. Since there was no feedback, I assume there
should not be an issue.

Best regards,
Lothar

> --
> An old man doll... just what I always wanted! - Clara

