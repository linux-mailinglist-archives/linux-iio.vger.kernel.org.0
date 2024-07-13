Return-Path: <linux-iio+bounces-7597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE0A930584
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 14:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB2FB213BF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25F1304AA;
	Sat, 13 Jul 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCp5Nqzi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93641094E;
	Sat, 13 Jul 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720872401; cv=none; b=cbdbC0Ch/GugqHwUdQw15PTW62uCMFOl8mhNaPRZZijiwWZfkQaka5+9NLRpayfpr3TeYs+Z02FDWLh621vpILf3HmOrybeHW7OPD54hHg9B8Ru/Q5SJOEONxb3v4hnUgj+vH72V7luy+k8wSlkMM8zPSagaxPxItihAdqe5ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720872401; c=relaxed/simple;
	bh=exJRVuts03+xbd5E3jHRZttzHEIn0UyRikFCHT6Lrs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRzAH3FNfh7wEsdOWdSGtSC/di7O4K9fx4MAKsiAZULUcRiiMsg9OOvlzMD27bSs9LWDPOfgYbzHNp141hWzhWRt1ZgAE+iZQxC39Ys01hgQmYs92W00cEBe+FTBr66BXrjhghQFVtjzKKaYRZ4unnhCmpAaJE14HSBLVFjWmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCp5Nqzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2B4C32781;
	Sat, 13 Jul 2024 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720872401;
	bh=exJRVuts03+xbd5E3jHRZttzHEIn0UyRikFCHT6Lrs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZCp5NqziwBusPMeRP+xvIbu3d0YplovBG9Fu3g7a188FnVcDVlxsa+RjEkjzJCGzn
	 NpjYeC5Jna+EwQtcnF7xyoGLyFIOcTQ5gPcmccaznxT/wubhNr6i8d3CO04ilB453m
	 8rkp20VEJVPjc9x448fRWgrMgUDMGTPo1frwKHSSsnXZb3iKd2D1DIqR90CCtyQCqb
	 R65F5bK4acEtarmto0PWpRrRVPAYZ5NGjN68b8ZhvrlJaOk5bv1fdXLBR9F1pc4hRb
	 KfgHWRunFisITx3rw+aOCMyq3DpeWXYp1LqakoikwQU8PFEOGo/dAAvRq+H/qV16LH
	 4zH2Wxw0B1qiA==
Date: Sat, 13 Jul 2024 13:06:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH 1/3] iio: light: stk3310: relax chipid check warning
Message-ID: <20240713130627.3d03290f@jic23-huawei>
In-Reply-To: <20240712152417.97726-1-kauschluss@disroot.org>
References: <20240712152417.97726-1-kauschluss@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 20:54:00 +0530
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> In order to allow newer devices which are compatible with existing
> sensors, issuing a warning for an unknown chipid indicates that
> something has gone wrong with the init process, which isn't ideal.
> Swap it with a friendlier info message to get things right.
> 
> Suggested-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Give the patch series a cover letter next time as it makes it easy for
people to comment on whole series together + gives the series a nice
name in patchwork etc.

Plus this isn't (I think) version 1.  So that should be in the patch naming.

Actual change looks fine to me.

Thanks,

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index e3470d6743ef..48a971de6a04 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -496,7 +496,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
>  
>  	ret = stk3310_check_chip_id(chipid);
>  	if (ret < 0)
> -		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
> +		dev_info(&client->dev, "new unknown chip id: 0x%x\n", chipid);
>  
>  	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
>  	ret = stk3310_set_state(data, state);


