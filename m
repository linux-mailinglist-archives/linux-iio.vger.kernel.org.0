Return-Path: <linux-iio+bounces-17001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C3FA665B3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 02:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BBC7A341A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80DB17A316;
	Tue, 18 Mar 2025 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjQUKdl/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BD175D47;
	Tue, 18 Mar 2025 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262716; cv=none; b=tTwVRgNegXkq1qroxqTA76rpZ+VrRkOqjeca/Kj9aLFf5+1KxzXUnEEdBW1kGaHplj36z3mYOgko1bvhIWBSIV21tbCN5obo86e9XRjooQWpTjSPRiHCl/jXjd/rJclI1oS7MjW818ZFZTo+OB8Iu15cqAfFWkdTjA+Sr6qU5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262716; c=relaxed/simple;
	bh=B4jkCowqNhZ8/th7Pe4Z251HnJHfp1DmkrTSzF+kwPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u04/cF9q9SCZb4Yo7omcbVcxMg5Iv3a6vsGmydv4F8nFuoIjCELRIWxDlJdlKvh0fvT+GGQ8j83igxloD4xF84qltUj2AG2zjqHu/6jYhFo/tW0OjtbzKufMZyBsh26zbCwd+/g028SDgPAn+OpKEugzrUhk7IZ/alXPLA70jvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjQUKdl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5ACC4CEED;
	Tue, 18 Mar 2025 01:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742262713;
	bh=B4jkCowqNhZ8/th7Pe4Z251HnJHfp1DmkrTSzF+kwPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjQUKdl/BvIl8AUf24mPXZyaG54Fv0zMkLX7Wf2zQlGGeFdQCqvFBfC78Frgm/vsh
	 xOHxpljo1cmo8jKD6eDhwPH01OIHOrLmmAjp5+RVqBjKgRe6WtjFODlPrnOgt1HJCO
	 n8iqlUNSB+qRG3ft+sXeP/R7bu5FxR7+8ZZURtFFF8DT7eV+HlDeHOAflV8+ro6gax
	 IQxtK4+ZWsfKINTBaihRveTjzaFDMVqKbrID+cel201fRyQf+X7emTzIa0X9QnN6IW
	 tAWkuzN/s+RRDUIFH1m6QLHp2IMCrQCkHjm8t1gnQzoKfWxojXPjwC9v+OZLXQBkWp
	 Z4fJva7qe5iJA==
Date: Tue, 18 Mar 2025 01:51:50 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: cros_ec: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z9jRtoDZM0opi_4C@google.com>
References: <Z9dy43vUUh4goi-Q@kspp>
 <Z9d7rp-ullvmXKoM@google.com>
 <112490dd-4490-44f4-abd2-07f7a519aa7b@embeddedor.com>
 <20250317120447.4fa26083@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317120447.4fa26083@jic23-huawei>

On Mon, Mar 17, 2025 at 12:04:47PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 15:10:38 +1030
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
> > On 17/03/25 12:02, Tzung-Bi Shih wrote:
> > > On Mon, Mar 17, 2025 at 11:24:59AM +1030, Gustavo A. R. Silva wrote:  
> > >>   static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> > >>   					     u16 cmd_offset, u16 cmd, u32 *mask)
> > >>   {
> > >> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
> > >> +			sizeof(struct ec_response_get_cmd_versions));  
> > > 
> > > max(sizeof(struct ec_params_get_cmd_versions),
> > >      sizeof(struct ec_response_get_cmd_versions))?  
> > 
> > I considered that, but DEFINE_RAW_FLEX() complains about it due to the
> > 
> > _Static_assert(__builtin_constant_p(count),				\
> > 		       "onstack flex array members require compile-time const count");
> > 
> Maybe add an assert that you indeed have the larger of the two + a comment
> on why it matters?

Or, is there a way for using compiler-time MAX()?  I failed to find so.

