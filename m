Return-Path: <linux-iio+bounces-25017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F99BD191C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 08:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998A83B26E2
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 06:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8B2E03F0;
	Mon, 13 Oct 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaSHwMsH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6261E3DED;
	Mon, 13 Oct 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335273; cv=none; b=QG6He9u/YkQjWW97TmwYjuQPZjm5mDYjcajcMvL31Y2i1peTDUTHTRk4boHkRK0u8+Rrg67jnaTTu8vrJypj8SX5ffH17nhzxIW8XsBwnhc5wr7J2BrSUHG3605+xu8G2Re8OuZgLdb67KPQz02B3k5KXexpEkiGTgAyp2FGaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335273; c=relaxed/simple;
	bh=1ap+MJcPfkNA5oVgftpQ/EYbo9aqD7bOjQWjQ77cIbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrhfR9FeeH1F6pYw/2+/f/0d1pNRrdhQ/E/VWssSN4brxhhKNd29BJGO7z9dG4Qma8XK3/igzP/nfCygB/BpgUomYSTWMM8ApVhWITa5yXwRqZhrMxLgsgt5KWe9W9z4IKSW9B/1UaaHZQ0u/2KT+ttLoegdyhKlEFEJJByQTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaSHwMsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2E5C4CEE7;
	Mon, 13 Oct 2025 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760335273;
	bh=1ap+MJcPfkNA5oVgftpQ/EYbo9aqD7bOjQWjQ77cIbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SaSHwMsHgqQemegBnH4z3oFtqkOsLT1IhDEMS/coRuLAZoSlTb4Zs0o/UGOmLsK9n
	 RT5cyg951w3iTn84isKeDXTtaa6B2TN0/HlFVvI6oAxHRaxsEDNhZRrFU76CqYMbpK
	 zI85mwMbLeA+MwKebVlrEecroqp/YvpC5OqTRonT1XgJ7vlBFdhcP/aHkksVJcraQ8
	 XUPdW/zj6k3Af6rh17Du673XxKtIWcyjpb9i+ZFB3keNfkcPihDLignvGdGIS76ji+
	 kNJDXnYukWH7KdM8eeIEfV7PX/bx6+m2ZJ850+OrTKrX8VlYVzb66w2vaO933HFCov
	 DesJsblSJ2Nyw==
From: William Breathitt Gray <wbg@kernel.org>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
	Dharma Balasubiramani <dharma.b@microchip.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Allow shared IRQ for multi-channel TCBs
Date: Mon, 13 Oct 2025 15:01:01 +0900
Message-ID: <176033523436.106204.9869251013103555876.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006-microchip-tcb-v1-1-09c19181bb4a@microchip.com>
References: <20251006-microchip-tcb-v1-1-09c19181bb4a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=730; i=wbg@kernel.org; h=from:subject:message-id; bh=FfihZzLUnWdr8UZTAyufw7Pkrq9SwIy86X5nsYJ3Io8=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBlvpnZOLD3YYij3rHVJaMIfn71LJ/Mms2v6vd137m3fI 7/pchLiHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBE1tQwMvR8TJi44XOK/feI O21d/yTUDj3dPD0rZ4uNX9zDjo7zZqmMDF2qd1huvl31ZjpHTaS+yBmNX0ayFuKeB8+qSbxm8Sy 6zQoA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 06 Oct 2025 16:21:50 +0530, Dharma Balasubiramani wrote:
> Mark the interrupt as IRQF_SHARED to permit multiple counter channels to
> share the same TCB IRQ line.
> 
> Each Timer/Counter Block (TCB) instance shares a single IRQ line among its
> three internal channels. When multiple counter channels (e.g., counter@0
> and counter@1) within the same TCB are enabled, the second call to
> devm_request_irq() fails because the IRQ line is already requested by the
> first channel.
> 
> [...]

Applied, thanks!

[1/1] counter: microchip-tcb-capture: Allow shared IRQ for multi-channel TCBs
      commit: 109ff654934a4752f8875ded672efd1fbfe4d31d

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

