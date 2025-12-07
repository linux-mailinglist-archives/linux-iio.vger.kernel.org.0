Return-Path: <linux-iio+bounces-26895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA2CAB6F0
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B956300E010
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033612F6571;
	Sun,  7 Dec 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgZsh/5T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0822EC0A4;
	Sun,  7 Dec 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765122830; cv=none; b=t8LyOIk6kKCHFhO4+vFfNnXwdHxI2I7Mgy9Ds0KuN7/7SzO6VUak3of6IVQOiioxmbAmmS3AaV7znTd9UbW6FS9lpCx36ftM9IThN5Dc3aSvYZq9JAOrg9I29hZs1usay4zfPbgYdzTpnJaYMLOJ/Ea1eurUQwftLqtEvIT12y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765122830; c=relaxed/simple;
	bh=B1ipXkZP/nxKPY1EASzxZwvT8e3ub4v5J8d5lcDQj+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnvyOfYv4kmruKAXL/Z6GJ2TxnLqaWt+kafnog3VYZgz8pCJODIbG8jAQqis30Lm0KrsxLxVFJ7RxqsCv19qwlr743zh0m0yr/BHTdDzKBkW2a2ZsVQN979uCqzVR6y10n3mfpADG9CmO4UK/47oCGp0owaJ+l/g9bI0sSsSX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgZsh/5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799ACC4CEFB;
	Sun,  7 Dec 2025 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765122829;
	bh=B1ipXkZP/nxKPY1EASzxZwvT8e3ub4v5J8d5lcDQj+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TgZsh/5Tj3d42A2YsHm1u+TwxZ7w6aGbZ194G9Tm+RM5ni+DGO9CfdkGrXEOEry3B
	 hbkY67uWwnDEfq8XWseL/Gsv4hx601xy44PzHJQZJH03FHPI/aqjFZyCCnfnHw4Acr
	 h4tMLHeiVggwpEwcd29NRTQKemA0fY2IRTcSDduKjay+YGJovPHKYs5OV+GrQpWCae
	 j+ZVcCJN7llhXxMU7vSkQarWTrpCRNWPBX8mBY4rLBis4s24Ist0LqfYDpwIV57o5M
	 Y+ojyRUV/Vo6cFWkTiQLwTQCes1oo6LESvT+iy4UGijNvhzu0nOsW0nbKgl0FoCbxs
	 GeZbwZs/3GkQw==
Date: Sun, 7 Dec 2025 15:53:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 heiko@sntech.de, neil.armstrong@linaro.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: proximity: rfd77402: Move polling logic
 into helper
Message-ID: <20251207155339.2034ad0b@jic23-huawei>
In-Reply-To: <20251130153712.6792-4-raskar.shree97@gmail.com>
References: <20251130153712.6792-1-raskar.shree97@gmail.com>
	<20251130153712.6792-4-raskar.shree97@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> +static int rfd77402_measure(struct i2c_client *client)
> +{
> +	int ret;

Blank line here (which shows up in next patch)

>  	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
>  				 RFD77402_STATUS_MCPU_ON);
>  	if (ret < 0)

