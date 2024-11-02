Return-Path: <linux-iio+bounces-11841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E89BA0EF
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E1E1F216B9
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185F18732C;
	Sat,  2 Nov 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJqMs1nl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9C78C9C;
	Sat,  2 Nov 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730559666; cv=none; b=hkiJvICnoyk1qOzYKaY2SGw8t+SYCCauQUyAtghsvCRQ6LwJQTXTnfvXgvOq06cwNvPHuX6N0pXQb8V+Sj3AKSE1Jvd8GzpptVoqPiWIBt44WRoCWmshrZihgS6wx8QPRw9m3iQmaJQlZvXdCWS/KKvUevFu3W+Rjt5oxHsXNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730559666; c=relaxed/simple;
	bh=C0RfLupJNd0bvdqVpC6jIC+zpkkxt2Roevm+Eyc0S0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cltCTm5CKfom8Mc0fLn7MEo/WmTQMhbT105nEz3kp8HCbAPC0ibxhaQh6fIgX5W5l0Zq7xbmLxHowYK+VdYZFCJlr/9spJ/8hs80jEq0D8Pq/k1pYiui/kpkM+y5e1e4gNGNcDGE/ge4tM6gHaRAaujVUKG/JoEwjQR715JVADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJqMs1nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE7BC4CED2;
	Sat,  2 Nov 2024 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730559666;
	bh=C0RfLupJNd0bvdqVpC6jIC+zpkkxt2Roevm+Eyc0S0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sJqMs1nlrCeVXKi6Vq19+22UpEqWBrutt12oH+WO7bxC4oQHLA6YWmggBamOFpctd
	 82bepQSBMIKQW6j49/0lTBfUBKSb/IeXPIEAdcaXv1fd+C0YKQCtQRVSwcXq9xQaYE
	 oCEwYYE70+IljGGsXIscooqMrvOslC7snVIaZg27R0+D/Fv7cvhiUWIe6XPDMbtqwk
	 q+LsJDiKGLSkvbQ3zXp6LQp27XjJYyMfIFm6H7TPQU6a5BdZxCUDJSIEtS+FWJxC3U
	 AgnrpMk0luKb2VRGu23TpZmMRFhrSigeivEgyyREKsgoYdho6wnsjUqiiUnOcbgShY
	 ZVJocmStOe5xQ==
Date: Sat, 2 Nov 2024 15:00:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: finish cleanup of IIO_EVENT_CODE macros
Message-ID: <20241102150059.31554f9b@jic23-huawei>
In-Reply-To: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
References: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 Nov 2024 17:17:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Since [1], there are only a couple of users IIO_EVENT_CODE left in the
> kernel. We can clean these up too. Then we can make that macro "private"
> do discourage others from using it in the future.
> 
> [1]: https://lore.kernel.org/linux-iio/20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com/

Seems resonable.  Applied to the togreg branch of iio.git
and pushed out as testing.

Thanks,

Jonathan

> 
> ---
> David Lechner (3):
>       iio: dummy: use specialized event code macros
>       iio: accel: mma9553: use specialized event code macros
>       iio: events: make IIO_EVENT_CODE macro private
> 
>  drivers/iio/accel/mma9553.c                 | 24 +++++++++++------------
>  drivers/iio/dummy/iio_simple_dummy_events.c | 30 ++++++++++++++---------------
>  include/linux/iio/events.h                  | 15 +++++++++------
>  3 files changed, 34 insertions(+), 35 deletions(-)
> ---
> base-commit: c218214db564ca7d6885fa5859541a86197856c0
> change-id: 20241101-iio-fix-event-macro-use-cb374ab30c99
> 
> Best regards,


