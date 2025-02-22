Return-Path: <linux-iio+bounces-15946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC2A40913
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A08D42556C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE819E975;
	Sat, 22 Feb 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbY6Dl0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF1156F41;
	Sat, 22 Feb 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234562; cv=none; b=uaMCsld9QulBZ4Gwg7qCPY0Ka9+f2875e5KYaMRwqug7VhAYit66kS1FZoI+JlyX6iLgtEQ6/14bPRayC/QvjCpIy3X3/fUtqPzpyTlHdhgnGFy7uUAhXwj/Dm0Lqfi2uOcc0/sy6gLc8Y8npfWC+qZNosM4l/h5Bs0LhyHxg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234562; c=relaxed/simple;
	bh=+kOgJOLeUsEcRopHliSLADFOsTli+aEEbCVMgK8cpS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAhHupsSynSBTY6tdnKxh2rUyHW7Qdcu+IRrkcuPbGJK0U+abLotU2YZB85y3YXa8KGy/bxVArqp78Vu5/gpQeeVmOnmpVuRq9SqVnebTXazIJDVOWXrmKgUzwyZpTkXDjOqUuNhMztR3Ivgc7EHBEtsMFcX/73uFpDjfOO1D9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbY6Dl0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F820C4CED1;
	Sat, 22 Feb 2025 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740234562;
	bh=+kOgJOLeUsEcRopHliSLADFOsTli+aEEbCVMgK8cpS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rbY6Dl0q/olSwgwc9kO9jEoujL0x2R/2TQRchZ7LbOwjr09BtdqA+MppLWUdFxDXB
	 lkNihXX1fPfbopiPvnoOFKXUU6YLgepdwwKLh99HXML/1cs6EtYSvD2nm9cPql8PcU
	 tSvNYO3hARszAv1ANjDXG0Zv5OkKbJcqgL0jnnR/sRcZtO8J2k9RUQoeh1bHTb1ZPr
	 B/SPwPJ8X47mEqGhqiAQZkVA60KYSx3WijrZX45DeKTs3yJbc22xqna4TbGGf8Wfvz
	 FQmzDkdFWJltu4InfCyvKc6HTcEedQlaps7JFAFqEw7iqFEiXMJEtc8rFaK1cv7VGR
	 C9DVChcOcyVyw==
Date: Sat, 22 Feb 2025 14:29:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge
 Deller <deller@gmx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Message-ID: <20250222142910.4e6b706d@jic23-huawei>
In-Reply-To: <20250218132702.114669-2-clamor95@gmail.com>
References: <20250218132702.114669-1-clamor95@gmail.com>
	<20250218132702.114669-2-clamor95@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 15:26:59 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add bindings for the LM3533 - a complete power source for
> backlight, keypad, and indicator LEDs in smartphone handsets.
> The high-voltage inductive boost converter provides the
> power for two series LED strings display backlight and keypad
> functions.

Wrap patch descriptions to 75 chars as describe in submitting-patches.rst

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

