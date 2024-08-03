Return-Path: <linux-iio+bounces-8187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3F946948
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1042A1F210C0
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E899152783;
	Sat,  3 Aug 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSJrC3YI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EF13AD33;
	Sat,  3 Aug 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682725; cv=none; b=nvzHKyr8G4Om5PKepTevLnBt7mPce/etaQELlHd9OPWZJhTjJ1LZDj9ldqh87979z0yejFDsTxlgYAjUNt8XJHtccpn3GhaTpls2TOjaXltlWm5b483q7JnAMhEfQiQZqYWa8pT9PpwgjGk7EFraJeXNqqEUKtBOys6woSJKhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682725; c=relaxed/simple;
	bh=N1fQ0B7UEe03G6CId/BQ+4zakhQeItMZKgJdmzi59LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtzwdCR8yMKF1yzvNGi8o5kx6Hq6InW0I/C9922sWyk5pcqcTgSbP+3V53cL6RPSDTf1uuj4a9gzQy49/zn4TgMnM+Ug/Q5DNPFiV9nJTX9Vd5Us2LtRxoPFsCpfeG5e4MfcEMIWdn12oiNCwHseKJW0jvjDqVK0WGGBwfngvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSJrC3YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790F2C116B1;
	Sat,  3 Aug 2024 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722682724;
	bh=N1fQ0B7UEe03G6CId/BQ+4zakhQeItMZKgJdmzi59LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pSJrC3YIqwnQtIY27gIXM6JJ42OfX4vv/ZuoPwrdvgQs2hoNrzaVs8NOtXaxBhGk4
	 8XbvW/0RQ5n+2WyuvdTbPl4OBMLtt6jRwEQ6+q5gxXN/Jpts8phgCls2eOBIF194+3
	 0J7Zk/Cy55sNSKwnpz5Zqq7hREJEpV6y9O9dSJYBnPCmsZ5j2WVE9E0sEOJy2bG12h
	 bJSj2+MUwGjCBQ9lK1utl9iu3AsSvAVc3j0noVjAX1nGFx++U4QMYvd53vkan8Yi3d
	 Yxi5NQSU+YCBlDOdX0kUWNQTqleM4xh34CdgFpdPrtojm8//r5p33Nux7U69ca0AYi
	 rZb26A2zqxYCA==
Date: Sat, 3 Aug 2024 11:58:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
 mripard@kernel.org, tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 01/15] iio: adc: axp20x_adc: Add adc_en1 and adc_en1
 to axp_data
Message-ID: <20240803115833.00bbc571@jic23-huawei>
In-Reply-To: <20240802192026.446344-2-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
	<20240802192026.446344-2-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 14:20:12 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the register for adc_en1 and adc_en2 to the axp_data struct. This
> allows us to specify a different register to enable the adc channels
> for different devices such as the AXP717.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
As the final IIO patch has a dependency on patch 11 (mfd) I can't pick these
up directly (without a suitable tag in mfd).

So to give Lee options (if he just wants to pick the lot up)

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

