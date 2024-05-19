Return-Path: <linux-iio+bounces-5134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB38C960A
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D666E1C208FB
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C448CDD;
	Sun, 19 May 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB4JTvUL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952E6F066;
	Sun, 19 May 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716146256; cv=none; b=Fq3+fjopT36lYKf7f1fBDiPZZH8opzwsX0tufpoAYlrH37SDt7L5CgVPEe+cJ1qzBXbP04GjrWSnmIHp1G+5H/vk+BGKzDbai2XQAAMkW6RXGOvATJVjXadRDj8jcSk+Hsrvbh7oIjlxl9ALiKdZ4rXpyTIylaSC2tL8ZL3puqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716146256; c=relaxed/simple;
	bh=rirKKuH61jvwiHS0rkmvT98moSQpU+reBVvI8WR3kcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyywMM5e41rrqSFSGCfPh0zNWAIrraWcvVk15ErQ1JD1dmDCj7pBRthLLWOceyetvJ2cjuSXcXWlAbYKoGTmxicJLqZRSJJBNW2QoNPd2DkaFBiWvpfPx53jlEvG36dst7B1fApoqiSEJbosp8HNzwqaCHeLY02mr7iEyqjgQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB4JTvUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0147C32781;
	Sun, 19 May 2024 19:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716146256;
	bh=rirKKuH61jvwiHS0rkmvT98moSQpU+reBVvI8WR3kcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AB4JTvULGuWNeXkM8SGrq8V4/Z1l7qjxuxyMOu0S6XY5+pZ+x37HOmCci5QYMmlzc
	 VKfxdZhBZr9+7xKT7fjAxhLmL8ETlGDvW73X60gUpBK759xxP/cyiag6v/wBrWv4i8
	 aUublmUmJEFmIxYncF2yZfU3Q/MgqTZm8YaYIzot2h7XBznSdRT9GS8o0TqsWOLVxt
	 jp1FKWMlRw/gMGbr3Z5vqCGYpJd6dp+cVZ+VlXQZdmmKSOnD3eNly9gyRmJWMwB7MN
	 F7ezdYbEUHmJq6fjr51BCoETGpJTOICxjtIAde7NadM7Awi45Pl1qSMG9S6IO5A1bW
	 aSjJ/r+p+fi2A==
Date: Sun, 19 May 2024 20:17:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v2 4/9] iio: adc: ad7173: refactor ain and vref
 selection
Message-ID: <20240519201724.01f190a4@jic23-huawei>
In-Reply-To: <20240514-ad4111-v2-4-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
	<20240514-ad4111-v2-4-29be6a55efb5@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 10:22:49 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
>  Move validation of analog inputs and reference voltage selection to

Odd space before M

> separate functions to reduce the size of the channel config parsing
> function and improve readability.
> 


