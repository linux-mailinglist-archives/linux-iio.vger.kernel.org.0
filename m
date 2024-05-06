Return-Path: <linux-iio+bounces-4851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EBA8BD0E8
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DB4B21695
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F378153824;
	Mon,  6 May 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfEjx5Lu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38B153583;
	Mon,  6 May 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007564; cv=none; b=g2051KvBELRE822nbQSEGPWdlXP7IELyRehbowa2mwZa8qdv4GFT+LT8Z/1+B89M8XLWig2/AzHyJCsX+PQ6MKLZ10hy+RUpsKyyLaLfQdt9G9HE4ykhJlwwfhxdRnRjJbp7gboq5hUmpbFwxcmZJmFQYcHcLyxfTWhXT8gdWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007564; c=relaxed/simple;
	bh=mS7dSTeWCBi5ZyYS09A2fI9maoy49+AMSmPQlxoNqps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MQnoqd4eHBI5qsTIuhPp5LiJCu2h6PWCyMf5wO6Z2MgS+H1nJLSny9zKdIEQygzsNeWsnHVjLT6rx32mV3ZmGKKhmhHVMK2MkrYmoNiegEkxLLP5DSSMX9ZBw2JOFonSeDG7lqbxMul50NdQKys3Vd0WoKH+ucpgn4ZFHq3BoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfEjx5Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC200C4AF66;
	Mon,  6 May 2024 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007563;
	bh=mS7dSTeWCBi5ZyYS09A2fI9maoy49+AMSmPQlxoNqps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qfEjx5LuL6bEffjRxJ3mTsH7wUbsTYK2zv/kCnb0FqyCADylG1X3h4GDctDp87LcN
	 ho5M7DPB8GVZpQR+W7uuldtRJ1DsWnZaQ2GtECLFCPHuvwtnc3FUeEvH9OXTPIREVH
	 qhViGMzOF/ROqN7qaUL5xixVYa3AdwK0kkPUBUUUOhtLljgYQyaG6ZcJuGc2kRckiS
	 JZQIhA4sMuFK07RLGE6kiak3yPV0E1sh7T2zQvYOo5fTScibR6kqMh5ONj43akUL3a
	 rg9NVNAl3QG/+5macYiqyI0D4Myn5Q4OBdNWjk6lzdU9C9iCQqq5S9q0lTFLSaLImq
	 fE9uJ5u90f3RA==
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
Message-Id: <171500756002.1968386.17290951989557329800.b4-ty@kernel.org>
Date: Mon, 06 May 2024 23:59:20 +0900
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

[1/7] regulator: devres: add API for reference voltage supplies
      commit: b250c20b64290808aa4b5cc6d68819a7ee28237f
[2/7] hwmon: (adc128d818) Use devm_regulator_get_enable_read_voltage()
      commit: cffb8d74bd4e9dd0653c7093c4a5164a72c52b1f
[3/7] hwmon: (da9052) Use devm_regulator_get_enable_read_voltage()
      commit: d72fd5228c9f2136a3143daf5c7822140211883a

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


