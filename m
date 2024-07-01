Return-Path: <linux-iio+bounces-7101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E758291E64F
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 19:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F29B25D55
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1216E872;
	Mon,  1 Jul 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4hTqg5f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF416B75B;
	Mon,  1 Jul 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854015; cv=none; b=lp04a6eN5ucHWIkpSFg3dzv+8JcrWEEzTw2YnmLvXhCLBz9pUt6NcydZP4+Ls1ZKDtqgJyXCGwo+7a2YqEPLqhbdFk5osjrq/rICFRFhGsymw5/Fqwyqluyj7FpmMEQpuGH9vR9Ke1jQg9pfCcnqxLYe3ly/iVXlqXCMz+LXyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854015; c=relaxed/simple;
	bh=p3I+LsJZzotiH0m3SrVtCk1M0xHZDS/wWyLhpk61IH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFrkc1OPm1oNt/2TBbdp/ug1WfLsEXw6tuthPBJa0gkS2RIHquBXPm63OcL5gbikt5Z/h8GfUMisteEK7QHC/FRARh4KfHAyWpnvKQx+M3SoIfbNz2qN2WaEB9hC2Fg/2NeflCPTBD9KmA2qEmcXCOGSkXMx4rMI6jM4uFiExRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4hTqg5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF86C116B1;
	Mon,  1 Jul 2024 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719854015;
	bh=p3I+LsJZzotiH0m3SrVtCk1M0xHZDS/wWyLhpk61IH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4hTqg5f9whwQiSdWbmVY6pq9LpgPZARjTya8v1UCuT4+U8pPJ06iKVN3HbRDzYhZ
	 Kc3DpyQ3gvuylxnRVMRWKdKWcixp/DA21vBY6/NLTheIae3YuvJpP7UzA5lR94mKTB
	 mn3sk4EDD4IpcDrF5MQ3P+UB00gf3ysPN/YU1bioYBjQGgBKhuUoYEWfhJ15p0XLom
	 An0Es9BZl0m0pikCWKsAKtN0xo+3k2gbwWR5mERi7G7cQ9nnncppGZrgM5BYJ8WDQH
	 YOIReRX3WHh+1wBhMj/Lqni/99xydb/qQw/+oPAZK3AdPQNsuV6pb6AbOeeRq+WgT9
	 vf+mishl2PA3w==
Date: Mon, 1 Jul 2024 11:13:33 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dlechner@baylibre.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Conor Dooley <conor+dt@kernel.org>, jstephan@baylibre.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: adc: adi,ad7606: normalize
 textwidth
Message-ID: <171985401324.129711.10327596818735583111.robh@kernel.org>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
 <20240628-cleanup-ad7606-v2-3-96e02f90256d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628-cleanup-ad7606-v2-3-96e02f90256d@baylibre.com>


On Fri, 28 Jun 2024 14:48:21 +0000, Guillaume Stols wrote:
> Normalize textwidth to 80 columns on the descriptions.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 50 +++++++++++-----------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


