Return-Path: <linux-iio+bounces-16923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BAA63A5D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 02:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2433A7E03
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 01:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7BF433CB;
	Mon, 17 Mar 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvvtAdcY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF4DF71;
	Mon, 17 Mar 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742175154; cv=none; b=mdvfUByffu2zwOCiI9BYNiUD2yrUaN6WbV0y9tRIos4naFPYqFTEulv8aV6B/zGfgCCr3w+kK/B+JmbsCmU1TUVzBho9Xq8znMLwwW2h2NKBrZsOnKFBJkO6j7f0GLMP8rnBFSNcZd++lcblq+7H1rmpOBXnQljFuz+RxXqbL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742175154; c=relaxed/simple;
	bh=s8GEmYzbmS9r1yi+MUIttdEdJaVN5wVHb6I3vPopbTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+Rx2mK/Zk7y85Iw8IoPaDTD+M8buQjVLzan6tYe83yy59anxZ5yyqTufJb59kV8wzHM4XKMqeV7zu2C0ZKswWnK4QturKPWUcucMi1WpeWy4l4M33xy3jmZl41WGKzBSP70shS2P83XfY+E9y8/gbrTyAhcF3mtpV9rzNR9wKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvvtAdcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8C7C4CEDD;
	Mon, 17 Mar 2025 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742175154;
	bh=s8GEmYzbmS9r1yi+MUIttdEdJaVN5wVHb6I3vPopbTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvvtAdcY3LePAv0xsm6FdDZcrFUa/xd8jEpteznMBts5AU8E+vF7+GGlMc115YNRH
	 BQWFNZ3f1wLPIMOhbyvOGwS2qwFRaM0nwE/0Vb3uuT4RTGbDjBq2VdxZOCBNmcCUIY
	 zoR4yeBN87VjEDsPtPXB8jeH1EnHQClpbX4rWRF7fhsY8MR8upGNGI6KetBB/EUf/n
	 vZ9eKQCfseOVVmgqaith+zXVjL0vobpGa7Poz9sbCOVkYCtL+LsxMs2nGA8GnLaRF6
	 YFLhJ6aZg7SfuKgQL2XMYCeVbg0bmRxh7KLMSI3MN77a6jdpYTXThuv/tVuJWESizU
	 TX3ewDoH0483A==
Date: Mon, 17 Mar 2025 01:32:30 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: cros_ec: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z9d7rp-ullvmXKoM@google.com>
References: <Z9dy43vUUh4goi-Q@kspp>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9dy43vUUh4goi-Q@kspp>

On Mon, Mar 17, 2025 at 11:24:59AM +1030, Gustavo A. R. Silva wrote:
>  static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>  					     u16 cmd_offset, u16 cmd, u32 *mask)
>  {
> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
> +			sizeof(struct ec_response_get_cmd_versions));

max(sizeof(struct ec_params_get_cmd_versions),
    sizeof(struct ec_response_get_cmd_versions))?

