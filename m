Return-Path: <linux-iio+bounces-11606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEF9B63AD
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC91B22E4D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC71E9072;
	Wed, 30 Oct 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWATzUEO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E71E3DD3;
	Wed, 30 Oct 2024 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293504; cv=none; b=e4vy6i9VJbtfcjxtKnbdC/SPkIM1z2PHZPuTempvgDR0Fb3fiVL7yehmmiMt0OVQ2A17b/Ja7zc1aRgWc0KJyWkU06LKS5piiHVd0dVOJZKDojUgtYEMag7KvCfDKks1dsxL6AObtqyS2xJGWWSgYi6htGRssMUkD5l7H4jLlBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293504; c=relaxed/simple;
	bh=078Xyy2dsa/WIxqMkf70NPMDAWJaZI2RrYQPgzscuXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnb30Y2DoFzSui66IJXl4S8nymgf+zRtlbvZLzMwcpL9B0fJHG1pzsUBnEjZagdM9xfsQMUpJ9B5d3Nzfj3vuoapHTWPRR939B+YbkfPMOrOvf/xwN+7dszaDFBshzyGu96LkDhNo8xCtTT1m+HrJ6MjsxLtJaMsC9YaUXEAqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWATzUEO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d47eff9acso4677408f8f.3;
        Wed, 30 Oct 2024 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730293500; x=1730898300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=078Xyy2dsa/WIxqMkf70NPMDAWJaZI2RrYQPgzscuXI=;
        b=CWATzUEOahPXo+eO5YLCTh1I8anJnKYI++9aDjA+aLB4o64Q70je2ZGZNtITiH4CwA
         E3eM18ewxSLvxV7TTmmhkKQX0Id1qdxW3XYc/wiYCbZ0FJrxxxovR1E2/wDP4EekDNmL
         Bu4s/ezr68Q+AvV3W9QW1crFWrYEaSvDHXEXY/L1PYqVxu8EoRbbBKXQoIDUPUYHG3n5
         tEwJWuTnHoUZdFeC8Zi9w5chGDe3B5hfbPx60E3rDQ0dc/CdunhC1HkslAJpjuQxMK11
         uDP+xA5Z8wAPGcm+JFyzH4PXYYm8ZjaBXote3C3uCXUemL3JleMgJiQ2ivw4a82Cjpz/
         xK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730293500; x=1730898300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=078Xyy2dsa/WIxqMkf70NPMDAWJaZI2RrYQPgzscuXI=;
        b=Bnamcnt/srzFxy3byQU3OthaPC/zgX7WFWIxgfsWUCHoW6sogQ45Gi9KUyrlm0er7d
         +aNfWttqDG5Zmpp4kzqW+Kpir8L3z3qvBB6NP62CQGpEoJbmob+jGx7SBxv+pldIYpaq
         JrsvMN7Tyv76sr7FNdRqbQCsvGeRSazKg2PbWu7N24BAXvy0eo12dmhWLSs/n5Fg0kW2
         h2CyBeTKTLFp4EwB7nD6nr9nHgdg/RgvnIDd/KEqFaKHUZjsOrjaGQ+/Syhe66/yI8Dc
         NOULqsNyWQyk+s2bvkZeckNZ90gahyDtlVpW+c8yVOqpBuptNX3anTT4uGhzO9FqAGmU
         c70Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQvAvXCG8afXu8DfMXaTSAKJmy5TRQl/d0IlYou43vThzlroImhiUH0gj6HVyNjGrNfbdtbtvgquI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCHwOteXRu7wtlcRIoZxymumG5rGrdkqlnF7NApzEaZkjUhQh
	bDH5IMhRkz8yHRi/Ja2DfYoJvE4e2gsmp2WzrxShj0hkrtz09ihk
X-Google-Smtp-Source: AGHT+IFpOOd/uvf/Jny8m0n3aBYwWdwnNXjb09/Dv9El2B+45ip09m74HMLDQ+30Ig3aA5elOTbF/g==
X-Received: by 2002:adf:edc9:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-38061163b1dmr10053379f8f.26.1730293499587;
        Wed, 30 Oct 2024 06:04:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b48216sm15257332f8f.59.2024.10.30.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:04:59 -0700 (PDT)
Message-ID: <a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for
 reading irq status using a GPIO
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Date: Wed, 30 Oct 2024 14:04:58 +0100
In-Reply-To: <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	 <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-28 at 17:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Some of the ADCs by Analog signal their irq condition on the MISO line.
> So typically that line is connected to an SPI controller and a GPIO. The
> GPIO is used as input and the respective interrupt is enabled when the
> last SPI transfer is completed.
>=20
> Depending on the GPIO controller the toggling MISO line might make the
> interrupt pending even while it's masked. In that case the irq handler
> is called immediately after irq_enable() and so before the device
> actually pulls that line low which results in non-sense values being
> reported to the upper layers.
>=20
> The only way to find out if the line was actually pulled low is to read
> the GPIO. (There is a flag in AD7124's status register that also signals
> if an interrupt was asserted, but reading that register toggles the MISO
> line and so might trigger another spurious interrupt.)
>=20
> Add the possibility to specify an interrupt GPIO in the machine
> description instead of a plain interrupt. This GPIO is used as interrupt
> source and to check if the irq line is actually active in the irq
> handler.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Hi all,

Regarding this, I do share some of the concerns already raised by Jonathan.=
 I fear
that we're papering around an issue with the IRQ controller rather than bei=
ng an
issue with the device. When I look at irq_disable() docs [1], it feels that=
 we're
already doing what we're supposed to do. IOW, we disable the lazy approach =
so we
*should* not get any pending IRQ. Also looking at drivers as the xilinx gpi=
o
controller, it seems some are careful about this [2] and make sure to clear=
 all
pending IRQs when unmasking.

Jonathan also said this:

"True enough - that race is a possibility, but not all interrupt inputs
are capable of gpio usage whilst setup to received interrupts."

To my understanding this also means this is doomed to fail for some devices=
 or am I
not following it?

All that said, my naive feeling would be for a masked line to not get any p=
ending IRQ
and if it does, the driver should make sure to clean all outstanding interr=
upts when
unmasking. But I'm far from being an expert of the IRQ subsystem. Maybe it =
would be
interesting to get some inputs about someone who actually knows better?

[1]: https://elixir.bootlin.com/linux/v6.11.5/source/kernel/irq/chip.c#L366
[2]: https://elixir.bootlin.com/linux/v6.11.5/source/kernel/irq/chip.c#L366

- Nuno S=C3=A1



