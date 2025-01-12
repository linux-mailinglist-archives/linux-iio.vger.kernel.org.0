Return-Path: <linux-iio+bounces-14174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C644A0A8CC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA567A1363
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5F1ACECA;
	Sun, 12 Jan 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS1GWg5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9C1A4F2F;
	Sun, 12 Jan 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682800; cv=none; b=ZwwNeX6EtjB4hZMnyohll0xifZrQPSEVTDpWVPTb4/USCe5TaCpynJl8TBT9IiW1Xo4mZ97EGSRiDPCAj5aYF4EG6YrUg++6VSfyvXbQA57kVUHl5zgrCSJwaPvydndVVxAiIwEohXPNUVXHaehnXfUVc1Rd5+7dKEFPrJbI72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682800; c=relaxed/simple;
	bh=6sXlswZqJbtew9LD98uN0tih1S2UZsurrLwWYccg0tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ForPiQmaprPR4LJ5ttleyhjG2fA524WQ6Hlhc7IeM9Z51qY+wgNhlzEmxCX5r8civVLKWRJTPa0xNEBhiOoamfcVxcrvtVpCewdXqtY+NSx5060obYtbiX0YivFjyCD5NJVCmsjECgbeWyu3WB+5HwtYNrGJpNsRk1C5FwsDriY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS1GWg5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0CFC4CEDF;
	Sun, 12 Jan 2025 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736682800;
	bh=6sXlswZqJbtew9LD98uN0tih1S2UZsurrLwWYccg0tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hS1GWg5CUmhntQLNBLL/ovKFdx6UXejBxSRfPVUs5NQ06QiF+mhSGmZuAZFqfKJHf
	 M5GnWyojV2SWFkoNUO+FzHRn/IMKksdl4Y4h+Z4rdGG/0pEOqZBCUibnI92M9ENQph
	 9t00Rs7Vreu2qOt6lPrAR4e3cmEArWlqjoo+KUEvn76rKsCAIAdhS8WcRTnHWPlBum
	 wQXAMou5FZqJnG3TsS0XnDuQo3RG/UvZK1ohHiXM18SZ2sKnQraYainNeN3r11+rYq
	 lZXYQFvVTap1131JG2QT3ix/g2ssCOOKD/ub5Durboo9LDmlBRrQ6A4nlCeReapJPq
	 gSyz+lrOIWdxQ==
Date: Sun, 12 Jan 2025 11:53:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: lars@metafoo.de, jstephan@baylibre.com, yasin.lee.x@gmail.com,
 dan.carpenter@linaro.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iio-next] iio: proximity: Fix use-after-free in
 hx9023s_send_cfg()
Message-ID: <20250112115314.2e5ad298@jic23-huawei>
In-Reply-To: <20250107123510.44978-1-dheeraj.linuxdev@gmail.com>
References: <20250107123510.44978-1-dheeraj.linuxdev@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 18:05:10 +0530
Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> wrote:

> Reorder the assignment of fw_size to happen before release_firmware()
> to avoid accessing the firmware structure after it's been freed.
> 
> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602791
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Gah. I didn't see this until after I'd sent the pull request.
Never mind, we have plenty of time to get this in during the rc1 cycles.

I'll queue it up after rc1.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/hx9023s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index e092a935dbac..5aa8e5a22f32 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -1036,12 +1036,13 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
>  		return -ENOMEM;
>  
>  	memcpy(bin->data, fw->data, fw->size);
> -	release_firmware(fw);
>  
>  	bin->fw_size = fw->size;
>  	bin->fw_ver = bin->data[FW_VER_OFFSET];
>  	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
>  
> +	release_firmware(fw);
> +
>  	return hx9023s_bin_load(data, bin);
>  }
>  


