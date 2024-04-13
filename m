Return-Path: <linux-iio+bounces-4228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138668A3C6D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 13:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96112824AE
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 11:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E73D994;
	Sat, 13 Apr 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A190ehRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCE1E516;
	Sat, 13 Apr 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713006480; cv=none; b=IUaXeQEsfNm8QNGqp1H8nOtxvoBoDk2WPiw4qPFeQ8CMuDYvl8qDLU4ZX80ixLV3zj4VvPh7KKRDb+RITybSeipWeJtL08uRY1kNvLHiV6SFhLMDso7ItNZDW2O/i3ahLuycKoFehmTjMs3HOxPF3TLN0sBvJhh+z98GQIV4U5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713006480; c=relaxed/simple;
	bh=MHhOzL47t8O9jhHxmlQa3kE77aDFPBgPO+0CV2y2THE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9WchUnaI6JvpHacg9Xm5hzfIkALzuXp3uNEO4iUKTEQn2MrrZOu5FyWJZ9mV6Sd4yP/0OPbRwSuwpYZCVZqYvpptyAMMvxsCBjFpqhytXgZfXckbfkGBugR1r9MrsmZ34hBW2FA552IeiLLtXuVZjenoD2rpf5Je7VXfEi8kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A190ehRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE78C2BBFC;
	Sat, 13 Apr 2024 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713006480;
	bh=MHhOzL47t8O9jhHxmlQa3kE77aDFPBgPO+0CV2y2THE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A190ehRw40hYvOr7cKbl8O77URKf8jdcI25qSt/WtDWYkV0wBMlKOOHKEpM904x2e
	 uOWH4aaD3vVnc1QedpgINVMxGh0bHc092nAUNYzmRJSASn8MM4Inkob+WVWAG6Y/af
	 E+XI4aLIiIMuQL2lyoQAnlfHr66ZOcZ8D+cR68Od0z+BEbDeCMjeMrOKwKqfJ0e8Qm
	 JDA71RXu+A/oTIDvllodq5c81gnf+012ZukvkmnWBXC9csHXDlCJnGKlZpRjnfZp8D
	 RmCN873U5aNZxkeYhmInxwHF/ebrItA6+txJ7xGSpP4UojRBI/k1sQ3zDzaSO22tSQ
	 YXoDaKEBGLvrQ==
Date: Sat, 13 Apr 2024 12:07:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v3 0/2] iio: imu: inv_icm42600: add support of
 ICM-42688-P
Message-ID: <20240413120748.678d6154@jic23-huawei>
In-Reply-To: <20240408090720.847107-1-inv.git-commit@tdk.com>
References: <20240408090720.847107-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 09:07:18 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> This series is for adding support of high-end specs ICM-42688-P chip.
Applied.

Thanks,

> 
> Changelog:
> * v2: change order of chip definitions and order of patches
> * v3: add patch description and resend without email IP header issue
> 
> Jean-Baptiste Maneyrol (2):
>   dt-bindings: iio: imu: add icm42688 inside inv_icm42600
>   iio: imu: inv_icm42600: add support of ICM-42688-P
> 
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 3 +++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 3 +++
>  5 files changed, 14 insertions(+)
> 
> --
> 2.34.1
> 



