Return-Path: <linux-iio+bounces-27847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7660DD29E85
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 03:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DEA3023D7D
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 02:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE3334C25;
	Fri, 16 Jan 2026 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUxzyPH1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53419D065;
	Fri, 16 Jan 2026 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529337; cv=none; b=b+ensUFcarGB8J9UUZ2L1GerlznWS1g8hkYksGy0RFxPNhEBaRx/LKri29A+VBbQfrXAlenHGpr6s1ooVm0o80BMyB9BcboeypSaTUHHNJsQmjcptNr0fJYKAfpwXXFX7sDQn4vfFRMiiKYvfGgS6+Zuou7vjWa6DGNbcc2aV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529337; c=relaxed/simple;
	bh=sno2tWjsBNPmpnaKlE6qtXy545sE4ON2GCYjm2//rew=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=oFHK6Ec0jr+zIQRriIQ/m+zxCzr+zWKyl/heqTlunesgez2XIVoB8JSav/yM2AFJDHRq4Y2hc7RQczbS/hYYOclPx3m/5MM3dnPWOe9ZHQlbGIajeO9SKpG/AAzRpaEOoeKwjMQPggzyGPBkwmltb8Choh14HfsxNij/Stb/ESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUxzyPH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7890FC116D0;
	Fri, 16 Jan 2026 02:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768529336;
	bh=sno2tWjsBNPmpnaKlE6qtXy545sE4ON2GCYjm2//rew=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cUxzyPH1/GE0ZbZk/CuOg6tqprq5nDKPLtaNV16nL6PhCDMsGPF4JERgpWvmcBnw4
	 NerEoIpBdO0aQQtqMbQW1zF/darIsPRQGttdVTiyqJw422E8tgVSCdcqFJ1gcYtGH4
	 QA529vsED10PaXQsIYI7m4BEja+zsTXygdvMKGbX9naiUsMBchvwU4M4m5aeEGVGAP
	 oP1q6+//9LFe36a+QFuxXdb8BJo2w0LGzfIkKPHE3AAgpP5Xl3kcxXlXeLi+Q6ws/P
	 6E6VcGnYdUxAE6K771ftOhrTHpudxLP5G8Qy5y3vD1Lt2WUI9Tqoe+ZXDWPV3H1vtt
	 lMP79gf5Nt1vQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260114092742.13231-5-angelogioacchino.delregno@collabora.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com> <20260114092742.13231-5-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 04/10] spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
From: Stephen Boyd <sboyd@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org, angelogioacchino.delregno@collabora.com, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com, Jonathan Cameron <jonathan.cameron@huawei.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jic23@kernel.org
Date: Thu, 15 Jan 2026 20:08:54 -0600
Message-ID: <176852933471.16445.12620793496789127631@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2026-01-14 03:27:36)
> Some devices connected over the SPMI bus may be big, in the sense
> that those may be a complex of devices managed by a single chip
> over the SPMI bus, reachable through a single SID.
>=20
> Add new functions aimed at managing sub-devices of a SPMI device
> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
> for adding a new subdevice and removing it respectively, and also
> add their devm_* variants.
>=20
> The need for such functions comes from the existence of those
> complex Power Management ICs (PMICs), which feature one or many
> sub-devices, in some cases with these being even addressable on
> the chip in form of SPMI register ranges.
>=20
> Examples of those devices can be found in both Qualcomm platforms
> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
> sub-devices, and in newer MediaTek platforms showing similar HW
> features and a similar layout with those also having many subdevs.
>=20
> Also, instead of generally exporting symbols, export them with a
> new "SPMI" namespace: all users will have to import this namespace
> to make use of the newly introduced exports.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

