Return-Path: <linux-iio+bounces-8729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6895D556
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EDE28442E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A004190473;
	Fri, 23 Aug 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qntfOPd4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A98757F3;
	Fri, 23 Aug 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438128; cv=none; b=dtxmxpipM4rv09/oH4wuLDY7co4D0Kqvp9vAqrRSmXZPZgqsu8k1vURhgs8cQJutis4wmjiqsIh5jIm7vHgRPcO+X5bA6qcM7Ar+Hpf5klyYdb1/gRRq8Y6d1WxjZ215IZZEF5P2am34QAxHCYnqiZDWVfKa7hRTlpoLEK/9i9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438128; c=relaxed/simple;
	bh=Wpm1M+EL+xssIty9Xs4HeEYne37qV6qGfa/kM2c0/t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOQ87yXd8ZvzoQ+Wt64Ew0Ly2F+0dCSWMJanNyo4ACc7b3UujRg9rdnHdL58FM7ayn/xZSDN5M/WAF5MLuYp7tqaH/V+KgkY2ZMZnbd517YrrFJmv/PvmhR1Y0LZjHqXI3Jt+JV2CsD6ge/p7Q7QBy14Fr6mga1exoL/GnDFHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qntfOPd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4830C32786;
	Fri, 23 Aug 2024 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724438127;
	bh=Wpm1M+EL+xssIty9Xs4HeEYne37qV6qGfa/kM2c0/t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qntfOPd4lHcqqO3AfjL3G4n1ezCRpc+LolAbFYLtSrb4BnECn/7KLYi06KhCmcIbO
	 iD/zSgwRadX7MLfWb1nPdQf53fOaMwwi9u4n6YVdyP51E46OP8sLLlaanGJ1eqy0J5
	 T3Yt4asxe1Yfy22IcKe0oNmcTKpcEwdP2B0G2mUMgPUDtWIAJci4l4p/P0Xpbb+zt9
	 UddWtw03bkqICrtlob3FHOkS9HOD1F7+P0h0VOF/Rxcp+ek7vL0f50AA+JTFG9zQBE
	 j6vmcG12SbTE0UVOx9qnuX4KX/0B7Q3isdBs5XVjLiBdpFXbFneJtYASwBnDUASqf2
	 iiB/qh6hC7Blw==
Date: Fri, 23 Aug 2024 19:35:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@mainlining.org, Danila Tikhonov <danila@jiaxyga.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 4/4] iio: magnetometer: ak8975: Add AK09118 support
Message-ID: <20240823193517.68c6dc4c@jic23-huawei>
In-Reply-To: <20240819-ak09918-v4-4-f0734d14cfb9@mainlining.org>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
	<20240819-ak09918-v4-4-f0734d14cfb9@mainlining.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Aug 2024 00:29:42 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:

> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Add additional AK09118 to the magnetometer driver which has the same
> register mapping and scaling as the AK09112 device.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
Applied rest of series to the testing branch of iio.git.
I'll rebase that after the pull I have outstanding is in Greg's
tree and then it will become togreg and get picked up by linux-next
etc.

Thanks,

Jonathan

