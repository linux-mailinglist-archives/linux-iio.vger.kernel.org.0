Return-Path: <linux-iio+bounces-23178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA83B32EF6
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F61B60541
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDAE253F05;
	Sun, 24 Aug 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL43HlqO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5141FE474;
	Sun, 24 Aug 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756031016; cv=none; b=jo5hcbz4JsoCT/5chDErBBTAR/fLf129gSXt+ZCJHx+UTe/JvWvpuA140mvHi+zqyZJzvB2QVn0E115M0QGvzpgzT3Djro9XNBPGysnHcW5eAvjiCMyCNxqmplfunJDqFr2zoI6++l5CCMmbe3GVuEP+hPesDuvi6mNPaDi+oPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756031016; c=relaxed/simple;
	bh=/JlW/aeDjeVIjiBoLSu7Lu4ouEASj/9Nv2pswZgq+h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnSvdIX9yMmkRnp+dkqjnkO364nZiwMtUVI14+0tRB2DgxJtsthRjPClFEUzv4yqEtoKR8VBL846Rs1BhOalRDoa7iunVi1HETDe1JUDZicsZAKsH4qO2bSZxrgg2y2rwRkryXnF1MnnCjZaCpPWiasO19jl159aadgJfogN4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL43HlqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F34C4CEEB;
	Sun, 24 Aug 2025 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756031015;
	bh=/JlW/aeDjeVIjiBoLSu7Lu4ouEASj/9Nv2pswZgq+h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rL43HlqOWN+PJSQmBIjMMSKEq2/Frp/370xGinFn4iLNWsKvRBJ5QY4+U+w1EqSXR
	 btM2qGLG1aao48I9L8tNcSylrZ9FfClXZz8EvzoqnYlXiHY1SQmw90FOKfsncL5ADj
	 PP8tJCOdks/QWzyF/nnirnC651fb/qo8DV8xbHRHypcl9KH6l56Iq3kEGWQfkStMom
	 qD9KdmWAkjcHu2yfp08K4Sga5Y0kkmFsA7uea2nwDKBnmMkq4bD+h0SFegL1oc8Dbm
	 2N6U45awYyyt2z9+t0RcbvuL6aCMelpwao1a9JbE7UyH5bPz+HP0ANoZ3tb25oeSKa
	 4j0MWGXpdKIsQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com,
	~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: proximity: Add Lidar-lite-v2
Date: Sun, 24 Aug 2025 19:23:22 +0900
Message-ID: <20250824102324.427517-1-wbg@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802121238.108ebfad@jic23-huawei>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800; i=wbg@kernel.org; h=from:subject; bh=/JlW/aeDjeVIjiBoLSu7Lu4ouEASj/9Nv2pswZgq+h4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBmrXnAKFOql/5h9ibdSQvDXCeV59e2zvR8L3H7/8Jif+ q5ZzKo1HaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBEdq5n+F+zsrW44kfjlsdN 75dvOri5havWwrTjoukcjZe14SpOvBsZGZbf+PtXanbW6shZ82dN5d8qzbEk/MSRx6LCOzlen32 uOJEbAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sat, Aug 02, 2025 at 12:12:38PM +0100, Jonathan Cameron wrote:
> > On 7/3/25 18:26, David Lechner wrote:
> > > On 7/1/25 5:30 PM, Rodrigo Gobbi wrote:  
> > >> The compatible grmn,lidar-lite-v3 is managed by the same
> > >> driver of pulsedlight,lidar-lite-v2, which is a trivial device.  
> > > 
> > > As a general rule of thumb, using the driver as justification for
> > > dt-bindings is never a good reason. The bindings describe the hardware,
> > > not the driver.
> > > 
> > > Assuming I found the correct datasheet [1], I see a power enable pin
> > > and a mode control pin, so I would say that this isn't a trivial device.
> > > Therefore this will need it's own new file. We could at least add
> > > power-gpios and power-supply properties. How to handle the mode pin
> > > isn't so clear to me though, so might omit that for now.  
> > About the mode control pin and the data being returned within PWM, it`s also
> > unclear to me how to describe that here. Looking other kind of existing iio
> > devices, couldn`t find a reference for it so I`ve not described that.
> 
> So far we've never supported a sensor with a PWM output.  Needs some capture logic
> and whilst there is some supported in the kernel, I don't think we have the
> infrastructure to describe the sensor beyond it. It relies on an odd combination
> of triggering via a light pull low that the device then drives high.  To make
> that work with a standard capture unit is probably a case of wiring multiple pins
> or some external components.
> 
> +CC counters subsystem maintainer William.
> 
> https://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf
> for reference

So how does this look from the monitor pin side; a low level for some
amount of time followed by a high for a set duration, where distance can
then be derived from the amount of time spanning between falling edge
and rising edge?

In theory this could be represented as a counter device (in the context
of the Generic Counter paradigm the monitor pin would serve as the
"Signal"), then Counter events could be defined for the edge
transitions, and finally distance can be derived by userspace by
capturing the edge transition events and comparing the timestamps.

However, while that approach works in a technical sense, it definitely
feels clunky. On a conceptual level, a remote detection instrument
like a lidar isn't really a counter device: it's purpose isn't to track
the progression of a count.

I think it would be more appropriate for us first to properly define an
abstract representation for these kind of range-finding devices. For
example, these devices are going to have some sort of trigger (whether a
pin polarity or command sequence), some sort
of transmission signal (involving a particular strength, frequency, and
duration), and some sort of reception interpretation (perhaps involving
noise filtration, multiple previous record averaging, and timestamping).

Once the general abstract representation of these types of devices is
adequately defined, the DT-binding design will naturally arise from it
and subsequently a proper driver interface.

> However, I'm also in agreement with others that this is an unusual case where
> we are very likely to missdesign a DT-binding without having explored what the
> driver stack looks like and so are best just leaving a gap for now.
> 
> Even if we did describe the mode stuff it would be optional so not describing it
> for now should be fine.

I second this as well for now. There may be other devices that we will
encounter with similar mode pins and such that would help us figure out
the best way to introduce these to a DT-binding in the future.

William Breathitt Gray

