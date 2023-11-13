Return-Path: <linux-iio+bounces-47-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F797E9577
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 04:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794AE1F21016
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 03:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C7C2C1;
	Mon, 13 Nov 2023 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHdRd0B2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54468C0A;
	Mon, 13 Nov 2023 03:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3970EC433B6;
	Mon, 13 Nov 2023 03:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699845835;
	bh=3fhqQ/6Paof6tKXgjKwnx+l50Cg3avv/xAwzx5scwHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHdRd0B2QP8kwbaKeutfP4bb6zeLjivj6vjCDrlzRkfmENozNn5IK8TQhzd2TZtLW
	 2hb44pwT1g04n+hfzQQA+rMbnEFa43VxfnKK0mVW+9JvcJNuX43GIrpDPN16BwKSRU
	 Azs+PDkJg+14ukH5bZC7NxBSydgjSAyFLzT77tDD3kF1raUoh5t3JJt0hVItieSCwC
	 saAjdm2d1ntefledwJJbvRfedLAHCGIxfOXOp+Umd3trduL9iC7WwUxITe533aUS17
	 SzjCuM6h3SY2M1WH+UumCLa7HEZr157CKpz01DH5zfE/I8o4Aal+KdjqYU38QZsHTM
	 ud9Bz4HzTdDRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F47EE21ECD;
	Mon, 13 Nov 2023 03:23:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] iio: cros_ec: fix an use-after-free in
 cros_ec_sensors_push_data()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <169984583512.27851.7360374052526064442.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 03:23:55 +0000
References: <20230829030622.1571852-1-tzungbi@kernel.org>
In-Reply-To: <20230829030622.1571852-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
 lars@metafoo.de, chrome-platform@lists.linux.dev, gwendal@chromium.org,
 linux-iio@vger.kernel.org, dianders@chromium.org, swboyd@chromium.org,
 stable@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Jonathan Cameron <Jonathan.Cameron@huawei.com>:

On Tue, 29 Aug 2023 11:06:22 +0800 you wrote:
> cros_ec_sensors_push_data() reads `indio_dev->active_scan_mask` and
> calls iio_push_to_buffers_with_timestamp() without making sure the
> `indio_dev` stays in buffer mode.  There is a race if `indio_dev` exits
> buffer mode right before cros_ec_sensors_push_data() accesses them.
> 
> An use-after-free on `indio_dev->active_scan_mask` was observed.  The
> call trace:
> [...]
>  _find_next_bit
>  cros_ec_sensors_push_data
>  cros_ec_sensorhub_event
>  blocking_notifier_call_chain
>  cros_ec_irq_thread
> 
> [...]

Here is the summary with links:
  - [v2] iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()
    https://git.kernel.org/chrome-platform/c/7771c8c80d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



