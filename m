Return-Path: <linux-iio+bounces-5158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE968CADA9
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 13:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F421C22221
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6080C74BE0;
	Tue, 21 May 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evKcC3YT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840047A74;
	Tue, 21 May 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292405; cv=none; b=QMTuXdbmEhpG6IZ2BX7mH+CUSjsROhedc48BOFO+wVHZltT1+2owwTjdQD/4o/sIp0nstPsBvoOjrvk2XqsQckyFcjJ2ouDAPQAJ4+WW9yb7TRQuElNknl7l0/h5MBY+yJSJlbMMXcGsjrF9DLSc07ylaWeBz6mHc8Zh+oOpRkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292405; c=relaxed/simple;
	bh=bgbL4qkqVJQCDQnzAo0jbcRu2jQl8c9c7m8V4LS1btE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzIpVgc72NugRVO3eIrhoXnI+zAjVi8L0xTvdYVl8YRXZKjAqlTfTuhxkw8oHPPixgX/LS1vQmrkqIb4i6zvyAgYa6JCc7705CBZjSbsRW9S06UhZROgTCoPPnNugBNwCL7y5EWgAVupvS2OlPM1G48naSIetWYOma4PYCv4lPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evKcC3YT; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f40b5e059so5316571e87.0;
        Tue, 21 May 2024 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716292402; x=1716897202; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgbL4qkqVJQCDQnzAo0jbcRu2jQl8c9c7m8V4LS1btE=;
        b=evKcC3YT3e6hmG0mTrY/b08rmdDx+blHrFleFIXtUyy6Xzjz8qjrnlifG79srxu+OV
         e8tepVEz3Gob24UJjRduGmsU+tB3QUcQwpPUEZGSaIbNvXWZUUadqkIqNxDYudvRr3QN
         gdHGGzxXPZNU4jL6LdHDktifDmFyYp8AnNWIG7wGEJbQuuMpzG60y9rkoqbDwGj3u27l
         c+NXJkG7i5O7fssuQyQU4i/h2ZgsrJV3DxUyIDAsF7m91wckMKZrDMx1sCPw5LPnpkYm
         hNKxLJLZfTEoWwGdq89ck37uoRyAdwBTPj3/k4vJ0p13Kzj9GNGcTR7AwFxENLV/mlmf
         2RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292402; x=1716897202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgbL4qkqVJQCDQnzAo0jbcRu2jQl8c9c7m8V4LS1btE=;
        b=Huyb5cM31d+A6yEhWPd6uIJ2Lh17mgY8/fscOJ32omYUoYd6U/gg/BY+bqfu6wPI2U
         a08UofU9xixhFU85kGztC+HG3EK6GnU6N5ZsQjof5zA/OXhtsDz2cg7Sr9LD9UauALR0
         a/p/AGl9uiBRpdYxdqErnJeQXuYZFUIWm0Z7pKrua3vuXS+yKObQzCgpQvk820I4ZVLQ
         yIH/OspvjUDyppJ1eGBmoW1VD+Uj2QISi9VO07z6x2d2kcuWsEvfq8+gJ0KXdFRokWaF
         ZhaFsrPAS2yIMVmNv6PT5tju4uCaKXyKUCO7kC5zSTlsNn3dWhMPICdULAMtaXWvgD0O
         HgVw==
X-Forwarded-Encrypted: i=1; AJvYcCUlb7nlsLFRYaT2KY5AZoP4Fii+ja6k6vSRti8fYti3gmG63XEIHFr9yLrhNFWZrpIjW2GyxQVbdEvZZtVYJypGIRKzUvQoU0AKIrAQaq6vITRx3m6WeQ78gTf8spCMsIY7sLqeYVj7VdkRDrXsLxlyPEzLRBi5j8gnxdrp7n02FE7NDN4xEf8ra0MGR0AvWbwkcuLNiT2r7ETnfdUXcg==
X-Gm-Message-State: AOJu0YwZ2ebEpV/JnO+6HzttBLqRKM2puX713KN8GBA0syMBJ/bHWL10
	lQq9StqN5+Z9K8NYBsfzZ+HFMB4hShOzK8dJwxLCsoNiIjODDuo7
X-Google-Smtp-Source: AGHT+IHvcCZyF+4F7NuebEMVZAlg5/2Fo32USFCmrjE0s61wGflmsUuW+CUAJ2Cuu2lxlU0PcU10WA==
X-Received: by 2002:a05:6512:3c84:b0:523:a5b3:5e21 with SMTP id 2adb3069b0e04-523a5b35fe3mr13753664e87.8.1716292401392;
        Tue, 21 May 2024 04:53:21 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5752c2e2f2dsm4201664a12.29.2024.05.21.04.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 04:53:21 -0700 (PDT)
Message-ID: <a35a8063dd3488093be9d1596268856fbcc02177.camel@gmail.com>
Subject: Re: [PATCH RFC v2 2/8] spi: add basic support for SPI offloading
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Tue, 21 May 2024 13:57:03 +0200
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-2-8707a870c435@baylibre.com>
References: 
	<20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	 <20240510-dlech-mainline-spi-engine-offload-2-v2-2-8707a870c435@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 19:44 -0500, David Lechner wrote:
> SPI offloading is a feature that allows the SPI controller to perform
> complex transfers without CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
>=20
> This patch adds the basic infrastructure to support SPI offloading. It
> introduces new callbacks that are to be implemented by controllers with
> offload capabilities.
>=20
> On SPI device probe, the standard spi-offloads devicetree property is
> parsed and passed to the controller driver to reserve the resources
> requested by the peripheral via the map_channel() callback.
>=20
> The peripheral driver can then use spi_offload_prepare() to load a SPI
> message into the offload hardware.
>=20
> If the controller supports it, this message can then be passed to the
> SPI message queue as if it was a normal message. Future patches will
> will also implement a way to use a hardware trigger to start the message
> transfers rather than going through the message queue.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v2 changes:
>=20
> This is a rework of "spi: add core support for controllers with offload
> capabilities" from v1.
>=20
> The spi_offload_get() function that Nuno didn't like is gone. Instead,
> there is now a mapping callback that uses the new generic devicetree
> binding to request resources automatically when a SPI device is probed.
>=20

Yeah, what I disliked the most was adding the platform devices from spi-eng=
ine
driver and then the complexity in the IIO trigger part of it.=C2=A0I also d=
idn't like
(as you said) for the peripheral to have to explicitly request an offload b=
ut,
IIRC, Mark was actually ok with the spi_offload_get/put() mechanism so let'=
s see
what he has to say. He's main point (I think) was for the controllers to ha=
ve a
way to know which offload instance is busy or not (but I guess controllers =
can
keep track of that as well with this approach and using the enable/disable
callbacks or the prepare/unprepare).

THB, I do like this approach (and it is what I had in mind) and it's simple
enough while covering what we know about this feature atm.

- Nuno S=C3=A1



