Return-Path: <linux-iio+bounces-12587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 541569D774D
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56802B261C9
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD977F11;
	Sun, 24 Nov 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uucXZ6qV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CE1E531;
	Sun, 24 Nov 2024 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469996; cv=none; b=rcyZSr9ovSMznEkhQCjnaHlPkE5rqHHvnefC9o14MEy2vWZZ2WvkrBkWXAnl0kvyA836qlZ3QE7OWdx/gns2WfMZMa93lBe4nYdLKBqXivAla5G3dJeHUltGYWEs+PBt0mDmAYKPdh92oeiepgFMKpq3frgqkH56SHZPPNlnb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469996; c=relaxed/simple;
	bh=m5EaufxYOCgvQD7PLW/UK4+ViW/a9/04yeGqV2OVmug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmvF0poJj12oRJFRYxffaFGpjbxY+7tG5fHs4cLJEmt16zOrlRPO/uUIIC/t1ZnNM5TjmniXgG/IJ4ja8ZiqCO+PD2JTPCCHGWsxu7sOXvVtH6g87GWHa1pbXDxIzbzWfPgOtOHJbvI0ZI4jAxTXdGRWs/OBKkynWA4+/uAQmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uucXZ6qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEACC4CECC;
	Sun, 24 Nov 2024 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732469995;
	bh=m5EaufxYOCgvQD7PLW/UK4+ViW/a9/04yeGqV2OVmug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uucXZ6qVhFutxrUv/uZVWQ13Gm38x9uqlRICcYRtaA4S2fK17kDymZE014ABKR1F3
	 b9I1AVW1m3Jq56Bam7wqugvrftVHqrqu6dWsNFHrxey3Nn3bcQ/v1knDf1ZGg62VDi
	 xy+FbG30DFJgFPpyHRbTsbKy0zRsQ0pMR1pVOgAAAA+80nSQbj5TQRhC7s+L6uYUmX
	 BbVkZaTcHwwbY/hh/OQ2CZEWvrOaSalL1fq/reP1ycwkN3oeLOjhCCslf+2R8bF+/p
	 bs/5zaxg/mRy3xmRj/6rUHdfFr69N1NSfTVvEuOrSlTJXwdKRPfVVCvBcxxDsTDBgI
	 8xYAmVY0qfAHg==
Date: Sun, 24 Nov 2024 17:39:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: add tab to align irq_line
Message-ID: <20241124173949.0d093579@jic23-huawei>
In-Reply-To: <20241122-iio-adc-ad_signal_delta-fix-align-v1-1-d0a071d2dc83@baylibre.com>
References: <20241122-iio-adc-ad_signal_delta-fix-align-v1-1-d0a071d2dc83@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 11:42:48 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Align the irq_line field in struct ad_sigma_delta with the other fields.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
> ---
>  include/linux/iio/adc/ad_sigma_delta.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index f8c1d2505940..1851f8fed3a4 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -96,7 +96,7 @@ struct ad_sigma_delta {
>  	unsigned int		active_slots;
>  	unsigned int		current_slot;
>  	unsigned int		num_slots;
> -	int		irq_line;
> +	int			irq_line;
>  	bool			status_appended;
>  	/* map slots to channels in order to know what to expect from devices */
>  	unsigned int		*slots;
> 
> ---
> base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
> change-id: 20241122-iio-adc-ad_signal_delta-fix-align-2e229d6c03db
> 
> Best regards,


