Return-Path: <linux-iio+bounces-6310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A790997B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 19:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9476D1C21034
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF450A6D;
	Sat, 15 Jun 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTWzK7g4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1C4501E;
	Sat, 15 Jun 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474222; cv=none; b=e6CUp0H/mkm/cQpHTYxYz3DGE7jkYvfrG5bz7FoWF6326cZV5hTQGoduKuCmC46d54sj6F/j9RAcWibocUH6zlTFYRX2rkk1/1FhWGD4CZBnXKoxFx4xykOIa1TOdCtRZGgWZm+M2dfsm18xihfMKHewiyPDkQHMYC2c1RmB/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474222; c=relaxed/simple;
	bh=Ks5PLRKhZlg6Dzjofxbh/ajLXqb9o68vwX4X8VGsGVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmDfkwMNqLsp7c0kGpHpEtRflxQd0SeYrxIQrbA1Xc3H7RtKYFUeWsi5cL/yR4wD+rLr00I15OaXWrhLcUmIVUkzAkWtmc5tKz1f3zA00i7s56itJQnVJ3WgR6YmiyLbTuw7EQZOgxcI0/A1isY7Ftx6lqyqPhPR5jSN85SskaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTWzK7g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987EEC116B1;
	Sat, 15 Jun 2024 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718474221;
	bh=Ks5PLRKhZlg6Dzjofxbh/ajLXqb9o68vwX4X8VGsGVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTWzK7g4hI2d22e8pfsZd15ZXEmeLeKh04+Gpoy82XLKL7ou0/MnOw0wqzHvoYDcL
	 x6ok7Dtlf7z/wSsqzA04X2eHO3VDq92gAlxIYYQpIKCSf9csGLpQx1V2bUovgEptKZ
	 YL7X5ghVZGPp03HGpCwwjR2/Hdbx2yT3e5Xok7MJNvlcR9HbSIncDPjrxFCvdlhCU+
	 UMdImXi3Pc6TYsXy03zZAA9/os21vHY+rhFs4hR4SV0HvBe7ck4cPPvHDRMCYJ7G4r
	 k5/0sppclAjVGGQ/GclGaOPPNhGkW1IVhBbkV2UDniM+2dOkRQhUFr7rmZ0is0/RPE
	 zFdg1W95iN/Ag==
Date: Sat, 15 Jun 2024 18:56:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 linux-iio@vger.kernel.org, denis.ciocca@st.com, devicetree@vger.kernel.org,
 linus.walleij@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240615185654.6ef4dddd@jic23-huawei>
In-Reply-To: <20240615-urgent-mammogram-3eb5ca127239@spud>
References: <20240611160821.13941-1-kauschluss@disroot.org>
	<20240611160821.13941-2-kauschluss@disroot.org>
	<20240611-reassign-eliminate-b05e4a302cfb@spud>
	<56ab50d7c542356b7e377023b84a6018@disroot.org>
	<20240615-urgent-mammogram-3eb5ca127239@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Jun 2024 13:11:04 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Jun 15, 2024 at 09:46:59AM +0000, Kaustabh Chakraborty wrote:
> > On 2024-06-11 18:17, Conor Dooley wrote:  
> > > On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote:  
> > >> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.  
> > > 
> > > I can see that! Your commit message should mention why this device
> > > is not compatible with existing variants.  
> > 
> > Sure, is adding the WhoAmI value enough? Or do I also have to
> > explain the different registers and sensor settings.  
> 
> The whoami isn't sufficient, but if there's registers that behave
> differently etc, please mention those.
> 

Or (mostly putting this for future reference of anyone reading this)
undiscoverable things like different scale factors for channels.

> Thanks,
> Conor.


