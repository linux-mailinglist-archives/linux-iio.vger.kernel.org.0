Return-Path: <linux-iio+bounces-9446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9346975831
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8CD1C22410
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D81AE864;
	Wed, 11 Sep 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiUzo0Vz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375D224CC;
	Wed, 11 Sep 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071743; cv=none; b=u7/Ov4d3W1yPOmJuAd5I6wCoohYuZmJRG2o+jlRLHpSHWJl+ezNfhShZc5ioisajWn58q7wxOaTsyCwhfUOzoYRZNFENtItm2RRXt7VY+od60J8pFnJz5uJF76BCUbFw2b9UhngUMxd18Q332YqaPJVe6C1yaQRlrRD+wgIg3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071743; c=relaxed/simple;
	bh=0PHSN8Z8Ga6gGdIabdpiB4yZj0UtQvwndVg/JTxkKRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCfTu4Ae3bHnWVngWV469Wpjkm+INMFaoTAL5/wgM2iiDoAppjfMxtuOa67tQNwn7959TdvwfH4qWM2ymBZEmMpzKBl3w2Fqrobum1exynR2BDcTfxzc/7wzyTyy6RuZOZ3Gr35yE735rHhvf2j0f/0asbD9SyjLvG+TYefjq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiUzo0Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892DFC4CEC0;
	Wed, 11 Sep 2024 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726071742;
	bh=0PHSN8Z8Ga6gGdIabdpiB4yZj0UtQvwndVg/JTxkKRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiUzo0VzxBEmBrjNEbkYJsPAEc9eZi/N7P5Ft4A46hxB+62e9yeVJSe+q7pNvqPJu
	 qHGrcPLCUlMk14RbTpDo82ZriZuNnyOhgfGz9wXKnFhpK59yA+0E+fNX+ORt4RECn6
	 ObQr7aQSLZV8umuXOjvB5RUN0fHvWIeuw2YZaADTmEWoYdEgn/XJdm8A1arAEi1Xt3
	 fxxuG0YbW2R+18NQoD/X1hsCB/vNaebltbuXq4N7yhcVUJ4U6+MvwdQbqFEag4mq/D
	 mxp1DWpMV9LShCqi/4rPDuxfSatmdIyp4cX0+6Tgyj80jUoCj78qTI2h83hXVx52Kv
	 rkppIBxiYH/0Q==
Date: Wed, 11 Sep 2024 11:22:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	marcelo.schmitt1@gmail.com, Kai.Dolde@de.bosch.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
	dima.fedrau@gmail.com
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Message-ID: <172607173923.689453.12557027377891944945.robh@kernel.org>
References: <20240910113650.4733-1-Jianping.Shen@de.bosch.com>
 <20240910113650.4733-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910113650.4733-2-Jianping.Shen@de.bosch.com>


On Tue, 10 Sep 2024 13:36:49 +0200, Jianping.Shen@de.bosch.com wrote:
> From: Shen Jianping <Jianping.Shen@de.bosch.com>
> 
> add devicetree binding for Bosch imu smi240.
> The smi240 is a combined three axis angular rate and
> three axis acceleration sensor module.
> 
> * The smi240 requires VDD and VDDIO
> * Provides only spi interface.
> 
> Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
> ---
>  .../bindings/iio/imu/bosch,smi240.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


