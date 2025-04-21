Return-Path: <linux-iio+bounces-18417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80BA9503F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7A87A660E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64522641F2;
	Mon, 21 Apr 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU7x46/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A835961;
	Mon, 21 Apr 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235219; cv=none; b=nXaN/mzQ2CUasWQ/rdsHVLet/JKf4TrRAuGQkF6Iu7BO5RNjPk+toxxKXoVnVJtatdJk+71v6XoHnUKPZw6lGhgta1ye3MtLbYhT/7F3PgE3GTYTXDEtxoJpUs0ejGGoCyaB/8RwOiIzYWhhbY22OBoHC247fxmtRrByhmXII1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235219; c=relaxed/simple;
	bh=OGYIMz+Uwt/sJEJ2ysFUESDiElsLDxozy6olHhsXkE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVJ23lVpjh6N0XNwaNAVYklK0yGaA4x88dwMtuiJE4lVnDtoE+lL5TcUjRLUuYQQln/Dr95lmPTy2Ln6LYC5EDH1ynAmenQ5B7NC/WQrGVD/cYB17mlvpqtz8YC8qNtDLrk9LpqZic8ABi2l1/jmBA5xgPqqWiSyVd9SvieYm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU7x46/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751D3C4CEE4;
	Mon, 21 Apr 2025 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745235219;
	bh=OGYIMz+Uwt/sJEJ2ysFUESDiElsLDxozy6olHhsXkE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hU7x46/nbpCEWTmFFBbmra+yVnLOLPyQAIkMtK5VqxhXUubPvOSOmsDF/J281Vq2t
	 dDu25C9wo4vWsqaGkIU4zWo8KiSCT4MsURvTQgozjp3JLVPwAzxrhUQ8EPIdzVEwX+
	 aSbIetjT8+sPp1QmDXBDGTTpFAHYIpwV72a8gk8TeG1EfiMftvqJ5FuAXqrdbhhn2N
	 gDeqF4ZtSa8S//n7isbgTIaaBWY777qGlipOKtmSWT4QOOWnVkM57/+SRX5L0KGsl0
	 wpKL0w3PMY0a4SsIcn6jdcTbw8TWTu78dnFDJ2IkDWXwHZGAtE7SWndSb7E6XFyVH8
	 iG8P8YTKubY3Q==
Date: Mon, 21 Apr 2025 12:33:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 0/3] Fix and refactor output disable logic
Message-ID: <20250421123331.634076d5@jic23-huawei>
In-Reply-To: <20250420175419.889544-1-gshahrouzi@gmail.com>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Apr 2025 13:54:16 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> Patch 1 includes the initial fix.
> 
> Patch 2 refactors the code to use the out_altvoltage_powerdown ABI.
> 
> Patch 3 adds small improvements by minimizing the size of types and
> doing a redundancy check.
> 
> Not sure whether to include a read function for powerdown as well since
> all the other attributes only had write permissions. I can also do this
> for the other attributes to help modernize the driver.
> 
> Changes in v3:
> 	- Include version log in cover letter.
Just post it in reply to that v2!

Note though that this needs a rebase as I mentioned in the thread wrt to
the original fix. I'll take a quick look though to see if I can spot
anything else for v4.

> Changes in v2:
> 	- Refactor and make small improvements ontop of the initial fix.
> 
> Gabriel Shahrouzi (3):
>   iio: frequency: Use SLEEP bit instead of RESET to disable output
>   staging: iio: ad9832: Refactor powerdown control
>   staging: iio: ad9832: Add minor improvements to ad9832_write_powerdown
> 
>  drivers/staging/iio/frequency/ad9832.c | 50 ++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 14 deletions(-)
> 


