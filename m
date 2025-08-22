Return-Path: <linux-iio+bounces-23148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD0B31B90
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E75A57AE722
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91055313550;
	Fri, 22 Aug 2025 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7wztDtc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46674305E2B;
	Fri, 22 Aug 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872604; cv=none; b=WIDzQfpwMV9OhyMBhTNnjCWajRB5TBxTv4zInO0GfsrjmNV8Qd24N4DPVFMgCLqCCE4eZVbPSZqDS8EhSLPGzMrhftcocq/OGJ0vKk7FP4uCXl7iQbzUlqElCx3ISphz40WxCTJenobU4I2FtLudbRKO4zAjelT7OBBPTqID3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872604; c=relaxed/simple;
	bh=p12u8vR8qiv7q0T3C6sATwxvsQ21DT4TNvgeIZFALCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p93z2zMHflhaSFAq6q1pVtY3o0exs54Sp6P5I3cxGh7M7+nq13TpCi5CVjfh8febt8OTgDtQq9lJ7WLb7pSgE/Y7DImCc4vc800QxG0zkZYHo1W0DiPG4ErIrw6mUph2mtSsrAkbd0szXIsS5rYuG9h2AH3hMfwY1aiFnDcwxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7wztDtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A69C4CEED;
	Fri, 22 Aug 2025 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872603;
	bh=p12u8vR8qiv7q0T3C6sATwxvsQ21DT4TNvgeIZFALCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7wztDtcoLnf4euD7YyiSJ6Cdw+vq/HiDC9PejmzhDILhI5g/hqEWfEcH/TSTfLCQ
	 g2UNAq+U18UTfNxZDh2bE1OW9Lms79Y+NQeyEbH3ud8oGwfFz3eBAQr6bSdhW7rV0l
	 sr0FF7pECu1A11xgznHzRZitNnzwMdlsry+l1gqRRQkG7q45UQ2RO40dQvXmpHT3Cw
	 d1fuNYFlmygAZ7kLZC1R1w0I9LT6tfq92XQCOoWYG8oJoYtzuZlLDPtC1iufG1R7Qc
	 4Mlc0O6v9m9egfm9IuuSQ73DJllJbjPQnSJ3hI5LdqM/kHAtoBNBotcXP2FlvbzqVH
	 jmToV1ArHKQvQ==
Date: Fri, 22 Aug 2025 09:23:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, devicetree@vger.kernel.org, andy@kernel.org,
	linux-kernel@vger.kernel.org, conall.ogriofa@amd.com,
	nuno.sa@analog.com, dlechner@baylibre.com, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2] MAINTAINERS: Update xilinx-ams driver maintainers
Message-ID: <175587260151.3622268.4895714822866786813.robh@kernel.org>
References: <20250820100519.2272509-1-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820100519.2272509-1-salih.erim@amd.com>


On Wed, 20 Aug 2025 11:05:19 +0100, Salih Erim wrote:
> Anand left AMD/Xilinx some time ago. Salih and Connall are new
> maintainers of xilinx-ams driver.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml | 3 ++-
>  MAINTAINERS                                                    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


