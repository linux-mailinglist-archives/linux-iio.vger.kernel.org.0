Return-Path: <linux-iio+bounces-15590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998BA375E3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CBA188BD8A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452919C553;
	Sun, 16 Feb 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTdNsL1o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17A18DB21;
	Sun, 16 Feb 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724015; cv=none; b=VZlOg5wCFVWAnB7TwG8b4IjiD55dnHrrrTkXWhw3KB2y5OHxsBPD9TlAoTQeVB7RyVnQwZe9k/eaANlIQmdl+WM3UofjEaQhQrthpr1zPVpZYowIBz89hv1Ew15ZFAjfPE9SAgSftQhuZB0mPaWgaaekAgk/cFx6674w/PPKCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724015; c=relaxed/simple;
	bh=VYToQ/4dqk8RStG8Ey/hwHeYLBxZ15D7FpT1+nhkAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXgFGBe9lOsdMr1myZchHny20KLwO8vOaHfW7Tq6x7GpaUxWt9eqk8X90QrApMUCSMOQg4NemgRN3DJ/S+nimfOuZtqwxOn0PAU/gvMYPh3yC9P2eIUD0Wg+7YfrdV0UxVDnlJZXjLcYPWRnYU43gmcZbPtvBA4ZQKBuXP+qiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTdNsL1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DF5C4CEDD;
	Sun, 16 Feb 2025 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724014;
	bh=VYToQ/4dqk8RStG8Ey/hwHeYLBxZ15D7FpT1+nhkAlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BTdNsL1okkXPSEIIN6irCt05MdKuE0I4zIpWS4OL92Yo1o5E8+lWiNuSHLWMCCBdp
	 R3YvXcDSp81TDacYwpy2LK2a3/k2fpF6v0jNyMg2wkmkmiNpUQi71aYly4Gs04mCCU
	 pAulIvcx2yN2pL0ast1gR1CqQFxOGClG9o2RqJ+UkiE8AUdkZf5Xr1C2caE+2THuSW
	 GM0yuGvzlnW7jRdgY3OPAlAhkslEHAzrLoMpk9MlatTssgjLGgUM235wj+1vhUXFTj
	 U3uS+mILpWeShAP88Kk/CqqGvFiMbghIm2lQibXko76KC4C1vMSwglRd2dhb6EhZKM
	 B26JEhRucysIQ==
Date: Sun, 16 Feb 2025 16:40:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 0/6] Add support for ADIS16550
Message-ID: <20250216164004.000483a1@jic23-huawei>
In-Reply-To: <20250211175706.276987-1-robert.budai@analog.com>
References: <20250211175706.276987-1-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 19:56:57 +0200
Robert Budai <robert.budai@analog.com> wrote:

> *** BLURB HERE ***
Missing... 

> 
> Robert Budai (6):
>   iio: imu: adis: Add custom ops struct
>   iio: imu: adis: Add reset to custom ops
>   iio: imu: adis: Add DIAG_STAT register
>   dt-bindings: iio: Add adis16550 bindings
>   iio: imu: adis16550: add adis16550 support
>   docs: iio: add documentation for adis16550 driver
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       |   73 ++
>  Documentation/iio/adis16550.rst               |  376 ++++++
>  Documentation/iio/index.rst                   |    1 +
>  MAINTAINERS                                   |   10 +
>  drivers/iio/imu/Kconfig                       |   13 +
>  drivers/iio/imu/Makefile                      |    1 +
>  drivers/iio/imu/adis.c                        |   36 +-
>  drivers/iio/imu/adis16550.c                   | 1151 +++++++++++++++++
>  include/linux/iio/imu/adis.h                  |   34 +-
>  9 files changed, 1682 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
>  create mode 100644 Documentation/iio/adis16550.rst
>  create mode 100644 drivers/iio/imu/adis16550.c
> 


