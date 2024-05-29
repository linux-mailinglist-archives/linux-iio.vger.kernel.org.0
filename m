Return-Path: <linux-iio+bounces-5423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63C8D2DFB
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 09:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1D61C225EB
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00811667E5;
	Wed, 29 May 2024 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOy2cQG5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9D15B99A
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967096; cv=none; b=Zr5yTwkIk/tK1mI3OM6HXcxCWYMd8GKRaXUHHvQ1Iec3M42kp/KP8PQVDBRHqp63VLCb+OcgzN0mDWP70OcU3Fu7E6O6/oJQB6tIp64XLAXvXRYSIY9etsV73/gtj4K+JGz1kkj2El2ivMutYRQePtuP2LYgZM1UCYKOwlDoGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967096; c=relaxed/simple;
	bh=fxAtXfk0qi43EVKznqK5x5RQWOFbzlN4V2TtoN5CZaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sw75g9i6iIeIEPxFjIDeI+kue1QNuhXtoZqHzBNepiftx/NWL5HMd9gf3CRMSa3UDeebCz38avHC9t4wzL1M9ddEjxT75Rjoe0na7NNyAW2/VmXmM59F+B2RpwnAaHn+pUueK2IGSvVXYyxm88lygHfdTUeTjoGpNKDqXyWO+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOy2cQG5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a626777f74eso203912866b.3
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716967093; x=1717571893; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxAtXfk0qi43EVKznqK5x5RQWOFbzlN4V2TtoN5CZaw=;
        b=aOy2cQG5+7WDp/b/MW1JoqndoDvRTXFklykAf1ylc3sKXm7ZT/FQn675XWlC8MBtJ7
         86yExqbMeSN+tLB9dhOxKdw1wjyNSOeKzRjsDqteEcpxUnprc3F7hEhM3C0BoSOii7k3
         AcPO5jOLasYisIyayA28R9Cdjtn5mRXvIrHZdlpJC562pkWTjXHsaULaUsO1OAW7jQJ9
         KFj4zf5UWv0TfQvasdMWFsojhgEv1jTINLk81qk99EHyyDjGhGcDhqaICiFPasLdkgbo
         DmYLLUA83s3jeZNGokT1M3VFsFnB6VWO0gFPLfmddnAdyM8t3s0VMu+PHBEGZITefTU0
         jtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716967093; x=1717571893;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxAtXfk0qi43EVKznqK5x5RQWOFbzlN4V2TtoN5CZaw=;
        b=K3StJhUNijCysguQbq9LL8BY0mU6Y5yqjKsb+u+jDz0udYCPom8rtZTnNhTHTlzgHX
         NE2n9lJVRjh98kKOYppcNrDbhVpReaPJ8AgrVWEr37sD9MyB2zveuK1GWHbiD+s5lwx6
         gbkYpz6k1qNfAGF9Ajr2N6ucQpMU+aDKOaOhVzPcMdVPe/7kgklyKS/EEnEtAR8NDBAz
         aqO3EgGiRZUnF2dkX6hSrbRZZgHKmjK95ZSOZ2Dut3O3MdjTU+5jD2wdvvOng5SIUSwv
         v+JXXSlZH1dP3a3Wt3eVxKLprosb4R3sDGmK+cWVSe1tpv2iss+gXiBcHX1KnJ9TFmLd
         xUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm9EoLE4qMpMdU9q0b/xkswwwiQasBXy9rag4vXylo+0PTcXbQvNWn+yzNxmlT0YwFb/dZYLM1SURqqEWEFtDImqh5UgfbS5dE
X-Gm-Message-State: AOJu0Yy/rtP+6JsYn9e8T+fGamc+FOjqJ2Kd9peZUJkDiY/COECMDsZg
	eFOmB3Wdv5P61ePOhYmdyiBxJtiWOGD7tOy6+2bvPbQGH0UtSo5M
X-Google-Smtp-Source: AGHT+IEXmkEbDD64TUPNbfrw8tGNnU+rVHjc8Hr24XCO8xrQ9qIl6TGUHrOEdrp8W1jabNd/onpx8A==
X-Received: by 2002:a17:906:2ada:b0:a59:c941:e5e5 with SMTP id a640c23a62f3a-a62646d5a8amr1363598166b.45.1716967092694;
        Wed, 29 May 2024 00:18:12 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a652baa786dsm20856166b.124.2024.05.29.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:18:12 -0700 (PDT)
Message-ID: <56bbd0b7b2618d803a38b1638dc2820599086f56.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: adi-axi-adc: make sure DRP is locked on
 enable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>
Date: Wed, 29 May 2024 09:18:11 +0200
In-Reply-To: <20240525175418.7b537296@jic23-huawei>
References: <20240522-dev-axi-adc-drp-v2-1-b63c9790a48a@analog.com>
	 <20240525175418.7b537296@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-05-25 at 17:54 +0100, Jonathan Cameron wrote:
> On Wed, 22 May 2024 15:14:56 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > When enabling the core, make sure DRP (Dynamic Reconfiguration Port)
> > is locked. Most of the designs don't really use it but we still get the
> > lock bit set. So let's do it all the time so the code is generic.
> >=20
> > While at it add proper mutex guards as we should not be able to disable
> > the core in the middle of enabling it. Also reduce the timeout time to =
1
> > microsecond as it seems to be enough and goes in line with what we have
> > on the similar DAC core (adi-axi-dac).
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Sounds like a fix, so fixes tag?
>=20

Can add one even though we do not need to rush any backport as the current =
user we
have for this is not doing anything crazy :).

Anyways, I'll then split the fix into a separate patch so it's more clear.

- Nuno S=C3=A1

