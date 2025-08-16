Return-Path: <linux-iio+bounces-22781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A9DB28C9D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247D21893163
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287328C004;
	Sat, 16 Aug 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV/7FWua"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE228BABC;
	Sat, 16 Aug 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338403; cv=none; b=cLuGw5Cwq92S7UtAf1woy+v+Z39I8yiaWNQYZFj6o19SjPyGuCJS6gR0yypsBU71ACH6KG3jGbQaS5THRulb1H89e7qJ2PAx0d32+79xX3gM14QvQUsxPCYOVQHG4wOO2ALWc+O/opUHZOV6wcRFtz/+5pBJl7493MD1XAomyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338403; c=relaxed/simple;
	bh=3GwEhMCh8CvyB9+oQFM1I7XmJPbvIVXSBo7AZ12eJrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DO4dQKR4bIoJoIyTT76E4C9w37tZxlw7jseZpJrV0HnlTYtR4y0IhniWVrjQZ7Ec4oQSCxRf/mYbKlRDu/mu+P9pGnuBtdMZTo4spwWWwp7E4DV5uOv0oOh4AeC7exw0KYVos2PBlir8iYEVRBR5wjr9xZtfhpqsqgfnXAZDEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV/7FWua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAEEC4CEF5;
	Sat, 16 Aug 2025 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755338403;
	bh=3GwEhMCh8CvyB9+oQFM1I7XmJPbvIVXSBo7AZ12eJrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EV/7FWuaeF5j+769qo01+/DEqzr8xpCYmyV/BCb5mICtYKjJ5efYrvevFeMl8uEJP
	 aHA8Grsc19SAvq4DfOKLWPWTOyw4+WMFpCzspjdCXCy0lHMlQSPGnRCZocJvwMTL8A
	 3zVgvfki6DKMZChjMf8ToCpr75TdWI/StXDhpf3Qdtz4FgWJfJrkc+GoSuYdXp3OBh
	 Dl0lNA3jWv9EVkVyjEH+K3yu2TJFzOaQZcb9cjCPd62/C7zqe0dJnToC9xBsR1/5H4
	 eJHZdTod/KPCyFXm6uayEHgZ2Zh6QvH4xMXU4q+ao8TJr8rvukUhbpF52x9nXvLLey
	 TYamnQ7xNanAQ==
Date: Sat, 16 Aug 2025 10:59:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: mcp9600: White space cleanup for tab alignment
Message-ID: <20250816105955.101622d0@jic23-huawei>
In-Reply-To: <20250815164627.22002-3-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
	<20250815164627.22002-3-bcollins@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 16:46:04 +0000
Ben Collins <bcollins@watter.com> wrote:

> Purely to align tabs for #defines.
Hi Ben,

Mention the changes to two digits for register addresses to.
Good change to roll in here given what you are touching anyway so
just make sure to call it out in the patch description.

Jonathan

> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  drivers/iio/temperature/mcp9600.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 6e9108d5cf75f..40906bb200ec9 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -23,25 +23,25 @@
>  #include <linux/iio/iio.h>
>  
>  /* MCP9600 registers */
> -#define MCP9600_HOT_JUNCTION 0x0
> -#define MCP9600_COLD_JUNCTION 0x2
> -#define MCP9600_STATUS			0x4
> +#define MCP9600_HOT_JUNCTION		0x00
> +#define MCP9600_COLD_JUNCTION		0x02
> +#define MCP9600_STATUS			0x04
>  #define MCP9600_STATUS_ALERT(x)		BIT(x)
> -#define MCP9600_ALERT_CFG1		0x8
> +#define MCP9600_ALERT_CFG1		0x08
>  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
>  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
>  #define MCP9600_ALERT_CFG_ACTIVE_HIGH	BIT(2)
>  #define MCP9600_ALERT_CFG_FALLING	BIT(3)
>  #define MCP9600_ALERT_CFG_COLD_JUNCTION	BIT(4)
> -#define MCP9600_ALERT_HYSTERESIS1	0xc
> +#define MCP9600_ALERT_HYSTERESIS1	0x0c
>  #define MCP9600_ALERT_HYSTERESIS(x)	(MCP9600_ALERT_HYSTERESIS1 + (x - 1))
>  #define MCP9600_ALERT_LIMIT1		0x10
>  #define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
>  #define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
> -#define MCP9600_DEVICE_ID 0x20
> +#define MCP9600_DEVICE_ID		0x20
>  
>  /* MCP9600 device id value */
> -#define MCP9600_DEVICE_ID_MCP9600 0x40
> +#define MCP9600_DEVICE_ID_MCP9600	0x40
>  
>  #define MCP9600_ALERT_COUNT		4
>  


