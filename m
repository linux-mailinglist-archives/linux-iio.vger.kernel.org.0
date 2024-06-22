Return-Path: <linux-iio+bounces-6704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3599131FA
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 06:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF6DB20FDD
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 04:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA483CBB;
	Sat, 22 Jun 2024 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuOj0PaY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811C83A07;
	Sat, 22 Jun 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719031942; cv=none; b=StMoXY1qx1IL36gKdusvAfxosB1Qm8mUNIkyfLHCHlDQVGUTz82J3dAJl+dmAwj7+SayUQt9QyOC1TODkjOqm7CWnkyvBfzr8ZJRhNoyQpd7zW8zQk0U2hpfUVnc6viwCxRcadxYnrLUm6PKVC6RZ8qXJ/vA956DbWmnFZzbrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719031942; c=relaxed/simple;
	bh=HbVrmtfT+SdnNmVPJNal83B7uUqIYjZq+xdTpW2DmYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqXi+4TgSvxSzlpwJN/x1ID9JmUi3AWzEq4SxLQul69VkPPgCWhJk6ZqDKPquHjx+hLLRSeQO/DmljAg2Yy+F5YNA+kU3XSHUj6AzP2W0uIMVEiCflsGwSd+mhXsZlZXoBjFwEaC08HicQF9+Z3uIGRIxzy+9bI/uDt2hCER6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuOj0PaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D55DC32781;
	Sat, 22 Jun 2024 04:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719031941;
	bh=HbVrmtfT+SdnNmVPJNal83B7uUqIYjZq+xdTpW2DmYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BuOj0PaYWb+3doJ9rDY3tLFvqXr0k0to4Ff8jv2a21ApuJsg9r904+Ic0TigjfXst
	 TTWq9vdJnkQdQ/cIDHUdKwNhMasnYCBeB/2Fv/6iVtXDRqQKWHldBhCphSTAgY3L65
	 NHrva3C5QME0H40iYwVAm7Tgsi8T83YoSsqpECM9jMwHA34tiMNK/kaVdKjldmqkQ+
	 XbK7qOT5y64eXNlJ+4y/HzfXl52nKw+Cn1FasLIP5QN7tts9/5Ir3DL7++MK6ckBNQ
	 fzXwYqCQ5xD0v6Cqpbt963VxsQW5tB59pkbewuJn1qz6zRR+Sh/0A2JhM/Oyjhx0lG
	 uJDWKCbn0BeAQ==
From: William Breathitt Gray <wbg@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: ti-eqep: enable clock at probe
Date: Sat, 22 Jun 2024 13:52:03 +0900
Message-ID: <171903185635.2727617.17899562703045384773.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621-ti-eqep-enable-clock-v2-1-edd3421b54d4@baylibre.com>
References: <20240621-ti-eqep-enable-clock-v2-1-edd3421b54d4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=524; i=wbg@kernel.org; h=from:subject:message-id; bh=hSP1C6Hpr+B++EMexFKtcb4+ZjFuW2uVh0qiaRvN/OE=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDGllERGef8MYF5spGW5/tTX1fF2N6iXrXRxveEWuvyuc3 sqX3JDYUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAEzkrB/D/4SSKb43VP6FVLix M0dr/6+UWJK2evrk+InnmytzglT4tjL8FZCPN7z8caH+9qIMzhd7nh9rjLJ3Oz9XbcIZ4Qvas2X +cQEA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Fri, 21 Jun 2024 17:22:40 -0500, David Lechner wrote:
> The TI eQEP clock is both a functional and interface clock. Since it is
> required for the device to function, we should be enabling it at probe.
> 
> Up to now, we've just been lucky that the clock was enabled by something
> else on the system already.
> 
> 
> [...]

Applied, thanks!

[1/1] counter: ti-eqep: enable clock at probe
      commit: 0cf81c73e4c6a4861128a8f27861176ec312af4e

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

