Return-Path: <linux-iio+bounces-49-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B117E95A6
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 04:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698BB280A0D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 03:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D094C8EA;
	Mon, 13 Nov 2023 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwx0RLwg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E160DC131;
	Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51E8AC433AB;
	Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699846957;
	bh=Pg8KGKCTx09ynw4PpsdjEPCbj7JGswFIbPDvp2oXAs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uwx0RLwg2clUjL0F0QCgbcoamqTjEa6lfpdUDZrQiKTkjcQ2fivCmwGH4GQy3vMev
	 jORvpnzjtJJJ1GTYkuo/gouAUtk14rmJNlV62KS7hmEQ/jLhHBAdbO5ODG7XRCCx35
	 mkDoHufzzICtAOD4j2Qbya4ro8dwmdFYWydMLzF6+05svyOOHVaV+7XzGUJ1/em1th
	 5s4XIp4nRc/tYVgy+KAHaHhQsqmgqrv8YeK3otUESscjYUGLSPPVZtOtttY9FomoqL
	 BSNHqy7/9T05L4xFrG/c3f1h3WfZRGYbfnbY9ps0UoyLmHcbJtIF8ONYVnzT6zTpy0
	 MjA5ZPnpwSMbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 367CBC04DD9;
	Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
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
 <169984695721.27851.13616090914535428940.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 03:42:37 +0000
References: <20230829030622.1571852-1-tzungbi@kernel.org>
In-Reply-To: <20230829030622.1571852-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
 lars@metafoo.de, chrome-platform@lists.linux.dev, gwendal@chromium.org,
 linux-iio@vger.kernel.org, dianders@chromium.org, swboyd@chromium.org,
 stable@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



