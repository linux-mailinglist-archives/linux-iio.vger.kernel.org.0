Return-Path: <linux-iio+bounces-6055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690D90121A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360021C20E10
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD24317B;
	Sat,  8 Jun 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgUEZpTu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386911718;
	Sat,  8 Jun 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857663; cv=none; b=PSYSPsSxh9LL5rkb+qJYp6iWrMunP0pM2FJHn9JyBrCxNzBtioqjv797eKxVpXLuLUZgqh2Wdl/kk4dWWBQTmna0cPwvHWnehkPSvwygopvSkA/NTbXMnpY5UvJZKAGEJ/w5iYTCixXw2Uh5EwdILJlLZdMp7uqjh5J9DVCeLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857663; c=relaxed/simple;
	bh=50S6Lswn1r44hRlmB2kSl8+Im7fYL4RZp/xxNiPMJhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBp7jdN1vW8bhTCez5Do092ztPruwLU7reTp4Zu6yCMVH0u72bfjz7g+IcjDdRZlOtwNiZa+XSgx5a2f1QJrduNks6n0Myth9ly3xq6ChFa+OfQqj6oj2pDEawvGYzSF/QakyJaZPm+rZ9444WZmO2u+ZNml8/gzOOSp8EnIZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgUEZpTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B3AC2BD11;
	Sat,  8 Jun 2024 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717857663;
	bh=50S6Lswn1r44hRlmB2kSl8+Im7fYL4RZp/xxNiPMJhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MgUEZpTuPd524grhZFpsVtXgC+CsvaHZO1Nh54y4V8xKCyxFBqFwZ+z8cj664VE3D
	 3uJGOy7ZMaSVeY63B0RdiTOOIPqMn9cPxXuDXI9i5dLqQeVi0BUXfhO/RrbrEf/B3M
	 VayBF9g1W1/hkVWK6mYWqJVe34A5qnLd4bJ7heYLPEToWYh6pQqej3DB8fzPp/AaDp
	 uLXmoEnWxE/5UZRI17zXirVvFdn1hz1H4B+gSMgbhuDyN2Xugg3zbbjSPYgMrymdo6
	 ejfJuM2m4JphLcskOt7tUmtAHRcy91ko2ANWQlK26P98DPEW1EMiN2X2eurIlU+j9l
	 uyRCYPe5O+0GA==
Date: Sat, 8 Jun 2024 15:40:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael Hennerich"
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 1/5] iio: ABI: Generalize ABI documentation for DAC
Message-ID: <20240608154053.1cf1097e@jic23-huawei>
In-Reply-To: <20240603012200.16589-2-kimseer.paller@analog.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
	<20240603012200.16589-2-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 09:21:56 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Introduces a more generalized ABI documentation for DAC. Instead of
> having separate ABI files for each DAC, we now have a single ABI file
> that covers the common sysfs interface for all DAC.
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

A few comments inline.

I wondered if it made sense to combine voltage and current entries of each type
in single block, but I think the docs would become too complicated with lots
of wild cards etc.  Hence I think the duplication is fine.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dac   | 61 +++++++++++++++++++
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 31 ----------
>  2 files changed, 61 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
> new file mode 100644
> index 000000000000..36d316bb75f6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
> @@ -0,0 +1,61 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +       		Toggle enable. Write 1 to enable toggle or 0 to disable it. This
Tab vs space issue - see below.

> +		is useful when one wants to change the DAC output codes. The way
> +		it should be done is:
> +
> +        	- disable toggle operation;
> +        	- change out_currentY_rawN, where N is the integer value of the symbol;
> +        	- enable toggle operation.
Same question as below on whether this is accurate - Maybe it just needs to mention
this scheme needs to be used for autonomous toggling (out of software control).
It works for software toggling but may be overkill!

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_rawN
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute has the same meaning as out_currentY_raw. It is
> +		specific to toggle enabled channels and refers to the DAC output
> +		code in INPUT_N (_rawN), where N is the integer value of the symbol.
> +		The same scale and offset as in out_currentY_raw applies.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_symbol
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Performs a SW switch to a predefined output symbol. This attribute
> +		is specific to toggle enabled channels and allows switching between
> +		multiple predefined symbols. Each symbol corresponds to a different
> +		output, denoted as out_currentY_rawN, where N is the integer value
> +		of the symbol. Writing an integer value N will select out_currentY_rawN.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
> +KernelVersion:	5.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +       		Toggle enable. Write 1 to enable toggle or 0 to disable it. This

Mix of spacing and tabs is inconsistent. Hence the odd indent in this reply version.

> +		is useful when one wants to change the DAC output codes. The way
> +		it should be done is:

Hmm. Is this true?  If we are doing autonomous toggling on a clock or similar than agreed.
If we are using the out_current_symbol software control it would be common to switch
to A, modify B, switch to B, modify A etc.

I think our interface has probably evolved and so this might need an update.

> +
> +        	- disable toggle operation;
> +        	- change out_voltageY_rawN, where N is the integer value of the symbol;
> +        	- enable toggle operation.

