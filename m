Return-Path: <linux-iio+bounces-19890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A27AC34FE
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDF43B081A
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAE1D6193;
	Sun, 25 May 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrC+Yxqb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A424315F;
	Sun, 25 May 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748180635; cv=none; b=irSJf399HRztxXJddKgGihQRI9A/+DIqw6kN+Ng9iJBjaaALvt70hEIFfZL9wSIA21/P651WSkfQCsPJYai5i2i8bAtCLEwNZMivt6VNTVrI/VeSzT+v884MuCJhCiBNgVXzaptz/GouIXo0q6kGv7/+AuS5t5aD1FK3r0w41Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748180635; c=relaxed/simple;
	bh=fvwmMyJeVqnvBrPw+40HDJlMeP815WgZLOoQbFqx1mI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws7zWytDS0Ao0o2pM29y7d7ja1Oesk2eXzOOsoEXw7s07VzYtaXy7p2e4coVLQygDSsRdaNWmMt4uWwXOa+ekoXvYLcXtdc6kfzsTw7BFKlTrp8CpbC3pxlw6oLreLrCu3q6+9IX/31FEtoXvfjHO2TXBceeORUrZOEwXnVem5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrC+Yxqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F0BC4CEEA;
	Sun, 25 May 2025 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748180634;
	bh=fvwmMyJeVqnvBrPw+40HDJlMeP815WgZLOoQbFqx1mI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZrC+YxqbRQE6NQ+hULI70bgHNHy/PicL4eGmVWPDEVvCq+iPi21ciZoxA7tsA9OVp
	 GyPa4Bx4VqG59W/m5GW3u0NiM2KnMqWsa19mqLXwn8ucStfjf6erqlrMV/BxUFkNzI
	 OL9ZFhxt6WNZPRLxTyrxHsKoNF1c1mrhKcBwYNoQvXRkDBWu6UgpvbywKbSKnzkjMV
	 1n/rFBKnWm0Q+bSWXKIqTyIe4qriI95/pN639rQ2+r1rYt0tKj585uhphU39YtZeL/
	 EYgnyubCYMgWgyZzUjXlTVT50TfWEPw8/uinJDCHCJgFotQyZw51T9sdMZYXNmYyb1
	 zCxu/S9tM8ShA==
Date: Sun, 25 May 2025 14:43:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v4] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <20250525144347.24429a37@jic23-huawei>
In-Reply-To: <20250523172727.2654957-1-gwendal@google.com>
References: <20250523172727.2654957-1-gwendal@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 10:27:27 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> ChromeOS EC can report activity information derived from the
> accelerometer:
> - Reports on-body/off-body as a proximity event.
> - Reports significant motion as an activity event.
> 
> This new sensor is a virtual sensor, included only when the EC firmware
> is compiled with the appropriate module.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
4 versions in as many days isn't a good way to post to the list.

Please slow it down to give time for more reviews to come in.

Thanks,

Jonathan

