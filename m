Return-Path: <linux-iio+bounces-16963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A455A64E4E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D51886162
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780E248898;
	Mon, 17 Mar 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n14Sw+/L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A11A5BB8;
	Mon, 17 Mar 2025 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213344; cv=none; b=LyE+Ll1grchC4jgJQWoQZ6e6xpc/Rj1z6gTYX3iDj6Ar4n0f2beEA38dX3/WYi21jmgJwWfwzRBA1hGQw9R81Kqfc9qPWkgvoMkh+KQ0r43a5IER+i7aKY89tq7tNE6eRWHfENCDjlccY5OXjQQpY77IJhXkMtPTzNCgDhAN91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213344; c=relaxed/simple;
	bh=SkQzYeWho8Ux2HCXmYTi6ZzOnA8nDtKvR9Rdm+m/TFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPtPE2m5xLiKUJcqGrWVKE6vAYnP6b4HgFtCrg/vyptlBhmlFypIHgolMKAtAiEXnMNSYbxmuqe/9tdTxeGtgVR33HMbSDibcDeS5U0A/AEsLML/BpqzMQKDb23WhO4fjUbTDOn4iguM0g4R4Eq0Z5GJ8eXoBi27kULqbZ23IUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n14Sw+/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D8FC4CEF0;
	Mon, 17 Mar 2025 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742213344;
	bh=SkQzYeWho8Ux2HCXmYTi6ZzOnA8nDtKvR9Rdm+m/TFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n14Sw+/LrXua9uHpOvEHqUd+YxPjbsk+sr3CDdSQZWeOwn/6o6kf1lPoO2rLyjYKU
	 bnImhfFScfajoKJ/mj3nCAgLPMkGGcLlENxKNPm/XB3b7o6YToKILDucKdNoUD2YlK
	 UMKoe8TJqryPoUxw+gg+/9AAaiG8ZmuvMmd23KjWGqe03u54bt76bsSS3YoUFpRRck
	 tVJEg87Md3BubDx1IpDkygjap7Pp7eWxlPST8aAtHb+f0iRpAEC2jIZ3DUbIcFryO2
	 87E66Wl3fwVGRq4YOW1I45w/ykdFEjRSQCkUeeIbzAQ1DUg8H8KbzNg+hvFhr0hWcw
	 /7FKkGSYOoWLQ==
Date: Mon, 17 Mar 2025 12:08:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Benson Leung <bleung@chromium.org>, Guenter Roeck
 <groeck@chromium.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: proximity: cros_ec_mkbp_proximity: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250317120849.347f9a26@jic23-huawei>
In-Reply-To: <Z9d8uhMqHJ6K0nci@google.com>
References: <Z9dzDB1gttXehYGO@kspp>
	<Z9d8uhMqHJ6K0nci@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 01:36:58 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Mon, Mar 17, 2025 at 11:25:40AM +1030, Gustavo A. R. Silva wrote:
> >  static int cros_ec_mkbp_proximity_query(struct cros_ec_device *ec_dev,
> >  					int *state)
> >  {
> > -	struct {
> > -		struct cros_ec_command msg;
> > -		union {
> > -			struct ec_params_mkbp_info params;
> > -			u32 switches;
> > -		};
> > -	} __packed buf = { };
> > -	struct ec_params_mkbp_info *params = &buf.params;
> > -	struct cros_ec_command *msg = &buf.msg;
> > -	u32 *switches = &buf.switches;
> > +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data, sizeof(u32));  
> 
> max(sizeof(struct ec_params_mkbp_info), sizeof(u32))?

If not (I assume same reason as previous case), then maybe an assert
that sizeof(struct ec_params_mkbp_info) <= sizeof(u32)?


