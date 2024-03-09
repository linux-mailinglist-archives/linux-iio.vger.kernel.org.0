Return-Path: <linux-iio+bounces-3422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BF877357
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 19:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7761F21FA9
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F317147F4A;
	Sat,  9 Mar 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc6sGbjq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A645BE2;
	Sat,  9 Mar 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009643; cv=none; b=gBtgZEo7tKcCMnDFh1g3ezLHz7v8TzZvgAOCtcg5OhPW5fDaudyUkspYAQkezaUQkSdHhDvV8I+NHFS6UjN7U8YVozfUlS8nb2igBBZefm4ASbfM9XGkLlo+ErVYEuin2GO5gL8ihxv7aAkqqWxB1tpODAxJBCfowMNAa85EyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009643; c=relaxed/simple;
	bh=CKj/UKmETF+xIHWdB4Jyz6DrukhG0odsfMn9YApPjAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvZW0zwFS7fenRRsc/48KWHtI+NLury47mI06/l7hA2o5qoo/yfWIRt+h7jI/a2PfyWQdLxeEHCJOPxOGaBy0uHLtXI4EaZ9LdbKnK2YU8RDTx0m7yZqBDysEXtSFC8lUs14d0ENzWC+qfQx0GCUOu6pqbq236F2Eog0Q4XhzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc6sGbjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3AC433C7;
	Sat,  9 Mar 2024 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009643;
	bh=CKj/UKmETF+xIHWdB4Jyz6DrukhG0odsfMn9YApPjAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sc6sGbjqoEZjIR9h4rOCjSdjOG4whBdVNue/qKG4jIxib4oZvSdkFJ8xexr1Ed0nw
	 c6uy/MTUGqotUH4cVxbPCojidokMaw6z6UPVFwWIdbc/RLfrbCupvZskvThqQcsnvk
	 c9jcuqDiReqI5UaaYJG02QoV2ANCBjAhDDYk51oq76BewxMa4XR8tNfPPtDTSN4BHn
	 zMGQa/fmHVp5unfqYmaTOXQzXjpp+PcATfRbeDEtgzNliP2HWAnYrYP9BIFXI2Aisy
	 EOLdIUZ0RWo8MnPk2aPmN8iww4Uwa+lC+iJbhg5CA+BL/Aq0LG5IfGmQoqvBsdJGMd
	 VJL86qNETRNyA==
Date: Sat, 9 Mar 2024 18:40:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/3] HID: hid-sensor-custom: Convert to platform remove
 callback returning void
Message-ID: <20240309184031.0b43143c@jic23-huawei>
In-Reply-To: <f4c8334ea1548d911862ede881ab0d90a408c156.1709747164.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709747164.git.u.kleine-koenig@pengutronix.de>
	<f4c8334ea1548d911862ede881ab0d90a408c156.1709747164.git.u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  6 Mar 2024 18:50:49 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

