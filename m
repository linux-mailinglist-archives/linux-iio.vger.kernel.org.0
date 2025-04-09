Return-Path: <linux-iio+bounces-17840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D01A81A6E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 03:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95E04A2EE3
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D4156237;
	Wed,  9 Apr 2025 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvoZflYb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955F450FE;
	Wed,  9 Apr 2025 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161572; cv=none; b=nwkOkXbidHmqheEkENEnocl8Fr875Ov+4XO8Slo6yobzv08G69CLVEKahCkpgHmCSf9XGd0H9+RN3AYyBW8yqcTwSbRE/hI5EO69Akp2k04kT9eiHxsR7Nqfy5A5VrStyhvrY5T5/EwSdpCEZEd5c/HsuOI5QJYiHMdj1KnvCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161572; c=relaxed/simple;
	bh=oLB76dZ1a9iTwEdLHF0eFgFSVVWekvWRnHNDCRRf8s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0y8ZR20ffeGRH28oigX7mOZFZB524YZCmVzVMk8ebgG6QMOB0pGYTeP38AXQt8d1EK3fFFDRDxDVU0i7DYVHMAxnQoRERF/TxczMxFVNgwsnYgomOdsSpLTKE808ELMCDZyOEqVCAbhQ1w46KvVWwXU+V5SU9cItFsd2UmIj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvoZflYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DABC4CEE5;
	Wed,  9 Apr 2025 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744161570;
	bh=oLB76dZ1a9iTwEdLHF0eFgFSVVWekvWRnHNDCRRf8s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvoZflYbWPWh6fzevFtbf3Y2nEy5DgacqnfhR0rclNly0y1qiJZWxtwfZw0CvYyAt
	 VLpw1/GsSY9I8l/WyyPh1hVjLgGIkZUW2tXqs8RH7cwidbil7bbqXyibXTDUz5VTLM
	 FYHSeAKZTa0riyKfcDpfVWQBvmEcB6mCAyPbnSEPkkB6xm9EHIvFl4y4m91hvnbL/m
	 9Y56K/AhtI951odbkMQnFOGkMlw21N5gNxvgPHQMD2MuypFVTkdiEhhSL69AxgjIl/
	 ueTOiTNySFJu/OeK4KRjNwzJ/JQMFg2UvMwf6rJxtVqffjuvSRzhO2fn0uzGtenOB6
	 wbv2B18cDpPBw==
Date: Wed, 9 Apr 2025 01:19:27 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec_sensors: Flush when changing the FIFO
 timeout
Message-ID: <Z_XLH7bwXAJ0hv5q@google.com>
References: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
 <20250408155619.2169189-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408155619.2169189-1-gwendal@chromium.org>

On Tue, Apr 08, 2025 at 08:56:19AM -0700, Gwendal Grignou wrote:
> |hwfifo_timeout| is used by the EC firmware only when new samples are
> available.
> When the timeout changes, espcially when the new timeout is shorter than
> the current one, send the samples waiting in the FIFO to the host.
> Inline the call to transmit |hwfifo_timeout| value to the firmware.
> 
> Now flush when a sensor is suspended (ODR set to 0) as well.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

