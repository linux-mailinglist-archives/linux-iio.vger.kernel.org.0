Return-Path: <linux-iio+bounces-27845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC0D29DA4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 03:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DECFA3034FA3
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 02:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78773370F9;
	Fri, 16 Jan 2026 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDSprsML"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4430EF7C;
	Fri, 16 Jan 2026 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529009; cv=none; b=kYxeprN8V4fV1Gw6pzsNp1OjR0BREHSX7aFYvFvwGQPBCgFT4hZTMukbXgjUxE8AP4LobPJQPhclEKi3++haPJNlkZGXtPpxP9s2bD8cx8pNpV62XDZ6lWCUyLgEaXjFNM8zJ2b9CAjgisCHgX5k2e3YKkxT70GY+3U9DCvrPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529009; c=relaxed/simple;
	bh=DkpW3zYqmOwUKSxDph4dzyzLm9SF8AXpnbf5qImijEs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=bm0eTh8xoadbhxWVR/J0t/Cfjgp8j8EBPkZqCNxQXa837Y+Lx5R5VE1GJP/TNs9YJPjJCCD1ke1TjhH+QHpW+CoBrBkDqgwuA7xcGX0i2axhyLt0in9rFEEhp9dn1x0E3/dp+qQwC4vuo9+p3cb3HUyji57LJR80MVsJgtXbP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDSprsML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A952C116D0;
	Fri, 16 Jan 2026 02:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768529008;
	bh=DkpW3zYqmOwUKSxDph4dzyzLm9SF8AXpnbf5qImijEs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WDSprsMLMODh21KcQsCnCCx6GPBHrrzvGmRZxShpKF4CjYiSrGajH6BoFOyJl0BMO
	 EI1P5PpfxYF8Vf2VU8eIRMIUC+8oAUOQ1QDsBf75icIoVXPWNdFd69ucX/aDS8QNRZ
	 CWyCmDWx7zvLL6y6cS/pLk7YMLAjs2sncAHYclHPfqVzX+CW23EmqDg10bNXYacx/Y
	 DUXUjcT2dgqcLScFqxFGSAcCpdwr1FHOLvLJ4LF1K0AmD7B3KorhGkz3MwWjAybiMG
	 +uCyG+1SDT9YuOQATetjfrvnAwVpxbRzkvxntGRTzzjukvEzteofEXRuU1cgo3ybqF
	 g3veFPMtwCfhg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260114092742.13231-3-angelogioacchino.delregno@collabora.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com> <20260114092742.13231-3-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 02/10] spmi: Print error status with %pe format
From: Stephen Boyd <sboyd@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org, angelogioacchino.delregno@collabora.com, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jic23@kernel.org
Date: Thu, 15 Jan 2026 20:03:26 -0600
Message-ID: <176852900658.16445.9455000795236599425@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2026-01-14 03:27:34)
> Instead of printing just a number, use the %pe format for error
> status, increasing readability of error prints.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

