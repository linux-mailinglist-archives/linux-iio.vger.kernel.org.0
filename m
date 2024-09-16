Return-Path: <linux-iio+bounces-9620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1697A536
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3E31F21619
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D14158DBA;
	Mon, 16 Sep 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvyPPq4P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26F1482ED;
	Mon, 16 Sep 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500154; cv=none; b=HBttPWMBHo0Myl9F92ew2QeBLNTK/lpHeCiqKfYPBSEaH5dUGiHvHknPqCNArEjfZXUNS6DZ1VzHF7W9jjp6AH71XnbN1hV0X2eZLiBGXh8qDDfEtl9g1N+kHtw2vjYxsMAJPkXD3TDa57kdan6+d+zmb8VDPVmIc1wrv9RJkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500154; c=relaxed/simple;
	bh=C9MlE4yODMM5mb6XjDjjfXwhm5Ed/UVERDpGQeMhzI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0AcJEdJGbhfBynxf5g12Bifp5KAxSp+Hkn/q8OYkfo3NelYjS3pz+V7jF5xpmR8WVYlCf8sbbJetk8KCQnEmNNEos6vU/Zq8l1OZjSo6l4QabD8Rh1S7lR9+awRSWAPwZZqV8uKfSrNTGKIrywLc0Gjlc3a3Qk4bMA9QbT23G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvyPPq4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18086C4CEC5;
	Mon, 16 Sep 2024 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726500154;
	bh=C9MlE4yODMM5mb6XjDjjfXwhm5Ed/UVERDpGQeMhzI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QvyPPq4PaX8U6jJA+NLsNZk82XFNX5LgSvfSbeeetrqB/4g6cwgPk1E2VLx7GoSfU
	 Qvc4FanfUnRlaE4FdEvBIUYhJWhZF7fcWKA3aYJ7/1rhZu/6Pa75pGN1mgrjPbmO7+
	 jdRe2fYMw/SsHRgzjdb8kCHMTxM+fO2YaPS/MLhY9sp1rUGYv17R/d7a7sK5fthxJj
	 1KkV4uE6GSv/j4yqCZuCRip29Hu0beqfeSlfzF8ETCZ+koLgOrJCJx2Iy+IPR7Dm5o
	 s/zGRaHOLtnn9AAU4qWnf8ChOtGRMfqL2COSzhcrmzx1EL2lsN7Vk7OZpPJElq9LLx
	 J15/JjJxrLQMQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365928acd0so5032716e87.2;
        Mon, 16 Sep 2024 08:22:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJWFRzmwuDCshCy9ywEeD+JjKkTxlRJ38VIZkHAa0S77utjedn1HZLtXvQw8KuzBXEFS1NCtqaw6/h@vger.kernel.org, AJvYcCXPfa59aB+oJO1Mwac2/+FQyjOpC4PAE612iu1NBBfnXeouTtNissGeU5gEYvDQ6N/mPR3UoyGtZypB@vger.kernel.org, AJvYcCXhOWFf77tC9OHybIhmg/mk3RoXNRaBWQvbbJe3C2lLP3uoeUUPJR3UHoVbXv37Uomng0g1hAtwU0tz8UwE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlq+7SnEbSNF8P08q6xjcgd0WCA+GhUhJx3QHkitYcKmZLUXgW
	sUB7bzT4cr+bSvWqDHUur6F1MLPJDRgSql15mKAcjAYGf2uzRJLeGF8d1toYrvePcS/3mT44NVB
	+8hWFDtLl9lSRgpiqDpfKv0a+3w==
X-Google-Smtp-Source: AGHT+IGdtTw/KSz+ewhmThokJhzQHLQtbmkjbMSGHd0sSEClAzNlgWwy0LVcgG/meO/bYpmv5im6I9R4MCOcEvebLO4=
X-Received: by 2002:a05:6512:3195:b0:530:aa3f:7889 with SMTP id
 2adb3069b0e04-53678ff4b11mr8342939e87.56.1726500152476; Mon, 16 Sep 2024
 08:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910234440.1045098-1-robh@kernel.org> <20240914151806.66c58bfd@jic23-huawei>
In-Reply-To: <20240914151806.66c58bfd@jic23-huawei>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Sep 2024 10:22:19 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+oJ71ncJOLH_ozyKgO8N0Dq85nvXM00cpOE24wUprXjQ@mail.gmail.com>
Message-ID: <CAL_Jsq+oJ71ncJOLH_ozyKgO8N0Dq85nvXM00cpOE24wUprXjQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad56xx: Fix duplicate
 compatible strings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Auchter <michael.auchter@ni.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 9:18=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 10 Sep 2024 18:44:39 -0500
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
>
> > adi,ad5686.yaml and adi,ad5696.yaml duplicate all the I2C device
> > compatible strings with the exception of "adi,ad5337r". Since
> > adi,ad5686.yaml references spi-peripheral-props.yaml, drop the I2C
> > devices from it making it only SPI devices. Update the titles to make
> > the distinction clear.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Is this an urgent thing, or can it wait for the merge window after next?
> For now I've queued it up for then in my testing branch but can yank it
> out and send it as a fix after rc1 if that is useful.

Sooner would be better. It's now a warning in dtschema main branch.
The issue is not so much the duplication, but that which schema gets
applied is not deterministic.

Rob

