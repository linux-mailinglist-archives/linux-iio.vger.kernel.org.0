Return-Path: <linux-iio+bounces-4413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CE8AC052
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 19:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58DB280C26
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77D25779;
	Sun, 21 Apr 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKztmugM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C7111AD
	for <linux-iio@vger.kernel.org>; Sun, 21 Apr 2024 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721262; cv=none; b=nXPdBnOcCQbL/lyaRuHCGDS34Yle8dMTb5BochTU5kQbZVn1rQ3el8cHis8F8viTyTr+L4ZNzKvd/7/bTMrP6Xs0bWueWvoasWA/1vRX1RkQE6rYgVJp7QeZZQaklcmKWYpXc9k+xLjq1VaiwTmOCFwv5z5P5hL36SDYZ7PLIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721262; c=relaxed/simple;
	bh=gTHYxJ0HQuTkh44w5bjAt6Z0Mg/FWXsQHahsW8WLZ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bf15FCFI3W4qzjufPcUlLesVbI4rFgFnaM2xXsYQyWtbugpkH7GO/pijwfADer0L+H/yRYwwFJaXbD36qpWsGTzep5XDCWrtq8cLUzU33rKX1f8nnTapx1SvD3sWaYrEddQcJSau08agvehYm3mYg4mVHkrHLwvKDKiiUgSRoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKztmugM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18940C113CE;
	Sun, 21 Apr 2024 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713721262;
	bh=gTHYxJ0HQuTkh44w5bjAt6Z0Mg/FWXsQHahsW8WLZ5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AKztmugMjdSq/Ips6x973Wca9AzKVQvsTy+XYerNRpb/pwcTU+UggsgSf82i9+We5
	 N8sHa+0NlWCDSRL9SRp0qbUBty159/MiuvyKsZ+VbI668J8hNAbEemcjBbXb3D6Coz
	 Ryf0sh8rsDUYaOc3OCd2v9kizYGGg6YWlusxlTYQI05HZ3q4CZx1M3BaB4A1pu8BWU
	 P6vDYFeqhe3kfURp3iyv6u7wwSFrQpLkiqZBHBB+hc+O24Q3N30V+2OK6gPNDghtyB
	 jHOX4L0cwF7VQF9XCiEL7yX8Xh/Hot/T5BDlmi0bWj2EJwvs6pN+9z1fnzzXl7mHzE
	 lxGQH7hDvDcVA==
Date: Sun, 21 Apr 2024 18:40:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bertin Salvador <lorenzobs@usp.br>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] IIO: Use of device_for_each_child_node_scoped() in
 ti-ads131e08
Message-ID: <20240421184050.1f350636@jic23-huawei>
In-Reply-To: <20240420182744.153184-1-lorenzobs@usp.br>
References: <20240420182744.153184-1-lorenzobs@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Apr 2024 15:27:42 -0300
Lorenzo Bertin Salvador <lorenzobs@usp.br> wrote:

> This series is making use of device_for_each_child_node_scoped() to avoid
> the need to remember to call fwnode_handle_put() in early exits from
> loops over the child nodes. It is also correcting a minor style problem
> in drivers/iio/adc/ti-ads131e08.c
> 
> Lorenzo Bertin Salvador (2):
>   iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped() to
>     simplify error paths.
>   iio: adc: ti-ads131e08: Fix a style problem in struct declaration.

The title of the cover letter only reflects one of these patches and
needs to cover them both.  However, for tidying up type actions a vague
title like iio: adc: ti-ads131e08: code style improvements
would be fine as long as the description gives a more detailed listing
of what is going on.  That's covered by your description above.

Thanks,

Jonathan

> 
>  drivers/iio/adc/ti-ads131e08.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 


