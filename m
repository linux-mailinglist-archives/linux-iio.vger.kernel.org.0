Return-Path: <linux-iio+bounces-4464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2928AE96F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 16:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FEC281839
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD813B582;
	Tue, 23 Apr 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRKtCJUt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C391135414;
	Tue, 23 Apr 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882430; cv=none; b=TVMqpHSpVweTUSNF27hNrGDZw8e4u78+9ginqTn1X6lLkrxQCt3Mia0J+mjldMBxpKpyLOFUb/6x3mqPphRDk4MXu/snMnlYWSqAVBdRxOfwSdOI6ufwP1hjrsrrMXGT60gFSn/sZg6RJJ2xV12L/OBJWG90WGeUMMeEwyd88K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882430; c=relaxed/simple;
	bh=p6+nMfFtgTI1FIbPYAQn6VkjWsmoaZ1b4k1WTxh5HCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbfm04yHlehPQRd/dvdjt1eVI4J7e6QctoPLGklrUqx1vg2dlncQ8XnVIi+bPaG4e2k9e/c2oTDLee05s4/H/mSnsOPAu9NqP+FtPMpiwaD2TXyd9gVCnKxrl9gxgHxs9D15wemO4GVPppoem22hDlqbkzhDiY5SsbW9NCNZpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRKtCJUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA940C116B1;
	Tue, 23 Apr 2024 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713882430;
	bh=p6+nMfFtgTI1FIbPYAQn6VkjWsmoaZ1b4k1WTxh5HCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRKtCJUtYQXs6vqAEQFOK9FlqRtyIVjBZ8KwKP9CFX3NztHoANMLEGjUPV/+Wi/7I
	 ObU1s81qNHLZSHvwOCOpWfmfInDu9wrCPnFxvtFxt0+fTPIB6RhrRd0E3yrevKGiVU
	 v71j5Efh2VHjH3QKHBdIfzJely875Euwte3Drz2rM3WFcpW6Yhvj5gwmRhJlLD1mVK
	 V3KsALi/4hxAH0K82B3z0ZttabzgSrfx42R4IM/H1Vb8+5UB72HZOZlhRVVNkIiQ7Z
	 GKR1ypoBVwyczX4mEaYl2N2IIwXECbp+H9v07KI3WO8xZaI+g1ssfGeR4NC49rv1eH
	 o0e7avn8ylCPA==
Date: Tue, 23 Apr 2024 09:27:07 -0500
From: Rob Herring <robh@kernel.org>
To: inv.git-commit@tdk.com
Cc: linux-iio@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	lars@metafoo.de, jic23@kernel.org, devicetree@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: add icm42686 inside
 inv_icm42600
Message-ID: <171388241406.154626.4140712543078243270.robh@kernel.org>
References: <20240422152240.85974-1-inv.git-commit@tdk.com>
 <20240422152240.85974-2-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422152240.85974-2-inv.git-commit@tdk.com>


On Mon, 22 Apr 2024 15:22:39 +0000, inv.git-commit@tdk.com wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add bindings for ICM-42686-P chip supporting high FSRs.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


