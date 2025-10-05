Return-Path: <linux-iio+bounces-24730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B085BB9425
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 07:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DB718988FA
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 05:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC431E1E12;
	Sun,  5 Oct 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuB3jYPK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6415ECCC;
	Sun,  5 Oct 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759642796; cv=none; b=nrfUELzevJM2SIeGdKAGxetB6qI9I1/EF6/kvCZ3q0HFrWt6rrpU3C1xvXnVClYvDLJ/4VoeeQ+BNDfcOn+9vzyLwDeHx9/NWmWSY6nOuLknBJV6M9ZhOQkGWOiLRIYet6cfG4sU1y1bV9rzDcrApXKPcHzhzpBZiYsu0ee4qck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759642796; c=relaxed/simple;
	bh=NZCzWl9AB2y422Nwn0yx+KSPggqE2G6/stIinDXFMaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSGUEX0NKN7D/nLQath5lmS4JnbQlblMB8bEnbdMp8H5JD9czVlP/xDJfwzaQvZi/+dtCwnzCL0eEJllJOr/SB4wigPA8rfMh2rP8KbwsOMYajNNXlbhNzj6wWs5eLUBTyv/TuAJSwWO52UKzkoEqfBJvAziCNTMhThd51J5YBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuB3jYPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A914BC4CEF4;
	Sun,  5 Oct 2025 05:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759642796;
	bh=NZCzWl9AB2y422Nwn0yx+KSPggqE2G6/stIinDXFMaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuB3jYPKVZ64xA5pd3uKC26zEa2PTUT0xsI6tBMSOKsVGZQp6iynYTsAv++c20tR8
	 XTh5XTP9Hglzd5GkoIFKnDlo38tfEn4d8Q7sZCCkybVcy/NFELzoIyJ8x+Zch+pcG/
	 lXuvISW9clYRheCPteSUkyqEOdgJV1hvNDERZhimk179Ij5CdPyxF1XZ73JkEiQQ2O
	 vxZHHnFiExDdeNKbl0ATez/s4gPMe9iKHjDkZ1gm8kSZYHgdAMB7X5zZHw0qF4yS+J
	 li6Izk/ct5zk7yy4BATzUocxZQCmk4mCbzY2vEqFMPBXoh+I16XYGZrjMqr2n64RAf
	 WRnTj0RfvfNSA==
From: William Breathitt Gray <wbg@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update Intel Quadrature Encoder Peripheral maintainer
Date: Sun,  5 Oct 2025 14:39:43 +0900
Message-ID: <20251005053945.2213668-1-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <70ef3a26-d70b-3506-3bae-6c87c39f3d22@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=wbg@kernel.org; h=from:subject; bh=NZCzWl9AB2y422Nwn0yx+KSPggqE2G6/stIinDXFMaY=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBmPWHz82NrbhD4cU91a7hWn/W/uE5+7DIs1HrDJiAidi ir2SXjdUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAEzk40qG/0k2FqGOYsfWcnrO 3bDvp4hOH+vdV9eNAzIDKuf6TBd12MTIsO2t8xyxyfxqLUVxtzOSX01s+zjzl0zNmsMtqx7wRQT m8gMA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 24, 2025 at 04:33:30PM +0300, Ilpo Järvinen wrote:
> On Wed, 24 Sep 2025, Jarkko Nikula wrote:
> 
> > My address is going to bounce soon and Ilpo agreed to be a new
> > maintainer.
> >
> > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> --
>  i.
> 
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b9fc91b4ce4f..8fc8426d88c8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12609,7 +12609,7 @@ S:	Orphan
> >  F:	drivers/ptp/ptp_dfl_tod.c
> >
> >  INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
> > -M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >  L:	linux-iio@vger.kernel.org
> >  F:	drivers/counter/intel-qep.c

Hi Ilpo,

Is this driver "Supported" (someone is actually paid to look after it)?
If so, you should an "S:" entry indicating the Supported status here in
this patch as well so we can track it.

Thanks,

William Breathitt Gray

