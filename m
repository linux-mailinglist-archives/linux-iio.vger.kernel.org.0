Return-Path: <linux-iio+bounces-27312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1BCD5B92
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 043F230024AA
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900C30B50D;
	Mon, 22 Dec 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGO6ITaY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73512745E;
	Mon, 22 Dec 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401586; cv=none; b=ocmm09agY4iZGBylqFMZvBg+NSPc7pRojdm5JYXGckkSIk/vwM1ZQ1pV/rMCujNe1sZla/ub3RQ7148x8ZbphjIAj6q7a2CbxcUBvlYe0LUW+5gwBbLtbnv9JjP/mobvKwu4Qjgn4NUn69/wLn5ybGb9rjuZi72GyZUnpoXPLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401586; c=relaxed/simple;
	bh=eTkoYmnvwiotpPxO9BjV8Nw5XtjazWYc1gnEEXQ6YDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eG5ooCpPqkvbtl9bkxN842glvzWABsL1aGo/8akAbc4Rg9r6pmA1SE+g3g2vdsxyc455Bn6wtuKjgRuFBgfCKQi+AVhYaPKKYk6xoJo0dvSpph4hJ4WW+MuWH2FcsFAhdyruBDoAOpwAWQW3n6hXhtOieJAwqRzUEz7wvwwG0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGO6ITaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60397C4CEF1;
	Mon, 22 Dec 2025 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766401586;
	bh=eTkoYmnvwiotpPxO9BjV8Nw5XtjazWYc1gnEEXQ6YDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGO6ITaYTrw0Jo/1kPB4ek3xtuXdRwj9V7UPzcbYngygFqYzyDAZq91Po4u2ZPo22
	 IVzTfC7oAGfkmMiy8+KiAPKV+Hvip76Cb2Z77L27N6u+ZJPAzWGwdHGmetED21un1w
	 7s//yQI5rzmGsWeBVBQkJ5YeNAyOZfBfVPdc1NlrDxGTR/YR81ieJQ7tNwRFdgUf5q
	 CggvyRiqN/MFv7fGI644qWdxipiDS8PODkSc5QPVMdLtcCB/7eB37qjFfHDYuJXQH4
	 xs2crB/xoVhdoxDoNT0EDyLAVJIn74Rp6nk+ZPBAwkcbHZiqGsyCxcGZbOPBKavSbz
	 w+QN6TKeeYmnw==
From: William Breathitt Gray <wbg@kernel.org>
To: andriy.shevchenko@linux.intel.com,
	Haotian Zhang <vulab@iscas.ac.cn>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] counter: 104-quad-8: Fix incorrect return value in IRQ handler
Date: Mon, 22 Dec 2025 20:06:11 +0900
Message-ID: <176640150655.10855.1594253560508072254.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215020114.1913-1-vulab@iscas.ac.cn>
References: <20251202083952.1975-1-vulab@iscas.ac.cn> <20251215020114.1913-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=wbg@kernel.org; h=from:subject:message-id; bh=NDBMKk2YfQDtHTFlcGNfWJ8fAXS+2oned2yVeac7A1I=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJmeatzbvZerlRwuDSnY8vxC645Juz6Wn8h51rPlEc+Ct f8PL925qaOUhUGMi0FWTJGl1/zs3QeXVDV+vJi/DWYOKxPIEAYuTgGYyJRDDL/ZdFU2b16zQq1U /vDLdZ/m9Wr0bMq2NjkVse40j66P3duXDP+z9B8+D/0p5Zzlcbf0zZqMqcyNZd6VvKs/Wl5Rl5B 8088GAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 15 Dec 2025 10:01:14 +0800, Haotian Zhang wrote:
> quad8_irq_handler() should return irqreturn_t enum values, but it
> directly returns negative errno codes from regmap operations on error.
> 
> Return IRQ_NONE if the interrupt status cannot be read. If clearing the
> interrupt fails, return IRQ_HANDLED to prevent the kernel from disabling
> the IRQ line due to a spurious interrupt storm. Also, log these regmap
> failures with dev_WARN_ONCE.
> 
> [...]

Applied, thanks!

[1/1] counter: 104-quad-8: Fix incorrect return value in IRQ handler
      commit: 9517d76dd160208b7a432301ce7bec8fc1ddc305

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

