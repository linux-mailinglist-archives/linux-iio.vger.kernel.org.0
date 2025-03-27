Return-Path: <linux-iio+bounces-17284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE9A73594
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B72189CAA2
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A19418A92D;
	Thu, 27 Mar 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnHbAHTA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399B186E20;
	Thu, 27 Mar 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089222; cv=none; b=hjJq6QtM4YSwseTNSuXsqWtE0VPoV+EoNzkWyw5dYh/2IrzrtSPPL24yivduVmUswdxr1Iot6E9L70GKEN1rBqoeww0dxVgfhLPAZVWPYXdkQoz6YyPUgZLzYt7wOsMOaQs4zm8BV1qH0os3kZauD678oih5FiS/9b4/o5zrm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089222; c=relaxed/simple;
	bh=pVqOWJYuj94Q8C5G3ZscRki9Gk5QZILnqWiBiivFR3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD9W3HyYnerUxZIsefOVmwJFNZDZd7sp/7f0LMoeaTT60yGogI0C2/UzkTFwMsgm/1CGYVqytHFzNB0e+ZfeA0MM7F2BAXjVv8JyN/YjJ4MxKGRya7krF0qv90s7ZntiaDopfg05QI072lLk4QVg5iDSFtiGdoPmNwgoDsz8jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnHbAHTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B638C4CEDD;
	Thu, 27 Mar 2025 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743089222;
	bh=pVqOWJYuj94Q8C5G3ZscRki9Gk5QZILnqWiBiivFR3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pnHbAHTAA5R0gJ8q3elQ/HenXdGB+lTdT4iDtRcsh2p5u+2vUVqrrbkmQuRpr0gag
	 Gr3l50pJBeQXQaItsTHaCk1huBYwCVvURbzkMmXR8vhmq4yS4DUPaHJ0EoNG3ZoDG/
	 QVMnhNkNpUBb1RirDMm8ph0cpI4zPKEjTRfjFN4CglxVWPt8/4rfW2P2c0IJrhJNnq
	 w6C9z6ViC7jn2cD01bhRd/iENJ9POtT6i2emLV3da5WpwlAQZrhJs9EpTLlJ2EygZP
	 11zyMPab+ETXo9zo3X/XiN0sv7zk8oR7NYpulryup1yaPAn1b5bKAFu7PXILltJ1li
	 3HO6Hws2UDyJA==
Date: Thu, 27 Mar 2025 15:26:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Siddharth Menon <simeddon@gmail.com>, linux-iio@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <20250327152650.3c27cb2a@jic23-huawei>
In-Reply-To: <Z965Rz8NuXhbHrgy@debian-BULLSEYE-live-builder-AMD64>
References: <20250319045212.72650-1-simeddon@gmail.com>
	<Z965Rz8NuXhbHrgy@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +		phase_cmd = (i % 2 == 0) ? AD9832_CMD_PHA8BITSW : AD9832_CMD_PHA16BITSW;
> > +
> > +		st->phase_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, phase_cmd) |
> > +			FIELD_PREP(AD9832_ADD_MSK, addr - i) |
> > +			FIELD_PREP(AD9832_DAT_MSK, phase_bytes[i]));  
> Would suggest to align with the first cpu_to_be16 argument here too, but better
> wait for Jonathan's opinion about this.

I'd typically go for one tab as done here.

