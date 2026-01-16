Return-Path: <linux-iio+bounces-27846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E282AD29DBB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 03:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 614343035F57
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 02:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590B334C25;
	Fri, 16 Jan 2026 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfJYTjha"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36460336EC9;
	Fri, 16 Jan 2026 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529015; cv=none; b=dliQpCAMHB8tDFBNJa2uPOQnc0R1brqtWlX1usopwhjSK4qxgQmVpbjvXu5kpp77hNlPHCOu3ut8QWoFcQfmGdGP18zkOio53cMzcwaSjdEZkuVmhHo/Tyck2um5ctge2JHJOMLCfI9w7PAOASmzY3kIPzPCuaFFoyf2jLzvw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529015; c=relaxed/simple;
	bh=40eJA6Ogxkz9I5QHI99S7KWohXek2h7xLollVv0h59A=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=km1T4zsDS6wxdPvLgBfs41JhbQMA0Jfc8OoIkKU8FFqGj7ZePGs49ht4FY67Tp4SFGOolX5WjaXlElXkuEeSXUheneLmoX3wtHl2bPkna1rD2NDmXXCCyeImXks0pMpf+JpWAuD2aWA1LPluZMwBbGw8BzPCNL24pRp02fIwkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfJYTjha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB71AC116D0;
	Fri, 16 Jan 2026 02:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768529014;
	bh=40eJA6Ogxkz9I5QHI99S7KWohXek2h7xLollVv0h59A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IfJYTjhatOwkxbqsEyY4khelBjeF4AQjFUpP1GL67B5KZWW1NxAQm+YxXvyB8eS/P
	 eVLJ85133bWzIw4tuZHLeujih9NgIbFKAgpmHPKxz2kG13SsPiXFBd4MYVkyFnKG7I
	 ww4FjEsTxNuCdIuquwoHuDSjcanDfMddqOoeEqeGKqYi0QbfYYp1IvwmZrWjsn1ML0
	 +WqrWKgGbgG8BTZmXYiDMx6cD8r/yhjyrYTgXKhx3phiVvXcdZ+BuF2a/DIX8RpndZ
	 TJtOKxargwIi7tfMJmOgG/C5wGvS1oJhrvYfh0/VK4hMd3sWTNrEdJ58c7yKgsbejs
	 URs0zLjVJ3buA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260114092742.13231-4-angelogioacchino.delregno@collabora.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com> <20260114092742.13231-4-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 03/10] spmi: Remove unneeded goto in spmi_device_add() error path
From: Stephen Boyd <sboyd@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org, angelogioacchino.delregno@collabora.com, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jic23@kernel.org
Date: Thu, 15 Jan 2026 20:03:32 -0600
Message-ID: <176852901295.16445.358528724346630388@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2026-01-14 03:27:35)
> If any error happens during device_add() just return inside of the
> conditional, as the goto path doesn't do anything else if not just
> returning.
>=20
> While at it, to improve readability, also change this function to
> explicitly return 0 (for success) at the end.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

