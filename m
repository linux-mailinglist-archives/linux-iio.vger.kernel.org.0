Return-Path: <linux-iio+bounces-27037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E2CB7C6E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 04:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FFB302B758
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 03:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857A307486;
	Fri, 12 Dec 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le8XEaKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12A306D23;
	Fri, 12 Dec 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765510478; cv=none; b=fKip/1/Ju/omiKtNPF5C6QSUaP+vDvopy2vmmXqy5ZNh6LuC3bpDRi1T2vQwzjhHrxH0Wa/AEWrUaN8SYcj2YBfIfErb/rtTE7OYcIDPuwX/6Gdl5En5Xy0ByHx/1gFoiGwHm/RUqtBxgtoBxl6WdsanO5PEJHh2QSAHaYqDtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765510478; c=relaxed/simple;
	bh=Da76C/F7HgzekTcizGYUb/sNGCzYKccqBwv56E/Cqwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA0O2SfF8pgEVhb7EyBxv91hTrG9y4aE79pbaSndCRx3KMmino2byrOzGqx23+RXMxxmcLTRHmHKk/wvBrLJtz/e0nTSnkcGLVBp4nHh2ALW9F3lnJY5g78Kq9yfgpTunjVNhzvxD4Khw/gcQidkXDg0l3+NcOB9SjoClr82Ksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le8XEaKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F76C4CEF1;
	Fri, 12 Dec 2025 03:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765510477;
	bh=Da76C/F7HgzekTcizGYUb/sNGCzYKccqBwv56E/Cqwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Le8XEaKJXgLQnqQH3POryCUC58yvRb4R4amjOmfTawF3aHmBr2Laz43+2fztjqguK
	 dCyuUsNAVK60eL78pXIVTLJqsfLPmvAoSiZCfBI1RuBl77OIbPtJStzxtZcu5AnOEs
	 l7xQnd9Hvrqttp9YXzv7cdbO85pvHN8XDrTqFUgnFs1m9SU0ZWiu3KOF021636CQGa
	 yduGQKR1xCZ8YXPJZJuZgv53D/iWJ3VGtZalGrK5BViqhgkUclZa+X5ETO/k7mr1Ug
	 Kfi16v7pBL+t0uu07/LhigJB3SWRFL6dEhrKhSBxZcF/9XqbtNYuXm3XxF2JQiZBno
	 iXwnv17XJh4NQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: William Breathitt Gray <wbg@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: 104-quad-8: Fix incorrect return value in IRQ handler
Date: Fri, 12 Dec 2025 12:34:07 +0900
Message-ID: <20251212033417.24108-1-wbg@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206180007.1365-1-vulab@iscas.ac.cn>
References: <20251206180007.1365-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=wbg@kernel.org; h=from:subject; bh=Da76C/F7HgzekTcizGYUb/sNGCzYKccqBwv56E/Cqwg=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJnWvVpRPjfUduVcWSmxe9v7t1YiHDWf/fQ+9tty3dOeu I259fGGjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiC00YGa473XIo/j875cR7 z7bXUjozNz/gKd2Y+StqoaH7AevZqq4M/7Q9nlf0vW8TWlN9rTo68Uj31WszpF/y9P5PW/83bfP uHHYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sun, Dec 07, 2025 at 02:00:07AM +0800, Haotian Zhang wrote:
> quad8_irq_handler() should return irqreturn_t enum values, but it
> directly returns negative errno codes from regmap operations on error.
> 
> Return IRQ_NONE if the interrupt status cannot be read. If clearing the
> interrupt fails, return IRQ_HANDLED to prevent the kernel from disabling
> the IRQ line due to a spurious interrupt storm. Also, log these regmap
> failures with WARN_ONCE.
> 
> Fixes: 98ffe0252911 ("counter: 104-quad-8: Migrate to the regmap API")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
>   -Return IRQ_HANDLED if regmap_write() fails.
>   -Add WARN_ONCE() to log the error messages.

Hi Haotian,

Thank you for making the requested changes. I have a couple more
suggestions below, and then I think this patch will be ready to merge.

>  	ret = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		WARN_ONCE(true, "quad8: regmap_read failed: %d\n", ret);

The warning should indicate the purpose of the operation so users know
what failed for the hardware. So perhaps "quad8: Attempt to read
Interrupt Status Register failed: %d\n" is better.

>  	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		WARN_ONCE(true, "quad8: regmap_write failed: %d\n", ret);

For the same reason as above, perhaps "quad8: Attempt to clear pending
interrupts by writing to Channel Operation Register failed: %d\n" is
better.

William Breathitt Gray

