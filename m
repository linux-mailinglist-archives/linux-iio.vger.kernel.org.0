Return-Path: <linux-iio+bounces-8208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD64C946A39
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A628D1C20A2C
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E5415382C;
	Sat,  3 Aug 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKTtg+fy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899E1DFF7;
	Sat,  3 Aug 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697466; cv=none; b=XToucc0DeMeLHQ6Hns+dobjrUUs5igAFYCXhyCu+ec9e4PMTn73fHiVknn1vsgQGVXfMrciTodwjat3pYQG2ZVUTEycRSKS5C+UC4/clE8PBRV5i1TIQOasNpmlw26z0o2/p7MTy2mXXxfTFBiglLQf8ehCrexyt7HWr3E0wcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697466; c=relaxed/simple;
	bh=nk9OH1rz67vCkNLxre1WT1DDUtI57exbt6L12E7o8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4BXWmn7PvK5a4CRAo1vbPySY8Iv3VxKs+lNS+hdNPvPXJGC+v5Xebhi40csL5iKIMl7HSwDQeB6DYUDra2EZvgwkSPKtaKlNEcAHFAvDBXF62o+ExB0r/wZlVC3D6dl8D7MtC/4SPz6NG373AEH+kjVIeRBrk6IQqQ0oZUMXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKTtg+fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABACCC116B1;
	Sat,  3 Aug 2024 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722697466;
	bh=nk9OH1rz67vCkNLxre1WT1DDUtI57exbt6L12E7o8wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKTtg+fyRwN2z7ir/GBUAJGle3obTJCc2RO87PuJmWnNghl9WTbIjIymUA0qYJawF
	 ZvMIpK4/tjJhvvGjKOTvPluECa5EAFsE2mBb70nJxGl8aJcgeZsJxM4lHz7hSfBSEc
	 aX/ixrBcxTnb0Kj7DTgO4Cri9kMiHw1ggq4lZaROMTIwpyvbPEmHGC6WUaEazjvySp
	 3gzB49y0oVlPEahtoUIkV4Wgyq+W3A0qVxk7C//GC3drJsZh4xS5VfL5RzlrnJsIL2
	 z4C12CpO3WdjIGtTcHeu77uJ3ShoetdTZDB5BgLkZdISwqL4VImKxVkfFB1a6N96BD
	 2UQa0uICTwsbg==
Date: Sat, 3 Aug 2024 16:04:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Stefan Popa <stefan.popa@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: Re: [PATCH 2/4] iio: adc: ad7124: fix config comparison
Message-ID: <20240803160417.05e18d56@jic23-huawei>
In-Reply-To: <20240731-ad7124-fix-v1-2-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
	<20240731-ad7124-fix-v1-2-46a76aa4b9be@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 15:37:23 +0300
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The ad7124_find_similar_live_cfg() computes the compare size by
> substracting the address of the cfg struct from the address of the live
> field. Because the live field is the first field in the struct, the
> result is 0.
> 
> Also, the memcmp() call is made from the start of the cfg struct, which
> includes the live and cfg_slot fields, which are not relevant for the
> comparison.
> 
> Fix by grouping the relevant fields with struct_group() and use the
> size of the group to compute the compare size; make the memcmp() call
> from the address of the group.
> 
> Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

