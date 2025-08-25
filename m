Return-Path: <linux-iio+bounces-23187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11AB338B6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D35F188FF20
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147CB29B8D9;
	Mon, 25 Aug 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCBEu3Et"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF9299928;
	Mon, 25 Aug 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110403; cv=none; b=DvisxtT51/0RrOeopyTGjFf4njQTYWb2/tnNXhpsRqeE6RcGk7thQgAVaHPlPytfdhofodQYARRAX1WRjDevM4oNJPbcpP5USKJyZv4wmF6pa80LWYv5bhGAb89UyM/MXzuWXDSs1+FxPKK7fURxgqKWSDJ6OMAUGUfFyEecOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110403; c=relaxed/simple;
	bh=JhmYYHVQIIQ7Csurfk62kT6LMaFbd2N3YVxTtzBRMX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrCFKrI92QO5RwOTeJYIgBsjKkUrLF+ncXj2vRvj6YKk+enMovNwEntwhS2RoCfEFbmXwJ1xiXRLWQjQvm8tJL1CRMPVfSS/LyLizChlKxdSI8XcbCe/XOez7rXthdup5TqQDskmw7yh2culaETyD+ZV/WIx51LU3e4w6p2Ik9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCBEu3Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E758FC4CEED;
	Mon, 25 Aug 2025 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110403;
	bh=JhmYYHVQIIQ7Csurfk62kT6LMaFbd2N3YVxTtzBRMX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pCBEu3EtIW+SnXjYv65YO8vxgAisoOnQh0kf2IVKmspHprv9NmJzn1ygswz0UoYo9
	 EXrPbSE8FSQDt+C/Wcgln7MkrLdxv/BuASxcNcjW/hRZUyjSCpE8h73SdOf47JuKmc
	 2s9FwBz2tfBByWbbCNIx6z+UGemHhOI+YYp5JS3UijCduk398en3u6rJjzKwxk2FgH
	 bR0p1XCod3qDjKYiwsgMwyKiNGCt8TEGoEoSOZVm3WWZnGgnJ0z+4qcS2a3zV5smcg
	 AAyfMz/PfAPVchpsdZw6nH+hbfn3ClpEOPM1pEYSnCMJCK20U1i/pobzyKeVUcZjT3
	 jhXhKgSE3XvbA==
Date: Mon, 25 Aug 2025 09:26:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Salih Erim <salih.erim@amd.com>, conall.ogriofa@amd.com,
 nuno.sa@analog.com, andy@kernel.org, michal.simek@amd.com, krzk@kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Update xilinx-ams driver maintainers
Message-ID: <20250825092634.75230a7d@jic23-huawei>
In-Reply-To: <e61c2e01-cd8d-4193-afcf-5ddaef34300e@baylibre.com>
References: <20250820100519.2272509-1-salih.erim@amd.com>
	<e61c2e01-cd8d-4193-afcf-5ddaef34300e@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Aug 2025 11:13:06 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/20/25 5:05 AM, Salih Erim wrote:
> > Anand left AMD/Xilinx some time ago. Salih and Connall are new
> > maintainers of xilinx-ams driver.
> > 
> > Signed-off-by: Salih Erim <salih.erim@amd.com>  
> 
> Looks like you forgot to pick up all of the trailers from v1.
> 
> Also, there should be a changelog of what changed from v1 to
> v2. Just rewording the commit message, I assume.
> 
> 
> 

Looks to be just that. Something to fix for next time but
for this one, applied (having dropped v1)

