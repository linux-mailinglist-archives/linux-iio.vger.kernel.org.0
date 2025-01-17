Return-Path: <linux-iio+bounces-14434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAEDA15433
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E5C166AF8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24D19D89D;
	Fri, 17 Jan 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raGP8CeJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23819C574;
	Fri, 17 Jan 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131143; cv=none; b=Q6r7Q4vs/UekgZV+mZE5hjN0xFlcAaF10bvRm90sBvbTZCKm/PkmJ3JwqjlIezv4xOwE8FTJLd/4GtuiejrX05YK6veN1QE/ZrE3wP746DJ9M1MRcPzp4IDE1tPmXP/t+MnmP+XStMFbz8JXNg3L6CUSkC/k6L7NsHosjtU0QIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131143; c=relaxed/simple;
	bh=1ScA36VYztuyZnZ373XOAVM27pu0c6JnSlThrTKs9p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaHhWiKCNjZV2/6IUy9UrQVgJg/TdaqZcXhHaQ/AVwqkYLu8s1y26JiArAvAEYZ661G/DbcgYwqk4eYUoITDF7Ff9NhZ8an+/gUKDvoPHYlxFmMxwgHShp8RUMGhAV2rnus9UYVGdkbTr5T114FZqW0cPPUFeHak3YOnRG6SasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raGP8CeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0BCC4CEDD;
	Fri, 17 Jan 2025 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737131141;
	bh=1ScA36VYztuyZnZ373XOAVM27pu0c6JnSlThrTKs9p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raGP8CeJdmUfDLP7MpV4gnEWzlop3xBmjg7887weSCbYnySHQfi12qSD7oDS5b5o9
	 Hun4/L21m34QIObut7y/M6DC12ExwoaWY9g3vAEXEQT9UPVFsfFt0sZj42GK63p6Lv
	 eRr+E5X+ZChEDDjiefRzWXWe8CNqTao8WbCpvBFRgYj9VU/P+hrmmvIHsRd+Nzup2f
	 Zmw6krwbgjdpJVI5J9qMtL1cTkqcxNwJpkmh0KQBpcUTtO1bPA8yuE69oL+mJTRUx6
	 AlYu2fCIfGc00ntGkcZg4p1+zyGLTRKQaD+S4VOkUTzJbjX2Bc6ntaYmzGKtck+qJi
	 DcuTQPhD8s+NQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	David Lechner <dlechner@baylibre.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] counter: ti-eqep: add direction support
Date: Sat, 18 Jan 2025 01:25:00 +0900
Message-ID: <173713087799.311492.3968071915540963397.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
References: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=wbg@kernel.org; h=from:subject:message-id; bh=mUYnqVDjXT67H6LfpEjZHUj8wr475HYpYaYWPIYVAt4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOldzXtXa6pe+uOgfDJDvHOqw7INJ9/b//+8f5rTOZv8m Xp5l1b96ChlYRDjYpAVU2TpNT9798ElVY0fL+Zvg5nDygQyhIGLUwAmsvwvw1/xwJI50peT7BQ3 eyZp257Ku+Io/GLhmta0v1fztwo2BO5l+KdeqsS2No/pwuO7Ap/qX1YV/eCfmXwqqu7Sq5nPONT ZfbgA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Fri, 10 Jan 2025 18:22:03 -0600, David Lechner wrote:
> This is dusting off an old patch [1] that adds direction support to the
> TI eQEP driver, so calling this a v2, even though it has been several
> years. :-)
> 
> v2 changes:
> * Split out core change into separate patch.
> * Removed extra blank line.
> * Rebased on current iio/testing branch.
> * Add patch adding the event to the counter_event_watch tool.
> * Bonus patch to fix a missing gitignore entry.
> 
> [...]

Applied, thanks!

[1/4] tools/counter: gitignore counter_watch_events
      commit: 2ea167ef2aeaea4edcbfc64a95c2f66339eb7dc0
[2/4] counter: add direction change event
      commit: 6bd5aafd033866bceeb0246bf774b091cb3ca7be
[3/4] tools/counter: add direction change event to watcher
      commit: 845e924ef6d5943c22d3f5736752d4bb8885cdb5
[4/4] counter: ti-eqep: add direction support
      commit: ceb3075433d94767cef05cbe8e9fc9355d04d945

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

