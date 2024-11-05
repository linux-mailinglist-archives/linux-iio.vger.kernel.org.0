Return-Path: <linux-iio+bounces-11907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3D39BC1F7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 01:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738E91C211D6
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94D566A;
	Tue,  5 Nov 2024 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxX7In7Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A4ADDDC;
	Tue,  5 Nov 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766310; cv=none; b=F9HC3m/HOsalYipYyLkFe68hXF6jNT+eU+XyXZKxfdY6ARh+57ePtxr9yveNSS9dwwSLCNQEXzOjurScppyP+nn2n/fdRHZNHkcoEmZwDpqdkreRnrR3h8Tu7+1TgSxhtLxzocOAVpm4BV1QsjsxXTPYXOsjwEtNsv5IeJWh7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766310; c=relaxed/simple;
	bh=qbnDUfYEThmPH8j4hgWH8kza1uAcp5ET3WCJbFvsbDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwAU69jcamm479v+t/Vb7piO75YVc3LlLKelRPLDNNe8tpwVwFbC7NhS+j2rWEf7wZ8HNJ24z1DfExkpzQtq0tQwliVAQ2PxXsqptU3gkwfyjxg8ov7/P7PFHx/4pNP0NuE/PWFzfkrER5IJmTg/6igU7iNSzjNMJumT6wAbhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxX7In7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD03C4CECE;
	Tue,  5 Nov 2024 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730766309;
	bh=qbnDUfYEThmPH8j4hgWH8kza1uAcp5ET3WCJbFvsbDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxX7In7Z2gLCD5KTV4WGKqyXC6TWSW53C5v3zAV8CT+5vKj8FTtX4wa5HWh7oAOlN
	 +Q6l5oQOuxqp8H2skviyzqAYPexng6eKJAmNiD07wyXJgGJXdnvvZPz4gVlla9rIQH
	 Tjwowi7xHc0EDPqVTD2pt6FjXW7F9II4LOXP5IDOcBnKiawa9EO6RLZXhgwKncXPZu
	 GR0DmGz9clvlziw3XAG3rgMzQSCEf9RUNHKBLZ2NiuviqemiV0DcZYrwsq6FwjyUum
	 5UMISPKsF9vMhLoMLvCK05VgmNfTPLqJqfm19mseZEVGLYnXYI3wzrXgwTlZblxP7E
	 lGk77S6AkKBnQ==
From: William Breathitt Gray <wbg@kernel.org>
To: vigneshr@ti.com,
	jpanis@baylibre.com,
	gregkh@linuxfoundation.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: ti-ecap-capture: Add check for clk_enable()
Date: Tue,  5 Nov 2024 09:24:59 +0900
Message-ID: <173076612184.810486.17124240246908472539.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104194059.47924-1-jiashengjiangcool@gmail.com>
References: <20241104194059.47924-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=364; i=wbg@kernel.org; h=from:subject:message-id; bh=a8n5behxk0+d4YBmPYlIo0dhde1V5wO+A7w6VJo2O38=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOmaqYt372O4qNVQtZCd+3D5VCUGZaZu41sysfcLp11hm PXPyOVpRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRxwyMDP3ZnPfYghmzSj32 XDl6tNxiwVaPDFn//Yymn7KST9otymRkWL/5Rmtj9O55i2L/be5oKe880lfwLOZYkNUWg33NzRF X+QA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 04 Nov 2024 19:40:59 +0000, Jiasheng Jiang wrote:
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> 

Applied, thanks!

[1/1] counter: ti-ecap-capture: Add check for clk_enable()
      commit: 1437d9f1c56fce9c24e566508bce1d218dd5497a

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

