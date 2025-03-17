Return-Path: <linux-iio+bounces-16925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F9A63A74
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 02:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A27616D5AF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 01:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745EA14A614;
	Mon, 17 Mar 2025 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj8o900N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494814885D;
	Mon, 17 Mar 2025 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742175422; cv=none; b=XoL/BG3LXC8mN2qcMe/WbybvAFKrg/1YxD7iQhcjSNV/cs4u0Su/FzPd2gFu3WSrdDu2BBw6XGxqyqK8RPT4DH6+5D9vrBL4U6pIuDIaBP51aJIgi+yFWHFKABU+cO5BhnEVwa+QjvLUOcTV+ibfyPpB1GpLAWbAOM/mYxWIX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742175422; c=relaxed/simple;
	bh=nwx6ZMPwuOfMY3kzRkY8EBTEoySAEbPQO8MSRkYzdsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUh9GtyHzvi420bNcZ51MRVSKawsu6PHQzrIV/B0CTTLBmTPKsbkZvfVnJ5M928ESZnGgkAUg8QXqGoz2saf0OFpRmOkhNGTWEi99hkBod1BOtaFSY3aCH7hDBrE70pHSG7c4t5Ba1+N64V04uAWx2VbEtkNGj+7D0EumdSndIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj8o900N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE47C4CEE9;
	Mon, 17 Mar 2025 01:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742175421;
	bh=nwx6ZMPwuOfMY3kzRkY8EBTEoySAEbPQO8MSRkYzdsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fj8o900NllfjXhsZEl/xWYe/VmnBWlqCMtkFi4RoEpDWTEbGiQTDIaFHEo+c3eoEW
	 blzqEvYjjhk+QQPKHSR/X+7jHJE//Cw5heBC5+u46tNKMNHbU3AgRjEBWjUqKkYqds
	 I1OA5cnP1kKwvizkh9EO6g72bRX9vQlrXP+xE0wjon3TEMlbqz1KsZ7N4Y3ExeBlvx
	 hMBN8W9SnBgAu5K2DFRTaNvs/cRoJJg91JqSeRmJQwlUN/R5QrGk2K/N3zcHHp/6+j
	 kcOzI8KLmBJ3pLapLepEUp6+Vuc5rNS5HGJsSnwQt3LBMrfMapNw9nFj1jz502TZDn
	 ECiMnkzjseMCg==
Date: Mon, 17 Mar 2025 01:36:58 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: proximity: cros_ec_mkbp_proximity: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z9d8uhMqHJ6K0nci@google.com>
References: <Z9dzDB1gttXehYGO@kspp>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9dzDB1gttXehYGO@kspp>

On Mon, Mar 17, 2025 at 11:25:40AM +1030, Gustavo A. R. Silva wrote:
>  static int cros_ec_mkbp_proximity_query(struct cros_ec_device *ec_dev,
>  					int *state)
>  {
> -	struct {
> -		struct cros_ec_command msg;
> -		union {
> -			struct ec_params_mkbp_info params;
> -			u32 switches;
> -		};
> -	} __packed buf = { };
> -	struct ec_params_mkbp_info *params = &buf.params;
> -	struct cros_ec_command *msg = &buf.msg;
> -	u32 *switches = &buf.switches;
> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data, sizeof(u32));

max(sizeof(struct ec_params_mkbp_info), sizeof(u32))?

