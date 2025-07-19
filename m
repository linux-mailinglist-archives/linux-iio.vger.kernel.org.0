Return-Path: <linux-iio+bounces-21773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C3B0AFA6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11A41AA301A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B431223DEE;
	Sat, 19 Jul 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht0kUdS8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C532629C
	for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752925875; cv=none; b=oUso5mAp3b441qUgtBmIasLiDZM+0Oj3KO5qIQGLY9MFAcNf4rxkDCBDGWKMyYdAzFa4Jh65jfaezogVflZwchpTd66X2deaHiRk+v4sEyaB0I+6EP6RC3udaN2yT3pvoI43UQ4H/VVlehKlJuxxDbv/wfNa/6VU39wbK+ek4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752925875; c=relaxed/simple;
	bh=2j7mTmf1BeqxbWjI9YgAv0d9LfOGbrXw0ukDlmStids=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSyCfWmrfW7IvVP3tPFuWDSyLHLkjLCr4GqpeYKLdpUIFIGgxWOuZYqL7ky8T8MD3KatMxKSg5s89VlK2wvjHr+j5845f/6Bgk1niTgWK/TdOdKAHujYHcTQK+Tt1+WzzMByJzlg0tFWEoOIOUJ0M4Eh4FiIEQAzHryp3xyCfow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht0kUdS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F848C4CEE3;
	Sat, 19 Jul 2025 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752925874;
	bh=2j7mTmf1BeqxbWjI9YgAv0d9LfOGbrXw0ukDlmStids=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ht0kUdS8CmCQYLjlakXs1yH2Q8N/pXmLATSgp26okoMgKBQsZYCIsJ5rM+mVT8gsW
	 jcOkgCgnvM0H7ssMZG/Brw015Au7CHviyso/5SHIYMKq1YR3y1xfvG/bHcciih1wyM
	 oZcagNEN2JJFX4GWkP3wSZcjtM0lqgY5LtWfD1png94mZLE15ZpPw7eBmmEw90fMDM
	 z9F2AnU8PDF4wQj48cLJMLJH/vkQGkXcvvpEEsj1x8oep4dnNI1l7V1RZ/ozJeOc/X
	 jRCdQeU/TzglR8j9GTKCxl9GrXre9aFMwWr42KkgKRcRjPyshCgTMRUHAdhuP849IY
	 rmcI8/XQVsXuQ==
Date: Sat, 19 Jul 2025 12:51:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] backlight: lm3630a: Use scoped iterator to simplify
 error handling
Message-ID: <20250719125108.7d1c51e5@jic23-huawei>
In-Reply-To: <20250719042641.134628-5-andreluizrodriguescastro@gmail.com>
References: <20250719042641.134628-5-andreluizrodriguescastro@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 01:21:02 -0300
Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com> wrote:

> This avoids the need to manually call fwnode_handle_put() in error paths.
> Prevents potential memory leaks if future error paths forget the cleanup.
> 
> Signed-off-by: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>

No idea why you sent this to linux-iio. Check MAINTAINERS for appropriate lists
and maintainers to send it to.

Given it's in front of me, a few comments.
> ---
>  drivers/video/backlight/lm3630a_bl.c | 121 +++++++++++++--------------
>  1 file changed, 56 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 37651c2b9393..35a13bd38133 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -16,29 +16,29 @@
>  #include <linux/pwm.h>
>  #include <linux/platform_data/lm3630a_bl.h>
>  
> -#define REG_CTRL	0x00
> -#define REG_BOOST	0x02
> -#define REG_CONFIG	0x01
> -#define REG_BRT_A	0x03
> -#define REG_BRT_B	0x04
> -#define REG_I_A		0x05
> -#define REG_I_B		0x06
> -#define REG_INT_STATUS	0x09
> -#define REG_INT_EN	0x0A
> -#define REG_FAULT	0x0B
> -#define REG_PWM_OUTLOW	0x12
> -#define REG_PWM_OUTHIGH	0x13
> -#define REG_FILTER_STRENGTH	0x50
> -#define REG_MAX		0x50
> -
> -#define INT_DEBOUNCE_MSEC	10
> -
> -#define LM3630A_BANK_0		0
> -#define LM3630A_BANK_1		1
> -
> -#define LM3630A_NUM_SINKS	2
> -#define LM3630A_SINK_0		0
> -#define LM3630A_SINK_1		1
> +#define REG_CTRL 0x00
> +#define REG_BOOST 0x02
> +#define REG_CONFIG 0x01
> +#define REG_BRT_A 0x03
> +#define REG_BRT_B 0x04
> +#define REG_I_A 0x05
> +#define REG_I_B 0x06
> +#define REG_INT_STATUS 0x09
> +#define REG_INT_EN 0x0A
> +#define REG_FAULT 0x0B
> +#define REG_PWM_OUTLOW 0x12
> +#define REG_PWM_OUTHIGH 0x13
> +#define REG_FILTER_STRENGTH 0x50
> +#define REG_MAX 0x50
> +
> +#define INT_DEBOUNCE_MSEC 10
> +
> +#define LM3630A_BANK_0 0
> +#define LM3630A_BANK_1 1
> +
> +#define LM3630A_NUM_SINKS 2
> +#define LM3630A_SINK_0 0
> +#define LM3630A_SINK_1 1

Don't reformat this stuff in a patch doing anything other than that.
It's noise that makes the patch hard to read.


>  
>  
> @@ -479,12 +473,10 @@ static int lm3630a_parse_node(struct lm3630a_chip *pchip,
>  			      struct lm3630a_platform_data *pdata)
>  {
>  	int ret = -ENODEV, seen_led_sources = 0;
> -	struct fwnode_handle *node;
>  
> -	device_for_each_child_node(pchip->dev, node) {
> +	device_for_each_child_node_scoped(pchip->dev, node) {
>  		ret = lm3630a_parse_bank(pdata, node, &seen_led_sources);
>  		if (ret) {
> -			fwnode_handle_put(node);
>  			return ret;
>  		}
Drop {} to comply with standard kernel style.

>  	}
> 
> 
> 
> 
>  MODULE_DEVICE_TABLE(i2c, lm3630a_id);
>  
>  static const struct of_device_id lm3630a_match_table[] = {
> -	{ .compatible = "ti,lm3630a", },
> -	{ },
> +	{
> +		.compatible = "ti,lm3630a",
> +	},
> +	{},
>  };
>  
>  MODULE_DEVICE_TABLE(of, lm3630a_match_table);


