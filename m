Return-Path: <linux-iio+bounces-24289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52003B89C3F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B95A01446
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF650313E13;
	Fri, 19 Sep 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FuaBUzXS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB55313D75;
	Fri, 19 Sep 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290377; cv=none; b=W2edY/+P0Fi1PGfn2KZTNU+2wOiRwszIxTncm2V3YFzXU3dKCIif7wt3Wtpt8UgU8i+4Y4XmEUxg6SuyWlAlA9nePtUfsqdBJOcHCpeYNpcHnvDpl6HuyY3UvI8orNWdYrzG6KZajGrg0LembbO7e08RNo7T4fL+Rym2tILo9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290377; c=relaxed/simple;
	bh=G+eKhQdY3LXsknfdquHgWXFZCZJaYm8/KtCWfTr3cUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbsjHhFOP/Bfcm2Nsu5eToAoR8fXH9bmdNap+6hNBTZNkS1q4q23Knv15KfdxIrv5/29YVO3CIJNB4htKWWHv3ktNwNwc6iVwQQ6uS6gKfG49wqY7zJTTeMu15S9pztOQZXcjHyYQGYYD2GFaI0wg+83zkR8IKfgsm21w+Z/NR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FuaBUzXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E045C4CEF5;
	Fri, 19 Sep 2025 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758290377;
	bh=G+eKhQdY3LXsknfdquHgWXFZCZJaYm8/KtCWfTr3cUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuaBUzXS0qCl6HAJ4XYjHQp6it8Dm536/l+ZByopsVOtdtZ/m3yVdkKgZIERvVALP
	 nrWyMbs/HCYptk+HuEp9y/UxEBUEBwq4i478l52wlAqBpQ2QcqULucRqK3+Fyu9k7b
	 ygJGYPQ9kxlywpHj5HihIV09eFg543KFXH4iaKZE=
Date: Fri, 19 Sep 2025 15:59:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	sre@kernel.org, krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <2025091925-thirsting-underuse-14ab@gregkh>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
 <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMxWzTxvMLsVWbDB@smile.fi.intel.com>

On Thu, Sep 18, 2025 at 10:00:29PM +0300, Andy Shevchenko wrote:
> I,o.w. I principally disagree on putting MODULE_IMPORT_NS() into the header
> file.

Yes, please never do that, it defeats the purpose of module namespaces
completly.  If you don't want to have module namespaces, don't use them
for your subsytem.  Don't use them and then make them moot by putting
MODULE_IMPORT_NS() in the .h file for the symbols as that's pointless.

thanks,

greg k-h

