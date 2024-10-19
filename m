Return-Path: <linux-iio+bounces-10797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C29A4EE6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79009B25EB0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBBC17DE36;
	Sat, 19 Oct 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KryZxhla"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691922338;
	Sat, 19 Oct 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349760; cv=none; b=A5KYTpSvuoHTZ65QefOxxiVqsyN5CNyNo+0qazuZUs/SDHXhikBkaI7fwjj6z/Z/tXLy5eR064lymQvNhtJhRX191oiHKvjTGnthd27q8jfVrRbZGqEm2vrUnatXjwVP5L1338oVURb8IN2S/IyIecXJnZqypVQCAP20mEjrLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349760; c=relaxed/simple;
	bh=oK4Pcb440cKuVgZfd/oc6U9n/M8yHkAa6Bb5dH4nkh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXVk1W506w8jAdHoBkB5JBZ7DlvKRCJLrhCZHWvpYQf9fruLLrJQyfFg8bWVgooNxBHZ+XbwXpX2unj8+QZJFK5PqcLqwMu/7hhtQ4kq3k6xKD17miiYjOQSdqU1D6NZKyGTvi8AYLLxqVZW64nLaf42JBU75ylBtWCBr8SY9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KryZxhla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9B5C4CEC5;
	Sat, 19 Oct 2024 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729349760;
	bh=oK4Pcb440cKuVgZfd/oc6U9n/M8yHkAa6Bb5dH4nkh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KryZxhlaGTCKuS6bK/dGEL4JJpC1paCUEVI3faG0uS0lln53sbv9GcvLLvkYpvgYK
	 VJzWRrjc7lmRWVggMOB76IZC+IWnfFTcCWVML6/ULRSQn5ebi1i3Deavy9sKeqCYzW
	 7plZpubSuoiTXgSOjkuZcjOBtvGIrjvn4VkNmbt7UP4WAi8wOfPULpskk0gXrRsT+4
	 BaJY4IR+Wy05w+nvZbfo48tb3jr2IwvXETm5DQi8BX7k9cChNykL6xCPypbK0FC+FI
	 pUrH+2KX9S0rOBUv8FBbq9sqEWfgOR09NtETUlXNX4jsFUqmphEugLAPKngwsXTNUe
	 304E/ghYvgiPQ==
Date: Sat, 19 Oct 2024 15:55:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Ana-Maria
 Cusco <ana-maria.cusco@analog.com>, George Mois <george.mois@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20241019155510.1885393b@jic23-huawei>
In-Reply-To: <7f3ccd71-f885-4f84-bda3-cb2adaffc4fa@linaro.org>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
	<20241014143204.30195-2-ramona.nechita@analog.com>
	<7f3ccd71-f885-4f84-bda3-cb2adaffc4fa@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 19:59:47 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/10/2024 16:31, Ramona Alexandra Nechita wrote:
> > Add dt bindings for AD7779 8-channel, simultaneous sampling ADC
> > family with eight full =CE=A3-=CE=94 ADCs on chip and ultra-low input
> > current to allow direct sensor connection.
> >=20
> > Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com> =20
>=20
> <form letter>
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.
>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>=20
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>=20
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>=20
> Best regards,
> Krzysztof
>=20
If we go around again, please also fix the part number in the patch title.

Jonathan


