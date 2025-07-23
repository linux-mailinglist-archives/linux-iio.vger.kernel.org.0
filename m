Return-Path: <linux-iio+bounces-21930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE80B0FDBD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 01:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2814E587A9E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA8254844;
	Wed, 23 Jul 2025 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1K9qzH7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA5A59;
	Wed, 23 Jul 2025 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314381; cv=none; b=Zu8Tcqsw5hlb3HjqakuVfVwInrhwnAJWxBvOBueMostNHVe86x+qxL/TgSSWkgKbb5iR3iQ628ygEroiUyp8tAhxuW8pCLA0nutyzsDa50coE9GRdoDOMdOmkrIhr9YnxmlKnS7YkRqA13fWWV1lnkecPrDeOYRb9ErsfBxVqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314381; c=relaxed/simple;
	bh=L9TrYMjgYebm6KWIWcjYqtWR2XfIR95CuTK3iPlv5r4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7uU45rD1Iq+kR2bychZe8m5lEEBwxirzfqf43VPKrH88QB1eXiD64Sb+4X7cRcR87fGYVhvnWH6tjYJXEG4Cstr7mzfJKbJWSJ4mEBBtQ+Pz6j7ivPlUyVQRbtyFSEK0XWWPxrc2MMYemQk2llzkabQUHyK4bvZUk3cf4hbxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1K9qzH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525B2C4CEE7;
	Wed, 23 Jul 2025 23:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753314381;
	bh=L9TrYMjgYebm6KWIWcjYqtWR2XfIR95CuTK3iPlv5r4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i1K9qzH7DG2h+g1yZsEjaOVZzigH1fChupHxonmAIx7JGqhCu+z87XlBnVEupXEt6
	 KSqkbGRpnDxmrhXtnF1dcFlSHwR1cn5ToYnTcU2qtx8pk7v85TdPm10X605v4xe17R
	 wpbUeQu7mCREt74xv0h5FygWr++g81Wpj85SOxBpjOmSJb251GcTyhRdonSQSdj3JI
	 W7of1EJ+hb2S3xA6dWqjuH+45NyOpujnCTIPius9sxbeG/NSDlnyQztLfic65oghnN
	 4TCL++mWSgE9usLvZUw6/KW0T9ZQpTwet84KvfyjPT3ptHhE9tlUoBWJTBc3AvBXUO
	 fSVFmBk159VXw==
Date: Wed, 23 Jul 2025 16:46:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML
 docs
Message-ID: <20250723164619.303f1dcd@kernel.org>
In-Reply-To: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 22:35:13 +0530 Sanjay Suthar wrote:
> - net/amlogic,meson-dwmac.yaml

Acked-by: Jakub Kicinski <kuba@kernel.org>

