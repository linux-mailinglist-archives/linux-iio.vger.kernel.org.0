Return-Path: <linux-iio+bounces-17386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC95A75D71
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 02:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78F1188A6C6
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 00:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2BA2905;
	Mon, 31 Mar 2025 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+6Jkkg7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257710E3;
	Mon, 31 Mar 2025 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743380014; cv=none; b=jqZD9vy5ec+UowuIuhmMY1jp0f/IXxl+sRChzZ2eAs1PLalgtrcuGM2zOTJIDIdh/eFQoiieEmEnpVQsUbILnL2vJ/8zqpHgQ17agnRKlcd9RsU6VFKnwnK4SzemryNcI4GhJ8vtkOBTLNHG+CeE0BqZvjVDQTC/Z15Krdfi/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743380014; c=relaxed/simple;
	bh=4CbAp4pECBgFZbFOj5cTFco4WbE55qFgtndAGjWLScI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAdkMBbM1zYpJQr37Kf0GAx+mLt9t9J3JQ182s4oFgxLUSEeRBX/mL1iZZiyfsXnaFeHS8H5gvIj1nrlZz//FHllZ2PdkuW2ZmunOf+DfNc6De3tsyNzpdd/YjgIpLAn1bR5VQGMQ8B3xWvd9/dLRZdJVdVqkr+uKNkAhjRbXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+6Jkkg7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so6409029a91.1;
        Sun, 30 Mar 2025 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743380012; x=1743984812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CbAp4pECBgFZbFOj5cTFco4WbE55qFgtndAGjWLScI=;
        b=a+6Jkkg7wsgBQLipTTJD8DxJA7Co3y5WLCLvECQFf7K90etED1oKSOoWjPazEf/MzG
         AXDWLn59TIgHdgI6E2qiq9gS69jAOPp3smK9AxP3et6wtwk6vu7YsNGEyLeBpuPpHx74
         C5lqOAaf3tdAoHWpaczf3qWARDG98R1rCAA4/r3JETtXjs7PxLD7VoCrPgBHfBx23YBs
         X0XR4yW6DtF6LlJ1q81R77teYzBaUnYNZod4Hv9rparinoY9/ZShMiNZZOT3mXvfompV
         7PiZuBq6jP1cijnksG15glfAPcuEhRhz02FB4sFbj6PfML9FTPA3PI6sJ5jGWJX+foC7
         BBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743380012; x=1743984812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CbAp4pECBgFZbFOj5cTFco4WbE55qFgtndAGjWLScI=;
        b=LYcXzOCDLttrKVGQCPmio8R0kab3BGWktjpVzRsov/OICS2xBEG3RjP3ED/nU99T/c
         5SoEdPbNP3kn3jKY6ZT5T8mFXy1zCC4jEVdPrMjwgHogQUmGm7rtx79DRm/oH5ApZPMM
         fn3GmaTUH3uMuUeOkkQqViojJO4w0iAMeRoyJwEkI/vn/lOZy0+2/NVo4hrfio2aAfCk
         0XrJ3sfRalCM9Pj5TiHogTBfwnNluBeUnJMGBSGfO5s3yjRnid0uUF5G24aAQundVAcC
         nzRBCn5+pr4U86WgaT2EdbSlSF+ZcCoguMJJ+Z+tS7jNYJDnBpmGCJ0A3rzFMuV2Yqhd
         u+vg==
X-Forwarded-Encrypted: i=1; AJvYcCV6hkkuEOUjd9NEsaU0Fl0Zdmuo0BABO14uD+RxG3Jb0AcR/GMmDZZ8hxnbTOqZq7Yi04RnvF4+pqk+@vger.kernel.org, AJvYcCXg5uctJ1W3hjMx5inivEuMWY4vWzh3ThkJVIzwnobbprC7c3FnvIfh/YVlVpuPXQ9Q8Lw/WzIm3Ic7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1yEhRLWPS6MaYGOcG8mFYcEa2xb2dNc+cPU3TWsu4GHEOCfw
	QUPNI+UKrCXxlJ9X+1pbwMlxIlQ820wY9dpafkFLEfnUKul/F1SzhEYvHvdWC2z5LPgNRPM3h+P
	tyged33TVEn5HM44Skau2nzrtKiU=
X-Gm-Gg: ASbGncsqNa11DVvMge70CTIWD8MnY6XQgEkTbfiyXFCX3uBqcaEx9yl40Is/NAnJQXl
	vpmYfTtUVZGz5VRDhN/3dGfCbK6k/wsTo7D3Y3Euqbw2Y7/BVndwU/Ya309xUizdlOb94QL3OqE
	HagmjdOon6IxiOXMNJEamvMLIcLA==
X-Google-Smtp-Source: AGHT+IFDkSvHYmC526xvc6LRmLmjEOTrXykH1PrRV7+2H5rATJWkcYmQhKCarFXOh4RgOzoc7OncKjA2W4AlUQs51hg=
X-Received: by 2002:a17:90b:2ed0:b0:2fe:84d6:cdf9 with SMTP id
 98e67ed59e1d1-30532145bf0mr9146597a91.26.1743380012574; Sun, 30 Mar 2025
 17:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329164905.632491-1-gye976@gmail.com> <20250329164905.632491-4-gye976@gmail.com>
 <864f223f-2d0b-4202-b46d-824ee61fc817@kernel.org>
In-Reply-To: <864f223f-2d0b-4202-b46d-824ee61fc817@kernel.org>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 31 Mar 2025 09:13:21 +0900
X-Gm-Features: AQ5f1JpHQGR9iir2r3M5TRy_NnLuMeRiU7jTlqlyPPDPe_aarRmnzXuTPLyAX24
Message-ID: <CAKbEzntatDQHoUcnESxLwuNwtfvb4BWH4d4Bwxen95RESHHtbg@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: add winsen to the vendor prefixes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	lars@metafoo.de, gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof, thank you for the review.


On Sun, Mar 30, 2025 at 6:37=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 29/03/2025 17:49, Gyeyoung Baek wrote:
> > Add winsen to the vendor prefixes.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> > ---
> Your patches are ordered entirely in opposite order. First you use the
> binding, then you document. First you use prefix, then you document it.
>
> It's not bisectable. Reverse everything (see also DT submitting patches).

On second thought, reverse order makes more sense. thanks.

> Best regards,
> Krzysztof

Thanks,
Gyeyoung Baek

