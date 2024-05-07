Return-Path: <linux-iio+bounces-4859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C96F8BE6BC
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15681F2389B
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DCF1649C8;
	Tue,  7 May 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaVLuODM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971A160880;
	Tue,  7 May 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093920; cv=none; b=Ay6zG/slMlJ0HtHftXw4emxz2S/cBVu/G8QHl5UlM7Xuret5tGu086fw08P93rovC66J0xDB19Qop4j7fdzRVaDVcVs68uKN0TnofsWaP9yIsDfYKM7y2atUCkgGTnJvMJceL5tGHbhxJ6/bH+lbU04UZLTsIDtyS5G8cjBCz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093920; c=relaxed/simple;
	bh=gsF49rpRd7cEvtum0swJOWyyH0y73tl9jTA077FL6Qw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WkZmWT1uKcz6joxxp9htqgUmwPr+stY5SPoe8fFrnyJnCiXE47p+C07Pd9PDfgisl1ivCoAQBPF/LHcrJnSasvFvgNsy9fLiTlt7zZJFd0purUCAjMUPOuVvVLZnZImmpKxojWt7p56dQ+VfwW2nSdLaeNgBI198sHFECBbdo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaVLuODM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF7AC2BBFC;
	Tue,  7 May 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093919;
	bh=gsF49rpRd7cEvtum0swJOWyyH0y73tl9jTA077FL6Qw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MaVLuODMusqKr76w3NGsb6FBrSHT41EgQOFGJkVyUczjEkAXPgQna4W8w7b/wwfFQ
	 5oL3ksgUpOuMfg87rkeJsH1wB5H/3Zvk1NP2v0RhmIDoCKyFCLPgunfXC0geT926Bh
	 Sr405Gd/YESltUsO0+eqj4KSFcOfGe9ekWaAI5u2ac2ddt6kkMKZoeYCQVq8c8S6ZT
	 xJXqRYZPsHtVAn1W79kR7Jjdj6mV0fCnKv7tohHRHcvF48HMNllnYj970xF64gkrdc
	 i4i2beZQGR+UOhz4HZ6VK4WeHht+CJZrao9TCcbYRE1Oa41Dat/gCzXRHB+Owtoree
	 rsyRcFRfahf6A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-input@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
Subject: Re: (subset) [PATCH v2 0/7] regulator: new API for voltage
 reference supplies
Message-Id: <171509391425.1991000.13525667517853877249.b4-ty@kernel.org>
Date: Tue, 07 May 2024 23:58:34 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 29 Apr 2024 18:40:08 -0500, David Lechner wrote:
> In the IIO subsystem, we noticed a pattern in many drivers where we need
> to get, enable and get the voltage of a supply that provides a reference
> voltage. In these cases, we only need the voltage and not a handle to
> the regulator. Another common pattern is for chips to have an internal
> reference voltage that is used when an external reference is not
> available. There are also a few drivers outside of IIO that do the same.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[4/7] iio: addac: ad74115: Use devm_regulator_get_enable_read_voltage()
      commit: 41b94bc6d96b9b046ef08114f057dcc6c52e28b6
[5/7] iio: frequency: admv1013: Use devm_regulator_get_enable_read_voltage()
      commit: 2f4bb1fa758abf4f5ee5a70ea7c2b1b8c8f7625d
[6/7] staging: iio: impedance-analyzer: ad5933: Use devm_regulator_get_enable_read_voltage()
      commit: 9fcf6ef3e10b9fc605d84802058c0f30517bbaa7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


