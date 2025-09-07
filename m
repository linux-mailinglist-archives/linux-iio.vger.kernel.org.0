Return-Path: <linux-iio+bounces-23847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B5EB47ABA
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA694189DE29
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8FC25DB12;
	Sun,  7 Sep 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbblHwr7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E813315D43;
	Sun,  7 Sep 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757243628; cv=none; b=EcZLCf3H1i1cQ2dsgzfe7cqX37/39J4pOgH+ftFF1uQI1DROVhhhoTJYOj0kDkqdsDUZhaKt6Qw1QSe3e6zahaKaMkhgY5wQi2IViRuGa1TuoGjTfM25jFtPcDJVT7TbNLFTViMVQ8a7tD/osne1hSwLRSlPhB7uuzcnePuwHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757243628; c=relaxed/simple;
	bh=yBoNTmSwEkvIJox07f1hgtmJQmhXtUgFUC1mvIL8pj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzi/Dp5qxFW+aIpxQBj7yFeKWIEcWLSfvMM9KKyq59hTnAzOv5cEXTkpNGyt3dfcd0te3YCq/QVkx0Rel3ScEUodM6FGTO8hxvbwypOL5oeqILTdUfY0ODKDZHjQa26bPRTSUuMoD1YdIoXI12exit4z7hr+Od/TKk24+w1p/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbblHwr7; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce5be7d0so1714235fac.0;
        Sun, 07 Sep 2025 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757243626; x=1757848426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4xHjqlMS+DEiA8wz+/XQo2KEWTde7fbxo5bGymj5PE=;
        b=fbblHwr745wh0tkJ3MUBzNebZfrlNrqzubajfBijttxBdytD2LJpw7WKpKNcwDZqBo
         GNcNTIhSKVARsO1stYwKGxD5DxNVJnQRlCgYNijj3Rtv89UdmI/+3PBwkl/TAOA1aLhs
         8uL5elFGlYp8U0gLzXxICl2POxpWMtX/BChS2dwyCh/foMkgDdC18KQC2tbCosMkDDrC
         ajSPkbEkRq91MySOx2HhXESY53HWqfltMpVj9XyTtIxfOs7Zbwe/kJpfykLhkNHnfahA
         dWNSLrDV6NarWAIhJRTrWAJ9MmYngj4sa+ksK0oMNac+Ox2k+dKTxICTvjEbkbQPkb+2
         VASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757243626; x=1757848426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4xHjqlMS+DEiA8wz+/XQo2KEWTde7fbxo5bGymj5PE=;
        b=fHNyZDtlzEJMdJKylS5MZcv+RBl/unTViUceD8KJTrCNGLlGDy+RSYqKEsS1r0SZ1b
         85+QQoWp+Agh0eaVadDKge36nEYJd1oCCLmCBpolcOuetgOC1NxjlCLrVcqBQsgEXuYH
         EKCRC9toETPIshB1F8+9LtR/KO0M3Lqctu2rPm20uhdrzDfwqnXkIzKsjolXeqGZGVVD
         T2Ny3ohLi1cWsEhgYJ5JRQLHT/AlaXH/af6/d3/0qI4KPbsWxVdWlitFJ/9t7DVHftlG
         XjUegjdxMKdv8pQIepYzd0gltOi0wtbu8K7KzagWz0Y9+EyDCYCicxWmyUQV/nv4SuRL
         PTFw==
X-Forwarded-Encrypted: i=1; AJvYcCU5JgtdLWRZ1sH1dSfFVMcIwM6X6MgdKNQe5c6Ypw+67TdNZTJY9YYw5JhA9cFi1sQZMWyCCIPwBg9Crctl@vger.kernel.org, AJvYcCVVN7EnMSG3FUQpc/7ICVN+wFv6ZvzJUAD8kDDeiG1RVKtoldXZePtWRGjMAzyguaQ/BBEyZ+7uwMFq@vger.kernel.org, AJvYcCXdkAA2eiWsHunvfNJDRjDhG4pbBkAYQawEzYtOxD6uJwwVlFk2N1mNAdZXZ56PoJ1LLvbbUxTyBlWg@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGVN5kyCdtH2Zh6mBW7m7Ys0O1Z6+2jeonWigr4pvIEn3XHGi
	s+6yrgV+NQdqG+Cr9H5BAmQtxjnVAm74UPXwz9EtENw/ctA2a43nsuD8lHVeyPDH9cbg6hMZhxZ
	afb6qnSUOASx0fDTG/0ddpPrDnODDiDw=
X-Gm-Gg: ASbGnctnkm1AnR0AZ15x3fiD7SofJ9FGm3D2wYOuCDNiyiMdFx17vOnKZbXIGkWuDID
	lvNjHzwzuTrQFF0Hw3Yu70uzJRJ6n7lqZ952WHv3OTDiNmi4Q6F26y2wAMO6tcdxT2QtzIuG8z7
	uPFa/GLTy6pjcqg/KBltjreGzDyohhvNeqqZJU1nmxC9qNMjNnGxKemERmfQpXnbRTMEZ0FhT3f
	d2dcar2DemoFnF+ePOBmapG/66r95qgqHs2726zDw==
X-Google-Smtp-Source: AGHT+IGBICOnHMUscRYyMjgmEnWs/ay+hZBpXEkd0FWdcwPImYWwYupR5A1QSQyYlH4KB6rrI3rwJxgErtcEXnG/GDw=
X-Received: by 2002:a05:6871:7382:b0:314:b6a6:6873 with SMTP id
 586e51a60fabf-32265a22294mr1678655fac.41.1757243626272; Sun, 07 Sep 2025
 04:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
 <20250906-tlv493d-sensor-v6_16-rc5-v6-1-b1a62d968353@gmail.com> <20250907103617.5400c1bb@jic23-huawei>
In-Reply-To: <20250907103617.5400c1bb@jic23-huawei>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sun, 7 Sep 2025 16:43:34 +0530
X-Gm-Features: Ac12FXweiy_J3XV4pBd5moNjn7MHCtWRLEMuCQqMqElP7HplfqY2zkgHY5Y3DwY
Message-ID: <CAFmh=S0AP4_9H8CiSp3oAciNF=FGMGp4bFz6QEJNFGqwdvj65w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: magnetometer: Infineon TLV493D
 3D Magnetic sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Krzysztof gave an RB on version 3.  Please make sure to pick up such tags.
>
Indeed, RB was given by Krzystof on the V3 patch but this patch got
modified for MAINTAINERS file changes which were not part of V3.
Considering that I thought it should be removed. I have added this in
the cover letter change logs as well. Is this correct understanding?
> This time I'll apply it by hand if nothing else comes up.
Thanks,
Dixit

