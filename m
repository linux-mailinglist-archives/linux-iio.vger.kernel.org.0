Return-Path: <linux-iio+bounces-27844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E79D29D92
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 03:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D5B3002630
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B87336EC9;
	Fri, 16 Jan 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0yWSDB3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D4285074;
	Fri, 16 Jan 2026 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768528997; cv=none; b=SKqslnFjXKcxgR2ZCfHpdmdCNmvy96wV+G1gnSq8RtWSDChWgNnbSFoMAesTrrC03hhg5Uy/PXF5AjA/sQmPdP0o2VD/2+Y/j+yqyoa6zww6R6+JebycNu1TLxLuh6Rbuc0lFKCjqBOpi2vEBV/muuY4CsKkVnB4M76M1WQEDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768528997; c=relaxed/simple;
	bh=yRBOsXLD9J7HJ26+T9b8ZHvPW4supdfoc8WylsZQNoc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=EsilEuNX9/fpAIfB8z+YQYaS5sk4f28POz+NdbQzy92Y/L2gRdCgCkWtTwFcmv0pV1e5NPvcgxlk/1zf82fHCTkn0x0fN0NyQ1nmSS1N+FbN/b/zRBBVSlgACgjwU2ehaeiNxLeGH/WlNM+iwJ2sMcyHX5d02I/LGzfLPNBBBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0yWSDB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADA5C116D0;
	Fri, 16 Jan 2026 02:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768528997;
	bh=yRBOsXLD9J7HJ26+T9b8ZHvPW4supdfoc8WylsZQNoc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=c0yWSDB3P7Jzomlap+u39IVR58g0E5yfQ/bonELEVAbOwPHL3/2sU2KOj6cDoTGAI
	 ll0BDnxHVVoN5vEAjFcxjGsAUhUBg7l4rnf69K6JZM5P8t8lsP9In3IkgqXV0RSMUO
	 +9psxmUBpaZPOBYlibwf8KmA/eIKwuM8uR2LpltAIANYxFuuup+akY7aKP90PGQQX7
	 P/6YBD19iYrcWq8V/AL9kmp9g0Bc/JfTlqe/fLtqNAu95EXV1ajf2tlPhg1KPo1mz0
	 9cBZgFTz/PgmetZpGsCdEKWARF2DlpnPfoXesjN20w/Cb8LKtuJCzoP2qQz15H4k21
	 74lzj7uPsNAfg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260114092742.13231-2-angelogioacchino.delregno@collabora.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com> <20260114092742.13231-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 01/10] spmi: Remove redundant dev_name() print in spmi_device_add()
From: Stephen Boyd <sboyd@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org, angelogioacchino.delregno@collabora.com, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jic23@kernel.org
Date: Thu, 15 Jan 2026 20:03:15 -0600
Message-ID: <176852899514.16445.4062211943640481142@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2026-01-14 03:27:33)
> Function spmi_device_add() uses dev_{dbg,err}() for respectively
> debug and error prints, and passes the same device pointer as both
> the dev_{dbg,err}() parameters and to a dev_name() that is part of
> the actual message.
> This means that the device name gets printed twice!
>=20
> Remove the redundant dev_name() from the messages.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

