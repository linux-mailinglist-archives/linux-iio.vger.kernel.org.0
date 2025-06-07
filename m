Return-Path: <linux-iio+bounces-20301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02802AD0E6E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250BD3AE265
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7501E412A;
	Sat,  7 Jun 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoAZINdU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BEF1990A7;
	Sat,  7 Jun 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312786; cv=none; b=Hlsgalt5/6hC2UsCn+e73klxDxEnXlWFQx3Ne3xytelSOVv+Sr0NNBhKVWzwI3bAT7mxCxCQ5VVxRBReAInAOb8yMwI2bhaRTd3kQ58hBfX74XLth7q1rLVIWaJRjQH45hkhpH5bPHyGmLf/dfX9tbph6uf5DVqrVWFeW5d7u3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312786; c=relaxed/simple;
	bh=xBHJZAq320huSZYVEghWqBlw7mafGQOvvitjx5Lpu1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkyP62vvEKTP8Q/QwdpoGjOfOwzn49S/Td5ighHuQwjKgVGJ7Xij/Bz65KFcsuDw0Q/RebVphALpSy5mNmkUYJpJHbHEE3pgem/+E6H0PiHg0JnWOD/5kwwxBUKwJVFeScGpitKB96xknhvWuL4+CgwcvytY2KSQpzsG0h50gJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoAZINdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1EDC4CEE4;
	Sat,  7 Jun 2025 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749312786;
	bh=xBHJZAq320huSZYVEghWqBlw7mafGQOvvitjx5Lpu1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IoAZINdU0n9TTvFqZhJZCSBZfZ5ikvlOm9LNDcmGfZcqgV32Htl6QhCtlRKnRvhK+
	 HBErwVolsyueSUMgQQb8zSN7pWjIlJ7agQUJAjP7Jq4xXQ68nmnZDHteugDzbjtnQP
	 6h5ineagJcffTtJviAIOAI3WIIeBg6L7pzWKuvVTOIcL9ndjB6665bpAAdnTH67tst
	 q5WvD3gIP+wvZpyHusCLpmC6qcIomN2xVa2s4CQvaWnW9gCFXKbm5xN9LlCOmPKeGO
	 1aTUkFmtd8Is54QfQRTRiWIvMeZoo7LJ66qMXqGe3dYHETC4dRDpBYzM1gA/RP1WbU
	 Fo5bg4PoQiWJA==
Date: Sat, 7 Jun 2025 17:13:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@google.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, tzungbi@kernel.org,
 chrome-platform@lists.linux.dev, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <20250607171301.537dd168@jic23-huawei>
In-Reply-To: <CAMHSBOUb-HPqmW3CFspipNGQGzbYUV+oqVw-Cbw0Bk4Huwz-QQ@mail.gmail.com>
References: <20250523172727.2654957-1-gwendal@google.com>
	<20250525144233.13df701f@jic23-huawei>
	<CAMHSBOUb-HPqmW3CFspipNGQGzbYUV+oqVw-Cbw0Bk4Huwz-QQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +     for_each_set_bit(i, &activities, BITS_PER_LONG) {
> > > +             /* List all available triggers */
> > > +             if (i == MOTIONSENSE_ACTIVITY_BODY_DETECTION) {
> > > +                     channel->type = IIO_PROXIMITY;
> > > +                     channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > > +                     channel->modified = 0;  
> >
> > Not modified is the 'obvious' default so can probably drop that one.
> >  
> > > +                     channel->event_spec = cros_ec_body_detect_events;
> > > +                     channel->num_event_specs =
> > > +                             ARRAY_SIZE(cros_ec_body_detect_events);
> > > +                     st->body_detection_channel_index = index;
> > > +             } else {
> > > +                     channel->type = IIO_ACTIVITY;  
> >
> > This is getting a little creative.  Do we know anything about what the
> > underlying detection actually is?  Activity sensor are often some form
> > of magnitude sensor on a specific type of data.  I guess if we have no
> > idea what this then activity detection makes some sense.  
> As written earlier, the event is triggered when a threshold is
> crossed. So contrary to other activity sensors like walking or
> swimming, there is no confidence level, it just happened that we are
> not still anymore.

The confidence level is a bit of a fiction for all sensors. I just wanted
the ABI to allow for algorithms getting more clever over time.  Right now
they all claim to be 0 or 100.

Anyhow, I don't think that matters anyway.


