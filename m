Return-Path: <linux-iio+bounces-12093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B809C2E3E
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738751F2184F
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875619ADB6;
	Sat,  9 Nov 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obk2G2Xv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473C2233B;
	Sat,  9 Nov 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731166233; cv=none; b=Tl+lqFOQfBPGZ6TomAeBTQ5GPkL8UYguJqUGtVh78mCxEv6EgJEQ/zGTYpvuWSCKyg5RK7fpJIS7M6GuHCyhy82z4FHmFy05nRw1gGmcfNlWCH0UxHbSdYblJOV93zIB7bvV4mNc6TiJ+bEvo9hODcySwjHLvRg5K/wd7Mouedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731166233; c=relaxed/simple;
	bh=roFrbOlCT/sdsb/tZqBh3bDN6GPUXZ4uT1VhJyLd4xY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p42BEJdmw8VAlbYmP2ILG3jmzeDy+25t5f1T3QYFiSOawEPsvkPfmTNwoaQzs2/3WUfW67udpQpvqenM1hAVJYcSV2ej4Tu9Nb9Hdl2Gvo6EPiWHwVRck5W69KQcknED9RPkiCEhXj5laqnQ02HJR7rR+yilD17Fb9et5NFxLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obk2G2Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0C9C4CED5;
	Sat,  9 Nov 2024 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731166232;
	bh=roFrbOlCT/sdsb/tZqBh3bDN6GPUXZ4uT1VhJyLd4xY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Obk2G2XvDl+JhN7ezrwoa9gB9DYov1d4F4JJCcVdhq0BRmvJmpsBBpohcptgqWffz
	 ZFCYNsdT+fMT9YVilzxrJ+DH7kPfjwwWHQghrDqOss/KrMsCECNfgNy3Ub1tUwRMfF
	 dbP511TBFsOLo8ENotJJbhQyGSXL/oH+AunZpTKwauCKp8rti1Gd2gTK1RdvFp2AvY
	 t8WtUf40AThvZCJ0CsnUvJzVguOedpbwsGpcfmM/K4LdL6eivg3YxEFDfODu3NiJNA
	 Gzxr9xh1QPZ6CdniS9tJVB66w7mZnNpIhbuUrt9tx9MoZoNn9R81WPIGZfyl9rXVkD
	 d6+YTgDk7FJ3A==
Date: Sat, 9 Nov 2024 15:30:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Sebastian Reichel
 <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <20241109153022.4af7b433@jic23-huawei>
In-Reply-To: <20241106090422.GK1807686@google.com>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
	<20241106090422.GK1807686@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 09:04:22 +0000
Lee Jones <lee@kernel.org> wrote:

> On Mon, 04 Nov 2024, Stanislav Jakubek wrote:
> 
> > Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> > filename to match the compatible of the only in-tree user, SC2731.
> > Change #interrupt-cells value to 1, as according to [1] that is the
> > correct value.
> > Move partial examples of child nodes in the child node schemas to this new
> > MFD schema to have one complete example.
> > 
> > [1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > Changes in V3:
> > - remove $ref to nvmem/sc2731-efuse and list the compatibles with
> >   additionalProperties: true (Krzysztof)
> > 
> > Changes in V2:
> > - rebase on next-20241029
> > - drop partial examples in child node schemas, move them here (Rob)
> > 
> > Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> > Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> > 
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  17 --
> >  .../bindings/leds/sprd,sc2731-bltc.yaml       |  31 ---
> >  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 252 ++++++++++++++++++
> >  .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ---
> >  .../bindings/power/supply/sc2731-charger.yaml |  21 +-
> >  .../bindings/power/supply/sc27xx-fg.yaml      |  38 +--
> >  .../regulator/sprd,sc2731-regulator.yaml      |  21 --
> >  .../bindings/rtc/sprd,sc2731-rtc.yaml         |  16 --  
> 
> Is everyone happy with me merging this through MFD?
> 
Sure for IIO bit.



