Return-Path: <linux-iio+bounces-684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801DB807746
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 19:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079B7281594
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C86E2CD;
	Wed,  6 Dec 2023 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeaRwAUR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13E49F6E
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 18:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C24C433C8;
	Wed,  6 Dec 2023 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701885933;
	bh=OCruHlR7kWLecpOSQsd2C+ZXoLW/73SVP7tDoBQiGSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jeaRwAURh7Bm0GfcGJUDU4cgPZdOXR0NeD6+BPtXPu3XKDbnBL/Cc/mK7flYu8hCw
	 EklEhr4oBD/e/M/YG2rUHab3yCXWMexAQ10gCWHWo8JTxn1VV8I8tvT0Z0XOjXKceu
	 jTHZ7CBhc7Ivf76t88NKohc+MrDsWsMiNRkBuy1WuG6QY4tMYQieCclP6KeOj2HekH
	 8pmQhqEs0tElrVQ4uRd/cJg7i2IR44spXiyicsIHvaoAor7m+0KU6ZGdz+ewL3RvfO
	 okok531Yzc1KQNLSszaTwZcD5B8JJoIQ3W2aajlgZMVYJwdWnVxCnAIXseeL6TCsCI
	 Kfm88P12n1JXA==
Date: Wed, 6 Dec 2023 18:05:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 8/8] iio: adc: adi-axi-adc: convert to regmap
Message-ID: <20231206180525.7f4ce56c@jic23-huawei>
In-Reply-To: <20231205-iio-backend-prep-v1-8-7c9bc18d612b@analog.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	<20231205-iio-backend-prep-v1-8-7c9bc18d612b@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Dec 2023 18:06:48 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use MMIO regmap interface. It makes things easier for manipulating bits.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Rest of series including this one look fine to me, but we should leave
them on list for a day or two before applying them.  If we agree on
language for patch 1 description I can tidy that up whilst applying.

Thanks,

Jonathan

