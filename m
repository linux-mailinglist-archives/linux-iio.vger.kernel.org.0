Return-Path: <linux-iio+bounces-4220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492578A3BFA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 11:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D2BB21736
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397C24A0E;
	Sat, 13 Apr 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfQ/NyBQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50144A33
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001114; cv=none; b=UuLFYo7aVnvM7177e/g+dCi4FpnJehVO5X1sCYhsqwlXOe3/Ua+0iqvtG1YjXFszC7IFngoK/EO4jvo+4gy2ImYcNYvbEaTsMAGb8az7IXwAfbJZEfml3noyTbKKFiZgrf5XAcLTkFKKfe3lkUG/DkP/3H1Og4H3ey3bLPCieis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001114; c=relaxed/simple;
	bh=rgZ60NkisOU89hn87VYDNDQVjeK7iYhQ3wjA13GYzsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWNRM6kYbvcndSZawidid0m1UF+3iCupIosI7ptZNGzVcKqAUlDbiVCTcflgOq/7icHetnw+V0MXDNbyNdUWDROOxZSpx4T9QKV7FL0SRNNc9h9IZtV3yfvEJVHI2leG8+xmiaZIVz81R6rSkcDLkLcZKPzihpHV2d185CdOF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfQ/NyBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8B6C2BD10;
	Sat, 13 Apr 2024 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713001114;
	bh=rgZ60NkisOU89hn87VYDNDQVjeK7iYhQ3wjA13GYzsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RfQ/NyBQBWBB7rIOfgkl7X+InbAfuyXZdJjRHN0/4Hb599IRGNPAe9oEPv3x0lRlQ
	 bYjw6d9b1wChzBjR0D96uA6oBdybmIM3SuZetCBx6ODQyBpYJ9BlFRz48tt9i3LPws
	 dafwn1ISBoEgGSefQ08xDnDwcRm+Ao7EZiSYAPGLJlb2QRXXpitfpCSiLAmZ20OzMr
	 CdnZ9gsHxb2njY1oro4neVP3xfrU65AAk6Vx1SXlMnIUZDlU00hGNuV5bbG4XIB16r
	 vYWINTd6BZR3Jhr73eQiJtbYiFEtbED6GW7Sko8aI+EpbzDyYRUcFpMJeTCqJYOEWo
	 mELanm4ftqHvg==
Date: Sat, 13 Apr 2024 10:38:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 4/8] iio: adc: stm32: Use
 device_for_each_child_node_scoped()
Message-ID: <20240413103819.33d35055@jic23-huawei>
In-Reply-To: <20240330185305.1319844-5-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
	<20240330185305.1319844-5-jic23@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Mar 2024 18:53:01 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
> 
> Note this would have made the bug fixed in the previous path much
> less likely as it allows for direct returns.
> 
> Took advantage of dev_err_probe() to futher simplify things given no
> longer a need for the goto err.
> 
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied,

Thanks,


